# ADR-031 — Hasta sahibi portalı ve mobil uygulama

## Durum

**KABUL EDİLDİ (2026-10-16, kullanıcı: "senin dediğin gibi olsun"):** teknoloji = ayrı Angular PWA, sonra Capacitor ile mağaza paketi (TypeScript; React Native/Flutter seçilmedi); v0 geliştirmesi **şimdi, ürün işleriyle paralel** başlar; marka = klinik adı + logo, alt bilgide Vetinity; uygulama/alan adı mağaza öncesi netleşir, o zamana dek geçici "Vetinity". AK-5 (hukuk görüşü, "Geliştirme varsayımı" ile beklenmeden) ve AK-7 (v2) dışında açık karar kalmadı. Önceki durum notu: **Taslak — öneri; "Açık kararlar" bölümü kullanıcı onayı bekler (2026-10-16).** Kabul edilmiş tek girdi kullanıcı kararıdır: hasta sahibi portalı ve mobil uygulama **zorunludur** (önceden Aşama 11 / P2 olarak ertelenmişti, yükseltilir). Diğer her madde öneridir; ürün kararı gerektiren yerler "açık karar" (AK-n) olarak işaretlidir ve karar verilmemiştir. İlgili: [ADR-021](ADR-021-kvkk-consent-form.md), [ADR-024](ADR-024-hukuki-metin-taslaklari.md), [ADR-025](ADR-025-hasta-listesi-aktif-tedavi-kvkk-ret.md), [ADR-029](ADR-029-surumlu-hukuki-kabul.md), [ADR-014](ADR-014-pilot-and-production-operations.md); backlog PORTAL-001…010, MOBILE-001…004, APPT-001, MSG-001/002.

## Bağlam

- Roadmap'te portal "kullanım ihtiyacı doğrulanır" diye P2, native mobil Aşama 12 (Future) idi; online randevu APPT-001 P1 (public sayfa) olarak duruyor ama hasta sahibi kimliği olmadan çalışan bir talep formu.
- Bugün hasta sahibi **hiçbir kimlikle sistemde yok**: `Client` yalnız klinik çalışanının gördüğü bir kayıt; hatırlatmalar e-posta ile gider, `RemindersOptedOut` ve KVKK Ret ([ADR-025](ADR-025-hasta-listesi-aktif-tedavi-kvkk-ret.md)) ile kapanır. Sürümlü kabul ([ADR-029](ADR-029-surumlu-hukuki-kabul.md)) yalnız klinik kullanıcıları içindir.
- Rakip gözlemi (problem odaklı; görünüm/akış kopyalanmaz): DaySmart PetCare — klinik panelinden **ayrı web yüzeyi**; ana ekranda yaklaşan ziyaret, aşı hatırlatması, açık fatura, hayvan kartları; hayvan profili (temel bilgi, kayıtlar, hatırlatmalar, ziyaretler); belge görüntüleme ve imza; bağlantı süresi dolumu ayarı ([daysmart.md](../competitors/daysmart.md), IDEA-017). E-Vet: SMS/e-posta şablonları, SMS geçmişi, WhatsApp Web yönlendirmesi; hasta sahibi uygulaması gözlenmedi. Bu belgenin ürün tasarımı bunlardan türetilmez; çözülen problem: *hasta sahibi klinikle telefonsuz iletişim kurabilsin, aşı/randevu/bakiye bilgisine kendisi ulaşsın, resepsiyon yükü azalsın*.

## Öneri

### K1 — Kim kullanır

**Hasta sahibi** (ana kullanıcı) ve **klinik çalışanı** (kullanıcı kararı, 2026-10-16: "çalışan da mobil uygulamayı kullanabilmeli; aynı internet sitesine mobilden girebildiği gibi"). İki ayrı yüzey kalır: hasta sahibi portalı (ayrı uygulama) ve klinik paneli. Çalışan, **mevcut klinik paneline telefonundan aynı adresten girer**; panel telefon genişliğinde tam kullanılabilir olmalıdır (şu anki "masaüstü/tablet öncelikli" kapsamı genişler) ve ana ekrana eklenebilir (PWA) olur. Çalışanın hasta sahibi portalına girişi yoktur; portalda yalnız davet gönderme, erişim yönetimi ve gelen talepleri işleme klinik panelinde yapılır. Çalışan için **ayrı mağaza uygulaması** kararı verilmedi (AK-1b).

