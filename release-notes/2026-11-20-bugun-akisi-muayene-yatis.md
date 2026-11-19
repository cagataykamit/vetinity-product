# Sürüm notu: 2026-11-20 (TSİ), Bugün akışı denetim düzeltmeleri, gelişsiz muayene ve yatan hasta

**Yayınlanan:** backend `main` `a2c0ab2e`, panel `main` `cd0ce138` (`main-GZEXW47L.js`). Portal ve site değişmedi, yeniden yayınlanmadı.
**Migration:** yok. İzin ve `seed` değişikliği yok.
**Yedek:** Migration olmadığı için alınmadı (kılavuz §5.2). Önceki paketler sunucuda `api-eski` ve `web-eski` olarak saklı.
**Doğrulama:** `vetinity-api` aktif, `/health/ready` 200, yayın sonrası günlükte ERR/FTL yok; panel yeni `main` dosyasıyla açılıyor (`200 application/javascript`), www 200, `api.vetinity.com/health/live` 200.

- **Gelişsiz muayene (kullanıcı kararı, Karar 1 A):** geliş seçilmeden açılan ve bugüne tarihli muayene hayvanın açık gelişine bağlanır; açık geliş yoksa aynı işlemde yeni geliş açılır ve "muayenede" olur. Sorumlu hekim, kaydı açan klinik hekimiyse odur, değilse randevunun hekimi. Geçmiş tarihli muayene ve içe aktarma geliş açmaz (EXAMINATIONS_WORKSPACE sözleşmesi).
- **Yatan hasta (kullanıcı kararı, Karar 2 A):** yatan hastanın gelişi taburcuya kadar açık kalır; "Önceki günden açık" sayısına ve "Unutulmuş olabilir" uyarısına girmez. Taburcu edilince yatış ekranı "Gelişi tamamla" önerir (OPEN_ITEMS K-D2-8).
- **Bugün satırı:** "Muayene aç" gelişin mevcut muayenesini açar (yeni boş muayene açmaz). Muayene sayfasında bağlı geliş açıksa "Bugün'e dön" ve "Ziyareti tamamla".
- **Ücretsiz kararı sonradan:** tamamlanmış ücretsiz gelişte "Ücretsiz" işareti sonradan verilebilir; açık geliş listesinde "Tamamla" aynı soruyu sorar.
- **Randevunun hekimi:** gelişe ve Bugün'ün planlı satırına geçer, Geldi penceresinde önseçili gelir; hekim filtresi planlı satırlara da uygulanır.
- **Açık işler:** "Ücret bekliyor: N kalem" çipi, bekleyen ücret kalemleri sayfasına götürür.
- **e-Belge önerisi:** ziyaret kapanınca e-Belge penceresi yalnız belge kesme izni olana açılır.
- **Bilinen sınırlar:** ekranlar canlıda tarayıcıda denenmedi. Yapay zekâ serisi kendi dallarında, yayında değil. Testler: backend 4413 uygulama ve tam entegrasyon paketi 2179 test geçti (4 atlandı); panel 3486, portal 268, site 42 testin hepsi geçti.
