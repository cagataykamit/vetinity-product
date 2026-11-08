# Pilot klinik görüşme paketi — 2026-11-09

Amaç: ilk pilot klinikle ilk görüşmede hiçbir şeyi atlamamak; görüşmeden önce bizim kararlarımızı netleştirmek, görüşmede kliniği tanımak, gösterim yapmak ve pilot koşullarında anlaşmak. Kaynaklar: [ADR-014](../decisions/ADR-014-pilot-and-production-operations.md) (K4 gölge kullanım, K8 içe aktarma, K9 kapsam), [canlı işletim kılavuzu](CANLI-ISLETIM-KILAVUZU.md) §10–12, [ADR-019](../decisions/ADR-019-data-import.md), [HBS ve e-belge görüşme paketi](hbs-e-belge-gorusme-paketi.md), [rol bazlı kullanıcı kılavuzu](KULLANICI-KILAVUZU-ROL-BAZLI.md). Hukuki tavsiye değildir.

---

## 1. Görüşmeden önce senin karar vermen gerekenler

Bunlar netleşmeden kliniğe söz verme; görüşmede "bunu size yazılı ileteceğim" demek yeterli.

| # | Konu | Seçenek / öneri |
|---|---|---|
| 1 | Pilot ücreti | Öneri: pilot süresi (gölge 2 hafta + ilk 1 ay) ücretsiz; sonra ilk yıl indirim (ör. %50) ve "kurucu klinik" olarak fiyat sabitleme. Paket: Kurumsal açılır, pilot sonunda klinik kendi paketini seçer |
| 2 | Pilot süresi | Öneri: 2 hafta gölge + 4 hafta gerçek kullanım; sonunda birlikte değerlendirme |
| 3 | Başlangıç tarihi | Sunucu kurulumuna bağlı (bölüm 6). Kurulum ve doğrulama hazır olduktan sonra en az 1 hafta pay bırak; kesin tarih verme |
| 4 | Sözleşme tarafı | Veri işleme sözleşmesi ve kullanım şartlarında Vetinity'nin unvanı boş (`[Şirket unvanı]`). Şahıs işletmesi mi, şirket mi? (mali müşavir sorusu, HBS/e-belge paketi madde 10) |
| 5 | Destek kanalı | Hangi telefon / WhatsApp / e-posta, hangi saatler; mesai dışında acil durumda kim aranır (kılavuz §12) |
| 6 | Bakım saati | Öneri: hafta içi 23:00–01:00 |
| 7 | Veri kaybı ve kesinti hedefi | Öneri: en çok 15 dk veri kaybı, en çok 4 saat kesinti (ADR-014 K2'yi yazılı kabul) |

## 2. Görüşme akışı (60–75 dk)

1. **Tanışma ve dinleme (15 dk):** klinik bugün nasıl çalışıyor, en çok neyden şikâyetçi. Önce dinle, sonra göster.
2. **Gösterim (25 dk):** bölüm 4'teki akış.
3. **Pilot koşulları (15 dk):** gölge kullanım, süre, ücret, destek, veri ve KVKK (bölüm 5).
4. **Kliniğin hazırlayacakları (10 dk):** bölüm 3'teki liste; kim, ne zamana.
5. **Sonraki adım:** kurulum tarihi aralığı, eğitim günü, iletişim kişisi.

## 3. Kliniğe sorulacaklar ve istenecekler

### 3.1 Klinik profili

- Hekim sayısı, diğer personel (sekreter, teknisyen), kim hangi işi yapıyor; kaç kişi sisteme girecek (rol: yönetici, klinik yöneticisi, veteriner, sekreter).
- Şube sayısı (pilot için tek şube tercih, ADR-014 K4).
- Günlük ortalama hasta; randevulu / randevusuz oranı; acil yoğunluğu.
- Hangi türler (kedi, köpek, kuş, egzotik, çiftlik?).
- Yatış, laboratuvar (kendi cihazı mı dış lab mı), görüntüleme var mı?
- Stok ve satış: ilaç, aşı, mama, aksesuar satıyor mu; stok kimde takip ediliyor?
- Ödeme yöntemleri: nakit, kart (POS), havale; veresiye / borç takibi nasıl?

### 3.2 Bugünkü sistem ve veri

- Kâğıt mı, Excel mi, rakip program mı (hangisi)? Programdan **dışa aktarma** (Excel/CSV) alınabiliyor mu?
- Aktarılacaklar (ADR-014 K8): müşteri, hasta, aşı geçmişi. Muayene ve ödeme geçmişi ilk sürümde aktarılmaz; klinik bunu kabul ediyor mu?
- Örnek bir dışa aktarma dosyası isteyin (kişisel veri içermeyen birkaç satırlık örnek ya da başlık satırı yeterli). Rakip program dosyası TIER-021 eşlemesini hızlandırır.

### 3.3 Resmî işler

- **e-Fatura / e-SMM:** klinik şahıs mı, şirket mi; bugün belgeyi nereden kesiyor (program, GİB portal, muhasebeci)? Mali müşavirinin iletişimi (e-fatura görüşmesi için, HBS/e-belge paketi bölüm 2).
- **HBS:** e-Reçete ve aşı (ATS) kaydını kim, ne zaman giriyor? Vetinity'deki HBS yardımcısını göster (bkz. HBS/e-belge paketi bölüm 1).
- **KVKK:** müşteriye aydınlatma metni veriyor mu, açık rıza formu var mı; VERBİS kaydı var mı?

### 3.4 Donanım ve ortam

- Bilgisayar sayısı, işletim sistemi, tarayıcı (Chrome/Edge güncel olmalı).
- Telefon / tablet kullanımı (hekim muayenede telefondan girecek mi?).
- İnternet bağlantısı ve yedeği (mobil hat?).
- Yazıcı (fiş, reçete, aşı karnesi çıktısı), barkod okuyucu var mı?

### 3.5 Hasta sahibi iletişimi

- Hatırlatmalar bugün nasıl gidiyor: SMS, WhatsApp, telefon? Müşterilerin e-posta adresi kayıtlı mı? (Vetinity bugün e-posta ile hatırlatır; SMS yok.)
- Kliniğin web sitesi, Google işletme kaydı, sosyal medya var mı? (Klinik sitesi ve Veteriner bul için.)

### 3.6 Kliniğin pilot için hazırlayacakları

- [ ] Eski veri dosyası (müşteri, hasta, aşı)
- [ ] Personel listesi: ad, e-posta, rol
- [ ] Çalışma saatleri, randevu süreleri, hekimlerin çalışma günleri
- [ ] Hizmet ve fiyat listesi (muayene, aşı, işlemler)
- [ ] Stok listesi (isteğe bağlı, gölge dönemden sonra da olur)
- [ ] Logo ve fotoğraflar (klinik sitesi için; yoksa hazır fotoğraflar kullanılır)
- [ ] İletişim kişisi ve telefonu (destek, günlük kısa görüşme)
- [ ] Mali müşavir iletişimi (e-fatura)

## 4. Gösterim akışı

Gösterim **yerel bilgisayardan** yapılır (canlı sunucu henüz yok). Önceden bir prova yapılmalı (bölüm 7).

1. **Kayıt ve örnek klinik:** yeni deneme kaydı, "Örnek klinikle başla" (sentetik veri, gerçek kişi yok; EXAMPLE_CLINIC sözleşmesi). Klinik verisiyle başlarken örnek veri tek düğmeyle temizlenir.
2. **Bugün ekranı:** randevulu ve randevusuz geliş, bekleme, acil işareti, hasta uyarı rozetleri, "Sahip onayladı" rozeti.
3. **Muayene:** randevudan muayene aç, metin parçaları, vital, kesinleştirme ve ek not.
4. **Ücret ve ödeme:** ücret, tahsilat, bakiye, gün sonu, kasa sayımı (Kurumsal).
5. **Aşı:** aşı kaydı, aşı sihirbazı (takvimden öneri, hekim onayı), aşı defteri, HBS yardımcısı.
6. **Hatırlatmalar:** aşı/randevu e-postası, onayla/iptal ve takvime ekle bağlantıları, otomatik hatırlatıcılar (kontrol, borç).
7. **Hasta sahibi portalı:** aşı, randevu, bakiye; portaldan randevu talebi.
8. **Klinik web sitesi:** sihirbaz, canlı önizleme, en yakın müsait saatler.
9. **Raporlar:** gün sonu, borç raporu, işletme performansı ve kırılımlar, kayıt defterleri.
10. **Stok ve satış, barkod:** mal kabul, satış, barkod (kamerayla okutma canlıda HTTPS'te çalışır; yerelde elle barkod girişi gösterilir).

Gösterimde **söz verme**: e-fatura tarihi, SMS, mağaza uygulaması, otomatik HBS gönderimi, Veteriner bul yayın tarihi. Bunlar için "yol haritasında, tarih pilotla birlikte netleşecek" de.

## 5. Pilot koşulları (kliniğe anlatılacak)

- **Gölge kullanım (ilk 2 hafta):** gerçek iş eski yöntemle sürer; aynı iş Vetinity'ye paralel girilir. Vetinity kaydı bu dönemde resmî kayıt değildir. Gerçek ödeme eski yöntemle alınır (kılavuz §10).
- **Fark listesi:** her gün sonunda 10 dk, Bugün ekranı ile eski defter karşılaştırılır; farklar yazılır.
- **Çıkış ölçütleri (klinikle anlaşılır):** iki hafta boyunca ciddi hata yok, fark listesi kapanmış, personel günlük akışı yardımsız yapıyor, bakiyeler tutuyor.
- **Eğitim:** ilk gün bir oturum (rol bazlı kılavuz), ilk hafta her gün kısa görüşme.
- **Destek:** bölüm 1 madde 5'teki kanal ve saatler.
- **Veri ve KVKK:** klinik veri sorumlusu, Vetinity veri işleyen. Veri işleme sözleşmesi, kullanım şartları ve gizlilik politikası **taslaktır**, hukukçu onayı bekliyor (HUKUKI-ONAY-LISTESI A1–A6). Öneri: gerçek müşteri verisi girilmeden önce hukukçu onayı alınır; alınmadan başlanacaksa bu kliniğe açıkça söylenir.
- **Bırakma hakkı:** klinik pilotu istediği an bırakabilir; zaten eski yöntemde olduğu için iş durmaz. Veri talep edilirse dışa aktarılır (tam veri dışa aktarma biçimi henüz yok, kılavuz §10).
- **Yedek:** her gün yedek alınır; yedekten geri dönüş provası canlıdan önce yapılır (ADR-014 K2).

## 6. Bizim taraftaki durum (dürüst özet)

| Konu | Durum |
|---|---|
| Ürün kodu (Aşama 1–3 ve çoğu P1) | Hazır, testli; yerelde çalışıyor |
| Canlı sunucu (VPS, SQL Server, alan adları, e-posta, yedek) | **Yok, senin işin.** Kurulunca migration, ayar ve ilk doğrulama 1–2 gün (kılavuz §11.1) |
| Hukuk metinleri | Taslak, hukukçu onayı bekliyor |
| iyzico canlı anahtar | Yenilenmedi; pilot ücretsizse ödeme pilot başında gerekmez |
| e-Fatura | Yok; gölge dönemde eski yerden kesilir, ilk ücretli müşteriden önce gerekli (ADR-036) |
| SMS / WhatsApp otomatik | Yok; e-posta var, WhatsApp elle bağlantı |
| Mağaza uygulaması | Yok; panel ve portal telefon tarayıcısında çalışır |
| Klinik sitesi, Veteriner bul | Kod hazır; yayın alan adı geçişine (ADR-033) bağlı |
| Tanıtım e-postası ("uzun süredir gelmediniz") | Kod hazır, hukuk onayına kadar kapalı (ADR-046) |

## 7. Görüşmeden önce prova

- [ ] Backend ve panel yerelde güncel main'den açılır, örnek klinikle yeni bir deneme kaydı yapılır, bölüm 4'teki akış baştan sona bir kez tıklanır.
- [ ] Bilgisayar şarjda, internet yoksa da yerelde çalıştığı bilinir (SQL Server ve API aynı makinede).
- [ ] Ekran ölçeği ve tarayıcı yakınlaştırması projeksiyon/ekran için ayarlı.
- [ ] Bu paket çıktı ya da telefonda açık.

## 8. Görüşme sonrası

- Notlar bu dosyanın yanına `PILOT-KLINIK-GORUSME-NOTLARI-<tarih>.md` olarak yazılır (kişisel veri yazılmaz).
- Kliniğin yanıtlarına göre: içe aktarma eşlemesi (TIER-021), e-fatura belge türü (ADR-036 AK-3), HBS akışı, rol dağılımı ve başlangıç tarihi güncellenir.
- Kliniğe yazılı özet gönderilir: pilot koşulları, tarih aralığı, hazırlanacaklar listesi.
