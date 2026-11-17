# Randevu takvimi: yeniden tasarım taslağı (2026-11-18)

**Durum:** Taslak, onay bekliyor. Kod yazılmadı. Onaydan sonra kodu Opus yazacak.
**Kapsam:** Panelde `/panel/appointments/calendar`: hafta, gün ve ay görünümleri.
**Taslak:** [`takvim-taslak/takvim-taslak.html`](takvim-taslak/takvim-taslak.html). Statik bir sayfa; veriler uydurmadır, gerçek hasta ya da sahip adı yoktur. Görünüm adresin sonundaki `#` ile seçilir: `#hafta`, `#hafta-asi`, `#gun`, `#ay`, `#renkler`. Koyu tema için `?dark` eklenir.
**Ekran görüntüleri:** `takvim-taslak/1536-*.png`. Kullanıcının ekranı 1920×1080, ölçek %125 (tarayıcı içi 1536×728 CSS piksel). Görüntüler bu boyutta, başsız Chrome ile alındı.

## Sorun (canlıdaki görünüm, 2026-11-18)

- Planlı aşılar ızgaranın üstündeki "aşı" bandında satır satır duruyor: günde 10–20 renkli çip var, her çipte kısaltılmış aşı adı, altında "+10 aşı" ya da "Daha az". Bant ekranın yarısını kaplıyor.
- Randevular bandın altında kalıyor. Görmek için aşağı kaydırmak gerekiyor. Kartlar küçük ve hepsi aynı gri.
- Renkler randevuyu değil aşıyı anlatıyor. Pazartesi sütunu baştan sona kırmızı, bugün sarı, ileri günler siyah. Durum çoğunlukla tarihten geldiği için renk yeni bir bilgi taşımıyor.
- Kullanıcının sözü: "Saatler belli değil, takvime bakıyorum ne olduğu belli değil."

**Birinci amaç:** Takvime bakınca kimin ne zaman geleceği bir bakışta okunsun. İlk ekranda mesai saatleri ızgaraya sığsın, kaydırma gerekmesin.

## 1. Planlı aşılar: gün başlığında tek satırlık sayaç ve sağ panelde liste

**Öneri:** Her günün başlığında tek satırlık bir sayaç olsun: "13 aşı · 3 gecikmiş". Sayaca tıklanınca o günün aşı listesi sağdan açılan panelde görünsün. Gün görünümünde bu panel baştan açık gelsin.

| Seçenek | Karar | Gerekçe |
|---|---|---|
| Saat ızgarasına yerleştirmek | Ret | Planlı aşının saati yok. Sözleşme §5.2: "Vadeli satırda saat anlamlı değildir." Izgaraya koymak için saat uydurmak gerekir, bütün aşılar 09:00'a yığılır. Kart randevu gibi görünür ama çakışma ve "Boş saat bul" hesabına girmez (§5.2 "Randevu değildir"). Günde 15–20 aşı kartı randevuları da ezer. |
| **Gün başlığında sayaç, tıklanınca liste** | **Seçildi** | Izgara her gün aynı yükseklikte kalır; aşı sayısı ne olursa olsun randevular yukarı itilmez. "Bugün kaç aşı var, kaçı gecikmiş" takvimde görünmeye devam eder; 2026-11-16 kararı (aşı takvimde görünsün) korunur. Liste panelde olduğu için aşı adı tam yazılır ve eylemler ("Aşıyı yap", "Randevu ver") yanında durur. Backend değişikliği gerekmez: sayaç `GET /vaccinations/calendar/summary`, liste `GET /vaccinations/calendar` (§5.2, §7). |
| Ayrı sekme ya da görünüm | Ret | Gün planlanırken aşı bilgisi gözden çıkar; 2026-11-16 kararına ters düşer. Ayrı liste ihtiyacını mevcut aşı listesi (`/vaccinations?onlyOverdue=true`) zaten karşılıyor. Paneldeki "Haftanın tüm aşıları" bağlantısı oraya gider. |
| Varsayılanda kapalı katman | Ret | Gecikmiş aşı gözden kaçar. Katman açılınca da bugünkü sorun aynen geri gelir. |

Bu, rakiplerin klinik pratiğiyle de örtüşüyor: aşı vadesi takvimde görünür, iş ise ayrı bir hatırlatma ya da aşı listesinden yürütülür (E-vet "Hatırlatma listesi", [RAKIP-IS-AKISI](RAKIP-IS-AKISI-CALISMASI-2026-10.md) §1.2). Bizde ikisi aynı ekranda: sayaç takvimde, liste yan panelde.

