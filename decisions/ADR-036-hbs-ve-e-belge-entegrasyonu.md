# ADR-036 — HBS ve e-belge (e-SMM / e-Arşiv / e-Fatura) entegrasyonu

## Durum

**Taslak, kullanıcı kararı bekliyor (2026-10-19).** Tetikleyen: kullanıcı beyanı (2026-10-19) — HBS entegrasyonu ve e-Fatura/e-SMM Vetinity için de zorunlu. Keşif: [research/hbs-ve-e-belge-kesfi-2026-10.md](../research/hbs-ve-e-belge-kesfi-2026-10.md). Hukuki/vergi görüşü beklenmez; çalışma varsayımıyla ilerlenir ([HUKUKI-ONAY-LISTESI](../roadmap/HUKUKI-ONAY-LISTESI.md) B5, C2). Mevzuat iddialarının çoğu keşifte **DOĞRULANMADI** olarak işaretli; bu ADR onları gerçek kabul etmez, kuralı tek yerde ve değiştirilebilir tutar. Backlog: [INT-005](../backlog/feature-backlog.md#int-005--e-fatura--e-smm), [INT-007](../backlog/feature-backlog.md#int-007--otomatik-fatura--e-belge-oluşturma), [INT-008](../backlog/feature-backlog.md#int-008--hbs-e-reçete-ve-ats-aşı-kaydı-yardımcısı).

## Bağlam

- **HBS** (Tarım ve Orman Bakanlığı, `hbs.tarbil.gov.tr`, e-Devlet ile giriş) kliniğe üç iş yükler: **e-Reçete** (2018'den beri), **ATS** aşı kaydı (serbest hekimin aşıları), yetkiliyse **ev hayvanı kimliklendirme** (çip/pasaport). Sahip değişikliği/ölüm/kayıp bildirimi sahibin yükümlülüğü görünüyor. Klinik yazılımları için **herkese açık resmî web servis bulunamadı** (DOĞRULANMADI).
- **e-belge:** Serbest çalışan veteriner hekim hizmet için **e-SMM**; şirket klinik ve ayrı ticari satış için **fatura** (e-Arşiv; alıcı e-Fatura mükellefiyse e-Fatura). Tek klinikte iki belge türü olabilir. GİB'e doğrudan bağlanmak her klinik ayrı mükellef olduğu için gerçekçi değil; yol **özel entegratör API'si**.
- Rakip E-vet ikisini ayrı menüde sunuyor; Kolayvet e-belgeyi pakete dahil ediyor. Bizde ikisi de yok, sitede "Şu an yok" listesinde ([ADR-035](ADR-035-paketler-ve-fiyat.md)).
- Mevcut model: mikroçip, parti/SKT, aşı↔uygulama↔parti bağı **var**; müşteri TCKN/VKN/vergi dairesi, ücrette KDV/stopaj, belge bağlantısı, e-Reçete No / ATS belge seri no / HBS hayvan kimlik no **yok**.

## Kapsam seçenekleri

| | HBS | e-belge | Değerlendirme |
|---|---|---|---|
| **A (önerilen v1)** | **Manuel yardımcı:** muayene/aşı/reçete kapanınca HBS'e girilecek veri tek ekranda, alan alan ve kopyalanabilir; dışa aktarma; HBS'ten dönen numaralar (e-Reçete No, aşı belge seri no, HBS hayvan kimlik no) geri kaydedilir; "HBS'e girilmedi" iş listesi | **Entegratör üzerinden kes / iptal / PDF**, kiracı kendi entegratör hesabıyla; ilk tek entegratör; elle "Belge kes" + ziyaret/satış kapanışında öneri | Yasal işi Vetinity'den yürütülebilir kılar; bilinmeyen HBS API'sine bağımlı değil |
| B | A ile aynı | Yalnız hazır veri (GİB portalına elle) | Ucuz ama "e-fatura var" denemez; rakip seviyesinin altında |
| C (v2) | Resmî web servis izni çıkarsa **otomatik gönderim** | **Otomatik kesme kuralı** (ücret/tahsilat/ziyaret kapanışı), çoklu entegratör, gelen e-Fatura | A'nın veri modeli üzerine kurulur; HBS kısmı D9 (Bakanlık yanıtı) olmadan başlamaz |

**Önerilmeyen:** HBS portalını tarayıcı eklentisi/ekran kazıma ile otomatikleştirmek; GİB portalını gayriresmî kütüphaneyle taklit etmek; Vetinity'nin özel entegratör izni alması.

## Mimari ilkeler (kod repo'larında tasarlanır; burada yalnız kural)

1. **Sağlayıcı soyutlaması:** `IEDocumentProvider` benzeri tek arayüz (oluştur, durum sorgula, iptal, PDF/görüntü, alıcı e-Fatura mükellefi mi sorgusu). Mevcut `IEmailSender` / `IBillingCheckoutProvider` deseni izlenir. Entegratöre özgü alanlar adaptörde kalır; domain'de entegratör adı geçmez. HBS için ileride `IHbsGateway` (v1'de yok; v1 yalnız veri hazırlama).
2. **Belge türü kuralı tek yerde:** (kiracı mükellef türü × satır türü hizmet/ürün × alıcı bireysel/kurumsal/e-Fatura mükellefi) → e-SMM / e-Arşiv / e-Fatura. KDV oranı, stopaj, iptal süresi, bilinmeyen alıcı kimliği gibi değerler **sabit/ayar olarak tek yerde**; mevzuat değişince tek yerden değişir (HUKUKI-ONAY-LISTESI kuralı).
3. **Idempotency:** Her belge isteği `RequestId` ile; aynı ücret/satış satırı **iki geçerli belgeye** bağlanamaz (veritabanı kısıtı). Entegratöre giden istekte de bizim belge kimliğimiz/UUID'miz taşınır ki yeniden denemede çift belge oluşmasın.
4. **Durum makinesi ve yeniden gönderim:** `Taslak → Gönderiliyor → Kesildi | Hata → (Yeniden dene) ; Kesildi → İptal istendi → İptal edildi | İptal reddedildi`. Asenkron entegratör işleri arka plan işiyle sorgulanır; geçici hatalar sınırlı ve artan aralıklarla yeniden denenir; kalıcı hata kullanıcıya anlaşılır metinle döner. Kesilmiş belge **değiştirilmez**; düzeltme = iptal + yeni belge (süre içinde) veya iade belgesi (sonraki iş).
5. **Denetim izi:** Kim, ne zaman kesti/iptal etti, entegratör yanıt kodu, belge no/ETTN; mevcut audit mekanizmasıyla. HBS yardımcısında "HBS'e girildi" işaretleyen kullanıcı ve zaman.
6. **Kiracı başına kimlik bilgisi güvenliği:** Entegratör API anahtarı/OAuth sırrı kiracı başına **şifreli** saklanır (ASP.NET Data Protection veya eşdeğeri; anahtar halkası sunucu dışı yedekli), API yanıtlarında asla dönmez, günlüğe yazılmaz, yalnız kiracı yöneticisi (Owner/ClinicAdmin) yazabilir ve "bağlantıyı sına" ile doğrular. Sohbete/commit'e yazılmaz.
7. **Test / canlı ortam:** Kiracı ayarında ortam (Test/Canlı) açıkça seçilir; test belgesi canlıya karışmaz; deneme (trial) ve örnek klinikte gerçek belge kesilemez (TRIAL-004 / mevcut kısıt politikası). Geliştirme yalnız sandbox kimlik bilgisiyle.
8. **Kişisel veri:** TCKN/VKN yalnız belge için gerekli olduğunda istenir, maskeli gösterilir, KVKK aydınlatma metnine amaç olarak eklenir (A3; hukuki onay listesine not).

## Mevcut modellerle etkileşim

| Model | Etki |
|---|---|
| `Client` | + kişi türü (bireysel/kurumsal), TCKN (bireysel), VKN + vergi dairesi + unvan (kurumsal), yapılandırılmış fatura adresi (il/ilçe). Zorunlu **değil**; yalnız belge kesilirken eksikse istenir (az zorunlu alan ilkesi). |
| `Clinic` / kiracı ayarları | + mükellef türü (serbest meslek / şirket / ikisi), VKN/TCKN, vergi dairesi, e-belge sağlayıcısı, ortam, şifreli kimlik bilgisi, varsayılan KDV/stopaj. |
| `Charge` | + KDV oranı (hizmet kataloğu/ürün varsayılanından, FIN-008), satır türü (hizmet/ürün), belge bağlantısı (okunur). İptal edilmiş ücrete belge kesilemez; belgesi olan ücret iptal edilirken belge iptali önerilir. |
| `Payment` | Belge ödeme anında kesilmek zorunda değil; ödeme yöntemi belgeye bilgi olarak geçer. Kesme anı kuralı AK-4. |
| `Sale` / Peşin müşteri (ADR-016) | Satış ticari kalemse fatura; Peşin müşteriye bilinmeyen alıcı kuralı (DOĞRULANMADI) tek yerde. |
| `Examination` / `Visit` | Kapanışta (ve kesinleştirmede, ADR-013) "belge kesilecek" ve "HBS'e girilecek" işleri iş listesine düşer; muayene kilidi belgeyi etkilemez. |
| `Pet` | + HBS hayvan kimlik no (isteğe bağlı), çip no biçim uyarısı (15 hane). |
| `Vaccination` / `Administration` (+`BatchId`) | ATS yardımcısı: aşı adı, parti/seri, SKT, tarih, hekim, hayvan/sahip kimliği hazır; + aşı uygulama belgesi seri no, "ATS'e girildi" zamanı/kullanıcı. |
| `Prescription` / `PrescriptionItem` | e-Reçete yardımcısı: kalemler yapılandırılmış olmalı (ürün, miktar, doz, birim, parti); + e-Reçete No. Serbest metin `Content` yetmez. |
| Rapor Merkezi / defterler | "HBS'e girilmemiş" ve "Belgesi kesilmemiş ücretler" listeleri; Aşı Bilgi Raporu ve reçete defteri yeni alanları gösterir. |
| Paketler (ADR-035) | Öneri: **hiçbir kademede kilitlenmez** (mevzuata uyum ücretli basamak olmaz ilkesi); entegratör kontör maliyeti kliniğin kendi sözleşmesinde. AK-6. |

## Dilimler ve tahmini sıra (tahmin; ölçülmedi)

| Dilim | İçerik | Ön koşul |
|---|---|---|
| 0 | Bu ADR'nin kararları; mali müşavir görüşmesi; entegratör seçimi ve **sandbox hesabı**; pilot hekimle HBS ekran gözlemi | Kullanıcı |
| 1 | Veri modeli: müşteri vergi/kimlik alanları, kiracı mükellef ayarları, ücrette KDV/satır türü (FIN-008 ile), pet HBS kimlik no; KVKK aydınlatma notu | 0 |
| 2 | **HBS yardımcısı v1:** aşı (ATS) ve reçete (e-Reçete) için hazır veri ekranı + numara geri kaydı + "HBS'e girilmedi" iş listesi + dışa aktarma; reçete kalemlerinin yapılandırılması | 1 (reçete için Aşama 5 reçete yapısı) |
| 3 | **e-belge çekirdeği:** sağlayıcı arayüzü, belge varlığı + durum makinesi, idempotency, şifreli kimlik bilgisi, ayar ekranı + bağlantı sınaması (sandbox) | 0 (entegratör), 1 |
| 4 | Kes / iptal / PDF akışı: ücret(ler)den ve satıştan elle "Belge kes", ziyaret/satış kapanışında öneri; e-SMM ve e-Arşiv; alıcı e-Fatura mükellefi sorgusu → e-Fatura | 3 |
| 5 | Raporlar (belgesiz ücretler, kesilen/iptal belgeler), denetim, gün sonu ile uyum; canlı ortam geçişi (kullanıcı onayı) | 4 |
| v2 | Otomatik kesme kuralı, iade belgesi, gelen e-Fatura, ikinci entegratör; HBS resmî web servis (izin varsa) | Talep + D9 |

**Sıra önerisi:** Dilim 1 → 2 (HBS, entegratör beklemez) ve Dilim 3–4 (entegratör sandbox gelince) paralel; 5 canlı öncesi.

## Roadmap önceliği önerisi

Bugün: e-Fatura/e-SMM **Aşama 11, P2** ("pilot için engelse P1"); HBS roadmap'te hiç yok. Öneri:

- **HBS yardımcısı v1 (Dilim 2) → P1, Aşama 5 (reçete/aşı) uzantısı; pilot canlı veriye geçmeden önce.** Gerekçe: hekim HBS'e her gün giriyor; veri Vetinity'de yoksa iki kez yazar ve "eski sistemi bırakma" engellenir. Maliyeti düşük, dış bağımlılığı yok.
- **e-belge v1 (Dilim 3–5) → P1, Aşama 9 (pilot ve canlıya çıkış) çıkış koşulu: "eski sistemi bırakma" anı.** INT-007 notuyla uyumlu: gölge kullanım (ADR-014 K4, ilk 2 hafta) belge gerektirmez, çünkü belge eski sistemden kesilmeye devam eder; ama **ilk ücretli canlı müşteri** için zorunlu kabul edilir (kullanıcı beyanı). Satış sitesinde "Şu an yok" ifadesi e-belge canlıya çıkana kadar kalır.
- v2 kalemleri Aşama 11'de kalır.

## Açık kararlar (kullanıcıya)

| # | Karar | Seçenekler | Öneri |
|---|---|---|---|
| AK-1 | Entegratör ve ticari model | (a) Klinik istediği entegratörle kendi sözleşmesi, Vetinity yalnız desteklediği sağlayıcıyı bağlar; (b) Vetinity tek entegratörle çözüm ortaklığı, onboarding/kontör Vetinity üzerinden; (c) a, sonra b | **(c):** v1 tek entegratör, klinik kendi hesabıyla; çözüm ortaklığı teklifleri paralel toplanır |
| AK-2 | İlk entegratör | Paraşüt / eLogo / Uyumsoft / Sovos / BirFatura / diğer | **Teklif + sandbox sonrası seç.** Kriter: e-SMM + e-Arşiv + e-Fatura tek API, sandbox, iptal API'si, OAuth/API anahtarı, kontör fiyatı, Türkçe destek. Paraşüt dokümanı en erişilebilir göründü (DOĞRULANMADI) |
| AK-3 | Desteklenecek mükellef türleri (v1) | (a) yalnız serbest meslek (e-SMM); (b) yalnız şirket (e-Arşiv/e-Fatura); (c) ikisi + karma (hizmet SMM, ürün fatura) | **(c)** — veri modeli baştan karmayı taşımalı; ilk pilot klinik türüne göre ilk çalışan yol seçilir |
| AK-4 | Belge ne zaman kesilir | (a) elle "Belge kes"; (b) ödeme alınınca; (c) ziyaret/satış kapanınca öneri; (d) tam otomatik | **v1: (a) + (c) öneri**; (d) v2 |
| AK-5 | HBS v1 kapsamı | (a) Manuel yardımcı (hazır veri + numara geri kaydı + iş listesi); (b) yalnız dışa aktarma; (c) otomatik gönderim (izin şartı) | **(a)**; Bakanlığa web servis sorusu paralel (D9) |
| AK-6 | Paketlerde yeri | (a) tüm kademelerde; (b) Profesyonel ve üstü; (c) ek ücretli modül | **(a)** — ADR-035 ilkesi; kontör maliyeti kliniğin entegratör sözleşmesinde |
| AK-7 | Öncelik | Yukarıdaki roadmap önerisi; ya da Aşama 11'de kalsın | **Öneri kabulü:** HBS yardımcısı pilot canlı veriden önce, e-belge ilk ücretli canlı müşteriden önce |
| AK-8 | HBS yetki/hesap | Hekim e-Devlet ile kendi girer (Vetinity kimlik bilgisi tutmaz) / Vetinity kimlik bilgisi tutar | **Hekim kendi girer**; Vetinity HBS kimlik bilgisi **saklamaz** |

## Sonuçlar

- Backend önce: sözleşme (veri modeli + belge uçları), sonra frontend. Migration'lar yerel dev DB'de doğrulanır; paylaşılan/üretim için ayrı onay.
- Kullanıcı eylemleri (ajan yapamaz): pilot hekimle HBS ekran gözlemi; Bakanlığa web servis sorusu; mali müşavir görüşmesi; entegratör teklifi ve sandbox hesabı (kimlik bilgisi yalnız gizli depoya).
- Hukuki onay listesine (B5, C2) bu ADR bağlantısı ve TCKN/VKN için KVKK amaç notu eklenmeli (ayrı commit; dosya başka oturumda değişiyor olabilir).
- Riskler: mevzuat iddialarının doğrulanmamış olması (kural tek yerde, değiştirilebilir); entegratör bağımlılığı (soyutlama); çift belge (idempotency + kısıt); kimlik bilgisi sızıntısı (şifreleme, günlük yasağı); HBS'in resmî API sunmaması (v1 bundan bağımsız).
