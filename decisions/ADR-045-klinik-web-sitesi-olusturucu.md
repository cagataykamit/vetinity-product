# ADR-045 — Klinik web sitesi oluşturucu

## Durum

**Kabul edildi (2026-11-07).** "Kullanıcı" yazan maddeler kullanıcının kararıdır. "Öneri" yazanlar ajan önerisidir; kullanıcıya bildirildi, itiraz gelmedi. Kullanıcı farklı derse yalnız ilgili K maddesi değişir.

Kaynak: kullanıcının 2026-11-07 tarihli modül metni, üç öncelikli özelliği ve taslak üzerindeki seçimleri. Taslak: FE `taslak/klinik-web-sayfasi`, `src/app/pages/taslak/site-olusturucu/`, `f703f27b` (main'e alınmaz).

İlgili: [TIER-002](../backlog/feature-backlog.md#tier-002--klinik-web-sitesi-oluşturucu) (bu ADR ilk sürüm sınırlarını değiştirir), [ADR-033](ADR-033-alan-adi-ve-adres-duzeni.md), [ADR-034](ADR-034-tanitim-sitesi-konumlandirma.md), [ADR-035](ADR-035-paketler-ve-fiyat.md), [ADR-040](ADR-040-kiraci-izolasyonu-global-filtre.md), [ADR-042](ADR-042-online-randevu-talebi.md), [ADR-044](ADR-044-ai-eklentisi-kredi-ve-fon.md).

## Bağlam

- Web sitesi olmayan klinik, müşterisine gönderecek bir adres bulamıyor. TIER-002 bunu ortak şablonlu tek sayfa ve 5 adımlı sihirbazla çözmeyi öneriyordu.
- Kullanıcı hedefi büyüttü: sonuç hazır tema gibi değil, ajansın teslim ettiği özel proje gibi görünmeli. Öncelik sırası: tasarım kalitesi, kullanım kolaylığı, canlı önizleme, kişiselleştirme, SEO ve performans, ölçeklenebilir mimari.
- Kod gerçekleri (2026-11-07, okundu):
  - `Clinic` alanları: ad, il, ilçe, telefon, e-posta, adres, açıklama. Logo, slug, slogan, WhatsApp, konum, sosyal medya yok.
  - `ClinicWorkingHour` ve `ClinicOnlineBookingSettings` (açık/kapalı, `BookingCode`) var.
  - `StoredFile` kiracı, klinik ve sahip kaydına bağlı; herkese açık görsel kavramı yok.
  - Yalnız kullanıcı sınırı zorlanıyor; paket özelliği kuralı yok (TIER-001).
  - FE'de SSR yok; `projects/` altında yalnız portal var.

## Kararlar

### K1 — Kapsam (kullanıcı)

Tek sayfa değil, çok sayfalı site. Sihirbaz 7 adım: klinik bilgileri, marka kimliği, tasarım seçimi, sayfalar, içerik, SEO ve teknik, son kontrol ve yayın. Sayfalar açılıp kapanır. Varsayılan: Ana Sayfa, Hakkımızda, Hekimlerimiz, Hizmetlerimiz, Hizmet Detayları, Sağlık Rehberi, Galeri, İletişim. İsteğe bağlı: Acil, SSS, Randevu, Ekibimiz, Şubelerimiz.

TIER-002'deki "ekip fotoğrafı yok" sınırı kalkar. Fiyat, kampanya ve hasta verisi yine yoktur.

### K2 — Klinik başına bir site, sürümleme (kullanıcı)

Klinik başına bir aktif site vardır; çoklu site yok. Taslak ile yayınlanmış sürüm ayrı tutulur. Her yayın değişmez bir sürüm olarak saklanır, önceki sürüme dönülebilir.

Öneri: dönüş, eski sürümü taslağa kopyalar; yayınlamak yine kliniğin onayıyladır. Saklanan sürüm sayısına üst sınır uygulamada belirlenir.

### K3 — Sihirbaz ve çizim motoru bağımsız (kullanıcı)

Motor yalnız site yapılandırmasını alıp çizer, sihirbazdan hiçbir şey almaz. Bölüm alternatifleri bir kayıt defterinden gelir; yeni tasarım paketi sihirbaz kodunu değiştirmez. İçerik ve tasarım yapılandırması ayrıdır. Önizleme ve yayın aynı bileşenleri çizer.

### K4 — Bölüm tabanlı tasarım, dört konsept (kullanıcı)

Konseptler: Modern, Premium, Friendly, Nature. Kadran oluşturucuda yoktur. Konsept, bölüm alternatifleri ile renk, font ve köşe için hazır bir başlangıçtır; klinik sonra bölümleri tek tek değiştirir. Hero, hizmetler, ekip, galeri ve footer için alternatifler zorunludur. Farklı konseptlerin bölümleri bir arada bozulmadan çalışır.

### K5 — Otomatik tasarım önerisi kural tabanlı (öneri)

Klinik kimliğine göre öneri istendi (kullanıcı). Öneri açık kurallarla çalışır: renk, hekim ve hizmet sayısı, kliniğin karakter seçimi, logodan çıkarılan renk. Nedenini tek cümleyle söyler, değiştirilebilir, kontrastı bozmaz. AI yoktur; AI kredi ve maliyet konusu ayrıdır (ADR-044).

### K6 — Yorum yok, kendi alan adı sonra (kullanıcı)

- Hasta sahibi yorumları sitede ve sihirbazda yoktur.
- İlk sürümde herkes `vetinity.com/k/{adres}` altında yayınlanır. Kendi alan adı sonraki iştir.

### K7 — Fotoğraf (kullanıcı; ayrıntı öneri)

Klinik yüklemediği yerde Vetinity'nin hazır fotoğrafı görünür (kullanıcı). Seti kullanıcı sağlayabilir; sağlayana kadar taslaktaki fotoğraflar yer tutar.

Öneri:
- Set dosya olarak bizim depolamamızda durur, kaynak ve lisans kaydıyla. Üçüncü taraf adresinden çizilmez. Kullanıcının seti gelene kadar bu set canlıya çıkmaz; lisansı ve kişi hakkı doğrulanmadı.
- Hazır fotoğraflar yalnız hayvan görselidir: klinik içi ya da çalışan görünmez, müşteri kliniği olduğu gibi sanmasın.
- Galeri hazır fotoğrafla doldurulmaz; yükleme yoksa görünmez. Hekim kartında fotoğraf yoksa monogram çizilir.
- Sihirbaz hangi görsellerin hazır fotoğraf olduğunu gösterir ve değiştirmeyi önerir. Yayında hazır fotoğraf "temsili görsel" ibaresi taşır.
- Araştırma (`research/klinik-sitesi-kurallari-2026-11.md`): Unsplash ve Pexels koşulları, görselleri ürün içinde set olarak müşterilere sunmaya sınır getiriyor olabilir. Set için ürün içi kullanıma izin veren ücretli lisans ya da kendi çekim tercih edilir; her görsel için kaynak ve lisans kaydı tutulur. Sonuç hukukçuya sorulur.
- Set gelene kadar kayıt noktası boş kalır; görselsiz düzenler çizilir.

### K8 — Veri kaynağı (öneri)

Kural tek yerde kalsın diye ad, il, ilçe, adres, telefon, e-posta ve saatler klinik kaydından okunur; sihirbazda değişince klinik kaydına yazılır ve bu ekranda söylenir. Slogan, logo, WhatsApp, konum, sosyal medya, tanıtım, hizmet, hekim kartı ve yazılar site yapılandırmasındadır. Hekim kartı panel kullanıcısından bağımsızdır; böylece kullanıcı kaydındaki kişisel veri siteye kendiliğinden geçmez.

### K9 — Yayın akışı (öneri)

Yayın öncesi zorunlu liste: ad, telefon, adres, en az bir saat satırı. Diğer eksikler uyarıdır. "Değişiklik var, yayında değil" şeridi, sayfayı geçici kapatma ve kapalıyken açıklayıcı sayfa vardır. Bağlantı ve QR yayından sonra verilir. Geri al, yinele ve otomatik kaydetme taslak için geçerlidir.

### K10 — Adres (öneri)

`{adres}` klinik adından önerilir, klinik değiştirir; benzersizdir, ayrılmış sözcükler alınamaz. Değişince eski adres yeni adrese yönlenir ve başkasına verilmez; kısa bağlantı ve QR çalışmaya devam eder. Yayınlanmış site adresini en çok 3 kez değiştirebilir, sonrası için destekle iletişime geçer (kullanıcı). Hiç yayınlanmamış sitedeki değişiklik sayılmaz.

### K11 — Randevu (öneri)

Randevu düğmesi kliniğin portal bağlantısındaki (`/randevu/{kod}`) mevcut talep formuna gider; site içinde ikinci form kurulmaz, kural ve e-posta kodu tek yerde kalır (2026-11-07 kararı). Taslaktaki site içi form ürüne geçmez. E-posta kodu ve hız sınırı aynı kalır. Online randevu kapalıysa düğme telefona döner. Bu sürümde sitede müsait saat gösterilmez; herkese açık uç TIER-017'dir. Randevu kodunun site üzerinden görünmesi ADR-042'deki tahmin edilemezlik varsayımını zayıflatır: koruma kod doğrulama ve hız sınırına dayanır, klinik kodu yine yeniler.

### K12 — Yayın altyapısı (öneri, teknik)

- Site ayrı Angular uygulamasıdır (`projects/`): panel kodu ve oturumu ile aynı pakete girmez. Motor paylaşılan klasördedir, panel önizlemesi de onu kullanır.
- Sayfalar sunucuda üretilir (Angular SSR): adresler dinamik olduğundan derleme anı prerender yetmez; paylaşım botları JS çalıştırmaz, ilk görünüm de hızlı olmalıdır.
- Bu, sunucuda yeni bir Node süreci demektir. Barındırma, DNS ve yönlendirme işleri kullanıcı söyleyince yapılır; `vetinity.com/k/...` için ADR-033 geçişi gerekir. Ajan kendiliğinden dağıtım yapmaz.
- Google Fonts bağlantısı üründe yoktur, fontlar bizim sunucudan gelir (`@fontsource`, OFL-1.1; depoda Inter için aynı yol kullanılıyor). Üçüncü taraf harita gömülmez, bağlantı verilir.
- Herkese açık görsel için ayrı küçük varlık türü eklenir; `StoredFile`'daki hasta dosyalarının erişim kuralı değişmez.
- Görsel küçültme yüklemeden önce tarayıcıda yapılır, backend'e görsel kütüphanesi eklenmez (2026-11-07 kararı): lisans ve yerel bağımlılık yükü yoktur. Backend tür ve boyut sınırını yine zorlar. Ölçü sunucuda garanti edilmediği için tek görselden çok boyut üretilmez; gerekirse sonra değerlendirilir.
- SSR ile hız sınırı: site sunucusundan gelen istekler tek IP görünür; gerçek istemci IP'sinin güvenli iletimi yayın altyapısıyla birlikte çözülür.

### K13 — Paket (kullanıcı: "hepsinde olsun")

Site oluşturucu Temel, Profesyonel ve Kurumsal'ın hepsindedir; önceki "Profesyonel ve Kurumsal" kararının yerine geçer. Paket kilidi gerekmez, TIER-001'e bağlı değildir. Paket düşürme siteyi etkilemez. Paketler sayfasına satır, modül çalışınca eklenir (ADR-034).

**Abonelik biterse (kullanıcı: "Hemen kapansın"):** deneme ya da dönem bitip abonelik salt okunur olduğunda ve iptalde site ek süre olmadan kapanır; müşteri açıklayıcı kapalı sayfa görür. Öneri: veri silinmez, ödeme yapılınca son yayınlanan sürüm kendiliğinden geri gelir; klinik elle kapattıysa kapalı kalır; pasif kiracıda site bulunamaz (404). Salt okunur kiracı elle kapatamaz; site zaten kapalı olduğundan sorun oluşmaz.

### K14 — İzolasyon ve içerik sınırları (öneri)

Site kayıtları kiracı filtresi altındadır (ADR-040); herkese açık uç yalnız yayınlanmış sürümün çıktısını döner, taslağı ya da kiracı kimliğini döndürmez. Hasta verisi siteye girmez. Sayfa içi hazır metinler elle yazılır; üstünlük, kliniğe dair doğrulanmamış iddia ve tıbbi iddia içermez.

Reklam sınırı (2026-11-07 kaynak okuması, hukuk görüşü değil): 6343 sayılı Kanun md. 41 reklam ve propaganda niteliğindeki ifadeleri internette de yasaklıyor; hizmet listesi ve hekim tanıtımının nerede reklama dönüştüğü net değil. Çalışma varsayımı: site bilgilendirme amaçlıdır. Fiyat, kampanya, "ücretsiz", "garanti", "en iyi", rakip kıyası, müşteri yorumu, önce/sonra görseli sunulmaz. Sihirbaz serbest metindeki bu tür sözcüklerde uyarı verir, engellemez; uymak kliniğin sorumluluğundadır. Bilgilendirme metni ve bu uyarılar hukukçu görüşüne kadar "taslak" sayılır.

## Sonuçlar

- **Backend:** site, sürüm ve adres kayıtları, herkese açık görsel, yönetim ve herkese açık uçlar, sözleşme belgesi. Migration yalnız yerel veritabanına.
- **Frontend:** paylaşılan motor ve dört paket, panelde Ayarlar kartı ve sihirbaz, ayrı site uygulaması. Taslak kod taşınırken `anyComponentStyle` bütçesi aşılıyor (panel 4 KB): bileşen başına stil bölünür ya da site uygulamasına ayrı bütçe verilir.
- **Tanıtım:** çalışmadan sitede yazılmaz.

## Uygulama sırası (öneri)

1. Backend: site, sürüm, adres; yönetim uçları; herkese açık görsel.
2. Panel: motor ve dört paket taşınır; sihirbaz gerçek veriye bağlanır; önizleme.
3. Site uygulaması ve SSR; randevuya bağlantı; SEO çıktıları, sitemap, robots.
4. Yayın sonrası: QR ve paylaşım, adres yönlendirmesi, geçici kapatma, sürüme dönüş.
5. Canlı: fotoğraf seti, ADR-033 geçişi, dağıtım (kullanıcı söyleyince).

## Değerlendirilen seçenekler

- **Ortak şablonlu tek sayfa (eski TIER-002):** az iş, ama kullanıcının "hazır tema gibi görünmesin" ölçütünü karşılamaz.
- **Tema seçimi:** bölüm farkı yok, rakipten ayrışma zayıf.
- **Backend'in kabuk HTML'e meta etiket koyması (SSR yerine):** Node süreci gerekmez ve paylaşım önizlemesini çözer; ama içerik JS'siz görünmez, ilk görünüm yavaşlar. Altyapı zorlanırsa geçici yol olarak kalır.
- **Klinik başına çoklu site:** yönetimi zorlaştırır, kullanıcı istemedi.
- **AI ile metin ve tasarım:** ADR-044 kredi kararından bağımsız sonra eklenebilir; ilk sürüme girmez.
