# Cloudflare Turnstile kurulumu (bot koruması)

Deneme kaydında e-posta kodu isteği, hasta sahibi portalında giriş kodu ve parola sıfırlama kodu, online randevu sayfasında e-posta kodu isteği Cloudflare Turnstile ile korunur ([TRIAL-001](../backlog/feature-backlog.md); backend `docs/TRIAL_SIGNUP_ABUSE_API_CONTRACT.md` §4). Turnstile ücretsizdir, bulmaca göstermez; yalnız gerektiğinde onay kutusu çıkar.

Anahtarlar girilene kadar Turnstile atlanır: sitede widget görünmez, yalnız hız sınırları ve e-posta kodu / tek deneme kuralları çalışır (API başlarken günlüğe uyarı yazılır). Anahtarlar girilip API yeniden başlatılınca başka değişiklik olmadan devreye girer.

Kaynak: developers.cloudflare.com/turnstile (2026-11-15 okundu).

## Yapılacaklar

1. **Ücretsiz Cloudflare hesabı** açın (dash.cloudflare.com). Alan adının Cloudflare'e taşınması **gerekmez**; Turnstile her sitede çalışır.
2. Panoda **Turnstile** sayfası → **Add widget**:
   - Widget name: `Vetinity`
   - Hostname: `vetinity.com` (tek kayıt www, panel, portal ve api alt alan adlarını kapsar; ücretsiz planda widget başına en çok 10 alan adı). `localhost` eklemeyin; yerel geliştirmede anahtar gerekmez.
   - Widget mode: **Managed** (önerilen).
   - Pre-clearance: kapalı.
3. **Create** → **Site key** ve **Secret key** görünür. Secret key'i kimseyle paylaşmayın, sohbete ve depoya yazmayın.
4. **Sunucuya ayarlar** (ortam değişkeni):

   ```
   Turnstile__SiteKey=<site key>
   Turnstile__SecretKey=<secret key>
   ```

   `Turnstile:ExpectedHostname` üretim ayarında `vetinity.com` olarak hazır. Panel, site ve portal site anahtarını sunucudan okur; ön yüzü yeniden derlemek gerekmez. Ardından API yeniden başlatılır; günlükte "Cloudflare Turnstile insan doğrulaması etkin" satırı görünür.
5. **İlk deneme:** `panel.vetinity.com/auth/signup` sayfasında e-posta girip "Kod gönder"; ardından portal girişinde "Kod gönder". Hata olursa API günlüğünde `Turnstile` satırlarına bakılır (`invalid-input-secret` = gizli anahtar yanlış).

## Notlar

- Mağaza uygulaması (portalın Capacitor paketi) içinde Turnstile **denenmedi**. Uygulamada giriş kodu çalışmazsa sunucuda `Turnstile__EnforcePortal=false` ile portal giriş, parola sıfırlama ve online randevu kodundaki doğrulama kapatılır (hız sınırları sürer); deneme kaydı korunmaya devam eder.
- Turnstile güvenlik amacıyla IP adresi ve tarayıcı/cihaz bilgisi gibi teknik sinyaller işler; Gizlilik Politikası 1.1 ve Portal Gizlilik Politikası 1.1'e eklendi. Cloudflare ABD şirketidir: yurt dışına aktarım mekanizması (Kanun m.9) metindeki yer tutucu satırda tamamlanmalı.
- Sayfalarda içerik güvenliği politikası (CSP) eklenirse `script-src` ve `frame-src` için `https://challenges.cloudflare.com` izinli olmalı.
