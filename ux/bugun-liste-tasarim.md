# Bugün: günlük liste yeniden tasarım taslağı (2026-11-18)

**Durum:** Taslak, kullanıcı seçimi bekliyor. Kod yazılmadı. Seçimden sonra kodu Opus yazacak.
**Kapsam:** Panelde `/panel/today`: "Bekliyor / Devam ediyor / Planlı randevular / Tamamlandı / Gelmedi" grupları. Sayfa başı, Liste ve Hastalar seçimleri ile Açık işler çipleri korunur.
**Taslak:** [`bugun-liste-taslak/bugun-liste-taslak.html`](bugun-liste-taslak/bugun-liste-taslak.html). Tıklanır, statik bir sayfa. Veriler uydurmadır ve saat 15:20 kabul edilir.
- Üst çubuktaki çizgili şeritten A, B ya da C seçilir. Adresler `#A`, `#B`, `#C`.
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
