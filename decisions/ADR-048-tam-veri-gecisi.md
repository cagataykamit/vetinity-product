# ADR-048 — Tam veri geçişi: içe aktarma kapsamının genişletilmesi

## Durum

**Kabul edildi (2026-11-10).** Kullanıcı: "Tüm geçişleri eksiksiz hazırla, ona başla." Kullanıcı kuralı gereği klinik pratiği sorusu sorulmadı; kapsam rakip pratiğinden türetildi. [ADR-019](ADR-019-data-import.md) (K1–K13) aynen geçerli; bu ADR onun kapsamını genişletir ve K7 (geri alma) kuralını yeni kayıt türleri için yeniden yazar. [ADR-014](ADR-014-pilot-and-production-operations.md) K8'in "muayene ve ödeme ilk sürümde yok" sınırı kalkar. Tetikleyen: [ADR-034](ADR-034-tanitim-sitesi-konumlandirma.md) 2026-11-10 eki (hedef kitle her ölçekte klinik); eski ve büyük programdan gelen klinik, muayene ve hesap geçmişini bırakmaz.

Teknik sözleşme backend `docs/IMPORT_API_CONTRACT.md` (bölüm 12, "Tam geçiş"); bu belge yalnız kararı ve gerekçeyi tutar.

## Bağlam

- Bugün yalnız müşteri, hasta ve uygulanmış aşı aktarılıyor. Pilot için tasarlanan kapsam kâğıt ya da Excel kullanan küçük kliniğe göreydi.
- Rakip pratiği (araştırma 2026-11-10, kaynaklar aşağıda):
  1. Müşteri, hasta, aşı, hatırlatma ve **gelecek randevular** neredeyse her üründe taşınıyor (Covetrus Pulse, Digitail, Shepherd, ezyVet).
  2. **Ödeme ve tahsilat geçmişini canlı işlem olarak alan ürün yok.** Borç, açılış ya da yaşlandırılmış bakiye olarak geliyor (Pulse: "yalnız yaşlandırılmış bakiye"; Digitail: "credit, outstanding balance"; IDEXX Neo: A/R bakiyesini klinik elle giriyor; ezyVet: ödenmemiş faturalar ayrıca ekleniyor).
  3. Klinik geçmişte tarih, hekim ve tanı alanlara ayrılıyor; tetkik, tedavi ve fiyat ayrıntısı **metin** olarak taşınıyor (Digitail). Yapılandırılmış reçete ve laboratuvarı tam taşıyan yalnız ezyVet.
  4. Ürün ve hizmet kartları taşınıyor; stok miktarı çoğunlukla sayımla yeniden giriliyor (yalnız Pulse açıkça taşıyor).
  5. Belgeler ve görüntüler, satıcı ekibinin yaptığı dönüşümde dosya olarak ekleniyor; kliniğin kendi yaptığı Excel geçişinde yok.
  6. Türkiye'de kapsamı açıkça yazan rakip yok. Kolayvet "hasta, müşteri, ürün ve stok" aktarıyor ve uygun yazılımdan ücretsiz taşıma yapıyor; kalem listesi vermiyor. Kapsamı açıkça yazmak ayrışma fırsatı.
- Vetinity'ye özgü kısıtlar:
  - Kayıt defterleri yasal kayıttır ([ADR-015](ADR-015-batch-based-stock-and-registers.md)): muayene, reçete, ilaç ve narkotik defteri muayene, reçete ve stok kayıtlarından türer. Eski dönemin kayıtları eski programın defterindedir.
  - Gün sonu, kasa sayımı, ciro raporu ve e-belge ([ADR-036](ADR-036-hbs-ve-e-belge-entegrasyonu.md)) ücret ve ödeme kayıtlarından türer.
  - Alacak (fazla ödeme) kaydı bugün yalnız bir ödemeden doğar.

## Kararlar

