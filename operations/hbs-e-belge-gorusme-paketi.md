# HBS ve e-belge görüşme paketi — 2026-10-24

Amaç: [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md) ve [keşif](../research/hbs-ve-e-belge-kesfi-2026-10.md) içindeki **DOĞRULANMADI** maddelerini dört görüşmeyle kapatmak. Bu paket hukuki veya vergi tavsiyesi değildir; yanıtlar gelince keşif tablosu (D3–D16) güncellenir. Kişisel veri, parola ve ekran görüntüsündeki hasta bilgisi bu belgeye yazılmaz.

Sıra önerisi: (1) hekim, (2) mali müşavir, (3) entegratör, (4) Bakanlık. Bakanlık yanıtı en yavaş olandır, yazıyı en başta gönderin.

---

## 0. Otomatik e-reçete: bugünkü bilgi

- **Resmî web servis/API kanıtı yok.** HBS e-reçete (`hbsapp.tarim.gov.tr`) Bakanlığın HAYBİS modülü; yazılım firmalarına açık bir entegrasyon dokümanı bulunamadı. Bu, yokluğunun kanıtı değildir (D9).
- **Piyasa nasıl yapıyor:** Kolayvet "Tarbil entegrasyonu"nu bir **Chrome eklentisi** olarak sunuyor: klinik yazılımındaki işlem, HBS ekranında hazır doldurulmuş görev olarak çıkıyor (müşteri adı, telefon, TC, çip, doğum tarihi). Kullanıcı e-Devlet ile kendi girer. Gönderimin kullanıcı onayı olmadan yapılıp yapılmadığı sayfada yazmıyor. FugeVet de eklentiyle çalışıyor. Yani rakipler "tam otomatik" değil, **form doldurma yardımcısı** sunuyor (Kolayvet sayfası pazarlama dilidir, bağımsız doğrulanmadı).
- **e-Reçete resmî kılavuzda (Talimat ve Uygulama Kılavuzu, 12.12.2018):** kedi, köpek ve atlar kapsamda. Sistemde kaydı olmayan hayvan için önce "Tanımsız Hayvan" kaydı açılıyor (sahip TCKN/VKN ile aranır; tür, çip no zorunlu değil, doğum tarihi, cinsiyet, ırk, eşgal) ve sistem hayvan numarası üretiyor. Bu, D3'ü büyük ölçüde kapatır (kılavuz tam metni TEİS arşivinde PDF; kısmen okundu). İmza yöntemi (e-imza mı, e-Devlet şifresi mi) **DOĞRULANMADI**.

**Seçenekler (otomasyon derecesi artan sırayla):**

| # | Yol | Durum | Not |
|---|---|---|---|
| A | Manuel yardımcı (yapıldı, ADR-036 Dilim 2) | Üründe var | Hazır veri, kopyala, geri kayıt |
| B | **Form doldurma eklentisi** (Kolayvet tarzı): hekim HBS'e kendi girer, eklenti alanları doldurur, gönder düğmesine hekim basar | Önerilmedi (keşif 2.2) ama piyasada yaygın | Bakanlık izni gerekmez; portal değişince kırılır; kullanım şartları riski hukuki görüş konusu |
| C | **Resmî web servis** (Bakanlık yetkilendirmesiyle) | Bilinmiyor | Bakanlığa yazı (bölüm 4) yanıtına bağlı |

Önerim: C'nin yanıtını bekleyin; yanıt gelene kadar A ile ilerleyin. Satış baskısı çıkarsa B ayrı ADR ile ve "hekim onaylar" kuralıyla düşünülür.

---

## 1. Hekim görüşmesi (30–45 dk, ekran paylaşımlı)

Hekim kendi e-Devlet'iyle HBS'e girer; hasta bilgisi görünmeyecek şekilde ekran görüntüsü alınır.

