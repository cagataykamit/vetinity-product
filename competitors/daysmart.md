# DaySmart Vet — Rakip Analizi

## Ürün

DaySmart Vet (uluslararası veteriner klinik yönetim platformu)

## İncelenen alan

Muayene deneyimi (SOAP / Medical Note), hasta geçmişi, klinik yardımcılar, mobil

## Analiz durumu

**Kısmi** — Temel gözlemler kaydedildi; detaylı ekran bazlı analiz ileride genişletilecektir.

---

## Bilinen gözlemler

| Alan | Gözlem |
|---|---|
| SOAP / Medical Note | Birleşik muayene çalışma alanı |
| Subjective / Objective | Yapılandırılmış muayene bölümleri |
| Vital bulgular | Muayene içinde vital değer girişi |
| Hazır bundle | Tedavi paketleri yaklaşımı |
| Doz hesaplayıcı | Muayene/tedavi akışına gömülü |
| Speech-to-text | Muayene notu için sesli giriş |
| Hasta kayıt timeline'ı | Kronolojik hasta geçmişi |
| Checkout iş akışı | Muayene sonrası ödeme akışı |
| Hasta sahibi mobil uygulaması | Pet owner mobil deneyimi |
| Kalıcı dikkat ve uyarı paneli | Kritik hasta uyarıları sürekli görünür |
| SOAP kilitleme | Aynı SOAP kaydında eşzamanlı çalışma ve kilitleme |

## Kullanıcı problemi

Veteriner hekimler muayene sırasında dağınık ekranlar arasında gezinmek, hasta geçmişini hızlıca taramak ve tekrarlayan tedavi kombinasyonlarını hızlı uygulamak zorundadır.

## Güçlü yön

- Birleşik ve güçlü muayene (SOAP) çalışma alanı
- Hasta timeline ile merkezi geçmiş görünümü
- Kalıcı kritik uyarı paneli
- Bundle ve şablonlarla hız kazancı
- İş akışına gömülü yardımcılar (doz hesaplayıcı, speech-to-text)

## Zayıf yön

- Arayüz modern SaaS standartlarının altında kalabilir (Vetinity fırsat alanı)
- Karmaşık arayüz yoğun kullanıcılar için öğrenme eğrisi

## Vetinity için çıkarım

| Problem | Vetinity yaklaşımı | Backlog / ADR |
|---|---|---|
| Birleşik muayene alanı | Modern muayene çalışma alanı; Türkçe terminoloji | [EXAM-001](../backlog/feature-backlog.md), [ADR-005](../decisions/ADR-005-modern-examination-experience.md) |
| Hasta geçmişi | Merkezi timeline; ayrı veri deposu yok | [TIMELINE-001](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md) |
| Kritik uyarılar | Kalıcı alerji ve dikkat uyarıları | [EXAM-009](../backlog/feature-backlog.md) |
| Tedavi hızı | Bundle/paketler, şablonlar, doz hesaplayıcı | [EXAM-006](../backlog/feature-backlog.md), [EXAM-007](../backlog/feature-backlog.md), [EXAM-008](../backlog/feature-backlog.md) |
| Sesli not | Speech-to-text değerlendirmesi | [AI-005](../backlog/feature-backlog.md) |
| Modern arayüz | Sade, hızlı, Tailwind/PrimeNG tabanlı UX | [UX ilkeleri](../ux/ux-principles.md) |

## Kopyalanmaması gereken unsur

- SOAP terminolojisinin birebir İngilizce kullanımı — Vetinity Türkçe ve doğal veteriner dili kullanır
- Arayüz layout'unun birebir kopyalanması
- SOAP kilitleme mekanizmasının aynen uygulanması (Vetinity kendi eşzamanlılık modelini değerlendirmeli)

## Kanıt / ekran / kaynak notu

Ürün gözlemi ve genel pazar bilgisi. Detaylı ekran görüntüsü analizi ileride eklenecektir.

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
- [ADR-005 — Modern muayene deneyimi](../decisions/ADR-005-modern-examination-experience.md)
- [ADR-006 — Hasta timeline](../decisions/ADR-006-patient-timeline.md)
