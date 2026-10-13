# Vetinity kullanıcı kılavuzu (rol bazlı)

**Durum:** Taslak v0.1 (2026-10-13). Aşama 9 Dilim 11. Pilot klinik eğitimi için.

> **Menü yeniden düzenleme sürüyor (Aşama 8).** Menü adları aşağıda iki kaynaktan verilir: (a) frontend yerel `main`'deki **şu anki** menü (kodu okuyarak), (b) Aşama 8 menü taslağındaki **hedef** adlar (`docs/ASAMA8_DISCOVERY.md` bölüm 3.2; kullanıcı onayı D-M1: ~16 öğe, 6 grup). Pilot başlamadan menü son hâlini alacaktır; bu kılavuz o zaman gözden geçirilmelidir. Adresler (rotalar) taşınmaz; bir ekranı bulamazsanız menüde "Klinik", "Para", "Stok", "Raporlar" ve "Ayarlar" gruplarına bakın.

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
| Aşı, tedavi, reçete, lab, yatış | Yalnız okur | Ekler/günceller (yatışta taburcu) | Evet |
| Uygulama (stoktan düşen) | Okur | Ekler, **düzeltir/iptal eder** | Evet |
| Ücret | Ekler | Yalnız okur | Ekler, **düzeltir/iptal eder** |
| Ödeme | Ekler, düzenler | Yalnız okur | Ekler, düzenler, **iptal eder** |
| Ürün / stok hareketi | Ürünleri okur, stok hareketi ekler | Okur | Ürünü ekler/düzenler/pasifleştirir, stok hareketi ekler |
| Raporlar | İlgili modülü okuyorsa görür | İlgili modülü okuyorsa görür | Evet |

Menüde bir öğenin görünmesi o modülün **okuma** izninize bağlıdır. Rapor sayfaları da ilgili modülün okuma iznine bağlıdır (Ödeme Raporu ← ödeme okuma, vb.).

### 0.2 Giriş ve ilk ekran

- Giriş sonrası ilk sayfa izninize göre değişir: **Bugün** (geliş okuma izni varsa) veya **Özet**. (Kodda: giriş sonrası `Bugün` veya `Özet` yönlendirmesi; Aşama 8 kararı D-M2: Resepsiyon ve Hekim → Bugün, Yönetici → Özet.)
- Çıkış üst çubuktaki **kullanıcı menüsünden** yapılır.
- Üstte **klinik seçici** vardır; çok klinikli hesapta doğru kliniği seçili tutun.
- Abonelik süresi bitmişse yazma düğmeleri "(salt okunur)" olur: kayıt eklenemez/değiştirilemez, görüntülenir. Yönetici **Ayarlar → Abonelik** sayfasına bakar.

### 0.3 Kısa sözlük

- **Geliş (ziyaret):** hastanın klinikte bugünkü kaydı. Randevulu veya randevusuz olabilir.
- **Bakım durumu:** Bekliyor → Devam ediyor → Tamamlandı. **Ödeme durumundan bağımsızdır.**
- **Muayene:** Taslak → **Kesinleştirildi**. Kesinleşen muayene değiştirilmez; sonradan yalnız **ek not** eklenir.
- **Ücret:** müşteriye yazılan borç satırı (ödeme sayılmaz). **Ödeme:** tahsilat; mutlaka bir/bir kaç ücrete **bağlanır**.
- Para birimi yalnız **TRY**.

---

## 1. Resepsiyon (Sekreter) – gün akışı

