# Kod, mimari ve paket denetimi — 2026-10-27

Kapsam: backend (`C:\Users\DELL\source\repos\Veteriner`, main `cfaa82df`), frontend (`C:\FrontEnd\veteriner-frontend`, main `498166fa`), ürün deposu. Yöntem: salt okuma; iki paralel denetim (backend, frontend) + koordinatörün paket taraması (`dotnet list package --outdated/--vulnerable/--deprecated`, `npm outdated`, `npm audit`) ve nokta doğrulaması. Build/test çalıştırılmadı; hiçbir kaynak dosya değiştirilmedi. Önceki inceleme: [KOD-INCELEME-2026-10-24.md](KOD-INCELEME-2026-10-24.md); oradaki kodlar (B1…, O1…, F1…, P1…) burada aynı anlamda kullanılır.

## 1. Özet

Temel sağlam ve 24 Ekim'den bu yana yapılan büyük geçişler (Mediator, .NET 10, xUnit v3, Angular/PrimeNG 22, Vitest) temiz: Mediator pipeline sırası eski MediatR kaydıyla aynı ve testle sabit; xUnit v3 ve Vitest geçişlerinde kalıntı yok; CI'da lint, audit, portal build ve iki projeli test var; frontend sözleşme kopyaları backend ile byte düzeyinde aynı; güvenlik açığı olan NuGet paketi yok; npm'de kalan 3 orta bulgu yalnız Capacitor CLI'da.

Gerçek hata riski taşıyan **yeni** bulgu 3 tane: portal üretim derlemesinin localhost API adresiyle çıkması (F-Y1), istemci iptalinin Mediator pipeline'ında hâlâ ERR loglanması (B-Y1), ölü domain-event yolu (B-Y2). Geri kalanı ertelenmiş borçların durum tespiti ve karar bekleyen maddeler.

## 2. Yeni bulgular — gerçek hata riski

