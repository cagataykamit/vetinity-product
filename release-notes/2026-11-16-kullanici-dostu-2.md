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

## Ek yayın: 2026-11-16 18:40 (TSİ), portal tüm paketlerde, E-vet tür düzeltmesi, aktarma notları

**Yayınlanan:** backend `main` `8cab1afe`, panel `main` `43c2bff7` (`main-AKGG5PH7.js`). Portal derlemesi değişmedi (`main-ZS3H6KLO.js`), yeniden yayınlanmadı.
**Migration:** `AddImportBatchWarnings` (`ImportBatches.WarningsJson`); `migrate` ve `migrate-query` çalıştırıldı, seed gerekmedi.
**Yedek:** Migration'dan önce elle yedek alındı (18:39, Drive kopyası doğrulandı).
**Doğrulama:** API `/health/ready` 200, tüm girdiler Healthy; yayın sonrası günlükte hata yok; panel yeni `main` dosyasıyla açılıyor; www 200.

- **Hasta sahibi portalı ve portaldan randevu talebi Temel dahil tüm paketlerde** (kullanıcı kararı, ADR-035). Paket kartlarındaki "Kimin için" metinleri düzeltildi: Temel "Tek şubeli, küçük ekipli klinik", Profesyonel "Tek şubeli, ekibi büyüyen klinik", Kurumsal "Birden çok şubesi ya da büyük ekibi olan klinik".
- **E-vet aktarması, türü belirsiz hasta:** E-vet türü seçilmemiş hastaya "Diğer" yazıyor. Böyle bir hastanın türe özgü aşıları hep aynı türü gösteriyorsa hasta o türle gelir (ör. yalnız köpek aşısı olan hasta Köpek); önizlemede "Türü aşılarından çıkarıldı" notu çıkar. Aşılar farklı türleri gösteriyorsa ya da türe özgü aşı yoksa tür Diğer kalır, aşılar reddedilmez, uyarıyla gelir. Türü açıkça yazılı ve aşıyla çelişen satır eskisi gibi reddedilir.
- **Aktarma notları satır satır:** "Dosya okunurken N not çıktı" paneli her notu tek satırda gösterir: sayı, ne olacağı, konu, tür (karar, dikkat, bilgi, aktarılmayacak). Karar bekleyen not baştan açık gelir ve "Sizden beklenen"e götürür; ayrıntı tıklayınca açılır; başlıktaki tür sayıları filtre. Notlar aktarmaya kaydedilir; sayfa yenilenince ya da geçmişten açılınca kaybolmaz.
- **Bilinen sınırlar:** Ekranlar canlıda tarayıcıda denenmedi. Aktarma notları gerçek bir E-vet yedeğiyle değil, yerel örnek yedekle denendi; bu yayından önce yapılmış aktarmaların notları kayıtlı olmadığı için eski partilerde görünmez. Nottan satır incelemesine filtreyle gitme sonraki işte. Testler: backend 1326 domain, 4343 uygulama ve 2131 entegrasyon testi geçti, 4 atlandı; panel 3329 testten 3328'i birleşik koşuda geçti, düşen 1 test (`primeng-select-behavior`, eşzamanlı backend testi yükü altında zamanlama) tek başına 4/4 geçti.

## Ek yayın: 2026-11-16 22:38 (TSİ), aktarma geri alma süresi, kilitlenme düzeltmesi, RCSI

**Yayınlanan:** backend `main` `b7afdfbf`, panel `main` `faf4ce00` (`main-WCYXYUFV.js`). Portal değişmedi.
**Migration:** `EnableReadCommittedSnapshot` (ADR-050, [işletim notu](../operations/veritabani-rcsi.md)). Komut veritabanında READ_COMMITTED_SNAPSHOT açıldı; Zonguldak veritabanına dokunulmadı. Öncesinde migration girişinin yetkisi doğrulandı (db_owner), süren aktarma işi yoktu. `migrate` ve `migrate-query` çalıştırıldı.
**Yedek:** Migration'dan önce elle yedek alındı (22:38).
**Doğrulama:** `is_read_committed_snapshot_on = 1`; API `/health/ready` 200, tüm girdiler Healthy; yayın sonrası günlükte uyarı yok; panel yeni `main` dosyasıyla açılıyor.

- **Neden:** 21:38'de DOGUSZONGULDAK'ın aktarma geri alması 3750/8799 birimde durdu. Yalnız okuyan bir basınç ölçümü outbox güncellemesiyle kilitlendi (SQL 1205) ve iş tümüyle başarısız sayıldı. Veri bozulmadı; her birim kendi işleminde.
- **Geçici veritabanı hataları işi düşürmez:** aktarma, geri alma, outbox, projeksiyon ve hatırlatma işçileri kilitlenme ve benzeri geçici hatalarda kısa bekleyip üç kez daha dener (`TransientSqlRetry`, kural tek yerde).
- **Geri alma 30 gün açık:** aktarma uygulandıktan 30 gün sonra kesinleşir; listede son tarih yazar, süre dolunca "Kesinleşti" görünür ve geri al sayfası açıklama gösterir.
- **Sade liste:** aktarma listesi varsayılan olarak geçerli partileri gösterir; geri alınanlar ve kapanmış taslaklar "Durum" filtresinden açılır.
- **Bilinen sınırlar:** Ekranlar canlıda tarayıcıda denenmedi. Kilitlenme gerçek yük altında değil, testte sahte 1205 hatasıyla canlandırıldı. RCSI'yle davranışı değişebilen üç yer ve zaten yarışa açık yerler (token yenileme, randevu çakışması, sınırlar) ayrı işte ele alınıyor. Testler: backend 1337 domain, 4343 uygulama ve 2142 entegrasyon testi geçti, 4 atlandı; panel 3340, portal 267, site 42 testin hepsi geçti.