**Ayrıntılar** (`#hafta`, `#hafta-asi`, `#gun`):

- **Sayaç:** Her gün başlığının altında 22 px yüksekliğinde tek satır. İçinde kalkan simgesi, "N aşı" ve gecikmiş varsa kırmızıyla "· N gecikmiş". Başka durum renklendirilmez. Aşı yoksa satırın yeri boş kalır, böylece sütunlar hizalı kalır. Kapalı ve boş günde (pazar) yalnız sayı görünür.
- **Araç çubuğu:** Mevcut "77 aşı" sayacı tarih başlığının yanında kalır ("32 randevu · 77 aşı"). Tıklanınca haftanın listesi açılır, liste günlere göre gruplanır.
- **Panel (hafta görünümü):** Sağdan açılır, genişliği 352 px. Izgarayı karartmaz, pencere de değildir. × ya da Esc ile kapanır. Seçili günün sayacı vurgulanır. Panelin üstünde şu açıklama yazar: "Planlı aşı randevu değildir; saati yoktur, gün içinde yapılır." Sekmeler: "Yapılacak / Yapıldı / Tümü". Geçmiş günlerde bunlar "Gecikmiş / Uygulandı / Tümü" olur.
- **Panel (gün görünümü):** Sağda sürekli açık, 330 px. Sekmeler: "Bugünün aşıları 17 | Boş saat bul". Hafta görünümünde "Boş saat bul" araç çubuğunda bir düğme olur ve aynı panelde açılır. Bugünkü kalıcı sağ sütun hafta görünümünden kalkar ve günlere yer açılır.
- **Liste satırı:**
  - Durum şeridi.
  - **Hasta** · sahip.
  - Aşının tam adı (kısaltma yok).
  - Aynı gün o hastanın randevusu varsa "◷ 14:00 randevusu var" rozeti. Eşleştirme istemcide `petId` ile yapılır, iki liste zaten elde. Yeni uç gerekmez.
  - Sağda "Aşıyı yap" düğmesi. Tıklanınca mevcut kural işler (§5.2): `Planned` için düzenleme, `NextDue` için yeni aşı.
  - ⋯ menüsünde "Randevu ver" ve "Aşı kaydını aç".
  - Uygulanmış aşıda düğme yerine "✓ 09:04" yazar. `Applied` satırında saat anlamlıdır.
- **Filtreler:** Bugünkü davranış aynen kalır. Hekim filtresi bir hekime ayarlıyken sayaç ve panel gizlenir, çünkü aşı kaydında hekim yok (§6.3). Tür filtresindeki "Planlı aşılar" seçeneği kalır.
- **Telefon:** Ajandadaki "Aşılar · randevu değildir" kutusu tek satırlık sayaca dönüşür. Dokununca liste aşağı doğru açılır.

## 2. Randevular ızgarada nasıl okunur olur

**Ölçek: mesai saatleri ekrana sığar** (`#hafta`, `#gun`)

- Izgaranın aralığı, gösterilen günlerin çalışma saatleriyle o günlerdeki randevuların birleşimidir; tam saate yuvarlanır. Mesai dışındaki bir randevu (örneğin cumartesi kapanıştan sonra) aralığı genişletir. Kart, taralı alanın üstünde görünür.
- Dakika başına piksel sabit değildir: `clamp(ızgara yüksekliği / aralık, 0,8, 1,6)`. Bugün 1,6 px/dk sabit. Kullanıcının ekranında 09:00–18:00 aralığı yaklaşık 0,9 px/dk'ya denk gelir: bir saat yaklaşık 54 px, 30 dakikalık randevu yaklaşık 27 px. İlk açılışta kaydırma olmaz; `scrollToMinute` yalnız "Tüm gün" modunda kalır.
- Saatler için iki düğme eklenir: "Mesai | Tüm gün". "Tüm gün" 00:00–24:00 aralığını bugünkü ölçekle ve kaydırmalı gösterir.
- Dikey yer kazanmak için şunlar kalkar ya da sıkışır (toplam yaklaşık 150 px):
  - Kart içindeki "Randevu takvimi" başlığı kalkar; sekme zaten "Takvim" diyor.
  - "Bekleyen talepler (0)" düğmesi kalkar. Talep sayısı "Talepler" sekmesinde rozet olarak görünür.
  - Tür ve Durum filtreleri, üstlerindeki etiketlerle birlikte tek satıra iner.
  - Aşı bandı kalkar.
