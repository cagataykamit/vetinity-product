# 2026-11-24 (2. yayın) — Klinik sitesi: randevu kapalıyken girişte numara

**Canlıda:** Panel ve klinik sitesi `c872ba21` (`main-QN3NOVQT.js`). API ve portal değişmedi. Migration yok.

## Ne değişti

- Klinik online randevuyu kapattığında dört konseptin giriş bölümündeki birincil düğme "Hemen ara" yerine "Ara · +90 … " yazar (kullanıcı kararı). Metin kuralı tek bileşende (`site-call`); alt şerit ve alt sayfalardaki arama düğmeleri de aynı bileşeni kullanır. 360 px'ten dar ekranda yalnız numara. Randevu açıkken değişiklik yok; numara yoksa düğme çizilmez.

## Testler

- Panel 499 dosya / 4008; portal 279; site 43. `vetinity-web` ve `site` derlemeleri başarılı.
- Görüntüler (örnek veri, dört konsept × 375/1280) kullanıcıya gösterildi ve onaylandı.

## Doğrulama

- `vetinity-site` aktif, hata yok; panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı; www, `/veteriner`, portal 200. Geri alma: `web-eski`, `site-eski`.

## Açık

- Üst çubuktaki ve hizmet ayrıntısındaki arama düğmesi hâlâ "Hemen ara".
