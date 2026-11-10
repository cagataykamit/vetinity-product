# Vetinity canlı işletim kılavuzu

**Durum:** v1.0 (2026-11-11). Ürün 2026-11-10'dan beri canlıda. Staging yok (kullanıcı kararı 2026-11-10); yayınlar doğrudan canlıya yapılır. Kaynaklar: [ADR-014](../decisions/ADR-014-pilot-and-production-operations.md) (K1–K9), [ADR-033](../decisions/ADR-033-alan-adi-ve-adres-duzeni.md) (alan adı düzeni), backend `docs/deploy/*` ve `docs/cqrs/cqrs-11b-operations-runbook.md`.

## Bu belge nasıl okunur

- Bölüm 1, 5, 7 ve 9 **sunucunun bugünkü gerçek kurulumunu** yazar (2026-11-10 kurulumu, 2026-11-11 sunucudan okunarak doğrulandı). Diğer bölümler yöntem ve beklentidir.
- **[YAPILACAK]** = henüz kurulmamış veya kararlaştırılmamış. Boşluklar `<...>` ile işaretlidir.
- **[ÖNERİ]** = kullanıcı kararı bekleyen öneri (bölüm 12).
- Gizli bilgiler (parola, anahtar, bağlantı dizesi) bu belgeye **yazılmaz**; yalnız durdukları dosyanın yolu yazılır.
- Bu belge hukuki tavsiye değildir (bölüm 8).

## 1. Canlı ortam

### 1.1 Adresler

| Yüzey | Adres | Ne sunar |
|---|---|---|
| Tanıtım sitesi | `https://www.vetinity.com` | Angular SPA (`web`); `vetinity.com` → `www` 301. `/k/*` (klinik siteleri) ve `/veteriner*` (Veteriner bul) site Node sürecine gider |
| Klinik paneli | `https://panel.vetinity.com` | Aynı `web` paketi; `/` → `/panel` 302. Panel dışı yollar `www`'ye, `www`'deki `/panel`, `/auth`, `/join` yolları panele yönlenir (nginx + uygulama içi yüzey koruması) |
| Hasta sahibi portalı | `https://portal.vetinity.com` | Portal SPA; `/randevu/*` başka sitelere gömülebilir |
| API | `https://api.vetinity.com` | .NET 10 API (nginx → `127.0.0.1:5100`) |

Sertifikalar Let's Encrypt (certbot, webroot `/var/www/letsencrypt`), 2027-02-08'e kadar geçerli, kendiliğinden yenilenir. DNS Porkbun'da.

### 1.2 Sunucu

- Kullanıcının VPS'i: `185.149.103.114`, Ubuntu 22.04, 8 GB bellek, 150 GB disk (2026-11-11'de %15 dolu). SSH bağlantı noktası `3522`, anahtarla (`~/.ssh/vetinity_deploy`), `root`.
- **Aynı sunucuda başka bir site (Zonguldak) çalışır.** Onun veritabanına, dosyalarına ve nginx yapılandırmasına dokunulmaz. Sistem genelindeki .NET 9 onun içindir, kaldırılmaz/yükseltilmez. Sunucu genelinde bir değişiklik (paket kurma, SQL Server ayarı, nginx ana yapılandırması) önce kullanıcıya sorulur.
- Vetinity'nin çalışma zamanları ayrı klasördedir: .NET 10 `/opt/dotnet10`, Node 24 `/opt/node24`.

| Ne | Yer |
|---|---|
| Yayın klasörleri | `/var/www/vetinity/production/{web,portal,api,dbmigrator,site}`; bir önceki `web` sürümü `web-eski` |
| API servisi | `vetinity-api.service` (kullanıcı `vetinity`, `Restart=always`), ayarlar `EnvironmentFile=/etc/vetinity/production/api.env` |
| Site servisi | `vetinity-site.service` (Node SSR, `127.0.0.1:4400`), ayarları servis dosyasında (`SITE_*`) |
| nginx | `/etc/nginx/sites-available/vetinity-{http,api,www,panel,portal}` ve `/etc/nginx/snippets/vetinity-{guvenlik,site-proxy}.conf` |
| Yüklenen dosyalar | `/var/lib/vetinity/files` (`FileStorage__RootPath`) |
| Yedekler | `/var/backups/vetinity/gunluk/<gün>`; betik `/opt/vetinity/yedek.sh` (bölüm 9) |

### 1.3 Ayarlar ve gizli bilgiler

- API ayarları yalnız `api.env` ortam değişkenlerindedir (`root:vetinity`, 640; klasör 750). `appsettings.Production.json` yayına girmez. İçindeki anahtar adları: `ASPNETCORE_*`, `DOTNET_*`, `ConnectionStrings__DefaultConnection` / `__QueryConnection` (veritabanı girişi `vetinity_app`), `Jwt__*`, `AllowedHosts`, `AllowedOrigins__0..3` (panel, portal, www, apex), `App__BaseUrl`, `App__FrontendBaseUrl`, `OwnerPortal__PortalBaseUrl`, `Smtp__*` (Gmail, `vetinity.app@gmail.com`, uygulama şifresi), `DemoRequests__NotifyEmail`, `FileStorage__*`, `PetProjection__WriteEvents=false`, `PaymentProjection__WriteEvents=false`, `RefreshTokenCleanup__Enabled=true`, `Billing__*` (iyzico).
- Yalnız `root`'un okuyabildiği gizli dosyalar (içerikleri hiçbir yere yazılmaz, sohbete yapıştırılmaz): `/root/.vetinity-sa` (SQL `sa`), `/etc/vetinity/production/.db-pass` (`vetinity_app`), `/etc/vetinity/production/.smtp-pass`, `/root/.vetinity-gdrive-client` (Drive bağlantısı), `/root/VETINITY-YEDEK-SIFRESI.txt` (yedek şifreleme parolaları).
- Gizli değerleri sunucu dosyalarına **kullanıcı kendisi girer**; ajan parola yazmaz.

