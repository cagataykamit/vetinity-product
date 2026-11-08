# TIER-012 — İYS ve Tarbil araştırması (2026-11-08)

> **Bu not hukuki tavsiye değildir.** Ürün ekibi için hazırlanmış bir keşif notudur. Mevzuat yorumları ajan değerlendirmesidir. Canlı kullanımdan önce bir hukukçunun onaylaması gerekir (`roadmap/HUKUKI-ONAY-LISTESI.md` A4, C5, C6).

**Yöntem:** Web araması ve sayfa okuma (2026-11-08). Giriş gerektiren hiçbir sayfa açılmadı, form doldurulmadı.
- Yönetmelik ve Kanun metinleri mevzuat.gov.tr'nin güncel (konsolide) metninden okundu. Metinler bir özetleme aracıyla okunduğu için madde ve fıkra numaraları hukukçu kontrolünde ayrıca teyit edilmelidir.
- İYS sayfaları (iys.org.tr) tarayıcıda açılıp metni doğrudan okundu.
- Okunan iç kaynaklar: `backlog/feature-backlog.md` (TIER-003, TIER-012, INT-003, INT-004, INT-008), `roadmap/HUKUKI-ONAY-LISTESI.md`, `research/hbs-ve-e-belge-kesfi-2026-10.md`, backend `docs/AUTOMATED_REMINDERS_API_CONTRACT.md` §2.

Kaynak türü: **[R]** resmî kaynak (mevzuat.gov.tr, Resmî Gazete, iys.org.tr, Bakanlık siteleri). **[İ]** ikincil kaynak (haber, blog, ticari mevzuat sitesi, rakip sitesi).

---

## Kısa sonuç

1. **Klinik "hizmet sağlayıcı"dır, İYS kaydı onun yükümlülüğüdür.**
   - Ticari ileti gönderecek her klinik kendi tüzel/gerçek kişiliğiyle İYS'ye kaydolmalıdır.
   - Ticari ileti onayı her hizmet sağlayıcı için ayrı alınır.
   - Vetinity başkası adına onay alamaz (aracı hizmet sağlayıcı kuralı). Vetinity yalnız kliniğin onay almasına araç olabilir.
2. **Hatırlatma iletilerinin çoğu onay istisnasına girer.**
   - Yönetmelik, borç hatırlatma ve devam eden ilişkiye dair bildirimler için önceden onay aramaz. Satılan hizmetin "kullanım ve bakımı" iletileri de onaysız gönderilebilir.
   - Şart: iletide mal veya hizmet tanıtılmamalı, özendirilmemelidir.
   - "Uzun süredir gelmediniz" iletisi geri kazanım amaçlıdır, ticari ileti sayılmalıdır. İYS, kutlama/tebrik iletilerini bile onaya bağlıyor.
3. **Vetinity İYS'ye doğrudan API ile bağlanamaz.**
   - İYS'ye API erişimi 250.000'den az adresi olan hizmet sağlayıcılar için yalnız Bakanlıkça yetkilendirilmiş bir **entegratör** üzerinden açılır.
   - Vetinity'nin kendisinin entegratör olması ağır şartlara bağlı: 1 milyon TL ödenmiş sermaye, ISO 27001/27701/22301 belgeleri, beş uzman personel, sızma testi. Bu, ayrı bir iş kolu demektir.
   - Bu yüzden gerçekçi yol iki tane: klinik bir entegratör yetkilendirir ve Vetinity o entegratörün API'sini kullanır, ya da yarı elle CSV yükleme yapılır.
4. **Süreler kısa.**
   - İYS dışında alınan onay ve ret **3 iş günü** içinde İYS'ye kaydedilmelidir. Kaydedilmeyen onay geçersiz sayılır.
   - Ret talebi 3 iş günü içinde uygulanmalıdır.
   - İYS'de onayı olmayan alıcıya ticari ileti gönderilemez. Bu kural e-posta için de geçerlidir.
   - Bu yüzden `MarketingSendingEnabled` için tek bir genel anahtar yetmez. Gönderimin klinik başına bir İYS bağlantısıyla açılması gerekir.
5. **"Tarbil" ayrı bir yükümlülük değil, bir alan adı ve marka.**
   - Bakanlığın Hayvan Bilgi Sistemi (HBS) `hbs.tarbil.gov.tr` altında çalışır. Piyasadaki "Tarbil entegrasyonu" bu sistemlere giriş yardımı demektir (Kolayvet: Chrome eklentisi).
   - Pet kliniğini ilgilendiren işler: e-Reçete, ATS aşı kaydı ve PETVET kimliklendirmesi. Bunların ilk ikisi INT-008 ile karşılandı.
   - Resmî web servis yine bulunamadı (doğrulanmadı).

---

## A. İYS

### A1. Ticari elektronik ileti nedir?