### 1.1 Sabah: Bugün ekranını aç
- **Menü:** Panel → **Bugün** (hedef menü: üstte **Bugün**).
- Ekranda bölümler: **Bekliyor**, **Devam ediyor**, **Planlı randevular**, **Tamamlandı**, **Gelmedi**; en altta **Aktif yatışlar**. Görünüm anahtarı: **Bugün / Yanlış işaretlenenler**; kapsam anahtarı: **Benim hastalarım / Tümü**. Resepsiyon sorumlu hekim olmadığı için **Tümü** ile çalışır.
- Süre sütunu **Bekliyor** satırlarında bekleme süresini gösterir (30 dk üstü uyarı, 60 dk üstü kritik renk).
- Sık hata: Liste boş görünüyor → kapsamın "Benim hastalarım" olmadığına ve doğru kliniğin seçili olduğuna bakın, **Yenile** düğmesine basın.

### 1.2 Hasta geldi – randevulu geliş
1. **Planlı randevular** bölümünde hastanın satırını bulun.
2. **Geldi** düğmesine basın; açılan pencere **Hasta geldi**.
3. Gerekirse **Sorumlu hekim** seçin (randevudaki hekim varsayılan gelir), acil ise **Acil** anahtarını açın.
4. **Geldi olarak kaydet**. Satır **Bekliyor** bölümüne geçer; bilgi mesajı "Geliş kaydedildi".

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
- **Menü:** Klinik → **Randevular** (liste), **Randevu Takvimi** (şu anki menüde ayrı öğe; Aşama 8 taslağında Randevular içine alınacak).
- Yeni randevu, erteleme ve iptal bu ekrandan yapılır. Durum etiketleri: Planlandı / Tamamlandı / İptal. Resepsiyon **tamamlama** yapmaz (muayene başlayınca randevu otomatik tamamlanır; **doğrulanacak**).

### 1.5 Yanlış geliş / durum düzeltme
- Yanlışlıkla açılan gelişi **silemezsiniz**. Bunu **yönetici** düzeltir (Bölüm 3.6). Resepsiyon yönetici istemelidir; "Düzelt" menüsü sizde görünmeyebilir.

### 1.6 Ücret girmek
Bkz. Bölüm 4.1. Resepsiyon ücret ve ödeme **ekler**, **düzeltemez/iptal edemez**.

### 1.7 Gün sonu
- **Bugün**'de **Bekliyor/Devam ediyor** bölümlerinde unutulmuş kayıt kaldı mı? (12 saatten uzun açık kayıt "önceki günden" ipucu gösterir.)
- **Tamamlandı** satırlarında ödeme rozeti (**Ödendi / Kısmi ödendi / Ödenmedi / Ücret yok**) borç kalanları gösterir; ödeme alınacaksa **⋯ → Ödeme al**.
- Gölge dönemde (ilk 2 hafta) günün sonunda eski defterle karşılaştırın (canlı işletim kılavuzu bölüm 10).

---

## 2. Hekim (Veteriner) – gün akışı

### 2.1 Bugün: benim hastalarım
- **Menü:** Panel → **Bugün**. Kapsam varsayılan olarak **Benim hastalarım** gelir (size atanmış gelişler); tümünü görmek için **Tümü**.
- Satırdaki **Başlat** düğmesi bakımı başlatır (Bekliyor → Devam ediyor), **Tamamla** bakımı bitirir. **Acil işaretle / Acili kaldır** ikonu acil durumunu değiştirir.
- Hekim, Bugün'de ücret/ödenen/kalan bilgisini **görür** ama **Ödeme al** menüsü yoktur (ödeme alma yetkisi yoktur).

### 2.2 Muayene açmak
- Bugün satırında **Muayene aç** düğmesi (geliş kaydından muayene taslağı açar; hasta tekrar seçilmez). Alternatif: Klinik → **Muayeneler** → **Yeni** (hedef menü adı aynı) ya da randevu detayından.
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
- **Menü:** Klinik → **Aşılar**, **Tedaviler**, **Reçeteler** (şu anki menüde ayrı öğeler). Reçete **dış temindir**: yazmak stoktan **düşmez**. Stoktan düşen kayıt **Uygulama**'dır (Bölüm 8).

