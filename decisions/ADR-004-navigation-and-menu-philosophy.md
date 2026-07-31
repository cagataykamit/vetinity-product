# ADR-004 — Navigasyon ve menü yaklaşımı

## Durum

Kabul edildi

## Bağlam

Vetinity modül sayısı arttıkça sidebar şişme riski taşır. Türler, ırklar ve ürün kategorileri gibi tanım ekranları günlük ana operasyon değildir; ancak sidebar'da yer kaplayabilir.

Temel UX ilkesi: **"Yeni özellik eklemek, otomatik olarak yeni bir sidebar menü öğesi eklemek anlamına gelmez."**

## Karar

1. **Menü şişmesi önlenecektir.** Yeni özellikler eklendikçe sidebar otomatik büyümeyecektir.
2. Yeni özellik, mevcut bir iş akışına, ayarlar bölümüne veya iç navigasyona eklenip eklenemeyeceği **değerlendirilecektir**.
3. **2–3 etkileşim prensibi:** Kullanıcı sık kullandığı işlere 2–3 etkileşim içinde ulaşabilmelidir.
4. Türler, ırklar ve ürün kategorileri gibi günlük ana operasyon olmayan tanım ekranları gelecekte **Ayarlar > Tanımlar** altında toplanacaktır.

> **Not:** Tanımlar merkezi kabul edilmiş ürün yönüdür; uygulamanın tamamlandığı anlamına gelmez.

5. Derin linkler korunmalıdır; menü yapısı değişse bile mevcut URL'ler çalışmaya devam etmelidir.

## Gerekçe

- Uzun vadeli navigasyon sürdürülebilirliği ([UX ilkeleri](../ux/ux-principles.md))
- Tanım ekranları nadiren kullanılır; ana menüde yer kaplamamalı
- Rapor Merkezi ([ADR-003](ADR-003-report-center.md)) ve gömülü AI ([ADR-008](ADR-008-embedded-ai-assistant.md)) ile tutarlı menü felsefesi

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Her modül ayrı sidebar öğesi | Şişme; sürdürülebilir değil |
| Tanımları tamamen kaldırma | Operasyonel gereklilik |
| Hamburger/overflow menü | Sık kullanılan işler gizlenir; 2–3 etkileşim ihlali |

## Olumlu sonuçlar

- Sidebar sade ve odaklı kalır
- Yeni özellik ekleme navigasyonu bozmaz
- Tanım ekranları mantıksal gruplama altında
- Derin link uyumluluğu korunur

## Riskler ve olumsuz sonuçlar

- Mevcut kullanıcılar tanım ekranlarının yer değiştirmesine alışmak zorunda
- Ayarlar menüsü altında keşfedilebilirlik sorunu (boş durum ve yönlendirme gerekli)
- Geçiş döneminde eski ve yeni menü yapısı birlikte bulunabilir

## Uygulama etkileri

- Sidebar sadeleştirme ([UX-001](../backlog/feature-backlog.md))
- Ayarlar > Tanımlar merkezi ([UX-002](../backlog/feature-backlog.md))
- Türler, ırklar, ürün kategorileri taşınması ([UX-003](../backlog/feature-backlog.md)–[UX-005](../backlog/feature-backlog.md))
- Navigasyon belgesi güncellenmeli ([Navigasyon](../ux/navigation.md))

## İlgili belgeler

- [ADR-003 — Rapor Merkezi](ADR-003-report-center.md)
- [ADR-008 — Gömülü AI yardımcısı](ADR-008-embedded-ai-assistant.md)
- [UX ilkeleri](../ux/ux-principles.md)
- [Navigasyon yapısı](../ux/navigation.md)
- [Tasarım kararları](../ux/design-decisions.md)
