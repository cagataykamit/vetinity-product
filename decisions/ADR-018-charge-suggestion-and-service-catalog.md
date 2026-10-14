# ADR-018 — Ücret önerisi ve hizmet kataloğu

## Durum

**Taslak, kabul önerisi (2026-10-14).** Backend uygulandı (`feat/ucret-onerisi`, push edilmedi; migration `AddChargeSuggestions` hiçbir paylaşılan veritabanına uygulanmadı). Karar yolu: rakip pratiği (E-vet, DaySmart) ve mevcut ADR'lerle uyumlu en basit model; gerekçesi aşağıda. Kullanıcı onayı bekler. Kaynak: [HEDEF-IS-AKISLARI-2026-10.md](../ux/HEDEF-IS-AKISLARI-2026-10.md) bölüm 1.4 ve dilim D4, [RAKIP-IS-AKISI-CALISMASI-2026-10.md](../ux/RAKIP-IS-AKISI-CALISMASI-2026-10.md), [ADR-017](ADR-017-workflow-centered-navigation.md) K2 (ücret önerisi kabul; model burada). Sözleşme: backend `docs/CHARGE_SUGGESTION_API_CONTRACT.md`.

## Bağlam

Hekim işlemi (uygulama, aşı) kaydeder, ücreti resepsiyon yazar ([ADR-012](ADR-012-basic-charges-payments-balance.md) karar 2: hekim `Charges.Create` yok). Arada köprü olmadığı için ücret unutulur, resepsiyon kalemleri sayfa gezerek bulur. Rakipte işlem içinden doğan kalemler fiyatlı katalogdan gelir (rolsüz). Bizde ürünün fiyatı var ([ADR-016](ADR-016-direct-sale.md)), hizmetin yok; FIN-008 bu yüzden yeniden açılır.

## Kararlar

