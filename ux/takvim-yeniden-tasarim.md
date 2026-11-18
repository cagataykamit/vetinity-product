# Randevu takvimi: yeniden tasarım taslağı (2026-11-18, 2. tur)

**Durum:** Taslak, onay bekliyor. Kod yazılmadı. Onaydan sonra kodu Opus yazacak.
**Kapsam:** Panelde `/panel/appointments/calendar`: hafta, gün ve ay görünümleri.
**Taslak:** [`takvim-taslak/takvim-taslak.html`](takvim-taslak/takvim-taslak.html). Tıklanır, statik bir sayfa; veriler uydurmadır, gerçek hasta ya da sahip adı yoktur.
- Üstteki çizgili şeritten A, B ya da C seçilir. Gün, Hafta ve Ay düğmeleri her seçenekte çalışır.
- "Renk açıklaması" ve "Açık / koyu tema" bağlantıları da aynı şeritte.
- Adres biçimi `#A-hafta`, `#B-gun`, `#C-ay`.

## Seçim: üç düzen (kullanıcı seçecek)

Hepsinde ortak olanlar:
- Aşı ve randevu saate göre tek akışta durur, saat satırın başındadır.
- Durum renkle gösterilir (sol şerit), tür biçimle ayrılır.
- Uygulanan aşılar tek satıra toplanır.
- Saati bilinmeyen aşılar "Saatsiz" başlığı altında durur.

Seçenekler arasındaki fark, haftanın ve günün nasıl dizildiği:

| | Hafta | Gün | Kimin işine yarar | Zayıf yanı |
|---|---|---|---|---|
| **A · Sütun akış** | Her gün bir sütun, içinde saat sırasıyla randevu kartları ve tek satırlık aşılar | Saat ızgarası: hekim sütunları ve ayrı bir "Aşılar" sütunu | Haftayı bir bakışta görmek isteyen | Dar sütunda sahip adı kısalır; yoğun gün kaydırılır |
| **B · Ajanda** | Günler alt alta, her iş bir satır: saat, iş, hasta · sahip, hekim, durum, eylem ("Kabul et", "Aşıyı yap") | Aynı tablo, tek gün | Resepsiyon: hiçbir şey kısalmaz, satırdan iş yapılır | Haftanın tamamı bir ekrana sığmaz; açılışta bugüne kayar |
| **C · Saat ızgarası** | Bugünkü ızgara korunur; randevu blok, aşı her gün sütununun sağındaki şeritte saatiyle metin | Saat ızgarası (A ile aynı) | Boş saat ve doluluk görmek isteyen, hekim | Kartta yalnız hasta adı sığar; sahip balonda |

Ay görünümü üç seçenekte de aynı.
**Ekran görüntüleri:** `takvim-taslak/1536-*.png`. Kullanıcının ekranı 1920×1080, ölçek %125 (tarayıcı içi 1536×728 CSS piksel). Görüntüler bu boyutta, başsız Chrome ile alındı.

**2. turda ne değişti:** 1. turda aşılar gün başlığında bir sayaç ve yan panelde bir listeydi. Kullanıcı, aynı klinik ve aynı hafta için E-vet takviminin ekran görüntülerini gönderdi ve şu düzeni istedi: **aşı ve randevu tek akışta, saatler görünür**. Yönlendirmesi "kopyalamasın, daha iyisini, kullanıcı dostu olanı yapalım; olmadı kullanıcıya seçenek sunarız" oldu. Bu tur o yönde kuruldu. 1. turun sayaç ve panel önerisi geri çekildi.

## Sorun

Canlıdaki görünüm, 2026-11-18:

- Planlı aşılar ızgaranın üstünde ayrı bir bantta duruyor. Günde 10–20 renkli çip var ve bant ekranın yarısını kaplıyor. Randevular altta kalıyor ve kaydırmadan görünmüyor.
- Kullanıcının sözü: "Saatler belli değil, takvime bakıyorum ne olduğu belli değil."
- Bandın kurulma gerekçesi doğruydu: aşı randevu yeri doldurmaz, çakışma ve "Boş saat bul" hesabına girmez. Sorun bandın ayrı olması değil, sınırsız uzayıp ızgarayı aşağı itmesiydi.

**E-vet'ten alınan klinik pratik** (görünüm alınmadı):

- Aşı ve randevu gün içinde saate göre tek listede duruyor.
- Yapılacak aşı görevlerinin bir saati var.
- Tür ve durum ayrı gösteriliyor.
- Tamamlananlar takvimde kalıyor.

