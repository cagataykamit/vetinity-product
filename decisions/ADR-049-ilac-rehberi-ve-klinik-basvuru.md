# ADR-049 — İlaç rehberi ve klinik başvuru bilgisi (E-vet DataVet karşılığı)

## Durum

**Önerildi (2026-11-15).** Kod yok. Tetikleyen: kullanıcı 2026-11-12'de pilot kliniğin E-vet verisini aktarırken E-vet'in İlaç Rehberi ve DataVet Lab ekranlarını gösterip "bizim bunları da yapmamız lazım" dedi. Kullanıcı kuralı gereği klinik pratiği sorusu sorulmadı; kapsam rakip pratiğinden ve kaynak araştırmasından türetildi. Aşağıdaki K1–K7 **öneridir**; "Açık kullanıcı kararları" bölümündeki maddeler kullanıcı onayı bekler. Backlog: [REF-001](../backlog/feature-backlog.md#ref-001--ilaç-rehberi-ve-lab-değer-işareti).

## Bağlam

### Rakipte ne var (E-vet, [competitors/e-vet.md](../competitors/e-vet.md#datavet-modül))

| Yüzey | Gözlenen | Doğrulanmayan |
|---|---|---|
| **İlaç Rehberi** | Ürün, Etken Madde ve Lisans Firması sekmeleri; ~1,8 bin ürün; ürün detayında etken madde, prospektüs bölümleri, özet, firma; ayrı "Etkileşim" ekranı | Etkileşim motoru, kaynağı, şiddet sınıfı; reçeteye bağlı uyarı gözlenmedi |
| **DataVet Lab** (Pet, Büyükbaş) | Tür seçimi; BOS, Biyokimya, Hemogram vb. parametrelerde Yok/Düşük/Normal/Yüksek seçimi; sağda "Olası Hastalıklar" listesi ve eşleşme oranı; "Karşılaştır" | Puanlama formülü, bilgi tabanının kaynağı, klinik doğrulama; hasta kaydına yazma yok |
| **Semptom ve Nekropsi** | Semptom ya da nekropsi bulgusu işaretleyince "Olası Hastalıklar" listesi | Aynı |

Kullanıcının 2026-11-15 ekran görüntüsü (DataVet Lab Pet, köpek, Biyokimya sekmesi; iki parametre "Düşük", biri "Normal" işaretli): listede tek satır "Olası Teşhis", Lab⅓ "1/13", Lab% "8%". Yüzde, o hastalığa bağlı 13 parametreden eşleşen birinin oranı gibi görünüyor (1/13 ≈ %7,7); olasılık hesabı olduğuna dair işaret yok. Tek parametrenin eşleşmesi bir hastalığı "Olası Teşhis" başlığıyla listeye çıkarıyor.

Rakip ekranları ayrı başvuru araçlarıdır: hasta kaydıyla bağı yoktur, hekim değeri elle işaretler. [Rakip analizi](../roadmap/RAKIP-ANALIZI-2026-10.md) bu alanı "Yok, öncelik düşük–orta" olarak yazmıştı.

### Vetinity'de bugün ne var (backend `main` `e0994451`, 2026-11-15 okuması)

- **Ürün kartı** (`Product`): ad, barkod, tür (`ProductKind`), narkotik sınıfı, farmasötik form, sunum, ambalaj, üretici. **Etken madde alanı yok.**
- **Reçete satırı** (`PrescriptionItem`): ad, isteğe bağlı `ProductId`, doz, birim, talimat.
- **Lab sonucu** (`LabResult`): test adı, sonuç metni, yorum, durum. **Parametre, değer, birim ve referans aralığı yapılandırılmış değil**; sonuç serbest metin. E-vet'ten gelen lab geçmişi de metin ([ADR-048](ADR-048-tam-veri-gecisi.md) T2).
- **Global katalog deseni:** `VaccineDefinition` ve `ClinicalTerm` sistem satırlarını `TenantId = null` ile tutar, seed'le gelir, kiracı salt okur ([sistem katalogları araştırması](../research/sistem-kataloglari-kaynak-arastirmasi-2026-11.md)). Aşı kataloğu hastalık düzeyindedir (ürün değil), 2026-11-12'de HBS ruhsatlı biyolojik ürün listesine göre düzeltildi.
- **AI kuralları:** AI tanı koymaz, yalnız taslak üretir, hekim onaylar ([ADR-008](ADR-008-embedded-ai-assistant.md), AI-009). AI-105 Laboratory Summary "kesin tanı veya tedavi önerisi vermez" diyor ve erteli. [AI yol haritası](../ai/ai-roadmap.md) Aşama 3 "kontrollü ayırıcı tanı", "lab yorum desteği" ve "ilaç etkileşimi"ni **yüksek riskli araştırma** olarak sayıyor (teslimat sözü yok).
- **Kullanım şartları** md. 9: Vetinity "veterinerlik … tavsiyesi vermez"; hekimlik kararı klinikte.

### Veri kaynağı araştırması (2026-11-15)

İşaretler: [O] okundu, [A] arama sonucundan, doğrulanmadı.

| # | Kaynak | Bulgu | Durum |
|---|---|---|---|
| D1 | Bakanlık "Pazarlama İzinleri" sayfası (tarimorman.gov.tr/Konular/Veteriner-Hizmetleri/Veteriner-Saglik-Urunleri/pazarlama-izinleri) | "Ruhsatlı Veteriner İlaçları" bağlantısı HBS sorgusuna gider. Veteriner sağlık ürünlerinde yetkili birim Gıda ve Kontrol Genel Müdürlüğü. | [O] |
| D2 | HBS **Ruhsatlı Veteriner İlaçları** sorgusu (hbs.tarbil.gov.tr/Receipt/SearchProduct) | 2026-11-15'te boş aramada **1.749 kayıt**. Sütunlar: Ürün Adı, Uygulama Şekilleri, Farmasötik Şekil, Terapötik Grup, ATCvet Kodu, Hedef Türler, Etkin Maddeler, **Ürün Özellikleri Özeti** (PDF bağlantısı, 1.413 satırda var), Ruhsat Sahibi. 74 ruhsat sahibi, ~369 farklı etken madde yazımı, 27 hedef tür değeri; 616 satırda hedef türde kedi ya da köpek var. Ruhsat numarası ve tarihi yok. Etken madde adları normalize değil (aynı madde farklı yazımlarla geçiyor). | [O] |
| D3 | Aynı sayfanın kullanım şartı | Kullanım ya da yeniden kullanım şartı yok. Altbilgi "© T.C. Tarım ve Orman Bakanlığı", ana site "Tüm Hakları Saklıdır". API ya da toplu indirme yok. | [O] |
| D4 | HBS **Ruhsatlı Veteriner Biyolojik Ürünler** (…/Receipt/SearchVaccine) | Aynı yapı, hastalık türü sütunu var; 2026-11-12'de 483 kayıt (önceki araştırma S15). | [O] |
| D5 | Veteriner Tıbbi Ürünler Hakkında Yönetmelik (RG 24.12.2011/28152, değişiklikler 2020 ve 2024) | Ürün Bakanlıkça onaylanmış prospektüs ve etiketle piyasaya sunulur; onaylı metin izinsiz değiştirilemez. Metnin yazarı ruhsat sahibidir. | [A] (ikincil kopyalardan) |
| D6 | FSEK 5846 md. 31 ve Ek md. 8 | Mevzuat metinleri serbest. Veri tabanını oluşturanın, tabanın önemli bir kısmının çekilmesini önleme hakkı var (Ek md. 8). Ürün Özellikleri Özeti mevzuat değildir; ruhsat sahibinin hazırladığı, Bakanlığın onayladığı belgedir. | [O] (kanun metni önceki araştırmada S35); belgelerin telif durumu **NOT VERIFIED** |
| D7 | ATCvet sınıflaması (WHO İşbirliği Merkezi, Oslo) | Tek tek ürün satırındaki kod olgudur. Tam ATCvet dizinini ad ve hiyerarşiyle ticari üründe kullanmanın şartı okunmadı. | **NOT VERIFIED** |
| D8 | Plumb's Veterinary Drugs etkileşim denetleyicisi | Ticari; API erişimi "iletişime geçin", şartlar ve fiyat açık değil; yalnız ikili etkileşim. Türkçe ve Türkiye ürün eşlemesi yok. | [A] |
| D9 | Açık lisanslı veteriner ilaç etkileşimi kaynağı | Bulunamadı. | **NOT VERIFIED** (arama sonuçsuz) |
| D10 | ASVCP referans aralığı kılavuzu (Friedrichs ve ark. 2012, Vet Clin Pathol 41(4)) | Referans aralığı her laboratuvar ve cihaz için ayrı belirlenmelidir; cihazın varsayılan aralıkları başlangıç noktasıdır. Tek bir "tür bazlı genel tablo" yanıltıcı olur. | [A] (tam metin okunmadı) |
| D11 | Lab değerinden ya da semptomdan "olası hastalık" bilgi tabanı | Kullanılabilir lisanslı Türkçe kaynak bulunmadı. MSD Veterinary Manual bütün hakları saklı, yalnız okuma kaynağı (önceki araştırma S32). Ders kitapları telifli. Kendi bilgi tabanımız klinik patoloji uzmanı yazarlığı ve doğrulaması ister. | [O] (S32) / genel kısım **NOT VERIFIED** |

Rakibin ~1,8 bin ürünlük kataloğu, D2'deki 1.749 kaydın ölçeğine yakın. Rakibin bu kaynağı kullandığı **NOT VERIFIED**; kullansa bile bu bize izin vermez. **Rakibin içeriği (ürün metinleri, hastalık bilgileri, parametre listeleri, puanlama) hiçbir biçimde alınmaz**; E-vet aktarımında (ADR-048) rehber verisi zaten yok, eklenmez.

## Kararlar (öneri)

| # | Konu | Öneri | Gerekçe |
|---|---|---|---|
| K1 | **Sıra** | (1) **İlaç rehberi**, ruhsat bilgisiyle ve ürün kartına bağlı. (2) **Lab değer işareti**: yapılandırılmış lab satırı, sonuçla gelen referans aralığına göre düşük/yüksek ve önceki sonuçlarla eğilim. (3) **Olası tanı listesi** (lab, semptom, nekropsi): **yapılmaz.** (4) **İlaç etkileşimi**: lisanslı kaynak olmadan **yapılmaz.** | (1) resmî ve açık bir kaynağa dayanır, günlük işe (reçete, stok) bağlanır. (2) bilgi tabanı gerektirmez; tanı koymaz, aritmetik karşılaştırmadır. (3) ve (4) için güvenilir, lisanslı kaynak yok (D9, D11); tanı algısı riski yüksek (K3). |
| K2 | **İlaç rehberi veri kaynağı** | Tek kaynak HBS Ruhsatlı Veteriner İlaçları (D2), gerekirse biyolojik ürünler (D4). Yalnız **olgu alanları** alınır: ürün adı, etken madde(ler), farmasötik şekil, uygulama yolu, hedef türler, ATCvet kodu, terapötik grup, ruhsat sahibi. **Ürün Özellikleri Özeti metni kopyalanmaz ve saklanmaz**; ekranda Bakanlık sayfasındaki belgeye bağlantı verilir. Toplu alımdan önce Bakanlığa (GKGM, Veteriner Sağlık Ürünleri ve Halk Sağlığı Daire Başkanlığı) yazılı izin ya da veri paylaşımı talebi gönderilir (bkz. açık karar 2). | Sayfada kullanım şartı yok ve "tüm hakları saklıdır" yazıyor (D3); bütün tabanın çekilmesi Ek md. 8'e takılabilir (D6). Belge metni ruhsat sahibinindir. Bağlantı, onaylı güncel metni gösterdiği için kopyadan daha doğrudur. |
| K3 | **Katalog modeli** | Global, salt okunur **ruhsatlı ürün kataloğu** (`TenantId` yok; mevcut `VaccineDefinition` / `ClinicalTerm` sistem satırı deseni). Etken maddeler ayrı, normalize edilmiş listede tutulur (yazım varyantları tek maddeye eşlenir, eşleme kuralı tek yerde). Her satırda kaynak ve son eşitleme tarihi. Güncelleme ayda bir karşılaştırmayla: yeni, değişen ve kaynaktan düşen ürün raporlanır; düşen ürün silinmez, "ruhsat listesinde artık yok" diye işaretlenir. | Sistem kataloğu deseni zaten var; yeni soyutlama gerekmez. Normalize etken madde arama ve eşleme için şart (D2). |
| K4 | **Mevcut modüllere bağlantı** | **Ürün kartı:** isteğe bağlı "ruhsatlı ürün" bağı; etken madde, hedef tür ve ATCvet bağdan okunur, ürün kartına kopya alan açılmaz. Bağ barkodla ya da adla önerilir, kullanıcı onaylar; bağsız ürün (hizmet, mama, ithal ürün) olduğu gibi çalışır. **Reçete ve uygulama:** satır bağlı ürüne gidiyorsa etken madde görünür; hastanın türü ruhsattaki hedef türler arasında değilse **engellemeyen bir bilgi notu** ("Bu ürün ruhsatında [tür] için kayıtlı değil") çıkar. **Rehber araması:** etken maddeye göre "stokta bu maddeyi içeren ürünler" listesi. **Aşı kataloğu:** değişmez (hastalık düzeyi kalır); biyolojik ürün ruhsatı istenirse yalnız ürün kartı bağıyla gelir. **HBS e-reçete** ([ADR-036](ADR-036-hbs-ve-e-belge-entegrasyonu.md)): HBS ürün kimliğiyle eşleşme sonraki iştir, HBS e-reçete ürün kimliklerinin bu sorguyla aynı olduğu **NOT VERIFIED**. | Bilgi tek yerde yaşar (katalog). Hedef tür notu rakipte gözlenmedi; olgu karşılaştırmasıdır, doz ya da tedavi önermez. Ruhsat dışı (kaskad) kullanım meşru olduğu için engellemez. |
| K5 | **Lab değer işareti** | `LabResult`'a isteğe bağlı **sonuç satırları**: parametre, değer, birim, referans alt ve üst sınırı (sonuç raporundan ya da cihazdan), işaret (düşük / normal / yüksek; işaret sınırlardan hesaplanır, elle seçilmez). Mevcut metin sonuç alanı kalır. Aynı hastada aynı parametrenin önceki değerleri eğilim olarak gösterilir. **Tür bazlı global referans tablosu sunulmaz**; klinik isterse kendi cihazı için varsayılan aralık tanımlar. Lab cihazı entegrasyonu (INT-001) bu satırları doldurur; E-vet geçmişi metin kalır. | Referans aralığı laboratuvara ve cihaza özgüdür (D10). İşaret sayısal karşılaştırmadır, tanı değildir. AI-105 (lab özeti) açıldığında bu yapılandırılmış veriyi kullanır. |
| K6 | **Klinik ve hukuki sınır** | Rehber ve lab işareti **bilgi** ekranıdır: tanı, doz ve tedavi önermez. Rehber ekranında kısa not: "Bilgi Bakanlık ruhsat listesinden alınmıştır, [tarih]. Esas metin ürünün onaylı Ürün Özellikleri Özeti'dir. Klinik karar hekime aittir." "Olası teşhis", "olasılık", "%" gibi ifadeler hiçbir ekranda kullanılmaz. Kullanım şartları md. 9 zaten "veterinerlik tavsiyesi vermez" diyor; yeni madde gerekmez, rehber verisinin kaynağı ve güncelliği için bir cümle eklenir. | Rakibin "Olası Hastalıklar" listesi ve eşleşme yüzdesi tanı algısı yaratır; anlamı doğrulanmadı (e-vet.md). ADR-008 ve AI-105'in "tanı koymaz" kuralıyla tutarlı. |
| K7 | **Paket** | İlaç rehberi araması, ürün kartı bağı, hedef tür notu ve lab sonuç satırları **her pakette** (Temel dahil). AI ile lab özeti AI-105 kapsamında, [ADR-044](ADR-044-ai-eklentisi-kredi-ve-fon.md) kotasıyla. | ADR-035 yönü: Temel kısılmaz, üst paketlerin değeri yeni işlerle gelir. Rehber günlük reçete ve stok işinin parçası; klinik güvenliği bilgisini pakete kilitlemek kötü görünür. Bakım maliyeti katalog eşitlemesidir, kullanım başına maliyet yoktur. |

### Yapılmayanlar ve yeniden değerlendirme koşulu

- **Olası tanı listesi (lab, semptom, nekropsi):** Şu üç koşul birlikte sağlanmadan açılmaz: (a) lisanslı ya da kendi yazdığımız, kaynağı gösterilen bilgi tabanı, (b) veteriner klinik patoloji uzmanının içerik sorumluluğu ve doğrulaması, (c) [AI yol haritası](../ai/ai-roadmap.md) Aşama 3 değerlendirme kriterleri. Nekropsi kaydı Vetinity'nin hedef kitlesinde (pet kliniği) nadirdir; backlog'a madde açılmaz, rakip notunda kalır.
- **İlaç etkileşimi:** Lisanslı kaynak (ör. ticari veteriner ilaç veritabanı) şartları ve fiyatı öğrenilip Türkiye ürünleriyle etken madde üzerinden eşlenebildiği gösterilmeden yapılmaz. Kendi etkileşim listemizi yazmak önerilmez: yanlış negatif, "uyarı yoksa güvenli" algısı yaratır.

## Değerlendirilen alternatifler

| Seçenek | Neden seçilmedi |
|---|---|
| Rakibin üç ekranını (rehber, lab, semptom) birlikte yapmak | Tanı listesi ve etkileşim için kaynak yok; kopyalama kuralına ve "özellik sayısı başarı ölçütü değildir" ilkesine aykırı. |
| Rehberi hiç yapmamak, yalnız HBS sorgusuna bağlantı vermek | En ucuz ve izin gerektirmez; ama etken madde araması, ürün kartı bağı ve reçetede tür notu olmaz. İzin gelmezse geri çekilme yolu olarak kalır (açık karar 2, seçenek C). |
| Prospektüs metnini saklayıp ekranda göstermek | Metin ruhsat sahibinindir, güncel kalmaz; bağlantı onaylı güncel belgeyi gösterir. |
| Tür bazlı global lab referans tablosu | Laboratuvara özgü aralık ilkesine aykırı (D10); kaynağı lisans gerektirir; yanlış işaret riski. |
| Lab değerinden "olası tanı"yı AI ile üretmek | ADR-008 ve AI-105 kuralına aykırı; AI Aşama 3 kapsamı. |

## Sonuçlar

- **Olumlu:** Reçete ve stokta etken madde ve hedef tür görünür; rakibin ayrı başvuru ekranı yerine iş akışına gömülü bilgi. Lab sonuçları yapılandırılır; eğilim, cihaz entegrasyonu ve AI lab özeti için zemin hazırlanır. Tanı algısı riski alınmaz.
- **Olumsuz:** Rakipteki "Olası Hastalıklar" ve "Etkileşim" ekranlarının karşılığı olmaz; satışta "DataVet bizde de var" denemez. Katalog eşitlemesi sürekli bakım ister. Bakanlık izni gecikirse rehber verisi gelmez.
- **Teknik (öneri, sözleşme backend'de yazılır):** global katalog tablosu ve etken madde tablosu (tek migration), eşitleme komutu (DbMigrator ya da yönetim komutu; HBS'e istek yalnız eşitlemede), `Product` üzerinde isteğe bağlı katalog bağı, `LabResult` sonuç satırları (ayrı migration). Yeni izinler: rehber okuma her rolde; katalog bağı mevcut `Products.Update`.
- **Ürün belgeleri:** tanıtım sitesine bu iş çalışmadan yazılmaz (ADR-034 karar 6).

## Açık kullanıcı kararları

| # | Karar | Seçenekler | Öneri |
|---|---|---|---|
| 1 | Kapsam ve sıra (K1) | A: rehber + lab işareti; tanı listesi ve etkileşim yok. B: yalnız rehber. C: rakipteki gibi üçü birden. | **A.** |
| 2 | Bakanlık verisinin alınma yolu (K2) | A: önce GKGM'ye yazılı izin ya da veri paylaşımı talebi; izin gelmeden toplu alım yok, geliştirme paralel. B: kamuya açık sorgudan olgu alanları alınır, kaynak gösterilir, talep paralel gönderilir. C: veri alınmaz, ürün kartından HBS sorgusuna bağlantı verilir. | **A.** Talep yazısını kim gönderecek: kullanıcı (Vetinity adına başvuru dışa dönük adımdır). Cevap gelmezse ne yapılacağı ayrıca kararlaştırılır. |
| 3 | Hedef tür notu (K4) | A: engellemeyen bilgi notu. B: not yok. | **A.** |
| 4 | Lab sonuç satırları (K5) | A: bu ADR ile, rehberden sonra. B: INT-001 (cihaz entegrasyonu) ile birlikte. C: yapılmaz. | **A.** Elle giriş de yapılandırılmış olur, cihaz sonradan aynı yapıyı doldurur. |
| 5 | Paket (K7) | A: her pakette. B: rehber her pakette, lab eğilimi ve hedef tür notu Profesyonel ve Kurumsal'da. | **A.** |
| 6 | Menüdeki yeri | A: ayrı menü öğesi yok; rehber global aramada, ürün kartında ve reçete satırında açılır, ayrıca Stok grubunda "İlaç rehberi" sayfası. B: Klinik grubunda ayrı öğe. | **A** (menü büyümesi sınırlı tutuluyor, Aşama 8 kararı). |
| 7 | Olası tanı listesi ve etkileşim için ileride kaynak araştırması | A: şimdi yok, yeniden değerlendirme koşulu bu ADR'de kalır. B: ticari veritabanı sağlayıcısından teklif istenir. | **A.** |

## Doğrulanmayanlar

- Ürün Özellikleri Özeti belgelerinin telif sahibi ve yeniden kullanım şartı; Bakanlığın verinin toplu kullanımına izin verip vermeyeceği.
- ATCvet dizininin ticari kullanım şartı (yalnız ürün satırındaki kod kullanılacak).
- HBS e-reçete ürün kimliklerinin bu sorgudaki ürünlerle aynı olup olmadığı.
- Yönetmelik maddeleri birincil kaynaktan (mevzuat.gov.tr) okunmadı; ikincil kopyalardan.
- ASVCP kılavuzunun tam metni okunmadı.
- Rakibin veri kaynağı ve hangi pakette sunduğu.
- Açık lisanslı veteriner etkileşim kaynağı bulunamadı; bu, olmadığı anlamına gelmez.

## İlgili belgeler

- [Rakip: E-vet DataVet, İlaç Rehberi, Nekropsi](../competitors/e-vet.md#datavet-modül)
- [Rakip analizi 2026-10](../roadmap/RAKIP-ANALIZI-2026-10.md)
- [Sistem katalogları kaynak araştırması](../research/sistem-kataloglari-kaynak-arastirmasi-2026-11.md)
- [ADR-008 Gömülü AI](ADR-008-embedded-ai-assistant.md) · [ADR-035 Paketler](ADR-035-paketler-ve-fiyat.md) · [ADR-036 HBS ve e-belge](ADR-036-hbs-ve-e-belge-entegrasyonu.md) · [ADR-044 AI kredisi](ADR-044-ai-eklentisi-kredi-ve-fon.md) · [ADR-048 Tam veri geçişi](ADR-048-tam-veri-gecisi.md)
- Backlog: [REF-001](../backlog/feature-backlog.md#ref-001--ilaç-rehberi-ve-lab-değer-işareti), [AI-105](../backlog/feature-backlog.md#ai-105--laboratory-summary), [INT-001](../backlog/feature-backlog.md)
