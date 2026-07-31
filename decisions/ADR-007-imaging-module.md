# ADR-007 — Imaging / Görüntüleme modülü

## Durum

Kabul edildi

## Bağlam

Veteriner kliniklerinde röntgen, ultrason, CT, MR ve diğer görüntüleme kayıtları önemli klinik verilerdir. Röntgen özelliği yalnızca genel bir dosya yükleme alanı olarak düşünülmemelidir; klinik bağlamı (hayvan, muayene, tarih, tür) taşımalıdır.

Dijital röntgen ve laboratuvar cihazı entegrasyonları temel dosya yönetimiyle aynı özellik olarak ele alınmamalıdır; bunlar ayrı ve daha ileri entegrasyon seviyesidir.

## Karar

1. Uzun vadeli ürün alanı: **Imaging / Görüntüleme** modülü.
2. Desteklenebilecek içerik türleri:
   - Röntgen, ultrason, CT, MR, endoskopi, klinik fotoğraf, video, DICOM
3. Görüntüleme kayıtları:
   - **Hayvana bağlı** olmalı
   - İlgili **muayene veya klinik kayıtla ilişkilendirilebilmeli**
   - **Hasta timeline'ında** görüntülenebilmeli ([ADR-006](ADR-006-patient-timeline.md))
   - Açıklama, tarih, görüntü türü ve klinik not taşıyabilmeli
4. Cihazdan otomatik veri alma **ayrı ve daha ileri bir entegrasyon seviyesidir** ([INT-002](../backlog/feature-backlog.md), [IMG-006](../backlog/feature-backlog.md)).

## Gerekçe

- Görüntüleme klinik karar sürecinin parçasıdır
- Genel dosya yükleme klinik bağlamı kaybeder
- Timeline entegrasyonu hasta hikâyesinin bütünlüğünü sağlar
- Cihaz entegrasyonu ayrı seviye olarak değerlendirilmeli (maliyet, karmaşıklık)

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Yalnızca genel dosya yükleme | Klinik bağlam yok; timeline entegrasyonu zor |
| Yalnızca röntgen sayfası | Ultrason, CT, MR vb. kapsanmaz |
| Cihaz entegrasyonu olmadan modül açmama | Manuel yükleme temel ihtiyaç; cihaz entegrasyonu sonra gelir |
| DICOM'u ilk günden zorunlu kılma | DICOM araştırma aşamasında ([IMG-005](../backlog/feature-backlog.md)) |

## Olumlu sonuçlar

- Yapılandırılmış görüntüleme arşivi
- Muayene ve timeline ile entegre klinik bağlam
- Gelecekte cihaz entegrasyonu için altyapı
- Profesyonel klinik deneyim

## Riskler ve olumsuz sonuçlar

- Büyük dosya depolama maliyeti
- DICOM desteği teknik olarak karmaşık
- Cihaz entegrasyonu partner ve protokol bağımlılığı
- Görüntüleme modülü olmadan muayene-görüntüleme bağlantısı eksik kalır

## Uygulama etkileri

- Görüntüleme kayıtları modülü ([IMG-001](../backlog/feature-backlog.md))
- Röntgen, ultrason, klinik fotoğraf/video ([IMG-002](../backlog/feature-backlog.md)–[IMG-004](../backlog/feature-backlog.md))
- Muayene ve timeline bağlantıları ([IMG-007](../backlog/feature-backlog.md), [IMG-008](../backlog/feature-backlog.md))
- DICOM ve cihaz entegrasyonu araştırması ([IMG-005](../backlog/feature-backlog.md), [IMG-006](../backlog/feature-backlog.md))

## İlgili belgeler

- [ADR-006 — Hasta timeline](ADR-006-patient-timeline.md)
- [ADR-005 — Modern muayene deneyimi](ADR-005-modern-examination-experience.md)
- [Feature backlog — IMG maddeleri](../backlog/feature-backlog.md)
- [Roadmap P1](../roadmap/roadmap.md#p1--premium-klinik-deneyimi)
