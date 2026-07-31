# AI Roadmap

AI yeteneklerinin kademeli açılım planı. Güvenlik ilkeleri ve teknik yaklaşım [AI stratejisi](ai-strategy.md) belgesinde tanımlıdır. Stratejik karar: [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md).

> **Not:** Bu roadmap kesin teslimat taahhüdü içermez. Aşama 3 yüksek riskli araştırma alanıdır; üretim teslimatı sözü değildir.

---

## Aşama 1 — Düşük riskli klinik yardımcılar

**Durum:** Planlandı  
**Öncelik:** P1  
**Risk seviyesi:** Düşük

AI'nin ilk üretim yetenekleri. Tüm çıktılar taslak statüsünde; kullanıcı onayı zorunlu.

| Yetenek | Açıklama | Backlog |
|---|---|---|
| Muayene notunu yapılandırma | Serbest metni şikâyet, bulgu, değerlendirme, plan alanlarına yapılandır | [AI-001](../backlog/feature-backlog.md) |
| Hasta geçmişini özetleme | Kronolojik kayıtların kısa özeti | [AI-002](../backlog/feature-backlog.md) |
| Hasta sahibi açıklaması | Teknik nottan sade dilde açıklama taslağı | [AI-003](../backlog/feature-backlog.md) |
| Taburcu / evde bakım talimatı | Taburcu talimatı taslağı | [AI-004](../backlog/feature-backlog.md) |

### Aşama 1 altyapı gereksinimleri

- AI çıktı onay akışı ([AI-009](../backlog/feature-backlog.md))
- Kullanım kotası ([AI-007](../backlog/feature-backlog.md))
- Maliyet takibi ([AI-008](../backlog/feature-backlog.md))
- Audit metadata ([AI-010](../backlog/feature-backlog.md))
- Provider-independent backend (teknik detay backend repo'da)

### Aşama 1 kapsam dışı

- Otomatik kesin tanı
- Otomatik reçete
- Bağımsız doz kararı

---

## Aşama 2 — İş akışı ve arama

**Durum:** Planlandı / Araştırılacak  
**Öncelik:** P1–P2  
**Risk seviyesi:** Orta

Klinik verimliliğini artıran iş akışı destek yetenekleri.

| Yetenek | Açıklama | Durum | Backlog |
|---|---|---|---|
| Speech-to-text | Konuşmayı metne dönüştürme | Araştırılacak | [AI-005](../backlog/feature-backlog.md) |
| Doğal dilde hasta geçmişi arama | "Geçen ay antibiyotik alan kediler" gibi sorgular | Planlandı | [AI-006](../backlog/feature-backlog.md) |
| Rapor özetleme | Rapor verilerinin doğal dilde özeti | Planlandı | — |
| Klinik şablon önerileri | Muayene tipine göre şablon önerisi | Planlandı | [EXAM-006](../backlog/feature-backlog.md) |
| Kullanıcı kontrollü hatırlatma taslakları | Hatırlatma metni taslağı | Planlandı | — |

### Aşama 2 bağımlılıkları

- Aşama 1 altyapısının tamamlanması
- Hasta timeline temel görünümü ([TIMELINE-001](../backlog/feature-backlog.md)) — arama için
- Modern muayene çalışma alanı ([EXAM-001](../backlog/feature-backlog.md)) — speech-to-text için

---

## Aşama 3 — Yüksek riskli araştırma alanları

**Durum:** Araştırılacak  
**Öncelik:** P2+  
**Risk seviyesi:** Yüksek

> ⚠️ **Bu aşama kesin teslimat sözü değildir.** Yüksek klinik risk taşıyan alanların fizibilite, düzenleyici uyumluluk ve güvenlik değerlendirmesi gerektirir. Araştırma sonuçlarına göre roadmap güncellenir.

| Alan | Açıklama | Not |
|---|---|---|
| Kontrollü ayırıcı tanı desteği | Olası tanılar listesi (hekim onaylı) | Kesin tanı değil; destek aracı |
| Laboratuvar yorum desteği | Lab sonuçlarının bağlamsal yorumu | Yanlış yorum riski yüksek |
| Görüntüleme AI desteği | Röntgen/görüntü analizi | Düzenleyici ve doğruluk gereksinimleri |
| İlaç etkileşimi kontrolleri | İlaç-ilaç etkileşim uyarıları | Veri kaynağı güvenilirliği kritik |
| Doz güvenlik kontrolü | Doz aralığı uyarıları | Bağımsız doz kararı vermez; uyarı |

### Aşama 3 değerlendirme kriterleri

Her araştırma alanı için aşağıdakiler değerlendirilmeden üretime alınmaz:

1. Klinik doğruluk ve yanlış pozitif/negatif oranı
2. Hekim sorumluluğu ve onay akışının yeterliliği
3. Düzenleyici uyumluluk (Türkiye ve hedef pazarlar)
4. Tenant veri güvenliği ve izolasyon
5. Maliyet-fayda analizi
6. AI servisi başarısızlığında klinik akış etkisi (sıfır olmalı)

---

## Roadmap özeti

```
Aşama 1 (P1)     Düşük riskli yardımcılar     → Planlandı
Aşama 2 (P1-P2)  İş akışı ve arama            → Planlandı / Araştırılacak
Aşama 3 (P2+)    Yüksek riskli araştırma       → Araştırılacak (teslimat sözü yok)
```

---

## İlgili belgeler

- [AI stratejisi](ai-strategy.md)
- [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md)
- [Roadmap — P1 AI maddeleri](../roadmap/roadmap.md)
- [Feature backlog — AI maddeleri](../backlog/feature-backlog.md)
