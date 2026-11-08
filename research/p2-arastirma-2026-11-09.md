# P2 araştırma notu: CHECKOUT-001, EXAM-013, RECORD-004, SEC-002 (2026-11-09)

Yalnız kod ve belge okundu. Kod yazılmadı, dal açılmadı, test ya da sunucu çalıştırılmadı. Bu notta "doğrulanmadı" diye işaretlenmemiş her bilgi dosya okumasına dayanıyor; tarayıcıda ya da HTTP ile denenmiş değil.
Kısaltmalar: BE = `C:\Users\DELL\source\repos\Veteriner\src`, FE = `C:\FrontEnd\veteriner-frontend\src\app`.

---

## 1. CHECKOUT-001: ziyaret kapanışı ve tahsilat

### Bugünkü durum

- **Geliş ve bakım durumu:** `Visit` (`BE/Backend.Veteriner.Domain/Visits/Visit.cs`) üç durumlu: Bekliyor → Devam ediyor → Tamamlandı. `Complete` yalnız Devam ediyor durumundan geçer, yani bekleyen geliş önce başlatılmalı. Ödeme bakım durumunu değiştirmez (ADR-009 madde 2). ADR-009 ekinde "Check Out" karşılığı bilerek boş bırakıldı ve bu işe havale edildi.
- **Ücret bekleyen kalemler:** Uygulama, hizmet ve paket satırları `ChargeSuggestion` doğuruyor (ADR-018). Ücrete çevirme kalem kalem yapılıyor: `BE/Backend.Veteriner.Application/ChargeSuggestions/Commands/{Convert,Waive}`, FE'de `features/charges/pages/charge-suggestions-page` (her satırda "Ücrete çevir"; toplu çevirme ADR-018'de ertelendi).
- **Ödeme:** `CreatePaymentCommand` (`BE/.../Payments/Commands/Create/CreatePaymentCommand.cs`). Tahsis zorunlu; fazlası ya da avans krediye yazılıyor (FIN-005), `requestId` ile çift istek korunuyor, nakitte kasa seçiliyor. **Her ödemenin tek yöntemi var** (`PaymentMethod`: Nakit / Kart / Havale). Parçalı ödeme ("100 TL'nin 50'si nakit, 50'si kart") için iki ayrı ödeme formu doldurmak gerekiyor.
- **Arayüz akışı (`features/visits/pages/today-page/today-page.component.ts` 493–506):** Bugün satırından üç ayrı sayfaya gidiliyor: `/panel/charges/pending?visitId=` (Ücretlendir), `/panel/charges/new` (Ücret ekle) ve `/panel/payments/new?visitId=` (Ödeme al; o gelişin açık ücretleri dolu geliyor, krediden ödeme ve kasa seçimi var). "Tamamla" ise Bugün'de ayrı bir eylem. Hastayı çıkışa almak bugün en az üç ekran ve kalem başına bir tık demek.
- **Açık iş göstergesi:** `IVisitOpenItemsReader` (`BE/.../Visits/ReadModels/IVisitOpenItemsReader.cs`) her geliş için ücret durumunu tek yerde hesaplıyor: Ücret yok / Ödeme bekliyor / Kısmi ödendi / Ödendi.
- **Belge:** Tahsilat makbuzu ya da ziyaret özeti yok. Doğrudan satışta bilgi amaçlı satış fişi var (`features/sales/components/sale-receipt.component.ts`, "resmî belge, fatura veya e-belge değildir" ibaresiyle). Evde bakım talimatı gelişe bağlanabiliyor (`BE/.../CareInstructions`). Aşı sertifikası ya da karnesi bulunamadı.

### Rakipler (yalnız yetenek; görünüm kopyalanmaz)

