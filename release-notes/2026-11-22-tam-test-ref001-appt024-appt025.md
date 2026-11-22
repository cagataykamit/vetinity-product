# 2026-11-22 — Tam test düzeltmeleri, lab işareti ve ilaç rehberi, talep geçmişi, oda ve cihaz takvimi

**Canlıda (22:45 civarı):**
- API `9e75d4e7`.
- Panel `48431432` (`main-VDABW32E.js`).
- Portal (`main-MDTQ5ZKD.js`).
- Klinik sitesi aynı panel commit'inden.

**Veritabanı:**
- Migration: `AddLabResultLines`, `AddDrugGuideCatalog`, `AddAppointmentResources`. Yalnız ekleme yapıyor; silme ve tür değişikliği yok.
- Seed: 7 yeni yetki bağı eklendi, geri alınan yok.
- Öncesinde elle yedek alındı: `gunluk/2026-11-22/*_22-41.bak`, Drive kopyası doğrulandı.

## Ne değişti

**Tam test düzeltmeleri (yerel tam test, aynı gün)**
- **Aşı:**
  - Uygulanmış aşının sonraki tarihi artık yaklaşan ve gecikmiş aşı sayılıyor. Kural tek yerde: `VaccinationDueRule`.
  - Bu tanımı listeler, hasta kartı, portal, Rapor Merkezi, AI araması ve hatırlatma birlikte kullanıyor.
  - E-vet ile aktarılan kayıtlar dönüşüm gerekmeden sayılıyor.
- **Çalışma saatleri:** Yeni klinikte ilk kez kaydedilebiliyor (`isConfigured`). Hatalı gün satırında neden yazıyor. Liste Pazartesi ile başlıyor.
- **Davet:** Davet ve "Yeniden gönder" e-posta gönderiyor.
- **Roller:**
  - Klinik yöneticisi kendi kliniğine personel davet edip üye yönetebiliyor.
  - Hekim müşteri ve hasta açabiliyor.
  - Rol adları Türkçe.
- **Kayıt ve katılım:** Ad-soyad soruluyor. Kayıt hataları alanın yanında.
- **İstek sınırı:** Giriş yapmış istekte kullanıcı başına 600/dk, girişsizde IP başına 200/dk.
- **Fiş ve muayene:**
  - Bilgi fişi hizmeti tam tutarla yazıyor; önceki ödeme ayrı satırda.
  - Muayene ayrıntısında klinik adı görünüyor.
- **Biçim:** Telefon, ondalık ve para biçimi her yerde aynı. Çip alanı yalnız rakam alıyor. Olağan dışı ateşte uyarı çıkıyor (kayıt engellenmiyor).
- **Portal:** Koyu tema geldi. Son muayene kilosu gösteriliyor. Aydınlatma metni eksiz ("Veri sorumlusu: …").
- **Abonelik ekranı:** Paket açıklamaları tanıtımla aynı. Denemede düğme "Bu pakete geç".
- **Salt okunur mod:** Bugün kısayolları pasif. Hata metni "Ayarlar → Abonelik" diyor.
- **İçe aktarma:** Kolayvet seçeneği gizlendi; örnek dosya gelince açılacak.
- **Reçete formu:** Hasta bilgisi adres çubuğundan ön doluyor.

**REF-001 (dilim 2–3)**
- Lab sonucuna değer satırları eklendi. Satırda düşük/normal/yüksek işareti, önceki değer ve eğilim var.
- İlaç rehberi (Stok > İlaç rehberi) açıldı; katalog boş. Ürün kartında rehber bağı var. Reçetede ve uygulamada hedef tür notu engellemeden gösteriliyor.
- Yeni izin: `DrugGuide.Read`, her rolde.

**APPT-024:** Online randevu talebi ayrıntısında durum geçmişi ve oluşan randevu satırı var.

**APPT-025, 1. dilim ([ADR-053](../decisions/ADR-053-kaynak-bazli-takvim.md) kabul edildi):**
- Tanımlar > Oda ve cihazlar ekranı eklendi.
- Randevuya bir oda ve bir cihaz atanabiliyor.
- Gün görünümünde kaynak sütunları var.
- Kapasite aşılırsa kayıt engelleniyor (409).

## Testler (birleşik main)

- **Backend Domain:** 1403/1403.
- **Backend Application:** 4642/4642.
- **Backend Integration:** 2266 geçti, 4 atlandı, 1 başarısız.
  - Başarısız test: `StockBatches…Same_RequestId_Out_That_Missed_Winner…`. Aralıklı bir eşzamanlılık testi; sınıfıyla 3 tekrarda 34/34 geçti.
  - Aynı aileden bir test, birleştirmeden önceki dalda da bir kez kalmıştı.
- **Panel:** 3812 testten 3811'i geçti. Kalan `date-input-datetime` testi zaman aşımına düştü; tek başına 7/7 geçti.
- **Portal ve site:** Portal 271/271, site 42/42.
- **Derleme:** web, portal ve site derlemeleri başarılı.

## Doğrulama

- `vetinity-api` aktif, `/health/ready` 200, günlükte hata yok.
- Yeni uçlar yetki istiyor: `drug-guide` ve `appointment-resources` 401 dönüyor.
- Panelin `main-*.js` dosyası ve `ngsw.json` zaman damgası yerel derlemeyle aynı; `ngsw.json` no-cache.
- Portal `main-*.js` aynı.
- www, `/veteriner` ve portal 200.
- **Geri alma:** Sunucuda `api-eski` (`ab708f5a`), `web-eski`, `portal-eski`, `site-eski`, `dbmigrator-eski` saklı. Şema için yedek noktası 22:41.

## Notlar

- Yeni yetkiler için kullanıcıların çıkış yapıp yeniden girmesi gerekiyor: hekimde müşteri/hasta açma, klinik yöneticisinde davet, herkeste ilaç rehberi.

## Doğrulanmayanlar

- Canlıda girişle hiçbir yeni ekran denenmedi.
- Davet e-postasının canlıda gerçekten gittiği denenmedi.
- Tarayıcıda yerelde de denenmeyenler:
  - davetle katılımda ad-soyad;
  - klinik yöneticisi ekranı;
  - kapasitesi 2 olan oda;
  - telefonda takvimde kaynak (gösterilmiyor).
