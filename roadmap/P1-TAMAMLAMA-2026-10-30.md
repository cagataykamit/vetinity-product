# P1 tamamlama turu (2026-10-30)

Kullanıcı: "P1'i de bitirelim." P0 27/27 bitti. Bu belge kalan P1'in sırasını, kararlarını ve ilerleyişini tutar; oturum değişse de buradan devam edilir.

## Kararlar (kullanıcı, 2026-10-30)

- **AI (AI-001…010, AI-100…108):** pilottan sonraya. Sonra kotalı, ücretli ek paket olarak açılacak (AI-007 kota, AI-008 maliyet). Gerekçe: ürün AI'sız tam çalışıyor; maliyet kullanım başına (kabaca klinik başına ayda 1–45 $, modele göre; ölçülmedi).
- **Online randevu (APPT-001…016):** portal + kliniğe özel bağlantı. Kayıtlı sahip portaldan kendi hayvanını seçip talep gönderir; bağlantıdan gelen yeni kişi e-posta koduyla doğrulanır. Talep klinikte onay kuyruğuna düşer, doğrudan onaylı randevu oluşmaz.
- **Ertelenmiş üç madde bu tura alındı:** UX-008 kişiye özel bildirim, FIN-005 müşteri kredisi/mahsup, TRIAL-006 deneme kotası.

Klinik pratiği soruları rakip pratiğinden türetilip ajan tarafından karara bağlanır; ADR gerektiren yeni ürün kararı çıkarsa kullanıcıya sorulur.

## Dış bağımlılıklar (kod tarafı hazırlanır, açılış kullanıcıda)

| Madde | Beklenen |
|---|---|
| MOBILE-002 mağaza uygulaması | Apple Developer ve Google Play hesapları |
| MOBILE-003 push, PORTAL-010 push kanalı | Firebase (FCM) / APNs anahtarları |
| PORTAL-010 WhatsApp | Business API maliyet kararı (AK-6: önce bağlantı, API sonra) |
| INT-007 otomatik e-belge | Entegratör seçimi ve muhasebeci yanıtları |
| WEB-007 paketler sayfası | Fiyat kararı |
| PORTAL-007 İYS/ETK | Hukuki görüş (çalışma varsayımıyla ilerlenir) |

## Dalgalar

Her madde kendi feature branch'inde; önce backend sözleşmesi, sonra frontend. Main'e alma ve push dalga sonunda kullanıcı onayıyla. Migration yalnız yerel DB'ye uygulanır ve kılavuz §11.1'e eklenir.

| Dalga | Maddeler | Durum |
|---|---|---|
| 1a | TIMELINE-003 tarih aralığı, TIMELINE-004 derin bağlantı, UX-006 son görüntülenenler, WEB-003 JSON-LD + staging noindex, APPT-014 sahip tarafı hatırlatma kapatma, EXAM-010 hızlı lab/reçete bağlantısı | Geliştirildi (main + origin) |
| 1b | REPORT-003 favoriler, REPORT-004 kayıtlı filtreler, REPORT-007 PDF + deneme kısıtı | Geliştirildi (main + origin) |
| 2a | RECORD-002 değişiklik geçmişi, RECORD-001 satır fiyat/fatura görünümü, RECORD-005 uygulama yolu/bölge/üretici, RECORD-008 reçete iptali | Geliştirildi (main yerel, gönderilmedi) |
| 2b | EXAM-008 doz hesaplayıcı, EXAM-007 tedavi paketleri, APPT-017/018/019 satır içi müşteri/hasta oluşturma | Geliştirildi (main yerel, gönderilmedi) |
| 3 | APPT-005…008 randevu nedeni/süre/hekim/müsaitlik; APPT-002/001/003/004/009 bağlantı + portal talebi; APPT-010/011/016 kuyruk; APPT-012/013 şablon + e-posta; APPT-015 bildirim merkezi + UX-008 | Geliştirildi (main yerel, gönderilmedi) |
| 4 | CHECKIN-001…005, EXAM-011/012 şablon parçaları, RECORD-006 (araştırma), PORTAL-007/009/010, FIN-005, TRIAL-006 | Geliştirildi (4a + 4b; main yerel, gönderilmedi; RECORD-006 yalnız araştırma + taslak ADR-043) |
| 5 | MOBILE-002/003/004, INT-007, WEB-005, WEB-007 (dış bağımlılıklara göre) | MOBILE-004 geliştirildi (main yerel, gönderilmedi; gerçek cihaz doğrulaması bekliyor); diğerleri bekliyor |