E-vet'te zayıf bulduğumuz yerler:

- Hafta kartı 3 satır ve her satır "…" ile kesiliyor. Tür ("Aşıla…") ve hasta adı çoğu kartta okunmuyor.
- Tür için ayrı bir renk ekseni kullanılıyor (turuncu aşı, yeşil kontrol, mavi diğer). Bu renkler durum renkleriyle aynı aileden: yeşil hem "kontrol" hem "tamamlandı" anlamına geliyor.
- Ay hücresi sınırsız uzuyor. Tamamlananlar da tek tek listeleniyor, yani bitmiş iş dikkat isteyen işle aynı ağırlıkta.
- Aşının saati çoğu zaman randevu saati değil. 00:14, 06:10, 20:17, 21:53 gibi saatler var; aynı sahibin dört aşısı 12:01–12:03 arasına dizilmiş. Bu saatler büyük olasılıkla görevin girildiği an. Randevu gibi bir blok olarak çizilince sahte doluluk yaratıyor.

## Önerilen düzen: tek akış, saat önde

**Temel kural:** Gün, saate göre sıralı tek bir akıştır. Randevu ve aşı aynı listededir ve saat her satırın en başında durur. Böylece "kim ne zaman geliyor" yukarıdan aşağı okunur.

### Hafta: liste (varsayılan)

`1536-hafta.png`, ayrıntılı hâli `1536-hafta-ayrintili.png`.

- Her gün bir sütundur. Saat ızgarası yoktur, öğeler saate göre sıralıdır. Boş saat yer kaplamaz, yoğun gün de sığar.
- **Gün başlığı:** "16 Pazartesi" ve altında "5 randevu · 13 aşı · 4 gecikmiş". Yalnız gecikmiş sayısı kırmızıdır.
- **Akışın başı:**
  - "✓ 8 aşı uygulandı ▸": uygulanmış aşılar tek satıra toplanır, tıklanınca açılır.
  - "SAATSİZ · 2": saati bilinmeyen aşılar. Saat uydurulmaz.
- **Bugün sütunu:** Şimdiki saatin geçtiği yere ana renkte "14:20 ———" ayracı girer.
- **Randevu kartı:**
  - 1. satır: saat aralığı (kalın), tür (gri etiket), hekim baş harfi.
  - 2. satır: **hasta** · sahip.
  - "Ayrıntılı" seçilirse 3. satırda hekimin tam adı.
- **Aşı satırı:**
  - Kısa hâlde tek satır: saat · kalkan simgesi · **hasta** · aşı adı.
  - Ayrıntılı hâlde ikinci satıra sahip gelir.
- **Randevulu hastanın aşısı:** Aynı gün aynı hastanın randevusu varsa aşı ayrı satır olmaz, randevu kartının altında görünür ("Kedi karma (FVRCP) · Aşıyı yap"). Hasta bir kez okunur, iş tek yerde biter. Eşleştirme istemcide `petId` ile yapılır.
- **Kısaltma sırası:** Yer daralınca önce sahip adı, sonra tür kısalır. Saat ve hasta adı en son kısalır.
- **Kapalı gün:** Taralı gösterilir ve daha dar olur. O güne düşen aşılar yine görünür.
- **Yoğun gün:** Gün uzunsa sütunlar birlikte kayar, başlık sabit kalır. Kaydırma artık gün içinde ileri saate gitmek demek. Bugünkü gibi aşı bandını geçip randevuyu aramak gerekmez.

### Gün: saat ızgarası (varsayılan)

`1536-gun.png`

- **Sütunlar:** Hekim başına bir sütun ("6 randevu · 4 bekliyor"), yanında ayrı bir **"Aşılar"** sütunu.
- **Aşılar sütunu:**
  - Aşı randevu bloğu gibi çizilmez, yer kaplıyor görünmez.
  - Yarım saatlik dilimde ilk aşı tek satır olarak görünür, kalanlar "+N" olur. Dilimde en acil durum öne alınır.
  - Saatsiz ve mesai sonrası aşılar sütun başlığında sayı olarak durur ("2 saatsiz · 1 mesai sonrası ▾"). Tıklanınca açılır.
- **Ölçek:** Izgara, gösterilen günün çalışma saatleriyle o günün randevularının birleşimine ekrana sığacak şekilde ölçeklenir. Kullanıcının ekranında 09:00–18:00 kaydırmasız sığıyor, bir saat yaklaşık 54 px. Mesai dışındaki aşı ızgarayı genişletmez.
- **Kart:** Geniş olduğu için tek satır: "**09:00–09:30 Karamel** · Emre Aksoy · Aşı · Karma (DHPPi+L)".
- **Şimdi çizgisi:** Ana renkte, kartların altından geçer. Saat sütununda "14:20" yazar.

