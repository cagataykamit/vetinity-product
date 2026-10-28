# Vetinity Hasta Sahibi Portalı Gizlilik Politikası

Sürüm: 0.1 (taslak) · Taslak tarihi: 2026-10-16 · Durum: hukuki onay bekliyor

Bu politika, hasta sahibi portalını (web ve mobil uygulama) kullanan kişilerin **portal hesabına** ilişkin verilerinin nasıl işlendiğini anlatır ([ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K4). Portal'da gördüğünüz klinik kayıtlarının veri sorumlusu ilgili kliniktir; o kayıtlar için kliniğinizin aydınlatma metni geçerlidir ([aydınlatma metni şablonu](aydinlatma-metni.md)). Klinik çalışanları ve site ziyaretçileri için ayrı [gizlilik politikası](gizlilik-politikasi.md) geçerlidir.

**1. Veri sorumlusu**
[Şirket unvanı], [adres], [MERSİS/ticaret sicil no], [iletişim e-postası]. [AK-5: portal hesabı verileri (bölüm 2a) için Vetinity'nin veri sorumlusu mu, bağlı klinik adına veri işleyen mi olduğu hukuki görüş bekliyor. Bu taslak, Vetinity'nin kendi kullanıcı hesaplarındaki varsayımla (veri sorumlusu) yazılmıştır; görüş farklı çıkarsa 1, 3 ve 4. bölümler değişir.] Klinik kayıtları (bölüm 2b) bakımından Vetinity, kliniğin talimatıyla veri işleyendir.

**2. Hangi verileri işleriz**

*a) Portal hesabı verileri*
- Hesap: e-posta adresi, görünen ad, parola (yalnız geri döndürülemez özet olarak; parolasız girişte hiç tutulmaz).
- Giriş ve güvenlik: giriş kayıtları (zaman, başarılı/başarısız deneme, kullanılan yöntem), tek kullanımlık kodların geçerlilik ve deneme bilgisi, kilitleme durumu, IP adresi [hukuk: güvenlik kaydında IP tutulmalı mı, süresi], Portal'da hangi kaydın görüntülendiğine ilişkin erişim kaydı (kim, ne zaman, hangi kayıt; içerik değil).
- Cihaz ve oturum: oturum ve yenileme jetonları, cihaz/tarayıcı türü, "tüm cihazlardan çıkış" için oturum listesi; bildirim izni verirseniz bildirim cihaz jetonu (v1).
- Bildirim tercihi: hangi bildirim türünü hangi kanaldan almak istediğiniz.
- Kabul kayıtları: bu politikanın ve [portal kullanım şartlarının](portal-kullanim-sartlari.md) kabul ettiğiniz sürümü ve zamanı.
- Klinik bağları: hesabınızın hangi klinikteki müşteri kaydına bağlı olduğu, davet ve bağ durumu.

*b) Portal'da gösterilen klinik kayıtları (veri sorumlusu klinik)*
Hayvanlarınızın temel bilgileri (ad, tür, ırk, doğum tarihi, mikroçip, kilo), randevularınız, aşı geçmişi ve yaklaşan aşı/kontrol, bakiye ve ödeme durumu, reçete ve tedavi özeti (sade dilde, kliniğin açtığı ölçüde), kliniğin iletişim bilgileri. **Muayene notları, laboratuvar sonuçları ve görüntüler Portal'da gösterilmez** (ADR-031 AK-8). Bu kayıtlar Portal için ayrıca toplanmaz; kliniğin mevcut kaydından salt okunur gösterilir.

**3. Amaçlar ve hukuki sebepler**
Hesabın açılması, girişin sağlanması ve klinik kayıtlarının size gösterilmesi (Kanun m.5/2-c, sözleşmenin ifası); hesap güvenliği, yetkisiz erişimin ve kötüye kullanımın önlenmesi, erişim kaydı (m.5/2-f meşru menfaat; [hukuk: m.5/2-ç kapsamında saklama yükümlülüğü var mı]); şartların ve politikanın sürümlü kabulünün ispatı (m.5/2-e hakkın tesisi ve korunması); işlemsel bildirimler — giriş kodu, parola sıfırlama, randevu ve aşı hatırlatması (m.5/2-c; tercihinizle kapatılabilir); tanıtım/kampanya iletileri yalnız açık rızanızla [AK-5: İYS/ETK ayrımı hukuki görüş bekliyor].

