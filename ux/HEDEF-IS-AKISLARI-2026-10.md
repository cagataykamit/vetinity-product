# Hedef iş akışları ve uygulama önerisi (2026-10-14)

**Durum:** Öneri. Kod yazılmadı, hiçbir şey çalıştırılmadı. Kabul edilirse ADR-018 (ücret önerisi) ve ilgili backlog maddeleri açılır; ADR-017'nin dilim sırası bu belgeye göre güncellenir.
**Kaynak:** [RAKIP-IS-AKISI-CALISMASI-2026-10.md](RAKIP-IS-AKISI-CALISMASI-2026-10.md) (rakip akışları, kanıt etiketleri **[G] [O] [B] [V] [Ç]**), [denetim](ARAYUZ-IS-AKISI-DENETIMI-2026-10.md) (B-numaraları), [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md), [ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](../decisions/ADR-015-batch-based-stock-and-registers.md), [ADR-016](../decisions/ADR-016-direct-sale.md), [ADR-017](../decisions/ADR-017-workflow-centered-navigation.md).
**Yöntem notu:** Rakipten yalnız iş akışı ve iş kapsamı alındı; ekran düzeni, sekme yapısı, renk kopyalanmadı. Kullanıcıya soru sorulmadı; her karar öneri ve gerekçeyle yazıldı. Klinik pratiği doğrulaması pilotta yapılır, geliştirmeyi bekletmez.

---

## 0. Özet

Mevcut sistemin parçaları rakiplerden **daha sağlam** (Bugün kuyruğu, kısmi güncelleme ve kesinleştirme, ücret→tahsisli ödeme, parti bazlı stok, uygulama kaydı). Rakiplerin 12 yıllık avantajı **parçaları birbirine bağlayan akış**: bir olay bir kez girilir; stok, kayıt, hatırlatma ve ücret ondan türer; kullanıcı sayfa değiştirmeden çalışır.

**En önemli 5 bulgu:**

1. **Ücret kendiliğinden oluşmuyor.** İki rakipte de ücret satırı, işi yaparken (E-vet ziyaret formunun Satış sekmesi, DaySmart kayıt/bundle) fiyatlı katalogdan doğuyor. Bizde hekim işlemi yapıyor, ücreti başkası elle yazıyor, **fiyat katalogu ve "ücretlenmemiş işlem" listesi yok** (B-02). Kaybolan gelir riski. Rakipler rolsüz yapıyor; biz **rol ayrımını koruyarak** ücret önerisi + resepsiyon onayıyla (K2) daha güvenli yapabiliriz.
2. **Muayene bir sayfada değil, 6 sayfada.** Tedavi, reçete, aşı, lab, yatış ayrı form sayfaları; tam muayene ≈ 18 tıklama, ≈ 12 geçiş (denetim, çıkarım). Her iki rakipte işlemler **aynı ekranda** eklenir. Çözüm: yeni sayfa değil, mevcut muayene detayını **ziyaret çalışma alanına** çevirmek (yan panelden ekle, kayıttan sonra aynı yerde kal).
3. **"Bir olay, tek giriş" ilkesi** (DaySmart: aşı kaydı = stok + hatırlatma + fatura). Aşı için backend **bitti** (`26d805a`), ama **frontend formu yok**; hekim bugün hâlâ iki kayıt girmek zorunda (B-01 sahada açık).
4. **Hiçbir rakip "açık iş denetimli gün sonu" yapmıyor.** E-vet günlük kasa/işlem dökümü verir, DaySmart kasa mutabakatı; ikisi de ücretlenmemiş işlem, açık geliş, bekleyen lab, borçlu çıkanı **göstermez**. Burası fark yaratma alanı (K6 + K8).
5. **Denetimdeki sürtünmelerin çoğu dün-bugün kapatıldı** (menü, eylem çubuğu, ödemeye dönüş, doğrudan satış arayüzü, uyarı rozeti); **kalan açık işler artık akış kalitesi değil, veri bağları:** ücret önerisi, fiyat/hizmet kataloğu, Bugün açık işler, aşı tek giriş arayüzü, gün sonu. Bunlar migration/sözleşme gerektirir.

**İlke:** Rakibin ekranını değil, **çözdüğü problemi** alıyoruz: (a) bir olay bir giriş, (b) bağlam taşınır, (c) yaptığın yerde kal, (d) kaybolan gelir görünür, (e) rol ayrımı korunur, köprü kurulur.

---

## 1. Hedef akışlar

Gösterim: **Bugün** = denetim/kod okumasından ve rakip ekran dizisinden çıkarılan alt sınır tahmin (ölçülmedi). **Hedef** = tasarım hedefi (ölçülmedi, uygulanınca ölçülür).

### 1.1 Hasta bulma ve geliş

**Hedef akış (Resepsiyon):**
1. Üst çubuktaki aramaya ad/telefon/çip yaz (yapıldı). Sonuç satırında **kısa eylemler**: *Geldi*, *Randevu*, *Muayene* (yeni, bugün yalnız detay sayfasındaki eylem çubuğunda).
2. Sonuç yoksa aynı kutudan **"Yeni müşteri ve hasta"** (hızlı kayıt, telefon zorunlu; var).
3. Randevulu hasta: Bugün'de satırdan *Geldi* (var).
4. Geliş anında satırda: acil, bekleme süresi, hayvan uyarıları, **borç** (var) ve **"önceki ziyaretten kalan açık iş"** (lab bekliyor, ücretlenmemiş; K6, yeni).

**Adım:** Bugün 3–4 (arama, sonuç, hasta, Geldi) → Hedef **2–3** (arama, satırdaki Geldi). Kayıtsız hasta: bugün 3 → hedef 3 (aynı).

