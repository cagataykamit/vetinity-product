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
| 1a | TIMELINE-003 tarih aralığı, TIMELINE-004 derin bağlantı, UX-006 son görüntülenenler, WEB-003 JSON-LD + staging noindex, APPT-014 sahip tarafı hatırlatma kapatma, EXAM-010 hızlı lab/reçete bağlantısı | Bekliyor |
| 1b | REPORT-003 favoriler, REPORT-004 kayıtlı filtreler, REPORT-007 PDF + deneme kısıtı | Bekliyor |
| 2a | RECORD-002 değişiklik geçmişi, RECORD-001 satır fiyat/fatura görünümü, RECORD-005 uygulama yolu/bölge/üretici, RECORD-008 reçete iptali | Bekliyor |
| 2b | EXAM-008 doz hesaplayıcı, EXAM-007 tedavi paketleri, APPT-017/018/019 satır içi müşteri/hasta oluşturma | Bekliyor |
| 3 | APPT-005…008 randevu nedeni/süre/hekim/müsaitlik; APPT-002/001/003/004/009 bağlantı + portal talebi; APPT-010/011/016 kuyruk; APPT-012/013 şablon + e-posta; APPT-015 bildirim merkezi + UX-008 | Bekliyor |
| 4 | CHECKIN-001…005, EXAM-011/012 şablon parçaları, RECORD-006 (araştırma), PORTAL-007/009/010, FIN-005, TRIAL-006 | Bekliyor |
| 5 | MOBILE-002/003/004, INT-007, WEB-005, WEB-007 (dış bağımlılıklara göre) | Bekliyor |

Kapsam dışı (bu turda bilinçli kapanış): EXAM-015 kilit açma (ADR-013 gereği yok), REPORT-008 dilim 2–3 (pilot geri bildirimine bağlı).

## İlerleme

Her madde bitince buraya dal, commit ve test sonucu yazılır.
