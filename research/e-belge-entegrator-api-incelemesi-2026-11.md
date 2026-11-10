# e-belge entegratör API incelemesi ve firmadan bağımsız tasarım — 2026-11-10

Amaç: [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md) Dilim 3–4'ün (e-belge çekirdeği, kes/iptal/PDF) **aracı firma seçilmeden** başlayabilmesi için ortak yapıyı gerçek bir API'ye bakarak tasarlamak. Kaynak: herkese açık dokümanlar (web, 2026-11-10). Firmalardan resmî yanıt yok; başvurular gönderildi ([görüşme paketi](../operations/hbs-e-belge-gorusme-paketi.md#entegratör-başvuruları)). Kod deposunda tasarlanır; burada yalnız bulgu ve kural. Hukuki veya vergi tavsiyesi değildir.

## 1. Bulgular

### Nilvera (doküman tam okunabildi: `developer.nilvera.com`)

| Konu | Bulgu |
|---|---|
| Kimlik doğrulama | API anahtarı (64 hex), `Authorization: Bearer {anahtar}`. Anahtarı **klinik kendi portalında** üretir (API Tanımları → Yeni Anahtar), bir kez gösterilir, süresiz olabilir, iptal edilebilir. Bir örnekte `Authorization: APIKEY` yazıyor (doküman tutarsız) |
| Ortam | Canlı `api.nilvera.com`, test `apitest.nilvera.com`; test ve canlı anahtarlar ayrı. Test hesabının nasıl alındığı yazmıyor |
| e-SMM | `POST /evoucher/Send/Model` tek çağrıda oluştur+gönder (taslak akışı da var). Gövde: makbuz bilgisi (UUID, seri/no, tarih, para birimi, gönderim tipi kâğıt/elektronik), düzenleyen ve alıcı (VKN/TCKN, ad, vergi dairesi, adres), satırlar (brüt ücret, KDV oranı/tutarı, **satır bazında gelir vergisi stopajı**). Yanıt: UUID + makbuz no |
| e-Arşiv | `POST /earchive/Send/Model`; satırlar ve **KDV oranına göre başlık toplamları**; yanıt UUID + fatura no |
| e-Fatura | `POST /einvoice/Send/Model`; alıcı etiketi (`CustomerAlias`) gerekiyor, nereden alındığı yazmıyor |
| Mükellef sorgusu | `GET /general/GlobalCompany/Check/TaxNumber/{vkn}` → kayıt listesi (boş değilse e-Fatura mükellefi; çıkarım) |
| Durum | `GET .../{UUID}/Status` → `waiting / succeed / error / unknown`, raporlandı mı, iptal mi. **Sonuç asenkron**, sorgulanarak izlenir |
| İptal | `PUT .../{UUID}/Cancel`; iptal geri alma ucu var. Süre sınırı dokümanda yok |
| PDF / HTML / XML | UUID ile alınıyor |
| Bildirim (webhook) | Bulunamadı ("bildirim kuralı" uçları var, ne gönderdiği okunmadı) |
| Hata biçimi | `{Message, Errors:[{Code, Description, Detail}]}`; 400 geçersiz, 403 yetki, 404 yok, **409 zaten var** (aynı UUID), 422 iş kuralı: **2000 kontör yetersiz**, 2025 alıcı e-Fatura mükellefi (e-Arşiv kesilemez), 2054 alıcı e-Fatura mükellefi değil, 2034 zaten iptal, 2036 kuyruktayken iptal edilemez, 3009 seri tanımlı değil |
| Numara | Seri **kliniğin hesabında önceden tanımlı** olmalı; belge numarasını firma verir |

### Paraşüt (kısmen: `apidocs.parasut.com` → `devhub.parasut.com`)

- OAuth2 yetkilendirme kodu + PKCE; erişim belirteci 2 saat, yenileme belirteci 30 gün ve **her yenilemede değişiyor**. İstekler `api.parasut.com/v4/{şirket_id}/...`. Hız sınırı pakete göre (429). Webhook için ayrı paket. Test (staging) hesabı 6 ayda silinir.
- e-SMM / e-Arşiv / e-Fatura uçları ve PDF: belge sayfası bu oturumda yüklenmedi, **okunamadı**.

## 2. Tasarıma etkisi (firmadan bağımsız kurallar)

1. **Kimliği biz üretiriz, göndermeden önce kaydederiz.** Belgenin UUID'si (ETTN) Vetinity'de oluşturulur ve gönderimden önce veritabanına yazılır. Yeniden denemede aynı UUID gider; firma "zaten var" (Nilvera 409) derse belge kaybolmuş sayılmaz, durum sorgusuyla devam edilir. Çift belgeyi bu ve "bir ücret yalnız bir geçerli belgeye bağlı" veritabanı kısıtı birlikte önler (ADR-036 ilke 3).
2. **Sonuç asenkron kabul edilir.** "Gönderildi" ile "kesildi" ayrı durumlar; arka plan işi belgeyi durum ucundan sorgular (artan aralık, sınırlı deneme). Webhook varsayılmaz (ilke 4).
3. **Numara firmadan gelir, seri kliniğin hesabındadır.** Kiracı e-belge ayarında belge türü başına seri kodu tutulur; "bağlantıyı sına" seri tanımlı mı diye bakar.
4. **Kimlik bilgisi biçimi sağlayıcıya özeldir.** Nilvera'da kliniğin yapıştırdığı tek API anahtarı; Paraşüt'te OAuth (yönlendirme + değişen yenileme belirteci). Ortak model: kiracı başına **şifreli, sağlayıcıya özel gizli veri** (ilke 6) + adaptörün "bağlan" akışı. v1'de yalnız **anahtar yapıştırma** akışı yazılır; OAuth gerekirse o adaptörle eklenir.
5. **Satır başına KDV ve stopaj** zaten Dilim 1'de var (ücrette KDV oranı, satır türü; klinikte varsayılan stopaj). Başlık toplamları (KDV oranına göre) adaptörde hesaplanır, domain'de değil.
6. **Alıcı yönlendirmesi:** kurumsal alıcıda önce mükellef sorgusu; mükellefse e-Fatura, değilse e-Arşiv (şirket klinik / ürün satırı); serbest meslek hizmetinde e-SMM. Kural tek yerde (ilke 2); firmanın 2025/2054 hatası da aynı kuralı geri besler.
7. **Hata sınıfları** (adaptör çevirir, kullanıcıya Türkçe ve anlaşılır döner): geçersiz veri (düzeltip yeniden dene), yetki/anahtar geçersiz (ayar ekranına yönlendir), **kontör bitti** (klinik kendi firmasından kontör alır), seri tanımlı değil, zaten var (durum sorgusuna geç), geçici hata / hız sınırı (otomatik yeniden dene).
8. **PDF istenince firmadan alınır**; v1'de dosya saklanmaz (gerekirse önbellek sonra).
9. **İptal süresi dokümanda yok**; süre ADR-036'daki gibi tek sabitte kalır (8 gün, DOĞRULANMADI), firma reddederse "İptal reddedildi" durumuna düşer.
10. **Sahte sağlayıcı (fake):** geliştirme ve testte gerçek firmanın davranışını taklit eder (asenkron sonuç, 409, kontör bitti, iptal). Gerçek adaptör geldiğinde yalnız o değişir.

## 3. Önerilen kod dilimleri (tahmin; ölçülmedi)

| Dilim | İçerik | Firma bekler mi |
|---|---|---|
| 3a backend | Sözleşme belgesi; belge varlığı + satırlar (ücret bağı), durum makinesi, UUID/çift belge kısıtı, belge türü kuralı, kiracı e-belge ayarı (sağlayıcı, ortam, seri, şifreli gizli veri), sağlayıcı arayüzü + sahte sağlayıcı, migration (yalnız yerel) | Hayır |
| 4a backend | "Belge kes" (ücretlerden / satıştan), eksik alıcı bilgisi hatası, iptal, PDF, durum sorgulama arka plan işi, "belgesi kesilmemiş ücretler" ve belge listeleri, denetim kaydı | Hayır (sahte sağlayıcıyla) |
| 3a/4a panel | e-belge ayar ekranı (bağlantıyı sına), "Belge kes" diyaloğu, belge durumu rozeti, listeler | Hayır |
| 3b | Seçilen firmanın adaptörü, test hesabıyla uçtan uca deneme | **Evet** (sandbox) |

Kaynaklar: `developer.nilvera.com` (API anahtarı üretimi, e-SMM gönderme/durum/iptal, e-Arşiv ve e-Fatura gönderme, mükellef sorgusu, hata kodları), `devhub.parasut.com` (OAuth rehberi). Okunmayanlar: Nilvera PDF uç yolları, bildirim kuralı, seri oluşturma; Paraşüt belge uçları, webhook, test ortamı adresi.
