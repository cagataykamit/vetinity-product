# Tanıtım sitesi görsel tasarım önerisi (çok sayfalı)

> Bu belge [tanitim-sitesi-onerisi.md](tanitim-sitesi-onerisi.md) (içerik, bilgi mimarisi, açık kararlar AK-1…9) üzerine **görsel ve yerleşim** katmanıdır. Mevcut site tek sayfa + fiyat; hedef, aynı marka paletiyle çok sayfalı, gerçek ekran görüntülü, telefonda tam çalışan bir site. Rakip görünümü kopyalanmaz; Sakai/"Genesis" şablon kalıntıları (sahte önizleme kartı, modül vitrini, "stats strip") kaldırılır. Açık kararlar verilene kadar metinler yer tutucudur; yerleşim kararlardan bağımsızdır.

## 1. Mevcut tasarımın sorunları (staging, 2026-10-16)

| Sorun | Kanıt |
|---|---|
| Her bölüm aynı kalıp: ortada simge rozeti + başlık + alt metin + eşit kartlar; ritim yok, göz kaymıyor | Özellikler, Modül vitrini, SSS aynı başlık düzeni |
| Kahraman alanın yarısı sahte "Panel önizleme" kartı; mesaj taşımıyor, ürün göstermiyor | `aria-hidden` mock kart |
| Kartlar boş: simge + 2 kelime ("Dashboard", "Aşı"); değer yok | Modül vitrini 9 kutu |
| Yoğun gölge/yuvarlatma (rounded-3xl, shadow-2xl) şablon hissi veriyor; marka kimliği yalnız teal renk | `public-page-theme.scss` |
| Mobilde menü yok; tek sütun kartlar uzun kaydırma | 375 px ölçümü |
| Görsel hiyerarşi tek seviye: her şey "kart" | ekran görüntüleri |

## 2. Tasarım ilkeleri

