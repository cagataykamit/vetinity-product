# UX Tasarım Kararları Özeti

Bu belge, UX ile ilgili stratejik kararların kısa referansını sunar. Her kararın detaylı gerekçesi ilgili ADR veya ana belgede tutulur; burada tekrarlanmaz.

## Karar tablosu

| Konu | Karar | Durum | Ana kaynak |
|---|---|---|---|
| Sidebar sadeleştirme | Yeni özellik otomatik yeni menü oluşturmaz | Kabul edildi | [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) |
| Tanımlar merkezi | Türler, ırklar, ürün kategorileri → Ayarlar > Tanımlar | Hedef (uygulanmadı) | [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) |
| Rapor Merkezi | Sidebar'da tek "Raporlar"; iç navigasyon | Kabul edildi | [ADR-003](../decisions/ADR-003-report-center.md) |
| Muayene çalışma alanı | Tam sayfa/geniş alan; SOAP mantığı, Türkçe terminoloji | Kabul edildi | [ADR-005](../decisions/ADR-005-modern-examination-experience.md) |
| Hasta timeline | Kronolojik birleşik görünüm; ayrı veri deposu yok | Kabul edildi | [ADR-006](../decisions/ADR-006-patient-timeline.md) |
| Görüntüleme modülü | Imaging yaklaşımı; hayvan/muayene/timeline bağlantısı | Kabul edildi | [ADR-007](../decisions/ADR-007-imaging-module.md) |
| Gömülü AI | AI ayrı menü değil; taslak + kullanıcı onayı | Kabul edildi | [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md) |
| Self-service trial | 14 gün; satış görüşmesi zorunlu değil | Kabul edildi | [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) |
| Örnek klinik onboarding | Önerilen seçenek; sentetik veri | Kabul edildi | [ADR-002](../decisions/ADR-002-example-clinic-strategy.md) |
| 2–3 etkileşim prensibi | Sık işlere hızlı erişim | Kabul edildi | [UX ilkeleri](ux-principles.md) |
| Claim bazlı görünürlük | Yetkisiz işlevler gizlenir | Planlandı | [REPORT-006](../backlog/feature-backlog.md) |
| Derin link koruma | Menü değişse bile URL'ler çalışır | Kabul edildi | [Navigasyon](navigation.md) |

## Terminoloji kararları

| Uluslararası | Vetinity (Türkçe) | Not |
|---|---|---|
| SOAP — Subjective | Şikâyet ve anamnez | Doğal veteriner dili |
| SOAP — Objective | Klinik bulgular | Vital değerler dahil |
| SOAP — Assessment | Değerlendirme / tanı | |
| SOAP — Plan | Plan / tedavi planı | |
| Hospitalization | Yatış | Pansiyon ile karıştırılmaz |

## Henüz kararlaştırılmamış UX konuları

Aşağıdaki konular backlog'da veya roadmap'te; kesin UX kararı henüz ADR olarak kaydedilmedi:

- Muayene şablonları UX detayı ([EXAM-006](../backlog/feature-backlog.md))
- Timeline filtre ve görünüm tasarımı ([TIMELINE-003](../backlog/feature-backlog.md))
- Rapor Merkezi kart vs. sekme yaklaşımı ([REPORT-002](../backlog/feature-backlog.md))
- Trial onboarding adım sayısı ve akış sırası ([TRIAL-002](../backlog/feature-backlog.md))

---

## İlgili belgeler

- [UX ilkeleri](ux-principles.md)
- [Navigasyon yapısı](navigation.md)
- [Stratejik kararlar (ADR)](../decisions/ADR-001-self-service-trial-strategy.md)