- **DaySmart** (videodan, sandbox'ta doğrulanmadı; `competitors/daysmart.md` 491–590): Visit Complete'ten sonra ayrı Check Out adımı var. Birden fazla açık fatura seçiliyor, krediden mahsup yapılabiliyor, fazla tahsilatta para üstü mü kredi mi seçiliyor, belge seçilip teslim kanalı belirleniyor (e-posta, SMS, yazdır), hatırlatma sayıları görünüyor. Rakibin zayıf yanı: "Visit Complete" ile "Check Out" ayrımı kullanıcıyı karıştırabiliyor.
- **E-Vet** (`competitors/e-vet.md` 951–1077): "Kaydet / Öde" ile ayrı ödeme ekranına geçiliyor; canlı testte parçalı ödeme gözlendi (Nakit + Kart).

### Seçenekler

| | Yaklaşım | Artı | Eksi |
|---|---|---|---|
| A | Yalnız FE: tek "Hesabı kapat" paneli mevcut uçları sırayla çağırır | Migration yok, hızlı | Okuma birden çok sorguya dağılır; kural FE'de toplanır |
| B | BE'de tek `checkout` komutu: kalemleri çevir, N ödeme yaz, gelişi kapat; hepsi tek işlemde | Bölünmez (atomik), denetim tek kayıt | Büyük yeni sözleşme; ödeme ve kalem kuralları ikinci bir yoldan çağrılır (iki yerde kural riski) |
| **C (öneri)** | BE'ye yalnız **okuma** ucu (`GET /visits/{id}/checkout-summary`: bekleyen kalemler, gelişin ve müşterinin açık ücretleri, kredi, bakiye, yaklaşan hatırlatma) + FE'de tek panel; yazma mevcut uçlarla | Yazma kuralları tek yerde kalır; her adım zaten idempotent (`requestId`, çevirmede RowVersion), yarıda kalırsa tekrar denemek güvenli | Bölünmez değil: ilk ödeme yazılıp ikincisi hata verirse panel kalan tutarı yeniden gösterir (bu doğru bir durum, çünkü para alınmıştır) |

### Önerilen akış (C)

Bugün satırında ve muayene kesinleştirme sonrasında **"Hesabı kapat"** eylemi, tek bir panel açar:

1. **Ücret bekleyenler:** Satır içinde çevir ya da gerekçeyle ücretsiz say. "Tümünü ücrete çevir" seçeneği eklenir; istemci her kalemi kendi `requestId`'si ile çevirir, yeni toplu uç gerekmez.
2. **Açık ücretler:** Bu gelişinkiler seçili gelir. Müşterinin diğer açık ücretleri isteğe bağlı seçilir (rakipteki "birden fazla açık fatura" yeteneği).
3. **Tahsilat:** Bir ya da daha fazla ödeme satırı (yöntem, tutar, nakitse kasa), krediden ödeme, fazlası krediye. Parçalı ödeme, aynı tahsisler bölünerek art arda ödeme isteği gönderilerek yapılır.
4. **Kapat:** Geliş Tamamlandı değilse tamamlanır (gerekirse önce başlatılır). **Borçla kapatmaya izin var** (ADR-009: bakım ile ödeme ayrı); panel kalan borcu açıkça gösterir.
5. **Belge:** Bilgi amaçlı "ziyaret ve tahsilat özeti" yazdırılır (satış fişi deseni) ve varsa bakım talimatı. E-posta veya SMS ile teslim ilk dilimde yok.

Yeni bakım durumu **eklenmez**. Rakipteki "Visit Complete ≠ Check Out" ayrımı kafa karıştırdığı için tek adımda birleştirilir; bu Vetinity'nin rakipten daha iyi olduğu nokta.

### İş büyüklüğü

Orta-büyük, yaklaşık 5 dilim:

1. BE özet okuma ucu ve sözleşmesi (`VISITS_API_CONTRACT` ya da yeni bir belge).
2. FE paneli: kalemler ve açık ücretler.
3. FE: parçalı tahsilat ve kredi.
4. FE: kapanış, özet fişi, Bugün ve muayeneden giriş noktaları.
5. İsteğe bağlı: `Visit.CheckedOutAtUtc/By` (migration) ve gün sonu raporunda "kapatılmadan bırakılan gelişler".

### Ürün kararı soruları

1. Kapanış zamanı ve kapatan kişi gelişe kalıcı olarak yazılsın mı (migration, gün sonunda görünür), yoksa "Tamamlandı ve ödeme durumu" yeterli mi? Öneri: ilk sürümde yazılmasın, pilotta bakılsın.
2. "Hesabı kapat" müşterinin başka gelişlerden kalan açık ücretlerini de varsayılan olarak seçsin mi? Öneri: hayır, yalnız gösterilsin, seçim elle yapılsın.

### Hukuki ve güvenlik

- Özet fişi resmî belge değildir. "Bilgi amaçlıdır; fatura veya e-belge değildir" ibaresi zorunlu olmalı. Resmî belge işi INT-005/INT-007'de.
- Belgenin e-posta veya SMS ile gönderimi kişisel veri aktarımıdır (KVKK). İşlem bildirimi olduğu için ticari ileti sayılmaması beklenir, ama bu **doğrulanmadı** (ADR-046 çizgisi). İlk dilimde yalnız yazdırma önerilir.
- Yetki: Hekimde `Charges.Create` yok (ADR-012). Panelde çevirme ve tahsilat düğmeleri izne göre gizlenir; yeni izin gerekmez.

---

## 2. EXAM-013: paket kalem seçimi ve miktar düzenleme

### Bugünkü durum

- **Şablon / paket:** `ExaminationTemplate` (`BE/Backend.Veteriner.Domain/Catalog/ExaminationTemplate.cs`). Metin alanları, en çok 20 satır (ürün veya hizmet + miktar; aynı ürün bir kez) ve isteğe bağlı `PackagePrice` taşıyor.
- **Uygulama:** `ApplyExaminationTemplateCommandHandler` (`BE/.../ExaminationTemplates/Commands/Apply/`) şablonun **tüm satırlarını, şablondaki miktarla** yazıyor. Komutta yalnız `TemplateId` ve `RowVersion` var. Stoklu satır mevcut `CreateAdministrationCommand` ile yazılıyor (FEFO, stok ve kontrollü ürün kuralları orada). Fiyatlı pakette tek paket kalemi doğuyor, satırlar "pakete dahil" işaretleniyor. Hepsi tek işlemde; bir satır reddedilirse hiçbiri yazılmıyor.
- **FE:** `entities/examination-template/components/examination-template-apply-dialog.component.ts`. Önizleme satırları ve toplamı gösteriyor ama satır seçimi ve miktar düzenleme yok.
- **Bugün uygulanmayan kalemin düzeltilmesi:** Paket uygulandıktan sonra ilgili uygulama ADR-013 iptaliyle (stoğa iade) tek tek geri alınıyor. Bu hem zahmetli hem de denetim kaydında gürültü üretiyor.

### Seçenekler

| | Yaklaşım | Not |
|---|---|---|
| **A (öneri)** | Uygulama anında satır bazında dahil/hariç ve miktar. Apply komutuna isteğe bağlı `lines: [{productId, quantity}]`; yalnız şablondaki ürünler kabul edilir, listede olmayan satır hariç sayılır, miktar mevcut `Administration` sınırlarıyla doğrulanır | Migration yok, şablon değişmez. Kural tek yerde kalır: geçerlilik denetimi şablon satır kuralı ve uygulama kuralıyla aynı. Bir sonraki adımı (EXAM-014) da açar |
| B | Şablonda en az–en çok miktar ve fiyat aralığı (DaySmart'taki gibi) | Migration ve editör değişikliği gerekir, fiyat aralığı ADR-018 fiyat kuralıyla çakışır. Ertelensin |
| C | Bugünkü yol (uygula, sonra iptal et) | Sorunu çözmüyor |

### Fiyatlı pakette davranış (öneri, rakip pratiğinden türetildi)

- Satır hariç tutulsa ya da miktarı değişse de **paket fiyatı sabit kalır**. Gerekirse resepsiyon kalemi ücrete çevirirken fiyatı düzenler (ADR-018 K3'te zaten var). Önizlemede bu bir satırla belirtilir.
- Orantılı fiyat yok.
- Tüm stoklu ve hizmet satırları hariç tutulursa paket kalemi de doğmaz. Böylece "yalnız metin uygula" mümkün olur.

### İş büyüklüğü

Küçük-orta, 2 dilim:

1. BE: komut, doğrulayıcı, sözleşme ve testler (hariç satır, miktar sınırı, şablonda olmayan ürün, fiyatlı paket).
2. FE: önizlemede onay kutusu ve miktar alanı, toplamın yeniden hesaplanması.

### Ürün kararı

Gerekmiyor (paket fiyatının sabit kalması rakip pratiğinden türetildi). Kullanıcı farklı isterse bu yalnız fiyat kuralını etkiler.

### Hukuki ve güvenlik

Yok. Kontrollü ürün satırı mevcut uygulama kurallarından geçer.

---

## 3. RECORD-004: kayıt kopyalama

### Bugünkü durum

- Klinik kayıtlarda kopyalama yok. Tek örnek muayene şablonlarındaki "Kopyala ve düzenle": içerik yeni adla normal POST ile gönderiliyor, ayrı uç yok (`features/examination-templates/pages/examination-templates-page.component.ts` 28).
- Oluşturma formları bağlamı sorgu parametresinden alıyor (`prescription-new-page`, `treatment-new-page`, `lab-result-new-page`: `contextParams`).
- **Kesinleştirme kilidi:** `BE/.../Examinations/Access/ExaminationLinkedRecordLock.cs` ve ADR-013. Kesinleşmiş muayeneye tedavi ve aşı eklenemez; uygulama ve reçete yalnız gerekçeyle "sonradan eklendi" olarak eklenir.
- DaySmart'ta kayıt satırında ve muayenede "duplicate" eylemi var (gözlem, doğrulanmadı; `competitors/daysmart.md` 301, 344).

### Hangi türde anlamlı?

| Tür | Öneri | Neden |
|---|---|---|
| **Reçete** | **Evet, ilk dilim** | Kronik ilaç tekrarı en sık ihtiyaç; çok kalemli. Kopyalanır: başlık, içerik, kalemler (ad, ürün, doz, birim, miktar, talimat). **Kopyalanmaz:** lot (`PrescriptionItem.LotNumber`), HBS alanları, iptal ve geç kayıt alanları, tarih |
| Tedavi | Evet, ikinci dilim | Başlık ve açıklama. Tekrarlanan tedaviler için muayene şablonu zaten var, değeri orta |
| Lab istemi | İsteğe bağlı | Tek alan (`TestName`); kopyalamanın kazancı az. Sonuç, yorum ve durum kopyalanmaz |
| Uygulama | Evet, "tekrar uygula" olarak (sonra) | Stoktan yeniden düşer, parti FEFO ile yeniden seçilir; lot kopyalanmaz |
| **Muayene** | **Hayır** | Klinik bulguyu başka bir güne taşımak ("copy-forward") kaydın doğruluğunu bozar. Bunun yerine şablon ve metin parçası (EXAM-006/007/011) var |
| Aşı | Hayır | Sonraki doz ve hatırlatma aşı takviminden doğar; kopyalamak yanlış hatırlatma üretir |
| Yatış, görüntüleme | Hayır | Canlı kayıt ya da dosya bağımlı |

### Kesinleştirme kilidiyle ilişki

- Kopya **yeni bir kayıttır** ve kaynak hiç değişmez. Bu yüzden kaynağın kesinleşmiş olması engel değildir.
- Kopya **kaynağın muayene bağını taşımaz**; hedef, aynı hastanın o anki açık gelişi ya da muayenesidir. Aksi halde kesinleşmiş eski muayeneye yanlışlıkla geç kayıt açılır.
- Hedef kesinleşmişse normal oluşturma ucu ADR-013 kuralını kendiliğinden uygular: reçetede gerekçe istenir, tedavide reddedilir. Yeni yazma yolu açılmadığı için kilit tek yerde kalır.
- Kopya yalnız **aynı hasta** için yapılır. Başka hastaya reçete kopyalamak hatalı reçete riskidir.

### Önerilen tasarım

- Ayrı kopyalama ucu yok. Kayıt detayındaki "Kopyasını oluştur" eylemi oluşturma formunu kaynaktan doldurur; hekim gözden geçirip kaydeder (klinik karar hekimde). Kopyalanacak alanlar, tür başına tek bir FE yardımcısında oluşturma girdisi biçiminde tanımlanır; sunucu bunu sıradan bir oluşturma isteği gibi doğrular.
- İsteğe bağlı `CopiedFromId` (migration) ilk dilimde yok. Oluşturma zaten denetim kaydına yazılıyor.

### İş büyüklüğü

Küçük, 2 dilim (ağırlıkla FE):

1. Reçete kopyası.
2. Tedavi kopyası ve uygulamada "tekrar uygula".

İlk dilimde BE değişikliği yok.

### Ürün kararı

Muayene ve aşının kapsam dışı bırakılmasının onaylanması (öneri: dışarıda kalsın).

### Hukuki ve güvenlik

Reçete hekimin sorumluluğundadır: kopya otomatik kaydedilmez, tarih yenilenir, HBS'e yeniden girilmesi gerekir. Kontrollü ilaç reçetesinin kopyalanmasına özel bir mevzuat kuralı olup olmadığı **doğrulanmadı**. Öneri: kontrollü ürün içeren kalemde uyarı gösterilsin.

---

## 4. SEC-002: izinler JWT'de, yetki geri alma gecikmesi

### Bugünkü durum

- **Token içeriği:** Girişte ve yenilemede izin kodları token'a tek tek `permission` claim'i olarak yazılıyor (`BE/.../Auth/Commands/Login/LoginCommandHandler.cs` 180–185; `Refresh/RefreshCommandHandler.cs` 138–144). Kodlar `PermissionReader`'dan geliyor (`BE/Backend.Veteriner.Infrastructure/Caching/PermissionReader.cs`: bellek önbelleği, 10 dk + 0–2 dk sapma).
- **Yetki denetimi yalnız token'a bakıyor:** `BE/Backend.Veteriner.Api/Auth/PermissionAuthorizationHandler.cs`, `PermissionAnyOfAuthorizationHandler.cs` ve uygulama içinden 44 dosyada kullanılan `BE/Backend.Veteriner.Infrastructure/Web/CurrentUserPermissionChecker.cs`. Denetleyicilerde yaklaşık 432 `Policy = PermissionCatalog...` kullanımı var; hepsi aynı işleyiciden geçiyor.
- **Token ömrü:** `Jwt:ExpMinutes` = 60 (`appsettings.json`, `appsettings.Production.json`); yenileme token'ı 7 gün. `ClockSkew` sıfır.
- **Geri alma etkisi:** Rol veya izin değişince önbellek düşürülüyor (`IPermissionCacheInvalidator`: izin ekleme/çıkarma, izin güncelleme/silme, kullanıcı claim'i ekleme/çıkarma, üye rolü atama/kaldırma, üyeyi çıkarma). Rol-izin değişikliğinde ayrıca yenileme token'ları iptal ediliyor. **Ama verilmiş access token süresi dolana kadar, en çok 60 dk, eski izinle geçerli.** Üye çıkarılırsa yenileme reddediliyor (`TenantNotMember`); yine de eldeki token 60 dk çalışıyor.
- **Bu gecikmeden etkilenmeyenler:** Klinik erişimi veritabanından okunuyor gibi görünüyor: `ClinicReadScopeResolver`, `IUserClinicRepository`'ye bağımlı. Bu bilgi kurucu bağımlılığından çıkarıldı; her istekte okunduğu ayrıntılı **doğrulanmadı**. Doğruysa gecikme yalnız izin kodlarında.
- **Kapsam dışı yol:** DbMigrator seed önbelleği düşürmüyor (`docs/SECURITY_CONFIGURATION.md` 59–63).
- **FE:** Menü ve düğmeler izinleri token'dan okuyor (`core/auth/auth.service.ts` 643–680). Yenileme yalnız 401 alınca yapılıyor (`core/api/auth.interceptor.ts`); 401'de bir kez sessizce yenileyip isteği tekrarlıyor.
- **Testler:** Bütünleşik testlerde 74 dosya token'a izni doğrudan yazıyor (`tests/.../Infrastructure/IntegrationTestAuthHelper.cs` `IssueUserAccessTokenAsync`, 85 kullanım). İzni sunucudan okumaya geçmek bu testlerin çoğunu kırar.

### Seçenekler

| | Yöntem | Gecikme | Maliyet | Not |
|---|---|---|---|---|
| A | Token ömrünü kısalt (ör. 15 dk) | ≤ 15 dk | Yalnız ayar | FE 401'de sessizce yeniliyor, kullanıcı fark etmez; her 15 dk'da bir ek istek. Gecikme kapanmaz, yalnız kısalır |
| B | Kalıcı izin sürümü (User'a sayaç sütunu, token'a claim, her istekte karşılaştırma) | Anında | Orta + migration | Sayaç her değişim noktasında artırılmalı; her istekte sayaç okunacağı için yine önbellek gerekir |
| C | İzni sunucudan oku (`IClaimsTransformation` ile token'daki izinleri önbellekteki güncel kümeyle değiştir) | Anında (tek sunucuda) | Orta | Tek yerde değişir, işleyiciler aynı kalır. Ama 74 test dosyası kırılır; test yardımcısını DB'ye izin yazacak şekilde baştan yazmak gerekir |
| **D (öneri)** | **İzin değişim damgası:** `PermissionCacheInvalidator` önbelleği düşürürken kullanıcıya "izinleri şu an değişti" damgası da yazar (bellek önbelleği, ömrü = token ömrü). JwtBearer `OnTokenValidated` olayında token'ın `iat` değeri damgadan eskiyse 401 döner. FE zaten sessizce yeniler, yeni token güncel izinle gelir. Süreç başlangıcı da genel bir damga sayılır (yeniden başlatmada damgalar kaybolsa bile açık kalmaz) | Anında (tek sunucuda) | Küçük | Migration yok; değişim noktaları zaten tek arayüzden geçiyor (kural tek yerde). Testler etkilenmez. Yan etki: izin eklenince de kullanıcı yeni izni hemen alır |

**Öneri: D**, yanına isteğe bağlı A (`ExpMinutes` 30). Birden fazla API süreci çalıştırılırsa bellek damgası süreçler arasında paylaşılmaz; o gün damga paylaşılan önbelleğe ya da veritabanına taşınır. Bugünkü kurulumun tek süreç olduğu **doğrulanmadı** (VPS işi kullanıcıda). A bu durumda gecikmeye üst sınır koyar.

### Ayrıntılar

- Damga saniyeye yuvarlanır ve `iat < damga` ile karşılaştırılır. Aynı saniye içinde verilmiş eski bir token'ın kabul edilme payı ihmal edilebilir. `<=` kullanılırsa yenileme döngüye girer.
- Seed yolu önbelleği düşürmüyor. Seed sonrası bir süreç yeniden başlatması yeter, çünkü genel damga devreye girer.
- FE'de iş yok. İstenirse 403 alınca bir kez yenileme yapılabilir, böylece menü de güncellenir.

### İş büyüklüğü

Küçük. 1 BE dilimi: damga, `OnTokenValidated`, 2–3 bütünleşik test (izin kaldır → sonraki istek 401 → yenileme → 403), `SECURITY_CONFIGURATION.md` güncellemesi. Seçenek A eklenirse 1 ayar satırı.

### Ürün kararı sorusu

"Yetki kaldırma anında etkili olsun; bunun için etkilenen kullanıcının oturumu arka planda bir kez yenilensin (D). Token ömrü de 30 dakikaya insin mi?" Öneri: D evet, ömür 30 dk.

### Hukuki ve güvenlik

- İşten ayrılan ya da yetkisi alınan personelin 60 dk boyunca hasta sahibi kişisel verisine ve düzeltme işlemlerine (`*.Correct`) erişebilmesi KVKK m.12 "uygun güvenlik düzeyi" açısından bir açık. `roadmap/HUKUKI-ONAY-LISTESI.md` C4'te "ertelendi" olarak geçiyor.
- D uygulanınca C4 notu güncellenmeli.
- Güvenlik incelemesi bulgusu O6 (`docs/SECURITY_REVIEW_2026-10.md` 44–47) kapanır.
