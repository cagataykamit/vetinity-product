# Tanıtım sitesi analizi (www.vetinity.com) — 2026-10-16

> Amaç: tanıtım sitesinin bugünkü hâlini kanıtla değerlendirmek, ürünün **gerçekten** yaptıklarını belgelerden ve koddan çıkarıp tanıtımda söylenebilecek iddiaları ayırmak, rakip vaatlerine karşı boşluğu görmek. Öneri ve bilgi mimarisi ayrı belgede: [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md). Bu belge karar vermez; karar gerektiren yerler "Açık karar" olarak işaretlidir. Bu belge yazılırken kod yazılmadı, yayına/alan adına dokunulmadı.

## 1. Yöntem ve sınırlar

- **Kod:** `C:\FrontEnd\veteriner-frontend` `main` (`341e535`, 2026-10-16): `src/app/pages/public/*`, `src/app/features/public/utils/*`, `src/app/pages/landing/*`, `src/app.routes.ts`, `src/index.html`, `vercel.json`.
- **Canlı:** `https://www.vetinity.com` ve `https://vetinity.com` **tanıtım sitesine gitmiyor**: ikisi de alan adı park sayfasına (`vetinity-com.l.ink`, "A Brand New Domain!") yönleniyor (curl, 2026-10-16 13:49 UTC). Tanıtım sitesi yalnız `https://staging.vetinity.com` adresinde görüldü; `Last-Modified: 02 Jul 2026` (nginx), yani **staging'deki derleme üç buçuk aylık**, bugünkü `main` değil. Ölçümler staging üzerinde yapıldı (masaüstü 1024 px ve 375 px emülasyon, yalnız gezme; form gönderilmedi, giriş/kayıt yapılmadı).
- **Ölçüm yaklaşık:** Lighthouse çalıştırılmadı; `performance` API ve DOM sorgularıyla bakıldı. Erişilebilirlik için otomatik tarayıcı (axe) kullanılmadı; elle gözlem.
- **Rakip:** `competitors/` ve `roadmap/RAKIP-ANALIZI-2026-10.md` + rakiplerin **herkese açık tanıtım sayfaları** (E-vet Smart `evetsmart.com`, DaySmart `daysmart.com/vet`, VETport); iddialar rakibin kendi beyanıdır, doğrulanmadı. Görünüm ve metin kopyalanmaz.
- Portal/mobil, defterler vb. "var/yok" durumu `main` koduna ve `roadmap/AJAN-KUYRUGU.md` / `DEVIR-2026-10-15.md` notlarına dayanır; **hiçbiri üretimde değil** (son push 2026-10-12, staging 2 Temmuz derlemesi).

## 2. Mevcut sitenin envanteri