### 1.4 Veritabanı

- SQL Server 2022 aynı sunucuda (Zonguldak ile paylaşılır). `max server memory` 3072 MB (kullanıcı onayı 2026-11-10).
- Vetinity veritabanları: `VetinityCommandDb` (komut) ve `VetinityQueryDb` (sorgu). Uygulama yalnız `vetinity_app` girişiyle bağlanır; `sa` yalnız yedek doğrulaması ve bakım içindir.
- API açılışta migration çalıştırmaz. Şema değişikliği yalnız `DbMigrator` ile yapılır (bölüm 5.3).

## 2. Roller ve sorumluluklar

| Rol | Kim | Sorumluluk |
|---|---|---|
| Ürün sahibi / karar verici | `<ad>` (kullanıcı) | Önem derecesi onayı, müşteri iletişimi, geri alma kararı, KVKK danışmanıyla temas |
| Nöbetçi mühendis | `<ad>` **[YAPILACAK]** | Uyarıyı alır, ilk müdahaleyi yapar, durumu günceller |
| Pilot klinik irtibatı | `<ad, telefon>` **[YAPILACAK]** | Klinikte sorunu bildiren ve duyuruyu alan tek kişi |
| KVKK danışmanı / avukat | `<ad>` **[YAPILACAK]** (ADR-014 K3) | Kişisel veri ihlali değerlendirmesi |
| VPS sağlayıcısı | `<firma, destek kanalı>` **[YAPILACAK]** | Sunucu/ağ kesintileri; sunucu kaybında yeni makine |

Küçük ekipte bir kişi birden fazla rolü üstlenebilir; yine de her olay için **tek olay yöneticisi** adı yazılır.

## 3. Olay yönetimi

### 3.1 Önem dereceleri

| Derece | Tanım | Örnek | İlk müdahale hedefi **[ÖNERİ]** | Güncelleme sıklığı **[ÖNERİ]** |
|---|---|---|---|---|
| **S1 – Kritik** | Klinik çalışamıyor veya veri kaybı/yanlış veri riski var; ya da kişisel veri ihlali şüphesi | Giriş yapılamıyor, API tamamen kapalı, kayıtlar kayboluyor, başka klinik verisi görünüyor, bakiye tutarsız | Mesai içi 30 dk, mesai dışı 2 saat | 1 saatte bir |
| **S2 – Yüksek** | Önemli bir akış bozuk ama geçici çözüm var | Ödeme alınamıyor ama ücret girilebiliyor, rapor açılmıyor, yavaşlık dayanılmaz | Mesai içi 2 saat | 4 saatte bir |
| **S3 – Orta** | Tek ekran/özellik sorunlu, iş sürüyor | Bir filtre yanlış, bir buton çalışmıyor | Sonraki iş günü | Çözüm veya plan bildirilince |
| **S4 – Düşük** | Görsel/metin hatası, iyileştirme isteği | Yazım hatası, hizalama | Haftalık gözden geçirme | — |

Hedefler **[ÖNERİ]** olup kullanıcı onayı bekler (bölüm 12). Pilotta "mesai" saatleri klinikle birlikte yazılır: `<saatler>` **[YAPILACAK]**.

Kural: Şüphede kalınırsa bir üst derece seçilir; sonradan düşürmek serbesttir. **Kişisel veri sızıntısı şüphesi her zaman S1'dir** ve bölüm 8 akışı da başlar.

### 3.2 Müdahale akışı

1. **Algıla:** kliniğin bildirimi (bölüm 4) veya uyarı (bölüm 7).
2. **Kaydet:** olay kaydı açılır (başlık, saat, bildiren, derece, olay yöneticisi). Kayıt yeri **[YAPILACAK]** (örn. paylaşılan bir tablo/iş takip aracı).
3. **Sınıflandır:** önem derecesi atanır; S1 ise ürün sahibi hemen aranır.
4. **İlk tespit:** nedir, kimleri etkiliyor, veri etkisi var mı? Kanıtlar: günlükler, `traceId`/`correlationId` (hata yanıtlarında bulunur), `/health/ready`.
5. **Önlem:** önce zararı durdur (gerekirse etkilenen özelliği kapat, son sürümü geri al – bölüm 5). Veri değiştiren "düzeltme" betikleri yedek alınmadan çalıştırılmaz.
6. **İlet:** bölüm 3.3 şablonuyla kliniği bilgilendir; sıklık tabloya göre.
7. **Çöz ve doğrula:** düzeltme sonrası olayı bildiren akışla yeniden denenir; klinik onaylar.
8. **Kapat:** kapanış mesajı gönderilir; olay sonrası inceleme planlanır (bölüm 3.4).

### 3.3 İletişim şablonları

**İlk bildirim (klinik irtibatına):**
> Konu: [S?] Vetinity – `<kısa sorun adı>`
> Saat `<ss:dd>`'de `<ne olduğu, kullanıcıya görünen belirti>` sorununu tespit ettik. Etkilenenler: `<kimler / hangi ekran>`. Şu an yapmanız gereken: `<ör. bu ekranı kullanmayın, işi kâğıda yazın>`. Bir sonraki bilgilendirme: `<saat>`. İletişim: `<ad, telefon>`.

