# E-Vet SMART — Rakip Analizi

## Ürün

E-Vet SMART (Türkiye pazarı veteriner klinik yönetim yazılımı)

## İncelenen alan

**Tamamlanan pass'ler:**

- Platform shell / navigation ve IA envanteri (**navigation discovery tamamlandı**, 2026-09-23); login sonrası Hasta Kabul landing (alan etiketleri; kısmi — bkz. [Review Tracker](#review-tracker)).
- **Hasta Kartı / Patient Workspace** — planlanan görsel/product review kapsamı **REVIEWED / CLOSED** (2026-09-24 – 2026-09-25); [kapsam](#hasta-kartı--patient-workspace) ve [tracker](#review-tracker).
- **Global Hospitalizasyon modülü** — sol menü **Hospitalizasyon** / **Hospitalizasyonlar** operasyon yüzeyi **REVIEWED / CLOSED** (2026-09-25); [kapsam](#global-hospitalizasyon-modül) ve [tracker](#review-tracker).
- **Global Takvim modülü** — Randevular + Hatırlatma/iletişim batch **REVIEWED / CLOSED** (2026-09-25); [kapsam](#global-takvim-modül) ve [tracker](#review-tracker).
- **Global Doğrudan Satış modülü** — walk-in satış, ödeme, miat/expiry seçimi ve destekleyici Ürün/Stok kanıtları **REVIEWED / CLOSED** (2026-09-27); [kapsam](#global-doğrudan-satış-modül) ve [tracker](#review-tracker).

**Devam eden / henüz sistematik incelenmeyen:** Muayene Odası (global), tam Stok/Ürün modül review, vb. — [Review Tracker](#review-tracker), [Next Review Queue](#next-review-queue).

## Analiz durumu

| Kapsam | Durum |
|---|---|
| **E-Vet SMART genel competitor review** | **Devam ediyor (IN PROGRESS)** — gözlemlenen sürüm **v4.12.0** |
| **Navigation / IA discovery** | Tamamlandı (2026-09-23) |
| **Hasta Kartı / Patient Workspace** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Hospitalizasyon modülü** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Takvim modülü** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Doğrudan Satış modülü** | **REVIEWED / CLOSED** (2026-09-27) |

> **CLOSED:** Planlanan modül görsel/product review kapsamı tamamlandı; kaynak dokümantasyon oluşturuldu. **Anlamına gelmez:** reverse engineering, backend/domain semantics, tam status enum veya tüm E-Vet ürün kapsamının incelenmiş olması.

---

## Kanıt disiplini

Kanıt sınıflandırması:

| Etiket | Anlam |
|---|---|
| **OBSERVED** | Canlı UI'da doğrudan görülen |
| **VIDEO OBSERVED** | E-Vet eğitim/yönlendirme videosundan; aynı iddia canlı UI ile ayrı doğrulanmadı |
| **INFERRED** | Menü/etiketlerden makul ama doğrulanmamış çıkarım |
| **VETINITY IMPLICATION** | Vetinity için değerlendirme adayı (kesin karar değil) |
| **TBD** | İleride doğrulanacak |

Bu belgede **yapılmaz:**

- UI'da görülmeyen backend mimarisi varsayımı
- Veritabanı modeli varsayımı
- API / entegrasyon implementasyonu varsayımı
- Yalnızca menü adından workflow davranışı türetme
- “Resmi” menüde bulunmayı tek başına mevzuat zorunluluğu sayma
- E-Vet davranışını Vetinity requirement olarak yazma

> Aşağıdaki navigation ve alan listeleri **rakip gözlemi**dir; field-level Vetinity product requirement değildir.

---

## Kaynak

| Alan | Değer |
|---|---|
| Kaynak türü | Canlı ürün incelemesi (live product review) |
| Gözlemlenen sürüm | v4.12.0 |
| İnceleme tarihi | 2026-09-23 (navigation); 2026-09-24 – 2026-09-25 (Hasta Kartı — CLOSED); 2026-09-25 (Global Hospitalizasyon — CLOSED); 2026-09-25 (Global Takvim — CLOSED); 2026-09-27 (Global Doğrudan Satış — CLOSED) |

---

## Platform shell / navigation

**OBSERVED:** E-Vet iki ana navigation yüzeyi kullanıyor.

### 1. Üst yatay domain navigation

- Rapor
- Stok
- Finansal
- Ürün
- Müşteri
- Hasta
- Muayene
- Laboratuvar
- Genel

### 2. Sol operasyonel navigation

- Hasta Kabul
- Takvim
- Doğrudan Satış
- Muayene Odası
- Lab İstekleri
- Xray İstekleri
- Pacs İstekleri
- Hospitalizasyon
- HBS (Hayvan Bilgi Sistemi)
- VKY
- e-Fatura / e-SMM
- DataVet
- İlaç Rehberi
- Nekropsi
- Mobil Uygulamalar
- Katalog
- Dokümanlar
- Güncelleme Notları
- WhatsApp Destek Hattı

**OBSERVED:** Navigation envanteri (üst domain + sol operasyonel + belgelenen sol alt menüler) tamamlandı. Alt menüsü listelenmeyen sol öğeler için alt yapı **TBD** (gözlemlenmediyse varsayılmaz).

### Sol navigation — alt menüler

#### Takvim

**OBSERVED — alt menü (IA envanteri):** Randevular · Hatırlatma · Doğum Günü Hatırlatma · Toplu Sms · Toplu Bildirim · Sms Geçmişi · Kara Liste · Şablonlar.

**INFERRED:** Takvim yalnız scheduling değil; reminder ve outbound communication yüzeyleri de içerir (menü co-location).

**TBD:** Tek backend Task/Communication domain **uydurulmaz**. Ekran detayı → [Global Takvim (modül)](#global-takvim-modül) (**REVIEWED / CLOSED**).

#### VKY

**OBSERVED:**

- Güncel Durum Ekranı
- Performans Göstergeleri
- Parametre Tanımları

**TBD:** “VKY” kısaltmasının açılımı ve menü öğelerinin işlevi (yalnızca gözlemlenen isimler kayıtlıdır).

#### e-Fatura / e-SMM

**OBSERVED:**

- Fatura Yönetim Paneli
- Giden e-Faturalar
- Gelen e-Faturalar

Entegrasyon sağlayıcısı, teknik mimari veya mevzuat davranışı bu menü isimlerinden **çıkarılmaz**.

#### DataVet

**OBSERVED:**

- Laboratuvar
  - Pet
  - Büyükbaş
- Semptomlar

Pet / Büyükbaş ayrımı UI navigation'da gözlemlendi; tenant, product edition, ayrı veri modeli veya backend architecture anlamına geldiği **varsayılmaz**.

#### Mobil Uygulamalar

**OBSERVED:**

- SmartVET
- SmartIVET

**TBD:** Uygulama hedef kullanıcısı ve capability kapsamı (isimlerden tahmin edilmez).

---

## Landing / Hasta Kabul

**OBSERVED:** Login sonrası çalışma alanı Hasta Kabul ekranı.

**OBSERVED — arama ve aksiyonlar:**

- Müşteri adı/soyadı ile arama
- Hasta adı ile arama
- Detaylı Arama
- Yeni Müşteri

**OBSERVED — Yeni Müşteri kartı tab yapısı:**

- Ana
- İletişim
- Adres
- Özel
- Notlar

**OBSERVED — Ana tab üzerinde görülen alan etiketleri (örnekler):**

- Adı Soyadı
- Protokol No
- Kart No
- GSM
- Kimlik No
- Doğum Tarihi
- Mobil Kullanıcı Adı
- Mobil Şifre
- İletişim Tipi
- Açıklama

**TBD:** Arama sonuçları, Detaylı Arama kapsamı, kayıt/kaydetme akışı, zorunlu alanlar ve validasyon. Global Hasta Kabul operasyon yüzeyi — **PARTIAL** ([Review Tracker](#review-tracker)).

---

## Hasta Kartı / Patient Workspace

**Review status:** **REVIEWED / CLOSED** (planlanan patient-card product review kapsamı).

**Kaynak:** Canlı ürün incelemesi — Hasta Kartı screenshot seti; **2026-09-24 – 2026-09-25**; sürüm **v4.12.0**.

> E-Vet hasta kartı yapısı **rakip gözlemidir**; Vetinity navigation veya requirement olarak yazılmaz. Aşı Kartı yan paneli **persistent clinical alert / patient summary** olarak sınıflandırılmaz (aşı programı / kart UI gözlemi).

### Sol navigasyon (hasta bağlamı)

**OBSERVED:**

- Anasayfa
- **Randevu & Ziyaret**
  - Randevular
  - Ziyaret Geçmişi
- **Muayene & Aşı**
  - Muayene Geçmişi
  - Aşı Programı
- **Lab & Xray & Pacs**
  - Lab Geçmişi
  - Xray Geçmişi
  - Pacs Geçmişi
- **Hospitalizasyon**
  - Hospitalizasyon Geçmişi
- **Diğer**
  - Hasta Ağırlık Hareketleri
  - Hasta Formları
  - Ekstreler
  - Dosyalarım

**OBSERVED:** Bazı navigasyon öğelerinin yanında **"+"** aksiyonu; hasta bağlamından yeni kayıt oluşturma imkânı (hangi modüllerin **"+"** taşıdığı tam envanter **TBD**).

### Anasayfa

Hasta kartı Anasayfa alt sekmeleri incelendi (Ana, Özel, Bilgi).

#### Anasayfa > Ana

**OBSERVED — alan etiketleri:**

- Adı
- Protokol No
- Kart No
- HBS Kimlik No
- Hasta Türü
- Irk
- Cinsiyet
- Renk
- Doğum Tarihi
- Yaş
- Yaş Grubu
- Kan Grubu
- Ağırlık
- Besin Tipi
- Çiftleştir
- Sahiplendir
- Çip No
- Hasta Grubu

**OBSERVED — üst aksiyonlar:** QR Kodu, Yönlendir, Sms, Sil (Sil akışı → [Hasta silme](#hasta-silme)).

**OBSERVED — sağ Aşı Kartı paneli:**

- Filtreler: Tümü, Yapıldı, Yapılacak
- Tarihli satırlar; satır **düzenle** / **sil** aksiyonları

#### Anasayfa > Özel

**OBSERVED — alan etiketleri:**

- Kalıtsal Hastalık
- Predispozisyonlar (modal → [Predispozisyonlar](#predispozisyonlar))
- Vücut Durumu
- Alerjik Durumu
- Takip Et
- Takip Nedeni
- Durum
- Beni Uyar
- Pasif veya Ölüm Nedeni

**OBSERVED:** Hasta düzeyinde alerji, takip, uyarı metadata alanları mevcut.

**TBD:** “Beni Uyar” bilgisinin diğer workflow'larda **persistent alert** olarak gösterildiği kanıtlanmadı. Bu gözlem **PATTERN-001 / IDEA-004** için yeterli semantic kanıt **değildir** (sidebar/navigation ≠ persistent summary band).

#### Anasayfa > Bilgi

**OBSERVED — alan etiketleri:**

- Anne Adı
- Anne Kimlik No
- Baba Adı
- Baba Kimlik No
- Bilgi
- Açıklama

---

## Randevular

*(Hasta Kartı — patient-context; Patient Card **CLOSED**.)*

Global klinik takvimi ayrı yüzeydir → [Global Takvim (modül)](#global-takvim-modül) · [Patient-context vs global Takvim](#patient-context-vs-global-takvim).

**OBSERVED — hasta kartı Randevular listesi kolonları:**

- İşlemler
- Tarih
- Aşı Paketi
- Görev Tipi
- Açıklama
- Bölüm
- Veteriner
- Durum

**OBSERVED — durum örneği:** `Gelmedi` (tek örnek; tam durum kümesi **TBD**).

**OBSERVED — Yeni Randevu alanları:**

- Görev Tipi
- Bölüm
- Veteriner
- Durum
- Tarih
- Süre (dk)
- Aşı Paketi
- Bilgi
- Açıklama

**OBSERVED — aynı ekranda günlük slot / uygunluk görünümü:** yaklaşık **30 dakikalık** zaman dilimleri; **0/1** benzeri doluluk göstergeleri (örnek UI).

**TBD:** Slotların backend capacity / scheduling algoritması; çift rezervasyon kuralları; online booking ile ilişki.

**VETINITY IMPLICATION:** Hasta bağlamından randevu oluştururken veteriner ve zaman uygunluğunun aynı workflow içinde gösterilmesi değerlendirilebilir (E-Vet UI kopyalanmaz). İlgili backlog notları: [APPT-006](../backlog/feature-backlog.md#appt-006--randevu-nedeni-varsayılan-süre), [APPT-025](../backlog/feature-backlog.md#appt-025--kaynak-bazlı-takvim).

---

## Ziyaret Geçmişi

**OBSERVED:** Hasta kartında **Randevular** ile **Ziyaret Geçmişi** ayrı navigasyon / liste yüzeyleri.

**OBSERVED — Ziyaret Geçmişi kolonları:**

- İşlem Tarihi
- Veteriner
- Oluşturan
- Fatura No
- Açıklama
- Toplam
- Ödeme
- Tedavisi var mı?

**OBSERVED:** Tarih aralığı filtresi.

**TBD:** Ziyaret kaydı oluşturma/kapama akışı; randevu ile otomatik bağlantı; fatura/ödeme hesaplama semantiği.

**VETINITY IMPLICATION:** Appointment ile Visit/Encounter ürün tasarımında ayrı lifecycle ihtiyacı olabilir. **Yazılmaz:** “E-Vet backend'inde Appointment ve Visit ayrı entity'dir” — domain/backend modeli gözlemlenmedi.

İlgili değerlendirme kayıtları: [CHECKIN-005](../backlog/feature-backlog.md#checkin-005--ziyaret-yaşam-döngüsü-ve-durum-geçişleri), [IDEA-020](../research/ideas.md#idea-020--check-in-orchestration).

---

## Yeni Ziyaret

**OBSERVED — üst sekmeler:**

- Satış
- Aşı Listesi
- Muayene
- Notlar

**Context:** Hasta/ziyaret bağlamı **Satış** ≠ sol menü **Doğrudan Satış** (global walk-in). Alan benzerliği var; aynı ekran **değil** → [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül).

**OBSERVED — Satış sekmesi (form / liste öğeleri):**

- İşlem Tarihi
- Fatura No
- Veteriner
- e-Fatura/SMM Notu & Açıklama
- Barkod / QR okutma
- Depo
- Ürün
- Miktar
- Fiyat
- İskonto
- Toplam
- Ürün satırı ekleme
- Operasyon Paketi
- Genel İndirim
- Genel Toplam
- Kaydet
- Kaydet / Öde

**OBSERVED:** Ziyaret bağlamında klinik ve ticari işlemler yakın bir workflow içinde sunuluyor (UI düzeni).

**OBSERVED — Satış > Operasyon Paketi:** “Operasyon Paketleri” modalı (Paket listesi/kolon, **+ Ekle**). Gözlemlenen ortamda liste: “Kayıt bulunamadı”; **+ Ekle** akışı ilerlemedi → **BLOCKED** (sebep bilinmiyor; bug/permission/config/prerequisite **tahmin edilmez**). Operasyon paketi semantiği **TBD**; “paket = product/service bundle” **requirement olarak yazılmaz**.

**OBSERVED — Aşı Listesi / Notlar sekmeleri:** Patient-card review kapsamında yüzeyler incelendi (tracker); üretim/takvim **semantiği TBD** (Aşı Programı generation).

**OBSERVED — Muayene sekmesi > Açıklama & Tedavi Şekli:**

- Tedavi Şablonları
- Tedavi Şekli
- **SmartVette İzin Ver:** Evet / Hayır
- Açıklama
- Diğer Parametreler (collapsible)
- Reçete (collapsible)

**INFERRED:** “SmartVette İzin Ver” SmartVet mobil / hasta-sahibi görünürlük izni ile ilişkili **olabilir**.

**TBD:** Hangi klinik verinin mobil uygulamada görünürlüğünü kontrol ettiği; architecture fact **yazılmaz**.

**TBD:** e-Fatura/SMM alanının entegrasyon davranışı.

**VETINITY IMPLICATION:** Encounter/consultation sırasında oluşan billable item'ların billing/checkout süreciyle ilişkisi Vetinity tasarımında dikkate alınmalı; E-Vet sekme/UI tasarımı kopyalama hedefi değildir. → [CHECKOUT-001](../backlog/feature-backlog.md#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu), [RECORD-001](../backlog/feature-backlog.md#record-001--recordfinans-bağlantısı-görünürlüğü).

---

## Hasta Ağırlık Hareketleri

**OBSERVED:** Hasta kapsamlı ağırlık geçmişi raporu (Diğer > Hasta Ağırlık Hareketleri).

- Tarih ekseninde **line chart**
- Birden fazla ağırlık ölçümü
- PDF, download/export, print

**TBD:** Ölçümlerin kaynak kayıtları (muayene, yatış, manuel giriş vb.).

---

## Predispozisyonlar

**OBSERVED — Predispozisyon modalı (Anasayfa > Özel):**

- Arama (searchable)
- Sayfalama (paginated); gözlemlenen toplam **55** kayıt
- Hastalık kategorileri altında gruplu liste

**OBSERVED — kategori örnekleri (tam liste değil):** Renal ve Üriner Hastalıklar; Dermatolojik Hastalıklar; Kardiyovasküler Hastalıklar; Neoplastik Hastalıklar; Gözle İlgili; Gözle İlgili-Dermatolojik Hastalıklar; Muskuloskeletal Hastalıklar; Nörolojik Hastalıklar; Neoplastik-Hormonal Hastalıklar; Gastrointestinal Hastalıklar.

**OBSERVED — aksiyon:** “Müşteriye Gönder”; WhatsApp ikonu.

**TBD:** Gönderim payload/şablon/kanal semantiği.

---

## Hasta silme

**OBSERVED — akış (Anasayfa > Ana > Sil):**

1. Sil
2. “Silme İşlemi - Onay”
3. “Seçili kaydı silmek istediğinizden emin misiniz?” → Evet / Hayır
4. Evet ile **test kaydı** silindi; başarı: “Seçili kayıt silindi!”
5. Kayıt aktif hasta görünümünden kayboldu

**TBD:** Hard delete / soft delete / arşiv-inactive — UI kanıtından backend delete semantics **çıkarılmaz**.

---

## Global Hospitalizasyon (modül)

**Review status:** **REVIEWED / CLOSED** (planlanan global Hospitalizasyon product review kapsamı).

**OBSERVED — giriş:** Sol operasyonel menü **Hospitalizasyon** → global sayfa başlığı **Hospitalizasyonlar**.

### Liste (Hospitalizasyonlar)

**OBSERVED — üst filtreler:** Tarih Aralığı, Arama Metni, **Ara**, **Temizle**.

**OBSERVED — aksiyon:** **+ Yeni Kayıt**.

**OBSERVED — tablo kolonları:** İşlemler, Müşteri, Hasta, Bölüm, Veteriner, Oda, Giriş Tarihi, Çıkış Tarihi, Günler, Tedavisi var mı?

**OBSERVED — satır gruplama:** Yatış durumuna göre gruplar. Gözlemlenen grup etiketleri: **Yatan**, **Taburcu**.

**OBSERVED:** Sorgu/tarih filtresi sonuç kümesi içinde yalnızca aktif yatan listesi değil; **Yatan** ve **Taburcu** grupları birlikte görüntülenebilir. Kayıt **Yatan** → **Taburcu** düzenlendiğinde aynı kayıt **Yatan** grubundan **Taburcu** grubuna taşındı.

**TBD:** Gözlemlenen **Yatan** / **Taburcu** dışında tam status enum **uydurulmaz**.

### Hospitalizasyon Tanımı (+ Yeni Kayıt / Düzenle)

**OBSERVED — form başlığı:** Hospitalizasyon Tanımı.

**OBSERVED — kırmızı/zorunlu etiketli alanlar:** Müşteri, Hasta, Durum, Giriş Tarihi, Bölüm.

**OBSERVED — diğer alanlar:** Çıkış Tarihi, Oda, Veteriner, Tedavi Şekli, Uygulamalar, Açıklama.

**OBSERVED — aksiyonlar:** Kaydet, Geri Dön.

**OBSERVED — Durum (örnek):** varsayılan/mevcut **Yatan**; düzenlemede **Taburcu** kaydedildi.

**OBSERVED — konum örnekleri (requirement değil):** Bölüm: Klinik, Hasta Odası; Oda: Kafes, Kedi Kafes - 4, Kedi Kafes 7, Yoğun Bakım 4, vb.

**TBD:** Kaynak hiyerarşisi, kapasite, yatak/kafes lifecycle.

**Competitor evidence → Vetinity backlog (kaynak V1 scope; E-Vet requirement değil):** [HOSP-001](../backlog/feature-backlog.md#hosp-001--yatış-yaşam-döngüsü-ve-aktif-yatışlar) (yeni kayıt, durum grupları, giriş/çıkış, düzenleme, global operasyon yüzeyi), [HOSP-002](../backlog/feature-backlog.md#hosp-002--yatış-konum-ataması) (Bölüm, Oda).

### Satır genişletme (inline)

**OBSERVED:** Sol ok ile satır genişletme; **Bilgi | İçerik** tablosu:

- Tedavi Şekli
- Uygulamalar
- Açıklama

**OBSERVED:** Gerçek kayıtlarda çok satırlı klinik metin (ör. ilaç/tedavi talimatı, sıvı/uygulama, serbest not).

**TBD / NOT OBSERVED:** Yapılandırılmış MAR, doz zamanlama, hemşirelik görev panosu, uygulama tamamlama/atlandı logları, vital flowsheet — bu ekran kanıtı **free/multi-line text** davranışıdır; structured inpatient administration **iddia edilmez**.

### İşlemler menüsü

**OBSERVED (dropdown):** İncele, Düzenle, Sil.

**NOT OBSERVED (bu menüde):** Ayrı Taburcu, Treatment, Medication administration aksiyonları — başka yüzeylerde olabilir; **bilinmiyor**.

### İncele (read-only modal)

**OBSERVED:** Owner/müşteri + hasta bağlamı; Durum, Giriş Tarihi, Çıkış Tarihi, Bölüm, Oda, Veteriner; Tedavi Şekli, Uygulamalar, Açıklama (read-only). Genişletilmiş satır içeriği ile **substantially mirror**.

### Düzenle

**OBSERVED:** Hospitalizasyon Tanımı dolu form; alanlar yeni kayıt ile aynı set. Test: Durum **Yatan** → **Taburcu**, **Çıkış Tarihi** boş bırakılarak kaydedildi.

### Taburcu lifecycle (doğrudan test)

**OBSERVED — başlangıç:** Kayıt **Yatan** grubunda; Giriş Tarihi dolu; Çıkış Tarihi boş.

**OBSERVED — aksiyon:** Düzenle → Durum = **Taburcu**, Çıkış Tarihi boş → Kaydet.

**OBSERVED — sonuç:**

1. Kayıt **Yatan** grubundan kayboldu; **Taburcu** grubunda göründü.
2. Global **Hospitalizasyonlar** sayfasında erişilebilir kaldı.
3. **Hasta Kartı > Hospitalizasyon Geçmişi**'nde görünür kaldı.
4. Hasta geçmişi / İncele modal: Durum = Taburcu; Giriş Tarihi = mevcut; Çıkış Tarihi = **"-"** (boş gösterim).
5. Global **Taburcu** satırında Çıkış Tarihi hâlâ boş; **Günler** boş.

**OBSERVED:** Test edilen akışta **Taburcu** durumuna geçiş **Çıkış Tarihi'ni otomatik doldurmadı**. UI düzeyinde Durum ile Çıkış Tarihi bağımsız alanlar; **Taburcu** + boş çıkış tarihi birlikte mümkün.

**TBD:** Günler hesaplama; çıkış tarihi validasyon kuralları. Bu competitor davranışı otomatik Vetinity requirement **değil**.

### Sil (onay)

**OBSERVED:** İşlemler > Sil → “Silme İşlemi - Onay” / “Seçili kaydı silmek istediğinizden emin misiniz?” → Evet / Hayır. Yatış kaydı **silinmedi** (yalnızca onay UI).

**TBD:** Delete persistence semantics.

### Ürün karakterizasyonu (yalnızca gözlem)

**OBSERVED — görece hafif inpatient operasyon yüzeyi:** yatış lifecycle + durum gruplama + bölüm/oda + veteriner + giriş/çıkış tarih alanları + tedavi/uygulama serbest metin + not + hasta geçmişi sürekliliği.

**NOT OBSERVED / TBD (feature absent iddiası değil):** medication administration record, scheduled dose administration, nursing task board, completion/skipped events, inpatient vital flowsheet, occupancy/capacity enforcement, structured bed/cage resource lifecycle.

---

## Global Takvim (modül)

**Review status:** **REVIEWED / CLOSED** (planlanan Global Takvim / randevu / hatırlatma / iletişim batch review kapsamı; edge kanıtları 2026-09-27 ile finalize).

**OBSERVED — giriş:** Sol menü **Takvim**; alt yüzeyler bu pass'te incelendi (nav envanteri yukarıda).

### Patient-context vs global Takvim

| Yüzey | Kapsam | Belge |
|---|---|---|
| **Patient Card** | Randevular listesi, **Yeni Randevu**, hasta-scoped geçmiş, slot/yoğunluk ızgarası (create) | [Randevular](#randevular) |
| **Global Takvim** | Klinik geneli **Randevular** takvimi (Ay/Hafta/Gün), filtreler, durum renklendirme, mevcut randevu **Düzenle** modalı; Hatırlatma/Doğum Günü/Toplu SMS-Bildirim/Geçmiş/Kara Liste/Şablonlar | Bu bölüm |

Aynı ekran **değildir**; ilişkili randevu capability'sinin farklı context yüzeyleri.

---

### Randevular — global calendar

**OBSERVED — sayfa:** Randevular.

**OBSERVED — görünümler:** Ay, Hafta, Gün.

**OBSERVED — navigasyon:** Seçili/güncel tarih kontrolü; önceki/sonraki dönem; haftalık tarih aralığı başlığı.

**OBSERVED — filtreler:** Tarih, Görev Tipi, Bölüm, Veteriner, **Filtrele**.

**OBSERVED — takvim kartları:** Kompakt randevu/görev bilgisi; kart/hover'da (her kartta her alan **garanti değil**) örnekler: başlangıç/bitiş saati, durum, müşteri/hasta, bölüm, veteriner, açıklama/detay.

#### Durum renklendirme (legend)

**OBSERVED legend:**

- Tamamlanmamış Randevular
- Bugünkü Randevular
- Tamamlanan Randevular
- Gelecek Randevular

**OBSERVED:** Temporal/durum renklendirmesi **≠** Görev Tipi tanımlarındaki renk işaretleri — karıştırılmaz.

**TBD:** Renk kalıcılığı / config modeli.

#### Görev Tipi filtresi

**OBSERVED:** Filtrede heterojen **Görev Tipi** değerleri (renk kodlu; tam enum **değil**). Örnekler (klinik-özel girişler dahil): Aşılama; Check Up / Check Up 1 / Check Up 2; Kontrol Muayenesi; Biyokimya; Hemogram; Vcheck Test; Doppler Ultrason Muayenesi; Kemoterapi; Kısırlaştırma; Operasyon; Dikiş Alınması; Diş Temizliği; Reçete; Tedavi; Taburcu; Traş; Otel; Randevu; Randevu Talep; Hatırlatma; Borç Hatırlatma; Çek-Senet Hatırlatması; Ödeme Sözü; Hasta Sahibi Doğum Günü; Uyarı; tohumlama ile ilgili girişler; diğer klinik-özel görünümler.

**INFERRED:** Görev Tipi yalnız muayene randevusu değil; operasyonel/hatırlatma kategorilerini de kapsayan geniş yüzey.

**TBD:** Unified Task backend, config mimarisi — UI'dan **çıkarılmaz**.

#### Bölüm filtresi

**OBSERVED örnekler (requirement değil):** Dış Klinik, Hasta Odası, Klinik, Muayene Odası - 2, Traş.

---

### Mevcut randevu — Düzenle modal

**OBSERVED:** Takvim kartına tıklanınca doğrudan **Düzenle** modalı.

**OBSERVED alanlar:** Durum, Görev Tipi, Tarih, Süre (dk), Bölüm, Veteriner, Müşteri, Hasta, Aşı Paketi, Bilgi, Açıklama. **Kaydet**.

**OBSERVED örnek kayıt:** Durum = Tamamlandı; Süre = 30 dk.

#### Düzenle modal — alt aksiyonlar (footer)

**OBSERVED — doğrulanmış:**

| Aksiyon | Davranış |
|---|---|
| **+** | **Yeni Randevu** modalını açar (global calendar-context **create**). |
| **Yeşil gönder / paper-plane** | SMS gönderimi; başarıda “SMS Gönderimi Tamamlandı” (Toplam / Başarılı / Başarısız); teslimat ayrıntıları için **SMS Geçmişi** yönlendirmesi — aynı geri bildirim/desen [Doğum Günü Hatırlatma](#doğum-günü-hatırlatma) ve kayıt yüzeyi [Sms Geçmişi](#sms-geçmişi) ile uyumlu (**duplicate SMS spec yok**). |
| **Mavi kişi** | İlgili **Müşteri Kartı**'na contextual navigation/handoff (Müşteri Kartı benchmark bu pass'te genişletilmedi). |

**OBSERVED — + → Yeni Randevu alanları:** Durum, Görev Tipi, Tarih, Süre (dk), Bölüm, Veteriner, Müşteri, Hasta, Aşı Paketi, Bilgi, Açıklama, **Kaydet**.

**Product distinction:** Patient Card > [Yeni Randevu](#randevular) ile aynı temel appointment capability'sine **yakın** alan seti; **aynı ekran değil** — global create modalında patient-context **availability / slot-density grid** **gözlemlenmedi**. Related capability, different context surface.

**OBSERVED — çöp ikonu:** Görünür.

**NOT OBSERVED / TBD:** Çöp ikonu tıklanınca silme onayı, persistence veya tam delete workflow — ikon görselinden **çıkarılmaz**.

**NOT OBSERVED / TBD:** Drag/drop ile randevu taşıma (gerçek veri değiştirmemek için **test edilmedi**); var/yok **iddia edilmez**.

---

### Hatırlatma

**OBSERVED filtreler:** Tarih Aralığı, Arama Metni, Ara, Temizle.

**OBSERVED üst alan:** SMS bakiye; şablon seçimi; şablon önizleme (göz ikonu).

**OBSERVED listeler:** Sms Gönderim Listesi, Email Gönderim Listesi.

**OBSERVED aksiyonlar (gözlemlenen satırlarda):** Seçili kişiye SMS / OTP SMS (uygun olduğunda), Email Gönder, WhatsApp (Hatırlatma satırı).

**OBSERVED alan örnekleri:** Gönderildi, Tarih, Müşteri, GSM, Email, Hasta, Aşı Paketi, İncele.

**OBSERVED:** Satırlar hatırlatma/görev bağlamına göre gruplanabilir (ör. **Aşılama** grubu).

#### WhatsApp Web handoff (Hatırlatma)

**OBSERVED (test):** Hatırlatma satırındaki yeşil WhatsApp aksiyonu → **WhatsApp Web** açılır; ilgili sohbet/composer; mesaj alanı **önceden doldurulmuş**.

**OBSERVED prefilled örnek metin:** “Randevunuzu hatırlatmak istedik. İyi Günler dileriz.”

**Characterization:** Reminder surface → WhatsApp Web handoff/deep-link → prefilled reminder text → nihai gönderim **WhatsApp tarafında kullanıcı** (E-Vet içi otomatik “sent” kanıtı **yok**).

**NOT inferred / NOT OBSERVED:** Official WhatsApp Business API; server-side WhatsApp send; delivery webhook; WhatsApp delivery tracking; message history sync; provider/vendor; E-Vet içinde WhatsApp gönderim logu.

**TBD / NOT OBSERVED (CLOSED'ı engellemez):** Prefilled metnin şablon/config kaynağı; telefon normalizasyon/routing; WhatsApp'ta gönderilen mesajın E-Vet communication history'ye yazılıp yazılmaması; delivery/read sync; API vs basit web deep-link implementasyonu.

---

### Doğum Günü Hatırlatma

**OBSERVED — sayfa:** Doğum Günü Listesi.

**OBSERVED filtreler:** Tarih Aralığı, Arama Metni.

**OBSERVED sekmeler:** Müşteri Listesi, Hasta Listesi.

**OBSERVED müşteri listesi:** checkbox, Müşteri, GSM, Email, Doğum Tarihi.

**OBSERVED üst:** SMS bakiye, Şablon, önizleme.

**OBSERVED aksiyonlar:** Sms Gönder, Bildirim Gönder.

**OBSERVED — SMS doğrulama:** Şablon seçilmeden → “Lütfen şablon seçiniz.”

**OBSERVED — başarılı SMS testi:** “SMS Gönderimi Tamamlandı” — toplam, Başarılı, Başarısız; detay için **SMS Geçmişi** yönlendirmesi.

**OBSERVED workflow:** Doğum Günü Listesi → alıcı seçimi → şablon → SMS → sonuç → SMS Geçmişi.

**TBD — Bildirim Gönder:** “Durum” modalı / hesap satırı gözlemlendi; alıcı uygunluğu, hedef uygulama, kanal, push **kanıtlanmadı**.

---

### Toplu Sms

**OBSERVED hedef sekmeleri:** Müşteri Listesi · Bakiyesi Olan Müşteri Listesi · Müşteri Grubu · Manuel Liste.

**Müşteri Listesi:** seçim, Müşteri, GSM, Email, arama, sayfalama.

**Bakiyesi Olan Müşteri Listesi:** Müşteri, GSM, Bakiye; Tümüne Gönder / Seçili OTP SMS / Seçili SMS (parantez içi adetler). **TBD:** “Bakiyesi Olan” iş kuralı.

**Müşteri Grubu:** seçilebilir gruplar — Adı, Kod (örnekler requirement değil).

**Manuel Liste:** GSM listesi, Sil, + Yeni; “Kayıt bulunamadı”. **TBD:** import/toplu yapıştırma.

**OBSERVED composer:** Ticari Evet/Hayır; Şablon; Sms Mesajı + sayaç. **TBD:** Ticari = KVKK/ETK/IYS semantiği; OTP iş use-case.

---

### Toplu Bildirim

**OBSERVED:** Basit composer — zorunlu **Başlık**, **Mesaj**; **Gönder**.

**TBD:** Alıcı kümesi, kanal, mobil uygulama bağımlılığı, push sağlayıcı — push **kesinleştirilmez**.

---

### Kara Liste

**OBSERVED:** arama, checkbox, GSM, Hesap Adı, **Kaldır**; ortamda “Kayıt bulunamadı”.

**NOT OBSERVED / TBD:** Kara listeye ekleme akışı.

---

### Şablonlar

**OBSERVED — liste (~35 kayıt / sayfalama):** İşlemler, Adı, Kullanım Yeri, Ticari, Durum; **+ Yeni Kayıt**. Örnek Durum: Aktif; Ticari: Hayır.

**OBSERVED Kullanım Yeri (çoklu yüzey):** Hatırlatma Listesi, Doğum Günü Listesi, Toplu Sms, Müşteri Kartı, Hasta Kartı, vb.

**OBSERVED — Şablon Tanımı (+ Yeni):** Adı, Kullanım Yeri, Durum, Ticari; kanallar **SMS**, **Email**; SMS editör; dinamik token/placeholder.

**OBSERVED token etiketleri (tam liste değil):** Aşı, Çip No, Hasta, Hasta Doğum Tarihi, Hasta Kart No, İlgili Kişi, Klinik Koordinatları; render örnekleri `{Vaccine}`, `{Chip Nr}`, `{Patient}`, `{Patient BirthDate}` vb.

**INFERRED:** Şablonlar statik metin değil; hasta/klinik bağlamlı placeholder destekler.

**TBD:** Template storage implementasyonu.

---

### Sms Geçmişi

**OBSERVED — sayfa:** Sms Geçmişi Listesi.

**OBSERVED filtreler:** Tarih Aralığı, Gönderildi Durumu, Arama Metni, Ara, Temizle.

**OBSERVED üst:** SMS bakiye; OTP Sms Gönder; Sms Gönder.

**OBSERVED kolonlar:** checkbox, İşlem Tarihi, Müşteri, GSM, Mesaj, Gönderildi, Durum.

**OBSERVED:** Başarılı — Gönderildi/Gönderildi; başarısız/gönderilmedi — Gönderilmedi; Durum alanında **sayısal kod/değer** (provider error/message ID **iddia edilmez**, anlam **TBD**).

**OBSERVED:** Geçmişte gönderilen/denenen mesaj içeriği görüntülenir.

---

### Stale / geçmiş tarihli SMS gözlemi

**OBSERVED (tek test):** 25.09.2026'da gönderilen SMS mesaj gövdesinde 22.09.2026 randevu/hatırlatma tarihi; gönderim başarılı; SMS Geçmişi'nde sent; gönderim öncesi stale/geçmiş tarih **uyarısı veya blok yok**.

**VETINITY IMPLICATION:** Stale-reminder uyarı/onay değerlendirilebilir — otomatik requirement, güvenlik bug'ı veya tüm SMS yüzeyleri için genelleme **değil**.

---

### Ürün sentezi — Takvim

**OBSERVED — en az üç görünür concern (co-location):**

1. **Scheduling** — global takvim, Ay/Hafta/Gün, filtreler, düzenleme; randevu bağlamından hızlı aksiyonlar: **+ → Yeni Randevu**, **SMS gönder**, **Müşteri Kartı** handoff
2. **Reminder worklists** — hatırlatma listesi, doğum günü, hasta/müşteri bağlamı; Hatırlatma → **WhatsApp Web** prefilled-message handoff
3. **Outbound communication** — SMS, Email, toplu bildirim, OTP SMS aksiyonu, şablonlar, placeholder, SMS geçmişi, kara liste, alıcı segmentasyonu

**TBD:** Ortak backend mimarisi — **UNKNOWN** (UI co-location ≠ domain birliği; unified task architecture **çıkarılmaz**).

---

## Global Doğrudan Satış (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-27 — planlanan global direct sale / checkout / payment / destekleyici miat-stok kanıtı kapsamı).

**OBSERVED — giriş:** Sol operasyonel menü **Doğrudan Satış**.

**OBSERVED — bağlam:** Ekran başlığı/ müşteri bağlamı **Doğrudan Satış Müşterisi**; kayıtlı müşteri zorunluluğu olmadan walk-in / gelgeç kullanım yüzeyi.

**Related capability, different context surface:** [Yeni Ziyaret > Satış](#yeni-ziyaret) ile benzer satır/fiyat/depo/barkod alanları paylaşılabilir; ziyaret vs global walk-in **ayrı yüzeyler**.

---

### Ana satış ekranı

**OBSERVED — üst alanlar:**

- İşlem Tarihi
- Fatura No
- Veteriner
- Açılır bölüm: **e-Fatura|SMM Notu & Açıklama** → açıldığında **e-Fatura|SMM Notu**, **Açıklama**

**VIDEO OBSERVED:** Gelgeç / kimliksiz müşteri senaryosunda e-Fatura **düzenlenemediği**, yalnızca e-Fatura/SMM **notu** ve açıklama girilebildiği anlatıldı.

**TBD / NOT VERIFIED (live UI):** Walk-in e-Fatura kısıtının tam hukuki/sistem kuralı; kayıtlı müşteri ile farklı save/e-Fatura davranışı (video: kayıtlı satışta bakiyeye yazma vs gelgeçte kırmızı **Kaydet / Öde** — **VIDEO OBSERVED**; mavi/kırmızı buton evrensel kural **uydurulmaz**).

---

### Barkod, depo, ürün arama

**OBSERVED:**

- Barkod alanı + QR/barkod tarama yüzeyi
- **Depo** seçimi (ör. Ana Depo, Depo - Kerimler)

**VIDEO OBSERVED:** Barkod/QR yüzeyinin barkodlu ürün satışı için kullanıldığı anlatıldı.

**NOT OBSERVED / TBD:** Barkod backend/protokol; tarama sonrası satır ekleme davranışı (canlı test yok).

**OBSERVED — ürün arama:** Boş durumda “Lütfen arama yapınız”; yazınca dropdown; sonuçlarda ürün adı yanında depo etiketi (ör. `| Ana Depo`).

**OBSERVED ANOMALY / TBD:** **Depo - Kerimler** seçiliyken arama sonuçlarında yine `| Ana Depo` etiketi görüldü — yanlış filtre mi, stok kaynağı etiketi mi, başka UI semantiği mi **doğrulanmadı** (**BUG iddiası yok**).

---

### Satış satırları

**OBSERVED kolonlar:** Ürün · Miktar · Fiyat · İskonto · Toplam.

**OBSERVED:** Ürün yanında küçük action/document ikonu (semantik **TBD / NOT CLASSIFIED**). Miktar yanında kırmızı sayısal değer; hover → **Stok Miktarı** + mevcut miktar (**stok quantity visibility OBSERVED**).

**OBSERVED — satır İşlemler:** Bilgiyi göster · Sil.

**OBSERVED — Bilgiyi göster:** Serbest metin **Bilgi** alanı; sağda satır **KDV oranı** (ör. %10, %20); kullanıcı Bilgi’ye metin yazabiliyor. **Bilgi** = line note/information surface (**lot/batch alanı değil**).

---

### İndirim, stopaj, toplamlar

**OBSERVED:** Toplam · Genel İndirim · Genel Toplam.

**OBSERVED — ek + menüsü:** İndirimi kaldır · Stopaj ekle.

**INFERRED:** Line + genel indirim + stopaj aksiyonu olan direct-sale checkout finans yüzeyi.

**TBD:** Stopaj hesaplama/formül; Türkiye vergi semantiği **çıkarılmaz**.

---

### Kaydet / Öde ve ödeme ekranı

**OBSERVED:** Kırmızı **Kaydet / Öde** aksiyonu.

**VIDEO OBSERVED:** Gelgeç **Doğrudan Satış Müşterisi** senaryosunda **Kaydet / Öde** akışı; kayıtlı müşteride farklı save/bakiye davranışı anlatımı (**live UI doğrulanmadı**).

**OBSERVED:** **Kaydet / Öde** → **Doğrudan Satış Fatura Ödemesi** ekranı.

**OBSERVED — özet:** Ziyaret Toplamı · Ödeme Toplamı.

**OBSERVED — alanlar:** İşlem No · Açıklama.

**OBSERVED — Ödeme Detayları (satır bazlı, çoklu satır):** Ödeme Tipi · İşlem Tarihi · Makbuz No · Tutar; satıra bağlı örnekler: Ana Kasa · Belge No · Kart Sahibi · Açıklama.

**OBSERVED ödeme tipleri:** Nakit Ödeme · Kredi Kartı Ödeme · Çek Ödeme · Senet Ödeme · Banka Transferi Ödeme.

**OBSERVED (canlı test):** 100 TL toplam → 50 TL Nakit + 50 TL Kredi Kartı — **split tender / mixed payment**.

**NOT inferred:** Banka/POS terminal entegrasyonu · settlement.

---

### Doğrudan Satış Geçmişi ve İncele

**OBSERVED — Doğrudan Satış Geçmişi:** Tarih aralığı filtresi; tablo kolonları ör. Veteriner · Oluşturan · Fatura No · Ödeme · Toplam.

**OBSERVED — İşlemler menüsü (isimler):** İncele · Düzenle · Ödeme · Sms Gönder · Kopyala · Fatura (3 lü) · Fatura · Bilgi Fişi · Hesap Ekstresi · Hesap Ekstresi (Detaylı) · Sil.

**TBD / NOT VERIFIED:** Kopyala · fatura çıktıları · Bilgi Fişi · SMS — uçtan uca davranış.

**OBSERVED — İncele modal satır kolonları:** Ürün · Depo · Miktar · Fiyat · KDV Oranı · İskonto · Toplam Fiyat · **Miat** · **Seri No** · Açıklama; sağda sale totals / indirim / stopaj özeti.

**OBSERVED:** Tamamlanmış direct sale read surface — ürün + depo + finans + expiry metadata birlikte.

---

### Ödeme bağımlılığı ve silme (canlı test)

**OBSERVED (100 TL walk-in / Doğrudan Satış Müşterisi):**

1. Satış + bağlı **100 TL payment** kaydı oluşturuldu.
2. **Doğrudan Satış Geçmişi > Sil** → “Bu kayıt silinemez, ilişkisi vardır”.
3. **Ödeme Geçmişi** — İşlem Tipi: Doğrudan Satış Fatura; İşlemler: Düzenle · Ödeme Fişi · Sil.
4. İlişkili payment kaydı kaldırıldı/silindi → **Ödeme Geçmişi’nde artık görünmüyor** (doğrulandı).
5. Aynı Direct Sale kaydında **Sil tekrar denendi** → **başarıyla silindi**; kayıt ilgili geçmişte **artık yok** (doğrulandı).

**OBSERVED — UI/product lifecycle:** Sale → payment dependency (Sil engeli) → payment removal → sale deletion.

**OBSERVED:** İlişkili payment varken Direct Sale silme **engelleniyor**; payment **ayrı financial record**; payment kaldırıldıktan sonra **aynı satış silinebiliyor**.

**TBD / NOT VERIFIED:** Direct Sale silindikten sonra **stok miktarının otomatik geri gelmesi** (test edilmedi — “stok kesin geri geldi” **yazılmaz**); hard vs soft delete; audit/event history; e-Fatura/e-SMM bağlı kayıtlarda delete guard; diğer finansal ilişki türlerinde guard kuralları.

---

### Direct sale — miat / expiry seçimi

**OBSERVED:** Miat kontrollü ürün satırında expiry/date **dropdown**; aynı ürün için örn. `12 Ocak 2029 - Ana Depo` · `28 Şubat 2029 - Ana Depo`; erken tarih listede önce ve seçili göründü.

**NOT VERIFIED / TBD:** FEFO/FIFO otomatik seçim · enforce · hangi bucket’tan düşüldüğü · sıralama = policy mi yalnızca UI sort mu.

---

### Lot / batch / Seri No

**NOT OBSERVED (bu pass):** Alış Faturası · Stok Giriş · Doğrudan Satış compose yüzeylerinde açık **lot/batch numarası** giriş alanı.

**OBSERVED:** İncele’de **Seri No** kolonu.

**TBD:** Seri No giriş kaynağı · ürün kapsamı · barkod ilişkisi · lot/batch ile aynı kavram mı · unique serial tracking — **Seri No = Lot/Batch çıkarımı YAPILMAZ**.

---

### Destekleyici inceleme — Ürün Tanımı (PARTIAL, modül CLOSED değil)

**Amaç:** Direct sale miat davranışını anlamak; **Global Ürün modülü review kapatılmadı**.

**OBSERVED — Ürün Tanımı (seçilmiş alanlar):** İçerik Tipi · Ürün Tipi · Ürün Grubu · Ürün Alt Grubu · Adı · Durum · Birim · Çarpan · Barkod-1 · Barkod-2 · Hasvet Kodu · Reçete Ürünü mü? · Alış/Satış fiyatları · Alış/Satış KDV · KDV dahil bayrakları · **Stok Durum Kontrolü** · **Miat Kontrolü** (Evet/Hayır) · Minimum/Maksimum/Alarm Miktarı · Aşı Paketi Var Mı · Fiyat Aralık Listesi.

**OBSERVED:** **Miat Kontrolü** ürün bazında — expiry zorunluluğu **conditional** (her ürün için zorunlu değil).

---

### Destekleyici inceleme — Stok Giriş / Alış Faturası / Depo Stok Durumu (PARTIAL)

**Global Stok modülü CLOSED değil** — yalnızca direct sale expiry kanıtı için:

**OBSERVED — Stok Giriş:** İşlem Tarihi · İşlem No · Açıklama · Barkod · Depo · Ürün · Faktör|Çarpan & Miktar · Birim · + Yeni. Miat kontrollü ürün → satır **Miat** zorunlu (“Bu alan zorunludur!”); kontrolsüz üründe **Miat** alanı yok.

**OBSERVED — Alış Faturası (özet):** İşlem Tarihi · Satıcı Firma · Fatura No · Stok Hareketini Engelle · Teslim/Vade/Depo Çıkış/Açıklama · Barkod · Depo · KDV Dahil · ürün satırları · Faktör|Çarpan & Miktar · Fiyat · KDV · İskonto · Toplam; miat kontrollü üründe satır **Miat** zorunlu.

**OBSERVED — Stok > Depo Stok Durumu kolonları:** İçerik Tipi · Ürün Tipi · Barkod-1 · Barkod-2 · Ürün · Birim · **Miat** · **Miktar**.

**OBSERVED:** Aynı ürün + aynı depoda farklı **Miat** değerleriyle **ayrı satırlar** (ör. 12.01.2029 ve 28.02.2029) — UI-level **expiry-separated quantity rows** (**lot/batch entity iddiası yok**).

**NOT REVIEWED (Stok menüsü — systematic değil):** İade/Sipariş faturası · Stok Çıkış · Sayım · Sıfırlama · Transfer · satıcı ödemeleri · Depolar tanımı vb.

---

### Ürün sentezi — Doğrudan Satış

**OBSERVED — bir arada:**

1. Walk-in **Doğrudan Satış Müşterisi** checkout (depo + arama + satır + KDV/indirim/stopaj)
2. **Kaydet / Öde** → dedicated payment screen · **split tender**
3. Stok miktarı görünürlüğü · **miat bucket** seçimi satışta
4. Geçmiş · çoklu belge/ödeme aksiyonları · **İncele** read model
5. Sale → payment dependency → payment removal → sale deletion (canlı test)

**TBD:** Ortak checkout backend ziyaret satışı ile **UNKNOWN** — UI alan benzerliği ≠ tek domain aggregate.

---

### VETINITY IMPLICATION (Doğrudan Satış pass)

*(Competitor architecture claim değil; değerlendirme adayları.)*

- Direct Sale ile clinical visit sale **ortak checkout/payment primitive’leri** paylaşabilir → [CHECKOUT-001](../backlog/feature-backlog.md#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu).
- Satış sırasında **stok miktarı** ve **expiry bucket** seçimi görünür olmalı (miat ürün bazında opsiyonel).
- Aynı SKU’nun farklı expiry envanter satırları anlaşılır sunulmalı (**FEFO enforce iddiası yok**).
- Payment relation varken destructive sale action **finansal bütünlük** korumalı.
- **Split payment** first-class ödeme capability adayı.

---

## Hospitalizasyon geçmişi

*(Hasta kartı — patient-scoped; Patient Card review kapsamında CLOSED.)*

**OBSERVED — hasta bazında Hospitalizasyon Geçmişi kolonları:**

- İşlemler
- Bölüm
- Oda
- Giriş Tarihi
- Çıkış Tarihi
- Günler
- Tedavisi var mı?

**OBSERVED — örnek değerler (UI):** Bölüm: Hasta Odası; Oda: Kafes (tek örnek; oda/kafes veri modeli **uydurulmaz**).

**OBSERVED — global ↔ hasta sürekliliği:** Global Hospitalizasyon kaydı **Taburcu** yapıldıktan sonra **Hospitalizasyon Geçmişi**'nde görünür kaldı ([Taburcu lifecycle testi](#taburcu-lifecycle-doğrudan-test)). Patient-scoped yatış geçmişi read surface kanıtı — duplicate storage **varsayılmaz**.

**Competitor evidence → Vetinity backlog:** [HOSP-003](../backlog/feature-backlog.md#hosp-003--hasta-yatış-geçmişi-ve-klinik-bağlam) (global → patient history continuity; tedavi/uygulama/bağlam görünürlüğü). [TIMELINE-001](../backlog/feature-backlog.md#timeline-001--hasta-timeline) ile read-model hizalması değerlendirmesi (bu belgede karar yok).

**Vetinity requirement kaynağı (PRIMARY):** [v1-release-scope.md](../roadmap/v1-release-scope.md), [ux/navigation.md](../ux/navigation.md), [ux/design-decisions.md](../ux/design-decisions.md).

> E-Vet kolonları/listeleri Vetinity requirement değildir; **competitor evidence**dır.

---

## Ekstreler / finansal hareketler

**OBSERVED — hasta kartı Diğer > Ekstreler:**

- Hesap Ekstresi
- Hesap Ekstresi (Detaylı)

**OBSERVED — rapor / liste adları (hasta-finans bağlamında):**

- Müşteri ve Hasta Hareketleri
- Müşteri ve Hasta Hareketleri (Detaylı)

**OBSERVED — filtreler:**

- Tarih Aralığı
- Devreden Bakiye

**OBSERVED:** PDF, export ve print aksiyonları.

**TBD:** Ekstre satır semantiği; müşteri vs hasta bakiye ayrımı; muhasebe entity modeli.

**VETINITY IMPLICATION:** Patient-context financial visibility ile owner/client financial context ilişkisi ürün tasarımında dikkate alınmalı; E-Vet accounting/domain modeli **tahmin edilmez**. → [REPORT-007](../backlog/feature-backlog.md#report-007--excelpdf-dışa-aktarma-politikasi), [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability) (ziyaret–fatura izlenebilirliği ile birlikte değerlendirme).

---

## Dosyalarım (attachments)

**OBSERVED — hasta bazında generic dosya yükleme:**

- İşlem Tarihi
- Bilgi
- Dosya
- Dosya Seç
- Satır ekleme
- Kaydet
- Liste arama

**VETINITY IMPLICATION:** Patient-scoped generic attachment/document capability değerlendirilmeli. **Aynı capability sayılmamalı:** generic attachment vs lab result vs Xray vs PACS vs clinical document. → [RECORD-003](../backlog/feature-backlog.md#record-003--record-attachment).

---

## Hasta Formları

**Review status:** **REVIEWED / CLOSED** (patient-card kapsamı).

**OBSERVED — menü girişleri:**

1. Muayene Formu
2. Operasyon Formu
3. Tedavi Formu
4. Anestezi Formu
5. Özel Form
6. Özel Form-2 … Özel Form-6

Hukuki metinler Vetinity requirement **olarak kopyalanmaz**; kişisel veri örnekleri yazılmaz.

### Muayene Formu

**OBSERVED:** Yapılandırılmış, yazdırılabilir muayene formu — sistem/organ değerlendirme alanları; normal/anormal benzeri seçimler; Vücut Isısı, Ağırlık, Solunum, Nabız; serbest not; anterior/posterior vücut diyagramları; Veteriner Hekim alanı.

**OBSERVED — export format seçici:** Html, Pdf, Xls, Xlsx, Csv, Image; download/export, print.

### Operasyon Formu

**OBSERVED:** “OPERASYON İZİN FORMU” — owner kimlik/iletişim bağlamı; hasta bağlamı; operasyon/müdahale onam metni; risk/komplikasyon kabulleri; owner ad/imza alanı; export/download/print.

### Tedavi Formu

**OBSERVED:** “Tedavi İzin ve Tahmini Ücret Talep Formu” — owner/hasta bağlamı; tedavi/prognosis kabulleri; tahmini/süregelen maliyet kabul dili; imza alanı; export/download/print.

### Anestezi Formu

**OBSERVED:** “ANESTEZİ İZİN FORMU” — owner/hasta bağlamı; anestezi onamı; risk/alternatif kabulleri; imza alanı; export/download/print.

### Özel Form

**OBSERVED:** “HASTA MUAYENE FORMU” tarzı özel şablon — temel owner/hasta bilgileri; tarih, tür, cinsiyet, ırk, aşı/beslenme bağlamı vb. **Custom form/template** capability gözlemi (ayrı product capability listesi **çıkarılmaz**).

### Özel Form-2 / Özel Form-3

**OBSERVED:** Basit/generic özel rapor şablonları — owner/hasta bilgisi; sınırlı ek içerik.

### Özel Form-4

**OBSERVED:** Aynı render çıktısında **karışık/tutarsız** owner-hasta/şablon içeriği — mevcut hasta bağlamıyla uyumlu üst bilgiler **ve** farklı owner/hasta değerleri birlikte; içerikte “Tedavi İzin ve Tahmini Ücret Talep Formu” benzeri tedavi-onam metni.

**TBD / UNKNOWN:** Kök neden (bug, yanlış binding, yanlış şablon) — **kesin sınıflandırılmaz**.

**VETINITY IMPLICATION (genel):** Özel belge/şablon sistemlerinde güvenilir data binding, şablon doğrulama ve önizleme önemli olabilir — competitor architecture fact **değil**.

### Özel Form-5 / Özel Form-6

**OBSERVED:** Çok minimal generic “Özel Form” çıktıları — temel owner/hasta metadata; anlamlı ek form gövdesi **gözlemlenmedi**. Görsel olarak birbirine **yakın** çıktı; backend duplicate template **kesinleştirilmez**.

**TBD (Türkiye / hukuk):** Hukuki geçerlilik; zorunlu alanlar; elektronik imza; onam saklama — **requirement değil**.

**VETINITY IMPLICATION:** Structured/generated patient forms ve consent/document workflow değerlendirilmeli; dijital portal veya e-imza **gözlemlenmiş gibi varsayılmaz**. → [PORTAL-005](../backlog/feature-backlog.md#portal-005--dijital-onam-ve-imza), [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-014](../research/patterns.md#pattern-014--document-to-signature-continuity).

---

## Rapor navigation

**OBSERVED — ana gruplar:**

- Genel
- Randevu
- Resmi
- Depo
- Finansal
- Rapor Özellikleri

**OBSERVED — Rapor > Genel:**

- Müşteri Listesi
- Hasta Listesi
- İstatistik
- Hasta Veri İstatistiği
- Sahiplenme Listesi
- Çiftleştirilecek Hastalar
- Takipteki Hastalar
- Hospitalizasyon Listesi
- Ziyaret Geçmişi
- Ziyarete Gelmeyen Müşteriler
- Z. Gelmeyen Müşteri Detaylı
- Test Sonuç Karşılaştır
- Anket Sonuçları
- Bugün Uygulanacak Tedaviler
- En Yoğun Dönemler
- Laboratuvar Test Sayısı Raporu

**OBSERVED — Rapor > Randevu:**

- Yapılacak İşler
- Yapılacak Aşı Çizelgesi
- Yapılan Aşı Çizelgesi

**OBSERVED — Rapor > Resmi:**

- Muayene Kayıt Defteri
- Aşı Kayıt Defteri
- İlaç Kayıt Defteri
- Reçete Kayıt Defteri
- Narkotik Kayıt Defteri
- Aşı Bilgi

**OBSERVED — Rapor > Depo:**

- Depo Stok Durumu
- Ürün Alışı
- MS Altına Düşen Ürünler
- SKT Geçen Ürünler
- SKT Yaklaşan Ürünler
- Ürün Hareketleri
- Ürün Listesi
- Aktif Stok
- Gelecek Aşılar
- Hareket Olmayan Ürünler
- Stok Analiz
- ABC Analizi (Ürün Bazlı) – Pareto Prensibi
- ABC Analizi (Ürün Tipi Bazlı) – Pareto Prensibi

**OBSERVED — Rapor > Finansal alt grupları:**

- Bakiye
- Kasa
- Satış
- Gelir - Gider

**OBSERVED — Finansal > Bakiye:**

- Bakiyesi Olan Müşteriler
- Bakiye İndirimi
- Bakiyesi Olan Firmalar
- Yaşlandırma

**OBSERVED — Finansal > Kasa:**

- Günlük Kasa
- Tarihler Arası Kasa
- Tarihler Arası Kasa Son 3 Gün
- Kasa Ve Banka Hareketleri

**OBSERVED — Finansal > Satış:**

- Ürün Satışı
- Ürün Satışı (Detaylı)
- Ürün Tipi Bazında Satış
- Kullanıcı Bazında Satış (Veteriner)
- Ürün Tipi Bazında Aylık Satış
- Aylık Satış

**OBSERVED — Finansal > Gelir - Gider:**

- Ürün Tipi Bazında Kâr
- Ortalama Maliyet
- Yıllık Tahsilat
- Aylık Tahsilat
- Gider
- Yıllık Gelir - Gider
- Günlük İşlem Dökümü
- Gider Türü Dağılım Raporu

**TBD:** Rapor ekranlarının filtreleri, kolonları, export davranışı, hesaplama semantiği ve drill-down davranışı (bu pass'te yalnızca navigation isimleri gözlemlendi).

---

## Stok navigation (üst domain)

**OBSERVED:**

- Alış Faturası
- İade Faturası
- Sipariş Faturası
- Stok Giriş
- Stok Çıkış
- Sayım
- Stok Sıfırlama
- Stok Transferi
- Depo Stok Durumu
- Satıcı Firmaya Ödeme
- Satıcı Firmalar
- Depolar

---

## Finansal navigation (üst domain)

**OBSERVED:**

- Banka Giriş/Çıkış
- Kasa Giriş/Çıkış
- Bankalar
- Banka Hesapları
- Kasalar
- Klinik Gider Grupları
- Klinik Gider Tipleri

---

## Ürün navigation (üst domain)

**OBSERVED:**

- Ürünler
- Hızlı Fiyatlandırma
- Ürün İndirimleri
- Ürün Tipleri
- Ürün Grupları
- Ürün Alt Grupları

---

## Müşteri navigation (üst domain)

**OBSERVED:**

- Müşteriler
- Müşteri Ödemeleri
- Müşteri Ekstreleri
- Müşteri Satış Faturaları
- Müşteri İade Faturaları
- Müşteri Grupları

---

## Hasta navigation (üst domain)

**OBSERVED:**

- Hasta Sahibi Değiştirme
- Hasta Türleri
- Hasta Irkları
- Renkler
- Hasta Yaş Grupları
- Besin Tipleri
- Cinsiyetler
- Hasta Grupları

---

## Muayene navigation (üst domain)

**OBSERVED:**

- Reçete
- ATS Listesi
- Aşı Paketleri
- Aşı Programları
- Aşılanmamış Hasta Takibi
- Muayene Özellikleri
- Semptomlar
- Teşhisler
- Operasyon Paketleri
- Tedavi Paketleri
- Tedavi Şablonları
- Tedavi Takip Parametreleri
- Tedavi Takip Parametre Paketleri

---

## Laboratuvar navigation (üst domain)

**OBSERVED:**

- Lab Sonuçları Karşılaştır
- Test Grupları
- Test Grup Panelleri
- Test Referansları
- Pacs Grupları
- Cihazlar
- Laboratuvarlar

---

## Genel navigation (üst domain)

**OBSERVED:**

- Birimler
- Bölümler
- KDV Oranı
- Rol Şablonları
- Veterinerler & Personeller
- Odalar
- Görev Tipleri
- Meslekler
- Ayarlar
- Yedek Al
- Kullanma Kılavuzu
- Alpemix

---

## Review Tracker

Hasta-scoped bir yüzeyin incelenmesi, ilgili **global modülün** reviewed olduğu anlamına **gelmez**.

### Hasta Kartı — REVIEWED / CLOSED

Planlanan patient-card review kapsamında **incelendi** (tekrar inceleme gerekmez):

Patient Card navigation / IA · Anasayfa > Ana · Anasayfa > Özel · Anasayfa > Bilgi · Aşı Kartı side panel · QR Kodu · Yönlendir · SMS · Sil flow · Randevular · Yeni Randevu · Ziyaret Geçmişi · Yeni Ziyaret > Satış · Yeni Ziyaret > Aşı Listesi · Yeni Ziyaret > Muayene · Yeni Ziyaret > Notlar · Muayene Geçmişi · Yeni Muayene · Aşı Programı UI · Lab Geçmişi · New Lab flow · Xray Geçmişi · New Xray flow · PACS Geçmişi · New PACS flow · Hospitalizasyon Geçmişi · Ekstreler · Müşteri ve Hasta Hareketleri · Müşteri ve Hasta Hareketleri (Detaylı) · Dosyalarım · Hasta Ağırlık Hareketleri · Predispozisyonlar · SmartVette İzin Ver · Hasta Formları (Muayene, Operasyon, Tedavi, Anestezi, Özel Form 1–6)

**BLOCKED / TBD** (CLOSED kapsamını **engellemez**):

- Operasyon Paketi creation/details (**BLOCKED** in review environment)
- Aşı Programı generation semantics
- SmartVet exact visibility scope
- Predispozisyon “Müşteriye Gönder” exact behavior
- QR scan destination/data scope
- Patient delete persistence semantics
- “Beni Uyar” cross-workflow visibility
- Özel Form-4 inconsistent content root cause

### Global Hospitalizasyon — REVIEWED / CLOSED

Planlanan global modül review kapsamında **incelendi** (tekrar inceleme gerekmez):

Global Hospitalization list · Tarih/arama filtreleri · Durum gruplama (Yatan/Taburcu) · + Yeni Kayıt · Satır genişletme · İncele · Düzenle · Sil onayı · Bölüm/Oda ataması · Tedavi Şekli/Uygulamalar/Açıklama · Yatan → Taburcu geçişi · Taburcu kaydın global listede kalması · Hasta Hospitalizasyon Geçmişi sürekliliği

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- Tam status enum · Günler hesaplama · çıkış tarihi validasyon kuralları · yapılandırılmış inpatient ilaç uygulama · hemşirelik workflow · vital/flowsheet · oda/kafes kapasite modeli · doluluk zorunluluğu · backend delete semantics · structured bed/cage lifecycle

### Global Takvim — REVIEWED / CLOSED

Planlanan Global Takvim / randevu / hatırlatma / iletişim batch **incelendi** (tekrar inceleme gerekmez):

Takvim navigation · Randevular global calendar · Ay / Hafta / Gün · date navigation · Görev Tipi filter · Bölüm filter · Veteriner filter · calendar status coloring · appointment card/hover details · existing appointment edit modal · edit modal + → global Yeni Randevu create · edit modal SMS send · edit modal → Müşteri Kartı handoff · Hatırlatma · SMS reminder list · Email reminder list · Hatırlatma WhatsApp Web handoff + prefilled message · Doğum Günü Hatırlatma · customer/patient birthday tabs · birthday SMS validation/send/result · Toplu Sms · customer list · balance customer list · customer groups · manual list · Toplu Bildirim · Sms Geçmişi · Kara Liste · Şablon Listesi · Şablon Tanımı · dynamic template placeholders · stale/past-date SMS observation

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- drag/drop appointment rescheduling · complete Görev Tipi semantics/config architecture · complete appointment status enum · edit modal trash/delete confirmation and persistence · OTP SMS exact business use case · Ticari exact regulatory/consent semantics · Toplu Bildirim exact recipient/channel · Doğum Günü Bildirim exact recipient/channel · blacklist add flow · SMS failed numeric status meaning · Email delivery history semantics beyond observed surface · complete template token catalog · WhatsApp prefilled-text source · WhatsApp phone routing · WhatsApp send logging back into E-Vet · WhatsApp delivery/read sync · WhatsApp API vs deep-link implementation

### Global Doğrudan Satış — REVIEWED / CLOSED

Planlanan global direct sale batch **incelendi** (2026-09-27; tekrar inceleme gerekmez):

Doğrudan Satış navigation · Doğrudan Satış Müşterisi walk-in context · ana satış alanları · e-Fatura|SMM notu bölümü · barkod/QR yüzey · depo seçimi · ürün arama · satır kolonları · stok miktarı hover · Bilgiyi göster/KDV/Bilgi · genel indirim/stopaj · Kaydet/Öde · Doğrudan Satış Fatura Ödemesi · split payment · ödeme tipleri · geçmiş listesi · İncele read model · payment-blocked delete then post-payment-removal sale delete (canlı test) · destekleyici Ürün Tanımı miat flag · Stok Giriş/Alış Faturası miat validation · Depo Stok Durumu expiry-separated rows · direct sale expiry dropdown

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- barcode exact scan semantics · selected depot vs product-result depot anomaly · FEFO/FIFO enforcement · lot/batch support · Seri No creation/source · Kopyala exact behavior · invoice / 3-copy / Bilgi Fişi details · SMS from sale history · delete persistence (hard/soft) · sale delete stock reversal · audit/event history on delete · e-Fatura/e-SMM linked delete guard · other financial relation delete guards · registered-customer blue-save/balance (**VIDEO OBSERVED**, live UI) · e-Fatura walk-in exact legal/system rules · line document icon semantics · stopaj calculation · POS/bank integration

### E-Vet genel — kalan ana alanlar

| Alan | Durum | Not |
|---|---|---|
| **Hospitalizasyon** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül) |
| **Takvim** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Takvim (modül)](#global-takvim-modül) |
| **Doğrudan Satış** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül); [Yeni Ziyaret > Satış](#yeni-ziyaret) ayrı yüzey |
| **Muayene Odası** | **PARTIAL / NOT SYSTEMATIC** | **Sıradaki ana hedef** ([Next Review Queue](#next-review-queue)); patient muayene reviewed |
| **Lab / Xray / Pacs İstekleri** (global kuyruk) | **PARTIAL / NOT SYSTEMATIC** | Patient history/new request reviewed |
| **HBS** | NOT REVIEWED | |
| **VKY** | NOT REVIEWED | |
| **e-Fatura / e-SMM** | PARTIAL | Nav + patient finans alanları |
| **DataVet** | NOT REVIEWED | |
| **İlaç Rehberi** | NOT REVIEWED | |
| **Nekropsi** | NOT REVIEWED | |
| **Mobil Uygulamalar** | NOT REVIEWED | |
| **Katalog / Dokümanlar** | NOT REVIEWED | |
| **Rapor** (üst domain, sistematik) | **PARTIAL** | Nav isimleri + patient/financial outputs |
| **Stok** | **PARTIAL** | Direct Sale pass: Stok Giriş, Alış Faturası (özet), Depo Stok Durumu — [destek](#destekleyici-inceleme--stok-giriş--alış-faturası--depo-stok-durumu-partial); tam menü **NOT REVIEWED** |
| **Finansal** (üst domain) | **PARTIAL** | Nav + patient ekstre + direct sale ödeme geçmişi (kısmi) |
| **Ürün** | **PARTIAL** | Direct Sale pass: Ürün Tanımı (destek) — [destek](#destekleyici-inceleme--ürün-tanımı-partial-modül-closed-değil); tam modül **NOT REVIEWED** |
| **Müşteri** (global) | **PARTIAL / NOT SYSTEMATIC** | |
| **Hasta** (üst domain, global) | **PARTIAL** | Patient Card **CLOSED**; master-data ekranları ayrı |
| **Muayene** (üst domain config) | **PARTIAL** | |
| **Laboratuvar** (üst domain config) | **PARTIAL** | |
| **Genel / configuration** | NOT REVIEWED | |
| **Hasta Kabul** (global landing) | **PARTIAL** | Landing alanları; tam operasyon **TBD** |

---

## Next Review Queue

Ürün inceleme önceliği (architecture kararı **değil**):

1. ~~Hospitalizasyon~~ — **CLOSED** ([Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül))
2. ~~Takvim~~ — **CLOSED** ([Global Takvim (modül)](#global-takvim-modül); patient-context randevu [Randevular](#randevular))
3. ~~Doğrudan Satış~~ — **CLOSED** ([Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül))
4. **Muayene Odası** — **NEXT**
5. Lab İstekleri
6. Xray İstekleri
7. Pacs İstekleri
8. Rapor
9. Stok
10. Finansal
11. Ürün
12. Müşteri / global Hasta
13. e-Fatura / e-SMM
14. HBS
15. VKY
16. DataVet
17. İlaç Rehberi
18. Nekropsi
19. Mobil Uygulamalar
20. Katalog / Dokümanlar
21. Genel / configuration

---

## Preliminary observations

Aşağıdakiler **preliminary observation**dır; Vetinity ürün kararı veya scope kararı değildir.

**INFERRED (navigation yapısı):**

- Sol operasyonel navigation günlük operasyon / kısayol yüzeyi olarak konumlanıyor; her menü öğesinin gerçek workflow'u deep-dive yapılmadan kesinleştirilmemeli.
- Üst navigation'da operasyonel/domain ekranları ile master-data / configuration ekranları birlikte sunuluyor (ör. **Hasta** menüsünde Tür, Irk, Renk, Yaş Grubu, Besin Tipi, Cinsiyet gibi tanım ekranları).
- **Muayene** menüsü klinik/operasyonel yetenek etiketleri ile şablon/konfigürasyon verilerini aynı navigation altında birleştiriyor.
- **Rapor** merkezi klinik, operasyonel, stok, finansal ve “Resmi” adlı kayıt/rapor yüzeylerini tek yapı altında topluyor.
- “Resmi” altında Muayene, Aşı, İlaç, Reçete ve Narkotik kayıt defteri rapor/menu isimleri gözlemlendi.
- **Takvim** navigation'ı randevu işlevlerinin yanında hatırlatma, toplu SMS/bildirim, SMS geçmişi, kara liste ve şablon yüzeylerini de barındırıyor (menü envanterine göre).
- **e-Fatura / e-SMM** ayrı bir operasyon alanı olarak sol navigation'da görünür durumda (alt menü: Fatura Yönetim Paneli, Giden/Gelen e-Faturalar).
- **DataVet > Laboratuvar** altında Pet ve Büyükbaş ayrımı gözlemlendi (anlamı workflow deep-dive ile doğrulanacak).

**TBD:**

- “Resmi” ekranların hukuki/regulatory zorunluluk olup olmadığı (menü adından türetilmez).
- HBS, PACS, İlaç Rehberi entegrasyon/kapsam detayları; VKY işlevi; e-Fatura/e-SMM sağlayıcı ve mevzuat davranışı; DataVet ekran içi akışları; SmartVET / SmartIVET hedef kullanıcı ve capability kapsamı.

**INFERRED (domain coverage — menü envanterinden):**

- Görünen menü kapsamı satın alma/stok/depo, finans, müşteri, hasta, klinik (muayene), laboratuvar/PACS ve raporlama alanlarına uzanıyor.

---

## VETINITY IMPLICATION

*(Minimum — deep-dive ilerledikçe genişletilecek.)*

- **TBD:** Navigation'da operasyon ile master-data birleşiminin Vetinity IA hedefleriyle nasıl karşılaştırılacağı ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md), [ADR-003](../decisions/ADR-003-report-center.md) — bu pass'te karar yok).
- **TBD:** Türkiye-local entegrasyon adları (HBS, VKY, e-Fatura/e-SMM, DataVet) için ayrı entegrasyon deep-dive.

---

## Ürün özeti / hedef kitle / güçlü-zayıf / backlog

**TBD** — Navigation IA tamamlandı; **Hasta Kartı**, **Global Hospitalizasyon**, **Global Takvim** ve **Global Doğrudan Satış** **REVIEWED / CLOSED**. Genel E-Vet özeti, güçlü/zayıf ve kalan modül deep-dive'lar ilerledikçe doldurulacaktır ([Next Review Queue](#next-review-queue)).

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
