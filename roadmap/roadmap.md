# Vetinity Ürün Roadmap

> **Not:** Bu roadmap kesin tarih taahhüdü içermez. Öncelik sıralaması ve stratejik yönü gösterir. Detaylı özellik maddeleri [feature backlog](../backlog/feature-backlog.md) içinde tutulur.

> **Ana plan (2026-10-09):** Bu roadmap, [Uçtan uca yol haritası ve ürün kararları](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md) belgesine (8 Ekim 2026) hizalanır. Teslim sırası ve kapsam konusunda iki belge çeliştiğinde **o belge geçerlidir**. Önceki P0–P4 yapısı silinmedi; "Önceki öncelik yapısı (referans)" başlığı altında korunuyor. Ana plandaki yeni kapsam ve öncelikler product repository'ye henüz backlog/ADR olarak işlenmedi; uygulandı anlamına gelmez.

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

## Ana plana göre teslim sırası

Kaynak: [Uçtan uca yol haritası](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md), bölüm 4. Takvim tarihi veya hafta tahmini yoktur.

| Aşama | Öncelik | Teslim edilecek sonuç | Sürüm konumu |
|---|---|---|---|
| 0 | Başlangıç + sürekli | Mevcut kapsamı ve ürün belgelerini hizalama; çalışma durumunu koruma; temel release eksiklerini doğrulama | Her sürümün temeli |
| 1 | P0 | Güvenli, bağlamlı muayene çalışma alanı | **İlk geliştirme işi** |
| 2 | P0 | Hasta bulma, geliş, bekleme ve Bugün yüzeyi | Kontrollü pilotun operasyon temeli |
| 3 | P0 | Temel ücret, tahsilat, kısmi ödeme ve bakiye | Kontrollü pilotun finans temeli |
| 4 | P1 | Hasta özeti, kritik uyarılar, timeline, klinik revizyon/finalization | v1.0 klinik sürekliliği |
| 5 | P1 | Tedavi, reçete ve klinik stok kullanımının gereken dar bağlantısı | v1.0 günlük işlem bütünlüğü |
| 6 | P1 | Lab istem/bekleyen sonuç ve manuel görüntüleme/dosya kayıtları | v1.0 diagnostik katmanı |
| 7 | P1 | Yatış görünürlüğü, bakım tamamlama, taburcu talimatı ve takip | v1.0 bakım sürekliliği |
| 8 | P1 | Menü, rapor merkezi, bildirim/açık işler, örnek klinik ve onboarding | v1.0 kullanım ve keşif |
| 9 | Çıkış koşulu | Gerçek klinik senaryolarıyla pilot; canlı işletim ve müşteri geçişini doğrulama | İlk ticari sürüm |
| 10 | P2 | Şablonlar/snippet, seçilmiş paketler ve onaylı AI yardımcıları | v1.x farklılaşma |
| 11 | P2 / ihtiyaca göre P1 | Online randevu, gelişmiş finans/kapanış, SMS/e-belge/POS/iletişim/portal | Talep doğrulanmış genişleme |
| 12 | Future | Cihaz/LIS/PACS, ileri yatış, mobil, hastane/enterprise ve yeni segmentler | İlk klinik sürümünden sonra |

**Aşama 1 durumu (2026-10-10):** Dilim 1 kullanıcı tarafından kabul edildi; iki depoda `feature/muayene-dilim1` dalında, main'e merge ve deploy bekliyor, yani üretimde kullanılabilir değil ("Tamamlandı" değil). Doğrulanmayanlar ve kalan manuel senaryolar: [AJAN-KUYRUGU](AJAN-KUYRUGU.md).

İlk iş: **Muayene kayıt bütünlüğü ve bağlamlı çalışma alanı, dilim 1** (EXAM-001–005, ADR-005). Kapsam dışı: tam Visit, timeline, alerji veri modeli, gerçek finalize/addendum, ücret/bakiye, ürün stok tüketimi, AI, cihaz entegrasyonu ve genel menü yeniden tasarımı (bölüm 23).

