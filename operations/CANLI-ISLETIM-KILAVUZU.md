# Vetinity canlı işletim kılavuzu

**Durum:** Taslak v0.1 (2026-10-13). Aşama 9 Dilim 11. Kaynaklar: [ADR-014](../decisions/ADR-014-pilot-and-production-operations.md) (K1–K9), backend `docs/ASAMA9_READINESS.md` (keşif; yalnız kod/belge okuması), backend `docs/deploy/*` ve `docs/cqrs/cqrs-11b-operations-runbook.md`.

## Bu belge nasıl okunur

- Bu belge **yöntem ve beklentiyi** yazar. Ürün canlıda değildir; altyapı henüz kurulmamıştır.
- **[YAPILACAK]** = henüz kurulmamış veya kararlaştırılmamış. Uydurma değer yoktur; boşluklar `<...>` ile işaretlidir ve doldurulacaktır.
- **[ÖNERİ]** = kullanıcı kararı bekleyen öneri (bölüm 12).
- Hosting yönetilen bulut (Azure) varsayımıyla düşünülmüştür (ADR-014 K1) ama adımlar platformdan bağımsız yazıldı. Platform adı geçen yerde "yönetilen platform" denir.
- Bu belge hukuki tavsiye değildir (bölüm 8).

## 1. Mevcut durum özeti (neden çoğu madde "yapılacak")

Backend keşfine göre (2026-10-13, kodu/belgeyi okuyarak; hiçbir ortama bağlanılmadı):

| Konu | Durum |
|---|---|
| Üretim/staging ortamı | Kurulu olduğuna dair kanıt yok; yalnız tasarım/runbook belgeleri var (Windows IIS hedefli; ADR-014 K1 bunu yedek plan sayar) |
| CI/CD, sürüm etiketi | Yok (API sürümü kodda sabit `1.0.0`, git etiketi yok) |
| Yedekleme / geri yükleme | Repoda tanımlı değil, hiç denenmedi |
| Hata izleme / uyarı aracı | Yok. Var olanlar: Serilog dosya günlüğü, `/health/live`, `/health/ready`, OpenTelemetry çıktısı (toplayıcı yok) |
| Olay yönetimi / destek | Yok (bu belge ilk taslak) |
| Sabit parolalı varsayılan yönetici | Kodda var; Dilim 1 ile kaldırılacak (K7). Kaldırılana dek üretimde `seed` çalıştırılmaz |

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

- Her birleşmede otomatik derleme/yayın yok; sürüm numarası ve etiketi yok **[YAPILACAK – Dilim 2]**.
- API açılışta migration/seed **çalıştırmaz**; veritabanı değişikliği yalnız `DbMigrator` komutlarıyla yapılır (`migrate`, `migrate-query`, `seed`).
- EF migration'ında **geri alma (down) yoktur**; veritabanını geri almanın yolu **yedekten dönüş** (backend runbook'u: "yedekten dönüş").
- İdempotent migration SQL betiği üretimi henüz yok **[YAPILACAK – Dilim 2]**.
- Tam entegrasyon test paketi yeşil değil (bilinen kırık testler) → sürüm kesmeden önce "temiz referans" gerekir.

### 5.2 Sürüm öncesi (her canlı yayından önce)

- [ ] Yayın içeriği listelendi (hangi commit/etiket, hangi migration var, izin/seed değişikliği var mı).
- [ ] Etiketli, birleşik sürüm. **Seed yalnız etiketli birleşik sürümden çalıştırılır**; farklı dallardan seed izinleri birbirinden siler.
- [ ] Testler: Domain + Application + ilgili entegrasyon sınıfları geçti; tam paket sonucu ve bilinen kırıklar açıkça not edildi.
- [ ] Staging'de aynı sürümle migration + temel kabul denendi **[YAPILACAK – staging kurulunca]**.
- [ ] **Yedek alındı ve alındığı doğrulandı** (bölüm 5.3 adım 1).
- [ ] Migration varsa **kullanıcı onayı alındı** (migration başına; paylaşılan/üretim DB'ye onaysız uygulanmaz).
- [ ] Bakım penceresi planlandı ve klinik bilgilendirildi (bölüm 6).
- [ ] Geri alma planı yazılı: önceki yayın paketi saklı, yedek noktasının saati kayıtlı.
- [ ] Yeni izinler (`*.Read` vb.) varsa: özel roller elle güncellenecek mi, notlandı.

### 5.3 Yayın adımları (özet)

1. **Yedek:** veritabanı yedek noktası kaydedilir (saat + doğrulama). Yönetilen platformda anlık görüntü/nokta-zaman yedeği de not edilir.
2. Bakım penceresi başlar; gerekirse klinik kullanıcılar çıkış yapar.
3. Yeni API paketi dağıtılır; gizli bilgiler platformun gizli deposundan gelir (dosyaya yazılmaz).
4. `DbMigrator migrate` (komut DB), ardından `migrate-query` (sorgu DB'si; pilotta okuma bayrakları kapalı olsa da bağlantı ve şema zorunludur) **[YAPILACAK – üretim runbook'unda doğrulanacak]**.
5. Yalnız gerekiyorsa `seed` (etiketli sürümden). Sonrasında kullanıcılar **çıkış-giriş** yapar (izinler yenilensin).
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
- Serilog dosya günlüğü; yavaş SQL günlüğü (eşik 200 ms).
- Hata yanıtlarında `traceId`/`correlationId`.
- OpenTelemetry iz/metrik çıktısı (toplayıcı yapılandırılırsa).

### 7.2 Beklenen ama kurulmamış olanlar **[YAPILACAK – Dilim 5]**

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
3. **Durdur:** erişim kapatılır (ilgili hesabın parolası/oturumu iptal, sızan anahtar döndürme, ilgili özelliğin kapatılması). *Not: bugünkü sistemde hesap kilitleme yok ve izin değişikliği açık oturumları hemen kesmez (SEC-001/SEC-002 ertelendi); bu yüzden hesap devre dışı bırakma + parola sıfırlama + gizli anahtar döndürme birlikte düşünülür.*
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
- Hesap kilitleme ve izin değişince oturum iptali yok (SEC-001/002 ertelendi); bu yüzden bölüm 8 adım 3 ihtiyatlı yazıldı.
- Önem derecesi süreleri, mesai saatleri ve nöbet düzeni öneridir; hiçbiri kararlaştırılmadı.