Kapsam dışı (bu turda bilinçli kapanış): EXAM-015 kilit açma (ADR-013 gereği yok), REPORT-008 dilim 2–3 (pilot geri bildirimine bağlı).

## İlerleme

Her madde bitince buraya dal, commit ve test sonucu yazılır.

### Dalga 1a (2026-10-30, alt ajan) — main + origin
- TIMELINE-003: FE `feat/timeline-tarih-araligi` `45e3bbab` (filtre zaten çalışıyordu; uçtan uca test + "Filtreleri temizle").
- TIMELINE-004: BE+FE `feat/timeline-derin-baglanti` BE `9ef1a247` (`relatedTreatmentId`), FE `a87b9ba3`.
- UX-006: FE `feat/son-goruntulenenler` `47a40899` (kiracı+kullanıcı anahtarlı localStorage, en çok 10).
- WEB-003: FE `feat/tanitim-seo-jsonld` `04c76642` (Organization + FAQPage JSON-LD; staging robots `Disallow: /`).
- APPT-014: BE+FE `feat/portal-hatirlatma-tercihi` BE `e1cd46a3`, FE `99517aff` (portal "Hatırlatmalar" anahtarı; KVKK Ret varken açılamaz).
- EXAM-010: FE `feat/muayene-hizli-lab-recete` `01eb24c7` (özellik vardı; test eklendi).
- Testler (ajan raporu): FE birleşik geçici dalda lint/tsc temiz, panel 2116/2116, portal 128/128; BE tam entegrasyon (APPT-014 dalında) 1693 geçti / 2 atlandı. Elle tarayıcı denemesi yok.
- Açık soru: sahip hatırlatmayı kapatırsa mevcut davet kuralı (ADR-031 K4) o müşteriye yeni portal davetini engelliyor.

### Dalga 1b (2026-10-30, alt ajan) — main + origin
- REPORT-003 favoriler: BE `a909009d`, FE `7fc31786`; migration `AddReportFavorites`.
- REPORT-004 kayıtlı filtreler: BE `bae9e769`, FE `96ff20f3`; migration `AddReportSavedFilters`; tarih aralığı kaydedilmez.
- REPORT-007 PDF: BE `6719c32b`, FE `bab02739`; PDFsharp-MigraDoc 6.2.4 (MIT; 6.5+ AGPL, sürüm sabit, dependabot engelli). Denemede 1.000 satır (TRIAL-004), ücretlide PDF 5.000 satır.
- Birleştirme: iki migration yerel DB'ye uygulandı. Birleşik main'de BE domain 771, application 3731, rapor/defter/portal/timeline entegrasyon 184 geçti; FE lint/tsc temiz, panel 286 ve portal 23 dosya geçti. PDF görünümü gözle denenmedi.

### Dalga 2 ve 3 (2026-10-30, oturumlar p1-dalga-2 / p1-dalga-3) — main yerel, gönderilmedi
- Dalga 2: RECORD-002, RECORD-005, RECORD-008 (+ defterde "İptal"), RECORD-001, EXAM-008, APPT-017/018/019, EXAM-007 paket fiyatı (kullanıcı kararı). Dalga 3: ADR-042 online randevu talebi + bildirim merkezi (APPT-001…016, UX-008), izin `AppointmentRequests.Manage`.
- Birleştirme (koordinatör): BE `entegrasyon/dalga-2-3` → main `57b5cb35`, sonra DbMigrator düzeltmesi `700a1675`; FE main `a46ae366`. Çakışmalar: reçete denetleyicisi, uygulama DTO/eşleyici/fikstürleri, sözleşme bölümleri (RECORD-005 §11, RECORD-001 §12, EXAM-007 §13). Birleşimde eklenen: pakete dahil uygulamada satır ücret durumu `IncludedInPackage`; kayıt geçmişinde uygulama yolu Türkçe etiketi.
- Beş migration yerel DB'ye uygulandı; `DbMigrator seed` çalıştı (yerelde açılışta DI hatası vardı, düzeltildi: DbMigrator `AddApplication`).
- Testler: BE domain 810, application 3739, tam entegrasyon 1726 geçti / 2 atlandı; FE lint/tsc temiz, panel ve portal production build hatasız, panel 2201 (3 atlandı), portal 153 geçti. Tarayıcıda elle uçtan uca denenmedi.
- Açık: portal gizlilik taslağına randevu talebi maddesi (HUKUKI C6); portal talep durumu sayı dönüyor (metne çevirme önerisi).

