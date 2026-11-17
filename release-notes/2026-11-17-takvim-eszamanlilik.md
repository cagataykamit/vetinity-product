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

## Ek yayın: 2026-11-17 22:50 (TSİ), geri alma 15 gün, güncelleme aktarması, aktarma satırlarının saklanması

**Yayınlanan:** backend `main` `6cda9ba7`, panel `main` `3bdbb891` (`main-42FFWWBN.js`). Portal değişmedi (`main-IUS6NQD7.js`), yeniden yayınlanmadı.
**Migration:** `AddImportSourceLinks` (ADR-051, kaynak kimliği eşleme tablosu); `migrate` ve `migrate-query` çalıştırıldı. Canlıda aktarma partisi yoktu, geriye dönük doldurulacak kayıt çıkmadı.
**Yedek:** Migration'dan önce elle yedek alındı (22:50, Drive kopyası doğrulandı).
**Doğrulama:** API `/health/ready` 200, tüm girdiler Healthy; yayın sonrası günlükte uyarı yok; panel yeni `main` dosyasıyla açılıyor.

- **Geri alma 15 gün:** aktarma uygulandıktan sonra 15 gün geri alınabilir. Aktarma ekranı başlatmadan önce "Aktarmadan sonra 15 gün içinde geri alabilirsiniz", bitince kalan günü ve son anı yazar; liste ve geri al sayfası kalan günü gösterir.
- **Güncelleme aktarması (ADR-051):** aynı programdan ikinci yedek mükerrer kayıt yaratmaz. Müşteri ve hasta önce programın kendi numarasıyla (E-vet müşteri no, hasta no) eşleşir; klinik kayıtta da mükerrer denetimi var. Önizlemenin en üstünde "Bu dosya önceki aktarmayla büyük ölçüde örtüşüyor: X yeni müşteri, Y yeni hasta… gelecek" özeti çıkar. Mevcut müşterinin bakiyesi dosyadakinden farklıysa farklar listelenir; varsayılan atlamaktır, tek seçimle farklar devir olarak açılır; geri almada bu hareketler de silinir.
- **Aktarma satırlarının saklanması (ADR-051 eki):** aktarılmış partinin satır ayrıntısı geri alma süresi dolunca silinir; parti kaydı ve sayıları kalır, ekran "satır ayrıntısı saklanmıyor" der. Aktarılmamış ya da tamamen geri alınmış parti aynı süre sonra kaydıyla silinir (denetim kaydı `ImportBatch.Deleted`). Ayrı 30 günlük saklama sabiti kalktı; süre tek yerde.
- **Bilinen sınırlar:** Ekranlar canlıda tarayıcıda denenmedi. Güncelleme aktarması yerelde ikinci E-vet yedeğiyle uçtan uca denendi, canlıda gerçek yedekle denenmedi. Performans testi koşulmadı. Testler: backend 1340 domain, 4402 uygulama ve 2167 entegrasyon testi geçti, 4 atlandı; panel 3401 testten 3400'ü geçti, düşen 1 test bu yayındaki metin değişikliğini bekleyen eski ifadeydi, düzeltildi ve geçti; portal 268, site 42 testin hepsi geçti.