| # | Kalem | Karar | Nasıl ve neden |
|---|---|---|---|
| T1 | Muayene, klinik notlar, tanı, tedavi | **Alınır** | Yeni tablo **Klinik geçmiş**. Her satır, hastaya bağlı salt okunur bir "eski program kaydı" olur. Alanlar: tarih, kayıt türü, şikâyet, anamnez, bulgular, tanı, tedavi, reçete, laboratuvar sonucu, not, hekim adı, kilo ve ateş. Bu kayıtlar `Examination` tablosuna **yazılmaz**. Böylece muayene defterine, kesinleştirme ve ek not akışına, ücret önerisine, sahip portalına ve muayene raporlarına girmez. Hasta ekranında ve zaman çizelgesinde "Eski program" etiketiyle görünür. |
| T2 | Reçete ve laboratuvar | **Metin olarak alınır** | Klinik geçmiş satırında `Recete` ve `LabSonuc` metin alanlarıdır. Yapılandırılmış reçete satırı (ürün eşleme, stok düşümü, reçete ve narkotik defteri) ile lab sonuç kaydı **oluşmaz**. Eski dönem reçetesi Vetinity defterine girerse yasal kayıt yanlış olur. Rakiplerin çoğu da metin taşıyor. |
| T3 | Açık bakiye (devir borcu) | **Alınır** | Müşteri tablosunda isteğe bağlı `AcikBakiye` sütunu bulunur. Pozitif tutar, yeni oluşan her müşteri için tek bir **devir ücreti** açar ("Devir bakiyesi (eski program)"). Ücret içe aktarma işaretlidir (`ImportBatchId`). Bakiyeye, borç raporuna ve sahip portalındaki bakiyeye girer; normal tahsilatla kapanır. **Ciroya, gün sonuna ve e-belge akışına girmez**: eski dönemin faturası eski programda kesildi. Negatif (alacak) tutar, yeni oluşan müşteriye tek bir **devir alacağı** açar ("Devir alacağı (eski program)"). Devir alacağı mevcut müşteri kredisinin (FIN-005) yeni bir kaynağıdır: kaynak ödemesi yoktur, içe aktarma işaretlidir (`ImportBatchId`). Müşteri bakiyesinde ve sahip portalında kredi olarak görünür. Sonraki ücretlere mevcut mahsup akışıyla uygulanır, kalanı mevcut iade akışıyla geri verilir. Oluşması **ciroya, gün sonuna, kasaya, kasa sayımına ve e-belgeye girmez**: ödeme yazılmaz, eski dönemin tahsilatı eski programdadır. Kalanın nakit iadesi gerçek bir kasa çıkışıdır ve diğer kredi iadeleri gibi gün sonunda görünür. Borç raporu yalnız borçluları listeler; devir alacağı, diğer krediler gibi orada yer almaz. Sahte ödeme yazılmaz, çünkü aktarım gününün kasasını, cirosunu ve gün sonunu bozar. Mevcut müşteriyle eşleşen satırın bakiyesi eklenmez; mevcut veri ezilmez (ADR-019 K4). |
| T4 | Ücret ve tahsilat geçmişi | **Salt okunur geçmiş olarak alınır** | Yeni tablo **Hesap hareketleri**. Satırlar (tarih, borç ya da tahsilat, tutar, açıklama, ödeme şekli, belge no) müşteriye bağlı salt okunur kayıtlardır. Müşterinin hesap ekranında "Eski program hareketleri" olarak görünür. Bakiyeyi, kasayı, gün sonunu, raporları ve e-belgeyi **etkilemez**. Bakiyenin tek kaynağı T3'tür. Hiçbir rakip tahsilat geçmişini canlı işlem olarak almıyor; ödeme olarak yazmak kasa sayımını ve tahsisleri bozar. |
| T5 | Randevular | **Yalnız gelecek randevular alınır** | Yeni tablo **Randevular**. Bugünden sonraki randevu, partinin kliniğinde ve planlı durumda gerçek randevu olur. Hekim adı bir kullanıcıyla eşleşirse atanır, eşleşmezse randevu notuna düşer. Saat çakışması engel değildir; eski program zaten planlamıştı. Geçmiş randevular atlanır ve raporda bilgi olarak görünür: gerçekleşen ziyaret klinik geçmişte zaten var (E-vet görevleri istisnadır: Sonuçlar, 2026-11-12 eki). **Randevu hatırlatması**, aşıdaki gibi (ADR-019 K3) yönetici "hatırlatmaları aç" diyene kadar gitmez. |
| T6 | Hatırlatmalar | **Ayrı tablo yok** | Vetinity hatırlatması aşı vadesinden ve randevudan türer, kural tabanlıdır. Eski programın aşı hatırlatması `SonrakiAsiTarihi`, randevu hatırlatması T5 ile taşınır. ezyVet de yalnız aşı hatırlatmasını aktarıyor. |
| T7 | Ürün ve hizmet kartları, fiyat listesi | **Alınır, stok miktarı alınmaz** | Yeni tablo **Ürünler**. Alanlar: ad, tür (hizmet, ilaç, aşı, diğer), kategori (mevcut kategoriyle eşleşir), birim, satış fiyatı, barkod, stok kodu, üretici, açıklama. Aynı barkodlu ya da aynı adlı mevcut ürünle eşleşir, yenisi oluşmaz. **Stok miktarı alınmaz**: Vetinity stoku parti, son kullanma tarihi ve ilaç defteriyle izler (ADR-015). Açılış stoku mal kabulle girilir. Narkotik sınıfı elle işaretlenir. |
| T8 | Belgeler, ekler, görüntüler | **Bu sürümde alınmaz** | Excel ya da CSV dosya taşıyamaz. Klinik gerekli belgeyi hasta belgelerine elle yükler. Toplu belge geçişi, satıcı ekibinin yaptığı dönüşüm modeliyle ayrı iştir. |
| T9 | Geçmiş randevu, yatış, stok hareketi, satış, kasa, raporlar | **Alınmaz** | Rakip pratiği ve T1–T4: anlamlı geçmiş klinik geçmişte ve hesap hareketlerinde taşınır; raporlar ve kasa yeni dönemde başlar. |