**Güncelleme:**
> Konu: [S?] Vetinity – güncelleme `<no>`
> Durum: `<araştırılıyor / neden bulundu / düzeltme uygulanıyor>`. Etki değişti mi: `<evet/hayır>`. Sonraki bilgilendirme: `<saat>`.

**Kapanış:**
> Konu: [S?] Vetinity – çözüldü
> Sorun `<ss:dd>`'de giderildi. Neden: `<tek cümle>`. Veri etkisi: `<yok / şu kayıtlar etkilendi: ...>`. Sizden beklenen: `<ör. şu kayıtları kontrol edin>`. Ayrıntılı inceleme `<tarih>`'e kadar paylaşılacaktır.

Bakım duyurusu şablonu bölüm 6'dadır. Mesajlara parola, token, bağlantı dizesi **yazılmaz**.

### 3.4 Olay sonrası inceleme (S1 ve S2 için zorunlu, S3 için isteğe bağlı)

Olaydan sonra en geç 5 iş günü içinde, suçlayıcı olmayan biçimde yazılır:

- Özet ve zaman çizelgesi (algılama, ilk müdahale, önlem, çözüm saatleri).
- Etki: kaç kullanıcı/klinik, veri etkisi var mı.
- Kök neden ve **neden daha önce yakalanmadı** (test, izleme, süreç).
- İyi giden ve kötü giden şeyler.
- Aksiyonlar: sahibi + tarih (kod düzeltmesi, test ekleme, uyarı ekleme, belge güncelleme).
- Bu kılavuzda değişmesi gereken yer var mı.

İnceleme notlarının saklanacağı yer karara bağlanır (bölüm 12); gizli bilgi içermez.

## 4. Destek kanalı: pilot klinik hatayı nasıl bildirir

**Kanal:** Vetinity WhatsApp destek hattı (panel menüsünün en altındaki "WhatsApp destek"; numara frontend `vetinity-support.constants.ts`). Mesaj klinik adıyla hazır açılır. Destek saatleri `<saatler>` **[YAPILACAK – kullanıcı kararı]**.

**Klinik için kısa yönerge (olduğu gibi paylaşılabilir):**

> Bir şey yanlış giderse önce bu ekranı kapatmayın. Aşağıdakileri bize gönderin:
> 1. **Ekran görüntüsü** (hata kutusu, ekranın tamamı; adres çubuğu görünsün).
> 2. **Saat** (yaklaşık dakika, tarih).
> 3. **Kim** (hangi kullanıcıyla giriş yapılmıştı; parolayı yazmayın).
> 4. **Hangi adımlar** (menüden nereye girdiniz, neye bastınız, ne bekliyordunuz, ne oldu).
> 5. Hangi hasta/müşteri/kayıt (adını yazabilirsiniz; kimlik/TC gibi bilgi göndermeyin).
> 6. İşinizi etkiliyor mu? (devam edebiliyor musunuz / hayır).

**Destek tarafında istenenler:** yukarıdakilere ek olarak hata yanıtında görünen `traceId`/`correlationId` varsa (hata ekranında veya tarayıcı ağ sekmesinde) alınır. Bildirenden parola/token/ekran paylaşım kodu **istenmez**. Kullanıcı hesabına başka birinin adına giriş yapılmaz.

**Karşılama:** her bildirime en geç `<süre>` içinde "aldık, derece S?" yanıtı gider **[ÖNERİ: mesai içi 1 saat]**.

**Sık görülen "hata değil" durumlar (kullanıcı kılavuzuyla uyumlu):** abonelik süresi bitince ekranlar "salt okunur" olur; yetkisiz ekran/düğme görünmez veya erişimde "bulunamadı" sayfası açılır; kesinleşmiş muayene değişmez (ek not eklenir). Bunlar önce [kullanıcı kılavuzuna](KULLANICI-KILAVUZU-ROL-BAZLI.md) bakılarak ayıklanır.

## 5. Sürüm ve geri alma prosedürü

### 5.1 Bugünkü gerçek durum

