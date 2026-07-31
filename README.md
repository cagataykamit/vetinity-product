# Vetinity — Ürün Yönetimi

Bu repository, **Vetinity** veteriner klinik yönetim platformunun merkezi ürün hafızasıdır. Uygulama kodu içermez; ürün vizyonu, stratejisi, roadmap, backlog, UX ilkeleri, AI stratejisi, rakip analizleri ve stratejik kararlar burada tutulur.

## Temel ayrım

| Repository | Soru |
|---|---|
| **vetinity-product** (bu repo) | Ne yapıyoruz ve neden yapıyoruz? |
| **vetinity-web** (frontend) | Nasıl uyguluyoruz? (UI, entegrasyon, contract) |
| **Backend repository** | Nasıl uyguluyoruz? (mimari, CQRS, deploy, auth) |

Teknik dokümantasyon kendi kod repository'lerinde kalır. Bu repository teknik belgeleri tekrar üretmez veya kopyalamaz.

## Zorunlu Ürün Geliştirme Akışı

> **Kesin kural:** Vetinity'de yeni bir ürün fikri veya büyük ürün değişikliği doğrudan kodlanmaz.

Tüm ekip ve agent'lar için geçerli standart süreç:

```
Kullanıcı içgörüsü veya rakip gözlemi
  → Problem ve kullanıcı değeri
  → Rakip analizi gerekiyorsa competitors/
  → Feature backlog
  → Stratejik karar gerekiyorsa ADR
  → Roadmap önceliklendirmesi
  → UX ve teknik kapsam
  → Frontend/backend geliştirme
  → Doğrulama
  → Backlog, roadmap ve release notlarının güncellenmesi
```

**Doğrudan kodlanabilir:** bug düzeltmeleri, yazım/görünüm hataları, küçük erişilebilirlik iyileştirmeleri, kabul edilmiş tasarımın tamamlanması, davranışı değiştirmeyen teknik bakım.

**Önce bu repository'de kararlaştırılmalı:** yeni modül, ana ekran, menü değişikliği, akış değişikliği, trial/abonelik, AI, entegrasyon, veri modeli kararı, rakip özelliği, büyük UX kararı.

Tam kurallar, kapanış kontrol listesi ve ayrım tabloları: **[WORKFLOW.md](WORKFLOW.md)**

### Teknik kaynakların konumu

- **Frontend:** `vetinity-web` → `docs/` (ör. `FRONTEND-INTEGRATION-HANDOVER.md`, `BACKEND-INTEGRATION.md`)
- **Backend:** Backend repository → `docs/` (mimari, CQRS, deploy, security, auth/tenant, contract)

## Belge haritası

```
README.md                          ← Bu sayfa; giriş ve süreç rehberi
WORKFLOW.md                        ← Zorunlu ürün geliştirme akışı
vision/vision.md                   ← Uzun vadeli ürün vizyonu
roadmap/roadmap.md                 ← Önceliklendirilmiş ürün yol haritası
roadmap/release-plan.md            ← Aşamalı yayın planı ve metrikler
backlog/feature-backlog.md         ← Detaylı özellik backlog'u
ux/ux-principles.md                ← UX ilkeleri
ux/navigation.md                   ← Navigasyon ve menü yapısı
ux/design-decisions.md             ← UX tasarım kararları özeti
ai/ai-strategy.md                  ← AI stratejisi ve güvenlik ilkeleri
ai/ai-roadmap.md                   ← AI yetenek aşamaları
competitors/                       ← Rakip analizleri
decisions/                         ← Architecture Decision Records (ADR)
release-notes/                     ← Sürüm notları (gelecek)
```

## Süreç kuralları (özet)

Detaylı akış, istisnalar ve kapanış kontrol listesi için [WORKFLOW.md](WORKFLOW.md) kullanılır.

- **Her fikir roadmap'e girmez;** önce backlog'a alınır.
- **Her küçük değişiklik ADR gerektirmez.** ADR stratejik ve geri dönüşü maliyetli kararlar içindir.
- **Rakip özelliği kopyalanmaz;** çözdüğü problem analiz edilir.
- **Geliştirme tamamlandığında** backlog, roadmap ve release notları güncellenmeden iş kapanmış sayılmaz.
- **Product repository** neyi ve neden yaptığımızın kaynağıdır; frontend/backend nasıl uyguladığımızın kaynağıdır.

## Roadmap ve backlog farkı

| | Backlog | Roadmap |
|---|---|---|
| **Amaç** | Tüm fikirleri, problemleri ve detayları kaydetmek | Önceliklendirilmiş hedefleri ve aşamaları göstermek |
| **Granülarite** | Tek tek özellik maddeleri | Tematik gruplar (P0, P1, …) |
| **Durum** | Planlandı, Araştırılacak, Tasarlanacak, … | Aynı durum değerleri; kesin tarih taahhüdü yok |
| **Güncelleme** | Yeni fikirler sürekli eklenir | Öncelik değişikliklerinde güncellenir |

## ADR ne zaman gerekli?

Aşağıdaki durumlarda `decisions/` altında ADR oluşturulur:

- Birden fazla modülü veya ekip alanını etkileyen kararlar
- Geri dönüşü maliyetli mimari veya ürün yönü kararları
- UX veya iş modeli değişiklikleri (trial stratejisi, menü felsefesi vb.)
- Rakip analizinden çıkan stratejik farklılaşma kararları

Mevcut ADR'ler: [decisions/](decisions/)

## Rakip analizleri nasıl işlenir?

1. `competitors/README.md` şablonunu kullanarak yeni analiz ekle.
2. Bilinmeyen detayları uydurma; analiz durumunu açıkça belirt.
3. Vetinity için çıkarımı ve kopyalanmaması gereken unsurları yaz.
4. İlgili backlog maddesi ve ADR'ye bağlantı ver.
5. Stratejik karar gerektiriyorsa ADR oluştur.

## Belgelerin güncellenmesi

- Her belge tek bir konunun **ana kaynağı** olmalıdır; diğer belgeler ona bağlantı verir.
- Durum değişikliklerinde ilgili backlog, roadmap ve ADR kayıtları birlikte güncellenir.
- Tamamlanmamış özellikler tamamlanmış gibi gösterilmez.
- Tüm belgeler Türkçe ve UTF-8 formatındadır.

## Katkı ve değişiklik ilkeleri

- Yalnızca ürün yönetimi içeriği eklenir; uygulama kodu, script veya build yapılandırması eklenmez.
- Markdown bağlantıları göreli yollarla oluşturulur.
- Aynı içerik birçok dosyada tekrarlanmaz; tek kaynak prensibi uygulanır.
- Değişiklikler anlamlı commit mesajları ile kaydedilir (commit bu repo dışında yapılır).

## Hızlı bağlantılar

- [Ürün geliştirme akışı (WORKFLOW)](WORKFLOW.md)
- [Ürün vizyonu](vision/vision.md)
- [Roadmap](roadmap/roadmap.md)
- [Feature backlog](backlog/feature-backlog.md)
- [UX ilkeleri](ux/ux-principles.md)
- [AI stratejisi](ai/ai-strategy.md)
- [Rakip analizleri](competitors/README.md)
- [Stratejik kararlar (ADR)](decisions/ADR-001-self-service-trial-strategy.md)