- Kapalı ve boş gün (pazar) sütunu 58 px'e daralır. Diğer günler genişler: 1536 px ekranda gün başına yaklaşık 200 px.

**Kart: önce saat, sonra hasta, sonra sahip**

| Kart yüksekliği | İçerik |
|---|---|
| 40 px'ten az (30 dk) | Tek satır: [durum simgesi] **09:30** **Zeytin** · S. Aydın [EA]. Gün görünümünde kart geniş olduğu için şöyle yazılır: **09:00–09:30 Karamel** · Emre Aksoy · Aşı. |
| 40 px ve üstü | 1. satırda saat aralığı ve hekim rozeti, 2. satırda **Hasta** · sahip. |
| 56 px ve üstü | 3. satır eklenir: tür · hekimin tam adı. |
| Çakışan şeritler (hafta) | Yalnız saat ve hasta yazar, hekim rozeti düşer. Ayrıntı balonda. |

- **Kısaltma sırası:** Yer daralınca önce sahip adı kısalır ("S. Aydın"), sonra hasta adı. Saat hiç kısalmaz; rakamlar sabit genişliktedir.
- **Hekim:**
  - Hafta görünümünde nötr bir baş harf rozeti (EA) gösterilir. Tam ad rozetin `title`'ında ve balonda yer alır.
  - Hekimsiz randevuda rozet kesik çizgili "–" olur.
  - Tek hekimli klinikte rozet hiç gösterilmez.
  - Gün görünümünde hekim zaten sütundur; sütun başlığında "6 randevu · 4 bekliyor" yazar.
  - Hekim başına zemin rengi (`VET_TONES`) kalkar; gerekçe 3. bölümde.
- **Gün başlığı:** "16 Pazartesi … 5 randevu" ve altında aşı sayacı. Bugünün numarası dolu kutu içinde gösterilir ve sütun hafif tonlanır. Ayrı "Bugün" rozeti kalkar.
- **Şimdi çizgisi:** Ana renkte (koyu turkuaz) olur, kartların altından geçer. Saat sütununda şimdiki saat yazar ("14:20"). O an süren randevunun çevresine sarı bir halka gelir.
- Ayrıntı balonu ve randevu penceresi bugünkü gibi kalır (`calendar-bubble`).

**Ay görünümü** (`#ay`)

- Hücrenin başlığında gün numarası ve "6 randevu" yazar; gecikmiş varsa kırmızıyla "· 1 gecikmiş" eklenir.
- Altında ilk iki randevu saatiyle gösterilir ("▌09:00 Karamel"). Kalanlar için "+N randevu" yazar.
- En altta tek satırlık aşı sayacı vardır.
- Kapalı günün başlığında "kapalı" yazar.
- Hücreye tıklanınca o güne geçilir. Randevu satırları için 42 günlük `GET /appointments/calendar` çağrısı gerekir; sınır 45 gün olduğu için sığar. Aşılar özet ucundan gelmeye devam eder (bkz. açık soru 2).

## 3. Durum renkleri: renk şeritte, zemin yalnız gecikmişte

Kullanıcının 2026-11-16'da seçtiği dört renk aynen kalır (`calendar-layer.utils.ts`, `vaccineChipClass` yorumu): bugün sarı, gelecek siyah, gecikmiş kırmızı, tamamlanan yeşil. Değişen şey rengin nasıl uygulandığı:

| Durum | Kart |
|---|---|
| Gelecek | Beyaz zemin, koyu 4 px sol şerit. Varsayılan, sakin görünüm. |
| Bugün (bekliyor) | Beyaz zemin, sarı şerit. Sütun hafif tonlu. O an süren randevunun çevresi sarı. |
| Gecikmiş | Kırmızı şerit, açık kırmızı zemin, "!" simgesi, saat kırmızı. Zemin rengi yalnız bu durumda kullanılır. |
| Tamamlanan | Yeşil şerit, "✓" simgesi, soluk yazı. |
| Gelmedi / iptal | Gri şerit, taralı zemin, üstü çizili yazı, "Gelmedi" etiketi. Durum filtresine girmez (§6.1). |
| Çakışma | Kırmızı halka; bugünkü gibi kalır. |

