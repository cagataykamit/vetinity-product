# 2026-11-21 — Gecikmiş aşı: yalnız son 1 ay

**Canlıda:** API `a7d548e0` (15:14), panel `f8fb7ec5` (`main-7E3HAMKE.js`, 15:15). Migration ve seed yok.

## Ne değişti

- Gecikmiş aşı, vadesinden sonraki **1 takvim ayı** boyunca gecikmiş görünür. Bu süreden eski vadeler gecikmiş listesinde, takvimde, Rapor Merkezi sayacında, hasta kartındaki "Yapılacaklar"da, hasta özetinde, sahip portalında ve AI aramasında artık gösterilmez.
- Kural tek yerde tanımlı: `VaccinationDueRule`. Kayıtlara dokunulmadı; eski aşılar aşı listesinde durumlarıyla görünmeye devam eder.
- Hatırlatmalar değişmedi; sistem zaten yalnız vadeden önce hatırlatır.
- Panelde yalnız metinler değişti: gecikmiş listesi açıklaması ve Rapor Merkezi metni.

## Testler

- Backend Application, ilgili filtre: 536/536.
- Backend Integration (aşı, açık işler, portal, Rapor Merkezi): 160/160.
- Panel tam takım: 470 dosya, 3738/3738.

## Doğrulama

- `vetinity-api` aktif; `/health/ready` 200; logda yalnız bilinen "https port" uyarısı var.
- Paneldeki `main-*.js` ve `ngsw.json` zaman damgası yerel derlemeyle aynı; `ngsw.json` `no-cache`; www 200.
- Geri alma: sunucuda `api-eski` (`e667628d`) ve `web-eski` (`dd8ad7e2`) saklı.

## Doğrulanmayanlar

- Takvim ve gecikmiş listesi canlıda girişle denenmedi.

Not: `2026-11-21-vital-olcumu-ekrani.md` "yayın bekliyor" diyor. Vital ekranı (`dd8ad7e2`) 14:55'te canlıya çıktı.
