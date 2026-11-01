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
| 4 | CHECKIN-001…005, EXAM-011/012 şablon parçaları, RECORD-006 (araştırma), PORTAL-007/009/010, FIN-005, TRIAL-006 | 4a (CHECKIN-001…005, EXAM-011/012, TRIAL-006): geliştirildi, dal `feat/dalga-4a` (main'e alınmadı). 4b: ayrı oturum |
| 5 | MOBILE-002/003/004, INT-007, WEB-005, WEB-007 (dış bağımlılıklara göre) | Bekliyor |

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

### Dalga 4a (2026-11-01, oturum dalga-4a) — dal `feat/dalga-4a`, main'e alınmadı, gönderilmedi
- Worktree'ler: BE `C:\Vetinity\wt\dalga-4a-be`, FE `C:\Vetinity\wt\dalga-4a-fe` (ikisi de `feat/dalga-4a`, main'den). Ürün belgeleri `docs/dalga-4a` (docs/dalga-2 üstüne).
- EXAM-011/012 metin parçaları: BE `9c850b69` (migration `AddClinicalSnippets`, izinler `ClinicalSnippets.*`, sözleşme `docs/CLINICAL_SNIPPET_API_CONTRACT.md`); FE `ede5d175`, `c2b2510c`, `4afa9a61`, `944036ff` (Ayarlar → Tanımlar → Metin parçaları; muayenede `#` tetikleyici). Muayene şablonuyla ayrım sözleşme §1'de.
- TRIAL-006 deneme kotası: BE `dc7e3ddd` (müşteri 1.000, hasta 2.000, depolama 500 MB; `Trial.*QuotaExceeded` 422; `TRIAL_LIMITS_API_CONTRACT.md` K7 §3.4); FE `e9c80cb4`.
- CHECKIN-001…005 geliş hazırlığı: BE `db7f8680` (Visit `ArrivalReason` + `PreparedExaminationTemplateId`, `PUT /visits/{id}/preparation`, Bugün satırında randevu/geliş nedeni ve şablon adı, migration `AddVisitPreparation`); FE `4d0aa541`, `f55c35a0`, `b81841b4`, `c1e6d79c`. ADR-009 eki (2026-11-01): yeni durum yok, şablon gelişte uygulanmaz, teklif belgesi yok (tahmini ücret önizlemesi).
- Testler: BE build 0 hata/0 uyarı, domain 822, application 3760, entegrasyon (Visits, Catalog, Clients, Pets, Files, Imports, Tenants) 303 geçti; tam entegrasyon paketi çalıştırılmadı. FE lint ve tsc (app+spec) temiz, panel 2274 geçti / 3 atlandı (306 dosya), portal 153 geçti, panel ve portal production build hatasız.
- Migration'lar yerel DB'ye uygulandı (`AddClinicalSnippets`, `AddVisitPreparation`). `DbMigrator seed` **çalıştırılmadı** (farklı daldan seed başka dalın izinlerini silebilir); birleştirmeden sonra tek daldan çalıştırılmalı.
- Doğrulanmayan: tarayıcıda elle deneme yok; gerçek backend'le FE uçtan uca yok; `#` listesinin imleç konumu ve koyu tema gözle bakılmadı.
- Açık: metin parçaları ayarlarında "Pasifleri göster" varsayılan kapalı; teklif (estimate) belgesi pilot geri bildirimine bırakıldı; şablon seçici 200 aktif şablonla sınırlı.
