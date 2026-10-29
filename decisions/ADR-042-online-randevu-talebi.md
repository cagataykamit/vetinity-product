# ADR-042 — Online randevu talebi: portal ve kliniğe özel bağlantı

## Durum

**Kabul edildi (2026-10-30).** Kanal kararı kullanıcının: "Portal + klinik bağlantısı". Aşağıdaki ayrıntılar ajan önerisidir (rakip pratiğinden türetildi). Kullanıcı farklı derse yalnız ilgili K maddesi değişir.

Kapsam: APPT-001…016 (P1). APPT-020 ve sonrası (HTML butonu, iframe, widget, depozito, takvim senkronu, QR, mini sayfa) bu ADR'nin dışındadır.

## Bağlam

- Randevu bugün yalnız klinik içinden oluşturuluyor. Hasta sahibi telefonla arıyor; mesai dışında talep kaybediliyor.
- Portal (ADR-031) var: hasta sahibi klinik davetiyle hesap açar (K3), kendi hayvanlarını, aşı ve randevularını görür. Bildirim kanalı e-posta (K7, AK-6); push mağaza uygulamasıyla gelecek (MOBILE-003).
- Rakip pratiği (DaySmart, e-Vet gözlemleri, backlog notları): kliniğe özel bağlantı; randevu nedeni seçimi, nedenin varsayılan süresi ve uygun hekimi; yalnız müsait saatlerin gösterilmesi; doğrudan randevu yerine **talep → klinik onayı**; onay/red e-postası şablonlu; klinikte bekleyen talep kuyruğu ve takvimde ayırt edilebilir görünüm.

## Kararlar

### K1 — İki giriş kapısı, tek talep modeli

- **Portal:** oturum açmış sahip, bağlı olduğu klinikte kendi hayvanlarından birini seçer (APPT-003). Hayvan listede yoksa talebe ad/tür/ırk serbest metni eklenir (APPT-004); klinik kaydı onayda oluşturur. Portal sahibin klinik kayıtlarını değiştirmez (ADR-031).
- **Kliniğe özel bağlantı:** `portal` alan adında `/randevu/{klinik-kodu}` (APPT-002). Kod rastgele ve tahmin edilemez; klinik yeniden üretebilir (eski bağlantı kapanır). Hesabı olmayan kişi ad, telefon, e-posta ve hayvan bilgisi girer; **e-postaya gelen tek kullanımlık kodla doğrulanmadan talep oluşmaz.**
- Bağlantıdan gelen kişi için otomatik müşteri, hasta ya da portal hesabı **oluşmaz** (ADR-031 K3: hesap klinik davetiyle açılır). Talep bir iletişim anlığı (ad, telefon, e-posta, hayvan metni) taşır. Klinik onaylarken mevcut müşteriyle eşleştirir ya da satır içi yeni müşteri/hasta oluşturur (APPT-017/018); isterse portal daveti gönderir.

### K2 — Randevu nedeni (APPT-005/006/007)

- Klinik başına liste: ad, varsayılan süre (dk), online'da görünür mü, uygun hekimler (boşsa klinikteki tüm hekimler), sıra, aktif.
- Klinik içi randevu formunda da kullanılır: neden seçilince süre önerilir (zorunlu değil, değiştirilebilir).
- Online akışta yalnız "online'da görünür" ve aktif nedenler listelenir.

### K3 — Müsaitlik (APPT-008)

- Müsait saat = kliniğin çalışma saatleri ∩ (neden için uygun hekimlerden en az biri) − o hekimin çakışan randevuları. Adım, nedenin süresidir.
- Klinik ayarları: online randevu açık/kapalı (**varsayılan kapalı**), en erken (ör. 2 saat sonrası) ve en geç (ör. 30 gün) talep sınırı.
- Bekleyen talepler saati **bloke etmez**; çakışma onay anında denetlenir. Sahibe "talep" olduğu, kesin randevu olmadığı açıkça söylenir.
- Saatler İstanbul duvar saatidir.

