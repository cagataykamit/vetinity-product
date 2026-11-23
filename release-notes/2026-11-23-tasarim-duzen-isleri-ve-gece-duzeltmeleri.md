# 2026-11-23 — Tasarım düzen işleri, klinik sitesi yenilemesi, hukuki metinler ve gece düzeltmeleri

**Canlıda (09:45 civarı):**
- API `3ac749d1`.
- Panel `498bafa9` (`main-667WGS2C.js`).
- Portal aynı commit'ten (`main-4X6GMUJ7.js`).
- Klinik sitesi aynı panel commit'inden.

**Veritabanı:**
- Migration: `AddClientPetSoftDelete` (komut DB), `AddClientPetReadModelIsDeleted` (sorgu DB). Yalnız ekleme: yeni sütunlar ve müşteri e-posta+telefon benzersiz indeksine `DeletedAtUtc IS NULL` süzgeci.
- Seed: 4 yeni yetki bağı (`Clients.Delete`, `Pets.Delete`; Admin, Owner, ClinicAdmin), geri alınan yok.
- Öncesinde elle yedek alındı: `gunluk/2026-11-23/*_09-42.bak`, Drive kopyası doğrulandı.
- Ürün adı düzeltmesi (DOGUSZONGULDAK): 49 ad (İp, İyot, İyodür, İntrameduller). Sonraki dry-run 0.

## Ne değişti

**Tasarım düzen işleri (2026-11-22 taraması, kullanıcının seçtiği seçenekler)**
- **Bugün (B-01 A, B-02 A):** Telefonda tek "Randevusuz geliş" düğmesi ve "…" menüsü; açık işler tek satır özet. HBS ve gecikmiş randevu çipleri Bugün'den Rapor Merkezi "Bakmanız gerekenler" bandına taşındı ([ADR-052](../decisions/ADR-052-ozet-kaldirilir-rapor-merkezi-sorular.md) 2026-11-23 eki); Bugün'de "Birikmiş n iş Raporlar'da →" bağlantısı. B-03, B-06, B-07.
- **Liste filtreleri (G-02 A, G-10, R-06):** Telefonda arama + "Filtre (n)"; rapor filtre çubukları tek desen ("Filtrele", "Temizle", "Dışa aktar ▾").
- **Telefon listeleri (G-04 B):** Gün başlıklı ince satırlar, dokununca açılır.
- **Mal kabul (S-03 B):** Telefonda özet satırlar, tek satır düzenleme.
- **Takvim (R-02 A, R-01):** 1440 px altında sağ panel kapalı, "Hekimler" menüsü.
- **Hasta kartı (M-02 B, M-03):** Üç gruplu eylem şeridi; "Vefat olarak işaretle" "…" menüsünde.
- **Hasta sahibi portalı ayarı (A-04 A):** Tam genişlik tablo, belirgin başlıklar.
- **Kasa (S-05 A):** Para › Kasa sekmesi; tanımlar Ayarlar › Tanımlar'da. Rapor Raporlar › Kasa hareketleri'nde kaldı.
- **Giriş, kayıt, şifre, davet (L-01, L-03):** Tanıtımın sıcak diline uyarlandı; yapı ve metin aynı.
- **Paketler (T-04 A):** Telefonda paket seçici + tek sütun.
- **Klinik sitesi (K-01, W-01 A):** Dört konsept tek düzen; üst kısım renkli giriş bölümü, gövde sakin kartlar; telefonda altta "Ara · Randevu al" şeridi; normal ölçüde telefon, "Haritada aç"; üst çubukta en çok beş bağlantı.

**Küçük tasarım maddeleri:** G-05, G-08 (KVKK yer tutucu düğmeleri), G-11, G-12, G-14, G-15, G-16, K-02, K-04, M-04, M-05, S-01, S-04, S-06, Y-02, A-06, A-07, PO-02…06, W-02…04; tarih-saat alanında gün seçince panel açık kalır.

**Diğer düzeltmeler**
- Para birimi seçimi formlardan kalktı (ADR-012, yalnız TRY).
- Takvimde "Boş saat bul" açık günden arar.
- Rapor Merkezi açılışında yer tutucu; ekran sonradan kaymıyor.
- Yeni randevu formunda takvimden gelen saat silinmiyor (APPT-025).
- Aşı çift sayımı: planlı kayıt aynı aşının önceki sonraki tarihini kapatır.
- Tanıtım: "Şimdilik aktarılmaz" listesi kaldırıldı, SSS olumlu; telefonda üst çubuk opak ve tam genişlik; alt bilgi "© 2026 Vetinity".
- Kamerayla barkod okutma tüm paketlerde ([ADR-035](../decisions/ADR-035-paketler-ve-fiyat.md) eki).
- Ürün adı sözlüğü: İp, İyot, İyodür, İntrameduller ve mama kelimeleri.

**Hukuki metinler:** Panel ve portal metinlerinde köşeli parantezli yer tutucular kalktı; deneme 14 gün, iade/iptal, saklama ve silme cümleleri koddaki gerçeğe uyduruldu (otomatik silme vaadi yok; talep üzerine), Google (e-posta) alt işleyenlere eklendi, barındırma yeri Türkiye. Sürümler: Terms 1.1, Privacy 1.3, DataProcessing 1.2, PortalTerms 1.1, PortalPrivacy 1.2 — kullanıcılar bir kez yeniden onay verir.

**Müşteri ve hasta yumuşak silme — yalnız backend ([ADR-054](../decisions/ADR-054-musteri-hasta-yumusak-silme.md)):** Uç noktalar ve kurallar canlıda; panelde düğme henüz yok (ayrı yayın).

## Testler (birleşik main)

- **Backend:** Domain 1417/1417, Application 4707/4707, Integration 2277 geçti, 4 atlandı, 0 başarısız.
- **Panel:** 492 dosya, 3871/3871. Portal 279/279, site 43/43.
- **Derleme:** web, portal, site başarılı (portal'da bilinen iki stil bütçesi uyarısı).

## Doğrulama

- `vetinity-api` ve `vetinity-site` aktif, `/health/ready` 200; son 10 dakikada API ve site günlüğünde hata yok.
- Panel `main-*.js` ve `ngsw.json` zaman damgası yerel derlemeyle aynı, `ngsw.json` no-cache. Portal `main-*.js` aynı.
- www, `/paketler`, `/veteriner`, portal 200. Yeni `clients/deleted` ucu girişsiz 401.
- **Geri alma:** Sunucuda `api-eski` (`bcc964eb`), `web-eski`, `portal-eski`, `site-eski`, `dbmigrator-eski` saklı. Şema için yedek noktası 09:42.

## Notlar

- Hukuki metin sürümleri arttığı için personel, klinik yöneticileri (veri işleme sözleşmesi) ve portal kullanıcıları ilk girişte yeniden onay ekranı görür.
- Yeni silme yetkileri için yöneticiler çıkış yapıp yeniden girmeli (panel ekranı gelince).

## Doğrulanmayanlar

- Canlıda girişle yeni ekranlar denenmedi.
- Klinik sitesinin canlıdaki yayınlanmış sitelerde görünümü girişsiz açılan sayfa dışında denenmedi; paneldeki site oluşturucu önizlemesi tarayıcıda açılmadı.
- Gerçek telefon ve Safari denenmedi.