### Geri alma (ADR-019 K7, yeni türler için)

K7'nin özü değişmez: yalnız partinin oluşturduğu kayıt silinir, bağı olan kayıt silinmez, eşleşen mevcut kayıt hiçbir zaman silinmez. Yeni türler için kural:

- **Klinik geçmiş ve hesap hareketi** kayıtları salt okunurdur ve başka kayıt onlara bağlanamaz. Her zaman silinebilirler ve hasta ya da müşteriyle birlikte silinirler. **Başka partinin** eklediği kayıt hastayı veya müşteriyi korur (aşıdaki gibi).
- **Devir ücreti** müşteriyle birlikte silinir. Tahsilat bağlanmışsa ya da ücret iptal edilmişse kalır ve müşteri de kalır: klinik bu kayıtla iş yapmıştır.
- **Randevu**, hâlâ planlı durumdaysa ve gelişe ya da muayeneye bağlanmamışsa silinir. Hastanın "randevusu var" engeli partinin kendi randevularını saymaz.
- **Ürün**, sonradan düzenlenmemişse ve stok, mal kabul, ücret, satış, reçete ya da uygulama kaydında kullanılmamışsa silinir.

Muayene ve ödeme geçmişi gelince "bağı olan kayıt" kümesi büyüyor. Kural yine denetimle sağlanır, varsayımla değil: partinin kendi kayıtları bağ sayılmaz, diğer her bağ engeldir.

### Finans, kasa ve e-belge yalıtımı

- İçe aktarılan her ücret işaretlidir (`Charges.ImportBatchId`). Ciro ve gün sonu okuması (tek yer: finans olay okuyucusu) işaretli ücreti dışlar. Kasa sayımı yalnız ödemeden türediği için etkilenmez: içe aktarma ödeme yazmaz. E-belge akışı ([ADR-036](ADR-036-hbs-ve-e-belge-entegrasyonu.md)) uygulandığında işaretli ücret için belge düzenlemez; bu kural e-belge diliminin kabul koşuludur. **Uygulandı (2026-11-11, backend `11b87b90`):** devir ücreti belgesiz listesine, hatırlatma sayacına, ödemeden ve otomatik kesmeye girmez; elle seçim `EDocuments.ImportedCharge` (409) ile reddedilir; ücret listesinde "e-Belge kes" eylemi gösterilmez (frontend `f5c239ee`). Kural tek yerde: `EDocumentRules.IsDocumentableCharge`.
- Hesap hareketleri ve klinik geçmiş ayrı tablolardır; hiçbir finans, defter ya da rapor sorgusu onları okumaz.

## Sonuçlar