### Hafta: saat ızgarası (seçenek)

`1536-hafta-izgara.png`

- Saat dilimini görmek isteyen (örneğin boş yer arayan resepsiyon) içindir.
- Randevular blok olarak çizilir. Aşılar her gün sütununun sağındaki ince şeritte, yarım saatlik dilimde **sayı** olarak görünür; üzerine gelince liste açılır. Mesai dışındaki aşılar kenarda "↑1 / ↓1" olarak durur.
- Dar sütunda hasta adı kısalıyor. Varsayılan bu yüzden liste.

### Ay

`1536-ay.png`

- Hücre başlığında "6 rnd · 9 aşı · 3 gecikmiş" yazar.
- Altında yalnız **dikkat isteyenler** saatiyle listelenir: gecikmişler, bugünün bekleyenleri, ilerinin ilk üçü. Kalanlar "+N daha" olur.
- Tamamlananlar sayıya girer, satır olarak gösterilmez. Hepsi bitmişse "✓ hepsi tamamlandı" yazar.
- Hücre uzamaz; hücreye tıklanınca o güne geçilir.
- Veri kaynağı: 42 günlük `GET /appointments/calendar` (sınır 45 gün) ve aynı aralık için `GET /vaccinations/calendar`.

## Durum ve tür: iki ayrı eksen

`1536-renkler.png`

**Durum = renk.** Kullanıcının 2026-11-16'da seçtiği dört renk aynen kalır: bugün sarı, gelecek koyu, gecikmiş kırmızı, tamamlanan yeşil. Renk yalnız sol şeritte ve simgede kullanılır.

| Durum | Görünüm |
|---|---|
| Gelecek | Koyu şerit, beyaz zemin. Varsayılan, sakin görünüm. |
| Bugün | Sarı şerit. O an süren randevunun çevresi sarı. |
| Gecikmiş | Kırmızı şerit, açık kırmızı zemin, "!" simgesi, saat kırmızı. Zemin rengi yalnız bu durumda kullanılır. |
| Tamamlanan | Yeşil şerit, "✓", soluk yazı. Uygulanan aşılar tek satıra toplanır. |
| Gelmedi / iptal | Gri şerit, taralı zemin, üstü çizili, "Gelmedi" etiketi. Bugünkü kodda kehribar renkte ve "Bugün" sarısıyla karışıyor. |

**Tür = biçim, renk değil.**

- **Randevu:** Çerçeveli kart, saat *aralığı*, gri tür etiketi (Kontrol, Muayene, Operasyon…).
- **Aşı:** Çerçevesiz satır, kalkan simgesi, tek *an*. "Randevu yeri doldurmaz" bilgisi görünüşten okunur.
- **Neden türe renk yok:** Tür listesi kliniğe göre uzuyor (nedenler), renkle ayırt edilemez. Durum renkleriyle de karışır; E-vet'teki "yeşil kontrol mü, tamamlandı mı" sorunu bundan doğuyor.

**Diğer kurallar:**

- Hekim, nötr bir baş harf rozetiyle gösterilir (EA). Hekim başına zemin rengi (`VET_TONES`) kalkar.
- Şimdi çizgisi ana renktedir. Kırmızı yalnız gecikmiş ve çakışma içindir.
- Filtredeki durum çipleri renk açıklaması işini görür; çiplerdeki şerit kartlardaki şeritle aynıdır.

## Kullanıcıya görünüm seçeneği

`1536-hafta-ayarlar.png`

Tek bir düzen herkese uymayabilir: hekim günü saat ızgarasında, resepsiyon haftayı listede görmek isteyebilir. Araç çubuğundaki "Görünüm" düğmesi beş seçenek açar:

| Seçenek | Değerler | Varsayılan |
|---|---|---|
| Hafta | Liste / Saat ızgarası | **Liste** |
| Gün | Saat ızgarası / Liste | **Saat ızgarası** |
| Ayrıntı | Kısa / Ayrıntılı | **Kısa** |
| Aşılar | Akışta / Gizli | **Akışta** |
| Uygulanan aşılar | Tek satırda / Hepsi | **Tek satırda** |

