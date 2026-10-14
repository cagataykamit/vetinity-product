# ADR-016 — Doğrudan satış (muayenesiz ürün satışı)

## Durum

**Kabul edildi (2026-10-14, kullanıcı: "onaylıyorum", önerilen cevaplarla).** Kaynak: backend `docs/DIRECT_SALE_DISCOVERY.md` (bölüm 7, 10 karar). Rakip analizindeki "doğrudan satış" boşluğunu kapatır ([RAKIP-ANALIZI-2026-10.md](../roadmap/RAKIP-ANALIZI-2026-10.md)).

## Bağlam

Bugün `Charge` (ücret) ürüne bağlı değil ve stok düşmez; `Administration` stok düşürür ama hayvan zorunlu ve ücret üretmez. "Ürün sat → hem stok düş hem ücret yaz" yapan tek bir akış yok. Klinikler mama, ilaç ve aksesuarı muayenesiz de satar.

## Kararlar

| # | Konu | Karar |
|---|---|---|
| 1 | Model | Yeni **`Sale` + `SaleLine`** varlığı. Satış komutu mevcut komutlarla ücret ve stok hareketini üretir. `Charge` ve `Administration` genişletilmez. |
| 2 | Müşterisiz satış | Her kliniğe tek bir **"Peşin müşteri"** kaydı; bu müşteriye satış hep tam ödenir. |
| 3 | Aşı ve narkotik/psikotropik | İlk sürümde **satılamaz** (yalnız hekim uygulamasıyla). Sonra, müşteri+hayvan zorunlu olarak açılabilir. |
| 4 | Veresiye | Müşterili satışta olabilir (mevcut bakiye/tahsis kuralları); Peşin müşteride ödeme zorunlu. |
| 5 | Ücret | Satış başına **tek ücret**, açıklaması "Ürün satışı"; satır dökümü satışta durur. |
| 6 | Fiyat | Ürün fiyatı varsayılan, satırda düzenlenebilir (gerekçesiz); ayrı indirim alanı ilk sürümde yok. |
| 7 | Süresi geçmiş parti | Satış **engellenir** (uygulama kuralıyla aynı, [ADR-015](ADR-015-batch-based-stock-and-registers.md) karar 6); miktar tek partiye sığmazsa kullanıcı iki satır girer. |
| 8 | İptal/iade | İptalde "stoğa dön / zarar yaz" seçimi sorulur ([ADR-013](ADR-013-finalized-examination-late-entries-and-administration-void.md) çizgisi); ilk sürümde yalnız **tam iptal**, kısmi iade sonra. |
| 9 | Yetki | Satış: sekreter ve yönetici düzeyi. İptal: yalnız Admin/Owner/ClinicAdmin. Veteriner şimdilik satış yapmaz. |
| 10 | Belge | Bilgi amaçlı fiş; fatura/e-belge ayrı iş (INT-007). Mevzuat doğrulanmadı, pilot klinik muhasebecisine sorulmalı. |

## Sonuçlar

- Backend: `Sales` ve `SaleLines` tabloları (migration, yerel dev DB'ye doğrulayarak uygulanır; paylaşılan/üretim için ayrı onay), satış oluşturma/iptal/listeleme uçları, izinler, requestId idempotency, RowVersion, audit; "Peşin müşteri" kaydının güvenli oluşturulması. Sözleşme önce.
- Frontend: satış ekranı (sepet, parti/FEFO önerisi, ödeme), satış listesi, iptal akışı, fiş görünümü.
- Defterler: aşı ve narkotik satılamadığı için Aşı Bilgi ve narkotik sarf defterleri etkilenmez.
- Ertelenen: kısmi iade, indirim, aşı/narkotik satışı, fatura/e-belge, veresiye raporunda satış ayrımı.
- Riskler: Peşin müşteri kaydının her klinikte tek olması ve silinememesi; satış tutarı ile ücret tutarı tutarlılığı (kural satış komutunda tek yerde).
