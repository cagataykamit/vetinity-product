# Tanıtım sitesi önerisi: konumlandırma, bilgi mimarisi, ana sayfa, SEO, dilimler

> Dayanak: [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) (bulgular, doğrulanmış iddia tablosu, rakip vaatleri). Bu belge **öneridir**; bölüm 9'daki açık kararlar kullanıcı onayı bekler, hiçbiri verilmiş sayılmaz. Rakip görünümü ve metni kopyalanmaz; her bölüm bir klinik problemini çözer. Site metni **yalnız doğrulanmış yetenekleri** anlatır (analiz belgesi bölüm 4); hukuki taslaklar taslak kalır (ADR-024).

## 1. Konumlandırma

### 1.1 Ana hedef kitle (öneri: Seçenek A)

**Tek hekimli ya da 2–5 kişilik Türkiye'deki küçük klinik; kâğıt/Excel'den veya eski masaüstü programdan geçen.** Gerekçe: pilot profili bu (ADR-014 K4); ürünün en güçlü ve kanıtlı parçaları (Bugün, muayene, defterler, KVKK formları, geçiş sihirbazı) tam bu kitlenin günlük derdine denk düşüyor; çok klinik ikinci satır olarak kalır ("büyüyünce şube ekleyin"). Hastane segmenti (PACS, cihaz, ileri yatış) sitede yer almaz.

### 1.2 Konumlandırma cümlesi (iç kullanım)

> Vetinity, küçük veteriner kliniğinin gününü — gelişten tahsilata — tek ekranda yürüten, kayıt defterlerini ve KVKK evrakını kendiliğinden tutan, satışçısız denenebilen Türkçe bulut klinik programıdır.

### 1.3 Mesaj hiyerarşisi

| Sıra | Mesaj | Kanıt (ürün) |
|---|---|---|
| 1 | **Gününüz tek ekranda akar:** kim geldi, kim bekliyor, kim acil, kimin ücreti yazılmadı | Bugün yüzeyi (ADR-009/011, CHECKIN-006…014, açık işler) |
| 2 | **Defterleriniz kendiliğinden tutulur:** aşı, ilaç, narkotik/psikotropik, muayene, reçete defterleri ve Aşı Bilgi raporu; yazdır, Excel'e al | ADR-015, `reports/registers` (biçim notu: "resmî biçime uygunluk doğrulanmadı" → sitede "mevzuata uygun" denmez) |
| 3 | **KVKK evrakı hazır:** aydınlatma ve açık rıza formu, rıza kaydı, veri kopyası, talep süreci | ADR-021/025/032 (ifade: "uyumlu" değil, "formlar ve kayıt hazır; metin danışmanınızca onaylanır") |
| 4 | **Kayıtlarınız güvende ve dürüst:** kesinleşen muayene kilitlenir, düzeltme izlidir, iki kişi birbirini ezmez, roller ve izinler | ADR-013, rowVersion, denetim izi |
| 5 | **Eski programdan geçiş yarım gün:** Excel yükle, eşle, kontrol et, geri al | ADR-019 (ölçüm: 8.000 hasta dakikalar içinde) |
| 6 | **Önce dene, sonra karar ver:** 14 gün, kart yok, satış görüşmesi yok | ADR-001, `TrialDays=14` |

Söylenmeyecekler (bugün): SMS/WhatsApp, e-Fatura, POS, online randevu, cihaz/PACS, yapay zekâ, mobil uygulama, hasta sahibi portalı ("yakında" dışında), Türkiye veri merkezi/yedek (sağlayıcı seçilince), müşteri sayısı/referans (pilot sonrası).

### 1.4 Ton

- Türkçe, kısa, somut; klinik çalışanının kelimeleri (hasta, sahip, geliş, bekleme, defter, tahsilat). ADR-022: "pet" değil "hasta"; "Dashboard" değil "Özet".
- Sıfat yerine fiil: "modern platform" değil "sabah açın, günün listesi hazır".
- Abartı yok, sayı uydurma yok. Yapmadığımızı açıkça yazarız ("Yol haritasında" bölümü); bu rakiplerin "her şey var" tonundan ayrışır ve pilot kliniğin beklentisini doğru kurar.
- Jargon ve İngilizce terim yok (SOAP, dashboard, multi-tenant, SaaS).

## 2. Bilgi mimarisi