- **Varsayılanların gerekçesi:**
  - Haftada amaç kimin ne zaman geleceğini okumak; liste bunu yoğun günde de kaydırmasız yapar.
  - Günde amaç slot ve hekim dağılımı; bunu ızgara verir.
  - Aşılar akışta olur, çünkü kullanıcı bunu istedi ve gecikmiş aşı gözden kaçmamalı.
- **Hatırlama:** Seçim **kullanıcı başına** hatırlanır, klinik başına değil; aynı klinikte hekim ve resepsiyon farklı seçebilir. İlk sürümde tarayıcıda saklanır. Bugünkü filtreler de böyle saklanıyor (`vetinity.calendar.filters`, `calendar-layer.utils.ts`), aynı desen izlenir.
- Klinik genelinde bir varsayılan ve sunucuda kullanıcı tercihi ilk sürümde yok; gerekirse sonra eklenir. "Varsayılana dön" bağlantısı var.
- "Aşılar: Gizli" seçeneği, Tür filtresinden "Planlı aşılar"ı kaldırmakla aynı sonucu verir; kural tek yerde, `calendarRequestFor` içinde kalır. Düğme yalnız kısayoldur.

## Backend: aşı saatinin korunması (ayrı madde)

Takvim tek akışa geçerse aşının bir saati olması gerekir. Bugün sorun iki yerde:

1. **E-vet aktarması saati atıyor.** `EVetBackupConverter.cs:612` sonraki aşı tarihini saatiyle alıyor (`last.DueAt = due.Start`), ama `:789` satıra `yyyy-MM-dd` olarak yazıyor. Saat burada kayboluyor. `Vaccination.DueAtUtc` `DateTime` olduğu için saati tutabilir; kaybın nedeni şema değil, aktarma.
2. **Saatin bilinip bilinmediği ayırt edilemiyor.** Panelden girilen planlı aşı yalnız tarih taşıyor. Sözleşme §5.2 bunu açıkça yazıyor: "vadeli satırda saat anlamlı değildir". Saatli ve saatsiz kayıt aynı alanda olunca istemci hangisinin gerçek saat olduğunu bilemez.

**Öneri:**

- `Vaccination`'a `DueTimeSpecified` (bool, varsayılan `false`) eklenir.
  - **Migration gerekir.** Mevcut kayıtlar `false` olur, yani bugünkü gibi saatsiz kalır.
  - E-vet aktarması tarihi saatle yazar ve `true` işaretler.
  - Panelin aşı formuna isteğe bağlı "Saat" alanı eklenir.
  - `GET /vaccinations/calendar` yanıtına `timeSpecified` alanı eklenir. Sözleşme §5.2 güncellenir: saatli satır akışta saatiyle yer alır, saatsiz satır "Saatsiz" grubuna girer.
  - Vade ve gecikme kuralı gün bazlı kalır (ADR-028). Saat yalnız sıralama ve gösterim içindir. Hatırlatma, çakışma ve boş saat hesabı değişmez.
- **Elenen seçenek:** "Saat 00:00 ise saatsiz say" kuralı. E-vet'te gece yarısına yakın gerçek saatler var (00:14), kural kırılgan olur.
- **Yayındaki veri:** Pilot kliniğin daha önce aktarılmış 5754 sonraki doz tarihinin saati yeniden aktarma yapılmadan geri gelmez. Bu, güncelleme aktarmasıyla (ADR-051) ya da yeniden aktarmayla yapılabilir; canlı veriye dokunduğu için kullanıcı onayı gerekir. Saat gelene kadar bu kayıtlar "Saatsiz" grubunda görünür.
- **Ayrıca,** randevu takvimi yanıtına `state` (`CalendarItemState?`) eklenmeli. Kural backend'de tek yerde (`CalendarItemStateRule.ForAppointment`); filtrede ve özette kullanılıyor ama takvim yanıtında yok. Bu ekleme geriye dönük uyumludur, migration gerekmez.

## Uygulama notları (Opus için)

**Sıra:** Önce backend (saat bayrağı ve migration, aktarma, `timeSpecified`, randevu `state`), sonra frontend.

**Frontend:**

- `calendar-vaccine-strip` kalkar.
- `appointment-calendar-grid`:
  - `allDay` bandı kalkar.
  - `PX_PER_MIN` hesaplanan bir değere dönüşür.
  - `VET_TONES` kalkar.
  - Hafta için aşı sayı şeridi, gün için "Aşılar" sütunu eklenir.
