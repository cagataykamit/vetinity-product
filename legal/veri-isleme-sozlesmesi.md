# Veri İşleme Sözleşmesi (Klinik = veri sorumlusu, Vetinity = veri işleyen)

Sürüm: 1.1 · Tarih: 2026-11-20

**1. Taraflar ve konu**
Veri sorumlusu: abonelik kaydındaki Klinik. Veri işleyen: [Şirket unvanı] ("Vetinity"). Konu: Vetinity'nin, Hizmeti sunarken Klinik adına işlediği kişisel veriler (müşteri ve hasta sahibi kimlik/iletişim/finans verileri, hayvana ilişkin kayıtlar).

**2. İşlemenin niteliği**
Süre: abonelik süresi ve dışa aktarma süresi. Amaç: kliniğin kayıt, randevu, muayene, aşı, stok ve ödeme yönetimini barındırmak; Klinik için açıldığında yapay zekâ destekli özellikleri (hasta geçmişi özeti, muayene notu, hasta sahibine açıklama ve taburcu talimatı taslakları, doğal dille hasta araması) sunmak. Veri kategorileri ve ilgili kişi grupları: Klinik müşterileri ve çalışanları. Özel nitelikli veri bilinçli olarak toplanmaz; Klinik bu tür veriyi serbest metin alanlarına girmemeyi taahhüt eder.

**3. Vetinity'nin yükümlülükleri**
a) Verileri yalnız Klinik'in yazılı (Hizmet kullanımıyla verilen) talimatları doğrultusunda işler. b) Verilere erişen personelin gizlilik yükümlülüğü altında olmasını sağlar. c) Kanun m.12 uyarınca uygun teknik ve idari tedbirleri alır (rol/izin kontrolü, iletişimde şifreleme, denetim kaydı, yedekleme, erişim kısıtı). d) Alt işleyenleri (barındırma, ödeme, bildirim sağlayıcıları; yapay zekâ özellikleri için Anthropic PBC, ABD) [liste ve güncelleme usulü] hakkında Kliniği bilgilendirir ve alt işleyenlere aynı seviyede yükümlülük getirir. e) Veri ihlalini öğrendiğinde gecikmeksizin [48 saat içinde] Kliniğe bildirir. f) İlgili kişi taleplerinde Kliniğe makul yardımda bulunur; doğrudan gelen talepleri Kliniğe yönlendirir. g) Kanun'a uyumun kanıtlanması için gerekli bilgiyi sağlar ve makul denetime katlanır. h) Yapay zekâ özellikleri her klinikte kapalı başlar; Klinik'in talebiyle Vetinity açar. Açıkken yalnız istenen işlem için gereken klinik kayıtlar (hayvanın geçmişi, muayene, tanı, tedavi ve aşı kayıtları, kullanıcının yazdığı metin) yapay zekâ sağlayıcısına gönderilir. Göndermeden önce hasta sahibinin adı, e-posta adresi, telefon, kimlik ve mikroçip gibi uzun numaralar ve hayvanın adı metinden çıkarılır; müşteri kaydı gönderilmez. Bu temizleme serbest metindeki her kişisel veriyi yakalamayabilir; Klinik serbest metin alanlarına gereksiz kişisel veri yazmamayı taahhüt eder. Gönderilen metin Vetinity'de saklanmaz; yalnız kullanım kaydı (kullanıcı, özellik, zaman, token, tahmini maliyet, sonuç) tutulur. Yapay zekâ çıktısı taslaktır; kullanıcı kontrol edip onaylamadan kayda geçmez.

**4. Klinik'in yükümlülükleri**
Aydınlatma yükümlülüğünü, hukuki sebebin (gerekirse açık rızanın) varlığını, VERBİS ve saklama kararlarını, ilgili kişi taleplerinin yanıtlanmasını üstlenir; kullanıcı hesaplarını yetkili kişilere verir.

**5. Yurt dışı aktarım**
Veriler Türkiye'de [barındırma yeri] tutulur. Yurt dışına aktarım Kanun m.9'a uygun olmadıkça yapılmaz. Klinik için yapay zekâ özellikleri açıldığında madde 3(h)'deki veriler, işlemin yapılması için Anthropic PBC'ye (Amerika Birleşik Devletleri) aktarılır; özellik kapalı klinikte bu aktarım olmaz.

**6. Süre sonu**
Sonlandırmada Klinik verisini dışa aktarabilir; [süre] sonunda Vetinity verileri siler/anonimleştirir ve talep halinde yazılı teyit verir. Yasal saklama zorunluluğu bulunanlar o süre kadar ayrı tutulur.

Klinik, hizmet süresince ve sonlandırmada panelden kendi verisinin tamamını makinece okunur biçimde (ZIP içinde CSV) alabilir. Pakete parola, oturum ve API kimlik bilgileri, hasta sahibi portal hesap bilgileri, gönderilen ileti içerikleri ve başka müşterilerin verisi dahil edilmez. Hazırlanan paket 7 gün saklanır ve sonra silinir; talep ve indirmeler denetim kaydına yazılır. Biçim ve verilen/verilmeyen alan tablosu: backend `DATA_EXPORT_API_CONTRACT.md` §6.

**7. Sorumluluk ve uygulanacak hukuk**
Kullanım Şartları'ndaki sorumluluk ve uyuşmazlık hükümleri geçerlidir; bu sözleşme KVKK ve ilgili tebliğlere tabidir.
