# 2026-11-16 — Sürüm notu (kullanıcı dostu 2., 3. ve 4. dalga, virüs taraması)

**Tarih:** 2026-11-16, 03:47 (TSİ)
**Yayınlanan:** backend `main` `f0112187`, panel `main` `7ad9e655` (`main-X4GKS45I.js`). Portal derlemesi değişmedi (`main-ZS3H6KLO.js`), yeniden yayınlanmadı. Klinik siteleri değişmedi.
**Migration:** Yok.
**Yedek:** Yayından önce elle yedek alındı (03:45, Drive kopyası doğrulandı).
**Doğrulama:** API `/health/ready` 200 (`clamav`: "clamd yanıt veriyor."), yayın sonrası günlükte hata yok, panel yeni `main` dosyasıyla açılıyor, www 200.
**Kaynak:** [Kullanıcı dostu denetimi](../research/kullanici-dostu-denetim-2026-11-15.md), O1–O3, O5–O10, B1–B4.

## Formlar ve seçiciler (2. dalga)

- **Yerinde ekleme (O1):** Tür, ürün kategorisi, yatış bölümü ve odası, kasa türü, randevu nedeni seçicilerden tek tıkla eklenir. Stok hareketi, mal kabul ve şablon satırında ürün hızlı ürün diyaloğuyla eklenir. Irk, renk, desen ve tür listelerinde arama var.
- **Kaydedilmemiş değişiklik (O2):** Oluştur/düzenle sayfaları ve dolu diyaloglar çıkmadan önce "Kaydedilmemiş değişiklikler var. Çıkılsın mı?" diye sorar.
- **Kaydet (O3, B4):** Kaydet düğmesi hep etkin. Eksik alanlar işaretlenir, ilk hataya gidilir ve üstte özet çıkar. Sık formlarda alanlar ortak düzende.
- **Klavye (O8):** Formlarda Ctrl+Enter ile kaydedilir. Diyalog kapanınca odak açan düğmeye döner. Kullanıcı menüsünde "Kısayollar" listesi var.

## Gezinme, yetki ve randevu (3. dalga)

- **Telefon ve tablet (O5):** Dokunmatik ekranda 44 px dokunma hedefi, telefonda sabit Kaydet.
- **İptal (O6):** Kullanıcıyı listeye değil geldiği yere döndürür. Listeler filtreyi korur.
- **Paket ve yetki (O7):** Paket dışı sekme ve kartlar kilit simgesiyle, "Üst pakette" ipucuyla görünür. Salt okunur modda pasif düğmenin yanında kısa neden yazar.
- **Randevu (O9):** Yeni randevuda gün şeridi ve boş saat düğmeleri. Bugün satırından "Randevu al" müşteri ve hasta dolu açılır.
- **Ücret (O10):** Açıklama yazdıkça hizmet ve ürün önerilir.

## Takvim, geri alma ve taslak (4. dalga)

- **Takvim (B1):** Saat ızgaralı görünümde hekim sütunları ve "Boş saat bul" paneli. Hekimi atanmış randevuda çakışma yalnız aynı hekim için kontrol edilir.
- **Randevu iptalinde Geri al (B2):** İptalden sonra kısa süre "Geri al" çıkar. Geri alınabilecek iptal için bekleme listesine otomatik teklif gitmez.
- **Muayene taslağı (B3):** Muayene formu yazıldıkça tarayıcıya kaydedilir. Sayfa yeniden açılınca "Kaydedilmemiş taslağınız var, sürdürülsün mü?" sorulur. Taslak kayıtta, Vazgeç'te, kesinleşmede ve çıkışta silinir.

## Virüs taraması

- Yüklenen dosyalar (görüntüleme ve lab dosyası, klinik sitesi görseli, içe aktarma dosyası) kaydedilmeden önce ClamAV ile taranır. Virüslü dosya reddedilir ve denetim kaydına yazılır. Tarayıcıya ulaşılamazsa yükleme reddedilir.
- Sunucu: ClamAV 1.5.4, clamd yalnız `127.0.0.1:3310`. İmzalar freshclam ile kendiliğinden güncellenir. Ölçülen bellek ~970 MB. Ayrıntı ve geri alma: [CLAMAV-KURULUM.md](../operations/CLAMAV-KURULUM.md).

## Bilinen sınırlar

- Ekranlar tarayıcıda denenmedi; doğrulama yalnız testlerle yapıldı. 3. dalga kısıtlı rollü hesapla ve paketi kilitli klinikle denenmedi.
- Canlıda gerçek bir dosya yüklenerek tarama denenmedi; EICAR test dosyası sunucuda clamd'ye doğrudan gönderildi.
- **Testler (birleşik main):**
  - Backend: 1325 domain, 4329 uygulama ve 2129 entegrasyon testi geçti, 4 test atlandı.
  - Panel: 3289 test geçti (B1–B3 ve 2. dalga birleşimi). 3. dalga dalında main ile birleşik hâlde 3312 test geçti; birleşik main ağacı bu dalla aynı.
  - Portal: 267 testin hepsi geçti.

## Ek yayın: 2026-11-16 15:28 (TSİ), tanıtım sitesi yeni tasarım ve e-belge bölümü

**Yayınlanan:** panel/site `main` `bf166f4a` (`main-2IMRSHC5.js`, `styles-ZDST4IPE.css`). Backend ve portal değişmedi. Migration yok. Yedek 15:28'de alındı.
**Doğrulama:** www ana sayfa, Özellikler, Paketler, İletişim ve panel 200; canlıda Özellikler'de e-belge bölümü görünüyor, başlıklar Nunito ile çiziliyor.

- **Tanıtım sitesi "Sıcak klinik" tasarımında (kullanıcı seçimi C):** ana sayfa, Özellikler, Defterler ve KVKK, Geçiş, Paketler, İletişim. Dört renk tonu (açık ve koyu tema tek yerden), fosforlu vurgu, eğik yapışkan not görselleri; düğmeler lacivert-teal. Ekran görüntüleri büyük ve yakın çekimli, telefonda dar parça gösteriliyor, Özellikler'de bölüm dizini kaydırdıkça işaretleniyor.
- **Yazı tipi:** Nunito uygulamanın kendi dosyalarından yükleniyor (dış yazı tipi sunucusu yok).
- **Özellikler'de e-belge bölümü:** e-Fatura/e-Arşiv tüm paketlerde; metin "desteklenen e-belge sağlayıcıları" diyor, sağlayıcı adı yok. SSS ve Hakkımızda'daki "e-Fatura yok" ifadeleri kaldırıldı.
- **Bilinen sınırlar:** Tarayıcıda kullanıcı ve ajan baktı (1440/768/375, açık/koyu); ekran okuyucu, klavye ve sayfa hızı (LCP/CLS) ölçülmedi. Bazı ekran görüntüleri telefonda küçük kalıyor. Testler: panel 3313 testin hepsi geçti; son hizalama düzeltmesi yalnız CSS, ayrıca derlendi.