### K4 — Talep yaşam döngüsü (APPT-009/010/011)

- Durumlar: `Bekliyor` → `Onaylandı` (randevu oluşur, talebe bağlanır) | `Reddedildi` (gerekçe zorunlu, sahibe gider) | `İptal` (sahip vazgeçti) | `Süresi doldu` (istenen saat geçti, iş otomatik kapatır).
- **Yeniden planla:** klinik farklı saat/hekimle onaylar; randevu o saatte oluşur ve sahibe "saat değiştirildi" bildirimi gider. Ayrı bir "öneri bekliyor" durumu yoktur; sahip uymayan saati portaldan iptal edebilir.
- Her geçiş kim/ne zaman bilgisiyle tutulur ve denetim kaydına yazılır (APPT-024'ün asgarisi).
- Yetki: yeni izin `AppointmentRequests.Manage` (kuyruğu görme, onay/red). Varsayılan rollerde klinik yöneticisi ve resepsiyon. Ayarlar mevcut klinik ayar yetkisiyle.

### K5 — Bildirimler (APPT-012/013/015, UX-008)

- Sahibe e-posta: talep alındı, onaylandı, saat değiştirildi, reddedildi. Klinik başına düzenlenebilir şablon; yoksa Vetinity varsayılanı. Önizleme var. Onay/red ekranında mesaj gönderim öncesi düzenlenebilir.
- Hatırlatma tercihleri (APPT-014) onaylanan randevuya da uygulanır.
- Klinik tarafı: **bildirim merkezi** (APPT-015) — kullanıcıya kalıcı bildirim listesi, okunmamış rozeti, tür filtresi. İlk türler: yeni randevu talebi (yetkisi olanlara), talep iptali, kişiye atanan iş (UX-008). Bildirim merkezi açık işler listesinin yerini almaz; yalnız olay tabanlı ve kişiye yönelik olanları taşır (UX-008 notu).
- Push ve WhatsApp sonra (MOBILE-003, PORTAL-010).

### K6 — Kötüye kullanım koruması

- Bağlantı uçları kimliksizdir: IP başına hız sınırı (portal-auth politikası), aynı e-posta + klinik için en fazla 3 bekleyen talep, kod doğrulaması zorunlu.
- Klinik bağlantıyı kapatabilir ya da yeniden üretebilir; online randevu varsayılan kapalı.

### K7 — Takvim görünümü (APPT-016)

- Bekleyen talepler takvimde istenen saatte farklı görünümle (kesik çerçeve, "Talep") gösterilir; filtre ile gizlenebilir. Tıklanınca kuyruktaki talep açılır.

## Sonuçlar

- Backend: `AppointmentReason`, `AppointmentRequest` (+ durum geçmişi), klinik online randevu ayarları, kimliksiz bağlantı uçları, portal uçları, müsaitlik sorgusu, e-posta şablonları, bildirim modeli. Migration'lar yalnız yerel DB'ye; canlı listesi kılavuz §11.1.
- Frontend: panelde neden yönetimi, online randevu ayarları ve bağlantı, talep kuyruğu, takvim katmanı, bildirim merkezi; portalda talep akışı; bağlantı sayfası.
- Hukuki: bağlantı formu kişisel veri topluyor; portal gizlilik taslağına "randevu talebi" maddesi eklenmeli (HUKUKI-ONAY-LISTESI C6 ile).

## Değerlendirilen seçenekler

- **Yalnız portal:** en güvenli, ama hesabı olmayan yeni müşteriye kapalı.
- **Herkese açık form, doğrulamasız:** en kolay, kötüye kullanıma açık.
- **Portal + doğrulamalı bağlantı (seçilen):** kayıtlı müşteriye hızlı, yeni müşteriye açık, sahte talebi e-posta koduyla sınırlar.
