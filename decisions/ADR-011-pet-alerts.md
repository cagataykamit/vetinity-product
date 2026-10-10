# ADR-011 — Hayvan uyarıları (alerji, agresiflik, kronik hastalık, anestezi riski)

## Durum

Kabul edildi (2026-10-10, kullanıcı kararı: "en iyisini yap"). Ürün canlıda değil, gerçek veri yok.

## Bağlam

Hekim ve resepsiyon, hastanın kritik uyarılarını (alerji, agresiflik, kronik hastalık) muayene öncesi görmek ister ([CHECKIN-013](../backlog/feature-backlog.md), [ADR-005](ADR-005-modern-examination-experience.md) hasta bağlamı). Backend doğrulaması: sistemde yapılandırılmış uyarı alanı yok; tek mevcut alan serbest metin `Pet.Notes` (2000 karakter), bunu rozete çevirmek güvenilir değildir.

## Karar

Hayvana yapılandırılmış uyarılar eklenir:

- `Pet.AlertFlags`: bayrak kümesi `Allergy`, `Aggressive`, `ChronicCondition`, `AnesthesiaRisk`.
- `Pet.AlertNote`: tek kısa serbest not (en çok 200 karakter, ör. alerjinin ne olduğu); bayrak olmadan dolu not geçersizdir.
- Kural `Pet.ApplyAlerts` içinde tek yerde. `POST/PUT /pets` opsiyonel `alertFlags` ve `alertNote` alır; `null` veya hiç gönderilmemesi "dokunma", `[]` temizler (eski istemci hastanın kritik uyarısını sessizce silmesin).
- Okuma: `GET /pets/{id}` ve `GET /visits/today` satırlarında `petAlerts { flags, note }` (hiçbir zaman null değil). Muayene hasta bağlamı aynı uçtan alır.
- Eski kayıtlar "uyarı yok".

Bayrak listesi bilerek kısa tutuldu; yeni bayrak eklemek geriye uyumlu bir genişlemedir. `AnesthesiaRisk` klinik güvenlik için eklendi (backend ajanı önerisi; kullanıcıya açık: gereksizse kaldırılır).

## Değerlendirilen alternatifler

| Alternatif | Sonuç |
|---|---|
| `Notes` serbest metninden rozet çıkarmak | Reddedildi: güvenilir değil, klinik güvenlik için yapılandırılmış veri gerekir |
| Çok sayıda ayrıntılı alanlar (alerji listesi, ilaç, doz) | Reddedildi: ilk sürüm için aşırı; ihtiyaç doğarsa ayrı iş |
| Uyarıyı müşteri düzeyinde tutmak | Reddedildi: uyarılar hayvana özgü |

## Olumlu sonuçlar

- Hekim, muayeneye girmeden kritik uyarıları görür; resepsiyon aynı bilgiyi Bugün'de görür.
- Kısmi güncelleme semantiği uyarıları kazara silmeyi önler.

## Riskler ve olumsuz sonuçlar

- Hayvan liste ucu (`GET /pets`) ve Query DB read modeli bu işte değişmedi; read model bayrakları açılmadan önce ayrıca ele alınmalı.
- Hızlı kayıt (`quick-register`) uyarı almıyor; uyarılar sonradan hayvan düzenlemeyle eklenir.

## İlgili belgeler

- [CHECKIN-013](../backlog/feature-backlog.md)
- [ADR-005 — Modern muayene deneyimi](ADR-005-modern-examination-experience.md)
- Backend sözleşmesi: `docs/PET_ALERTS_API_CONTRACT.md` (backend deposu)
