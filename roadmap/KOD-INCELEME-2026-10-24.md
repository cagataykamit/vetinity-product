# Kod ve mimari incelemesi — 2026-10-24

Kapsam: backend (`C:\Users\DELL\source\repos\Veteriner`, main `c8441437`), frontend (`C:\FrontEnd\veteriner-frontend`, main `44168fd9`), ürün deposu. Yöntem: salt okuma; dört paralel inceleme (backend mimari, backend verimlilik/doğruluk, frontend, test/CI/sözleşme) + koordinatörün kaynak kodda nokta doğrulaması. Build/test çalıştırılmadı; sayılar `grep`/`wc` çıktısıdır. Hiçbir dosya değiştirilmedi.

## 1. Genel değerlendirme

Temel sağlam. Backend katman yönü doğru (Domain → Application → Infrastructure → Api), domain modeli anemik değil (70 entity'de `private set`, iş kuralları aggregate'te, para yuvarlama tek yerde), controller'lar ince ve standart (`ToActionResult` 353 kullanım, elle `ProblemDetails` 0), 20+ varlıkta rowversion, webhook idempotent, hosted service'ler düzgün (scope başına DbContext, cancellation, backoff, dead-letter). Frontend tamamen modern Angular: 270 bileşenin hepsi standalone, zoneless, `@if/@for` (eski direktif 0), `input()/output()` (dekoratör 0), feature kodunda `any` 0, HTTP tek `ApiClient` + tek interceptor. Test tabanı geniş ve davranış odaklı (backend 4.595 test, %45'i olumsuz senaryo adı taşıyor; frontend 1.859 `it`, "should create" 0). Önceki güvenlik incelemesinin açık maddeleri kodda kapanmış; IDOR bulunmadı.

Borç iki yerde birikmiş:
- **Backend:** çapraz kesen kurallar (kiracı bağlamı, klinik kapsamı, "klinik uyuşmazlığı") tek yerde değil, 40-250 kopya halinde; Application katmanı EF Core'a doğrudan bağımlı; repository yazımları anında commit ettiği için çok yazımlı handler'larda kısmi yazma riski var.
- **Frontend:** feature sınırı fiilen yok (431 çapraz import, 20+ döngüsel çift); liste/detay sayfa iskeleti 15-25 kopya; zoneless altında OnPush yalnız %6; 1000+ satırlık 5 sayfa bileşeni, en büyük ikisinin testi yok.

## 2. Yüksek öncelikli bulgular (gerçek hata riski)

### B1. Çok yazımlı handler'lar transaction'sız; kısmi yazma riski
`EfRepository<T>` Ardalis `RepositoryBase<T>`'yi override'sız sarıyor; `AddAsync/UpdateAsync/DeleteAsync` her çağrıda `SaveChanges` çalıştırıyor (kodda 4 yerde yorumla kabul edilmiş). `TransactionBehavior` (Infrastructure/Behaviors) yalnız `ITransactionalRequest` işaretli komutlarda işlem açıyor: 9 komut işaretli, `ITransactionalRollbackOnFailureRequest` 15. İki veya daha fazla yazım yapan 21 handler'ın 10'u işaretsiz.

En kritik ikisi (koordinatör doğruladı):
- `Clinics/Commands/WorkingHours/UpdateClinicWorkingHours/UpdateClinicWorkingHoursCommandHandler.cs:86-110` — mevcut satırlar tek tek silinir (her biri commit), sonra yeni satırlar tek tek eklenir; 5. günde `ArgumentException` → Failure döner, klinik eksik saatle kalır. Komut `IRequest` dışında işaret taşımıyor.
- `Public/Commands/OwnerSignup/PublicOwnerSignupCommandHandler.cs:170-183` — user, tenant, subscription, clinic, UserTenant, UserClinic, claim, legal acceptance, redemption ardışık `AddAsync`; ortada hata → kullanıcı kiracısız/yetkisiz kalır, aynı e-postayla yeniden kayıt `Users.DuplicateEmail` ile kalıcı engellenir.

Aynı desen: `Tenants/Commands/Create`, `Public/Commands/SignupAndAcceptInvite`, `Reminders/Commands/UpdateSettings`, `Examinations/Commands/Create` (muayene kaydedildikten sonra randevu tamamlanması ikinci commit).

**Öneri:** Kısa vadede 10 handler'a `ITransactionalRollbackOnFailureRequest`. Kalıcı çözüm: `EfRepository`'de `SaveChanges`'i kapat (Ardalis `RepositoryBase` yazım metodlarının `saveChanges: false` overload'ı / override), tek `_uow.SaveChangesAsync` (127 handler'da zaten çağrılıyor) gerçek tek commit olsun. Bu değişiklik entegrasyon testleriyle korunmalı.

### B2. Çapraz kesen kurallar tek yerde yaşamıyor (SOLID/"kural tek yerde" ihlali)
- Kiracı bağlamı kontrolü 3 katmanda: `TenantContextMiddleware`, controller'larda `TryGetResolvedTenant` 248 çağrı (400 döner), handler'larda `_tenantContext.TenantId is not { } tenantId` 184 kopya (`Tenants.ContextMissing`).
- Klinik kapsam filtresi 33 spec'te satır içi + `Dashboard/DashboardSpecificationClinicScope.cs` entity başına 10+ kopya; Pets/Charges/Payments spec'leri bunu Dashboard namespace'inden kullanıyor (modül sınırı ters).
- "İstek clinicId aktif klinikle uyuşmuyor" kuralı 22 farklı hata koduyla (`Appointments.ClinicContextMismatch`, `Payments.…`, …) 60+ yerde; `Tenants.TenantInactive` 49 yerde, 44 handler'da `tenant.IsActive`.
- Kiracı izolasyonu global query filter ile değil, her spec'te elle: `HasQueryFilter` yalnız 3 (soft-delete). Bugün IDOR yok (20 `*Idor*` entegrasyon test dosyası, GetById spec'lerinin hepsi TenantId filtreli), ama güvenlik "unutulmamaya" dayanıyor.

