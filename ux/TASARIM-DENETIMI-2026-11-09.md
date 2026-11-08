# Vetinity tasarım denetimi (2026-11-09)

**Durum:** Denetim ve öneri. Kod değiştirilmedi, commit atılmadı, dal açılmadı, `ng test` / `dotnet test` / build çalıştırılmadı, dev sunucu açılmadı (makine yükü). Ürün kararı gerektiren maddeler "karar" diye işaretli; kullanıcı onayı bekler.

**Kaynaklar:** 26 hazır ekran görüntüsü (`C:\FrontEnd\veteriner-frontend\public\marketing\screens\`, açık/koyu, masaüstü/telefon); panel kodu (`src\app`: layout, `_menu.scss`, `_dark.scss`, `_mobile.scss`, `_responsive.scss`, `_core.scss`, `panel-navigation.ts`, paylaşılan bileşenler, Bugün, hasta kartı, hasta özeti); `projects\portal`, `projects\site`, `projects\site-engine`, `features\clinic-site`, `features\vet-finder`; ürün deposunda `ux\` (ilkeler, navigasyon, Ekim iş akışı denetimi, tanıtım tasarımı), ADR-004/017/022/023/026/031/034/042/045/047. Dört alt ajan tanıtım sitesi, portal, klinik sitesi + veteriner bul ve panel metin taramasını (grep tabanlı) yaptı; bulguları doğrulanan dosya yollarıyla buraya alındı.

**Sınırlar:** Piksel, taşma ve kontrast değerleri ekran görüntüsü ve koddan (token hex, sınıf adı) çıkarımdır; tarayıcıda ölçülmedi. Böyle yerler **(doğrulanmadı)** ile işaretli. Kullanıcı tercihi gereği ölçüler ekran görüntüsünden değil koddan okundu (kök yazı 14 px, `_core.scss:4`; menü satırı `clamp(22px…38px)`, `_menu.scss:266`; dokunma hedefi 44 px, `_common.scss:21`). Rakip görünümü kopyalanması önerilmez.

Yol kısaltmaları: `FE` = `C:\FrontEnd\veteriner-frontend\src\app`, `P` = `C:\FrontEnd\veteriner-frontend\projects`, `UR` = `C:\Vetinity\vetinity-product`.

---

## 0. En önemli 10 bulgu

| # | Bulgu | Öncelik | İş |
|---|---|---|---|
| 1 | **Panelde eylem sözlüğü ve yazım tek değil.** Aynı iş üç adla: "Muayene aç" (Bugün) / "Muayene Oluştur" (randevu detayı) / "Muayene başlat" (hasta kartı); "Ödeme al" / "Ödeme Oluştur" / "Yeni Ödeme"; "Ücret ekle" / "Yeni Ücret". ~50 düğme/başlık kelime başı büyük ("Yeni Randevu", "Şifre Değiştir", "Devam Et"), geri kalan panel cümle düzeni. | Yüksek | küçük |
| 2 | **Bugün satırında eylem hiyerarşisi karışık.** Bekleyen satırda yeşil birincil "Muayene aç" ile gri "Başlat" yan yana; "Başlat" neyi başlattığı metinden anlaşılmıyor (bakım durumu). Acil anahtarı basılıyken kırmızı dolu yuvarlak düğme, durum rozetiyle karışıyor. "Hekim: Atanmadı" her satırda tekrar. Telefonda hızlı eylemler 3 satıra sarıyor, kart içinde iki tam genişlik düğme + yuvarlak kırmızı + "…" dikey alan yiyor. | Yüksek | orta |
| 3 | **Portalın ana işi 3 tık derinde.** Randevu talebi oluşturma yalnız Randevular → "Randevu talepleri" → "Yeni randevu talebi" yoluyla; ana sayfada ve Randevular başında birincil düğme yok. Gecikmiş aşı kartı "kliniğinizi arayın" diyor, talep formuna götürmüyor. | Yüksek | orta |
| 4 | **Dört yüzey, dört renk dili.** Panel: PrimeNG Aura varsayılan `emerald` (`FE\layout\service\layout.service.ts:39`). Tanıtım: lacivert `#0b1d3a` + turkuaz `#0fa39a`. Portal: turkuaz `#0b6f69` özel düğme + emerald pButton yan yana. Site sihirbazı: siyah `#16181b`, Instrument Sans, koyu tema yok. Giriş/kayıt sayfaları Sakai kalıntısı (56 px köşe, gradient çerçeve, teal üstünde beyaz ≈3:1). Tanıtımdan "Ücretsiz dene"ye tıklayan kullanıcı üç farklı görsel dilden geçiyor. | Yüksek | orta–büyük (**karar**) |
| 5 | **Tanıtım sitesinde çelişen metin ve ADR-034'e aykırı iddia.** Kayıt sayfası "ödeme sonraki fazda eklenecektir" derken paketler sayfası fiyat yazıyor (`FE\pages\auth\owner-signup-page.component.ts:187`). Paket kartlarında hasta sahibi portalı "var" (`FE\entities\subscription\utils\pricing-plan.utils.ts:187-188`); ADR-034 karar 6 "yalnız geliştiriliyor" diyor. | Yüksek | küçük (**karar**) |
| 6 | **Klinik sitesi: iki varsayılan konsept kendi kontrast denetiminden geçemiyor.** Modern vurgu `#e4572e`/beyaz ≈3.7:1, Nature `#a9582f`/`#eff2e7` ≈4.48:1 (`P\site-engine\src\engine\site-tokens.ts:115-126`); kullanıcı hiçbir şey değiştirmeden 2. adımda "kontrast düşük" uyarısı görüyor, Nature'da "4.5:1" yazıp "en az 4.5:1" diyor. (doğrulanmadı: hesap elle) | Yüksek | küçük |
| 7 | **Kabul edilmiş kararlardan sapmalar görünür metinde.** ADR-022'ye karşı "Hayvan" etiketi 6 yerde (ör. `FE\features\appointment-requests\pages\appointment-requests-page.component.ts:84` tablo başlığı "Hayvan"; `waitlist-entry-dialog.component.ts:47`); kullanıcı tercihine karşı "Süzgeç" 6 görünür yerde (ör. `FE\shared\ui\context-filter-chip\app-context-filter-chip.component.ts:12` "Süzgeci kaldır"); ADR-026'ya karşı Özet'te 6 "Detay" metin bağlantısı (`FE\features\dashboard\pages\dashboard-page.component.html:227,423,533,616,654,679`). | Yüksek | küçük |
| 8 | **Koyu temada kart–zemin ayrımı yok.** Zemin `surface-950`, kart `surface-900` (`_dark.scss:2`, `--surface-card`); yalnız kenar çubuğu için 1 px çerçeve eklendi (`_dark.scss:12-16`, yorum "~1.1:1"). İçerik kartları (`.card`, `_utils.scss:11`) aynı sorunu taşıyor; koyu ekran görüntülerinde kart kenarı seçilmiyor. (doğrulanmadı: oran ölçülmedi) | Orta | küçük |
| 9 | **Boş/yükleniyor/hata durumları yarı ortak.** `app-empty-state` 75 kullanımın 26'sı `hint`'siz ("Kayıt yok." ile bitiyor); 13 yerde elle "Yükleniyor…", 12 yerde elle "Kayıt yok"; kısmi hata "alınamadı" turuncu, tam hata kırmızı; "Tekrar dene" / "Yeniden dene" iki biçim. UX ilkesi 15 ("boş durum sonraki adımı öğretir") yarım uygulanıyor. | Orta | orta |
| 10 | **Site sihirbazında klinik sahibine dönük jargon ve dil karışımı.** "Hero", "footer", "navigasyon" (`P\site-engine\src\model\site.model.ts:219-230`, `FE\features\clinic-site\builder\content-step.component.ts:24,79`); konsept adları İngilizce ("Modern Veterinary", "Nature & Wellness", `site-concepts.ts:28-121`); "VeterinaryCare (JSON-LD)", "sitemap.xml" açıklamasız; "Devam Et". Pazarlamadaki `klinik-sitesi-dark.webp` açık sürümle birebir aynı (sihirbazın koyu teması yok). | Orta | küçük |

---

## 1. Tutarlılık

### 1.1 Renk ve marka

| Yer | Sorun | Neden önemli | Öneri | Öncelik / iş |
|---|---|---|---|---|
| `FE\layout\service\layout.service.ts:39`, `FE\app.config.ts:24` | Panel birincil rengi PrimeNG Aura'nın hazır `emerald` paleti; `definePreset` yok. Tanıtım `--vetinity-teal #0fa39a` / lacivert, portal `#0b6f69`. Logo turkuaz-lacivert. | Marka rengi ürün içinde hiçbir yerde kullanılmıyor; "hazır şablon" izlenimi. | Tek `definePreset` ile primary'yi marka turkuazına çek (WCAG için 600/700 tonları kontrol); portal aynı preset'i alsın; tanıtım değişkenleri aynı hex'lerden türesin. **Karar:** renk seçimi kullanıcının. | Yüksek / orta |
| `FE\features\inventory\...\product-stocks-page:86`, `stock-movements-page:90`, `product-stock-movements-page:102` | Üç "Dışa aktar" düğmesi `severity="help"` (mor); panelde başka hiçbir yerde mor yok (`help` 3 / `secondary` 199). Ekran: `stok-light.webp` sağ üstte mor düğme. | Tek anlam için ayrıksı renk; dışa aktar diğer sayfalarda gri/çerçeveli. | `secondary`. | Orta / küçük |
| `FE\features\visits\pages\today-page\today-page.component.ts:218` (`text-orange-600`) vs hasta kartı "Açık borç" kırmızı (`client-pets-panel:71`), gecikmiş aşı `text-amber-700` (`pet-vaccination-plan:113`) / `text-orange-700` (`examination-patient-context:94`) | Aynı anlam iki ton: borç Bugün'de turuncu, hasta kartında kırmızı; "gecikme" amber ve turuncu karışık (turuncu 40, amber 177 kullanım). | Renk anlam taşıyorsa tek olmalı. | Uyarı = amber tek ton; borç = tek renk (kırmızı ise her yerde). | Orta / küçük |
| ~535 yerde `<small class="text-red-500">` form hatası; PrimeNG `p-error` 0 | Hata rengi tek yerde yaşamıyor. | Tema değişince 535 yer elle. | Ortak `app-field-error` ya da tek sınıf; ayrı dalga. | Düşük / büyük |
| `P\portal\src\app\layout\portal-content.scss:105-136`, `portal-list.scss:37-71`, `portal-booking-*.ts` | Portalda ~15 farklı hex elle yazılı; `:root`'ta 6 değişken. `.portal-dark` varyantı hazır ama hiç uygulanmıyor. | Koyu tema, klinik marka rengi (APPT-022) ve Capacitor paketi için tek yerden değişim yok. | 8–10 token (`--portal-accent-strong`, `--portal-warn-*`, `--portal-danger`, `--portal-info-*`). | Orta / orta |

### 1.2 Tipografi ve ölçek

| Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|
| `_core.scss:4` kök 14 px; Tailwind `text-sm` = 12,25 px, `text-xs` = 10,5 px | Yardımcı metinler çok küçülüyor: "Tahsilata dahildir." (`gun-sonu-light.webp`), form ipuçları ("Vital değerler opsiyoneldir…", `muayene-light.webp`), daraltılmış menü rozeti 0,65 rem ≈ 9 px (`_menu.scss:382`). Kaç yerde `text-xs` var sayılmadı (doğrulanmadı). | Ürün genelinde alt sınır 12 px: `text-xs` yerine `text-sm`, rozet en az 10 px. Kök 14 px kararı korunuyorsa Tailwind ölçeğini buna göre bir basamak kaydır (tek yer: `tailwind.css`). | Orta / küçük–orta |
| `_typography.scss:19-41` h1 2,5 rem … h6 1 rem; `app-page-header` başlık `text-xl` (20 px); `app-list-header` ayrı bileşen | Sayfa başlığı iki bileşenden geliyor (109 `app-page-header`, 21 `app-list-header`); list-header'da kategori satırı yok, "N kayıt" var. İkisi de kullanmayan 2 sayfa (`change-password-page`, `site-builder-page`). | Tek başlık bileşeni (liste modu girdi ile). | Düşük / orta |
| Tanıtım `public-home-page.component.ts:74,119,133,182` | h3 ölçeği `text-lg` / `text-xl` / `text-base` karışık; tasarım belgesi 22/20 der. Bölüm dikey ritmi 64/80/112 px karışık (tasarım 64/96). | `.public-section` ve tek h3 sınıfı. | Düşük / küçük |
| Hukuki sayfalar `FE\pages\public\legal-document-page.component.ts:28,44,57` | Gövde `text-sm` (14 px), `max-w-3xl`; uzun metin için küçük. | `text-base`, 720 px. | Düşük / küçük |

### 1.3 Köşe, boşluk, simge

- Panel: `--content-border-radius` tek kaynak; menü/flyout/kart tutarlı. Olumlu.
- Portal: 0,375 / 0,5 / 0,625 / 0,75 / 0,875 rem / 999 px karışık, token yalnız 0,875 (`P\portal\src\styles.scss:14`). Düşük / küçük.
- Giriş/kayıt: `public-page-theme.scss:1015-1019` 56 px köşe + gradient çerçeve; tasarım ilkesi "gradient yalnız kahraman". Orta / küçük.
- Simge ailesi: menü ve satır eylemleri Font Awesome Solid (ADR-026), düğmeler PrimeIcons (`pi pi-*`), rapor/ayar kartları PrimeIcons. İki aile aynı ekranda (Bugün: FA menü + pi düğme). Kabul edilmiş karışım; ama yalnız simgeli düğmelerde (`pi-exclamation-triangle`, `pi-ellipsis-h`) FA'nın dolu stili ile pi'nin ince çizgisi yan yana ağırlık farkı yaratıyor (`bugun-light.webp` sağ sütun). Düşük / orta (karar: tek aile mi).

### 1.4 Düğme hiyerarşisi

| Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|
| `today-page.component.html:409-433`; `bugun-light.webp` | Bekleyen satırda "Muayene aç" (birincil, dolu) + "Başlat" (ikincil) + Acil anahtarı + "…": satırda 4 kontrol, 2'si metinli. "Başlat" bakımın başladığını işaretliyor ama metin bunu söylemiyor; "Muayene aç" zaten bakımı başlatıyorsa (doğrulanmadı) "Başlat" fazlalık. Devam eden satırda "Tamamla" ikincil; oysa akışın sonraki adımı. | Satırda tek birincil: bekleyende "Muayene aç", devam edende "Tamamla" (ya da "Bakımı tamamla"); "Başlat"ı "…" menüsüne al ya da "Muayene aç" ile birleştir. Acil anahtarı: basılı durumu dolu kırmızı düğme yerine satır başında rozet + menüde "Acil işaretini kaldır". | Yüksek / orta |
| `today-page.component.html:119-120, 199-215` | "Hekim: Atanmadı" 6 satırın 6'sında aynı. | Boş değer soluk "—"; atama yapılabiliyorsa tıklanır "Hekim ata". | Orta / küçük |
| `telefon-bugun-light.webp`; `today-page.component.html:1-20` | Telefonda Yenile · Randevusuz geliş · Yeni randevu · Yeni muayene · Hızlı satış 3 satıra sarıyor (~250 px); "Yenile" metin düğmesi birincilin yanında aynı yazı ağırlığında. | Telefonda yalnız "Randevusuz geliş" + "…" (diğerleri menüde); Yenile simge düğmesi. | Orta / küçük |
| `FE\entities\patient\components\patient-action-bar\patient-action-bar.component.ts:24-33`; `hasta-karti-light.webp` | 9 düğme: "Geldi" birincil + 8 eşit çerçeveli (Muayene başlat, Randevu al, Aşı, Lab, Görüntüleme, Yatış, Ücret ekle, Ödeme al). Telefonda `flex-wrap` ile 3–4 satır (doğrulanmadı). ADR-020 "şimdi ne yapılır" şeridi; ama 8 eşit seçenek öncelik vermiyor. | Role göre ilk 3–4 görünür (sekreter: Geldi, Randevu al, Ödeme al; hekim: Muayene başlat, Aşı, Lab) + "Diğer ▾". | Orta / orta |
| `FE\features\pets\pages\pet-detail-page\pet-detail-page.component.ts:81` | "Vefat olarak işaretle" kimlik kartının sağında "Düzenle" ile eşit görünürlükte; nadir ve duygusal bir eylem. | Kartın "…" menüsüne ya da Düzenle sayfasına. | Orta / küçük |
| `kesinlestirme-light.webp` (muayene detayı) | "Değişiklikleri gör" dolu gri, "Düzenle" çerçeveli, "Şablon uygula" metin: üç ikincil düğme üç stil. | Tek ikincil stil (çerçeveli); en az kullanılan metin düğmesi. | Düşük / küçük |
| `kayit-defteri-light.webp` (rapor filtre çubuğu) | Sıra: Temizle · **Filtrele** · PDF · Excel · CSV · Yazdır (6 düğme). Birincil ortada, "Temizle" önde. "Kayıtlı filtreler" alanı tarih alanlarının üstünde. | Filtrele en solda birincil, Temizle metin düğmesi sağında; PDF/Excel/CSV/Yazdır → tek "Dışa aktar ▾"; kayıtlı filtre tarihlerin altında. Aynı çubuk tüm raporlarda (ortak bileşen). | Orta / küçük–orta |
| Portal `portal-content.scss:132-136` vs pButton | İki birincil düğme stili aynı ekranda: `.portal-action-link--primary` (#0b6f69) ve pButton (emerald). Örn. "Taleplerimi gör" biri, "Talebi gönder" diğeri. | Tek birincil = pButton; `--primary` action-link yalnız `tel:`/`mailto:`. | Orta / küçük |

### 1.5 Tablolar, formlar, diyaloglar

| Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|
| `stok-light.webp`; stok durumu sayfası | "Klinik" sütunu 10 satırda aynı değer (tek klinik); "Kategori" tümü "—"; satır eylemi yalnız göz, ADR-026 md. 6 "Düzenle her listede" gereği ürün düzenleme simgesi yok (doğrulanmadı: satır ürün mü stok kaydı mı). | Tek klinikte Klinik sütunu gizle (çok klinikte göster); boş sütunu başa değil sona; Düzenle simgesi. | Orta / küçük |
| `asi-sihirbazi-light.webp` | Aşı–Doz arası ~600 px boşluk; satır 55 px. Başlık "Bulut — aşı planı" sayfa başlığı; menüde "Aşı planı öner" küçük metin bağlantısı (`pet-summary-card.component.ts:190`). | Sütun genişliklerini içeriğe göre; satır sıkılaştır; hasta kartında bağlantıyı eylem çubuğundaki "Aşı" düğmesine bağla (bkz. 2.3). | Düşük / küçük |
| `pet-summary-card.component.ts:164-176` | "Son uygulanan:" ve "Sıradaki:" ile değer arasında boşluk yok ("Son uygulanan:Karma", "Sıradaki:planlanmış aşı yok"; Angular boşluk düşürmesi). Ekran: `hasta-karti-light.webp`. | Etikete `&nbsp;` ya da `mr-1`. | Düşük / küçük |
| `gun-sonu-light.webp` | "19 kayıt" sayacı kartların arasında, hiçbir karta ait görünmüyor. | Tablo kartının başlığına. | Düşük / küçük |
| `kvkk-formu-light.webp` | "Kabul ediyorum / Kabul etmiyorum" iki kutu yan yana; "Metin sürümü: Varsayılan metin" küçük. Kabul edilebilir; yazdırma biçimi. | — | — |
| Panel `.p-dialog` telefonda tam ekran (`_mobile.scss:71-84`) | Doğru yaklaşım; dialog başlıkları 28/28 cümle düzeni. Olumlu. | — | — |
| Form hata–alan bağı: tanıtım demo formu (`public-demo-request-form.component.ts:47-115`), kayıt (`owner-signup-page.component.ts:154-156` `<label for>` ↔ `p-password` `inputId` yok), portal 4 form | `aria-invalid` var, `aria-describedby` yok; kayıtta alan altı hata yok, tek genel "Tüm zorunlu alanları doldurun." | Hata `<small>`'a `id`, girdiye `aria-describedby`; `inputId="password"`. | Orta / küçük |

### 1.6 Boş / yükleniyor / hata durumları

- `app-loading-state` 103, `app-error-state` 104, `app-empty-state` 56 dosyada: temel iyi.
- Elle "Yükleniyor…" 13 yer (`client-portal-access-panel:132`, `client-pets-panel:99`, `pet-card-timeline:45`, `pet-summary-card:92,117,150`, `examination-procedures-section:100`, `cash-registers-page:188`, `performance-page.html:28`, `clinics-overview-page.html:33`, `site-builder-page:133`, `wizard-kit:407`); elle "Kayıt yok" 12 yer (`dashboard-page.html:639,664`, `examination-detail-page:310`, `pet-summary-card:18,30`, `pet-card-timeline:59,85`, `pet-timeline-page:95,125`, `waitlist-page:117`, `patients-home-page:69`).
- `hint`'siz boş durum 26 ("Kayıt yok.", "Not yok.", "Bildirim yok.", "Bu müşteriye ait randevu kaydı yok."…). Nokta karışık (37 noktalı / 107 noktasız `message`).
- Kısmi hata "alınamadı/Alınamadı" turuncu (`client-card-header:152,177`, `examination-patient-context:73,107,133`), tam hata kırmızı; "Tekrar dene" (ortak) / "Yeniden dene" (sihirbaz ×2).
- Öneri: boş durum şablonu "ne yok + ne yapılır" (hint ya da eylem zorunlu); 25 elle yazılan metin ortak bileşene; kısmi hata için tek stil kararı. **Orta / orta.**

---

## 2. Bilgi mimarisi ve iş akışı

### 2.1 Menü ve gezinme

Menü (`FE\core\routing\panel-navigation.ts:320-424`): Günlük iş (Bugün, Randevular) · Müşteri ve hasta · Klinik (Kayıtlar) · Para ve stok (Para, Stok) · Yönetim (Raporlar, Özet, Ayarlar) + WhatsApp destek. ADR-017/023 ile uyumlu, 8–9 satır, sekmeler flyout'ta başlıksız (kullanıcı tercihi). Olumlu.

| Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|
| `panel-navigation.ts:351` "Müşteri ve Hasta" vs `:341` "Bekleme listesi", `:368` "Kayıtlar" | Menü öğesi kelime başı büyük, diğerleri cümle düzeni; sayfa başlığı "Müşteri ve Hasta" iken flyout sekmesi "Ara". | "Müşteri ve hasta"; Ara sayfası başlığı = sekme adıyla hizalı. | Düşük / küçük |
| `panel-navigation.ts:178,190,197,223,230,278,558,568` | Rapor kartları "Randevu Raporu", "Ödeme Raporu"…, Ayarlar "Organizasyon Ayarları", "Hatırlatma Geçmişi" kelime başı büyük; `page-title.strategy.ts:14` "Randevu Takvimi" (menü "Takvim"). Diğer 60+ öğe cümle düzeni. Resmî defter adları istisna kalabilir. | Cümle düzeni; "Organizasyon Ayarları" → "Kurum ayarları" (sayfa içi her yerde "Kurum"). | Orta / küçük |
| `panel-navigation.ts:216-221` | **Kasa** Rapor Merkezi'nde "Para" bölümünde kart; ama açıklaması "kasaya giriş/çıkış, aktarım, kasa tanımları" — günlük işlem aracı, rapor değil. Sekreter kasayı Raporlar'da aramaz. | Kasa'yı Para sekmesi yap (Ücretler · Ücret bekleyenler · Ödemeler · Satışlar · **Kasa**); Raporlar'da yalnız kasa raporu kalsın. ADR-023 md. 4 ("yeni sayfa ilgili satırın sekmesi") ile uyumlu. **Karar.** | Orta / küçük |
| `panel-navigation.ts:498-609` Ayarlar | 5 bölüm, 20 kart; "Davetler" ve "Davet oluştur" iki ayrı kart; "Klinikler" ile "Organizasyon Ayarları" ayrı; "Tanımlar" bölümünde tek kart "Tanımlar". Settings home kart ızgarası doğrulanmadı (görüntü yok). | Davet oluştur → Davetler sayfasında düğme; Tanımlar bölüm başlığını kaldırıp kartı "Klinik ve kurum"a al; 20 → ~16 kart. | Düşük / küçük |
| `FE\features\imports\routes\imports.routes.ts:26`; `subscription-page.component.ts:117` | **Geçiş desteği** Ayarlar → Veri içe aktarma → Geçiş desteği (3. seviye) ve Abonelik sayfasında kart. Yeni kullanıcı için en kritik ilk hafta işi, iki yan yolda. | Ayarlar "Veri" bölümünde kendi kartı ("Eski programdan geçiş: içe aktarma ve destek"); ilk hafta rehberi kartından doğrudan bağlantı (var mı doğrulanmadı). | Orta / küçük |
| `panel-navigation.ts:593-599` API erişimi; `:544-550` Veteriner bul; `:538-543` Web sayfam | Ayarlar altında bulunabilir, açıklamalar net. Olumlu. "Web sayfam" ile tanıtımdaki "klinik web sitesi" terimi farklı. | "Web sitem" ya da her yerde "web sayfası". | Düşük / küçük |
| İlk hafta rehberi: `today-page.component.html:21` kart + kullanıcı menüsü (`app.topbar.ts:139`) | İyi yerleştirilmiş. | — | — |
| Bekleme listesi: Randevular sekmesi (`:341`); Aşı sihirbazı: hasta kartı metin bağlantısı (`pet-summary-card:190`) | Bekleme listesi doğru yerde. Aşı sihirbazı yalnız özet kartındaki küçük bağlantıdan; eylem çubuğundaki "Aşı" düğmesi tek aşı kaydı formuna gidiyor (doğrulanmadı). | "Aşı" düğmesi menü: "Aşı uygula" / "Aşı planı öner". | Orta / küçük |

### 2.2 Sık işlerin tıklama sayısı (koddan; kullanıcıyla ölçülmedi, alt sınır)

Ekim denetimindeki sayım (`UR\ux\ARAYUZ-IS-AKISI-DENETIMI-2026-10.md` §3.3) kısmen eskidi; bugünkü yollar:

| İş | Yol | Tık | Not |
|---|---|---|---|
| Randevulu geliş (sekreter) | Bugün › Geldi › diyalog kaydet | 2 | İyi |
| Randevusuz geliş | Bugün › Randevusuz geliş › ara+seç › kaydet | 3 | İyi; yeni müşteri+hasta mini form aynı diyalogda |
| Muayene (hekim) | Bugün › Muayene aç › form | 1 + form | İyi; "Başlat" ile ilişkisi belirsiz (1.4) |
| Ücret (sekreter) | Hasta kartı › Ücret ekle › form; ya da Para › Ücretler › Yeni Ücret › müşteri seç | 1–3 + form | Hasta kartından iyi; "Ücret bekleyenler" sekmesi (ADR-018) var |
| Ödeme | Bugün satırı "Müşteri borcu" › … › Ödeme al; hasta kartı Yapılacaklar › Ödeme al | 2–3 | "Müşteri borcu ₺1.600" metni tıklanır değil (doğrulanmadı); doğrudan ödeme al bağlantısı olsa 1 tık |
| Randevu | Bugün › Yeni randevu › form | 1 + form | İyi |
| Aşı uygulama | Hasta kartı › Aşı › form | 1 + form | İyi |
| Aşı planı | Hasta kartı › Aşı planı öner (küçük bağlantı) › sayfa › onay | 2–3 | Bulunabilirlik düşük |
| Gün sonu | Raporlar › Gün sonu › tarih | 2 | İyi; Bugün'den kısayol yok |

Öneri: Bugün'deki "Müşteri borcu" rozeti doğrudan "Ödeme al"a bağlansın (küçük); Bugün sağ üstte gün sonuna kısayol (akşam) (küçük, **karar**).

### 2.3 Ön büro ve hekim için hız

- Sekreter: Bugün ekranı iyi; telefonda hızlı eylem sarması ve 9'lu eylem çubuğu yavaşlatıyor (1.4). Global arama Ctrl+K var (olumlu). Kayıt defteri filtre çubuğu 6 düğme (1.4).
- Hekim: Muayene formu iki sütun, sol "Hasta bağlamı" kartı 40 % genişlik alıp kısa kalıyor (`muayene-light.webp`): form alanı daralıyor; "Şikâyet sözlüğünde ara" ayrı satır. Öneri: bağlam kartı daraltılabilir yan şerit (~280 px) ya da üstte tek satır özet; sözlük arama şikâyet alanının içine. Orta / orta.
- Kesinleştirme kontrolü sağ sütunda liste + düğme (ADR-027) iyi; ancak "Ücret ekle" yeşil birincil sayfanın en üstünde, "Kesinleştir" de yeşil birincil sağda: aynı sayfada iki birincil. Öneri: "Ücret ekle" ikincil (hekim zaten ücret ekleyemez, ADR-012; görünüyorsa role bağlı). Orta / küçük.

---

## 3. Okunurluk ve erişilebilirlik

| Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|
| `_dark.scss:2`, `_utils.scss:11` `.card` | Koyu temada zemin `surface-950` / kart `surface-900`; kart sınırı yok. Kenar çubuğuna 1 px çerçeve eklenmiş, içerik kartlarına eklenmemiş. Koyu ekranlarda (`bugun-dark.webp`, `muayene-dark.webp`) kart kenarı seçilmiyor. (doğrulanmadı: oran) | `.card` ve `p-card` için koyu temada `box-shadow: 0 0 0 1px var(--surface-border)` (kenar çubuğuyla aynı kural, tek yerde). | Orta / küçük |
| `_dark.scss:18-24` | Gri düğme ve toggle'a koyu temada 3:1 çerçeve eklenmiş. Olumlu; ama `rounded` metin düğmeler ("…", Acil pasif) kapsam dışı. | `p-button-text` için hover dışında sınır gerekmez; kabul. | — |
| Odak: `_mixins.scss:1-10`, menü `outline 2px` (`_menu.scss:135`), satır eylemi (`row-action-button:76`) | Odak halkası tanımlı ve görünür. Olumlu. Tanıtım/portal sekmeleri `role="tablist"` ama ok tuşu yok (`public-home-page:85-101`, `portal-appointments.component.html:9-23`). | Ok tuşu ya da `aria-pressed` segment. | Düşük / küçük |
| Renge dayalı anlam | Durum rozetleri metin taşıyor (`app-status-tag`), satır eylemleri `aria-label` + ipucu. Olumlu. İstisna: Acil anahtarı basılı/pasif yalnız renk + simge; `aria-pressed` var, görsel fark yalnız dolgu (1.4). | Basılıyken "Acil" rozeti + anahtar. | Orta / küçük |
| Dokunma hedefi | Panel 44 px kural (`_mobile.scss`, `row-action-button:87-90`), portal `--portal-touch`, site motoru 44/48 px. Olumlu. Sapma: Veteriner bul çipleri ≈34 px, kart düğmesi 40 px (`P\site\src\vet-finder.css:96-106, 235-240`). | `min-height: 44px`. | Orta / küçük |
| Yazı boyutu | Kök 14 px + `text-xs` = 10,5 px (1.2). Giriş alanları telefonda 16 px (`_mobile.scss:33-47`) doğru. | Alt sınır 12 px. | Orta / küçük–orta |
| 375 px taşma (doğrulanmadı) | Panel: tablolar `table-stack-phone` ile karta dönüyor (`_mobile.scss:105-145`), üst çubuk 360 px'te taşmıyor (yorum). Tanıtım karşılaştırma tablosu 4 sütun `table-layout: fixed; min-width: 21rem` (`public-page-theme.scss:597-605`): 375 px'te paket sütunu ~77 px, `overflow-wrap: anywhere` kelime ortasından bölebilir; tasarım "mobilde akordeon" diyordu. Portal başlıkta çok klinikte ad ~135 px alana sığmalı (`styles.scss:409-411`). | Tanıtım: `md` altında grup akordeonu ya da paket başına liste; "Sadece farkları göster" mobilde varsayılan açık. Portal: "Değiştir" yalnız simge ya da ad tek satır + ellipsis. | Orta / orta |
| Avatar baş harfi `account-summary.utils` `.toUpperCase()` ×3 | "i" → "I" (Türkçe "İ" olmalı). | `toLocaleUpperCase('tr-TR')`. | Düşük / küçük |
| `_menu.scss:81-95` menü başlığı CSS `uppercase` + `lang="tr"` | Doğru (İ/ı tarayıcıda çözülür). | — | — |
| Site sihirbazı `site-builder-page.styles.ts:129-131` "Panele dön" 1040 px altında `display:none` | Erişilebilir ad `title`'a kalıyor. | `sr-only` ile gizle. | Düşük / küçük |
| Site motoru nav çekmecesi (`nature-nav.component.ts:25-37`) | Escape/odak tuzağı görülmedi (doğrulanmadı: dosya tam okunmadı). | Escape, açılınca Kapat'a odak, kapanınca Menü'ye. Dört nav için. | Orta / orta |
| Portal `fa-regular fa-calendar-plus` (`portal-add-to-calendar.component.ts:46`) ama yalnız `solid.min.css` yüklü | Glif boş kalabilir (doğrulanmadı). | `fa-solid`. | Düşük / küçük |

---

## 4. Metin ve dil

Panel taraması (grep, sayılar ±birkaç):

| Konu | Bulgu | Öneri | Öncelik / iş |
|---|---|---|---|
| Eylem adları | Muayene: "Muayene aç" (Bugün) / "Muayene Oluştur" (`appointment-detail:122-128`, aynı akış) / "Yeni muayene" / "Muayene başlat" (hasta kartı). Ödeme: "Ödeme al" (`charges-list:138`) / "Ödeme Oluştur" (6 detay sayfası) / "Yeni Ödeme" (`payments-list:83`), hepsi `/payments/new`. Ücret: "Ücret ekle" / "Yeni Ücret". Randevu: "Yeni randevu" / "Yeni Randevu" (6) / "Yeni randevu oluştur" / "Randevu al". Dialog kapatma: "Vazgeç" 11 dosya, "İptal" 5, "Kapat" 3 ("İptal" aynı zamanda iş eylemi: "Randevuyu iptal et"). | Sözlük (tek yer, `UR\ux\design-decisions.md`'ye ek): **Muayene aç · Yeni randevu · Ödeme al · Ücret ekle · Geldi · Vazgeç**; ~25 yer. | Yüksek / küçük |
| Büyük-küçük harf | Kelime başı büyük ~50 düğme/başlık: "Yeni Randevu/Müşteri/Hasta/Ücret/Ödeme/Klinik/Tür/Irk", "Ödemeyi Düzenle"…, "Müşteri Düzenle" (ek eksik), "Şifre Değiştir" ×2, "Devam Et", "Muayene/Ödeme/Reçete Oluştur"; tablo başlıkları "Ad Soyad", "Kayıt Tarihi", "Randevu Türü"; bölüm başlıkları "Çalışma Saatleri", "Fatura Adresi". Dialog başlıkları 28/28 cümle düzeni. | Cümle düzeni standart (resmî defter adları ve özel adlar istisna). | Yüksek / küçük |
| ADR-022 "Hayvan" | Görünür 6: `waitlist-entry-dialog:47` etiket "Hayvan"; `appointment-requests-page:84` başlık "Hayvan" (yanı "Sahip"); `clinic-reminder-rule.model.ts:44`; `portal-inbox-page:171`; `vet-finder-settings-page:57,124` "Hayvan sahipleri" (başka yerde "Hasta sahipleri"). "HBS Hayvan Kimlik No" resmî ad, kalır. | "Hasta"; talep tablosu "Müşteri | Hasta". | Yüksek / küçük |
| "Süzgeç" (kullanıcı: "filtre") | Görünür 6: `app-context-filter-chip:12` "Süzgeci kaldır"; `charge-suggestions-page:120` ×2; `client-pets-panel:27` aria; `import-review-step:168,179` aria; bir `app-empty-state` "Bu süzgece uyan satır yok." Yorumlarda ~48 (dokunulmasa da olur). | "Filtre". | Yüksek / küçük |
| Müşteri / Sahip / Hasta sahibi | "Müşteri" 160, "Sahip" 40, "Hasta sahibi" 20. Kural yazılı değil; aynı tabloda "Sahip | Hayvan" vs başka tabloda "Müşteri | Hasta". | Kural: varlık/liste = Müşteri; hasta kartında ilişki satırı "Sahip:"; müşteriye hitapta "hasta sahibi". Bir cümle `design-decisions.md`'ye. | Orta / küçük |
| Lab / Laboratuvar | Menü "Lab sonuçları", timeline "Lab" (`pet-timeline.utils:114`) ama aynı dosyada :20 "Laboratuvar"; rol metinleri "Laboratuvar sonucu". | Tek biçim ("Lab" kısa kalacaksa her yerde). | Orta / küçük |
| Geliş / Ziyaret | Düğme "Geldi", isim "Geliş" (14) ve "Ziyaret" (11: "Ziyaret sebebi", "ödemesi açık ziyaretler"); aynı alan iki sırayla: "Ziyaret sebebi / şikâyet" (`workspace.html:131`) ve "Şikâyet / ziyaret sebebi" (`detail:66`). | "Geliş" tek; alan "Şikâyet / geliş sebebi" tek sıra. | Orta / küçük |
| "Görüntüleme" çift anlam | Modül adı ve "görme yetkisi" (`panel-tr.ts:9` "Görüntüleme yetkiniz olan klinik bulunmuyor"). | Yetki cümlelerinde "görme/okuma yetkisi". | Düşük / küçük |
| ₺ / TRY | `money` pipe tek kaynak (olumlu); görünür "₺" 2, "(TRY)" 1 (`charge-suggestion-convert-dialog:55` "Birim fiyat (TRY) *"). | "(₺)". | Düşük / küçük |
| ya da / veya | 24 dosyada ikisi birden. | Tek bağlaç. | Düşük / küçük |
| Erişilebilir ad idiomu | `aria-label` 72, `[attr.aria-label]` 60, `ariaLabel` 90; ipucu `pTooltip` 3, `title` 218. Eksik ad bulunamadı (olumlu). | Kural yazılsın (bir cümle). | Düşük / küçük |
| Tarih | `trDate`/`trDateTime` tek kaynak, `dd.MM.yyyy HH:mm`. Olumlu. | — | — |

Site sihirbazı ve klinik sitesi metinleri için 6.2; tanıtım ve portal için 5 ve 6.1.

---

## 5. Tanıtım sitesi

Genel: Tasarım belgesinin iskeletine uyuyor (tek h1, "İçeriğe atla", odak tuzağı, 44 px, koyu tema, gerçek ekran görüntüleri, yasak iddialar yok, "Şu an yok" listesi dürüst, JSON-LD). Sorunlar metin tutarlılığı ve giriş/kayıt sayfalarının marka dışı kalması.

| # | Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|---|
| T1 | `FE\pages\auth\owner-signup-page.component.ts:187` | "Bu adımda ödeme alınmaz; deneme süresi kurum aboneliğinde başlatılır. Paket değişimi ve ödeme sonraki fazda eklenecektir." — SSS (`public-faq-content.utils.ts:80,89`) ve paketler sayfası fiyatıyla çelişiyor; "kurum aboneliği" jargon. | Gerçek akışa göre tek cümle: "Bu adımda ödeme alınmaz; 14 gün sonra paket seçip panelden ödersiniz." | Yüksek / küçük |
| T2 | `pricing-plan.utils.ts:187-188, 42` | Hasta sahibi portalı ve portaldan randevu talebi paket satırı olarak "var". ADR-034 karar 6: yalnız "geliştiriliyor". Dosya yorumu 2026-11-09 kullanıcı kararı diyor; ADR'de yok. | **Karar:** ya ADR-034/031'e "portal yayında" notu ya satırlar "yakında" rozeti. | Yüksek / küçük |
| T3 | `public-home-page.component.ts:51-52`, `public-cta.component.ts:19-20` | Birincil "Ücretsiz dene", ikincil "Demo iste"; ADR-034 karar 5 "pilot bitene kadar demo öne". Örnek klinik artık kayıtta var (`owner-signup:170`), gerekçe düştü. | ADR notu; metin değişmez. | Orta / küçük (**karar**) |
| T4 | `public-plan-comparison.component.ts:67-86`, `public-page-theme.scss:597-605` | Telefonda 4 sütunlu sıkıştırılmış tablo (3.) ve ~48 satır × 6 grup; "Sadece farkları göster" kapalı. | Mobil akordeon; farklar varsayılan açık. | Orta / orta |
| T5 | `public-page-theme.scss:1070-1074, 1015-1019, 930-941`; `owner-signup-page.component.ts:110,170,266` | Giriş/kayıt: teal zemin + beyaz metin (≈3:1), 56 px köşe + gradient, etiket 1,25 rem; seçili paket çerçevesi `text-primary` = emerald. | Auth kartı `public-card`, düğme `public-btn-primary` (lacivert), seçili paket `--vetinity-teal`. | Orta / orta |
| T6 | `owner-signup-page.component.ts:133,139,67` | "Klinik / işletme adı *" + "İlk klinik adı *" iki ad alanı (tek hekimli hedef kitle için kafa karıştırıcı); "Seçilen plan" (sitede her yerde "paket"). | Tek "Klinik adı", kurum adı = klinik adı varsayılan (**karar**); "Seçilen paket". | Orta / orta |
| T7 | `public-contact-content.utils.ts:9,16`; `public-contact-page:24`, `demo-form:32`, `faq-page:52` | Gmail adresi görünür; "bir iş günü" üç yerde elle, `PUBLIC_SUPPORT_RESPONSE_TIME = null`. | AK-6 gelince tek sabit. | Orta / küçük (**kullanıcı**) |
| T8 | CTA metinleri | Deneme için 5 varyant: "Ücretsiz dene" / "14 gün ücretsiz başlayın" / "14 gün ücretsiz deneyin" / "Hesap oluştur" / "Hesabı oluştur"; demo için "Demo iste" / "Canlı demo isteyin". | Düğme = "Ücretsiz dene", "Demo iste"; başlıklar serbest. | Orta / küçük |
| T9 | `public-features-content.utils.ts:161,187`, `pricing-plan.utils.ts:188`, `:132,152`, `public-registers-content.utils.ts:22` vs `pricing-plan:146` | "hayvan"/"hasta", "Müşteri"/"Hasta sahibi", "Aşı Bilgi raporu"/"Aşı Bilgi Raporu". | ADR-022 terimleri; büyük harf tek. | Orta / küçük |
| T10 | `public-demo-request-form.component.ts:47-115`; `public-demo-request.mapper.ts:33-51` | Hata `<small>` kimliksiz; şehir/telefon/program/mesaj hataları şablonda gösterilmiyor; "* zorunlu" açıklaması yok; başarıda odak `role=status`'a gitmiyor. | `aria-describedby`, eksik hata blokları, "* zorunlu alan" satırı. | Orta / küçük |
| T11 | `public-home-page.component.ts:45-46`, `public-features-page:25`, `public-about-page:18,41`, `owner-signup:55,98`, `public-migration-page:37` | "Veteriner klinikleri için" + "Veteriner kliniğinizin günü…" çift "veteriner"; "Modül listesi değil, bir ziyaretin yolculuğu" iç dil; "Küçük veteriner klinikleri için, klinikle birlikte" belirsiz; "Aşağıdaki tarihlerle giriş yapabilirsiniz"; beş adım h2 (düz hiyerarşi). | Metin düzeltmeleri; adımlar h3. | Düşük / küçük |

İlk izlenim ve değer önerisi: "Kliniğinizin günü tek ekranda" mesajı ADR-034 ile uyumlu, kahramanda gerçek ekran görüntüsü var; güven unsuru olarak sayı/referans yerine "yapmıyoruz" listesi ve "yarım günde geçiş" (ADR-019 ölçümü) kullanılmış — dürüst ve yeterli. Paketler sayfası fiyatı backend kataloğundan alıyor, alınamazsa "Fiyat için bize yazın" (ADR-034 karar 4b) — doğru.

---

## 6. Hasta sahibi portalı ve klinik sitesi

### 6.1 Portal (`P\portal\src\app`)

Güçlü: iskelet → hata (Tekrar dene) → boş durum deseni her kartta ve ekran okuyucuya duyurulur (`shared\ui\portal-states.component.ts`); skip link, 3 px odak, 44 px token, 16 px girdi, güvenli alan, hareket azaltma; "talep ≠ randevu" mesajı her noktada (ADR-042); hata metinleri tek yerde (`core\errors\portal-errors.ts`), sunucu metni gösterilmiyor.

| # | Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|---|
| P1 | `features\home\portal-home.component.html` (talep yok), `features\appointments\portal-appointments.component.html:5-7`, `features\booking\portal-appointment-requests.component.html:19-21` | Randevu talebi 3 tık derinde (0. bölüm #3). | Klinik online talep alıyorsa ana sayfa ve Randevular başında birincil "Randevu talebi oluştur"; gecikmiş aşı kartı (`home:68`) aynı bağlantı. | Yüksek / orta |
| P2 | `layout\portal-brand.component.ts:7-8` (bilinçli "Geri yok") | Ana ekrana eklenmiş PWA'da tarayıcı çubuğu yok; hayvan detayından listeye dönmek için alt sekmeye basılıyor. iOS geri hareketi doğrulanmadı. | Alt sayfalarda başlığın solunda "Geri". | Orta / küçük |
| P3 | `portal-home.component.html:5-13 → 19-45 → 48-88 → 92-118` | Klinik kartı en üstte (ad zaten başlıkta), gecikmiş aşı/borç 2.–4. sırada. | Aksiyon gerektiren kart en üste; klinik kartı alta/küçük satıra. | Orta / küçük |
| P4 | `layout\portal-content.scss:132-136` vs pButton | İki birincil düğme stili ve iki yakın yeşil (#0b6f69 / emerald). | Tek birincil (1.4). | Orta / küçük |
| P5 | Hex dağınıklığı (1.1) | Koyu tema yok (`app.config.ts:21-22` bilinçli), `prefers-color-scheme` yok; gece beyaz ekran. | Token çalışması → koyu tema (**karar**). | Orta / orta → büyük |
| P6 | `features\auth\portal-login.component.ts:20-23`, `portal-errors.ts:56,65,68` | Hata metinleri 2–3 cümle, ~150 karakter; telefonda 4–5 satır. Kilit uyarısı ilk hatada gereksiz. | İlk cümle kısa; kilit uyarısı 429'da ya da ikinci hatada. | Orta / küçük |
| P7 | `portal-errors.ts:87,59,75`, `notifications\portal-notification-preferences.component.ts:103`, `balance\portal-balance.component.html:55-56` | "Sunucuya ulaşılamadı", 'KVKK açık rıza kaydınız "Ret"', "Hesabım > Bildirim tercihleri", "ücrete bağlanmamış ödemeler… düşülmemiştir". | "Bağlantı kurulamadı", "Klinikteki kayıtlarınızda hatırlatma izni kapalı", "Hesabım sayfasındaki bildirim tercihleri", "Henüz bir işleme sayılmamış ödemeniz var: X ₺". | Orta / küçük |
| P8 | `account\portal-account-deletion.component.html:16,74` | "Bu işlem geri alınamaz." `portal-muted` gri 15 px; onay adımında yalnız checkbox. | Uyarı bandı, normal renk; kod adımında tekrar. | Orta / küçük |
| P9 | `portal-notification-preferences.component.ts:133` | Kaydedildi geri bildirimi yalnız `sr-only`. | Görünür 2–3 sn "Kaydedildi". | Orta / küçük |
| P10 | `account\portal-account.component.ts:24`, `portal-password-reset.component.ts:33`, `app.routes.ts:51` | Kodla giren hesabın parola belirleme yolu hesap sayfasında yok (sıfırlama guest guard'lı). | Hesapta "Parola belirle" bağlantısı; guard/uç kontrolü (backend sözleşmesine bak). | Orta / orta |
| P11 | `app.routes.ts:145` | `**` → ana sayfaya sessiz yönlendirme; 404 yok. | Kısa "Sayfa bulunamadı" + ana sayfa bağlantısı. | Düşük / küçük |
| P12 | Kod alanları: `portal-public-booking.component.scss:47-53` `.booking-code` yalnız orada; giriş/sıfırlama/silme sıradan kutu. Kod düğmesi 3 metin ("Kod gönder" / "Onay kodu gönder" / "Doğrulama kodu gönder"). | Tutarsız. | `.portal-code` ortak; "… kodu gönder" tek kalıp. | Düşük / küçük |
| P13 | `pets\portal-pet-detail.component.ts:55` | "Kısırlaştırılmış: Hayır" bilinmeyen durumda da yazıyor (boolean). | Nullable ise yalnız bilinen değer (backend). | Düşük / küçük |
| P14 | "Portal" kelimesi kullanıcı metinlerinde (invite:22, shell:58, balance:68, login:114, account:64) | Geçici marka; AK-12 netleşince. | "Uygulama" ya da marka adı. | Düşük / küçük |

ADR-031 K2 boşluğu (not): kesinleşmiş randevu için portaldan iptal/erteleme yok, yalnız e-posta bağlantısından; yol haritasında.

### 6.2 Klinik sitesi: sihirbaz, motor, SSR, veteriner bul

Güçlü: token sözleşmesi tek yerde, `ensureContrast`/`readableOn` ile kontrast güvenceli (`P\site-engine\src\engine\site-tokens.ts`); bölümler sabit renk yazmıyor, konseptler karışabiliyor (ADR-045 K3/K4 gerçekten uygulanmış); 44/48 px hedefler, `alt` disiplini, `aria-current/expanded`, hareket azaltma, DOM ölçümlü denetim (`auditPreview`); randevu düğmesi portal formuna, kapalıysa telefona (K11); reklam uyarısı engellemeden (K14); SSR başlık/OG/JSON-LD/canonical tam, kapalı site 503 + `noindex`; fontlar `@fontsource`, Google Fonts yok (K12).

| # | Yer | Sorun | Öneri | Öncelik / iş |
|---|---|---|---|---|
| K1 | `site-tokens.ts:115-126`, `FE\features\clinic-site\builder\brand-step.component.ts:101-105` | Modern ≈3.7:1, Nature ≈4.48:1 varsayılan vurgu: kutudan çıkınca uyarı; Nature "4.5:1" yazıp "en az 4.5:1" der. (doğrulanmadı) | Vurguları 4.5 üstüne (Modern ~`#c9471f`, Nature ~`#9a4f28`); eşik karşılaştırmasını yuvarlanmış değerle. | Yüksek / küçük |
| K2 | `site-builder-page.styles.ts:3-23`; `klinik-sitesi-dark.webp` = `-light.webp` | Sihirbaz renkleri sabit hex, koyu tema yok; pazarlamada iki özdeş görsel. | Çerçeve token'larına koyu set ya da `-dark` görselini kaldır. | Orta / orta |
| K3 | `site-builder-page.styles.ts:23`, üst çubuk | Instrument Sans + siyah; panelle tek bağ "Panele dön". Nötr "editör çerçevesi" bilinçli görünüyor. | Karar belgesine bir satır; üst çubukta Vetinity işareti ve odak rengi panel primary. | Düşük / küçük |
| K4 | `site-builder-page.component.ts:175` "Devam Et"; `publish-step.component.ts:192` "Geri Al" | Yazım. | "Devam et", "Geri al". | Düşük / küçük |
| K5 | `site.model.ts:219-230`, `content-step.component.ts:24,79,80`, `pages-step.component.ts:40`, `site-claims.ts:62-66`; `site-concepts.ts:28,59,90,121`; `brand-step.component.ts:8-12`; `seo-step.component.ts:75-83` | "Hero", "footer", "navigasyon"; "Modern Veterinary", "Nature & Wellness", "Modern Medical"; "VeterinaryCare (JSON-LD)", "sitemap.xml", "robots.txt" açıklamasız. | "Giriş bölümü", "Alt bilgi", "Üst menü"; "Modern / Zarif / Samimi / Doğal"; her teknik dosyaya bir satır açıklama. Etiketler tek yerde. | Orta / küçük |
| K6 | `site-builder-page.styles.ts:170-181`; `store:40` | "Kaydedildi 14:32" 1040 px altında gizli; yalnız hata görünür. | Dar ekranda simge/kısa metin. | Orta / küçük |
| K7 | `clinic-step.component.ts:25-28,49`; `site-builder-page.component.ts:20` | Alan sırası İlçe–İl (her yerde il, ilçe); 1. adım grubu "Marka" (logo) ile 2. adım "Marka kimliği" (renk) çakışıyor; 2. adım logo için 1. adıma yolluyor (`brand-step:52`). | İl, İlçe; 1. adım grubu "Logo, slogan ve tanıtım" ya da logoyu 2. adıma. | Orta / küçük |
| K8 | `publish-step.component.ts:93`, `site-checks.ts:93`, `wizard-kit.ts:559` vs `site-renderer.component.ts:42` | Sihirbaz "hazır fotoğraf", site "temsili"; yayında çıkacak "Bu sitedeki bazı görseller temsilidir." cümlesi sihirbazda söylenmiyor. | Yayın uyarısına cümleyi ekle; terim "hazır (temsili) fotoğraf". | Orta / küçük |
| K9 | `site-vm.ts:232`; `content-step:29` | Online randevu kapalıysa düğme kliniğin yazdığı metin yerine sabit "Hemen ara"; alanda açıklama yok. | İpucu: "Online randevu kapalıysa düğme telefona bağlanır ve 'Hemen ara' yazar." | Orta / küçük |
| K10 | `site-claims.ts:17-25`; `site.model.ts:206` | K14 taraması "en hızlı/en modern/en yakın", "%100", "ilk ve tek", "ödüllü", "sertifikalı" yakalamıyor; `\bucreti\b` "ücret/ücretler"i kaçırıyor; sayfa ipucu "Hekimler, uzmanlıkları." kendi bayrağını öneriyor. | Liste genişlet; ipucu "Hekimler ve ilgi alanları." | Orta / küçük |
| K11 | `site-hours.ts:90` "Kapalı · Saat girilmemiş"; `vet-finder-card.component.ts:87` "Çalışma saati girilmemiş" | Ziyaretçiye yönetici dili. | "Saat bilgisi yok" / "belirtilmemiş". | Orta / küçük |
| K12 | `premium-hero.component.ts:46-47,64,101,161`, `premium-gallery.component.ts:80-81` | Fotoğraf üstü sabit beyaz metin; açık kullanıcı fotoğrafında başlık okunmayabilir; denetim bunu ölçmüyor (`site-checks.ts:44-54`). (doğrulanmadı) | `text-shadow` ya da gradyanı başlığa kadar; denetime "fotoğraf üstü metin" uyarısı. | Orta / küçük |
| K13 | `modern-hero.component.ts:105-114`; `klinik-sitesi-light.webp` | Künye etiketi 76 px sabit; "Kapalı · Açılış yarın 09:00" kırılıyor, saat tek başına alta düşüyor. | `nowrap` / `minmax(76px, auto)`. | Düşük / küçük |
| K14 | `P\site\src\app\site-page-host.component.ts:19-20` | Kapalı (503) metni "Klinikle iletişim için daha sonra tekrar bakabilirsiniz" bulanık, ad/telefon yok (backend `message` doğrulanmadı); 404 "kapatmış olabilir" yanıltıcı (kapalı ayrı durum). | "Bu site şu anda yayında değil." + telefon (varsa); 404 "Bu adreste klinik sitesi yok." | Orta / küçük–orta |
| K15 | `P\site\src\vet-finder.css:96-106, 235-240`; `vet-finder-page.component.ts:69,71,151-153` | Çip ≈34 px, düğme 40 px; `<a aria-pressed>` geçersiz; sayfa altı yalnız kliniklere seslenir, ziyaretçi için gizlilik/KVKK bağlantısı yok. | 44 px; `aria-current`; alt bilgi + KVKK bağlantısı. | Orta / küçük |
| K16 | `FE\features\vet-finder\...\vet-finder-settings-page.component.ts:86-89,118` | Anahtar değişince durum etiketi kayıtlı değeri gösterir ("Listelenmiyor"); sıralama açıklaması iki yerde farklı cümle. | "Kaydet'e basınca geçerli olur" notu; tek kaynak. | Düşük / küçük |
| K17 | `publish-step.component.ts:31-40,218-223`; `site-builder-page.component.ts:78`; `content-step.component.ts:162`; `wizard-kit.ts:239-245` | 7. adımda üç cihaz küçük resmi dar panelde ~70 px; `aria-valuemax="7"` sabit; "Tanınabilir insan olmayan fotoğraflar seçin" dilbilgisi; `<label>` sayaç metnini okutuyor. | Tek küçük resim + anahtar; `steps.length`; cümle düzelt; sayaç `aria-hidden`. | Düşük / küçük |

Paket özeti (token'lardan): Modern Instrument Sans, beyaz/`#14171a`, ana `#0f4c81`, vurgu `#e4572e` (3.7:1 ✗), köşe 2 px · Premium Cormorant/Jost, gece `#100f0d`/`#f3efe6`, altın `#c7a66b`, fotoğraf üstü beyaz metin riski · Friendly Bricolage/Figtree, krem `#fff3e3`, `#c8401f`/`#f2b233`/`#0f6b62`, köşe 20/32/999 px, ana ≈4.55:1 (sınırda) · Nature Newsreader/Karla, adaçayı `#eff2e7`, `#2f4a36`/`#8a9a6b`/`#a9582f` (4.48:1 ✗ sınırda), köşe 10/14 px.

---

## 7. Güçlü yanlar (kısa)

- Menü ADR-017/023'e sadık, ölçüler koddan (clamp satır, kaydırmasız sığma), flyout başlıksız, rozetler anlamlı; tüm sayfalar claim'e göre gizleniyor (ilke 11).
- Satır eylemleri tek bileşen (`app-row-action-button`): `aria-label`, ipucu, 32/44 px, tehlike rengi (ADR-026 birebir).
- Telefon kuralları tek dosyada (`_mobile.scss`): 44 px, 16 px girdi, tam ekran diyalog, tablo → kart.
- Tarih ve para biçimi tek kaynak (`trDate`, `money`); `lang="tr"`; Inter yerelden (KVKK).
- Koyu tema için bilinçli düzeltmeler belgelenmiş (`_dark.scss` yorumları).
- Hasta kartında "Yapılacaklar" ve "Klinik özet" blokları; muayene detayında kesinleştirme kontrol listesi.
- Portal ve klinik sitesi erişilebilirlik temeli (skip link, odak, hedefler, durum deseni, kontrast güvencesi).
- Tanıtımda abartısız, dürüst dil; yasak iddialar spec'le korunuyor.

---

## 8. Hızlı kazanımlar (< 1 gün, yüksek etki)

1. **Eylem sözlüğü + cümle düzeni** (panel, ~75 metin + spec): Muayene aç · Yeni randevu · Ödeme al · Ücret ekle · Vazgeç; "Yeni Randevu" → "Yeni randevu" vb.; menüde "Organizasyon Ayarları" → "Kurum ayarları", rapor adları cümle düzeni.
2. **Karar sapmaları** (panel, 18 yer): "Hayvan" → "Hasta" (6), "Süzgeç" → "Filtre" (6), Özet'te 6 "Detay" bağlantısı → `app-row-action-button`.
3. **Mor "Dışa aktar"** 3 düğme → `secondary`; Bugün "warning" turuncu → amber.
4. **`pet-summary-card` boşluk** ("Son uygulanan: Karma"); "Hekim: Atanmadı" → soluk "—".
5. **Koyu temada `.card` çerçevesi** (kenar çubuğu kuralının aynısı, `_dark.scss`'e 3 satır).
6. **Site sihirbazı metinleri:** "Devam et"; hero/footer/navigasyon → Giriş bölümü/Alt bilgi/Üst menü; konsept ve palet adları Türkçe; İl–İlçe sırası; teknik dosyalara bir satır açıklama; yayın uyarısına "temsili görsel" cümlesi.
7. **Modern ve Nature vurgu rengi** 4.5:1 üstüne (iki hex) + yuvarlanmış eşik.
8. **Tanıtım:** kayıt sayfası eski cümle (T1); "Seçilen plan" → "paket"; CTA metinleri iki etikete; `inputId="password"`; demo formu `aria-describedby`.
9. **Portal:** alt sayfalarda "Geri"; "Bu işlem geri alınamaz." uyarı bandı; bildirim tercihlerinde görünür "Kaydedildi"; hata metinleri kısaltma (P6–P7); `fa-regular` → `fa-solid`.
10. **Veteriner bul:** çip/düğme 44 px; "girilmemiş" → "belirtilmemiş"; `aria-pressed` → `aria-current`; alt bilgiye KVKK bağlantısı.
11. **Pazarlama görseli:** `klinik-sitesi-dark.webp` kaldır ya da gerçek koyu sürüm üret.
12. **Bugün telefon:** hızlı eylemleri "Randevusuz geliş" + "…" menüsüne indir.

---

## 9. Karar gerektirenler (kullanıcıya)

1. Marka rengi: panel/portal `definePreset` ile turkuaz mı kalacak emerald mı; giriş/kayıt sayfaları tanıtım diline mi çekilecek (0. bölüm #4).
2. Tanıtımda hasta sahibi portalı "var" mı "geliştiriliyor" mu (ADR-034/031 güncellemesi) (T2); deneme/demo sırası ADR notu (T3); kayıtta tek klinik adı alanı (T6); AK-6 iletişim bilgileri (T7).
3. Kasa'nın Raporlar'dan Para sekmesine taşınması (2.1).
4. Bugün satırında "Başlat"ın kaderi (kaldır / menüye al / "Muayene aç" ile birleştir) ve Acil anahtarının gösterimi (1.4).
5. `detail-row-link` (yazı + ok hap) ADR-026 kapsamında mı (ürün kararı).
6. Portal koyu tema (P5) ve klinik sitesi sihirbazı koyu çerçeve (K2).
7. Tek simge ailesi (FA Solid) mi, pi + FA karışımı mı (1.3).

## 10. Doğrulanmayanlar

- Tüm piksel/taşma/kontrast değerleri koddan ve ekran görüntüsünden çıkarım; tarayıcıda 375 px, 992–1100 px ölçümü ve koyu tema kart–zemin oranı ölçülmedi.
- Site paketleri kontrast oranları elle hesap (±0.05); nav çekmecelerinin klavye davranışı tam okunmadı; kapalı site backend `message` içeriği bakılmadı.
- "Muayene aç"ın bakımı da başlatıp başlatmadığı (today-page.ts akışı tam okunmadı); stok durumu satırının ürün düzenleme rotasına eşlenip eşlenmediği.
- `app-empty-state` hint'siz 26 kullanımın kaçının `ng-content` ile eylem taşıdığı sayılmadı.
- Portal: `isNeutered` nullable mı, parola belirleme için oturumlu uç var mı (backend sözleşmesi okunmadı); iOS standalone geri hareketi.
- Panel metin sayıları regex tabanlı, ±birkaç; dinamik etiketler (`[label]`, `statusLabel()`) taranmadı.
- Build/test çalıştırılmadı; canlıya bakılmadı.
