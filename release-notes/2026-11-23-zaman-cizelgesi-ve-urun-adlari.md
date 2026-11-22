# 2026-11-23 — Zaman çizelgesi A ve ürün adı düzeltmesi

**Canlıda:**
- API ve DbMigrator `bcc964eb`
- Panel `1ee56528` (`main-HOJ5FLOJ.js`)

Bu sürümde migration ve seed yok. Elle yedek 02:32'de alındı (`gunluk/2026-11-23`); Drive kopyası doğrulandı.

## Ne değişti

- **Zaman çizelgesi (hasta kartı ve "Tarih filtreli tam liste"):** Kullanıcı A tasarımını seçti.
  - Kayıtlar gün başlıklı gruplarda gösteriliyor.
  - Her tür kendi rengi ve ikonuyla ayrılıyor.
  - Olağan durumlar soluk; bekleyen sarı, iptal kırmızı.
  - Klinik adı yalnız başka kliniğin kaydında görünüyor.
  - Eski kayıtlarda "Eski programdan" etiketi var.
  - Kurallar tek yerde: `pet-timeline.utils.ts`.
- **Ürün adı aktarması:** E-vet ve genel ürün aktarmasında noktasız "ı" hatası sözlükle düzeltiliyor.
  - Sözlük `ProductNameSpelling.cs` içinde: 281 harf dizisi.
  - Sözlükte olmayan şüpheli kelimeler önizlemede `Imports.ProductNameSpellingSuspect` uyarısıyla gösteriliyor.
  - Müşteri, hasta ve diğer alanlara dokunulmuyor.
- **DbMigrator:** `fix-product-names --tenant <id> [--dry-run]` komutu eklendi. Tek kiracıda çalışıyor ve tekrar çalıştırılabiliyor.

## Canlı veri düzeltmesi

- **Kiracı:** DOGUSZONGULDAK (E-vet aktarması 2026-11-17).
- **Deneme:** 949 ad çıktı. Bu liste yerel deneme listesiyle birebir aynıydı.
- **Uygulama:** 949 ürün adı düzeltildi. İkinci çalıştırmada 0 değişiklik oldu.
- **Kontrol örneği:** "8In1 Delıghts Strong Xs" → "8In1 Delights Strong Xs".
- **Dokunulmayanlar:**
  - Doğru Türkçe kelimeler (Açık, Kırmızı, Maması…).
  - "Sadı" (kullanıcı kararı: olduğu gibi kalsın).
  - Satış ve ücret satırlarındaki satış anı ad kopyaları.
- Önce/sonra listesi koordinatör notlarında: `urun-adi-i-dryrun-canli.tsv`.

## Testler (birleşik main)

- Backend Domain 1406/1406, Application 4673/4673, Integration 2267 geçti / 4 atlandı / 0 başarısız.
- Panel: 3835/3836. Kalan test `date-input-datetime` zaman aşımı (bilinen, yük altında); tek başına 7/7 geçti.
- Portal 271/271, site 42/42.
- `ng build vetinity-web` başarılı.

## Doğrulama

- API aktif, `/health/ready` 200, günlükte hata yok.
- Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı.
- Geri alma için sunucuda saklı: `api-eski` (`1649c2ea`), `web-eski`, `dbmigrator-eski`. Ad düzeltmesi için yedek noktası 02:32.

## Sonraki tur

- Sözlüğe yalnız büyük I'lı kelimeler eklenecek: "Ip"→"İp" (42 kez), "Iyot", "Iyodür".
- Sözlüğe yaygın mama kelimeleri eklenecek: Senior, Indoor, Sensitive, Digestive.
- Aralıklı takılan `date-input-datetime` testi kararlı hale getirilecek.

## Doğrulanmayanlar

- Zaman çizelgesi canlıda girişle denenmedi.
- "Eski programdan" etiketi ve başka klinik adı yalnız birim testiyle doğrulandı.
