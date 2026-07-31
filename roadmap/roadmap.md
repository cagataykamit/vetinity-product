# Vetinity Ürün Roadmap

> **Not:** Bu roadmap kesin tarih taahhüdü içermez. Öncelik sıralaması ve stratejik yönü gösterir. Detaylı özellik maddeleri [feature backlog](../backlog/feature-backlog.md) içinde tutulur.

## Durum değerleri

| Durum | Açıklama |
|---|---|
| Planlandı | Karar alındı, henüz başlanmadı |
| Araştırılacak | Keşif ve değerlendirme gerekiyor |
| Tasarlanacak | Ürün/UX tasarımı bekleniyor |
| Geliştiriliyor | Aktif geliştirme sürecinde |
| Tamamlandı | Üretim ortamında kullanılabilir |
| Ertelendi | Bilinçli olarak ertelendi |

---

## P0 — Çıkış Öncesi Ürün Deneyimi

Çıkış öncesi dönemde kullanıcı edinimi, onboarding ve temel klinik deneyiminin olgunlaştırılması hedeflenir.

### Modern muayene deneyimi

| Alan | Değer |
|---|---|
| **Amaç** | Muayeneyi Vetinity'nin en kritik çalışma alanı haline getirmek |
| **Kullanıcı değeri** | Veteriner hekim muayene sırasında tüm klinik bağlamı tek ekranda yönetir |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | — |
| **Kapsam notu** | SOAP mantığı, Türkçe terminoloji; şablon/bundle/doz hesaplayıcı P1'e taşınır |

→ [ADR-005](../decisions/ADR-005-modern-examination-experience.md) · [EXAM backlog maddeleri](../backlog/feature-backlog.md)

### Self-service 14 günlük trial

| Alan | Değer |
|---|---|
| **Amaç** | Kullanıcıların satış görüşmesi olmadan ürünü denemesini sağlamak |
| **Kullanıcı değeri** | Anında erişim; satış sürtünmesi olmadan değer değerlendirmesi |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | Trial kısıtlama politikası, dönüşüm akışı |
| **Kapsam notu** | Canlı demo büyük/kurumsal müşteriler için opsiyonel kalır |

→ [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md)

### Örnek Veteriner Kliniği

| Alan | Değer |
|---|---|
| **Amaç** | İlk 5–10 dakikada ürün değerini göstermek |
| **Kullanıcı değeri** | Boş ekran yerine gerçekçi sentetik veriyle hızlı keşif |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | Sentetik seed verileri |
| **Kapsam notu** | Önerilen onboarding seçeneği; gerçek müşteri verisi kullanılmaz |

→ [ADR-002](../decisions/ADR-002-example-clinic-strategy.md)

### Menü sadeleştirme

| Alan | Değer |
|---|---|
| **Amaç** | Sidebar şişmesini önlemek; tanım ekranlarını Ayarlar altında toplamak |
| **Kullanıcı değeri** | Daha az bilişsel yük; sık kullanılan işlere hızlı erişim |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | — |
| **Kapsam notu** | Türler, ırklar, ürün kategorileri → Ayarlar > Tanımlar (hedef, henüz uygulanmadı) |

→ [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md)

### Rapor Merkezi

| Alan | Değer |
|---|---|
| **Amaç** | Sidebar'da tek "Raporlar" menüsü; iç navigasyonla rapor erişimi |
| **Kullanıcı değeri** | Rapor keşfi ve erişimi tek merkezden |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | — |
| **Kapsam notu** | Favoriler, kaydedilmiş filtreler, dışa aktarma backlog'da |

→ [ADR-003](../decisions/ADR-003-report-center.md)

### Trial kısıtlama politikası

| Alan | Değer |
|---|---|
| **Amaç** | Trial'da günlük kullanımın büyük bölümünü deneyimletirken riskli işlemleri sınırlamak |
| **Kullanıcı değeri** | Gerçekçi deneyim; maliyetli/riskli entegrasyonlardan koruma |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | Self-service trial |
| **Kapsam notu** | SMS, e-Fatura, POS, API anahtarı, toplu dışa aktarma sınırlandırılır |

### Trial'dan ücretli plana dönüşüm akışı

| Alan | Değer |
|---|---|
| **Amaç** | Trial bitiminde veya öncesinde sorunsuz plan yükseltme |
| **Kullanıcı değeri** | Kesintisiz geçiş; veri kaybı olmadan devam |
| **Durum** | Planlandı |
| **Öncelik** | P0 |
| **Bağımlılıklar** | Self-service trial, abonelik modülü |
| **Kapsam notu** | Dönüşüm metrikleri tanımlanacak |

---

## P1 — Premium Klinik Deneyimi

Klinik çalışma alanlarının derinleştirilmesi ve ilk AI yetenekleri.

| Madde | Durum | Öncelik | Not |
|---|---|---|---|
| Hasta timeline | Planlandı | P1 | [ADR-006](../decisions/ADR-006-patient-timeline.md) |
| Imaging / Görüntüleme temel modülü | Planlandı | P1 | [ADR-007](../decisions/ADR-007-imaging-module.md) |
| Muayene şablonları | Planlandı | P1 | |
| Hazır tedavi paketleri / bundles | Planlandı | P1 | |
| Doz hesaplayıcı | Planlandı | P1 | |
| İlk düşük riskli AI yardımcıları | Planlandı | P1 | [AI roadmap](../ai/ai-roadmap.md) Aşama 1 |
| Speech-to-text değerlendirmesi | Araştırılacak | P1 | |
| Cihaz entegrasyonu altyapısının araştırılması | Araştırılacak | P1 | |

---

## P2 — Entegrasyonlar ve Gelişmiş AI

Dış sistem entegrasyonları ve AI yeteneklerinin genişletilmesi.

| Madde | Durum | Öncelik |
|---|---|---|
| Dijital röntgen cihazı entegrasyonları | Araştırılacak | P2 |
| Laboratuvar cihazı entegrasyonları | Araştırılacak | P2 |
| e-Fatura / e-SMM | Planlandı | P2 |
| SMS | Planlandı | P2 |
| WhatsApp | Planlandı | P2 |
| Online ödeme / POS | Planlandı | P2 |
| Gelişmiş AI arama | Planlandı | P2 |
| AI rapor özetleme | Planlandı | P2 |
| Kontrollü klinik karar desteği araştırması | Araştırılacak | P2 |

---

## P3 — Mobil ve Hasta Sahibi Deneyimi

| Madde | Durum | Öncelik |
|---|---|---|
| Veteriner mobil uygulaması | Planlandı | P3 |
| Hasta sahibi uygulaması | Planlandı | P3 |
| Online randevu | Planlandı | P3 |
| Push bildirimleri | Planlandı | P3 |
| Aşı ve kontrol hatırlatmaları | Planlandı | P3 |
| Reçete ve tedavi görüntüleme | Planlandı | P3 |
| Güvenli mesajlaşma değerlendirmesi | Araştırılacak | P3 |

---

## P4 — Enterprise

| Madde | Durum | Öncelik |
|---|---|---|
| Çok şubeli gelişmiş yönetim | Planlandı | P4 |
| SSO | Planlandı | P4 |
| Gelişmiş audit | Planlandı | P4 |
| Workflow engine | Planlandı | P4 |
| API marketplace | Planlandı | P4 |
| Kurumsal raporlama ve KPI | Planlandı | P4 |
| Gelişmiş entegrasyon yönetimi | Planlandı | P4 |

---

## İlgili belgeler

- [Release plan](release-plan.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [Ürün vizyonu](../vision/vision.md)
