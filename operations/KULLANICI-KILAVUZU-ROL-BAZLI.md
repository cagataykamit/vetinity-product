# Vetinity kullanıcı kılavuzu (rol bazlı)

**Durum:** Sürüm 0.3 (2026-11-22; önceki 0.2 2026-11-20, ilk sürüm 2026-10-13). Pilot klinik eğitimi için. 0.3'te yerel tam testteki (2026-11-22) ekranlara göre Bugün, Hesabı kapat, fazla tahsilat, Ayarlar ve salt okunur mod güncellendi.

> **Menü (canlıdaki panel, 2026-11-20):** **Bugün** · **Randevular** (Liste, Takvim, Talepler, Bekleme listesi) · **Müşteri ve Hasta** (Ara, Müşteriler, Hastalar, Portal gelen kutusu) · **Kayıtlar** (Muayeneler, Tedaviler, Reçeteler, Aşılar, Lab sonuçları, Görüntüleme, Yatışlar, Uygulamalar) · **Para** (Ücretler, Ücret bekleyenler, Ödemeler, Satışlar, e-Belgeler) · **Stok** (Ürünler, Stok durumu, Stok hareketleri, Mal kabul) · **Raporlar** · **Ayarlar**. Sekmeler yetkinize göre görünür. Menü adları kodu okuyarak yazıldı (`panel-navigation.ts`).

> **Bu kılavuz ekran görüntüsü içermez.** Ekran ve düğme adları koddan okundu; gerçek ekranda küçük farklar olabilir. Uygulama tarayıcıda uçtan uca denenmedi (bkz. Bölüm 13 "Doğrulanacaklar"). Kılavuzla ekran uyuşmazsa bunu destek kanalına bildirin.

## 0. Başlamadan önce

### 0.1 Roller ve ne yapabilirler

Rol adları uygulamada **Sekreter** (resepsiyon), **Veteriner** (hekim) ve yönetici düzeyi (**Admin / Owner / ClinicAdmin**) olarak tanımlıdır. Aşağıdaki tablo backend'in varsayılan rol-izin tablosundan (`RolePermissionBindings`) alındı; klinikteki gerçek izinler yönetici tarafından değiştirilmiş olabilir. **Bir düğmeyi göremiyorsanız çoğu zaman yetkiniz yoktur**, hata değil.

| İş | Resepsiyon (Sekreter) | Hekim (Veteriner) | Yönetici |
|---|---|---|---|
| Müşteri / hayvan kaydı | Ekler, düzenler | Okur; hayvanı düzenler (yeni hayvan eklemez) | Evet |
| Randevu | Ekler, iptal eder, gelmedi işaretler, erteler | Ekler, erteler, tamamlar | Evet |
| Geliş kaydı (Bugün) | Ekler, günceller | Ekler, günceller | Evet + **düzeltir** |
| Muayene | Yalnız **okur** | Açar, düzenler, **kesinleştirir**, ek not ekler | Evet |
| Aşı, tedavi, reçete, lab, yatış, vital ölçümü | Yalnız okur | Ekler/günceller (yatışta taburcu; vital ölçümünü düzeltir/iptal eder) | Evet |
| Uygulama (stoktan düşen) | Okur | Ekler, **düzeltir/iptal eder** | Evet |
| Ücret | Ekler | Yalnız okur | Ekler, **düzeltir/iptal eder** |
| Ödeme | Ekler, düzenler | Yalnız okur | Ekler, düzenler, **iptal eder** |
| Ürün / stok hareketi | Ürünleri okur, stok hareketi ekler | Okur | Ürünü ekler/düzenler/pasifleştirir, stok hareketi ekler |
| Raporlar | İlgili modülü okuyorsa görür | İlgili modülü okuyorsa görür | Evet |

Menüde bir öğenin görünmesi o modülün **okuma** izninize bağlıdır. Rapor sayfaları da ilgili modülün okuma iznine bağlıdır (Ödeme Raporu ← ödeme okuma, vb.).

### 0.2 Giriş ve ilk ekran

- Giriş sonrası ilk sayfa **Bugün**'dür (geliş okuma izni olan herkes, yönetici dahil); bu izin yoksa ve bir rapora izniniz varsa **Raporlar**; o da yoksa menüdeki ilk sayfa. (ADR-030 eki, ADR-052.) **Özet** sayfası kaldırıldı; eski `/panel/dashboard` adresi **Raporlar**'ı açar.
- İlk 14 gün Bugün'ün üstünde rolünüze göre kısa adımlı **İlk hafta** rehberi görünür; kullanıcı menüsünden yeniden açılır.
- Çıkış üst çubuktaki **kullanıcı menüsünden** yapılır.
- Üstte **klinik seçici** vardır; çok klinikli hesapta doğru kliniği seçili tutun.
- Abonelik süresi bitmişse kiracı **salt okunur** olur: üstte salt okunur bandı çıkar, kayıtlar görüntülenir ama eklenemez/değiştirilemez. Yazma düğmeleri pasiftir; sayfa düzeyindeki düğmelerin yanında "Salt okunur modda kapalı" yazar. Yönetici **Ayarlar → Abonelik** sayfasından devam eder.

### 0.3 Kısa sözlük

- **Geliş (ziyaret):** hastanın klinikte bugünkü kaydı. Randevulu veya randevusuz olabilir.
- **Bakım durumu:** **Sırada** (geldi, bekliyor) → **Muayenede** → **Tamamlandı**. Gelişi olmayan randevu **Bekleniyor**, gelmeyen **Gelmedi** görünür. **Ödeme durumundan bağımsızdır.**
- **Muayene:** Taslak → **Kesinleştirildi**. Kesinleşen muayene değiştirilmez; sonradan yalnız **ek not** eklenir.
- **Ücret:** müşteriye yazılan borç satırı (ödeme sayılmaz). **Ödeme:** tahsilat; ücretlere **bağlanır**, ücretlerden fazla kısım **müşteri kredisine** yazılır.
- **Müşteri kredisi:** müşterinin fazla ödemesi ya da avansı; sonraki ücretlerde **Krediden** kullanılır.
- Para birimi yalnız **TRY**.