### Dalga 4a (2026-11-01, oturum dalga-4a) — dal `feat/dalga-4a`; main yerel (aşağıda "Dalga 4 birleştirme"), gönderilmedi
- Worktree'ler: BE `C:\Vetinity\wt\dalga-4a-be`, FE `C:\Vetinity\wt\dalga-4a-fe` (ikisi de `feat/dalga-4a`, main'den). Ürün belgeleri `docs/dalga-4a` (docs/dalga-2 üstüne).
- EXAM-011/012 metin parçaları: BE `9c850b69` (migration `AddClinicalSnippets`, izinler `ClinicalSnippets.*`, sözleşme `docs/CLINICAL_SNIPPET_API_CONTRACT.md`); FE `ede5d175`, `c2b2510c`, `4afa9a61`, `944036ff` (Ayarlar → Tanımlar → Metin parçaları; muayenede `#` tetikleyici). Muayene şablonuyla ayrım sözleşme §1'de.
- TRIAL-006 deneme kotası: BE `dc7e3ddd` (müşteri 1.000, hasta 2.000, depolama 500 MB; `Trial.*QuotaExceeded` 422; `TRIAL_LIMITS_API_CONTRACT.md` K7 §3.4); FE `e9c80cb4`.
- CHECKIN-001…005 geliş hazırlığı: BE `db7f8680` (Visit `ArrivalReason` + `PreparedExaminationTemplateId`, `PUT /visits/{id}/preparation`, Bugün satırında randevu/geliş nedeni ve şablon adı, migration `AddVisitPreparation`); FE `4d0aa541`, `f55c35a0`, `b81841b4`, `c1e6d79c`. ADR-009 eki (2026-11-01): yeni durum yok, şablon gelişte uygulanmaz, teklif belgesi yok (tahmini ücret önizlemesi).
- Testler: BE build 0 hata/0 uyarı, domain 822, application 3760, entegrasyon (Visits, Catalog, Clients, Pets, Files, Imports, Tenants) 303 geçti; tam entegrasyon paketi çalıştırılmadı. FE lint ve tsc (app+spec) temiz, panel 2274 geçti / 3 atlandı (306 dosya), portal 153 geçti, panel ve portal production build hatasız.
- Migration'lar yerel DB'ye uygulandı (`AddClinicalSnippets`, `AddVisitPreparation`). `DbMigrator seed` **çalıştırılmadı** (farklı daldan seed başka dalın izinlerini silebilir); birleştirmeden sonra tek daldan çalıştırılmalı.
- Doğrulanmayan: tarayıcıda elle deneme yok; gerçek backend'le FE uçtan uca yok; `#` listesinin imleç konumu ve koyu tema gözle bakılmadı.
- Açık: metin parçaları ayarlarında "Pasifleri göster" varsayılan kapalı; teklif (estimate) belgesi pilot geri bildirimine bırakıldı; şablon seçici 200 aktif şablonla sınırlı.

