# Rakip Analizleri

Vetinity rakip ürünlerini problem odaklı inceler. Özellik kopyalamak yerine çözülen problem anlaşılır ve Vetinity'nin kendi UX ve iş akışı felsefesiyle ele alınır.

## Analiz prensipleri

1. **Problem önce:** Rakip özelliği değil, çözdüğü kullanıcı problemi değerlendirilir.
2. **Kopyalama yok:** Arayüz ve akış birebir kopyalanmaz.
3. **Bilinmeyeni uydurma:** Bilinmeyen detaylar "bilinmiyor" veya "incelenecek" olarak işaretlenir.
4. **Backlog bağlantısı:** Çıkarımlar ilgili backlog maddelerine bağlanır.
5. **ADR bağlantısı:** Stratejik karar gerektiren çıkarımlar ADR'ye referans verir.

---

## Standart değerlendirme şablonu

Her rakip analizi aşağıdaki alanları içermelidir:

| Alan | Açıklama |
|---|---|
| **Ürün** | Rakip ürün adı |
| **İncelenen alan** | Analiz kapsamı (muayene, timeline, entegrasyon vb.) |
| **Kullanıcı problemi** | Rakip özelliğinin çözdüğü problem |
| **Güçlü yön** | Rakibin iyi yaptığı alan |
| **Zayıf yön** | Rakibin zayıf kaldığı alan |
| **Vetinity için çıkarım** | Vetinity'nin nasıl yaklaşması gerektiği |
| **Kopyalanmaması gereken unsur** | Bilinçli olarak kopyalanmayacak detay |
| **İlgili backlog maddesi** | Feature backlog referansı |
| **İlgili ADR** | Stratejik karar referansı (varsa) |
| **Kanıt / ekran / kaynak notu** | Gözlem kaynağı |
| **Analiz durumu** | Tamamlandı / Kısmi / Beklemede |

---

## Mevcut analizler

| Rakip | Pazar | Analiz durumu | Belge |
|---|---|---|---|
| DaySmart Vet | Uluslararası | Kısmi | [daysmart.md](daysmart.md) |
| ezyVet | Uluslararası | Beklemede | [ezyvet.md](ezyvet.md) |
| Digitail | Uluslararası | Beklemede | [digitail.md](digitail.md) |
| Provet Cloud | Uluslararası | Beklemede | [provet-cloud.md](provet-cloud.md) |
| Bulutvet | Türkiye | Kısmi | [bulutvet.md](bulutvet.md) |

---

## Vetinity farklılaşma alanları (rakip analizlerinden)

| Alan | Vetinity yaklaşımı | Kaynak |
|---|---|---|
| Muayene deneyimi | Modern, sade, Türkçe terminoloji | DaySmart, [ADR-005](../decisions/ADR-005-modern-examination-experience.md) |
| Navigasyon | Menü şişmesini önleme; Rapor Merkezi | [ADR-003](../decisions/ADR-003-report-center.md), [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) |
| AI | Gömülü yardımcı; ayrı modül değil | [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md) |
| Trial | Self-service; satış zorunluluğu yok | [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) |
| Arayüz | Modern SaaS; eski UI'dan kaçınma | ezyVet gözlemi |

---

## İlgili belgeler

- [UX ilkeleri — Rakip kopyalama ilkesi](../ux/ux-principles.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [Ürün vizyonu](../vision/vision.md)