---

## 1. Resepsiyon (Sekreter) – gün akışı

### 1.1 Sabah: Bugün ekranını aç
- **Menü:** **Bugün** (menünün en üstü; girişte açılan sayfa).
- **Başlıktaki düğmeler** (yetkinize göre): **Yenile**, **Randevusuz geliş**, **Yeni randevu**, **Yeni muayene**, **Hızlı satış**. Başlıkta günün durum sayıları yazar.
- **Üst kutular:** bekleyen **online randevu talepleri** (kutucuk ya da Açık işler satırında çip; talep Bugün'den ayrılmadan açılır ve onaylanır), **bekleme listesi** özeti (iptal edilen saate uyan kişi varsa).
- **Liste** seçimi: **Günlük liste / Yanlış işaretlenenler**. **Hastalar** seçimi (yalnız hekim kaydı olan kullanıcıda): **Benim hastalarım / Tümü**. Resepsiyon **Tümü** ile çalışır. Aynı satırda sağda **Açık işler** (önceki günlerden kalan işler).
- **Günlük liste** tek tablodur; ara başlıklar: **Klinikte** (Sırada ve Muayenede olanlar), **Sıradaki randevular** (Bekleniyor), **Tamamlandı** (katlıdır; ödemesi ya da işi kalan satır açık kalır, "… tamamlanan kayıt daha göster" ile hepsi açılır), **Gelmedi**. Ayrı bölümde **Aktif yatışlar**.
- Her satırda sağda **tek ana düğme**, yanında **⋯** (diğer işlemler): randevuda **Geldi**; sıradaki hastada **Muayeneye al** (bakımı başlatır ve muayeneyi açar); muayenedeki hastada **Muayene aç** ve **Hesabı kapat** (ödeme/ücret yetkisi olmayanda **Tamamla**); tamamlanmış ama kalanı olan gelişte **Hesabı kapat**, hiç ücreti yoksa **Ücret ekle**.
- Klinikteki satırda gelişten bu yana süre yazar; **Sırada** bekleyende 30 dk üstü uyarı, 60 dk üstü kritik renk. 12 saatten uzun açık gelişte "Unutulmuş olabilir" notu çıkar.
- Sık hata: Liste boş görünüyor → kapsamın "Benim hastalarım" olmadığına ve doğru kliniğin seçili olduğuna bakın, **Yenile** düğmesine basın.

### 1.2 Hasta geldi – randevulu geliş
1. **Sıradaki randevular** başlığı altında hastanın satırını bulun.
2. **Geldi** düğmesine basın; açılan pencere **Hasta geldi**.
3. Gerekirse **Sorumlu hekim** seçin (randevudaki hekim varsayılan gelir), acil ise **Acil** anahtarını açın.
4. **Geldi olarak kaydet**. Satır **Klinikte** başlığına **Sırada** durumuyla geçer; bilgi mesajı "Geliş kaydedildi".

- Sık hata: "Açık geliş kaydı zaten var" → aynı hasta için yeni kayıt açılmadı; mevcut kayıt listede, onu kullanın. İki kez tıklamak ikinci kayıt üretmez.
- Hasta randevuya gelmedi ve saati geçtiyse: satırdaki **⋯** menüsü → **Gelmedi olarak işaretle**. Yanlışlıkla işaretlendiyse **Gelmedi işaretini geri al** (gerekçe ister).

### 1.3 Randevusuz geliş ve yeni hasta kaydı
1. Bugün ekranı üstünde **Randevusuz geliş**.
2. **Hasta** alanına adı yazıp listeden seçin (mikroçip, telefon, Türkçe harf farkı aramada desteklenir; **doğrulanacak** – Bölüm 13).
3. Hasta kayıtlı değilse: **Yeni müşteri ve hasta ekle** (müşteri ve hayvan tek işlemde kaydedilir; telefon zorunludur). Müşteri kayıtlı ama hayvan yeniyse: **Bu sahibe yeni hayvan ekle**.
4. Gerekirse sorumlu hekimi seçin, **Acil** anahtarını açın, **Kaydet**.

- Sık hata: "Listeden bir hasta seçin" → yazdığınız ad listeden seçilmedi; listeden tıklayın.
- Sık hata: aynı telefonla müşteri zaten varsa yinelenen kayıt uyarısı alırsınız; var olan müşteriyi seçin. (Kural backend'de var; ekrandaki tam mesaj **doğrulanacak**.)

### 1.4 Randevu verme / erteleme / iptal
- **Menü:** **Randevular** → **Liste**, **Takvim**, **Talepler** (online randevu talepleri), **Bekleme listesi** sekmeleri. Takvim ayrı menü öğesi değildir, Randevular içinde bir sekmedir. Takvimin gün görünümünde hekim sütunlarının yanında saatli **Aşılar** sütunu durur; saati girilmemiş aşılar "Saatsiz" başlığında görünür.
- Yeni randevu, erteleme ve iptal bu ekrandan yapılır. Durum etiketleri: Planlandı / Tamamlandı / İptal. Resepsiyon **tamamlama** yapmaz (muayene başlayınca randevu otomatik tamamlanır; **doğrulanacak**).

### 1.5 Yanlış geliş / durum düzeltme
- Yanlışlıkla açılan gelişi **silemezsiniz**. Bunu **yönetici** düzeltir (Bölüm 3.6). Resepsiyon yönetici istemelidir; "Düzelt" menüsü sizde görünmeyebilir.

### 1.6 Ücret girmek ve hesabı kapatmak
Hasta çıkarken **Bugün** satırında **Hesabı kapat** (Bölüm 4.2): ücret bekleyen kalemler, açık ücretler ve tahsilat tek panelde. Ayrı ücret için Bölüm 4.1. Resepsiyon ücret ve ödeme **ekler**, **düzeltemez/iptal edemez**.

### 1.7 Gün sonu
- **Bugün**'de **Klinikte** başlığı altında unutulmuş kayıt kaldı mı? (12 saatten uzun açık gelişte "Unutulmuş olabilir" notu; önceki günden kalan gelişte saat tarihle yazar.)
- **Tamamlandı** satırlarında açık iş çipleri (**Ücret bekliyor (N)**, **Ücret yok**, **Lab bekliyor (N)**, **Ödeme bekliyor**, **Kısmi ödeme**) ve borç/kalan tutarı işi kalanları gösterir; kalanı olan satırda ana düğme **Hesabı kapat**'tır (**⋯ → Ödeme al** da kullanılabilir).
- Gölge dönemde (ilk 2 hafta) günün sonunda eski defterle karşılaştırın (canlı işletim kılavuzu bölüm 10).

---

## 2. Hekim (Veteriner) – gün akışı

### 2.1 Bugün: benim hastalarım
- **Menü:** **Bugün**. Kapsam varsayılan olarak **Benim hastalarım** gelir (size atanmış gelişler); tümünü görmek için **Tümü**.
- **Sırada** olan hastada satırın ana düğmesi **Muayeneye al**: bakımı başlatır (Sırada → Muayenede) ve muayene formunu gelişe bağlı açar. Muayenedeki hastada **Muayene aç** ve **Tamamla** (bakımı bitirir). Acil durumu **⋯ → Acil olarak işaretle / Acil işaretini kaldır** ile değişir.
- Hekim, Bugün'de ücret/ödenen/kalan bilgisini **görür** ama **Hesabı kapat** ve **Ödeme al** yoktur (ödeme alma yetkisi yoktur).

### 2.2 Muayene açmak
- Bugün satırında **Muayeneye al** (sıradaki hasta) ya da **Muayene aç** (muayenedeki hasta): geliş kaydından muayene taslağı açılır, hasta tekrar seçilmez. Alternatif: **Kayıtlar** → **Muayeneler** → **Yeni** ya da randevu detayından.
- Muayene çalışma alanı bölümleri: **Anamnez**, **Değerlendirme / tanı**, **Plan / tedavi planı**, bulgular ve vitaller. Kaydedince ayrıntı sayfasına döner.
- Sık hata: Başka biri aynı muayeneyi kaydettiyse çakışma uyarısı çıkar. **"Yazdıklarımı atıp güncel kaydı yükle"** yazdıklarınızı siler; önce metninizi kopyalayın.
- Aynı gün iki sekmede aynı muayeneyi düzenlemeyin.

### 2.3 Muayene sırasında ilgili kayıtlar
Muayene ayrıntı sayfasındaki düğmelerle (yetkinize göre): **Tedavi Oluştur**, **Reçete Oluştur**, **Aşı Oluştur**, **Lab İstemi Oluştur**, **Yatış Başlat**, **Ödeme Oluştur**. Her biri ilgili modülün formunu bu muayene ve hastayla önceden bağlı açar. Ayrıntı: Bölüm 6 (lab), 7 (yatış), 8 (uygulama/stok).

### 2.4 Kesinleştirme
1. Muayene **Taslak** durumundayken ayrıntı sayfasında **Kesinleştir**.
2. Onay penceresi (**Muayeneyi kesinleştir**) uyarır: kesinleştirdikten sonra içerik **değiştirilemez, işlem geri alınamaz**.
3. **Kesinleştir** ile onaylayın. Sayfada kesinleştiren kişi ve zaman görünür.

- Sık hata: "Kesinleştirdim ama bir not eklemeyi unuttum" → Bölüm 2.5.
- Kesinleşmiş muayeneye bağlı **tedavi, reçete, aşı** artık eklenemez/değiştirilemez (backend reddeder). Not: ayrıntı sayfasında bu düğmeler görünebilir; basarsanız hata alırsınız (**doğrulanacak** – Bölüm 13). Lab ise sonradan eklenebilir.

### 2.5 Ek not (kesinleşmeden sonra düzeltme)
1. Kesinleşmiş muayenenin ayrıntı sayfasında **Kesinleşme sonrası ek notlar** bölümü → **Ek not ekle**.
2. **Gerekçe** (5–500 karakter) ve **ek not metni** (1–4000 karakter) yazın → **Ek notu kaydet**.
3. Ek notlar eskiden yeniye listelenir; **silinemez ve düzenlenemez**. Yanlış yazarsanız yeni bir ek not ile düzeltin.
- Bölüm görünmüyorsa "Ek not ekleme" yetkiniz yoktur (yönetici verir).

### 2.6 Aşı, tedavi, reçete
- **Menü:** **Kayıtlar** → **Aşılar**, **Tedaviler**, **Reçeteler** sekmeleri. Reçete **dış temindir**: yazmak stoktan **düşmez**. Stoktan düşen kayıt **Uygulama**'dır (Bölüm 8).

### 2.7 Gün sonu
- **Muayenede** durumundaki gelişleri **Tamamla** (ödeme resepsiyonda **Hesabı kapat** ile alınır).
- Taslakta kalan muayeneleri kesinleştirin (Kayıtlar → Muayeneler → durum filtresi).

---

## 3. Yönetici – gün akışı

Yönetici, resepsiyon ve hekim işlerinin tümünü yapabilir; ek olarak **düzeltme ve iptal** yetkileri vardır.

### 3.1 Sabah: Bugün ve Raporlar
- **Bugün**'den kuyruğu izleyin. **Açık işler** satırı önceki günlerden kalan işleri toplar; **Gecikmiş randevu: N** çipi son 30 günde gelinmemiş ve hâlâ planlı randevuları takvimde açar. Gün listesinin başlığında o gün iptal edilen randevu sayısı yazar.
- Bugün'de müşteri bazında **toplam borç** ve satır bazında ücret/ödenen/kalan görünür.
- Sayılara **Raporlar** (Rapor Merkezi, bölüm 9) üzerinden bakın: kasa, ciro, tahsilat, borç, randevu ve klinik iş hacmi seçili şubeye göre, eğilim çizgisiyle görünür.

### 3.2 Müşteri ve hayvan kayıtları
- **Menü:** **Müşteri ve Hasta** → **Ara**, **Müşteriler**, **Hastalar**. Hayvan sayfası hasta özeti ve zaman çizelgesini (muayene, tedavi, reçete, lab, aşı, yatış, geliş) gösterir.

### 3.3 Ayarlar
- **Menü:** **Ayarlar** (tek giriş; kartlar):
  - **Hesap:** Hesabım, Abonelik, Size özel geliştirmeler.
  - **Klinik ve kurum:** Klinikler, KVKK metinleri, Online randevu, Web sayfam, Veteriner bul, e-Belge, Hasta sahibi portalı, Organizasyon Ayarları, Kurum üyeleri, Davetler, Davet oluştur.
  - **İletişim:** Hatırlatmalar, Hatırlatma Geçmişi.
  - **Tanımlar:** Türler, Irklar, Ürün kategorileri, Tanı ve şikâyet sözlüğü, Muayene şablonları, Metin parçaları, Yatış konumları, Randevu nedenleri, Aşı takvimi (adresleri `/panel/settings/definitions/...`; eski `/panel/species` vb. adresler yeni adrese yönlenir).
  - **Veri:** Veri içe aktarma, API erişimi, Verimi dışa aktar.
  - Kartlar yetkinize ve paketinize göre görünür.
- Yeni kullanıcı: **Davet oluştur**. Rol değişikliği: **Kurum üyeleri**. İzin değişikliği açık oturuma hemen yansımayabilir: kullanıcı **çıkış-giriş** yapsın.
- Hatırlatma e-postaları şu an gerçek gönderim doğrulamasından geçmedi (**doğrulanacak**, canlı işletim kılavuzu bölüm 1).

### 3.4 Ücret ve ödeme düzeltme / iptal
Bkz. Bölüm 5 (düzeltme ve iptal).

### 3.5 Raporlar
Bkz. Bölüm 9.

### 3.6 Geliş düzeltme (yanlış geliş, durum geri alma)
1. **Bugün** → ilgili satırda **⋯** menüsü → **Düzelt**.
2. **Yapılacak düzeltme** seçin: "Durumu … yap" (Sırada / Muayenede / Tamamlandı) veya **Yanlış geliş olarak işaretle**.
3. **Gerekçe** (5–500 karakter) yazın → **Düzeltmeyi kaydet**.
4. Yanlış işaretlenmişleri görmek için görünümü **Yanlış işaretlenenler**'e alın; yanlış gelişi geri almak için satırda **⋯ → Geri al** (gerekçe ister).
- Düzeltme izinli ve **kayıt altına alınır** (kim, ne zaman, gerekçe).

### 3.7 Gün sonu / hafta sonu
- Kasayı ve açık bakiyeleri **Raporlar** (Rapor Merkezi) → "Bugünün kasası tuttu mu?" (Gün sonu, Kasa) ve "Kimin bize borcu var?" (Borç Raporu) kartlarından kontrol edin.
- Düşük stok için **Stok Durumu** (Bölüm 8).
- Gölge dönemde fark listesini gözden geçirin.

---

## 4. Ücret ve ödeme

### 4.1 Ücret eklemek (Resepsiyon, Yönetici)
- **Menü:** Para → **Ücretler** → **Yeni Ücret** (sayfa başlığı "Yeni Ücret: Müşteriye ücret satırı ekleyin. Ücret ödeme sayılmaz.").
- Ücret **müşteriye** bağlıdır; geliş veya muayene bağlamak **isteğe bağlıdır** (örn. mama satışı için muayenesiz ücret girilebilir).
- Açıklama, miktar, birim fiyat (TRY) girin. Tutar = miktar × birim fiyat.
- Sık hata: miktar/fiyat 0 veya ondalık sınırı aşıyor → alanın altındaki kırmızı uyarıyı düzeltin.
- Hekim ücret **ekleyemez**; yalnız görür.

### 4.2 Hesabı kapat (Resepsiyon, Yönetici)
Hasta çıkarken tek panel (CHECKOUT-001, yayında 2026-11-20): **Bugün** satırında **Hesabı kapat** (muayenedeki hastada ve kalanı olan tamamlanmış gelişte satırın ana düğmesi; **Tamamla** ve **Ödeme al**'ın yerini alır, **Ödeme al** ⋯ menüsünde kalır). Panel sağdan çekmece olarak açılır; üstünde hasta, müşteri ve telefonu, geliş saati ve sorumlu hekim yazar.
1. **Ücret bekleyen kalemler** ücrete çevrilecek olarak gelir. İstemediğinizi **Ücretsiz** ile gerekçe yazarak (en az 5 karakter, geri alınamaz) ücretsiz sayın. Fiyatı olmayan kaleme birim fiyat girin.
2. **Açık ücretler:** bu gelişin ücretleri seçili gelir. Önceki gelişlerden kalan borç gösterilir ama seçili gelmez; birlikte almak için işaretleyin.
3. **Tahsilat:** **Nakit (F2)**, **Kart (F3)**, **Havale (F4)** ile satır ekleyin; birden fazla satır parçalı ödemedir (ör. nakit + kart). **Kalanı** düğmesi kalan tutarı yazar. Müşterinin kredisi varsa **Krediden (F8)**. Fazla alınan tutar müşteri kredisine yazılır. Birden fazla kasa varsa nakitte kasa sorulur.
4. **Kaydet (Ctrl+Enter):** kalemler çevrilir, ödemeler alınır, geliş tamamlanır (bekleyen geliş önce başlatılır). Tutarın bir kısmı alınmazsa düğme "borç bırak" der; geliş yine tamamlanır, kalan borç Bugün'de görünür.
5. Bir adım hata verirse panel durur: kaydedilenler geçerlidir. **Tekrar dene** çift kayıt yapmaz; para alınmadıysa **Borçla kapat**.
6. Bitince **Fişi yazdır** (ziyaret ve tahsilat özeti, A5; resmî belge değildir). Belge kesme izniniz ve bağlı e-Belge sağlayıcınız varsa Bugün'deki **Tamamla** ile aynı e-Belge önerisi açılır.
- Muayene ve ücreti olmayan muayenedeki hastada satırda **Tamamla** kalır (önce sorar).
- Çekmecede **yeni hizmet/ürün kalemi eklenmez**; yalnız ücret bekleyen kalemler ve açık ücretler gelir. Hekim aşı/reçeteyi ürünsüz girdiyse çekmece "ücret bekleyen kalem yok" der; ücreti önce **Ücret ekle** (Bölüm 4.1) ile yazın.
- Alt toplam: **Hesap**, varsa **Krediden** ve **Alınan**, sonra **Kalan** (fazla alınmışsa **Krediye yazılacak**).

### 4.3 Ödeme almak (Resepsiyon, Yönetici)
Kısayol: **Bugün** satırı → **⋯** → **Ödeme al**. Ya da: Para → **Ödemeler** → **Yeni Ödeme**.
1. Müşteriyi seçin; açık ücretleri listelenir.
2. Her ücret için ne kadar ödendiğini girin (**Tamamı** düğmesi ücretin kalanını yazar).
3. Yöntem ve tarihi kontrol edin, kaydedin.
- **Kurallar:** ödeme ücretlere bağlanır; bağlanmayan kısım (fazla ödeme ya da avans) **reddedilmez**, müşteri kredisine yazılır ve sonraki ücretlerde **krediden** kullanılır (FIN-005). Formda "Fazlası (₺…) müşteri kredisine yazılır" notu görünür. Çift tıklama aynı ödemeyi iki kez saymaz.
- **Örnek:** 1.000 TL ücret, 400 TL ödeme → kalan 600 TL; sonraki 600 TL ödeme borcu kapatır.
- Ödeme sonrası Bugün satırında kalan varsa **Kısmi ödeme** çipi ve kalan tutar görünür; borç kapanınca çip kalkar.

### 4.4 Bakiye nerede görülür
- Bugün'de satır bazında ücret / ödenen / kalan ve müşterinin toplam borcu.
- Müşteri bazlı bakiye müşteri ekranında (**doğrulanacak** – tam yeri). Müşteri listesinde "borcu olanlar" filtresi **yoktur** (karar).
- Ödeme yöntemi ve tarihe göre liste: Para → **Ödemeler** (arama, yöntem, tarih aralığı filtreleri).

---

## 5. Düzeltme ve iptal

> Kural: **Silme yoktur**; kayıt düzeltilir veya gerekçeyle iptal edilir. Tüm düzeltme/iptaller denetim kaydına yazılır. Ücret/ödeme düzeltme-iptal **yalnız yönetici düzeyindedir**.

| Ne düzeltilecek | Nereden | Kim | Gerekçe |
|---|---|---|---|
| Geliş (durum, yanlış geliş) | Bugün → ⋯ → **Düzelt** / **Geri al** | Yönetici | Zorunlu (5–500) |
| Gelmedi işareti | Bugün → ⋯ → **Gelmedi işaretini geri al** | Randevu "gelmedi" iznine sahip | İstenir |
| Ücret tutarı/açıklaması | Para → Ücretler → satırda **Düzelt** | Yönetici | Zorunlu |
| Ücret iptali | Para → Ücretler → satırda **İptal et** | Yönetici | Zorunlu |
| Ödeme düzenleme (yöntem/not vb.) | Para → Ödemeler → **Düzenle** | Ödeme güncelleme izni (Resepsiyon, Yönetici) | — |
| Ödeme iptali | Ödemeler listesi veya ödeme ayrıntısı → **İptal et** | Yönetici | Zorunlu |
| Kesinleşmiş muayene | Muayene → **Ek not ekle** | Hekim, Yönetici | Zorunlu (5–500) |
| Uygulama kaydı | Uygulamalar → **İptal et** | Hekim, Yönetici | Zorunlu (ayrıntı Bölüm 8) |

**Ücreti düzeltme:** satırda **Düzelt** → açıklama / miktar / birim fiyat'tan en az biri değişmeli → **Gerekçe** → **Düzeltmeyi kaydet**.

**Ücreti iptal etme:** satırda **İptal et** → onay penceresi: "İptal edilen ücret listelerden, bakiyeden ve Bugün tutarlarından düşer; geri alınamaz. Yanlışsa yeni ücret yazılır." **Ödemesi olan ücret önce ödeme iptal edilmeden iptal edilemez.**

**Ödemeyi iptal etme:** ödeme ayrıntısında **İptal et** → gerekçe → onay. Ödeme iptal edilince bağlı ücretler yeniden açık kalan olur (**doğrulanacak** – tam davranış).

**Kısıtlar:** ödeme **tahsisliyse** (ücrete bağlıysa) tutar, müşteri, klinik ve para birimi kilitlidir; yanlış tutar için ödemeyi iptal edip doğrusunu girin.

Sık hata: "İptal et" düğmesini göremiyorum → yönetici yetkiniz yoktur; yöneticiye haber verin. Düğmeler pasif ve yanında "Salt okunur modda kapalı" → abonelik süresi dolmuş olabilir.

---

## 6. Laboratuvar

- **Menü:** **Kayıtlar** → **Lab sonuçları**. Muayeneden: **Lab İstemi Oluştur**.
- **Yeni kayıt** ile: ya yalnız **istem** (sonuçsuz) ya da sonuçla birlikte kayıt girilir. Durumlar: **İstendi** → **Sonuçlandı**; ikisinden de **İptal**. İstek zamanı sunucuda atanır.
- Sonuç gelince kaydı açıp **Düzenle** ile sonuç metnini ve tarihini girin; kayıt **Sonuçlandı** olur.
- Hekim yorum yazmalıysa kayıt "değerlendirme bekliyor" işaretiyle görünür; yorum yazınca işaret kalkar. (Ekrandaki tam etiket **doğrulanacak**.)
- İptal: **İptal et** → gerekçe.
- Kesinleşmiş muayenede sonuç, yorum ve not eklenebilir; **test adı, hayvan ve bağlı muayene değiştirilemez** (hata mesajı gelebilir).
- Sekreter lab'ı yalnız **okur**.
- Sık hata: iki kişi aynı kaydı açıp kaydederse çakışma uyarısı → güncel kaydı yükleyip yeniden düzenleyin.

---

## 7. Yatış

- **Menü:** **Kayıtlar** → **Yatışlar**. Aktif yatışlar **Bugün** ekranının altında da listelenir; ilgili satırda **Yatışta** rozeti görünür.
- **Yeni yatış** (veya muayeneden **Yatış Başlat**). Düzenlemek için **Düzenle**.
- Taburcu: yatış ayrıntısı → **Taburcu et** → **Taburcu işlemi** penceresi.
- Yatış ücreti: ayrıntı sayfasında **Ödeme Oluştur** (ödeme akışına gider; ücretin ayrıca yazılması gerekebilir – **doğrulanacak**).
- Yatışı yalnız hekim ve yönetici oluşturur/taburcu eder; resepsiyon okur.

### 7.1 Vital ölçümü (ateş, nabız, solunum, kilo)

Aynı **Vital ölçümleri** bölümü üç yerde durur:
- **Yatış ayrıntısı:** Taburcu et düğmelerinin altında. Ölçümler bu yatışa bağlanır. Grafikler yatıştan bugüne kadar olan süreyi gösterir.
- **Muayene ayrıntısı:** muayene kaydının altında. Muayenenin ilk ölçümü eskisi gibi muayene formundaki vital alanlarında kalır. Aynı muayenede yeniden ölçtüğünüzde buradan ekleyin.
- **Hasta kartı:** başlığı **Vital ve kilo eğilimi**. Buradan eklenen ölçüm yatışa ya da muayeneye bağlı değildir. Üstten **Son 7 gün / 1 yıl / Tümü** seçilir.

Bölümün işleyişi:
1. **Hızlı giriş:** ölçtüğünüz değerleri yazın; boş bıraktığınız alan kaydedilmez, en az bir değer yeter. Ondalıkta virgül de nokta da olur (38,6). **Ölçüm zamanı** boş kalırsa şimdi sayılır. **Enter** kaydeder. Kutuların altında son değer ve zamanı görünür.
2. **Grafikler:** ateş, nabız, solunum ve kilo yan yana dört grafikte, aynı zaman ekseninde. Başlıkta son değer ve bir önceki ölçüme göre fark yazar. Dolu nokta vital ölçümü, içi boş nokta muayeneden gelen değerdir.
3. Bir noktaya tıklayın: o saatin bütün değerleri, not ve bağlı olduğu kayıt açılır. Buradan **Düzenle**, **İptal et** ve **Değişiklikleri gör**. Muayeneden gelen değer burada düzenlenmez, **Muayeneyi aç** ile muayenede düzeltilir.
4. **Tablo olarak göster:** bütün ölçümler liste hâlinde. **İptal edilenleri göster** ile iptal edilmiş ölçümler üstü çizili görünür.

Kurallar:
- Değer sınırları: ateş 25–45 °C, nabız 1–400, solunum 1–200, kilo 0,01–9.999,99 kg. Nabız ve solunum tam sayıdır.
- Ölçüm zamanı ileri olamaz, en çok **7 gün** geriye girilir. Yatışta zaman yatıştan önce olamaz.
- **Silme yoktur.** Yanlış girilen ölçüm **İptal et** ile gerekçe yazılarak (en az 5 karakter) iptal edilir; geri alınamaz.
- **Kesinleşmiş muayene:** yeni ölçüm **Sonradan ekleme gerekçesi** ister. Bu muayeneye bağlı ölçüm düzenlenemez; düzeltmek için iptal edip yeniden girin.
- Taburcu edilmiş ya da iptal edilmiş yatışta yeni ölçüm girilmez; mevcut ölçümler düzeltilebilir. Hasta kartında, vefat olarak işaretlenmiş hastaya yeni ölçüm girilmez.
- Resepsiyon ölçümleri görür, ekleyemez ve düzenleyemez.
- Ölçümler hasta zaman çizelgesinde **Vital ölçümü** olarak görünür.
- Sık hata: iki kişi aynı ölçümü düzenlerse çakışma uyarısı çıkar → **Yazdıklarımı atıp güncel kaydı yükle**, sonra yeniden düzenleyin.

---

## 8. Stok ve uygulama

### 8.1 Ürün ve stok
- **Menü (şu anki):** Stok → **Ürünler**, **Stok Durumu**, **Stok hareketleri**. **Hedef menü:** tek **Ürünler** girişi; Stok Durumu ve Stok hareketleri bu sayfada **sekmeler** olacak (rotalar kalır). Ürün kategorileri: **Ayarlar → Tanımlar → Ürün kategorileri**.
- **Ürünler → Yeni ürün**: yönetici ekler/düzenler; **Pasifleştir / Aktifleştir** ile ürün kullanımdan kalkar (stok kaydı silinmez).
- **Stok Durumu:** klinik stok özeti, **Düşük stok** süzgeci (minimum stok altı). Eldeki miktar minimumun altına inerse yalnız **bilgi** verilir, işlem engellenmez.
- **Stok hareketleri → Yeni stok hareketi:** giriş / çıkış / sayım gibi işlem tipleri, ürün ve miktar; resepsiyon ve yönetici ekler. Hareketler listelenir ve süzülür (hareket tipi, tarih).
- Miktar birimi ürünün stok birimidir; dönüşüm yoktur (şişe ise 0,5 yarım şişedir, ml girmeyin).

### 8.2 Uygulama (hastaya fiilen uygulanan ürün)
- Reçete dış temindir ve stok **düşmez**. Klinikte hastaya uygulanan ilaç/ürün **Uygulama** olarak kaydedilir ve stoktan düşer.
- **Nereden:** hayvanın özetindeki **Uygulamalar** bölümü → **Tümü →** → **Uygulamalar** sayfası (`/panel/administrations`; şu an **menüde ayrı öğe değildir**). **Uygulama ekle** → pencere **Uygulama kaydet**: ürün, miktar → **Kaydet ve stoktan düş**.
- **Yetersiz stokta** kayıt yapılmaz (stok eksiye inmez): önce stok girişi yapın.
- Uygulama **düzenlenmez**. Yanlışsa **İptal et** (gerekçeli) → pencere **Uygulamayı iptal et**; ardından doğru kaydı ekleyin. İptalde stok ya **geri verilir** (varsayılan) ya da **zarar/imha** diye düşük kalır; seçim ekranda sorulur (**doğrulanacak**).
- İptal edilenleri görmek için **İptal edilenler** süzgeci.
- Kesinleşmiş muayeneye sonradan uygulama eklenebilmesi backend kararıdır (gerekçeyle, "kesinleştirmeden sonra eklendi" işaretiyle); **ekranı henüz doğrulanmadı** (Bölüm 13).

---

## 9. Raporlar

- **Menü:** tek **Raporlar** girişi (Rapor Merkezi). Ana ekran raporları iş sorularının altında toplar: "Bugünün kasası tuttu mu?", "Bu dönem nasıl geçti?", "Para hangi yolla geldi?", "Kimin bize borcu var?", "Randevular boşa gidiyor mu?", "Klinikte ne kadar iş yaptık?", "HBS'e girilmemiş kayıt kaldı mı?", "Denetim gelse defterler hazır mı?" (ADR-052).
  - Her kartta özet sayı, çoğunda eğilim çizgisi ve cevabı veren raporlar vardır. Üstteki **Bugün / Bu hafta / Bu ay** seçicisi sayıları değiştirir; kasa, borç ve HBS kartları dönemden bağımsızdır. Sayılar seçili şubeye göredir.
  - **Bakmanız gerekenler** bandı yalnız iş bekliyorsa görünür: HBS'e girilmemiş reçete ve aşı, bugün ücreti kapanmamış iş, zamanı geçmiş aşı, asgari seviyenin altındaki stok. Her satır ilgili listeyi açar.
  - Raporu ☆ ile favorilere ekleyin; favoriler en üstte kısayol olur. **Rapor adıyla bul** kutusu eşleşen raporun kartını vurgular.
  - Kart ve uyarı, bağlandığı raporun izniyle görünür; izniniz olmayan kart çizilmez. Mevcut rapor adresleri değişmedi.
- Her rapor kendi okuma iznine bağlıdır (yetkiniz yoksa görünmez).
- Filtreleri seçin; sonuç tablosu sayfalıdır. Yetkiniz varsa **Excel indir** / **CSV indir** düğmeleri vardır. Dışa aktarma ekrandaki filtreyle aynı olmalıdır; farklı görürseniz bildirin (**doğrulanacak**).
- Dışa aktarılan dosya kişisel veri içerir: paylaşılan bilgisayarda bırakmayın, e-postayla kontrolsüz göndermeyin.
- Sık hata: rapor boş → tarih aralığını genişletin; yetkisiz erişimde "bulunamadı" sayfası açılır.

---

## 10. Sık karşılaşılan durumlar (hızlı tablo)

| Belirti | Olası neden | Ne yapılır |
|---|---|---|
| Bir düğme/menü yok | Yetkiniz yok | Yöneticiden yetki isteyin; izin değişince çıkış-giriş yapın |
| Düğmeler pasif, yanında "Salt okunur modda kapalı" | Abonelik/erişim durumu salt okunur | Yönetici Ayarlar → Abonelik'e baksın |
| "Açık geliş kaydı zaten var" | Aynı hasta için geliş açık | Mevcut satırı kullanın |
| Hasta listede yok | Kayıtlı değil / yazım farkı | Mikroçip veya telefonla arayın; yoksa **Yeni müşteri ve hasta ekle** |
| Muayene değiştirilemiyor | Kesinleşti | **Ek not ekle** |
| Kaydetme çakışması | Başkası aynı kaydı değiştirdi | Metni kopyalayın, güncel kaydı yükleyin, yeniden düzenleyin |
| Ödeme borçtan fazla girildi | Fazlası reddedilmez | Fazlası müşteri kredisine yazılır; sonraki ücrette **Krediden** kullanılır |
| Ücret iptal edilmiyor | Üzerinde ödeme var | Önce ödemeyi iptal edin (yönetici) |
| Yanlış geliş / yanlış durum | Hatalı tıklama | Yönetici **Düzelt** ile düzeltir |
| Uygulama kaydedilmiyor | Stok yetersiz / ürün pasif | Stok girişi yapın / ürünü aktifleştirin |
| Beklenmeyen hata mesajı | Sistem sorunu | Ekranı kapatmayın; ekran görüntüsü, saat, kullanıcı, adımlarla destek kanalına bildirin |

Bildirimde nelerin istendiği için canlı işletim kılavuzu bölüm 4'e bakın.

---

## 11. Bu kılavuzda olmayan konular

Aşağıdakiler yoktur veya bu kılavuzda ayrıntılı anlatılmaz: çoklu para birimi, POS, görüntüleme (dosya yükleme), yönetici onayı akışı, kişiye özel bildirim zili, rol bazlı farklı menüler (UX-007, ertelendi), hesap kilitleme.

Panelde olan ama bu kılavuzda yalnız değinilenler: **müşteri kredisi** (fazla ödeme ve avans; Bölüm 4.2–4.3), **hizmet kataloğu** (Stok → Ürünler, ürün türü "Hizmet"; ücret formu açıklamada katalogdan öneri verir), **e-Belge** (e-fatura/e-arşiv; Ayarlar → e-Belge ve Para → e-Belgeler), **online randevu**, **hasta sahibi portalı**, **klinik web sayfası** ve **veri içe aktarma** (Ayarlar kartları).

## 12. Gölge dönem (ilk 2 hafta) hatırlatması

Gerçek iş eski yöntemle sürer; Vetinity'ye paralel girilir. Gerçek ödeme yalnız eski yöntemle alınır. Fark gördüğünüzde bildirin (canlı işletim kılavuzu bölüm 10).

## 13. Doğrulanacaklar

Aşağıdaki maddeler koddan/belgelerden **kesin doğrulanamadı** veya uygulama tarayıcıda uçtan uca denenmedi; pilot öncesi test hesabıyla ekran ekran teyit edilmelidir:

1. **Menü adları ve yapısı:** sekmeli menü ve Rapor Merkezi canlıda (2026-11-20); kılavuzdaki yollar koddan okundu, ekranda rol rol teyit edilmedi.
2. **Rol-izin tablosu** (bölüm 0.1) backend varsayılanından; pilot kliniğin gerçek rolleri elle doğrulanmadı.
3. **Muayene aç** düğmesinin görünme koşulları, randevudan açılışta randevunun otomatik "Tamamlandı" olması (kuyruk notuna göre backend davranışı; tarayıcıda denenmedi).
4. **Kesinleşmiş muayenede** Tedavi/Reçete/Aşı düğmelerinin görünür kalması ve basınca alınan hata mesajının metni.
5. **Ek not**: uçtan uca elle denenmedi; ek not bölümünün Addendum izni olmayan kullanıcıdaki görünümü yalnız birim testlerle kapsandı.
6. **Ödeme iptalinin** ücret kalanına etkisi ve Bugün rozetinde görünümü; ödeme/ücret düzeltme-iptal arayüzü **gerçek iptal ile elle denenmedi** (kuyruk notu).
7. **Hızlı müşteri+hasta kaydı**: yinelenen telefon mesajı ve ekran metni.
8. **Arama**: mikroçip / Türkçe harf / telefon aramasının gerçek SQL Server'daki davranışı doğrulanmadı (kuyruk notu).
9. **Uygulama**: iptalde stok sonucu seçiminin (geri ver / zarar yaz) ekran karşılığı; kesinleşmiş muayeneye sonradan ekleme (ADR-013) arayüzü kodda bulunamadı; uygulama sayfasına menüden erişim yok.
10. **Lab**: istem/sonuç/iptal durum akışının arayüzü tam okunmadı; "değerlendirme bekliyor" etiketi.
11. **Yatış** ücreti: "Ödeme Oluştur"un ücreti kendiliğinden oluşturup oluşturmadığı.
12. **Rapor dışa aktarma**: hangi izinle görünür, ekrandaki filtreyle birebir aynı mı.
13. **Müşteri bakiyesinin** müşteri ekranında nerede gösterildiği.
14. **Hasta özeti/timeline** ekranı adım adım anlatılmadı (okunmadı).
15. **Tarih/saat dilimi** (İstanbul günü sınırı) ve Bugün'ün 500 satır sınırı yalnız birim testle kapsandı.
16. **E-posta/hatırlatma**: gerçek gönderim doğrulanmadı; ekran var, teslim garantisi yok.
17. **Vital ölçümü** (bölüm 7.1): yerelde hekim hesabıyla ekleme, düzenleme, iptal, yatış öncesi zaman reddi denendi. Resepsiyon hesabı, salt okunur kiracı, koyu tema ve iki kişinin aynı anda düzenlemesi tarayıcıda denenmedi.
18. **Bugün ve Hesabı kapat** (bölüm 1.1, 4.2): yerel tam testte (2026-11-22, canlıyla aynı sürüm) randevusuz geliş → Muayeneye al → kısmi nakit ödeme → Hesabı kapat ile kalanın kartla alınması denendi; ekran adları bu denemeye göre yazıldı. Bilgi fişinin önceki ödemeyi göstermemesi düzeltildi, yayın bekliyor.

## 14. Kullanıcı kararı gerektirenler

1. Rol adlarının pilot klinikte nasıl söyleneceği (Sekreter = Resepsiyon, Veteriner = Hekim) ve klinikte hangi kişinin hangi rolde olacağı.
2. Menü Aşama 8'de tamamlandıktan sonra bu kılavuzun menü adlarının güncellenmesi (yeni menü onaylanınca).
3. Ekran görüntülü sürüm gerekiyor mu? (Gerçek ekran görüntüleri pilot ortamı hazır olunca alınır; şimdilik eklenmedi.)
4. Pilotta test kaydı adlandırması ("TEST" öneki) ve test kayıtlarının nasıl iptal edileceği.