| Adres | İçerik | Kaynak | Not |
|---|---|---|---|
| `/` | Kahraman bölüm (başlık, 2 CTA, sahte "Panel önizleme" kartı), 4 yetenek kartı, 6 özellik, "Neden Vetinity?" (6 madde), 9 modül simgesi, çağrı kartı, 6 SSS | `public-home-page.component.ts`, `public-home-content.utils.ts` | Gerçek ekran görüntüsü yok; sahte önizleme `aria-hidden` |
| `/pricing` | Temel / Pro / Premium; hepsinde "Fiyat yakında", "14 gün · ödeme alınmaz"; kullanıcı ve klinik sınırı; "Paketi seç" → `/auth/signup?plan=` | `pricing-page.component.ts`, `pricing-plan.utils.ts` | Sitedeki sınırlar (1/5/sınırsız kullanıcı) backend `SubscriptionPlanCatalog` ile **çelişiyor** (3/10/50); klinik sınırı backend'de yok |
| `/gizlilik`, `/kullanim-sartlari`, `/veri-isleme-sozlesmesi` | Hukuki taslaklar, sarı "taslak" bandı | `legal-document-page.component.ts`, `legal-documents.utils.ts` | ADR-024/029; sürüm 0.x = taslak |
| `/join/:token` | Kurum daveti kabulü | `join-invite-page.component.ts` | Panel akışı, tanıtım değil |
| `/auth/login`, `/auth/signup` | Giriş, deneme kaydı (`noindex`) | `features/auth` | 14 gün deneme backend'de gerçek (`SubscriptionTrialDefaults.TrialDays = 14`) |
| `src/app/pages/landing/*` | Eski Sakai şablon açılış sayfası (hero/features/pricing/footer widget'ları) | 7 dosya, 501 satır | **Route'a bağlı değil**, ölü kod; `topbarwidget` `/landing` adresine yönlendiriyor, o adres `notfound`'a düşer |
| `public/demo/images` | Sakai şablon örnek görselleri (flag/galleria/product) | | Üretim derlemesine giriyor mu bakılmadı; tanıtımla ilgisiz |

Üst çubuk: Özellikler · Modüller · SSS · Paketler · Giriş yap · Ücretsiz başla · tema düğmesi. Alt bilgi: aynı bağlantılar + üç hukuki metin + "Veteriner klinik yönetimi için tasarlandı." **Yok:** iletişim, demo talebi, hakkımızda, destek/yardım, referans, blog, KVKK aydınlatma (ziyaretçi için), çerez bildirimi, sosyal bağlantı, telefon/e-posta/adres (kullanım şartlarında bile tüzel kişi adı boş).

## 3. Bulgular (kanıtlı)

### 3.1 Erişim ve dağıtım (en acil)
- **B1 — www.vetinity.com park sayfası.** Tanıtım sitesi kamuya açık adreste yok. Her şeyden önce gelir; SEO, reklam, kartvizit boşa gider. (Alan adı/DNS işi kullanıcıda; ADR-033.)
- **B2 — Staging eski.** `Last-Modified 2 Temmuz`; sitede son 3 ayın ürün ilerlemesi yok (defterler, KVKK, içe aktarma, Bugün, gün sonu…). Tanıtım içeriği sadece metin olsa da yeni derleme gerekli.
- **B3 — Tek Angular uygulaması.** Tanıtım + panel + portal aynı derlemede: `index.html` 27 KB, ana sayfada ~782 KB JS indirildi (31 kaynak), DOMContentLoaded ~0,54 s (yerel ağ, önbelleksiz değil). Vercel yönlendirme dosyası var ama staging nginx. Tanıtım sayfası için SSR/prerender yok: `curl` ile gelen HTML'de **`<h1>` yok**, içerik tamamen istemci tarafında; arama motoru JS çalıştırmazsa boş sayfa görür. ADR-033 zaten ayrı origin öngörüyor; tanıtımın ayrı (statik/prerender) derlemesi bunu çözer.
- **B4 — robots.txt / sitemap.xml yok**: her ikisi `index.html` (text/html) döndürüyor. Canonical `document.location.origin` ile üretiliyor → staging'de `https://staging.vetinity.com/`; staging arama motoruna "asıl" diye kendini sunuyor (noindex yok).

### 3.2 SEO ve paylaşım
- Başlık ve açıklama var (`setPublicPageMeta`): "Vetinity — Klinik yönetim platformu". **"veteriner" kelimesi başlıkta yok**; hedef arama "veteriner klinik programı/yazılımı" (rakipler bu kelimeleri kullanıyor). `og:image`, `twitter:card`, `lang`'a uygun `hreflang`, yapılandırılmış veri (Organization/SoftwareApplication/FAQPage) yok.
- Tek `<h1>` doğru; `<h2>` sırası mantıklı. SSS zaten var → FAQPage JSON-LD kolay kazanım.
- Giriş/kayıt `noindex` (doğru). Hukuki sayfalar indekslenebilir (sorun değil).
- Yazı tipi Google Fonts'tan (`fonts.googleapis.com`, preconnect var): dış kaynak + KVKK açısından IP aktarımı; ayrı iş yürüyor (`wt-font`).

### 3.3 Mobil (375 px)
- Yatay taşma yok (`scrollWidth 375`); yalnız dekoratif daire taşıyor, `overflow-hidden` içinde.
- **Üst menü mobilde yok**: `md:` altı gizli, hamburger yok. 375 px'te Paketler, SSS, Giriş yap ve Ücretsiz başla **üst çubuktan ulaşılamaz**; yalnız kahraman bölümdeki iki düğme ve alt bilgi kalıyor. (Kod: `public-topbar.component.ts` satır 33 `hidden … md:flex`, satır 47 aynı.)
- Dokunma hedefi: 15 bağlantı/düğmeden 7'si 44 px altında (üst çubuk bağlantıları, alt bilgi bağlantıları).
- Kahraman başlığı 35 px, 3 satır; sahte önizleme kartı ilk ekranın yarısını kaplıyor, mesajı yok.

### 3.4 Erişilebilirlik
- `lang="tr"` doğru; bölümler `aria-labelledby`; SSS düğmeleri `aria-expanded`/`aria-controls` doğru.
- **Tema düğmelerinin erişilebilir adı boş** (iki düğme `aria-label=""`; `[ariaLabel]` PrimeNG'de beklenen şekilde basılmıyor). Devir notunda "tema düğmesine aria-label" küçük iş olarak zaten var.
- "İçeriğe atla" bağlantısı yok. Simgeler `aria-hidden` (doğru). Kontrast elle ölçülmedi; açık temada `text-muted-color` küçük metinler sınırda olabilir (doğrulanmadı).

### 3.5 Dil ve metin
- **Terminoloji ADR-022'ye aykırı:** "Hasta ve pet kayıtları" (özellik kartı ve Temel paket), "Dashboard" (modül vitrini), "Admin … sekreter" (SSS; üründe rol adları Yönetici/Hekim/Resepsiyon). Panelde "hasta" dili tamamlandı, site geride kaldı.
- **Jenerik ve ürün-merkezli:** "modern yönetim platformu", "modül", "operasyon", "güvenli panel deneyimi", "tutarlı tarih-saat gösterimi", "abonelik kontrolü" — bunlar klinik çalışanının problemi değil, yazılımın iç özellikleri. Bir veteriner "tutarlı tarih-saat gösterimi" aramaz.
- **Boş iddialar:** "Gelişmiş operasyon raporları", "Öncelikli kullanım kapasitesi", "Genişletilebilir modül vitrini", "Kurumsal ölçekte operasyon" (Premium) — tanımı yok.
- **Sahte veri:** "Max (Köpek)", "Luna (Kedi)" önizleme kartı; abartılı sayı yok (iyi), ama gerçek ekran görüntüsü de yok.
- SSS yüzeysel: fiyat, veri güvenliği/KVKK/yedek, eski programdan geçiş, destek, sözleşme/iptal, fatura yok.

### 3.6 Fiyat sayfası
- Üç kartta aynı "Fiyat yakında"; karar verilmemiş görünüyor ve güveni düşürüyor. Backend'de fiyat yok (`SubscriptionPlanCatalog` yalnız ad + maxUsers); iyzico/Stripe checkout altyapısı var ama anahtarlar yenilenecek (ADR-014).
- Site–backend çelişkisi: kullanıcı sınırları 1/5/∞ (site) vs 3/10/50 (backend); klinik sınırı sitede var, backend'de yok. Hangisi doğruysa diğeri düzeltilmeli (**açık karar**, bkz. öneri belgesi).

## 4. Ürünün doğrulanmış yetenekleri → tanıtımda söylenebilir / söylenemez

Durum sütunu: **Var (main)** = yerel `main`'de kod + test; **Dal** = birleşmemiş; **Geliştiriliyor**; **Yok**. "Üretim" sütunu: bugün staging'de bile yok (2 Temmuz derlemesi) — yayınlanmadan sitede "var" denmemeli ya da "yakında" denmeli.

| İddia | Durum | Kanıt | Tanıtımda |
|---|---|---|---|
| Randevu, takvim, yeniden planlama, gelmedi işareti | Var (main) | `features/appointments`, ADR-010 | Söylenebilir |
| Bugün ekranı: randevulu/randevusuz geliş, bekleme sırası, uzun bekleme uyarısı, acil, hasta uyarı rozetleri, açık işler | Var (main) | ADR-009/011, CHECKIN-006…014, D2 | Söylenebilir — **ana farklılaştırıcı adayı** |
| Muayene çalışma alanı (SOAP benzeri bölümler, vital, şablon, tanı/şikâyet sözlüğü, kesinleştirme + ek not, eşzamanlı çakışma koruması) | Var (main) | ADR-005/013/020, S2–S4 | Söylenebilir |
| Hasta kartı, zaman çizelgesi, hasta özeti, kilo geçmişi | Var (main) | ADR-006/020, Aşama 4 | Söylenebilir |
| Tedavi/uygulama kaydı, stok düşümü, parti (lot) + son kullanma, mal kabul, düşük/süresi geçmiş stok | Var (main) | ADR-015, Aşama 5, Q7 | Söylenebilir |
| Reçete (satırlı) | Var (main) | Aşama 5 D3 | Söylenebilir; **e-reçete yok** |
| Ücret, tahsilat, kısmi ödeme, bakiye, düzeltme/iptal, ücret önerisi, hizmet kataloğu | Var (main) | ADR-012/018 | Söylenebilir |
| Doğrudan satış (muayenesiz ürün satışı, stok düşer), gün sonu raporu, borç raporu | Var (main) | ADR-016, Q5/Q8, `feat(sales)` | Söylenebilir |
| Kayıt defterleri: Muayene, Reçete, Aşı, İlaç, Narkotik/Psikotropik; Aşı Bilgi raporu; CSV/XLSX/yazdırma | Var (main) (`reports/registers`) | ADR-015, `REGISTERS_API_CONTRACT.md` | Söylenebilir **"mevzuata uygun" DENMEZ**: sözleşmede "resmî biçime uygunluk doğrulanmadı". Güvenli ifade: "Aşı, ilaç ve narkotik kayıt defterlerini otomatik tutar, yazdırır" |
| KVKK: klinik başına aydınlatma + açık rıza formu (yazdırılabilir), rıza durumu ve metin sürümü, müşteri veri kopyası, KVKK talep süreci | Var (main) | ADR-021/025/032, `operations/kvkk-talep-sureci.md` | Söylenebilir; **"KVKK uyumlu" DENMEZ** (hukuki onay yok, HUKUKI-ONAY-LISTESI). Güvenli: "KVKK süreçleriniz için hazır formlar ve kayıt" |
| Lab istem/sonuç durumu, yatış (hospitalizasyon) | Var (main) | Aşama 6–7 | Söylenebilir; cihaz/PACS entegrasyonu **yok** |
| Aşı ve randevu hatırlatması | Var — **yalnız e-posta** | `Infrastructure/Reminders`, `Mailing/MailKit`; SMS gönderici yok (ContactChannel enum'da Sms yalnız tercih bilgisi) | "E-posta ile hatırlatma" denir; "SMS" DENMEZ. Gerçek gönderim senaryosu doğrulanmadı (roadmap notu) |
| Eski programdan veri aktarımı (Excel/CSV şablon, sütun eşleme, doğrulama, arka plan, geri alma; 5.000 müşteri/8.000 hasta/20.000 aşı ölçüldü) | Var (main) | ADR-019, Q12–Q18 | Söylenebilir: "müşteri, hasta ve aşı geçmişi"; muayene/ödeme geçmişi aktarımı **yok** |
| Rapor merkezi, global arama (mikroçip, telefon, Türkçe harf) | Var (main) | ADR-003, SEARCH-001, UX-006 | Söylenebilir |
| Çok klinik (tek kurum), roller ve izinler, denetim izi | Var | tenant/clinic temeli | Söylenebilir |
| Çalışanın telefondan aynı panele girmesi | Kısmen (responsive, "masaüstü/tablet öncelikli") | MOBILE-004 Planlandı | "Tarayıcıdan her cihazda" güvenli; "mobil uygulama" DENMEZ |
| Hasta sahibi portalı (hayvanlarım, randevular, aşılar, bakiye) ve mobil uygulaması | **Geliştiriliyor** (backend Dilim A/B dallarda; frontend `projects/portal` iskelet, giriş/davet/kabul var) | ADR-031, `PORTAL_API_CONTRACT.md` | Yalnız "yakında" / yol haritası olarak; yayın tarihi verilmez |
| 14 gün ücretsiz deneme, kartsız | Var (backend `TrialDays=14`) | ADR-001 | Söylenebilir; **trial kısıtlama politikası ve dönüşüm akışı karar bekliyor** (roadmap açık soru) |
| Örnek klinik verisiyle deneme | **Ertelendi** (pilot sonrası) | ADR-002, kuyruk notu 2026-10-14 | DENMEZ |
| Online ödeme (iyzico/Stripe abonelik) | Altyapı var, anahtar yenilenecek | ADR-014 | Sitede "kartla ödeme" DENMEZ (şimdilik) |
| SMS, WhatsApp, e-Fatura/e-SMM, POS, online randevu, cihaz/PACS, AI yardımcı | **Yok** (Aşama 10–12) | roadmap | DENMEZ; "yol haritası" bölümünde isteğe bağlı |
| Veri Türkiye'de barındırılır / yedek / şifreleme | **Karar var, uygulama yok** (ADR-014 K1–K2: yönetilen bulut, dakikalar düzeyinde yedek; VPS/hosting kullanıcıda) | ADR-014 | Sağlayıcı seçilince yazılır; şimdi DENMEZ |
| Hukuki metinler (gizlilik, kullanım şartları, DPA) | Taslak 0.x | ADR-024/029 | Taslak bandı kalır (ADR-024, onaysız kaldırılmaz) |
| Referans müşteri, klinik sayısı | **Yok** (pilot henüz başlamadı) | ADR-014 | Sayı uydurulmaz; pilot sonrası |

## 5. Rakiplerin tanıtım vaatleri ve boşluklar

Kaynak: rakiplerin kamuya açık sayfaları (2026-10-16) + `competitors/`. Rakip beyanları doğrulanmadı.

| Rakip | Ana vaat / ton | Fiyat | Çağrı | Güven ögeleri |
|---|---|---|---|---|
| **E-vet Smart (Plus)** — TR | "Türkiye'nin en çok tercih edilen", bulut + yapay zekâ, "hata payını sıfıra indiren"; e-Fatura/e-Arşiv, POS, PACS, SMS, lab cihazı, arayan numara; mobil (SmartVet/SmartIVET) | Yok (iletişime geçin) | Ücretsiz deneme "kurulum yok, taahhüt yok" + demo talebi | Hekim yorumları; "veriler Türkiye'deki veri merkezinde"; rol bazlı yetki |
| **DaySmart Vet** — ABD | "Finish records up to 50% faster"; 21.000+ profesyonel, 2.500+ klinik, 15+ yıl; 40+ entegrasyon; 7/24 destek | Ayrı sayfa, ana sayfada yok | "Book a demo", "no pressure, no commitment"; ücretsiz deneme yok | Müşteri hikâyeleri (isimli hekimler), entegrasyon logoları, durum sayfası |
| **VETport** — global bulut | SOAP EMR, 20+ entegrasyon, 7/24 destek, "her cihazdan" | Üçüncü taraf sitelerde ~119 $/ay (tutarsız) | Demo/deneme | 2002'den beri |
| **Bulutvet** — TR (legacy) | Pansiyon, kasa, senet, SMS/POS, e-Fatura | Bilinmiyor | Bilinmiyor | Bilinmiyor |

**Ortak kalıp:** (1) fiyat gizli, (2) demo + deneme ikisi birden, (3) sosyal kanıt sayıları, (4) entegrasyon listesi (e-Fatura, SMS, POS, PACS) başlık düzeyinde, (5) "modern/bulut/yapay zekâ" sıfatları, (6) mobil uygulama.

**Vetinity'nin bugün aynısını söyleyemeyeceği şeyler:** entegrasyon listesi (hiçbiri yok), sayılar, mobil uygulama, Türkiye veri merkezi (henüz seçilmedi), yapay zekâ.

**Rakiplerin söylemediği, Vetinity'nin kanıtla söyleyebileceği şeyler (boşluklar):**
1. **Günün akışı tek ekranda** (Bugün: geliş, bekleme, acil, uyarı, ücretlenmemiş işlem, açık işler). Rakip siteleri modül listesi anlatıyor; iş akışı anlatmıyor.
2. **Kayıt defterleri otomatik** (aşı, ilaç, narkotik/psikotropik, muayene, reçete) + Aşı Bilgi raporu; parti/son kullanma takibiyle birlikte. Rakipte var ama tanıtımda öne çıkmıyor; Türkiye'ye özgü, uluslararası ürünlerde hiç yok.
3. **KVKK iş akışı hazır**: aydınlatma + açık rıza formu, rıza kaydı ve metin sürümü, veri kopyası ve talep süreci. Rakip sitelerinde KVKK geçmiyor. (İfade dikkatli: "uyumlu" değil, "formlar ve kayıt hazır; metni danışmanınız onaylar".)
4. **Kayıt dürüstlüğü**: kesinleştirilen muayene kilitlenir, düzeltme ek notla, her düzeltme/iptal gerekçeli ve izli; iki kişinin aynı kaydı ezmesi engellenir. Hekim ve denetim için güven mesajı.
5. **Eski programdan geçiş sihirbazı** (Excel, eşleme, kuru çalıştırma, geri alma, hatırlatma seli yok). Rakip sitelerinde geçiş anlatılmıyor; geçiş korkusu en büyük satış engeli.
6. **Şeffaflık**: ne yapmadığımızı yazmak (SMS yok, e-Fatura yol haritasında) rakiplerin "her şey var" tonundan ayrışır; pilot kliniğe uygun.
7. **Kartsız 14 gün deneme + satışçısız kayıt** (ADR-001): E-vet de "deneme" diyor, DaySmart demiyor. Fark, denemenin gerçekten anında olması; bu, örnek klinik ertelendiği için boş hesapla başlıyor — **zayıf nokta**, bkz. öneri.

## 6. Hedef kitle ve konumlandırma seçenekleri (özet; gerekçe ve öneri öneri belgesinde)

| Seçenek | Kim | Mesaj | Ton | Risk |
|---|---|---|---|---|
| A — Tek hekimli / küçük klinik (kâğıt/Excel'den geçen) | 1–3 kullanıcı, tek klinik; ADR-014 pilot profili | "Günü kaçırmadan yönet; defterler ve KVKK kendiliğinden" | Sade, somut, Türkçe; teknik sıfat yok | Fiyat hassasiyeti; SMS/e-Fatura isteyebilir |
| B — Çok klinikli işletme | 2+ şube, yönetici | "Tüm şubeler tek kurumda, rol ve rapor" | Yönetici dili | Bugün tanıtımın tonu bu; ama pilot ve örnek veri yok, referans yok, enterprise beklentileri (SSO, audit) P4 |
| C — Hayvan hastanesi | Yatış yoğun, çok hekim | "Yatış, lab, görüntüleme" | Klinik derinlik | PACS/cihaz yok; yatış yeni; hedef değil (Aşama 12) |

Kanıt: pilot profili küçük klinik (ADR-014 K4), Bugün/geliş/defter/KVKK yetenekleri A'ya en çok değer katıyor; B yalnız ikincil satır ("büyüyünce şube ekleyin"). **Öneri: A ana, B ikincil; C sitede yok.** Karar kullanıcının (AK-1 öneri belgesinde).

## 7. Görsel ihtiyaçlar (gerçek ekran, anonim test verisi)

Çekilecek (panelde TEST/sentetik veriyle; gerçek müşteri verisi yok; tarayıcı 1536 CSS px, açık tema; koyu tema ikinci set):
1. **Bugün** ekranı: 5–6 satır, biri bekliyor, biri acil, biri uyarı rozetli, ücret bekleyen çipi.
2. **Muayene çalışma alanı**: dolu bir muayene (şikâyet, bulgular, vital, tanı), sağda hasta bağlamı; kesinleştirme kontrol listesi.
3. **Hasta kartı + zaman çizelgesi**.
4. **Aşı Kayıt Defteri** ekranı ve yazdırma önizlemesi (resmî biçim notuyla).
5. **KVKK açık rıza formu yazdırma görünümü** + müşteri kartında rıza durumu.
6. **Ödeme al / bakiye** paneli; gün sonu raporu.
7. **Veri aktarma sihirbazı**: eşleme adımı ve doğrulama raporu.
8. **Stok > Mal kabul** (parti, son kullanma) ve düşük stok uyarısı.
9. Telefon genişliğinde Bugün (responsive kanıtı) — yalnızca gerçekten iyi görünüyorsa.
10. Portal **yok** (geliştiriliyor); yayınlanana kadar görsel konmaz.

Her görsel: PNG/WebP, 2× çözünürlük, `alt` metni, klinik adı "Örnek Veteriner Kliniği", kişi/hayvan adları açıkça sentetik; telefon numaraları `+90 5xx 000 00 00` biçiminde.

## 8. Önceliklendirilmiş uygulama dilimleri (küçükten büyüğe; kapsam öneri belgesinde)

| # | Dilim | Boyut | Bağımlılık |
|---|---|---|---|
| D0 | www alan adını siteye bağlama + güncel derleme yayını | Kullanıcı (ADR-033/VPS) | — |
| D1 | Metin düzeltmeleri: ADR-022 dili, boş iddiaları silme, başlık/meta'ya "veteriner", tema düğmesi `aria-label`, mobil menü (hamburger), paket sınırı tutarlılığı, ölü `landing/` klasörünün silinmesi | Küçük | — |
| D2 | Teknik SEO: `robots.txt`, `sitemap.xml`, `og:image`, JSON-LD (Organization + FAQPage), staging `noindex`, canonical sabit `www` | Küçük | D0 için adres kararı |
| D3 | Ana sayfa yeniden yazımı (problem odaklı omurga, gerçek ekran görüntüleri, dürüst "yapmıyoruz" listesi), SSS genişletme | Orta | Görsel çekimi (bölüm 7) |
| D4 | Yeni sayfalar: Özellikler (iş akışı anlatımı), Güvenlik ve KVKK, Geçiş, İletişim/Demo talebi (form → e-posta; backend ucu yok, yeni), Hakkımızda/Destek | Orta | AK-5 demo modeli, iletişim bilgileri |
| D5 | Fiyat sayfası kararı uygulaması (fiyat ya da "teklif al") | Küçük–orta | AK-2 |
| D6 | Tanıtımın ayrı derleme/prerender olarak sunulması (ADR-033 ile birlikte), analitik (dış kaynaksız) | Orta | ADR-033 uygulaması |
| D7 | Portal/mobil sayfası (yayınlanınca), referans/vaka sayfası (pilot sonrası) | Sonra | Portal yayını, pilot |

## 9. Açık kararlar

Öneri belgesindeki AK-1…AK-8 listesi geçerlidir (hedef kitle, fiyat gösterimi, ana mesaj, ton, demo/deneme modeli, iletişim bilgileri ve tüzel kişi, analitik, adres düzeni etkisi). Bu belge karar vermez.

## Kaynaklar (rakip tanıtım sayfaları, 2026-10-16)

- E-vet Smart: https://www.evetsmart.com · https://www.e-vet.com.tr
- DaySmart Vet: https://www.daysmart.com/vet/
- VETport: https://vetport.com · https://www.trustradius.com/products/vetport · https://www.aaha.org/trends-magazine/publications/view-from-the-board-considerations-for-choosing-veterinary-practice-management-software/
- E-vet mobil uygulamaları (App Store): https://apps.apple.com/us/app/-/id1269577446 · https://apps.apple.com/app/id1185786102
