# Product Research

Bu klasör, Vetinity'nin uzun vadeli **ürün araştırma merkezidir**. Rakip gözlemleri, tekil fikirler ve tekrar eden tasarım kalıpları burada tutulur.

> **Önemli:** Bu klasördeki belgeler backlog, roadmap veya ADR değildir. Hiçbiri geliştirme kararı anlamına gelmez.

---

## Belgeler

| Belge | Amaç |
|---|---|
| [ideas.md](ideas.md) | Tekil ürün fikirleri — rakip araştırmalarından çıkan, henüz backlog'a alınmamış aday fikirler |
| [patterns.md](patterns.md) | Tekrar eden ürün tasarım kalıpları — birden fazla rakipte görülebilen, Vetinity tarafından kullanılabilir veya kullanılmayabilir yapılar |
| [tanitim-sitesi-analizi-2026-10.md](tanitim-sitesi-analizi-2026-10.md) | Tanıtım sitesi (www) analizi: bulgular, doğrulanmış iddia tablosu, rakip vaatleri; öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md), ADR-034 taslak |
| [hbs-ve-e-belge-kesfi-2026-10.md](hbs-ve-e-belge-kesfi-2026-10.md) | HBS (e-Reçete, ATS aşı kaydı, kimliklendirme) ve e-belge (e-SMM / e-Arşiv / e-Fatura) keşfi: yükümlülükler, entegrasyon yolları, doğrulanan/doğrulanmayan tablosu; ADR-036 taslak |
| [sistem-kataloglari-kaynak-arastirmasi-2026-11.md](sistem-kataloglari-kaynak-arastirmasi-2026-11.md) | Sistem katalogları (tür, ırk, renk, aşı, şikâyet, tanı, şablon) için kaynak ve lisans araştırması: FCI/FIFe, HBS ruhsatlı aşılar, WSAVA, VeNom/SNOMED lisansı; 53 düzeltme, 228 ekleme önerisi; güncel tutma takvimi |

---

## Ideas vs Patterns

| | Ideas | Patterns |
|---|---|---|
| **Odak** | Tek bir somut fikir veya özellik adayı | Birden fazla rakipte görülen genelleştirilmiş tasarım kalıbı |
| **Kaynak** | Genellikle tek veya birkaç rakip | Birden fazla rakip veya tekrarlayan gözlem |
| **Sonraki adım** | Problem, değer, kapsam değerlendirmesi → backlog adayı | Kalıbın Vetinity bağlamında uygunluğu değerlendirmesi → ilgili idea veya backlog adayı |

---

## Araştırma akışı

Rakip analizi tamamlandığında çıkarımlar önce bu klasöre kaydedilir; backlog'a geçiş [WORKFLOW.md](../WORKFLOW.md) sürecine tabidir.

```
Rakip gözlemi
  → competitors/ analiz belgesi
  → research/ideas.md (tekil fikirler)
  → research/patterns.md (tekrar eden kalıplar)
  → (değerlendirme sonrası) backlog / ADR / roadmap
```

Detaylı rakip araştırma adımları: [competitors/README.md](../competitors/README.md#araştırma-süreci)

---

## İlgili belgeler

- [Ürün geliştirme akışı](../WORKFLOW.md)
- [Rakip analizleri](../competitors/README.md)
- [Feature backlog](../backlog/feature-backlog.md)
