# Kullanıcı dostu olma denetimi (2026-11-15)

**Durum:** Denetim ve öneri. Kod değiştirilmedi; push, merge, deploy yok. Ürün kararı gerektiren maddeler **(karar)** ile işaretli.

**Soru:** Sekreter, hekim, klinik sahibi ve hasta sahibi kılavuz okumadan, en az tıklama ile, kaybolmadan işini yapabiliyor mu?

**Kısa cevap:** Temel iyi (arama, geliş kaydı, muayene açma, hızlı satış, portal talep formu). Asıl kayıplar dört yerde: seçicide yerinde ekleme yok, dolu form uyarısız kayboluyor, pasif Kaydet nedenini söylemiyor, sık formlarda varsayılan eksik.

## Yöntem ve sınırlar

- **Tarayıcıda denendi [T]:** Panel ve portal yerelde çalıştırıldı (frontend `main` `da734556`, backend `main`, yerel veritabanı). Örnek Veteriner Kliniği (sentetik veri) ve boş bir deneme kliniği ile gezildi. Genişlikler 1440, 768 ve 375 px; açık ve koyu tema. Taşma, dokunma hedefi, yazı boyutu ve kontrast sayfada ölçüldü.
- **Koddan okundu [K]:** Dört alt ajan kodu taradı (seçiciler, boş durum ve mesajlar, veri kaybı/tutarlılık/yetki, portal ve klavye). Sayılar onların sayımıdır; ilk 10 bulgunun dosya ve satırlarını ayrıca açıp doğruladım.
- **Denenmedi:** Sekreter ve Veteriner rolüyle giriş (yalnız yönetici hesabı vardı); gerçek telefon ve ekran klavyesi; ekran okuyucu; canlı ortam hızı; portalda talebin gönderilmesi ve klinik onayı.
- 2026-11-09 görsel tasarım denetimi (renk, tipografi, düğme hiyerarşisi) burada tekrarlanmadı; yalnız hâlâ geçerli olanlara değinildi.

