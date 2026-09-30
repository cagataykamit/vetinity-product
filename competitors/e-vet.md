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
- **Global Muayene Odası modülü** — klinik worklist / patient-routing yüzeyi **REVIEWED / CLOSED** (2026-09-28); [kapsam](#global-muayene-odası-modül) ve [tracker](#review-tracker).
- **Global Lab İstekleri modülü** — lab worklist, patient-context request creation, structured results **REVIEWED / CLOSED** (2026-09-28); [kapsam](#global-lab-i̇stekleri-modül) ve [tracker](#review-tracker).
- **Global Xray İstekleri** — request/configuration yüzeyleri **PARTIAL** (2026-09-29); [kapsam](#global-xray-i̇stekleri-partial) ve [tracker](#review-tracker).
- **Global Pacs İstekleri modülü** — populated worklist, CR/US modalities, external Fujifilm Synapse Mobility viewer handoff **REVIEWED / CLOSED** (2026-09-29); [kapsam](#global-pacs-i̇stekleri-modül) ve [tracker](#review-tracker).
- **Rapor (üst domain)** — Rapor Özellikleri, Genel, Randevu, Resmi, Depo, Finansal **REVIEWED / CLOSED** (2026-09-29; erişilebilir ekran seti ve yetki sınırları içinde; ACCESS-BLOCKED alt raporlar explicit); [kapsam](#rapor) ve [tracker](#review-tracker).
- **Stok (üst domain)** — 12 menü öğesi **REVIEWED / CLOSED** (2026-09-30; erişilebilir ekranlar ve güvenli/read-only etkileşimler kapsamında; side-effect davranışları NOT OBSERVED); [kapsam](#stok-modül) ve [tracker](#review-tracker).
- **Finansal (üst domain)** — 7 menü öğesi **REVIEWED / CLOSED** (2026-09-30; erişilebilir ekranlar ve güvenli/read-only UI incelemesi kapsamında; save/posting ve bakiye/ledger etkileri NOT VERIFIED); [kapsam](#finansal-modül) ve [tracker](#review-tracker).

**Devam eden / henüz sistematik incelenmeyen:** tam Ürün modül review, Xray result lifecycle (incelenen klinikte doğrulanamadı), PACS US missing-image root cause, DataVet entegrasyon deep-dive, vb. — [Review Tracker](#review-tracker), [Next Review Queue](#next-review-queue).

## Analiz durumu

| Kapsam | Durum |
|---|---|
| **E-Vet SMART genel competitor review** | **Devam ediyor (IN PROGRESS)** — gözlemlenen sürüm **v4.12.0** |
| **Navigation / IA discovery** | Tamamlandı (2026-09-23) |
| **Hasta Kartı / Patient Workspace** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Hospitalizasyon modülü** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Takvim modülü** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Doğrudan Satış modülü** | **REVIEWED / CLOSED** (2026-09-27) |
| **Global Muayene Odası modülü** | **REVIEWED / CLOSED** (2026-09-28) |
| **Global Lab İstekleri modülü** | **REVIEWED / CLOSED** (2026-09-28) |
| **Global Xray İstekleri** | **PARTIAL** (2026-09-29) |
| **Global Pacs İstekleri modülü** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor** (üst domain) | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor Özellikleri** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor → Genel** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor → Randevu** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor → Resmi** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor → Depo** | **REVIEWED / CLOSED** (2026-09-29) |
| **Rapor → Finansal** | **REVIEWED / CLOSED** (2026-09-29) |
| **Stok** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) |
| **Finansal** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) |

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
| İnceleme tarihi | 2026-09-23 (navigation); 2026-09-24 – 2026-09-25 (Hasta Kartı — CLOSED); 2026-09-25 (Global Hospitalizasyon — CLOSED); 2026-09-25 (Global Takvim — CLOSED); 2026-09-27 (Global Doğrudan Satış — CLOSED); 2026-09-28 (Global Muayene Odası — CLOSED); 2026-09-28 (Global Lab İstekleri — CLOSED); 2026-09-29 (Global Xray İstekleri — PARTIAL); 2026-09-29 (Global Pacs İstekleri — CLOSED); 2026-09-29 (Rapor / Genel pass); 2026-09-29 (Rapor / Randevu, Resmi, Depo, Finansal consolidation — Rapor CLOSED); 2026-09-30 (Stok — CLOSED); 2026-09-30 (Finansal — CLOSED) |

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
- Muayene Odası *(global modül — [Global Muayene Odası (modül)](#global-muayene-odası-modül) **CLOSED**)*
- Lab İstekleri *(global modül — [Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül) **CLOSED**)*
- Xray İstekleri *(global — [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial))*
- Pacs İstekleri *(global modül — [Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül) **CLOSED**)*
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

### Destekleyici inceleme — Stok Giriş / Alış Faturası / Depo Stok Durumu (öncül destek notu)

**Not:** Bu bölüm direct sale expiry kanıtı için yazılmış öncül destek notudur; Stok menüsünün tam incelemesi → [Stok (modül)](#stok-modül).

**OBSERVED — Stok Giriş:** İşlem Tarihi · İşlem No · Açıklama · Barkod · Depo · Ürün · Faktör|Çarpan & Miktar · Birim · + Yeni. Miat kontrollü ürün → satır **Miat** zorunlu (“Bu alan zorunludur!”); kontrolsüz üründe **Miat** alanı yok.

**OBSERVED — Alış Faturası (özet):** İşlem Tarihi · Satıcı Firma · Fatura No · Stok Hareketini Engelle · Teslim/Vade/Depo Çıkış/Açıklama · Barkod · Depo · KDV Dahil · ürün satırları · Faktör|Çarpan & Miktar · Fiyat · KDV · İskonto · Toplam; miat kontrollü üründe satır **Miat** zorunlu.

**OBSERVED — Stok > Depo Stok Durumu kolonları:** İçerik Tipi · Ürün Tipi · Barkod-1 · Barkod-2 · Ürün · Birim · **Miat** · **Miktar**.

**OBSERVED:** Aynı ürün + aynı depoda farklı **Miat** değerleriyle **ayrı satırlar** (ör. 12.01.2029 ve 28.02.2029) — UI-level **expiry-separated quantity rows** (**lot/batch entity iddiası yok**).

*(Diğer Stok menü öğeleri — İade/Sipariş faturası, Stok Çıkış, Sayım, Sıfırlama, Transfer, satıcı ödemeleri, Depolar vb. — bu öncül notta yoktu; sonradan [Stok (modül)](#stok-modül) altında incelendi.)*

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

## Global Muayene Odası (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-28 — planlanan global **Muayene Odası** product review kapsamı).

**OBSERVED — giriş:** Sol operasyonel menü **Muayene Odası**.

**NOT:** Bu yüzey klasik **clinical examination form** / SOAP muayene kaydı **değildir**. Patient-card [Muayene Geçmişi](#hasta-kartı--patient-workspace) · [Yeni Muayene](#hasta-kartı--patient-workspace) · [Yeni Ziyaret > Muayene](#yeni-ziyaret) ile **birleştirilmez** — ilişkili klinik bağlam, farklı operasyonel yüzeyler.

---

### Global liste / worklist

**OBSERVED:** Liste/worklist yüzeyi.

**OBSERVED — filtreler:** Tarih Aralığı · Veteriner · Bölüm · Durum · Arama Metni.

**OBSERVED — kolonlar:** İşlemler · Bölüm · İşlem Tarihi · Müşteri · Hasta · Açıklama · Yönlendir · Durum.

**OBSERVED:** Satırlar **veteriner/assignee** başlığı altında gruplanabiliyor.

**INFERRED (sınırlı karakterizasyon):** Operasyonel hasta yönlendirme / clinic **work queue** niteliği — fiziksel “muayene odası” oda yönetimi **iddia edilmez**.

---

### Yeni kayıt — Muayene Odası Tanımlama

**OBSERVED alanlar:** Durum · İşlem Tarihi · Müşteri · Hasta · Bölüm · Veteriner · Açıklama · **Kaydet** · **Kaydet / Yeni**.

#### İki ayrı “Durum” kavramı (UI semantiği)

Backend’de ayrı field/entity **iddia edilmez**. UI’da **iki farklı state concept** gözlemlendi:

| Kavram | Gözlemlenen değerler | Yüzey |
|---|---|---|
| **A) Record state** | Aktif · Pasif | Tanımlama formu **Durum** dropdown |
| **B) Operational workflow state** | Beklemede · Tamamlandı | Global liste **Durum** filtresi · satır **Durum** · inline toggle |

**NOT:** Aktif/Pasif ile Beklemede/Tamamlandı **birleştirilmez**.

---

### Workflow status lifecycle (canlı test)

**OBSERVED — Durum filtresi:** Beklemede · Tamamlandı.

**OBSERVED — inline hızlı aksiyon:**

- **Beklemede** → satırda yeşil check/tick → tıklanınca **Tamamlandı**
- **Tamamlandı** → satır aksiyonu **circular-arrow / reopen-like** ikona dönüşür → tıklanınca **Beklemede**

**OBSERVED:** İki yönlü status toggle **çalışıyor**.

**NOT OBSERVED:** Status değişiminde confirmation modal; success toast / notification.

**NOT:** Circular-arrow için resmi “undo” / “reopen” ürün adı **verilmez** — yalnızca **reopen-like / circular-arrow action** betimlemesi.

---

### Yönlendir / routing

**OBSERVED:** Satır **Yönlendir** → modal.

**OBSERVED modal alanları:** İşlem Tarihi · Bölüm · Veteriner · Açıklama · **Güncelle**.

**OBSERVED Bölüm örnekleri (requirement değil):** Dış Klinik · Hasta Odası · Klinik · Muayene Odası - 2 · Traş.

**OBSERVED assignee dropdown örnekleri (UI label = Veteriner):** Aslı · Doğuş · Kıvanç · **Klinik** (generic/non-person-looking entry).

**NOT inferred:** Dropdown yalnızca gerçek veteriner kullanıcılarından oluşur. Güvenli betimleme: **assignee/provider selector** (UI etiketi: Veteriner).

**NOT OBSERVED / TBD:** Routing history · audit trail · notification · yeni queue item yaratma · ownership transfer domain model · backend workflow engine.

---

### Routing — canlı test

**OBSERVED başlangıç:** Bölüm = Dış Klinik; workflow state = Beklemede.

**OBSERVED aksiyon:** Yönlendir modal — Bölüm **Dış Klinik → Hasta Odası**; **Güncelle**.

**OBSERVED sonuç:**

- Aynı kayıt worklist’te **kaldı**
- **Bölüm** = Hasta Odası
- Workflow state = **Beklemede** (otomatik **Tamamlandı** **olmadı**)

**OBSERVED:** Routing mevcut kaydın **bölüm** bilgisini güncelleyebiliyor; test edilen örnekte routing ile **Beklemede/Tamamlandı** lifecycle **ayrı aksiyonlar**.

---

### Sil

**OBSERVED:** Satırda delete/trash aksiyonu.

**OBSERVED:** Sil → “Silme İşlemi - Onay” / “Seçili kaydı silmek istediğinizden emin misiniz?” (onay UI).

**NOT OBSERVED / TBD (CLOSED’ı engellemez):** Actual delete persistence · dependency guard · hard vs soft delete · audit/history.

---

### Ürün karakterizasyonu (OBSERVED UI’dan, sınırlı)

**OBSERVED UI davranışından çıkarım:** Global Muayene Odası, müşteri/hasta kayıtlarını **bölüm** ve **assignee** bağlamında operasyonel olarak sıraya alan, **Beklemede/Tamamlandı** lifecycle’ı ve manuel **Yönlendir** ile yeniden yönlendirme sağlayan **lightweight clinic worklist / patient-routing surface** gibi davranır.

**NOT:** Asıl **clinical examination record** ile aynı şey **değildir**.

---

### VETINITY IMPLICATION (Muayene Odası pass)

*(E-Vet davranışı olarak sunulmaz; değerlendirme adayları.)*

- Inline **Beklemede ↔ Tamamlandı** geçişi hızlı olabilir; kısa **feedback** ve **undo** imkânı güvenlik/UX açısından değerlendirilebilir.
- **Patient routing / clinic work queue** ihtiyacı [v1-release-scope.md](../roadmap/v1-release-scope.md) ve [ux/navigation.md](../ux/navigation.md) ile ayrı hizalanmalı — competitor kopyası **değil**.

**Backlog cross-ref (bu pass’te ID evidence eklenmedi):** [EXAM-001](../backlog/feature-backlog.md#exam-001--modern-muayene-çalışma-alanı)–[EXAM-015](../backlog/feature-backlog.md#exam-015--medical-note-lock) muayene **kaydı** odaklı; [CHECKIN-005](../backlog/feature-backlog.md#checkin-005--ziyaret-yaşam-döngüsü-ve-durum-geçişleri) **ziyaret/encounter** yaşam döngüsü — global worklist semantiği **doğrudan eşleşmedi** (POTENTIAL GAP — rapor).

---

## Global Lab İstekleri (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-28 — planlanan global **Lab İstekleri** product review kapsamı).

**OBSERVED — giriş:** Sol operasyonel menü **Lab İstekleri**.

**Cross-ref (patient-context, Hasta Kartı CLOSED):** Yeni istek **global listede değil** — [Lab Geçmişi](#hasta-kartı--patient-workspace) **`+` → Yeni Lab İstek** (Patient Card review’da **New Lab flow** olarak geçer; bu pass’te form detayı doğrulandı).

---

### Global worklist

**NOT OBSERVED:** Global ekranda **Yeni Kayıt** / global create butonu.

**OBSERVED — filtreler:** Tarih Aralığı · Arama Metni · Ara · Temizle.

**NOT OBSERVED:** Beklemede / İşleniyor / Tamamlandı için ayrı **status filter**, quick filter veya tab (canlı örnekte ~1.400+ kayıt).

**OBSERVED — aksiyon:** **Yazdır** (liste düzeyi).

**OBSERVED — kolonlar:** İşlemler · İstek ID · İstek Tarihi · İstek No · Test Grubu · Bölüm · Veteriner · Müşteri · Hasta Protokol No · Hasta · Doğum Tarihi.

**INFERRED:** Merkezi **operational worklist** — yeni istek oluşturma yüzeyi **değil**.

**OBSERVED — gruplama:** Status başlıkları altında (ör. **Beklemede**, **Tamamlandı**).

**NOT OBSERVED / TBD:** Global listede ayrı **İşleniyor** group heading (enum detail ekranında var — aşağıda).

**OBSERVED — sıralama (görünür gruplar içinde):** İstek Tarihi **yeni → eski** (default sort/backend implementation **iddia edilmez**).

---

### Patient-context request creation — Yeni Lab İstek

**OBSERVED yol:** Hasta kartı **Lab & Xray & Pacs → Lab Geçmişi → `+`** → **Yeni Lab İstek**.

**OBSERVED alanlar:** İstek Tarihi · İstek No · Hasta Durumu · SmartVette İzin Ver · Açıklama & Analiz Yorumu (expandable) · Test Grubu · Test Grup Panel · Test Kalemleri · İstek Kalemleri · Ekle · **Kaydet**.

**OBSERVED:** Müşteri/hasta formda yeniden seçilmez — **patient context** içinde oluşturma.

**OBSERVED — Hasta Durumu:** Ayakta Tedavi · Baygın · Hospitalizasyon · Uyanık.

**OBSERVED — SmartVette İzin Ver:** Evet · Hayır (**TBD:** exact business rule; entegrasyon/data sharing **doğrulanmadı**).

---

### Test group & panel selection

**OBSERVED Test Grubu örnekleri (tam enum değil):** ABL 9 KAN GAZI · AU10V HORMON ANALİZ · FUJI DRI-CHEM 4000i BİYOKİMYA ANALİZİ · HASVET VH-3 · HASVET VH-5 · HIZLI TEST KİTLERİ · MINDRAY BC-2800 VET KAN SAYIM · MINDRAY BC-5000 VET KAN SAYIM · vb.

**OBSERVED Test Grup Panel örnekleri:** COMPREHENSIVE S-PANEL · KIDNEY PANEL · LIVER PANEL · PLUS PANEL · PRE-SURGICAL S-PANEL.

**INFERRED:** Tekil test kalemleri ile hazır panel/grup seçimi **ayrı UI kavramları**; panel seçiminin auto-add davranışı **TBD**. Cihaz/analiz tipi adları grupta geçebilir — **device/LIS architecture çıkarımı yok**.

---

### Request lifecycle / status

**OBSERVED — Lab Sonuçları / detail `İstek Durumu` enum:** Beklemede · **İşleniyor** · Tamamlandı.

**OBSERVED — global group headings (bu pass):** Beklemede · Tamamlandı (**İşleniyor** group **NOT OBSERVED**).

**OBSERVED — detail üst:** İstek ID & İstek No · İstek Tarihi · Hasta Durumu.

**OBSERVED — detail alanlar:** İstek Durumu · Analiz Başlangıç Tarihi · Analiz Bitiş Tarihi · Analiz Yorumu · Açıklama.

**OBSERVED — alt aksiyonlar:** Geri Dön · **Kaydet** (**NOT OBSERVED:** ayrı **Tamamla** butonu).

**NOT inferred:** Status dropdown + Kaydet = otomatik completion semantics.

---

### Lab Results — structured analytes

**OBSERVED result tablosu kolonları:** Test Adı · Lab Değeri · Açıklama · Sonuç · Datavet · Min. Ref · Maks. Ref · Birim · Ref. Açıklaması.

**OBSERVED analyte örnekleri (CBC benzeri):** Lökosit · Bazofil · Nötrofil · Eozinofil · Lenfosit · Monosit · Eritrosit · Hemoglobin · MCV · MCH · MCHC · RDW-CV · RDW-SD · Hematokrit · Trombosit · MPV · PDW · PCT · vb.

**OBSERVED:** Reference min/max ve **Birim** görüntülenebilir; **Lab Değeri** structured input; placeholder örneği `0,00 / + / -`.

**TBD / INFERRED:** Placeholder’dan tüm testlerde numeric + positive/negative semantiği **kesin çıkarılmaz**.

---

### Completed ≠ populated results

**OBSERVED (Tamamlandı grubu — gerçek kayıt):** Status = **Tamamlandı**; inline expanded table’da analyte satırları ve referans aralıkları var; **Lab Değeri alanları boş** göründü.

**OBSERVED:** **Tamamlandı** status’u **`structured result values populated`** anlamına **gelmez**. Completion lifecycle ≠ result population (**birleştirilmez**).

---

### Reference ranges

**OBSERVED:** Aynı analyte (ör. Lökosit) farklı kayıtlarda farklı aralıklar (ör. 5.5–19.5 vs 6–17).

**Characterization:** Context-dependent / configurable-looking reference ranges; species · breed · age · sex · device · profile **TBD** (derivation **doğrulanmadı**).

---

### Inline expand

**OBSERVED:** Satır sol ok → expand.

**OBSERVED expanded:** Test group başlığı · Test Adı · Lab Değeri · Referans · ek Lab Değeri sütunu · **Test Sayısı** · DataVet.

**TBD:** Test Sayısı chart-like icon + numeric badge anlamı.

---

### Row actions & sharing (tooltip doğrulandı)

| UI | Tooltip / davranış |
|---|---|
| Kalem | **Düzenle** |
| Bulut/down | **İndir** |
| Yazıcı | **Yazdır** |
| Kare/barcode benzeri | **Barkod Yazdır** |
| WhatsApp | **Whatsapp ile paylaş** (share action only) |
| Gri mail | **Email ile paylaş** |
| Kırmızı çöp | **Sil** |

**OBSERVED — Email ile paylaş validation:** “Tanımlı email adresi bulunmamaktadır!” (customer/contact email dependency — UI seviyesi).

**TBD:** İndir / Yazdır / Barkod Yazdır çıktı formatları; Sil confirmation/dependency/audit; WhatsApp/email delivery logging.

**NOT inferred:** WhatsApp API · server send · delivery/read tracking.

---

### DataVet (analyte-level)

**OBSERVED:** Result grid’de analyte **DataVet** ikonu → modal (ör. Lökosit): analyte açıklaması · klinik bilgi/yorum · artış/azalış nedenleri · kaynakça/referanslar.

**OBSERVED characterization:** **Analyte-level veterinary reference / interpretation content surface**.

**NOT OBSERVED / TBD:** Lab device integration · result import · LIS · bidirectional sync · automatic analyzer feed · cloud sync · DataVet dışı entegrasyon fonksiyonları.

*(Sol menü **DataVet** modülü ayrı — bu pass **NOT REVIEWED**.)*

---

### UX observations

**OBSERVED gap:** Büyük worklist’te status yalnızca **visual grouping**; dedicated status filter yok.

**VETINITY IMPLICATION:** Lab worklist’te open work’ü ayırmak için status filter / quick segments / tabs **değerlendirilebilir** (E-Vet weakness olarak; otomatik backlog ID **yok**).

---

### Ürün sentezi — Lab (UI lifecycle, architecture iddiası yok)

**OBSERVED:** Patient context içinden **Yeni Lab İstek** formu açılır; global **Lab İstekleri** mevcut request’leri **operational worklist** olarak listeler (detail/result/share kanıtları bu pass’te — yukarıda).

**NOT LIVE-VERIFIED:** Patient-context **Kaydet** → kaydın global worklist’te görünmesi (Lab pass’te yeni request **kaydedilmedi**).

**OBSERVED (mevcut kayıtlar üzerinden):** Worklist → **Lab Sonuçları** structured entry → reference ranges → inline expand → print/download/barcode/share → DataVet interpretation modal.

**TBD:** Backend entity model · billing linkage · specimen model · patient save → global list continuity.

---

### VETINITY IMPLICATION (Lab pass)

- Patient-context create yüzeyi + global worklist read continuity değerlendirilebilir ([v1-release-scope.md](../roadmap/v1-release-scope.md) Laboratory Results satırı ile hizalama **karar değil**); save→queue **canlı doğrulanmadı**.
- Structured analyte + reference range + completion≠values ayrımı product modelinde net olmalı.
- Status filter eksikliği operasyonel risk adayı.

**Backlog (bu pass):** Dedicated **LAB-*** epic yok; zayıf eşleşmelere evidence **eklenmedi** — audit raporu.

---

### TBD / NOT OBSERVED (CLOSED’ı engellemez)

Test Grup Panel auto-add · Test Grubu → kalem population · SmartVette İzin Ver semantics · global **İşleniyor** grouping · populated completed example · out-of-range visual flags · İndir/Yazdır/Barkod formatları · Test Sayısı badge · DataVet beyond reference content · reference derivation rules · delete guard/audit · share delivery tracking · lab billing · specimen/sample fields · external analyzer architecture · patient-context lab request save → global worklist appearance.

---

## Global Xray İstekleri (PARTIAL)

**Review status:** **PARTIAL** (2026-09-29 — request/configuration yüzeyleri incelendi; **CLOSED değil**).

**Characterization:** Request/configuration surfaces were reviewed, but the **current reviewed clinic/account** had no selectable Xray **Test Grubu** and no Xray request records in the searched period; real request/result lifecycle **could not be validated**.

**NOT inferred:** “E-Vet Xray modülü kullanılmıyor” (global ürün iddiası yok).

**Cross-ref:** Patient **Xray Geçmişi → + → Yeni Xray İstek** (Hasta Kartı **CLOSED** — form yapısı bu pass’te doğrulandı). [Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül) ile **shared diagnostic request/configuration pattern at UI level** (domain model / backend engine **iddia edilmez**).

---

### Global worklist shell

**OBSERVED — giriş:** Sol menü **Xray İstekleri**; breadcrumb **Anasayfa > Xray İstekleri**.

**NOT OBSERVED:** Global **Yeni Kayıt** butonu.

**OBSERVED — filtreler:** Tarih Aralığı · Arama Metni · Ara · Temizle.

**OBSERVED — kolonlar:** İşlemler · İstek ID · İstek Tarihi · İstek No · Bölüm · Veteriner · Müşteri · Hasta Protokol No · Hasta.

**OBSERVED (incelenen klinik/hesap):** Tarih aralığı 28.09.2019 – 28.09.2026 → **Kayıt bulunamadı**.

**OBSERVED:** Current reviewed clinic/account had **no Xray request records** in the searched 2019–2026 date range.

---

### Patient-context — Yeni Xray İstek

**OBSERVED yol:** **Lab & Xray & Pacs → Xray Geçmişi → `+`** → **Yeni Xray İstek**.

**OBSERVED alanlar:** İstek Tarihi · İstek No · Hasta Durumu · SmartVette İzin Ver · Açıklama & Analiz Yorumu · Test Grubu · Test Grup Panel · Test Kalemleri · İstek Kalemleri · Ekle · **Kaydet**.

**OBSERVED — Hasta Durumu:** Ayakta Tedavi · Baygın · Hospitalizasyon · Uyanık.

**OBSERVED — SmartVette İzin Ver:** Evet · Hayır (**TBD:** business/integration semantics).

**NOT LIVE-VERIFIED:** Request **Kaydet** · global listede görünme · result/status lifecycle.

---

### Test Grubu / Test Grup Panel (request form)

**OBSERVED — Test Grubu dropdown:** **Kayıt bulunamadı** (incelenen klinikte seçilebilir Xray test grubu yok).

**OBSERVED — Test Grup Panel dropdown (aynı form):** COMPREHENSIVE S-PANEL · KIDNEY PANEL · LIVER PANEL · PLUS PANEL · PRE-SURGICAL S-PANEL (Lab pass’te görülen panel adlarıyla aynı terminoloji).

**NOT VERIFIED:** Intentional shared catalog vs config leakage vs irrelevant options; gerçek Xray request’te kullanım.

**NOT:** Bug iddiası yok.

---

### Test Grubu Tanımı (shared configuration surface)

**OBSERVED yol:** **Test Grupları > Test Grubu Tanımı** (configuration; tam üst-domain IA bu pass’te **PARTIAL**).

**OBSERVED alanlar:** Tür · Test Tipi · Adı · Serbest Parametreli · Laboratuvar · Cihaz · Durum · **Test Kalemleri** grid (Kod · Sıra No · Test Adı · Cihaz Kodu · Test Grup Panelleri · Durum) · Ekle · Geri Dön · Kaydet.

**OBSERVED — Tür:** **Lab** · **Röntgen**.

**Characterization:** Shared/generic **configuration surface at UI level** (single table / backend entity **iddia edilmez**).

---

### Tür / Test Tipi behavior

**OBSERVED — Tür = Röntgen iken Test Tipi örnekleri:** Hemogram · Arteriyel K.G. · Biyokimya · Diğer · Hormon · İdrar · Venüs Kan Gazı · **Röntgen** (lab-oriented seçenekler de listede).

**OBSERVED:** Strict type filtering **gözlemlenmedi**. **TBD:** Exact filtering/business rule (frontend/config bug **iddia edilmez**).

---

### Serbest Parametreli

**OBSERVED:** Test Grubu seviyesinde **Serbest Parametreli** Evet/Hayır. **TBD:** Exact semantics (free-text result builder **varsayılmaz**).

---

### Laboratuvar / Cihaz (Tür=Röntgen, Test Tipi=Röntgen)

**OBSERVED:** **Laboratuvar** ve **Cihaz** alanları görünür kaldı.

**OBSERVED — Laboratuvar örneği:** Lab - 1.

**OBSERVED — Cihaz dropdown örnekleri:** Mindray BC5000 · Nx600 · VCHECK V200 (Lab bağlamında da gözlemlenen isimler).

**NOT VERIFIED:** Tür bazlı filtreleme · Röntgen-only cihaz kataloğu · bu cihazların Xray workflow’unda kullanılabilirliği · klinik Röntgen config tamamlığı.

**NOT inferred:** “Röntgen cihaz desteği yok” · “Lab cihazlarını Xray’de kullanıyor”.

---

### Test Kalemi required validation

**OBSERVED save attempt:** Tür = Röntgen · Test Tipi = Röntgen · Adı = Test1 → **Kaydet** → **“Kalem girişi yapmadınız, lütfen kalem(ler) ekleyiniz.”**

**OBSERVED:** En az bir **Test Kalemi** olmadan Test Grubu kaydı **validation ile bloklandı**.

**OBSERVED:** Kaydet denemesi validation ile bloklandı; başarılı kayıt / persistence kanıtı **gözlemlenmedi**. Test kalemi eklenmedi.

---

### Product characterization

**PARTIAL —** workflow surface observed; current reviewed clinic/account appears **without usable Xray test group selection and without Xray request rows** in searched range → **result/processing lifecycle not validated**.

---

### VETINITY IMPLICATION (Xray pass)

- Lab/Xray **shared request form + Test Grubu Tanımı** pattern’i Vetinity’de diagnostic request/config tasarımında ayrıştırılabilir ([ADR-007](../decisions/ADR-007-imaging-module.md) imaging ≠ generic file — **karar değil**, bağlam).
- Tür/Test Tipi/Cihaz catalog tutarlılığı ve modality-specific filtering değerlendirilebilir.
- Xray **CLOSED** sayılmadan önce en az bir configured clinic + request + (varsa) result/image yüzeyi gerekir.

**Backlog:** Bu pass’te IMG/DICOM/PACS evidence **eklenmedi** (görülmedi).

---

### TBD / NOT OBSERVED (PARTIAL — competitor’da varmış gibi yazılmaz)

Gerçek Xray request lifecycle · status enum/grouping · result/detail screen · image upload/attachment · DICOM · PACS handoff · viewer · radiology report · interpretation fields · annotations · image count/series · modalities · Xray device integration · usable Xray Test Group in reviewed clinic · billing · delete dependency · print/download/share · SmartVette semantics · Test Grup Panel meaningfulness for Xray · Laboratuvar/Cihaz catalog filtering · patient save → global queue.

**NOT:** [Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül) ayrı operasyon yüzeyi; PACS kanıtı Xray **PARTIAL** durumunu **değiştirmez**.

---

## Global Pacs İstekleri (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-29).

**Characterization:** Patient-context PACS request surface, populated global worklist, **CR** external viewer handoff and real image viewing were validated. Reviewed **US** records existed in the worklist but returned **“Pacs Görüntüsü mevcut değil..”**; the cause remains **unresolved** (CLOSED = planned visual/product workflow review completed — **not** full integration semantics).

**Distinction vs Xray:** **Xray İstekleri** and **Pacs İstekleri** are **separate** global modules. Xray remains **[PARTIAL](#global-xray-i̇stekleri-partial)**; PACS evidence does **not** close Xray.

**Diagnostic surfaces synthesis (UI level, backend iddiası yok):** En az üç ayrı operasyon yüzeyi — **Lab İstekleri** · **Xray İstekleri** · **Pacs İstekleri** — **shared patient-context navigation** (**Lab & Xray & Pacs**) altında; PACS tarafı gerçek imaging study/viewer continuity gösterirken Xray request/configuration incelenen klinikte doğrulanamadı.

---

### Global PACS worklist

**OBSERVED — giriş:** Sol menü **Pacs İstekleri**; breadcrumb **Anasayfa > Pacs İstekleri**.

**NOT OBSERVED:** Global **Yeni Kayıt** butonu.

**OBSERVED — filtreler:** Tarih Aralığı · Arama Metni · Ara · Temizle.

**OBSERVED — kolonlar:** İstek Tarihi · İstek No · **Modalite** · Adı · Müşteri · Hasta · Veteriner · **İncele**.

**OBSERVED:** Reviewed account contained a **large populated PACS history/worklist** (exact count **not** treated as product spec).

**INFERRED:** Merkezi **operational worklist / imaging history** — global create yüzeyi **gözlemlenmedi** (patient-context create — aşağıda).

---

### Modalities

**OBSERVED — Modalite values (same list surface):** at least **CR** and **US**.

**OBSERVED — anatomy/procedure-oriented `Adı` examples (generic, no PII):**

| Modalite | Örnek `Adı` kategorileri |
|---|---|
| **CR** | ABDOMEN - FVS · ARKA EXTREMITE - FVS · GOGUS - FVS · KAFATASI - FVS · ON EXTREMITE - FVS · SIRT EXTREMITE - FVS |
| **US** | ABDOMEN |

**OBSERVED:** PACS worklist can show **different imaging modalities** on one list surface.

**NOT inferred:** universal modality support · all DICOM modalities · modality-neutral backend architecture.

---

### Patient-context — Yeni Pacs İstek

**OBSERVED yol:** **Lab & Xray & Pacs → Pacs Geçmişi → `+`** → **Yeni Pacs İstek**.

**OBSERVED alanlar:** İstek Tarihi · Veteriner · **Pacs Grubu** · SmartVette İzin Ver · İstek Nedeni · Açıklama · **Kaydet**.

**OBSERVED:** Create form opens from **patient context**; global **Yeni Kayıt** **not** observed.

**NOT LIVE-VERIFIED:** **Kaydet** · save → global PACS queue appearance · viewer availability after new request · downstream acquisition lifecycle.

---

### PACS Group catalog

**OBSERVED — `Pacs Grubu` dropdown:** populated.

**OBSERVED örnek gruplar (configuration labels, no PII):**

**CR:** CR - ABDOMEN - FVS · CR - ARKA EXTREMITE - FVS · CR - GOGUS - FVS · CR - KAFATASI - FVS · CR - ON EXTREMITE - FVS · CR - SIRT EXTREMITE - FVS

**US:** US - ABDOMEN · US - CARDIOLOGY

**OBSERVED:** PACS request creation exposes a **modality/anatomy-purpose oriented** configured group catalog.

**NOT VERIFIED:** configuration admin screen · modality/device mapping · AE Title · DICOM node · worklist mapping · billing mapping.

---

### SmartVette İzin Ver

**OBSERVED** on patient PACS form (also on Lab/Xray request forms — **TBD** exact semantics / integration behavior).

---

### CR → external PACS viewer handoff

**OBSERVED (live):** Global PACS list, **Modalite = CR** row → **İncele** → E-Vet UI **separate browser tab/context** → **Fujifilm Synapse Mobility** web viewer.

**OBSERVED:** **External PACS viewer handoff**; **CR** radiographic images **displayed successfully**.

**NOT inferred / TBD:** E-Vet native image storage · E-Vet as DICOM server · API/protocol (DICOMweb/WADO/QIDO/STOW) · SSO/token · iframe embed · exact integration mechanism.

---

### Fujifilm Synapse Mobility — viewer observations

**OBSERVED — structure/navigation:** study/worklist side · modality/date filter UI · multiple image/series-like entries under a study · thumbnail/image navigator · **side-by-side multi-image** layout · radiographic images.

**OBSERVED — toolbar:** rich diagnostic imaging toolbar (navigation/pan/zoom-like · measurement/drawing-like icons · layout/view · window/level-like · series/image navigation).

**NOT VERIFIED per control:** exact annotation tools · export · download · print · share · persistable measurements/annotations (icon appearance alone **does not** imply behavior).

**Characterization:** **External viewer exposes a rich diagnostic imaging toolbar.**

---

### DICOM-style metadata (external viewer)

**OBSERVED — overlay/metadata fields (examples):** Görüntü Tipi · Erişim Numarası · Seri Numarası · Görüntü Numarası · Seri Tarihi · Modalite (**CR**) · institution/clinic text.

**Characterization:** **DICOM-style metadata visible in the external viewer** (Synapse).

**NOT inferred:** E-Vet parses/stores DICOM metadata (display may be **viewer-side**).

---

### US records — image unavailable

**OBSERVED:** Global list contains **Modalite = US** rows.

**OBSERVED (live, multiple US samples):** **İncele** → message **“Pacs Görüntüsü mevcut değil..”** (all reviewed US examples).

**Characterization:** US request/worklist **metadata was present**, but reviewed US records did **not** provide an accessible PACS image.

**NOT written as product defect:** “E-Vet cannot do ultrasound” · “Synapse lacks US” · “US integration broken” · “US not stored”.

**TBD — possible explanations (inference only, not root cause):** image never associated · historical/migrated data · unavailable/deleted study · mapping/access issue.

---

### Request metadata ≠ accessible imaging study

**OBSERVED:** US rows exist in worklist while **İncele** reports no accessible image — **PACS request/history metadata record ≠ accessible imaging study**.

**VETINITY IMPLICATION:** Where possible, separate **request/study metadata** from **image availability** in product UX (e.g. evaluate explicit feedback such as görüntü mevcut · görüntü bekleniyor · görüntü erişilemiyor — **design evaluation**, not implementation decision).

---

### Observed limitation / unresolved behavior (CLOSED scope)

Reviewed **US** PACS list entries → **“Pacs Görüntüsü mevcut değil..”** on **İncele**; **root cause unresolved** (does **not** downgrade module to PARTIAL for this pass).

---

### VETINITY IMPLICATION (PACS pass)

- Patient-context create + global populated imaging worklist + **external viewer handoff** continuity değerlendirilebilir ([ADR-007](../decisions/ADR-007-imaging-module.md) — imaging ≠ generic file; **karar değil**).
- **Image availability state** ayrı gösterim (US observation).
- **Xray** vs **PACS** ayrı modül/yüzey olarak benchmark edilmeli; kanıtları birleştirme.

**Backlog cross-ref (this pass):** [IMG-001](../backlog/feature-backlog.md#img-001--görüntüleme-kayıtları) · [IMG-005](../backlog/feature-backlog.md#img-005--dicom-desteği-araştırması) — conservative E-Vet notes added where exact semantic match.

---

### TBD / NOT OBSERVED (CLOSED ≠ all verified)

PACS Group admin/configuration · exact DICOM protocol · DICOMweb · modality worklist integration · AE Title · device acquisition · upload/import · image↔request association mechanics · CR acquisition lifecycle · US missing-image root cause · reporting/radiologist workflow · report signing · persisted annotations/measurements · export/download/print/share · image/study delete · audit · permissions · billing · patient save → global queue · SmartVette semantics.

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

## Rapor

**Review status (üst domain):** **REVIEWED / CLOSED** (2026-09-29).

| Kategori | Status |
|---|---|
| Rapor Özellikleri | **REVIEWED / CLOSED** |
| Rapor → Genel | **REVIEWED / CLOSED** |
| Rapor → Randevu | **REVIEWED / CLOSED** |
| Rapor → Resmi | **REVIEWED / CLOSED** |
| Rapor → Depo | **REVIEWED / CLOSED** |
| Rapor → Finansal | **REVIEWED / CLOSED** |
| **Rapor overall** | **REVIEWED / CLOSED** |

**CLOSED anlamı:** Mevcut **erişilebilir ekran seti ve yetki sınırları içinde** competitor review tamamlandı. **“Her raporun içeriği gözlemlendi” anlamına gelmez.** ACCESS-BLOCKED alt raporlar (bkz. [Rapor — Open / access-limited items](#rapor--open--access-limited-items)) kategori closure’ını bozmaz. E-Vet genel review **IN PROGRESS** kalır.

**Privacy:** Gerçek müşteri/hasta/GSM/kimlik/finansal toplamlar dokümana taşınmadı; yalnızca alan adı, yapı ve capability.

---

### Report navigation / inventory

**OBSERVED — üst menü `Rapor` ana kategoriler:**

- Genel *(detay — [Rapor → Genel](#rapor--genel-reviewed--closed))*
- Randevu *(detay — [Rapor → Randevu](#rapor--randevu-reviewed--closed))*
- Resmi *(detay — [Rapor → Resmi](#rapor--resmi-reviewed--closed))*
- Depo *(detay — [Rapor → Depo](#rapor--depo-reviewed--closed))*
- Finansal *(detay — [Rapor → Finansal](#rapor--finansal-reviewed--closed))*
- Rapor Özellikleri *(detay — [Rapor Özellikleri](#rapor-özellikleri))*

**OBSERVED:** Geniş rapor menü ağacı; çok sayıda hazır (predefined) rapor. Custom report builder **gözlemlenmedi**.

**OBSERVED — Rapor > Genel (menü envanteri):**

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
- Hareket Olmayan Ürünler *(ACCESS-BLOCKED / NOT OBSERVED)*
- Stok Analiz *(ACCESS-BLOCKED / NOT OBSERVED)*
- ABC Analizi (Ürün Bazlı) – Pareto Prensibi *(ACCESS-BLOCKED / NOT OBSERVED)*
- ABC Analizi (Ürün Tipi Bazlı) – Pareto Prensibi *(ACCESS-BLOCKED / NOT OBSERVED)*

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

*(Menü görünürlüğü içerik incelemesi anlamına gelmez; ekran bazlı durum aşağıdaki kategori bölümlerinde.)*

---

### Shared report presentation shell

**OBSERVED (Genel pass — tekrarlayan UI):**

- Sol: rapora özel filtreler
- Sağ: document/report **preview**
- Üst sağ: **Pdf** dropdown · download/cloud-like action · **Yazdır...**

**Characterization:** **Shared report presentation shell** — filter → preview → export/download/print.

**OBSERVED (Rapor genel):** Kategorize **predefined report catalog** (üst menü); bazı raporlar tablo, bazıları chart, bazıları tablo + chart; bazı raporlarda sayfalama; filtre seti rapora göre değişiyor.

**NOT inferred:** Tek generic report engine / backend architecture (shell aynı görünse de).

---

### Rapor Özellikleri

**Review status:** **REVIEWED / CLOSED** (2026-09-29).

**OBSERVED — ekran:** **Rapor Özellik Listesi**.

**OBSERVED (reviewed account):** ~92 report property definition; tablo kolonları en az **İşlemler** · **Adı**; satır aksiyonu **İşlemler → Düzenle**.

**OBSERVED — örnek düzenleme (`Alış Faturası`):** **Rapor Özellik Tanımı** alanları — Yukarıdan/Alttan/Sağdan/Soldan Ayırma · **Satır Sayısı** · **Antetli Kağıt Yolu** · Dosya Seç · **Kaydet**.

**Characterization:** İncelenen Rapor Özellikleri ekranında custom report builder gözlemlenmedi; rapor bazında **output/layout/print template** (margins, satır sayısı, antetli kağıt asset) ayarları.

**NOT OBSERVED:** custom SQL/query builder · kolon seçme builder · formula builder · chart designer · dynamic report creation · per-report permissions UI · filter schema editor.

**TBD:** URL’de report-specific code parametresi (backend semantics **iddia edilmez**).

---

### Rapor → Genel (REVIEWED / CLOSED)

**Review status:** **REVIEWED / CLOSED** (2026-09-29). **15/16** rapor içerik olarak incelendi; **Laboratuvar Test Sayısı Raporu** **ACCESS-BLOCKED** (aşağıda).

| # | Rapor | Status |
|---|---|---|
| 1 | Müşteri Listesi | **REVIEWED** |
| 2 | Hasta Listesi | **REVIEWED** |
| 3 | İstatistik | **REVIEWED** |
| 4 | Hasta Veri İstatistiği | **REVIEWED** |
| 5 | Sahiplenme Listesi | **REVIEWED** |
| 6 | Çiftleştirilecek Hastalar | **REVIEWED** |
| 7 | Takipteki Hastalar | **REVIEWED** |
| 8 | Hospitalizasyon Listesi | **REVIEWED** |
| 9 | Ziyaret Geçmişi | **REVIEWED** |
| 10 | Ziyarete Gelmeyen Müşteriler | **REVIEWED** |
| 11 | Z. Gelmeyen Müşteri Detaylı | **REVIEWED** |
| 12 | Test Sonuç Karşılaştır | **REVIEWED** |
| 13 | Anket Sonuçları | **REVIEWED** |
| 14 | Bugün Uygulanacak Tedaviler | **REVIEWED** |
| 15 | En Yoğun Dönemler | **REVIEWED** |
| 16 | Laboratuvar Test Sayısı Raporu | **ACCESS-BLOCKED / NOT OBSERVED** |

#### Müşteri Listesi

**OBSERVED filters:** Müşteri Grubu · Durum (default **Aktif**) · Ülke · Şehir · İlçe · Köy - Mahalle (geniş ülke kataloğu).

**OBSERVED columns (en az):** Müşteri · Kayıt · Grup · Kimlik No · Gsm · Email · İlçe · Köy/Mah. · Borç · Ödeme.

**OBSERVED:** Bazı filtre kombinasyonları **0** sonuç. **NOT OBSERVED:** drill-down.

#### Hasta Listesi

**OBSERVED filters:** Müşteri · Hasta Türü · Irk · Hasta Grubu · Yaş Aralığı Min/Max.

**OBSERVED layout:** Müşteri-level header/row + altında hasta detail.

**OBSERVED patient columns (en az):** Hasta Adı · Protokol · Tür · Hasta Irkı · Cinsiyet · Doğum Tarihi · Kayıt Tarihi.

**OBSERVED summary:** Filtrelenen Hasta Sayısı · Toplam Hasta Sayısı. *(Gerçek isim/protokol dokümana taşınmadı.)*

#### İstatistik

**OBSERVED filter:** Tarih Aralığı.

**OBSERVED:** Summary **KPI document** (tablo/list değil) — gruplar **Müşteri** / **Hasta** / **Genel** (Yeni/Toplam/Yeni Oranı %, Ortalama Ziyaret Sayısı/Tutarı, Ortalama Uygulanan Aşı Sayısı; Genel: Uygulanan Aşı, Toplam Aşı, Uygulanan Aşı Oranı %). **NOT OBSERVED:** chart/dashboard/drill-down. *(Klinik KPI sayıları dokümana taşınmadı.)*

#### Hasta Veri İstatistiği

**NOT OBSERVED:** görünür filtre.

**OBSERVED overview:** Aktif · Pasif + Ölü · Toplam.

**OBSERVED distributions:** Tür/Cinsiyet/Irk bazında Aktif/Pasif — pie charts + % labels; ırk listesi geniş kategori/count formatında da.

**Characterization:** **Patient population segmentation/distribution analytics**.

#### Sahiplenme Listesi

**OBSERVED filters:** Hasta Türü · Irk · Cinsiyet (Dişi/Erkek/Kısır/Kısırlaştırılmış…/Bilinmiyor).

**OBSERVED dependency:** Tür seçilmeden Irk **Kayıt bulunamadı**; Köpek seçilince köpek ırkları — **tür→ırk dependent filter**.

**OBSERVED output title:** `SAHİPLENDİRİLMEK İSTENEN HASTA LİSTESİ`. Columns: Sahip · Gsm · Hasta · Tür · Irk · Cinsiyet · Doğum Tarihi. Pagination.

**OBSERVED — report failure (filter scenario):** Hasta Türü = Köpek · Irk = Golden Retriever → UI’da ham teknik mesaj: `The conversion of the varchar value '1024371' overflowed an INT2 column. Use a larger integer column.` → report generation **failed**; internal/database-style error **end user’a exposed**.

**OBSERVED — recovery:** Irk kaldırılıp yalnız Köpek → report **başarılı**.

**NOT inferred:** Schema/table root cause · “report tamamen bozuk”.

**VETINITY IMPLICATION:** Unexpected report errors → user-safe feedback + server-side logging; raw DB exception text **surface edilmemeli**.

#### Çiftleştirilecek Hastalar

**OBSERVED filters:** Hasta Türü · Irk · Cinsiyet. Title: `ÇİFTLEŞTİRİLMEK İSTENEN HASTA LİSTESİ`. Aynı column family; **Toplam Kayıt Sayısı**. İncelenen kombinasyon **0** sonuç. **NOT OBSERVED:** mating flag/workflow source.

#### Takipteki Hastalar

**OBSERVED filters:** Hasta Türü · Irk · Cinsiyet. Title: `TAKİPTEKİ HASTA LİSTESİ`. Columns aynı family; **Toplam Kayıt Sayısı**. İncelenen örnek **0** sonuç. **NOT OBSERVED:** “Takipte” state nasıl set edilir.

#### Hospitalizasyon Listesi

**OBSERVED filters:** Tarih Aralığı · Durum (**required**) · Müşteri · Hasta. Boş Durum → `Bu alanın doldurulması zorunludur.`

**OBSERVED Durum:** Yatan Hasta · Taburcu.

**OBSERVED columns (en az):** Sahip Adı · Hasta Adı · Bölüm · Oda · Yatış Tar. · Taburcu Tar. · Yatış Bilgisi · Hosp. Gün · Veteriner. Rows species/category altında grouped; duration text örn. `x gündür bekliyor` benzeri.

**Cross-ref:** [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül) ile complementary (Yatan/Taburcu semantics).

#### Ziyaret Geçmişi

**OBSERVED filters:** Tarih Aralığı · Veteriner · Müşteri · Hasta.

**OBSERVED:** `ZİYARET GEÇMİŞİ RAPORU` — header (Hasta Sahibi, Hasta Adı, Veteriner, Tarih) + line items (Ürün, Miat, Birim, Fiyat, Miktar, Toplam, satır/genel indirim, Net, Kdv%, KDV, Genel) + financial summary (KDV’siz Toplam, iskonto toplamları, KDV, Toplam Tutar) + ödeme (Ödeme Tipi, Miktar, Ödenen, Kalan).

**Characterization:** Visit context + billable lines + payment summary (accounting architecture **iddia edilmez**).

#### Ziyarete Gelmeyen Müşteriler

**OBSERVED filters:** Gün · Bakiye >=. Title: `ZİYARETE GELMEYEN MÜŞTERİLER VE SON ZİYARET BİLGİSİ`. Large paginated result (ör. Gün=5). Columns en az: Tarih · Kayıt Tarihi · Müşteri · Gün · Bakiye · Hasta · Toplam · İskonto · indirim alanları + yatay devam.

**Characterization:** Lapsed/inactive client by days since last visit, optional balance floor.

#### Z. Gelmeyen Müşteri Detaylı

**OBSERVED filters:** Gün · Bakiye >=. Title: `ZİYARETE GELMEYEN MÜŞTERİ LİSTESİ VE SON ZİYARET BİLGİSİ`. Per-customer blocks (Gün, Tarih, Müşteri, Bakiye, Hasta, Ziyareti Giren Kişi, financial summary, visit description).

**OBSERVED vs önceki rapor:** önceki = tabular summary; bu = **detailed per-customer presentation**.

#### Test Sonuç Karşılaştır

**OBSERVED filters:** Müşteri · Hasta · Tarih Aralığı · Test Grubu · Test — **required validation** (Müşteri sonrası boş alanlar için Hasta/Test Grubu/Test uyarıları).

**OBSERVED:** Müşteri → hasta → test grubu → analyte seçimi; output `TEST SONUÇLARI KARŞILAŞTIRMA` + **chart**.

**OBSERVED:** Longitudinal comparison **surface** exists.

**NOT VERIFIED:** Seçilen aralıkta görünür multi-date trend noktaları · reference-range overlay · abnormal flags · cross-test semantics (incelenen sorguda chart’ta belirgin data point **gözlemlenmedi**).

#### Anket Sonuçları

**NOT OBSERVED:** filtre. Title: `Anket Sonuçları`. Hierarchy: survey → section → questions; her soruda Şık · Sayı · Oran(%) · Cevap aggregates.

**Characterization:** Aggregate survey results reporting (survey creation workflow **not inferred**).

#### Bugün Uygulanacak Tedaviler

**NOT OBSERVED:** filtre. Title: `Bugün Uygulanacak Tedaviler`. Sections: Müşteri · Hasta · Açıklama · Ürün · Miktar · Birim · Toplam. İncelenen anda satır **gözlemlenmedi**.

**Characterization:** Daily operational treatments report — full treatment-plan lifecycle **not inferred**.

#### En Yoğun Dönemler

**OBSERVED filters:** Tarih Aralığı · İşlem Tipi · Veteriner · Personel.

**OBSERVED metrics (en az):** **Ziyaret/Satış**, **Tamamlanan Randevu**, **Muayene** — each: Toplam · Ortalama · En Yoğun · En Sakin.

**OBSERVED visualization:** Aylık **multi-series bar chart** (değerler ay bazında; klinik-specific sayılar dokümana taşınmadı).

**Characterization:** Period-based **operational workload/activity analytics**.

#### Laboratuvar Test Sayısı Raporu

**Status:** **ACCESS-BLOCKED / NOT OBSERVED**.

**OBSERVED:** Menüde görünür; navigasyon sonrası **403 – Erişim reddedildi!** / `Bu sayfaya erişim yetkiniz bulunmamaktadır.`

**OBSERVED:** Page/report-level **access enforcement**; reviewed account **yetkisiz**.

**NOT inferred:** Role model · permission schema · hangi rol verir.

**UX observation (bug iddiası değil):** Menü görünür kalıyor; tıklayınca 403 — discoverability/permission UX adayı.

**NOT OBSERVED:** filters · columns · metrics (içerik erişilemedi).

---

### Rapor → Randevu (REVIEWED / CLOSED)

**Review status:** **REVIEWED / CLOSED** (2026-09-29). Menü: Yapılacak İşler · Yapılacak Aşı Çizelgesi · Yapılan Aşı Çizelgesi (rapor başlıkları menü adından farklı görünebilir: “Ay Bazında … Aşı Randevu Çizelgesi”).

#### Yapılacak İşler

**OBSERVED filters:** Tarih Aralığı · Görev Tipi · Veteriner · coğrafi filtreler (Ülke/Şehir/İlçe vb.).

**OBSERVED:** Görevler personel/veteriner ve **görev türüne göre gruplanabiliyor**; aşılama ve kontrol muayenesi gibi iş türleri görülebiliyor.

#### Ay Bazında Yapılacak Aşı Randevu Çizelgesi

**OBSERVED:** Tarih Aralığı filtresi · satırlarda **aşı paketleri** · sütunlarda **ayın günleri** · hücrelerde yapılacak randevu/adet dağılımı (**matrix**).

#### Ay Bazında Yapılan Aşı Randevu Çizelgesi

**OBSERVED:** Aynı **matrix** yaklaşımı; tamamlanan/yapılan aşı randevuları.

**Characterization:** Operational **planning/reporting** evidence.

**NOT inferred:** Takvim task engine ile aynı domain modeli · scheduled vaccine lifecycle · yeni capability/ID gerekliliği.

---

### Rapor → Resmi (REVIEWED / CLOSED)

**Review status:** **REVIEWED / CLOSED** (2026-09-29). Çoğu rapor **tarih aralığı** ile filtrelenen, **resmi kayıt defteri benzeri / kayıt defteri formatında sunulan print-oriented** çıktı (mevzuatla ilişkili görünebilecek alan/format gözlemi; hukuki geçerlilik veya zorunluluk iddiası yok).

| Rapor | OBSERVED alan/yapı (örnek) |
|---|---|
| **Muayene Kayıt Defteri** | muayene tarihi · hasta sahibi bilgileri · hasta bilgileri · şikayet · teşhis vb. klinik kayıt alanları (tablo) |
| **Aşı Kayıt Defteri** | ticari ad · seri no · son kullanma tarihi · miktar · satın alınan firma · nakil/soğuk zincir ile ilgili kolonlar |
| **İlaç Kayıt Defteri** | ürün · farmakolojik şekil · takdim şekli · adet/birim/firma |
| **Reçete Kayıt Defteri** | reçete bilgileri · veteriner · hayvan sahibi · hayvan bilgileri |
| **Narkotik ve Psikotropik Ürünler Stok ve Sarf Defteri** | stok ve sarf hareketlerini resmi kayıt formatında sunan kolon yapısı |
| **Aşı Bilgi** | tarih · hasta/hasta sahibi · tür · çip no · ürün · seri no · SKT · miktar/fiyat/toplam |

**TBD:** Official veterinary record/report requirements require **independent Turkey regulatory validation**. Bu ekranlar hukuki/mevzuat kapsamı **kanıtı değildir**.

---

### Rapor → Depo (REVIEWED / CLOSED)

**Review status:** **REVIEWED / CLOSED** (2026-09-29) — erişilebilir raporlar; 4 rapor **ACCESS-BLOCKED** (kullanıcı-doğrulamalı erişim engeli; ayrı 403 ekranı gözlemlenmedi — aşağıda + [access-limited list](#rapor--open--access-limited-items)).

| Rapor | Status | OBSERVED yapı |
|---|---|---|
| **Depo Stok Durumu** | REVIEWED | Filtre: Depo · Ürün Tipi · Ürün Grubu · Alt Grubu · Ürün; birden fazla depo. Kolonlar: depo · ürün tipi · ürün · barkod · seri no · SKT · toplam stok · birim · ortalama birim alış maliyeti · alış KDV · toplam alış stok tutarı · birim satış · toplam satış tutarı · **muhtemel kâr**; alt bölümde aggregate totals |
| **Ürün Alışı** | REVIEWED | tarih · firma · ürün · seri no · SKT · miktar · fiyat · KDV · indirim; ürün/depo/kategori filtreleri |
| **MS Altına Düşen Ürünler** | REVIEWED | minimum stok altındaki ürünler; depo bazlı stok görünümü |
| **SKT Geçen Ürünler** | REVIEWED | depo · ürün · miktar · SKT · geçen gün benzeri süre alanı |
| **SKT Yaklaşan Ürünler** | REVIEWED | kullanıcı **gün eşiği** girer; SKT + kalan gün; birden fazla depo |
| **Ürün Hareketleri** | REVIEWED | Filtre: tarih · ürün · barkod · satıcı firma · işlem tipi. Alanlar: işlem tarihi · işlem tipi · müşteri · depo · ürün · miat · stok kontrol · birim |
| **Ürün Listesi** | REVIEWED | Filtre: ürün tipi · grup · alt grup · durum; barkod · alış/satış KDV/fiyat/durum (product master alanları raporlanıyor) |
| **Aktif Stok** | REVIEWED | Geçmiş **işlem tarihi** seçilebilir · depo · ürün tipi filtreleri; **belirli tarihteki aktif stok snapshot benzeri** rapor yüzeyi |
| **Gelecek Aşılar** | REVIEWED | Tarih aralığı · toplam aşı · yetersiz stok özeti · aşı paketi bazında mevcut stok / yapılacak / kalan stok karşılaştırması |
| Hareket Olmayan Ürünler | **ACCESS-BLOCKED / NOT OBSERVED** | — |
| Stok Analiz | **ACCESS-BLOCKED / NOT OBSERVED** | — |
| ABC Analizi (Ürün Bazlı) | **ACCESS-BLOCKED / NOT OBSERVED** | — |
| ABC Analizi (Ürün Tipi Bazlı) | **ACCESS-BLOCKED / NOT OBSERVED** | — |

**NOT inferred:** “Muhtemel kâr” accounting-grade realized profit · Aktif Stok backend historical snapshot implementation · Gelecek Aşılar için otomatik replenishment/sipariş önerisi (**gözlemlenmedi**) · ACCESS-BLOCKED raporların içeriği.

---

### Rapor → Finansal (REVIEWED / CLOSED)

**Review status:** **REVIEWED / CLOSED** (2026-09-29). Alt gruplar: Bakiye · Kasa · Satış · Gelir - Gider (+ Günlük İşlem Dökümü). Gerçek tutar/isim/ciro/tahsilat değerleri dokümana **taşınmadı**.

#### A. Receivables / balances

- **Bakiyesi Olan Müşteriler:** filtre — tarih aralığı · müşteri grubu · iletişim tipi · ülke/şehir/ilçe vb.; alanlar — müşteri · son ziyaret · borç · ödeme · bakiye.
- **Bakiye İndirimi:** tarih · müşteri · iletişim bilgileri · indirim · bakiye.
- **Yaşlandırma:** müşteri seçimi · borç/ödeme/bakiye özeti · geçmiş faturalar ve kalan tutarlar (invoice/balance history yapısı). **NOT inferred:** klasik aging bucket (30/60/90) yapısı.
- **Bakiyesi Olan Firmalar:** satıcı firma filtresi ekranı gözlemlendi; **incelenen hesapta firma seçeneği/data bulunmadı** (boşluk ≠ capability yok).

#### B. Cash / bank reporting

- **Günlük Kasa:** gün içi hareketler · açıklama · işlem tipi · nakit / kredi kartı / banka transferi · ödeme toplamı.
- **Tarihler Arası Kasa:** başlangıç/bitiş tarih-zaman · kullanıcı · devreden bakiye · açık hesap filtreleri · devir/giriş vb. hareket grupları · nakit/kredi kartı/banka transferi/ödeme/açık hesap kolonları.
- **Tarihler Arası Kasa Son 3 Gün:** benzer kasa hareket raporu; daha kısa tarih penceresi preset/use-case.
- **Kasa ve Banka Hareketleri:** tarih aralığı · kasa · banka hesabı · devreden bakiye · hesap bazında giriş/çıkış/durum hareketleri.

**NOT inferred:** Accounting ledger architecture.

#### C. Sales

- **Ürün Satışı:** tarih aralığı · ürün tipi/grubu/alt grubu/ürün · veteriner vb. filtreler · depo/ürün bazlı aggregate sales output.
- **Ürün Satışı (Detaylı):** işlem tarihi · depo · ürün tipi/grubu · ürün · müşteri/hasta ilişkisi · miktar · tutar · indirim; yüksek hacimli **paginated** detay.
- **Ürün Tipi Bazında Satış:** payment summary (nakit · kredi kartı · havale · toplam) · satış/tahsilat/kalan tahsilat özetleri · ürün tipi bazında **bar chart** + **percentage pie chart** (product-type composition).
- **Kullanıcı Bazında Satış (Veteriner):** satış toplamı · ödeme toplamı · veteriner bazlı karşılaştırmalı chart; ekranda raporun yalnızca **doğrudan satış ve ziyaret** tutarları/ödemelerini kapsadığına dair açıklama var. **NOT inferred:** genel personel productivity score.
- **Ürün Tipi Bazında Aylık Satış:** ürün tipleri satır · aylar sütun (**monthly matrix**).
- **Aylık Satış:** tarih aralığı · ay bazlı **bar chart**.

#### D. Cost / profitability

- **Ürün Tipi Bazında Kâr:** ürün · miktar · birim maliyet · maliyet · satış tutarı · kâr tutarı · kâr oranı.
- **OBSERVED data-quality note:** Bazı satırlarda maliyet 0 iken kâr tutarı satış tutarına eşit görünebiliyor (competitor report calculation/data-quality evidence). **NOT inferred:** backend formül implementasyonu veya muhasebesel doğruluk.
- **Ortalama Maliyet:** depo · ürün tipi · ürün · birim · toplam miktar · ortalama net birim fiyat · net toplam benzeri maliyet alanları.

#### E. Collection / revenue

- **Yıllık Tahsilat:** nakit · kredi kartı · havale · iade · toplam ciro summary · aylık chart.
- **Aylık Tahsilat:** aynı payment-channel summary · daha dar tarih aralığında günlük/periyodik chart.

#### F. Expense / income-expense

- **Gider:** tarih aralığı · klinik gider grubu · klinik gider tipi · tarih/açıklama/ödeme tipi/tutar · toplam / grup toplam / genel toplam.
- **Gider Türü Dağılım Raporu:** gider grubu/tipi filtreleri · **chart yüzeyi**; incelenen sorguda görünür data olmayabilir (chart capability ≠ data availability).
- **Yıllık Gelir - Gider:** aylık gelir · gider · kazanç tablosu · aggregate genel toplam · chart alanı.

**NOT inferred:** Sistemin gider takibi yapmadığı (incelenen ekranda giderlerin sıfır olması competitor **data state**).

#### G. Daily transaction audit

- **Günlük İşlem Dökümü:** belirli işlem tarihi · müşteri satış dökümü · müşteri · hasta/direct sale · satış kalemleri · tutar · ödeme · bakiye. **Characterization:** Operational audit / day-closing review evidence.

---

### Rapor — Cross-category synthesis

**Product characterization (Rapor genel):** Kategorize **predefined report catalog**; ortak **filter → print-oriented preview → Pdf/download-like/Yazdır** shell; çoğu rapor document/print-oriented, bazıları chart veya calculated analytics. Aile örnekleri: **operational** (Randevu, Genel listeleri) · **official/record-book** (Resmi) · **inventory** (Depo: expiry, low-stock, movement, purchase, active-stock, future-vaccine demand) · **financial** (receivables, cash/bank, sales, cost/profit, collections, income-expense, daily audit).

**Genel sınıflandırma (detay):**

E-Vet **Genel** raporları en az şu sınıfları gösterir: (1) master/entity lists — Müşteri/Hasta; (2) KPI statistics — İstatistik; (3) population segmentation — Hasta Veri İstatistiği; (4) operational patient lists — Sahiplenme/Çiftleştirme/Takipte/Hospitalizasyon; (5) clinical+commercial detail — Ziyaret Geçmişi; (6) lapsed-client — Ziyarete Gelmeyen (+ detaylı); (7) longitudinal lab chart — Test Sonuç Karşılaştır; (8) survey aggregates — Anket; (9) daily ops — Bugün Uygulanacak Tedaviler; (10) workload analytics — En Yoğun Dönemler; (11) restricted — Lab Test Count **403** in reviewed account.

**OBSERVED tendency:** Çoğu rapor **document/print-oriented** preview; bazıları chart/calculated analytics içerir. Interactive dashboard-first **dominant değil**.

---

### VETINITY IMPLICATION (Rapor — tüm kategoriler)

*(Değerlendirme adayları; mimari/requirement kararı değil — dashboard, custom builder, Excel requirement üretilmez.)*

- **Operational reports** ile **management analytics** birbirinden ayrılabilir; predefined catalog küçük/orta klinikler için güçlü olabilir ([ADR-003](../decisions/ADR-003-report-center.md) bağlam).
- Rapor filtreleri **domain-aware** olmalı (tür→ırk, Durum zorunlu, depo/ürün grubu vb.); ortak shell ([REPORT-005](../backlog/feature-backlog.md#report-005--ortak-rapor-filtre-çubuğu)) ile uyum değerlendirilebilir.
- **Report errors:** raw backend/DB exception → user-safe message + server-side logging (Sahiplenme Listesi senaryosu).
- **Permission UX:** report permissions navigation ile tutarlı olmalı; menüde görünüp 403 dönen raporlar (erişim kontrolü çalışıyor) vs gizleme/disable + açıklama değerlendirilebilir ([REPORT-006](../backlog/feature-backlog.md#report-006--claim-bazlı-rapor-görünürlüğü)).
- **Print/PDF** çıktıları veteriner iş akışları için değerli ([REPORT-007](../backlog/feature-backlog.md#report-007--excelpdf-dışa-aktarma-politikası) bağlam).
- **Inventory reporting** yalnız stock-on-hand değil: expiry, low-stock, movement, purchase, active-stock, future-demand gibi operasyonel sorulara da cevap veriyor.
- **Financial reporting** ayrı karar sorularına cevap veriyor: receivables, collection channels, cash/bank movements, sales, cost/profit, expenses.
- **Longitudinal clinical comparison** (Test Sonuç Karşılaştır) değeri mevcut Vetinity scope/backlog kontrol edilmeden feature’a çevrilmemeli.

---

### Rapor — Open / access-limited items

**ACCESS-BLOCKED / NOT OBSERVED** (içerik hakkında varsayım yok; kategori closure’ını bozmaz):

| Rapor | Kategori | Status |
|---|---|---|
| Laboratuvar Test Sayısı Raporu | Genel | **ACCESS-BLOCKED / NOT OBSERVED** (menüde görünür; **403**) |
| Hareket Olmayan Ürünler | Depo | **ACCESS-BLOCKED / NOT OBSERVED** |
| Stok Analiz | Depo | **ACCESS-BLOCKED / NOT OBSERVED** |
| ABC Analizi (Ürün Bazlı) | Depo | **ACCESS-BLOCKED / NOT OBSERVED** |
| ABC Analizi (Ürün Tipi Bazlı) | Depo | **ACCESS-BLOCKED / NOT OBSERVED** |

*(403 = page/report-level erişim kontrolü gözlemi; role/claim/report-based model **iddia edilmez**.)*

**Evidence düzeyi ayrımı:**

- **Laboratuvar Test Sayısı Raporu:** 403 ekranı **doğrudan OBSERVED**.
- **Depo’daki dört rapor** (Hareket Olmayan Ürünler · Stok Analiz · ABC Analizi Ürün Bazlı · ABC Analizi Ürün Tipi Bazlı): kullanıcı canlı sistemde erişim/yetki engeli olduğunu **doğruladı**; bu dört rapor için ayrı 403 ekranı **gözlemlendi/capture edildi iddiası yoktur**.

**Empty-data observations (capability yok değil):** Bakiyesi Olan Firmalar (firma verisi yok) · Gider Türü Dağılım chart (görünür data yok) · Test Sonuç Karşılaştır chart (görünür trend noktası yok) · Bugün Uygulanacak Tedaviler (satır yok) · Çiftleştirilecek/Takipteki Hastalar (0 sonuç).

---

### TBD / NOT OBSERVED (Rapor — kapanış sonrası)

Exact export format list (PDF dışı) · cloud/download icon semantics · Excel/CSV support not observed · scheduled/emailed reports · saved filter presets · custom SQL/query/formula builder / drag-drop designer (**gözlemlenmedi**) · report-level column configuration · role/permission model ve admin UI · row drill-down · chart tooltips/drill-down · caching/refresh timing · multi-clinic aggregation · dashboard home · survey creation workflow · treatment source workflow · Turkey regulatory validation of Resmi reports · ACCESS-BLOCKED rapor içerikleri.

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

*(Ekran bazlı inceleme ve status → [Stok (modül)](#stok-modül).)*

---

## Stok (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-30).

**CLOSED anlamı:** Erişilebilir ekranlar ve güvenli/read-only etkileşimler kapsamında tamamlandı; destructive actions veya gerçek kayıt oluşturma/tamamlama gerektiren side-effect davranışları NOT OBSERVED olarak bırakıldı.

**Kanıt notu:** Bu bölüm canlı UI gözlemidir; backend entity/table/architecture çıkarımı yoktur. Benzer ekranlar (ör. Alış/İade/Sipariş Faturası formları, Rapor > Depo raporları) shared backend kanıtı değildir. Gerçek müşteri/satıcı/ticari değerler dokümana taşınmadı.

### Ekran durumu

| Alt ekran | Reviewed clinic/account durumu | Gözlem düzeyi |
|---|---|---|
| Alış Faturası | Liste **empty in reviewed clinic/account** | Liste + Yeni form + **AI ile içeri aktar** modalı |
| İade Faturası | **Empty in reviewed clinic/account** | Liste + form |
| Sipariş Faturası | **Empty in reviewed clinic/account** | Liste + form |
| Stok Giriş | Çok sayıda kayıt | Liste + Yeni + İncele + Düzenle (save doğrulanmadı) |
| Stok Çıkış | Kayıt var | İncele + Yazdır (mevcut kayıt üzerinde) |
| Sayım | **Empty in reviewed clinic/account** | Liste + Yeni form |
| Stok Sıfırlama | Filtre sonrası satırlar | Filtre + grid + satır seçimi; **Sıfırla basılmadı** |
| Stok Transferi | Kayıt var (İşleniyor) | Liste + Yeni + mevcut kayıt Düzenle |
| Depo Stok Durumu | Çok sayıda satır | On-hand stock view (arama + yazdır gözlendi) |
| Satıcı Firmaya Ödeme | **Empty in reviewed clinic/account** | Liste + Yeni form |
| Satıcı Firmalar | **Empty in reviewed clinic/account** | Liste + Satıcı Firma Tanımı |
| Depolar | Birden fazla depo (Aktif + Pasif) | Liste + Depo Tanımı |

### Alış Faturası

**OBSERVED — liste (empty in reviewed clinic/account):** Tarih Aralığı · Arama Metni · Ara · Temizle · **Faturayı AI ile İçeri Aktar** · Yeni Kayıt. Kolonlar: İşlemler · İşlem Tarihi · Satıcı Firma · Oluşturan · Bakiye · Fatura · Teslim Tarihi · Genel Toplam · Ödeme Toplamı.

**OBSERVED — Yeni Alış Faturası:** İşlem Tarihi · Satıcı Firma · Fatura No · **Stok Hareketini Engelle** (Evet/Hayır) · *Açıklama & Tarihler* accordion (Teslim Tarihi · Vade Tarihi · Depo Çıkış Tarihi · Açıklama) · Barkod/QR tarama · Depo · KDV Dahil · ürün satırları (Faktör/Çarpan & Miktar · Fiyat · KDV · İskonto · Toplam) · Genel İndirim · Net Toplam · KDV Top. · Genel Toplam · Kaydet · Kaydet / Öde. Miat kontrollü üründe satır Miat alanı ([öncül not](#destekleyici-inceleme--stok-giriş--alış-faturası--depo-stok-durumu-öncül-destek-notu)).

**OBSERVED — Faturayı AI ile İçeri Aktar (modal; UI metni):** Modal metnine göre XML, PDF, JPG ve PNG formatları destekleniyor; UI, yapay zekânın belgeyi analiz edip fatura bilgilerini otomatik içeri aktardığını ifade ediyor. Alanlar: Dosya Seç · Satıcı Firma · Depo · **İçe Aktar ve Eşleştir**.

**NOT VERIFIED (live):** Gerçek dosya yükleme, analiz, alan eşleştirme, validation ve başarılı import/save sonucu live olarak doğrulanmadı. Ayrıca: AI import doğruluğu · mapping kuralları · duplicate handling · accounting/stock posting · model/provider/OCR pipeline (UI açıklamasının ötesinde çıkarım yok).

**Stok Hareketini Engelle:** `Stok Hareketini Engelle` = Evet/Hayır alanı OBSERVED; seçimin stok miktarı/hareket oluşturma üzerindeki gerçek etkisi NOT VERIFIED.

### İade Faturası

**OBSERVED:** Liste (**empty in reviewed clinic/account**; kolonlar İşlemler · İşlem Tarihi · Satıcı Firma · Bakiye · Fatura No · Teslim Tarihi · Genel Toplam · Ödeme Toplamı). Form Alış Faturası ile **çok benzer shell**: İşlem Tarihi · Satıcı Firma · Fatura No · Stok Hareketini Engelle · Açıklama & Tarihler · Barkod · Depo · KDV Dahil · satırlar (Faktör/Çarpan & Miktar · Fiyat · KDV · **Stok** kolonu · İskonto · Toplam) · Genel İndirim · totals · Kaydet · Kaydet / Öde.

**INFERRED (isim + form):** Purchase return / vendor credit / stock decrease niyeti. **NOT VERIFIED:** gerçek save ile stok azalması · accounting credit-note davranışı.

### Sipariş Faturası

**OBSERVED:** Liste (**empty in reviewed clinic/account**) kolonları İşlemler · İşlem Tarihi · İşlem No · Satıcı Firma · Açıklama. Form: purchase-benzeri alanlar · **Geçmiş Satın Alımlar** · totals · Kaydet (alan bazında ayrıntı doğrulanmadı).

**NOT VERIFIED:** Purchase order / proforma / draft invoice / procurement order semantiği (menü adı olduğu gibi kaydedildi) · stok hareketi yaptığı · supplier order lifecycle · siparişe karşı teslim alma · alış faturasına dönüşüm.

### Stok Giriş

**OBSERVED — liste:** Tarih Aralığı · Arama Metni · Ara · Temizle · Yeni Kayıt; kolonlar İşlemler · İşlem Tarihi · İşlem No · Açıklama. **İşlemler:** İncele · Düzenle · Yazdır · Sil.

**OBSERVED — Yeni Stok Giriş:** İşlem Tarihi · İşlem No · Açıklama · Barkod · Depo · ürün satırı (Faktör/Çarpan & Miktar · Birim) · Ekle · Kaydet · Kaydet / Yeni.

**OBSERVED — İncele (mevcut kayıt; `Stok Giriş - İncele` modalı):** İşlem Tarihi · İşlem No · Açıklama · Ürün · Depo · Faktör & Çarpan · Miktar · Birim · **Ortalama Maliyet (KDV hariç)** · **Seri No** · **Miat** · Açıklama.

**OBSERVED — Düzenle (mevcut kayıt):** Ürün + depo aynı seçim metninde; miktar/faktör · birim; miat izlenen üründe **Miat** alanı görünür (mevcut miatlı ürün düzenlenebilir formda açıldı). Ortalama Maliyet ve Seri No bu bağlamda ayrıca gözlemlenmedi (yalnızca İncele modalında görüldü); düzenleme sonrası save doğrulanmadı.

**Bağlam (öncül gözlemlerle tutarlı):** Ürün tanımında Miat Kontrolü Evet/Hayır; miat izlenen ürünlerde purchase-side/stok ekranlarında Miat alanı ([Ürün Tanımı](#destekleyici-inceleme--ürün-tanımı-partial-modül-closed-değil)). Bu turda lot/batch alanı doğrulanmadı; **Seri No ≠ lot/batch**; FEFO/FIFO enforcement iddiası yok.

### Stok Çıkış

**OBSERVED:** Mevcut kayıtlar; **İşlemler:** İncele · Yazdır. **İncele (`Stok Çıkış - İncele`):** İşlem Tarihi · İşlem No · Açıklama · Ürün · Depo · **Çıkış Miktarı** · Birim · Seri No · Miat. Mevcut bir stok çıkış kaydında `Depolar Arası Stok Transferi` açıklaması gözlemlendi; bu kayıt transferle ilişkili olabilir, ancak transfer lifecycle / otomatik movement üretimi **doğrulanmadı**.

**NOT VERIFIED:** Bağımsız Yeni Kayıt · Düzenle · Sil aksiyonları (doğrulanmadı) · backend transaction ilişkisi / atomicity / ledger.

### Sayım

**OBSERVED — liste (empty in reviewed clinic/account):** **İç / Dışa Aktar** · Yeni Kayıt; kolonlar İşlemler · İşlem Tarihi · İşlem No · Açıklama · **Durum**.

**OBSERVED — Yeni Sayım:** İşlem Tarihi · Durum (**İşleniyor** · **Tamamlandı**) · İşlem No · Açıklama · Barkod · Depo · ürün · **Miktar | Stok** · Birim · Ekle · Kaydet · Kaydet / Yeni.

**NOT OBSERVED:** Mevcut sayım kaydı yoktu → fiziksel sayım vs sistem stoku karşılaştırma sonucu · fark hesabı · **Tamamlandı** sonrası stok düzeltmesi · onay/kilit · varyans posting · İç/Dışa Aktar dosya formatı/şema/yön/validation.

### Stok Sıfırlama

**OBSERVED:** Filtre — Depo · Ürün Tipi · Ürün Grubu · Ara · Temizle. Grid — satır checkbox · Depo · Ürün · Miat · Miktar · pagination/arama · **Sıfırla** aksiyonu. Depo filtresi sonrası mevcut stok satırları görüldü; satır checkbox ile tekil seçim yapılabildi.

**Güvenlik:** Destructive olduğundan **Sıfırla basılmadı.**

**NOT OBSERVED:** onay diyaloğu · seçili satır vs filtrelenmiş tüm satır semantiği · sıfırlama yöntemi · stok ledger kaydı · audit · geri alma/reversal · yetki koruması · nihai yan etkiler.

### Stok Transferi

**OBSERVED — liste:** mevcut kayıtlar, grup etiketi **İşleniyor**; kolonlar İşlemler · İşlem Tarihi · İşlem No · Açıklama.

**OBSERVED — Yeni Transfer:** Durum · İşlem Tarihi · İşlem No · Açıklama · Barkod · Depo · Ürün · Miktar · **Giriş Deposu** · Birim · Ekle · Kaydet.

**OBSERVED — mevcut transfer (Düzenle):** Kaynak-depo bağlamlı ürün satırı · miktar girişi · yanında mevcut stok/referans miktarı benzeri (kırmızı) sayısal değer · ayrı **Giriş Deposu** · Birim · miat bazlı secondary satır/expiry bucket · tek transferde birden fazla ürün satırı ve farklı miatlar · kaynak ve hedef ayrı depo · açıklama `Depolar Arası Stok Transferi` · kayıtlar **İşleniyor**.

**UI-level evidence:** Transfer formu kaynak envanter satırı + miktar + hedef depo taşıyor; [Stok Çıkış](#stok-çıkış) İncele’de transfer açıklamalı çıkış hareketi görüldü.

**NOT OBSERVED / iddia edilmez:** Transfer atomicity · kaynak azalışı + hedef artışı aynı transaction · tamamlanınca iki tarafın otomatik post edilmesi · **İşleniyor → Tamamlandı** geçiş kuralı · reservation/in-transit muhasebesi · onay workflow’u · negatif stok koruması.

### Depo Stok Durumu

**OBSERVED:** Arama Metni · Ara · Temizle · Yazdır; depo bazlı gruplama; kolonlar İçerik Tipi · Ürün Tipi · Barkod-1 · Barkod-2 · Ürün · Birim · **Miat** · **Miktar**. Reviewed hesapta çok sayıda satır; aynı ürün/depo için farklı expiry bucket satırları ([öncül not](#destekleyici-inceleme--stok-giriş--alış-faturası--depo-stok-durumu-öncül-destek-notu)).

**Karakter:** Availability/on-hand görünümü. **NOT inferred:** FEFO allocation engine · lot ledger. *(Rapor > Depo > Depo Stok Durumu raporu ayrı yüzey — [Rapor → Depo](#rapor--depo-reviewed--closed).)*

### Satıcı Firmaya Ödeme

**OBSERVED — liste (empty in reviewed clinic/account):** Tarih Aralığı · Arama Metni · Ara · Temizle · Yeni Kayıt; kolonlar İşlemler · İşlem Tipi · İşlem Tarihi · Satıcı Firma · İşlem No · Ödeme.

**OBSERVED — Yeni payment:** Başlık — İşlem No · Satıcı Firma · Açıklama · Ödeme Toplamı. Ödeme detay satırları — **Ödeme Tipi** · İşlem Tarihi · Makbuz No · Tutar · tipe göre secondary alan · satır ekle/kaldır benzeri kontroller · Kaydet.

**OBSERVED — Ödeme Tipi:** Nakit Ödeme · Kredi Kartı Ödeme · Çek Ödeme · Senet Ödeme · Banka Transferi Ödeme. Koşullu detay örnekleri: nakit → kasa seçimi + Belge No; kredi kartı → kartla ilgili secondary alan (Kart Sahibi).

**Karakter:** Tender seti daha önce müşteri/direct-sale ödemesinde görülene benzer; **shared backend Payment model iddiası yok**. Ödeme detay satırlarında ekle/kaldır benzeri kontroller görüldü (UI gözlemi); multi-tender kaydın çalıştığı veya backend’de nasıl işlendiği çıkarılmaz.

**NOT OBSERVED:** gerçek save/posting yapılmadı · kasa hareketi etkisi · banka hesabı hareketi etkisi · muhasebe/ledger posting · vendor balance update · ödeme→fatura tahsisi · silme/reversal lifecycle.

### Satıcı Firmalar

**OBSERVED — liste (empty in reviewed clinic/account):** Arama Metni · Ara · Temizle · Yeni Kayıt; kolonlar İşlemler · Adı · İlgili Kişi · GSM · Email · Borç · Ödeme · Bakiye · Durum.

**OBSERVED — Satıcı Firma Tanımı:** *Genel Bilgiler* — Adı · Durum · Pasif Nedeni · İlgili Kişi · Vade Gün Sayısı · Kod · Kimlik No · Ülke · Şehir · İlçe · Köy - Mahalle · Adres. *İletişim Bilgileri* — GSM · Tel 1 · Tel 2 · Faks · Email · Posta Kodu · Vergi Dairesi · Vergi No · Web Adresi. *Diğer Bilgiler* — Bilgi · Açıklama. Kaydet.

**NOT VERIFIED:** Kimlik/vergi alanlarının etiket ötesi hukuki/vergisel anlamı. Gerçek değerler dokümana alınmadı.

### Depolar

**OBSERVED:** **Depo Listesi** — Yeni Kayıt · arama · kolonlar İşlemler · Kod · Adı · Durum; birden fazla depo; **Aktif** ve **Pasif** durumları. **Depo Tanımı** — Durum · Kod · Adı · Kaydet · Kaydet / Yeni.

**NOT OBSERVED:** depo hiyerarşisi · raf/bölge (bin/location) hiyerarşisi · şube kapsamı · valuation scope · yetkiler.

---

### Stok — Cross-module synthesis

**OBSERVED capability families (UI level; tek generic inventory engine/backend iddiası yok):**

1. Vendor master (Satıcı Firmalar)
2. Warehouse/depot master (Depolar)
3. Purchase-side documents (Alış · İade · Sipariş Faturası)
4. Manual inventory movement (Stok Giriş · Stok Çıkış)
5. Physical inventory count (Sayım)
6. Destructive stock reset (Stok Sıfırlama)
7. Inter-warehouse transfer (Stok Transferi)
8. Warehouse on-hand / expiry view (Depo Stok Durumu)
9. Vendor payments (Satıcı Firmaya Ödeme)
10. Barcode/QR-supported item entry
11. Expiry-aware stock rows (Miat)
12. AI-assisted supplier invoice import (yalnız modal/UI düzeyi)

**OBSERVED UI / workflow capabilities:** Depo bazlı miktar gösterimi · Stok Giriş/Çıkış/Transfer/Sayım ayrı menü/ekranlar · ayrı vendor payment ekranı · transfer formunda kaynak depo ve ayrı **Giriş Deposu** alanı · ayrı stok sıfırlama ekranı · Alış Faturası’nda **Stok Hareketini Engelle** alanı (etkisi NOT VERIFIED) · ayrı AI import modalı (yalnız UI metni).

**INFERRED (dikkatli):** Inventory domain’i basit ürün miktarından daha geniş operasyonel envanter/procurement kapsamına sahip görünüyor · Miat birden fazla ekranda görünür alan olarak yer alıyor ve stok izlenebilirliğinin önemli parçası olabilir · purchase belge formlarında Satıcı Firma ve Depo alanlarının birlikte bulunması, belge–satıcı–depo ilişkisi olabileceğini düşündürüyor (backend ilişkisi doğrulanmadı) · vendor, envanter ve ödeme akışları yakın operasyonel ailede konumlanmış.

---

### Stok — VETINITY IMPLICATION

*(Competitor’dan kopyalama değil; yeniden kullanılabilir dersler. Yeni feature ID yok, karar değil.)*

- Envanter **depo + ürün + miktar**ı açıkça modellemeli.
- Expiry-sensitive ürünler expiry-aware stok görünürlüğü ve hareket yönetimi ister.
- Stok Giriş / Çıkış / Transfer / Sayım operasyonel olarak ayrı workflow’lardır (altta ortak domain primitive’leri paylaşsalar bile).
- Destructive envanter işlemleri (ör. stok sıfırlama) açık izin/onay/audit/geri alma tasarımı gerektirir; competitor’da onay diyaloğu **gözlemlenmedi**.
- Transfer UX’i kaynak vs hedef depoyu belirsizliğe yer bırakmadan göstermeli.
- Purchase belge posting ile envanter posting ayrıştırılabilir/konfigüre edilebilir olabilir; E-Vet’in **Stok Hareketini Engelle** kontrolü competitor evidence’dır, otomatik Vetinity requirement değil.
- Satıcı yönetimi ve satıcı ödemeleri procurement/accounting sınırına aittir; mimari sahiplik bağımsız kararlaştırılmalı.
- AI fatura okuma gelecekte ilginç bir verimlilik yeteneği olabilir; yalnızca E-Vet’te var diye MVP’ye çekilmemeli.
- Ekran çoğalmasından kaçınılıp tutarlı tek envanter workspace/workflow modeli daha net olabilir.

---

### Stok — Backlog cross-reference

Mevcut backlog’da envanter/stok/satıcı/procurement domain’ine ait ID yok. **Exact-match bulunamadığı için backlog’a E-Vet Stok evidence’ı eklenmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| RECORD-005 (lot/expiry/route/site) | NO MATCH | Klinik kayıt seviyesinde lot/uygulama izlenebilirliği; E-Vet’te stok tarafı Miat gözlemlendi, lot/batch doğrulanmadı |
| CHECKOUT-001 (ziyaret kapanışı/tahsilat) | NO MATCH | Müşteri checkout ≠ satıcı ödemesi |
| INT-005 (e-Fatura / e-SMM) | NO MATCH | AI fatura import ≠ e-belge entegrasyonu; e-belge linkage NOT OBSERVED |
| AI-* | NO MATCH | Mevcut AI kayıtları klinik/iletişim odaklı; fatura ingest yok |
| REPORT-* | Dokunulmadı | Rapor turu CLOSED |

**Potential backlog gaps (kayıt açılmadı):** envanter/procurement domain’i · depo/warehouse master · stok hareketi (giriş/çıkış/transfer/sayım) · satıcı master ve satıcı ödemesi · destructive stock action güvenliği · AI supplier invoice ingestion.

---

### Stok — TBD / NOT OBSERVED

lot/batch · FEFO/FIFO · valuation yöntemi · ortalama maliyet formülü · negatif stok politikası · transfer atomicity · stock ledger mimarisi · rezervasyon · purchase order lifecycle · approval/finalized state · audit trail · reversal · sayım düzeltme semantiği · stok sıfırlama güvenlik önlemleri · AI fatura import teknik uygulaması ve sonucu · depo hiyerarşisi/şube mimarisi · seri takibi semantiği · fatura→ödeme tahsis lifecycle · gerçek Alış Faturası save lifecycle · **Stok Hareketini Engelle = Evet** etkisi · Alış/İade/Sipariş silme/reversal/audit · e-belge linkage · Kaydet / Öde sonrası ödeme bağımlılığı · Sayım İç/Dışa Aktar detayı · Stok Çıkış bağımsız oluşturma/düzenleme/silme.

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

*(Ekran bazlı inceleme ve status → [Finansal (modül)](#finansal-modül).)*

---

## Finansal (modül)

**Review status:** **REVIEWED / CLOSED** (2026-09-30).

**CLOSED anlamı:** Erişilebilir Finansal menü ekranları ve güvenli/read-only UI incelemesi kapsamında tamamlandı. Gerçek finansal kayıt oluşturma, save/posting, silme/reversal, banka/kasa bakiye etkisi, reconciliation, muhasebe/ledger entegrasyonu ve Raporlara Dahil Et/Etme seçiminin gerçek rapor etkisi live olarak doğrulanmadı.

**Kanıt notu:** Bu bölüm canlı UI gözlemidir; backend entity/table/architecture çıkarımı yoktur. Banka ve Kasa ekranlarının benzerliği UI/workflow benzerliğidir; ortak backend/model kanıtı değildir. Gerçek banka/hesap/kasa adı, IBAN, hesap no, gider kalemi adı ve tutar dokümana taşınmadı. Rapor > Finansal raporları ([Rapor → Finansal](#rapor--finansal-reviewed--closed)) ve hasta ekstre yüzeyleri ayrı yüzeylerdir.

### Ekran durumu (7/7)

| Alt ekran | Reviewed clinic/account durumu | Gözlem düzeyi |
|---|---|---|
| Banka Giriş/Çıkış | Liste **empty in reviewed clinic/account** | Liste + Yeni Kayıt formu (save edilmedi) |
| Kasa Giriş/Çıkış | Liste **empty in reviewed clinic/account** | Liste + Yeni Kayıt formu (save edilmedi) |
| Bankalar | En az bir aktif tanım | Liste + Banka Tanımı |
| Banka Hesapları | Birden fazla aktif hesap/POS niteliğinde kayıt | Liste + Banka Hesabı Tanımı |
| Kasalar | En az bir aktif tanım | Liste + Kasa Tanımı |
| Klinik Gider Grupları | Liste **empty in reviewed clinic/account** | Liste + Grup Tanımı |
| Klinik Gider Tipleri | Çok sayıda tanım | Liste + Tip Tanımı |

### Banka Giriş/Çıkış

**OBSERVED — liste (empty in reviewed clinic/account; `Kayıt bulunamadı`):** Tarih Aralığı · Arama Metni · Ara · Temizle · Yeni Kayıt; kolonlar İşlemler · İşlem Tarihi · İşlem Tipi · Oluşturan · Giriş/Çıkış · Banka Hesabı · Tutar · Klinik Gider Tipi · Raporlara Dahil Et / Etme · Açıklama.

**OBSERVED — Yeni Kayıt formu:** Giriş/Çıkış · İşlem Tarihi · Banka Hesabı · Raporlara Dahil Et / Etme · Tutar · Klinik Gider Tipi · Açıklama · Kaydet · Kaydet / Yeni. `Giriş/Çıkış` seçimi yön alanıdır (form/UI’dan `Giriş` ve `Çıkış` anlaşılıyor; başka enum üyesi belgelenmedi). `Raporlara Dahil Et / Etme`: **Evet** · **Hayır**. `Banka Hesabı` seçimi tanımlı banka hesaplarından, `Klinik Gider Tipi` seçimi konfigüre edilmiş gider tiplerinden geliyor (configurable expense type selection).

**NOT VERIFIED:** gerçek save/posting · banka hesabı bakiyesinin değişmesi · double-entry muhasebe · external accounting integration · reconciliation · delete/reversal lifecycle · `Raporlara Dahil Et / Etme` seçiminin hangi raporlara ve nasıl etki ettiği · audit trail / immutable ledger · kullanıcı/rol bazlı financial authorization.

### Kasa Giriş/Çıkış

**OBSERVED — liste (empty in reviewed clinic/account; `Kayıt bulunamadı`):** Tarih Aralığı · Arama Metni · Ara · Temizle · Yeni Kayıt; kolonlar İşlemler · İşlem Tarihi · İşlem Tipi · Oluşturan · Giriş/Çıkış · Kasalar · Tutar · Klinik Gider Tipi · Raporlara Dahil Et / Etme · Açıklama.

**OBSERVED — Yeni Kayıt formu:** Giriş/Çıkış · İşlem Tarihi · Kasa · Raporlara Dahil Et / Etme · Tutar · Klinik Gider Tipi · Açıklama · Kaydet · Kaydet / Yeni. Kasa dropdown’ında tanımlı kasa seçilebiliyor.

**OBSERVED (UI/workflow):** Banka Giriş/Çıkış ile alan ve akış olarak çok benzer; fark hesap/kasa seçim alanıdır. **Aynı backend entity/table, generic accounting engine veya shared domain model iddiası yoktur.**

**NOT VERIFIED:** save/posting sonucu · kasa bakiyesi etkisi · transaction reversal/delete · cash ledger · accounting posting · report inclusion davranışı · reconciliation.

### Bankalar

**OBSERVED — liste:** Yeni Kayıt · arama; kolonlar İşlemler · Kod · Adı · Durum. Reviewed hesapta en az bir aktif banka tanımı vardı.

**OBSERVED — Banka Tanımı:** Durum · Kod · Adı · Kaydet · Kaydet / Yeni. Bank master/configuration capability.

**NOT VERIFIED:** delete/deactivate lifecycle · bank master’ın başka kayıtlarla dependency kuralları · external banking integration.

### Banka Hesapları

**OBSERVED — liste:** Yeni Kayıt · arama; kolonlar İşlemler · Banka · Adı · Hesap No · Hesap Kodu · IBAN No · Banka Şubesi · Banka Şube No · Pos Mu · Durum. Reviewed hesapta birden fazla aktif banka hesabı / POS niteliğinde kayıt vardı.

**OBSERVED — Banka Hesabı Tanımı:** Durum · Banka · Adı · Banka Şubesi · Banka Şube No · Iban No · Hesap No · Hesap Kodu · Pos Mu · Kaydet · Kaydet / Yeni. `Pos Mu` bir boolean/choice alanı; `Hesap Kodu` alanı mevcut.

**Not:** `Pos Mu` alanı gerçek POS entegrasyonu, terminal bağlantısı veya ödeme gateway entegrasyonu anlamına **gelmez**; `Hesap Kodu` alanı muhasebe entegrasyonu kanıtı **değildir**.

**NOT VERIFIED:** IBAN validation · POS settlement · bank feed · payment processor linkage · accounting/chart-of-accounts linkage · bank reconciliation.

### Kasalar

**OBSERVED — liste:** Yeni Kayıt · arama; kolonlar İşlemler · Kod · Adı · Hesap Kodu · Durum. Reviewed hesapta en az bir aktif kasa tanımı vardı.

**OBSERVED — Kasa Tanımı:** Durum · Kod · Adı · Hesap Kodu · Kaydet · Kaydet / Yeni.

**NOT VERIFIED:** `Hesap Kodu` alanının muhasebe bağlantısı / ledger mapping’i.

### Klinik Gider Grupları

**OBSERVED — liste (empty in reviewed clinic/account; `Kayıt bulunamadı`):** Yeni Kayıt · arama; kolonlar İşlemler · Adı · Durum.

**OBSERVED — Klinik Gider Grup Tanımı:** Durum · Adı · Kaydet · Kaydet / Yeni. Configurable expense grouping capability.

**NOT VERIFIED:** group hierarchy · nested groups · delete/deactivate dependency rules · report behavior.

### Klinik Gider Tipleri

**OBSERVED — liste:** Yeni Kayıt · arama; kolonlar İşlemler · Adı · Klinik Gider Grubu · Hesap Kodu · Durum. Reviewed hesapta çok sayıda configured expense type vardı (tek tek belgelenmedi).

**OBSERVED — Klinik Gider Tip Tanımı:** Durum · Adı · Hesap Kodu · Klinik Gider Grubu · Kaydet · Kaydet / Yeni. Yeni kayıt formunda `Klinik Gider Grubu` dropdown’ı reviewed account’ta seçilebilir grup göstermedi (`Kayıt bulunamadı`); bu yalnızca reviewed account’ta selectable group bulunmadığını gösterir, group desteği hakkında sonuç değildir.

**NOT VERIFIED:** `Hesap Kodu` alanının muhasebe entegrasyonu veya chart-of-accounts mapping davranışı.

---

### Finansal — Cross-module synthesis

**OBSERVED UI / workflow capabilities:**

- Banka bazlı giriş/çıkış hareket ekranı
- Kasa bazlı giriş/çıkış hareket ekranı
- Giriş/Çıkış yön alanı · işlem tarihi · tutar · açıklama
- Configurable Klinik Gider Tipi seçimi
- Hareketin raporlara dahil edilip edilmemesine yönelik Evet/Hayır alanı (etkisi NOT VERIFIED)
- Banka, Banka Hesabı, Kasa, Klinik Gider Grubu ve Klinik Gider Tipi master/tanım ekranları
- Banka Hesabı üzerinde POS niteliğini belirten alan
- Banka Hesabı, Kasa ve Gider Tipi tanımlarında `Hesap Kodu` alanları

**INFERRED / PRODUCT INTERPRETATION:** Gözlenen UI kapsamında Finansal alan, full accounting suite’ten ziyade operational cash/bank movement + financial masters + expense classification yapısına benziyor. Bu bir Vetinity product yorumudur; E-Vet backend mimarisi veya muhasebe kapsamı hakkında hüküm değildir.

**Observed olarak yazılmaz:** çift taraflı muhasebe · general ledger · muhasebe fişi · chart of accounts entegrasyonu · banka entegrasyonu · banka ekstre importu · reconciliation · settlement · POS gateway · finansal kapanış · mutabakat · tahakkuk muhasebesi · VAT/accounting posting · immutable journal · atomic posting · audit-compliant ledger.

---

### Finansal — VETINITY IMPLICATION

*(Competitor’dan kopyalama değil; ders adayları. Yeni feature ID yok, karar değil.)*

- Operasyonel kasa/banka hareketi, finansal master’lar (banka, hesap, kasa) ve gider sınıflandırması birbirinden ayrı düşünülebilir; tam muhasebe kapsamı ayrı bir karar konusudur.
- Gider sınıflandırması (grup/tip) konfigüre edilebilir olabilir; ancak hiyerarşi ihtiyacı bu kanıttan çıkmaz.
- Bir hareketin raporlara dahil edilip edilmemesi kontrolü ancak rapor etkisi açıkça tanımlanırsa güvenli olur; E-Vet’te etkisi doğrulanmadı.
- Hesap kodu alanları muhasebe entegrasyonu kararı verilmeden eklenirse yanlış beklenti yaratabilir.
- POS niteliği alanı ile gerçek POS/ödeme entegrasyonu ayrı değerlendirilmelidir.

---

### Finansal — Backlog cross-reference

**Exact-match bulunamadı; backlog’a E-Vet Finansal evidence’ı eklenmedi.** Backlog’da banka/kasa hareketi, gider sınıflandırması, kasa/banka hesabı master’ı, muhasebe/ledger, hesap kodu eşlemesi veya rapora dahil etme kontrolü ID’si yok.

| Aday | Karar | Gerekçe |
|---|---|---|
| CHECKOUT-001 | NO MATCH | Ziyaret kapanışı ve müşteri tahsilatı; banka/kasa hareketi değil |
| INT-006 (POS ve online ödeme) | NO MATCH | `Pos Mu` alanı POS/online ödeme entegrasyonu kanıtı değil |
| INT-005 (e-Fatura / e-SMM) | NO MATCH | Yasal e-belge; `Hesap Kodu` accounting integration değil |
| PORTAL-004 (açık fatura görüntüleme) | NO MATCH | Hasta sahibi portalı; ilgisiz |
| REPORT-* | NO MATCH | Rapor Merkezi yapısı; `Raporlara Dahil Et/Etme` Report Center capability değil |

**Potential backlog gaps (kayıt açılmadı):** operasyonel kasa/banka hareketi · finansal master’lar (banka/hesap/kasa) · gider sınıflandırma (grup/tip) · muhasebe/ledger kapsamı · hareketin rapora dahil edilmesi kontrolü.

---

### Finansal — TBD / NOT OBSERVED

gerçek save/posting · banka/kasa bakiye etkisi · double-entry muhasebe · external accounting integration · chart-of-accounts/hesap kodu eşlemesi · general ledger · reconciliation · bank feed/ekstre import · POS settlement · payment processor linkage · IBAN validation · delete/reversal lifecycle · audit trail / immutable ledger · rol bazlı finansal yetki · `Raporlara Dahil Et / Etme` gerçek rapor etkisi · gider grup hiyerarşisi/dependency kuralları · banka/hesap/kasa deactivate ve dependency kuralları · `Giriş/Çıkış` tam enum listesi.

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

### Global Muayene Odası — REVIEWED / CLOSED

Planlanan global Muayene Odası batch **incelendi** (2026-09-28; tekrar inceleme gerekmez):

Muayene Odası navigation · global worklist · filtreler · kolonlar · assignee gruplama · Muayene Odası Tanımlama · record state Aktif/Pasif · workflow Beklemede/Tamamlandı · inline iki yönlü toggle · Yönlendir modal · routing live test (Dış Klinik → Hasta Odası) · delete confirmation UI

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- delete persistence / hard-soft delete · routing history / audit trail · routing notification · assignee dropdown exact semantics · Aktif/Pasif backend/domain anlamı · hidden workflow states · multi-user concurrency / queue ownership · SLA / wait-time · routing reason/history · backend ilişki clinical examination record ↔ worklist entry

### Global Lab İstekleri — REVIEWED / CLOSED

Planlanan global Lab İstekleri batch **incelendi** (2026-09-28; tekrar inceleme gerekmez):

Lab İstekleri navigation · global worklist (no global create) · filtreler · kolonlar · status grouping Beklemede/Tamamlandı · date sort within groups · patient Lab Geçmişi + Yeni Lab İstek form · Test Grubu/Panel · Hasta Durumu · SmartVette İzin Ver field · Lab Sonuçları detail · status enum incl. İşleniyor · structured analyte grid · reference ranges · completed-with-empty-values observation · inline expand · row actions (edit/download/print/barcode/WhatsApp/email/delete) · email validation · DataVet analyte modal · status filter gap observation

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- panel auto-add · test population on group select · SmartVette semantics · global İşleniyor group · populated completed UI · abnormal flags · output formats · Test Sayısı meaning · DataVet integration beyond content · reference derivation · delete persistence · share logging · lab billing · specimen model · analyzer/LIS architecture · patient-context lab request save → global worklist appearance

### Global Xray İstekleri — PARTIAL (CLOSED değil)

Planlanan global Xray + Test Grubu Tanımı batch **kısmen incelendi** (2026-09-29):

Xray İstekleri navigation · global worklist shell (no global create) · filtreler/kolonlar · empty worklist in searched range · patient Xray Geçmişi + Yeni Xray İstek form · Test Grubu empty · Test Grup Panel populated (lab panel names) · Test Grupları > Test Grubu Tanımı · Tür Lab/Röntgen · Test Tipi catalog behavior · Serbest Parametreli · Laboratuvar/Cihaz fields when Tür=Röntgen · test kalem required validation (save blocked)

**TBD / NOT OBSERVED** (PARTIAL — CLOSED **yapılmaz**):

- gerçek request save · global queue appearance · status/result lifecycle · imaging upload/DICOM/PACS/viewer · radiology report · Xray-specific device catalog rules · SmartVette semantics · configured Xray Test Group in reviewed clinic · billing · share/print/download

### Global Pacs İstekleri — REVIEWED / CLOSED

Planlanan global PACS batch **incelendi** (2026-09-29; tekrar inceleme gerekmez):

Pacs İstekleri navigation · populated global worklist (no global create) · filtreler/kolonlar incl. Modalite · CR and US modalities · patient Pacs Geçmişi + Yeni Pacs İstek form · Pacs Grubu catalog (CR/US groups) · SmartVette field · CR **İncele** → Fujifilm Synapse Mobility external viewer · real CR images · study/series/image navigation · DICOM-style metadata in viewer · rich viewer toolbar (behaviors partly NOT VERIFIED) · US **İncele** → “Pacs Görüntüsü mevcut değil..” (reviewed samples)

**Observed limitation / unresolved (CLOSED’ı engellemez):**

- reviewed US records: no accessible image on **İncele** · root cause **TBD**

**TBD / NOT OBSERVED** (CLOSED kapsamını **engellemez**):

- PACS group admin · DICOM/integration protocol · acquisition/upload association · save → global queue · reporting/signing · annotation persistence · export/print/share/delete · billing · SmartVette semantics

### Rapor — REVIEWED / CLOSED

Rapor üst domain **erişilebilir ekran seti ve yetki sınırları içinde** incelendi (2026-09-29; tekrar inceleme gerekmez). **Anlamına gelmez:** her raporun içeriği gözlemlendi.

| Kategori | Status | Not |
|---|---|---|
| Rapor Özellikleri | **REVIEWED / CLOSED** | ~92 definition · layout/print config; custom builder gözlemlenmedi |
| Rapor → Genel | **REVIEWED / CLOSED** | 15/16 içerik; Lab Test Sayısı **ACCESS-BLOCKED** |
| Rapor → Randevu | **REVIEWED / CLOSED** | Yapılacak İşler + aşı çizelgeleri (matrix) |
| Rapor → Resmi | **REVIEWED / CLOSED** | 6 kayıt defteri/bilgi raporu; mevzuat doğrulaması **TBD** |
| Rapor → Depo | **REVIEWED / CLOSED** | 9 erişilebilir · 4 **ACCESS-BLOCKED** |
| Rapor → Finansal | **REVIEWED / CLOSED** | Bakiye · Kasa · Satış · Maliyet/Kâr · Tahsilat · Gider · Günlük İşlem Dökümü |
| **Rapor overall** | **REVIEWED / CLOSED** | E-Vet genel review **IN PROGRESS** |

**ACCESS-BLOCKED / NOT OBSERVED** (kategori closure’ını bozmaz): Laboratuvar Test Sayısı Raporu · Hareket Olmayan Ürünler · Stok Analiz · ABC Analizi (Ürün Bazlı) · ABC Analizi (Ürün Tipi Bazlı) — [detay](#rapor--open--access-limited-items).

**TBD / NOT OBSERVED (CLOSED kapsamını engellemez):** Excel/CSV · scheduled/emailed reports · saved filters · custom builder · role/permission model · drill-down · chart interactions · dashboard home · Turkey regulatory validation.

### Stok — REVIEWED / CLOSED

Stok üst domain menüsü (12 öğe) **erişilebilir ekranlar ve güvenli/read-only etkileşimler kapsamında** incelendi (2026-09-30; tekrar inceleme gerekmez). **Anlamına gelmez:** destructive action veya gerçek kayıt oluşturma/tamamlama gerektiren side-effect davranışları gözlemlendi.

Alış Faturası (+ AI ile içeri aktar modalı) · İade Faturası · Sipariş Faturası · Stok Giriş · Stok Çıkış · Sayım · Stok Sıfırlama · Stok Transferi · Depo Stok Durumu · Satıcı Firmaya Ödeme · Satıcı Firmalar · Depolar

**Empty in reviewed clinic/account** (capability yok değil): Alış/İade/Sipariş Faturası, Sayım, Satıcı Firmaya Ödeme, Satıcı Firmalar listeleri.

**TBD / NOT OBSERVED (CLOSED kapsamını engellemez):** [Stok — TBD](#stok--tbd--not-observed) listesi.

### Finansal — REVIEWED / CLOSED

Finansal üst domain menüsü (7 öğe) **erişilebilir ekranlar ve güvenli/read-only UI incelemesi kapsamında** incelendi (2026-09-30; tekrar inceleme gerekmez). **Anlamına gelmez:** gerçek finansal kayıt oluşturma, save/posting, silme/reversal, banka/kasa bakiye etkisi, reconciliation, muhasebe/ledger entegrasyonu ve `Raporlara Dahil Et/Etme` seçiminin gerçek rapor etkisi live olarak doğrulandı.

Banka Giriş/Çıkış · Kasa Giriş/Çıkış · Bankalar · Banka Hesapları · Kasalar · Klinik Gider Grupları · Klinik Gider Tipleri

**Empty in reviewed clinic/account** (capability yok değil): Banka Giriş/Çıkış, Kasa Giriş/Çıkış, Klinik Gider Grupları listeleri.

**TBD / NOT OBSERVED (CLOSED kapsamını engellemez):** [Finansal — TBD](#finansal--tbd--not-observed) listesi.

### E-Vet genel — kalan ana alanlar

| Alan | Durum | Not |
|---|---|---|
| **Hospitalizasyon** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül) |
| **Takvim** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Takvim (modül)](#global-takvim-modül) |
| **Doğrudan Satış** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül); [Yeni Ziyaret > Satış](#yeni-ziyaret) ayrı yüzey |
| **Muayene Odası** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Muayene Odası (modül)](#global-muayene-odası-modül); patient muayene geçmişi ayrı (Hasta Kartı **CLOSED**) |
| **Lab İstekleri** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül); patient Lab Geçmişi (Hasta Kartı **CLOSED**) |
| **Xray İstekleri** (global kuyruk) | **PARTIAL** (2026-09-29) | Bkz. [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial); current clinic: no request rows / no selectable Xray Test Grubu; result lifecycle **not validated** |
| **Pacs İstekleri** (global modül) | **REVIEWED / CLOSED** (2026-09-29) | Bkz. [Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül); US image unavailable on reviewed samples — limitation documented |
| **HBS** | NOT REVIEWED | |
| **VKY** | NOT REVIEWED | |
| **e-Fatura / e-SMM** | PARTIAL | Nav + patient finans alanları |
| **DataVet** | NOT REVIEWED | |
| **İlaç Rehberi** | NOT REVIEWED | |
| **Nekropsi** | NOT REVIEWED | |
| **Mobil Uygulamalar** | NOT REVIEWED | |
| **Katalog / Dokümanlar** | NOT REVIEWED | |
| **Rapor** (üst domain) | **REVIEWED / CLOSED** (2026-09-29) | Bkz. [Rapor](#rapor); erişilebilir ekran seti/yetki sınırları içinde; 5 rapor ACCESS-BLOCKED |
| **Stok** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) | Bkz. [Stok (modül)](#stok-modül); güvenli/read-only kapsam; side-effect davranışları NOT OBSERVED; Rapor > Depo raporları ayrı ([Rapor → Depo](#rapor--depo-reviewed--closed)) |
| **Finansal** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) | Bkz. [Finansal (modül)](#finansal-modül); güvenli/read-only UI kapsamı; save/posting, bakiye/ledger ve rapor etkisi NOT VERIFIED; Rapor > Finansal ve patient ekstre ayrı yüzeyler |
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
4. ~~Muayene Odası~~ — **CLOSED** ([Global Muayene Odası (modül)](#global-muayene-odası-modül))
5. ~~Lab İstekleri~~ — **CLOSED** ([Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül))
6. ~~Xray İstekleri~~ — **PARTIAL** ([Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial); result lifecycle incelenen klinikte doğrulanamadı — **CLOSED değil**)
7. ~~Pacs İstekleri~~ — **CLOSED** ([Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül))
8. ~~Rapor~~ — **CLOSED** ([Rapor](#rapor); erişilebilir ekran seti içinde; ACCESS-BLOCKED alt raporlar explicit)
9. ~~Stok~~ — **CLOSED** ([Stok (modül)](#stok-modül); güvenli/read-only kapsam; side-effect davranışları NOT OBSERVED)
10. ~~Finansal~~ — **CLOSED** ([Finansal (modül)](#finansal-modül); güvenli/read-only UI kapsamı; save/posting ve bakiye/ledger etkileri NOT VERIFIED)
11. **Ürün** — **NEXT**
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

**TBD** — Navigation IA tamamlandı; operasyon modülleri (Hospitalizasyon, Takvim, Doğrudan Satış, Muayene Odası, Lab, Pacs) **CLOSED**; **Xray** **PARTIAL**; **Rapor** üst domain **REVIEWED / CLOSED** (2026-09-29; erişilebilir ekran seti içinde); **Stok** üst domain **REVIEWED / CLOSED** (2026-09-30; güvenli/read-only kapsam); **Finansal** üst domain **REVIEWED / CLOSED** (2026-09-30; güvenli/read-only UI kapsamı). Genel E-Vet özeti ilerledikçe doldurulacaktır ([Next Review Queue](#next-review-queue)).

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
