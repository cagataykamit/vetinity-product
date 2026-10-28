# Vetinity canlı işletim kılavuzu

**Durum:** Taslak v0.1 (2026-10-13). Aşama 9 Dilim 11. Kaynaklar: [ADR-014](../decisions/ADR-014-pilot-and-production-operations.md) (K1–K9), backend `docs/ASAMA9_READINESS.md` (keşif; yalnız kod/belge okuması), backend `docs/deploy/*` ve `docs/cqrs/cqrs-11b-operations-runbook.md`.

## Bu belge nasıl okunur

- Bu belge **yöntem ve beklentiyi** yazar. Ürün canlıda değildir; altyapı henüz kurulmamıştır.
- **[YAPILACAK]** = henüz kurulmamış veya kararlaştırılmamış. Uydurma değer yoktur; boşluklar `<...>` ile işaretlidir ve doldurulacaktır.
- **[ÖNERİ]** = kullanıcı kararı bekleyen öneri (bölüm 12).
- Hosting yönetilen bulut (Azure) varsayımıyla düşünülmüştür (ADR-014 K1) ama adımlar platformdan bağımsız yazıldı. Platform adı geçen yerde "yönetilen platform" denir.
- Bu belge hukuki tavsiye değildir (bölüm 8).

## 1. Mevcut durum özeti (neden çoğu madde "yapılacak")

