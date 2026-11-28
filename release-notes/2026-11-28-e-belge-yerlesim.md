# 2026-11-28 — e-Belge entegratör kartı yerleşimi

**Canlıda:** Panel `69688b10` (`main-QNBSZJS7.js`). API, portal ve klinik sitesi değişmedi. Migration yok.

## Ne değişti

- **API anahtarı satırı:** "Bağla ve sına" düğmesi yalnız anahtar alanıyla hizalanır; açıklama satırın altına indi (önceden düğme açıklamanın hizasına kayıyordu).
- **Entegratör seçimi:** Açıklama seçim kutusunun dar genişliğine sıkışıp iki satıra kırılmıyor.
- **Boşluk:** Anahtarla bağlanan sağlayıcıda bağlı değilken boş işlem satırı çizilmiyor; seçim ile anahtar alanı arasındaki fazla boşluk kalktı.

## Testler

- Panel 499 dosya / 4010. `vetinity-web` derlemesi başarılı.
- Kullanıcı yerelde gördü ve onayladı.

## Doğrulama

- Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı; panel, e-Belge sayfası, www, `/paketler` yanıt veriyor.
- Geri alma: `web-eski`.
