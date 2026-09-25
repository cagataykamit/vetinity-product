# E-Vet SMART — Rakip Analizi

## Ürün

E-Vet SMART (Türkiye pazarı veteriner klinik yönetim yazılımı)

## İncelenen alan

**Tamamlanan pass'ler:**

- Platform shell / navigation ve IA envanteri (**navigation discovery tamamlandı**, 2026-09-23); login sonrası Hasta Kabul landing (alan etiketleri; kısmi — bkz. [Review Tracker](#review-tracker)).
- **Hasta Kartı / Patient Workspace** — planlanan görsel/product review kapsamı **REVIEWED / CLOSED** (2026-09-24 – 2026-09-25); [kapsam](#hasta-kartı--patient-workspace) ve [tracker](#review-tracker).
- **Global Hospitalizasyon modülü** — sol menü **Hospitalizasyon** / **Hospitalizasyonlar** operasyon yüzeyi **REVIEWED / CLOSED** (2026-09-25); [kapsam](#global-hospitalizasyon-modül) ve [tracker](#review-tracker).

**Devam eden / henüz sistematik incelenmeyen:** Takvim (global), Doğrudan Satış, vb. — [Review Tracker](#review-tracker), [Next Review Queue](#next-review-queue).

## Analiz durumu

| Kapsam | Durum |
|---|---|
| **E-Vet SMART genel competitor review** | **Devam ediyor (IN PROGRESS)** — gözlemlenen sürüm **v4.12.0** |
| **Navigation / IA discovery** | Tamamlandı (2026-09-23) |
| **Hasta Kartı / Patient Workspace** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Hospitalizasyon modülü** | **REVIEWED / CLOSED** (2026-09-25) |

> **CLOSED:** Planlanan modül görsel/product review kapsamı tamamlandı; kaynak dokümantasyon oluşturuldu. **Anlamına gelmez:** reverse engineering, backend/domain semantics, tam status enum veya tüm E-Vet ürün kapsamının incelenmiş olması.

---

## Kanıt disiplini

Kanıt sınıflandırması:

| Etiket | Anlam |
|---|---|
| **OBSERVED** | Canlı UI'da doğrudan görülen |
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
| İnceleme tarihi | 2026-09-23 (navigation); 2026-09-24 – 2026-09-25 (Hasta Kartı — CLOSED); 2026-09-25 (Global Hospitalizasyon — CLOSED) |

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

**OBSERVED:**

- Randevular
- Hatırlatma
- Doğum Günü Hatırlatma
- Toplu Sms
- Toplu Bildirim
- Sms Geçmişi
- Kara Liste
- Şablonlar

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

### E-Vet genel — kalan ana alanlar

| Alan | Durum | Not |
|---|---|---|
| **Hospitalizasyon** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül) |
| **Takvim** (global) | **PARTIAL** | Hasta bağlamında randevu reviewed — **sıradaki ana alan** ([Next Review Queue](#next-review-queue)) |
| **Doğrudan Satış** | **NOT REVIEWED** | Visit Sales ≠ global Direct Sale |
| **Muayene Odası** | **PARTIAL / NOT SYSTEMATIC** | Patient muayene reviewed |
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
| **Stok** | NOT REVIEWED | Nav envanteri only |
| **Finansal** (üst domain) | **PARTIAL** | Nav + patient ekstre |
| **Ürün** | NOT REVIEWED | Nav envanteri only |
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
2. **Takvim** — **NEXT** (global modül; patient-context randevu **PARTIAL**)
3. Doğrudan Satış
4. Muayene Odası
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

**TBD** — Navigation IA tamamlandı; **Hasta Kartı** ve **Global Hospitalizasyon** **REVIEWED / CLOSED**. Genel E-Vet özeti, güçlü/zayıf ve kalan modül deep-dive'lar ilerledikçe doldurulacaktır ([Next Review Queue](#next-review-queue)).

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