Backend keşfi (2026-10-13) ve sonraki backend belgeleri (`docs/CI_CD.md`, `docs/SECURITY_CONFIGURATION.md`; `docs/MONITORING_ALERTING_CONTRACT.md` ayrı dalda, henüz `main`'de değil) okunarak güncellendi (2026-10-14). Belge/kod okuması; hiçbir ortama bağlanılmadı, iş akışları çalıştırılmadı:

| Konu | Durum |
|---|---|
| Üretim/staging ortamı | Kurulu olduğuna dair kanıt yok; yalnız tasarım/runbook belgeleri var (Windows IIS hedefli; ADR-014 K1 bunu yedek plan sayar) |
| CI/CD, sürüm etiketi | CI iş akışı tanımlı (`.github/workflows/ci.yml`: derleme + test + artifact + idempotent migration betikleri; `v*` etiketiyle SemVer). **GitHub'da henüz çalışmadı** (`CI_CD.md`: ilk koşuda ayar gerekebilir). **Dağıtım (CD) ve hosting yok.** Telemetri sürümü kodda sabit `1.0.0` (derleme sürümünü okumaz) |
| Yedekleme / geri yükleme | Repoda tanımlı değil, hiç denenmedi |
| Hata izleme / uyarı aracı | Hesap/araç yok. Kod tarafı (izleme dalında, `main`'de değil): korelasyon kimliği, `IErrorReporter` soyutlaması (varsayılan yalnız günlüğe yazar), outbox eşikleri, `ops.*` metrikleri. Üretim günlüğü stdout'a JSON (platform toplar); `/health/live`, `/health/ready`; OTLP yalnız `OTEL_EXPORTER_OTLP_ENDPOINT` verilirse. Toplayıcı, uptime izleyici ve uyarı kanalı kurulu değil |
| Olay yönetimi / destek | Yok (bu belge ilk taslak) |
| Sabit parolalı varsayılan yönetici | Development dışında artık oluşturulmaz; ilk yönetici `DbMigrator create-platform-admin` ile (`SECURITY_CONFIGURATION.md`). Üretim açılış doğrulaması eksik/yer tutucu gizli ayarlarda API'yi başlatmaz. Üretimde `seed` yalnız etiketli birleşik sürümden |

Bu nedenle aşağıdaki prosedürler **go-live öncesi hazırlık hedefidir**. Gerçek ortam kurulunca her maddenin yanındaki `<...>` alanları doldurulur ve prosedür provası yapılır (bölüm 11).

## 2. Roller ve sorumluluklar

| Rol | Kim | Sorumluluk |
|---|---|---|
| Ürün sahibi / karar verici | `<ad>` (kullanıcı) | Önem derecesi onayı, müşteri iletişimi, geri alma kararı, KVKK danışmanıyla temas |
| Nöbetçi mühendis | `<ad>` **[YAPILACAK]** | Uyarıyı alır, ilk müdahaleyi yapar, durumu günceller |
| Pilot klinik irtibatı | `<ad, telefon>` **[YAPILACAK]** | Klinikte sorunu bildiren ve duyuruyu alan tek kişi |
| KVKK danışmanı / avukat | `<ad>` **[YAPILACAK]** (ADR-014 K3) | Kişisel veri ihlali değerlendirmesi |
| Platform sağlayıcı desteği | Bulut hesabı açılınca **[YAPILACAK]** | Altyapı kesintileri, yedekten dönüş |

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

**Kanal:** `<e-posta adresi / telefon / mesajlaşma grubu>` **[YAPILACAK – kullanıcı kararı; alan adı ve e-posta hizmeti kurulunca]**. Pilotta tek kanal tercih edilir; acil durumda telefon.

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

- CI tanımlı (`ci.yml`; tetik: `main`'e push, `v*` etiketi, PR, elle) ve GitHub'da her `main` push'unda koşuyor (backend: derleme + birim, LocalDB entegrasyon; frontend ayrı iş akışı). `main` dal koruması kullanıcı işi. **Otomatik dağıtım yok**: CI yalnız derler, test eder, artifact üretir.
- Sürüm = git etiketi (`vMAJOR.MINOR.PATCH` veya `-rc.1`), yalnız testleri geçmiş `main` commit'ine; iş akışı bunu zorlamaz. Etiketsiz koşu `0.0.0-ci.<koşu no>` alır. Etiket push'u kullanıcı işi. Uygulama içi telemetri sürümü hâlâ sabit `1.0.0` (bilinen boşluk).
- Artifact'lar: `api-<sürüm>`, `dbmigrator-<sürüm>`, `migrations-<sürüm>`, test sonuçları (etiket koşuları 90 gün, diğerleri 30 gün saklanır).
- Bilinen tuzak: `Api.csproj` yayından `appsettings.Production.json`'u her zaman dışlar; üretim yapılandırması platform ortam değişkenlerinden gelmeli (`AllowedOrigins`, `AllowedHosts`, `Jwt:Key`, bağlantı dizeleri, `Smtp:*`; eksikse API açılmaz). Kural Dilim 3'te netleşecek **[YAPILACAK]**.
- API açılışta migration/seed **çalıştırmaz**; veritabanı değişikliği yalnız `DbMigrator` komutlarıyla yapılır (`migrate`, `migrate-query`, `seed`).
- EF migration'ında **geri alma (down) yoktur**; veritabanını geri almanın yolu **yedekten dönüş** (backend runbook'u: "yedekten dönüş").
- İdempotent migration betikleri CI'da üretilir (`migrations-<sürüm>`: `AppDbContext.sql` komut DB, `QueryDbContext.sql` sorgu DB); **hiçbir DB'ye otomatik uygulanmaz**. Betik izin/seed verisi eklemez.
- Tam entegrasyon test paketi yeşil (2026-10-28, `d091bc1b`: 1684 geçti, 2 bilinçli atlanan performans ölçümü, 0 başarısız; yerelde ~9 dk). CI'da `integration-tests` işi Windows + LocalDB'de koşar. Sürüm kesmeden önce kırmızı koşu varsa nedeni not edilir.

### 5.2 Sürüm öncesi (her canlı yayından önce)

- [ ] Yayın içeriği listelendi (hangi commit/etiket, hangi migration var, izin/seed değişikliği var mı).
- [ ] Etiketli, birleşik sürüm; bu commit için CI koşusu görüldü ve `migrations-<sürüm>` artifact'ı indirildi. **Seed yalnız etiketli birleşik sürümden çalıştırılır**; farklı dallardan seed izinleri birbirinden siler.
- [ ] Testler: Domain + Application + ilgili entegrasyon sınıfları geçti; tam paket sonucu ve bilinen kırıklar açıkça not edildi.
- [ ] Staging'de aynı sürümle migration + temel kabul denendi **[YAPILACAK – staging kurulunca]**.
- [ ] **Yedek alındı ve alındığı doğrulandı** (bölüm 5.3 adım 1).
- [ ] Migration varsa betik **gözden geçirildi** (sütun/tablo silme, tür daralması, veri kaybı riski) ve **kullanıcı onayı alındı** (migration başına; paylaşılan/üretim DB'ye onaysız uygulanmaz).
- [ ] Bakım penceresi planlandı ve klinik bilgilendirildi (bölüm 6).
- [ ] Geri alma planı yazılı: önceki yayın paketi saklı, yedek noktasının saati kayıtlı.
- [ ] Yeni izinler (`*.Read` vb.) varsa: özel roller elle güncellenecek mi, notlandı.

### 5.3 Yayın adımları (özet)

1. **Yedek:** veritabanı yedek noktası kaydedilir (saat + doğrulama). Yönetilen platformda anlık görüntü/nokta-zaman yedeği de not edilir.
2. Bakım penceresi başlar; gerekirse klinik kullanıcılar çıkış yapar.
3. Yeni API paketi dağıtılır; gizli bilgiler platformun gizli deposundan gelir (dosyaya yazılmaz).
4. Migration: ya `DbMigrator migrate` (komut DB) + `migrate-query` (sorgu DB'si; pilotta okuma bayrakları kapalı olsa da bağlantı ve şema zorunludur) ya da CI'dan inen idempotent betikler (`AppDbContext.sql`, `QueryDbContext.sql`; `sqlcmd`/SSMS/platform aracı). Hangisinin kullanılacağı ve komut sırası **[YAPILACAK – Dilim 3 üretim runbook'unda doğrulanacak]**.
5. Yalnız gerekiyorsa `seed` (etiketli sürümden; yeni izin eklenmişse gerekir). `seed` oturumları iptal etmez: sonrasında kullanıcılar **çıkış-giriş** yapar (izinler yenilensin). Üretimde `seed` varsayılan yönetici oluşturmaz; ilk yönetici yalnız kurulumda `create-platform-admin` ile.
6. Doğrulama: `/health/ready` yeşil; giriş; Bugün açılır; bir test hastasıyla geliş → muayene taslağı (test kaydı politikası klinikle konuşulur); rapor sayfası açılır.
7. Pencere kapanır, klinik bilgilendirilir.

### 5.4 Geri alma

**Karar:** Yayın sonrası S1/S2 belirti görülürse olay yöneticisi 30 dk içinde "ileri düzelt mi, geri al mı" kararı verir **[ÖNERİ]**. Veri bozuluyorsa önce geri alınır.

| Durum | Geri alma yolu |
|---|---|
| Yalnız uygulama kodu, migration yok | Önceki yayın paketine dön, yeniden başlat, `/health/ready` ve temel akışı doğrula |
| Yapılandırma / özellik bayrağı kaynaklı | Bayrağı önceki değerine al, yeniden başlat (CQRS runbook'undaki bayrak geri alma) |
| Migration uygulandı, veri yazılmadı veya önemsiz | Önceki yayın paketi + gerekirse yedekten dönüş; migration down olmadığından şema geri alma kararı **ayrıca** verilir |
| Migration uygulandı ve yeni veri yazıldı | Yedekten dönüş **yeni yazılan verileri kaybettirir** → önce ürün sahibine karar sor; kaybolacak kayıtlar listelenip kliniğe bildirilir; mümkünse kayıtlar elle yeniden girilir |
| Seed nedeniyle izin kaybı | Doğru etiketli sürümden seed'i yeniden çalıştır, kullanıcılar çıkış-giriş yapsın |

Geri alma sonrası olay kaydı ve (S1/S2 için) olay sonrası inceleme zorunludur. **Sürüm geri alma provası** staging'de en az bir kez yapılmadan canlı yayın yapılmaz **[YAPILACAK – Dilim 10]**.

## 6. Bakım penceresi

- **Standart pencere:** `<gün, saat aralığı>` **[YAPILACAK – klinikle konuşulur; öneri: kliniğin kapalı olduğu saat]**.
- **Duyuru:** planlı bakımdan en az 2 iş günü önce, en az bir hatırlatmayla **[ÖNERİ]**.
- **Acil bakım:** güvenlik açığı veya veri bütünlüğü riski varsa pencere beklenmez; S1 akışı + önceden telefonla haber.
- **Pencerede yapılanlar:** yayın, migration, platform güncellemesi, geri yükleme provası (gerekirse).
- **Kaçınılacak zamanlar:** klinik yoğun saatleri; ay sonu kapanışı **[ÖNERİ – klinikle teyit]**.
- Yönetilen platformun kendi bakımları (işletim sistemi/runtime yaması) platformun penceresine bağlıdır; bu pencereler öğrenilip klinikle çakışma kontrol edilir **[YAPILACAK]**.

**Bakım duyuru şablonu:**
> Konu: Vetinity planlı bakım – `<tarih>`
> `<Tarih>` `<başlangıç>`–`<bitiş>` arasında Vetinity kısa süreli kullanılamayabilir. Bu sürede yeni kayıt girmeyin; işi kâğıda yazıp bakım sonrası girin. Bakım bitince size yazacağız. Sorun olursa: `<iletişim>`.

## 7. İzleme ve uyarı beklentileri

### 7.1 Bugün var olanlar (kod okumasına göre)

- `/health/live` (süreç ayakta mı), `/health/ready` (komut DB, sorgu DB, outbox, projeksiyonlar; sorunda 503).
- Outbox sağlığı: ölü mektup (dead-letter) varsa Unhealthy; bekleyen > 500 ise Degraded.
- Üretim şablonunda günlük stdout'a yapılandırılmış JSON (platform toplar; dosya sink'i varsayılan kapalı); yavaş SQL günlüğü (eşik 200 ms).
- Hata yanıtlarında `traceId`/`correlationId`.
- OpenTelemetry iz/metrik çıktısı (toplayıcı yapılandırılırsa).

### 7.1b İzleme kod katmanı (backend `MONITORING_ALERTING_CONTRACT.md`; ayrı dalda, `main`'e birleşmedi)

- `X-Correlation-ID` başlığı ve ProblemDetails `correlationId`: destek taleplerinde bu kimlik istenir (bölüm 4).
- Beklenmeyen (5xx) hatalar `IErrorReporter` ile raporlanır; varsayılan uygulama yalnız günlüğe yazar ve `ops.errors.unhandled.total` sayar. Dış hata izleme hizmeti **bağlı değil** (hesap/DSN gerekir).
- Outbox eşikleri `/health/ready` içinde: dead-letter > 0 Unhealthy; en eski bekleyen ≥ 120 sn Degraded, ≥ 600 sn Unhealthy; bekleyen > 500 Degraded. Metrikler: `ops.outbox.pending`, `ops.outbox.dead_letter`, `ops.outbox.oldest_pending_age` (son `/health/ready` sonucundan beslenir; uptime izleyici bu ucu en az dakikada bir çağırmalı).
- Sözleşmenin önerdiği uyarılar (kanal kurulunca): hazır değil 503 ≥ 2 dk; canlı değil ≥ 1 dk; dead-letter > 0; outbox gecikmesi ≥ 600 sn; 5 dk'da 5'ten fazla beklenmeyen hata; projeksiyon Unhealthy. Eşikler pilot verisiyle ayarlanmadı; gerçek metrik adları toplayıcıda doğrulanmalı.

### 7.2 Beklenen ama kurulmamış olanlar **[YAPILACAK – Dilim 5: hesap ve kanal kullanıcı işi]**

| Beklenti | Neden |
|---|---|
| `/health/ready` ve `/health/live` dışarıdan düzenli yoklama (uptime) + uyarı kanalı | Kimse bakmadan sessiz kesinti olmasın |
| Hata izleme ve merkezi günlük toplama | Hata günlükleri tek yerde aransın |
| 5xx oranı uyarısı | Yayın sonrası bozulmayı yakalamak |
| Outbox ölü mektup ve projeksiyon gecikmesi uyarısı | Gece kalan işlerin farkına varmak |
| Yavaş sorgu uyarısı | Pilot hacminde performans (K6: yavaşlık ölçülürse Query DB açılır) |
| Yedek başarısı/başarısızlığı uyarısı | Yedeksiz kalmamak |
| Sertifika/alan adı bitiş uyarısı | Beklenmedik kesinti |
| E-posta gönderim hatası uyarısı | Hatırlatma/davet gitmiyor olabilir ("gönderildi" = SMTP'ye iletildi, teslim izi yok) |

Uyarı eşikleri ve alıcılar, araç seçilince yazılır: `<eşik>` / `<alıcı>`. Her uyarının "alındığında ne yapılır" notu olmalıdır (uyarı yorgunluğunu önlemek için).

### 7.3 Günlük/haftalık kontrol **[ÖNERİ, araçlar kurulana dek elle]**

- Günlük (mesai başı): `/health/ready` yeşil mi, yedek dün gece alındı mı, açık S1/S2 var mı.
- Haftalık: hata ve yavaş sorgu günlüklerine göz at, bekleyen destek kayıtları, disk/veritabanı boyutu.

## 8. KVKK: kişisel veri ihlali karar noktaları

> **Bu bölüm hukuki tavsiye değildir.** Ürün ekibi hukuki değerlendirme yapmaz ve ihlal/bildirim kararını vermez. Amaç, olası bir ihlalde **zaman kaybetmeden doğru kişiye gitmek** için karar noktalarını sıralamaktır. Süreler, kapsam ve bildirim yükümlülükleri **KVKK danışmanı/avukat** ile teyit edilir (ADR-014 K3; danışman henüz atanmadı **[YAPILACAK]**).

Sistemde işlenen kişisel veriler (koddan çıkarılan envanter; tam liste değil): müşteri (ad, e-posta, telefon, adres), hayvan (ad, doğum tarihi, mikroçip, pasaport no, notlar), kullanıcı (e-posta, parola özeti, ad), klinik kayıtlar ve serbest metin notlar, finans kayıtları, denetim ve oturum kayıtları. T.C. kimlik no alanı yoktur. Veri envanteri danışmanla kesinleştirilir.

**Karar akışı:**

1. **Şüphe/algı:** Yetkisiz erişim, yanlış kişiye veri gösterimi (ör. başka klinik verisi), kayıp cihaz/hesap, sızan gizli bilgi, yanlış gönderilen e-posta, yedek/depolamanın açığa çıkması.
2. **Hemen:** olay S1 olarak açılır; olay yöneticisi ve ürün sahibi haberdar edilir. **Kanıt korunur** (günlükler silinmez, ekran görüntüsü alınır; yeniden başlatma/temizlik kararı önce sorulur).
3. **Durdur:** erişim kapatılır (ilgili hesabın parolası/oturumu iptal, sızan anahtar döndürme, ilgili özelliğin kapatılması). *Not: hesap kilitleme yok (SEC-001 ertelendi). Üretimde `RevokeSessionsOnPermissionChange=true` (kullanıcı kararı 2026-10-13) yalnız yönetim API'sindeki dört izin komutunda etkilenen kullanıcıların refresh token'larını iptal eder; verilmiş access token süresi bitene dek (`Jwt:ExpMinutes` 60 dk) geçerli kalır; `seed` ve rol atama oturum iptal etmez. Bu yüzden hesap devre dışı bırakma + parola sıfırlama + gizli anahtar döndürme birlikte düşünülür.*
4. **Olgular (danışmana gidecek bilgi):** ne zaman başladı/fark edildi, hangi veri türleri, kaç kişi/kayıt tahmini, hangi klinik(ler), veri kime açıldı/sızdı, hâlâ sürüyor mu, ne yapıldı. Tahmini sayılar "tahmin" diye işaretlenir; bilinmeyen "bilinmiyor" yazılır.
5. **Danışmana bildir (aynı gün):** `<danışman iletişimi>` **[YAPILACAK]**. Kararı o verir: bu bir ihlal mi? Kuruma (KVKK Kurulu) ve/veya ilgili kişilere bildirim gerekir mi? Hangi sürede? Bildirimi **kimin** (veri sorumlusu klinik mi, Vetinity veri işleyen olarak mı) yapacağı sözleşmeye bağlıdır (veri işleyen sözleşmesi K3 kapsamında hazırlanır).
6. **Veri sorumlusu kliniğe haber:** veri işleyen rolünde olunuyorsa sözleşmedeki süre içinde kliniğe yazılı bilgi verilir. Süre sözleşmeyle yazılır: `<süre>` **[YAPILACAK]**. *Mevzuattaki sürelerin (kamuoyunda anılan 72 saat dâhil) doğru uygulanışı danışmanla teyit edilmelidir; bu belge bu süreyi doğrulamaz.*
7. **Kayıt:** karar ne olursa olsun, olay, alınan karar ve gerekçesi yazılı tutulur (ihlal kayıt defteri **[YAPILACAK – danışmanla biçim]**).
8. **Düzeltici işler:** kök neden, olay sonrası inceleme (bölüm 3.4), gerekirse teknik KVKK işleri (erişim denetimi, anonimleştirme – Dilim 8).

Her şüphede danışmana gitmek bir yük değil, kuraldır: "bu ihlal değildir" kararını da danışman verir.

## 9. Yedek ve geri yükleme

### 9.1 Hedefler (ADR-014 K2)

- Günlük tam yedek + sık işlem günlüğü yedeği (yönetilen platformun otomatik yedeği); hedef **veri kaybı dakikalar düzeyinde**.
- Saklama **30 gün**, **ayrı konumda**.
- **Ayda bir geri yükleme provası.**
- Sorgu DB'si yedeği zorunlu değil (komut DB'den yeniden üretilebilir; ancak geri yükleme süresini kısaltır).
- RPO/RTO sayıları Dilim 4'te yazılı kabul edilecek: **RPO = `<dakika>`, RTO = `<dakika/saat>`** **[YAPILACAK – şimdilik sayı verilmez]**.
- Şu an hiçbiri kurulu değildir; yedek ve prova olmadan canlıya çıkılmaz (ADR-014 go-live koşulu).

### 9.2 Aylık geri yükleme provası kontrol listesi

Prova **üretimi değil**, ayrı bir hedefe (staging/geçici veritabanı) geri yükler.

- [ ] Prova tarihi ve sorumlusu belirlendi; önceki provanın aksiyonları kapandı.
- [ ] Yedek zinciri seçildi: son tam yedek + sonraki işlem günlükleri / seçilen hedef zaman noktası (örn. "dün 14:37").
- [ ] Yedeklerin **yaşı ve sürekliliği** kontrol edildi (boşluk var mı, 30 gün saklama korunuyor mu, ayrı konumda mı).
- [ ] Geri yükleme başlangıç saati yazıldı (RTO ölçümü için kronometre).
- [ ] Komut DB seçilen zaman noktasına geri yüklendi; kayıt sayıları, son kayıt zamanı ve **kayıp tahmini (RPO ölçümü)** not edildi.
- [ ] Gerekirse sorgu DB'si yeniden üretildi/geri yüklendi; API geri yüklenen veriye bağlandı (gizli bilgiler platformdan).
- [ ] `/health/ready` yeşil; giriş; örnek hasta/muayene/ücret/ödeme kayıtları açıldı; bakiye toplamı örnekle uyumlu.
- [ ] Geri yüklenen ortamdaki kişisel veri provadan sonra **silindi** (kopya kalmadı).
- [ ] Ölçülen RPO/RTO yazıldı; hedefle karşılaştırıldı; sapma aksiyona bağlandı.
- [ ] Prova sonuç notu kaydedildi (tarih, kim, süre, sorun, aksiyon).
- [ ] Yedek şifrelemesi ve erişim yetkileri gözden geçirildi (kimler yedeğe erişebilir).

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
- Geri dönüş: Vetinity'yi bırakma kararı verilirse klinik zaten eski yöntemdedir; Vetinity verisi talep üzerine dışa aktarılır (dışa aktarma biçimi **[YAPILACAK]**; bugünkü rapor Excel/CSV dışa aktarımı tam veri dışa aktarımı değildir).
- Pilot kapsamı önce Aşama 1–3 senaryolarıdır (muayene, geliş, ücret ve ödeme) (K9); diğer ekranlar kullanılabilir ama gölge dönemde kritik sayılmaz.
- İlk gün: eğitim oturumu (kullanıcı kılavuzuyla), ilk hafta günlük kısa görüşme **[ÖNERİ]**.

## 11. Go-live öncesi hazırlık özeti (hepsi açık)

ADR-014'e göre canlı koşulları: Dilim 1 (sertleştirme), 3 (ortam), 4 (yedek + geri yükleme provası), 5 (izleme), 6 (e-posta), 7 (içe aktarma), KVKK danışmanlığı ve Dilim 10 provası. Bu kılavuz için ek olarak:

- [ ] Bölüm 2 iletişim bilgileri dolduruldu.
- [ ] Destek kanalı kuruldu ve klinik bilgilendirildi.
- [ ] Olay yönetimi masa başı provası yapıldı (örnek S1 senaryosu, şablonlarla).
- [ ] Sürüm geri alma provası ve yedekten dönüş provası yapıldı.
- [ ] Bakım penceresi klinikle anlaşıldı.
- [ ] KVKK danışmanı atandı, ihlal akışı (bölüm 8) onunla gözden geçirildi.
- [ ] Bu kılavuzdaki **[YAPILACAK]** ve `<...>` alanları kalmadı veya bilinçli ertelendi.

### 11.1 İlk canlı kurulumda bekleyen teknik adımlar (2026-10-28)

Kod `main`'de hazır; aşağıdakiler yalnız yerel geliştirme ortamında uygulandı. Canlıya geçiş kullanıcı söyleyince, bölüm 5.2–5.3 sırasıyla yapılır.

**Veritabanı**
- [ ] Migration'lar: `AddBillingPeriod` (yıllık ödeme, BILL-001), `AddCheckoutDuplicatePaymentRefund` (çift ödeme iadesi, BILL-005), `AddOwnerAccountDeletion` (portal hesap silme, ADR-041). Üçü de yalnız yerel DB'de uygulandı.
- [ ] SQL Server bellek sınırı (`max server memory`) ve servis hesabına "Lock pages in memory".

**Uygulama ayarları (ortam değişkeni; `appsettings.Production.json` yayına girmez)**
- [ ] `AllowedHosts` gerçek api alan adını içerir (ADR-033: `api.vetinity.com`); yoksa iyzico dönüşü ve webhook 400 alır.
- [ ] `Billing:DefaultCheckoutProvider` = `Iyzico` (Manual yalnız geliştirme; Stripe yıllıkta reddedilir).
- [ ] Ad değişikliği: `PerformanceDiagnostics:MediatRSlowMs` → `PerformanceDiagnostics:MediatorSlowMs` (eski ad okunmaz).
- [ ] Yeni ayar `Outbox:ClaimLeaseSeconds` (varsayılan 300; çok örnekli çalışmada outbox claim süresi).
- [ ] iyzico canlı anahtarları yenilenmiş hâliyle gizli depoda (sandbox anahtarı kullanılmaz).

**Sunucu ve altyapı**
- [ ] .NET 10 Hosting Bundle (IIS) ya da eşdeğer çalışma zamanı.
- [ ] Alan adı düzeni (ADR-033): `www`, `panel`, `portal`, `api`; frontend CI'da `API_BASE_URL` canlı api adresi.
- [ ] ClamAV: yüklenen dosyalar arka planda taranır, şüpheli dosya karantinaya alınır (karar verildi, kurulum burada).
- [ ] Dosya deposu (`FileStorage:RootPath`) için disk yedeği; DB yedeğiyle aynı saklama düzeni (bölüm 9).

**İlk açılış doğrulaması**
- [ ] İlk platform yöneticisi `DbMigrator create-platform-admin` ile açılır; bir kez giriş yapılır ve yönetici sayfaları (satış ortakları, deneme metrikleri, çift ödemeler) açılır.
- [ ] Gerçek kartla küçük tutarlı bir iyzico ödemesi uçtan uca denenir (ödeme → dönüş → abonelik etkin); webhook'un da geldiği günlükten görülür.
- [ ] Arka plan işleri canlıya yakın ortamda bir tur gözlenir: içe aktarma, hatırlatma gönderimi, outbox claim (O3), ödeme uzlaştırma.

## 12. Kullanıcı kararı gerektirenler

1. Önem derecesi hedef süreleri ve güncelleme sıklığı (bölüm 3.1) uygun mu?
2. Destek kanalı: hangi e-posta/telefon/mesajlaşma aracı? Mesai saatleri?
3. Nöbet düzeni: mesai dışı S1'de kim aranır?
4. Bakım penceresi için tercih edilen saat.
5. Olay sonrası inceleme notlarının saklanacağı yer (ürün deposu mu?).
6. Gölge dönem çıkış ölçütleri ve fark listesinin tutulacağı araç.
7. RPO/RTO sayıları (ADR-014 K2 Dilim 4'te kabul edilecek).

## 13. Doğrulanmayanlar

- Hiçbir ortama bağlanılmadı; sağlık uçları, yedekler, uyarılar çalıştırılmadı. Yukarıda "var" denen her şey backend belgesi/kod okumasından alındı.
- Yönetilen bulut (Azure) hizmetlerinin yedek/geri yükleme özellikleri, saklama süreleri ve komutları bu belgede **anlatılmadı** (hesap yok; platforma özgü adımlar kurulumda eklenecek).
- `DbMigrator` komut sırası ve Query DB'nin pilotta (bayraklar kapalı) şema güncelleme gereksinimi üretim runbook'unda doğrulanacak.
- Kişisel veri ihlaline ilişkin yasal süreler ve sorumluluk dağılımı doğrulanmadı (hukuki konu).
- Hesap kilitleme yok; izin değişikliğinde oturum iptali yalnız dört yönetim komutuyla ve access token süresi kadar gecikmeyle (backend `SECURITY_CONFIGURATION.md`'den alındı, kod çalıştırılmadı). Bölüm 8 adım 3 ihtiyatlı yazıldı.
- Backend `CI_CD.md`, `SECURITY_CONFIGURATION.md` ve izleme sözleşmesi okundu; CI iş akışları GitHub'da çalışmadığı için CI davranışı doğrulanmadı. İzleme sözleşmesi `main`'de değil, değişebilir.
- Destek erişimi (davet/üyelikten çıkarma) backend belgesinde de "uç yolları ve arayüz adımları doğrulanmadı" diye geçiyor.
- Önem derecesi süreleri, mesai saatleri ve nöbet düzeni öneridir; hiçbiri kararlaştırılmadı.