### Dalga 4b (2026-11-01, oturum p1-dalga-4b) — dal `feat/dalga-4b`; main yerel (aşağıda "Dalga 4 birleştirme"), gönderilmedi
- Worktree'ler: BE `C:\Vetinity\wt\dalga-4b-be`, FE `C:\Vetinity\wt\dalga-4b-fe`, docs `C:\Vetinity\wt\dalga-4b-docs` (`docs/dalga-4b`). Hepsi main'den (BE `700a1675`, FE `9e6ed293`).
- FIN-005 müşteri kredisi/mahsup: sözleşme `CLIENT_CREDIT_API_CONTRACT.md`. BE `542abd5d`, `c28c8363`, `fda161d3`, `bd6cf709`, `487191e7`, `b4cb6ec7` (test temizliği). FE `f2fe7222` (uçlar), `b8106085`, `fdadec5c`, `b22a797d`, `73b5d5b2`, `16cab28f`. Fazla ödeme/avans → kredi, FIFO mahsup tahsis sayacından, gerekçeli geri alma, tam iade gün sonunda "Kredi iadesi" (net tahsilattan düşer), kredisi kullanılmış ödeme iptal edilemez.
- PORTAL-007/009/010: sözleşme `PORTAL_API_CONTRACT.md` §10–13. BE `b87c0965`, `501cc944`, `8f07efe5`, `ec752a96`, `5a698349`, `2bd18736` (ADR-031 K4 eki: davet yalnız KVKK Ret ile engellenir; tek başına geri alınabilir). FE `3f4073de`, `ebca798e`, `5a589324` (portal), `71b55b58`, `f5de0a99`, `de7fee81` (panel). Push yalnız soyutlama (FCM/APNs yok), WhatsApp personel `wa.me` bağlantısı, ticari ileti onayı kaydı (gönderim kapalı). Portal randevu talebi `status` metne çevrildi (açık soru kapandı).
- RECORD-006: araştırma + ADR-043 taslağı (öneri B; AK-1…9 kullanıcı kararı bekler), kod yok.
- Migration'lar (yalnız yerel DB, 2026-11-01): `AddClientCredits`, `AddPortalPreferencesDataRequestsAndSettings`. Yeni izin yok, seed gerekmez. Dalga 4a migration'larıyla zaman damgası iç içe; birleşimde snapshot sıralı migration'larla yeniden üretilmeli.
- Testler: BE domain 843, application 3740 geçti; tam entegrasyon 1728 geçti / 9 başarısız / 2 atlandı — 9'u kredi FK'sinin test temizliğini bozmasından, `b4cb6ec7` ile düzeltildi; düzeltme sonrası ilgili 172 test (ScopeIdor, Parity, Projections.Payments, OwnerPortal, ClientCredit) geçti, tam paket yeniden koşulmadı. FE lint 0, tsc panel+portal temiz, panel 2258 geçti / 3 atlandı (tek dosya `appointment-request-detail-dialog` VITEST_BROWSER_CONNECTION_CLOSED; main'de de düşüyor, düzeltmesi `feat/musteri-detay-tasarim`), portal 168/168, production build panel + portal hatasız. Tarayıcıda ve gerçek backend'e karşı elle uçtan uca denenmedi.
- Açık: (1) açık ücreti olan müşteriye ücrete bağlamadan avans (ekran yalnız açık ücret yokken sunuyor); (2) hatırlatma için WhatsApp düğmesi müşteri kartı yeniden tasarımına bırakıldı; (3) mevcut e-posta gönderimleri bildirim dağıtıcısına taşınmadı (teknik borç); (4) portal gizlilik taslağına eklenecekler HUKUKI C6 notunda (sürüm 0.1 kaldı); (5) panel muayene çalışma alanındaki kopya kilit kuralı reçeteyi de kilitliyor (RECORD-006 bulgusu, ADR-013 ekiyle çelişiyor; Dalga 4a'nın alanı, düzeltilmedi).

### Dalga 4 birleştirme (2026-11-02, oturum entegrasyon) — main yerel, gönderilmedi
- Yöntem: her depoda `entegrasyon/dalga-4` (main'den), `--no-ff` birleştirmeler, testler geçince main fast-forward. Feature dalları ve worktree'ler duruyor. Derleme/test ayrı worktree'lerde (`C:\Vetinity\wt\entegrasyon-be`, `...\entegrasyon-fe`): ana BE checkout'ta açık kalan `dotnet run` API'si `bin` klasörünü kilitliyordu.
- BE main `700a1675` → `a98cc7b3`: `fix/sablon-uygulama-ozet` (`cc0f63c7`), `feat/dalga-4a` (`952b51a8`), `feat/dalga-4b` (`a98cc7b3`). Metin çakışması yok; ortak dosyalar (`AppDbContext`, Application `DependencyInjection`, `AppDbContextModelSnapshot`) otomatik birleşti. Snapshot doğrulandı: `has-pending-model-changes` değişiklik yok; zincir sırası `…182503_AddClinicalSnippets`, `…183435_AddClientCredits`, `…183442_AddVisitPreparation`, `…184559_AddPortalPreferencesDataRequestsAndSettings`.
- FE main `9e6ed293` → `037f810e` → `0b5e354e`: `feat/musteri-detay-tasarim` (`fix/detay-sayfa-duzeni` içinde; `775ef45f`), `fix/sablon-uygulama-ozet` (`77ecaa36`), `feat/dalga-4a` (`5d61d521`), `feat/dalga-4b` (`26742726`), test düzeltmesi `037f810e`; ikinci adımda `feat/mobile-004` (`54bd0360`, metin çakışması yok) ve Dalga 4 ekranlarına telefon kuralları `0b5e354e` (metin parçaları, portal veri talepleri gelen kutusu ve klinik portal ayarı tabloları `table-stack-phone`; satır içi metin düğmeleri ve kredi panelindeki "Kaynak ödeme" `max-sm:touch-hit`; geliş hazırlığı, ödeme ekranı kredi parçaları ve Bugün hazırlık etiketi ortak kurallarla kapsanıyor, ek iş çıkmadı).
- FE çakışmaları ve çözüm (yeni detay tasarımı esas alındı, 4a/4b eklemeleri onun parçalarına taşındı):
  - Şablon uygulama diyaloğu: iki giriş birlikte (`examinationVisitReason` şablon düzeltmesinden, `preselectedTemplateId` CHECKIN-003'ten).
  - Muayene detayı: tasarım iskeleti korundu; "Gelişte hazırlanan" şeridi eylem şeridinin altına (`card mb-4`), "Şablon uygula" tasarım stilinde `openTemplateDialog(null)`. 4a tarafındaki eski başlık para düğmeleri tasarımın `app-detail-action-bar`'ında zaten var.
  - Müşteri detayı: portal erişim paneli tasarımda 3. satırda (eski konumdaki kopya alınmadı); kredi paneli (FIN-005) para satırının altına tam genişlik ayrı satır, kredi yokken çizilmez (`empty:hidden`, bölüm `card mb-0`).
  - Ödeme detayı: "Krediye yazılan" kimlik kartında tutarın yanında koşullu gösterge (`payment-credited`).
  - Birleşim sonrası tsc (spec) hatası: 4a testi apply sonucunun yeni zorunlu `text`/`pendingChargeCount` alanlarını bilmiyordu → `037f810e`.
- Belge çakışmaları: kılavuz §11.1 migration satırı ve bu dosyadaki dalga tablosu "4" satırı ile İlerleme bölümleri (ikisi de korundu).
- Yerel DB (`VetinityCommandDb`): dört Dalga 4 migration'ı zaten uygulu; birleşik zincire karşı bekleyen migration yok (`migrations list --connection`; tasarım zamanı fabrikası LocalDB `VetinityCommandDb_EfDesign`'a baktığı için bağlantısız liste "Pending" gösterir, yanıltıcı). `DbMigrator seed` birleşik koddan çalıştı: 12 yeni rol-izin bağı (`ClinicalSnippets.*`), geri alınan 0. Kullanıcı yeni izinler için çıkış-giriş yapmalı.
- Testler (birleşik kod): BE build 0 hata / 0 uyarı; domain 864, application 3761, tam entegrasyon 1741 geçti / 0 başarısız / 2 atlandı (10 dk 52 sn). FE lint 0, tsc panel app+spec ve portal app+spec temiz, panel vitest 318 dosya / 2358 test geçti, portal 30 dosya / 168 test geçti, panel + portal production build hatasız ve uyarısız. MOBILE-004 sonrası (`0b5e354e`): lint 0, tsc dört yapılandırma temiz, panel 319 dosya / 2363 test, portal 30 / 168 geçti; production build hatasız, `ngsw.json` üretildi (varlık grupları app 286 + assets 41 dosya, `dataGroups` boş) ve `manifest.webmanifest` çıktıda.
- Doğrulanmayan: telefonda/gerçek cihazda ve PWA kurulumu denenmedi; tarayıcıda elle bakılmadı (özellikle müşteri detayında kredi satırı, ödeme detayında kredi göstergesi, muayene detayında hazırlanan şablon şeridi); gerçek backend'le FE uçtan uca yok. Çalışan dev sunucuları (API, `ng serve`) eski kodla açık; yeniden başlatılmadı.