- Backend: dört yeni mantıksal tablo (klinik geçmiş, hesap hareketleri, randevular, ürünler), müşteri tablosunda `AcikBakiye`, iki yeni salt okunur varlık, `Charges.ImportBatchId` ve `Appointments.ImportBatchId`, yeni parti sayaçları. Tek migration gerekir, seed gerekmez: mevcut izinler kullanılır (`Examinations.Create`, `Charges.Create`, `Appointments.Create`, `Products.Create`, commit'te ek izin).
- Frontend: sihirbaz yeni tabloları, şablonu ve sütun eşlemeyi gösterir. Hasta ekranında eski program kayıtları, müşteri hesabında eski program hareketleri listelenir. Tanıtım sitesinde "Şimdilik aktarılmaz" listesi ve SSS cevabı yeni kapsama göre güncellenir.
- KVKK: klinik geçmiş sağlık verisidir. Aşı geçmişiyle aynı kural geçerlidir: hazırlık satırı 30 gün tutulur (K9), audit ve günlüğe satır verisi yazılmaz, sahip portalına açılmaz. Yeni varlıklar kiracı ve müşteri veri kopyasına (ADR-032) girer.
- Fiyat ve paket etkisi yok: içe aktarma her pakette açık (TIER-021). Deneme kiracısının tablo başına 500 satır sınırı yeni tablolara da uygulanır.
- Devir alacağı (2026-11-11 eki, kullanıcı: "eski programdan devir olarak yapalım onu"): pilot E-vet yedeğinde 20 müşterinin toplam −₺37.085,50 alacağı uyarıyla dışarıda kalıyordu. Kredi tablosunda kaynak ödeme isteğe bağlı olur ve `ImportBatchId` eklenir (tek migration). Geri alma devir alacağını da siler. Alacak kullanılmış, iade edilmiş ya da mahsubu geri alınmışsa satır, devir borcundaki "değişti" kuralıyla tutulur.
- E-vet geçmiş görevleri (2026-11-12 eki; kullanıcı: ileride geçmiş muayenelerin AI ile özeti yapılacak, bunun için geçmiş muayene, aşı ve hastalık kayıtları gerekecek): E-vet kısırlaştırma, operasyon, taburcu, dikiş alma, tetkik ve kontrol gibi işleri muayene listesine değil **görev** olarak yazıyor (pilot yedekte 2.950 tamamlanmış ve 927 gelinmemiş geçmiş görev). T5'teki "gerçekleşen ziyaret klinik geçmişte zaten var" varsayımı E-vet için tutmuyor. Bu yüzden E-vet dönüştürücüsü geçmişte kalan aşı dışı görevi **klinik geçmiş** satırına çevirir (T1). Kayıt türü görev tipidir; not "E-vet görevi: Tamamlandı" ya da "E-vet görevi: Gelmedi" ve görevin bilgi/açıklama metnidir. İptal edilen, hastasız ve hasta işi olmayan türdeki (maaş, borç/ödeme hatırlatması, bilgi) görev yine alınmaz. Kanonik Randevular tablosunun kuralı (T5) değişmez: geçmiş randevu gerçek randevu olmaz.
- Açık kalan, sonraki iş: belge ve ek geçişi, yapılandırılmış reçete ve lab dönüşümü (ancak defter etkisi çözülürse), satıcı ekibinin yaptığı program bazlı dönüşüm (Kolayvet ve E-vet profillerine yeni tablo eşlemeleri, gerçek dışa aktarma dosyası görülünce).

## Kaynaklar (erişim 2026-11-10)

- Kolayvet: `kolayvet.com/sss`, `kolayvet.com/ozellikler/ozellikler/gelismis-ice-disa-aktarma`, `.../ucretsiz-tasima`
- Covetrus Pulse: `vetdata.freshdesk.com/support/solutions/articles/8000112422-pulse-data-conversion-basics`, `.../8000112512-customer-assisted-conversion-faqs`
- Digitail: `help.digitail.io/en/articles/12831941-switching-veterinary-practice-management-software-from-cornerstone-to-digitail`, `.../12832525-what-to-expect-during-your-onboarding-and-data-migration-with-digitail`
- Shepherd: `shepherd.vet/pricing/`
- ezyVet: `docs.ezyvet.com/discover-resources/onboarding-resources-for-new-ezyvet-customers/cornerstone-data-conversions` (sayfa açılmadı; bilgi arama alıntısından, doğrulanmadı)
- IDEXX Neo: `idexxneosupport.zendesk.com/hc/en-us/articles/360007591453` (403; bilgi arama alıntısından, doğrulanmadı)
- VetBis, Vetsoft, E-vet ve diğer Türk ürünleri için kalem düzeyinde kaynak bulunamadı.

## Uygulama notu (2026-11-10)

- Devir ücreti otomatik borç hatırlatmasına da hatırlatmalar serbest bırakılana kadar girmez (aşı ve randevuyla aynı kural).
- Ürün geri alma nedenleri kodda ücret önerisi ve muayene şablonu bağlarıdır; ücret satırı ürün bağı tutmadığı için "ücret" nedeni yoktur.
- Hacim (yerel, 24.500 satır, yedi tablo): doğrulama ~4 sn, uygulama ~89 sn, geri alma ~60 sn; doğrulama sorgu sayısı satır sayısından bağımsız (backend `IMPORT_PERFORMANCE_FINDINGS.md` bölüm 9).