### 2.7 Gün sonu
- **Devam ediyor** bölümündeki gelişleri **Tamamla**.
- Taslakta kalan muayeneleri kesinleştirin (Klinik → Muayeneler → durum filtresi).

---

## 3. Yönetici – gün akışı

Yönetici, resepsiyon ve hekim işlerinin tümünü yapabilir; ek olarak **düzeltme ve iptal** yetkileri vardır.

### 3.1 Sabah: Özet ve Bugün
- **Menü:** Panel → **Özet** (hedef menü: üstte **Özet**) klinik göstergelerini gösterir. **Bugün**'den kuyruğu izleyin.
- Bugün'de müşteri bazında **toplam borç** ve satır bazında ücret/ödenen/kalan görünür.

### 3.2 Müşteri ve hayvan kayıtları
- **Menü:** Klinik → **Müşteriler**, **Hayvanlar**. Hayvan sayfası hasta özeti ve zaman çizelgesini (muayene, tedavi, reçete, lab, aşı, yatış, geliş) gösterir.

### 3.3 Ayarlar
- **Menü:** **Ayarlar** (tek giriş; kartlar):
  - **Hesap:** Hesabım, Abonelik.
  - **Klinik ve kurum:** Klinikler, Organizasyon Ayarları, Kurum üyeleri, Davetler, Davet oluştur.
  - **İletişim:** Hatırlatmalar, Hatırlatma Geçmişi.
  - **Tanımlar:** Türler, Irklar, Ürün kategorileri (adresleri `/panel/settings/definitions/...`; eski `/panel/species` vb. adresler yeni adrese yönlenir).
- Yeni kullanıcı: **Davet oluştur**. Rol değişikliği: **Kurum üyeleri**. İzin değişikliği açık oturuma hemen yansımayabilir: kullanıcı **çıkış-giriş** yapsın.
- Hatırlatma e-postaları şu an gerçek gönderim doğrulamasından geçmedi (**doğrulanacak**, canlı işletim kılavuzu bölüm 1).

### 3.4 Ücret ve ödeme düzeltme / iptal
Bkz. Bölüm 5 (düzeltme ve iptal).

### 3.5 Raporlar
Bkz. Bölüm 9.

### 3.6 Geliş düzeltme (yanlış geliş, durum geri alma)
1. **Bugün** → ilgili satırda **⋯** menüsü → **Düzelt**.
2. **Yapılacak düzeltme** seçin: "Durumu … yap" (Bekliyor / Devam ediyor / Tamamlandı) veya **Yanlış geliş olarak işaretle**.
3. **Gerekçe** (5–500 karakter) yazın → **Düzeltmeyi kaydet**.
4. Yanlış işaretlenmişleri görmek için görünümü **Yanlış işaretlenenler**'e alın; yanlış gelişi geri almak için satırda **⋯ → Geri al** (gerekçe ister).
- Düzeltme izinli ve **kayıt altına alınır** (kim, ne zaman, gerekçe).

### 3.7 Gün sonu / hafta sonu
- Açık bakiyeleri **Ücretler** ve **Ödemeler** raporlarıyla kontrol edin.
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

### 4.2 Ödeme almak (Resepsiyon, Yönetici)
Kısayol: **Bugün** satırı → **⋯** → **Ödeme al**. Ya da: Para → **Ödemeler** → **Yeni Ödeme**.
1. Müşteriyi seçin; açık ücretleri listelenir.
2. Her ücret için ne kadar ödendiğini girin (**Tamamı** düğmesi ücretin kalanını yazar).
3. Yöntem ve tarihi kontrol edin, kaydedin.
- **Kurallar:** her yeni ödeme en az bir ücrete bağlanır ve bağlanan toplam ödeme tutarına eşittir (avans/serbest ödeme yok). Borçtan fazla tahsilat **reddedilir** (para üstü verilir, kayıt borç kadar girilir). Çift tıklama aynı ödemeyi iki kez saymaz.
- **Örnek:** 1.000 TL ücret, 400 TL ödeme → kalan 600 TL; sonraki 600 TL ödeme borcu kapatır.
- Sık hata: ödeme tutarı borçtan fazla → tutarı borca indirin.
- Ödeme sonrası Bugün'de rozet **Kısmi ödendi** / **Ödendi** olur.