## Öncelik eşlemesi (önceki yapı → ana plan)

Önceliği değişen maddeler gerekçesiyle birlikte yazılmıştır. Durum alanları değişmedi; hiçbiri uygulanmış sayılmaz.

| Madde | Önceki | Ana plandaki yeri | Not |
|---|---|---|---|
| Modern muayene deneyimi | P0 | Aşama 1 (P0), ilk iş | Dilim 1 bütünlük + dört bölüm. Gerçek finalize/addendum Aşama 4'te. Şablon, bundle ve doz hesaplayıcı Aşama 10'a (aşağıya bakın). |
| Geliş, bekleme ve Bugün yüzeyi | — (yeni) | Aşama 2 (P0) | Ayrı Visit modeli önerisi; uygulama öncesi ADR gerekir. CHECKIN-001/005 dar kapsam; dar hasta/sahip araması için exact backlog kaydı henüz yok. |
| Temel ücret, tahsilat, bakiye | — (yeni) | Aşama 3 (P0) | Exact backlog kaydı ve ADR gerekir; RECORD-001 ve CHECKOUT-001 tek başına bu tasarımı tanımlamaz. |
| Hasta timeline | P1 | Aşama 4 (P1), v1.0'ın temel dilimi | İleri sürümler ilk ticari sürümden sonra. [ADR-006](../decisions/ADR-006-patient-timeline.md) |
| Imaging / Görüntüleme temel modülü | P1 | Aşama 6 (P1), manuel kayıt/dosya | PACS/DICOM Aşama 12. [ADR-007](../decisions/ADR-007-imaging-module.md) |
| Self-service 14 günlük trial | P0 | Aşama 8 (P1) | **P0 → P1.** Gerekçe: örnek klinik; geliş, muayene, kısmi tahsilat, bekleyen lab, aşı ve yatış gibi bağlı senaryoları göstermek için önce bu temellerin olması gerekir. [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) |
| Örnek Veteriner Kliniği | P0 | Aşama 8 (P1) | **P0 → P1.** Aynı gerekçe. [ADR-002](../decisions/ADR-002-example-clinic-strategy.md) |
| Menü sadeleştirme | P0 | Aşama 8 (P1) | **P0 → P1.** Mevcut route'lar ve bookmark'lar korunur. [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) |
| Rapor Merkezi | P0 | Aşama 8 (P1) | **P0 → P1.** Borç raporu ücret modelinden sonra anlamlıdır. [ADR-003](../decisions/ADR-003-report-center.md) |
| Trial kısıtlama politikası | P0 | **Açık soru** | Ana planda ayrıca zamanlanmadı. Aşama 8 trial kapsamıyla birlikte ele alınması önerilir; karar bekliyor. |
| Trial'dan ücretli plana dönüşüm akışı | P0 | **Açık soru** | Ana planda yalnızca "abonelik" platform kapısı olarak geçiyor (Aşama 9). Zamanlama kararı bekliyor. |
| Muayene şablonları, hazır tedavi paketleri | P1 | Aşama 10 (P2) | **P1 → P2.** Büyük yapılandırma motoru ilk günlük akışa gereksiz kapsam ekler. |
| Doz hesaplayıcı | P1 | Aşama 10 (P2) | **P1 → P2.** Klinik olarak doğrulanmış ayrı kapsam gerektirir. |
| İlk düşük riskli AI yardımcıları | P1 | Aşama 10 (P2) | **P1 → P2.** İlk ticari klinik akıştan sonra, onaylı taslak olarak. [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md) |
| Speech-to-text değerlendirmesi | P1 | Aşama 12 (Future) | Araştırma; release taahhüdü değildir. |
| Cihaz entegrasyonu altyapısı, dijital röntgen ve laboratuvar cihazı entegrasyonları | P1 / P2 | Aşama 12 (Future) | Pilot manuel sonuçla çalışamıyorsa ayrıca önceliklendirilir. |
| SMS, e-Fatura / e-SMM | P2 | Aşama 11 | Pilot için satın alma veya kullanım engeliyse P1'e çıkar. |
| WhatsApp, online ödeme / POS | P2 | Aşama 11 | WhatsApp için ilk kullanım tipi (Web yönlendirmesi veya Business API) açıkça seçilir. |
| Online randevu | P3 | Aşama 11 (P2) | **P3 → P2.** Check-in'in teknik ön koşulu değildir. |
| Hasta sahibi uygulaması (portal) | P3 | Aşama 11 (P2) | Kullanım ihtiyacı doğrulanır. |
| Aşı ve kontrol hatırlatmaları | P3 | Aşama 7 | Mevcut e-posta hatırlatması korunur ve gerçek gönderim senaryosuyla doğrulanır. |
| Veteriner mobil uygulaması | P3 | Aşama 12 (Future) | İlk sürümde responsive web; native yok. |
| Çok şubeli yönetim, SSO, gelişmiş audit, workflow engine, API marketplace, kurumsal raporlama | P4 | Aşama 12 (Future) | Mevcut tenant/clinic temeli korunur. |
| Diğer P2–P3 maddeleri (gelişmiş AI arama, AI rapor özetleme, kontrollü klinik karar desteği, push bildirimleri, reçete/tedavi görüntüleme, güvenli mesajlaşma) | P2 / P3 | Ana planda ayrıca yeniden sıralanmadı | Mevcut öncelikleri geçerli kalır; Aşama 10–12 ile uyumlu olduğu doğrulanacak. |