**Öneri (kademeli):** `IRequireTenant`/`IRequireClinic` işaret arayüzü + tek pipeline behavior; `Domain`'de `IClinicScoped` + `Application/Common`'da tek generic `ApplyClinicScope<T>`; tek `Clinics.ContextMismatch` kodu; `ITenantScoped` entity'ler için `AppDbContext`'te kiracı global filter (arka plan işleri `IgnoreQueryFilters` ile bilinçli açar). Spec'lerdeki elle filtre savunma derinliği olarak kalır.

### B3. Application katmanı EF Core'a doğrudan bağımlı
`Backend.Veteriner.Application.csproj` → `Microsoft.EntityFrameworkCore` 9.0.9 + `.Relational`; 120 dosyada `using Microsoft.EntityFrameworkCore` (50 `DbUpdateConcurrencyException`, 15 `DbUpdateException`, 15 `EF.Functions.Like`, 4 `.Include`). `docs/architecture/foundation-rules.md §1` "yalnız Domain" diyor; belge kodla çelişiyor.

**Öneri:** `DbUpdate*Exception`'ı `TransactionBehavior`/`EfRepository`'de yakalayıp Application'a kendi Result koduyla ilet; `EF.Functions.Like` için Infrastructure arama yardımcısı; sonra paketi csproj'dan düşür ve NetArchTest ile kilitle. Ya da belgeyi gerçeğe çek (daha ucuz, ama borcu kabul eder).

### B4. Saat kaynağı iki başlı
`DateTime.Now`/`Today` sıfır (iyi), saat dilimi tek yerde (`Common/Time/OperationDayBounds.cs`). Ama `DateTime.UtcNow` Domain'de 86 satır / 29 dosya (`TimeProvider` 0), Application'da 97 satır / 81 dosya (`TimeProvider` 68 dosya) — iki kaynak yan yana. Testlerde 290 dosya gerçek saat kullanıyor, `FakeTimeProvider` yalnız 3 dosyada. Örnek: `Domain/Auth/VerificationToken.cs:32` `IsActive => DateTime.UtcNow < ExpiresAtUtc`.

**Öneri:** Domain'de `UtcNow` yasağı (analizör/CI kuralı), zaman parametre olarak gelsin; Application'da `TimeProvider` zorunlu; testlerde sabit saat. Devir notundaki "Bugün testi saate bağlı kararsız" sorunu bu kökten geliyor.

### B5. Frontend feature sınırı yok, döngüsel bağımlılık var
`src/app/features` içinde başka feature'dan import 431 kenar; karşılıklı çiftler 20+ (appointments↔clients, appointments↔examinations, clients↔pets, clients↔payments, examinations↔prescriptions/lab-results/imaging, pets↔payments). `shared/` → `features/` 53 import (ör. `shared/forms/client-search/client-search.component.ts:10-12`). `features/subscriptions/services/tenant-read-only-context.service.ts` kesitsel bir kural, 93 dosyadan import ediliyor.

