# ADR-006 — Hasta timeline

## Durum

Kabul edildi

## Bağlam

Vetinity'de hasta (hayvan) geçmişi şu anda modüller arasında dağınıktır: randevu, muayene, laboratuvar, tedavi, reçete, aşı, yatış gibi kayıtlar ayrı ekranlarda tutulur. Veteriner hekim bir hayvanın tam klinik hikâyesini görmek için birden fazla modüle gitmek zorundadır.

Rakip analizi (DaySmart) hasta timeline'ının değerini doğrulamaktadır ([DaySmart analizi](../competitors/daysmart.md)).

## Karar

1. Hasta geçmişi uzun vadede **merkezi bir timeline görünümünde** birleştirilecektir.
2. Timeline aşağıdaki kayıtları kronolojik şekilde gösterebilir:
   - Randevu, muayene, laboratuvar, görüntüleme, tedavi, reçete, aşı, yatış, operasyon, kontrol ve klinik açıdan ilgili diğer kayıtlar
3. Timeline **ayrı ve tekrar eden bir veri deposu olmayacaktır**.
4. Timeline, **mevcut modül kayıtlarının birleştirilmiş görünümü** olarak tasarlanacaktır.
5. Her timeline olayı ilgili kaynağa **derin link** ile bağlanacaktır.

## Gerekçe

- Merkezi bağlam sağlar ([UX ilkeleri](../ux/ux-principles.md))
- Ayrı veri deposu veri tutarsızlığı riski taşır
- Mevcut kayıtların birleştirilmiş görünümü bakım maliyetini düşürür
- Derin linkler detay ekranlarına kesintisiz geçiş sağlar

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Timeline için ayrı veritabanı tablosu | Veri kopyası; senkronizasyon sorunu |
| Yalnızca muayene geçmişi | Eksik bağlam |
| Modül bazlı sekmeler (mevcut) | Kronolojik bütünlük yok |
| Dashboard widget olarak özet | Derinlemesine geçmiş için yetersiz |

## Olumlu sonuçlar

- Tek bakışta hasta hikâyesi
- Muayene öncesi hızlı hazırlık
- AI hasta geçmişi özeti için zengin bağlam ([AI-002](../backlog/feature-backlog.md))
- Modüller arası gezinme azalır

## Riskler ve olumsuz sonuçlar

- Çok kayıtlı hastalarda performans sorunu
- Farklı modül kayıt tiplerinin birleştirilmesi karmaşık olabilir
- Timeline olay modeli tüm modüllerle uyumlu olmalı

## Uygulama etkileri

- Hasta timeline geliştirilmeli ([TIMELINE-001](../backlog/feature-backlog.md))
- Timeline olay modeli tasarlanmalı ([TIMELINE-002](../backlog/feature-backlog.md))
- Filtreler ve derin linkler ([TIMELINE-003](../backlog/feature-backlog.md), [TIMELINE-004](../backlog/feature-backlog.md))
- Görüntüleme modülü timeline ile bağlanacak ([IMG-008](../backlog/feature-backlog.md))

## İlgili belgeler

- [DaySmart rakip analizi](../competitors/daysmart.md)
- [ADR-007 — Imaging modülü](ADR-007-imaging-module.md)
- [Feature backlog — TIMELINE maddeleri](../backlog/feature-backlog.md)
- [Roadmap P1](../roadmap/roadmap.md#p1--premium-klinik-deneyimi)
