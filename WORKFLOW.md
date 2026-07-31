# Vetinity Ürün Geliştirme Akışı

Bu belge, Vetinity'de yeni ürün fikirleri ve büyük ürün değişikliklerinin nasıl ele alınacağını tanımlayan **zorunlu çalışma sürecidir**.

> **Kesin kural:** Vetinity'de yeni bir ürün fikri veya büyük ürün değişikliği doğrudan kodlanmaz.

---

## Repository ayrımı

| Repository | Rol |
|---|---|
| **vetinity-product** (bu repo) | Neyi ve neden yaptığımızın kaynağı |
| **vetinity-web** (frontend) | Nasıl uyguladığımızın kaynağı (UI, entegrasyon) |
| **Backend repository** | Nasıl uyguladığımızın kaynağı (mimari, API, deploy) |

Ürün kararlarının ana kopyası yalnızca bu repository'de tutulur. Frontend ve backend repository'lerinde ürün kararlarının ikinci bir ana kopyası oluşturulmaz.

---

## Standart akış

Her yeni ürün fikri veya büyük değişiklik aşağıdaki sırayı izler:

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

### Adım rehberi

| Adım | Ne yapılır | Nereye yazılır |
|---|---|---|
| 1. Problem | Hangi kullanıcı problemi çözülüyor? Değer nedir? | [backlog/feature-backlog.md](backlog/feature-backlog.md) |
| 2. Rakip analizi | Rakip özelliği mi ilham veriyor? Problem odaklı incele | [competitors/](competitors/README.md) |
| 3. Backlog | Maddeleri kimlik, öncelik ve durumla kaydet | [backlog/feature-backlog.md](backlog/feature-backlog.md) |
| 4. ADR | Stratejik, geri dönüşü maliyetli veya çok alanlı karar | [decisions/](decisions/) |
| 5. Roadmap | Önceliklendirilmiş hedefe taşı (P0–P4) | [roadmap/roadmap.md](roadmap/roadmap.md) |
| 6. UX / teknik kapsam | UX ilkeleri, navigasyon; teknik tasarım kod repo'larında | [ux/](ux/ux-principles.md), frontend/backend `docs/` |
| 7. Geliştirme | Uygulama kod repo'larında | vetinity-web, backend |
| 8. Doğrulama | Kabul kriterleri, kullanıcı testi | — |
| 9. Belge güncelleme | Durum, release notu | backlog, roadmap, [release-notes/](release-notes/README.md) |

---

## Doğrudan kodlanabilecek küçük işler

Aşağıdaki işler product workflow'a tabi **değildir**; kod repository'lerinde doğrudan yapılabilir:

- Bug düzeltmeleri
- Yazım ve basit görünüm hataları
- Küçük erişilebilirlik iyileştirmeleri
- Mevcut ve kabul edilmiş tasarımın tamamlanması
- Davranışı değiştirmeyen teknik bakım

Bu işler için backlog veya ADR oluşturulması **gerekmez**.

---

## Önce product repository'ye alınması gereken işler

Aşağıdaki iş türlerinde geliştirmeye **başlanmadan önce** bu repository'de karar ve kapsam oluşturulmalıdır:

- Yeni modül
- Yeni ana ekran
- Menü veya navigasyon değişikliği
- Kullanıcı akışını değiştiren özellik
- Trial, abonelik veya fiyatlandırma politikası
- AI özelliği
- Harici entegrasyon
- Klinik veri modelini etkileyen ürün kararı
- Rakipten alınması düşünülen özellik
- Birden fazla modülü etkileyen büyük UX kararı

Bu işler için en az **backlog maddesi** gerekir. Stratejik kararlarda **ADR** de oluşturulmalıdır.

---

## Temel kurallar

### Backlog ve roadmap

- **Her fikir roadmap'e girmez;** önce backlog'a alınır.
- Backlog tüm fikirleri ve detayları tutar; roadmap önceliklendirilmiş hedefleri gösterir.

### ADR

- **Her küçük değişiklik ADR gerektirmez.**
- ADR; stratejik, geri dönüşü maliyetli veya birçok alanı etkileyen kararlar içindir.

### Rakip analizi

- **Rakip özelliği doğrudan kopyalanmaz;** çözdüğü problem analiz edilir.
- Vetinity'nin kendi UX ve iş akışı felsefesiyle ele alınır.

### Geliştirme sonrası

- **Geliştirme tamamlandığında** ilgili ürün belgeleri (backlog durumu, roadmap, release notu) güncellenmeden iş tamamen kapanmış sayılmaz.

### Belge tutarlılığı

- Kod ile belge çelişirse gerçek uygulama durumu doğrulanır ve belge güncellenir.
- Geçersiz hale gelen kararlar sessizce silinmez; durum ve gerekçe ile güncellenir.
- Ürün dokümanları teknik dokümanların kopyası haline gelmez.

---

## İş kapanış kontrol listesi

Geliştirme tamamlandığında:

- [ ] [backlog/feature-backlog.md](backlog/feature-backlog.md) — ilgili maddelerin durumu güncellendi
- [ ] [roadmap/roadmap.md](roadmap/roadmap.md) — ilgili hedeflerin durumu güncellendi
- [ ] [release-notes/](release-notes/README.md) — kullanıcıya görünür değişiklik varsa sürüm notu oluşturuldu
- [ ] İlgili ADR — uygulama etkileri bölümüne not düşüldü (varsa)

---

## İlgili belgeler

- [README — Giriş](README.md)
- [Feature backlog](backlog/feature-backlog.md)
- [Roadmap](roadmap/roadmap.md)
- [Stratejik kararlar (ADR)](decisions/ADR-001-self-service-trial-strategy.md)
- [Rakip analizleri](competitors/README.md)
- [UX ilkeleri](ux/ux-principles.md)
