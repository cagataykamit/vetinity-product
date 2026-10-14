# Rakip iş akışı çalışması: E-vet SMART ve DaySmart Vet (2026-10-14)

**Durum:** Araştırma belgesi. Ürün kararı değildir. Hedef akışlar ve dilimler: [HEDEF-IS-AKISLARI-2026-10.md](HEDEF-IS-AKISLARI-2026-10.md).
**Amaç (kullanıcı):** "Rakip bu işi 12 senedir yapıyor; nasıl yapmış bakıp biz de en iyisini yapalım." Rakipten yalnız **iş akışı ve iş kapsamı** alınır; görünüm, renk, düzen kopyalanmaz ([WORKFLOW](../WORKFLOW.md) benchmark ilkeleri). Klinik pratiği soruları kullanıcıya sorulmaz, rakip pratiği varsayılandır ([ADR-017](../decisions/ADR-017-workflow-centered-navigation.md)).

---

## 0. Kaynak, yöntem, sınırlar

**Kanıt etiketleri** (her akış maddesinde):

| Etiket | Anlamı |
|---|---|
| **[G]** | Ekran görüntüsünü bu çalışmada açıp gördüm (dosya adı yazılı). |
| **[O]** | Yalnız OCR metin dizininden okudum, görüntüyü açmadım (ekran numarası ve tarih yazılı). OCR hata içerebilir. |
| **[B]** | Depodaki önceki gözlem belgesinden ([e-vet.md](../competitors/e-vet.md), [daysmart.md](../competitors/daysmart.md)); bölüm adı yazılı. |
| **[V]** | DaySmart webinar/demo videosundan; canlı sandbox'ta doğrulanmadı ([daysmart.md](../competitors/daysmart.md) bu kaynağı ayırıyor). |
| **[Ç]** | Çıkarım: ekran sırasından benim ürettiğim sonuç; rakipte doğrulanmadı. |

**Neye baktım:** iki gözlem belgesinin ilgili bölümleri; E-vet OCR dizininden hasta kartı, yeni ziyaret/muayene, randevu, ödeme ekran dizileri (ekran 35–60, 108–118, 153–158, 223–228); DaySmart OCR dizini; **4 ekran görüntüsünü doğrudan açtım**: E-vet `Ekran görüntüsü 2026-09-23 204020.png` (Yeni Ziyaret, Satış sekmesi) ve `…205203.png` (Yeni Muayene, Muayene sekmesi); DaySmart `Ekran görüntüsü 2026-08-08 230530.png` (hasta geçmişi, aşı kayıtları) ve `…2026-08-04 134931.png` (takvimde yeni hasta). Toplam 1.555 görüntünün çok küçük bir kısmı; kalanı OCR ve önceki belgelere dayanıyor.

**Sınırlar (önemli):**

- Ekran görüntüsü **kaydedilmemiş davranışı** göstermez. E-vet'te çoğu yeni kayıt kaydedilmeden bırakılmış (önceki belge "save çalıştırılmadı" diyor); stok düşümü, ücretin oluşması, ziyaret ile lab/yatış bağı **görünmez**.
- Tek kullanıcı hesabı (yönetici düzeyi gibi görünüyor) ile gezilmiş; **rol farkı (kim neyi yapar) rakipte gözlenmedi.**
- Adım ve tıklama sayıları ekran sırasından çıkarımdır, **süre ölçülmedi**, alt sınır sayılmalı.
- DaySmart akışının önemli kısmı (check-in, ziyaret durumu zinciri, checkout) **videodan**; sandbox'ta doğrulanmadı.
- Gerçek kişi/hayvan adı, telefon, sekme başlığı bu belgeye alınmadı; ekran görüntüleri depoya kopyalanmadı.

**Bizim mevcut durum kaynağı:** [ARAYUZ-IS-AKISI-DENETIMI-2026-10.md](ARAYUZ-IS-AKISI-DENETIMI-2026-10.md) (B-numaraları) ve **kod depolarının yerel `main` durumu** (git günlüğü ve rota/menü dosyaları, salt okuma). Uygulama bu çalışmada **çalıştırılmadı**; "yapıldı" ifadeleri commit mesajı ve dosya varlığına dayanır, tarayıcıda doğrulanmadı.

### 0.1 Denetimden bu yana bizde değişenler (kod okumasından)

Denetim (bu sabah) sonrası frontend yerel `main` (`715aad9`) ve backend yerel `main` (`983e13d`) şunları içeriyor (hepsi push edilmemiş, tarayıcıda doğrulanmamış):

