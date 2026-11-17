# Sürüm notu: 2026-11-17 21:03 (TSİ), takvim filtreleri ve ay görünümü, eşzamanlılık düzeltmeleri

**Yayınlanan:** backend `main` `d807f4bc`, panel `main` `0c2ac5e7` (`main-RAVWKYPP.js`), portal `main-IUS6NQD7.js` (oturum yenileme kilidi nedeniyle yeniden yayınlandı).
**Migration:** `RefreshTokenRevokedAtConcurrencyToken` (yalnız model anlık görüntüsü, şema değişmedi); `migrate` ve `migrate-query` çalıştırıldı.
**Yedek:** Migration'dan önce elle yedek alındı (21:03).
**Doğrulama:** API `/health/ready` 200, tüm girdiler Healthy; yayın sonrası günlükte uyarı ve hata yok; panel ve portal yeni `main` dosyalarıyla açılıyor.

- **Takvim filtreleri:** hekim, tür, durum ve şube filtresi sunucu tarafında çalışır.
- **Ay görünümü:** gün başına randevu ve aşı özeti; günün numarası üstte, telefonda sayı numaranın altında.
- **Aşı katmanı ve ayrıntı balonu:** takvimde yaklaşan aşılar görünür; randevu kartında neden ve not balonda, ayrıntı ve düzenleme pencerede açılır, ayrıntıdan iptal ve Geri al yapılabilir.
- **Izgara başlangıcı:** takvim yalnız gösterilen günlerin çalışma saatinden başlar ve ilk kayda kaydırılır. Kayıt zamanı gelmeyen randevuda "Oluşturulma / Güncellenme" satırı gizlenir.
- **Eşzamanlılık:** aynı anda gelen isteklerde çift randevu açılmaz (kiracı takvim kilidi, `ITransactionLock`); bekleyen talep, açık aktarma taslağı ve etkin API anahtarı sınırları aşılamaz; eksik Ana kasa aynı anda tamamlanınca ve kasa sayımı Ana kasayı tamamlarken 500 dönmez.
- **Oturum yenileme:** refresh token tek kullanımlık; aynı anda ikinci yenileme yeni jeton almaz. Panel ve portalda sekmeler yenilemeyi Web Locks ile sırayla yapar; çıkış ve yenileme yarışı 500 vermez.
- **Geri al sayfası:** geri alınamayan kayıtlar adıyla, nedeniyle ve bağlı oldukları kayıtla gruplu gösterilir.
- **Bilinen sınırlar:** Ekranlar canlıda tarayıcıda denenmedi. Geri alma süresinin 15 güne inmesi ve güncelleme aktarması bu yayında yok, kendi dallarında hazır. Testler: backend 1337 domain, 4383 uygulama ve 2164 entegrasyon testi geçti, 4 atlandı; panel 3386 testten 3385'i birleşik koşuda geçti, düşen 1 test (`date-input` gün seçince panel kapanır, eşzamanlı backend testi yükü altında zamanlama) tek başına 20/20 geçti; portal 268, site 42 testin hepsi geçti.
