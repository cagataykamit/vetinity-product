# ADR-010 — Randevu "Gelmedi" (NoShow) durumu

## Durum

Kabul edildi (2026-10-10, kullanıcı kararı). Ürün canlıda değil ve gerçek müşteri verisi yok; geriye dönük veri taşıma ve rapor uyumu kısıtı yoktur.

## Bağlam

Randevu durumları `Scheduled / Completed / Cancelled`; `NoShow` bilinçli kaldırılmıştı. Randevusuna gelmeyen hasta bugün Bugün'de ve dashboard "gecikmiş planlı" uyarısında süresiz "Planlı" kalıyor, raporlanabilir bir "gelmedi" bilgisi yok ([CHECKIN-010](../backlog/feature-backlog.md)). Backend ajanı kod keşfiyle beş seçenek değerlendirdi (tasarım belgesi backend deposunda `docs/CHECKIN-010-NOSHOW-DESIGN.md`).

## Karar

Randevuya **`NoShow` sonuç durumu** eklenir (`Scheduled → NoShow`; `Completed` ve `Cancelled` gibi sonuç durumudur). "Gelmedi" bilgisi tek yerde, randevu durumunda tutulur; rapor, dashboard, takvim, hatırlatma, slot kuralı, Query DB projeksiyonları ve Bugün aynı alandan okur.

- Yalnızca `Scheduled` ve saati geçmiş randevu "gelmedi" işaretlenebilir.
- İşaretleme elle yapılır; otomatik "gün sonu gelmedi" yoktur.
- Geç gelen hasta davranışı ve yetki seçimi uygulama planında netleşir (varsayılan: işaretli randevuya geliş açılırsa işaret geri alınır, geliş engellenmez).
- `PUT /appointments/{id}` durum bypass bulgusu aynı değişiklikte ele alınır.

## Değerlendirilen alternatifler

| Alternatif | Sonuç |
|---|---|
| Ayrı `AppointmentNoShow` kaydı (ilk öneri) | Reddedildi: her tüketici ikinci kaynağa ayrıca bakmak zorunda, biri unutulursa tutarsızlık; canlı veri olmadığı için tek kaynak maliyeti düşük |
| Visit'te `NoShow` bakım durumu | Reddedildi: Visit gerçek geliştir; gelmeyen hasta için sahte geliş zamanı ve indeks çakışmaları |
| Randevu nullable işaret alanı | Reddedildi: durum `Scheduled` kalır, her tüketici işareti ayrıca dışlamalı |
| Randevu notuna metin | Reddedildi: raporlanamaz |

## Olumlu sonuçlar

- Tek doğruluk kaynağı; sonradan ekranlar arası tutarsızlık riski düşük.
- Randevu sonuçları (tamamlandı, iptal, gelmedi) tek modelde.

## Riskler ve olumsuz sonuçlar

- Rapor toplamı, dashboard, takvim, hatırlatma, Query DB projeksiyonları/rebuild, Excel/CSV, DTO enum'ları ve randevu yazma kuralları birlikte değişir; eksik bırakılırsa rapor sessizce yanlış toplar. Çözüm: tüm tüketiciler testlerle tek değişiklikte kapsanır.
- Eski `NoShow` kalıntı enum değeriyle çakışma riski; uygulama planında doğrulanır.

## İlgili belgeler

- [ADR-009 — Visit modeli ve geliş akışı](ADR-009-visit-model-and-arrival-flow.md)
- [CHECKIN-010](../backlog/feature-backlog.md)
- [Ajan kuyruğu](../roadmap/AJAN-KUYRUGU.md)