### 4.3 Bakiye nerede görülür
- Bugün'de satır bazında ücret / ödenen / kalan ve müşterinin toplam borcu.
- Müşteri bazlı bakiye müşteri ekranında (**doğrulanacak** – tam yeri). Müşteri listesinde "borcu olanlar" süzgeci **yoktur** (karar).
- Ödeme yöntemi ve tarihe göre liste: Para → **Ödemeler** (arama, yöntem, tarih aralığı süzgeçleri).

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

Sık hata: "İptal et" düğmesini göremiyorum → yönetici yetkiniz yoktur; yöneticiye haber verin. Düğmeler "(salt okunur)" → abonelik süresi dolmuş olabilir.

---

## 6. Laboratuvar

- **Menü:** Klinik → **Lab sonuçları** (hedef menü adı aynı). Muayeneden: **Lab İstemi Oluştur**.
- **Yeni kayıt** ile: ya yalnız **istem** (sonuçsuz) ya da sonuçla birlikte kayıt girilir. Durumlar: **İstendi** → **Sonuçlandı**; ikisinden de **İptal**. İstek zamanı sunucuda atanır.
- Sonuç gelince kaydı açıp **Düzenle** ile sonuç metnini ve tarihini girin; kayıt **Sonuçlandı** olur.
- Hekim yorum yazmalıysa kayıt "değerlendirme bekliyor" işaretiyle görünür; yorum yazınca işaret kalkar. (Ekrandaki tam etiket **doğrulanacak**.)
- İptal: **İptal et** → gerekçe.
- Kesinleşmiş muayenede sonuç, yorum ve not eklenebilir; **test adı, hayvan ve bağlı muayene değiştirilemez** (hata mesajı gelebilir).
- Sekreter lab'ı yalnız **okur**.
- Sık hata: iki kişi aynı kaydı açıp kaydederse çakışma uyarısı → güncel kaydı yükleyip yeniden düzenleyin.

---

## 7. Yatış

- **Menü:** Klinik → **Yatışlar**. Aktif yatışlar **Bugün** ekranının altında da listelenir; ilgili satırda **Yatışta** rozeti görünür.
- **Yeni yatış** (veya muayeneden **Yatış Başlat**). Düzenlemek için **Düzenle**.
- Taburcu: yatış ayrıntısı → **Taburcu et** → **Taburcu işlemi** penceresi.
- Yatış ücreti: ayrıntı sayfasında **Ödeme Oluştur** (ödeme akışına gider; ücretin ayrıca yazılması gerekebilir – **doğrulanacak**).
- Yatışı yalnız hekim ve yönetici oluşturur/taburcu eder; resepsiyon okur.

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

- **Menü (şu anki):** Raporlar → **Ödeme Raporu**, **Randevu Raporu**, **Muayene Raporu**, **Aşı Raporu**. **Hedef:** tek **Raporlar** girişi (Rapor Merkezi, kategori kartları); mevcut rapor adresleri çalışmaya devam eder.
- Her rapor kendi okuma iznine bağlıdır (yetkiniz yoksa görünmez).
- Filtreleri seçin; sonuç tablosu sayfalıdır. Yetkiniz varsa **Excel indir** / **CSV indir** düğmeleri vardır. Dışa aktarma ekrandaki filtreyle aynı olmalıdır; farklı görürseniz bildirin (**doğrulanacak**).
- Dışa aktarılan dosya kişisel veri içerir: paylaşılan bilgisayarda bırakmayın, e-postayla kontrolsüz göndermeyin.
- Sık hata: rapor boş → tarih aralığını genişletin; yetkisiz erişimde "bulunamadı" sayfası açılır.

