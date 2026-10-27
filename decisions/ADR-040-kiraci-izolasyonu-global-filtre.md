# ADR-040 — Kiracı izolasyonu: EF global filtre, kapalı varsayılan, açık kapsam

## Durum

**Kabul edildi (2026-10-27, kullanıcı: "Önerileri uygula").** Seçenek C. Denetim B2 için hazırlandı.

## Bağlam

- Denetim B2 (KOD-INCELEME 2026-10-24 ve 2026-10-27): kiracı izolasyonu tamamen elle yazılan koşullara dayanıyor.
  - Handler'da `TenantId is not { }` denetimi 185 yerde, `TryGetResolvedTenant` 259 yerde (24 Ekim'de 248).
  - Specification'lar kiracıyı parametre olarak alıyor: 246 spec dosyasının 205'i `TenantId` içeriyor. Bir spec'te koşul unutulursa veri başka kiracıya görünür; derleme ya da test bunu yakalamaz.
  - EF global filtre yalnız 3 yerde var ve hepsi geçersiz kılma (iptal edilmiş ücret/ödeme) içindir; kiracı filtresi yok.
- `TenantId` taşıyan 45 Domain varlığı var. Kiracısız olanlar: `Tenant`, `User`, `Species`, `Breed`, `PetColor`, `DiscountCode`.
- Kiracı bağlamı olmadan çalışan yollar:
  - 13 arka plan servisi (outbox işlemcisi, projeksiyonlar, hatırlatmalar, içe aktarma, planlı plan değişikliği, dosya ve token bakımı).
  - Hayvan sahibi portalı: kiracı JWT'den değil, sahip–müşteri bağlantısından (`OwnerAccountClientLink.TenantId`) çözülür ve birden fazla kiracıya yayılabilir.
  - Platform yönetimi, seed'ler, DbMigrator, herkese açık uçlar (kayıt, davet, demo talebi).
- Klinik düzeyi (`ClinicContextMismatch`, 22 kod / 62 kullanım) iş kuralıdır: kullanıcı birden fazla kliniğe erişebilir ve listelerde klinik filtresi isteğe bağlıdır. Global filtreye uygun değildir.

## Seçenekler

- **A. Yalnız test ile zorlama.** Mimari test, kiracılı varlığa giden her spec'in `TenantId` koşulu içerdiğini denetler. Çalışma zamanı değişmez, ama koşulun doğru değerle yazıldığını garanti etmez ve spec dışı sorguları (okuma modelleri, ham sorgular) kapsamaz.
- **B. Açık varsayılanlı global filtre** (`TenantId == ctx.TenantId || ctx.TenantId == null`). Arka plan yolları değişmeden çalışır, ama bağlam eksik olduğunda **her şeyi gösterir**. Güvenlik açısından kabul edilemez.
- **C. Kapalı varsayılanlı global filtre + açık kapsam (önerilen).** Sektörde yaygın çok kiracılı desen (Finbuckle, ABP veri filtreleri). Bağlam yoksa sorgu boş döner; bağlamsız çalışması gereken yol bunu açıkça ister.

## Karar (öneri: C)

1. **Varlık işareti.** Kiracılı varlıklar `ITenantOwned { Guid TenantId { get; } }` uygular.
2. **Global filtre.** `AppDbContext`, bu arayüzü uygulayan her varlığa EF Core 10 adlı filtresiyle `HasQueryFilter("Tenant", e => e.TenantId == CurrentTenantId)` ekler. `CurrentTenantId` istek kapsamındaki kiracı sağlayıcıdan okunur. Mevcut iptal filtreleri ayrı adla (`"Voided"`) kalır.
3. **Kapalı varsayılan.** Kiracı yoksa `CurrentTenantId` null olur ve filtre hiçbir satır döndürmez. Eksik bağlam veri sızdırmaz; boş sonuç ya da "bulunamadı" olarak görünür.
4. **Açık kapsam.** `ITenantScope` iki işlem sunar:
   - `UseTenant(tenantId)`: portal (bağlantıdan çözülen kiracı) ve kiracı bazında dönen arka plan işleri için.
   - `AsSystem()`: kiracılar arası çalışması gereken platform işleri için (outbox, bakım, platform yönetimi, seed). Bu kapsamda filtre devre dışıdır ve kullanım yeri gerekçesiyle kodda görünür.
5. **Yazma koruması.** `SaveChanges` sırasında eklenen ya da değiştirilen kiracılı varlığın `TenantId`'si etkin kiracıyla eşleşmiyorsa (sistem kapsamı hariç) istisna fırlatılır.
6. **Mevcut elle koşullar kalır.** Spec'lerdeki `TenantId` parametresi ve handler denetimleri ikinci savunma hattı olarak durur. Kaldırılmaları ayrı, kademeli bir iştir ve bu ADR'nin kapsamında değildir.
7. **Klinik kapsamı global filtreye girmez.** Klinik denetimi tek yardımcıya toplanır; 22 kopya kod ayrı küçük işte birleştirilir.

## Sonuçlar

- **Artı:** Unutulan koşul artık sızıntı değil, boş sonuçtur. Okuma modelleri ve spec dışı sorgular da korunur. Yeni modül varsayılan olarak güvenlidir.
- **Eksi ve riskler:**
  - Bağlamsız yolların hepsi `UseTenant` ya da `AsSystem` ile işaretlenmelidir. Atlanan yol boş veri görür; tam entegrasyon paketi bu yolların çoğunu kapsıyor, kalanlar için arka plan servisleri tek tek gözden geçirilir.
  - `AsSystem()` kötüye kullanılabilir; kullanımları mimari testle izinli listeye bağlanır.
  - Okuma modeli (`QueryDbContext`) aynı desenle ikinci adımda korunur.
  - Sorgu planlarına her tabloda `TenantId` koşulu eklenir. `TenantId` içeren 51 yapılandırmanın 48'inde `TenantId` ile başlayan indeks var. Eksik 3'ü (`SalesPartner`, `TenantActivation`, `TenantSubscription`) kiracı başına tek ya da az satırlı tablolar; etki ölçülür.
- **Uygulama sırası:** arayüz ve filtre → kapsam ve arka plan servisleri → portal → yazma koruması → mimari test → QueryDbContext. Her adım tam entegrasyon paketiyle doğrulanır.