## Hizalamadan çıkan açık işler

1. **Backlog:** Geliş/Bugün, dar hasta/sahip arama, temel ücret/bakiye, lab istemi ve yapılandırılmış reçete satırı için exact kayıtlar açılmalı. Komşu feature ID'siyle tamamlanmış sayılmaz.
2. **ADR:** Visit modeli ve temel finans (ücret/tahsilat/bakiye) için ADR gerekir. [WORKFLOW](../WORKFLOW.md) bu iki işte geliştirmeden önce karar ister.
3. **v1 kapsamı:** [v1-release-scope.md](v1-release-scope.md) içindeki geniş etiketler (Patient Timeline, Imaging, Notification Center vb.) ana plandaki dar kapsamla netleştirilmeli.
4. **Trial:** Kısıtlama politikası ve ücretli plana dönüşüm akışının zamanlaması karara bağlanmalı.
5. **Kod doğrulaması:** Muayene dilim 1 başlamadan, ana plandaki kod bulgularının (randevu bağlantısının kaybolması, tarih filtresi uyuşmazlığı, eski formun yeni sürümü ezmesi) güncel kodda hâlâ geçerli olduğu doğrulanmalı.

---

## Önceki öncelik yapısı (referans)

> **Not:** Aşağıdaki P0–P4 bölümleri 2026-10-09 öncesi yapıdır. Öncelik ve sıra için yukarıdaki eşlemeye bakın. ADR bağlantıları ve kapsam notları geçerliliğini korur.

## P0 — Çıkış Öncesi Ürün Deneyimi

Çıkış öncesi dönemde kullanıcı edinimi, onboarding ve temel klinik deneyiminin olgunlaştırılması hedeflenir.

### Modern muayene deneyimi

| Alan | Değer |
|---|---|
| **Amaç** | Muayeneyi Vetinity'nin en kritik çalışma alanı haline getirmek |
| **Kullanıcı değeri** | Veteriner hekim muayene sırasında tüm klinik bağlamı tek ekranda yönetir |
| **Durum** | Geliştiriliyor (dilim 1 kabul edildi, merge bekliyor) |
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

- [Uçtan uca yol haritası ve ürün kararları (ana plan)](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)
- [Release plan](release-plan.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [Ürün vizyonu](../vision/vision.md)
