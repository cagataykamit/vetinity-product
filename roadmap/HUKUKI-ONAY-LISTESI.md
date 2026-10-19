# Hukuki onay listesi (pilot öncesi)

Amaç: Vetinity'nin hukuki görüş gerektiren tüm noktalarını tek yerde toplamak. **Aşağıdaki hiçbir madde hukuki tavsiye değildir**; ürün ekibinin taslak ya da varsayımlarıdır, **KVKK/veteriner mevzuatı konusunda uzman bir hukukçu tarafından onaylanmadan canlı klinik verisiyle kullanılmamalıdır.** Her maddenin yanında kodda nerede durduğu yazılıdır.

Durum değerleri: **Onay bekliyor** · **Soru** (hukukçuya cevaplatılacak) · **Onaylandı** (tarih, kim).

## A. KVKK

| # | Konu | Mevcut hâl (taslak/varsayım) | Hukukçuya soru | Kod yeri | Durum |
|---|---|---|---|---|---|
| A1 | Açık rıza metni | Varsayılan taslak (ADR-024, `legal/acik-riza-metni.md` v0.2): aydınlatmadan ayrılmış, yalnız hatırlatma/iletişim iznini kapsayan 4 maddelik açık rıza; hizmet rızaya bağlanmaz. (Eski 7 maddelik metnin amaç/aktarım/saklama içeriği aydınlatma metnine taşındı.) Yapı, standart Türkçe açık rıza beyanlarının genel kurgusundan esinlenilmiştir; metin bizim sözcüklerimizle yazılmıştır, **hiçbir rakip metni kopyalanmamıştır**. Köşeli parantezler (saklama süresi, başvuru kanalı) boş bırakıldı. | Metin yeterli mi? Açık rıza mı, aydınlatma mı yeterli? Hangi maddeler ayrı onay gerektirir? | backend `ClinicKvkkFormTemplateDefaults.Text`; klinik Ayarlar > KVKK form metni | Onay bekliyor |
| A2 | Açık rıza gerekli mi? | Sistem şu an açık rıza almadan da çalışır; rıza yalnız isteğe bağlı kayıt (ADR-021). | Veteriner hizmetinde işleme "sözleşmenin ifası / hukuki yükümlülük" sebebiyle yapılabilir mi, ayrıca açık rıza gereksiz ya da yanıltıcı mı olur? | ADR-021 | Soru |
| A3 | Aydınlatma metni | Ürün yalnız açık rıza formu üretir; ayrı bir **aydınlatma metni** (veri sorumlusu kimliği, amaç, aktarım, toplama yöntemi, haklar) yok. | Aydınlatma metni ayrı bir belge olarak mı verilmeli, hangi biçimde? | `legal/aydinlatma-metni.md`; backend `kvkk-disclosure-template` (`ClinicKvkkFormKind.Disclosure`) | Onay bekliyor (taslak yazıldı) |
| A4 | Hatırlatma izni | Açık rıza metninin 4. maddesi hatırlatmaları kapsar. Sistemde "hatırlatma istemiyor" bayrağı var (çıkış). Rıza "Ret" olunca bayrak otomatik açılmaz (ADR-021 madde 4). | Aşı/randevu hatırlatması "hizmet bilgilendirmesi" mi, "ticari elektronik ileti" mi (İYS gerekir mi)? Rıza reddi hatırlatmayı kapatmalı mı? | backend `Client.RemindersOptedOut`, ReminderProcessor | Soru |
| A5 | Saklama ve imha | Politika yok. İçe aktarma önizleme/hata dosyaları 30 gün sonra silinir (ADR-019 K9). Müşteri/hasta verisi için süre ve silme akışı tanımsız. | Saklama süreleri nedir (muayene kayıtları, ödeme, defterler)? Silme/yok etme talebi nasıl işlenmeli? | ADR-019 K9, yok | Soru |
| A6 | VERBİS ve veri sorumlusu | Klinik veri sorumlusu, Vetinity "veri işleyen" varsayımı (SaaS). Sözleşme yok. | Veri işleyen sözleşmesi ve VERBİS yükümlülüğü? Müşteri (klinik) ile Vetinity arasındaki ilişki? | yok | Soru |
| A7 | Yurt içi/yurt dışı aktarım | Sunucu: kendi Linux VPS (ADR-014), yurt dışı aktarım yok. Ödeme: iyzico. E-posta/SMS sağlayıcısı belirlenmedi. | Ödeme ve e-posta sağlayıcıları için aktarım şartı? | ADR-014 | Soru |
| A8 | Eski verilerin içe aktarımı | Klinik eski müşteri/hasta/aşı verisini yükler (ADR-019). İçe aktarılan müşterilere otomatik hatırlatma gitmez (K3). | İçe aktarma için hukuki dayanak ve rıza gerekli mi? | ADR-019 K3 | Soru |
| A9 | Rıza kaydı | Müşteri kartında yalnız durum (Yok/Kabul/Ret), tarih ve işaretleyen tutulur; imzalı form kâğıtta kalır, tarama yüklenmez. | Kâğıt formun saklanması yeterli mi? Kayıt ek alanlar (metin sürümü, kanal, kanıt) gerektirir mi? | backend `Client.KvkkConsent*` | Soru |
| A10 | Güvenlik ve erişim | Rol/izin sistemi, denetim kaydı, yedek (VPS'te elle). | Teknik/idari tedbirler yeterli mi? | genel | Soru |

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
| C4 | Hesap/parola güvenliği | Hesap kilitleme ve izin süresi ertelendi (SEC-001/002). | Asgari güvenlik beklentisi. | Soru |
| C5 | Portal kullanım şartları (hasta sahibi) | Taslak `legal/portal-kullanim-sartlari.md` v0.1 (ADR-031 K4): bilgilendirme amaçlı, tıbbi tavsiye değil, acilde klinik aranır; kod/parola güvenliği; klinik veri sorumlusu, Vetinity veri işleyen; erişimin kapatılması; sorumluluk sınırı; sürümlü yeniden kabul. | AK-5: sözleşmenin tarafı (yalnız Vetinity mi, klinik de mi); portal hesabı için Vetinity rolü; tüketici mevzuatı karşısında sorumluluk sınırı; yaş sınırı ve vekâlet/ortak sahiplik; hatırlatmalar İYS/ETK kapsamında mı. | Onay bekliyor (taslak yazıldı) |
| C6 | Portal gizlilik politikası (hasta sahibi) | Taslak `legal/portal-gizlilik-politikasi.md` v0.1 (ADR-031 K4): portal hesabı verileri (e-posta, görünen ad, giriş kayıtları, cihaz/oturum, bildirim tercihi) ve gösterilen klinik kayıtları (aşı, randevu, bakiye, reçete/tedavi özeti; lab/görüntü/muayene notu yok, AK-8); çoklu klinik bağında her klinik ayrı veri sorumlusu. Vetinity veri sorumlusu varsayımıyla yazıldı. | AK-5: portal hesabı verilerinde Vetinity sorumlu mu işleyen mi; giriş/erişim kaydı ve IP saklama süresi; hesap silindikten sonra kabul kayıtlarının saklama süresi; push sağlayıcıları için yurt dışı aktarım (m.9); İYS/ETK. | Onay bekliyor (taslak yazıldı) |

## Geliştirme varsayımı (kullanıcı kararı, 2026-10-16)

Hukuki görüş gelene kadar **geliştirme beklemez**: yukarıdaki taslak metinler ve "Mevcut hâl" sütunları **çalışma varsayımı** olarak kabul edilip iş sürer (ADR-024). Bu, hukuki onay verilmiş anlamına gelmez:
- Durum sütunları "Onay bekliyor/Soru" olarak kalır; "Onaylandı" yalnız hukukçu yanıtıyla yazılır.
- Kullanıcıya görünen **taslak uyarıları** (hukuki sayfalardaki bant, form metni uyarı satırı, `LEGAL_DRAFT_NOTICE`) pilot öncesi hukukçu onayına kadar KALIR; onaysız metni onaylı gibi göstermeyiz.
- Hukuki bir kural varsayımla koda girerse tek yerde yaşar (örn. sürüm sabiti, saklama süresi sabiti) ve burada ilgili satıra not düşülür; hukukçu farklı derse tek yerden değişir.
- **Pilot canlı müşteri verisiyle başlamadan önce** A1–A5 ve B1–B4 hukukçuyla kapatılır (aşağıdaki öneri geçerli).

## Nasıl kullanılır

1. Bu dosya hukukçuya verilir. Her satırdaki **Soru** ve **Onay bekliyor** hücreleri cevaplanır.
2. Onaylanan taslak metinler (A1 vb.) Ayarlar'dan (KVKK form metni) klinik tarafından girilir ya da varsayılan metin güncellenir.
3. Cevaplar ADR olarak yazılır (varsa ADR-021 güncellenir); durum sütunu "Onaylandı (tarih, kim)" yapılır.
4. **Pilot klinik canlı veriyle başlamadan önce A1-A5 ve B1-B4 kapanmalıdır** (önerilir; asıl karar ürün sahibinde ve hukukçudadır).
