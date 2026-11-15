# Bakanlık yazısı: ruhsatlı ürün listesinin kullanımı (2026-11-16)

Amaç: [ADR-049](../decisions/ADR-049-ilac-rehberi-ve-klinik-basvuru.md) karar 2. HBS'deki ruhsatlı veteriner ilaç ve biyolojik ürün listesindeki olgu alanlarını ilaç rehberinde kullanmak için Bakanlığın iznini ya da koşullarını öğrenmek. İzin ya da olumlu yanıt gelmeden liste toplu alınmaz ([REF-001](../backlog/feature-backlog.md#ref-001--ilaç-rehberi-ve-lab-değer-işareti) Dilim 1).

## Gönderim

- **Muhatap:** T.C. Tarım ve Orman Bakanlığı, Gıda ve Kontrol Genel Müdürlüğü, Veteriner Sağlık Ürünleri ve Halk Sağlığı Daire Başkanlığı. Bakanlığın sayfası veteriner sağlık ürünleri işlerini bu genel müdürlüğe veriyor ([O], 2026-11-15). Daire başkanlığının adı GKGM'nin "Daire Başkanlıklarımız" sayfasının arama sonucundaki başlığından alındı [A]; sayfa açılıp okunmadı.
- **Kanal (öneri):** CİMER (cimer.gov.tr) → Bilgi Edinme, e-Devlet ile, ücretsiz, kayıtlı. Yazı soru biçiminde olduğu için bilgi edinme başvurusuna uygun. Kanundaki yanıt süresi 15 iş günü (önceki HBS yazısındaki not; DOĞRULANMADI). İkinci seçenek: Bakanlığa ya da il tarım müdürlüğüne dilekçe.
- **Gönderen:** Kullanıcı, kendi adıyla. Vetinity henüz şahıs işletmesi olarak kayıtlı değil; işletme adı ve vergi bilgisi gelince yazıya eklenebilir, beklemek gerekmez. Ad soyad, telefon ve e-posta yazının sonuna **kullanıcı tarafından** yazılır. TCKN ve adres CİMER formu zaten istediği için metne yazılmaz.
- **Ek:** gerekmez. İstenirse ilaç rehberinin nasıl görüneceğini anlatan tek sayfa sonra hazırlanır.
- [HBS ve e-belge görüşme paketi](hbs-e-belge-gorusme-paketi.md) bölüm 4'teki e-reçete yazısından ayrı gönderilir: konu ve muhtemel yanıt veren birim farklı.

## Metin

> **Konu:** HBS'de yayımlanan ruhsatlı veteriner tıbbi ürün listesinin veteriner klinik yazılımında kullanılması hakkında bilgi talebi
>
> Veteriner klinikleri için bulut tabanlı klinik yönetim yazılımı (Vetinity) geliştirmekteyim. Yazılımda hekimlerin reçete yazarken ve stok kartı oluştururken ürünün ruhsat bilgisini doğru görmesini sağlayan bir "ilaç rehberi" bölümü hazırlıyoruz.
>
> Bu bölümde, Bakanlığınızın Hayvan Bilgi Sistemi üzerinden kamuya açık olarak yayımladığı "Ruhsatlı Veteriner İlaçları" ve "Ruhsatlı Veteriner Biyolojik Ürünler" sorgu sayfalarındaki aşağıdaki bilgileri kullanmak istiyoruz:
>
> - ürün adı,
> - etkin madde(ler),
> - farmasötik şekil ve uygulama şekli,
> - hedef türler,
> - ATCvet kodu ve terapötik grup,
> - ruhsat sahibi firma.
>
> Kullanım şekli:
>
> - Bilgiler değiştirilmeden, kaynağı ("T.C. Tarım ve Orman Bakanlığı, HBS ruhsatlı ürün listesi") ve son güncelleme tarihiyle gösterilecektir.
> - Ürün Özellikleri Özeti belgelerinin metni kopyalanmayacak ve saklanmayacak; kullanıcı, belgeyi görmek için Bakanlığınızın sayfasına yönlendirilecektir.
> - Liste ayda bir Bakanlığınızın sayfasıyla karşılaştırılarak güncellenecek; listeden çıkan ürünler "ruhsat listesinde artık yok" olarak işaretlenecektir.
> - Bilgiler yalnız yazılımı kullanan veteriner klinikleri için gösterilecek, ayrıca satılmayacak ve üçüncü kişilere veri olarak verilmeyecektir.
> - Yazılım tanı, doz ya da tedavi önerisi vermeyecek; klinik karar hekime aittir.
>
> Bu çerçevede:
>
> 1. Söz konusu bilgilerin yukarıdaki şekilde kullanılmasında Bakanlığınızca bir sakınca var mıdır? Uyulması gereken koşullar (kaynak gösterimi, güncelleme sıklığı, izin ya da protokol) nelerdir?
> 2. Bu listenin toplu ya da makine tarafından okunabilir bir sürümü (Excel, CSV, web servisi vb.) bulunmakta mıdır? Varsa yazılım firmalarının erişimi için hangi başvuru yapılmalıdır?
> 3. Ürün Özellikleri Özeti belgelerine, Bakanlığınızın sayfasındaki adresleriyle bağlantı verilmesinde bir sakınca var mıdır?
> 4. Bu konuda başvurulması gereken farklı bir birim varsa yönlendirmenizi rica ederim.
>
> Bilgilerinize arz ederim.
>
> [Ad Soyad] · [Telefon] · [E-posta] · [Tarih]

## Yanıt gelince

Yanıtı tarih ve kanal bilgisiyle bu belgenin altına ekleyin (kişisel veri olmadan). Sonra:

- **İzin ya da "sakınca yok":** ADR-049 karar 2'ye not düşülür, REF-001 Dilim 1'in veri alımı açılır; yanıttaki koşullar (kaynak gösterimi, sıklık) kabul kriterine yazılır.
- **Toplu veri ya da servis var:** sayfa taraması yerine o kaynak kullanılır.
- **Ret ya da koşul kabul edilemez:** ADR-049 açık karar 2'nin C seçeneğine (yalnız HBS sorgusuna bağlantı) dönülür; kullanıcıya sorulur.
- **Yanıt gelmezse:** süre dolunca hatırlatma ya da dilekçe; ne yapılacağı kullanıcıya sorulur.

| Tarih | Kanal | Durum |
|---|---|---|
| — | — | Gönderilmedi |
