# ADR-018 — Ücret önerisi ve hizmet kataloğu

## Durum

**Taslak, kabul önerisi (2026-10-14).** Karar yolu: rakip pratiği (E-vet, DaySmart) ve mevcut ADR'lerle uyumlu en basit model; gerekçesi aşağıda. Kullanıcı onayı bekler. Kaynak: [HEDEF-IS-AKISLARI-2026-10.md](../ux/HEDEF-IS-AKISLARI-2026-10.md) bölüm 1.4 ve dilim D4, [RAKIP-IS-AKISI-CALISMASI-2026-10.md](../ux/RAKIP-IS-AKISI-CALISMASI-2026-10.md), [ADR-017](ADR-017-workflow-centered-navigation.md) K2 (ücret önerisi kabul; model burada).

## Bağlam

Hekim işlemi (uygulama, aşı) kaydeder, ücreti resepsiyon yazar ([ADR-012](ADR-012-basic-charges-payments-balance.md) karar 2: hekim `Charges.Create` yok). Arada köprü olmadığı için ücret unutulur, resepsiyon kalemleri sayfa gezerek bulur. Rakipte işlem içinden doğan kalemler fiyatlı katalogdan gelir. Bizde ürünün fiyatı var ([ADR-016](ADR-016-direct-sale.md)), hizmetin yok; FIN-008 bu yüzden yeniden açılır.

## Kararlar

| # | Konu | Karar | Gerekçe |
|---|---|---|---|
| 1 | Model | **Hesaplanan öneri, kalıcı "öneri" varlığı yok.** "Ücret bekliyor" kalemi, ücreti henüz bağlanmamış aktif işlem kaydıdır (bugün: `Administration`, aşıya bağlı olanlar dahil). Kalıcı olan yalnız iki iz: `Charge.SourceType/SourceId` (hangi işlemden doğdu) ve ücretsiz sayma kaydı. | Kalıcı öneri satırı, işlem kaydı ve iptal/değişiklikte ikinci bir yerde tutarlılık sorunu çıkarır (kural iki yerde yaşar). Hesaplanan listede işlem kaydı tek doğruluk kaynağıdır; "önerilen" ile "gerçek" ayrışamaz. |
| 2 | Çift ücret | İşlem başına **en çok bir ücret**: `Charge` kaynağı kiracıda benzersiz (DB düzeyinde). Dönüştürme `requestId` ile idempotent; aynı kaynağa ikinci ücret reddedilir. | Eşzamanlı iki resepsiyon, yeniden deneme ve çift tık güvenli. |
| 3 | Dönüştürme | Rsp ve yönetici düzeyi (`Charges.Create`), tek tıkla; ad, miktar, birim fiyat kaynaktan dolu ve düzenlenebilir. Hekim yalnız **okur** (`ChargeSuggestions.Read`); ücret ekleyemez (ADR-012 K2 korunur). | |
| 4 | Ücretsiz say | Gerekçeli (5–500), audit'li, geri alınmaz; kalem listeden düşer. | Aksi halde bedelsiz işlemler listede sonsuza kadar kalır ve liste gürültüye döner. |
| 5 | Uygulama iptali | İptal edilen uygulama listeden düşer. Ücreti **zaten kesilmişse** ücret kendiliğinden değişmez (ADR-013 D5 çizgisi); yönetici ücreti ayrıca düzeltir/iptal eder. | Ücret finansal kayıttır, otomatik silinmez. |
| 6 | Ücret iptali | Ücret iptal edilince kalem **geri "bekliyor" olmaz.** | Yanlış ücretin iptali "bu işlem için ücret kararı verildi" bilgisini silmemeli; düzeltme elle serbest ücretle yapılır. Hata kolay geri alınmaz ama sessiz çift ücret riski kalkar. |
| 7 | Hizmet kataloğu | Ürün kataloğuna **`Service` ürün türü**: stok yok, fiyat var. KDV, birim dönüşümü, paket/bundle sonra. Hizmet uygulama, satış, reçete ve stok hareketinde kullanılamaz. | FIN-008'in en küçük hali; mevcut `Product` genişler, yeni katalog tablosu yok. |
| 8 | Kapsam (pilot) | Kaynak yalnız **uygulama** (stoktan düşen, aşı dahil). Tedavi, yatış günü ve lab için kalem **bu dilimde yok**: bu kayıtlarda ürün/hizmet bağı olmadığından fiyat kaynağı yok; hekimin işlemde hizmet seçmesi ayrı dilim (hizmet seçimi + bu ADR'nin kaynak türü genişlemesi). | Asgari pilot (D4) uygulama ve aşı kalemleridir. |
| 9 | Muayene göstergesi | Muayene özetinde **bekleyen ücret kalemi sayısı** (hekim ve resepsiyon görür); kesinleştirme kontrolü ve gün sonu bu sayıyı kullanır. | Kural tek sorguda. |

## Sonuçlar

- Backend: `Charge`'a kaynak izi (migration), ücretsiz sayma tablosu (migration), `Service` türü ve stok kapıları, `ChargeSuggestions` uçları (liste, dönüştür, ücretsiz say), izin `ChargeSuggestions.Read`. Sözleşme önce: backend `docs/CHARGE_SUGGESTION_API_CONTRACT.md`.
- Frontend: Ücretlendir yan paneli, Bugün rozeti, hizmet ürün formu.
- Ertelenen: tedavi/yatış/lab kalemleri (hizmet seçimi), paket/bundle, KDV, ücretsiz saymanın geri alınması, toplu dönüştürme.
- Riskler: ücret iptalinde kalemin geri gelmemesi bir ürün tercihidir, pilotta gözlenir; hesaplanan liste büyürse (binlerce uygulama) sorgu indeksi gerekir (kaynak indeksi var, ölçülmedi).
