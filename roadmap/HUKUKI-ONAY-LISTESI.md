# Hukuki onay listesi (pilot öncesi)

Amaç: Vetinity'nin hukuki görüş gerektiren tüm noktalarını tek yerde toplamak. **Aşağıdaki hiçbir madde hukuki tavsiye değildir**; ürün ekibinin taslak ya da varsayımlarıdır, **KVKK/veteriner mevzuatı konusunda uzman bir hukukçu tarafından onaylanmadan canlı klinik verisiyle kullanılmamalıdır.** Her maddenin yanında kodda nerede durduğu yazılıdır.

Durum değerleri: **Onay bekliyor** · **Soru** (hukukçuya cevaplatılacak) · **Onaylandı** (tarih, kim).

## A. KVKK

| # | Konu | Mevcut hâl (taslak/varsayım) | Hukukçuya soru | Kod yeri | Durum |
|---|---|---|---|---|---|
| A1 | Açık rıza metni | Varsayılan taslak (ADR-024, `legal/acik-riza-metni.md` v0.2): aydınlatmadan ayrılmış, yalnız hatırlatma/iletişim iznini kapsayan 4 maddelik açık rıza; hizmet rızaya bağlanmaz. (Eski 7 maddelik metnin amaç/aktarım/saklama içeriği aydınlatma metnine taşındı.) Yapı, standart Türkçe açık rıza beyanlarının genel kurgusundan esinlenilmiştir; metin bizim sözcüklerimizle yazılmıştır, **hiçbir rakip metni kopyalanmamıştır**. Köşeli parantezler (saklama süresi, başvuru kanalı) boş bırakıldı. | Metin yeterli mi? Açık rıza mı, aydınlatma mı yeterli? Hangi maddeler ayrı onay gerektirir? | backend `ClinicKvkkFormTemplateDefaults.Text`; klinik Ayarlar > KVKK form metni | Onay bekliyor |
| A2 | Açık rıza gerekli mi? | Sistem şu an açık rıza almadan da çalışır; rıza yalnız isteğe bağlı kayıt (ADR-021). | Veteriner hizmetinde işleme "sözleşmenin ifası / hukuki yükümlülük" sebebiyle yapılabilir mi, ayrıca açık rıza gereksiz ya da yanıltıcı mı olur? | ADR-021 | Soru |
| A3 | Aydınlatma metni | Ürün yalnız açık rıza formu üretir; ayrı bir **aydınlatma metni** (veri sorumlusu kimliği, amaç, aktarım, toplama yöntemi, haklar) yok. Not (2026-10-21, ADR-036 ilke 8): taslak v0.2'ye "fatura/e-belge düzenlenmesi ve resmî bildirim yükümlülükleri (kimlik/vergi numarası yalnız gerektiğinde)" amacı, TCKN/VKN veri kategorisi ve e-belge entegratörü alıcı grubu eklendi; kayıtlı klinik metinleri değişmez. | Aydınlatma metni ayrı bir belge olarak mı verilmeli, hangi biçimde? TCKN/VKN'nin yalnız belge gerektiğinde istenmesi ve maskeli gösterimi yeterli mi? | `legal/aydinlatma-metni.md`; backend `kvkk-disclosure-template` (`ClinicKvkkFormKind.Disclosure`) | Onay bekliyor (taslak yazıldı) |
| A4 | Hatırlatma izni | Açık rıza metninin 4. maddesi hatırlatmaları kapsar. Sistemde "hatırlatma istemiyor" bayrağı var (çıkış). Rıza "Ret" olunca bayrak otomatik açılmaz (ADR-021 madde 4). | Aşı/randevu hatırlatması "hizmet bilgilendirmesi" mi, "ticari elektronik ileti" mi (İYS gerekir mi)? Rıza reddi hatırlatmayı kapatmalı mı? | backend `Client.RemindersOptedOut`, ReminderProcessor | Soru |
| A5 | Saklama ve imha | Politika yok. İçe aktarma önizleme/hata dosyaları 30 gün sonra silinir (ADR-019 K9). Müşteri/hasta verisi için süre ve silme akışı tanımsız. | Saklama süreleri nedir (muayene kayıtları, ödeme, defterler)? Silme/yok etme talebi nasıl işlenmeli? | ADR-019 K9, yok | Soru |
| A6 | VERBİS ve veri sorumlusu | Klinik veri sorumlusu, Vetinity "veri işleyen" varsayımı (SaaS). Sözleşme yok. | Veri işleyen sözleşmesi ve VERBİS yükümlülüğü? Müşteri (klinik) ile Vetinity arasındaki ilişki? | yok | Soru |
| A7 | Yurt içi/yurt dışı aktarım | Sunucu: kendi Linux VPS (ADR-014), yurt dışı aktarım yok. Ödeme: iyzico. E-posta/SMS sağlayıcısı belirlenmedi. | Ödeme ve e-posta sağlayıcıları için aktarım şartı? | ADR-014 | Soru |
| A8 | Eski verilerin içe aktarımı | Klinik eski müşteri/hasta/aşı verisini yükler (ADR-019). İçe aktarılan müşterilere otomatik hatırlatma gitmez (K3). | İçe aktarma için hukuki dayanak ve rıza gerekli mi? | ADR-019 K3 | Soru |
| A9 | Rıza kaydı | Müşteri kartında yalnız durum (Yok/Kabul/Ret), tarih ve işaretleyen tutulur; imzalı form kâğıtta kalır, tarama yüklenmez. | Kâğıt formun saklanması yeterli mi? Kayıt ek alanlar (metin sürümü, kanal, kanıt) gerektirir mi? | backend `Client.KvkkConsent*` | Soru |
| A10 | Güvenlik ve erişim | Rol/izin sistemi, denetim kaydı, yedek (VPS'te elle). | Teknik/idari tedbirler yeterli mi? | genel | Soru |
| A11 | Dış API ile üçüncü taraf yazılıma veri aktarımı (TIER-009) | Kurumsal klinik kendi aldığı anahtarla müşteri (ad, telefon, e-posta), hayvan (ad, tür, ırk, cinsiyet, doğum tarihi, kısırlaştırma, durum), randevu (zaman, tür, durum) ve aşı (ad, durum, tarih) verisini dış yazılıma çeker. TCKN/VKN, adres, notlar ve klinik içerik verilmez. Anahtar yalnız okur, iptal edilebilir; oluşturma ve iptal denetim kaydında, okumalar kaydedilmez. | (1) Aktarımda veri sorumlusu klinik mi, Vetinity veri işleyen mi? (2) Klinik ile entegrasyon sağlayıcısı arasında veri işleme sözleşmesi gerekir mi, Vetinity bunu kullanım şartlarında istemeli mi? (3) Aydınlatma metnine "kliniğin seçtiği yazılım sağlayıcılarına aktarım" alıcı grubu eklenmeli mi? (4) Sağlayıcı yurt dışındaysa m.9 kapsamında ek koşul gerekir mi? (5) Okuma erişimlerinin kaydedilmesi ve saklama süresi zorunlu mu? (6) Silinen ya da itiraz edilen kaydın dış sisteme bildirilmesi gerekir mi? | backend `ExternalReadFeatures.cs`, `EXTERNAL_API_CONTRACT.md` §5 | Soru |

## B. Veteriner mevzuatı ve resmî defterler

Kayıt defteri sayfaları (Rapor Merkezi) **rakip yazılımın raporlarındaki sütun yapısından esinlenilerek** yapılmıştır; **resmî biçim doğrulanmadı** (bkz. `roadmap/KAYIT-DEFTERLERI-RAKIP-BICIMI.md`).

| # | Konu | Mevcut hâl | Soru | Kod yeri | Durum |
|---|---|---|---|---|---|
| B1 | Muayene kayıt defteri | Sütunlar rakip biçiminden; başlık "Hayvan Muayene Kayıt Defteri" (resmî ad doğrulanana kadar "hayvan"). | Resmî biçim, zorunlu sütunlar, saklama süresi, yazdırma/imza kuralı? | frontend `register-definitions.ts` | Soru |
| B2 | Reçete kayıt defteri | Gruplu başlıklar: Reçetenin / Veteriner hekimin / Hayvan sahibinin / Hayvanın (tür, kulak/işletme no, sayısı). Reçete sınıfı, cilt/sıra no, hekim adresi, kulak no, hayvan sayısı ambalaj alanları sistemde YOK. | Resmî biçim ve eksik alanlar zorunlu mu? E-reçete (ÜTS/ilaç takip sistemi) entegrasyonu gerekli mi? | `register-definitions.ts` | Soru |
| B3 | Aşı kayıt defteri | Aşı STOK/giriş defteri (ticari ad, seri no, SKT, miktar, firma, soğuk zincir, depo çıkış, fatura). Soğuk zincir ve fatura alanları sistemde yok. | Zorunlu alanlar? | `register-definitions.ts` | Soru |
| B4 | İlaç ve narkotik/psikotropik defter | Narkotik ve psikotropik ilaç hareket defteri var; satış kısıtı (aşı/narkotik doğrudan satılamaz, ADR-016). | Resmî defter biçimi, sayım ve denetim yükümlülüğü? | `register-definitions.ts`, ADR-016 | Soru |
| B5 | Aşı bilgi raporu / HBS | Hayvan bazlı aşı çıktısı (seri no, SKT). Hayvan Bilgi Sistemi (HBS) entegrasyonu yok. | HBS bildirimi zorunlu mu, hangi hayvanlar için? **Kullanıcı beyanı (2026-10-19): bizde de zorunlu; keşif ve ADR yürütülüyor, kapsam hukuki doğrulamada.** | yok | Soru (zorunluluk kullanıcı beyanı) |
| B6 | Kesinleşmiş muayene kaydı | Kesinleştirilen muayene kilitlenir, düzeltme yalnız ek not (ADR-013). | Tıbbi kayıt değiştirilemezliği ve saklama? | ADR-013 | Soru |
| B7 | Hekim yetkisi ve imza | Defterlerde imza/kaşe alanı yok; "imza resmî biçim doğrulanınca netleşir". | Defterlerde imza/kaşe ve sayfa numarası zorunluluğu? | `register-definitions.ts` | Soru |

## C. Ticari ve diğer

| # | Konu | Mevcut hâl | Soru | Durum |
|---|---|---|---|---|
| C1 | Kullanım şartları ve gizlilik politikası | Taslak metinler `legal/` altında; herkese açık /privacy ve /terms sayfaları (taslak bandıyla). Sürümlü kabul (TRIAL-009) yok. | Hizmet sözleşmesi, kullanım şartları, gizlilik politikası. | Onay bekliyor (taslak yazıldı) |
| C2 | E-fatura / e-belge | Planlı, henüz yok. Bilgi amaçlı fiş var (satışta, "mali değeri yoktur" notu). | Fiş/fatura yükümlülüğü, e-arşiv/e-SMM kapsamı. **Kullanıcı beyanı (2026-10-19): e-fatura/e-SMM bizde de zorunlu; keşif ve ADR yürütülüyor.** | Soru (zorunluluk kullanıcı beyanı) |
| C3 | Ödeme ve iade | iyzico entegrasyonu (kimlik bilgileri döndürülecek). | Mesafeli satış, iade/iptal kuralları. | Soru |
| C4 | Hesap/parola güvenliği | Panel ve portalda 5 hatalı denemede 15 dk hesap kilidi var (SEC-001, 2026-10-29). İzin geri alma gecikmesi ertelendi (SEC-002). | Asgari güvenlik beklentisi. | Soru |
| C5 | Portal kullanım şartları (hasta sahibi) | Taslak `legal/portal-kullanim-sartlari.md` v0.1 (ADR-031 K4): bilgilendirme amaçlı, tıbbi tavsiye değil, acilde klinik aranır; kod/parola güvenliği; klinik veri sorumlusu, Vetinity veri işleyen; erişimin kapatılması; sorumluluk sınırı; sürümlü yeniden kabul. | AK-5: sözleşmenin tarafı (yalnız Vetinity mi, klinik de mi); portal hesabı için Vetinity rolü; tüketici mevzuatı karşısında sorumluluk sınırı; yaş sınırı ve vekâlet/ortak sahiplik; hatırlatmalar İYS/ETK kapsamında mı. | Onay bekliyor (taslak yazıldı) |
| C6 | Portal gizlilik politikası (hasta sahibi) | Taslak `legal/portal-gizlilik-politikasi.md` v0.1 (ADR-031 K4): portal hesabı verileri (e-posta, görünen ad, giriş kayıtları, cihaz/oturum, bildirim tercihi) ve gösterilen klinik kayıtları (aşı, randevu, bakiye, reçete/tedavi özeti; lab/görüntü/muayene notu yok, AK-8); çoklu klinik bağında her klinik ayrı veri sorumlusu. Vetinity veri sorumlusu varsayımıyla yazıldı. | AK-5: portal hesabı verilerinde Vetinity sorumlu mu işleyen mi; giriş/erişim kaydı ve IP saklama süresi; hesap silindikten sonra kabul kayıtlarının saklama süresi; push sağlayıcıları için yurt dışı aktarım (m.9); İYS/ETK. | Onay bekliyor (taslak yazıldı) |
| C7 | İYS/ETK rol dağılımı (TIER-012) | Ajan araştırması (`research/iys-ve-tarbil-arastirmasi-2026-11.md`, hukuki görüş değil): İYS kaydı ve onay kliniğin (hizmet sağlayıcı) yükümlülüğü; hatırlatmalar Yönetmelik m.6/1–2 kapsamında onaysız, "uzun süredir gelmedi" ticari; küçük hizmet sağlayıcı İYS API'ye yalnız yetkili entegratör üzerinden erişir. Gönderim kapalı (`MarketingSendingEnabled = false`). | (1) Vetinity e-posta kanalında aracı hizmet sağlayıcı mı? (2) Portalda klinik adına toplanan ticari ileti onayı m.11/4 ile uyumlu mu, onay metninde hangi taraf adlandırılmalı? (3) Serbest meslek hekimi İYS'ye nasıl başvurur, iletide hangi kimlik bilgisini yazar? (4) Aynı tüzel kişiliğin şubeleri tek İYS hesabı mı kullanır? (5) Vetinity'nin İYS'ye yüklenecek CSV'yi hazırlaması entegratörlük sayılır mı? (6) Entegratör kimlik bilgisinin Vetinity'de saklanması için ek koşul var mı? (7) Ticari ileti onayı ile KVKK açık rızası tek metinde alınabilir mi? (8) Aşı tekrar dozu ve kontrol hatırlatması m.6/1 "kullanım ve bakım" kapsamında mı; hekimin planlamadığı genel "yıllık aşı zamanı" iletisi ticari mi; şablona klinik serbest metin eklerse istisna bozulur mu? (9) B5 eki: kedi/köpek kuduz aşısının ATS'ye girilmesi zorunlu mu, süresi ne; muayenehanenin İTS bildirim yükümlülüğü var mı; serbest hekimin PETVET kimliklendirme yetkisinin şartları? | Soru |

## Geliştirme varsayımı (kullanıcı kararı, 2026-10-16)

Hukuki görüş gelene kadar **geliştirme beklemez**: yukarıdaki taslak metinler ve "Mevcut hâl" sütunları **çalışma varsayımı** olarak kabul edilip iş sürer (ADR-024). Bu, hukuki onay verilmiş anlamına gelmez:
- Durum sütunları "Onay bekliyor/Soru" olarak kalır; "Onaylandı" yalnız hukukçu yanıtıyla yazılır.
- Kullanıcıya görünen **taslak uyarıları** (hukuki sayfalardaki bant, form metni uyarı satırı, `LEGAL_DRAFT_NOTICE`) pilot öncesi hukukçu onayına kadar KALIR; onaysız metni onaylı gibi göstermeyiz.
- Hukuki bir kural varsayımla koda girerse tek yerde yaşar (örn. sürüm sabiti, saklama süresi sabiti) ve burada ilgili satıra not düşülür; hukukçu farklı derse tek yerden değişir.
- **Pilot canlı müşteri verisiyle başlamadan önce** A1–A5 ve B1–B4 hukukçuyla kapatılır (aşağıdaki öneri geçerli).

### Koda giren varsayımlar — P1 Dalga 4b (2026-11-01; PORTAL-007/010, FIN-005)

Durum sütunları değişmedi; aşağıdakiler çalışma varsayımıdır ve her biri tek yerde yaşar (backend `feat/dalga-4b`):
- **A4 / C5 / C6 — İYS/ETK:** hatırlatma (aşı/randevu) ve işlemsel ileti (kod, davet, talep yanıtı) ticari ileti sayılmadı. Ticari ileti onayı portalda bağ başına kaydedilir (`OwnerAccountClientLinks.MarketingConsentAtUtc`), **gönderim kapalıdır** (`OwnerNotificationChannelPolicy.MarketingSendingEnabled = false`); ticari ileti gönderen özellik yok. Açmak hukuk görüşü + İYS kaydı + ürün kararı ister.
- **A5 / C6 — KVKK başvurusu:** portaldan "Verilerimle ilgili talep" (erişim, düzeltme, silme, itiraz, diğer) kliniğin gelen kutusuna düşer; yanıt süresi 30 gün (`OwnerDataRequest.ResponseDueDays`, KVKK m.13 varsayımı). Sistem silme/anonimleştirme yapmaz; klinik `operations/kvkk-talep-sureci.md` ile elle yürütür. Talep metni ve yanıt notu denetim kaydında maskelenir. Bir bağda en çok 3 açık talep (kötüye kullanım sınırı; hukukçu "başvuru hakkı sınırlanamaz" derse kaldırılır).
- **C6 — metin eksikleri (hukukçu onayında sürüm 0.2'ye eklenmeli; şimdi metin değiştirilmedi, sürüm 0.1 kaldı):** (a) portal randevu talebi verileri (hayvan, neden, istenen saat, not; veri sorumlusu klinik — ADR-042); (b) KVKK veri talebi verileri (tür, açıklama, kliniğin yanıtı) ve bölüm 10'daki "(v1)" ibaresinin kaldırılması; (c) bildirim tercihi kapsamı: push izni (sağlayıcı yok, cihaz jetonu tutulmuyor), ticari ileti onayı kaydı.
- **C6 — WhatsApp:** personel `wa.me` bağlantısıyla kendi WhatsApp'ından gönderir; sistem göndermez, içerik asgari (hayvan adı, tarih, klinik adı). Personelin kişisel cihaz/hesap kullanımı ve WhatsApp'ın yurt dışı aktarımı (m.9) hukukçuya sorulmalı.
- **FIN-005:** müşteri kredisi iadesi kasa çıkışı olarak gün sonu dökümüne girer; iade belgesi/fiş ve e-belge etkisi C2 (e-fatura) kapsamında ayrıca değerlendirilir.

### Koda giren varsayımlar — otomatik hatırlatıcılar (2026-11-07; TIER-003)

Durum sütunları değişmedi; hukuki görüş alınmadı. Kategori tek yerde yaşar (backend `OwnerNotificationChannelPolicy`):
- **A4 — "Uzun süredir gelmedi" iletisi:** ticari elektronik ileti sayıldı, onaysız gönderilmez. `MarketingSendingEnabled` kapalı olduğu sürece hiç gönderilmez.
- **A4 — Kontrol tarihi ve ödenmemiş bakiye hatırlatması:** mevcut hizmet ilişkisine dair bilgilendirme sayıldı, ticari ileti onayı aranmaz; hatırlatma istemeyen müşteriye gitmez. Hukukçuya sorulacak: bu iki ileti onay gerektirir mi?

## Nasıl kullanılır

1. Bu dosya hukukçuya verilir. Her satırdaki **Soru** ve **Onay bekliyor** hücreleri cevaplanır.
2. Onaylanan taslak metinler (A1 vb.) Ayarlar'dan (KVKK form metni) klinik tarafından girilir ya da varsayılan metin güncellenir.
3. Cevaplar ADR olarak yazılır (varsa ADR-021 güncellenir); durum sütunu "Onaylandı (tarih, kim)" yapılır.
4. **Pilot klinik canlı veriyle başlamadan önce A1-A5 ve B1-B4 kapanmalıdır** (önerilir; asıl karar ürün sahibinde ve hukukçudadır).