**Mevcut sayfalar:** Bugün **kalır ve merkez olur**; Hastalar (Müşteri+Hayvan sekmeli) kalır; global arama kalır.
**Yeni yüzey:** yok. Arama sonucuna eylem düğmeleri (frontend).
**Rakipten alınan:** E-vet'in detaylı kimlik araması (çip, protokol, telefon; SEARCH-001 çoğunu karşılıyor), DaySmart'ın "yeni hasta takvimden ayrılmadan" fikri (bizde hızlı kayıt var).
**Rakibi geçtiğimiz:** E-vet'te geldi/bekliyor/acil yok, DaySmart'ta check-in formu uzun; bizim geliş tek tık.
**Rol:** Rsp geliş açar; Hkm "benim hastalarım" görünümü; Yön hepsini görür.
**ADR uyumu:** ADR-009 (Visit), ADR-017 K3/K5/K7 uyumlu. **Küçük değişiklik önerisi:** Hastalar giriş sayfası, tablo yerine **arama-öncelikli** açılsın (E-vet'in "müşteri satırı genişler, altında hayvanlar" düzeni, **[B]**); tablo ikinci düzey. ADR-017'deki "Müşteri + Hayvan sekmeli" ifadesi bunun için gevşetilir.

### 1.2 Randevu

**Hedef akış (Rsp):**
1. Hasta/müşteri eylem çubuğundan veya takvimden *Randevu al* (var). Form hasta ile gelir.
2. **Randevu türü** seç (kontrol, aşı, muayene, operasyon vb.) → **süre ve hekim önerisi otomatik** (kliniğin tanımı, Ayarlar > Tanımlar).
3. Formda hekimin o günkü dolu saatleri **şerit olarak** görünür (E-vet'in slot doluluğu fikri **[B]**).
4. Kaydet → hatırlatma ayarı varsayılan (ayardan).

**Muayenede "Kontrol tarihi" alanı** (E-vet **[G]**) bizde "takip tarihi" olarak tedavi içinde; hedef: muayene kapanışında **tek alan: sonraki kontrol/aşı tarihi**, yanında *Randevu oluştur* (tek tık, hasta/hekim dolu) ve hatırlatma listesine düşer.

**Adım:** Bugün hasta bulunduktan sonra ≈ 4–5 → Hedef ≈ 3 (tür seç, saat seç, Kaydet).
**Mevcut sayfalar:** Randevular (Liste + Takvim sekmeli) kalır. **Yeni:** randevu türü tanımı (Ayarlar), takvim şeridi.
**Alınmayan:** E-vet'in "görev tipi" ile borç hatırlatma, taburcu gibi işleri takvime koyması: bunlar randevu değil **arama/yapılacak listesi** (bölüm 1.10).
**Rol:** Rsp, Hkm, Yön oluşturur (mevcut).
**ADR uyumu:** ADR-009 K4 (randevu başına tek muayene kuralı yok) açık kalır. APPT-006 (randevu nedeni, varsayılan süre) backlog'da; bu akış onu **P1'e çeker**.

### 1.3 Muayene: ziyaret çalışma alanı (şikâyet, bulgu, tanı, tedavi, reçete, aşı, uygulama)

Bu akış değişimin kalbi. **Yeni sayfa açılmaz;** mevcut muayene detayı/çalışma alanı genişler.

**Hedef akış (Hkm):**
1. Bugün'de satırdan *Muayene başlat* (ziyaret bağlı, hasta seçimi yok; var). Sayfa: üst **hasta bandı** (ad, tür, yaş, kilo, kritik uyarılar, bakiye, geliş durumu).
2. **Muayene bölümleri** (var): şikâyet/anamnez, bulgu + vital, değerlendirme (tanı), plan. Kayıtta kısmi güncelleme korunur.
3. **İşlemler** tek liste (yeni): tedavi, reçete, aşı, uygulama (stoktan düşen), lab, yatış. Her işlem **"+ İşlem ekle"** ile **yan panelde** açılır; müşteri, hayvan, muayene, ziyaret **dolu ve salt okunur**; kayıttan sonra **aynı sayfada kalınır**, liste güncellenir (B-07'nin kökü).
4. **Aşı ve uygulama tek girişte** (K1): ürün/parti seçilince aşı kaydı + stoktan düşüm tek işlemde (backend var).
5. Sayfanın "**Ücret kalemleri (öneri)**" bölümü: yapılan işlemlerden doğan kalemler salt görünür (hekim ücret **eklemez**, ADR-012); fiyatsa katalogdan önerilir. (Bölüm 1.4.)
6. **Kapat:** *Kesinleştir* öncesi **tamamlanma kontrolü** (uyarı, engel değil; K10): tanı boş mu, ücretlenmemiş işlem var mı, takip tarihi var mı. Sonra *Bakım tamamla* (Visit).
7. Gerekirse kontrol/sonraki aşı tarihi + *Randevu oluştur* (bölüm 1.2).

**Adım:** Bugün tam muayene ≈ **18 tıklama / ≈ 12 geçiş** (denetim; kısmen düşmüş olabilir, ölçülmedi) → Hedef ≈ **9–11 tıklama / 1–2 geçiş** (muayene, 3 işlem yan panelden, kesinleştir). Hedef sayı tahmin.
**Mevcut sayfalar:** Muayene detayı/çalışma alanı **kalır ve genişler**. Tedavi/reçete/aşı/lab/yatış **"Yeni"** form sayfaları, hasta eylem çubuğu ve hızlı yoldan hâlâ erişilir (retro giriş için); bağlamsız "Yeni" menüden kalkar (aşağıdaki ADR-017 K4 değişikliği).
**Yeni yüzey:** "İşlemler" bölümü + yan panel (yeni sayfa değil); tamamlanma kontrolü diyaloğu.
**Rakipten alınan:** E-vet'in **tek kayıt/tek Kaydet** ve sözlükten seçim fikri; DaySmart'ın **üst bağlam bandı** ve **kayıt = fatura satırı** bağı.
**Rakibi geçtiğimiz:** E-vet'in yapılandırılmamış tedavisi ve kilitsiz kaydı; DaySmart'ın uzun SOAP ekranı. Biz: kısa bölümler, yapılandırılmış işlemler, kilit + ek not.
**Sözlük (semptom/teşhis):** E-vet'te 1.435 semptom, 1.170 teşhis kaydı, aranarak seçiliyor **[B]**. Öneri: pilotta **serbest metin kalır**; pilot sonrası "kliniğin tanı listesi" (yazılan tanı onayla listeye eklenir, Ayarlar > Tanımlar). Gerekçe: sözlüğün hekimlerce **gerçekten kullanıldığı doğrulanmadı**, ilk gün için gerekli değil (RAKIP-ANALIZI "tanım yüzeyi" çıkarımı).
**Rol:** Hkm kayıt eder; Rsp yalnız okur ve ücret bölümünü kullanır; Yön her şeyi.
**ADR uyumu:** ADR-005 (modern muayene), ADR-013 (kesinleştirme kilit + ek not), ADR-009 (Visit) uyumlu. **Veri notu:** `visitId` bugün Charges, Examinations, Hospitalizations, LabResult, CareInstructions uç tanımında var (kod taraması); Treatments, Prescriptions, Vaccinations'da yok (B-16 kısmen sürüyor). Ziyaret çalışma alanı tedavi/reçete/aşıyı **muayene üzerinden** ziyarete bağlar, yeni alan gerektirmez.
**Muayenesiz ziyaret** (yalnız aşı veya yalnız ürün için gelen): çalışma alanı **Visit etrafında** açılabilmeli, muayene bölümü isteğe bağlı. Administration `examinationId` opsiyonel (sözleşme, kod); aşı/tedavi için doğrulanmadı (bölüm 5).

### 1.4 Ücretin oluşması (hekimin işlemi → resepsiyon)

**Hedef akış:**
1. Hekim işlemi kaydeder (tedavi, uygulama, aşı, reçeteli ürün, lab, yatış). Sistem her ücretlenebilir işlem için **"ücret bekliyor" kalemi** üretir (ADR-017 K2, yeni model: *ücret önerisi*). Fiyat, **ürün/hizmet kataloğundan** (varsa) gelir; yoksa boş, resepsiyon girer.
2. Bugün satırında **"Ücret bekliyor (n kalem)"** rozeti çıkar.
3. Rsp satırdan **"Ücretlendir"** yan panelini açar: kalemler listelenir; her kalem **Onayla / Fiyatı düzenle / Ücretsiz say (gerekçe zorunlu)**. *Ücrete çevir* → tek işlemde ücret kaydı(ları).
4. Aynı panelde **"Ödeme al"** (müşteri ve açık ücretler dolu; var olan ödeme formu) → tahsil → panel kapanır.
5. Onaylanmamış kalem **kesinleştirme kontrolünde ve gün sonunda** görünür (kaybolmaz).

**Adım (Rsp):** Bugün ücret için sayfa gezip kalemleri bulma + 3 (tek kalem ücret) ≈ **5–8**, kalemler bulunamazsa kayıp → Hedef **3** (rozet, Ücretlendir, Onayla; ödeme için +2).
**Çift giriş:** yok; kalem işlemden doğar, aynı bilgi ikinci kez yazılmaz.
**Fiyat/hizmet kataloğu:** Ürün kataloğuna **"Hizmet" türü** (stok takibi yok): muayene, kontrol, operasyon, bakım. Rakipte iki yerde de ürün+hizmet aynı **fiyatlı katalogdan** gelir (E-vet "ürün tipi/grubu/alt grubu", DaySmart item + kategori, **[B]**). Bizde ürün fiyatı var (ADR-016 satış fiyatı), hizmet yok. Bu, FIN-008'i (ertelenmişti) **yeniden açar**; gerekçe: ücret önerisi katalogsuz fiyatsız kalem üretir ve resepsiyon yine elle yazar.
**Paket/bundle** (E-vet operasyon paketi, DaySmart bundle): pilot sonrası; önce tekil kalem.
**Mevcut sayfalar:** Ücretler ve Ödemeler (Para) **kalır** (denetim, düzeltme, geçmiş); ücret oluşturma artık normalde Ücretlendir panelinden. Elle "Yeni Ücret" (serbest ücret) kalır.
**Rol:** Hkm yalnız kalemi görür/işaretler; **ücrete çevirme Rsp ve Yön** (ADR-012 karar 2 korunur: hekim `Charges.Create` yok). Ücretsiz sayma gerekçelidir ve audit'lenir.
**ADR uyumu:** ADR-012 ile **uyumlu, genişletir**; kalem (öneri) yeni varlıktır, Charge değildir. **ADR-018 gerekir** (ücret önerisi modeli, durumlar, kalemin kaynağı = işlem türü ve kimliği, iptal/değişiklikte davranış). ADR-017 K2 zaten kabul; model ADR'si eksik.
**Pilot-öncesi küçük sürüm (migration yok):** önerilen kalemler yerine **hesaplanan "ücreti olmayan ziyaret/muayene" listesi** (Bugün rozeti + gün sonu). Kalem düzeyi yok ama kaybolan geliri görünür kılar. (Dilim D2.)

### 1.5 Tahsilat ve borç

**Hedef akış:**
1. Bugün satırında **"Ödeme al"** birincil düğme (bugün ⋯ menüsünde, B-03 kısmen çözüldü).
2. Ödeme formu: müşteri ve açık ücretler dolu; **birden çok yöntem** (nakit + kart; E-vet'in split ödemesi **[B]**, canlı testle gözlendi); fazla ödeme reddi korunur (ADR-012).
3. Kayıt sonrası **makbuz/bilgi fişi** (yazdır/WhatsApp); ödeme müşteri hesabına yazılır.
4. Sonraki gelişte borç satırda; Hastalar/Müşteri sayfasında **Hesap** bölümü: ücretler + ödemeler + bakiye tek ekran (B-03'ün devamı).

**Adım:** Bugün (ücret var) 3; (ücret yok) ≈ 8 → Hedef 3 / 4 (ücret panelinden devam).
**Rakibi geçtiğimiz:** E-vet'te ödeme tahsisi (hangi borca) görünmüyor, silme önce ödemeyi silmeyi gerektiriyor; DaySmart'ta finansal kavram çok. Biz: tahsisli, düzeltme/iptal gerekçeli.
**Alınmayan:** E-vet'in kasa/banka/cari/gider (ön muhasebe, bilinçli kapsam dışı), DaySmart'ın kredi/iade/write-off yüzeyi (FIN-005 ertelendi).
**Rol:** Rsp tahsilat; düzeltme/iptal Yön (ADR-012).
**ADR uyumu:** ADR-012 uyumlu. **Doğrulanacak:** ödeme formunun çok yöntemli kayıt desteği (kod okunmadı; bölüm 5).

### 1.6 Doğrudan satış

**Hedef akış (Rsp):** Bugün'den veya Para > Satışlar'dan *Hızlı satış*: ürün ara/barkod → parti önerisi (FEFO, süresi geçmiş engelli) → fiyat → müşteri (veya Peşin) → ödeme → fiş. (Yapıldı; kod okuması, **tarayıcıda doğrulanmadı**.)
**Ek öneri (pilot sonrası):** Satışa **opsiyonel ziyaret bağı**: muayene sırasında hasta sahibine verilen ürün (mama, ilaç) resepsiyondan satılırken ziyaret seçilir; ziyaretin hesap özetinde görünür. Hekim satmaz (ADR-016 karar 9 korunur); hekim "verilecek ürün" notunu ücret önerisine **kalem** olarak bırakır (bölüm 1.4).
**ADR uyumu:** ADR-016 uyumlu. **Tek ücret kararı (K5)** ziyaret bağıyla çelişmez (satış tek ücret, ziyaretle ilişkili). **Çelişki adayı:** E-vet ve DaySmart ziyaret içinde ürün satışını hekimin ekranından yapıyor; ADR-016 K9 hekimi satıştan çıkarıyor. Öneri: değiştirme; rol ayrımı + ücret önerisi aynı işi denetimli yapar. Pilot gözleminde hekimin "ürünü kendisi satmak istemesi" yaygınsa K9 yeniden açılır.
**Barkod okutma:** E-vet'te var **[B]**; bizde **doğrulanmadı**, pilot sonrası.

### 1.7 Stok girişi (mal kabul) ve kullanımı

**Hedef akış (Rsp, Yön) mal kabul:**
1. Stok > **Mal kabul** (veya Stok durumu/düşük stok satırından *Giriş*): tedarikçi, fatura no/tarih (ADR-015 alanları) **bir kez**.
2. Çok satır: ürün, **parti no, SKT** (kontrollü sınıfta zorunlu), miktar, birim maliyet (isteğe bağlı).
3. **Kaydet** = tek işlem, N stok girişi (hepsi ya da hiçbiri).
4. Süresi geçmiş SKT'de uyarı (yapıldı).
**Adım:** Bugün tek ürün 3–4 (satır başına); 5 ürünlü mal kabul ≈ 15 → Hedef 4 + satır başına 2–3.
**Uzun vadeli fark yaratma:** fatura belgesi (foto/XML) → satır önerisi → kullanıcı onayı (ADR-008 gömülü yardımcı çerçevesi; E-vet'te benzeri var ama **çalıştığı doğrulanmadı**).
**Kullanım:** stok yalnız **üç yoldan** düşer: uygulama (hekim; aşı dahil), doğrudan satış (Rsp), elle düzeltme/zarar (Yön, gerekçeli). Üçü de aynı parti kuralını kullanır (FEFO, SKT engeli; ADR-015 kural tek yerde).
**Alınmayan:** E-vet'in çoklu depo, transfer, sayım, stok sıfırlama, sipariş/alış/iade faturası, satıcı ödemesi; DaySmart'ın PO → Receipt zinciri. Pilot kapsamı küçük klinik; sayım ADR-015'te ertelendi.
**Mevcut sayfalar:** Ürünler, Stok durumu, Stok hareketleri (Stok sekmeli) **kalır**; Mal kabul yeni sekme/yüzey.
**ADR uyumu:** ADR-015 uyumlu; yeni belge varlığı gerekmez (ortak fatura alanları satıra kopyalanır; toplu uç tek transaction). Belge düzeyi (fatura ↔ girişler) raporlama için istenirse ADR-015 eki.

### 1.8 Laboratuvar

**Hedef akış:**
1. İstem muayeneden (işlemler yan paneli) veya hasta eylem çubuğundan (var).
2. Hasta ayrılır; lab **Bugün'de "Lab bekliyor"** olarak görünür (K6; menü rozeti de kalır).
3. Sonuç girişi: Bugün'den veya lab listesinden **satır yan panelinde** (sonuç metni, yorum) → Kaydet.
4. Hekim yorumu → **"Sahibine gönder"** (WhatsApp/e-posta ile PDF/özet; pilot sonrası).
**Adım:** Bugün sonuç girişi ≈ 4 (rozet, satır, sonuç, Kaydet), 3–4 geçiş → Hedef 3, geçiş 0.
**Alınmayan (ilk sürüm):** analit tablosu, referans aralığı, cihaz/LIS entegrasyonu (E-vet'te analit+referans var **[B]**; ihtiyaç pilotta ölçülür). E-vet'in **durum filtresi yok** zayıflığı bizde yok (rozet + liste süzgeci).
**Rol:** Hkm ister ve yorumlar; sonucu kimin gireceği klinikte değişir: **Hkm ve Rsp sonuç girebilir** (öneri, izin ayrımı mevcut `LabResults.Update` ile doğrulanır; kod okunmadı).
**ADR uyumu:** Aşama 6 lab durumu ile uyumlu.

### 1.9 Yatış

**Hedef akış:** Muayeneden/işlemler panelinden *Yatış başlat* (bugün yapıldı); Bugün'de aktif yatış kartı (var). **Hedef ek:** yatış kartında **"Bugünkü bakım"** listesi: bakım talimatından saatli maddeler, *Yapıldı* tikiyle (DaySmart Treatment Board'un etkinlik/Complete fikri **[B]**, görünüm kopyalanmaz). Taburcu: tek diyalog (var) + **taburcu kontrolü** (açık borç, bekleyen sonuç; ana plan "kısa tamamlanma kontrolü", PATTERN-004).
**Pilot önceliği:** düşük; küçük klinikte yatış hacmi az olabilir (**doğrulanmadı**). Pilotta mevcut hâl yeterli.
**Rol:** Hkm açar/taburcu eder/bakım yazar; bakım tikini hekim veya **bakım personeli** (rol yok; pilot sonrası) atar.

### 1.10 Kontrol ve aşı hatırlatma (arama listesi)

**Hedef akış (Rsp):**
1. **"Aranacaklar"** çalışma listesi (Randevular altında bir sekme veya Bugün'ün ikinci sekmesi): gecikmiş aşı, kontrol tarihi geçmiş, borçlu müşteri, bugün/bu hafta vadesi gelenler (hesaplanan liste, D-N1 mantığı).
2. Satırdan eylem: **WhatsApp ile gönder** (ön dolu şablon; E-vet pratiği **[B]**, kullanıcı WhatsApp'ta gönderir), **Ara** (telefon bağlantısı), **Arandı** (not + sonuç: ulaşıldı/ulaşılamadı/randevu verdi), **Randevu ver** (hasta dolu).
3. Sonuç kaydı satırı listeden düşürür veya ertelenir; müşteri geçmişinde görünür (DaySmart "log call" **[B]**).
4. E-posta hatırlatma otomatik (var, **gerçek gönderim doğrulanmadı**).
**Adım:** Bugün listeye tek yerden bakma yok (aşılar listesi gecikmiş süzgeci); hedef 3 / hatırlatma.
**Alınmayan:** E-vet'in toplu SMS/doğum günü/kampanya (pazarlama, ticari ileti KVKK/ETK doğrulaması gerekir); mobil bildirim.
**Rol:** Rsp; Hkm okur.
**ADR uyumu:** yeni kapsam; ayrı backlog maddesi gerekir (REMIND-?). **Uyarı:** WhatsApp ön dolu bağlantı mesajı **işlem iletisi**, kampanya değil; yasal uygunluk pilot hukuki incelemesine bırakılır (**doğrulanmadı**).

### 1.11 Kayıt defterleri ve raporlar

**Hedef akış:** Rapor Merkezi (var): kart → tarih aralığı → önizleme → yazdır/PDF/Excel. **Eklenecek:** hızlı tarih ön ayarları (bugün, bu hafta, bu ay, geçen ay) ve **hasta belge çıktıları** (epikriz/muayene özeti, aşı karnesi) hasta çalışma alanından tek tık; E-vet'in "Epikriz Raporu" ve "Sağlık Karnesi" fikri **[B]**.
**Yapıldı:** altı defter (muayene, reçete, aşı, ilaç, narkotik/psikotropik, aşı bilgi; frontend yerel `main`'de). Resmî geçerliliği **ikisinde de doğrulanmadı**; mevzuat doğrulaması pilot hazırlığında (ADR-015 madde 5).
**Rol:** claim'e göre kart (var). **ADR uyumu:** ADR-003, ADR-015 uyumlu.

### 1.12 Gün sonu

**Hedef akış (Yön, kasadan sorumlu Rsp):**
1. Raporlar > **Gün sonu** (ve Bugün'den *Günü kapat* kısayolu).
2. **Bölüm A, açık işler:** tamamlanmamış geliş, **ücreti onaylanmamış kalem/ücreti olmayan ziyaret**, ödeme bekleyen, bekleyen lab, aktif yatış. Satıra tıklayınca ilgili ziyaret çalışma alanı.
3. **Bölüm B, tahsilat:** ödeme yöntemine göre toplam (nakit, kart, havale), satış toplamı (Satışlar ayrı satır), iptal/düzeltme listesi (gerekçeli).
4. **Bölüm C (isteğe bağlı):** "sayılan nakit" gir → fark görünür (not; kilit/mutabakat kaydı yok).
5. Yazdır/PDF.
**Adım:** Bugün ≥ 4 ayrı rapor → Hedef 2 (Gün sonu, tarih).
**Alınmayan:** E-vet'in kasa/banka/gider/yıllık gelir-gider, DaySmart'ın kapanış bakiyesi kilitleme (kasa mutabakatı ADR-012'de kapsam dışı). **Küçük çelişki:** Bölüm C "sayılan nakit" ADR-012'nin "kasa mutabakatı kapsam dışı" ifadesine **yaklaşır**; yalnız not alanı olarak (ledger/kilit yok) tutulursa çelişmez. Pilot sonrasına bırakılır.
**ADR uyumu:** ADR-017 K8 (günlük işlem dökümü + tahsilat/kasa özeti) ile uyumlu, kapsamı **açık iş bölümü** ile genişletir.

---

## 2. Rol bazlı kim neyi yapar (hedef)

| İş | Resepsiyon | Hekim | Yönetici |
|---|---|---|---|
| Hasta bul, geldi, hızlı kayıt, randevu | Yapar | Randevu alabilir (mevcut) | Yapar |
| Muayene, işlemler, aşı, uygulama, lab isteği, yatış | Okur | **Yapar** | Yapar |
| Lab sonucu girişi | Girebilir (öneri, doğrulanacak) | Girer ve yorumlar | Yapar |
| Ücret kalemi (öneri) | Görür ve onaylar | **Görür, ekleyemez** | Onaylar |
| Ücrete çevir, ödeme al | **Yapar** | Okur | Yapar |
| Ücret/ödeme düzeltme-iptal | — | — | **Yapar** (gerekçeli) |
| Doğrudan satış | **Yapar** | Yapmaz (ADR-016 K9) | Yapar, iptal eder |
| Mal kabul, stok girişi | Yapar | Okur | Yapar |
| Aranacaklar (hatırlatma listesi) | **Yapar** | Okur | Yapar |
| Gün sonu | Görür/kasa notu | — | **Yapar** |
| Tanımlar (hizmet kataloğu, randevu türü) | — | — | **Yapar** |

Rol açılışı (ADR-017 K5): Rsp ve Hkm → Bugün; Yön → Bugün (Özet ikinci yüz). Ayrı rol modları (Seçenek 3) hâlâ pilot geri bildirimine bırakılır.

---

## 3. ADR uyumu ve çelişkiler

| Konu | Mevcut karar | Hedefle ilişki | Öneri |
|---|---|---|---|
| ADR-012 K2 (hekim `Charges.Create` yok) | Kabul | **Uyumlu**; ücret önerisi hekimi ücretten ayırmaya devam ediyor | Değişiklik yok. **ADR-018** (ücret önerisi modeli) aç. |
| ADR-012 "kasa mutabakatı kapsam dışı" | Kabul | Gün sonu Bölüm C yaklaşır | Pilot sonrası; yalnız not alanı. |
| ADR-012 / FIN-008 hizmet kataloğu | **Ertelendi** | **Çelişir:** ücret önerisi katalog ister | **FIN-008'i yeniden aç** (yalnız "Hizmet" ürün türü, fiyat; KDV/birim sonra). |
| ADR-013 kesinleştirme kilit + ek not | Kabul | Uyumlu; kontrol listesi genişler | K10 metin uyarısı (yapıldı) → kalem/ücret uyarısı ADR-018 ile. |
| ADR-015 parti, SKT, tek kural | Kabul | Uyumlu; aşı/uygulama/satış tek kural, mal kabul çok satır | Yeni varlık yok; ek toplu uç. |
| ADR-016 K5 (satış başına tek ücret) | Kabul | Uyumlu | Opsiyonel `visitId` ekle (pilot sonrası). |
| ADR-016 K9 (hekim satış yapmaz) | Kabul | **Rakip pratiğiyle gerilim:** E-vet/DaySmart'ta hekim ürünü ziyarette ekler | Değiştirme; ücret önerisi aynı işi denetimli yapar. Pilotta izle. |
| ADR-017 K1 (aşı tek giriş) | Kabul (rakip pratiği) | Backend yapıldı, **frontend yok** | İlk dilimlerde yap. |
| ADR-017 K2 (ücret önerisi) | Kabul | Model ADR'si yok | ADR-018. |
| ADR-017 K3 (Hastalar sekmeli) | Kabul | E-vet'in **arama-öncelikli** açılışı daha iyi | Hastalar giriş sayfası arama-öncelikli; tablo ikinci düzey. Küçük değişiklik. |
| **ADR-017 K4 (Kayıtlar tek öğe, sekmeli)** | Kabul | Kayıt listeleri hâlâ **"Yeni"** düğmesi taşıyorsa bağlamsız kayıt (müşteri+hayvan baştan) çift giriş üretir (B-12) | **Değişiklik öner:** Kayıtlar listeleri **denetim/arama** amaçlı; **"Yeni" yalnız bağlamdan** (ziyaret çalışma alanı, hasta eylem çubuğu). Menü yapısı aynı kalır. |
| ADR-017 K6 (Bugün açık işler) | Kabul (rakip pratiği) | Gün sonu ile aynı hesap | Tek sorgu iki yüzey (kural tek yerde). |
| ADR-017 K7 (randevudan önce Visit) | Kabul | DaySmart check-in ile aynı yön | Yapıldığı **doğrulanmadı** (bölüm 5). |
| ADR-017 K8 (gün sonu) | Kabul | Açık iş bölümüyle genişler | Dilim D6. |
| ADR-009 (Visit) | Kabul | Ziyaret çalışma alanı Visit etrafında | Tedavi/reçete/aşıya `visitId` gerekmez (muayene üzerinden). |
| ADR-004 (menü sade) | Kabul | Menü 9 öğe, uyumlu | Yeni menü öğesi **eklenmez**: Mal kabul = Stok sekmesi, Aranacaklar = Randevular sekmesi, Gün sonu = Raporlar kartı. |

**Yapılmış işlerle uyum (kod okuması, çalıştırılmadı):** menü (9 öğe, sekmeli) hedefle uyumlu; hasta/müşteri eylem çubuğu hedef akışın giriş noktası; aşı tek giriş **yarım** (backend var, frontend yok); doğrudan satış hedefle uyumlu (ziyaret bağı eksik, pilot sonrası); ödemeye dönüş (B-03) yapıldı; **muayene detayındaki ayrı "Oluştur" sayfaları** hedefle **çelişir**, yan panele taşınacak.

---

## 4. Uygulama dilimleri

**Zorluk işareti (hepsi ölçülmedi, tahmindir):** K = küçük (birkaç dosya, güne kadar), O = orta (birkaç gün), B = büyük (hafta+ veya migration + çok yüzey).
**Tür:** FE = yalnız frontend; BE-S = backend sözleşmesi gerekir; MIG = migration gerekir (yerel dev DB'ye doğrulayarak; paylaşılan/üretim için ayrı onay).

### 4.1 Pilot öncesi (öneri sırası)

| # | Dilim | İçerik | Tür | Zorluk (ölçülmedi) | Bağımlılık / not |
|---|---|---|---|---|---|
| **D1** | **Aşı tek giriş: frontend** (K1) | Aşı formunda opsiyonel ürün/parti/miktar, stok düşümü bildirimi, hatalar backend metniyle | FE | K–O | Backend `26d805a`..`983e13d` yerel `main`'de; **migration `AddVaccinationAdministrationLink` uygulanmadı**, yerel DB'ye uygulanıp doğrulanmalı |
| **D2** | **Bugün açık işler + ücretlenmemiş ziyaret** (K6, B-02/B-15) | Satırda "Lab bekliyor", "Ücret yok/bekliyor", "Ödeme bekliyor" çipleri; hesaplanan liste | BE-S (okuma ucu, migration yok) + FE | O | Hesaplanan liste (D-N1); kalem düzeyi D4'te |
| **D3** | **Ziyaret çalışma alanı: İşlemler bölümü ve yan panel** (B-07, EXAM-010) | Muayene detayında işlemler tek liste; tedavi/reçete/aşı/lab/yatış yan panelden eklenir, aynı sayfada kalınır; kesinleştirme kontrol listesi; Kayıtlar listelerinde bağlamsız "Yeni" kalkar | FE (mevcut formlar yeniden kullanılır) | O–B | D1 ile aynı formu paylaşır; formlar sayfadan **bileşene** ayrılmalı |
| **D4** | **Ücret önerisi + hizmet kataloğu** (K2, FIN-008) | ADR-018; `Hizmet` ürün türü + fiyat; işlemden "ücret bekliyor" kalemi; Ücretlendir paneli; Hkm kalem görür | ADR + BE-S + **MIG** + FE | **B** | Pilot için **minimum**: tek kalem türü (uygulama ve aşı), fiyatlı ürünlerle; hizmet türü ve bundle sonra |
| **D5** | **Mal kabul** (B-13) | Çok satırlı stok girişi, tek işlem; düşük stok satırından "Giriş" | BE-S (toplu uç) + FE; düşük stok kısayolu FE | O | Migration yok (ortak fatura alanları satıra yazılır) |
| **D6** | **Gün sonu** (K8, B-19) | Açık iş, tahsilat (yönteme göre), satış, iptal/düzeltme; yazdır | BE-S (okuma) + FE | O | D2 sorgusunu paylaşır; Bölüm C (sayılan nakit) sonra |

### 4.2 Pilot sonrası

| # | Dilim | İçerik | Tür | Zorluk (ölçülmedi) |
|---|---|---|---|---|
| P1 | **Aranacaklar (hatırlatma çalışma listesi)** | Gecikmiş aşı/kontrol/borç listesi; WhatsApp ön dolu bağlantı; arandı kaydı | BE-S + MIG (arama sonucu kaydı) + FE | O–B |
| P2 | **Randevu türü ve süre ön ayarı**, "kontrol tarihi → randevu" | APPT-006; hekim doluluk şeridi | BE-S + MIG + FE | O |
| P3 | **Belge çıktıları** (muayene özeti/epikriz, aşı karnesi) | Hasta çalışma alanından PDF | FE (+ BE-S veri uçları) | O |
| P4 | **Satış–ziyaret bağı** | `Sale.visitId` opsiyonel, hesap özetinde | BE-S + MIG + FE | K–O |
| P5 | **Hasta çalışma alanı arama-öncelikli açılış** | Hastalar girişi (K3 ince ayarı) | FE | K |
| P6 | **Yatış günlük bakım listesi** | Bakım talimatından saatli maddeler, yapıldı tiki | BE-S + MIG + FE | O–B |
| P7 | **Tanı/semptom sözlüğü (kliniğin kendi listesi)** | Ayarlar > Tanımlar; muayenede aranarak seçim | BE-S + MIG + FE | O |
| P8 | **Lab analit/referans**, sonucu sahibine gönder | Yapılandırılmış sonuç; paylaşım | BE-S + MIG + FE | B |
| P9 | **Paket/bundle ve tedavi şablonu** | E-vet operasyon/tedavi paketi, DaySmart bundle: ücret önerisi + uygulama birlikte | BE-S + MIG + FE | B |
| P10 | **Teklif (estimate)** | Tedavi öncesi fiyat; onay; ücrete çevirme | BE-S + MIG + FE | B |
| P11 | **Mal kabul: fatura belgesinden aktarım** | Foto/XML → satır önerisi (ADR-008 çerçevesi, onaylı) | BE-S + FE (+ AI sağlayıcı kararı) | B |
| P12 | **Gün sonu Bölüm C** (sayılan nakit notu) | ADR-012 sınırına dikkat | FE + küçük BE | K |
| P13 | Barkod okutma, split ödeme doğrulaması | Satış/mal kabul hızlandırma | FE | K–O |

### 4.3 Önerilen ilk 3 uygulama dilimi

1. **D2: Bugün açık işler + ücretlenmemiş ziyaret.** *Gerekçe:* kaybolan geliri **hemen görünür** kılar (B-02, iki rakipte de olmayan fark), **migration gerektirmez**, ADR-017 K6 ve gün sonu (D6) için ortak sorguyu kurar. En yüksek değer/maliyet oranı.
2. **D1: Aşı tek giriş frontend.** *Gerekçe:* backend hazır ve testli; hekimin **çift giriş** sorununu (B-01, kritik) kapatır; D3'ün formlarını bileşene ayırmaya başlama fırsatı verir. Önce yerel DB'de migration doğrulaması.
3. **D3: Ziyaret çalışma alanı (İşlemler bölümü ve yan panel).** *Gerekçe:* denetimin en büyük sürtünmesi (≈ 18 tıklama, ≈ 12 geçiş); yalnız frontend; rakiplerin ortak gücü olan "tek ekranda işlem ekleme"yi bizim güvenli modelimizle (kısmi güncelleme, kilit) verir.

**D4 (ücret önerisi + katalog)** en büyük ve migration içerir: ADR-018 yazılıp ilk üç dilimle **paralel** hazırlanmalı; pilotta D2'nin "ücreti olmayan ziyaret" listesi geçici koruma sağlar. **Pilot başlamadan D4'ün asgari sürümü** (uygulama ve aşı kalemleri) önerilir; gerçekleşmezse pilot gölge dönemde (2 hafta, ADR-014 K4) elle ücretle yürür ve D2 listesi tek güvencedir.

---

## 5. Doğrulanmayanlar ve zayıf çıkarımlar

**Rakip gözleminin sınırları**

- Ekran görüntüsü kaydedilmemiş davranışı göstermez: E-vet'te yeni kayıtların çoğu kaydedilmemiş. **Zayıf çıkarımlar:**
  - E-vet'te ziyaret formundaki ürün satırının **stoktan düşüp düşmediği**, "uygulama" ile "satış"ın ayrılıp ayrılmadığı **bilinmiyor** (önceki belge de yan etkiyi doğrulamıyor). Bölüm 1.3 ve 1.6'daki "stok satışla düşer" **[Ç]**.
  - "Kaydet bakiyeye yazar, Kaydet/Öde ödeme ekranı açar" kısmı video anlatımına dayanıyor (**[B]**, canlı doğrulanmadı).
  - E-vet'te lab, yatış ve reçetenin **ziyaretle bağı**: formda yok; bağın başka yerde olup olmadığı bilinmiyor.
  - E-vet'te **rol ayrımı** (hekim ücret ekler mi) tek hesapla gezildiği için **bilinmiyor**.
  - E-vet'te "Yönlendir"in randevudan/kayıttan Muayene Odası kuyruğunu otomatik doldurup doldurmadığı **bilinmiyor**; kuyruğun elle dolduğu **[Ç, zayıf]**.
  - "AI ile fatura aktar" yalnız modal metni; çalışması doğrulanmadı.
- DaySmart check-in, durum zinciri (Booked→…→Check Out) ve checkout **videodan**; sandbox'ta doğrulanmadı. Census durum seçeneklerinin tam listesi bilinmiyor. Belge paketi tek PDF mi, doğrulanmadı.
- DaySmart'ta hızlı satış (doğrudan satış) ekranı **gözlenmedi**; "yok" diye yazılmadı, "gözlenmedi".
- Adım ve tıklama sayıları ekran sırasından çıkarım, **süre ölçülmedi**, hedef sayılar tasarım tahmini.
- OCR hatalı olabilir; incelenen ~55 E-vet ve ~10 DaySmart ekranı toplam 1.555'in küçük bir kısmı, **dört görüntüyü doğrudan** açtım.
- Resmî defter geçerliliği, e-reçete/HBS gönderimi, e-Fatura/e-SMM: **ikisinde de doğrulanmadı**; Türkiye mevzuat doğrulaması ayrı iş.

**Bizim durumumuzun sınırları**

- Uygulama **çalıştırılmadı**; "yapıldı" ifadeleri commit mesajı ve dosya varlığına dayanır (frontend `715aad9`, backend `983e13d`, **push edilmemiş**).
- Doğrudan satış backend migration'ının (`AddDirectSale`) **uygulanıp uygulanmadığı** ve aşı bağlantısı migration'ının uygulanmadığı doğrulanmadı.
- Randevudan muayene ADR-017 K7'nin (önce Visit) **gerçekleşip gerçekleşmediği** koddan doğrulanmadı.
- Ödeme formunun **çok yöntemli** (split) kayıt desteği ve `LabResults` izin ayrımı koddan okunmadı.
- Aşı/tedavi/reçetenin **muayenesiz** ziyarette (yalnız aşı için gelen) kaydedilip kaydedilemediği doğrulanmadı.
- Geçiş maliyetleri (zorluk işaretleri) ve hedef adım sayıları **ölçülmedi**.
- Klinik pratiği (lab sonucunu kimin girdiği, yatış hacmi, WhatsApp kullanımı, gün sonu alışkanlığı) rakip pratiğinden varsayıldı; pilotta [KLINIK-SORULARI-2026-10.md](KLINIK-SORULARI-2026-10.md) ile doğrulanır, geliştirmeyi bekletmez.

---

## İlgili belgeler

- [Rakip iş akışı çalışması](RAKIP-IS-AKISI-CALISMASI-2026-10.md), [Arayüz iş akışı denetimi](ARAYUZ-IS-AKISI-DENETIMI-2026-10.md), [UX ilkeleri](ux-principles.md)
- [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md), [ADR-009](../decisions/ADR-009-visit-model-and-arrival-flow.md), [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md), [ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](../decisions/ADR-015-batch-based-stock-and-registers.md), [ADR-016](../decisions/ADR-016-direct-sale.md), [ADR-017](../decisions/ADR-017-workflow-centered-navigation.md)
- [Rakip analizi](../roadmap/RAKIP-ANALIZI-2026-10.md), [Ajan kuyruğu](../roadmap/AJAN-KUYRUGU.md)