1. e-Reçete'de kedi/köpek tedavisinde reçete **gerçekten** yazılıyor mu? Hangi ilaç grupları (ruhsatlı veteriner ilaç, beşeri, majistral)? Yazılmayanlar kâğıt mı?
2. Reçete ekranındaki **tüm alanlar** (hayvan, ilaç seçimi, doz, miktar, süre, teşhis). Hangileri zorunlu?
3. İmza: e-imza mı kullanılıyor, e-Devlet girişi yeterli mi?
4. "Tanımsız Hayvan" ne sıklıkla açılıyor? Çipli hayvanda HBS kimlik no nereden geliyor?
5. ATS aşı kaydı: hangi aşılar (kuduz dışında?), kaç gün içinde, hangi alanlar (seri no, belge no).
6. Kimliklendirme (çip) yetkisi hekimde var mı, protokolle mi?
7. Günde ortalama kaç reçete/aşı kaydı; HBS'e girmek ne kadar zamanını alıyor? En çok neresi can sıkıyor?
8. Mevcut yazılımı HBS'e bir şey gönderiyor mu (eklenti dahil)?
9. Vetinity'deki HBS yardımcısı diyalogunu açıp alanları **gerçek ekranla** karşılaştırın (eksik/fazla alan).

## 2. Mali müşavir görüşmesi (30 dk)

1. Tek hekimli, şahıs klinik: hizmet için e-SMM yeterli mi? Muayene ücretine dahil ilaç/ürün ne olur?
2. Ayrı mama/aksesuar/ilaç satışı: fatura (e-Arşiv) mı? Aynı klinikte iki belge türü nasıl yönetilir?
3. Şirket (Ltd./A.Ş.) kliniği: hizmet ve ürün için hep fatura mı?
4. Alıcı bireysel ve kimlik vermek istemiyor: hangi alıcı bilgisiyle belge kesilir?
5. 2026 e-Arşiv/e-Fatura geçiş eşikleri ve kâğıt istisnası (kaynaklar çelişkili; hangisi güncel?).
6. İptal/düzeltme süresi (7 mi 8 gün mü?), iptalde ne yapılır.
7. KDV oranı: muayene, aşı, ilaç, mama için oranlar; stopaj ne zaman gösterilir?
8. POS tahsilatından sonra e-SMM sırası.
9. Entegratör kullanılırsa mükellefin yükümlülükleri (mali mühür, İVD kodu).

Vetinity'nin kendi kuruluşu (yazılım işletmesi olarak; **karar 2026-11-09: şahıs işletmesi**):

10. Şahıs işletmesi vergi kaydı ilk ücretli müşteriden ne kadar önce yapılmalı; faaliyet kodu (yazılım/SaaS) ne olmalı?
11. Bağ-Kur/SGK: şu an SGK'lı değilim; işletme kurulunca Bağ-Kur (4/b) zorunluluğu, aylık prim tutarı ve başlangıç tarihi; istisna veya teşvik (genç girişimci vb.) var mı?
12. İş yeri adresi olarak ev adresi: vergi kaydı ve fatura adresi için yeterli mi, sanal ofis gerekir mi?
13. Sorumluluk sigortası: yazılım hatası veya veri kaybına karşı mesleki sorumluluk (ve siber) sigortası gerekli mi, tipik kapsam ve maliyet?

Vetinity'nin kendi abonelik faturası (2026-11-08 eklendi; klinik e-belge işinden ayrı):

14. Kliniklere abonelik satışında hangi belge: e-Arşiv fatura mı, alıcı e-Fatura mükellefiyse e-Fatura mı? Şahıs işletmesi olarak e-Arşiv/e-Fatura'ya en baştan mı geçilir, kâğıt fatura dönemi olur mu?
15. Yazılım aboneliğinde KDV oranı (%20 varsayımı) ve stopaj gerekip gerekmediği.
16. Yıllık peşin ödemede fatura bir kerede mi, aylık mı kesilir? Ödemesiz deneme ve indirim kodu faturaya nasıl yansır?
17. Ödeme aracısı (iyzico) komisyonu için ayrıca belge gerekir mi; muhasebede nasıl gösterilir?
18. Kontrol sorusu: klinik yazılımının aracı firma (özel entegratör) olmadan GİB'e otomatik belge gönderebileceği bir yol var mı? (Bizim varsayımımız: yok; tek gerçekçi yol entegratör API'si.)

## 3. Entegratör API ve test hesabı başvurusu

