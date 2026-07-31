# Navigasyon Yapısı

Bu belge Vetinity'nin ürün perspektifinden navigasyon yapısını tanımlar. Teknik route tanımları `vetinity-web` repository'sinde tutulur; burada yalnızca ürün ve kullanıcı deneyimi açısından özet verilir.

## Temel ayrım: Route ≠ Sidebar

**Teknik route yapısı** ile **kullanıcıya görünen sidebar menüsü** aynı şey değildir.

- Bir modülün kendi route'u olabilir ancak sidebar'da ayrı menü öğesi olarak görünmeyebilir.
- Raporlar tek sidebar öğesi iken teknik olarak ayrı rapor route'ları korunabilir ([ADR-003](../decisions/ADR-003-report-center.md)).
- Türler, ırklar ve ürün kategorileri route olarak mevcut olabilir; sidebar'da Ayarlar > Tanımlar altında gruplanması hedeflenir ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md)).

**Derin linkler korunmalıdır.** Menü yapısı değişse bile mevcut URL'ler ve bookmark'lar çalışmaya devam etmelidir.

---

## Üst seviye route grupları

### Public

Kayıt, tanıtım ve genel bilgi sayfaları. Giriş yapmamış kullanıcılar erişir.

| Alan | Açıklama |
|---|---|
| **Amaç** | Ürün tanıtımı, self-service kayıt, trial başlatma |
| **Örnek** | Ana sayfa, kayıt, giriş |

Self-service trial stratejisi: [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md)

### Auth

Kimlik doğrulama akışları.

| Alan | Açıklama |
|---|---|
| **Amaç** | Giriş, çıkış, şifre sıfırlama, davet kabul |
| **Not** | Multi-tenant yapı; kullanıcı tenant bağlamında oturum açar |

### Panel

Giriş yapmış kullanıcıların ana çalışma alanı. Tüm klinik modülleri bu grup altındadır.

---

## Panel içi yapı

### Dashboard

Klinik özeti, hızlı erişim, günlük görevler. Giriş sonrası varsayılan landing.

### Klinik modülleri

Günlük klinik operasyonların kalbi.

| Modül | Ürün rolü |
|---|---|
| Müşteriler | Hasta sahibi kayıtları |
| Hayvanlar | Hasta (hayvan) kayıtları |
| Randevular | Randevu oluşturma ve yönetim |
| Randevu takvimi | Takvim görünümü |
| Muayeneler | Kritik çalışma alanı ([ADR-005](../decisions/ADR-005-modern-examination-experience.md)) |
| Tedaviler | Tedavi kayıtları |
| Reçeteler | Reçete yönetimi |
| Laboratuvar | Lab sonuçları |
| Aşılar | Aşı kayıtları ve takibi |
| Yatışlar | Hospitalization (yatış) yönetimi |
| Ödemeler | Tahsilat ve ödeme |
| Hatırlatmalar | Otomatik/manuel hatırlatmalar |

> **Not:** Yatış (Hospitalization) ile pansiyon aynı ürün alanı değildir. Pansiyon kavramı Bulutvet gibi rakiplerde farklı anlam taşır ([Bulutvet analizi](../competitors/bulutvet.md)).

### Ürün ve stok

Envanter ve ticari operasyonlar.

| Modül | Ürün rolü |
|---|---|
| Ürünler | Ürün kataloğu |
| Stok durumu | Anlık stok seviyeleri |
| Stok hareketleri | Giriş/çıkış kayıtları |

Ürün kategorileri sidebar'dan kaldırılıp Ayarlar > Tanımlar altına taşınması hedeflenir (henüz uygulanmadı).

### Raporlar

Sidebar'da **yalnızca tek bir "Raporlar" menü öğesi** bulunur. `/panel/reports` uzun vadede Rapor Merkezi yaklaşımına dönüşür.

- Ödeme, randevu, muayene, aşı raporları ayrı sidebar öğeleri **değildir**.
- Rapor erişimi Rapor Merkezi iç navigasyonu (kategori, kart, sekme) ile sağlanır.
- Teknik route'lar korunabilir.

Detay: [ADR-003](../decisions/ADR-003-report-center.md)

### Ayarlar

Klinik ve hesap yapılandırması.

| Alt alan | İçerik |
|---|---|
| Hesap ayarları | Profil, şifre |
| Abonelik | Plan, trial, dönüşüm |
| Klinik yönetimi | Klinik bilgileri |
| **Tanımlar** (hedef) | Türler, ırklar, ürün kategorileri |
| Rol ve yetki | Operation claim matrisi |
| Üyeler ve davet | Ekip yönetimi |

Türler, ırklar ve ürün kategorilerinin Ayarlar > Tanımlar altında toplanması **kabul edilmiş hedeftir**; henüz uygulanmamıştır.

### Organizasyon yönetimi

Multi-tenant üst yapı; organizasyon, klinik ve üye yönetimi.

---

## Önerilen sidebar yapısı

Mevcut ve hedef sidebar organizasyonu:

```
Dashboard

Klinik Operasyonlar
  ├── Müşteriler
  ├── Hayvanlar
  ├── Randevular
  ├── Muayeneler
  ├── Tedaviler
  ├── Reçeteler
  ├── Laboratuvar
  ├── Aşılar
  ├── Yatışlar
  └── Ödemeler

Ürün ve Stok
  ├── Ürünler
  ├── Stok Durumu
  └── Stok Hareketleri

Raporlar

Ayarlar
  └── Tanımlar (hedef)
        ├── Türler
        ├── Irklar
        └── Ürün Kategorileri
```

**Sidebar'da olmayacaklar (hedef):**
- AI ana menüsü — AI gömülü yardımcıdır ([ADR-008](../decisions/ADR-008-embedded-ai-assistant.md))
- Ayrı rapor menü öğeleri — Rapor Merkezi ([ADR-003](../decisions/ADR-003-report-center.md))
- Türler, ırklar, ürün kategorileri — Tanımlar altında ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md))

---

## AI navigasyonu

AI ayrı bir sidebar menüsü **değildir**. AI yetenekleri ilgili ekranlarda (muayene notu, hasta geçmişi, taburcu talimatı) gömülü yardımcı olarak sunulur.

Detay: [AI stratejisi](../ai/ai-strategy.md)

---

## İlgili belgeler

- [UX ilkeleri](ux-principles.md)
- [Tasarım kararları](design-decisions.md)
- [ADR-004 — Navigasyon ve menü yaklaşımı](../decisions/ADR-004-navigation-and-menu-philosophy.md)
- [Feature backlog — UX maddeleri](../backlog/feature-backlog.md)