---

## 10. Sık karşılaşılan durumlar (hızlı tablo)

| Belirti | Olası neden | Ne yapılır |
|---|---|---|
| Bir düğme/menü yok | Yetkiniz yok | Yöneticiden yetki isteyin; izin değişince çıkış-giriş yapın |
| Düğmeler "(salt okunur)" | Abonelik/erişim durumu salt okunur | Yönetici Ayarlar → Abonelik'e baksın |
| "Açık geliş kaydı zaten var" | Aynı hasta için geliş açık | Mevcut satırı kullanın |
| Hasta listede yok | Kayıtlı değil / yazım farkı | Mikroçip veya telefonla arayın; yoksa **Yeni müşteri ve hasta ekle** |
| Muayene değiştirilemiyor | Kesinleşti | **Ek not ekle** |
| Kaydetme çakışması | Başkası aynı kaydı değiştirdi | Metni kopyalayın, güncel kaydı yükleyin, yeniden düzenleyin |
| Ödeme kaydedilmiyor | Tutar borçtan fazla / ücret yok | Önce ücret girin; tutarı borca indirin |
| Ücret iptal edilmiyor | Üzerinde ödeme var | Önce ödemeyi iptal edin (yönetici) |
| Yanlış geliş / yanlış durum | Hatalı tıklama | Yönetici **Düzelt** ile düzeltir |
| Uygulama kaydedilmiyor | Stok yetersiz / ürün pasif | Stok girişi yapın / ürünü aktifleştirin |
| Beklenmeyen hata mesajı | Sistem sorunu | Ekranı kapatmayın; ekran görüntüsü, saat, kullanıcı, adımlarla destek kanalına bildirin |

Bildirimde nelerin istendiği için canlı işletim kılavuzu bölüm 4'e bakın.

---

## 11. Bu kılavuzda olmayan konular

Aşağıdakiler ilk sürümde yoktur veya bu kılavuzda anlatılmaz: müşteri kredisi/avans/mahsup, çoklu para birimi, hizmet kataloğu, e-fatura/POS, görüntüleme (dosya yükleme), yönetici onayı akışı, kişiye özel bildirim zili, global arama, rol bazlı farklı menüler (UX-007, ertelendi), hesap kilitleme.

## 12. Gölge dönem (ilk 2 hafta) hatırlatması

Gerçek iş eski yöntemle sürer; Vetinity'ye paralel girilir. Gerçek ödeme yalnız eski yöntemle alınır. Fark gördüğünüzde bildirin (canlı işletim kılavuzu bölüm 10).

## 13. Doğrulanacaklar

Aşağıdaki maddeler koddan/belgelerden **kesin doğrulanamadı** veya uygulama tarayıcıda uçtan uca denenmedi; pilot öncesi test hesabıyla ekran ekran teyit edilmelidir:

1. **Menü adları ve yapısı:** Aşama 8 sürüyor. Şu anki yerel menüde Randevu Takvimi, Stok Durumu, Stok hareketleri ve dört rapor ayrı öğe; hedef taslakta bunlar sekme/kart olacak. Rapor Merkezi sayfası ve Stok/Randevu sekmeleri henüz kodda yok.
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

## 14. Kullanıcı kararı gerektirenler

1. Rol adlarının pilot klinikte nasıl söyleneceği (Sekreter = Resepsiyon, Veteriner = Hekim) ve klinikte hangi kişinin hangi rolde olacağı.
2. Menü Aşama 8'de tamamlandıktan sonra bu kılavuzun menü adlarının güncellenmesi (yeni menü onaylanınca).
3. Ekran görüntülü sürüm gerekiyor mu? (Gerçek ekran görüntüleri pilot ortamı hazır olunca alınır; şimdilik eklenmedi.)
4. Pilotta test kaydı adlandırması ("TEST" öneki) ve test kayıtlarının nasıl iptal edileceği.