| Sayfa | Adres (öneri) | Amaç | Ana mesaj | Dilim |
|---|---|---|---|---|
| Ana sayfa | `/` | 30 saniyede "benim için mi?" ve deneme/demo'ya götürmek | Mesaj 1–6 | D3 |
| Özellikler (iş akışı) | `/ozellikler` | Günün akışını adım adım anlatmak (geliş → muayene → tahsilat → gün sonu), modül listesi değil | Bir ziyaretin yolculuğu | D4 |
| Kayıt defterleri ve KVKK | `/kayit-defterleri-ve-kvkk` (ya da `/guvenlik`) | Türkiye'ye özgü yükümlülükleri nasıl hafiflettiğimizi göstermek; güvenlik (roller, izler, kilitleme) | Mesaj 2–4 | D4 |
| Eski programdan geçiş | `/gecis` | Geçiş korkusunu kaldırmak: adımlar, ne aktarılır/ne aktarılmaz, geri alma | Mesaj 5 | D4 |
| Paketler | `/paketler` (eski `/pricing` yönlendirilir) | Karar AK-2'ye göre fiyat ya da teklif | Mesaj 6 | D5 |
| SSS | `/sss` (ana sayfada kısa, tam liste ayrı) | Fiyat, güvenlik, geçiş, destek, sözleşme, iptal, fatura | | D3 |
| Demo / iletişim | `/iletisim` | Form (ad, klinik, telefon/e-posta, mesaj) + e-posta/telefon; demo talebi aynı form | AK-5 | D4 |
| Hakkımızda ve destek | `/hakkimizda` | Kim yapıyor, nasıl ulaşılır, destek kanalı ve saatleri, kullanıcı kılavuzu bağlantısı | Güven | D4 |
| Hasta sahibi portalı ve mobil | `/hasta-sahibi` | Portal yayınlanınca; şimdilik yol haritasında tek satır | ADR-031 | D7 |
| Yol haritası (kısa) | ana sayfa bölümü, ayrı sayfa değil | SMS, e-Fatura, portal gibi "yakında"ları dürüstçe listelemek | Şeffaflık | D3 |
| Hukuki | `/gizlilik`, `/kullanim-sartlari`, `/veri-isleme-sozlesmesi`, + `/cerez-politikasi` (analitik eklenirse) | Mevcut; taslak bandı kalır | ADR-024 | — |
| Blog | **Şimdi gerek yok.** Pilot sonrası "klinik rehberleri" (defter nasıl tutulur, KVKK'da klinik ne yapmalı) SEO için değerli; içerik üretme kapasitesi yoksa açılmaz | | Sonra |

Üst menü (masaüstü): Özellikler · Defterler ve KVKK · Geçiş · Paketler · SSS · İletişim | Giriş yap · Ücretsiz dene. **Mobil: hamburger menü zorunlu** (bugün yok).
Alt bilgi: aynı bağlantılar + Hakkımızda/Destek + hukuki metinler + iletişim bilgisi (tüzel kişi adı, e-posta; AK-6).

## 3. Ana sayfa omurgası (bölüm bölüm)

| # | Bölüm | İçerik | Not |
|---|---|---|---|
| 1 | **Kahraman** | Başlık (öneri): "Kliniğinizin günü tek ekranda." Alt metin: "Geliş, bekleme, muayene, tahsilat ve kayıt defterleri — aynı yerde. 14 gün ücretsiz, kart yok." CTA-1 "Ücretsiz dene", CTA-2 "Demo iste" (AK-5). Sağda **gerçek Bugün ekranı** (anonim veri), sahte önizleme kaldırılır | Tek h1'de "veteriner" geçsin: "Veteriner kliniğinizin günü tek ekranda." |
| 2 | **Kime göre** | Üç kısa kart: "Tek hekimli klinik", "Büyüyen klinik (birkaç kullanıcı)", "Birden fazla şube" — her birinde 1 cümle | Seçenek A/B önceliği |
| 3 | **Bir günün akışı** | 4 adım yatay: Geliş (randevulu/randevusuz, bekleme) → Muayene (bölümler, kesinleştirme) → Tahsilat (kısmi ödeme, bakiye) → Gün sonu (kasa özeti, ücretlenmemiş işlem). Her adımda küçük gerçek ekran | Özellikler sayfasına bağlantı |
| 4 | **Türkiye'ye özgü** | İki sütun: Kayıt defterleri (liste + "yazdır/Excel") · KVKK (aydınlatma, açık rıza, rıza kaydı, veri kopyası). Altında küçük not: "Defter biçimi ve KVKK metinleri kliniğinizin danışmanınca onaylanır." | Dürüst ifade zorunlu |
| 5 | **Kayıt güvenliği** | 4 madde: kesinleşen muayene kilitlenir · her düzeltme gerekçeli ve izli · aynı anda iki kişi birbirini ezmez · roller ve izinler | |
| 6 | **Eski programdan geçiş** | 3 adım: Excel'i yükle → sütunları eşle → kontrol et ve aktar (geri alınabilir). "Müşteri, hasta ve aşı geçmişi aktarılır; muayene ve ödeme geçmişi şimdilik aktarılmaz." | |
| 7 | **Yol haritasında** | Kısa liste: hasta sahibi portalı ve mobil uygulaması (geliştiriliyor), SMS hatırlatma, e-Fatura, online randevu. "Tarih vermiyoruz; çıkınca burada yazar." | Şeffaflık |
| 8 | **SSS (6–8)** | Fiyat ne zaman/ne kadar · verilerim nerede, kim görür · eski programdan geçiş · hatırlatma nasıl gider (e-posta) · destek nasıl · sözleşme ve iptal · deneme sonunda ne olur · birden fazla klinik | FAQPage JSON-LD |
| 9 | **Çağrı** | "14 gün ücretsiz deneyin" + "Demo iste" + "Sorunuz mu var? iletişim" | |
| 10 | Alt bilgi | Bölüm 2 | |

Kaldırılacaklar: "Modül vitrini" (modül listesi değer anlatmıyor), "Neden Vetinity?" teknik maddeleri ("tutarlı tarih-saat", "abonelik kontrolü"), sahte önizleme kartı, `pages/landing/*` ölü kod.

## 4. Güven ögeleri (bugün kullanılabilenler)

- Gerçek ekran görüntüleri (analiz bölümü 7 listesi), sahte veri yerine.
- "Ne yapmıyoruz" listesi (şeffaflık).
- Hukuki metinlerin varlığı (taslak bandıyla; "hukuki onay sürüyor" demek saklamaktan iyidir).
- Destek kanalı ve yanıt süresi (AK-6 ile netleşir), kullanıcı kılavuzu (`operations/KULLANICI-KILAVUZU-ROL-BAZLI.md` yayınlanabilir hâle getirilirse).
- Pilot sonrası: isimli klinik referansı, ölçülmüş bir sayı ("X klinik, Y hasta kaydı"), durum sayfası.
- Barındırma/yedek: sağlayıcı seçilince "veriler Türkiye'de, günlük yedek, aylık geri yükleme provası" (ADR-014 K1–K2) — şimdi yazılmaz.

## 5. Çağrı-eylem akışı (deneme / demo)

```
Ana sayfa ─ "Ücretsiz dene" ─► /auth/signup (plan seçimi gizli, varsayılan Temel; AK-2) ─► e-posta doğrulama ─► boş panel
                                                                                            └► İLK 5 DAKİKA SORUNU: örnek klinik ertelendi (ADR-002)
           ─ "Demo iste"  ─► /iletisim formu ─► e-posta ile kullanıcıya ─► 1 iş günü içinde dönüş (AK-5)
```

- **İlk 5 dakika riski:** deneme boş panelle başlıyor; örnek klinik pilot sonrasına ertelendi. Öneri: siteye koymadan önce en azından panelde "ilk adımlar" kontrol listesi (klinik bilgisi → ilk müşteri+hasta → ilk randevu) ya da 2 dakikalık tanıtım videosu/ekran turu (TRIAL-002 kapsamı dışı, küçük). Karar: AK-5.
- Demo talebi için backend ucu yok; ilk sürümde form yerine `mailto:` + telefon yeterli olabilir (D4'te seçim).
- Deneme bitince ne olacağı (TRIAL-007 karar bekliyor) SSS'de dürüstçe: "Deneme sonunda verileriniz silinmez; paket seçene kadar salt okunur kalır" **ancak bu kural üründe yoksa yazılmaz** → AK-2 ile birlikte karar.

## 6. SEO

### 6.1 Anahtar kelime kümeleri (Türkçe; hacim ölçülmedi, rakip sayfalarından ve ürün dilinden türetildi)
- Birincil: "veteriner klinik programı", "veteriner yazılımı", "veteriner klinik yönetim programı", "bulut veteriner programı".
- Türkiye'ye özgü uzun kuyruk: "aşı kayıt defteri programı", "narkotik ilaç kayıt defteri veteriner", "veteriner KVKK açık rıza formu", "veteriner hasta takip programı", "veteriner randevu programı", "veteriner stok takip".
- Geçiş: "veteriner programı veri aktarma", "excel'den veteriner programına geçiş".

### 6.2 Sayfa başlığı / açıklama önerileri
| Sayfa | `<title>` | `description` |
|---|---|---|
| `/` | Vetinity — Veteriner klinik programı: günün akışı, kayıt defterleri, KVKK | Veteriner kliniğinizin gününü tek ekranda yönetin: geliş, muayene, tahsilat, aşı ve ilaç kayıt defterleri, KVKK formları. 14 gün ücretsiz, kart gerekmez. |
| `/ozellikler` | Özellikler — Gelişten tahsilata bir günün akışı · Vetinity | Randevu ve randevusuz geliş, bekleme sırası, muayene, reçete, stok, tahsilat ve gün sonu: Vetinity'de bir ziyaretin yolculuğu. |
| `/kayit-defterleri-ve-kvkk` | Kayıt defterleri ve KVKK — Vetinity | Aşı, ilaç, narkotik/psikotropik, muayene ve reçete defterleri otomatik; KVKK aydınlatma ve açık rıza formları, rıza kaydı ve veri kopyası. |
| `/gecis` | Eski programdan geçiş — Vetinity | Excel veya CSV ile müşteri, hasta ve aşı geçmişinizi aktarın: sütun eşleme, kontrol, geri alma. |
| `/paketler` | Paketler ve fiyat — Vetinity | (AK-2'ye göre) |
| `/sss` | Sık sorulan sorular — Vetinity | Fiyat, veri güvenliği, geçiş, destek, sözleşme ve deneme hakkında yanıtlar. |
| `/iletisim` | İletişim ve demo talebi — Vetinity | |

### 6.3 Teknik
- `robots.txt` (staging: `Disallow: /`; canlı: `/panel`, `/auth`, `/join` kapalı), `sitemap.xml` (yalnız tanıtım sayfaları), canonical **sabit `https://www.vetinity.com`** (origin'den türetme kaldırılır), staging `noindex`.
- `og:image` (1200×630, gerçek Bugün ekranı), `twitter:card=summary_large_image`.
- JSON-LD: `Organization` (ad, logo, iletişim), `SoftwareApplication` (kategori, fiyat AK-2'ye göre), `FAQPage` (SSS).
- Tanıtım sayfalarının **sunucu tarafında HTML üretmesi** (prerender/SSG): bugün curl'de `<h1>` yok. ADR-033 ayrımı sırasında tanıtımın ayrı statik/prerender derlemesi önerilir; 782 KB JS tanıtım için gereksiz.
- Yazı tipi yerelden (Google Fonts'tan değil) — ayrı iş sürüyor (`wt-font`).
- Görseller WebP + `width/height` + `loading="lazy"` (kahraman hariç).

## 7. Çerez ve analitik (KVKK'ya uygun, dış kaynaksız)

Öneri sırası:
1. **İlk sürüm: analitik yok.** Yalnız sunucu günlüklerinden (nginx access log) sayfa görüntüleme sayımı; kişisel veri işlenmediği için bant gerekmez. Yeterli: hangi sayfa okunuyor, hangi kaynak geliyor (referer).
2. **Gerekirse kendi barındırdığımız, çerezsiz sayaç** (ör. Plausible/Umami tarzı, kendi sunucumuzda, IP kısaltma, çerez yok). Çerez yoksa çerez bantı yok; aydınlatma metnine "ziyaret istatistiği" satırı eklenir. Üçüncü tarafa veri gitmez; ADR-033'teki "tanıtım sitesi ayrı origin" gerekçesine uyar.
3. **Kullanılmayacak:** Google Analytics/Tag Manager, Meta Pixel, Hotjar gibi dış kaynaklar (yurt dışı aktarım + çerez onayı + taslak hukuki metinler). Reklam ölçümü gerekirse ayrı karar (AK-7).
4. Dönüşüm ölçümü (deneme kaydı sayısı) **backend'den** (tenant oluşturma sayısı, TRIAL-008) alınır; sitede izleyici gerekmez.

## 8. Uygulama dilimleri (kapsam)

| # | Dilim | Kapsam | Kim / ne zaman |
|---|---|---|---|
| D0 | Adres ve yayın | `www.vetinity.com` → tanıtım; güncel derleme; staging `noindex` | Kullanıcı (ADR-033/VPS); ajan dokunmaz |
| D1 | Hızlı düzeltmeler (kod, küçük) | ADR-022 dili ("pet"→"hasta", "Dashboard"→"Özet", rol adları); boş iddiaları silme; `<title>`/`description` "veteriner"; tema düğmesi `aria-label`; mobil hamburger menü; paket sınırları backend ile aynı (AK-2 öncesi en azından çelişki giderme); `pages/landing/*` ve `public/demo` silme; tema/anlamsız "Modül vitrini" kaldırma | WEB-001, WEB-002 |
| D2 | Teknik SEO | `robots.txt`, `sitemap.xml`, sabit canonical, `og:image`, JSON-LD, prerender değerlendirmesi | WEB-003 |
| D3 | Ana sayfa yeniden yazımı | Bölüm 3 omurgası; gerçek ekran görüntüleri (analiz bölümü 7); SSS 6–8 soru | WEB-004, WEB-005 (görsel) |
| D4 | Yeni sayfalar | Özellikler, Defterler ve KVKK, Geçiş, İletişim/Demo, Hakkımızda/Destek | WEB-006 |
| D5 | Paketler | AK-2 kararına göre fiyat ya da "teklif al"; backend plan kataloğu ile tek kaynak | WEB-007 |
| D6 | Ayrı derleme + analitik | ADR-033 ile birlikte tanıtımın ayrı/prerender derlemesi; çerezsiz sayaç (AK-7) | WEB-008 |
| D7 | Sonrası | Portal sayfası (yayınlanınca), referans/vaka, blog (karar) | — |

D1 ve D2 "doğrudan kodlanabilecek küçük işler" sınıfındadır (WORKFLOW); D3–D6 bu belgeye ve açık kararlara bağlıdır.

## 9. Açık kararlar (kullanıcı)

| # | Karar | Seçenekler | Öneri |
|---|---|---|---|
| AK-1 | Ana hedef kitle | A küçük klinik · B çok klinikli işletme · C hastane | **A** ana, B ikincil satır, C yok |
| AK-2 | Fiyat gösterimi | (a) "Fiyat yakında" kalsın · (b) fiyat yazılsın (paket başına aylık TL, KDV notu) · (c) fiyat yok, "teklif al / iletişime geçin" · (d) tek paket + "büyüyünce konuşalım" | **(b)** pilot fiyatı belli olunca; o güne kadar **(c)** ("Pilot dönemi fiyatı için yazın"). "Fiyat yakında" kaldırılsın. Ayrıca kullanıcı/klinik sınırlarının tek doğrusu (site 1/5/∞ mi, backend 3/10/50 mi) |
| AK-3 | Ana mesaj | (a) "Günün akışı tek ekranda" · (b) "Defterler ve KVKK kendiliğinden" · (c) "Kayıtlarınız güvende" · (d) mevcut "modern yönetim platformu" | **(a)** kahraman, (b) ikinci bölüm; (d) bırakılır |
| AK-4 | Ton | (a) sade/klinik dili, "siz" · (b) kurumsal/teknik · (c) samimi/"sen" | **(a)** |
| AK-5 | Deneme/demo modeli | (a) yalnız deneme (ADR-001) · (b) deneme + demo talebi formu · (c) yalnız demo (pilot dönemi, boş panel riski) | **(b)**; pilot bitene kadar demo düğmesi öne, deneme boş panel riskiyle ikinci — ya da örnek klinik yerine "ilk adımlar" kontrol listesi (küçük iş) |
| AK-6 | İletişim ve tüzel kişi | Sitede e-posta/telefon/adres; kullanım şartlarındaki boş tüzel kişi; destek saatleri | Karar kullanıcıda; yoksa en az bir e-posta |
| AK-7 | Analitik | (a) yok · (b) çerezsiz kendi sayaç · (c) dış kaynak | **(a)** şimdi, **(b)** yayın sonrası |
| AK-8 | Adres düzeni etkisi | ADR-033 uygulanana kadar: (a) tanıtım aynı derlemede kalır, yalnız içerik değişir · (b) tanıtım hemen ayrı projeye alınır | **(a)** D1–D5 içerik işleri; (b) D6'da ADR-033 ile birlikte |
| AK-9 | Portal/mobil tanıtımı | (a) hiç yazma · (b) "yakında" tek satır · (c) ayrı sayfa şimdiden | **(b)** |

## 10. İlgili belgeler
- [Analiz ve kanıtlar](../research/tanitim-sitesi-analizi-2026-10.md)
- [ADR-001 self-service trial](../decisions/ADR-001-self-service-trial-strategy.md) · [ADR-022 hasta dili](../decisions/ADR-022-terminology-hasta.md) · [ADR-024 hukuki taslaklar](../decisions/ADR-024-hukuki-metin-taslaklari.md) · [ADR-031 portal](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) · [ADR-033 adres düzeni](../decisions/ADR-033-alan-adi-ve-adres-duzeni.md)
- Backlog: WEB-001…008 ([feature-backlog.md](../backlog/feature-backlog.md))
