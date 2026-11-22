# 2026-11-23 — Tasarım taraması düzeltmeleri

**Canlıda:**
- API `1649c2ea`
- Panel `6dbe352a` (`main-BRIL3IOJ.js`)
- Portal (`main-DR7ZUFIF.js`)
- Klinik sitesi

Bu sürümde migration ve seed yok.

Kaynak: Fable'ın 2026-11-22 tasarım taraması. 172 ekranda 71 bulgu çıktı: Y 9, O 44, D 18. Rapor koordinatör notlarında: `tasarim-taramasi-2026-11-22.md`.

## Ne değişti

- **Liste tabloları:** 1280 px'te kart genişliğine sığıyor; son sütun sağa yapışık. Ortak kural `_utils.scss` içindeki `list-table` sınıfında. Gereksiz sütunlar kaldırıldı: para birimi, ödenen, tek klinikte klinik adı.
- **Hastalar listesi:** Müşteri adı görünüyor. API'de `PetListItemDto.ClientName` var; kilo bilinmiyorsa `null` dönüyor.
- **Kurum üyeleri:** Ad, rol ve klinik görünüyor. API'de `/members` listesine `roles` ve `clinics` alanları eklendi.
- **Filtre ve sekmeler:** Hatırlatma geçmişinin filtre çubuğu düzeldi. Sekme çubuğu telefonda tek satırda kalıyor ve yatay kayıyor.
- **Takvim ve randevu:** Gün görünümü mesai başından açılıyor. Hafta başlıkları artık kesilmiyor. Randevu ayrıntısında "Geldi" düğmesi var.
- **Okunurluk:** Koyu temada paket tablosunun kontrastı düzeltildi. Portal birincil rengi panelle aynı turkuaz oldu; kontrast açık temada 4,8:1, koyu temada 8,2:1.
- **Terimler:**
  - Tek terim kullanılıyor: geliş, klinik, kurum, yöntem, ırk.
  - Muayene için randevudan gelişte "Muayeneye al", gelişsizde "Muayene başlat".
  - Rapor menü adları sayfa başlıklarıyla aynı.
  - Başlıklar cümle düzeninde.

## Testler (birleşik main)

- Backend Application: 4643/4643.
- Backend Integration: 2267 geçti, 4 atlandı, 0 başarısız.
- Panel tam takım (dalda): web 3821/3821, portal 271/271, site 42/42.
- web, portal ve site derlemeleri başarılı.
- Portal stil bütçesi uyarısı: `portal-content.scss` 2,70 kB.

## Doğrulama

- API aktif, `/health/ready` 200, günlükte hata yok.
- Panel `main-*.js` ve `ngsw.json` zaman damgası yerel derlemeyle aynı.
- Portal `main-*.js` aynı.
- www, `/veteriner`, portal ve API 200.
- Geri alma için sunucuda saklı: `api-eski` (`9e75d4e7`), `web-eski`, `portal-eski`, `site-eski`.

## Kalanlar

- Düzen değişikliği gerektiren 13 iş (seçenek tasarımı bekliyor): B-01, B-02, G-02, G-04, R-02, M-02, A-04, S-03, S-05, L-01, T-03, T-04, W-01.
- Küçük maddeler:
  - Ortak bileşen işleri: G-10 (ortak rapor filtresi), G-11 (yapışkan Kaydet çubuğu).
  - Diğerleri: G-12, B-03, M-03, K-02, S-01, S-04, A-06, L-02, PO-02, PO-03, PO-04, W-02, W-03.
- Takvimde "Boş saat bul" satırları başka gün açıkken "Bugün" yazıyor (olası hata).
- Para birimi seçimi formlardan kalkacak (ADR-012: yalnız TRY). Sonraki tura alındı.
- Kullanıcı kılavuzu yeni terimlere göre güncellenecek.

## Doğrulanmayanlar

- Canlıda girişle denenmedi.
- Yerelde de denenmeyenler:
  - hekim ve sekreter rolleri;
  - Ücretler ve Raporlar ekranları 375 px'te;
  - portalın 1280 px görünümü.