**4. Aktarım**
- **Bağlı klinik:** hesabınızın o klinikteki bağ durumu (davet, bağlı, erişim kapatıldı) ve Portal'dan ilettiğiniz talepler yalnız ilgili kliniğe görünür. Parolanız, oturum ve cihaz bilgileriniz kliniğe aktarılmaz.
- **Hizmet sağlayıcılar:** barındırma ve altyapı, e-posta gönderim sağlayıcısı [sağlayıcı belirlenmedi], bildirim (push) hizmeti — v1'de, uygulama mağazası platformlarının bildirim altyapısı [yurt dışına aktarım: sağlayıcı, ülke ve Kanun m.9 mekanizması buraya yazılır].
- **Yetkili kurumlar:** mevzuatın zorunlu kıldığı hallerde.
Verileriniz satılmaz ve reklam amacıyla paylaşılmaz.

**5. Birden çok klinik ve ayrı veri sorumluları**
Birden fazla Vetinity kliniğinden hizmet alıyorsanız tek portal hesabınız her kliniğe ayrı ayrı ve yalnız o kliniğin davetiyle bağlanır. Her klinik kendi kayıtlarının **ayrı veri sorumlusudur**; bir klinik diğer kliniğin kayıtlarını, sizin diğer kliniklerle bağınızı veya o kliniklerdeki hayvan bilgilerinizi göremez. Bir kliniğin erişiminizi kapatması diğer bağları etkilemez.

**6. Saklama**
- Hesap verileri, oturumlar, cihaz jetonları ve bildirim tercihleri: hesap açık olduğu sürece; hesap silinince silinir. E-posta adresiniz de silinir; aynı adresle yeniden davet alabilirsiniz.
- Giriş ve erişim kayıtları: [süre — hukuk belirler], sonra silinir veya anonimleştirilir.
- Kabul kayıtları: hesap silinse de ispat amacıyla [süre — hukuk belirler] saklanır.
- Klinik kayıtları: kliniğin saklama ve imha politikasına ve mevzuattaki sürelere bağlıdır; portal hesabının silinmesi bu kayıtları silmez ([saklama ve imha politikası](saklama-ve-imha-politikasi.md)).

**7. Güvenlik**
Tek kullanımlık ve süreli kodlar, deneme sınırı ve geçici kilitleme, parolanın geri döndürülemez özetle saklanması, kısa ömürlü oturum jetonları, iletişimde şifreleme, yalnız kendi kayıtlarınıza erişim kontrolü ve erişim kaydı uygulanır. Hiçbir sistem tamamen risksizdir; ihlal halinde Kanun m.12 uyarınca ilgili kişilere ve Kurul'a bildirim yapılır.

**8. Çerezler ve yerel depolama**
Portal, oturumunuzu sürdürmek için tarayıcı veya uygulama içi yerel depolamada oturum bilgisi ve dil/görünüm gibi zorunlu ayarları tutar. Analitik veya reklam çerezi kullanılmaz; kullanılması gerekirse önceden açık rızanız alınır [çerez politikası eklenecek]. Çıkış yaptığınızda oturum bilgisi cihazdan silinir.

**9. Haklarınız (Kanun m.11)**
Kişisel verilerinizin işlenip işlenmediğini öğrenme; işlenmişse bilgi talep etme; işlenme amacını ve amaca uygun kullanılıp kullanılmadığını öğrenme; aktarıldığı üçüncü kişileri bilme; eksik veya yanlış işlenmişse düzeltilmesini isteme; Kanun'daki şartlarla silinmesini veya yok edilmesini ve bunun aktarılanlara bildirilmesini isteme; münhasıran otomatik sistemlerle analiz sonucu aleyhinize bir sonuca itiraz etme; kanuna aykırı işleme nedeniyle zararın giderilmesini isteme haklarına sahipsiniz.

**10. Başvuru yolu**
- Portal hesabı verileri için: [başvuru e-postası/adresi]. Hesabınızı ve bildirim tercihlerinizi Portal'dan kendiniz de silebilir veya değiştirebilirsiniz.
- Klinik kayıtları için: doğrudan ilgili kliniğe veya Portal'daki "Verilerimle ilgili talep" bölümünden (v1) başvurabilirsiniz; talep kliniğin KVKK talep sürecine iletilir ve klinik yanıtlar. Vetinity'ye gelen klinik kaydı talepleri ilgili kliniğe yönlendirilir.
Başvurular en geç 30 gün içinde ücretsiz yanıtlanır; ayrıca maliyet gerekirse Kurul tarifesi uygulanabilir. Yanıtı yetersiz bulursanız veya süresinde yanıt verilmezse Kanun m.14 uyarınca Kişisel Verileri Koruma Kurulu'na şikâyet hakkınız saklıdır.

**11. Değişiklikler**
Politika güncellendiğinde yeni sürüm yayımlanır ve bir sonraki girişinizde onayınıza sunulur; kabul ettiğiniz sürüm kaydedilir ([ADR-029](../decisions/ADR-029-surumlu-hukuki-kabul.md)).