> **Durum (2026-10-27 gece):** üçü de düzeltildi, dallarda (main'e alınmadı): frontend `fix/portal-api-base-url` `8490d62f`; backend `fix/denetim-2026-10-27` `edba0fd3` (B-Y1) ve `3cdccd59` (B-Y2). Ayrıntı ve test sonuçları devir notunda.

### F-Y1. Portal üretim derlemesi localhost API adresiyle çıkıyor (K, dağıtım hatası)
`projects/portal/src/environments/environment.ts:11` `portalApiBaseUrl: 'https://localhost:7173/api/portal/v1'`. CI'daki "Set production API URL" adımı (`ci.yml:82-93`) `scripts/set-api-base-url.mjs` ile yalnız panelin `src/environments/environment.ts` dosyasını yazar; portal için eşdeğer yok. `ng build portal --configuration production` (`ci.yml:98`) portalı localhost adresiyle üretir; `capacitor.config.ts` `allowNavigation` da buradan türediği için mobil kabukta API host'u localhost olur. Staging dosyaları ve `portalBaseUrl` ADR-033 ile uyumlu; yalnız üretim API adresi eksik.
**Aksiyon:** betiğe `PORTAL_API_BASE_URL` (ya da `API_BASE_URL`'den `/api/portal/v1` türetme) ekle, CI'da portal derlemesinden önce koştur, etiket derlemesinde tanımsızlığı hata yap. Canlıya geçiş notlarına "CI'da `API_BASE_URL`" maddesinin yanına portal eşini ekle.

### B-Y1. İstemci iptali (499) yalnız middleware'de düzeltildi; pipeline hâlâ 2 ERR yazıyor (K)
`Middleware/ExceptionHandlingExtensions.cs:45-52` iptali 499 + Information yapar. Ama handler içinde iptal olduğunda istisna önce `Application/Common/Behaviors/UnhandledExceptionBehavior.cs:19-22` ve `LoggingBehavior.cs:22-24` içinden geçer; ikisi de `catch (Exception)` → `LogError`, `OperationCanceledException` filtrelenmez. Sonuç: her iptal için 2 ERR + 1 Information. `AuditBehavior.cs:98` iptali özel ele alıyor, bu ikisi almıyor. Ayrıca `Infrastructure/Behaviors/TransactionBehavior.cs:73` `RollbackAsync(ct)` iptal edilmiş token ile çağrılıyor. Test `ExceptionHandlingClientAbortTests` Mediator'sız minimal host kuruyor, bu boşluğu görmüyor. Önceden var olan "aynı istisna iki kez ERR" (Unhandled + Logging) sorunu da burada.
**Aksiyon:** iki behavior'da `ex is OperationCanceledException && ct.IsCancellationRequested` → Information; rollback'e `CancellationToken.None`; iki behavior'un aynı istisnayı iki kez loglamasını tekle; test Mediator üzerinden.

### B-Y2. Domain event yolu ölü kod; Domain'in tek paket bağımlılığı bu yol için (K-O)
`Infrastructure/DependencyInjection.cs:153` `DomainEventOutboxInterceptor` kayıtlı ama `:159-162` `AddInterceptors(...)` listesinde yok (doğrulandı). Dolayısıyla `Domain/Users/User.cs:52` `UserCreatedDomainEvent` hiç outbox'a düşmez; `OutboxProcessor.cs:138-152` domain event dalı ve `UserCreatedDomainEventHandler` (e-postayı düz metin loglar) erişilemez. Event üreten aggregate 1/39. `Domain.csproj:12` `Mediator.Abstractions` yalnız `IDomainEvent : INotification` için duruyor; `foundation-rules.md:13` "Domain dış paket bağımlı olmaz" ile çelişiyor. 24 Ekim'deki O8 "kayıtlı" demişti; doğrusu "kayıtlı ama bağlı değil", foundation §9 ("park") kodla uyumlu.
**Aksiyon (öneri):** kaldır — interceptor, `DomainEventTypeRegistry`, processor dalı, handler, `User` eventi, Domain'den Mediator paketi; `IDomainEvent` düz işaretçi kalır; `MediatorConfiguration.cs:19` `Assemblies`'ten Domain çıkar. Alternatif: bağla + test + e-postayı maskele. Ürün kararı değil, teknik karar.

## 3. Yeni bulgular — küçük

- **B-Y3.** BILL-001 `billingPeriod` ayrıştırma/doğrulama controller'da: `TenantsController.cs:580-593` string→enum çevirip `Subscriptions.Checkout.Validation.BillingPeriodInvalid` döner; `StartSubscriptionCheckoutCommandValidator` kural 0. Komut string alsın, kural validator'a. (K)
- **B-Y4.** `Infrastructure/Behaviors/TransactionBehavior.cs:8` namespace `Backend.Veteriner.Application.Common.Behaviors`; dosya Infrastructure'da. Namespace düzelt. (K)
- **B-Y5.** MediatR kalıntısı izlenen kaynaklarda 0; yalnız git dışı `appsettings.Development.json:15,37` `LuckyPennySoftware.MediatR.License` log anahtarı. Yerel dosyadan sil. (K)
- **F-Y2 (karar).** `<p-button>` bileşeni PrimeNG 22'de deprecated (`primeng-button.d.ts:81` "Use the [pButton] directive instead"; `loading` girdisi de deprecated): panel 323 (133 dosya) + portal 17 kullanım; `[loading]` 109. Bugün hata değil; sonraki majörde kalkar. Ayrıca `styleClass=` 58 kalıntı (codemod tutarsızlığı, PrimeNG'de hâlâ geçerli). Karar: v23 öncesi `p-button → pButton` geçişi planlanır mı, ertelenir mi. (B)
- **F-Y3 (yerel).** Ana frontend klasöründe `node_modules` lock'tan geride (`vitest` yok, `vite` 8.3.0 ↔ lock 8.3.5); önceki test koşuları silinen çalışma kopyalarında yapılmış. **`npm ci` bu denetim sırasında ana klasörde çalıştırıldı** (sonuç devir notunda).
- **Public type.** foundation §3 "dosyada tek public type" ihlali 281 dosya (24 Ekim: 220). Kuralı gevşet ya da analizör. (karar)

## 4. Paketler ve araçlar

| Depo | Bulgu | Aksiyon |
|---|---|---|
| backend | Güvenlik açığı olan paket: **0** (geçişli dahil) | — |
| backend | **Kullanım dışı (deprecated):** `FluentValidation.AspNetCore 11.3.1` (Legacy; kodda kullanım 0, yalnız csproj) | Kaldır (K) |
| backend | **Kullanım dışı:** `Microsoft.AspNetCore.Mvc.Versioning 5.1.0` + `.ApiExplorer` → `Asp.Versioning.Mvc` / `.ApiExplorer` ailesi; 62 dosyada `[ApiVersion]`/using | Geçiş (O; namespace değişimi + `AddApiVersioning` yapılandırması) |
| backend | `OpenTelemetry.Instrumentation.EntityFrameworkCore 1.15.1-beta.1` ↔ çekirdek 1.20.1; NuGet'te `1.20.1-beta.1` var (ön sürüm olduğu için `--outdated` göstermedi) | 1.20.1-beta.1'e hizala (K) |
| backend | `Stripe.net 51.2.0 → 53.0.0` (majör; Stripe yıllıkta reddediliyor, kullanım 2 dosya) | Dependabot majörleri yoksayıyor; elle değerlendir (K) |
| backend | `coverlet.collector 6.0.4 → 10.1.0`, `SQLitePCLRaw.lib.e_sqlite3 2.1.14 → 3.53.3` (test projeleri, majör) | Düşük öncelik |
| backend | `Directory.Build.props` yok; `TreatWarningsAsErrors`/`AnalysisLevel` tanımsız (yalnız `Nullable`) | CI'da uyarı sayısı 0 raporlanıyor; `TreatWarningsAsErrors` ile kilitlenebilir (K, karar) |
| frontend | `npm audit`: 3 orta, hepsi `@capacitor/cli` → `xcode` → `uuid` (geliştirme aracı; düzeltme yalnız CLI'nın majör düşürülmesiyle) | Kabul edilen risk, not |
| frontend | Minor/patch güncel; majör bekleyen: `eslint 9 → 10`, `@eslint/js 9 → 10`, `eslint-config-prettier 9 → 10`, `typescript 6.0 → 7.0`, `@primeuix/themes 2.0.3 → 3.1.0` (bilinçli sabit: 3.x her şeyi ~%12 küçültüyordu) | TypeScript 7 Angular 22 tarafından desteklenmiyorsa bekle; eslint 10 ayrı küçük iş |
| frontend | Kullanılmayan şüpheli: `@angular/platform-browser-dynamic` (import 0), `autoprefixer` (Tailwind 4 kendi ekliyor) | Kaldır (K) |
| frontend | `overrides.vite ^8.3.5` `@angular/build 22.2.4`'ün 8.3.0 sabitini eziyor (`launch-editor` açığı için) | Her `@angular/build` güncellemesinde yeniden değerlendir |
| araçlar | .NET SDK 10.0.401, Node 24.22.1, npm 11.6.4; CI ile aynı | — |
| GitHub | Backend'de 2 eski Dependabot dalı/PR (`nuget-minor-patch-*`): hepsi .NET 9.0.22 ve MediatR 13.1 bump'ı; .NET 10 + Mediator sonrası geçersiz | Kapat (kullanıcı; `gh` bu makinede kurulu değil) |

## 5. Ertelenmiş borçların güncel durumu

### Backend
| Kod | Ölçüm (2026-10-27) | Durum |
|---|---|---|
| B1 kalıcı (EfRepository SaveChanges) | `EfRepository.cs` 13 satır, override yok; `ITransactionalRequest` 10, `ITransactionalRollbackOnFailureRequest` 21; işaretsiz 2+ yazım 6 (4 tek yazım dallı, 2 bilinçli dış IO). Yeni handler'larda (Visits, DemoRequests, BILL-001) işaretsiz çok yazım yok | Kısa vade tamam; kalıcı çözüm yapılmadı (O) |
| B2 kiracı/klinik kuralı | `TenantId is not { }` 185; `ClinicContextMismatch` 22 kod / 62 kullanım; `HasQueryFilter` 3; `TryGetResolvedTenant` 259 (248'den ↑) | Yapılmadı, büyüyor (B) |
| B3 EF sızıntısı | `Application.csproj` EF Core 10.0.14; 120 dosya; `foundation-rules.md:12` çelişkili | Karar bekliyor (belge mi paket mi) |
| B4 saat kaynağı | Domain `UtcNow` 86/29; Application 91 satır / 77 dosya TimeProvider'sız; RS0030 suggestion | Değişmedi (O) |
| O2 iç komut döngüsü | CreateSale 4, VoidSale 3, ApplyTemplate 1 iç `Send`; guard önbelleği 0 | Yapılmadı (O) |
| O3 generic outbox claim | `OutboxProcessor.cs:79-107` parti, tek SaveChanges; claim 0 | Yapılmadı (K) |
| O8 domain event | = B-Y2 | Kaldır (K) |
| P4 test altyapısı | Factory türevi 15 (18'den ↓); `Task.Delay` 10 dosya / 17 satır | Kısmen (K) |
| P5 README | `README.md:28` "henüz implementasyon yok" | Yapılmadı (K) |
| Düşük | `EnableRetryOnFailure` 0; `KnownProxies` 0 (VPS'te) | Değişmedi |

Temiz: Mediator 8 behavior, sıra ve Scoped ömür `MediatorPipelineOrderTests` ile sabit; Infrastructure/Api'de handler 0; O7 (controller'da `AppDbContext` 0) doğrulandı; migration 84+84+1, Query 10+10+1; xUnit v3 uyumsuzluk 0; `appsettings.Production.json` ↔ `StartupConfigurationValidator` uyumlu; docs'ta MediatR/FluentAssertions/.NET 9 kalıntısı 0.

### Frontend
| Kod | 24 Eki | 27 Eki | Durum |
|---|---|---|---|
| B5 feature↔feature kenar / döngüsel çift | 431 / 20+ | 443 / **31** | Arttı (B) |
| B5 shared→features / core→features | 53 / — | 2 / 1 (hepsi `import type`) | Yapıldı |
| B5 layout→features çalışma zamanı / pages→features | — | 5 / 61 | Kural kapsamı dışı (K: kuralı genişlet) |
| B5 eslint kuralı | — | `no-restricted-imports` **warn**, yalnız `core/**` ve `shared/**`; feature↔feature kuralı yok; barrel 0 | Karar: `error` + kapsam |
| F1 liste iskeleti | 25/15/19/20 | 25/15/19/20 | Değişmedi (O) |
| F2 detay iskeleti | 3 | 10 dosya | Değişmedi (O) |
| F3 OnPush / Eager / belirsiz | 16/—/254 | 19 / **230** / 3; portal 20/20 OnPush | `ng update` eski Default'u `Eager` yazdı; 79 bileşende `subscribe/setTimeout/NgZone` yok (OnPush adayı, doğrulanmadı) |
| F3 şablon fonksiyon çağrısı | 63+102 | 25 + 1 | Kısmen; pipe'lar var (`money` 40, `trDate` 29, `trDateTime` 104) |
| F4 800+ satır bileşen | 5 | 6: subscription-page 1427 (spec yok), dashboard 1164, product-detail 1162 (spec yok), today 970, clinic-detail 894, examination-workspace 804 | Değişmedi (B) |
| F4 auth.service spec | yok | 28 `it` | Yapıldı |
| F5 `track $index` | 18 / 7 | 26 / 10 dosya | Arttı (K) |
| F5 temizlenmeyen subscribe | 1 | `router.events/interval/fromEvent` kaynaklı 0; `valueChanges` 3 (formun kendi kontrolü) | Temiz |
| F6 hata eşleme | 24 / 769 / 324 | 12 / **843** / 36 | api-error.utils 74 satır büyüdü, ertelenen yönün tersine |
| F7 Sakai kalıntısı | ~15.5k | 0 | Yapıldı |
| P2 sözleşme kopyası | 6/12 farklı | 18 dosya, 0 farklı; backend'de kopyası olmayan 25 sözleşme | Yapıldı |
| P3 CI | eksik | lint + audit + portal build + iki projeli test | Yapıldı |

Düşük: `standalone: true` 274 gereksiz tekrar; `prefer-on-push` kuralı kapalı; i18n altyapısı yok (bilinçli); bütçe adayı `register-table.component.scss` 2051 B (2 KB uyarı eşiğinin 3 B üstü, build koşmadığı için doğrulanmadı); portal panelden bilinçli kopya (`portal-` önekli, 52 dosya), codemod kalıntısı yok.

## 6. Belge–kod çelişkileri
1. `foundation-rules.md:12` "Application yalnızca Domain" ↔ EF Core paketi (B3). Karar açık.
2. `foundation-rules.md` §3 tek public type ↔ 281 dosya.
3. `foundation-rules.md:13` "Domain dış paket bağımlı olmaz" ↔ `Mediator.Abstractions` (B-Y2 kaldırılırsa kapanır).
4. Backend kök `README.md` çekirdek-yalnız anlatım ↔ 80+ controller (P5). *(Düzeltme 2026-10-27: gerçek sayı 61 controller, ~390 uç; README güncellendi, `35ba7e75`.)*
5. `release-notes/` yalnız şablon README; WORKFLOW "geliştirme bitince release notu" diyor, hiç sürüm notu yok (ürün henüz yayınlanmadığı için kabul edilebilir; ilk sürümle başlar).
6. Ürün deposunda `.claude/` izlenmiyor ve `.gitignore`'da yok (`launch.json`, worktrees). `.gitignore`'a eklenmeli (K). *(Yapıldı 2026-10-27, `37d4e68`.)*

## 7. Karar bekleyenler (kullanıcı)
1. B3: EF paketini Application'dan düşür (O) mü, `foundation-rules §1`'i gerçeğe çek (K) mı. Öneri: önce belge.
2. Lint katman kuralı `warn → error` + kapsamı layout/pages'e genişlet (devam listesindeki madde). Öneri: evet, ihlal 0 iken.
3. F-Y2 `p-button → pButton` geçişi: şimdi planla (B) mı, PrimeNG 23 çıkınca mı.
4. Public type kuralı: gevşet (belge) mi, analizörle zorla (281 dosya düzelir) mi.
5. Dependabot eski PR'ları kapat (kullanıcı, GitHub arayüzü).
6. Outbox denetim kaydı ve eski `/api/v1/outbox` uçları (devam listesinden taşındı).
7. Barkod/SKU araması `tr-TR` mi dilden bağımsız mı (öneri: dilden bağımsız; randevu/aşı kodlarında I→ı hatası yaşandı).

## 8. Önerilen iş sırası (karar gerektirmeyenler)
| Sıra | İş | Depo | Boyut |
|---|---|---|---|
| 1 | F-Y1 portal üretim API adresi (betik + CI) | frontend | K |
| 2 | B-Y1 iptal loglama + çift ERR + rollback token; test Mediator üzerinden | backend | K |
| 3 | B-Y2 ölü domain-event yolu + Domain'den Mediator paketi; B-Y3 billingPeriod validator'a; B-Y4 namespace | backend | K-O |
| 4 | Paket hijyeni: `FluentValidation.AspNetCore` kaldır, OTel EF 1.20.1-beta.1, `@angular/platform-browser-dynamic` + `autoprefixer` kaldır; `Connect Timeout=60` test bağlantıları (devam listesi 3) | ikisi | K |
| 5 | `Mvc.Versioning → Asp.Versioning` geçişi | backend | O |
| 6 | P5 README; ürün deposu `.gitignore` `.claude/` | ikisi | K |
| 7 | F3 Eager→OnPush: 79 adaydan başla | frontend | O |
| 8 | B1 kalıcı; O2/O3; F1/F2 iskelet; B2/B4 kademeli | ikisi | O-B (24 Ekim planı geçerli) |

*Durum (2026-10-27):* 1-3 main'de. 4-6 yapıldı, dallarda bekliyor (main'e alınmadı); ayrıntı [devir notu](DEVIR-2026-10-24.md) madde 8.

## 9. Doğrulanmayanlar
Build/test/lint koşmadı. Ardalis `AddAsync` SaveChanges davranışı paket kaynağından değil yorumlardan; B-Y1 log davranışı kod okumasından; Eager→OnPush adaylarının davranışsal uygunluğu; bütçe uyarısı; vite açığının güncelliği; çok satırlı aria-label durumu; public type sayımı regex tabanlı yaklaşık; Visits no-show geri alma entegrasyon testi Visits klasöründe bulunamadı.
