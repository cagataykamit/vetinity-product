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
| 2a | RECORD-002 değişiklik geçmişi, RECORD-001 satır fiyat/fatura görünümü, RECORD-005 uygulama yolu/bölge/üretici, RECORD-008 reçete iptali | Geliştiriliyor (oturum p1-dalga-2) |
| 2b | EXAM-008 doz hesaplayıcı, EXAM-007 tedavi paketleri, APPT-017/018/019 satır içi müşteri/hasta oluşturma | Geliştiriliyor (oturum p1-dalga-2) |
| 3 | APPT-005…008 randevu nedeni/süre/hekim/müsaitlik; APPT-002/001/003/004/009 bağlantı + portal talebi; APPT-010/011/016 kuyruk; APPT-012/013 şablon + e-posta; APPT-015 bildirim merkezi + UX-008 | Geliştiriliyor (oturum p1-dalga-3) |
| 4 | CHECKIN-001…005, EXAM-011/012 şablon parçaları, RECORD-006 (araştırma), PORTAL-007/009/010, FIN-005, TRIAL-006 | Bekliyor |
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
