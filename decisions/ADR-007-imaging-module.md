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

## Uygulama notu (2026-10-22)

Kullanıcı kararı (2026-10-22): görüntüleme ve dosya katmanı yapılır; altyapı/VPS/yedek işi kullanıcı söyleyene kadar yapılmaz. Teknik sözleşme: backend `docs/IMAGING_API_CONTRACT.md` (tek doğruluk kaynağı). Durum: dal `feat/goruntuleme-dosya-katmani` (backend + frontend), main'e alınmadı, migration (`AddImagingRecordsAndStoredFiles`) hiçbir veritabanına uygulanmadı.

**Kapsam (v1):**
- Görüntüleme kaydı: hasta, isteğe bağlı muayene, tarih, tür (Röntgen, Ultrason, BT, MR, Endoskopi, Klinik fotoğraf, Diğer), açıklama, klinik not, dosyalar. Silme yok; gerekçeli iptal, iptalde dosyaların erişimi kapanır.
- Kesinleşmiş muayene (ADR-013 uyumu): kesinleşmiş muayeneye görüntüleme bağlamak yeni (ek) kayıt sayılır ve serbesttir ("kesinleştirmeden sonra eklendi" rozeti); muayene kesinleştiğinde var olan kayıt düzenlenemez ve dosya almaz.
- Lab sonucuna dosya (PDF/fotoğraf) eklenir; lab istem-sonuç akışı değişmez, lab iptalinde dosyaların erişimi kapanır.
- Hasta zaman çizelgesinde "Görüntüleme" olayı (yalnız başlık, küçük resim yok); hasta kartında son görüntülemeler; muayene çalışma alanında ve hasta eylem çubuğunda "Görüntüleme" ekleme kısayolu; menüde Kayıtlar > Görüntüleme (ADR-023).
- İzinler: `Imaging.Read/Create/Update/Cancel`; yönetim ve Veteriner tam, Sekreter yalnız okur. Lab dosyası mevcut `LabResults.Read/Update` ile.

**Sınırlar:** Yalnız JPEG, PNG, WebP ve PDF (tür içerikten tespit edilir); dosya başına varsayılan 15 MB (yapılandırılabilir), kayıt başına 20 dosya. DICOM, video, büyük dosya, küçük resim üretimi, virüs taraması (yalnız arayüz yeri), fiziksel silme/saklama süresi ve cihaz entegrasyonu kapsam dışı ([IMG-004](../backlog/feature-backlog.md) videosu, [IMG-005](../backlog/feature-backlog.md), [IMG-006](../backlog/feature-backlog.md) açık).

**Depolama soyutlaması:** Dosyalar veritabanında değil, `IFileStorage` arkasında yerel diskte (kök dizin `FileStorage:RootPath` yapılandırmadır; kiracı/klinik/yıl-ay alt dizinleri, tahmin edilemez anahtar, orijinal ad yalnız meta tabloda). Buluta geçiş yeni bir depolama uygulaması ister, ürün akışı değişmez. Dosyalar statik adresle sunulmaz: yetkili akış ucu ve görüntüler için 5 dakikalık imzalı adres. Depolama konumu ve yedek ayarı yapılandırmadır; **dosyalar veritabanı yedeğine girmez**, disk yedeği dağıtım işiyle (ADR-014) kullanıcı tarafından planlanmalıdır.

## İlgili belgeler

- [ADR-006 — Hasta timeline](ADR-006-patient-timeline.md)
- [ADR-005 — Modern muayene deneyimi](ADR-005-modern-examination-experience.md)
- [Feature backlog — IMG maddeleri](../backlog/feature-backlog.md)
- [Roadmap P1](../roadmap/roadmap.md#p1--premium-klinik-deneyimi)