Kısaltmalar: `FE` = `C:\FrontEnd\veteriner-frontend\src\app`, `P` = `C:\FrontEnd\veteriner-frontend\projects\portal\src\app`, `BE` = `C:\Users\DELL\source\repos\Veteriner\src`, `G` = ekran görüntüsü klasörü `C:\Users\DELL\AppData\Local\Claude-Data\claude_pzs8sxrjxfjjc\side-session-notes\local_8c67d907-b45c-4512-aa03-6c596483533c\kullanici-dostu-denetim\`.

Önem: Yüksek / Orta / Düşük. Büyüklük: Küçük (1 güne kadar) / Orta (birkaç gün) / Büyük (hafta ve üstü).

---

## 0. En önemli 10 bulgu

| # | Bulgu | Kim | Önem | Büyüklük | Ayrıntı |
|---|---|---|---|---|---|
| 1 | **Seçicide yerinde ekleme yok: 18 yerde.** Ürün kategorisi, tür (3 diyalog), ürün (6 yer), yatış bölümü ve odası, gelir/gider türü, randevu nedeni, şablon. Müşteri, hasta, tür, ırk ve tanı sözlüğünde var; desen hazır. | Hepsi | Yüksek | Orta | O1 |
| 2 | **Dolu form uyarısız kayboluyor.** Menüye basınca, geri gelince ya da sekme kapanınca hiçbir uyarı yok (29 sayfa). Hızlı kayıt diyalogları dışarı tıklayınca kapanıp sıfırlanıyor (6 yer). | Sekreter, hekim | Yüksek | Orta | O2, H4 |
| 3 | **Kaydet pasif, nedenini söylemiyor: 54 dosya.** Eksik alan işaretlenmiyor, düğmede ipucu yok. Kullanıcı neden basamadığını arıyor. | Hepsi | Yüksek | Orta | O3 |
| 4 | **Sık formlarda varsayılan eksik.** Randevuda tarih ve tür boş, tek hayvanı olan müşteride hasta seçili gelmiyor (11 tık). Ödemede tarih boş, borcun tamamı tek tıkla seçilemiyor (4 ücret için 9 tık). | Sekreter | Yüksek | Küçük | H1, H2 |
| 5 | **Boş liste yanlış yönlendiriyor: 18 liste.** Hiç kayıt yokken de "Kayıt bulunamadı. Arama veya filtreleri değiştirerek tekrar deneyin." yazıyor; ilk adım düğmesi yok. | İlk haftadaki herkes | Yüksek | Küçük | H5 |
| 6 | **Takvim bir saat ızgarası değil.** Gün gün kart listesi; boş saat, hekim ve gün adı görünmüyor, takvimden randevu açılamıyor. | Sekreter | Yüksek | Büyük | B1 |
| 7 | **Klavye ile hızlı çalışılamıyor.** 10 diyalogda Enter kaydetmiyor; sayfa formlarında ilk alana odak yok (yeni müşteride ilk alana 18 Tab). | Sekreter | Yüksek | Küçük | H3, H14 |
| 8 | **Portalda ana iş ana sayfada yok.** Randevu talebi 3 dokunuş derinde; gecikmiş aşı kartı "arayın" diyor ama ne arama ne talep düğmesi var; klinik telefonu girilmemişse numara hiç yok. | Hasta sahibi | Yüksek | Küçük | H7, H9 |
| 9 | **Hasta sahibi doldurulmamış bir aydınlatma metni görüyor.** İlk girişte "[klinik adresi]", "[klinik telefonu]" yer tutucuları ve kliniğe yazılmış "hukuk danışmanınızca… değiştirilmelidir" notu çıkıyor. | Hasta sahibi, klinik sahibi | Yüksek | Küçük | H8 |
| 10 | **İngilizce ve teknik hata metinleri ekrana çıkabiliyor.** Backend'de 48 İngilizce iş kuralı ve 39 İngilizce doğrulama metni var; eşlenmeyen kodda sunucu metni aynen gösteriliyor. Yetkisiz sayfa da genel sitenin "Sayfa bulunamadı" ekranına atıyor. | Hekim, sekreter | Yüksek | Orta | O4, H6 |

---

## 1. Hızlı kazanımlar (1 gün içinde)

### H1. Sık formlarda varsayılan eksik: 9 alan
- **Ekran:** Yeni randevu `/panel/appointments/new`, tedavi, reçete, yatış, mal kabul, kasa hareketi.
- **Kim:** Sekreter, hekim.
- **Sorun [T]:** Randevuda tarih, saat ve tür boş geliyor; tek hayvanı olan müşteri seçilince hasta seçili gelmiyor (Can Öztürk, tek hayvanı Luna, alan boş kaldı). Bugünü seçince saat alanı pasif kalıyor ("Seçilen gün için uygun randevu saati bulunmuyor"), sonraki uygun gün önerilmiyor. **[K]:** Tedavi, reçete ve yatış tarihi boş ve zorunlu; mal kabulde geliş tarihi boş; tek gelir/gider türü olsa da seçili gelmiyor.
- **Öneri:** Tarih = bugün (saat geçmişse ilk uygun gün ve ilk boş saat); tür = "Muayene"; tek hayvan, tek tür, tek bölüm otomatik seçilsin; hekim = oturumdaki hekim (geliş diyaloğundaki kural).
- **Önem / büyüklük:** Yüksek / Küçük.
- **Dosya:** `FE\features\appointments\pages\appointment-new-page\appointment-new-page.component.ts:195-202`; `FE\entities\procedure\components\treatment-form.component.ts:208`; `prescription-form.component.ts:259`; `hospitalization-form.component.ts:266`; `FE\features\inventory\forms\goods-receipt-form.factory.ts:54`; `FE\features\reports\cash-registers\components\cash-movement-forms.component.ts:122-136`.
- **Görüntü:** `G\21-randevu-musteri-secildi.png`, `G\22-randevu-bugun-saat-pasif.png`, `G\23-randevu-dolu.png`.

### H2. Ödeme al: borcun tamamı tek tıkla alınamıyor
- **Ekran:** `/panel/payments/new`.
- **Kim:** Sekreter.
- **Sorun [T]:** Borçlu müşteride her ücret için ayrı "Tamamı" bağlantısına basmak gerekiyor (4 ücret, 4 tık). Toplam borç en üstte yazmıyor. Ödeme tarihi boş ve zorunlu. Bugün ekranındaki "Müşteri borcu ₺1.600,00" yazısı tıklanmıyor; ödeme "…" menüsünün içinde.
- **Öneri:** Üstte "Toplam borç ₺1.600 · Tamamını al" düğmesi; tarih = şimdi; Bugün'deki borç yazısı ödeme ekranını açsın.
- **Önem / büyüklük:** Yüksek / Küçük.
- **Dosya:** `FE\features\payments\pages\payment-new-page\payment-new-page.component.ts:328-331`; `FE\features\visits\pages\today-page\today-page.component.html` (borç etiketi).
- **Görüntü:** `G\m-odeme-al.png`, `G\24-bugun-satir-menusu.png`.

### H3. Diyaloglarda Enter kaydetmiyor: 10 yerde
- **Kim:** Sekreter, hekim.
- **Sorun [T]:** Hızlı müşteri ve randevusuz geliş diyaloğunda Enter'a basınca bir şey olmuyor. Kaydet düğmesi formun dışında ve `type="button"`.
- **Liste [K]:** quick-client:69, quick-pet:106, quick-species:82, visit-arrival:134, visit-correction:82, charge-correction:80, charge-suggestion-convert:72, administration-create:132, appointment-no-show:43, examination-addendum:56. Geliş diyaloğundaki hızlı kayıt bölümünün kendi formu da yok (`visit-quick-registration.component.ts:43-108`).
- **Öneri:** Düğmeye `type="submit" form="<form-id>"`; form kimlikleri zaten var.
- **Önem / büyüklük:** Yüksek / Küçük.
- **Dosya:** `FE\entities\client\components\quick-client-dialog.component.ts:29,69`.
- **Görüntü:** `G\42-hizli-musteri-diyalogu.png`.

### H4. Hızlı kayıt diyalogları dışarı tıklayınca kapanıyor: 6 yerde
- **Kim:** Sekreter (telefonda konuşurken).
- **Sorun [T]:** Hızlı müşteri diyaloğunda ad ve telefon yazıp dışarı tıkladım; diyalog uyarısız kapandı, yeniden açınca form boştu.
- **Liste [K]:** quick-client:28, quick-pet:31, quick-species:23, quick-breed:24, e-document-issue:36, report-saved-filters:71 (`dismissableMask=true`).
- **Öneri:** Form doluyken dışarı tıklama kapatmasın ya da "Vazgeçilsin mi?" diye sorsun. Hazır yardımcı var: `closeWithUnsavedChangesCheck` (`FE\shared\ui\unsaved-changes\unsaved-changes.ts:8-39`).
- **Önem / büyüklük:** Yüksek / Küçük.

### H5. Boş liste yanlış yönlendiriyor: 18 listede
- **Ekran:** Müşteriler, hastalar, randevular, muayeneler, aşılar, tedaviler, reçeteler, lab, görüntüleme, yatışlar, ödemeler, ürünler, stok hareketleri, tür, ırk, davetler, kurum üyeleri, raporlar.
- **Kim:** İlk haftasındaki sekreter ve klinik sahibi.
- **Sorun [T]:** Boş klinikte Randevular, Muayeneler ve Ürünler "Kayıt bulunamadı. Arama veya filtreleri değiştirerek tekrar deneyin." diyor; filtre yokken de. İlk adımı başlatan düğme yok. Aramada sonuç çıkmayınca da ("zzzz") "Filtreleri temizle" ya da "Bu adla yeni müşteri ekle" yok.
- **Öneri:** İki ayrı durum: "Henüz randevu yok" + "İlk randevuyu oluştur" düğmesi; "Bu aramaya uyan kayıt yok" + "Filtreleri temizle". Örnek: hatırlatma geçmişi (`reminder-logs-page.component.ts:108-115`) ve takvim (`appointments-calendar-page.component.ts:71-75`) bunu doğru yapıyor.
- **Önem / büyüklük:** Yüksek / Küçük (metin) – Orta (düğmeler).
- **Dosya:** `FE\shared\copy\panel-tr.ts:6-7`; `FE\features\clients\pages\clients-list-page\clients-list-page.component.ts:75` ve benzerleri.
- **Görüntü:** `G\bos-randevular.png`, `G\bos-urunler.png`, `G\bos-muayeneler.png`, `G\31-musteriler-bos-arama.png`.

### H6. Yetkisiz sayfa "Sayfa bulunamadı" diyor (karar)
- **Kim:** Sekreter, hekim.
- **Sorun [K]:** 95 rota korumasının hepsi `/notfound` adresine gönderiyor. Bu, panelin dışındaki genel 404 ekranı ("Paketler", "Giriş sayfası" bağlantılı). Kullanıcı yetkisi olmadığını değil, sayfanın olmadığını sanıyor. Tarayıcıda rol hesabıyla denenmedi.
- **Öneri:** Panel içinde "Bu sayfa için yetkiniz yok. Yöneticinize başvurun." ekranı; menü ve üst çubuk yerinde kalsın. Panelde bilinmeyen adres için bunu yapan ekran zaten var (`G\32-panel-404.png`).
- **Önem / büyüklük:** Yüksek / Küçük.
- **Dosya:** `FE\pages\notfound\notfound.ts:19-49`; örnek koruma `FE\features\charges\routes\charges.routes.ts:9`.

### H7. Portal: ana iş ana sayfada yok
- **Ekran:** Portal `/`, `/pets/:id`, `/appointments/requests`.
- **Kim:** Hasta sahibi.
- **Sorun [T]:** Randevu talebi yolu: Randevular → Randevu talepleri → Yeni randevu talebi (3 dokunuş). Ana sayfada düğme yok. Gecikmiş aşı kartı "Randevu için kliniğinizi arayabilirsiniz" diyor; dokununca açılan hayvan sayfasında hiçbir eylem yok. Online talep kapalıyken "telefonla arayabilirsiniz" yazıyor, arama düğmesi yok. (2026-11-09'da da yazılmıştı; düzelmemiş.)
- **Öneri:** Ana sayfanın üstüne "Randevu talep et" birincil düğmesi (klinik talep almıyorsa "Kliniği ara"). Gecikmiş aşı kartında ve aşı satırında aynı iki eylem; talep formu hayvanı önceden seçili açsın. **(karar: neden de önceden seçilsin mi?)**
- **Önem / büyüklük:** Yüksek / Küçük (düğmeler) – Orta (ön seçim).
- **Dosya:** `P\features\home\portal-home.component.html:15-72`; `P\features\pets\portal-pet-detail.component.html:54-70`; `P\features\booking\portal-appointment-request.component.html:9-15`; `portal-appointment-request.component.ts:87`.
- **Görüntü:** `G\p03-ana-sayfa.png`, `G\p10-hayvan-detay.png`, `G\p06-talep-yeni.png` (kapalı durum).

### H8. Hasta sahibi doldurulmamış aydınlatma metni görüyor
- **Ekran:** Portal `/accept` (davet kabulünden hemen sonra).
- **Kim:** Hasta sahibi; itibarı etkilenen klinik sahibi.
- **Sorun [T]:** Klinik metni düzenlememişse varsayılan metin aynen gösteriliyor: en üstte "Bu metin hukuk danışmanınızca onaylanmış aydınlatma metniyle değiştirilmelidir.", içinde "Adres: [klinik adresi]; Telefon: [klinik telefonu]; E-posta: [klinik e-postası]; Vergi/ticaret sicil bilgisi: [varsa]". Aynı not açık rıza formu varsayılanında da var. Bu, "taslak/hukukçu ibaresi konmaz" kararıyla da çelişiyor (2026-11-09).
- **Öneri:** Notu varsayılan metinden çıkar. Adres, telefon ve e-postayı klinik kaydından doldur; boş olanı cümleden düşür. Klinik sahibine Ayarlar > KVKK metinleri'nde "eksik bilgi var" uyarısı göster.
- **Önem / büyüklük:** Yüksek / Küçük.
- **Dosya:** `BE\Backend.Veteriner.Application\Clinics\KvkkFormTemplate\ClinicKvkkFormTemplateDefaults.cs:33,52,57`.
- **Görüntü:** `G\p02-davet-sonrasi.png`.

### H9. Klinik telefonu yoksa portal çıkmaza giriyor
- **Kim:** Hasta sahibi.
- **Sorun [T]:** Örnek klinikte telefon girilmemiş. Portal beş yerde "kliniği arayın" diyor (gecikmiş aşı, bakiye, çalışma saatleri, talep kapalı, acil uyarısı) ama Kliniğim sayfasında yalnız "Ankara" yazıyor; hiçbir `tel:` bağlantısı yok.
- **Öneri:** Portal ya da online randevu açılırken telefon zorunlu olsun. Online randevu ayarındaki "Kurulum kontrolü" bunu zaten gösteriyor ("Telefon yok… Telefonu ekle"); aynı uyarı portal ayarına ve ilk hafta rehberine de gelsin. Telefon yoksa "arayın" cümleleri gizlensin.
- **Önem / büyüklük:** Orta / Küçük.
- **Görüntü:** `G\p08-klinik.png`, `G\p11-bakiye.png`, `G\50-online-randevu-ayari.png` (iyi örnek).

### H10. Aynı iş farklı adlarla: 7 desen
- **Kim:** Hepsi.
- **Sorun [T] ve [K]:**
  - **İptal / Vazgeç:** Sayfa formlarında "İptal", diyaloglarda çoğunlukla "Vazgeç", 8 diyalogda yine "İptal" (quick-client, quick-pet, quick-species, quick-breed, visit-arrival:133, stock-movement-create:152, report-saved-filters:91, appointment-new:156). "İptal" düğmesi "Randevuyu iptal et" ile karışıyor.
  - **Ödeme Oluştur / Ödeme al:** 7 yerde "Ödeme Oluştur" (examination-detail:195, hospitalization-detail:151,153, treatment-detail:129,134, prescription-detail:138,142), 2 yerde "Ödeme al".
  - **Hayvan / Hasta:** 9 yerde "Hayvan" (ör. `appointment-requests-page.component.ts:84` sütun başlığı, `waitlist-entry-dialog.component.ts:47`). "Süzgeç" düzelmiş, görünür kullanım yok.
  - **Müşteri / Sahip:** Formlarda "Müşteri", Bugün tablosunda "Sahip" (`today-page.component.html:163,308`). **(karar)**
  - **Büyük harf:** "Yeni Müşteri", "Yeni Hasta", "Yeni Randevu", "Yeni Ödeme", "Yeni Ücret", "Randevu Türü", "Randevu Takvimi" kelime başı büyük; "Yeni ürün", "Yeni müşteri ekle" cümle düzeninde.
  - **(isteğe bağlı) / (opsiyonel):** 28'e 8; aynı geliş diyaloğunda ikisi yan yana.
  - **Para birimi:** "(TL)", "(₺)", "TRY" üçü de etikette; ayrıca "Güncelle" 2 yerde (client-edit:100, species-form:100), "Pasifleştir" 5 / "Pasife al" 4 yerde.
- **Öneri:** Tek sözlük: Kaydet; formdan çıkış "Vazgeç", kayıt iptali "… iptal et"; "Ödeme al"; "Hasta"; cümle düzeni; "(isteğe bağlı)"; "₺". Sözlük `FE\shared\copy\panel-tr.ts` içinde yaşasın.
- **Önem / büyüklük:** Orta / Küçük.
- **Görüntü:** `G\m-gelis-diyalogu.png`, `G\m-takvim.png`.

### H11. Arayüzde teknik ifade: 9 yerde
- **Kim:** Klinik sahibi.
- **Sorun [K]:** "Backend bu koleksiyonu boş döndürdü." (`tenant-member-detail-page.component.ts:130,267`), "tenant panelinden" (`panel-tr.ts:140,146`), "güncelleme API'si" (`breed-form-page.component.ts:49`), "…backend'de tutulur" (`client-detail-page.component.ts:219`), "API adresini…" (`core\auth\auth-error.utils.ts:110`), "(token veya inviteId eksik)" (`tenant-invites.service.ts:167`), "Kayıt kimliği: {GUID}" (`import-rollback-page.component.ts:79`).
- **Öneri:** Kullanıcı diline çevir ya da kaldır.
- **Önem / büyüklük:** Orta / Küçük.

### H12. Onaysız kaldırma: 4 yerde; iki "Vazgeç" düğmesi: 1 yerde
- **Kim:** Klinik sahibi, muhasebe.
- **Sorun [K]:** Üye detayında rol ve klinik "Kaldır" onaysız (`tenant-member-detail-page.component.ts:143,286`); klinik "Pasife al" onaysız (`clinic-detail-page.component.ts:135`); site sihirbazında görsel "Sil" onaysız (`clinic-site\builder\content-step.component.ts:238`). e-Belge "Hatalı belgeden vazgeç" diyaloğunda onay düğmesi de ret düğmesi de "Vazgeç" (`e-documents-page.component.ts:280`).
- **Öneri:** Diğer yerlerdeki onay deseni; onay düğmesi "Belgeyi geçersiz say". Onay metinlerinin geri kalanı iyi: hiç "Emin misiniz?" yok, düğmeler eylem adını taşıyor.
- **Önem / büyüklük:** Yüksek / Küçük.

### H13. Kayıttan sonra onay yok: 4 ekranda
- **Kim:** Sekreter.
- **Sorun [K]:** Randevu oluşturma (`appointment-new-page.component.ts:358`), ücret (`charge-new-page.component.ts:361`, listeye sessizce dönüyor), ürün oluşturma ve düzenleme (`product-create-page.component.ts:216`, `product-edit-page.component.ts:300`) onay göstermiyor. Diğer ekranlar "kaydedildi" bandı gösteriyor. Tarayıcıda kayıt oluşturulmadığı için denenmedi.
- **Öneri:** Hepsinde aynı bant. Toast başlığı da tek olsun ("Tamam" 21, "Kaydedildi" 6, "Bilgi" 6 yerde).
- **Önem / büyüklük:** Yüksek / Küçük.

### H14. Sayfa formlarında ilk alana odak yok
- **Kim:** Sekreter.
- **Sorun [T]:** Yeni müşteri, hasta, randevu, muayene, ödeme, ücret, ürün ve aşı sayfaları açıldığında odak hiçbir alanda değil. Yeni müşteride "Ad soyad" alanına sayfa başından 18 Tab ile ulaşıldı. Panelde "içeriğe atla" bağlantısı yok (portalda var). Hızlı satış ve diyaloglar doğru: odak ilk alanda.
- **Öneri:** Sık formlarda ilk alana odak; panel kabuğuna "İçeriğe geç" ve `<main>`.
- **Önem / büyüklük:** Orta / Küçük.
- **Dosya:** `FE\features\clients\pages\client-new-page`, `appointment-new-page`, `payment-new-page`; `FE\layout`.

### H15. Bugün ekranında üç küçük eksik
- **Kim:** Sekreter.
- **Sorun [T]:** (a) Geliş diyaloğundaki arama sonucu "Boncuk — Kedi · Sahip: Zeynep Çelik" yazıyor; telefon yok. Aynı adlı iki müşteri ayırt edilemez (genel aramada telefon ve mikroçip var). (b) Önceki günden açık gelişte yalnız "Geliş 21:40" yazıyor; tarih yok, bekleme "150 sa 8 dk". (c) Telefonda ilk hafta kartı ve açık işler ilk ekranı dolduruyor; ilk bekleyen hasta ancak 885 px aşağıda.
- **Öneri:** Sonuç satırına telefon; önceki gün gelişinde tarih; telefonda rehber kartı tek satıra insin.
- **Önem / büyüklük:** Orta / Küçük.
- **Görüntü:** `G\03-randevusuz-gelis-arama.png`, `G\dk-bugun.png`, `G\m-bugun.png`.

### H16. Portal girişinde iki küçük sürtünme
- **Kim:** Hasta sahibi.
- **Sorun [T]:** Kod istenince odak e-posta alanında kalıyor, kod alanına geçmiyor. 6 hane girilince kendiliğinden giriş yapılmıyor. **[K]:** Tek hayvanı olan sahipte talep formunda hayvan seçili gelmiyor.
- **Öneri:** Kod alanına odak, 6 hanede otomatik doğrulama, tek hayvanı otomatik seç.
- **Önem / büyüklük:** Orta / Küçük.
- **Dosya:** `P\auth\portal-login.component.ts:104-109`; `P\features\booking\portal-appointment-request.component.ts:87,129-130`.
- **Görüntü:** `G\p13-kod-ekrani.png`.

### H17. Müşteri telefonu: rehber "zorunlu" diyor, form istemiyor (karar)
- **Kim:** Sekreter.
- **Sorun [T]:** İlk hafta rehberi "telefon numarası zorunludur" diyor; yeni müşteri formunda yalnız ad yazınca Kaydet açılıyor. Telefon her biçimde kabul ediliyor ("5321112233", "0532 111 22 33", "532-111-22-33") ve düzeltilmiyor; hata metni beklenen biçimi söylemiyor ("Geçerli bir telefon numarası girin.").
- **Öneri:** Kural tek olsun (hızlı kayıtta zorunlu; tam formda da zorunlu ya da rehber metni düzelsin). Alandan çıkınca "0532 111 22 33" biçimine çevir; hata metnine örnek ekle.
- **Önem / büyüklük:** Orta / Küçük.
- **Dosya:** `FE\entities\first-week-guide\utils\first-week-guide.steps.ts:57`; `FE\features\clients\utils\client-upsert.validation.utils.ts:21`.
- **Görüntü:** `G\20-musteri-form-dogrulama.png`.

### H18. Yasal onay penceresi yazarken araya giriyor
- **Kim:** Metin sürümü değişince herkes.
- **Sorun [T]:** "Hukuki metinler güncellendi" penceresi sayfa açıldıktan birkaç saniye sonra (yerelde yaklaşık 7 sn) çıkıyor. O arada açtığım geliş diyaloğunun üstüne geldi; alttaki diyalog tıklanamaz oldu, yarım kalan iş bölündü. Canlıdaki gecikme ölçülmedi.
- **Öneri:** Onay durumu panel kabuğu çizilmeden önce okunsun.
- **Önem / büyüklük:** Orta / Küçük.
- **Dosya:** `FE\features\legal-acceptance\components\legal-acceptance-gate.component.ts:28,78`.
- **Görüntü:** `G\06-yasal-onay-kapisi.png`.

### H19. Diğer küçükler
| Sorun | Kaynak | Dosya | Önem |
|---|---|---|---|
| Hızlı satış sekme başlığı genel site başlığı ("Vetinity — Veteriner klinik programı…") | [T] | `FE\features\sales\routes\sales.routes.ts:19` | Düşük |
| Takvimde gün başlığı yalnız tarih ("02.11.2026"); gün adı yok. Aynı ekranda iki "Yeni randevu" düğmesi. "Bekleyen talepler (0)" sıfırken de birincil renkte. | [T] | `FE\features\appointments\pages\appointments-calendar-page` | Düşük |
| Liste satırına tıklamak açmıyor; yalnız ad bağlantısı ve göz simgesi (telefonda ad bağlantısı 15 px yüksek) | [T] | müşteri ve stok listeleri | Orta |
| Hız sınırı metni Türkçe karaktersiz: "Istek limiti asildi. Lutfen…" | [K] | `BE\Backend.Veteriner.Api\Middleware\RateLimitingExtensions.cs:64` | Orta |
| 502/503'te her zaman "Ödeme veya abonelik hizmeti… yanıt veremedi" | [K] | `FE\shared\utils\api-error.utils.ts:493-495` | Orta |
| Süresiz 3 hata bildirimi 3 saniyede kayboluyor | [K] | `change-password-page.component.ts:157,175`; `organization-billing-profile-section.component.ts:239` | Orta |
| Hızlı hasta diyaloğunda "Bu tür için yeni ırk" düğmesi yetkiye bakmıyor; yetkisiz kullanıcı basıp hata alır (denenmedi) | [K] | `FE\entities\pet\components\quick-pet-dialog.component.ts:83-87` | Orta |
| PrimeNG ekran okuyucu metinleri İngilizce (`aria` anahtarları eksik) | [K] | `FE\core\i18n\primeng-tr.ts` | Düşük |
| "Tekrar dene" / "Yeniden dene" iki biçim | [K] | `app-error-state.component.ts:27`; `import-wizard-page.component.ts:169` | Düşük |
| Koyu temada seçici yer tutucusu 4,07:1; açık temada etkin menü 4,2:1, pasif sekme 4,34:1 (sınır 4,5) | [T] | tema belirteçleri | Düşük |

---

## 2. Orta işler

### O1. Seçicide yerinde ekleme yok: 18 yerde
- **Kim:** Sekreter (mal kabul, hasta kaydı), hekim (uygulama, yatış), klinik sahibi (ürün).
- **Sorun [T]:** Ürün formunda kategori açılınca yalnız "Sonuç bulunamadı" çıkıyor. Alanın altındaki "Kategori ekle" bağlantısı formdan çıkarıyor; yazılanlar gidiyor (bkz. O2). Hasta formunda ise "Müşteri bulunamadı · Yeni müşteri ekle" var; yazılan ad diyaloğa taşınıyor.
- **Liste [K]:**

| Seçilen | Ekran | Dosya:satır | Şu an |
|---|---|---|---|
| Ürün kategorisi | Yeni ürün, ürün düzenle | `product-create-page.component.ts:46`, `product-edit-page.component.ts:58` | "Sonuç bulunamadı"; bağlantı formdan çıkarır |
| Tür | Hızlı hasta diyaloğu | `quick-pet-dialog.component.ts:48` | Tam formda var, burada yok |
| Tür | Geliş → yeni müşteri ve hasta | `visit-quick-registration.component.ts:75` | Yok |
| Tür | Aşı takvimi satırı | `vaccination-schedule-page.component.ts:157` | Yok |
| Ürün | Mal kabul satırı | `goods-receipt-page.component.ts:156` | "Eşleşen ürün bulunamadı." Yeni ürün en sık burada gelir |
| Ürün | Uygulama ekle | `administration-create-dialog.component.ts:62` | Yok |
| Ürün | Stok hareketi | `stock-movement-create-dialog.component.ts:74` | Yok |
| Aşı ürünü | Aşı formu | `vaccination-form.component.ts:202` | "Ürün tanımında tür 'Aşı' seçilmelidir" (yol tarifi) |
| Ürün/hizmet | Muayene şablonu satırı | `examination-template-editor-dialog.component.ts:114` | Yok |
| Ürün | Hızlı satış araması | `sale-new-page.component.ts:149-151` | "Satılabilir ürün bulunamadı." |
| Yatış bölümü, oda | Yeni yatış, yatış düzenle | `hospitalization-form.component.ts:159,168`; `hospitalization-edit-page.component.ts:193,202` | "Ayarlar → Tanımlar → Yatış konumları" (yol tarifi, bağlantı yok) |
| Gelir/gider türü | Kasa hareketi | `cash-movement-forms.component.ts:43` | "Önce Kasa ayarlarından bir tür ekleyin." |
| Randevu nedeni | Randevu formu | `appointment-reason-vet-fields.component.ts:24` | Liste boşsa alan hiç çizilmiyor |
| Muayene şablonu | Geliş hazırlığı | `visit-preparation-fields.component.ts:46` | "Tanımlı şablon yok." |

- **Yetkisiz kullanıcı [K]:** Yerinde ekleme hep gizleniyor; pasif düğme yok. "Yöneticinize başvurun" diyen tek yer tanı sözlüğü (`clinical-term-picker.component.ts:87`). İyi örnek: geliş diyaloğu "Hasta kayıtlı değilse kaydı resepsiyon oluşturur." (`visit-arrival-dialog.component.ts:88`).
- **Öneri:** Tek ortak desen: seçicinin boş durumunda "+ 'Mama' kategorisini ekle". Tek alanlı kayıtlar (kategori, tür, gelir/gider türü, bölüm) tek tıkla oluşsun ve seçilsin; çok alanlılar (ürün) küçük diyalogla. Yetkisizde "Eklemek için yöneticinize başvurun." Hazır desenler: `client-search.component.ts:58-75`, `clinical-term-picker.component.ts:57-90`. Ayrıca uzun listelerde arama kutusu eksik: ırk, renk, desen (`pet-new-page.component.ts:86,100,141,148`).
- **Önem / büyüklük:** Yüksek / Orta. İlk dilim (kategori, tür, mal kabulde ürün) 2–3 gün.
- **Görüntü:** `G\40-urun-kategori-secici.png` (sorun), `G\41-hasta-formu-yeni-musteri-ekle.png` (iyi örnek).

### O2. Kaydedilmemiş değişiklik koruması yok
- **Kim:** Hepsi; en çok uzun muayene yazan hekim.
- **Sorun [T]:** Yeni müşteri formunu doldurup menüden "Bugün"e bastım: uyarı çıkmadı; geri gelince form boştu. **[K]:** Kodda hiç `canDeactivate` koruması yok (29 oluştur/düzenle sayfası). Sekme kapatma uyarısı yalnız site sihirbazında. Yaklaşık 17 diyalog Esc, X ya da dışarı tıklamayla dolu içeriği atıyor.
- **Öneri:** Ortak `unsavedChangesGuard` + aynı kuralla `beforeunload`. Formlar için arayüz hazır (`HAS_UNSAVED_CHANGES`). Soru metni: "Kaydedilmemiş değişiklikler var. Çıkılsın mı?" düğmeler "Sayfada kal" / "Kaydetmeden çık".
- **Önem / büyüklük:** Yüksek / Orta.
- **Dosya:** `FE\shared\ui\unsaved-changes\unsaved-changes.ts:8-39`; `FE\features\clinic-site\builder\site-builder-page.component.ts:320` (tek örnek).

### O3. Kaydet pasif, nedenini söylemiyor: 54 dosya
- **Kim:** Hepsi.
- **Sorun [T]:** Bütün yeni kayıt sayfalarında Kaydet baştan pasif. Üstüne gelince ipucu yok. Dokunulmamış zorunlu alan işaretlenmiyor. Kaydet'e basınca çalışacak "eksikleri göster" kodu düğme pasif olduğu için hiç çalışmıyor. Telefonda düğme uzun formun dibinde (muayene 2.089 px, hasta 1.673 px); kullanıcı aşağı inip pasif düğmeyi buluyor.
- **Öneri:** Kaydet hep etkin olsun. Basınca eksik alanlar işaretlensin, ilk hatalı alana kaydırılıp odaklanılsın, üstte "2 alan eksik: Hasta, Randevu saati" özeti çıksın. (Portaldaki talep formu böyle çalışıyor: "Ne için geldiğinizi kısaca yazın.")
- **Önem / büyüklük:** Yüksek / Orta.
- **Dosya:** ör. `FE\features\clients\pages\client-new-page\client-new-page.component.ts:88`; ortak alan hatası bileşeni yok (her form kendi `fieldMessage()` yöntemini yazıyor).

### O4. İngilizce ve teknik sunucu hataları
- **Kim:** Hekim, sekreter.
- **Sorun [K]:** Ekranın kendi tablosunda olmayan hata kodunda sunucunun `detail` metni aynen gösteriliyor. Backend'de 48 İngilizce iş kuralı metni (21 dosya) ve 39 İngilizce doğrulama metni (18 dosya) var. Örnek: "Discharged hospitalization cannot be updated." (`BE\Backend.Veteriner.Domain\Hospitalizations\Hospitalization.cs:125`), "Title is required." (`Treatment.cs:102`). `Context.TenantConflict` eşlenmemiş: "JWT tenant_id ile sorgu tenantId farklı…". 400 doğrulama hataları yalnız 19 formda alana bağlanıyor; satış, ürün, ücret, bekleme listesi ve kasa formlarında "Aşağıdaki alanları kontrol edin" yazıyor ama işaretli alan yok.
- **Doğrulanmadı:** Bu metinlerin ekranda gerçekten çıkıp çıkmadığı (arayüz çoğunu önceden engelliyor olabilir).
- **Öneri:** Backend metinlerini Türkçeleştir (tek doğruluk kaynağı backend). Arayüzde bilinmeyen kodda sunucu metni yerine "İşlem yapılamadı. Sorun sürerse destekle iletişime geçin." + destek için kod.
- **Önem / büyüklük:** Yüksek / Orta.
- **Dosya:** `FE\shared\utils\api-error.utils.ts:318-370`; `BE\Backend.Veteriner.Api\Common\Extensions\ResultExtensions.cs:40`.

### O5. Telefon ve tablet
- **Kim:** Hekim (tablet), sekreter (telefon).
- **Sorun [T]:**
  - **Taşma yok.** 375 px'te 14 ekranın hiçbirinde yatay kaydırma çıkmadı. Diyaloglar tam ekran açılıyor.
  - **Tablet (768 px):** Düğmeler 33 px, üst çubuk simgeleri 35 px yüksek. 44 px kuralı yalnız telefon kırılımında uygulanıyor.
  - **Telefon:** Ad bağlantıları 15–17 px yüksek (Bugün, müşteri ve stok listeleri). Raporlarda "Favorilere ekle" 28×28 px.
  - **Yazı:** Gövdenin çoğu 12,25 px; rozet ve küçük notlar 10,5 px.
  - **Kaydet:** Uzun formlarda sabit değil, en altta (bkz. O3).
- **Öneri:** 44 px kuralını 1024 px'e kadar genişlet; satırın tamamı dokunulur olsun; telefonda Kaydet çubuğu ekranın altına sabitlensin; alt sınır 12 px.
- **Önem / büyüklük:** Orta / Orta.
- **Görüntü:** `G\t-bugun.png`, `G\t-hasta-karti.png`, `G\m-bugun.png`, `G\m-musteriler.png`, `G\m-muayene-yeni.png`.

### O6. "İptal" kullanıcıyı geldiği yere değil listeye götürüyor: 11 sayfa
- **Kim:** Sekreter.
- **Sorun [K]:** Müşteri kartından açılan "Yeni hasta" formunda İptal `/panel/pets` listesine gidiyor. `returnUrl` yalnız randevu düzenlemede var. Yeni ücret kayıttan sonra da listeye dönüyor (`charge-new-page.component.ts:361`). Filtre ve sayfa numarası 14 listede korunuyor; tedaviler, lab, kurum üyeleri ve davetlerde korunmuyor.
- **Öneri:** Ortak "geri dön" yardımcısı: önce `returnUrl`, yoksa bağlamdaki kart, yoksa liste.
- **Önem / büyüklük:** Orta / Orta.
- **Dosya:** `pet-new-page.component.ts:334`, `client-new-page.component.ts:147`, `appointment-new-page.component.ts:273`, `payment-new-page.component.ts:369`; doğru örnek `appointment-edit-page.component.ts:452-463`.

### O7. Yetki ve salt okunur mod (karar)
- **Kim:** Sekreter, hekim; deneme süresi biten klinik.
- **Sorun [K]:** Yetki eksikse eylemler gizli (tutarlı). Salt okunur modda karışık: 84 yerde gizli, 63 yerde pasif; pasif düğmede neden yazmıyor (üstteki bant söylüyor). Paket dışı sayfalar menüde normal görünüyor; kilit sayfa açılınca çıkıyor.
- **Öneri:** Kural: yetkisi olmayan iş gizli; paket dışı iş kilit simgesiyle görünür ("Üst pakette"); pasif düğmede kısa neden. Tarayıcıda rol hesabıyla denenmedi.
- **Önem / büyüklük:** Orta / Orta.
- **Dosya:** `FE\core\routing\panel-navigation.ts:59-66,689`; `FE\layout\component\app-read-only-banner.component.ts:60-78`.

### O8. Klavye ve erişilebilirlik
- **Kim:** Hızlı çalışan sekreter; ekran okuyucu kullananlar.
- **Sorun [K]:** Kısayol yalnız arama (Ctrl+K, "/") ve hızlı satışta (Ctrl+Enter). Diyalog kapanınca odak açan düğmeye dönmüyor (48 diyalog). Muayenedeki işlem çekmecesinde Esc kapalı. Etiketi bağlanmamış alanlar: hatırlatma ayarları 5, çalışma saatleri 28. 198 görsel `*` var, `aria-required` 2 yerde; 444 hata metnine karşı `aria-describedby` 3 yerde. **[T]:** Odak halkası görünür (alanlarda gölge, düğmelerde çizgi); Tab sırası görsel sırayla aynı.
- **Öneri:** Ctrl+Enter ile kaydetmeyi diyalog ve muayene formuna yay; kısayol listesi kullanıcı menüsünde; ortak "odağı geri ver" yardımcısı.
- **Önem / büyüklük:** Orta / Orta.
- **Dosya:** `FE\layout\component\app-global-search.component.ts:78-81`; `FE\features\examinations\components\examination-procedures-section.component.ts:128-131`.

### O9. Randevu vermek 11 tık
- **Kim:** Sekreter.
- **Sorun [T]:** Bugün → Yeni randevu (1) → müşteri yaz ve seç (1) → hasta aç, seç (2) → tarih aç, seç (2) → saat aç, seç (2) → tür aç, seç (2) → Kaydet (1). Saat, 15 dakikalık 35 satırlık açılır listeden seçiliyor. Formda hekim alanı görünmüyor.
- **Nasıl daha iyi yaparız:** H1'deki varsayılanlarla 5–6 tık. Saat seçimi için kendi portalımızdaki düzeni panele taşı: gün şeridi + sabah/öğleden sonra/akşam saat düğmeleri (tek dokunuş, dolu saat görünmez). Hasta kartındaki "Randevu al" müşteri ve hastayı dolu açıyor (koddan); Bugün ve genel arama sonuçlarından da aynı kısa yol verilsin.
- **Önem / büyüklük:** Orta / Orta.
- **Görüntü:** `G\22b-randevu-saat-listesi.png`, `G\p06-talep-adim3.png` (portaldaki saat seçici).

### O10. Ücret eklerken hizmet listeden seçilemiyor
- **Kim:** Sekreter.
- **Sorun [T]:** Yeni ücrette açıklama ve birim fiyat elle yazılıyor; ürün/hizmet listesinden seçim yok. İlk hafta rehberi ise "Hizmet fiyatları"nı tanımlatıyor. **[K]:** Bugünkü tek geliş otomatik seçilmiyor.
- **Doğrulanmadı:** Şablon/paket ve ücret önerisi yolunun bu ihtiyacı ne kadar karşıladığı.
- **Öneri:** Açıklama alanı yazdıkça hizmet ve ürün önersin; seçilince fiyat ve KDV dolsun; serbest metin de kalsın.
- **Önem / büyüklük:** Orta / Orta.
- **Dosya:** `FE\features\charges\pages\charge-new-page\charge-new-page.component.ts:91-111,277-292`.
- **Görüntü:** `G\15-ucret-yeni.png`.

---

## 3. Büyük işler

### B1. Takvim saat ızgarası değil
- **Ekran:** `/panel/appointments/calendar`.
- **Kim:** Sekreter (telefonda "yarın 14:00 boş mu?" sorusu).
- **Sorun [T]:** Gün ve hafta görünümü gün gün kart listesi. Boş saat, çakışma ve hekim görünmüyor; boş yere tıklayıp randevu açılamıyor; kart sürüklenemiyor. Boş saatleri görmek için Yeni randevu formunu açıp tarih seçmek gerekiyor.
- **Nasıl daha iyi yaparız:** Saat ızgaralı gün görünümü, hekim başına sütun, boş hücreye tıklayınca tarih-saat-hekim dolu form. Telefonda bugünkü ajanda listesi kalsın. Backlog'da karşılığı aranmadı.
- **Önem / büyüklük:** Yüksek / Büyük.
- **Görüntü:** `G\30-takvim-hafta.png`.

### B2. Geri alma yok
- **Sorun [K]:** Bildirim içinde "Geri al" hiç yok. Geliş, "Gelmedi", kredi mahsubu ve içe aktarmada ayrı geri alma eylemi var; randevu, ödeme, ücret, aşı, tedavi ve yatış iptalinde yok ("Geri alınamaz"). Silmeler yumuşak (iptal/pasif).
- **Öneri:** Önce randevu iptali için 10 saniyelik "Geri al". Backend sözleşmesi gerekir.
- **Önem / büyüklük:** Orta / Büyük.

### B3. Muayenede taslak kaydı yok
- **Sorun [K]:** Muayene, mal kabul ve yeni müşteri+hasta formlarında taslak ya da otomatik kayıt yok. O2 çözülse de tarayıcı çökmesi ya da oturum süresi dolması yazılanı götürür.
- **Öneri:** Önce muayene için tarayıcıda taslak (`sessionStorage`), "Kaydedilmemiş taslağınız var, sürdürülsün mü?" sorusuyla.
- **Önem / büyüklük:** Orta / Orta–Büyük.
- **Dosya:** `FE\features\examinations\pages\examination-workspace-page\examination-workspace-page.component.ts:356-388`.

### B4. Form altyapısı tek yerde değil
- **Sorun [K]:** Alan hatası, zorunlu işareti ve ekran okuyucu bağları her formda elle yazılıyor (444 hata metni, 198 `*`). O3 ve O8'in kalıcı çözümü ortak alan sarmalayıcıdır.
- **Önem / büyüklük:** Orta / Büyük.

---

## 4. On beş başlıkta durum

| # | Başlık | Durum | Bulgular |
|---|---|---|---|
| 1 | Seçicide yerinde ekleme | 7 yerde var, 18 yerde yok | O1 |
| 2 | Boş durumlar | 18 listede yanlış metin, düğme yok | H5 |
| 3 | Hata ve doğrulama | Alan altı mesaj var; pasif Kaydet ve İngilizce sunucu metni sorun | O3, O4, H11, H17 |
| 4 | Varsayılanlar | Geliş, muayene, hızlı satış, ürün iyi; randevu, ödeme, tedavi, reçete, yatış eksik | H1, H2 |
| 5 | Tıklama sayısı | Geliş 3, muayene açma 1 (iyi); randevu 11, tahsilat 9 | H1, H2, O9 |
| 6 | Kayıp ve geri dönüş | Koruma yok; onaylar iyi; geri alma az | O2, H4, H12, O6, B2, B3 |
| 7 | Tutarlılık | 7 desen | H10 |
| 8 | Arama | İyi (aşağıda) | H15a |
| 9 | Telefon ve tablet | Taşma yok; dokunma hedefi ve yazı küçük | O5 |
| 10 | Koyu tema | Metin kontrastı temiz; tek istisna yer tutucu | H19 |
| 11 | Klavye, erişilebilirlik | Diyalogda Enter yok, ilk alana odak yok | H3, H14, O8 |
| 12 | Bekleme, geri bildirim | Çift tıklama koruması var; 4 ekranda onay yok; içe aktarma iyi | H13 |
| 13 | Yardım, yönlendirme | Alan altı açıklamalar kısa ve yeterli; rehber adımları doğru ekrana gidiyor (koddan), bir çelişki | H17 |
| 14 | Yetki | Gizleme tutarlı; yetkisiz sayfa 404; pasif düğmede neden yok | H6, O7 |
| 15 | Portal | Davet, kodla giriş ve talep formu iyi; ana sayfada eylem yok, aydınlatma metni sorunlu | H7, H8, H9, H16 |

## 5. Tıklama sayıları [T]

| İş | Şimdi | Hedef | Not |
|---|---|---|---|
| Randevusuz geliş (kayıtlı hasta) | 3 tık + arama | 3 | İyi. Odak arama alanında; oturumdaki hekim otomatik |
| Muayene açma (Bugün satırından) | 1 tık | 1 | İyi. Hasta ve şikâyet dolu geliyor; odak ilk alanda değil |
| Yeni randevu | 11 tık + arama | 5–6 | H1, O9 |
| Tahsilat (4 açık ücret) | 9 tık | 3 | H2. Satır menüsünden açılışta ücretlerin seçili gelip gelmediği denenmedi |
| Hızlı satış | Barkod, Enter, Ctrl+Enter | aynı | İyi. Nakit ve tam ödeme varsayılan |
| Aşı | denenmedi | – | Koddan: durum varsayılanı "Planlandı"; "Uygulandı" seçilince tarih = şimdi |

## 6. İyi çalışanlar (korunsun)

- **Arama [T]:** Genel arama (Ctrl+K) ve geliş diyaloğu "zey", "çelik", "celik", "CELIK", "5321001005", "0532…", "532 100", kısmi mikroçip ile doğru sonucu buldu. Sonuç yoksa "Yeni kayıt: müşteri ve hasta" öneriyor. Müşteri listesi araması da aynı.
- **Geliş diyaloğu [T]:** Yetkisiz kullanıcıya "Hasta kayıtlı değilse kaydı resepsiyon oluşturur." diyor; hızlı kayıt aynı pencerede.
- **Portal [T]:** Davet sayfası tek ekran, sade. Kod ekranında 60 saniyelik yeniden gönder sayacı. Talep formu tek sayfada üç adım, yalnız uygun gün ve saatler, 44 px düğmeler, "kesin randevu değil" açıklaması. Alt gezinme 75×64 px. Taşma yok.
- **Online randevu ayarı [T]:** "Kurulum kontrolü" eksikleri sayıyor ve "Telefonu ekle" bağlantısı veriyor; açarken "müşteri şu eksikleri görecek" diye uyarıyor. Diğer ayar sayfalarına örnek.
- **Onay metinleri [K]:** "Emin misiniz?" yok; düğmeler eylem adını taşıyor; gerekçeli iptaller sonucu yazıyor.
- **Uzun işler [K]:** İçe aktarmada ilerleme çubuğu, "x / y satır", "sayfayı kapatabilirsiniz".
- **Çeviri [K]:** PrimeNG metinleri Türkçe; takvim, sayfalama, "Sonuç bulunamadı".
- **Koyu tema [T]:** Bugün, hasta kartı, takvim, stok, raporlar ve Özet'te 4,5:1 altında metin çıkmadı.

## 7. Doğrulanmayanlar

- Sekreter ve Veteriner rolünde ekranlar (yetkisiz sayfa, gizli eylemler, pasif düğmeler) yalnız koddan.
- Gerçek telefon: ekran klavyesi açılınca düğmelerin durumu, dokunma hissi.
- Ekran okuyucu ile okuma.
- Canlıdaki hız ve yasal onay penceresinin gecikmesi.
- Portalda talebin gönderilmesi, klinik onayı, iptali; parola ile giriş; hesap silme.
- H13 (kayıt sonrası onay) ve O4 (İngilizce metinlerin ekranda çıkması) yalnız koddan.
- Alt ajan sayımlarının tamamı tek tek açılmadı; ilk 10 bulgunun dosya ve satırları açılıp doğrulandı.

## 8. Açık sorular (ürün kararı)

1. "Müşteri" mi, "Sahip" mi? (H10)
2. Müşteri telefonu tam formda da zorunlu olsun mu? (H17)
3. Yetkisiz sayfada panel içi "yetkiniz yok" ekranı olsun mu? (H6)
4. Paket dışı menü öğeleri kilitli mi görünsün, gizli mi kalsın? (O7)
5. Gecikmiş aşıdan talep formuna geçişte hayvan ve neden önceden seçilsin mi? (H7)
6. Saat ızgaralı takvim öne alınsın mı? (B1)

## 9. Yerel ortamda bıraktıklarım

- Örnek Veteriner Kliniği'nde (yalnız yerel veritabanı) **online randevu talebi açıldı** ve örnek müşteri Zeynep Çelik'e **portal hesabı** açıldı (e-postalar yerel alıcıya düştü, dışarı çıkmadı). Müşteri, hasta, randevu, ücret ya da talep kaydı oluşturulmadı.
- Paneldeki "Hukuki metinler güncellendi" penceresi tarayıcıda atlandı; panel hesabı adına kabul kaydı yazılmadı. Portalda sentetik hasta sahibi için davet kabulü ve aydınlatma onayı yazıldı.
- Dev sunucuları, başsız tarayıcı ve yerel e-posta alıcısı kapatıldı.

## 10. Ekran görüntüleri

Klasör: `G` (yukarıda). Ad düzeni: numaralı = masaüstü 1440 px; `m-` = telefon 375 px; `t-` = tablet 768 px; `dk-` = koyu tema; `bos-` = boş klinik; `p` = portal 375 px. Toplam 91 görüntü; hepsi sentetik örnek veri.