**Bu bir fiyat teklifi değildir (kullanıcı, 2026-11-10).** ADR-036 AK-1 modelinde klinik entegratörle kendi sözleşmesini yapar, kontörü kendisi öder; Vetinity entegratöre ödeme yapmaz. Vetinity'nin istediği: **API dokümanı** (bağlantı kodunu bir kez yazmak için) ve **test (sandbox) hesabı** (gerçek belge kesmeden denemek için; genelde ücretsiz, DOĞRULANMADI). Bazı firmalar yazılım firmasından ücretsiz "yazılım/entegrasyon ortağı" kaydı isteyebilir (DOĞRULANMADI). Fiyat yalnız bilgi amaçlı sorulur: kliniğe yaklaşık maliyeti söylemek ve ileride "pakete dahil belge" seçeneğini (AK-1/AK-6, açık) değerlendirmek için.

**Başvurulacak firmalar (2026-11-10):** Paraşüt (API dokümanı en erişilebilir), BirFatura (API odaklı), UyumSoft (rakip E-vet'in seçeneklerinden), Nilvera, NES, Sovos ve **pilot kliniğin bugün kullandığı entegratör**. İlk desteklenecek firma şu sırayla seçilir: **e-SMM'nin API'den kesilebilmesi (eleme şartı**, her entegratör vermeyebilir, DOĞRULANMADI), pilot kliniğin ve kliniklerin yaygın kullandığı firma, doküman ve test hesabının hızı.

Gönderilecek metin (kısa):

> Veteriner klinik yönetim yazılımı (Vetinity) geliştiriyorum (şahıs işletmesi olarak; vergi kaydı tamamlanıyor). Müşteri kliniklerimin sizde **kendi hesaplarını açıp** e-SMM, e-Arşiv ve e-Fatura belgelerini Vetinity içinden, sizin API'niz üzerinden kesmesini planlıyoruz. Yazılım firması olarak entegrasyon geliştirmek için şunları rica ediyorum:
> 1. e-SMM, e-Arşiv ve e-Fatura için API dokümanı: belge oluşturma, iptal, durum sorgulama, PDF alma, e-Fatura mükellefi sorgusu. e-SMM aynı API'den kesilebiliyor mu?
> 2. Geliştirme için test (sandbox) hesabı; başvuru süreci ve bir ücreti var mı?
> 3. Yazılım firmaları için entegrasyon/yazılım ortağı programınız var mı, şartları nedir?
> 4. Kimlik doğrulama: kliniğin kendi hesabını yazılımımıza nasıl bağlarız (API anahtarı, OAuth, kullanıcı adı/şifre)? Sizde zaten hesabı olan klinik aynı hesabı kullanabilir mi?
> 5. Aynı belgenin iki kez gönderilmesini önleyen destek (idempotency), durum bildirimi (webhook), hız sınırları.
> 6. Bilgi amaçlı: kliniğin ödeyeceği kontör birim fiyatı ve yıllık/arşiv ücreti.
> 7. Vetinity'nin kendi abonelik faturalarını kesmek için sizde hesap açabilir miyim?

Not: Kontörün pakete dahil edilmesi (çözüm ortaklığı, E3) şimdilik sorulmaz; ADR-036 AK-1/AK-6 açık kararı, pilot kliniğin aylık belge sayısı ve kullanıcı kararıyla ayrıca açılır. Yanıtlar bu belgenin altına (tarih, firma, kişisel veri olmadan) işlenir.

**Rakip gözlemi (2026-11-08, [e-vet.md](../competitors/e-vet.md#ayarlar--e-fatura-bilgileri-2026-11-08)):** E-vet SMART ayarlarında entegratör seçimi **Altair** ve **UyumSoft**; klinik o firmadaki kendi kullanıcı adı/şifresini giriyor (ADR-036 AK-1 ile aynı model). Pilot kliniğin bugün kullandığı firma da sorulur (klinik zaten bir entegratörde hesaplıysa o firmayı desteklemek geçişi kolaylaştırır).

Karşılaştırma tablosu: e-SMM API'si, doküman kalitesi, test hesabı hızı, ortaklık şartı, kliniğe kontör fiyatı, destek. Test hesabı kimlik bilgileri yalnız user-secrets'a girer.

**Ön tarama (2026-11-10, web araması; resmî yanıt değil, DOĞRULANMADI):**

| Firma | Herkese açık API dokümanı | e-SMM API'si | Test ortamı | Başvuru kanalı |
|---|---|---|---|---|
| Nilvera | Var: `developer.nilvera.com` | Dokümanda "e-SMM API" bölümü var | Ayrı test ortamı (`apitest.nilvera.com`), ayrı API anahtarı; OAuth 2.0 / API anahtarı | Test hesabı kaydı kullanıcıda; doküman başvurusuz okunabiliyor |
| BirFatura | Talep üzerine | Belge türleri arasında e-SMM listeleniyor; API'de e-SMM görülmedi | Sitede "test ortamı ücretsiz" deniyor | Entegrasyon e-posta adresi sitede; adres sitede doğrulanarak yazılmalı. API e-ticaret sipariş çekme modeline yakın görünüyor, bizim modele uyumu sorulmalı |
| Paraşüt | Aramada resmî geliştirici portalı bulunamadı (önceki oturumda `apidocs.parasut.com` açılamadı) | Üçüncü taraf kaynağa göre var | Destek ekibinden (üçüncü taraf kaynak) | Destek / iletişim formu |
| Sovos | e-Fatura API dokümanı `api.fitbulut.com` altında | Bulunamadı | Bulunamadı | Kurumsal iletişim formu (sovos.com/tr) |
| UyumSoft | Bulunamadı | e-SMM özel entegratörü | Bulunamadı | İletişim formu (uyumsoft.com) |
| NES | Bulunamadı | Bulunamadı | Bulunamadı | İletişim formu |

Sonuç: **Nilvera** başvuru beklemeden doküman okunabilen ve e-SMM API'si görünen tek aday; ilk teknik inceleme oradan başlayabilir. Diğerlerine yukarıdaki metin gönderilir.

## 4. Bakanlık yazısı taslağı (HBS / ilgili genel müdürlük veya il müdürlüğü)

**Muhatap ve kanal (DOĞRULANMADI; öneri):** T.C. Tarım ve Orman Bakanlığı. e-Reçete duyuru ve talimatı **Gıda ve Kontrol Genel Müdürlüğü (GKGM)** sayfalarında, veteriner sağlık ürünleri sayfası **Hayvan Sağlığı ve Yetiştiriciliği Genel Müdürlüğü (HAYGEM)** altında; HAYBİS modülünü Tarım Reformu Genel Müdürlüğü koordine etmiş (2018 haberi). Hangisinin yanıtlayacağı belirsiz olduğundan başvuru "Tarım ve Orman Bakanlığı"na yapılır, metinde HBS e-Reçete/ATS birimi istenir. Kanal: **CİMER (cimer.gov.tr) → Bilgi Edinme (4982 sayılı Kanun)**, e-Devlet ile, ücretsiz; başvuru kayıtlı, yanıt süresi kanunda 15 iş günü (uzatma +15, DOĞRULANMADI). Kendi il tarım müdürlüğüne dilekçe ikinci seçenek.

> Konu: Veteriner klinik yazılımlarının HBS e-Reçete ve ATS ile entegrasyonu hakkında bilgi talebi
>
> Veteriner hekimler için klinik yönetim yazılımı geliştirmekteyim (şahsım adına; henüz şirketleşme yapılmamıştır). Serbest veteriner hekimlerin kullanıcı oldukları HBS e-Reçete ve Aşı Takip Sistemi (ATS) kayıtlarının, hekimin kendi yetkisi ve onayıyla klinik yazılımından iletilebilmesi için:
> 1. Üçüncü taraf yazılımlar için resmî bir web servis/API veya entegrasyon dokümanı bulunmakta mıdır?
> 2. Varsa yazılım firması olarak hangi başvuru, izin ve güvenlik koşulları aranmaktadır?
> 3. Yoksa planlanan bir entegrasyon çalışması var mıdır; yazılımların tarayıcı üzerinden hekim adına form doldurması Bakanlığın kullanım şartlarına uygun mudur?
> 4. Kedi, köpek ve at için e-Reçete'de yazılım tarafının sağlaması gereken veri alanları nelerdir?
>
> Bilgi ve yönlendirmenizi rica ederim. (Ad soyad, iletişim e-postası ve telefon — **kullanıcı doldurur**. Firma adı yok; gerçek kişi olarak gönderilir. TCKN, adres gibi bilgiler yazının kendisinde istenmedikçe yazılmaz.)

Şahıs adıyla gönderimin sonucu: Bakanlık yetkilendirmeyi veya dokümanı firmaya (tüzel kişi/vergi mükellefi) vereceğini söylerse bu, yanıtta yazar; şirketleşme ya da şahıs işletmesi kurma kararı o zaman netleşir. Yazıdaki "yazılımların tarayıcı üzerinden form doldurması uygun mu" sorusu yazıda kalsın, yanıt B seçeneğini belirler.

Gönderim kanalı ve imza kullanıcıdadır; yanıtı keşif belgesine D9 olarak işleyin.

---

## Yanıtlar gelince
Yanıtları bu belgenin altına (tarih + kaynak, kişisel veri olmadan) ekleyin; ajan keşif tablosunu ve ADR-036 açık kararlarını (AK-1…AK-8) günceller.

### Entegratör başvuruları

| Tarih | Firma | Kanal | Durum |
|---|---|---|---|
| 2026-11-10 | Nilvera | Destek e-postası | Gönderildi (kullanıcı), yanıt bekleniyor |
| 2026-11-10 | BirFatura | Entegrasyon e-postası | Gönderildi (kullanıcı), yanıt bekleniyor |
| 2026-11-10 | Paraşüt | İletişim kanalı | **Yanıt geldi (2026-11-10):** API bilgileri `devhub.parasut.com` → "API Başvurusu Yap" ile alınır; Paraşüt kullanıcısı "Paraşüt ile Giriş Yap", ardından "Paraşüt Kullanıcı Başvuru Formu"ndaki zorunlu alanlar → API bilgileri (istemci kimliği/sırrı). Kullanıcı eylemi: Paraşüt hesabı ve başvuru; geliştirme için Staging ortamı (staging hesabı 6 ayda silinir, devhub). Başvuruda istenen yönlendirme adresi (redirect URL, OAuth dönüşü): **en çok 3 adres, sonradan değiştirilemez** (değişiklik = yeni başvuru; Paraşüt formu, kullanıcı aktarımı 2026-11-10). Kalıcı olduğu için yol **sürüm içermez** ve ADR-033 düzeninin üç ortamına verilir: `https://localhost:7173/api/e-documents/parasut/callback` (yerel), `https://api-staging.vetinity.com/api/e-documents/parasut/callback`, `https://api.vetinity.com/api/e-documents/parasut/callback`. **Dilim 3b'de Paraşüt dönüş ucu tam bu yolla yazılır** (`api/v1` altında değil). Paraşüt test (staging) ve canlı başvurularının ayrı olup olmadığı DOĞRULANMADI. **e-SMM API'si teyit edildi (2026-11-11, resmî OpenAPI `devhub.parasut.com/openapi.json`: `POST /{şirket}/e_smms`; eleme şartı karşılanıyor).** **2026-11-11:** kullanıcı staging hesabını açtı (`uygulama-staging.parasut.com`), API başvurusu onaylandı; istemci kimliği ve sırrı geliştirici makinesinde API projesinin user-secrets deposunda: `EDocuments:Parasut:ClientId`, `EDocuments:Parasut:ClientSecret` (değerler hiçbir belgeye yazılmaz). Dilim 3b bu anahtar adlarını okur; canlı değerler ayrı alınır ve `api.env`e kullanıcı girer |
| 2026-11-10 | UyumSoft | İletişim / iş ortaklığı kanalı | Gönderildi (kullanıcı), yanıt bekleniyor |
| 2026-11-10 | NES | İş ortaklığı e-postası | **Yanıt geldi (2026-11-12, kullanıcı aktarımı):** e-Fatura, e-Arşiv, e-İrsaliye tek API; e-SMM aynı API içinde (dokümanla DOĞRULANMADI). Test ortamı ücretsiz, başvuru e-postayla. Yazılım ortağı programı: yıllık sabit ücret yok, kontör üzerinden gelir paylaşımı (katalog ekte). Bağlantı: her klinik kendi NES hesabını açar ve API anahtarı (token) verir; OAuth yok; mevcut NES hesabı kullanılabilir. Çift gönderim koruması yok, belge başına benzersiz UUID bizden; webhook yok, durum sorgulanır; sınır dakikada 60 istek. Kontör fiyatı için proje bilgisi istendi (site adresi, aktif müşteri sayısı, hedef). Kendi abonelik faturalarımız için NES hesabı açılabilir. Ekler (API dokümanı, katalog) henüz bize ulaşmadı |
| 2026-11-10 | Sovos (Digital Planet) | İş ortağı e-postası | Gönderildi (kullanıcı), yanıt bekleniyor |