Hasta sahibi iki sınıf kullanıcı üretir: (a) hesap açan (portal/uygulama); (b) hesap açmayan (klinik e-posta/SMS ile ulaşmaya devam eder). (b) için hiçbir işlev kaybolmaz.

### K2 — Temel senaryolar

| Senaryo | v0 | Sonra | Not |
|---|---|---|---|
| Hayvanlarım (ad, tür, ırk, doğum tarihi, mikroçip, kilo) | ✔ salt okunur | düzenleme talebi | Klinik kaydından türer |
| Randevularımı görme | ✔ | iptal/erteleme talebi | Yalnız gelecek + son geçmiş |
| Randevu talebi (yeni) | ✘ | ✔ v1 | Talep, onay klinikte (APPT-001 ile birlikte tasarlanır) |
| Aşı geçmişi ve yaklaşan aşı/kontrol | ✔ | PDF aşı karnesi | ADR-028 gecikme tanımı kullanılır |
| Bakiye ve ödeme geçmişi | ✔ yalnız tutar/durum | fatura/ekstre, online ödeme | Tutar görüntüleme; ödeme alma ayrı karar (AK-9) |
| Klinik bilgisi (adres, telefon, çalışma saati) | ✔ | harita/yol tarifi | |
| Klinikle mesaj | ✘ | ✔ v1/v2 | MSG-001/002; moderasyon ve acil uyarı metni gerekir (AK-7) |
| Bildirimler | ✔ e-posta | push, SMS | K7 |
| Belge/onam görüntüleme ve imza | ✘ | v2+ | PORTAL-005; hukuki geçerlilik araştırması |
| Reçete ve tedavi özeti | ✘ | ✔ v1 | AK-8 kararı (b); sade dil, klinik bazlı açma anahtarı, hukuki görüş (AK-5) sonrası |
| Muayene notu, lab, görüntü | ✘ | ✘ | AK-8 kararıyla kapsam dışı; yeniden açılırsa ayrı karar |

### K3 — Kimlik doğrulama ve müşteri hesabıyla bağ

