# Rakip Analizleri

Vetinity rakip ürünlerini problem odaklı inceler. Özellik kopyalamak yerine çözülen problem anlaşılır ve Vetinity'nin kendi UX ve iş akışı felsefesiyle ele alınır.

## Analiz prensipleri

1. **Problem önce:** Rakip özelliği değil, çözdüğü kullanıcı problemi değerlendirilir.
2. **Kopyalama yok:** Arayüz ve akış birebir kopyalanmaz.
3. **Bilinmeyeni uydurma:** Bilinmeyen detaylar "bilinmiyor" veya "incelenecek" olarak işaretlenir.
4. **Backlog bağlantısı:** Çıkarımlar ilgili backlog maddelerine bağlanır.
5. **ADR bağlantısı:** Stratejik karar gerektiren çıkarımlar ADR'ye referans verir.

---

## Primary Competitors

Vetinity'nin hedef kalite seviyesi ve ürün stratejisi için ana referanslardır.

### Global

| Rakip | Analiz durumu | Belge |
|---|---|---|
| ezyVet | Beklemede | [ezyvet.md](ezyvet.md) |
| Provet Cloud | Kısmi | [provet-cloud.md](provet-cloud.md) |
| Digitail | Beklemede | [digitail.md](digitail.md) |
| DaySmart Vet | Kısmi | [daysmart.md](daysmart.md) |

### Türkiye

| Rakip | Analiz durumu | Belge |
|---|---|---|
| E-vet Smart Plus | Beklemede | — |

---

## Legacy Competitors

Modern ürün vizyonunu belirleyen ana referans değildir. Eski iş akışlarını, güçlü yönleri ve Türkiye pazarındaki tarihsel yaklaşımları anlamak için değerlendirilir.

| Rakip | Analiz durumu | Belge |
|---|---|---|
| Bulutvet | Kısmi | [bulutvet.md](bulutvet.md) |

---

## Standart analiz şablonu

Tüm rakip analizlerinde aşağıdaki bölümler kullanılır:

| Bölüm | Açıklama |
|---|---|
| **Ürün özeti** | Rakip ürünün kısa tanımı ve pazar konumu |
| **Hedef müşteri kitlesi** | Hangi klinik tipine ve ölçeğe hitap ettiği |
| **Güçlü yönler** | Rakibin iyi yaptığı alanlar |
| **Zayıf yönler** | Rakibin zayıf kaldığı alanlar |
| **Dikkat çekici özellikler** | Öne çıkan veya farklılaştırıcı yetenekler |
| **UX değerlendirmesi** | Arayüz, navigasyon ve iş akışı gözlemleri |
| **AI ve otomasyon** | Yapay zeka ve otomasyon yaklaşımı (varsa) |
| **Entegrasyonlar** | SMS, POS, e-Fatura, cihaz vb. entegrasyonlar |
| **Vetinity için çıkarımlar** | Vetinity'nin problem odaklı nasıl yaklaşması gerektiği |
| **Backlog adayları** | İlgili feature backlog maddeleri veya aday fikirler |

Ek meta alanlar (gerekirse):

| Alan | Açıklama |
|---|---|
| **Kopyalanmaması gereken unsur** | Bilinçli olarak kopyalanmayacak detay |
| **İlgili ADR** | Stratejik karar referansı (varsa) |
| **Kanıt / ekran / kaynak notu** | Gözlem kaynağı |
| **Analiz durumu** | Tamamlandı / Kısmi / Beklemede |

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

## Araştırma Süreci

Her rakip için aşağıdaki adımlar standart yöntem olarak izlenir:

1. **Ürün erişimi** — Demo hesabı, trial veya halka açık kaynak
2. **Demo** — Canlı veya kayıtlı ürün gösterimi
3. **Dökümantasyon** — Resmi yardım, API veya pazarlama materyalleri
4. **Video** — Eğitim, demo veya kullanıcı kayıtları
5. **Screenshot** — Ekran görüntüsü arşivi
6. **Doğrudan gözlemler** — Kaynaktan doğrulanabilir davranışlar (yorumdan ayrı)
7. **Güçlü yönler** — Ürün değerlendirmesi
8. **Zayıf yönler** — UX ve operasyonel riskler
9. **Vetinity çıkarımları** — Değerlendirme adayları (kesin karar değil)
10. **Ideas** — Tekil fikirler → [research/ideas.md](../research/ideas.md)
11. **Patterns** — Tekrar eden kalıplar → [research/patterns.md](../research/patterns.md)

Bu akış, rakip notlarının ötesinde uzun vadeli ürün araştırma merkezine aktarımı sağlar. Backlog'a geçiş [WORKFLOW.md](../WORKFLOW.md) sürecine tabidir.

---

## İlgili belgeler

- [UX ilkeleri — Rakip kopyalama ilkesi](../ux/ux-principles.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [Ürün vizyonu](../vision/vision.md)
- [Product Research Ideas](../research/ideas.md)
- [Product Patterns](../research/patterns.md)
- [Research README](../research/README.md)