| # | Konu | Karar | Gerekçe |
|---|---|---|---|
| 1 | Model | **Kalıcı "ücret bekliyor" kalemi** (`ChargeSuggestion`): işlem kaydıyla **aynı transaction'da** doğar; ücret değildir. Durum: `Pending` → `Converted` \| `Waived` \| `Cancelled`, geri dönmez. İlk taslaktaki "hesaplanan liste" seçeneği **reddedildi**. | Hesaplanan listede (1) migration öncesi bütün uygulamalar bir anda "bekliyor" görünür (geçmiş ücretler serbest ücretle zaten kesilmiş, eşleşmez); (2) eşzamanlı karar için kilitlenecek satır yoktur, uygulama iptali ile çevirme yarışı kapanmaz; (3) ileride tedavi/lab/yatış/hizmet kaynakları her biri ayrı sorgu birleşimi ister; (4) ücretsiz sayma için yine ayrı tablo gerekir. Kalıcı kalemde liste tek tablo, kural tek varlıkta; "kural iki yerde" riski kalemin yalnız kaynakla aynı transaction'da yazılması/düşürülmesiyle kapanır. |
| 2 | Çift ücret | Kalem başına **en çok bir ücret**: yalnız `Pending` çevrilir; kalemin `RowVersion`'ı eşzamanlı iki karardan birini kabul eder (kaybedenin ücreti aynı transaction'da geri alınır); `requestId` tekrarı ilk ücreti döndürür. DB: kaynak `(tür, kimlik)` ve `chargeId` benzersiz. | Eşzamanlı iki resepsiyon, yeniden deneme ve çift tık güvenli. |
| 3 | Dönüştürme | Rsp ve yönetici düzeyi (`Charges.Create`), tek tık (boş gövde); ad, miktar, birim fiyat kalemden dolu ve düzenlenebilir. Ücret mevcut ücret kurallarıyla (müşteri = hayvanın güncel sahibi, muayene ve güncel geliş bağı) yazılır. Hekim yalnız **okur** (`Charges.Read`, zaten hekimde var); ücret ekleyemez (ADR-012 K2 korunur). **Yeni izin yok**, seed gerekmez. | Okuma için ayrı izin, aynı rollere giden ikinci bir anahtar olurdu. |
| 4 | Fiyat | Kalem doğduğu andaki **katalog fiyatı** saklanır; sonradan katalog değişikliği bekleyen kalemi değiştirmez. TRY değilse/ücret kuralına uymuyorsa boş, resepsiyon girer. Katalogda **bedelsiz (0)** tanımlı ürün kalem doğurmaz. | Rakipte satır fiyatı işlem anında oluşur. Bedelsiz ürünü listeye sokmak gürültü üretir; bilinçli ücretsiz katalog kararıdır. |
| 5 | Ücretsiz say | Gerekçeli (5–500), audit'li, geri alınmaz; kalem listeden düşer. | Aksi halde bedelsiz işlemler listede sonsuza kadar kalır. |
| 6 | Uygulama iptali | İptal edilen uygulamanın **bekleyen** kalemi aynı transaction'da düşer (`Cancelled`). Ücreti **zaten kesilmişse** ücret ve kalem değişmez (ADR-013 D5 çizgisi); yönetici ücreti ayrıca düzeltir/iptal eder. İptal ile çevirme yarışında tek kazanan (RowVersion); kaybeden iptal 409 alır, tekrar denenir. | Ücret finansal kayıttır, otomatik silinmez. |
| 7 | Ücret iptali | Ücret iptal edilince kalem **geri "bekliyor" olmaz** (`Converted` kalır). | Yanlış ücretin iptali "bu işlem için ücret kararı verildi" bilgisini silmemeli; düzeltme elle serbest ücretle yapılır. Sessiz çift ücret riski kalkar. |
| 8 | Hizmet kataloğu | Ürün kataloğuna **`Service` ürün türü**: stok yok, fiyat var, kontrollü sınıf olamaz, türü sonradan değişmez. KDV, birim dönüşümü, paket/bundle sonra. Hizmet uygulama, satış, reçete ve stok hareketinde kullanılamaz. | FIN-008'in en küçük hali; mevcut `Product` genişler, ürün sınıfı/kontrollü sınıf alanlarıyla çakışmaz. |
| 9 | Kapsam (pilot) | Kaynak yalnız **uygulama** (stoktan düşen, aşı kaydıyla yazılan dahil). Tedavi, yatış günü, lab ve hizmet seçimi **bu dilimde yok**: bu kayıtlarda ürün/hizmet bağı yok, fiyat kaynağı yok. Geçmiş uygulamalar için kalem üretilmez (backfill yok). | Asgari pilot (D4) uygulama ve aşı kalemleridir. |
| 10 | Göstergeler | Muayene özetinde ve Bugün satırında **bekleyen kalem sayısı** (hekim ve resepsiyon görür); kesinleştirme kontrolü ve gün sonu bu sayıyı kullanır. | Kural tek sorguda. |

## Sonuçlar

- Backend: `ChargeSuggestions` tablosu (migration `20261014043646_AddChargeSuggestions`), `Service` türü ve stok kapıları, uçlar (liste, `{id}/convert`, `{id}/waive`), `related-summary.pendingChargeCount`, `visits/today` satırında `pendingChargeCount`. `Charge` değişmedi.
- Frontend: Ücretlendir yan paneli, Bugün rozeti, kesinleştirme kontrolünde "n ücret bekliyor", hizmet ürün formu, seçicilerden hizmetin çıkarılması.
- Ertelenen: tedavi/yatış/lab kalemleri ve hekimin hizmet seçmesi (yeni kaynak türleri aynı tabloya eklenir), paket/bundle, KDV, ücretsiz saymanın geri alınması, toplu dönüştürme, geçmiş uygulamalar için backfill.
- Riskler: ücret iptalinde kalemin geri gelmemesi ve bedelsiz ürünün kalem doğurmaması ürün tercihidir, pilotta gözlenir. Ücreti kesilmiş uygulamanın iptali ücreti kendiliğinden düzeltmez; yönetici düzeltmesi unutulabilir (gün sonu raporunda görünür kılınmalı, D6).