1. **Ürün kendini göstersin:** her ana bölümde gerçek ekran (anonim veri), illüstrasyon değil. Ekranlar hafif perspektifsiz, düz, ince çerçeveli; tarayıcı çubuğu çizilmez (şablon hissi).
2. **Bir bölüm = bir problem = bir ekran.** Kart ızgarası yalnız kısa listelerde (3'lü), ana bölümler metin + ekran iki sütun, sırayla sağ/sol değişir.
3. **Az kart, çok beyaz alan, net tipografi.** Gölge yalnız ekran görüntülerinde; kartlarda 1 px çerçeve.
4. **Marka: lacivert + teal + sıcak nötr.** Mevcut `--vetinity-navy #0b1d3a`, `--vetinity-teal #0fa39a` korunur; üçüncü bir vurgu (amber, klinik uyarı rengi değil) yalnız "yol haritası/yakında" etiketlerinde. Gradient yalnız kahraman arka planında, kartlarda yok.
5. **Türkçe, kısa, somut.** Başlıklar en çok 8 kelime; alt metin 1–2 cümle; teknik sıfat yok.
6. **Telefon önce.** Her bölüm 375 px'te tek sütun ve okunur; menü hamburger; dokunma hedefi ≥44 px.
7. **Erişilebilir:** kontrast ≥4.5:1 (teal üstünde beyaz metin kullanılmaz, lacivert üstünde beyaz), odak halkası görünür, animasyon `prefers-reduced-motion`'a saygılı.

## 3. Tasarım dizgesi (token)

| Öğe | Değer | Not |
|---|---|---|
| Yazı tipi | Inter (yerelden; `wt-font` işi) — başlık 600/700, gövde 400/500 | Alternatif gerekmiyor |
| Ölçek (masaüstü / mobil) | h1 48/34 px · h2 36/28 · h3 22/20 · gövde 17/16 · küçük 14 | satır yüksekliği 1.15 / 1.55 |
| Konteyner | 1200 px, iç boşluk 24 px; mobil 16 px yan boşluk | bugün `max-w-6xl`=1152, kalabilir |
| Dikey ritim | bölüm arası 96 px masaüstü / 64 px mobil | tek değer, her yerde |
| Köşe | 12 px kart, 8 px düğme, 16 px ekran görüntüsü çerçevesi | `rounded-3xl` kaldırılır |
| Çerçeve | 1 px `--public-border` | gölge yok |
| Gölge | yalnız ekran görüntüsü: `0 24px 48px -24px navy/35%` | |
| Düğme | birincil: lacivert zemin + beyaz; ikincil: beyaz zemin + lacivert çerçeve; kahramanda birincil teal çerçeveli beyaz **değil**, lacivert | teal zemin üstünde beyaz metin kontrast yetersiz (≈3:1) |
| Vurgu | teal: bağlantı, simge, küçük etiket, çizgi; "yakında" etiketi amber `#b45309` zemin `#fef3c7` | |
| Koyu tema | korunur; zemin `#0b1220`, kart `#111a2e`, metin `#e5e7eb`, teal aynı | ekran görüntüleri koyu temada ayrı set (WEB-005) |

## 4. Ortak iskelet

**Üst çubuk** (yapışkan, 64 px, beyaz/yarı saydam + 1 px alt çizgi): sol logo; orta bağlantılar: Özellikler · Defterler ve KVKK · Geçiş · Paketler · SSS · İletişim; sağ: "Giriş yap" (metin), "Ücretsiz dene" (birincil), tema düğmesi (`aria-label` dolu). Mobil (<1024): logo + hamburger; açılınca tam ekran liste, altta iki düğme; Escape/kapatma; odak içeride kalır.

**Alt bilgi** (lacivert zemin): 4 sütun — Logo + 1 cümle; Ürün (Özellikler, Defterler ve KVKK, Geçiş, Paketler); Destek (SSS, İletişim, Kullanıcı kılavuzu, Hakkımızda); Hukuki (Gizlilik, Kullanım şartları, Veri işleme sözleşmesi, Çerez (varsa)). Altta: © yıl, tüzel kişi adı (AK-6), e-posta. Mobilde sütunlar alt alta, akordeon yok.

**Sayfa başlığı kalıbı** (ana sayfa dışı): küçük teal üst etiket ("Özellikler"), h1, 1–2 cümle; arka plan açık teal yüzey (`--vetinity-bg-soft`) tam genişlik, 160 px; gradient yok.

## 5. Sayfa sayfa yerleşim

### 5.1 Ana sayfa (`/`)

| # | Bölüm | Yerleşim | Görsel |
|---|---|---|---|
| 1 | Kahraman | Lacivert→teal gradient tam genişlik (mevcut gradient korunur ama kart içinde değil, kenardan kenara); sol %45 metin: etiket "Veteriner klinikleri için", h1, alt metin, iki düğme, altında küçük satır "14 gün ücretsiz · kart gerekmez · satış görüşmesi yok"; sağ %55 **gerçek Bugün ekranı**, hafif aşağı taşarak bir sonraki bölüme biner | Bugün (açık tema) |
| 2 | Kime göre | Beyaz zemin, 3 sütun kart (1 px çerçeve): Tek hekimli klinik / Birkaç kullanıcılı klinik / Birden fazla şube; her kartta simge + başlık + 1 cümle | simge |
| 3 | Bir günün akışı | Başlık ortada; altında 4 adımlı yatay şerit (numara, başlık, 1 cümle) ve seçili adımın büyük ekranı altta; adıma tıklayınca ekran değişir (JS yoksa dört ekran alt alta) | Bugün → Muayene → Ödeme al → Gün sonu |
| 4 | Türkiye'ye özgü | Açık teal yüzey tam genişlik; iki sütun: sol "Kayıt defterleri" (liste 5 defter + "yazdır, Excel'e al") + Aşı Kayıt Defteri ekranı; sağ "KVKK evrakı" (liste) + rıza formu yazdırma görünümü; altta küçük gri not (danışman onayı) | 2 ekran |
| 5 | Kayıt güvenliği | Beyaz; sol büyük ekran (kesinleştirme kontrol listesi), sağ 4 madde (teal onay simgesi) | 1 ekran |
| 6 | Geçiş | Beyaz; 3 numaralı adım yatay (Yükle → Eşle → Kontrol et ve aktar), altında sihirbaz eşleme ekranı; yanında "aktarılır / şimdilik aktarılmaz" iki küçük liste | 1 ekran |
| 7 | Yol haritasında | İnce lacivert şerit değil; açık gri yüzey, tek satır başlık + 4 amber "yakında" etiketli çip (Portal ve mobil, SMS, e-Fatura, Online randevu) + 1 cümle dürüst not | — |
| 8 | SSS | Tek sütun 720 px, akordeon (mevcut bileşen kalır, çerçeve 1 px, gölge yok), 6–8 soru | — |
| 9 | Çağrı | Lacivert kart, ortada h2 + 2 düğme + "sorunuz mu var?" bağlantısı | — |

Kaldırılır: sahte önizleme kartı, 4'lü "stats strip", "Neden Vetinity?" teknik maddeler, Modül vitrini, SSS'deki SVG rozet.

### 5.2 Özellikler (`/ozellikler`)
Sayfa başlığı kalıbı. Ardından 6 bölüm, her biri iki sütun (sağ/sol dönüşümlü), metin + gerçek ekran: Geliş ve bekleme (Bugün) · Muayene (çalışma alanı, şablon, sözlük, kesinleştirme) · Hasta kartı ve zaman çizelgesi · Tahsilat ve bakiye (ödeme al, kısmi ödeme, borç raporu) · Stok ve satış (parti/SKT, mal kabul, doğrudan satış) · Raporlar (rapor merkezi, gün sonu). Sol kenarda yapışkan bölüm dizini (masaüstü), mobilde yok. Sonda çağrı kartı.

### 5.3 Defterler ve KVKK (`/kayit-defterleri-ve-kvkk`)
Sayfa başlığı. Bölüm A "Kayıt defterleri": 5 defter + Aşı Bilgi raporu tablo biçiminde (defter · ne zaman dolar · çıktı) + defter ekranı + yazdırma önizlemesi küçük; gri not (resmî biçim doğrulaması). Bölüm B "KVKK": 4 adım (aydınlatma → açık rıza formu → rıza kaydı ve sürüm → veri kopyası/talep süreci) ikon şeridi + form ekranı; gri not. Bölüm C "Erişim ve iz": roller, izinler, denetim izi, kilitleme — 4 küçük kart. Çağrı.

### 5.4 Geçiş (`/gecis`)
Sayfa başlığı. Zaman çizgisi dikey (mobilde de aynı): 1 Şablonu indir / kendi Excel'ini yükle · 2 Sütunları eşle · 3 Kontrol raporu · 4 Aktar (arka planda) · 5 Gerekirse geri al. Her adımda küçük ekran. Yanında iki kutu: "Aktarılır: müşteri, hasta, aşı geçmişi" / "Şimdilik aktarılmaz: muayene, ödeme geçmişi". SSS 3 soru. Çağrı "Dosyanızı birlikte bakalım" (iletişim).

### 5.5 Paketler (`/paketler`)
Sayfa başlığı. AK-2'ye göre: (c) ise tek geniş kart "Pilot dönemi" + "Teklif al" düğmesi + "Tüm özellikler dahil, kullanıcı sınırı X"; (b) ise 3 kart yan yana, orta kart 1 px teal çerçeve ve "Önerilen" etiketi (gölge yok), fiyat büyük, "/ay", KDV notu, altta özellik listesi **farklar** olarak (ortak özellikler ayrı tabloda). Altta karşılaştırma tablosu (masaüstü) / akordeon (mobil). SSS 3 soru (deneme sonu, iptal, fatura).

### 5.6 SSS (`/sss`)
Tek sütun, sol dikey kategori sekmeleri (Genel · Fiyat ve deneme · Güvenlik ve KVKK · Geçiş · Destek), mobilde yatay kaydırmalı çipler.

### 5.7 İletişim ve demo (`/iletisim`)
İki sütun: sol kısa form (ad, klinik, telefon veya e-posta, mesaj, "demo istiyorum" onay kutusu; backend yoksa `mailto:` ile açılır), sağ iletişim kartı (e-posta, telefon, çalışma saatleri, yanıt süresi) — AK-6. Harita yok.

### 5.8 Hakkımızda ve destek (`/hakkimizda`)
Kısa metin (kim, neden), destek kanalı, kullanıcı kılavuzu bağlantısı, hukuki metinler bağlantısı. Fotoğraf yoksa yok; stok görsel kullanılmaz.

### 5.9 Hukuki sayfalar
Mevcut yapı; taslak bandı korunur; içerik genişliği 720 px, başlık dizini sağda (masaüstü).

## 6. Hareket ve etkileşim
- Kaydırmada bölüm giriş animasyonu yok (hız, sade). Yalnız "Bir günün akışı" adım geçişinde 150 ms çapraz solma.
- Ekran görüntüleri tıklanınca büyütme yok (basitlik); `alt` metni açıklayıcı.
- SSS akordeon tek açık değil, çok açık olabilir (mevcut davranış).

## 7. Görsel üretim kuralları (WEB-005)
Panelde "Örnek Veteriner Kliniği" sentetik veri, 1536 CSS px genişlik, %100 ölçek, açık ve koyu tema; 2× PNG → WebP; çerçeve CSS ile (görselde tarayıcı çubuğu yok); kişi adları ve telefonlar açıkça sentetik; her görselin `alt`'ı ne gösterdiğini söyler ("Bugün ekranı: bekleyen üç hasta, biri acil").

## 8. Dünyadan referans siteler (ilham, kopya değil)

Kullanıcı isteği (2026-10-16): "dünyadaki en iyi görsel SaaS'ları örnek alalım". Aşağıdakiler **yerleşim ve ilke** düzeyinde örnek alınır; renk, metin, bileşen ve görsel birebir alınmaz (hafıza: rakip görünümü kopyalanmaz). Gözlemler 2026-10-16'da sayfaların kendisinden; görsel hissi (renk/tipografi) metinden okunamadığı için bilinen tasarım dilinden yazıldı.

| Site | Neden iyi | Vetinity'ye uyarlanacak ilke |
|---|---|---|
| **Linear** (linear.app) | Kahramanın hemen altında gerçek ürün ekranı; her bölümde "Fig" etiketli küçük görseller; "+" işaretli özellik listeleri; kısa cümle, çok beyaz alan; CTA üstte ve altta | Bölüm 5.1 #1 ve #3: gerçek Bugün ekranı, bölüm başına tek ekran, özellik listesi kısa satırlar |
| **Attio** (attio.com) | Sekmeli platform anlatımı (5 sekme, her sekmede ürün ekranı); üç CTA sayfa boyunca tekrar eder (ücretsiz başla / satışla görüş / demo) | "Bir günün akışı" sekmeli ekran şeridi; CTA ikilisi (dene / demo) her sayfanın sonunda |
| **Stripe** (stripe.com) | Tipografi hiyerarşisi, ince gradient yalnız kahramanda, geri kalan beyaz; kod/ürün örnekleri gerçek | Gradient yalnız kahraman; kartlarda gölge yok (bölüm 3) |
| **Cal.com** (cal.com) | Sade, tek vurgu rengi, açık/koyu tema tutarlı; fiyat şeffaf | Tema tutarlılığı; AK-2 (b) seçilirse açık fiyat kartları |
| **Digitail** (digitail.com, veteriner) | "Oda" sekmeleri (resepsiyon, muayene odası, lab, evde); iş tipine göre yönlendirme (bağımsız klinik / yeni klinik / çok lokasyon); geçiş ve güvenlik bölümleri ayrı; Pet Parent App | "Kime göre" 3 kart (5.1 #2), Geçiş sayfası, Defterler ve KVKK sayfası. **Alınmayacak:** "#1 top-rated", "10.000 veteriner", ROI hesaplayıcı gibi kanıtsız iddialar |
| **Provet Cloud** (provet.com, veteriner) | Kahramanda ürün görseli + "Demo al" / "Fiyatları gör"; her özellik bölümünde ekran; "dağınık araçlar yerine tek sistem" karşılaştırma tablosu; kullanım senaryoları (genel pratik, mobil, grup, hastane); SSS'de geçiş, fiyat, veri sahipliği; veteriner başına aylık fiyat açık, yıllık sözleşme yok | Fiyat sayfasına "yıllık sözleşme yok" ve veri sahipliği SSS'si; "tek sistem" tablosu (kâğıt/Excel/eski program vs Vetinity) Geçiş sayfasına. **Alınmayacak:** rakam şeridi, logo şeridi, ISO/uptime iddiaları (bizde yok) |

Galeriler (tarama için): Saaspo, Land-book, SaaSUI (ürün arayüzüyle birlikte gösterir), Lapa Ninja. Kaynak listeleri: swipepages.com 2026 SaaS örnekleri, saasframe.io kategori listeleri, saasui.design galeri rehberi.

**Ortak kalıp (hepsinde):** tek kahraman cümlesi + gerçek ürün ekranı · bölüm = problem + ekran · az renk, çok beyaz alan · sosyal kanıt (bizde pilot sonrası) · CTA tekrarı · ayrı fiyat sayfası. Bizim farkımız: Türkçe, Türkiye'ye özgü bölümler (defter, KVKK), "ne yapmıyoruz" dürüstlüğü.

## 9. Uygulama notları (kod repo, ayrı iş)
- `pages/public/` altında ortak `PublicLayoutComponent` (üst çubuk + `<router-outlet>` + alt bilgi); her sayfa ayrı lazy bileşen; `features/public/utils/*-content.utils.ts` içerik sabitleri (mevcut desen korunur).
- Yeni route'lar: `ozellikler`, `kayit-defterleri-ve-kvkk`, `gecis`, `paketler` (`pricing` → yönlendirme), `sss`, `iletisim`, `hakkimizda`.
- `public-page-theme.scss`: gölge/rounded token'ları sadeleşir; yeni `--public-radius-*`, `--public-shadow-shot` eklenir; gradient yalnız kahraman.
- Ekran görüntüleri `public/marketing/` altında, WebP + `width/height`.
- Meta/OG/JSON-LD `public-seo.utils.ts` içinde sayfa başına (WEB-003).
- `pages/landing/*` ve `public/demo` silinir (WEB-001).
- Önce D1–D2 (WEB-001/002/003), sonra bu iskelet; içerik metinleri AK kararlarına kadar yer tutucu.