| Konu | Özet | Kaynak |
|---|---|---|
| Kanun | 6563 sayılı Elektronik Ticaretin Düzenlenmesi Hakkında Kanun. Ticari elektronik ileti için alıcının önceden onayı gerekir (m.6). Esnaf ve tacirlere önceden onay aranmaz (m.6/2). İletide gönderenin kimliği ve iletişim bilgisi bulunur (m.7). Alıcı gerekçesiz reddedebilir. Ret kolay ve ücretsiz olmalıdır. Ret 3 iş günü içinde uygulanır (m.8). Onay alınmadan ileti gönderilmesinin idari para cezası m.12'dedir. Toplu gönderimde ceza on katına kadar artırılabilir. | [R] [mevzuat.gov.tr — 6563](https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=6563&MevzuatTur=1&MevzuatTertip=5) |
| Ceza tutarı | Tutar her yıl güncellenir. Güncel tutar **doğrulanmadı**. | — |
| Yönetmelik | Ticari İletişim ve Ticari Elektronik İletiler Hakkında Yönetmelik. İlk yayımı RG 15.07.2015/29417. İYS'yi getiren değişiklik RG 04.01.2020/30998, ardından RG 28.08.2020/31227. Tanım (m.4): telefon, çağrı merkezi, faks, otomatik arama, kısa mesaj ve e-posta gibi araçlarla ticari amaçla gönderilen iletiler. | [R] [mevzuat.gov.tr — Yönetmelik](https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=20914&MevzuatTur=7&MevzuatTertip=5) |
| İYS'nin tarifi | Mal ve hizmeti tanıtmak, pazarlamak ya da işletmenin tanınırlığını artırmak amacıyla elektronik araçlarla yapılan iletişim. | [R] [iys.org.tr SSS](https://iys.org.tr/iys/sss) |
| Kapsam dışı (m.2/2) | Kamu kurumlarının bilgilendirmesi, operatörlerin kendi abonelerine gönderdiği iletiler, vakıf üniversiteleri ve kamu kurumu niteliğindeki meslek kuruluşları gibi dar istisnalar. Veteriner kliniği bunlardan birine girmiyor (ajan değerlendirmesi). | [R] Yönetmelik |
| Push bildirimi | İYS'ye göre yalnız mobil uygulama push bildirimi bugünkü uygulamada İYS'ye bildirilmez. Ret ve onay kuralları açısından durumu **doğrulanmadı**. | [R] [iys.org.tr SSS](https://iys.org.tr/iys/sss) |

### A2. Klinik iletileri ticari ileti mi?

**Onay gerektirmeyen iletiler (Yönetmelik m.6)**
- **m.6/1:** Alıcı iletişim bilgisini kendisiyle iletişime geçilsin diye vermişse, aldığı mal veya hizmetin değişikliği, kullanımı ve bakımıyla ilgili iletiler için ayrı onay gerekmez.
- **m.6/2:** Şu bildirimler onay gerektirmez: devam eden abonelik, üyelik veya ortaklık durumu, tahsilat, borç hatırlatma, bilgi güncelleme, satın alma ve teslimat ile mevzuatın gerektirdiği bilgilendirmeler. **Şart:** Bu iletilerde mal veya hizmet tanıtılamaz, özendirilemez.
- **m.6/5:** m.6/1 ve m.6/2 kapsamındaki iletilerde İYS kontrolü yapılmaz.
- **m.11/8:** Aracı hizmet sağlayıcı bu tür gönderimler için hizmet sağlayıcıdan beyan alır. İYS'ye göre iletinin ticari mi bilgilendirme mi olduğuna karar vermek **hizmet sağlayıcının**, yani kliniğin sorumluluğudur.

Kaynaklar: [R] Yönetmelik; [R] [iys.org.tr SSS](https://iys.org.tr/iys/sss). İYS SSS'ye göre kutlama, tebrik ve temenni iletileri onay ister. Hizmetten sonra bir kez gönderilen ve ürün özendirmeyen memnuniyet anketi ise onay istemez (Bakanlık görüşü).

| İleti | Ajan değerlendirmesi | Dayanak | Kesinlik |
|---|---|---|---|
| Randevu hatırlatması (alınmış randevu) | Ticari değil, bilgilendirme | m.6/2 ("satın alma … ve benzeri"), m.6/1 | Yüksek. Veterinere özgü resmî görüş bulunamadı |
| Aşı hatırlatması (hekimin planladığı ya da tekrar dozu gelen aşı) | Ticari değil, mevcut hizmetin devamı | m.6/1 ("kullanım ve bakım"), m.6/2 | **Orta, doğrulanmadı.** Hekimin planladığı ya da kayıtlı bir aşıya dayanmalı. İndirim, kampanya ya da başka hizmet eklenirse ticari olur |
| Kontrol tarihi hatırlatması | Ticari değil | m.6/1 | Orta-yüksek. Kontrol tarihini hekim belirlediyse mevcut tedavinin parçasıdır |
| Ödenmemiş bakiye hatırlatması | Ticari değil | m.6/2 ("borç hatırlatma" açıkça sayılıyor) | Yüksek. İletiye tanıtım eklenmemeli |
| "Uzun süredir gelmediniz" | **Ticari ileti** | Amaç geri kazanım ve tanınırlık. Somut bir hizmet ilişkisine bağlı değil. SSS'deki kutlama/tebrik örneğiyle aynı mantık | Yüksek |

**İstisnanın sınırı (özet):** İstisna, somut ve süren bir hizmet ilişkisine dayanan, yalnız bilgi veren iletilerde geçerlidir: alınmış randevu, hekimin kaydettiği plan, açık borç. Şu üç durumda istisna biter:
1. İletiye tanıtım ya da özendirme girerse (kampanya, indirim, "yeni hizmetimiz", "check-up zamanı").
2. İleti somut bir kayda değil, zamana ya da segmente dayanırsa ("6 aydır gelmediniz", "tüm kedi sahiplerine").
3. İleti, kliniğin kendi hizmet ilişkisi dışında kalan bir konuya değinirse.

Bugünkü sınıflandırma (TIER-003, sözleşme §2) bu değerlendirmeyle uyumlu.

### A3. İYS kaydı kimin yükümlülüğü?

| Konu | Bulgu | Kaynak |
|---|---|---|
| Kim kaydolur | Ticari ileti göndermek isteyen gerçek ve tüzel kişiler, yani **hizmet sağlayıcı = klinik** (Yönetmelik m.5/2). İYS SSS'ye göre kayıt olmadan ticari ileti gönderilemez. | [R] Yönetmelik; [R] [SSS](https://iys.org.tr/iys/sss) |
| Onaysız alıcı | İYS'de onayı bulunmayan alıcıya ticari ileti gönderilemez (m.5/3). E-posta dahil. | [R] Yönetmelik; [R] SSS |
| Vetinity'nin rolü | 6563'teki aracı hizmet sağlayıcı tanımı: başkalarının ticari faaliyetine elektronik ortam sağlayan kişi. Kliniğin iletisini gönderen Vetinity bu tanıma **yakın görünüyor (doğrulanmadı)**. Aracı hizmet sağlayıcı başkası adına onay alamaz (m.11/4). İYS'ye kayıtlı olmayan hizmet sağlayıcının iletisini göndermeye başlayamaz (m.11/6). | [R] Yönetmelik |
| Başvuru | e-Devlet ile, MERSİS kaydında yetkili görünen kişi başvurur. MERSİS kaydı olmayanlar için elle başvuru yolu var. Ticaret unvanı dışında bir adla gönderim yapılıyorsa marka tescil belgesi gerekir. | [R] [Başvuru](https://iys.org.tr/hizmet-saglayici/basvuru/nasil-yapilir) |
| Şahıs klinikleri | Serbest meslek erbabı veteriner hekimin hangi yoldan başvuracağı **doğrulanmadı**. | — |
| Onay muafiyeti | Mal ve hizmet satışında onay muafiyeti m.6/1 ve m.6/2'dedir (A2). Bu iletiler İYS'de sorgulanmaz. Tacir ve esnaf alıcı için de önceden onay aranmaz, ama bu alıcıların İYS'ye "tacir" tipiyle kaydedilmesi gerekir. Veteriner kliniğinin alıcıları çoğunlukla bireyseldir, bu muafiyet işimize yaramaz. | [R] Yönetmelik; [R] SSS |
| Kayıt eşiği | Yönetmelikte gönderim ya da alıcı sayısına bağlı bir kayıt eşiği **yok**. Ticari ileti gönderen herkes kaydolur. | [R] Yönetmelik |
| Ücret eşiği | İYS'nin ücret kademesi var (A4). Bazı ikincil kaynaklarda geçen "yıllık 500.000 ileti" eşiği resmî metinde bulunamadı. | [İ] [birfatura](https://birfatura.com/ileti-yonetim-sistemi-nedir-iys-nedir/) |
| İşletmeci | İleti Yönetim Sistemi A.Ş. Tek hissedarı TOBB. Ticaret Bakanlığı görevlendirdi. | [R] [iys.org.tr](https://iys.org.tr/hizmet-saglayici/kurumsal-hizmetler) |

### A4. İYS entegrasyonu

| Konu | Bulgu | Kaynak |
|---|---|---|
| Ücretsiz Temel Hizmetler | Mevzuatın zorunlu kıldığı her işlem ücretsizdir. İzin ekleme ve değiştirme, sorgulama, günlük rapor, marka ve bayi yönetimi İYS Web'de (`hs.iys.org.tr`) **elle** ya da CSV ile yapılır. API yoktur. | [R] [Kurumsal Hizmetler](https://iys.org.tr/hizmet-saglayici/kurumsal-hizmetler) |
| API (Entegrasyon modülü) | İLETİ paketlerinde sunulur. İzin ekleme/değiştirme, izin sorgulama, izin değişikliği bildirimi (pull/push) ve mutabakat servisleri var. **250.000'den az adresi olan hizmet sağlayıcı API'ye yalnız yetkilendirdiği entegratör üzerinden erişir.** | [R] aynı sayfa |
| Paket fiyatları (yıllık, KDV hariç) | İLETİ-5 (0–5.000 adres) ve İLETİ-25 (5.001–25.000 adres) ücretsiz. İLETİ-75: 24.948 TL. İLETİ-150: 48.552 TL. İLETİ-250: 58.433 TL. Fiyatların tarihi sayfada yok. Tek bir klinik büyük olasılıkla ücretsiz kademede kalır. Entegratörün kendi ücreti ayrıdır ve **doğrulanmadı**. | [R] aynı sayfa |
| Entegratör tebliği | Ticari Elektronik İleti Yönetim Sistemi Entegratörleri Hakkında Tebliğ (RG 18.09.2024/32666). Hizmet sağlayıcılara onay ve ret kaydı hizmeti vermek Bakanlık yetkisine bağlıdır. Şartlar: A.Ş. ya da Ltd., en az 1 milyon TL ödenmiş sermaye, en az beş uzman personel, ISO 22301, 27001 ve 27701, sızma testi, 7/24 yedekli altyapı, verinin yurt içinde tutulması. Hizmet sağlayıcı kendi sistemini bağlarsa entegratör yetkisi gerekmez. | [R] [Resmî Gazete](https://www.resmigazete.gov.tr/eskiler/2024/09/20240918-6.htm) |
| Kimlik bilgileri | `iysCode` ve `brandCode` (test ve canlı ortamda farklı). Canlı ortama erişim **IP kısıtlıdır** (en fazla 5 IP). API şifresi 6 ayda bir yenilenir. Saniyede en çok 10 istek. Toplu eklemede tek seferde en çok 1.000 izin. Test hesabı İYS Web'den e-Devlet ile açılır. Entegratör yetkisi İYS Web'de "Marka Yönetimi > Entegratör Ekle" adımıyla verilir. Doküman: [apidocs.iys.org.tr](https://apidocs.iys.org.tr). Bu oturumda açılmadı. | [R] [SSS — API Destek](https://iys.org.tr/iys/sss) |
| Aracı hizmet sağlayıcı (AHS) | Gönderim sistemini İYS ile uyumlu hale getirir (m.11/5). Kayıtsız hizmet sağlayıcının iletisini göndermez. Gönderimden önce İYS'de onayı sorgular (m.11/7). Bilgilendirme iletileri için hizmet sağlayıcıdan beyan alır (m.11/8). **E-posta kanalında AHS'nin İYS sorgulama yükümlülüğü yoktur.** Yine de hizmet sağlayıcı yalnız onaylı alıcıya ticari ileti gönderebilir. AHS API'sine başvuru için 5809 sayılı Kanun kapsamında **STH lisansı** istenir. Bu, SMS ve arama operatörlerini hedefler. | [R] Yönetmelik; [R] [AHS sayfası](https://iys.org.tr/hizmet-saglayici/araci-hizmet-saglayicilar); [R] SSS |
| Ret kanalı | İletinin gönderildiği kanalla aynı kanaldan, kolay ve ücretsiz olmalı ve **her iletide** bulunmalıdır (m.9/3–4). Örnek: SMS için ret numarası, e-posta için ret bağlantısı ya da yalnız rete ayrılmış bir URL. Alıcı İYS üzerinden de reddedebilir (m.9/7). | [R] Yönetmelik; [R] SSS |
| Ret süreleri | İleti gönderimi 3 iş günü içinde durdurulur (m.10/1). Hizmet sağlayıcıya ulaşan ret 3 iş günü içinde İYS'ye bildirilir (m.9/6). İYS üzerinden yapılan ret hizmet sağlayıcıya anlık ya da en geç 3 iş günü içinde iletilir (Bakanlık görüşü, SSS). API'si olmayan hizmet sağlayıcı İYS Web'den günlük izin değişikliği raporunu indirir. | [R] Yönetmelik; [R] SSS |
| Onay kuralları (m.7) | Onayda olumlu irade beyanı, ad soyad ve iletişim adresi bulunur. Onay kutusu önceden işaretli olamaz. Onay hizmetin ön koşulu yapılamaz. Elektronik ortamda alınan onay, ret imkânıyla birlikte 24 saat içinde alıcıya bildirilir. İYS dışında alınan onay **3 iş günü** içinde İYS'ye kaydedilir, kaydedilmezse geçersizdir. İspat yükü hizmet sağlayıcıdadır. Ticaret Bakanlığı'na göre onay talebinin kendisi ticari ileti olarak gönderilemez. | [R] Yönetmelik; [R] [Ticaret Bak.](https://ticaret.gov.tr/ic-ticaret/ticari-elektronik-iletiler/genel-bilgiler) |
| İzin kaydının içeriği | İletişim adresi, izin tarihi, kanal (arama, mesaj, e-posta), alıcı tipi (bireysel ya da tacir) ve izin kaynağı. | [R] SSS |
| Saklama | Onay kayıtları onayın geçerliliği bittikten sonra, diğer kayıtlar kayıt tarihinden itibaren **3 yıl** saklanır (m.13/2). | [R] Yönetmelik |
| İletide kimlik (m.8) | Tacir: MERSİS numarası ve ticaret unvanı. Esnaf: ad soyad ve TCKN ya da VKN. SMS'te de aynı. En az bir iletişim bilgisi (telefon, SMS numarası ya da e-posta). Niteliği belirten ibare ("tanıtım", "kampanya" gibi): SMS'te başta, e-postada konu satırında. Serbest meslek erbabı hekim için hangi kimliğin yazılacağı **doğrulanmadı**. | [R] Yönetmelik |

### A5. Vetinity için öneri (ajan önerisi, ürün ve hukuk kararı bekler)

**1. Hangi iletiler ticari sayılmalı**
- Bugünkü ayrım korunmalı. Ticari: `NoReturn` ve ileride eklenecek her kampanya, duyuru, kutlama ya da "yeni hizmet" iletisi.
- Ticari değil: randevu, aşı, kontrol, borç hatırlatması ve işlemsel iletiler (kod, davet).
- Kategori tek yerde (`OwnerNotificationChannelPolicy`) kalmalı.
- Ticari olmayan hatırlatma şablonları kilitli kalmalı. Klinik bu iletilere serbest metinle tanıtım ekleyememeli, yoksa istisna bozulur.
- Hatırlatmalarda yasal zorunluluk olmasa da "hatırlatma almak istemiyorum" bağlantısı kalsın (bugünkü `RemindersOptedOut`).

**2. Onay nasıl ve nerede kaydedilmeli**
- Onay **klinik adına** alınmalı. Metinde kliniğin unvanı yazmalı. Vetinity kendi adına onay toplamamalı.
- Kanal başına ayrı kayıt tutulmalı: e-posta, SMS, arama.
- Kayıt alanları: alıcı adresi, alıcı tipi (bireysel), onay zamanı, kaynak (portal, klinikte ıslak imza, klinikte tablet), metin sürümü, işlemi yapan kişi, ret zamanı ve ret kanalı.
- Onay kutusu önceden işaretli olmamalı. Onay hizmete şart yapılmamalı.
- Elektronik onaydan sonra 24 saat içinde ret bağlantılı bir "onayınız alındı" iletisi gönderilmeli.
- Kayıtlar onayın sona ermesinden sonra en az 3 yıl saklanmalı.
- Bugünkü portal bağı (`OwnerAccountClientLinks.MarketingConsentAtUtc`) kanal, kaynak ve metin sürümü tutmuyor. Model genişlemeli.
- Klinikte kâğıt ya da tablet ile onay girişi de gerekir. Yalnız portal bağı kapsamı çok daraltır.
- Onay isteği e-posta ya da SMS ile gönderilmemeli.

**3. İYS'ye ne zaman ve kim tarafından yazılmalı**
- Hukuken yazan **klinik**tir. Süre: onay ve ret için 3 iş günü.
- **Yol 1 (önerilen):** Klinik İYS'ye kaydolur ve bir yetkili entegratörü yetkilendirir. Vetinity o entegratörün API'sine kliniğin kimlik bilgisiyle bağlanır. Kimlik bilgisi şifreli, klinik başına ve gizli depoda tutulur. Akış:
  - onay ya da ret kaydı oluşunca hemen gönderilir,
  - İYS'deki retler pull/push ile geri alınır,
  - gönderimden önce İYS durumu sorgulanır.
  - Entegratör seçimi (sağlayıcı soyutlaması, ilk bir entegratör) ticari bir karardır. SMS sağlayıcısı (INT-003) aynı zamanda entegratör olabilir. Bu **doğrulanmadı**.
- **Yol 2 (geçici):** Vetinity yeni onay ve retleri CSV olarak verir, klinik İYS Web'e kendisi yükler. Günlük izin değişikliği raporu Vetinity'ye geri yüklenir. 3 iş günü sınırı ve İYS'deki retlerin geç görülmesi yüzünden kırılgandır. Ancak "gönderim kapalı, yalnız onay toplama" aşamasında kullanılabilir.
- **Önerilmez:** Vetinity'nin entegratör olması (ağır yetki şartları), İYS Web'i taklit etmek ya da kliniğin e-Devlet oturumunu kullanmak.

**4. İleti metninde ret ve kimlik**
- Her ticari iletide şunlar bulunmalı:
  - kliniğin kimliği: tacirse unvan ve MERSİS, şahıssa ad soyad ve VKN/TCKN (hangisi olacağı hukukçuya sorulacak),
  - bir iletişim bilgisi,
  - nitelik ibaresi: e-postada konu satırında "Tanıtım" ya da "Bilgilendirme",
  - aynı kanaldan, tek adımda ve ücretsiz ret yolu (e-postada ret bağlantısı).
- Ret anında uygulanmalı (yasal süre 3 iş günü). İYS'ye bildirilmesi otomatik iş olmalı.
- Kimlik ve ret alt bilgisi tek bir şablon bileşeninde yaşamalı.

**5. `MarketingSendingEnabled` hangi koşullarda açılır**
- Genel sabit yerine **klinik başına kapı** önerilir. Bu bir ürün kararıdır, ADR gerekir. Bir klinik için aşağıdakilerin hepsi sağlanmalı:
  1. Hukukçu görüşü alınmış olmalı (A4, C5, C6 ve aşağıdaki yeni sorular).
  2. Klinik İYS'ye kayıtlı olmalı. `iysCode` ve `brandCode` girilmiş, entegratör bağlantısı test edilmiş olmalı (Yol 1). Yol 2 için klinik yazılı olarak süreci üstlenmiş olmalı.
  3. Onay kaydı kanal, kaynak ve metin sürümünü tutmalı. Onay metni hukukçu onaylı olmalı.
  4. Onaylar ve retler İYS'ye 3 iş günü içinde yazılabiliyor olmalı. Başarısızlık görünür olmalı ve yeniden denenmeli.
  5. Gönderim öncesi kontrol yapılmalı: alıcının o kanalda onayı var, İYS'de reddi yok, Vetinity'de reddi yok.
  6. Şablonda kimlik bilgisi, nitelik ibaresi ve ret bağlantısı zorunlu olmalı. Bunlar eksikse gönderim başlamamalı.
  7. Ret anında uygulanmalı ve İYS'ye iletilmeli.
  8. Kayıtlar 3 yıl saklanmalı ve denetim kaydına yazılmalı.
  9. Ticari iletiler için ayrı gönderim limiti ve günlük kayıt tutulmalı. SMS kanalında sağlayıcıya ileti türü beyanı gitmeli (m.11/8).
- Paket kararı: İYS altyapısı kilitlenmemeli, çünkü yasal uyum işidir. Ticari ileti **özelliği** (NoReturn, kampanya) ise paket konusu olabilir. Bu ürün kararıdır.

---

## B. Tarbil

### B1. Tarbil nedir?

| Konu | Bulgu | Kaynak |
|---|---|---|
| Ad | TARBİL, "Tarımsal İzleme ve Bilgi Sistemi". Bakanlık ile İTÜ'nün 2011 protokolüyle başlayan, 2015'te tanıtılan, uydu ve gözlem istasyonlarıyla tarlaları izleme projesi. Bugünkü durumu ikincil kaynaklarda çelişkili (**doğrulanmadı**). | [İ] [YÖK Açık Bilim tezi](https://acikbilim.yok.gov.tr/handle/20.500.12812/250929), [İ] [Sözcü](https://www.sozcu.com.tr/100-milyon-dolarlik-asrin-projesi-bulut-mu-olacak-wp2780859) |
| Veterinerlikte kullanımı | `tarbil.gov.tr`, Bakanlığın sistemlerini barındıran alan adı. Hayvan Bilgi Sistemi `hbs.tarbil.gov.tr` adresinde, e-Devlet ile girilir. Piyasada "Tarbil" denince bu ekranlar kastediliyor. | [R] [hbs.tarbil.gov.tr](https://hbs.tarbil.gov.tr) (giriş sayfası, önceki keşif) |
| İşletici | Tarım ve Orman Bakanlığı | [R] |
| Rakip | Kolayvet'in "Tarbil entegrasyonu" bir Chrome eklentisi. Yazılımdaki işlem HBS ekranında hazır doldurulmuş bir görev olarak çıkıyor. Sayfada ATS, İTS, e-Reçete, Petvet ve Türkvet adları geçiyor. e-Devlet girişini kullanıcı yapıyor. Otomatik gönderip göndermediği **belirsiz**. | [İ] [Kolayvet](https://www.kolayvet.com/ozellikler/ozellikler/tarbil-entegrasyonu) |

### B2. Veteriner kliniğinin kayıt ve bildirim yükümlülükleri

| Sistem | Ne | Pet kliniği için | Kaynak | Durum |
|---|---|---|---|---|
| **e-Reçete** (HBS, HAYBİS) | Reçeteye tabi veteriner ilaçların elektronik reçetesi | 01.01.2018'den beri tüm veteriner hekimler için zorunlu. Kılavuz özetine göre kedi, köpek ve at kapsamda. | [R] [Bakanlık 2018](https://www.tarimorman.gov.tr/GKGM/Haber/175/Veteriner-Hekimlikte-E-Recete-Uygulamasina-Gecildi); [İ] [TEİS özeti](https://www.teis.org.tr/post/veteri%CC%87ner-heki%CC%87m-e-re%C3%A7ete-tali%CC%87mati-ve-uygulama-kilavuzu-hakkinda-bi%CC%87lgi%CC%87lendi%CC%87rme) | Zorunluluk doğrulandı. Hangi ilaç grupları kapsamda, **doğrulanmadı** |
| **İTS** (İlaç Takip Sistemi) | Veteriner ilaçların izlenmesi, e-Reçete ile bağlı | Muayenehanenin alım, uygulama ve satış bildirimi yükümlülüğü **doğrulanmadı** | [R] [Artvin İl Md.](https://artvin.tarimorman.gov.tr/Haber/475/Veteriner-E-Recete-Ve-Ilac-Takip-Sistemi-Ile-Ilgili-Bilgilendirmeler-Tamamlandi), [R] [Trabzon İl Md.](https://trabzon.tarimorman.gov.tr/Haber/431/Ilac-Takip-Sistemi-Anlatildi) | Açık |
| **ATS** (Aşı Takip Sistemi) | Sığır, koyun ve keçi dışındaki türlerin aşı (biyolojik ürün) kayıtları | Pet aşıları buraya girer. 2026/2 Tebliğ m.6 bunu ücret ve tahsilat bağlamında düzenliyor. Kedi/köpek kuduz aşısının girilme zorunluluğu ve süresi **doğrulanmadı**. Kaynağı belirsiz bir yönetmelik metninde ihbarı zorunlu hastalık aşıları için "10 gün içinde veri tabanına işleme" hükmü görüldü; hangi yönetmelik olduğu ve güncelliği doğrulanmadı. | [İ] [alomaliye — 2026/2 Tebliğ (RG 18.04.2026/33228)](https://www.alomaliye.com/2026/04/18/veteriner-biyolojik-urunler-ve-hayvan-tanimlama-ucretleri-tebligi/?noamp=mobile); [İ] [Lexpera — mülga 2024/11](https://www.lexpera.com.tr/mevzuat/tebligler/veteriner-biyolojik-urun-ve-hayvan-tanimlama-araclarinin-bedelleri-ile-uygulama-ucretlerinin-1) | Kısmen |
| **VETBİS** (HBS içinde) | Sığır, koyun ve keçinin aşı kayıtları | Pet kliniği için genelde kapsam dışı. Karma pratik yapan klinikleri ilgilendirir. | [İ] aynı tebliğ özetleri | Kısmen |
| **TÜRKVET** | Çiftlik hayvanı kayıt sistemi | Pet kliniği için kapsam dışı (ajan değerlendirmesi) | [İ] tebliğ tanımları, [R] Trabzon İl Md. | Kısmen |
| **PETVET** (Ev Hayvanı Kayıt Sistemi) | Kedi, köpek ve gelinciğin mikroçip ve pasaportla kimliklendirilmesi, sahip eşleşmesi | İl/ilçe müdürlüğü ve **yetkilendirilmiş** serbest veteriner hekim yapar. Hayvan sahibi serbest hekime beyanname verebilir. Kayıtta kuduz dahil aşılar tutulur. Kimliklendirme yönetmeliği RG 26.02.2018/30344, son değişiklik 2025. Haberlere göre son tarih 31.12.2025. Hekim yetkisinin şartları **doğrulanmadı**. | [R] [Bakanlık duyurusu 27.12.2022](https://www.tarimorman.gov.tr/Haber/5652/Sahipli-Hayvanlarin-Dijital-Kimliklendirilmesi); [İ] [CNN Türk](https://www.cnnturk.com/turkiye/evcil-hayvanlarda-mikrocip-zorunlulugunda-son-donemec-2371662) | Kısmen |
| Sahip değişikliği, ölüm, kayıp | 60, 30 ve 7 gün | **Sahibin** yükümlülüğü. Klinik en çok hatırlatma yapar. | [R] Bakanlık duyurusu (2022) | Güncelliği doğrulanmadı |

### B3. Hangileri yazılımla entegre edilebilir?

- **Resmî web servis ya da API bulunamadı.** Bakanlık sayfalarında yalnız sorgu ekranları var. Önceki keşfin D9 maddesi açık: yokluğu kanıtlanmadı. HBS'ye kurum dışı giriş e-Devlet ile yapılıyor.
- **Piyasadaki yol:** Tarayıcı eklentisiyle form doldurma (Kolayvet, FugeVet). Resmî entegrasyon değil. ADR-036 bunu önermedi. Sebepleri: kullanıcının e-Devlet oturumunu kullanması, portal değişince kırılması, kurum şartları.
- **Bugün mümkün olan:** Elle giriş artı Vetinity yardımcısı. INT-008 geliştirildi: e-Reçete ve ATS için hazır veri, geri kayıt ve iş listesi. Henüz pilot hekimle eşleştirilmedi.
- **PETVET kimliklendirme için yardımcı yok.**

### B4. Vetinity için öneri

| Sıra | İş | Paket | Zorluk (tahmin) | Dış bağımlılık |
|---|---|---|---|---|
| 1 | INT-008'i pilot hekimle doğrulamak: HBS e-Reçete ve ATS formlarının alanlarını ekranda görüp eşleştirmek | Kilitlenmez | Düşük | Pilot hekim |
| 2 | Bakanlığa yazılı soru: klinik yazılımları için HBS, ATS ve PETVET web servis izni (D9) | — | — | Bakanlık yanıtı |
| 3 | PETVET kimliklendirme yardımcısı: çip no (15 hane), sahip TCKN, adres ve hayvan bilgilerini hazır vermek, HBS kimlik no geri kaydı | Kilitlenmez | Düşük-orta | Hekimin yetkili olup olmadığı |
| 4 | Kuduz ve ATS süre kuralı: süre doğrulanırsa tek sabitte "girilmedi" uyarısı | Kilitlenmez | Düşük | Mevzuat teyidi |
| 5 | Resmî servis çıkarsa otomatik gönderim (ADR-036 H3) | Kilitlenmez önerilir | Yüksek | İzin ve kimlik modeli |

Not: Tarayıcı eklentisiyle form doldurma rakipte var ve kullanıcının gözünde "entegrasyon" sayılıyor. ADR-036 bunu önermiyor. Yeniden değerlendirilmesi bir **ürün kararıdır**, bu notta önerilmiyor.

---

## C. Sonuç tablosu

| Konu | Zorunlu mu | Kimin yükümlülüğü | Entegrasyon yolu | Önerilen ilk adım | Belirsizlik |
|---|---|---|---|---|---|
| Hatırlatmalar (randevu, aşı, kontrol, borç) | İYS onayı gerekmiyor (m.6/1–2, ajan değerlendirmesi) | Klinik (ileti türünü belirler) | Yok. İYS sorgusu yapılmaz | Şablonları tanıtımsız kilitle, SMS sağlayıcısına "bilgilendirme" beyanı | Aşı hatırlatmasının sınırı. Hukukçu |
| Ticari ileti (NoReturn, kampanya) | Evet: onay ve İYS kaydı | Klinik (hizmet sağlayıcı). Vetinity aracı olabilir | Yetkili entegratör API'si (Yol 1) ya da CSV (Yol 2). Doğrudan API yok (<250k adres) | Gönderim kapalı kalsın. Onay modelini genişlet. Entegratör kısa listesi | Vetinity'nin AHS sayılıp sayılmadığı, entegratör ücreti |
| İYS kaydı | Ticari ileti gönderecekse evet, eşik yok | Klinik (e-Devlet, MERSİS) | İYS Web (ücretsiz) | Klinik kurulum rehberi (ayrı iş) | Şahıs hekimin başvuru yolu |
| Ret yönetimi | Evet: her iletide, aynı kanal, 3 iş günü | Klinik. Vetinity teknik araç | Ret bağlantısı ve İYS'ye bildirim | Tek şablon bileşeni, anında uygulama | — |
| e-Reçete (HBS) | Evet (2018'den beri) | Hekim | Elle. Resmî servis bulunamadı | INT-008'i pilotla doğrula | İlaç kapsamı |
| ATS aşı kaydı | Pet aşıları ATS'ye giriyor | Hekim | Elle | INT-008 doğrulama, süre teyidi | Kuduz zorunluluğu ve süresi |
| PETVET kimliklendirme | Sahip için zorunlu, işlem yetkili hekimde | Sahip ve yetkili hekim | Elle | Yardımcı ekran (ayrı backlog maddesi) | Hekim yetkilendirme şartı |
| İTS | e-Reçete ile bağlı | Hekim, ecza deposu | Elle | Pilot hekime sor | Muayenehane bildirimi |
| VETBİS, TÜRKVET | Çiftlik hayvanı için | Hekim | Elle | Kapsam dışı (pet) | Karma pratik |

---

## Doğrulanmayanlar (özet)

1. Veteriner kliniği iletileri için Ticaret Bakanlığı'nın özel bir görüşü bulunamadı. A2 tablosu ajan yorumudur.
2. Vetinity'nin e-posta kanalında "aracı hizmet sağlayıcı" sayılıp sayılmadığı ve portal üzerinden klinik adına onay toplamanın m.11/4 ile uyumu doğrulanmadı.
3. Serbest meslek erbabı hekimin İYS'ye başvuru yolu ve iletide hangi kimlik bilgisinin yazılacağı doğrulanmadı.
4. 6563 m.12 ceza tutarının güncel değeri doğrulanmadı.
5. Entegratör ücretleri ve SMS sağlayıcılarının entegratör yetkisi doğrulanmadı. `apidocs.iys.org.tr` okunmadı.
6. Kedi/köpek kuduz aşısının ATS'ye girilme zorunluluğu ve süresi doğrulanmadı.
7. İTS'de muayenehanenin bildirim yükümlülüğü doğrulanmadı.
8. PETVET'te serbest hekimin yetkilendirilme şartları doğrulanmadı.
9. HBS, ATS ve PETVET için resmî web servisin varlığı doğrulanmadı (D9).
10. 2026/2 Tebliğ yalnız ikincil özetten okundu.
11. TARBİL projesinin bugünkü durumu doğrulanmadı.

## Kaynaklar

**Resmî**
- 6563 sayılı Kanun — https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=6563&MevzuatTur=1&MevzuatTertip=5
- Ticari İletişim ve Ticari Elektronik İletiler Hakkında Yönetmelik — https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=20914&MevzuatTur=7&MevzuatTertip=5
- İYS Entegratörleri Tebliği (RG 18.09.2024/32666) — https://www.resmigazete.gov.tr/eskiler/2024/09/20240918-6.htm
- İYS Kurumsal Hizmetler (paketler, API) — https://iys.org.tr/hizmet-saglayici/kurumsal-hizmetler
- İYS Aracı Hizmet Sağlayıcılar — https://iys.org.tr/hizmet-saglayici/araci-hizmet-saglayicilar
- İYS SSS (hizmet sağlayıcı, API destek) — https://iys.org.tr/iys/sss
- İYS Başvuru — https://iys.org.tr/hizmet-saglayici/basvuru/nasil-yapilir
- İYS API dokümanı (bu oturumda açılmadı) — https://apidocs.iys.org.tr
- Ticaret Bakanlığı, ticari elektronik iletiler genel bilgiler — https://ticaret.gov.tr/ic-ticaret/ticari-elektronik-iletiler/genel-bilgiler
- Bakanlık, veteriner e-reçete (2018) — https://www.tarimorman.gov.tr/GKGM/Haber/175/Veteriner-Hekimlikte-E-Recete-Uygulamasina-Gecildi
- Bakanlık, sahipli hayvanların dijital kimliklendirilmesi (2022) — https://www.tarimorman.gov.tr/Haber/5652/Sahipli-Hayvanlarin-Dijital-Kimliklendirilmesi
- Artvin İl Md., e-reçete ve İTS — https://artvin.tarimorman.gov.tr/Haber/475/Veteriner-E-Recete-Ve-Ilac-Takip-Sistemi-Ile-Ilgili-Bilgilendirmeler-Tamamlandi
- Trabzon İl Md., İTS — https://trabzon.tarimorman.gov.tr/Haber/431/Ilac-Takip-Sistemi-Anlatildi
- HBS giriş — https://hbs.tarbil.gov.tr

**İkincil**
- alomaliye, 2026/2 Tebliğ özeti — https://www.alomaliye.com/2026/04/18/veteriner-biyolojik-urunler-ve-hayvan-tanimlama-ucretleri-tebligi/?noamp=mobile
- Lexpera, mülga 2024/11 Tebliğ — https://www.lexpera.com.tr/mevzuat/tebligler/veteriner-biyolojik-urun-ve-hayvan-tanimlama-araclarinin-bedelleri-ile-uygulama-ucretlerinin-1
- TEİS, e-reçete kılavuzu özeti — https://www.teis.org.tr/post/veteri%CC%87ner-heki%CC%87m-e-re%C3%A7ete-tali%CC%87mati-ve-uygulama-kilavuzu-hakkinda-bi%CC%87lgi%CC%87lendi%CC%87rme
- Kolayvet, Tarbil entegrasyonu — https://www.kolayvet.com/ozellikler/ozellikler/tarbil-entegrasyonu
- CNN Türk, mikroçip son tarih — https://www.cnnturk.com/turkiye/evcil-hayvanlarda-mikrocip-zorunlulugunda-son-donemec-2371662
- YÖK Açık Bilim, TARBİL tezi — https://acikbilim.yok.gov.tr/handle/20.500.12812/250929
- Sözcü, TARBİL — https://www.sozcu.com.tr/100-milyon-dolarlik-asrin-projesi-bulut-mu-olacak-wp2780859
- BirFatura, İYS nedir — https://birfatura.com/ileti-yonetim-sistemi-nedir-iys-nedir/
- Önceki keşif: `research/hbs-ve-e-belge-kesfi-2026-10.md`

> **Bu not hukuki tavsiye değildir.** Yorumlar ajan değerlendirmesidir. Canlı kullanımdan önce hukukçu onayı gerekir.
