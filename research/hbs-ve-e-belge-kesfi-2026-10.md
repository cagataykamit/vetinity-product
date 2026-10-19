# HBS ve e-belge (e-SMM / e-Arşiv / e-Fatura) keşfi — 2026-10

Tarih: 2026-10-19. Tetikleyen: kullanıcı beyanı (2026-10-19) — HBS entegrasyonu ve e-Fatura/e-SMM Vetinity için de **zorunlu**. Bu belge keşiftir; **hukuki veya vergi tavsiyesi değildir**. Çalışma varsayımıyla ilerlenir ([HUKUKI-ONAY-LISTESI](../roadmap/HUKUKI-ONAY-LISTESI.md) "Geliştirme varsayımı"); doğrulanamayan her mevzuat/teknik iddia **DOĞRULANMADI** diye işaretlidir. Karar taslağı: [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md). Rakip gözlemi: [e-vet.md HBS](../competitors/e-vet.md#hbs-modül), [e-vet.md e-Fatura/e-SMM](../competitors/e-vet.md#e-fatura--e-smm-modül).

Yöntem: web araması ve resmî/ikincil sayfaların okunması (2026-10-19). Resmî Gazete tam metinleri ve Bakanlık kılavuzlarının çoğu bu oturumda **açılamadı** (ücretli mevzuat sitesi, kırık bağlantı, sertifika hatası); aşağıdaki mevzuat özetleri bu yüzden çoğunlukla Bakanlık il müdürlüğü duyuruları, haber ve entegratör bloglarına dayanır.

---

## 1. Kısa sonuç

1. **"HBS" tek bir bildirim değil, bir çatı.** Tarım ve Orman Bakanlığı'nın Hayvan Bilgi Sistemi (`hbs.tarbil.gov.tr`) altında, kliniği ilgilendiren en az üç iş var: **e-Reçete** (reçeteye tabi veteriner ilaçlar, 2018'den beri), **ATS — Aşı Takip Sistemi** (serbest hekimin yaptığı aşı kayıtları) ve **ev hayvanı kimlik/kayıt** (mikroçip, pasaport, sahip değişikliği, ölüm; eskiden PETVET adıyla anılır). Rakip E-vet'in "HBS" menüsü de tam olarak bu ikisini gösteriyor: **e-Reçete** ve **ATS** sekmeleri.
2. **Klinik yazılımları için herkese açık resmî bir HBS web servisi/API bulunamadı.** Giriş e-Devlet ile (kurum dışı kullanıcı). Piyasada bir ürünün HBS portal sayfalarını **tarayıcı eklentisiyle** otomatikleştirdiği görüldü; bu, resmî API'nin en azından kolay erişilebilir olmadığına işaret eder (kanıt değil). → **DOĞRULANMADI**: Bakanlığın yazılım firmalarına web servis izni verip vermediği.
3. **Serbest çalışan veteriner hekim e-SMM düzenler** (VUK 509 sıra no.lu tebliğ; veteriner hekimler serbest meslek erbabı). Ancak klinik **şirket** (Ltd./A.Ş.) ise belge **fatura**dır (e-Arşiv / e-Fatura). Muayenehanede ayrıca mama/aksesuar gibi **ticari satış** varsa bu kısım fatura gerektirir (ikincil kaynak, DOĞRULANMADI). Yani **tek klinikte iki belge türü** olabilir; ürün **belge türünü kiracı ve satır bazında** çözmelidir.
4. **GİB'e doğrudan entegrasyon Vetinity için gerçekçi değil**; yol **özel entegratör** (Paraşüt, Logo/eLogo, Uyumsoft, Sovos, BirFatura vb.) API'si. Kontör (belge başı) + yıllık ücret modeli yaygın; kontör birim fiyatı yaklaşık 0,5–1 TL bandında ilan ediliyor (tek satıcı sayfası, DOĞRULANMADI). Mükellefin (kliniğin) entegratörle **kendi sözleşmesi** olması tipik.
5. **Veri modelimiz eksik:** müşteride TCKN/VKN, vergi dairesi, fatura adresi yok; ücrette (Charge) KDV oranı/stopaj yok; reçetede HBS'in istediği yapı (ürün ruhsat/barkod, seri/parti, hayvan kimlik no) yok; muayene/aşıda HBS kimlik no ve aşı uygulama belgesi seri no alanı yok. Mikroçip, parti/SKT ve aşı↔uygulama↔parti bağı **var** (iyi başlangıç).