**Öneri:** `TenantReadOnlyContextService` → `core/tenant/`; paylaşılan VM/mapper/servisler → `shared/domain`; eslint `no-restricted-imports` ile feature→feature yalnız `index.ts` üzerinden.

## 3. Orta öncelikli bulgular

### Backend
- **O1. Audit yazımı korumasız.** `Common/Behaviors/AuditBehavior.cs:55-76`: `await next()` başarıyla commit ettikten sonra `_auditLogWriter.WriteAsync` try/catch'siz; audit DB hatası istemciye 500 döndürür, iş yazımı ise kalıcı olmuştur. Hata yolunda ikinci `WriteAsync` fırlatırsa özgün istisna maskelenir. → try/catch + LogError + sayaç.
- **O2. Satış/şablon akışında satır başına iç MediatR komutu.** `Sales/Commands/Create/CreateSaleCommandHandler.cs:343-346`, `Void/VoidSaleCommandHandler.cs:137-151`, `ExaminationTemplates/Commands/Apply/…:122-128`, `Sales/SaleDtoAssembler.cs:76-83`: her satır tam pipeline (validation, abonelik guard'ı 2 sorgu, audit, transaction kontrolü). 10 satırlık satış ≈ 10×(2 guard + stok + hareket) sorgu. `IMPORT_PERFORMANCE_FINDINGS`'teki "%29 tekrarlı kiracı/abonelik okuması" bu desenin sonucu. → Guard sonucunu istek kapsamında önbellekle; iç çağrıları domain servisine indir.
- **O3. Generic `OutboxProcessor` claim/lease kullanmıyor.** `Infrastructure/Outbox/OutboxProcessor.cs:63-108`: parti okunur, e-posta gönderilir, `ProcessedAtUtc` parti sonunda tek `SaveChanges` ile yazılır. Çökme veya ikinci instance aynı e-postayı yeniden gönderir. Projection processor'larda claim deposu var, generic outbox'ta yok. → Mesaj başına SaveChanges; ölçeklemeden önce claim.
- **O4. Outbox claim repository 4 kopya** (`SqlClientOutboxClaimRepository`, `SqlPetOutbox…`, `SqlPaymentOutbox…`, `SqlAppointmentOutbox…`; 256-269 satır, Client↔Pet diff 16 satır yalnız ad/tip). → `SqlOutboxClaimRepository<TMarker>`.
- **O5. Okuma modeli üretimde kapalı, 12 handler çift yol taşıyor.** `appsettings.Production.json` tüm `QueryReadModels:*Enabled=false`; 4 projection processor (474-834 satır), 4 hosted service, 29 arayüz. `docs/cqrs/*` bilinçli rollout diyor; kusur değil, sürekli bakım maliyeti. → **ADR gerektiren ürün kararı:** rollout takvimi + eski dalların silinmesi, ya da hedefi gerçekleşmeyen read-model'lerin çıkarılması.
- **O6. PERFORMANCE_FINDINGS §5 indekslerinin hiçbiri uygulanmamış.** `AppDbContextModelSnapshot.cs`: Charges/Payments `(TenantId, VoidedAtUtc)` yok; Examinations `(TenantId, ExaminedAtUtc)` INCLUDE'suz; StockMovements `(TenantId, MovementType, OccurredAtUtc)` yok. Ölçülen doğrusal büyüme (Borç raporu 5→55 ms, Defter 15→75 ms) sürer. → Onayla tek migration + yeniden ölçüm (pilot ölçeğinde acil değil).
- **O7. Api'de iki controller `AppDbContext`'e doğrudan iniyor:** `Controllers/OutboxController.cs`, `OutboxAdminController.cs`. → handler + `IOutboxAdminRepository`.
- **O8. Domain event köprüsü belgeyle çelişiyor.** `foundation-rules §9` "park edildi"; kodda `DomainEventOutboxInterceptor` kayıtlı, 39 aggregate'ten yalnız `User` event üretiyor, tüketici yalnız log (e-posta düz metin). Gerçek yan etkiler `_eventOutbox.EnqueueAsync` ile doğrudan yazılıyor. → Ya bağla ya kaldır; e-postayı `LogMasking.MaskEmail` ile maskele.
- **O9. `appsettings.Production.json` bağlantı anahtarı uyumsuz.** Dosyada `ConnectionStrings:SqlServer`; `Api/Configuration/StartupConfigurationValidator.cs:27` `DefaultConnection` zorunlu kılıyor; `Infrastructure/DependencyInjection.cs:90-99` ikisine de düşüyor. Dosya tek başına kullanılsa açılış hatası. → `DefaultConnection`'a çevir.
- **O10. Billing webhook entegrasyon testi yok.** `BillingWebhooksController`, `BillingCallbacksController` için `tests/…IntegrationTests` altında dosya yok; yalnız 6 unit test. İmza doğrulama, çift teslim, HTTP durum kodları uçtan uca denenmiyor. Üretimde para akışının tek kaynağı bu uç.

### Frontend
- **F1. Liste sayfası iskeleti 15-25 kopya.** `onTableLazyLoad` 25 dosya, `onMobilePageChange` 20, `restoreStateFromSessionStorage` 15, `suppressNextLazy` 19. `vaccinations-list-page.component.ts:486-510` ile `payments-list-page.component.ts:408-432` tek satır dışında aynı. Son iki düzeltme (`42a5f6e5`, `87512807`) aynı hatayı iki sayfada ayrı ayrı düzeltmiş. Raporlardaki `ReportListState` (13 sayfa) model olabilir. → `shared/list/list-page-state.ts`.
- **F2. Detay sayfası iskeleti kopya.** `route.paramMap → switchMap → lastId → loading/error` bloğu `product-detail-page:927-949`, `examination-detail-page:544-566`, `appointment-detail-page:340-359` birebir; `loading = signal(` 82, `error = signal<string|null>` 70. → `routeEntityLoader` yardımcısı veya Angular `resource()`.
- **F3. Zoneless altında OnPush yalnız 16/270 bileşen.** Şablonlarda `{{ fn(x) }}` 377 çağrı / 89 dosya (`money` 63, `formatDateTime` 55, `formatDate` 47); `@Pipe` 0. Her CD turunda formatlama yeniden koşar (824 satırlık dashboard şablonu dahil). → `money`/`trDate`/`trDateTime` pure pipe + OnPush schematics varsayılanı; 70+ bileşen alias'ı da kalkar.
- **F4. God component'ler, ikisi testsiz.** `subscription-page.component.ts` 1405 satır (spec yok), `product-detail-page.component.ts` 1307 (spec yok), `dashboard-page.component.ts` 1301 (824 satır inline şablon), `clinic-detail-page` 1055 (tek `it`), `today-page` 982. `core/auth/auth.service.ts` 785 satır, 24 public metot, spec yok. → subscription → `checkout-flow.service` + kart bileşenleri; product-detail → `stock-operation-dialog` + tablo; auth.service spec'i öncelikli.
- **F5. Bellek sızıntısı (bir yer).** `layout/component/app.menuitem.ts:259` `router.events.subscribe` temizlenmiyor (dosyada `DestroyRef/takeUntil/ngOnDestroy` 0); öğeler `@for` ile `track $index` üzerinden render ediliyor, bölüm değişiminde yeniden yaratılır. Diğer 506 `subscribe`'ın doğrulanan 5'i kendiliğinden tamamlanan kaynaklar (paramMap, HttpClient). → `takeUntilDestroyed(inject(DestroyRef))`; `track $index` → kararlı anahtar (18 kullanım / 7 dosya).
- **F6. Hata mesajı eşleme iki katmanda.** `shared/utils/api-error.utils.ts` 769 satır ve alan bilgisi taşıyor; buna ek 24 feature `*-error.utils.ts`; inline `e.message ?? 'Yükleme hatası'` 324 kez. Portal `portal-errors.ts` doğru modeli uyguluyor. → Shared'da yalnız ProblemDetails ayrıştırma; alan tabloları feature'da.
- **F7. Sakai şablon kalıntısı ölü kod.** `src/app/pages/{uikit,service,documentation,crud}` ~15.500 satır (`pages/service/customer.service.ts` 9.057 satır sahte veri); `pages/pages.routes.ts` hiçbir yerden import edilmiyor (bundle'a girmiyor), ama lint/IDE'ye giriyor; projedeki 44 `any`'nin 41'i burada. → Sil; `pages/auth|public|notfound` kalır.

### Süreç / test / CI
- **P1. Backlog kodun gerisinde.** `backlog/feature-backlog.md`: 113 "Planlandı", 2 "Geliştirildi". Oysa main'de var: CHECKIN-006 (`CreateVisitCommandHandler`), FIN-002 (`GetClientBalanceQueryHandler`), FIN-003 (`CorrectChargeCommandHandler`), CHECKIN-008, CHECKIN-010 (31 dosya), HOSP-001, EXAM-006, PORTAL-001. BILL-002/003 satırları "dalda, main'e alınmadı, push yok" diyor; gerçekte main'de ve push edilmiş (`47ba5fa6`, `85455fc9`; `origin/main` eşit). WORKFLOW §"kod-belge çelişirse belge güncellenir" ihlali. → Tek seferlik durum senkronu + her merge'de backlog satırı zorunlu.
- **P2. Frontend sözleşme kopyaları sapmış.** 12 aynı adlı dosyadan 6'sı backend'den farklı (VISITS 18 satır: `openItems`, `chargeIndicator`; PET_TIMELINE 14; EXAMINATIONS_WORKSPACE 7; INVOICING_IDENTITY 7; PAYMENT_ALLOCATION 3; IMAGING 2). Frontend kodu yeni alanları kullanıyor, yalnız belge eski. 26 backend sözleşmesinin frontend kopyası yok. `FRONTEND-CONTRACT-SYNC-STANDARD.md:25` "birebir" diyor. → Kopyayı kaldır, tek kaynağa bağla veya CI'da diff.
- **P3. CI eksikleri (iki depo).** Backend `ci.yml`: restore → build → unit → LocalDB entegrasyon → publish. Frontend `ci.yml`: `npm ci` → `ng build` → `ng test`. Yok: `npm run lint` (script var, çalışmıyor), `dotnet format --verify-no-changes`, `npm audit`, `dotnet list package --vulnerable`, CodeQL, Dependabot, coverage eşiği. Frontend CI'ın portal projesini derleyip test ettiği doğrulanmadı.
- **P4. Test altyapısı tekrarı.** 18 `*WebApplicationFactory` türevi, 16 `ConfigureWebHost` override'ı. `Task.Delay` sabitleri 10 dosyada (`OutboxProcessorIntegrationTests` 5×500 ms) oysa `EventualConsistencyTestSupport` polling yardımcısı var. → Parametreli tek fabrika; polling yardımcısı.
- **P5. Backend `README.md` eski** ("henüz implementasyon yok"; 79 controller, 377 uç var). `foundation-rules §3` "dosyada tek public type" 220 dosyada ihlal (kuralı gevşet veya analizör).

## 4. Düşük öncelik (not)
- `EnableRetryOnFailure` yok (`Infrastructure/DependencyInjection.cs:155,163`); yönetilen SQL'e geçişte ekle (TransactionBehavior'ın `BeginTransactionAsync` kullanımıyla execution strategy içinde).
- Dışa aktarımlar bellekte çift kopya (`RegisterCsvWriter`, `*XlsxWriter` → `byte[]`); 50.000 satır sınırı varken kabul edilebilir.
- `FinanceEvents.cs:94-96` `JsonException` sessizce yutuluyor → en az Debug log.
- `Application/Common` 8 feature'a `using` veriyor (`Common/ListSearchPetIds.cs`, `Common/Billing/*`) → ait oldukları feature'a taşı.
- Ölü tipler: `Common/Diagnostics/CriticalHandlerPerformance.cs`, `Common/Email/EmailAttachment.cs`.
- Domain `MediatR`'a bağımlı (`IDomainEvent : INotification`); tek paket, kabul edilebilir.
- `Microsoft.AspNetCore.Mvc.Versioning 5.1.0` eski paket ailesi (Asp.Versioning.* ile değiştirilmiş); `OpenTelemetry.Instrumentation.EntityFrameworkCore` ön sürüm.
- Yerel `appsettings.Development.json` git dışı ama diskte iyzico sandbox anahtarları dolu → user-secrets'a taşı. `appsettings.IntegrationTests.json` test JWT anahtarı git'te.
- Ters vekil `KnownProxies/KnownNetworks` tanımsız (SECURITY_CONFIGURATION D6 kendisi not etmiş); VPS geçişinde.
- FontAwesome Free tam CSS + PrimeIcons birlikte; bütçe uyarısı build çalıştırılmadığı için doğrulanmadı.
- Portal ile panel arasında kod paylaşımı yok, bilinçli kopya (`portal-money.ts`, `PortalApiClient`); 56 dosya için gerekçeli, şimdilik dokunma.

## 5. Temiz bulunan alanlar
- Para: 36 decimal alanın tümü `HasPrecision`; yuvarlama tek yerde (`Charge.cs:227`, `Sale.cs:185`, `AwayFromZero`).
- Eşzamanlılık: rowversion 20+ varlık, `MutationSequence` token, stok için `ProductStockForUpdateSpec` + `DbUpdateConcurrencyException` → 409.
- Webhook idempotency: receipt + unique indeks + duplicate-key yakalama. Hatırlatma dispatch log dedupe.
- Dosya katmanı: `RequestSizeLimit`, magic-byte tespiti, boyut sınırı, yarım yüklemede `DiscardAsync`.
- `catch (Exception)` 55 yerin tamamı log'luyor veya yeniden fırlatıyor; boş catch 2 (biri gerekçeli).
- Liste uçlarının hepsi sayfalı (`CountAsync` + spec); dışa aktarımlar 50.000 satır / 93 gün sınırlı.
- IDOR: GetById spec'lerinin hepsi TenantId filtreli; 20 IDOR entegrasyon test dosyası. `PetByClientNameAndSpeciesIdSpec` TenantId içermiyor ama çağıranlar (`CreatePetCommandHandler.cs:79`) müşteriyi önce `ClientByIdSpec(tenantId, …)` ile doğruluyor; sızıntı yok.
- Migration hijyeni: 79 migration + 79 Designer + tek snapshot; CI idempotent betik üretir, DB'ye uygulamaz.
- Depo hijyeni: `bin/obj/artifacts/_local_backup/dist` git dışı; 500 KB üstü dosya yok; sırlar git'te yok; üretim ayarlarında tüm sır alanları boş; `AllowedOrigins/AllowedHosts` boşsa açılış engelli; `Jwt:Key` ≥32 zorunlu; HSTS + güvenlik başlıkları + rate limit açık.
- Frontend: HTTP katmanı (`ApiClient` 60 satır, 401 → tek refresh → retry); sözleşme modelleri feature `models/` + `data/*.mapper.ts` ile tek yerde; testler davranış odaklı.

## 6. Önerilen sıra

| Sıra | İş | Depo | Boyut | Risk azaltımı |
|---|---|---|---|---|
| 1 | B1: 10 handler'a transaction işareti; sonra `EfRepository` SaveChanges kapatma + tek commit | backend | Küçük → Orta | Veri bütünlüğü (kayıt, çalışma saatleri) |
| 2 | O1 audit try/catch; O9 Production connection anahtarı; F5 menuitem sızıntısı; F7 Sakai ölü kod silme | ikisi | Küçük (1 PR her biri) | Hızlı kazanım |
| 3 | P1 backlog senkronu; P2 sözleşme kopyalarını tek kaynağa bağla | ürün+frontend | Küçük | Planlama doğruluğu |
| 4 | O10 billing webhook entegrasyon testleri; P3 CI'a lint + audit + Dependabot | ikisi | Küçük | Para akışı güvencesi |
| 5 | F3 pipe'lar + OnPush varsayılanı; F1/F2 `ListPageState` + `routeEntityLoader` (önce 5+5 sayfa) | frontend | Orta | Tekrar ve CD maliyeti |
| 6 | B2: `IRequireTenant`/`IClinicScoped` + tek behavior, tek hata kodu; kiracı global filter | backend | Orta → Büyük, kademeli | Güvenlik tipe bağlanır, 400+ kopya kalkar |
| 7 | B4 saat kaynağı (Domain `UtcNow` yasağı, `FakeTimeProvider` yaygınlaştırma) | backend | Orta | Flaky test, gün sınırı hataları |
| 8 | B3 EF sızıntısı; O4 outbox generic; O2 iç komut döngüleri | backend | Orta | Mimari borç |
| 9 | F4 god component bölme + auth.service spec; B5 feature sınırları (eslint kuralı) | frontend | Büyük, kademeli | Bakım |
| 10 | O5 read-model kararı (ADR); O6 indeksler (onay + ölçüm) | ürün/backend | Karar | — |

**Ürün kararı gerektirenler (kullanıcı):** O5 read-model rollout'u ya da kapsam daraltma (ADR); O6 indeks migration'ı; B3 için "paketi düşür" mü "belgeyi gerçeğe çek" mi.

## 7. Doğrulanmayanlar
Build/test çalıştırılmadı. Ardalis `AddAsync`'in anında `SaveChanges` çalıştırdığı paket kaynağından değil, repodaki 4 açıklayıcı yorumdan ve `EfRepository`'nin override içermemesinden çıkarıldı. Frontend bütçe uyarısı, çalışma zamanı bellek profili, frontend CI'ın portal'ı kapsadığı, `me/display-name` ve `tenants/{x}/subscription-discount` uçlarının backend karşılığı doğrulanmadı.
