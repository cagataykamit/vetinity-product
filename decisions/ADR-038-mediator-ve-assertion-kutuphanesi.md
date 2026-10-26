# ADR-038 — MediatR yerine Mediator, FluentAssertions yerine AwesomeAssertions

## Durum

**Kabul edildi (2026-10-26, kullanıcı: "Tamam diğerini de mediator yap senin önerilerin mantıklı").**

## Bağlam

- Backend'de her komut ve sorgu MediatR üzerinden geçiyor: 345 işleyici. Ortak kurallar MediatR ara katmanlarında: doğrulama, abonelik yazma kapısı, denetim kaydı, günlük, performans, beklenmeyen hata, aktivasyon sinyali.
- Domain olayları `IDomainEvent : INotification` ile MediatR'a bağlı.
- **MediatR 13.0'dan beri** lisans "Lucky Penny Software" adına. Seçenekler RPL-1.5 (kaynak açma yükümlülüğü) ya da ticari lisans. Bugün kullanılan 13.1 de bu kapsamda.
  - Ücretsiz Community lisansı koşullu: yıllık ciro 5M USD altı, yıllık yenileme.
  - 12.x sürümü Apache-2.0, ama yeni geliştirme almıyor.
- **FluentAssertions 8.x** "Xceed Community License (Non-Commercial Use)" altında; ticari ürün için uygun değil. Testlerde kullanılıyor: 608 dosya, yaklaşık 15.000 doğrulama.
- Kaynak: `chore/backend-majors` ajan raporu (2026-10-26); paket sayfaları nuget.org ve github.com/martinothamar/Mediator.

## Karar

1. **MediatR → [Mediator](https://github.com/martinothamar/Mediator)** (martinothamar, MIT, 3.x).
   - `Mediator.Abstractions` mesajın ve işleyicinin tanımlandığı projelere (Domain, Application), `Mediator.SourceGenerator` yalnız en dış çalıştırılabilir projelere (Api, DbMigrator; testler gerekirse) girer.
   - İşleyiciler `Task<T>` yerine `ValueTask<T>` döner. Ara katmanlar `MessageHandlerDelegate<TMessage, TResponse>` imzasına geçer.
   - Ara katman **sırası korunur**; açıkça `PipelineBehaviors` ile verilir.
   - Yaşam süresi **Scoped** (işleyiciler `DbContext` gibi kapsamlı bağımlılık taşıyor; kütüphane varsayılanı Singleton).
   - Domain'deki `IDomainEvent : INotification` korunur, yalnız arayüz paketi değişir.
2. **FluentAssertions → AwesomeAssertions** (Apache-2.0). FluentAssertions 7'nin topluluk devamı; yazım aynı, değişen yalnız paket ve `using`.

## Gerekçe

- **Mediator:**
  - Lisans bağımlılığı kalıcı olarak kalkar; ciro büyüyünce ücretli lisans gerekmez.
  - Kaynak üretici sayesinde eksik ya da yanlış bağlanmış işleyici çalışma zamanında değil derlemede yakalanır.
  - Hız ve bellek kazancı da var; bizim yükte belirleyici değil.
- **AwesomeAssertions:** lisans sorunu yok, test kodu yeniden yazılmaz.
- **Elenen seçenekler:**
  - MediatR Community lisansı: kod değişmez, ama koşullu ve yıllık.
  - Kendi dağıtıcımızı yazmak: bakımı bize kalır.
  - Wolverine: kapsamı fazla büyük, outbox'ımız zaten var.
  - Shouldly: 15.000 satır yeniden yazılır.

## Sonuçlar

- Geçiş ayrı dalda yapılır. Önce bekleyen backend dalları (BILL-001, küçük borç, büyük sürümler) yerel bir birleşim dalında toplanır; çakışmayı azaltmak için geçiş bu dalın üstünde yapılır. Main'e alma kullanıcı onayıyla.
- Kabul ölçütü: davranış değişmez.
  - Tüm birim ve entegrasyon testleri geçer.
  - Ara katmanların sırası ve abonelik kapısı işaretleri (`IIgnoreTenantWriteSubscriptionGuard` vb.) aynı çalışır.
  - API sözleşmesi değişmez.
- Mediator generic istekleri desteklemez; varsa somut tiplere çevrilir.
- `appsettings*.json`'daki `LuckyPennySoftware.MediatR.License` log susturma girdileri kaldırılır.
