# Bugün: günlük liste yeniden tasarım taslağı (2026-11-18)

**Durum:** Taslak, kullanıcı seçimi bekliyor. Kod yazılmadı. Seçimden sonra kodu Opus yazacak.
**Kapsam:** Panelde `/panel/today`: "Bekliyor / Devam ediyor / Planlı randevular / Tamamlandı / Gelmedi" grupları. Sayfa başı, Liste ve Hastalar seçimleri ile Açık işler çipleri korunur.
**Taslak:** [`bugun-liste-taslak/bugun-liste-taslak.html`](bugun-liste-taslak/bugun-liste-taslak.html). Tıklanır, statik bir sayfa. Veriler uydurmadır ve saat 15:20 kabul edilir. Aynı sayfada ikinci bir tasarım da var: [e-belge eksik ayar penceresi](#2-tasarım-e-belge-kes-penceresinde-eksik-ayar).
- Sol alttaki çizgili "Taslak" panelinden önce bölüm (Bugün listesi / E-belge uyarısı), sonra A, B ya da C seçilir. Adresler `#A`, `#B`, `#C`.
- Geldi → Başlat → Tamamla ve Ödeme al düğmeleri durumu gerçekten değiştirir. "Sıfırla" başa döner.
- "…" menüsü, Liste ve Hastalar seçimleri ile koyu tema da çalışır.

**Ekran görüntüleri:** `bugun-liste-taslak/1536-A.png`, `1536-B.png`, `1536-C.png`. Boyut 1536×730 CSS pikseldir (1920×1080 ekran, %125 ölçek) ve görüntüler başsız Chrome ile alındı.

## Sorun

Kullanıcının ekran görüntüsü, 2026-11-18:

- Saat hücresinde her satırda iki satır halinde "Randevu" ve saat yazıyor. Tekrar eden kelime saati gölgeliyor.
- Hekim sütununda neredeyse her satırda "Atanmadı" var. Bu sütun bilgi taşımadan yer kaplıyor.
- Durum gri bir kutu ve iki satıra kırılıyor ("Randevu / tamamlandı"). Satır bu yüzden yükseliyor.
- "Ödeme / yatış" sütunu çoğu satırda boş. Borç turuncu, altı çizili bir metin olarak görünüyor.
- "Geldi" düğmesi sabit genişlikli bir yuvanın ortasında havada kalıyor. "…" en sağda ve düğmeden kopuk.
- 26 satırın 25'i bitmiş iş. Bekleyen tek randevu bunların arasında kayboluyor.

**Kökteki hata (tasarımdan bağımsız):** Ekrandaki "Planlı randevular" grubunun neredeyse tamamı "Randevu tamamlandı" satırı. Bunlar ziyareti (Visit) olmayan ama durumu `Completed` olan randevular. `groupTodayItems` → `groupKeyOf` yalnız `careStatus`'a bakıyor. `careStatus` boş olunca satır "planned" grubuna düşüyor (`visit-status.utils.ts`). Bu yüzden bitmiş iş "Planlı" başlığı altında görünüyor. Hangi seçenek seçilirse seçilsin, `appointmentStatus === 'Completed'` ve `visitId` boş olan satır "Tamamlandı" grubuna gitmeli.

## Üç seçenekte ortak olanlar

- **Saat tek değerdir:** kalın ve tabular rakamla "15:30" yazılır. "Randevu" kelimesi kalkar. Gelen hastada altına küçük harfle "geldi 14:56" yazılır. Randevusuz gelişte ise geliş saati ve altında "randevusuz" görünür.
- **Durum, nokta ve tek satır metindir.** Gri kutu kullanılmaz ve metin kırılmaz.
  - Bekleniyor: içi boş gri halka, "10 dk sonra" ya da "15 dk gecikti".
  - Sırada: amber, bekleme süresiyle.
  - Muayenede: ana renk teal, süreyle.
  - Tamamlandı: yeşil.
  - Gelmedi: soluk.
- **Etiket önerisi:** Bugünkü "Bekliyor" (geldi, sırada) ile "Bekleniyor" (henüz gelmedi) birbirine çok yakın. Taslakta "Sırada" ve "Muayenede" kullanıldı. "Muayenede" kliniğe göre "İşlemde" de olabilir. Bu bir metin kararı ve `CARE_STATUS_LABEL` tek yerde değişir.
- **Satır başına tek birincil adım** sağa yaslı durur ve "…" hemen yanındadır:
  - Bekleniyor: Geldi.
  - Sırada: Başlat ve "Muayene aç".
  - Muayenede: Tamamla ve "Muayene aç".
  - Tamamlandı ama ödemesi açık: "Ödeme al" (çerçeveli düğme).
  - Tamamlandı ve ödendi: yalnız "…".

  Sabit genişlikli 4'lü yuva kalkar.
- **Para ikiye ayrılır.** Ziyaretin kalanı ("Kalan ₺850,00") satırın işidir ve "Ödeme al" düğmesiyle birlikte durur. Müşterinin toplam borcu ise müşteriye aittir. Bu yüzden müşteri adının yanında küçük amber bir "Borç ₺1.000" etiketi olarak görünür; altı çizili metin kullanılmaz.
- **Hekim:** Atanmamışsa "Atanmadı" yerine soluk "—" yazılır. Listedeki hiçbir satırda hekim yoksa sütun hiç çizilmez. Atanmışsa baş harf yuvarlağı ve ad gösterilir.
- **Bitmiş iş geri çekilir, açık iş öne çıkar.** Tamamlananlar daha alçak satırla, soluk saatle ve bağlantı rengi olmadan gösterilir. İşi kalan tamamlanmış satır (ödeme bekleyen) her zaman görünür kalır.
- **Hasta uyarısı** (Isırır, alerji) ve **Acil**, hasta adının yanında kırmızı küçük etiket olarak durur.
- **Ayrıntılar simgeye iner:** Müşteri onayı ve hazırlık şablonu A'da simge olarak durur, tam metin ipucunda okunur. B ve C'de yer olduğu için etiket olarak görünür.
- Liste (Günlük liste / Yanlış işaretlenenler), Hastalar (Benim hastalarım / Tümü) ve Açık işler bugünkü davranışla aynıdır. Seçili düğme ana renkle doludur.

## Seçenekler

| | Ne | Kimin işine yarar | Zayıf yanı |
|---|---|---|---|
| **A · Sıkı tablo** | Tek kart ve tek tablo. Ara başlıklar sırasıyla "Klinikte", "Sıradaki randevular" ve "Tamamlandı". Tamamlananlar katlıdır: yalnız işi kalanlar görünür, altında "23 tamamlanan kayıt daha göster" yazar. Satır 46 px, tamamlanan satır 38 px. | Bugünkü düzene alışmış resepsiyon: aynı sütunlar, daha az gürültü. En az kod değişikliği. | Tablo kalıyor. Çok randevulu günde "Sıradaki" bölümü uzar. |
| **B · Durum şeritleri** | Yan yana üç sütun: Sıradaki randevular, Klinikte ve Tamamlandı. Açık işler büyük kartlarda ve birincil düğmeyle görünür. Tamamlandı sütununda önce "İşi kalan" kartları, sonra sıkı bir "Bitenler" listesi (yeniden eskiye) gelir. | Hasta akışını yönetenler: "kim geldi, kim içeride" bir bakışta görülür. | Saat sırası sütunlar arasında bölünür. Az işli günde sütunlarda boşluk kalır. 30 randevulu günde ilk sütun kendi içinde kayar. |
| **C · Gün akışı** | Saat sırasıyla tek akış ve solda zaman çizgisi. Geçmiş saatler birer satıra toplanır ("10:00 ✓ 5 tamamlandı · Bulut, Tekir…") ve tıklanınca açılır. "ŞİMDİ 15:20" çizgisi vardır. Açık ve işi kalan kayıtlar iki satırlık geniş satırlar olarak görünür. Sağ sütunda "Günün durumu" (ilerleme çubuğu, sıradaki, klinikte, tahsilat) ve Açık işler yer alır. | Günü bir bütün olarak görmek isteyen hekim ve yönetici. Uzun günde bile tek ekrana sığar. | Saatlik özet, tek tamamlanmış kaydı bulmayı bir tık uzatır. Sağ sütun dar ekranda alta iner. |

**Öneri (karar kullanıcının):** Kullanıcının asıl şikâyeti gürültü ve kaybolan bekleyen satır. A bunu en az değişiklikle çözer. C ise aynı veriyle en çok bilgiyi verir. B, çok hekimli ve yoğun kliniklerde güçlüdür, ama pilot kliniğin bugünkü verisinde (çoğu satır tamamlanmış randevu) sütunlar boş kalır.

## Kodlayacak kişi için notlar

- **Sözleşme değişmez.** Taslaktaki her alan `TodayItemVm`'de zaten var: `scheduledAtUtc`, `arrivedAtUtc`, `careStatus`, `appointmentStatus`, `responsibleVeterinarianName`, `petAlerts`, `isUrgent`, `ownerConfirmedAtUtc`, `preparedExaminationTemplateName`, `outstandingAmount`, `clientOutstandingAmount`, `hasActiveHospitalization` ve açık iş çipleri. Backend işi yok.
- **Önce grup hatası:** `groupKeyOf` içinde Visit'siz `Completed` randevu `completed` grubuna gitmeli. Birim testi `visit-status.utils.spec.ts`'e eklenmeli.
- **Durum metni** tek yerde üretilsin: `careStatusLabel` ve randevu durumu birleşik bir yardımcıya taşınsın. "Randevu tamamlandı" yerine "Tamamlandı" yazılsın. "Bekleniyor" alt metni (`X dk sonra` / `X dk gecikti`) mevcut `now` sinyalinden hesaplanır.
- **Eylemler:** `todayItemActions` ve `todaySecondaryActions` aynı kalır. Değişen yalnız sunum:
  - Birincil düğme ve "Muayene aç" sağa yaslı bir `flex` içinde durur, "…" hemen yanındadır.
  - Tamamlanmış ve kalanı olan satırda "Ödeme al" görünür bir düğme olur; menüde de kalır.
  - Acil düğmesi menüye taşınır (taslakta "Acil olarak işaretle"). Acil işaretli satırda kırmızı "Acil" etiketi görünür.
- **`app-today-money`:** Ücret, Ödenen ve Kalan üçlüsü satırda tek "Kalan ₺…" olur. Ayrıntı ziyaret sayfasında ve ipucunda kalır. Müşteri borcu bileşenden çıkıp müşteri hücresine etiket olarak taşınır. Ödeme ve Ücretlendir çipleri (`chargePending` vb.) "Neden / not" hücresinde kalır.
- **Yatış:** "Yatışta" etiketi durum noktasının yanına gelir. Aktif yatışlar bölümü değişmez.
- **Dar ekran (≤ 40rem):** Bugünkü kart görünümü kalır. Ortak kurallar (tek saat, nokta durum, tek birincil düğme) kartlara da uygulanır.
- **Seçeneğe özel:**
  - **A:** `p-table` korunur, gruplar tek tabloda ara başlık satırı olur. Ayrı `section.card` kullanılmaz. "Tamamlananları göster" seçimi `localStorage`'da saklanabilir. Hekim sütunu `items.some(i => i.responsibleVeterinarianName)` ile çizilir.
  - **B:** Üç sütunlu CSS grid kullanılır. Sütunların yüksekliği ekrana sabitlenir ve her sütun kendi içinde kayar. `p-table` kullanılmaz.
  - **C:** Tamamlananlar istemcide saat dilimine (Europe/Istanbul) göre gruplanır. "Şimdi" çizgisinin yeri `now` sinyalinden gelir. Sağ sütundaki sayılar mevcut `groups()` ve `openItems`'tan hesaplanır, yeni uç gerekmez.
- **Renkler:** Değerler `vetinity-preset.ts`'ten alınır: `primary.600`, amber 700, yeşil 700. Koyu temada zinc yüzeyler ve `primary.400` kullanılır. Durum noktası renkle birlikte metin de taşır, yani yalnız renge güvenilmez.
- **Rakip:** E-vet ya da Kolayvet görünümü kopyalanmadı. Tasarım bizim mevcut panel dilimizden türetildi.

---

# 2. tasarım: "e-belge kes" penceresinde eksik ayar

**Durum:** Taslak, kullanıcı seçimi bekliyor. Kod yazılmadı.
**Taslak:** Aynı HTML. Sol alttaki panelden "E-belge uyarısı" seçilir; ardından seçenek A, B ya da C ve senaryo seçilir:
- **1 eksik:** Bugün görülen durum, yalnız mükellef türü eksik.
- **3 eksik:** Mükellef türü, VKN / TCKN ve entegratör bağlantısı eksik.
- **Yetkisiz:** Kullanıcının klinik ayarını değiştirme yetkisi yok.

Adresler `#E-A-one`, `#E-B-three`, `#E-C-noperm` biçimindedir. "Aç" ya da birincil düğme taslaktaki ayar sayfasına gider. Orada kaydedip "Ücretlere dön" denince pencere kalan eksiklerle yeniden açılır. Eksik kalmayınca "Kes" ile belge kesilir.

**Ekran görüntüleri:** `bugun-liste-taslak/1536-ebelge-A-1.png`, `1536-ebelge-A-3.png`, `1536-ebelge-B-3.png`, `1536-ebelge-C-3.png`, `1536-ebelge-A-yetkisiz.png`, `1536-ebelge-ayar-sayfasi.png`.

## Sorun

Ücretler sayfasında (`/panel/charges`) "Belge kes"e basınca açılan pencerede yalnız kırmızı bir yazı var: "Klinik mükellef türü seçilmemiş; Ayarlar > Klinik > Mükellef bilgileri bölümünü doldurun." Altında yalnız "Kapat" düğmesi duruyor.

- **Yazı nereden geliyor:** Backend'de `EDocumentDraftBuilder.BuildAsync` önizleme isteğini `EDocuments.TaxpayerTypeMissing` hatasıyla reddediyor. Pencere bu hatayı `loadError` olarak `text-danger` ile basıyor (`e-document-issue-dialog.component.ts`). Yani bu bir uygulama hatası gibi gösteriliyor, oysa yalnız eksik bir ayar.
- **Yalnız ilk eksik görünüyor:** Kurucu ilk eksikte durduğu için, birden çok ayar eksikse kullanıcı onları birer birer, her seferinde pencereyi yeniden açarak öğreniyor.
- **Yol tarifi var, yol yok:** "Ayarlar > Klinik > Mükellef bilgileri" menüde birebir böyle bir yer değil. Gerçek yer Ayarlar › Klinikler › (klinik adı) sayfasındaki "Mükellef bilgileri" kartı.
- **Tutarsızlık:** Entegratör bağlı değilse aynı pencere sarı bir not ve "Ayarlar › e-Belge" bağlantısı gösteriyor. Aynı türden iki eksik, iki farklı tonda anlatılıyor.

## Üç seçenekte ortak olanlar

- **Ton yardımcıdır.** Kırmızı ve "hata" sözcüğü kullanılmaz. Başlık ne yapılacağını söyler ("Belge kesmeden önce bir ayar gerekli"), korkutmaz.
- **Her eksik için üç bilgi verilir:** ne eksik (kısa ad), neden gerekli (bir cümle) ve tek tıkla nereye gidileceği (düğme).
  - **Mükellef türü:** "Belgenin e-SMM mi fatura mı olacağı bu seçimden çıkar." Düğme: "Mükellef bilgilerini aç".
  - **Kliniğin VKN / TCKN numarası:** "Belgede düzenleyen olarak kliniğin vergi kimliği yazılır." Düğme: "Mükellef bilgilerini aç".
  - **e-Belge entegratörü bağlantısı:** "Belge GİB'e entegratör hesabınız üzerinden gönderilir." Düğme: "Entegratörü bağla".
- **Seçim kaybolmaz.** Pencere, seçilen ücretlerin belgesiz kalıp beklediğini söyler.
- **Dönüş yolu vardır.** Ayar sayfasında üstte bir şerit durur: "Belge kesmek için buraya geldiniz… [Ücretlere dön]". Gerekli alanlar kaydedilince düğme birincil olur: "Ücretlere dön ve belgeyi kes". Dönüşte pencere aynı seçimle yeniden açılır.
- **Yetkisi olmayan kullanıcı** gidemeyeceği bir yere yönlendirilmez. Düğme yerine kilit simgeli bir not çıkar: "Bu ayarı klinik ayarlarını düzenleme yetkisi olan biri tamamlayabilir. Klinik yöneticinize 'Mükellef türü' eksik deyin."
- Müşteri tarafındaki eksik (ad soyad, kurumsal vergi no) bu tasarımın dışındadır. O, müşteri kaydına ait bir eksiktir ve bugünkü "Fatura bilgilerini tamamlayın" bağlantısı kalır. Yalnız tonu aynı yardımcı dile çekilir.

## Seçenekler

| | Ne | İyi yanı | Zayıf yanı |
|---|---|---|---|
| **A · Hazırlık listesi** | Pencerede numaralı bir kontrol listesi: eksikler numarayla, tamam olanlar yeşil tikle ve değeriyle ("VKN ••••••4521", "Bağlı · canlı ortam"). Her eksiğin yanında "Aç ›", altta "2 / 3 hazır" ve birincil düğme (ilk eksiğin düğmesi). | Birden çok eksik tek bakışta görünür. Tamam olanlar da görünür, kullanıcı ne kadar kaldığını bilir. Kodu en sade olan seçenek. | Her eksik için ayar sayfasına gidip dönmek gerekir. |
| **B · Yerinde tamamla** | Eksikler pencerenin içinde adım adım sorulur: "Adım 1 / 3". Mükellef türü üç açıklamalı seçenekle, VKN tek alanla girilir ve "Kaydet ve devam et" ile ilerlenir. Entegratör bağlantısı sağlayıcı sayfasında onaylandığı için tek o adım ayar sayfasına gider. Altta "Tüm ayarları sayfada aç" bağlantısı vardır. | En az tık. Kullanıcı sayfadan ayrılmadan belge keser. Seçeneklerin açıklaması, kullanıcıyı "hangisi benim?" sorusunda yalnız bırakmaz. | Ayar mantığı iki yerde yaşar (pencere ve ayar sayfası). Kural tek yerde kalsın diye form parçası paylaşılmalıdır. En çok kod bu seçenektedir. |
| **C · Önizlemede şerit** | Pencere bugünkü önizlemeyi gösterir: alıcı, belgeye girecek kalemler ve toplam. Üstte yumuşak amber bir şerit yer alır: "Belge kesmeye 3 adım kaldı", eksikler tıklanır çipler olarak. "Kes" düğmesi pasiftir, yanında birincil "Mükellef bilgilerini aç" durur. Belge türü satırında "Mükellef türü seçilince belirlenir" yazar. | Kullanıcı ne keseceğini görür. Uyarı, işi bölen bir hata değil, işin üstünde bir not olur. Entegratör uyarısıyla aynı yerde ve aynı tonda durur. | Backend'in eksik ayar varken de önizleme döndürmesi gerekir. Amber ton, A ve B'nin nötr tonundan bir derece daha uyarıcıdır. |

**Öneri (karar kullanıcının):** A, sorunu en az değişiklikle çözer ve kullanıcının üç isteğini de karşılar: ne eksik, neden gerekli, tek tıkla nereye. Kurulum anında sıkça karşılaşılacaksa B en akıcısıdır. C ise belge kesmeyi her gün kullanan klinikte en doğal olanıdır. Üçü de aynı backend değişikliğine dayanır.

## Kodlayacak kişi için notlar (2. tasarım)

**Önce backend (sözleşme değişikliği).** Önizleme ilk eksikte reddetmesin. Eksik klinik ayarlarını bir liste olarak döndürsün:
- Öneri: `EDocumentPreviewDto.clinicSetupIssues: { code: 'TaxpayerTypeMissing' | 'TaxpayerIdentityMissing' | 'NotConnected' }[]`.
- **Kesme ucu** aynı kontrolleri yapmaya ve reddetmeye devam eder. Önizleme yalnız bilgi verir.
- **Grup sorunu:** Mükellef türü yokken gruplar (belge türü) hesaplanamaz, çünkü `BuildGroups` `taxpayerType` ister. Önizleme bu durumda boş `groups` ile birlikte satır ve tutar özetini döndürmelidir; C seçeneği bunu ister. A ve B için satır özeti gerekmez.
- **VKN / TCKN kuralı (karar, 2026-11-19):** Kliniğin VKN / TCKN numarası zorunlu kesme koşuludur, çünkü e-belgede düzenleyenin vergi kimliği zorunlu alandır. Bugün `BuildAsync` bunu denetlemiyor. Önizleme bunu `TaxpayerIdentityMissing` sorunu olarak listelemeli, kesme ucu da reddetmeli. Kontrol sınırı: alan boş mu, biçimi doğru mu (VKN 10, TCKN 11 hane). Entegratör hesabındaki vergi numarasıyla eşleşme denetimi bu işin dışında kalır.
- **Bağlantı durumu:** Bugün önizlemede `connection.status` olarak geliyor; aynı listeye alınabilir. Böylece pencerede tek bir "eksikler" kaynağı olur.

**Rotalar (frontend):**
- **Mükellef bilgileri:** `/panel/settings/clinics/:clinicId`. Rota `features/clinics/routes/clinics.routes.ts` içinde `:clinicId`, sayfa `ClinicDetailPageComponent`, kart `app-clinic-taxpayer-settings-section`.
  - Kartın bugün bir `id`'si yok. Karta `id="mukellef-bilgileri"` verilip `fragment: 'mukellef-bilgileri'` ile gidilsin; `app.config.ts` içinde `anchorScrolling: 'enabled'` açık.
  - Klinik kimliği: aktif klinik (`AuthService.getClinicId()`). e-Belge ayar sayfası da aynı yolu kullanıyor.
  - Kart yalnız `Clinics.Update` yetkisi olan kullanıcıya çiziliyor (`canUpdateClinic`). Bu yüzden "Yetkisiz" senaryosunda düğme gösterilmez; yetki pencerede `CLINICS_UPDATE_CLAIM` ile denetlenir.
  - Mükellef türü seçenekleri `CLINIC_TAXPAYER_TYPE_OPTIONS` içindedir. B'deki açıklamalı seçenekler buradan türetilsin; etiketler tek yerde kalsın.
- **Entegratör:** `/panel/settings/e-documents` (`E_DOCUMENT_SETTINGS_ROUTE`). Bağlantı kartı `app-e-document-connection-card` için de bir parça adı verilebilir: `#entegrator`. OAuth dönüşü `?clinicId=` ile bu sayfaya gelir.
- **Dönüş:** Ayar sayfasına `queryParams: { returnTo: '/panel/charges', resumeEDocument: '1' }` gibi bir dönüş bilgisiyle gidilsin; seçilen ücret kimlikleri `sessionStorage`'da tutulabilir.
  - Ayar sayfası `returnTo` görünce üstteki şeridi çizer.
  - Ücretler sayfası `resumeEDocument` görünce seçimi geri yükler ve pencereyi açar.
  - Pencere birden çok sayfadan açılıyor: Ücretler, e-Belgeler, satış ayrıntısı ve yeni satış, Bugün'deki ziyaret kapanışı. Bu yüzden `returnTo` çağıran sayfanın kendi adresi olmalıdır.
- **Pencere bileşeni:** `loadError` yalnız gerçek ağ ya da sunucu hataları için kalsın. Eksik ayarlar ayrı bir `@if (setupIssues().length)` dalında çizilsin. Bugünkü `edoc-note--warn` (entegratör bağlı değil) bu dala taşınsın; iki ayrı ton kalmasın.
- **Metinler** tek yerde dursun: eksik kodundan başlık, gerekçe, düğme metni ve rotaya giden bir eşleme (ör. `e-document-labels.ts`'e `E_DOCUMENT_SETUP_ISSUE`).
