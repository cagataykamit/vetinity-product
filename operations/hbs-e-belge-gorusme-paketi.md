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

## 3. Entegratör teklif isteği (en az iki firma)

Gönderilecek metin (kısa):

> Veteriner klinik yönetim yazılımı (Vetinity) geliştiriyoruz. Kliniklerimizin kendi mükellef hesaplarıyla e-SMM, e-Arşiv ve e-Fatura keserken sizin API'nizi kullanmasını planlıyoruz. Şunları öğrenmek istiyoruz:
> 1. e-SMM, e-Arşiv ve e-Fatura için API dokümanı; belge oluşturma, iptal, durum sorgulama, PDF alma, e-Fatura mükellefi sorgusu.
> 2. Test (sandbox) hesabı ve kimlik bilgisi verme süreci.
> 3. Kimlik doğrulama modeli: her klinik kendi hesabıyla mı, bizim adımıza tek anlaşma mı (çözüm ortaklığı/bayilik koşulları)?
> 4. Fiyat: kontör birim fiyatı, kurulum/yıllık ücret, arşiv ücreti, çok kiracılı kullanımda indirim.
> 5. Aynı belgeyi iki kez göndermeyi önleyen idempotency desteği, webhook/durum bildirimi, hız sınırları.
> 6. Belge saklama süresi ve veri çıkışı.

Karşılaştırma tablosu: API kalitesi, sandbox hızı, fiyat, bayilik koşulu, destek. Test hesabı kimlik bilgileri yalnız user-secrets'a girer.

## 4. Bakanlık yazısı taslağı (HBS / ilgili genel müdürlük veya il müdürlüğü)

> Konu: Veteriner klinik yazılımlarının HBS e-Reçete ve ATS ile entegrasyonu hakkında bilgi talebi
>
> Veteriner hekimler için klinik yönetim yazılımı geliştirmekteyiz. Serbest veteriner hekimlerin kullanıcı oldukları HBS e-Reçete ve Aşı Takip Sistemi (ATS) kayıtlarının, hekimin kendi yetkisi ve onayıyla klinik yazılımından iletilebilmesi için:
> 1. Üçüncü taraf yazılımlar için resmî bir web servis/API veya entegrasyon dokümanı bulunmakta mıdır?
> 2. Varsa yazılım firması olarak hangi başvuru, izin ve güvenlik koşulları aranmaktadır?
> 3. Yoksa planlanan bir entegrasyon çalışması var mıdır; yazılımların tarayıcı üzerinden hekim adına form doldurması Bakanlığın kullanım şartlarına uygun mudur?
> 4. Kedi, köpek ve at için e-Reçete'de yazılım tarafının sağlaması gereken veri alanları nelerdir?
>
> Bilgi ve yönlendirmenizi rica ederiz. (Firma adı, yetkili, iletişim — **kullanıcı doldurur**.)

Gönderim kanalı ve imza kullanıcıdadır; yanıtı keşif belgesine D9 olarak işleyin.

---

## Yanıtlar gelince
Yanıtları bu belgenin altına (tarih + kaynak, kişisel veri olmadan) ekleyin; ajan keşif tablosunu ve ADR-036 açık kararlarını (AK-1…AK-8) günceller.