- Hafta listesi için yeni bir bileşen gerekir (gün sütunu ve tek akış).
- `appointment-calendar-month` hücresi değişir.
- Görünüm seçenekleri `calendar-layer.utils` içindeki depolama deseniyle saklanır.
- Renk sınıfları tek yerde durur.

**Telefon:** Ajanda zaten liste. Aynı tek akış kuralı uygulanır; ayrı bir "Aşılar" kutusu kalmaz.

## Açık sorular

1. **Migration onayı:** `DueTimeSpecified` alanı ve pilot klinik verisinde aşı saatinin yeniden aktarılması onaylanıyor mu?
2. **Ay hücresi:** 42 günlük randevu ve aşı listesi çekmek kabul edilebilir mi? Alternatif: yalnız gecikmişler ve sayı.
3. **Saat ızgarası ve E-vet saatleri:** E-vet'ten gelen aşı saatleri randevu saati değil (00:14, 06:10, 21:53). Bunlar da saat ızgarasına konsun mu? Yoksa yalnız panelden saatiyle girilen aşılar mı saatli sayılsın, aktarılan saat yalnız sıralamada mı kullanılsın?

## Ekran görüntüleri

| Dosya | Ne gösterir |
|---|---|
| `1536-hafta.png` | Hafta, liste, kısa (varsayılan): aşı ve randevu tek akışta, saat önde |
| `1536-hafta-ayrintili.png` | Hafta, liste, ayrıntılı: aşıda sahip, randevuda hekimin tam adı |
| `1536-hafta-ayarlar.png` | "Görünüm" seçenekleri açık |
| `1536-hafta-izgara.png` | Hafta, saat ızgarası seçeneği: aşı sağ şeritte sayı |
| `1536-gun.png` | Gün, saat ızgarası: hekim sütunları ve "Aşılar" sütunu |
| `1536-ay.png` | Ay: yalnız dikkat isteyenler, tamamlananlar sayıda |
| `1536-renkler.png` | Durum (renk) ve tür (biçim) eksenleri |
| `1536-hafta-koyu.png` | Hafta, koyu tema |

## 3. tur: kullanıcının seçtiği örneklerden üç seçenek (2026-11-18)

Kullanıcı 2. turdaki A/B/C düzenlerinin hiçbirini beğenmedi. Başka uygulamalardan örnek istedi ([`takvim-taslak/ornekler.html`](takvim-taslak/ornekler.html)) ve 3, 9 ve 15 numaraları seçti:

- **3:** Digitail ay görünümü.
- **9:** Bir klinik programı tasarımı.
- **15:** Bir salon randevu takvimi tasarımı.

Bu örneklerin görünümü kopyalanmadı, yalnız fikirleri alındı. Taslak: [`takvim-taslak/takvim-taslak-3.html`](takvim-taslak/takvim-taslak-3.html). Adres biçimi `#1-gun`, `#2-hafta`, `#3-ay`.

| Seçenek | Gün görünümü | Hafta ve ay |
|---|---|---|
| **1 · Klinik panosu** (9) | Üstte günün özeti (randevu, tamamlandı, klinikte, sıradaki, aşı, gelmedi); hekim sütunlarının yanında bir "Aşılar" sütunu; sağda "Klinikte" ve "Boş saatler" | Gün sütunlarında küçük kartlar; her günün başında aşı sayısı |
| **2 · Ferah kartlar** (15) | Özet ve sağ panel yok; çerçevesiz, gölgeli büyük kartlar, ad 16 px; durum renkli nokta ile gösterilir; saat başı 104 px | Aynı sade kart dili |
| **3 · Ajanda + takvim** (3) | Solda küçük ay takvimi ve "Bugün" listesi: randevu ve aşı saat sırasıyla tek listede, saatsizler başta; kart zemini durum renginde | Sol panel kalır; kartlar durum renginde dolgulu |

Ortak olanlar:
- Kartta hasta adı büyük, saat adın üstünde küçük.
- Muayenedeki randevu koyu ana renkte; klinikte bekleyen sarı ve kaç dakikadır beklediği yazılı.
- Geçmiş işler soluk.
- Şimdi çizgisi ana renkte.

Gün görünümünde yazı büyük olduğu için mesai saatleri ekrana sığmaz. Sayfa şimdiki saate kaydırılmış açılır.

"Klinikte" bilgisi Bugün sayfasındaki kabul kuyruğundan alınacak (`waitingVisits`); takvimde kullanılıp kullanılamayacağı doğrulanmadı.

Görüntüler `takvim-taslak/3-<seçenek>-<görünüm>.png` dosyalarında.