- **Otomatik dağıtım yok.** Yayın, geliştirici bilgisayarında derlenen paketin `scp` ile sunucuya gönderilmesiyle yapılır (bölüm 5.3). Her canlı yayın kullanıcı onayıyla yapılır.
- CI tanımlı (`ci.yml`; `main`'e push, `v*` etiketi, PR, elle) ve yalnız derler, test eder, artifact üretir. Sürüm etiketi bugün kullanılmıyor; yayınlanan sürüm `main` commit'idir (yayın notunda commit hash'i yazılır).
- Yayından önce yerel `main` testten geçer: frontend `npx ng test vetinity-web --watch=false` (2026-11-11: 375 dosya, 2997 test), backend birim + ilgili entegrasyon testleri.
- EF migration'ında **geri alma (down) yoktur**; veritabanını geri almanın yolu **yedekten dönüş**tür.
- Frontend paketleri canlı adresleri derleme ayarından alır (`environment.ts`: `apiBaseUrl`, `publicOrigin`, `panelOrigin`; portal `portalApiBaseUrl`). Canlı paket varsayılan (production) yapılandırmayla derlenir.

### 5.2 Sürüm öncesi (her canlı yayından önce)

- [ ] Yayın içeriği listelendi (hangi commit, hangi migration var, izin/seed değişikliği var mı).
- [ ] Testler geçti; bilinen kırıklar açıkça not edildi.
- [ ] Migration varsa: betik **gözden geçirildi** (sütun/tablo silme, tür daralması, veri kaybı riski) ve **kullanıcı onayı alındı** (canlı DB'ye onaysız uygulanmaz). Uygulamadan hemen önce elle yedek alındı (bölüm 9.3).
- [ ] Kullanıcıyı etkileyen kesinti varsa klinik bilgilendirildi (bölüm 6). Yalnız ön yüz yayını kesintisizdir.
- [ ] Geri alma yolu belli: önceki paket sunucuda saklı (`web-eski` vb.), yedek noktasının saati kayıtlı.
- [ ] Yeni izin varsa `seed` gerekeceği ve kullanıcıların çıkış-giriş yapacağı not edildi.

### 5.3 Yayın adımları

Komutlar geliştirici bilgisayarındaki Git Bash'te çalışır. `SSH="ssh -i ~/.ssh/vetinity_deploy -p 3522 -o BatchMode=yes root@185.149.103.114"`, `scp` için `-P 3522`. Sunucuya gönderilen betiklerde Windows satır sonu (`\r`) temizlenir.

**Panel ve tanıtım sitesi (`web`)** — kesintisiz:

1. `npx ng build vetinity-web` → `dist/vetinity-web/browser`.
2. `tar czf web.tgz -C dist/vetinity-web browser`, sunucuya `/root/web-<tarih>.tgz` olarak gönder.
3. Sunucuda: `web-yeni` klasörüne aç; `cp -rn web/. web-yeni/` ile **eski dosyaları da koru** (açık sekmeler ve service worker eski parçaları isteyebilir); `chown -R vetinity:vetinity web-yeni`; `mv web web-eski` (önceki `web-eski` silinir); `mv web-yeni web`; `.tgz` silinir.
4. Doğrula: `curl -s https://panel.vetinity.com/auth/login | grep -o 'main-[A-Z0-9]*\.js'` yerel `dist/.../index.html` ile aynı; o dosya `200 application/javascript`; `https://www.vetinity.com/` 200.
5. Kullanıcılar yeni sürümü iki yenilemede görür (ilki service worker'ı günceller): **Ctrl+F5 iki kez**.

**Portal (`portal`)**: `npx ng build portal`, aynı yöntemle `/var/www/vetinity/production/portal`'a.

**API (`api`)** — birkaç saniyelik kesinti:

1. `dotnet publish src/Backend.Veteriner.Api -c Release -r linux-x64 --self-contained false -o <çıktı>`.
2. Paketi gönder; sunucuda `api-yeni`'ye aç, `chown -R vetinity:vetinity`, `systemctl stop vetinity-api`, `mv api api-eski`, `mv api-yeni api`, `systemctl start vetinity-api`.
3. Doğrula: `systemctl is-active vetinity-api`; sunucuda `curl -s http://127.0.0.1:5100/health/ready` (dışarıya yalnız `/health/live` açık); `journalctl -u vetinity-api -n 50` içinde hata yok; panelde giriş.

**Migration ve seed (`dbmigrator`)** — yalnız kullanıcı onayıyla, önce elle yedek (bölüm 9.3):

1. `dotnet publish src/Backend.Veteriner.DbMigrator -c Release -r linux-x64 --self-contained false`, `/var/www/vetinity/production/dbmigrator`'a.
2. Sunucuda, `dbmigrator` klasöründe, uygulama kullanıcısıyla ve API ayarlarıyla:
   `sudo -u vetinity bash -c 'set -a; . /etc/vetinity/production/api.env; set +a; /opt/dotnet10/dotnet Backend.Veteriner.DbMigrator.dll <komut>'`
3. Komut sırası: `migrate` (komut DB) → `migrate-query` (sorgu DB) → gerekiyorsa `seed` (yeni izin eklendiyse). `seed` oturumları iptal etmez; yeni izinler için kullanıcılar çıkış-giriş yapar. Üretimde `seed` varsayılan yönetici oluşturmaz.
4. Sonra API yayını (yeni kod yeni şemayı bekler). Şema eski kodla uyumsuzsa migration ile API yayını arka arkaya yapılır.

**Klinik siteleri ve Veteriner bul (`site`)**: `npx ng build site` → `dist/site`; `site-yeni`'ye aç, `mv`, `systemctl restart vetinity-site`; doğrula: `https://www.vetinity.com/veteriner` 200.

**nginx**: değişiklik `sites-available` dosyasında yapılır, `nginx -t` geçmeden `systemctl reload nginx` yapılmaz. Zonguldak yapılandırmasına dokunulmaz.

### 5.4 Geri alma

**Karar:** Yayın sonrası S1/S2 belirti görülürse olay yöneticisi 30 dk içinde "ileri düzelt mi, geri al mı" kararı verir **[ÖNERİ]**. Veri bozuluyorsa önce geri alınır.

| Durum | Geri alma yolu |
|---|---|
| Ön yüz (`web`/`portal`) | `mv web web-bozuk; mv web-eski web` (portal için aynı); kullanıcılar Ctrl+F5 iki kez |
| API, migration yok | `systemctl stop vetinity-api; mv api api-bozuk; mv api-eski api; systemctl start vetinity-api`; `/health/ready` ve giriş doğrulanır |
| Ayar kaynaklı | `api.env`'deki değeri önceki hâline al, `systemctl restart vetinity-api` |
| Migration uygulandı, veri yazılmadı veya önemsiz | Önceki API paketi + gerekirse yayın öncesi yedekten dönüş; şema geri alma kararı **ayrıca** verilir |
| Migration uygulandı ve yeni veri yazıldı | Yedekten dönüş **yeni yazılan verileri kaybettirir** → önce ürün sahibine sorulur; kaybolacak kayıtlar listelenip kliniğe bildirilir |
| Seed nedeniyle izin kaybı | Doğru `main` sürümünden `seed` yeniden çalışır, kullanıcılar çıkış-giriş yapar |

Geri alma sonrası olay kaydı ve (S1/S2 için) olay sonrası inceleme zorunludur.

## 6. Bakım penceresi

- **Standart pencere:** `<gün, saat aralığı>` **[YAPILACAK – klinikle konuşulur; öneri: kliniğin kapalı olduğu saat]**.
- **Duyuru:** planlı bakımdan en az 2 iş günü önce, en az bir hatırlatmayla **[ÖNERİ]**.
- **Acil bakım:** güvenlik açığı veya veri bütünlüğü riski varsa pencere beklenmez; S1 akışı + önceden telefonla haber.
- **Pencerede yapılanlar:** yayın, migration, platform güncellemesi, geri yükleme provası (gerekirse).
- **Kaçınılacak zamanlar:** klinik yoğun saatleri; ay sonu kapanışı **[ÖNERİ – klinikle teyit]**.
- Sunucu işletim sistemi güncellemeleri ve yeniden başlatma aynı sunucudaki diğer siteyi de etkiler; yalnız kullanıcıya sorularak ve bakım penceresinde yapılır.

**Bakım duyuru şablonu:**
> Konu: Vetinity planlı bakım – `<tarih>`
> `<Tarih>` `<başlangıç>`–`<bitiş>` arasında Vetinity kısa süreli kullanılamayabilir. Bu sürede yeni kayıt girmeyin; işi kâğıda yazıp bakım sonrası girin. Bakım bitince size yazacağız. Sorun olursa: `<iletişim>`.

## 7. İzleme ve uyarı

### 7.1 Kurulu olanlar (2026-11-10)

- **UptimeRobot** (kullanıcının hesabı): dört adres dışarıdan düzenli yoklanır: `www`, `panel`, `portal` ve `https://api.vetinity.com/health/live`. Kesintide uyarı hesap e-postasına gider. 2026-11-10'da dördü de yeşil.
- Sağlık uçları: `/health/live` herkese açık (süreç ayakta mı). `/health/ready` ve diğer `/health` yolları nginx'te yalnız `127.0.0.1`'e açık; sunucuda `curl -s http://127.0.0.1:5100/health/ready` ile bakılır (komut DB, sorgu DB, outbox, projeksiyonlar; sorunda 503).
- Uygulama günlüğü: `journalctl -u vetinity-api` ve `journalctl -u vetinity-site`. Hata yanıtlarında `traceId`/`correlationId` vardır; destek talebinde bu kimlikle günlükte aranır.
- Outbox sağlığı `/health/ready` içinde: ölü mektup varsa Unhealthy; bekleyen > 500 ise Degraded.
- Yedek günlüğü: `/var/log/vetinity-yedek.log` (bölüm 9).
- Sertifika yenileme: certbot zamanlayıcısı; bitiş 2027-02-08.

### 7.2 Kurulmamış olanlar **[YAPILACAK]**

| Beklenti | Neden |
|---|---|
| `/health/ready` için dış uyarı | Bugün dışarıdan yalnız `live` yoklanıyor; DB veya outbox sorunu uyarı üretmez |
| Hata izleme ve merkezi günlük toplama | Günlükler yalnız sunucuda; 5xx artışı kendiliğinden fark edilmez |
| Yedek başarısızlığı uyarısı | Betik hata kodu döner ama kimseye haber vermez; günlük elle kontrol edilir |
| Disk doluluk uyarısı | Yedekler ve dosyalar aynı diskte |
| E-posta gönderim hatası uyarısı | "Gönderildi" = SMTP'ye iletildi; teslim izi yok |

Her uyarının "alındığında ne yapılır" notu yazılır (uyarı yorgunluğunu önlemek için).

### 7.3 Günlük/haftalık kontrol **[ÖNERİ, araçlar kurulana dek elle]**

- Günlük (mesai başı): UptimeRobot yeşil mi; `tail -5 /var/log/vetinity-yedek.log` son satır `INFO: bitti` mi; açık S1/S2 var mı.
- Haftalık: `journalctl -u vetinity-api --since "-7 days" -p err`; disk (`df -h /`); `/health/ready`; bekleyen destek kayıtları.

## 8. KVKK: kişisel veri ihlali karar noktaları

> **Bu bölüm hukuki tavsiye değildir.** Ürün ekibi hukuki değerlendirme yapmaz ve ihlal/bildirim kararını vermez. Amaç, olası bir ihlalde **zaman kaybetmeden doğru kişiye gitmek** için karar noktalarını sıralamaktır. Süreler, kapsam ve bildirim yükümlülükleri **KVKK danışmanı/avukat** ile teyit edilir (ADR-014 K3; danışman henüz atanmadı **[YAPILACAK]**).

Sistemde işlenen kişisel veriler (koddan çıkarılan envanter; tam liste değil): müşteri (ad, e-posta, telefon, adres), hayvan (ad, doğum tarihi, mikroçip, pasaport no, notlar), kullanıcı (e-posta, parola özeti, ad), klinik kayıtlar ve serbest metin notlar, finans kayıtları, denetim ve oturum kayıtları. T.C. kimlik no alanı yoktur. Veri envanteri danışmanla kesinleştirilir.

**Karar akışı:**

1. **Şüphe/algı:** Yetkisiz erişim, yanlış kişiye veri gösterimi (ör. başka klinik verisi), kayıp cihaz/hesap, sızan gizli bilgi, yanlış gönderilen e-posta, yedek/depolamanın açığa çıkması.
2. **Hemen:** olay S1 olarak açılır; olay yöneticisi ve ürün sahibi haberdar edilir. **Kanıt korunur** (günlükler silinmez, ekran görüntüsü alınır; yeniden başlatma/temizlik kararı önce sorulur).
3. **Durdur:** erişim kapatılır (ilgili hesabın parolası/oturumu iptal, sızan anahtar döndürme, ilgili özelliğin kapatılması). *Not: panel ve portal girişinde 5 hatalı denemede hesap 15 dk kilitlenir (SEC-001); kilit kendiliğinden açılır, parola sıfırlama da kaldırır. Üretimde `RevokeSessionsOnPermissionChange=true` (kullanıcı kararı 2026-10-13) yalnız yönetim API'sindeki dört izin komutunda etkilenen kullanıcıların refresh token'larını iptal eder; verilmiş access token süresi bitene dek (`Jwt:ExpMinutes` 60 dk) geçerli kalır; `seed` ve rol atama oturum iptal etmez. Bu yüzden hesap devre dışı bırakma + parola sıfırlama + gizli anahtar döndürme birlikte düşünülür.*
4. **Olgular (danışmana gidecek bilgi):** ne zaman başladı/fark edildi, hangi veri türleri, kaç kişi/kayıt tahmini, hangi klinik(ler), veri kime açıldı/sızdı, hâlâ sürüyor mu, ne yapıldı. Tahmini sayılar "tahmin" diye işaretlenir; bilinmeyen "bilinmiyor" yazılır.
5. **Danışmana bildir (aynı gün):** `<danışman iletişimi>` **[YAPILACAK]**. Kararı o verir: bu bir ihlal mi? Kuruma (KVKK Kurulu) ve/veya ilgili kişilere bildirim gerekir mi? Hangi sürede? Bildirimi **kimin** (veri sorumlusu klinik mi, Vetinity veri işleyen olarak mı) yapacağı sözleşmeye bağlıdır (veri işleyen sözleşmesi K3 kapsamında hazırlanır).
6. **Veri sorumlusu kliniğe haber:** veri işleyen rolünde olunuyorsa sözleşmedeki süre içinde kliniğe yazılı bilgi verilir. Süre sözleşmeyle yazılır: `<süre>` **[YAPILACAK]**. *Mevzuattaki sürelerin (kamuoyunda anılan 72 saat dâhil) doğru uygulanışı danışmanla teyit edilmelidir; bu belge bu süreyi doğrulamaz.*
7. **Kayıt:** karar ne olursa olsun, olay, alınan karar ve gerekçesi yazılı tutulur (ihlal kayıt defteri **[YAPILACAK – danışmanla biçim]**).
8. **Düzeltici işler:** kök neden, olay sonrası inceleme (bölüm 3.4), gerekirse teknik KVKK işleri (erişim denetimi, anonimleştirme – Dilim 8).

Her şüphede danışmana gitmek bir yük değil, kuraldır: "bu ihlal değildir" kararını da danışman verir.

## 9. Yedek ve geri yükleme

### 9.1 Kurulu düzen (2026-11-10)

- **Her gece 02:30** (`/etc/cron.d/vetinity-yedek`) `/opt/vetinity/yedek.sh` çalışır; çıktısı `/var/log/vetinity-yedek.log`. Betik yalnız Vetinity verisine dokunur.
- Yedeklenenler: `VetinityCommandDb` ve `VetinityQueryDb` tam yedek (`COMPRESSION, CHECKSUM`; yedeği `vetinity_app` alır), her biri `RESTORE VERIFYONLY` ile doğrulanır (`sa` ile; bu yetki uygulama girişine verilmez); `/var/lib/vetinity/files` klasörü `tar.gz`.
- **Sunucuda:** `/var/backups/vetinity/gunluk/<YYYY-AA-GG>/` (yalnız `root`), **14 gün** saklanır.
- **Sunucu dışında:** Google Drive (`vetinity.app` hesabı, `vetinity-yedek` klasörü), rclone `crypt` ile **şifreli** (`gcrypt:` uzak adı); kopya `rclone cryptcheck` ile doğrulanır, **30 gün** saklanır. Drive kopyası başarısızsa yerel yedek yine tamamdır, betik hata koduyla biter (`ERROR: Drive kopyasi basarisiz`).
- Şifreleme parolaları `/root/VETINITY-YEDEK-SIFRESI.txt`'de; **kullanıcı bu dosyanın bir kopyasını sunucu dışında güvenli yerde tutar** (sunucu kaybolursa Drive yedeği bu parolalar olmadan açılamaz).
- Veri kaybı en çok **1 gün** (gece yedeği arası; işlem günlüğü yedeği yok). RPO/RTO kabulü bölüm 12'de.
- 2026-11-10'da geri yükleme provası yapıldı ve geçti (yedek ayrı bir geçici veritabanına açıldı).

### 9.2 Kontrol

- Son yedek: `tail -5 /var/log/vetinity-yedek.log` → `INFO: Drive kopyasi dogrulandi` ve `INFO: bitti`.
- Yerel liste: `ls -la /var/backups/vetinity/gunluk/`.
- Drive listesi: `rclone lsl gcrypt:gunluk | tail` (adlar şifresiz görünür, içerik şifreli).

### 9.3 Elle yedek (migration ve riskli işlemden önce)

`/opt/vetinity/yedek.sh` elle çalıştırılır (aynı günün klasörüne zaman damgalı yeni dosyalar ekler). Bittiğinde günlükte `INFO: bitti` görülmeden migration uygulanmaz.

### 9.4 Geri yükleme

1. Olay yöneticisi ve ürün sahibi karar verir (yeni yazılan veri kaybolur; bölüm 5.4).
2. Gerekirse yedek Drive'dan indirilir: `rclone copy gcrypt:gunluk/<gün> /var/opt/mssql/geri-yukle/` (SQL Server kullanıcısı `mssql` okuyabilmeli).
3. `systemctl stop vetinity-api vetinity-site`.
4. `sa` ile `RESTORE DATABASE [VetinityCommandDb] FROM DISK = N'<yol>' WITH REPLACE, CHECKSUM` (sorgu DB'si için aynı). Dosyalar gerekiyorsa `tar xzf dosyalar_<ts>.tar.gz -C /var/lib/vetinity` (sahip `vetinity:vetinity`).
5. `systemctl start vetinity-api vetinity-site`; `/health/ready`, giriş, örnek hasta/muayene/ödeme kaydı.
6. Geri yükleme klasöründeki kopyalar silinir; olay kaydına yedek noktasının saati yazılır.

### 9.5 Aylık geri yükleme provası

Prova **canlı veritabanına değil**, geçici bir veritabanına (`VetinityProva_<tarih>` gibi) yapılır.

- [ ] Son gecenin yedeği seçildi; yedeklerin yaşı ve sürekliliği kontrol edildi (14 gün yerel, 30 gün Drive).
- [ ] Başlangıç saati yazıldı (RTO ölçümü).
- [ ] `RESTORE ... WITH MOVE` ile geçici ada açıldı; kayıt sayıları ve son kayıt zamanı not edildi (RPO ölçümü).
- [ ] Bir Drive kopyası da indirilip şifresi çözülerek açıldı (sunucu kaybı senaryosu).
- [ ] Geçici veritabanı ve indirilen dosyalar provadan sonra **silindi** (kişisel veri kopyası kalmaz).
- [ ] Ölçülen süreler ve sorunlar not edildi.

Prova sonucu alınmamış bir yedeğe "çalışıyor" denmez.

## 10. Pilot gölge kullanım kuralları (ADR-014 K4)

İlk **2 hafta gölge kullanım**: gerçek iş **eski yöntemle** (kâğıt/Excel) sürer, aynı iş Vetinity'ye **paralel** girilir.

- Vetinity kaydı **resmî kayıt değildir**; klinikte karar, ücret ve ödeme için eski kayıt geçerlidir.
- Vetinity'de farkı fark eden kişi bildirir (bölüm 4). Farklar bir "fark listesi"nde tutulur: tarih, eski kayıt, Vetinity kaydı, sebep.
- Her gün sonunda 10 dakika: Bugün ekranındaki gelişler ile eski deftere bakılır; eksik/fazla var mı.
- Ücret/ödeme: tutarlar iki kayıtta eşleşmeli; bakiye farkı olursa bildirim S2'dir.
- Gerçek ödeme **yalnız eski yöntemle** alınır; Vetinity'ye sonradan aynı tutarla girilir.
- Hatalı girişleri silmeye çalışmayın: ücret/ödeme **iptal** edilir (yönetici), geliş **düzeltilir**, kesinleşmiş muayeneye **ek not** eklenir (kullanıcı kılavuzuna bakın). Pilotta test için ayrı "TEST" kayıt adı kullanılır **[ÖNERİ]**.
- Gölge dönemi çıkış ölçütleri (örnek, klinikle netleşir **[YAPILACAK]**): iki hafta boyunca S1 yok, fark listesi kapanmış, kullanıcılar günlük akışı yardımsız tamamlıyor, bakiye uyumu.
- Geri dönüş: Vetinity'yi bırakma kararı verilirse klinik zaten eski yöntemdedir; Vetinity verisi klinik yöneticisi (Admin/Owner) tarafından Ayarlar > Verimi dışa aktar sayfasından tek ZIP pakette alınır: her tablo ayrı CSV (UTF-8, noktalı virgül, ilk sütun kayıt kimliği, zamanlar UTC ve İstanbul saatiyle, tutarlar ondalık noktayla), içinde BENIOKU.txt. Paket arka planda hazırlanır, hazır olunca bildirim gelir ve 7 gün saklanır; abonelik salt okunurken de çalışır. Biçim: backend `docs/DATA_EXPORT_API_CONTRACT.md` (2026-11-09). Yüklenen dosyaların içeriği (görüntü, lab ekleri) bu pakette yoktur; gerekirse ayrıca talep edilir **[YAPILACAK]**.
- Pilot kapsamı önce Aşama 1–3 senaryolarıdır (muayene, geliş, ücret ve ödeme) (K9); diğer ekranlar kullanılabilir ama gölge dönemde kritik sayılmaz.
- İlk gün: eğitim oturumu (kullanıcı kılavuzuyla), ilk hafta günlük kısa görüşme **[ÖNERİ]**.

## 11. Canlıya çıkış durumu (2026-11-11)

### 11.1 Tamamlananlar (2026-11-10)

- [x] Dört adres, sertifikalar ve nginx yönlendirmeleri (ADR-033); `.wasm` dosyası `application/wasm` ile sunulur; panel ve portal gömme başlıkları (`/randevu/*` gömülebilir, diğerleri `frame-ancestors 'none'`, `X-Frame-Options: DENY`).
- [x] Tüm migration'lar canlı komut ve sorgu DB'sine uygulandı, ardından `seed`. Canlı `api.env` ayarları (bölüm 1.3); `AllowedHosts` api adını içerir; projeksiyon olay yazımı kapalı; `FileStorage__RootPath` ve `App__BaseUrl` tanımlı.
- [x] İlk platform yöneticisi kullanıcının kendi hesabıdır; kliniksiz giriş yönetim sayfalarıyla açılır.
- [x] SMTP girişi doğrulandı (Gmail uygulama şifresi).
- [x] Gece yedeği, şifreli Drive kopyası, geri yükleme provası (bölüm 9).
- [x] SQL Server bellek sınırı 3072 MB.
- [x] PDF raporları için DejaVu Sans kurulu (`/usr/share/fonts/truetype/dejavu`, `fonts-dejavu-core`; 2026-11-11 doğrulandı). Sunucuda `fc-list` yok; yazı tipini dosya yoluyla kontrol edin.
- [x] UptimeRobot ile dış izleme (bölüm 7).
- [x] Site Node süreci (`/k/*`, `/veteriner*`) nginx arkasında; nginx aynı makinede olduğundan API'nin `ForwardedHeaders` (yalnız loopback'e güven) ayarı yeterli.

### 11.2 Açık olanlar

- [ ] **iyzico canlı anahtarları** (`Billing__Iyzico__ApiKey`/`SecretKey` henüz yok): şahıs işletmesinin vergi kaydı ve iyzico üye işyeri başvurusu kullanıcıda. Deneme süreleri bitmeden gerekli. Ardından gerçek kartla küçük tutarlı ödeme uçtan uca denenir (ödeme → dönüş → abonelik etkin; webhook günlükte görülür).
- [ ] **ClamAV kurulu değil** (2026-11-11): yüklenen dosyalar taranmıyor. Kurulumu sunucu geneli; kullanıcı onayıyla.
- [ ] Gerçek bir e-postanın (davet, hatırlatma, parola sıfırlama) canlıdan gidip ulaştığı denenmedi.
- [ ] Barkod okuyucu gerçek telefonla (iOS Safari, Android) denenmedi.
- [ ] Klinik sitesi hazır fotoğraf setinin lisansı (ADR-045 K7).
- [ ] Veteriner bul site haritası `robots.txt`'ye eklenmedi (`Sitemap: https://www.vetinity.com/veteriner/sitemap.xml`); bugün yalnız ana site haritası var.
- [ ] Push sağlayıcısı yok (`Push:Fcm` tanımsız; portal "henüz etkin değil" der). Ticari ileti gönderimi kapalı (ADR-046).
- [ ] SQL Server servis hesabına "Lock pages in memory" verilmedi (Linux'ta isteğe bağlı; paylaşılan sunucuda yapılmaması daha güvenli).
- [ ] Arka plan işleri canlıda bir tur gözlenmedi: içe aktarma, hatırlatma gönderimi, ödeme uzlaştırma.
- [ ] Bölüm 2 rolleri, destek saatleri, bakım penceresi ve gölge dönem ölçütleri (bölüm 12).

## 12. Kullanıcı kararı gerektirenler

1. Önem derecesi hedef süreleri ve güncelleme sıklığı (bölüm 3.1) uygun mu?
2. Destek kanalı: hangi e-posta/telefon/mesajlaşma aracı? Mesai saatleri?
3. Nöbet düzeni: mesai dışı S1'de kim aranır?
4. Bakım penceresi için tercih edilen saat.
5. Olay sonrası inceleme notlarının saklanacağı yer (ürün deposu mu?).
6. Gölge dönem çıkış ölçütleri ve fark listesinin tutulacağı araç.
7. RPO/RTO sayıları (ADR-014 K2). Bugünkü düzende veri kaybı en çok 1 gündür (gece yedeği); daha kısası işlem günlüğü yedeği ister.
8. Sunucu geneli kurulum: ClamAV (bölüm 11.2).

## 13. Doğrulanmayanlar

- Bölüm 1, 7 ve 9 sunucudan 2026-11-11'de okundu (servis dosyaları, klasörler, `api.env` anahtar adları, cron, yedek betiği). Gece yedeğinin cron'la ilk kendiliğinden koşusu 2026-11-11 02:30'dur; bu belge yazılırken henüz koşmamıştı (elle koşular başarılıydı).
- UptimeRobot'un tam izleme adresleri ve uyarı alıcısı kullanıcının hesabında; belgeye kullanıcının aktardığı biçimde yazıldı.
- Bölüm 5.3'teki API, portal ve site yayın adımları 2026-11-10 ilk kurulumundaki yöntemdir; `api-eski` ile geri alma henüz denenmedi. `web` yayını ve `web-eski` 2026-11-11'de iki kez kullanıldı.
- Drive yedeğinin başka bir makinede indirilip açılması (sunucu kaybı senaryosu) denenmedi.
- Kişisel veri ihlaline ilişkin yasal süreler ve sorumluluk dağılımı doğrulanmadı (hukuki konu).
- Önem derecesi süreleri, mesai saatleri ve nöbet düzeni öneridir; hiçbiri kararlaştırılmadı.
