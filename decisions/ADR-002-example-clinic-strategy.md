# ADR-002 — Örnek klinik stratejisi

## Durum

Kabul edildi

## Bağlam

Self-service trial ile kullanıcılar boş bir klinikle başlayabilir. Boş klinik deneyimi:

- Ürün değerini geç gösterir
- Kullanıcıyı "ne yapmalıyım?" sorusuna iter
- İlk 5–10 dakikada anlamlı keşif sağlamaz

Demo ortamının yaşayan bir ürün hissi vermesi UX ilkesidir ([UX ilkeleri](../ux/ux-principles.md)).

## Karar

1. İlk onboarding sırasında kullanıcıya iki seçenek sunulacaktır:
   - **Boş klinikle başla**
   - **Örnek Veteriner Kliniğini yükle** — **önerilen seçenek**
2. Örnek klinik:
   - Gerçek bir işletme gibi hissettirmeli
   - Gerçek müşterilere ait veri **içermemeli**
   - Tamamen sentetik fakat tutarlı verilerden oluşmalı
   - Kullanıcının yaklaşık ilk 5–10 dakika içinde ürünün temel değerini görmesini sağlamalı
3. Örnek içerikler: müşteriler, hayvanlar, randevular, muayeneler, aşılar, tedaviler, laboratuvar sonuçları, ödemeler, ürünler, stok hareketleri, raporlar, takvim kayıtları.

## Gerekçe

- Boş durum onboarding sürtünmesi yaratır
- Sentetik veri ile modüller arası ilişkiler gösterilebilir
- Kullanıcı silme/temizleme ile kendi verisine geçebilir
- Gerçek müşteri verisi gizlilik riski taşır; sentetik veri güvenlidir

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Yalnızca boş klinik | Yavaş değer keşfi |
| Gerçek klinik verisi (anonimleştirilmiş) | Gizlilik riski; tutarlılık sorunu |
| Video/slide tabanlı demo | Etkileşimli değil; yaşayan ürün hissi vermez |
| Satış temsilcisi tarafından doldurulmuş demo | Self-service ile çelişir |

## Olumlu sonuçlar

- Hızlı değer keşfi (time-to-value)
- Modüller arası ilişkilerin görselleştirilmesi
- Trial aktivasyon oranının artması
- Örnek klinik seçme oranı metrik olarak izlenebilir

## Riskler ve olumsuz sonuçlar

- Sentetik veri gerçekçi olmazsa ters etki yaratabilir
- Örnek veriyi temizleme/geçiş akışı net olmalı
- Seed verisi bakım maliyeti (modül eklendikçe güncellenmeli)

## Uygulama etkileri

- Onboarding akışına seçim ekranı eklenmeli ([TRIAL-002](../backlog/feature-backlog.md))
- Sentetik seed veri seti oluşturulmalı ([TRIAL-003](../backlog/feature-backlog.md))
- Örnek klinik seçme oranı metrik olarak izlenmeli ([TRIAL-008](../backlog/feature-backlog.md))

## İlgili belgeler

- [ADR-001 — Self-service trial](ADR-001-self-service-trial-strategy.md)
- [Feature backlog — TRIAL-002, TRIAL-003](../backlog/feature-backlog.md)
- [Release plan — Aşama 3](../roadmap/release-plan.md#aşama-3--self-service-trial-açılışı)
- [UX ilkeleri — Demo ortamı](../ux/ux-principles.md)