---

## 2. HBS — bulgular

### 2.1 Neler kayda tabi (çalışma özeti)

| Olay | Ne kaydedilir | Kim / nerede | Süre | Kaynak | Durum |
|---|---|---|---|---|---|
| Kimliklendirme (mikroçip + pasaport) | 15 haneli çip no, hayvan adı, tür, ırk, cinsiyet, renk, doğum tarihi; sahip adı, TCKN, telefon, il/ilçe/mahalle, acil kişi | İl/ilçe müdürlüğü veya **Bakanlıkça yetki verilen** kişi/kuruluş (serbest hekim, protokolle) | Tüm kedi/köpek için son tarih 31.12.2025 (2025 değişikliği); yeni doğanlar için başvuru süresi 6 ay (haber) | [Eskişehir İl Md.](https://eskisehir.tarimorman.gov.tr/Duyuru/675/Sahipli-Hayvanlarin-Dijital-Kimliklendirilmesi), [Medyascope 2025](https://medyascope.tv/2025/03/05/kedi-ve-kopeklerle-ilgili-yonetmelikte-degisiklik-evcil-hayvanlari-ciplendirme-suresi-yil-sonuna-kadar-uzatildi/), [Lexpera künye](https://www.lexpera.com.tr/mevzuat/yonetmelikler/kedi-kopek-ve-gelinciklerin-kimliklendirilmesi-ve-kayit-altina-alinmasina-dair-yonetmelik-1/3) | Kapsam (kedi, köpek, gelincik) ve çip tanımı doğrulandı (yönetmelik m.1–4). Serbest hekimin rolü ve süreler **DOĞRULANMADI** (haber düzeyi) |
| Aşı (özellikle kuduz) | Aşı, seri no, tarih, hekim | Serbest hekimin aşı kayıtları **ATS üzerinden** | "15 gün içinde" (2018 haberi) | [2024/11 Tebliğ m.6](https://www.lexpera.com.tr/mevzuat/tebligler/tz801y2024n32546s202411), [Ekonomist](https://www.ekonomist.com.tr/haberler/sahipli-kedi-ve-kopeklerin-kimliklendirilmesi-zorunlu-olacak.html) | ATS'nin varlığı ve "serbest veteriner hekimler tarafından yapılan aşı kayıtları ATS üzerinden yapılır" hükmü doğrulandı; ancak o tebliğ sayfada **mülga** görünüyor, yerine gelen metin ve kedi/köpek için hangi aşıların zorunlu olduğu **DOĞRULANMADI** |
| e-Reçete | Reçeteye tabi veteriner ilaçların reçetesi; hayvan, ilaç, miktar, doz | Tüm veteriner hekimler (serbest dahil), HBS e-Reçete; İlaç Takip Sistemi (İTS) ile bağlı | 01.01.2018'den beri | [Bakanlık haberi](https://www.tarimorman.gov.tr/GKGM/Haber/175/Veteriner-Hekimlikte-E-Recete-Uygulamasina-Gecildi), [Artvin İl Md.](https://artvin.tarimorman.gov.tr/Haber/475/Veteriner-E-Recete-Ve-Ilac-Takip-Sistemi-Ile-Ilgili-Bilgilendirmeler-Tamamlandi), Talimat (12.12.2018) — [Lexpera](https://www.lexpera.com.tr/mevzuat/kilavuzlar/veteriner-hekim-e-recete-ve-ilac-takip-sistemi-talimati-ve-uygulama-kilavuzu-3685613) | Sistem ve serbest hekimin kullanıcı olması doğrulandı. **Pet (kedi/köpek) tedavilerinin e-reçete kapsamında olup olmadığı, hangi ilaç grupları** — **DOĞRULANMADI** (talimat tam metni açılamadı) |
| Sahip değişikliği | Yeni sahip | Yeni sahip il/ilçe müdürlüğüne başvurur | 60 gün | Eskişehir İl Md. | Duyuru düzeyi; **sahibin** yükümlülüğü, hekimin değil |
| Ölüm | Ölüm bildirimi, pasaport teslimi | Sahip, il/ilçe müdürlüğüne | 30 gün | Eskişehir İl Md., Medyascope | Duyuru düzeyi; **sahibin** yükümlülüğü |
| Kayıp | Kayıp bildirimi | Sahip | 7 gün | Aynı | Aynı |

**Çıkarım (ürün için):** Hekimin/kliniğin doğrudan yaptığı işler **e-Reçete**, **ATS aşı kaydı** ve (yetkiliyse) **kimliklendirme**dir. Sahip değişikliği/ölüm/kayıp sahibin yükümlülüğü görünüyor; klinik yazılımı burada en fazla **hatırlatma/bilgi çıktısı** verir. Rakip de yalnız e-Reçete + ATS göstermekte.

### 2.2 Entegrasyon yolu ve kimlik doğrulama

| Konu | Bulgu | Durum |
|---|---|---|
| Portal | `hbs.tarbil.gov.tr`; giriş seçenekleri "Kurum içi kullanıcı" ve "**e-Devlet** kullanıcı girişi (kurum dışı)" | Doğrulandı (giriş sayfası, 2026-10-19) |
| Hekim yetkisi | 2018 haberlerinde serbest hekimlere eğitim verilip şifre tanımlandığı yazıyor; bugün e-Devlet girişi | Eski şifre yöntemi güncel mi **DOĞRULANMADI** |
| Resmî web servis / API | Bakanlık "Veteriner Sağlık Ürünleri" sayfasında yalnız sorgu ekranları (ruhsatlı ilaç, biyolojik ürün, ecza deposu) var; yazılım firması entegrasyon dokümanı bulunamadı | **DOĞRULANMADI** (yokluğu kanıtlanmadı) |
| Piyasa uygulaması | Bir ürün (FugeVet) `hbsapp.tarbil.gov.tr` e-reçete sayfalarını **tarayıcı eklentisi** ile otomatikleştiriyor ([Chrome Web Store](https://chromewebstore.google.com/detail/dhoegonpbndknopkjhbojogcncpfgggm), son güncelleme 2026-03) | Gözlem. Resmî API olmadığının **kanıtı değil**, ama işaret |
| Rakip E-vet | HBS ekranı: e-Reçete ve ATS listeleri, satırda "HBS Kimlik No", "e-Reçete No", "Aşı Uygulama Belgesi Seri No" ve kaydet-benzeri ikon, Excel dışa aktarma | Gözlem (2026-10-04); gönderimin otomatik mi el ile mi olduğu **DOĞRULANMADI** |

**Çalışma varsayımı:** Kısa vadede HBS'e **otomatik gönderim yapılamaz**; hekim HBS'e e-Devlet ile kendisi girer. Vetinity'nin değeri: girilecek veriyi **eksiksiz, doğru biçimde ve tek ekranda hazır** vermek, HBS'ten dönen numaraları (e-Reçete No, aşı belge seri no, HBS hayvan kimlik no) geri kaydetmek ve "HBS'e girilmemiş" işleri iş listesi olarak göstermek. Resmî web servis izni çıkarsa aynı veri modeli otomatik gönderime taşınır.

> Tarayıcı eklentisiyle Bakanlık portalını otomatikleştirme **önerilmez**: kullanıcı oturumunu yazılım adına kullanma, portal değişince kırılma ve kurum kullanım şartları riski. (Ürün görüşü; hukuki değerlendirme değil.)

---

## 3. e-belge — bulgular

### 3.1 Hangi belge, kime

| Durum | Belge | Kaynak | Durum |
|---|---|---|---|
| Serbest çalışan veteriner hekim (şahıs, serbest meslek kazancı), hizmet bedeli | **e-SMM** (e-Serbest Meslek Makbuzu); vergiden muaf olmayan tüm serbest meslek erbabı | VUK 509 Sıra No.lu Genel Tebliğ — [Sovos](https://sovos.com/tr/blog/kdv/e-smm-nedir-kimlere-zorunlu/), [Paraşüt](https://www.parasut.com/blog/e-smm-mukellefi-nedir), [GİB rehberi (TÜRMOB arşivi)](https://www.turmob.org.tr/Arsiv/FCKEditor/userfiles/file/GIB-2023-REHBERLER/2023_serbestmeslekkazancirehber.pdf), [Ekonomist](https://www.ekonomist.com.tr/teknoloji/serbest-meslek-dijitallesmeye-geciyor.html) | Veteriner hekimin e-SMM kapsamında olduğu birden çok ikincil kaynakta açık; **resmî tebliğ metni okunmadı** |
| Tedavide kullanılan ilaç | Hizmetin unsuru sayılır, **aynı e-SMM**'de gösterilir | [muhasebenews](https://www.muhasebenews.com/164613-2/) (2016 özelgesi özeti) | **DOĞRULANMADI** (özelgenin aslı okunmadı) |
| Ayrı ilaç/mama/aksesuar satışı (ticari kazanç) | **Fatura** (e-Arşiv; alıcı e-Fatura mükellefiyse e-Fatura) | Aynı | **DOĞRULANMADI** |
| Klinik şirket (Ltd./A.Ş.) | Hizmet ve ürün için **fatura** (e-Arşiv / e-Fatura) | Genel kural | **DOĞRULANMADI** (veterinere özgü kaynak bulunmadı) |
| e-Fatura mükellefi olmayana fatura | 1.1.2026'dan itibaren e-Arşiv genel kural (tutar sınırı kalktı); basit usul/işletme defteri için küçük tutarlarda kâğıt istisnası 31.12.2026'ya (veya 2027'ye) kadar | [Paraşüt](https://www.parasut.com/blog/e-fatura-ve-e-arsiv-zorunlulugu), [Sovos](https://sovos.com/tr/blog/kdv/2026-e-fatura-zorunlulugu-ve-gecis-rehberi/) | Kaynaklar kendi içinde çelişkili (tebliğ no 509/535/589; tarih 2026/2027); **DOĞRULANMADI** |
| e-Fatura'ya zorunlu geçiş | 2025 brüt hasılatı 3 milyon TL ve üzeri → 1.7.2026 (en çok tekrar eden) | [mukellef.co](https://mukellef.co/blog/e-fatura-gecis-hadleri/), [Sovos](https://sovos.com/tr/blog/kdv/sirketler-icin-2026-e-donusum-takvimi-ve-zorunluluklar/) | Kaynaklar çelişkili (3/4/5 milyon); **DOĞRULANMADI** |
| Hekim POS tahsilatı | POS yalnız tahsilat için; sonrasında yine e-SMM düzenlenir (379 sıra no.lu VUK tebliği) | ikincil (arama özeti) | **DOĞRULANMADI** |
| İptal | e-Arşiv ve e-SMM iptali belge alıcıya teslimden itibaren **8 gün** (GİB iptal kılavuzu 2021 v1.0); bazı kaynaklar 7 gün diyor. Entegratör kullanılıyorsa iptali entegratör GİB'e bildirir | [Paraşüt](https://www.parasut.com/blog/e-smm-iptal-ve-duzenleme-islemleri), [Paraşüt](https://www.parasut.com/blog/e-belgelerde-iptal-ihbar-ve-ihtarlarin-bildirilmesi) | **DOĞRULANMADI** (kılavuzun aslı okunmadı); süre tek sabitte yaşamalı |
| Stopaj | e-SMM'de alıcı vergi kesintisi yapmakla yükümlü (kurum/şirket) ise stopaj gösterilir; bireysel hasta sahibine düzenlenen makbuzda genellikle yok | Sovos | **DOĞRULANMADI** |

**Ürün çıkarımı:** Vetinity'de iki eksen var: (1) **kiracının mükellef türü** (serbest meslek şahıs / şirket / ikisi birden: hizmet e-SMM + ticari satış fatura) ve (2) **alıcı türü** (bireysel: TCKN veya "11111111111" benzeri bilinmeyen alıcı uygulaması — **DOĞRULANMADI**; kurumsal: VKN + vergi dairesi; e-Fatura mükellefi mi sorgusu). Belge türü bu ikisinden **tek bir kural yerinde** türetilmeli.

### 3.2 Entegrasyon yolları

| Yol | Ne demek | Vetinity için |
|---|---|---|
| **GİB Portal** (e-Arşiv Portal / e-SMM portal) | Mükellef GİB'in web arayüzünden elle keser | Resmî API yok (gayriresmî kütüphaneler portalı taklit ediyor — önerilmez). Vetinity yalnız "hazır veri + kopyala" sunabilir |
| **Doğrudan entegrasyon (GİB)** | Mükellefin kendi bilgi işlem sistemi GİB'e bağlanır; izin, mali mühür, güvenlik gereksinimleri | **Her klinik ayrı mükellef** olduğu için Vetinity'nin tek bir doğrudan entegrasyonla tüm kliniklere belge kesmesi mümkün görünmüyor; **özel entegratör izni** almak ise ayrı bir iş kolu. **Önerilmez** (gereksinimler DOĞRULANMADI) |
| **Özel entegratör API'si** | Klinik bir entegratörde (Paraşüt, eLogo, Uyumsoft, Sovos/Foriba, BirFatura, Kolaysoft vb.) mükellef hesabı açar; Vetinity o hesabın API kimlik bilgileriyle belge oluşturur/iptal eder/PDF alır | **Önerilen yol.** Örnek: Paraşüt API (OAuth2, e-Arşiv/e-Fatura/e-SMM kaynakları, asenkron iş takibi, PDF; sandbox kimlik bilgisi destek ekibinden — [üçüncü taraf dokümanı](https://docs.wisecp.com/en/parasut-e-invoice-addon), resmî `apidocs.parasut.com` bu oturumda okunamadı → **DOĞRULANMADI**) |
| **Vetinity'nin bir entegratörle iş ortaklığı** (bayi/çözüm ortağı) | Vetinity tek entegratörle anlaşır, klinik o entegratörde mükellef olur, fiyat/onboarding Vetinity üzerinden | Ticari karar; sürtünmeyi azaltır ama bağımlılık ve kontör yeniden satışı getirir (kullanıcı kararı) |

**Maliyet modeli (ilan edilen, DOĞRULANMADI):** Entegratörler genelde **kontör** (gönderilen/alınan belge başı 1 kontör) + bazen yıllık abonelik/arşiv ücreti alıyor. Örnek ilan: 500 kontör ≈ 400 TL, 10.000 kontör ≈ 0,52 TL/adet ([BirFatura](https://birfatura.com/e-fatura-kontor-fiyatlari-e-fatura-fiyatlari/)); Paraşüt e-SMM için kurulum ücreti yok, ön ödemeli kontör ([Paraşüt kılavuzu](https://www.parasut.com/kullanim-kilavuzu/e-serbest-meslek-makbuzuna-gecmenin-maliyeti-nedir)). Bir satıcı sektörde belge başı 10 TL'ye varan fiyatlar olduğunu iddia ediyor ([Faturaport](https://faturaport.com/blog/e-fatura/2026-mayis-e-fatura-kontor-fiyatlari)). Kuruluş başvurusu (e-Arşiv interaktif) için İVD kullanıcı kodu/şifresi gerekiyor, mali mühür gerekmiyor (Paraşüt kılavuzu; DOĞRULANMADI).

### 3.3 Sorumluluk dağılımı (çalışma varsayımı)

| Taraf | Sorumluluk |
|---|---|
| Klinik (mükellef) | Belgenin vergisel doğruluğu, mükellef türü, KDV/stopaj seçimi, entegratör sözleşmesi ve kontör, muhasebeci onayı |
| Entegratör | GİB'e iletim, imza/mühür, saklama (arşiv), iptal bildirimi |
| Vetinity | Doğru veriyi doğru zamanda göndermek, **aynı ücret için iki belge kesilmemesi** (idempotency), durum takibi, hata/yeniden deneme, denetim izi, kimlik bilgisinin güvenli saklanması; belgenin kendisini saklama yükümlülüğü entegratördedir (Vetinity yalnız referans + PDF bağlantısı/kopyası) |

---

## 4. Rakipler (özet, kopyalama yok)

| Rakip | Gözlenen | Kaynak | Not |
|---|---|---|---|
| E-vet SMART | Sol menüde ayrı **HBS** (e-Reçete + ATS listeleri, HBS kimlik no / e-Reçete no / aşı belge seri no alanları, Excel dışa aktarma) ve **e-Fatura / e-SMM** (hazır → taslak → gönder paneli; giden/gelen listeleri; e-Fatura / e-SMM seçici). Müşteri kartında Kimlik No zorunlu. Gelgeç müşteriye e-Fatura düzenlenemediği video anlatımı | [e-vet.md](../competitors/e-vet.md#hbs-modül) | Gönderim otomasyonu ve entegratör **DOĞRULANMADI** (PARTIAL) |
| Kolayvet | Sitede entegrasyon listesinde "E-Fatura, E-Arşiv, e-Smm", "E-Dönüşüm" sayfası, "Tarbil Entegrasyonu" ifadesi; entegratör adı yok; HBS/e-reçete ifadesi yok. Fiyat sayfasına göre SMS/e-fatura pakete dahil (ADR-035 bağlamı) | [kolayvet.com](https://www.kolayvet.com), [fiyatlar](https://www.kolayvet.com/fiyatlar) | "Tarbil Entegrasyonu" içeriği **DOĞRULANMADI** |
| FugeVet | HBS e-reçete sayfalarını tarayıcı eklentisiyle otomatikleştiriyor | Chrome Web Store | Yaklaşım önerilmez (bkz. 2.2) |
| Vetport, VetSoft, Hasvet, diğer yerli masaüstü ürünler | HBS / e-belge kanıtı bulunamadı | Arama | Bilgi yok |

**Problem odaklı ders:** Pazar bu iki modülü **temel hijyen** sayıyor (rakip menüsünde ayrı, Kolayvet'te pakete dahil). Ayırt edici olan modülün varlığı değil, **klinik akışın içinde unutulmaması**: muayene/aşı kapanırken "HBS'e girilecek" ve "belge kesilecek" işlerinin kendiliğinden belirmesi, tek tıkla belge, hatanın anlaşılır gösterilmesi.

---

## 5. Mevcut Vetinity modelleri ile eşleşme (backend `Veteriner`, 2026-10-19 okundu)

| İhtiyaç | Bugün var | Eksik |
|---|---|---|
| Hayvan kimliği | `Pet.MicrochipNumber`, `PassportOrTagNumber`, tür/ırk/renk/cinsiyet/doğum tarihi, `Status`/`DeceasedOn` | HBS hayvan kimlik no (rakipte "HBS Kimlik No"), çip formatı doğrulaması (15 hane) |
| Sahip kimliği | `Client.FullName`, `Phone`, `Address` (serbest metin), `Email` | **TCKN**, VKN + vergi dairesi, kurumsal/bireysel ayrımı, yapılandırılmış il/ilçe/fatura adresi |
| Aşı | `Vaccination` + `Administration.VaccinationId` + `Administration.BatchId` (parti/lot, SKT — ADR-015) | Aşı uygulama belgesi seri no, ATS'e girildi bilgisi/tarihi |
| Reçete | `Prescription` (serbest metin `Content`) + `PrescriptionItem` (ad, ürün, talimat, miktar) | e-Reçete No, ilaç ruhsat/barkod (HBS ürün eşlemesi), doz/birim yapısı, seri no, teşhis bağlantısı |
| Ücret | `Charge` (tutar, adet, birim fiyat, para birimi, iptal, `RequestId`) | **KDV oranı**, stopaj, belge türü, belgeye bağlanma (hangi belgede) |
| Ödeme / satış | `Payment` (yöntem, iptal, idempotency), `Sale` + `SaleLine` (tek ücret, Peşin müşteri — ADR-016) | Peşin müşteriye belge kuralı (bilinmeyen alıcı), ticari satış ↔ fatura ayrımı |
| Klinik / kiracı | `Clinic` (ad, şehir, telefon, adres) | Mükellef türü, VKN/TCKN, vergi dairesi, e-belge sağlayıcı ayarı, kimlik bilgisi (şifreli) |
| Sağlayıcı soyutlama deseni | `IEmailSender`, `IBillingCheckoutProvider` (iyzico) | e-belge sağlayıcı arayüzü (aynı desen) |

---

## 6. Doğrulanan / doğrulanmayan tablosu

| # | İddia | Durum | Nasıl doğrulanır |
|---|---|---|---|
| D1 | HBS portalı `hbs.tarbil.gov.tr`, kurum dışı giriş e-Devlet ile | **Doğrulandı** (giriş sayfası) | — |
| D2 | e-Reçete 01.01.2018'den beri tüm ülkede, serbest hekimler kullanıcı | **Doğrulandı** (Bakanlık + il müdürlüğü sayfaları) | — |
| D3 | Pet tedavilerinde e-reçete zorunlu ve hangi ilaçlar | DOĞRULANMADI | Talimat tam metni; pilot hekime sor |
| D4 | Serbest hekimin aşı kayıtları ATS üzerinden | Doğrulandı ama kaynak tebliğ **mülga** görünüyor | Yürürlükteki tebliğ; il müdürlüğü |
| D5 | Kedi/köpek kuduz aşısının ATS'e girilmesi zorunlu, süre | DOĞRULANMADI | Kuduz yönetmeliği; il müdürlüğü; pilot hekim |
| D6 | Kedi/köpek/gelincik kimliklendirme yönetmeliği (RG 26.02.2018/30344, son değişiklik 05.03.2025) | **Doğrulandı** (künye) | — |
| D7 | Serbest hekimin kimliklendirme yetkisi ve süreleri | DOĞRULANMADI (haber düzeyi) | Yönetmelik tam metni |
| D8 | Sahip değişikliği 60 gün, ölüm 30 gün, kayıp 7 gün (sahibin yükümlülüğü) | İl müdürlüğü duyurusu (2022); güncelliği DOĞRULANMADI | Yönetmelik tam metni |
| D9 | Klinik yazılımları için resmî HBS web servisi var | DOĞRULANMADI (bulunamadı) | Bakanlık HBS birimine yazılı soru |
| D10 | Veteriner hekim e-SMM kapsamında | Birden çok ikincil kaynakta açık; resmî metin okunmadı | VUK 509; mali müşavir |
| D11 | Tedavide kullanılan ilaç SMM'de, ayrı satış faturada | DOĞRULANMADI (özelge özeti) | Mali müşavir |
| D12 | 2026'da e-Arşiv genel kural, eşikler | DOĞRULANMADI (kaynaklar çelişkili) | GİB duyurusu; mali müşavir |
| D13 | e-SMM/e-Arşiv iptal süresi 8 gün (kılavuz) / 7 gün (bazı kaynaklar) | DOĞRULANMADI | GİB iptal kılavuzu |
| D14 | Entegratör API'leri e-SMM + e-Arşiv + iptal + PDF destekliyor, sandbox var | Paraşüt için üçüncü taraf dokümanı; DOĞRULANMADI | Seçilen entegratörün resmî dokümanı ve test hesabı |
| D15 | Kontör ≈ 0,5–1 TL/belge | Tek satıcı ilanı; DOĞRULANMADI | Teklif almak |
| D16 | Rakip E-vet gönderimi otomatik | DOĞRULANMADI | — (rakip hesabında config eksik) |

---

## 7. Entegrasyon seçenekleri karşılaştırması

### HBS

| Seçenek | Maliyet (geliştirme) | Klinik için değer | Risk / sorumluluk | Öneri |
|---|---|---|---|---|
| **H1. Manuel yardımcı** — bildirilecek veriyi hazır göster/kopyala/dışa aktar; HBS'ten dönen numarayı geri kaydet; "HBS'e girilmedi" iş listesi | Düşük–orta | Yüksek: unutmayı önler, çift yazımı azaltır | Düşük; gönderimi hekim yapar | **v1** |
| H2. Tarayıcı otomasyonu / portal taklidi | Orta, bakım yüksek | Orta | Yüksek: kullanım şartları, kırılganlık, e-Devlet oturumu | **Önerilmez** |
| H3. Resmî web servis (izin varsa) | Yüksek + izin süreci | En yüksek | Kimlik bilgisi/izin modeli bilinmiyor | **v2**, D9 netleşince |

### e-belge

| Seçenek | Maliyet | Klinik için değer | Risk / sorumluluk | Öneri |
|---|---|---|---|---|
| E1. Yalnız hazır veri (GİB portalına elle) | Düşük | Düşük | Düşük | Geçici yedek (entegratörü olmayan klinik) |
| **E2. Özel entegratör API'si, klinik kendi hesabıyla** (sağlayıcı soyutlaması; ilk 1 entegratör) | Orta–yüksek | Yüksek: Vetinity'den kes/iptal/PDF | Orta: kimlik bilgisi saklama, iki kez kesme, hata | **v1** |
| E3. Vetinity'nin çözüm ortaklığı (tek entegratör, onboarding/fiyat Vetinity üzerinden) | E2 + ticari iş | En yüksek sürtünmesizlik | Ticari bağımlılık, kontör yeniden satışı, destek yükü | Ticari karar (AK-1) |
| E4. GİB doğrudan / Vetinity özel entegratör olur | Çok yüksek | — | Çok yüksek, ayrı iş kolu | **Önerilmez** |

---

## 8. Kullanıcının yapması gerekenler (ajan yapamaz)

1. **Pilot/hedef klinikten bir hekimle HBS ekranlarını görmek** (e-Devlet ile giriş, e-Reçete ve ATS formlarının alanları; ekran görüntüleri — kişisel veri karartılarak). Bu, v1 "hazır veri" alanlarını kesinleştirmenin en hızlı yolu.
2. **Bakanlığa (HBS / Hayvan Sağlığı ilgili birim veya il müdürlüğü) yazılı soru:** klinik yazılımlarının HBS'e web servisle bağlanma imkânı ve izin süreci var mı (D9). Yanıt v2 kararını belirler.
3. **Bir mali müşavirle 30 dakikalık görüşme** (hukuki/vergi görüşü beklemeden ama varsayımları test etmek için): D10–D13, şahıs/şirket klinik ayrımı, Peşin (bilinmeyen) müşteriye belge.
4. **Entegratör kısa listesi ve teklif:** en az iki entegratörden (ör. Paraşüt ve eLogo/Uyumsoft) API dokümanı, **test (sandbox) hesabı**, çözüm ortaklığı koşulları ve kontör fiyatı. Test hesabı açılınca kimlik bilgileri yalnız gizli depoya (user-secrets) girer, sohbete yazılmaz.
5. Kararlar: ADR-036 "Açık kararlar" (AK-1…AK-8).

## Kaynaklar

- Tarım ve Orman Bakanlığı — HBS giriş: https://hbs.tarbil.gov.tr
- Bakanlık — Veteriner Sağlık Ürünleri (HBS sorgu bağlantıları, e-reçete talimatı bağlantısı): https://www.tarimorman.gov.tr/HAYGEM/Menu/67/Veteriner-Saglik-Urunleri
- Bakanlık — Veteriner hekimlikte e-reçete uygulamasına geçildi (2018): https://www.tarimorman.gov.tr/GKGM/Haber/175/Veteriner-Hekimlikte-E-Recete-Uygulamasina-Gecildi
- Artvin İl Md. — e-reçete ve İTS bilgilendirmesi: https://artvin.tarimorman.gov.tr/Haber/475/Veteriner-E-Recete-Ve-Ilac-Takip-Sistemi-Ile-Ilgili-Bilgilendirmeler-Tamamlandi
- Eskişehir İl Md. — sahipli hayvanların dijital kimliklendirilmesi (2022): https://eskisehir.tarimorman.gov.tr/Duyuru/675/Sahipli-Hayvanlarin-Dijital-Kimliklendirilmesi
- Kimliklendirme yönetmeliği künyesi (Lexpera): https://www.lexpera.com.tr/mevzuat/yonetmelikler/kedi-kopek-ve-gelinciklerin-kimliklendirilmesi-ve-kayit-altina-alinmasina-dair-yonetmelik-1/3
- 2024/11 Tebliğ (ATS, HBS tanımları; mülga) (Lexpera): https://www.lexpera.com.tr/mevzuat/tebligler/tz801y2024n32546s202411
- e-reçete talimatı künyesi (Lexpera): https://www.lexpera.com.tr/mevzuat/kilavuzlar/veteriner-hekim-e-recete-ve-ilac-takip-sistemi-talimati-ve-uygulama-kilavuzu-3685613
- Medyascope — 2025 yönetmelik değişikliği: https://medyascope.tv/2025/03/05/kedi-ve-kopeklerle-ilgili-yonetmelikte-degisiklik-evcil-hayvanlari-ciplendirme-suresi-yil-sonuna-kadar-uzatildi/
- FugeVet_RO (Chrome Web Store): https://chromewebstore.google.com/detail/dhoegonpbndknopkjhbojogcncpfgggm
- Sovos — e-SMM nedir: https://sovos.com/tr/blog/kdv/e-smm-nedir-kimlere-zorunlu/
- Paraşüt — e-SMM mükellefi, e-Fatura/e-Arşiv zorunluluğu, iptal, maliyet: https://www.parasut.com/blog/e-smm-mukellefi-nedir · https://www.parasut.com/blog/e-fatura-ve-e-arsiv-zorunlulugu · https://www.parasut.com/blog/e-smm-iptal-ve-duzenleme-islemleri · https://www.parasut.com/kullanim-kilavuzu/e-serbest-meslek-makbuzuna-gecmenin-maliyeti-nedir
- GİB serbest meslek kazancı rehberi (TÜRMOB arşivi): https://www.turmob.org.tr/Arsiv/FCKEditor/userfiles/file/GIB-2023-REHBERLER/2023_serbestmeslekkazancirehber.pdf
- muhasebenews — veteriner hekimlerin ilaç satışı ve vergisel durumu: https://www.muhasebenews.com/164613-2/
- BirFatura kontör fiyatları: https://birfatura.com/e-fatura-kontor-fiyatlari-e-fatura-fiyatlari/
- Faturaport (Mayıs 2026): https://faturaport.com/blog/e-fatura/2026-mayis-e-fatura-kontor-fiyatlari
- WiseCP Paraşüt eklentisi dokümanı (OAuth, sandbox): https://docs.wisecp.com/en/parasut-e-invoice-addon
- Kolayvet: https://www.kolayvet.com