Öneri:
- **Ayrı principal türü:** portal hesabı (`OwnerAccount`) personelden ayrıdır; personel kullanıcısı portala, hasta sahibi hesabı klinik paneline giremez (ayrı kimlik doğrulama şeması ve token hedef kitlesi; bkz. K6).
- **Klinik davetiyle bağ:** otomatik "telefon eşleşmesi" YOK (aile üyeleri/paylaşılan numara başka sahibin verisini sızdırabilir). Klinik, müşteri kartından "Portala davet et" der; davet tek kullanımlık, süreli (varsayılan 7 gün; DaySmart'ın bağlantı süresi ayarına benzer) bir bağlantı/kod üretir ve müşteri kartındaki telefon/e-postaya yollar. Sahip bağlantıyı açar, **telefona (veya e-postaya) gelen tek kullanımlık kodu** girer, hesabı oluşturur ve `Client` kaydına bağlanır.
- **Giriş:** parolasız (SMS veya e-posta tek kullanımlık kod) veya e-posta+parola — AK-2. Öneri: parolasız tek kullanımlık kod (mobilde sürtünme düşük, parola sızıntı yüzeyi yok); SMS maliyeti ve teslim sorunu için e-posta yedeği.
- **Bir hesap, birden çok klinik/müşteri kaydı:** hasta sahibi birden fazla Vetinity kliniğine gidebilir. Öneri: kişi bazlı tek hesap + klinik başına ayrı bağ (`OwnerAccount` ↔ `Client`, kiracı başına) — AK-3 (v0'da tek klinik gösterilse bile veri modeli buna hazır).
- **Bağ kopması:** klinik erişimi tek tıkla kapatabilir; müşteri kartı birleştirilir/silinirse bağ yeniden doğrulanır; telefon/e-posta değişince eski kodla giriş kapanır.
- Hesap güvenliği: kod deneme sınırı, kilitleme (SEC-001 ile aynı desen), kısa ömürlü erişim + yenileme jetonu, "tüm cihazlardan çıkış".

### K4 — KVKK etkisi

(Hukuki tavsiye değildir; [HUKUKI-ONAY-LISTESI](../roadmap/HUKUKI-ONAY-LISTESI.md) kapsamına eklenmelidir.)

- **Hangi veri:** hasta sahibinin kendi kimlik/iletişim verisi, hayvanın kimlik ve sağlık özeti (aşı, randevu), bakiye. v0'da klinik not, lab, görüntü ve reçete YOK (veri azaltma). Tüm okuma işlemleri denetim kaydına yazılır (kim, ne zaman, hangi kayıt; içerik değil).
- **Roller:** klinik veri sorumlusu, Vetinity veri işleyen (varsayım A6). Portal hesabının kendisi (giriş, cihaz jetonu, bildirim tercihi) için Vetinity'nin sorumlu mu işleyen mi olduğu **hukuki görüş ister** (AK-5); veri işleme sözleşmesi ve gizlilik politikasına portal eklemesi gerekir.
- **Aydınlatma/rıza:** ilk girişte (1) klinik aydınlatma metni (ADR-021/024) gösterilir, (2) Kullanım Şartları + Gizlilik'in **hasta sahibi varyantı** sürümlü kabul edilir — ADR-029 mekanizması (belge türü, sürüm, UTC zaman, silinmez kayıt, güncellenince yeniden kabul) hasta sahibi hesabına genişletilir; kabul eden kimlik = `OwnerAccountId`. (3) Push/SMS/e-posta bildirim tercihi ayrı ve geri alınabilir; ticari ileti ile işlemsel (randevu/aşı) ileti ayrı tutulur (İYS/ETK, AK-5).
- **Ret/opt-out uyumu:** KVKK "Ret" veya `RemindersOptedOut` olan müşteriye davet gitmez ve hatırlatma bildirimi üretilmez (ADR-025 ile tutarlı); hesap zaten varsa bildirim kanalı kapanır, hesap kapanmaz (AK-5).
- **Silme/erişim talebi:** portalda "Verilerimle ilgili talep" (erişim, düzeltme, silme) → klinikteki KVKK talep sürecine (ADR-029 taslağındaki talep süreci) düşer; klinik yanıtlar. Portal hesabını silme ayrı, kayıtlı klinik verisini silme klinik kararı ve mevzuat saklama süresine bağlıdır. Hesap silinince cihaz jetonları, bildirim tercihi ve oturumlar silinir; kabul kayıtları denetim için saklanır.
- **Çocuk/vekâlet:** küçük yaştaki sahip, ortak sahiplik: kapsam dışı; müşteri kaydındaki kişi tek sahip kabul edilir.

### K5 — Teknoloji seçenekleri

Kısıtlar: tek kod tabanı, mevcut Angular (vetinity-web) ve .NET backend ile uyum, küçük ekip, pilotun hızla hasta sahibiyle denenebilmesi.

| Seçenek | Artı | Eksi |
|---|---|---|
| **A. Yalnız PWA** (ayrı Angular uygulaması) | Mevcut yetkinlik; tek kod; mağaza süreci yok; en hızlı | iOS'ta push yalnız ana ekrana eklenmiş PWA'da çalışır; "mağazada yok" algısı; cihaz özellikleri sınırlı |
| **B. Angular + Capacitor** (A'nın üstüne sarmalayıcı) | Aynı kod tabanı PWA + iOS/Android paketi; yerel push, biyometrik kilit, mağaza | Mağaza hesapları, inceleme süreçleri, sürüm yönetimi; eklenti bakımı |
| C. Ionic (Angular) | B'ye benzer, hazır bileşen | Ek bağımlılık; UI dili kendi stilimizle çakışabilir |
| D. Flutter | Yerel his, iyi performans | Yeni dil/ekip, kod paylaşımı yok, ayrı backend istemcisi |
| E. React Native | Yerel his | Yeni yığın, kod paylaşımı yok |

**Öneri:** A ile başla, **B'ye evril**. Portal bir **ayrı Angular uygulaması** (aynı çalışma alanında paylaşılan tasarım kütüphanesi/API istemcisi; klinik paneliyle aynı paket değil — farklı hedef kitle, farklı paket boyutu ve güvenlik sınırı), mobil-öncelikli tasarlanır. Böylece v0 tarayıcıda yayına çıkar; push/mağaza gereksinimi netleşince aynı kod Capacitor ile sarılır. D/E önerilmez (ikinci kod tabanı). Not: iOS/Android mağaza ve push davranışları sürümle değişir; uygulama aşamasında güncel kaynaktan doğrulanmalıdır (bu belgede doğrulanmadı). Mağaza yayını isteği için AK-4.

### K6 — Backend API ayrımı

- **Ayrı yüzey:** portal uçları ayrı yol öneki ve ayrı denetleyici grubu (ör. `/api/portal/...`), ayrı kimlik doğrulama şeması ve token hedef kitlesi (audience); personel token'ı portalda, portal token'ı personel uçlarında **reddedilir** (testle sabitlenir).
- **Ayrı izin/rol:** personel izin kataloğuna karışmaz; portal işlevleri ilke olarak "yalnız kendi `Client` kayıtlarım" kapsamıdır (ownership kontrolü her uçta, tek yardımcıda).
- **Ayrı DTO:** personel DTO'ları yeniden kullanılmaz; her alan açıkça portal sözleşmesinde seçilir (sızıntıyı yapısal olarak önler). Sözleşme tek doğruluk kaynağı; önce backend.
- **Kiracı izolasyonu:** token'daki bağ listesinden kiracı/klinik belirlenir; her sorgu kiracı + müşteri filtresiyle çalışır; çapraz kiracı erişim testleri zorunlu (mevcut tenant filtresi desenine uyum). Genel arama/liste ucu yok; yalnız kimlik ile erişim (numaralandırma yok).
- **Koruma:** hız sınırı (IP + hesap), kod deneme sınırı, okuma denetim kaydı, yanıtta minimum alan, bakiye/ödeme uçlarında ek yetki kontrolü.
- **Klinik panel tarafı:** davet gönder/iptal, bağ durumu, erişimi kapat, portal talebi/mesaj gelen kutusu; mevcut izin kataloğuna yeni portal yönetim izni.

### K7 — Bildirim kanalı

| Kanal | Rol | Notlar |
|---|---|---|
| E-posta | v0 varsayılan | Mevcut altyapı (ADR-014 K5); doğrulama kodu ve hatırlatma |
| SMS | doğrulama kodu ve kritik hatırlatma | Sağlayıcı seçimi, maliyet/klinik başına kota, teslim durumu, İYS/ETK ayrımı (INT-003, APPT-023); AK-6 |
| Push | v1 (PWA web push veya Capacitor yerel push) | Cihaz jetonu depolama, onay izni, KVKK tercihi; AK-6 |
| WhatsApp | kapsam dışı | Ayrı karar (roadmap Aşama 11) |

Kanal seçimi kullanıcı tercihine bağlıdır; her bildirim türü için "kimin için, hangi kanal, hangi sırayla" kuralı tek yerde (backend) yaşar. Bildirim metni minimum veri taşır (hayvan adı ve tarih; teşhis/tedavi yok).

### K8 — Çıkış planı

- Portal **klinik bazında kapatılabilir** (özellik bayrağı); kapatılınca hesaplar silinmez, erişim durur.
- Veri taşınabilirliği: hasta sahibi kendi verisini dışa aktarabilir (aşı karnesi PDF dahil); hesap silme talebi K4'e göre.
- Teknoloji bağımlılığı düşük: PWA + Capacitor sarmalayıcı kaldırılsa web çalışmaya devam eder; mağaza hesapları **şirket adına** açılır (kişisel hesap değil, AK-4).
- Sağlayıcı bağımlılıkları (SMS, push) arayüz arkasında; değiştirilebilir.
- Portal başarısız olursa klinik iş akışı etkilenmez (portal çekirdeğe yazmaz; v0 salt okunur ve kendi okuma modelini kullanabilir).

## Aşamalı teslim önerisi

| Aşama | İçerik | Giriş koşulu |
|---|---|---|
| **P0 — Hazırlık** | Hukuki: aydınlatma/portal metin varyantı ve AK-5 görüşü; ADR kabulü; API sözleşmesi taslağı | Bu ADR'nin kabulü |
| **v0 — En küçük değerli dilim** (AK-11: şimdi, paralel) | Davetle hesap + e-posta kodu veya e-posta + parola (SMS yok, AK-6); hayvanlarım; randevularım (salt okunur); aşı geçmişi ve yaklaşan aşı; bakiye (salt okunur); klinik bilgisi; e-posta bildirimi; sürümlü kabul; erişimi kapatma; PWA | Pilot kliniğin canlıya çıkması (ADR-014) ve go-live koşulları |
| **v1** | Randevu talebi (klinik onaylı); reçete ve tedavi özeti; push bildirimi; fatura/ekstre PDF; aşı karnesi PDF; hesap/veri talebi; Capacitor ile mağaza uygulaması | v0 kullanım verisi |
| **v2** | Klinikle mesajlaşma; belge/onam imzası; online ödeme; çok klinik görünümü | Hukuki geçerlilik + ödeme kararı |
| **Ayrı hat (hasta sahibi portalından bağımsız)** | Klinik panelinin telefonda tam kullanımı (mobil responsive, PWA); ekran bazlı denetim ve düzeltme | Kullanıcı kararı AK-1; zamanı AK-11'e bağlı değil, pilotla paralel |

Her aşama kendi backlog kaydı ve kabul ölçütleriyle gelir; v0 başarı ölçütü (öneri): davetlerin kabul oranı, aylık etkin kullanıcı, telefonla sorulan "randevum ne zaman / aşım ne zaman" çağrılarında düşüş (klinik beyanı).

## Açık kararlar (kullanıcıya sorulacak)

| # | Soru | Seçenekler | Öneri |
|---|---|---|---|
| AK-1 | "Mobil uygulama" kimin için? | **KARAR (kullanıcı, 2026-10-16): hasta sahibi + çalışan; çalışan mobilden aynı siteye girer.** | Kapandı. **AK-1b KARAR (kullanıcı, 2026-10-16, öneri kabul): çalışan için mobil tarayıcı + ana ekrana eklenen PWA yeter, ayrı mağaza uygulaması yok;** pilotta ihtiyaç görülürse yeniden açılır |
| AK-2 | Hasta sahibi girişi | (a) SMS/e-posta tek kullanımlık kod; (b) e-posta + parola; (c) ikisi | **KARAR (kullanıcı, 2026-10-16): ikisi birden** — kullanıcı tek kullanımlık kodla (SMS/e-posta) veya e-posta + parolayla girebilir. Kapandı. Sonuç: parola saklama, sıfırlama ve zayıf parola kuralları da kapsama girer (SEC-001 kilitleme ile birlikte) |
| AK-3 | Hesap kapsamı | (a) kişi başına tek hesap, birden çok klinik; (b) klinik başına ayrı hesap | **KARAR (kullanıcı, 2026-10-16): proje zaten çoklu klinik tasarımlı → (a) kişi başına tek hesap, klinik başına bağ.** Kapandı. v0'da tek klinik gösterimi ayrı bir ürün kararı değil, yalnız ilk dilim sınırı |
| AK-4 | Dağıtım | **KARAR (kullanıcı, 2026-10-16): hasta sahibi uygulaması mağazada olacak** (PWA + Capacitor ile Google Play/App Store); mağaza hesabı şirket adına | Kapandı. v0 PWA, mağaza v1'de. Geliştirici hesaplarını açmak kullanıcı işi |
| AK-5 | Hukuki çerçeve | Portal hesabında Vetinity rolü (sorumlu/işleyen), İYS/ETK, silme–saklama süresi, vekâlet | Hukuk danışmanı görüşü; ADR-024 kapsamına eklenir |
| AK-6 | SMS sağlayıcısı ve maliyet modeli | (a) klinik kendi hesabı; (b) Vetinity havuzu, pakete dahil/ek ücret; push ayrı | **KARAR (kullanıcı, 2026-10-16): v0'da SMS yok, yalnız e-posta.** Kapandı (v0 için). SMS sağlayıcısı ve maliyet modeli SMS eklenmeden önce yeniden açılır. Sonuç: v0 kodu e-postayla gelir; telefon doğrulaması ve SMS hatırlatma sonraya kalır |
| AK-7 | Mesajlaşma politikası | Acil durum uyarısı, yanıt süresi beklentisi, saklama | v2'ye ertelenir; karar o zaman |
| AK-8 | Sağlık verisi görünürlüğü | (a) yalnız aşı/randevu/bakiye; (b) + reçete/tedavi özeti; (c) + lab/görüntü/not | **KARAR (kullanıcı, 2026-10-16): (b) aşı/randevu/bakiye + reçete ve tedavi özeti; lab, görüntü, muayene notu görünmez.** Kapandı. Sıralama notu (ajan, onay bekler): v0'da aşı/randevu/bakiye, reçete ve tedavi özeti v1'de |
| AK-9 | Ödeme | Bakiye gösterimi mi, online ödeme mi, hangi sağlayıcı | **KARAR (kullanıcı, 2026-10-16): yalnız bakiye gösterimi.** Kapandı; online ödeme ayrı ADR ile |
| AK-10 | Marka | Klinik markalı mı (kendi adı/logosu), Vetinity markalı mı | **KARAR (kullanıcı, 2026-10-16, öneri kabul): klinik adı + logo, alt bilgide Vetinity.** Kapandı |
| AK-11 | v0 zamanlaması | Pilot ve go-live'dan sonra mı, paralel mi? | **KARAR (kullanıcı, 2026-10-16, öneri kabul): şimdi, ürün işleriyle paralel.** Backend önce (portal API), sonra Angular PWA; altyapı/VPS işleri hariç (kullanıcı söyleyecek). Kapandı |
| AK-12 | Başlık/ad | Portal ve uygulama adı, alan adı | **KARAR (kullanıcı, 2026-10-16, öneri kabul): geçici "Vetinity"; ad ve alan adı mağaza öncesi netleşir.** Kapandı |

## Sonuçlar

- Backlog: PORTAL-001 öncelik P2→P1; PORTAL-006…010 ve MOBILE-001…004 eklenir. Roadmap: portal/mobil Aşama 11/12'den "pilot sonrası zorunlu" hattına taşınır (v0 zamanı AK-11).
- Backend (ileride, ayrı iş): `OwnerAccount`, davet, bağ, portal kimlik şeması, portal API, kabul kayıtlarının hasta sahibine genişletilmesi, bildirim hizmeti; migration kullanıcı onayıyla.
- Frontend (ileride): ayrı mobil-öncelikli Angular portal uygulaması; klinik panelinde davet/erişim yönetimi.
- Kod, migration, VPS/altyapı bu belgeyle başlamaz; kabul sonrası iş sırası WORKFLOW'a göre önce backend sözleşmesi.
- Riskler: hukuki görüş gecikmesi (AK-5), SMS maliyeti, hesap–müşteri yanlış eşleşme (davetle önlenir), iki yüzeyin bakım yükü, mağaza inceleme süreleri.
