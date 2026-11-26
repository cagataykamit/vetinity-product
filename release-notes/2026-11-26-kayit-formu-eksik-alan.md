# 2026-11-26 — Deneme kaydı: eksik alanlar ve onay kutusu; robot kontrolü geçici kapalı

**Canlıda:** Panel ve tanıtım `b071ce53` (`main-6GSSXSVG.js`). API kodu, portal ve klinik sitesi değişmedi. Migration yok.

## Ne değişti

- **Robot kontrolü geçici kapalı (2026-11-25, kullanıcı kararı):** Deneme kaydında e-posta kodu isteği 503 dönüyordu; Cloudflare Turnstile doğrulaması HTTP 400 veriyordu (Cloudflare bunu geçersiz gizli anahtarda verir; anahtarın kendisi görülmedi). Anahtar 15 Kasım'dan beri girili, o günden bu yana kayıt denenmemişti. Sunucu ayarında `Turnstile__` satırları `#GECICI-KAPALI-20261125` ile kapatıldı (yedek: `api.env.turnstile-yedek-20261125`), API yeniden başlatıldı; kod isteği 200. Hız sınırları ve e-posta kodu kuralları çalışıyor.
- **Onay kutusu:** Hukuki metin bağlantıları tanıtımın 44 px bağlantı yüksekliğini alıyordu; satırlar açılıp kutu metinden ayrılıyordu. Bağlantılar satır içinde, kutu ilk satırla hizalı (kayıt ve davet kabul sayfaları).
- **Eksik alanlar:** Boş gönderimde uyarı eksik alanları adlarıyla sayar ("Doldurulmamış alanlar: …"); sayfa ilk eksik alana kayıp odaklanır (paneldeki O3 davranışı). Zorunlu vergi numarası ve doğrulanmamış e-posta da bu listede ve alanın altında kırmızı uyarıyla gösterilir; önceden ayrıca ve sonradan denetleniyordu.

## Testler

- Panel 499 dosya / 4010. `vetinity-web` derlemesi başarılı.
- Kullanıcı yerelde gördü ve onayladı.

## Doğrulama

- Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı; panel kayıt sayfası, www, `/paketler` 200.
- Canlı kayıt sayfasında boş gönderim: sekiz eksik alan sayıldı, vergi numarası altında uyarı var, onay metni iki satır (42 px).
- Geri alma: `web-eski`.

## Açık

- Doğru Turnstile gizli anahtarı girilip satırlar açılacak (kullanıcı); kodda Cloudflare'in 400 yanıtındaki hata kodları günlüğe yazılmıyor.
- Gerçek bir deneme hesabı canlıda baştan sona açılmadı.