| İş | Durum | Kanıt |
|---|---|---|
| Menü: Bugün, Özet, Hastalar, Randevular, Para, Stok, Kayıtlar, Raporlar, Ayarlar (9 öğe, sekmeli birleşik öğeler) | **Yapıldı** (ADR-017 C1) | `panel-navigation.ts:207-255`, commit `06455ca`, `f173fdb` |
| Hayvan/müşteri detayında eylem çubuğu, formlar bağlamı okur (B-05) | **Yapıldı** | commit `621e442` |
| Ücret kaydından sonra ödemeye dönüş, ücret listesinde "Ödeme al" (B-03) | **Yapıldı** | `28cd9e6` |
| Uyarı rozeti tedavi/reçete/aşı/lab/yatış formlarında (B-10) | **Yapıldı** | `663272f` |
| B-04, B-06, B-07 (aşı detayında muayeneye dön), B-08 (kesinleştirme metni), B-09 (Bugün'de ad bağlantısı) | **Yapıldı** (Dilim A) | `1419939`, `8e0afce`, `56cd059`, `1e13eea`, `73b7c6c` |
| Doğrudan satış: backend (satış, Peşin müşteri, izinler, iptal) | **Yapıldı**, migration dosyası var, **uygulandığı doğrulanmadı** | BE `66ea2be`…`dbf99f9`, `93d768e` |
| Doğrudan satış: Para altında Satışlar, hızlı satış ekranı, iptal, fiş, Bugün'den kısayol | **Yapıldı** | FE `4c6e28b`, `1fbc76c`, `392272d` |
| Aşı tek giriş (K1): **backend** (aşı kaydında opsiyonel ürün/parti/miktar, atomik stok düşümü) | **Yapıldı**, migration `AddVaccinationAdministrationLink` **uygulanmadı** (commit mesajı) | BE `d9d7b57`…`983e13d` |
| Aşı tek giriş: **frontend** | **Yok.** `feat/asi-tek-giris` dalı `main` ile aynı noktada, aşı formunda ürün/parti alanı yok | `vaccination-new-page.component.ts` taraması |
| K2 ücret önerisi, K6 Bugün açık işler, K8 gün sonu dökümü | **Yok** (kodda iz bulunamadı) | `grep` boş |
| Muayene detayı: tedavi/reçete/aşı/lab/yatış hâlâ ayrı form sayfaları; kayıttan sonra kendi detayına gider | **Değişmedi** (kodda "Oluştur" düğmeleri `routerLink` ile ayrı sayfaya) | `examination-detail-page.component.ts:111-190` |

---

## 1. Çekirdek akışlar: rakip nasıl yapıyor

Her akışta: önce E-vet, sonra DaySmart, sonra bizim bugünkü durumumuz. Adım sayısı = kullanıcının yaptığı ayrı eylem (tıklama, arama kutusuna yazıp Ara, kaydet) ve **alt sınırdır**.

### 1.1 Hasta kabulü / geliş

**E-vet** ("Hasta Kabul" açılış ekranı)
1. Giriş sonrası açılan ekran **Hasta Kabul**: solda arama (müşteri adı/soyadı, hasta adı; "Detaylı Arama" ile protokol no, kart no, kimlik no, GSM, çip no, tür, ırk, cinsiyet, renk). **[B]** e-vet.md "Landing / Hasta Kabul"; **[O]** ekran 2.
2. Sonuçta müşteri satırı genişler, altında hayvanlar. Hayvan seçilirse **hasta kartı**; müşteri seçilirse müşteri kartı. **[B]**
3. Yoksa "Yeni Müşteri": 5 sekmeli form (Ana, İletişim, Adres, Özel, Notlar); hayvan müşteri kartından "+ Hasta" ile. **[B]** "Müşteri Kartı — shell"
4. Hasta kartında üst eylemler: QR, **Yönlendir**, SMS, Sil. **[O]** ekran 35, **[B]** "Anasayfa > Ana"
5. "Yönlendir" modalı: bölüm, veteriner, açıklama, güncelle; kayıt **Muayene Odası** listesine "Beklemede" olarak düşer, satır başında yeşil tikle "Tamamlandı". **[B]** "Global Muayene Odası"
6. **Adım sayısı:** kayıtlı hasta için yaz → Ara → genişlet/seç → hasta (≈4); kuyruğa almak için + Yönlendir (≈3). **[Ç]**
- **Gözlenmeyen:** "Geldi/bekliyor" durumu **yok** (randevu durumları yalnız Randevu, Gelmedi, Tamamlandı; **[O]** ekran 418). Bekleme süresi, acil işareti, kuyruk sırası **görünmedi**. Muayene Odası kuyruğu elle (Yönlendir veya "Yeni kayıt") dolduruluyor; randevudan otomatik düşüp düşmediği **bilinmiyor**.

**DaySmart**
1. Takvimde (hekim/oda/walk-in kolonları) randevu kartından **Check In**. **[V]** daysmart.md "Check-in orkestrasyonu"
2. Check-in formu tek adımda: şikâyet, kilo, mektup şablonu, gönderilecek form, yatış, medical note şablonu, **bundle**, **fatura seçimi/yeni**, kafes kartı, not. Randevu "Checked In" olur, not ve fatura randevuya bağlanır. **[V]**
3. **Census** listesi (operasyon kuyruğu): durum, triyaj, saat, atanan, hekim, şikâyet, hasta, müşteri, medical note, belgeler, fatura sütunları; durum satırdan değişir (Not confirmed, Confirmed, Cancelled, Checked in) + isteğe bağlı not. **[B]** "Census"
4. Ziyaret durumu zinciri: Booked → Checked In → In Room → Visit Complete → Check Out. **[V]**
5. Üst çubukta global "+" (yeni hasta, not, müşteri, ürün, teklif, fatura, ödeme). **[B]** "Quick Create"
6. **Adım sayısı:** kart (1) + Check In (1) + formu onayla (1) ≈ 3; form çok alanlı. **[Ç]**
- **Zayıf:** check-in formu çok alan içeriyor, ziyaret tamamlama ile check-out ayrımı karışabilir. **[B]**

**Bizde bugün:** Bugün sayfası (randevulu/randevusuz tek kuyruk, Geldi, bekleme uyarısı, acil, geri al, Gelmedi, benim hastalarım, hızlı kayıt) iki rakipten **ileride**; hasta/müşteri sayfasında eylem çubuğu yapıldı. Eksik: Bugün'de "ziyaret sonu açık işler" (K6).

### 1.2 Randevu

**E-vet**
1. Giriş noktaları: Takvim (Ay/Hafta/Gün; "+" → Yeni Randevu), hasta kartı **Randevular "+"**, müşteri kartı **Randevular "+"**. **[B]** "Global Takvim", "Randevular"; **[O]** ekran 108-109, 153-158
2. Form: Görev Tipi, Bölüm, Veteriner, Durum (Randevu, Gelmedi, Tamamlandı), Tarih, Süre (dk), Aşı Paketi, Bilgi, Açıklama; aynı ekranda 30 dakikalık slot listesi ve doluluk. **[B]**, **[O]** ekran 109
3. **Görev Tipi** salt randevu nedeni değil: Aşılama, Kontrol, Tedavi, Reçete, TABURCU, BORÇ HATIRLATMA, Biyokimya, Bolus Uygulama vb. (liste uzun). Takvim filtreleri: Tamamlanmamış, Bugünkü, Tamamlanan, Gelecek randevular. **[O]** ekran 154, 158
4. Hatırlatma: Takvim > Hatırlatma listesi; satırdan SMS, e-posta, **WhatsApp Web ön dolu mesajla** (kullanıcı orada gönderir). **[B]**
5. **Adım sayısı:** hasta kartından: Randevular "+" (1) + tür/veteriner/tarih seç (3) + Kaydet (1) ≈ 5. **[Ç]**

**DaySmart**
1. Takvimde zaman aralığı seç → form: randevu türü (varsayılan süre ön ayarı), şikâyet/neden, hekim veya kaynak, **müşteri ve hasta arama; yoksa "Add Client" ile takvimden ayrılmadan modal ekle ve randevuya dön**, tekrar, not, **onay e-postası ve kaç gün önce hatırlatma**. **[V]**, **[G]** `2026-08-04 134931.png` (takvim üstünde Yeni Hasta modalı: ad, durum, ırk zorunlu, renk, cinsiyet, yaş/doğum, çip, birincil hekim)
2. Online randevu: hasta sahibi talep gönderir, klinikte bildirim, takvimde "Pending"; Accept, Reject, Reschedule, History. **[V]**
3. **Adım sayısı:** ≈ 5–7 (müşteri/hasta yoksa modal zinciri). **[Ç]**

**Bizde bugün:** Randevu liste + takvim (sekmeli tek öğe), müşteri/hayvan detayından eylem çubuğu. Eksik: randevu türünün **süre ön ayarı** (APPT-006 backlog), aynı ekranda hekim doluluğu, kontrol/aşı tarihinden tek hamlede randevu. Kıyas: E-vet'in "görev tipi" fikri (borç hatırlatma, taburcu gibi iş türlerini takvime almak) bizde yok ve **gerekli olmayabilir**; ayrı bir "yapılacaklar/arama listesi" daha doğru olabilir (bölüm 1.10).

### 1.3 Muayene odası: şikâyet, bulgu, tanı, tedavi, reçete, aşı, ürün/hizmet ekleme

**E-vet: tek form, dört sekme** (hasta kartında Muayene Geçmişi **"+"** veya Ziyaret Geçmişi **"+"**; iki yol aynı formu açıyor: "Yeni Ziyaret" Satış sekmesi önde, "Yeni Muayene" Muayene sekmesi önde) **[G]** `2026-09-23 204020.png`, `…205203.png`; **[O]** ekran 39-47, 111-117
1. **Muayene** sekmesi: işlem tarihi, veteriner, **kontrol tarihi**, muayene tipi (örn. Günlük), ağırlık, vücut sıcaklığı; **semptomlar** (aranabilir çoklu seçim, ~1.435 kayıtlık sözlük, yanında "+" ile yeni ekle); **hastalık teşhisi** (aranabilir sözlük ~1.170 kayıt; yanında Predispozisyonlar); anamnez (serbest metin); Tetkik ve Yorumlar (tetkik yorumları; "klinik içi yorumlar" ve "bu alan epikrize yansımamaktadır" uyarısı). **[G]**, **[B]** "Semptomlar", "Teşhisler"
2. Aynı sekmede: Açıklama ve Tedavi Şekli (tedavi şablonu seç, serbest metin, "SmartVette izin ver"), Diğer Parametreler (genel durum, lenf yumruları, mukus membranlar, kıl örtüsü, dehidrasyon, solunum, nabız, kapiller dolum; seçimli listeler **muayene özellikleri tanımından**), **Reçete** (açılır bölüm: reçete tipi, açıklama, ürün satırları: ürün, miktar, birim, doz, kullanım yeri, tedavi süresi; "Sık kullanılanlar"; seri/cilt/sıra no, e-reçete no, Yazdır, Onayla). **[O]** ekran 44-47; **[B]** "Reçete"
3. **Aşı Listesi** sekmesi: aşı paketi seç + tarih + Ekle; altında hastanın Aşı Kartı (Tümü, Yapıldı, Yapılacak). **[O]** ekran 42, 115
4. **Satış** sekmesi: işlem tarihi, fatura no, veteriner, barkod/QR, depo, **ürün satırları (ürün, miktar, fiyat, iskonto, toplam)**, "Operasyon Paketi" (paketten çoklu satır), genel indirim, genel toplam. **[G]** `…204020.png`
5. **Notlar** sekmesi: tarihli not satırları. **[O]** ekran 43, 117
6. Alt çubuk: **Geri Dön, Kaydet, Kaydet / Öde**. Kaydedince Muayene Geçmişi listesi (tarih, hekim, teşhis, açıklama, toplam, ödeme) ve satırdan İncele/Düzenle; **Epikriz Raporu** ve **Tedavi** çıktıları ayrı rapor sayfasında. **[O]** ekran 48-54
7. **Adım sayısı:** hasta kartı → "+" (1) → semptom/teşhis/anamnez (≈6 seçim/yazı) → Kaydet (1); satış satırı için Satış sekmesi (1) + ürün ara/seç (2). Hasta bulunmuş sayılırsa **≈ 3 sekme dolaşımı ve tek kayıt**. **[Ç]**
- **Önemli:** tedavi **serbest metin + şablon**; yapılandırılmış tedavi kaydı yok görünüyor. Ürünlerin **stoktan düşüp düşmediği, hangi ürünün "uygulama" olduğu ekrandan anlaşılmıyor** (önceki belge de "stok/fatura yan etkisi doğrulanmadı" diyor). Lab ve yatış bu formda **değil**; hasta kartında ayrı "+" ile ayrı kayıt, ziyaretle bağı **görünmedi**. **[B]**, **[Ç]**
- **Güçlü:** semptom ve teşhis **sözlükten aranarak** seçiliyor (raporlanabilir, sayılabilir); kontrol tarihi muayenenin alanı; hepsi **tek kayıt, tek Kaydet**.
- **Zayıf:** her şey tek uzun form; ziyaret ile muayene aynı ekranda iki ad ("Yeni Ziyaret"/"Yeni Muayene"); kesinleştirme/kilit kavramı **gözlenmedi** (muayeneler listeden "Düzenle" ile açılabiliyor, **[O]** ekran 52).

**DaySmart: SOAP çalışma alanı** **[V]**, **[B]** "SOAP workspace", "Record, Belge, Ziyaret Durumu"
1. Check-in'den medical note açılır; üst bant: hasta özeti, muayene özeti, sağlayıcı, **bağlı fatura**, yaklaşan/gecikmiş hatırlatmalar.
2. Subjective, Objective, Assessment, Plan, Client Communication; vital'ler; sistem muayenesi bölümleri (varsayılan "within normal limits"); tanı geçmişi (durum, acuity). Şablonlar tür/ziyaret türüne göre. `#` ile **snippet** (örn. `#vomiting` anamnez soru setini yazar); sesle not (premium aday); doz hesaplayıcı.
3. Plan altında **kayıt (record)** ve **bundle** ekleme: kayıt türleri aşı, ilaç, işlem, tanı, vital tek "Record" altında, tür değişince form değişir; **Apply Item Rule** ürün seçince sonraki tarih, hatırlatma, miktar, uygulama yolu, fatura bağı, stok ilişkisini doldurur. **[B]**
4. **Aşı örneği [G]** `2026-08-08 230530.png`: hasta geçmişi > Vaccines: her aşı satırı **tek kayıt**; verilme tarihi, doz, **lot**, uygulama yolu, bölge, talimat, hekim, kaydeden, **bağlı fatura numarası** (satırdan faturaya bağlantı) ve hangi muayeneden geldiği ("Reference").
5. Her kayıt ve SOAP, faturaya **çift yönlü bağlantı**; not kilitlenir (lock). **[B]**
6. **Adım sayısı:** not açık geldiği için başlangıç 0; kayıt ekleme: menü (1) + tür/ürün (2) + kaydet (1) ≈ 4 / kalem; bundle ≈ 3 toplam. **[Ç]**
- **Güçlü:** bir olay tek giriş (aşı kaydı = stok + hatırlatma + fatura satırı); ziyaret boyunca hasta ve fatura bağlamı üstte sabit.
- **Zayıf:** ekran uzun/yoğun, sistem muayene bölümleri öğrenme yükü, item rule opak, ziyaret durumu çok adımlı (küçük klinik için ağır). **[B]**

**Bizde bugün:** muayene çalışma alanı (4 bölüm, kısmi güncelleme, kesinleştirme + ek not) rakiplerin ikisinden **yapılandırılmış ve güvenli**; ama **işlemler ayrı sayfalar**: tedavi, reçete, aşı, lab, yatış her biri "Oluştur → form sayfası → kaydet → kendi detayı → Bağlı muayene bağlantısı ile dönüş". Denetim sayımı: tam muayene ≈ 18 tıklama, ≈ 12 geçiş (B-07); iki rakipte bu iş tek ekran içinde. Semptom/teşhis sözlüğü bizde yok (serbest metin).

### 1.4 Ücretin oluşması, ücret ve tahsilat, borç

**E-vet**
1. Ücret **ziyaret formunun Satış sekmesinde** oluşur: ürün/hizmet satırı (katalogdan, fiyatlı), depo, iskonto, genel indirim. Ayrı "ücret" kavramı görünmüyor: ziyaret toplamı = borç. **[G]** `…204020.png`, **[B]** "Yeni Ziyaret"
2. **Kaydet** (bakiyeye yazar; video kaynaklı **[B]** "Ana satış ekranı" **doğrulanmadı**) veya **Kaydet / Öde**: "Ziyaret Fatura Ödemesi" ekranı: Ziyaret Toplamı, Ödeme Toplamı, işlem no, açıklama, **çok satırlı ödeme** (tip, tarih, makbuz no, tutar; kasa/belge no/kart sahibi). Tipler: Nakit, Kredi Kartı, Çek, Senet, Banka Transferi. Canlı testte 100 TL = 50 nakit + 50 kart. **[O]** ekran 223-227, **[B]** "Kaydet / Öde"
3. Sonradan tahsilat: müşteri kartı > **Ödeme Geçmişi "+"** (genel ödeme) veya ziyaret satırından Ödeme; Ödeme Fişi çıktısı; **Ekstre** (özet/detaylı), **Yaşlandırma** (bucket yok), **Bakiye İndirim** formu. **[B]** "Müşteri (modül)"
4. Borç görünürlüğü: müşteri listesinde **Borç / Ödeme / Bakiye** sütunları; "Bakiyesi Olan Müşteriler" raporu; **Toplu SMS "Bakiyesi olan müşteri"** listesi. **[B]**
5. **Adım sayısı:** ziyaret formu içinde ek 2–3 (Satış sekmesi, ürün) + Kaydet/Öde (1) + ödeme tipi/tutar (2) + Kaydet (1) ≈ 4–5 ek. Ayrı sayfaya gitmiyor. **[Ç]**
- **Rol:** gözlenen tek hesapta veteriner ve satış aynı ekranda; **hekim/resepsiyon ayrımı görünmedi**. Hekim ücret kalemi ekleyebiliyor gibi görünüyor **[Ç, zayıf]**.
- **Zayıf:** silme, ödeme varken engelleniyor ("ilişkisi vardır"), önce ödeme silinmeli (doğrulanmış canlı test). Ödeme tahsisi (hangi borca) yok görünüyor: **bakiye düzeyinde** çalışıyor **[Ç]**.

**DaySmart**
1. Kalem ekleme: **kayıt/bundle faturaya otomatik satır olur** (check-in'de fatura seçilir veya yeni açılır). Fatura = çalışma alanı: kalemler (hasta, hekim, miktar, fiyat, iskonto, vergi), alt sekmeler Items, Payments, Credits, Returns, Declined, Late Fees. **[B]** "Billing"
2. **Teklif (estimate)** → onay → **Convert → Invoice**; tedavi öncesi fiyat. **[B]**
3. **Check Out**: açık fatura(lar) seçilir, kredi kullanılır, tutar ve yöntem girilir, fazla ödeme için para üstü/kredi, **belge seçimi (aşı sertifikası, fatura, onam) + teslim kanalı (e-posta, SMS, yazdır)**, hatırlatma sayıları görünür. **[V]**
4. Tek ödeme **birden çok faturaya dağılabilir**; iade (return) ile para iadesi (refund) ayrı; müşteri kredisi; **write-off**; **kasa mutabakatı (açılış/kapanış bakiyesi)**. **[B]**
5. **Adım sayısı:** check-out ≈ 4–5 (Check Out, fatura seç, tutar, yöntem, belgeler/Onay). **[Ç]**
- **Güçlü:** ücret **iş yapıldıkça kendiliğinden oluşuyor**; ziyaret kapanışı = tahsilat + belge + hatırlatma tek yerde.
- **Zayıf:** finansal kavram çok, yatay sekmelere sıkışmış; Visit Complete / Check Out ayrımı kafa karıştırır. **[B]**

**Bizde bugün:** ücret ve ödeme **ayrı kayıtlar** (ücret → ödeme tahsisi, sağlam: kısmi ödeme, düzeltme/iptal, bakiye); Bugün satırından "Ödeme al"; ücret kaydından ödemeye dönüş yapıldı (B-03). **Ücret kendiliğinden oluşmuyor** ve **hekim ekleyemiyor** (ADR-012): işlemi yapan ile ücreti yazan ayrı ve aralarında köprü yok (B-02), ücretlenmemiş işlem listesi yok, **fiyat listesi/hizmet kataloğu yok** (FIN-008 ertelendi). Rakipte ikisinde de ürün/hizmet **fiyatlı katalogdan** geliyor. Bu, en büyük akış farkı.

### 1.5 Doğrudan satış (muayenesiz)

**E-vet** (sol ana menüde "Doğrudan Satış") **[B]** "Global Doğrudan Satış"
1. Ekran: işlem tarihi, fatura no, veteriner, e-Fatura/SMM notu; müşteri **varsayılan "Doğrudan Satış Müşterisi"** (gelgeç) veya kayıtlı müşteri; barkod/QR; depo; ürün arama (stok miktarı satırda görünür); satır: ürün, miktar, fiyat, iskonto, toplam; **miat/SKT dropdown** (aynı ürünün farklı SKT'leri, erken olan önde); genel indirim, stopaj.
2. **Kaydet / Öde** → aynı **çok satırlı ödeme** ekranı (split). Kayıtlı müşteride Kaydet bakiyeye yazar (video).
3. Geçmiş: tarih aralığı; satır eylemleri: İncele (ürün, depo, miktar, KDV, miat, seri no), Düzenle, Ödeme, SMS, Kopyala, Fatura, Bilgi Fişi, Hesap Ekstresi, Sil. Ödeme varsa silme engeli.
4. **Adım sayısı:** menü (1) + ürün ara/seç (2) + miktar/miat (1–2) + Kaydet/Öde (1) + ödeme (2) ≈ 7–8. **[Ç]**
- **Güçlü:** hızlı, barkodlu, SKT seçimi, split ödeme, geçmiş işlemleri zengin.
- **Zayıf:** stopaj/e-Fatura alanları ana ekranda yoğun; stok geri dönüşü silmede doğrulanmadı.

**DaySmart:** satış için ayrı "hızlı satış" ekranı gözlenmedi **[B]**; "New Invoice" (müşteri zorunlu, hasta isteğe bağlı) ve global "+" > New Invoice > kalem ekleme **[Ç]**; mağaza (POS) akışı ürün yüzeyinde **doğrulanmadı**.

**Bizde bugün:** hızlı satış ekranı **yapıldı** (sepet, parti önerisi, ödeme, Peşin müşteri, iptal, fiş, Bugün'den kısayol; kod okuması, **tarayıcıda doğrulanmadı**; backend migration uygulanması doğrulanmadı). ADR-016 kapsamı iyi korunuyor: aşı/narkotik satılmaz, süresi geçmiş parti engelli (E-vet SKT'yi yalnız gösteriyor, engellemiyor **[B]**). Eksik: satışı **ziyarete bağlama** (muayene sırasında mama/ilaç satışı, bölüm 3.2 çelişki notu), split ödeme kontrolü (ödeme tipi çoklu satır) ve barkod okutma (**doğrulanmadı**).

### 1.6 Stok girişi ve kullanımı

**E-vet** (Stok menüsü: Alış Faturası, İade Faturası, Sipariş Faturası, **Stok Giriş**, Stok Çıkış, Sayım, Stok Sıfırlama, Stok Transferi, Depo Stok Durumu, Satıcı Firmaya Ödeme, Satıcı Firmalar, Depolar) **[B]** "Stok (modül)"
1. **Stok Giriş** (faturasız): tarih, işlem no, açıklama, barkod, depo, ürün, miktar/çarpan, birim, "+ Yeni"; miat kontrollü üründe **Miat zorunlu** ("Bu alan zorunludur!"). Kontrolsüz üründe alan yok. Ürün tanımındaki "Miat Kontrolü" bayrağı belirliyor.
2. **Alış Faturası:** satıcı firma, fatura no, "Stok hareketini engelle", teslim/vade tarihi, depo, KDV dahil, satırlar (ürün, miktar, fiyat, KDV, iskonto, miat), **Kaydet / Öde** (tedarikçiye ödeme ayrı ekran). **"Faturayı AI ile içeri aktar"** (XML/PDF/JPG/PNG) modalı var; **gerçek çalışması doğrulanmadı**.
3. **Depo Stok Durumu:** depo bazlı gruplu; aynı ürün farklı SKT ayrı satır.
4. Kullanım: satışla (doğrudan satış, ziyaret Satış sekmesi) depodan düşer **[Ç]**; "Stok Çıkış" listesi yalnız okuma/yazdır (elle çıkış formu gözlenmedi).
5. Raporlar: Minimum stok altı, SKT geçen, SKT yaklaşan (gün eşiği girilir), ürün hareketleri, **Gelecek Aşılar** (planlı aşı sayısı ile stok karşılaştırması, "yetersiz stok" özeti). **[B]** "Rapor → Depo"
6. **Adım sayısı:** menü (1) + form (tarih/depo hazır) + ürün (2) + miktar/miat (2) + Kaydet (1) ≈ 6. **[Ç]**

**DaySmart:** **Purchase Order → Receipt (mal kabul) → Posted → stok hareketi**; Receipt satırı: ürün, post to, miktar, maliyet, vergi, üretici, **lot no, son kullanma**; kısmi teslim, back-order. Item rule ve düşük stok uyarıları (Inventory Alerts). **[B]** "Purchase Orders", "Receipts"
- **Adım sayısı:** receipt ≈ 5–6. **[Ç]**

**Bizde bugün:** parti (lot) bazlı stok, SKT, kontrollü sınıf kuralı, FEFO önerisi, süresi geçmiş parti kuralları (ADR-015) rakiplerden **daha disiplinli**. Zayıf: giriş yüzeyi gömülü (B-13: ürün detayı/stok hareketleri diyaloğu), fatura/tedarikçi bağı tek satırlık diyalog, **çok satırlı mal kabul yok**, düşük stok satırından giriş eylemi yok. Sipariş/alış faturası/tedarikçi ödemesi kapsam dışı (ön muhasebe).

### 1.7 Laboratuvar

**E-vet** **[B]** "Global Lab İstekleri"; **[O]** ekran 60
1. İstek **hasta kartından**: Lab Geçmişi "+" → Yeni Lab İstek: istek tarihi, hasta durumu (ayakta, baygın, hospitalizasyon, uyanık), test grubu (cihaz/analiz grupları), test grup paneli (örn. karaciğer paneli), test kalemleri, **Ekle**, Kaydet.
2. Global **Lab İstekleri** listesi (yeni istek butonu yok): durum başlıkları Beklemede/Tamamlandı; **durum filtresi yok** (~1.400 kayıt; **E-vet zayıflığı**).
3. Sonuç: satırı aç; analit tablosu (test adı, lab değeri, **referans min/max, birim**); durum Beklemede/İşleniyor/Tamamlandı + Kaydet. "Tamamlandı" ≠ değerler dolu (gözlendi). Satır eylemleri: indir, yazdır, barkod yazdır, **WhatsApp ile paylaş, e-posta ile paylaş**; analit DataVet yorum penceresi.
4. **Adım sayısı:** istek ≈ 5 (hasta kartı, +, grup, panel, Kaydet); sonuç girişi ≈ 4 (menü, satır, değerler, Kaydet). **[Ç]**

**DaySmart:** Patients > Labs / Images / Diagnoses / Rx Requests listeleri klinik çapında; lab isteği record türü (tanı) olarak. Ayrıntı gözlenmedi. **[B]**

**Bizde bugün:** lab durumlu (istendi/sonuç girildi/yorum/iptal), rozet; sonuç girişi menüden 4 tık. **Analit/referans aralığı yok** (sonuç metin). Fark yaratma alanı: bekleyen lab'ın **Bugün'e düşmesi** (K6) ve **sonucu müşteriyle tek tıkta paylaşma**.

### 1.8 Yatış

**E-vet** **[B]** "Global Hospitalizasyon"
1. Hasta kartı Hospitalizasyon Geçmişi "+" veya global "+ Yeni Kayıt": müşteri, hasta, durum (Yatan, Taburcu, Ölü), giriş/çıkış tarihi, bölüm, oda, veteriner, **Tedavi Şekli / Uygulamalar / Açıklama (serbest metin)**.
2. Liste: Yatan ve Taburcu grupları; satırı genişlet. **Taburcu = Düzenle > Durum Taburcu > Kaydet**; çıkış tarihi **otomatik dolmuyor**; "Günler" boş kalabiliyor.
3. **Adım sayısı:** yatırma ≈ 4; taburcu ≈ 4. **[Ç]**
- Hafif: ilaç/bakım saat planı, vital akışı, kapasite yok.

**DaySmart:** **Treatment Board** (Census'tan ayrı): kart = hasta, ırk, yaş, sorumlu, yatış süresi, durum, **bekleyen belge sayısı**; kart eylemleri New Activity, New Bundle, Documents, End; detayda vital özeti ve **kategori bazlı zaman çizelgesi** (Vitals, Medical, Other), her etkinlik "Due, Complete"; tekrarlı etkinlik, **tedavi başlangıcına göre vade**. Boarding ayrı modül (rezervasyon, oda takvimi, check-in sihirbazı). **[B]**

**Bizde bugün:** yatış modeli (neden, konum, bakım talimatı, taburcu, Bugün'de aktif yatış kartı); **günlük "yapılacak bakım" listesi/panosu yok**. E-vet'i geçiyoruz, DaySmart Treatment Board'un gerisindeyiz.

### 1.9 Kontrol ve aşı hatırlatma

**E-vet** **[B]** "Global Takvim", "Muayene (modül)"
1. Kaynaklar: muayenede **Kontrol Tarihi**; hasta kartı **Aşı Programı** (program oluştur: bölüm, veteriner, süre, tarih, aşı paketi; "Oluştur" ile satırlar → Kaydet; ekran 55-59); **Aşı Paketleri** (şablon + ilgili paket + gün aralığı) ve **Aşı Programları** (paket zinciri) tanım ekranları; **Aşılanmamış Hasta Takibi** (~1.948 hasta, satırdan Aşı Programı…).
2. İş listesi: **Hatırlatma** (tarih aralığı, şablon seç, SMS/e-posta/WhatsApp Web ön dolu mesaj, "Aşılama" grubu), Doğum Günü Listesi, **Toplu SMS** (müşteri, bakiyesi olan, grup, manuel liste), SMS Geçmişi (gönderildi/gönderilmedi), kara liste, şablon token'ları ({Vaccine}, {Patient}…).
3. Rapor: Yapılacak/Yapılan Aşı Çizelgesi, Gelecek Aşılar (stok yeterliliğiyle).
4. **Adım sayısı:** program oluşturma ≈ 6; hatırlatma gönderme (listeden) ≈ 3 (satır, kanal, gönder). **[Ç]**
- **Zayıf:** geçmiş tarihli mesaj uyarısız gönderildi (gözlem); WhatsApp gönderimi E-vet içinde kayda geçmiyor.

**DaySmart** **[B]** "Reminders Detail"
1. Reminders listesi: vade, tür (e-posta/SMS), sahip, hasta, **"Reminder For" (randevu, kontrol, çiftlik ziyareti, aşılar, testler gibi vadeli her kayıt)**, son gönderim, müşterinin sonraki ziyareti, iletişim bilgileri.
2. Filtre: tarih aralığı, kategori, tür, **"sonraki ziyaret planlıysa dahil et"**, hasta durumu; toplu eylem **Resend, Print cards, Log call**; export.
3. Kayıt kaydedilirken item rule **sonraki tarih ve hatırlatmayı** kendisi koyar.
4. **Adım sayısı:** listeden toplu gönder ≈ 3. **[Ç]**

**Bizde bugün:** aşı hatırlatma e-posta altyapısı var (**gerçek gönderim doğrulanmadı**), Ayarlar > Hatırlatmalar; **çalışma listesi** (kime, hangi kanal, ne zaman aranacak, arandı mı) yok. "Aşılar" listesi gecikmiş süzgeci var.

### 1.10 Kayıt defterleri ve raporlar

**E-vet** **[B]** "Rapor → Resmi", "Rapor → Finansal", "Rapor → Depo"
1. Tek **Rapor** menüsü, kategoriler (Genel, Randevu, Resmi, Depo, Finansal); her rapor: **tarih aralığı + filtre → baskı önizlemesi → PDF/indir/yazdır** (ortak kabuk).
2. Resmi: Muayene, Aşı, İlaç, Reçete Kayıt Defteri; Narkotik/Psikotropik Stok ve Sarf Defteri; Aşı Bilgi. (Resmî geçerlilik **doğrulanmadı**.)
3. **Adım sayısı:** menü (1) + kategori (1) + rapor (1) + tarih (2) + Filtrele (1) ≈ 6. **[Ç]**
- Denetim ve sahaya bağımlılık: "Epikriz Raporu", "Sağlık Karnesi", "Hasta QR Kod Raporu" gibi belge çıktıları.

**DaySmart:** Reports Dashboard + kategori (Schedule, Patient, Client, Communication, Inventory, Billing, Staff, Wellness); **raporu iş listesinden ayırma** eksikliği (bazı iş kuyrukları statik rapor). **[B]**

**Bizde bugün:** Rapor Merkezi tek giriş, 11 kart, 6 defter (frontend defter ekranları yerel `main`'de), ortak süzgeç. Hekim sütunu yalnız sorumlu hekim (karar). Eksik: **belge çıktıları** (epikriz, sağlık karnesi) ve ortak hızlı tarih ön ayarı **[Ç]**.

### 1.11 Gün sonu ve kasa

**E-vet** **[B]** "Rapor → Finansal"
1. **Günlük Kasa:** gün içi hareketler, işlem tipi, nakit/kredi kartı/havale kırılımı, ödeme toplamı.
2. **Günlük İşlem Dökümü:** belirli gün, müşteri satış dökümü (satış kalemleri, tutar, ödeme, bakiye); "gün kapama incelemesi" niteliğinde.
3. **Tarihler Arası Kasa:** başlangıç/bitiş zamanı, kullanıcı, **devreden bakiye**, açık hesap; son 3 gün ön ayarı.
4. Kasa/Banka tanımı, Kasa Giriş/Çıkış, gider grubu/tipi, yıllık gelir-gider (ön muhasebe).
5. VKY Güncel Durum: Finansal Yönetim, Hasta Analizi, Stok Kontrol, Genel İstatistikler (yönetici panosu).
6. **Kasa kapama/mutabakat ekranı yok** (gözlenmedi). **Adım sayısı:** ≈ 5 (Rapor, Finansal, Günlük Kasa, tarih, Filtrele). **[Ç]**

**DaySmart:** **Cash > Reconciliation**: tarih, açılış bakiyesi, kapanış bakiyesi, not (fiziksel kasa mutabakatı); Payment by Type panosu. **[B]**

**Bizde bugün:** Ödeme Raporu + Borç Raporu ayrı raporlar; **gün sonu yok** (B-19, K8 kabul, yapılmadı). Ücretlenmemiş işlem, açık geliş, bekleyen lab gün sonunda **hiçbir yerde görünmüyor**; hiçbir rakip de bunu yapmıyor.

---

## 2. Karşılaştırma tablosu

Bizim sütunu: denetim bulgu numarası → bugünkü durum (kod okuması; çalıştırılmadı).

| Akış | E-vet | DaySmart | Biz (bugün) | İkisinde de eksik / fark yaratma alanı |
|---|---|---|---|---|
| **Hasta kabulü / geliş** | İyi: arama-öncelikli açılış, detaylı kimlik/çip araması. Kötü: geliş durumu, bekleme, acil yok; kuyruk elle. | İyi: check-in orkestrasyonu, Census durum satırı. Kötü: formu çok alanlı, ad araması zayıf (virgüllü isim). | **Önde:** Bugün kuyruğu, geldi, bekleme, acil, geri al, benim hastalarım. Eylem çubuğu yapıldı (B-05). Eksik: K6 açık işler. | Her ikisi de **bekleyen işi (lab, borç, ücretlenmemiş)** geliş satırında göstermiyor → fark yaratırız. |
| **Randevu** | Görev tipi çok amaçlı, slot doluluk, hatırlatma. Kötü: durum yalnız 3, geldi yok. | İyi: tür=süre ön ayarı, takvimde inline müşteri/hasta, online talep. Kötü: modal zinciri. | Liste + takvim. Eksik: tür/süre ön ayarı, kontrol tarihinden randevu. | Kontrol/aşı tarihi ile randevuyu **tek hamlede** bağlamak. |
| **Muayene odası** | İyi: tek form, sözlükten semptom/teşhis, kontrol tarihi, tek Kaydet. Kötü: yapılandırılmamış tedavi, kilit yok, ziyaret/muayene çift adı, lab/yatış kopuk. | İyi: SOAP, snippet, item rule, kayıt=fatura satırı, hasta bandı. Kötü: uzun/yoğun, öğrenme yükü. | Güvenli (kısmi PUT, kesinleştirme, ek not) ama **işlemler ayrı sayfalar** (B-07: ≈18 tık, ≈12 geçiş); kısmen iyileşti (A2, A4). Sözlük yok. | **Kesinleştirmeden önce eksik/ücretlenmemiş kontrolü** (K10) ve işlemleri **sayfa değiştirmeden** ekleme. |
| **Ücretin oluşması** | Ürün/hizmet satırı ziyaret formunda, fiyat katalogdan. Kötü: rol ayrımı yok görünüyor, kalem=stok bağı belirsiz. | Kayıt/bundle faturaya **otomatik** satır; teklif→fatura. | **Kayıt var, ücret kendiliğinden yok (B-02)**, fiyat katalogu yok, hekim ücret ekleyemez (ADR-012). | **Rol ayrımlı öneri akışı:** hekim işlemi → resepsiyon onayı (K2); iki rakip bunu rolsüz yapıyor, **denetimli** yapabiliriz. |
| **Tahsilat / borç** | Çok satırlı ödeme (split), ödeme fişi, ekstre, bakiye raporu, toplu SMS. Kötü: tahsis yok, silme önce ödemeyi sildirir. | Fatura merkezi, çoklu faturaya dağıtım, kredi, iade/geri ödeme, write-off, kasa mutabakatı. Kötü: kavram yükü, yatay sekmeler. | **Sağlam:** ücret → tahsisli ödeme, düzeltme/iptal, bakiye, Bugün'de borç. B-03 giderildi. Eksik: split ödeme kontrolü, ödeme sonrası belge. | **Borçlu müşteriyi geliş anında uyarma** (Bugün'de var) + **ödeme anında belge/makbuz paketi**. |
| **Doğrudan satış** | Hızlı satış ekranı, barkod, SKT seçimi, split. | Ayrı hızlı satış ekranı gözlenmedi. | **Yapıldı** (ADR-016/K9; kod, **doğrulanmadı**). Peşin müşteri, parti önerisi, süresi geçmiş engel. Ziyarete bağlı satış yok. | Ziyaretteki satışla doğrudan satışı **tek mantık** yapmak. |
| **Stok girişi** | Stok Giriş + Alış Faturası (SKT zorunlu), AI ile fatura aktarma (doğrulanmadı), sayım, transfer, çoklu depo. | PO → Receipt (lot, SKT, kısmi teslim). | Parti disiplini güçlü (ADR-015); **giriş gömülü ve tek satır** (B-13); mal kabul ekranı yok. | **Fatura belgesinden (foto/XML) çok satırlı mal kabul** (AI, ADR-008 çerçevesi). Düşük stoktan tek tıkla giriş. |
| **Stok kullanımı** | Satışla düşer; tedavi serbest metin; uygulama kaydı belirsiz. | Record (lot, yol) → fatura; item rule. | **Yapılandırılmış uygulama kaydı** (parti, hekim, iptal/zarar) güçlü. | Uygulama = **tek giriş** (stok + kayıt + ücret önerisi). Aşıda backend hazır (K1). |
| **Lab** | Hasta kartından istek, panel/grup, analit tablosu + referans, paylaşım. Kötü: durum filtresi yok. | Klinik çapında lab listesi. | Durumlu, rozetli. Analit/referans yok. | **Bekleyen lab Bugün'de** + sonucu müşteriye tek tıkla gönderme. |
| **Yatış** | Hafif serbest metin; taburcu çıkış tarihi bağımsız. | **Treatment Board**: vital + etkinlik zaman çizelgesi. | Yatış modeli, bakım talimatı, taburcu. | **Günlük bakım panosu** (bugün yapılacaklar); E-vet'te yalnız rapor ("Bugün uygulanacak tedaviler"). |
| **Hatırlatma** | Liste + SMS/e-posta/WhatsApp ön dolu, aşılanmamış takibi, toplu SMS. | Reminders Detail: filtre, toplu gönder, arama kaydı. | Aşı e-postası (doğrulanmadı), çalışma listesi yok. | **Arama/gönderim listesi + sonuç kaydı** ve **WhatsApp ön dolu bağlantı** (Türkiye pratiği). |
| **Kayıt defteri / rapor** | Tek Rapor menüsü, ortak kabuk, 6 resmî defter, belge çıktıları. | Raporlar geniş, bazıları statik. | Rapor Merkezi + 6 defter (yerel `main`), borç raporu. Belge çıktıları yok. | Resmî geçerlilik **ikisinde de doğrulanmadı**; mevzuat doğrulaması bizim avantajımız olabilir. |
| **Gün sonu / kasa** | Günlük Kasa, Günlük İşlem Dökümü, tarihler arası kasa; mutabakat yok. | Kasa mutabakatı (açılış/kapanış). | **Yok** (B-19). | **Açık iş denetimli gün sonu:** ücretlenmemiş, açık geliş, bekleyen lab, kasa sayımı tek ekranda. İkisinde de yok. |

### 2.1 Rakiplerin iyi yaptığı (alınacak iş fikirleri)

1. **Bir olay, tek giriş** (DaySmart: kayıt = stok + hatırlatma + fatura satırı; E-vet: ziyaret formunda muayene, aşı, satış). Bizde en büyük eksik.
2. **Hasta/ziyaret bağlamı ekranda sabit** (DaySmart üst bant: hasta, fatura, hatırlatmalar). Bizde hasta başlığı muayenede var, tedavi/aşı formlarında rozet eklendi (B-10).
3. **Fiyatlı katalog** (ürün + hizmet) ve **paket/bundle** (muayene+aşı+ilaç tek seçim) rakiplerde temel; ücreti hızlı yapan budur.
4. **Aranabilir semptom ve teşhis sözlüğü** (E-vet) raporlama ve hız sağlar.
5. **Ödeme ekranı çok yöntemli** (split) ve ödeme fişi/ekstre.
6. **Hatırlatma iş listesi** (filtre, toplu gönder, sonuç kaydı).
7. **Kasa mutabakatı** (DaySmart) ve **günlük işlem dökümü** (E-vet).
8. **Tek Rapor girişi + ortak filtre kabuğu** (zaten yaptık).
9. **Mal kabulde lot/SKT zorunluluğu ürün bayrağıyla** (E-vet "Miat Kontrolü"; biz ürün sınıfıyla yapıyoruz).

### 2.2 Rakiplerin kötü yaptığı / kullanıcıyı yoran (kopyalanmayacak)

1. **Tek uzun form, sekmeler arası dolaşma** (E-vet Yeni Ziyaret, DaySmart SOAP): doldurma sırası belirsiz, uzun, kaybolma riski.
2. **Çok sayıda kayıt türü ayrı menüde** (E-vet Muayene menüsünde 13 tanım ekranı; DaySmart ayarda 38 yol): öğrenme maliyeti.
3. **Durum zinciri ağır** (DaySmart 5 durum) veya **hiç yok** (E-vet geldi/bekliyor).
4. **Lab/yatış ziyaretten kopuk** (E-vet), **iş kuyruğu statik rapor** (DaySmart).
5. **Silme engelleri ve geri alma zorluğu** (E-vet: önce ödemeyi sil, sonra satışı sil); **kilit yok** (E-vet).
6. Çok finansal kavram yatay sekmelerde (DaySmart), ön muhasebeye uzanan yüzey (E-vet kasa, banka, gider: bilinçli kapsam dışımız).

### 2.3 İkisinde de eksik, bizim fark yaratabileceğimiz yerler

1. **Rol ayrımlı ücret akışı:** hekim işlemi yapar, resepsiyon denetleyerek ücrete çevirir; **ücretlenmemiş işlem uyarısı** (kaybolan gelir). İkisi rolsüz tek ekran.
2. **Açık iş denetimli gün sonu** (ücretlenmemiş, açık geliş, bekleyen lab, borç, kasa sayımı).
3. **Bugün'e açık işler** (bekleyen lab, borçlu çıkan, tamamlanmamış geliş).
4. **Kesinleştirme öncesi kısa tamamlanma kontrolü** (kilit kavramı E-vet'te yok, DaySmart'ta var ama kontrol listesi yok).
5. **Mevzuata uygun, parti bazlı uygulama kaydı** (aşı, narkotik) **tek girişle** defterlere akıtma (E-vet'te defterler raporda, giriş ayrı).
6. **Mal kabulde fatura belgesinden otomatik satır önerisi** (E-vet'te "AI ile aktar" var ama **doğrulanmadı**; biz doğrulanabilir ve onaylı yaparız).

---

## 3. Bu belge neyi kanıtlamıyor

Bkz. [HEDEF-IS-AKISLARI-2026-10.md bölüm 5](HEDEF-IS-AKISLARI-2026-10.md) (doğrulanmayanlar ve zayıf çıkarımlar listesi).

## İlgili belgeler

- [Arayüz iş akışı denetimi](ARAYUZ-IS-AKISI-DENETIMI-2026-10.md), [UX ilkeleri](ux-principles.md)
- [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md), [ADR-015](../decisions/ADR-015-batch-based-stock-and-registers.md), [ADR-016](../decisions/ADR-016-direct-sale.md), [ADR-017](../decisions/ADR-017-workflow-centered-navigation.md)
- [Rakip analizi](../roadmap/RAKIP-ANALIZI-2026-10.md), [E-vet](../competitors/e-vet.md), [DaySmart](../competitors/daysmart.md), [Ajan kuyruğu](../roadmap/AJAN-KUYRUGU.md)
