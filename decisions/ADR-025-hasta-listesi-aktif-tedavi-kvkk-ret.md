# ADR-025 — Hasta listesi varsayılanı, "aktif tedavi" tanımı, protokol numarası, KVKK Ret ve hatırlatma

## Durum

**Kabul edildi (2026-10-16, kullanıcı kararı; dört soruda önerilen seçenekler seçildi).** [ADR-021](ADR-021-kvkk-consent-form.md) madde 4'ü değiştirir.

## Kararlar

1. **Hasta listesi varsayılanı = "Yaşayanlar".** Vefat eden hastalar varsayılan listede görünmez; süzgeçte "Tümü" ve "Vefat edenler" seçilebilir. Gerekçe: günlük kullanımda liste sade kalır, vefat edene bildirim/hatırlatma gitmez ([ADR-022](ADR-022-terminology-hasta.md) ile aynı dil).
2. **"Aktif tedavi" = takip tarihi bugün veya sonrası olan tedavi.** Elle kapatma gerekmez; takip tarihi geçince tedavi kendiliğinden aktiflikten düşer. Pano ve hasta özeti sayaçları bu tanımı kullanır; tanım tek yerde (backend) yaşar. Takip tarihi olmayan tedavi aktif sayılmaz. (Kesinleştir düğmesinin kontrol listesine konması ayrı, hâlâ açık.)
3. **Protokol/dosya numarası: şimdilik YOK.** Pilot klinikte veterinerler isterse yeniden değerlendirilir (backlog'a not).
4. **KVKK Ret → hatırlatma otomatik kapanır.** Müşteri kartında KVKK durumu "Ret" işaretlenince "hatırlatma istemiyor" bayrağı (`RemindersOptedOut`) açılır. Kabul'e geçilince bayrak kendiliğinden kapanmaz; elle açılır/kapanır (yanlışlıkla hatırlatma gitmemesi için güvenli taraf). Hukuki görüş (HUKUKI-ONAY-LISTESI A4) gelince gözden geçirilir.

## Sonuçlar

- Frontend: hasta listesi varsayılan süzgeci; Ret ile bayrak değişiminin arayüzde yansıması.
- Backend: "aktif tedavi" tanımı ve sayaç; `SetClientKvkkConsent` Ret'te bayrağı açar (denetim izi); gerekiyorsa sözleşme belgeleri.
- Belgeler: ADR-021 madde 4 notu, HUKUKI-ONAY-LISTESI A4 satırı.