- **Kural: renk istisnayı işaretler.** Haftada 77 tam dolgulu çip olunca renk her yere yayılıyor ve hiçbir şeyi ayırt etmiyor (`#renkler`, orta sütun). Şerit ve simgeyle göz önce gecikmişi, sonra saati görür. Simge ve yazı durumu ayrıca taşıdığı için renk körü kullanıcı da durumu okuyabilir.
- **Aynı dil her yerde:** Filtre çipleri renk açıklaması işini görür; çiplerdeki şerit kartlardaki şeritle aynıdır. Aşı panelindeki satır şeridi ve ay hücresindeki çizgi de aynı renkleri kullanır.
- **Hekim rengi kalkar:** Turuncu "bugün", gül rengi "gecikmiş", açık yeşil "tamamlandı" gibi okunuyor. İki ayrı renk sistemi aynı kartta yarışıyor.
- **Şimdi çizgisi kırmızı olmaz:** Kırmızı yalnız gecikmiş ve çakışma için ayrılır.
- **Gelmedi rengi değişir:** Bugünkü kodda "Gelmedi" kehribar rengi (`statusBar` 3 → `amber`) ve "Bugün" sarısıyla karışıyor. Taslakta gri ve taralı.
- **Koyu tema:** Aynı renk değişkenleri koyu temada da tanımlı (`1536-hafta-koyu.png`).

## Uygulama notları (Opus için)

1. **Backend (önce):** `AppointmentCalendarItemDto` alanına `state` (`CalendarItemState?`) eklenmeli. Kural backend'de tek yerde duruyor (`CalendarItemStateRule.ForAppointment`); filtrede ve özet ucunda kullanılıyor ama takvim yanıtında yok. Böylece istemci "bugün mü, gecikmiş mi" hesabını kendi yapmaz. Ekleme geriye dönük uyumlu, migration gerekmez. Sözleşme §6.1'e bir satır eklenir.
2. **Frontend:**
   - `calendar-vaccine-strip` kalkar, yerine gün başlığında sayaç ve panel gelir.
   - `appointment-calendar-grid`:
     - `allDay` bandı kalkar.
     - `PX_PER_MIN` hesaplanan bir değere dönüşür.
     - `VET_TONES` ve `toneClass` kalkar; `vetDotClass` filtrede kullanılıyorsa nötr baş harfe dönüşür.
     - Kart düzeni yukarıdaki tabloya göre yeniden yapılır.
     - Kapalı ve boş sütun daralır.
   - `appointment-calendar-month` hücresi değişir.
   - `calendar-grid.utils` içinde `gridBounds` aralığı "çalışma saati ∪ randevu" olarak hesaplanır.
   - Renk sınıfları tek yerde, `calendar-layer.utils` içinde durur; `vaccineChipClass` şerit sınıfına dönüşür.
3. **Mevcut uçlar yeter:** Sayaç için `vaccinations/calendar/summary`, panel için `vaccinations/calendar`, ay görünümündeki randevu satırları için `appointments/calendar` kullanılır.

## Açık sorular

1. Bir günün çalışma saati 14 saati aşıyorsa (örneğin yerel denemedeki pazar 01:00–23:59) bunu veri hatası sayıp aralığı randevulardan ve 08:00–20:00'den mi alalım? Yoksa çalışma saatine olduğu gibi uyalım mı? Taslak, çalışma saatinin olduğu gibi alındığını varsayıyor.
2. Ay hücresinde randevu satırları istiyor muyuz? İstersek 42 günlük randevu listesi çekilir; istemezsek bugünkü gibi yalnız sayı ve durum noktası kalır.
3. Hafta görünümünde aşı paneli kapalı başlıyor. Gün görünümünde açık. Bu ayrım uygun mu?

## Ekran görüntüleri

| Dosya | Ne gösterir |
|---|---|
| `1536-hafta.png` | Hafta, ilk açılış: 09:00–18:00 kaydırmasız sığıyor, gün başlığında aşı sayacı |
| `1536-hafta-asi-paneli.png` | Hafta, bugünün sayacına tıklanmış: sağ panelde aşılar |
| `1536-gun.png` | Gün, iki hekim sütunu ve sağda "Bugünün aşıları" |
| `1536-ay.png` | Ay, hücrede ilk iki randevu ve aşı sayacı |
| `1536-renkler.png` | Durum renkleri, tam dolgunun neden seçilmediği, sayaç biçimleri |
| `1536-hafta-koyu.png` | Hafta, koyu tema |
