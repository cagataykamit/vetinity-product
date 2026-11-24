# 2026-11-24 — Klinik sitesi: dört tasarım geri geldi

**Canlıda (sabah):**
- Panel ve klinik sitesi `b71bcc55` (`main-Y7WFL47T.js`).
- API ve portal değişmedi.

**Veritabanı:** Migration ve seed yok. Kayıtlı site verisinin biçimi değişmedi.

## Ne değişti

23 Kasım yayınındaki K-01, dört konsepti tek düzene indirmişti; bu yapı kararı kullanıcıya ayrıca onaylatılmadan uygulanmıştı. Kullanıcı kararı: "O tasarımları kendi içlerinde düzelteceğiz. Hepsini tek görünüm yapmayacağız."

- **Modern, Zarif, Samimi, Doğal** kendi bölüm düzenleriyle geri geldi (K-01 öncesi `37e7c2fb`, W-02 ve W-04 dahil). Panelde konsept ve bölüm alternatifi seçimi geri geldi.
- K-01 düzeltmeleri her konseptin kendi dilinde: klinik adı yazı işareti ("M" kare yok), normal boyda tıklanır telefon, çizim harita yerine "Haritada aç", konsepte uygun birincil + ikincil düğmeler (altı çizili metin düğme yok), telefonda altta "Ara · Randevu al" şeridi (randevu kapalıysa "Ara · numara"), üst çubukta en çok beş bağlantı ve "Diğer", saatlerde "Bugün" ve "24 saat açık".
- Geriye uyum: K-01 öncesi ve sonrası kaydedilmiş site verisi bozulmadan çizilir (spec).

## Testler (birleşik main)

- Panel 499 dosya / 4004; portal 279; site 43. `vetinity-web` ve `site` derlemeleri başarılı.
- Görsel denetim (ajan, sahte veri): dört konsept × 375/1280 × randevu açık/kapalı × logo var/yok, 11 alt sayfa; 146 sayfa, 0 sorun. Karşılaştırma kullanıcıya gösterildi ve onaylandı.

## Doğrulama

- `vetinity-site` aktif, günlükte hata yok. Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı. www, `/veteriner`, portal 200; bilinmeyen site 404.
- Geri alma: `web-eski`, `site-eski` sunucuda.

## Doğrulanmayanlar

- Canlıda yayınlanmış klinik sitesi şu an yok; gerçek bir sitede görülmedi.
- Paneldeki site oluşturucu tarayıcıda açılmadı (spec ve derleme geçti).
- Açık soru: randevu kapalıyken giriş bölümünde "Hemen ara" yerine numara gösterilsin mi.
