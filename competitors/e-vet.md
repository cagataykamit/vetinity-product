# E-Vet SMART — Rakip Analizi

## Ürün

E-Vet SMART (Türkiye pazarı veteriner klinik yönetim yazılımı)

## İncelenen alan

**Tamamlanan pass'ler:**

- Platform shell / navigation ve IA envanteri (**navigation discovery tamamlandı**, 2026-09-23); login sonrası Hasta Kabul landing (alan etiketleri; kısmi — bkz. [Review Tracker](#review-tracker)).
- **Hasta Kartı / Patient Workspace** — planlanan görsel/product review kapsamı **REVIEWED / CLOSED** (2026-09-24 – 2026-09-25); [kapsam](#hasta-kartı--patient-workspace) ve [tracker](#review-tracker).
- **Global Hospitalizasyon modülü** — sol menü **Hospitalizasyon** / **Hospitalizasyonlar** operasyon yüzeyi **REVIEWED / CLOSED** (2026-10-04; önceki pass 2026-09-25); [kapsam](#global-hospitalizasyon-modül) ve [tracker](#review-tracker).
- **Global Takvim modülü** — Randevular + Hatırlatma/iletişim batch **REVIEWED / CLOSED** (2026-09-25); [kapsam](#global-takvim-modül) ve [tracker](#review-tracker).
- **Global Doğrudan Satış modülü** — walk-in satış, ödeme, miat/expiry seçimi ve destekleyici Ürün/Stok kanıtları **REVIEWED / CLOSED** (2026-09-27); [kapsam](#global-doğrudan-satış-modül) ve [tracker](#review-tracker).
- **Global Muayene Odası modülü** — klinik worklist / patient-routing yüzeyi **REVIEWED / CLOSED** (2026-09-28); [kapsam](#global-muayene-odası-modül) ve [tracker](#review-tracker).
- **Global Lab İstekleri modülü** — lab worklist, patient-context request creation, structured results **REVIEWED / CLOSED** (2026-09-28); [kapsam](#global-lab-i̇stekleri-modül) ve [tracker](#review-tracker).
- **Global Xray İstekleri** — request/configuration yüzeyleri **PARTIAL** (2026-09-29); [kapsam](#global-xray-i̇stekleri-partial) ve [tracker](#review-tracker).
- **Global Pacs İstekleri modülü** — populated worklist, CR/US modalities, external Fujifilm Synapse Mobility viewer handoff **REVIEWED / CLOSED** (2026-09-29); [kapsam](#global-pacs-i̇stekleri-modül) ve [tracker](#review-tracker).
- **Rapor (üst domain)** — Rapor Özellikleri, Genel, Randevu, Resmi, Depo, Finansal **REVIEWED / CLOSED** (2026-09-29; erişilebilir ekran seti ve yetki sınırları içinde; ACCESS-BLOCKED alt raporlar explicit); [kapsam](#rapor) ve [tracker](#review-tracker).
- **Stok (üst domain)** — 12 menü öğesi **REVIEWED / CLOSED** (2026-09-30; erişilebilir ekranlar ve güvenli/read-only etkileşimler kapsamında; side-effect davranışları NOT OBSERVED); [kapsam](#stok-modül) ve [tracker](#review-tracker).
- **Finansal (üst domain)** — 7 menü öğesi **REVIEWED / CLOSED** (2026-09-30; erişilebilir ekranlar ve güvenli/read-only UI incelemesi kapsamında; save/posting ve bakiye/ledger etkileri NOT VERIFIED); [kapsam](#finansal-modül) ve [tracker](#review-tracker).
- **Ürün (üst domain)** — 6 menü öğesi **REVIEWED / CLOSED** (2026-10-01; tüm ana menü ekranları incelendi; davranışsal side-effect ve uygulama semantiği çoğu alanda NOT VERIFIED); [kapsam](#ürün-modül) ve [tracker](#review-tracker).
- **Müşteri (üst domain)** — 6 menü öğesi + Müşteri Kartı derin inceleme **REVIEWED / CLOSED** (2026-10-01; global menü ve kart shell kapsamında; çoğu save/posting ve entegrasyon semantiği NOT VERIFIED); [kapsam](#müşteri-modül) ve [tracker](#review-tracker).
- **Hasta** (üst domain — reference data) — 8 menü öğesi **REVIEWED / CLOSED** (2026-10-01; global üst menü configuration/owner-transfer yüzeyleri; [Hasta Kartı](#hasta-kartı--patient-workspace) ayrı); [kapsam](#hasta-modül) ve [tracker](#review-tracker).
- **Muayene** (üst domain) — 13 menü öğesi **REVIEWED / CLOSED** (2026-10-01; reçete/aşı config, klinik vocabulary, paket/template ve treatment-monitoring configuration; [Global Muayene Odası](#global-muayene-odası-modül) ve [Hasta Kartı](#hasta-kartı--patient-workspace) ayrı); [kapsam](#muayene-modül) ve [tracker](#review-tracker).
- **Laboratuvar** (üst domain) — 7 menü öğesi **REVIEWED / CLOSED** (2026-10-03; lab comparison, test/PACS/reference/device configuration; [Global Lab İstekleri](#global-lab-i̇stekleri-modül) · [Global Pacs İstekleri](#global-pacs-i̇stekleri-modül) · [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial) operasyon yüzeyleri ayrı); [kapsam](#laboratuvar-modül) ve [tracker](#review-tracker).
- **Genel** (üst domain) — 12 menü öğesi **REVIEWED / CLOSED** (2026-10-03; clinic master data, authorization surfaces, settings, backup UI, manual shell, external Alpemix link); [kapsam](#genel-modül) ve [tracker](#review-tracker).
- **VKY** (sol menü — yönetim analitiği) — 3 alt ekran **REVIEWED / CLOSED** (2026-10-04); [kapsam](#vky-modül) ve [tracker](#review-tracker). *(Üst menü [Rapor](#rapor) predefined rapor kataloğu ayrı yüzey.)*

**Devam eden / henüz sistematik incelenmeyen:** Xray result lifecycle (incelenen klinikte doğrulanamadı), PACS US missing-image root cause, DataVet entegrasyon deep-dive, vb. — [Review Tracker](#review-tracker), [Next Review Queue](#next-review-queue).

## Analiz durumu

| Kapsam | Durum |
|---|---|
| **E-Vet SMART genel competitor review** | **Devam ediyor (IN PROGRESS)** — gözlemlenen sürüm **v4.12.0** |
| **Navigation / IA discovery** | Tamamlandı (2026-09-23) |
| **Hasta Kartı / Patient Workspace** | **REVIEWED / CLOSED** (2026-09-25) |
| **Global Hospitalizasyon modülü** | **REVIEWED / CLOSED** (2026-10-04) |
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
| **Ürün** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) |
| **Müşteri** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) |
| **Hasta** (üst domain — reference data) | **REVIEWED / CLOSED** (2026-10-01) |
| **Muayene** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) |
| **Laboratuvar** (üst domain) | **REVIEWED / CLOSED** (2026-10-03) |
| **Genel** (üst domain) | **REVIEWED / CLOSED** (2026-10-03) |
| **VKY** (sol menü) | **REVIEWED / CLOSED** (2026-10-04) |

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
| İnceleme tarihi | 2026-09-23 (navigation); 2026-09-24 – 2026-09-25 (Hasta Kartı — CLOSED); 2026-09-25 (Global Hospitalizasyon — CLOSED); 2026-10-04 (Global Hospitalizasyon — reaffirm / CLOSED); 2026-10-04 (VKY — CLOSED); 2026-09-25 (Global Takvim — CLOSED); 2026-09-27 (Global Doğrudan Satış — CLOSED); 2026-09-28 (Global Muayene Odası — CLOSED); 2026-09-28 (Global Lab İstekleri — CLOSED); 2026-09-29 (Global Xray İstekleri — PARTIAL); 2026-09-29 (Global Pacs İstekleri — CLOSED); 2026-09-29 (Rapor / Genel pass); 2026-09-29 (Rapor / Randevu, Resmi, Depo, Finansal consolidation — Rapor CLOSED); 2026-09-30 (Stok — CLOSED); 2026-09-30 (Finansal — CLOSED); 2026-10-01 (Ürün — CLOSED); 2026-10-01 (Müşteri — CLOSED); 2026-10-01 (Hasta üst menü — CLOSED); 2026-10-01 (Muayene üst menü — CLOSED); 2026-10-03 (Laboratuvar üst menü — CLOSED); 2026-10-03 (Genel üst menü — CLOSED) |

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
- Hospitalizasyon *(global modül — [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül) **CLOSED**; sol nav sıradaki modül: **HBS**)*
- HBS (Hayvan Bilgi Sistemi) *(sol operasyonel nav — **NEXT** modül incelemesi; [Review Tracker](#review-tracker))*
- VKY *( [VKY (modül)](#vky-modül) **REVIEWED / CLOSED** 2026-10-04; HBS sıradaki **NOT REVIEWED** modül olarak korunur)*
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

**OBSERVED — alt menü (IA):** Güncel Durum Ekranı · Performans Göstergeleri · Parametre Tanımları.

**Review:** **REVIEWED / CLOSED** (2026-10-04) — ekran detayı → [VKY (modül)](#vky-modül).

**TBD:** “VKY” kısaltmasının tam açılımı (menü etiketinden **uydurulmaz**).

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

**Review status:** **REVIEWED / CLOSED** (2026-10-04; planlanan sol menü **Hospitalizasyon** / global **Hospitalizasyonlar** product review kapsamı).

**OBSERVED — giriş:** Sol operasyonel menü **Hospitalizasyon** → global sayfa başlığı **Hospitalizasyonlar**.

### Liste (Hospitalizasyonlar)

**OBSERVED — üst filtreler:** Tarih Aralığı, Arama Metni, **Ara**, **Temizle**.

**OBSERVED — aksiyon:** **+ Yeni Kayıt**.

**OBSERVED — liste kromu:** Sayfalama ve varsayılan tablo satır sayısı kontrolü (tam sayı/persisted preference **NOT VERIFIED**).

**OBSERVED — tablo kolonları:** İşlemler, Müşteri, Hasta, Bölüm, Veteriner, Oda, Giriş Tarihi, Çıkış Tarihi, Günler, Tedavisi var mı?

**OBSERVED — satır gruplama:** Kayıtlar durum başlıkları altında gruplanabiliyor. Gözlemlenen grup etiketleri: **Yatan**, **Taburcu**.

**OBSERVED:** Sorgu/tarih filtresi sonuç kümesi içinde yalnızca aktif yatan listesi değil; **Yatan** ve **Taburcu** grupları birlikte görüntülenebilir. Kayıt **Yatan** → **Taburcu** düzenlendiğinde aynı kayıt **Yatan** grubundan **Taburcu** grubuna taşındı.

**OBSERVED — Durum (form dropdown, UI):** **Yatan** · **Taburcu** · **Ölü** (liste gruplarında yalnızca **Yatan** / **Taburcu** gözlendi; **Ölü** kayıt örneği bu pass’te doğrulanmadı).

**NOT VERIFIED:** **Günler** hesaplama semantiği · tarih/saat timezone · grup sıralaması kuralları.

### Hospitalizasyon Tanımı (+ Yeni Kayıt / Düzenle)

**OBSERVED — form başlığı:** Hospitalizasyon Tanımı.

**OBSERVED — alanlar (UI):** Müşteri · Hasta · Durum · Giriş Tarihi · Çıkış Tarihi · Bölüm · Oda · Veteriner · Tedavi Şekli · Uygulamalar · Açıklama.

**OBSERVED — zorunlu işaretleme (UI):** Müşteri, Hasta, Durum, Giriş Tarihi, Bölüm kırmızı/zorunlu etiketli görünüyordu (backend validation **NOT VERIFIED**).

**OBSERVED — aksiyonlar:** Kaydet, Geri Dön.

**OBSERVED — Yeni Kayıt (UI):** Varsayılan **Durum** = **Yatan**; **Giriş Tarihi** inceleme günü ile dolu görünüyordu; **Bölüm** ve **Veteriner** önceden dolu olabiliyordu (kaynak: sistem ayarı / oturum / son seçim **NOT VERIFIED**).

**NOT VERIFIED:** Müşteri seçilmeden **Hasta** alanının davranışı · mutation/save persistence (yeni kayıt oluşturma bu pass’te zorunlu değildi).

**OBSERVED — referans seçimleri (mevcut kayıt):** **Bölüm**, **Oda**, **Veteriner** dropdown’ları seçilebilir; oda listesinde birden fazla klinik oda/kafes/yoğun bakım benzeri seçenek; veteriner listesinde birden fazla personel/veteriner seçeneği (isimler **kopyalanmadı**).

**INFERRED (UI-level, zayıf):** Hospitalizasyon kaydı bölüm + oda + sorumlu veteriner ile ilişkilendirilebiliyor.

**NOT VERIFIED:** Oda doluluk/kapasite · aynı odaya eşzamanlı yatış engeli · yatak/kafes kapasitesi · vardiya uygunluğu · conflict detection · otomatik room assignment · kaynak hiyerarşisi.

**Backlog exact-match (scope değiştirilmedi):** [HOSP-001](../backlog/feature-backlog.md#hosp-001--yatış-yaşam-döngüsü-ve-aktif-yatışlar) · [HOSP-002](../backlog/feature-backlog.md#hosp-002--yatış-konum-ataması) · [HOSP-003](../backlog/feature-backlog.md#hosp-003--hasta-yatış-geçmişi-ve-klinik-bağlam) — yalnızca competitor evidence cross-ref; E-Vet requirement **değil**.

### Satır genişletme (inline)

**OBSERVED:** Satır solundaki expand oku; liste sayfasından ayrılmadan inline detay. **Bilgi | İçerik** yapısında alan grupları:

- Tedavi Şekli
- Uygulamalar
- Açıklama

**OBSERVED:** Hospitalization record exposes **free-text** Treatment Method (**Tedavi Şekli**) / Applications (**Uygulamalar**) / Description (**Açıklama**) blocks (içerik metinleri **kopyalanmadı**).

**NOT OBSERVED / NOT VERIFIED (bu yüzeyden çıkarılmaz):** Structured medication administration record · medication order entity · dose scheduler · administration timestamp · missed dose tracking · nurse task workflow · inventory decrement · treatment protocol engine · vital flowsheet.

### İşlemler menüsü

**OBSERVED (dropdown):** İncele, Düzenle, Sil.

**NOT VERIFIED:** Sil aksiyonu gözlendi; confirmation, persistence, hard/soft delete, audit ve authorization davranışı NOT VERIFIED.

**NOT OBSERVED (bu menüde):** Ayrı Taburcu, Treatment, Medication administration aksiyonları — başka yüzeylerde olabilir; **bilinmiyor**.

### İncele (read-only modal)

**OBSERVED — üst blok:** Durum · Giriş Tarihi · Çıkış Tarihi · Bölüm · Oda · Veteriner (+ müşteri/hasta bağlamı read-only).

**OBSERVED — alt bloklar:** Tedavi Şekli · Uygulamalar · Açıklama (read-only; klinik metin **kopyalanmadı**). Inline expand ile **substantially mirror**.

**OBSERVED:** Mevcut bir **Taburcu** kaydı **İncele** modalında **boş Çıkış Tarihi** ile görüntülendi.

**INFERRED (UI-level):** Durum ile çıkış tarihi arasında zorunlu bir UI-level invariant **gözlemlenmedi** (backend validation, migrasyon veya veri girişi geçmişi **bilinmiyor**).

**NOT inferred:** Taburcu olduğunda çıkış tarihi zorunlu/otomatik/mutlaka dolu.

### Düzenle

**OBSERVED:** Hospitalizasyon Tanımı dolu form; alan seti yeni kayıt ile aynı. Lifecycle test: Durum **Yatan** → **Taburcu**, **Çıkış Tarihi** boş bırakılarak kaydedildi ([Taburcu lifecycle](#taburcu-lifecycle-doğrudan-test)).

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

### Sil (onay) — previous observation (2026-10-04 pass’te yeniden doğrulanmadı)

*(2026-09-25 önceki incelemede not edilmişti; **2026-10-04** Hospitalizasyon CLOSED kapsamının dayanağı değildir.)*

**OBSERVED (önceki pass — 2026-09-25; 2026-10-04 canlı UI’da yeniden doğrulanmadı):** İşlemler > Sil sonrası onay diyaloğu metinleri o pass’te raporlanmıştı; kayıt silinmemişti.

**NOT VERIFIED (2026-10-04):** Confirmation modal · delete persistence (hard/soft) · audit trail · authorization enforcement.

### Ürün karakterizasyonu (yalnızca gözlem)

**OBSERVED — görece hafif inpatient operasyon yüzeyi:** yatış lifecycle + durum gruplama + bölüm/oda + veteriner + giriş/çıkış tarih alanları + tedavi/uygulama serbest metin + not + hasta geçmişi sürekliliği.

**NOT OBSERVED / TBD (feature absent iddiası değil):** medication administration record, scheduled dose administration, nursing task board, completion/skipped events, inpatient vital flowsheet, occupancy/capacity enforcement, structured bed/cage resource lifecycle.

### Status / lifecycle (NOT VERIFIED)

**OBSERVED — Durum enum (form):** Yatan · Taburcu · Ölü.

**NOT VERIFIED:** Geçiş kuralları (Yatan → Taburcu zorunlu akışı) · Yatan → Ölü geçişi · geri alma · status change audit · kim/ne zaman değiştirdi · otomatik discharge · checkout/payment dependency · **Ölü** durumunun liste gruplama davranışı.

### Patient-context cross-reference

**OBSERVED (önceki pass):** Hasta kartı **Hospitalizasyon Geçmişi (+)** patient-scoped read surface — bölüm/oda, giriş/çıkış, gün, tedavi göstergesi kolonları; detay: [Hospitalizasyon geçmişi](#hospitalizasyon-geçmişi). Global **Hospitalizasyonlar** ile süreklilik: [Taburcu lifecycle testi](#taburcu-lifecycle-doğrudan-test).

### VETINITY IMPLICATION (research — architecture/ADR kararı değil)

- Hospitalization, hasta yaşam döngüsünde ayrı bir **patient lifecycle context** olarak anlamlı; core kayıt en azından admission/discharge state, location/resource ve sorumlu clinician bilgisini taşımalı.
- E-Vet’in uzun serbest metin blokları (Tedavi Şekli / Uygulamalar) Vetinity’de **timeline**, structured treatment administration veya task workflow ihtiyacını tek başına karşılamaz — ayrı ürün tasarımı gerekir ([HOSP-001](../backlog/feature-backlog.md#hosp-001--yatış-yaşam-döngüsü-ve-aktif-yatışlar) notlarındaki future scope ile uyumlu; burada scope kararı **yok**).
- Ward/room/resource assignment ileride kapasite veya availability ile zenginleşebilir ([HOSP-002](../backlog/feature-backlog.md#hosp-002--yatış-konum-ataması) — requirement kaynağı Vetinity v1 scope, E-Vet kopyası değil).
- **Durum** ve **çıkış tarihi** birbirinden bağımsız tutulacak mı yoksa invariant olacak mı — E-Vet UI’da zorunlu bağ **gözlemlenmedi**; Vetinity için ayrı ürün kararı.

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

### Destekleyici inceleme — Ürün Tanımı (öncül destek notu)

**Not:** Doğrudan Satış / miat kanıtı için öncül not; Ürün üst menüsünün tam incelemesi → [Ürün (modül)](#ürün-modül).

**OBSERVED — Ürün Tanımı (seçilmiş alanlar; özet):** İçerik Tipi · Ürün Tipi · Ürün Grubu · Ürün Alt Grubu · Adı · Durum · Birim · Çarpan · Barkod-1 · Barkod-2 · Hasvet Kodu · Reçete Ürünü mü? · Alış/Satış fiyatları · Alış/Satış KDV · KDV dahil bayrakları · **Stok Durum Kontrolü** · **Miat Kontrolü** (Evet/Hayır) · Minimum/Maksimum/Alarm Miktarı · Aşı Paketi Var Mı · Fiyat Aralık Listesi.

**OBSERVED:** **Miat Kontrolü** ürün bazında — expiry zorunluluğu **conditional** (her ürün için zorunlu değil). Ayrıntılı ürün master, taxonomy ve fiyatlandırma → [Ürün (modül)](#ürün-modül).

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

**OBSERVED (yapı):** **Bölüm** ve **Oda** kolonları/alansları mevcut; gerçek klinik/account değerleri **kopyalanmadı**.

**OBSERVED — global ↔ hasta sürekliliği:** Global [Hospitalizasyonlar](#liste-hospitalizasyonlar) kaydı **Taburcu** yapıldıktan sonra **Hospitalizasyon Geçmişi**'nde görünür kaldı ([Taburcu lifecycle testi](#taburcu-lifecycle-doğrudan-test)). Patient-scoped yatış geçmişi read surface kanıtı — duplicate storage **varsayılmaz**. **(+)** yüzeyi global modül ile aynı alan ailesini paylaşır; uzun tekrar → [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül).

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

**Bağlam (öncül gözlemlerle tutarlı):** Ürün tanımında Miat Kontrolü Evet/Hayır; miat izlenen ürünlerde purchase-side/stok ekranlarında Miat alanı ([Ürün Tanımı](#destekleyici-inceleme--ürün-tanımı-öncül-destek-notu)). Bu turda lot/batch alanı doğrulanmadı; **Seri No ≠ lot/batch**; FEFO/FIFO enforcement iddiası yok.

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

*(Ekran bazlı inceleme ve status → [Ürün (modül)](#ürün-modül).)*

---

## Ürün (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-01).

**CLOSED anlamı:** Ürün üst menüsündeki tüm ana ekranlar incelendi. **Anlamına gelmez:** indirim precedence, type-default inheritance, cascade filtering, satış zamanı fiyat/indirim seçimi, Excel import/export doğrulama, barkod standardı uyumu, e-SMM resmi mapping, stok/expiry enforcement, yetki modeli veya diğer davranışsal semantikler live olarak doğrulanmıştır.

**Kanıt notu:** Canlı UI gözlemi; backend entity/table/architecture çıkarımı yoktur. Gerçek ürün adları, fiyatlar, barkodlar ve müşteri adları dokümana taşınmadı.

### Ekran durumu (6/6)

| Alt ekran | Reviewed clinic/account durumu | Gözlem düzeyi |
|---|---|---|
| Ürünler | Çok sayıda kayıt (binlerce) | Liste + İncele/Düzenle/QRCode/Sil + import/export + barkod |
| Hızlı Fiyatlandırma | Filtrelenmiş ürün satırları | Toplu zam UI + **live** `%1` apply → Zam Geçmişi → Geri al |
| Ürün İndirimleri | Liste **empty in reviewed clinic/account** | Tanım formu; kayıt save edilmedi |
| Ürün Tipleri | 14 kayıt | Liste + Tip Tanımı |
| Ürün Grupları | 219 kayıt | Liste + Grup Tanımı |
| Ürün Alt Grupları | 49 kayıt (liste üst gruplar altında gruplu) | Liste + Alt Grup Tanımı |

### Ürünler

**OBSERVED — Ürün Listesi:** Durum filtresi · Arama Metni · Ara · Temizle · **İçe / Dışa Aktar** · **Barkod** · Yeni Kayıt. Reviewed hesapta çok sayıda (binlerce) ürün kaydı vardı. Kolonlar: İşlemler · Ürün Tipi · Ana Grup · Adı · Birim · Çarpan · Barkod-1 · Barkod-2 · Alış Fiyatı · Satış Fiyatı · Durum. **İşlemler:** İncele · Düzenle · QRCode · Sil.

**OBSERVED — İncele:** Ürün özet bilgileri bölümlenmiş modal. Alanlar (gözlenen set): İçerik Tipi · Ürün Tipi · Adı · Durum · Ürün Grubu · Ürün Alt Grubu · Bilgi · Kod · Birim · Çarpan · Barkod-1 · Barkod-2 · Hasvet Kodu · Reçete Ürünü mü? (Kliniğim Shop) · Alış Fiyatı · Alış KDV Oranı · Alış Fiyatına KDV Dahil · Satış Fiyatı · Satış KDV Oranı · Satış Fiyatına KDV Dahil · Stok Durum Kontrolü · Miat Kontrolü · Aşı Paketi Var Mı · Minimum/Maksimum/Alarm Miktarı · Açıklama · **Fiyat Aralık Listesi** (Min Aralık · Max Aralık · Fiyat · Ekle) — **tiered / quantity-range pricing UI capability**.

**OBSERVED — İçerik Tipi (örnek seçenekler, tam enum iddiası yok):** Aşı · Hizmet · Hospitalizasyon · Malzeme · Muayene · Operasyon · Sperma · Test · İlaç.

**OBSERVED — Ürün Tipi (örnek seçenekler, tam enum iddiası yok):** Aksesuar · Aşı · Hizmet · İlaç · Kozmetik · Laboratuvar · Mama & Ödül · Operasyon Malzemesi · Premiks · Sarf Malzemesi · Solüsyon · Sperma · Temizlik Malzemesi · Vitamin · vb.

**OBSERVED — Ürün Grubu:** Çok sayıda tanımlı grup seçilebiliyor (tek tek listelenmedi).

**OBSERVED — İçe / Dışa Aktar:** İçe Aktar — dosya seçimi · **Excel'den İçe Aktar**. Dışa Aktar filtreleri — Ürün Tipi · Ürün Grubu · Durum (Aktif · Pasif) · **Dışa Aktar (Excel)**. Spreadsheet import/export UI capability.

**OBSERVED — Barkod menüsü:** CODE-128 · EAN-13 · EAN-128 · QRCODE. EAN13 report: Ürün seçimi · Barkod · Filtrele · önizleme · PDF · indirme · yazdırma. QRCode: ürün seçimi · önizleme · PDF / download / print. Barcode/label/report generation UI (GS1 compliance veya barkod standardı validation iddiası yok).

**NOT VERIFIED:** Satış sırasında fiyat aralığı seçimi · aralık inclusive/exclusive sınırları · fiyat aralığı vs indirim precedence · Excel template/validation/duplicate handling/transaction/rollback/error report · ürün silme dependency · Düzenle save lifecycle.

### Hızlı Fiyatlandırma

**OBSERVED — filtreler:** Stoktakiler (Evet/Hayır) · Ürün Tipi · Ürün Grubu · Ürün · Arama Metni.

**OBSERVED — tablo (ürün satırı):** Satış — Fiyat · KDV Oranı · KDV Dahil. Alış — Fiyat · KDV Oranı · KDV Dahil. Ek: Barkod-1 · **Kaydet** (satır bazlı).

**OBSERVED — toplu zam:** Zam Oranı (%) · Hesapla · İşlemler · Uygula. İşlem seçenekleri: `Görünenlere zam uygula (N)` · `Tüm ürünlere zam uygula (N)` · `Zammı geri al...`. UI uyarısı: zam uygulamadan önce **Hesapla** ile yeni satış fiyatlarının önizlenmesi öneriliyor.

**OBSERVED — live test (güvenli):** Görünen 10 ürüne **%1** zam uygulandı · fiyatların değiştiği gözlendi · kayıt **Zam Geçmişi**'nde göründü (tarih · kullanıcı · ürün sayısı · zam oranı) · aynı history kaydında **Geri al** aksiyonu · onay metni: `Uygulanan zammı geri almak istediğinizden emin misiniz? Bu işlem geri alınamaz!` (rollback işleminin tekrar geri alınamayacağı uyarısı; immutable audit/event sourcing iddiası değil) · geri alma çalıştırıldı · örnek fiyatların önceki değerlere döndüğü gözlendi.

**NOT VERIFIED:** Rollback'in ikinci kez undo edilmesi · concurrent edits · authorization · audit log (görünen history ötesi) · alış fiyatı üzerinde bulk semantics · rounding/decimal precision · transaction boundaries · rollback'in sonradan manuel değiştirilmiş fiyatları nasıl ele aldığı.

### Ürün İndirimleri

**OBSERVED — liste (empty in reviewed clinic/account; `Kayıt bulunamadı`):** İşlemler · Adı · Müşteri Grubu · Müşteri · Durum.

**OBSERVED — Yeni Ürün İndirim Tanımı:** Adı · Müşteri Grubu · Müşteri · Durum. Müşteri Grubu dropdown'ında konfigüre gruplar; özel müşteri arama/seçim alanı. Discount line grid: Sil · Ürün Tipi · Ürün Grubu · Ürün · İndirim Oranı (%) · **Ekle** — birden fazla satır eklenebilir; müşteri grubu ve/veya spesifik müşteri alanları mevcut (AND/OR precedence iddiası yok).

**OBSERVED — UI behavior:** Ürün Tipi ve Ürün Grubu seçildiğinde **Ürün** arama dropdown'ı seçimlere göre görünür şekilde daralmadı; farklı tip/grup seçimlerinde uyumsuz görünen ürün kayıtları listelenmeye devam etti. *The product selector did not visibly narrow to the selected Product Type/Product Group in the reviewed UI state; whether those fields are informational, asynchronously applied, validated only on save, or affected by configuration is NOT VERIFIED.*

**NOT VERIFIED:** İndirim kaydı save edilmedi · satış/ziyaret faturasında indirim uygulaması · customer vs customer-group precedence · overlapping rules · stacking · highest/lowest/last-wins · tarih geçerliliği · min quantity · kampanyalar · specificity precedence · discount audit/history · delete/deactivate · save validation.

### Ürün Tipleri

**OBSERVED — liste:** İşlemler · Kod · Adı · Durum; **14** kayıt; İşlemler → Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Ürün Tip Tanımı:** Durum · Adı · Kod · Alış Fiyatına KDV Dahil · Alış KDV Oranı · Satış Fiyatına KDV Dahil · Satış KDV Oranı · **Miat Kontrolü** · **Stok Durum Kontrolü** · **e-SMM Yer Alır** · **e-SMM Adı** · Kaydet · Kaydet / Yeni. Mevcut kayıtlarda tip bazında KDV, miat, stok ve e-SMM alanları farklı Evet/Hayır kombinasyonlarıyla konfigüre edilmiş görünüyor.

**OBSERVED:** Product Type definition exposes configurable defaults/policy-like fields in the UI (KDV, miat, stok, e-SMM). **NOT VERIFIED:** propagation/inheritance/enforcement semantics. `e-SMM Yer Alır` + `e-SMM Adı` e-SMM ile ilişkili tip konfigürasyonu; resmi vergi mapping / entegrasyon semantiği doğrulanmadı.

### Ürün Grupları

**OBSERVED — liste:** İşlemler · Kod · Adı · **İçerik Tipi** · Durum; **219** kayıt; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Ürün Grup Tanımı:** Durum · İçerik Tipi · Kod · Adı · Kaydet · Kaydet / Yeni. Required göstergelerine göre Durum · İçerik Tipi · Adı zorunlu; Kod zorunlu görünmüyor.

**OBSERVED — İçerik Tipi (örnekler):** Aşı · Hizmet · Hospitalizasyon · Malzeme · Muayene · Operasyon · Sperma · Test · İlaç. UI taxonomy ilişkisi: **İçerik Tipi → Ürün Grubu** (backend entity/referential integrity iddiası yok).

### Ürün Alt Grupları

**OBSERVED — liste:** İşlemler · Kod · Adı · Durum; **49** kayıt; liste üst gruplar altında görsel gruplama; bir üst grup altında birden fazla alt grup; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Ürün Alt Grup Tanımı:** Durum · **Üst Grup** · Kod · Adı · Kaydet · Kaydet / Yeni. Required: Durum · Üst Grup · Adı; Kod zorunlu görünmüyor. Yeni kayıtta Üst Grup dropdown mevcut Ürün Gruplarını listeler. Observed UI hierarchy: **İçerik Tipi → Ürün Grubu → Ürün Alt Grubu → Ürün** (backend architecture iddiası değil).

**OBSERVED (captured state):** Mevcut bir alt grup liste ekranında belirli bir üst grup başlığı altında gösterildi; aynı kayıt edit ekranında açıldığında **Üst Grup** alanı `Seçiniz...` (boş) göründü. Whether this reflects loading behavior, stale/inconsistent data, alternate grouping logic, or a UI defect is NOT VERIFIED.

---

### Ürün — Cross-module synthesis

**OBSERVED UI / workflow capabilities:**

- Configurable product catalog (master list + detay alanları)
- Content type / product type / group / subgroup taxonomy yüzeyleri
- Stock/expiry policy-like flags (Stok Durum Kontrolü · Miat Kontrolü)
- Purchase/sales tax ve tax-inclusive configuration (ürün ve tip seviyesinde)
- Product-level price, barcode ve quantity/range pricing UI
- Excel import/export UI
- Barcode/QR label/report generation UI
- Bulk pricing: preview (Hesapla) · scope (görünenler vs tüm ürünler) · **Zam Geçmişi** · geri al (live rollback gözlendi)
- Customer/customer-group scoped discount-definition UI (save/apply doğrulanmadı)

**INFERRED (dikkatli):** Product area, gözlenen UI'da klinik hizmet ve fiziksel envanter kalemlerini kapsayan paylaşılan katalog/konfigürasyon yüzeyi gibi davranıyor. Product Type, yeniden kullanılabilir varsayılan/policy-benzeri alanları merkezileştirebilir (inheritance/enforcement doğrulanmadı).

**Observed olarak yazılmaz:** shared backend catalog model · database inheritance · referential integrity · automatic type inheritance · cascade filtering · discount precedence/stacking · sale-time discount application · inventory reservation · FEFO/FIFO · GS1 compliance · accounting integration · e-SMM official mapping · audit immutability · transactional bulk update · Excel validation/rollback · role/permission model.

---

### Ürün — VETINITY IMPLICATION

*(Ürün dersi/adayı; E-Vet kopyalama veya Vetinity implementation kararı değil.)*

- Hizmet, ilaç, malzeme, test vb. billable/catalog items için ortak katalog yaklaşımı değerlendirilebilir.
- Taxonomy kullanıcıya fayda sağlamalı; cascading/filter semantics açık ve tutarlı olmalı (E-Vet indirim ekranında selector daralması doğrulanmadı).
- Product type defaults vs product overrides ayrımı net tasarlanmalı.
- Bulk price updates: preview + explicit scope + history + rollback güçlü operasyonel pattern (E-Vet'te live kanıt var).
- Pricing history/audit önemli.
- Discount scope ve precedence kuralları görünür ve deterministik olmalı.
- Barcode/reporting ürün master'ından ayrıştırılabilir.
- Stok/expiry bayrakları gerçek inventory enforcement ile bağlanacaksa semantics net olmalı.

---

### Ürün — Backlog cross-reference

**Exact-match bulunamadı; backlog'a E-Vet Ürün evidence'ı eklenmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| UX-005 (ürün kategorileri Tanımlar altında) | NO MATCH | Vetinity IA önerisi; E-Vet üst menü Ürün yapısı kanıtı değil |
| CHECKOUT-001 | NO MATCH | Ziyaret checkout/tahsilat; ürün katalogu veya toplu fiyat değil |
| INT-005 (e-Fatura/e-SMM) | NO MATCH | Ürün tipinde e-SMM alanları ≠ yasal e-belge entegrasyonu |
| RECORD-005 (lot/expiry/route) | NO MATCH | Klinik kayıt izlenebilirliği; ürün master Miat bayrağı aynı semantik değil |
| REPORT-* | NO MATCH | Barkod rapor ekranı Report Center capability değil |

**Potential backlog gaps (kayıt açılmadı):** bulk pricing + rollback/history · customer/group discount definitions · product taxonomy · barcode label generation · Excel import/export · type-level defaults.

---

### Ürün — TBD / NOT OBSERVED

Satış zamanı tiered price seçimi · Excel import template/validation/duplicate/transaction/rollback · indirim save/apply ve precedence/stacking · product type default propagation · cascade product selector filtering (save-time validation bilinmiyor) · alt grup Üst Grup edit tutarsızlığı kök nedeni · GS1/barcode validation · e-SMM resmi mapping · stok/expiry enforcement at sale/inventory · ürün silme dependency · concurrent bulk pricing · authorization · purchase-side bulk zam semantics · rounding policy · discount date/campaign rules.

---

## Müşteri navigation (üst domain)

**OBSERVED:**

- Müşteriler
- Müşteri Ödemeleri
- Müşteri Ekstreleri
- Müşteri Satış Faturaları
- Müşteri İade Faturaları
- Müşteri Grupları

*(Ekran bazlı inceleme ve status → [Müşteri (modül)](#müşteri-modül).)*

---

## Müşteri (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-01).

**CLOSED anlamı:** Üst menüdeki 6 global ekran ve Müşteri Kartı shell’i (profil sekmeleri, müşteri-scoped sol menü, finansal/ekstre/rapor/sale/return/group yüzeyleri) incelendi. **Anlamına gelmez:** ledger/accounting engine, payment settlement, IYS/WhatsApp API entegrasyonu, SMS handset delivery, KVKK hukuki yeterlilik, aging bucket logic, return stock reversal, proforma→invoice conversion, RBAC veya immutable audit doğrulanmıştır.

**Kanıt notu:** Canlı UI gözlemi; backend/domain çıkarımı yoktur. Gerçek müşteri/hasta adı, telefon, kimlik, adres, e-posta, SMS Id, ürün adı, fiyat ve vergi no dokümana taşınmadı. Ödeme tipleri ve Direct Sale davranışları için → [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül). Randevu shell için → [Global Takvim (modül)](#global-takvim-modül). Patient workspace için → [Hasta Kartı / Patient Workspace](#hasta-kartı--patient-workspace). Devreden Bakiye / ekstre shell (hasta bağlamı) → [Ekstreler / finansal hareketler](#ekstreler--finansal-hareketler).

### Global menü envanteri (6/6)

| # | Ekran | Reviewed clinic/account | Not |
|---|---|---|---|
| 1 | Müşteriler | ~4318 kayıt | Directory → Müşteri Kartı |
| 2 | Müşteri Ödemeleri | ~5487 kayıt | Global payment list |
| 3 | Müşteri Ekstreleri | ~10941 kayıt | Global statement lines |
| 4 | Müşteri Satış Faturaları | Müşteri filtresi zorunlu | Print variants |
| 5 | Müşteri İade Faturaları | Liste **empty** | Yeni form açıldı; save yok |
| 6 | Müşteri Grupları | 4 configured group | Ürün İndirimleri ile UI linkage |

### Müşteriler — global liste

**OBSERVED:** Serbest metin arama · Ara · Temizle · pagination · yaklaşık **4318** kayıt. Kolonlar: Adı · Kayıt Tarihi · Protokol No · Kart No · Gsm · Email · Şehir · Borç · Ödeme · Bakiye · Durum (ör. **Aktif**). Müşteri adına tıklanınca **Müşteri Kartı** açılıyor. Yalnızca müşteri directory/master list UI kanıtı (CRM pipeline, merge, householding iddiası yok).

### Müşteri Kartı — shell

**OBSERVED — üst özet:** müşteri adı · Borç · Ödeme · Bakiye · **+ Hasta** · **Sms** · **Sil**.

**OBSERVED — ana sekmeler:** Ana · İletişim · Adres · Özel · Notlar.

**OBSERVED — Hastalar paneli:** **Aktif** · **Pasif / Vefat / Sahibi Değişmiş** (tam lifecycle modeli NOT VERIFIED).

**OBSERVED — sol operasyon menüsü (müşteri-scoped workspace):**

- *Finansal:* Ödeme Geçmişi (+) · Doğrudan Satış Geçmişi (+) · Bakiye İndirim Geçmişi (+) · Proformalar (+) · Ekstreler >
- *Randevu & Muayene:* Randevular (+) · Muayene Geçmişi
- *Diğer:* Dosyalarım · Whatsapp · KVKK · Ana sayfa

Müşteri Kartı yalnız CRUD profil değil; müşteri bağlamında finansal, randevu, klinik geçmiş, dosya, iletişim ve consent yüzeylerine erişim sağlayan **workspace/shell** (domain architecture kararı değil).

#### Ana sekme

**OBSERVED:** Adı Soyadı · Protokol No · Kart No · Gsm · Kimlik No · Mobil Kullanıcı Adı · Mobil Şifre (masked) · Doğum Tarihi · İletişim Tipi · Açıklama. İletişim Tipi’nde kanal tag’leri (ör. SMS · Email). Mobil şifre yanında dairesel aksiyon ikonu (reset/regenerate **test edilmedi** — action icon observed only). Hastalar paneli Ana altında da görünür.

#### İletişim sekme

**OBSERVED:** Erişilebilir İletişim (kanal tag’leri; GSM · Email örneği) · Email · Tel 1 · Tel 1 Hakkında · Tel 2 · Tel 2 Hakkında · ülke kodu · **IYS** · **IYS’ye Kayt** (buton gözlendi; **çalıştırılmadı**). IYS workflow · consent sync · status query · opt-in/out lifecycle NOT VERIFIED.

#### Adres sekme

**OBSERVED:** Ülke · Şehir · İlçe · Köy - Mahalle · Adres · **Harita Üzerindeki Konumu**. Harita UI · “Seçime Başla” benzeri seçim akışı · attribution **Leaflet / OpenStreetMap** render. Reverse geocoding · coordinate persistence · address validation · map provider architecture · routing NOT VERIFIED.

#### Özel sekme

**OBSERVED:** Durum · Beni Uyar · Müşteri Grubu · Meslek · İlgili Kişi · Sahiplenmek İster · Sahiplenme Bilgisi · Tüzel Mi · Tüzel Adı (Ünvan) · Vergi No · Vergi Dairesi · Bilgi · Pasif Nedeni. Customer metadata/profile capability. “Beni Uyar” davranışı NOT VERIFIED. Tüzel alanlar aynı kartta; ayrı corporate-account architecture iddiası yok.

#### Notlar sekme

**OBSERVED:** Satır bazlı not grid — Sil · Not Tarihi · Oluşturan · Not · **Ekle**. Note permissions · history/versioning · audit immutability NOT VERIFIED.

### Ödeme Geçmişi (müşteri-scoped)

**OBSERVED:** Tarih aralığı · liste · işlem menüsü · footer toplamları. Kolonlar: İşlemler · İşlem Tipi · Oluşturan · İşlem Tarihi · Hasta · İşlem No · Borç · Ödeme (ör. işlem sınıfları: **Doğrudan Satış Fatura Ödemesi** vb.). **İşlemler:** Düzenle · Ödeme Fişi · Sil. Ödeme Fişi → print/report render (ödeme tipi · tutar · toplam · PDF/download/print UI). Settlement/accounting iddiası yok.

### Global Müşteri Ödemeleri

**OBSERVED:** Tarih Aralığı · Arama Metni · Ara · Temizle · yaklaşık **5487** kayıt. Kolonlar: İşlemler · İşlem Tipi · İşlem Tarihi · Müşteri · Hasta Adı · İşlem No · Borç · Ödeme. İşlem tipleri (ör.): **Ziyaret Fatura Ödemesi** · **Genel Ödeme** · **Doğrudan Satış Fatura Ödemesi**. **İşlemler:** Düzenle · Sil. Detay örneği: ziyaret/satış toplamı · ödeme toplamı · İşlem No · Açıklama · Ödeme Detayları (Ödeme Tipi · İşlem Tarihi · Makbuz No · Tutar · kasa · Belge No · Ekle · Kaydet). Ödeme tipleri → [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül) (Nakit/Kredi Kartı/Çek/Senet/Banka Transferi Ödeme; duplicate prose yok).

### Doğrudan Satış Geçmişi (müşteri-scoped)

**OBSERVED:** Tarih aralığı · örnekte 2 kayıt · expand row (ürün satırları: Ürün · Toplam · Miktar · Birim · Depo; ödeme satırları: Ödeme Tipi · Tutar · Makbuz No · Kasa · Banka · Banka Hesabı · Pos Hesabı). **İşlemler (OBSERVED):** İncele · Düzenle · Ödeme · **Sms Gönder** · Kopyala · Fatura (3 lü) · Fatura · Bilgi Fişi · Hesap Ekstresi · Hesap Ekstresi (Detaylı) · Sil. Authorization · delete dependency · invoice numbering · fiscal finalization NOT VERIFIED.

#### SMS (Doğrudan Satış Geçmişi)

**OBSERVED — live interaction:** **Sms Gönder** sonrası **Durum** modalı — hesap/müşteri etiketi · GSM · **SMS Id** · yeşil check indicator. *SMS action returned a status modal containing a generated SMS ID and a green success indicator; downstream carrier delivery semantics were not verified.* Gerçek SMS Id/GSM dokümanda yok.

#### WhatsApp (Müşteri Kartı)

**OBSERVED:** Whatsapp aksiyonu/ekranı kişiye mesaj için **WhatsApp handoff** (rich in-app inbox/thread manager gözlemlenmedi). [Global Takvim (modül)](#global-takvim-modül) WhatsApp Web handoff ile uyumlu. Official WhatsApp Business API · server-side send · delivery/read sync · conversation history sync NOT VERIFIED.

### Bakiye İndirim Geçmişi (müşteri-scoped)

**OBSERVED:** **Kayıt bulunamadı** (empty). Kolonlar: İşlemler · İşlem Tarihi · Toplam · Açıklama · plus/new. **Yeni Bakiye İndirimi** formu: Müşteri Bakiyesi · İşlem Tarihi · İskonto · Açıklama · Kaydet — **kayıt yapılmadı**. Balance mutation · ledger · discount accounting · undo/reversal NOT VERIFIED (balance adjustment UI exists).

### Proformalar (müşteri-scoped)

**OBSERVED liste:** empty · İşlemler · İşlem Tarihi · Veteriner · Oluşturan · Toplam · plus/new. **Yeni Proforma:** İşlem Tarihi · Veteriner · Açıklama · Barkod/QR · Depo · Ürün · Miktar · Fiyat · İskonto · Toplam · Ekle · Operasyon Paketi... · Genel İndirim · Genel Toplam · Kaydet — **kayıt yapılmadı**. Estimate/proforma authoring shell. Conversion · approval · expiration · deposit · invoice conversion NOT VERIFIED.

### Ekstreler (müşteri-scoped)

**OBSERVED submenu:** Ekstreler · Hesap Ekstresi · Hesap Ekstresi (Detaylı) · **Yaşlandırma**.

**Ekstreler listesi:** tarih aralığı · **Giriş / Çıkış** direction badges · işlem tipi · açıklama · işlem tarihi · fatura no · hasta · toplam · expandable rows (ürün + ödeme satırları). Giriş/Çıkış = UI presentation; accounting debit/credit model iddiası yok.

**Hesap Ekstresi raporu:** Tarih Aralığı · **Devreden Bakiye** · Filtrele · PDF · download · print; render kolonları (hareket tipi · fatura/makbuz no · iskonto · borç · ödeme · bakiye vb.). Devreden Bakiye semantics → [Ekstreler / finansal hareketler](#ekstreler--finansal-hareketler) (NOT VERIFIED).

**Hesap Ekstresi (Detaylı):** Aynı filtre shell; satır altında ürün/service · depo · miktar · birim fiyat/tutar benzeri detay + ödeme kasa/tutar detayı — summary vs detailed statement ayrımı OBSERVED.

**Yaşlandırma:** Müşteri · gsm · borç · ödeme · bakiye + fatura tarihi/tipi/tutar/ödenen/kalan satırları; PDF/download/print. Klasik 0–30 / 31–60 / 61–90 **aging bucket kolonları gözlemlenmedi** — bucket logic · overdue classification · due date engine NOT VERIFIED.

### Global Müşteri Ekstreleri

**OBSERVED:** Tarih aralığı · arama · yaklaşık **10941** kayıt. Kolonlar: İşlemler · İşlem Tipi · Açıklama · İşlem Tarihi · Fatura No · Müşteri · Bakiye · Hasta Adı · Veteriner · Toplam. İşlem Tipi **Giriş / Çıkış** badge’leri. **Düzenle** row action. Customer-scoped Ekstreler ile cross-reference.

### Müşteri Satış Faturaları (global)

**OBSERVED:** Tarih Aralığı · **Müşteri** (zorunlu; boşken validation). Liste: İşlem Tipi · İşlem Tarihi · Fatura No · Toplam · Yazdırıldı · Yazdırılma Tarihi · Hasta · Veteriner (ör. **Doğrudan Satış** · **Ziyaret Faturası**). Üst: **Fatura** · **Fatura (3 lü)**; checkbox seçimi.

### Fatura / print variants

**OBSERVED (bu tur):** Satış Faturası · Üçlü Satış Faturası (üç kopya layout) · Toplu Satış Faturası (tarih · fatura öneki/no · Filtrele · Onayla) · Bilgi Fişi · Ödeme Fişi. Genel: printable render · PDF · download · print. Satış Faturası’nda invoice prefix/no · **Onayla** alanları görüldü. Fiscal issuance · tax authority · e-Fatura · immutable invoice number assignment iddiası yok.

### Müşteri İade Faturaları (global)

**OBSERVED liste (empty):** Tarih aralığı · arama · Ara · Temizle · Yeni Kayıt. Kolonlar: İşlemler · İşlem Tarihi · Fatura No · Müşteri · Genel Toplam · Ödeme · Bakiye.

**OBSERVED — Yeni İade Faturası (save yok):** Müşteri · İşlem Tarihi · Fatura No · **Stok Hareketini Engelle** (Evet/Hayır) · Açıklama · Barkod/QR · Depo · Ürün · Miktar · Fiyat · İskonto · Toplam · Ekle · genel indirim/totals. Return stock reversal · original-sale matching · refund · credit note · e-invoice return NOT VERIFIED.

### Müşteri Grupları (global)

**OBSERVED:** **4** configured customer group; İşlemler · Kod · Adı · Durum; Düzenle · Sil; Yeni Kayıt. **Tanım:** Durum · Kod · Adı · Kaydet · Kaydet / Yeni. [Ürün (modül)](#ürün-modül) Ürün İndirimleri formunda Müşteri Grubu selector linkage (UI). Automatic pricing · discount precedence · inheritance · auto membership NOT VERIFIED.

### Randevular (müşteri-scoped)

**OBSERVED:** Seçili müşteride liste empty. Kolonlar (ör.): İşlemler · Tarih · Hasta · Aşı Paketi · Görev Tipi · Açıklama · Bölüm. **Yeni Randevu:** Görev Tipi · Bölüm · Veteriner · Durum · Tarih · Süre (dk) · Hasta · Aşı Paketi · Bilgi · Açıklama · Kaydet. Durum: **Randevu** · **Gelmedi** · **Tamamlandı**. Randevu workflow → [Global Takvim (modül)](#global-takvim-modül); müşteri kartından erişim ayrıca kayıtlı.

### Muayene Geçmişi (müşteri-scoped)

**OBSERVED:** Tarih aralığı · seçili müşteride **empty**. Kolonlar: İşlem Tarihi · Hasta · Veteriner · Teşhis · Açıklama · Toplam. Müşteri seviyesinde clinical-history aggregation entry point; encounter detail navigation NOT VERIFIED.

### Dosyalarım (müşteri-scoped)

**OBSERVED:** empty · İşlem Tarihi · Bilgi · Dosya · search · Ekle · Kaydet. [Dosyalarım (attachments)](#dosyalarım-attachments) patient pattern ile benzer; customer-scoped attachment UI. Storage/version/MIME/ACL NOT VERIFIED.

### KVKK (müşteri-scoped)

**OBSERVED:** Printable **KVKK consent/report** — clinic-specific consent text (metin **kopyalanmadı**) · Kabul Ediyorum / Kabul Etmiyorum checkbox’ları · Veri Sahibi · Adı Soyadı · Tarih · İmza; PDF/download/print. *Customer-scoped printable KVKK consent template/report observed.* Legal adequacy requires independent validation. Digital capture · revocation · valid consent workflow iddiası yok.

---

### Müşteri — önemli gözlemler

**OBSERVED UI composition:** Tek müşteri context’inde master/profile · linked patients · payments · direct sales · balance adjustments · proformas · statements/reports · appointments · exam history · files · WhatsApp handoff · KVKK erişilebilir.

**INFERRED (dikkatli):** Müşteri alanı, gözlenen UI’da operasyonel ve finansal işler için context-preserving launch point işlevi görüyor (backend “customer workspace” modeli iddiası değil).

---

### Müşteri — VETINITY IMPLICATION

*(Nötr ürün dersi; implementation kararı veya E-Vet kopyalama değil.)*

- Customer workspace, ilgili finansal, iletişim ve klinik workflow’lara context koruyarak geçiş için değerlendirilebilir.
- Statement/invoice print variants çok sayıda; hangi belgenin resmi/fiscal olduğu kullanıcıya net olmalı (E-Vet’te doğrulanmadı).
- Aging adı vs içerik uyumu kullanıcı beklentisi riski taşıyabilir.
- IYS/KVKK/SMS yüzeyleri compliance review gerektirir; UI varlığı yeterlilik kanıtı değildir.

---

### Müşteri — Backlog cross-reference

| Aday | Karar | Gerekçe |
|---|---|---|
| CHECKOUT-001 | NO MATCH | Ziyaret checkout orkestrasyonu ≠ müşteri ödeme listesi |
| PORTAL-005 | NO MATCH | Dijital onam/imza ≠ printable KVKK şablonu |
| INT-005 | NO MATCH | e-Fatura/e-SMM ≠ fatura print UI |
| REPORT-007 | NO MATCH (ek not gerekmez) | Zaten Rapor/ekstre export shell; müşteri kanıtı aynı capability family — competitor evidence bu belgede |
| APPT-* | NO MATCH | Online booking backlog; klinik içi randevu shell Takvim’de |

**Potential backlog gaps (kayıt açılmadı):** customer master/workspace · customer-scoped financial history · balance discount UI · proforma · customer return invoice · aging/receivables report semantics · customer group segmentation.

---

### Müşteri — TBD / NOT OBSERVED

Ledger/accounting engine · payment settlement/gateway · bank reconciliation · discount precedence/stacking · customer-group automatic pricing · invoice fiscal finalization · e-Fatura mapping · IYS lifecycle · SMS delivery/read/retry · WhatsApp API · map geocoding persistence · mobile login integration · soft/hard delete · RBAC · return stock reversal · proforma conversion · aging buckets · concurrent edit on payments · audit immutability · Giriş/Çıkış = debit/credit · Bakiye = immutable ledger balance.

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

*(Ekran bazlı inceleme ve status → [Hasta (modül)](#hasta-modül). Patient clinical workspace → [Hasta Kartı / Patient Workspace](#hasta-kartı--patient-workspace).)*

---

## Hasta (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-01).

**Kapsam notu:** Bu bölüm **üst menü Hasta** alanını kapsar (reference/configuration + owner transfer). **Hasta Kartı / Patient Workspace** ayrı pass’te **REVIEWED / CLOSED**; klinik hasta bulma/liste davranışı [Hasta Kabul](#landing--hasta-kabul) ve müşteri bağlantılı workspace’lerde ayrı ele alınmıştır.

**CLOSED anlamı:** 8/8 global menü ekranı incelendi. **Anlamına gelmez:** owner transfer side-effect’leri, reference-data scope (tenant/clinic), delete dependency, age-group auto-classification, breed predisposition clinical rules veya patient-group business semantics doğrulanmıştır.

**UI organization (OBSERVED):** Bu üst menüde doğrudan **Hasta Listesi** ekranı gözlemlenmedi; menü ağırlıklı olarak patient reference/configuration data ve **Hasta Sahibi Değiştirme** operasyonundan oluşuyor.

### Global menü envanteri (8/8)

| # | Ekran | Reviewed clinic/account | Not |
|---|---|---|---|
| 1 | Hasta Sahibi Değiştirme | Form açıldı; **Kaydet çalıştırılmadı** | Owner transfer operation UI |
| 2 | Hasta Türleri | ~13 kayıt | Species/type config |
| 3 | Hasta Irkları | ~503 kayıt | Tür altında gruplu |
| 4 | Renkler | ~43 kayıt | Simple reference data |
| 5 | Hasta Yaş Grupları | ~24 kayıt | Tür altında gruplu; gün aralığı |
| 6 | Besin Tipleri | 9 kayıt | Nutrition type config |
| 7 | Cinsiyetler | 6 kayıt | Gender vocabulary |
| 8 | Hasta Grupları | **0 configured** (`Kayıt bulunamadı`) | Form açıldı; kayıt oluşturulmadı |

### Hasta Sahibi Değiştirme

**OBSERVED:** Ayrı operasyon ekranı — **Eski Sahip** (searchable/selectable) · **Hasta** (eski sahip bağlamında seçim) · **Yeni Sahip** (searchable/selectable) · **Kaydet** · **Geri Dön**. Canlı sahip değişikliği **yapılmadı**.

**OBSERVED (UI):** Owner change, sıradan patient-profile edit alanı değil; explicit operasyon ekranı.

**NOT VERIFIED:** ownership history · effective date · transfer reason · audit trail · approval · undo/reversal · old-owner access · clinical history transfer semantics · financial balance/invoice ownership · consent · notification · duplicate-owner handling · patient status transition · related records moving with the animal.

### Hasta Türleri

**OBSERVED — liste (reviewed clinic/account, ~13):** İşlemler · Adı · Öncelik No · Durum (Aktif/Pasif örnekleri); **Düzenle** · **Sil**; Yeni Kayıt.

**OBSERVED — Hasta Tür Tanımı:** Durum · Adı · **İkon** · Öncelik No · Kaydet · Kaydet / Yeni.

**NOT VERIFIED:** tenant/clinic/system-global scope · built-in values deletable · delete blocked by existing patient dependency. Bireysel tür adları katalog olarak kopyalanmadı.

### Hasta Irkları

**OBSERVED — liste (~503):** Patient type/species **grup başlıkları** altında breed satırları; İşlemler · Adı · Öncelik No · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Irk Tanımı:** Durum · **Hasta Türü** (configured types) · Adı · Öncelik No · **Predispozisyon Irkı** (selectable field) · Kaydet · Kaydet / Yeni.

Breed definition contains a selectable field labelled **Predispozisyon Irkı**; the downstream clinical/business semantics were **not verified** (genetic predisposition · disease-risk mapping · clinical alerts · synonym mapping — iddia edilmez).

### Renkler

**OBSERVED — liste (~43):** İşlemler · Adı · Öncelik No · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Renk Tanımı:** Durum · Adı · Öncelik No · Kaydet · Kaydet / Yeni. Simple configurable patient reference data. Species-specific filtering · genetic/pedigree mapping NOT VERIFIED.

### Hasta Yaş Grupları

**OBSERVED — liste (~24):** Tür/species altında gruplu; kolonlar İşlemler · **Cinsiyet** · Adı · **Alt Gün** · **Üst Gün** · Öncelik No · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Hasta Yaş Grubu Tanımı:** Durum · Hasta Türü · Cinsiyet · Adı · Alt Gün · Üst Gün · Öncelik No · Kaydet · Kaydet / Yeni. Mevcut kayıt örnekleri yapısal olarak configured type + gender + label + lower/upper day boundary gösteriyor.

**OBSERVED (configuration surface):** Species/gender/day-range based age-group configuration UI (`Hasta Türü + Cinsiyet + Ad + Alt Gün + Üst Gün`); basit enum değil.

**OBSERVED — Cinsiyet dropdown (Yaş Grubu formu):** Bilinmiyor · Dişi · Erkek · Kısır · Kısırlaştırılmış Dişi · Kısırlaştırılmış Erkek (aynı vocabulary [Cinsiyetler](#cinsiyetler) ekranında da görüldü; shared backend/FK iddiası yok).

**NOT VERIFIED:** automatic patient classification from birth date · age-group drives pricing/vaccination/protocols · recalculation rules.

### Besin Tipleri

**OBSERVED — liste (9 kayıt; görünen örnekler aktif):** İşlemler · Adı · Öncelik No · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Besin Tipi Tanımı:** Durum · Adı · Öncelik No · Kaydet · Kaydet / Yeni. Nutrition/feeding type reference data UI. Patient card linkage · dietary plan · product linkage NOT VERIFIED.

### Cinsiyetler

**OBSERVED — liste (6 kayıt, aktif):** İşlemler · Adı · Öncelik No · Durum; Yeni Kayıt. Visible vocabulary: Bilinmiyor · Dişi · Erkek · Kısır · Kısırlaştırılmış Dişi · Kısırlaştırılmış Erkek.

**OBSERVED — Cinsiyet Tanımı:** Durum · Adı · Öncelik No · Kaydet · Kaydet / Yeni.

**OBSERVED (UI model):** Gender/reproductive-status-like labels aynı reference listesinde sunuluyor; biological sex vs reproductive status ayrımı **yeniden yorumlanmadı** — E-Vet UI modeli olduğu gibi kaydedildi.

### Hasta Grupları

**OBSERVED — liste (reviewed clinic/account):** `Kayıt bulunamadı` (0 configured group). Kolonlar İşlemler · Kod · Adı · Durum; Yeni Kayıt.

**OBSERVED — Hasta Grup Tanımı:** Durum · Kod · Adı · Kaydet · Kaydet / Yeni — **kayıt oluşturulmadı**.

**NOT VERIFIED:** membership assignment · automatic grouping · reporting/pricing/reminder/campaign/clinical/hospitalization use · customer-group relation · permissions. Müşteri Grupları ile **aynı semantics varsayılmaz**.

---

### Hasta — Reference-data pattern (cross-screen)

**OBSERVED UI pattern** (Türler · Irklar · Renkler · Besin Tipleri · Cinsiyetler · benzeri):

- Liste: Yeni Kayıt · arama · pagination · İşlemler · Düzenle · Sil · Adı · Öncelik No · Durum
- Tanım: Durum · Adı · (çoğunda) Öncelik No · Kaydet · Kaydet / Yeni
- Domain-specific: Tür → İkon; Irk → Hasta Türü + Predispozisyon Irkı; Yaş Grubu → Hasta Türü + Cinsiyet + Alt/Üst Gün; Hasta Grubu → Kod

Rakip UI/configuration observation; yeni `PATTERN-*` veya Vetinity implementation kararı değil.

---

### Hasta — Global menü vs Patient Workspace

| Yüzey | Bu tur (üst menü Hasta) | Önceden CLOSED ([Hasta Kartı](#hasta-kartı--patient-workspace)) |
|---|---|---|
| Odak | Owner transfer · species/breed/color/age-group/nutrition/gender/patient-group **configuration** | Clinical/operational patient workspace (ziyaret, muayene, lab, PACS, aşı, dosya, ekstre, vb.) |
| Hasta listesi | Üst menüde **gözlemlenmedi** | Hasta Kabul / müşteri bağlamı / kart navigasyonu |

---

### Hasta — VETINITY IMPLICATION

*(Nötr ders; backlog kararı veya MVP commitment değil.)*

- Species/breed/color gibi veterinary reference data için configurable master-data, hard-coded enum’lara göre tenant/domain flexibility sağlayabilir (E-Vet scope/enforcement doğrulanmadı).
- Ownership transfer, normal patient editing’den farklı lifecycle/audit ihtiyaçları taşıyan **explicit operation** olarak ele alınabilir (E-Vet transfer semantics doğrulanmadı).
- Age-group configuration, species ve gender vocabulary’sine bağlı rule-like reference data ihtiyacını gösteriyor (auto-classification engine iddiası yok).

---

### Hasta — Backlog cross-reference

**Exact-match bulunamadı; backlog değiştirilmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| UX-003 / UX-004 | NO MATCH | Vetinity IA (Türler/Irklar Tanımlar altında); E-Vet üst menü Hasta yapısı kanıtı değil |
| PORTAL-002 | NO MATCH | Portal hayvan profili; global reference-data admin değil |
| (owner transfer) | NO MATCH | Backlog’da dedicated owner-transfer ID yok; profile edit ≠ transfer operation |

**Potential gaps (kayıt açılmadı):** owner transfer operation · species/breed/color/age-group/gender reference admin · patient groups · breed predisposition field semantics.

---

### Hasta — TBD / NOT OBSERVED

Owner transfer side-effects · reference-data tenant/clinic scope · delete referential integrity · breed predisposition downstream use · age-group auto-calculation · nutrition type clinical linkage · patient group business use · retroactive config propagation · built-in vs custom value lifecycle.

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

*(Ekran bazlı inceleme ve status → [Muayene (modül)](#muayene-modül). Operasyonel worklist → [Global Muayene Odası (modül)](#global-muayene-odası-modül). Patient muayene/aşı workspace → [Hasta Kartı / Patient Workspace](#hasta-kartı--patient-workspace).)*

---

## Muayene (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-01).

**Kapsam notu:** Bu bölüm **üst menü Muayene** alanını kapsar (13/13). **[Global Muayene Odası](#global-muayene-odası-modül)** sol menü worklist/routing yüzeyidir (**ayrı CLOSED**). **[Hasta Kartı](#hasta-kartı--patient-workspace)** içindeki Muayene Geçmişi, Yeni Muayene ve hasta-bazlı Aşı Programı UI **ayrı** patient workspace kanıtıdır — bu pass global üst menü configuration ve seçili operasyon listelerini kapsar.

**CLOSED anlamı:** 13/13 ekran incelendi (çoğunda save/posting veya resmi entegrasyon **çalıştırılmadı**). **Anlamına gelmez:** e-Reçete/ATS/HBS resmi gönderim, otomasyon motorları, stok/fatura side-effect, clinical decision support veya reminder delivery doğrulanmıştır.

**UI organization (OBSERVED):** Üst menü Muayene, yalnızca encounter ekranı değil; operasyonel listeler (reçete, aşılanmamış takip, ATS görünümü) ile reusable clinical vocabulary, aşı/tedavi paket-template tanımları ve treatment-monitoring parameter configuration’ı aynı navigation altında topluyor (rakip IA observation; Vetinity mimari kararı değil).

### Global menü envanteri (13/13)

| # | Ekran | Reviewed clinic/account | Not |
|---|---|---|---|
| 1 | Reçete | ~662 mevcut kayıt | Mevcut detay + yeni form açıldı; **yeni reçete Kaydet çalıştırılmadı**; print **InternalServerError** |
| 2 | ATS Listesi | 0 kayıt (geniş tarih) | Yeni Kayıt **gözlemlenmedi** |
| 3 | Aşı Paketleri | ~58 kayıt | Template + İlgili Aşı Paketi linkage |
| 4 | Aşı Programları | 0 configured | Form açıldı; **kaydedilmedi** |
| 5 | Aşılanmamış Hasta Takibi | ~1948 kayıt | → patient Aşı Programı handoff |
| 6 | Muayene Özellikleri | ~29 kayıt | Özellik Tipi grupları |
| 7 | Semptomlar | ~1435 kayıt | Reference vocabulary |
| 8 | Teşhisler | ~1170 kayıt | Reference vocabulary |
| 9 | Operasyon Paketleri | 0 configured | Form; **kaydedilmedi** |
| 10 | Tedavi Paketleri | 0 configured | Form; **kaydedilmedi** |
| 11 | Tedavi Şablonları | 1 kayıt | Serbest metin İçerik |
| 12 | Tedavi Takip Parametreleri | 15 kayıt | Veri tipleri + conditional fields |
| 13 | Tedavi Takip Parametre Paketleri | 0 configured | Form; **kaydedilmedi** |

### Cross-surface grouping (UI)

| Grup | Ekranlar |
|---|---|
| **A — Operational / patient-facing handoffs** | Reçete · ATS Listesi · Aşılanmamış Hasta Takibi → [Hasta Kartı](#hasta-kartı--patient-workspace) Aşı Programı |
| **B — Reusable clinical configuration** | Aşı Paketleri · Aşı Programları · Muayene Özellikleri · Semptomlar · Teşhisler · Operasyon Paketleri · Tedavi Paketleri · Tedavi Şablonları · Tedavi Takip Parametreleri · Tedavi Takip Parametre Paketleri |

---

### Reçete

**OBSERVED — Global Reçete Listesi (reviewed clinic/account, ~662 mevcut kayıt):** Tarih Aralığı · Arama Metni · kolonlar İşlemler · İşlem Tarihi · e-Reçete No · Veteriner · Müşteri · Hasta · Seri No · Cilt No · Sıra No · Yazdırıldı; satır **Düzenle** · **Yazdır** · **Sil**; **Yeni Kayıt**.

**OBSERVED — mevcut reçete:** Listeden bir kayıt açıldı; **Reçete Tanımı** form alanları incelendi — Reçete Tipi · İşlem Tarihi · Seri No · Cilt No · Sıra No · Bölüm · Veteriner · Müşteri · Hasta · e-Reçete No · Yazdırıldı · Onayla · Açıklama (expandable). Ürün satırı: Ürün · Miktar · Birim · Yazdır · Bilgi · Doz · Kullanım Yeri · Tedavi Süresi · Periyodik Kullanım Süresi · Sık Kullanılanlara Ekle · Ekle; **Sık Kullanılanlar...** · **Kayıtsız Ürünler...** aksiyonları.

**OBSERVED — yeni reçete:** **Yeni Kayıt** ile boş/yeni **Reçete Tanımı** ekranı da açıldı (aynı form yüzeyi).

**OBSERVED — Kayıtsız Ürünler modalı:** Ürün · Kullanım Miktarı; incelenen kayıtta `Kayıt bulunamadı`.

**OBSERVED — Bölüm dropdown örnekleri (tam enum değil):** Dış Klinik · Hasta Odası · Klinik · Muayene Odası - 2 · Traş.

**OBSERVED — Birim dropdown:** Adet · Damla ve laboratuvar/sayısal görünümlü diğer unit etiketleri; UI’da geniş unit vocabulary görünür (**shared backend unit table iddiası yok**).

**NOT live:** Yeni reçete için **Kaydet çalıştırılmadı** — review sırasında **yeni prescription create/save doğrulanmadı** (mevcut ~662 kayıt listesi ve açılan mevcut detay bununla çelişmez).

**OBSERVED — Yazdır:** Reçete rapor ekranı açıldı; sol tarafta Seri/Cilt/Sıra + **Onayla**; PDF/download/Yazdır UI; rapor içerik alanı yüklenirken **“Request failed with status code InternalServerError”** — successful prescription report rendering/printing bu oturumda **VERIFIED DEĞİL**.

**NOT VERIFIED:** başarılı e-Reçete gönderimi · resmi entegrasyon · elektronik imza · HBS/ATS submission · regulator acceptance · print-state persistence · Onayla approval semantics · billing/stock effects.

---

### ATS Listesi

**OBSERVED:** Tarih Aralığı · Arama Metni · kolonlar İşlemler · İşlem Tarihi · Aşı Uygulama Belgesi Seri No · Veteriner · Müşteri · Hasta Adı · HBS Kimlik No. İncelenen geniş tarih aralığında **kayıt yok**. Görünür **Yeni Kayıt** aksiyonu **gözlemlenmedi**.

ATS kısaltmasının teknik açılımı **tahmin edilmedi**. HBS Kimlik No kolonundan otomatik entegrasyon/submission **çıkarılmadı**.

**NOT VERIFIED:** ATS veri gönderimi · resmi servis entegrasyonu · belge oluşturma akışı · retry/error handling · status lifecycle · successful submission.

---

### Aşı Paketleri

**OBSERVED — liste (reviewed clinic/account, ~58):** İşlemler · Adı · İlgili Aşı Paketi · Günler · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Aşı Paketi Tanımı:** Durum · Adı · Şablon · İlgili Aşı Paketi · Günler · Kaydet · Kaydet / Yeni. Mevcut örneklerde gün değerleri ve bir paketin başka **İlgili Aşı Paketi** ile ilişkilendirilebildiği görüldü; Şablon dropdown clinic-configured template kayıtları listeler.

**OBSERVED (UI):** Package definition supports template selection and optional linkage to another vaccine package with a day interval (UI-level wording).

**NOT VERIFIED:** recurrence engine · automatic future appointment creation · reminder engine · dependency enforcement · chain execution semantics.

---

### Aşı Programları

**OBSERVED — liste:** Yeni Kayıt; reviewed account’ta `Kayıt bulunamadı`.

**OBSERVED — Aşı Program Tanımı:** Durum · Adı · satır tablosu Aşı Paketi · Günler · Sil · **Ekle** · Kaydet. Aşı Paketi dropdown mevcut paketleri gösterir.

**NOT live:** Yeni program **kaydedilmedi**.

**NOT VERIFIED:** programa bağlı hasta planı yayılımı · otomatik takvim/randevu · reminder generation · package chain expansion · conflict resolution.

---

### Aşılanmamış Hasta Takibi

**OBSERVED — global liste (reviewed clinic/account, ~1948):** Arama Metni · kolonlar İşlemler · Hasta · Yaş · Tür / Irk · Müşteri · GSM; satır aksiyonu **Aşı Programı...** (gerçek ad/telefon dokümana **taşınmadı**).

**OBSERVED — handoff:** Aksiyon hasta workspace **Hasta Aşı Programı** ekranına yönlendirdi ([Hasta Kartı](#hasta-kartı--patient-workspace) patient-context Aşı Programı UI ile ilişkili yüzey; ayrı pass).

**OBSERVED — Hasta Aşı Programı formu:** Bölüm · Veteriner · Süre (dk) · Tarih · Aşı Programı selector · **Oluştur** · alt grid Tarih · Aşı Paketi · Sil · Ekle · Kaydet.

**NOT live:** **Oluştur** ve **Kaydet** **çalıştırılmadı**.

**OBSERVED (UI handoff):** Global unvaccinated-patient tracking surface → patient-scoped vaccine program workflow handoff at UI level.

**NOT VERIFIED:** aşısız sayılma algoritması · age/species eligibility · missed-dose detection · automatic campaign · SMS generation · schedule persistence.

---

### Muayene Özellikleri

**OBSERVED — liste (reviewed clinic/account, ~29):** Kayıtlar **Özellik Tipi** başlıkları altında gruplanmış (ör. Dehidrasyon Derecesi · Lenf Yumruları); İşlemler · Adı · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Muayene Özellik Tanımı:** Durum · Özellik Tipi · Adı.

**OBSERVED — Özellik Tipi dropdown örnekleri (tam enum değil):** Kıl Örtüsü Yapısı · Mukus Membranları · Lenf Yumruları · Dehidrasyon Derecesi · Genel Durum · Semptomlar · Hastalık Teşhisi · Bulaşıcı Hastalık.

**OBSERVED (UI):** Configurable examination-property vocabulary grouped by visible examination property types.

**NOT VERIFIED:** patient examination form render · scoring · required-field rules · diagnosis automation · clinical decision support.

---

### Semptomlar

**OBSERVED — liste (reviewed clinic/account, ~1435):** Adı · Durum; Düzenle · Sil; Yeni Kayıt; search · pagination. Configurable reference-data management surface; list + **Yeni Kayıt** + **Düzenle** / **Sil** controls observed.

**OBSERVED — Semptom Tanımı:** Durum · Adı · Kaydet · Kaydet / Yeni.

**NOT live / NOT VERIFIED:** create · update · delete mutation behavior **exercised değil** · symptom–diagnosis mapping · coding standard · SNOMED.

---

### Teşhisler

**OBSERVED — liste (reviewed clinic/account, ~1170):** Adı · Durum; Düzenle · Sil; Yeni Kayıt; search · pagination. Configurable reference-data management surface; list + **Yeni Kayıt** + **Düzenle** / **Sil** controls observed.

**OBSERVED — Teşhis Tanımı:** Durum · Adı.

**NOT live / NOT VERIFIED:** create · update · delete mutation behavior **exercised değil** · ICD/SNOMED/code mapping · structured coding · diagnosis hierarchy · symptom-to-diagnosis recommendation · automatic decision support.

---

### Operasyon Paketleri

**OBSERVED — liste:** Yeni Kayıt; reviewed account’ta `Kayıt bulunamadı`.

**OBSERVED — Operasyon Paket Tanımı:** Durum · Adı · satır grid Ürün · Miktar · Ücretsiz (checkbox) · Sil · Ekle · Kaydet.

**NOT live:** Yeni paket **kaydedilmedi**.

**OBSERVED (UI):** Operation package definition can bundle product/service lines with quantity and per-line free-of-charge flag.

**NOT VERIFIED:** surgery workflow auto-population · stock deduction · invoice creation · package pricing · package execution semantics.

---

### Tedavi Paketleri

**OBSERVED — liste:** Yeni Kayıt; reviewed account’ta `Kayıt bulunamadı`.

**OBSERVED — Tedavi Paketi Tanımı:** Durum · Adı · satır alanları Ürün · Miktar · Birim · Periyodik Kullanım Süresi · Tedavi Süresi · Başlangıç Günü · Uygulama Yolu · Ücretsiz · Sil · Ekle · Kaydet. Süre alanlarında sayı + süre unit selector görünür.

**NOT live:** Yeni kayıt **kaydedilmedi**.

**OBSERVED (UI):** Treatment package definition supports reusable treatment-line configuration including quantity, unit, periodic-use duration, total treatment duration, start day, route and free-of-charge flag.

**NOT VERIFIED:** schedule generation · medication administration record · nurse task creation · stock/billing effects · clinical validation · dose calculation.

---

### Tedavi Şablonları

**OBSERVED — liste (reviewed clinic/account, 1 configured):** Adı · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Tedavi Şablonu Tanımı:** Durum · Adı · **İçerik** (büyük serbest metin) · Kaydet · Kaydet / Yeni.

**OBSERVED (UI):** Reusable named text treatment template.

**NOT VERIFIED:** rich-text structure · variable/token interpolation · automatic treatment creation · template versioning · smart fields.

---

### Tedavi Takip Parametreleri

**OBSERVED — liste (reviewed clinic/account, 15 kayıt):** İşlemler · Adı · Veri Tipi · Birim · Normal Aralık / Seçenekler · Durum; **kategori/group header** gruplama (ör. Vital · Klinik · Lab · Diğer).

**OBSERVED — örnek yapılar:** numeric vital + unit + normal range · selectable parameter + visible option values · text parameters · explanation-type parameter (liste örneklerinden; her tipin formu ayrıca doğrulanmadı).

**OBSERVED — Tedavi Takip Parametre Tanımı:** Durum · Adı · Kategori · İkon · Veri Tipi · Kaydet · Kaydet / Yeni.

**OBSERVED — Kategori dropdown:** Vital · Klinik · Lab · Davranış · Diğer.

**OBSERVED — Veri Tipi dropdown:** Sayısal · Seçimli · Metin · Açıklama.

**OBSERVED — İkon selector:** çeşitli clinic/medical style icon seçenekleri (backend kaynağı **tahmin edilmedi**).

**OBSERVED — Sayısal seçildiğinde:** Birim · Min Değer · Max Değer alanları görünür.

**OBSERVED — Seçimli seçildiğinde:** seçenek grid Sil · Metin · **Ekle**; yeni kayıt ekranında seçenek yokken `Kayıt bulunamadı`. Seçimli kayıt **kaydedilmedi**.

**OBSERVED — Metin / Açıklama:** Veri tipi seçenekleri mevcut; Açıklama tipi kayıt formunda base fields + Veri Tipi görüldü; ek validation/rendering behavior **türetilmedi**.

**OBSERVED (UI):** Configurable treatment-monitoring parameter model supports category, icon and multiple visible data types; numeric parameters expose unit/min/max, selectable parameters expose configurable option rows.

**NOT VERIFIED:** patient chart rendering · alerting from min/max · abnormal-value flags · trend charts · automatic lab ingestion · scoring · package application persistence.

---

### Tedavi Takip Parametre Paketleri

**OBSERVED — liste:** Yeni Kayıt; reviewed account’ta `Kayıt bulunamadı`.

**OBSERVED — Paket Tanımı:** Durum · Adı · line grid Parametre · Gün · Günde Kaç Kez · Başlangıç Günü · Sil · Ekle · Kaydet.

**NOT live:** Yeni kayıt **kaydedilmedi**.

**OBSERVED (UI):** Parameter-package configuration can group treatment-monitoring parameters with day, frequency-per-day and start-day values.

**NOT VERIFIED:** automatic schedule generation · observation task creation · treatment assignment behavior · reminders · patient persistence.

---

### Muayene — VETINITY IMPLICATION

*(Nötr ders; backlog kararı veya MVP commitment değil.)*

- Klinik vocabulary (semptom/teşhis/muayene özelliği) ve paket/template tanımlarının üst menü altında configurable master-data olarak sunulması, encounter ekranından ayrı admin yüzey ihtiyacını gösterir (E-Vet enforcement doğrulanmadı).
- Treatment-monitoring parameter tipi (sayısal min/max, seçimli option grid) structured observation config ihtiyacına işaret eder (chart/alert engine iddiası yok).
- Global reçete listesi + hasta bağlamı alanları, reçetenin hem registry hem clinical document yüzeyi olarak ele alındığını gösterir (resmi e-Reçete doğrulanmadı).

---

### Muayene — Backlog cross-reference

**Exact-match bulunamadı; backlog değiştirilmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| EXAM-001–015 | NO MATCH | Vetinity muayene **çalışma alanı** / encounter kaydı; E-Vet üst menü admin + global reçete listesi |
| EXAM-006 | NO MATCH | Muayene şablonları (structured exam note); E-Vet **Tedavi Şablonları** serbest metin |
| EXAM-007 | NO MATCH | Encounter-time bundle **uygulama**; E-Vet Tedavi/Operasyon **paket tanım** CRUD |
| EXAM-010 | NO MATCH | In-exam quick link; global Reçete modülü değil |
| RECORD-006 | NO MATCH | Unified dynamic record model; reference-data admin değil |

**Potential gaps (kayıt açılmadı):** global prescription registry · ATS/HBS linkage · vaccine package/program admin · unvaccinated tracking handoff · treatment monitoring parameter schema · e-Reçete print/report reliability.

---

### Muayene — TBD / NOT OBSERVED

e-Reçete successful print/PDF · Onayla persistence · ATS create/submit · aşı program rollout to patients · reminder/automation engines · reçete billing/stock · ICD/SNOMED · treatment package execution · monitoring alerts/trends · tenant scope · delete guards · audit guarantees.

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

*(Ekran bazlı inceleme ve status → [Laboratuvar (modül)](#laboratuvar-modül). Operasyonel worklist/istek → [Global Lab İstekleri](#global-lab-i̇stekleri-modül) · [Global Pacs İstekleri](#global-pacs-i̇stekleri-modül) · [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial). Patient lab history → [Hasta Kartı](#hasta-kartı--patient-workspace).)*

---

## Laboratuvar (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-03).

**Kapsam notu:** Bu bölüm **üst menü Laboratuvar** (7/7 configuration + comparison yüzeyleri). **Global Lab İstekleri** · **Pacs İstekleri** · **Xray İstekleri (PARTIAL)** sol menü operasyon kuyrukları **ayrı** pass’lerdir. **Test Grupları** tanımı [Global Xray (PARTIAL)](#global-xray-i̇stekleri-partial) pass’inde de kısmen görülmüştü; bu bölüm üst menü Laboratuvar kapsamını tamamlar — Xray **PARTIAL** statüsünü **değiştirmez**.

**CLOSED anlamı:** 7/7 ekran UI incelemesi tamamlandı. **Anlamına gelmez:** device/PACS/DICOM entegrasyonu çalışır, sonuç ingestion otomatik, lab comparison longitudinal veri render edildi, reference range otomatik uygulanır veya create/update/delete mutation doğrulanmıştır.

### Global menü envanteri (7/7)

| # | Ekran | Status | Reviewed clinic/account (özet) |
|---|---|---|---|
| 1 | Lab Sonuçları Karşılaştır | **REVIEWED / CLOSED** | Filtreler + export UI; başarılı comparison **not verified** |
| 2 | Test Grupları | **REVIEWED / CLOSED** | ~12 configured; detay + yeni form açıldı; **Kaydet çalıştırılmadı** |
| 3 | Test Grup Panelleri | **REVIEWED / CLOSED** | 5 configured panels |
| 4 | Test Referansları | **REVIEWED / CLOSED** | ~287 reference rows |
| 5 | Pacs Grupları | **REVIEWED / CLOSED** | ~21 configured; yeni form açıldı; **Kaydet çalıştırılmadı** |
| 6 | Cihazlar | **REVIEWED / CLOSED** | ~12 devices; yeni form açıldı |
| 7 | Laboratuvarlar | **REVIEWED / CLOSED** | 1 configured laboratory |

---

### Lab Sonuçları Karşılaştır

**OBSERVED — filtreler:** Tarih Aralığı · Müşteri · Hasta · Test Grubu · **Ara** · **Temizle**.

**OBSERVED — sonuç alanı kolonları:** Test · Birim · Min Değer · Max Değer.

**OBSERVED:** **Dışa Aktar (Excel)** aksiyonu.

**OBSERVED UX FRICTION — Müşteri → Hasta:** Müşteri seçildiğinde müşterinin hayvanı olmayan senaryoda **Hasta** selector UI’da görünmeye devam ediyor; dropdown açıldığında `Kayıt bulunamadı` (yalnız incelenen UI davranışı; backend bug / data integrity / tüm müşterilerde geçerli **iddia edilmez**).

**OBSERVED UX FRICTION — Test grubu keşfedilebilirliği:** Hasta seçilebildiğinde geçmişte hangi testlerin gerçekten çalışıldığı bu ekrandan görülemiyor; **Test Grubu** selector geniş/global configured test grupları sunuyor. Kullanıcı geçmiş uygulama bilgisi olmadan grup seçmek zorunda; seçilen hasta + test grubu kombinasyonlarında `Kayıt bulunamadı` görüldü. **Test Grubu** zorunlu alan validation’ı gözlemlendi.

**NOT VERIFIED:** başarılı longitudinal comparison render · tarih aralığında yan yana karşılaştırma semantiği · trend chart · analyte dönemsel değişim · abnormal flagging · cross-device normalization · reference-range reconciliation · export içeriği.

#### VETINITY IMPLICATION (product direction — implementation kararı değil)

1. Owner seçildiğinde yalnız owner’a bağlı hastalar gösterilmeli.
2. Owner’ın hastası yoksa patient selector boş dropdown bırakılmamalı; anlamlı empty-state / disabled state.
3. Hasta seçildikten sonra Test Grubu listesi mümkünse global katalogdan değil, hastanın **tamamlanmış lab sonuç geçmişinden** türetilmeli.
4. Kullanıcı “hangi testi karşılaştıracağım?” sorusunu tahminle çözmemeli.
5. Örnek flow: Patient → completed lab history → comparable analyte/test groups → date/range → comparison.
6. Uygun test yoksa açık empty state.
7. Global configured test catalog ile patient result history ayrılmalı.

**Product principle (rakip lesson):** *Comparison should begin from patient evidence/history, not from the global configured test catalog.*

---

### Test Grupları

**OBSERVED — liste (reviewed clinic/account, ~12):** İşlemler · Test Tipi · Adı · Durum; grouped presentation (ör. Lab altında); Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Test Grubu Tanımı (mevcut detay):** Tür · Test Tipi · Adı · Serbest Parametreli (Evet/Hayır) · Laboratuvar · Cihaz · Durum · **Test Kalemleri** grid — Kod · Sıra No · Test Adı · Cihaz Kodu · Test Grup Panelleri · Durum; satır **Teknikler - Göster** · Sil; Ekle · Kaydet.

**OBSERVED — Tür:** Lab · Röntgen.

**OBSERVED — Test Tipi dropdown (örnek kategoriler):** Hemogram · Arteriyel K.G. · Biyokimya · Diğer · Hormon · İdrar · Venüs Kan Gazı · Röntgen. Tür=Lab iken listede **Röntgen** değerinin görünmesi gözlemlendi — intentional design vs filtering **NOT VERIFIED**.

**OBSERVED — Test Kalemleri:** Kod selector geniş test/analyte vocabulary; Test Grup Panelleri configured panel dictionary; mevcut gruplarda çok satırlı grid (ör. ~25 ve ~32 item görünümleri — reviewed account). Pagination gözlemlendi. **Teknikler** genişleyebilir alt alan — içerik/semantik **doğrulanmadı**.

**NOT live:** Yeni kayıt ekranı açıldı; **Kaydet çalıştırılmadı**.

**NOT VERIFIED:** create/update/delete mutation · Teknikler işlevi · cihazdan otomatik mapping · device-code reconciliation · result ingestion · billing/stock · strict Tür→Test Tipi filtering · Serbest Parametreli runtime semantics.

---

### Test Grup Panelleri

**OBSERVED — liste (reviewed clinic/account, 5 configured):** İşlemler · Adı · Durum; Yeni Kayıt · Düzenle · Sil controls observed.

**OBSERVED — Tanım:** yalnızca Durum · Adı. Panel adları katalog olarak dump edilmedi.

**OBSERVED (cross-surface):** Test Grubu test item satırındaki **Test Grup Panelleri** selector bu panel kayıtlarını sunuyor — UI-level reusable panel dictionary; item’lar panel ile ilişkilendirilebiliyor.

**NOT VERIFIED:** panel membership’in panel formundan yönetimi · panel order/billing/device semantics · create/update/delete mutation exercised.

---

### Test Referansları

**OBSERVED — liste (reviewed clinic/account, ~287):** İşlemler · Hasta Türü · Cinsiyet · Test Adı · Min Değer · Max Değer · Açıklama · Birim · Durum; category/type heading altında gruplama.

**OBSERVED — form (existing + Yeni Kayıt yüzeyi):** Hasta Türü · Cinsiyet · Birim · Durum · Test Tipi · Test · Min Değer · Max Değer · Metin Değeri · Açıklama. Test Tipi örnekleri: Analiz · Arteriyel K.G. · Biyokimya · Diğer · Hemogram · Hormon · Venüs K.G. Test ve Birim dropdown’ları geniş vocabulary.

**OBSERVED (UI-level):** Species-aware reference ranges; gender alanı mevcut ve observed örnekte boş/optional; numeric min/max; Metin Değeri alanı.

**NOT VERIFIED:** age/breed-specific ranges · automatic reference selection · sex fallback · critical-value alerting · lab-device normalization · CDS · abnormal classification · create/update/delete mutation exercised.

---

### Pacs Grupları

**OBSERVED — liste (reviewed clinic/account, ~21):** İşlemler · Adı · Kod · Durum; modality grouping görünümü; Aktif/Pasif örnekleri.

**OBSERVED — Tanım:** Durum · **Modalite** · Adı · Kod. Modalite dropdown: CR · CT · DX · IO · MR · US · XA · MG.

**NOT live:** Yeni Kayıt formu açıldı; **Kaydet çalıştırılmadı**.

**OBSERVED (UI):** PACS group configuration is modality-coded at UI level.

**NOT VERIFIED:** DICOM routing · Study Instance UID · modality worklist · PACS server connection · DICOM compliance · automatic image ingestion · device/PACS routing rules.

---

### Cihazlar

**OBSERVED — liste (reviewed clinic/account, ~12):** İşlemler · Adı · DLL Adı · Durum.

**OBSERVED — Tanım:** Durum · Adı · DLL Adı · DLL Tipi · İşlem Protokolü · Port No · IP Adresi · Seri No. **İşlem Protokolü** örnekleri: TCP · COM · VETXPERT. Mevcut kayıtta TCP + port gibi bağlantı alanları görüldü. Yeni Kayıt formu açıldı.

**INFERRED:** DLL Adı / DLL Tipi alanları device-specific adapter/driver configuration **olabileceğini** düşündürür (confirmed integration **değil**).

**NOT VERIFIED / not confirmed:** .NET dynamic loading · plugin architecture · local Windows service · real-time TCP listener · COM serial reader · bidirectional integration · automatic result import · retry/reconnect · device health monitoring · save/update/delete mutation exercised · physical device connection.

#### VETINITY IMPLICATION (product direction)

Clinic-facing configuration’da ham adapter/DLL implementation detail’lerinin doğrudan kullanıcıya gösterilmesi tercih edilmemeli. Daha soyut UX: **Device** → Integration Profile → Connection Type → conditional settings (ör. TCP → IP/Port; serial → COM-specific fields). Driver/adapter mapping internal kalabilir (ADR/architecture kararı değil).

---

### Laboratuvarlar

**OBSERVED — liste (reviewed clinic/account, 1 configured):** İşlemler · Adı · Durum; Düzenle · Sil; Yeni Kayıt.

**OBSERVED — Tanım:** Durum · Adı (başka metadata gözlemlenmedi).

**OBSERVED (cross-surface):** Test Grubu **Laboratuvar** selector bu configured laboratory kaydını kullanıyor — UI-level reusable reference entity for test-group configuration.

**NOT VERIFIED:** location/address · department · staff assignment · hours · device ownership · multi-site · tenant scope · create/update/delete mutation exercised.

---

### Laboratuvar — Cross-surface model (UI relationships)

Özet (backend/schema iddiası **yok**):

```
Laboratory (configured name)
    ↓ used by
Test Group — Tür · Test Tipi · Device · Serbest Parametreli
    ├─ Test Items (Kod / analyte / device code / optional Panel)
    └─ links to Test Group Panel dictionary

Test Reference — species · optional gender · test · unit · min/max or text

PACS Group — modality · name · code

Device — connection/config fields (incl. DLL labels at UI)
```

---

### Laboratuvar — Backlog cross-reference

**Exact-match bulunamadı; backlog değiştirilmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| INT-001 | NO MATCH | Partner/protocol **research**; E-Vet admin device form ≠ integration scope |
| IMG-005 / IMG-006 | NO MATCH | DICOM/digital X-ray **research**; Pacs Grupları modality-coded config only |
| Global Lab/PACS modules | NO MATCH | Operasyon worklist; üst menü config pass ayrı |

**Potential gaps (kayıt açılmadı):** patient-centric lab comparison · test group/panel/reference admin · species reference ranges · modality-coded PACS groups · device connection UI · lab comparison UX friction lessons.

---

### Laboratuvar — TBD / NOT OBSERVED

Successful lab comparison output · device integration live · automated result ingestion · PACS/DICOM routing · reference auto-apply · panel auto-expand on requests · billing/stock linkage · shared DB/FK model · test group type-filter semantics enforcement.

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

*(Ekran bazlı inceleme → [Genel (modül)](#genel-modül). Üst menü **Rapor → Genel** rapor kategorisi ayrı — bkz. [Rapor → Genel](#rapor--genel-reviewed--closed).)*

---

## Genel (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-03).

**Kapsam notu:** Canlı klinik hesabı **read-only** UI incelemesi; Kaydet/sil/kullanıcı oluşturma/ayar değiştirme/yedek çalıştırma **yapılmadı**. **Anlamına gelmez:** permission backend enforcement, entegrasyonların çalışması, backup başarısı veya kılavuz içeriğinin bağımsız product doğrulaması.

**Kanıt notu:** Gerçek personel/müşteri adı, GSM, e-posta, kullanıcı adı, parola, API key, token, adres, koordinat, vergi no veya diğer secret/PII **dokümana taşınmadı**.

### Global menü envanteri (12/12)

| # | Ekran | Status |
|---|---|---|
| 1 | Birimler | **REVIEWED / CLOSED** |
| 2 | Bölümler | **REVIEWED / CLOSED** |
| 3 | KDV Oranı | **REVIEWED / CLOSED** |
| 4 | Rol Şablonları | **REVIEWED / CLOSED** |
| 5 | Veterinerler & Personeller | **REVIEWED / CLOSED** |
| 6 | Odalar | **REVIEWED / CLOSED** |
| 7 | Görev Tipleri | **REVIEWED / CLOSED** |
| 8 | Meslekler | **REVIEWED / CLOSED** |
| 9 | Ayarlar | **REVIEWED / CLOSED** |
| 10 | Yedek Al | **REVIEWED / CLOSED** |
| 11 | Kullanım Kılavuzu | **REVIEWED / CLOSED** (menü yüzeyi; 86 sayfa içerik ayrı doğrulanmadı) |
| 12 | Alpemix | **REVIEWED / CLOSED** (external link handoff) |

---

### Birimler

**OBSERVED — Birim Listesi (reviewed clinic/account, ~50):** Kod · Adı · e-Fatura Kodu · Durum; Düzenle · Sil; Yeni Kayıt. Form: Durum · Kod · Adı · e-Fatura Kodu · Kaydet · Kaydet / Yeni. Örnekler laboratuvar ölçüm/unit benzeri kayıtlar içeriyor.

**OBSERVED (UI):** Unit-of-measure master data; e-belge kodu metadata ile ilişkilendirilebilir.

**NOT VERIFIED:** standart/kod sistemi adı · e-Fatura mapping otomatik kullanımı · mutation exercised.

---

### Bölümler

**OBSERVED — Bölüm Listesi (reviewed clinic/account, ~6):** Ortak Alan · Kod · Adı · Durum; Düzenle · Sil; Yeni Kayıt. Form: Durum · Ortak Alan · Kod · Adı.

**OBSERVED (UI):** Reusable organizational/location classification; staff ve room tanımlarında bölüm referansı kullanılıyor.

**NOT VERIFIED:** `Ortak Alan` runtime semantics · department isolation · permission enforcement.

---

### KDV Oranı

**OBSERVED — liste (reviewed clinic/account, ~3 aktif):** 0 · 10 · 20; Düzenle · Sil; Yeni Kayıt. Form: Durum · KDV Oranı.

**OBSERVED (UI):** Centralized configurable tax rate master data.

**NOT VERIFIED:** compliance engine · historical rate/version handling · mutation exercised.

---

### Rol Şablonları

**OBSERVED — Rol Şablon Listesi:** reviewed account’ta `Kayıt bulunamadı`; Yeni Kayıt mevcut. Yeni form: Adı · Durum · Açıklama + permission tabs (aşağıda). Mutation **not exercised**.

#### Tab 1 — Roller

**OBSERVED:** Grouped CRUD matrix — kolonlar Göster · Yeni · Düzenle · Sil · Tümü. Domain grupları (müşteri, finansal, ürün, rapor, randevu, genel vb.). Temsilî izin öğeleri: Müşteriler · Müşteri Bakiyesine İndirim · Müşteri Dosyaları · Müşteri Grupları · Müşteri Ödemeleri · Müşteri İade Faturası · Ürünler · Ürün İndirimleri · Ürün Grupları · Ürün Alt Grupları · Ürün Tipleri · Randevu · Şablonlar · Bölümler · Meslekler · Personeller & Veterinerler · Rol Şablonları · Odalar · Görev Zamanlayıcı · Görev Tipleri · KDV Oranı (tam katalog dump edilmedi).

#### Tab 2 — Parametreli Roller

**OBSERVED:** Boolean/capability-style permissions. Örnek gruplar: Müşteri (GSM · Kimlik No · Tel 1/2 · İYS’ye Kayıt) · Yapay zeka (Yapay zeka · Rapor Modu) · Genel (Yedek Al — Randevular · Müşteri Listesi · Muayene Listesi · Giriş Bilgileri · Dosyalarım).

**OBSERVED (UI):** CRUD dışında field/action/capability-level permissions.

#### Tab 3 — Rapor Rolleri

**OBSERVED:** Rapor bazında **Göster**. Temsilî örnekler: Aktif Stok · SKT Geçen Ürünler · Gelecek Aşılar · MS Altına Düşen Ürünler · SKT Yaklaşan Ürünler · Takipteki Hastalar · Hospitalizasyon Listesi · Hasta Listesi · İstatistik · Anket Sonuçları · Test Sonuç Karşılaştır · Bugün Uygulanacak Tedaviler · Ziyaret Geçmişi.

**OBSERVED (UI):** Reporting visibility ayrı kontrol yüzeyi.

#### Tab 4 — Önceki İşlem Rolleri

**OBSERVED:** UI açıklaması — Yeni/Düzenle yetkisi verilen işlemlerde kullanıcının en fazla belirlenen **gün** kadar geriye dönük işlem yapabilmesi. Kolonlar: Gün Önce · Yeni · Düzenle · Tümü. Temsilî domainler: Müşteri Bakiyesine İndirim · Müşteri Ödemeleri · Müşteri İade Faturası · Lab İstek · Pacs İstek · Sayım · Doğrudan Satış · Hospitalizasyon · Reçete · Sipariş Faturası · Randevu.

**OBSERVED (UI):** Temporal permission / retroactive edit-create window — *user may have permission to perform an action, but only within an allowed historical window* (competitor observation; backend enforcement **NOT VERIFIED**).

#### Tab 5 — Tarih Aralığı Filtresi

**OBSERVED:** Feature/list bazında Gün Önce · Gün Sonra. Örnekler: Müşteri Muayene Geçmişi · Müşteri Ekstreleri · Müşteri Satış Faturaları · Müşteri Ödeme Geçmişi · Müşteri Ödemeleri · Müşteri İade Fatura Listesi.

**NOT VERIFIED:** backend data-window enforcement.

#### Tab 6 — SmartIVet Rolleri

**OBSERVED:** **Göster** visibility permissions. Örnekler: Aktif Hasta Listesi · Aktif Müşteri Listesi · Günlük Kasa · Kasa Hareketleri · Müşteri Ekstresi · Hospitalizasyon · Ziyaretçi Müşteri Sayısı · Günlük Yapılacak İşler · Toplam Bakiye.

**NOT VERIFIED:** SmartIVet product architecture; yalnızca ayrı feature/report visibility surface.

---

### Veterinerler & Personeller

**OBSERVED — Personeller & Veterinerler (~21):** Veteriner / Personel grup ayrımı; kolonlar Bölüm · Adı · Rol Şablonu · GSM · Email · Kullanıcı Adı · Durum (PII **kopyalanmadı**); Düzenle · Sil; Yeni Kayıt.

**OBSERVED — ana tab alanları:** Kullanıcı Tipi (Personel/Veteriner) · Durum · Bölüm · Adı · Diploma No · GSM · Doğum Tarihi · Email · Sicil No · Maaş · Kullanıcı Adı · Parola · Parolayı Onayla · Çift Faktörlü Güvenlik Doğrulama (Evet/Hayır) · Bilgi · İşe Giriş/Çıkış Tarihi · Rol Şablonu · **Uygula** aksiyonu.

**OBSERVED — user-level permission tabs:** Roller · Parametreli Roller · Rapor Rolleri · Önceki İşlem Rolleri · Tarih Aralığı Filtresi · SmartIVet Rolleri · **Diğer** (template ile aynı tab seti + Diğer).

**OBSERVED:** Mevcut bir veteriner kaydında CRUD matrix’in büyük kısmı açık görünüyordu → **template + per-user permissions coexist** (precedence/merge **NOT VERIFIED**).

**OBSERVED — Diğer tab:** SmartIVET Aktif/Pasif · Genel İndirim Oranı (%) · Yetkili Olduğu Depolar · Yetkili Olduğu Kasalar · Yetkili Olduğu Bankalar. UI metni: hiç depo seçilmezse **tüm depolar**; seçim yapılırsa yalnız seçilenler — aynı semantics kasa ve banka için.

**OBSERVED (authorization):** Operational **resource scope** (warehouse · cash register · bank) user-level configurable; capability/CRUD ile birlikte.

**NOT VERIFIED:** 2FA provider · password policy · termination semantics · Rol Şablonu Uygula replace vs merge · row-level security · query filter enforcement.

---

### Odalar

**OBSERVED — Oda Listesi (reviewed clinic/account, ~20):** department/group headings altında; Adı · Durum; Düzenle · **Oda QRCode** · Sil; Yeni Kayıt. Form: Durum · Bölüm · Adı.

**OBSERVED — Oda QRCode:** Report/view · QR görüntü · PDF/download/print controls.

**NOT VERIFIED:** QR scan workflow · hospitalization assignment · occupancy/capacity · mutation exercised.

---

### Görev Tipleri

**OBSERVED — liste (reviewed clinic/account, ~38):** Adı · Renk · Durum; Yeni Kayıt · Düzenle · Sil. Form: Durum · Adı · Şablon · Renk (native color picker). Şablon dropdown çok sayıda template (aşı · bilgilendirme · anestezi öncesi vb. — dump edilmedi).

**NOT VERIFIED:** template execution · task automation · recurrence · mutation exercised.

---

### Meslekler

**OBSERVED — Meslek Listesi (reviewed clinic/account, ~689):** Kod · Adı · Durum; Düzenle · Sil; Yeni Kayıt. Form: Durum · Kod · Adı. Geniş profession lookup catalog (liste dump **yok**).

---

### Ayarlar

**OBSERVED accordion’lar:** Genel · Müşteri/Hasta · Klinik Bilgileri · E-Fatura Bilgileri · SmartVet/Vetogle. Yalnızca **field/category adları**; gerçek değer/secret **yok**.

**Genel (observed fields):** Ana Depo · Ana Kasa · Ana Banka Hesabı · Takvim Görünüm · Aşı Görev Tipi · Tamamlanan Görev Tipi · Kontrol İş Tipi · Ürün Birimi · Doğrudan Satış Müşterisi · Ziyarete Gelmeme Gün Sayısı · Satış Fatura No/Öneki · Reçete Seri/Cilt/Sıra No · Ziyaret SMS Şablonu · Çek/Senet Görev Tipi · Bildirim Süresi (ms) · Hatırlatmaları SMS ile Gönder · Lab Sonuçlarını Bildirim ile Gönder · Randevu Otomatik Aktar · Otomatik Doğum Günü Hatırlatma · Tablo varsayılan satır sayısı.

**Müşteri/Hasta:** protokol no auto/increment · zorunlu/uyarı alanları · varsayılan tür/ırk/cinsiyet · Tekrarlı Kimlik Nr İzin Ver.

**Klinik Bilgileri (categories only):** clinic identity · SmartIVET name · contact · hours · address · coordinates · email server/SSL · HasvetApp API key field · SMS provider fields · PACS code · İYS fields · country/currency · VetXpert username/password fields — **integration success NOT VERIFIED**.

**E-Fatura Bilgileri (fields):** URL · firma/ünvan · vergi no · e-Fatura sağlayıcı · kullanıcı/şifre · adres alanları · WSDL/REST URL · açıklama alanları — reviewed account’ta çoğu boş görünüm; issuance/compliance **NOT VERIFIED**.

**SmartVet/Vetogle toggles (examples):** Randevularını Görebilir · Randevu Alabilir · Aşı Karnesi · Bakiye/Borc/Ödeme/Ekstre · Muayene/Lab/Pacs/X-Ray geçmişi · sahiplendirme/çiftleştirme görünürlükleri · Doktor SMS Gönder · Bildirim SMS Tel · Randevu Zaman Aralığı · Randevu Talep Görev Tipi · Randevu Max Tarih — portal capability toggles; architecture **NOT VERIFIED**.

---

### Yedek Al

**OBSERVED modal:** “Yedek almak istediğiniz başlıkları seçip Yedek Al tıklayınız.” **Excel Dosyası ile:** Müşteri Listesi · Hasta Listesi · Randevular · Muayene Listesi · **Giriş Bilgileri**. **Email ile:** Dosyalarım. UI: tanımlı e-postaya indirme linki **24 saat** içinde. **Yedek Al** button — **çalıştırılmadı**.

**NOT VERIFIED:** backup success · encryption · restore · full DB backup · export format.

**VETINITY IMPLICATION:** `Giriş Bilgileri` credential-class export permission ayrı capability; Vetinity’de çok daha sıkı security boundary (export içeriği görülmedi).

---

### Kullanım Kılavuzu

**OBSERVED:** Embedded PDF viewer · **86** sayfa · ürün kullanım kılavuzu; TOC geniş setup/workflow konuları (tanımlar, hasta, muayene, lab, müşteri vb.).

**CLOSED scope:** Genel menü **surface** only. Manual page contents **not** independently verified product behavior.

---

### Alpemix

**OBSERVED:** Genel > Alpemix → external **alpemix.com** (Windows download / third-party remote support site). E-Vet evidence: **link/handoff to external AlpeMix tooling** only.

**NOT VERIFIED:** auth handoff · embedded integration · session audit in E-Vet · data sharing. Alpemix site feature list (remote desktop, file transfer, vb.) **third-party marketing** — E-Vet native capability değil.

---

### Genel — Authorization model synthesis (OBSERVED UI layers)

1. **CRUD/action** — Göster / Yeni / Düzenle / Sil
2. **Capability / sensitive-field** — GSM, kimlik, İYS, AI, backup categories
3. **Report visibility** — Rapor Rolleri
4. **Temporal action restriction** — Önceki İşlem Rolleri (Gün Önce)
5. **Visible date-range restriction** — Tarih Aralığı Filtresi
6. **Resource scope** — depo · kasa · banka
7. **Role template + per-user configuration coexistence**

#### VETINITY IMPLICATION (research — ADR/architecture kararı değil)

- Basit role presets başlangıç; seçili advanced overrides.
- Hassas capability’ler ayrı izin.
- Finans/stok kaynaklarında optional resource scope.
- Historical edit window security/audit açısından anlamlı olabilir.
- Rakip UI çok granular/ağır — birebir kopyalama önerilmez.
- Principles: **Simple defaults, explicit advanced controls.** · **Permission ≈ capability + optional resource scope + optional temporal constraint**

---

### Genel — Backlog cross-reference

**Exact-match bulunamadı; backlog değiştirilmedi.**

| Aday | Karar | Gerekçe |
|---|---|---|
| UX-002 | NO MATCH | Vetinity Ayarlar>Tanımlar IA; E-Vet üst Genel admin yüzeyi değil |
| REPORT (report access) | NO MATCH | Rapor 403 gözlemi; Rol Şablonları admin UI ≠ report feature |
| APPT-036 | NO MATCH | Provider picker filter; staff/RBAC admin değil |

---

### Genel — TBD / NOT OBSERVED

Permission backend enforcement · template precedence · 2FA implementation · room QR workflow · SMS/e-Fatura/IYS/PACS/VetXpert/HasvetApp integration success · backup/restore · Alpemix session audit · mutation on all config screens · tenant isolation architecture.

---

## VKY (modül)

**Review status:** **REVIEWED / CLOSED** (2026-10-04; sol menü **VKY** — üç alt ekran product review kapsamı).

**Characterization:** Sol menüde klinik **yönetim analitiği / KPI** yüzeyi (finans, müşteri-hasta, stok, özet istatistikler, Top-N listeler, performans göstergeleri, parametre eşlemeleri). **[Rapor](#rapor)** üst menüsündeki predefined printable rapor kataloğu **değildir** — complementary analytics layer (backend birleşik mi **NOT VERIFIED**).

**OBSERVED — giriş:** Sol operasyonel menü **VKY** → alt öğeler: **Güncel Durum Ekranı** · **Performans Göstergeleri** · **Parametre Tanımları**.

### Global menü envanteri (3/3)

| # | Alt menü | Review status |
|---|---|---|
| 1 | Güncel Durum Ekranı | **REVIEWED / CLOSED** (2026-10-04) |
| 2 | Performans Göstergeleri | **REVIEWED / CLOSED** (2026-10-04) |
| 3 | Parametre Tanımları | **REVIEWED / CLOSED** (2026-10-04) |

### Güncel Durum Ekranı

**OBSERVED — üst sekmeler:** Finansal Yönetim · Hasta Analizi · Stok Kontrol · Genel İstatistikler · En Çok Özet / En’ler.

**OBSERVED — yaygın zaman seçimi (çoklu grafik/kart):** Bu Yıl · Geçen Yıl · Son 1 Yıl · Tarih Aralığı (tüm widget’lara aynı uygulama **NOT VERIFIED**).

#### Finansal Yönetim

**OBSERVED — rapor/grafik yüzeyleri (metrik türü; canlı tutarlar kopyalanmadı):**

- **Aylık Ciro Değişim Raporu** — aylık ciro · değişim oranı
- **Tahsilat Değişiklik Raporu** — tahsilat · değişim oranı
- **Yıllık Gelir Gider Raporu** — gelir · gider · kazanç
- **Toplam Gelir/Gider** — ödeme kanalı/türü kırılımı (ör. Kasa · Kredi Kartı · Banka Transferi · Çek · Senet); giriş/çıkış toplamları
- **Personel Satış Raporu** — personel bazlı satış tutarı (isimler **kopyalanmadı**)
- **Ürün Tipi Satış Raporu** — ürün tipi bazlı dağılım; ekran altında ödeme tipi özetleri

**NOT VERIFIED:** Grafik hesaplama formülleri · muhasebe doğruluğu · aggregation/cache mimarisi · export · drill-down · yetki/scope enforcement.

#### Hasta Analizi

**OBSERVED:**

- **Müşteri Sayısı Değişim Raporu** — yeni müşteri · değişim oranı
- **İşlem Yapılan Müşteri Sayısı** — adet · değişim oranı
- **Müşteri durum özeti** — toplam · aktif/pasif kırılım
- **Hasta durum özeti** — toplam · aktif/pasif/ölü (gözlenen kırılım etiketleri) kırılım
- Aktif hasta sayısı özet/donut
- **Hasta Türüne Göre Aktif Hasta** — tür bazlı dağılım
- **Veteriner Hekim Yönlendirme Sayısı Raporu** — veteriner bazlı yönlendirme/muayene benzeri grafik (backend semantiği **NOT VERIFIED**)
- **Yapılacak & Tamamlanan Aşı Sayısı** — aşı/paket satırları; **Beklemede** / **Tamamlandı** için Bugün · Bu Hafta · Bu Ay · Bu Yıl
- **Çiftleştirilecek Hastalar** · **Sahiplendirilecek Hastalar** panelleri (içerik/isimler **kopyalanmadı**)

#### Stok Kontrol

**OBSERVED — dashboard kartları / listeler:**

- **Klinik Stok Özeti ve Analizi** — toplam ürün · A/B/C sınıf dağılımı · depodaki toplam sermaye · hantallaşan stok / atıl sermaye · SKT yaklaşan riskli sermaye · stoklu/stoksuz/toplam satış cirosu (son 90 gün) · acil sipariş bekleyen ürün sayısı
- **Minimum Stok Altına Düşen Ürünler** — mevcut miktar vs minimum stok
- **SKT Geçmiş Ürünler** — ürün · depo · kategori/tür · miktar · geçen gün · tarih (gerçek ürün adları **kopyalanmadı**)
- **Son Kullanma Tarihi Yaklaşan Ürünler (Son 90 Gün)** — ürün · depo · kategori/tür · miktar · SKT · kalan gün · görsel risk göstergesi
- Yönetim uyarı metni — uzun süredir hareketsiz / atıl stok oranı (algoritma/threshold engine **NOT VERIFIED**)

**NOT VERIFIED:** ABC/atıl stok formülleri · risk eşik konfigürasyonu · otomatik sipariş · FEFO/FIFO · rezervasyon · alert gönderimi.

#### Genel İstatistikler

**OBSERVED — özet kart alanları (sayısal değerler kopyalanmadı):**

- **Bakiye** — Toplam Ödeme · Toplam Borç · Toplam Alacak
- **Müşteri** — Yeni · Toplam
- **Müşteri Sadakat Oranı** — tek KPI
- **Hasta** — Yeni · Toplam
- **Satış** — sayı · ciro · müşteri · hasta · müşteri ortalama satış · hasta ortalama satış
- **Aşı** — toplam · tamamlandı · müşteri · hasta · müşteri ortalama aşı · hasta ortalama aşı

**NOT VERIFIED:** Sadakat/ortalama formülleri · tarih filtresinin tüm kartlara uygulanması · historical snapshot semantics.

#### En Çok Özet / En’ler

**OBSERVED — Top-N / ranked list dashboard** (bazı listeler “30” ile etiketlenmiş):

- En Çok Satılan Ürünler
- En Çok Borcu Olan Müşteriler
- En Çok Randevusu Olan Müşteriler
- En Çok Ziyaret Yapan Müşteriler
- En Çok Harcama Yapan Müşteriler

Gerçek müşteri/ürün adları ve parasal sıra değerleri **kopyalanmadı**.

**NOT VERIFIED:** Ranking tie-break · iptal/iade dahililiği · müşteri merge · doğrudan satış generic müşteri semantiği · satır drill-down.

### Performans Göstergeleri

**OBSERVED — sayfa:** Performans Göstergeleri.

**OBSERVED — üst kontroller:** Tarih Aralığı · **Özel Değerler** dropdown · **Yeniden Hesapla**.

**OBSERVED — recalculation UX:** **Yeniden Hesapla** → “İşleminiz gerçekleştiriliyor...” loading/progress state.

**NOT VERIFIED:** Hesaplamanın başarıyla tamamlanması · yeni değerlerin persistence’ı · server-side/background job · **Özel Değerler** precedence · formüller · otomatik vs manuel alan kaynağı · scenario/historical snapshot.

**OBSERVED — sol/orta girdi alanları (örnek kategori/alan adları; canlı 0.00 vb. kopyalanmadı):**

- **Genel Klinik Bilgileri** — Tam Zamanlı Çalışan Veteriner Hekim Sayısı · Diğer Çalışan Sayısı · Aktif Hasta Sayısı · Çalışma Gün Sayısı · Hasta Başına Ortalama Yıllık Tıbbi Ziyaret
- **Klinik Gelirleri** — Muayene ve Konsültasyon · Aşı · Kuaför · PetShop ve Tamamlayıcı Servisler · (ek gelir sınıfları ekranın devamında)
- **Klinik Giderleri** — Laboratuvar/Operasyon/Sarf · Mama/İlaç/Malzeme · Amortisman · Vergiler (SGK, Muhtasar, KDV vb.) · Pazarlama/Reklam · İşletme · Finansal giderler · Toplam Giderler

**OBSERVED — sağ KPI tablosu (kayıt adları):** Hekim Başına Yıllık Ortalama Gelir · Hekim Başına Yıllık Ortalama Gelir (Sağlık Hizmetleri İçin) · Hekim Başına Yıllık Ortalama Maaş Maliyeti · Çalışan Başına Yıllık Gelir Ortalaması · Çalışan Başına Yıllık Maaş Gideri · Hekim Başına Aktif Hasta Sayısı · Günlük Konsültasyon/Vet · Hasta Başına Toplam Yıllık Ortalama Gelir · Tıbbi Hizmetler İçin Hasta Başına Ortalama Yıllık Gelir · Diğer Ürünlerin Hasta Başına Ortalama Yıllık Geliri · Her Hasta İçin Ziyaret Başına Ortalama Gelir · Kapı Açma Maliyeti · Giderleri Karşılamak İçin Günlük Min Olması Gereken Ziyaret Sayısı · Giderleri Karşılamak İçin Günlük Hekim Başına Min Olması Gereken Ziyaret Sayısı

### Parametre Tanımları

**OBSERVED:** VKY hesaplamalarını besleyen geniş **eşleme/konfigürasyon** ekranı (Save/mutation **test edilmedi**; parametre değiştirilmedi).

**OBSERVED — gelir eşleme alan başlıkları (örnek):** Aksesuar · Kozmetik · İlaç · Yem Katkı · Mama · Diagnostik Görüntüleme · Muayene ve Konsültasyon · Aşı · Hospitalizasyon · Laboratuvar Analiz · Kuaför · Operasyon · Diğer Tıbbi İşlem — *… Gelir Ürün Tip(ler)i*

**OBSERVED — gider / işletme parametreleri (örnek):** Danışman VH hizmeti · Amortisman · Klinik donanım/leasing · Finansal harcamalar · Vergiler · Teknisyen/diğer personel/VH maaş toplamları · Mama/ilaç/malzeme gider ürün tipleri · Kuaför gider · Genel yönetim (kira, utilities) · Laboratuvar/operasyon/sarf · Pazarlama/reklam

**OBSERVED — operasyonel parametreler:** Tıbbi Ziyaret Ürün Tip(ler)i · tam zamanlı VH/diğer personel sayısı · yıllık çalışma gün sayısı · kira fırsat maliyeti

**OBSERVED — dropdown kaynakları:** Gelir eşlemelerinde **ürün tipi** listesi (örnek tipler: Aksesuar · Aşı · Hizmet · İlaç · Kozmetik · Laboratuvar · Mama & Ödül · Operasyon Malzemesi — tam enum **iddia edilmez**). Gider eşlemelerinde **gider tipi** seçimi (örnek seçenek türleri: araç bakım/kiralama/otopark/sigorta/vergi/yakıt · BAĞKUR · banka komisyonu — tam liste **dump edilmedi**).

**INFERRED (UI-level):** VKY göstergeleri, mevcut ürün/gider sınıflarını yönetim analitiği kategorilerine bağlayan **configurable mappings** ile destekleniyor görünmektedir. Backend calculation architecture · rule engine · OLAP/warehouse · mapping enforcement **NOT VERIFIED**.

### VKY — Backlog cross-reference

**Backlog exact-match:** **NO MATCH** (VKY = entegre management analytics + KPI calculator + mapping config; [REPORT-001](../backlog/feature-backlog.md#report-001--rapor-merkezi) predefined **Rapor Merkezi** / printable catalog scope’u ile birebir değil; [AI-101](../backlog/feature-backlog.md#ai-101--ai-business-copilot) doğal dil copilot — adjacent, exact değil). Yeni backlog ID **oluşturulmadı**.

### VKY — TBD / NOT VERIFIED (CLOSED kapsamını engellemez)

Tüm formüller · muhasebe doğruluğu · recalculation success/persistence · parametre Save · export/drill-down · permission model · ABC/atıl/SKT risk algoritmaları · Top-N iş kuralları · performans KPI motoru · historical snapshots.

### VETINITY IMPLICATION (research — architecture/ADR kararı değil)

- E-Vet **VKY**, operasyonel klinik veriyi finans, müşteri/hasta, stok ve yönetim KPI’larında birleştiren kapsamlı bir **management analytics** katmanı sunar; birebir UI/kapsam kopyası önerilmez (“copy workflows, not UI”).
- **İlk aşama (companion clinic):** operasyonel dashboard · temel gelir/tahsilat özetleri · müşteri/hasta temel göstergeleri · kritik stok / min stok / SKT riskleri · basit satış kırılımları.
- **İleri aşama (research):** configurable management-accounting mappings · personel/ürün/hizmet performansı · break-even / kapı açma maliyeti · minimum günlük ziyaret · hekim productivity/economic KPI · scenario/benchmarking.
- Roadmap veya mimari karar **değildir**; [Rapor](#rapor) ve finans/stok operasyon modülleri ile read-model hizalaması ayrı ürün tasarımı gerektirir.

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

### VKY — REVIEWED / CLOSED

**REVIEWED / CLOSED** (2026-10-04). Sol menü **VKY** — **3/3** alt ekran:

Güncel Durum (5 sekme: Finansal Yönetim · Hasta Analizi · Stok Kontrol · Genel İstatistikler · En’ler) · zaman seçiciler · grafik/kart metrik türleri · Top-N listeler · Performans Göstergeleri (Tarih · Özel Değerler · Yeniden Hesapla + loading state) · KPI tablosu alan adları · Parametre Tanımları (ürün/gider tip eşlemeleri; Save **NOT VERIFIED**)

**TBD / NOT VERIFIED** (CLOSED kapsamını **engellemez**): formüller · recalculation success/persistence · mapping backend · export/drill-down · ABC/atıl/SKT algoritmaları · yetki modeli

### Global Hospitalizasyon — REVIEWED / CLOSED

**REVIEWED / CLOSED** (2026-10-04). Planlanan sol menü **Hospitalizasyon** modülü — global **Hospitalizasyonlar** operasyon yüzeyi:

Liste (Tarih Aralığı · Arama · Ara/Temizle · sayfalama) · durum gruplama (**Yatan** / **Taburcu**) · **+ Yeni Kayıt** · kolon seti (Müşteri/Hasta/Bölüm/Veteriner/Oda/tarihler/Günler/Tedavisi var mı?) · inline expand (Tedavi Şekli/Uygulamalar/Açıklama) · **İncele** read-only modal · **Düzenle** / **Yeni** form (**Hospitalizasyon Tanımı**; Durum **Yatan**/**Taburcu**/**Ölü**) · **İşlemler** (İncele/Düzenle/Sil) · Bölüm/Oda/Veteriner dropdown’ları · free-text clinical blocks (içerik kopyalanmadı) · Taburcu + boş çıkış tarihi (liste + İncele) · Yatan → Taburcu lifecycle testi · Hasta [Hospitalizasyon Geçmişi](#hospitalizasyon-geçmişi) sürekliliği

**TBD / NOT VERIFIED** (CLOSED kapsamını **engellemez**):

- Günler hesaplama · çıkış tarihi validasyon / otomatik discharge · **Ölü** lifecycle · geçiş/audit kuralları · Sil persistence · kapasite/conflict/occupancy · yapılandırılmış MAR/treatment engine · backend delete semantics

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

### Ürün — REVIEWED / CLOSED

Ürün üst domain menüsü (6 öğe) **tüm ana ekranlar incelenmiş** olarak **REVIEWED / CLOSED** (2026-10-01; tekrar inceleme gerekmez). **Anlamına gelmez:** indirim precedence, type inheritance, cascade filtering, satış zamanı fiyat/indirim uygulaması, Excel doğrulama, e-SMM mapping veya stok/expiry enforcement doğrulanmıştır.

Ürünler · Hızlı Fiyatlandırma · Ürün İndirimleri · Ürün Tipleri · Ürün Grupları · Ürün Alt Grupları

**Empty in reviewed clinic/account:** Ürün İndirimleri listesi.

**Live evidence (Hızlı Fiyatlandırma):** %1 zam → Zam Geçmişi → Geri al (fiyatlar döndü).

**TBD / NOT OBSERVED:** [Ürün — TBD](#ürün--tbd--not-observed).

### Müşteri — REVIEWED / CLOSED

Müşteri üst domain (**6/6** global menü) ve **Müşteri Kartı** derin inceleme **REVIEWED / CLOSED** (2026-10-01). **Anlamına gelmez:** IYS/SMS delivery, WhatsApp API, KVKK legal adequacy, aging buckets, return accounting veya ledger semantics doğrulanmıştır.

Müşteriler · Müşteri Ödemeleri · Müşteri Ekstreleri · Müşteri Satış Faturaları · Müşteri İade Faturaları · Müşteri Grupları · Müşteri Kartı (profil + müşteri-scoped menü).

**Empty (reviewed account):** Müşteri İade Faturaları listesi; seçili müşteride Randevular / Muayene Geçmişi / Bakiye İndirim / Proformalar / Dosyalarım empty örnekleri.

**Live:** Doğrudan Satış → Sms Gönder → Durum modal (SMS Id + success indicator; delivery NOT VERIFIED).

**TBD:** [Müşteri — TBD](#müşteri--tbd--not-observed).

### Hasta — REVIEWED / CLOSED

Hasta üst domain (**8/8** global menü) **REVIEWED / CLOSED** (2026-10-01). **Anlamına gelmez:** owner transfer audit/financial semantics, reference-data scope, delete guards, age-group automation, breed predisposition clinical rules veya patient-group business use doğrulanmıştır.

Hasta Sahibi Değiştirme · Hasta Türleri · Hasta Irkları · Renkler · Hasta Yaş Grupları · Besin Tipleri · Cinsiyetler · Hasta Grupları.

**Empty (reviewed account):** Hasta Grupları listesi (0 configured); üst menüde Hasta Listesi **gözlemlenmedi**.

**NOT live:** Owner transfer Kaydet çalıştırılmadı; Hasta Grup kaydı oluşturulmadı.

**Patient Workspace ayrı:** [Hasta Kartı](#hasta-kartı--patient-workspace) **CLOSED** — bu tracker global reference-data menüsünü kapsar.

**TBD:** [Hasta — TBD](#hasta--tbd--not-observed).

### Muayene — REVIEWED / CLOSED

Muayene üst domain (**13/13** global menü) **REVIEWED / CLOSED** (2026-10-01). **Anlamına gelmez:** e-Reçete/ATS resmi entegrasyon, successful prescription print, automation/reminder engines, stok/fatura side-effects veya clinical decision support doğrulanmıştır.

Reçete · ATS Listesi · Aşı Paketleri · Aşı Programları · Aşılanmamış Hasta Takibi · Muayene Özellikleri · Semptomlar · Teşhisler · Operasyon Paketleri · Tedavi Paketleri · Tedavi Şablonları · Tedavi Takip Parametreleri · Tedavi Takip Parametre Paketleri.

**Empty (reviewed account):** ATS (geniş tarih) · Aşı Programları · Operasyon/Tedavi paketleri · Tedavi Takip Parametre Paketleri listeleri.

**NOT live:** Yeni reçete **Kaydet** (create/save) · Aşı Programı Oluştur/Kaydet · boş paket/parameter paket kayıtları · seçimli takip parametresi kaydı. **Reçete:** ~662 mevcut kayıt listelenmiş; mevcut detay + yeni form açıldı.

**Reçete print caveat:** Yazdır rapor içeriği **InternalServerError** — successful rendering **not verified**.

**Ayrı yüzeyler:** [Global Muayene Odası](#global-muayene-odası-modül) worklist **CLOSED**; [Hasta Kartı](#hasta-kartı--patient-workspace) muayene/aşı patient UI **CLOSED**.

**TBD:** [Muayene — TBD](#muayene--tbd--not-observed).

### Laboratuvar — REVIEWED / CLOSED

Laboratuvar üst domain (**7/7** global menü) **REVIEWED / CLOSED** (2026-10-03). **Anlamına gelmez:** device/PACS/DICOM entegrasyonu, automated ingestion, successful longitudinal lab comparison, reference auto-apply veya mutation/save semantics doğrulanmıştır.

Lab Sonuçları Karşılaştır · Test Grupları · Test Grup Panelleri · Test Referansları · Pacs Grupları · Cihazlar · Laboratuvarlar.

**UX friction (Lab Sonuçları Karşılaştır):** owner without animals → patient selector still shown; test group from global catalog not patient history; empty `Kayıt bulunamadı` combinations.

**NOT live:** Test Grupları / Pacs Grupları yeni kayıt **Kaydet** çalıştırılmadı.

**Operasyon ayrı:** [Global Lab İstekleri](#global-lab-i̇stekleri-modül) · [Global Pacs İstekleri](#global-pacs-i̇stekleri-modül) **CLOSED**; [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial) **unchanged**.

**TBD:** [Laboratuvar — TBD](#laboratuvar--tbd--not-observed).

### Genel — REVIEWED / CLOSED

Genel üst domain (**12/12** global menü) **REVIEWED / CLOSED** (2026-10-03). **Anlamına gelmez:** permission enforcement, entegrasyon çalışması, backup başarısı, 2FA, veya kılavuz içeriğinin product truth olarak doğrulanması.

Birimler · Bölümler · KDV Oranı · Rol Şablonları · Veterinerler & Personeller · Odalar · Görev Tipleri · Meslekler · Ayarlar · Yedek Al · Kullanım Kılavuzu · Alpemix.

**Authorization highlight:** CRUD + parametreli capability + rapor visibility + temporal edit window + date-range filter + depo/kasa/banka scope + template/user coexistence.

**NOT live:** Yedek Al çalıştırılmadı; config mutation yapılmadı. **Secrets/PII** dokümana taşınmadı.

**Kullanım Kılavuzu:** menü yüzeyi CLOSED; 86 sayfa içerik review **değil**.

**TBD:** [Genel — TBD](#genel--tbd--not-observed).

### Finansal — REVIEWED / CLOSED

Finansal üst domain menüsü (7 öğe) **erişilebilir ekranlar ve güvenli/read-only UI incelemesi kapsamında** incelendi (2026-09-30; tekrar inceleme gerekmez). **Anlamına gelmez:** gerçek finansal kayıt oluşturma, save/posting, silme/reversal, banka/kasa bakiye etkisi, reconciliation, muhasebe/ledger entegrasyonu ve `Raporlara Dahil Et/Etme` seçiminin gerçek rapor etkisi live olarak doğrulandı.

Banka Giriş/Çıkış · Kasa Giriş/Çıkış · Bankalar · Banka Hesapları · Kasalar · Klinik Gider Grupları · Klinik Gider Tipleri

**Empty in reviewed clinic/account** (capability yok değil): Banka Giriş/Çıkış, Kasa Giriş/Çıkış, Klinik Gider Grupları listeleri.

**TBD / NOT OBSERVED (CLOSED kapsamını engellemez):** [Finansal — TBD](#finansal--tbd--not-observed) listesi.

### E-Vet genel — kalan ana alanlar

| Alan | Durum | Not |
|---|---|---|
| **Hospitalizasyon** (global modül) | **REVIEWED / CLOSED** (2026-10-04) | Bkz. [Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül); sol nav sıradaki: **HBS** |
| **Takvim** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Takvim (modül)](#global-takvim-modül) |
| **Doğrudan Satış** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül); [Yeni Ziyaret > Satış](#yeni-ziyaret) ayrı yüzey |
| **Muayene Odası** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Muayene Odası (modül)](#global-muayene-odası-modül); patient muayene geçmişi ayrı (Hasta Kartı **CLOSED**) |
| **Lab İstekleri** (global modül) | **REVIEWED / CLOSED** | Bkz. [Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül); patient Lab Geçmişi (Hasta Kartı **CLOSED**) |
| **Xray İstekleri** (global kuyruk) | **PARTIAL** (2026-09-29) | Bkz. [Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial); current clinic: no request rows / no selectable Xray Test Grubu; result lifecycle **not validated** |
| **Pacs İstekleri** (global modül) | **REVIEWED / CLOSED** (2026-09-29) | Bkz. [Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül); US image unavailable on reviewed samples — limitation documented |
| **HBS** | NOT REVIEWED | Sol operasyonel nav **NEXT** (Hospitalizasyon **CLOSED** 2026-10-04) |
| **VKY** | **REVIEWED / CLOSED** (2026-10-04) | Bkz. [VKY (modül)](#vky-modül); 3/3 alt menü; [Rapor](#rapor) ayrı |
| **e-Fatura / e-SMM** | PARTIAL | Nav + patient finans alanları |
| **DataVet** | NOT REVIEWED | |
| **İlaç Rehberi** | NOT REVIEWED | |
| **Nekropsi** | NOT REVIEWED | |
| **Mobil Uygulamalar** | NOT REVIEWED | |
| **Katalog / Dokümanlar** | NOT REVIEWED | |
| **Rapor** (üst domain) | **REVIEWED / CLOSED** (2026-09-29) | Bkz. [Rapor](#rapor); erişilebilir ekran seti/yetki sınırları içinde; 5 rapor ACCESS-BLOCKED |
| **Stok** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) | Bkz. [Stok (modül)](#stok-modül); güvenli/read-only kapsam; side-effect davranışları NOT OBSERVED; Rapor > Depo raporları ayrı ([Rapor → Depo](#rapor--depo-reviewed--closed)) |
| **Finansal** (üst domain) | **REVIEWED / CLOSED** (2026-09-30) | Bkz. [Finansal (modül)](#finansal-modül); güvenli/read-only UI kapsamı; save/posting, bakiye/ledger ve rapor etkisi NOT VERIFIED; Rapor > Finansal ve patient ekstre ayrı yüzeyler |
| **Ürün** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) | Bkz. [Ürün (modül)](#ürün-modül); 6/6 menü; Hızlı Fiyatlandırma live zam/rollback; davranışsal semantikler çoğunlukla NOT VERIFIED |
| **Müşteri** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) | Bkz. [Müşteri (modül)](#müşteri-modül); 6/6 menü + Müşteri Kartı |
| **Hasta** (üst domain — reference data) | **REVIEWED / CLOSED** (2026-10-01) | Bkz. [Hasta (modül)](#hasta-modül); 8/8 menü; [Hasta Kartı](#hasta-kartı--patient-workspace) ayrı |
| **Muayene** (üst domain) | **REVIEWED / CLOSED** (2026-10-01) | Bkz. [Muayene (modül)](#muayene-modül); 13/13; [Global Muayene Odası](#global-muayene-odası-modül) ayrı |
| **Laboratuvar** (üst domain) | **REVIEWED / CLOSED** (2026-10-03) | Bkz. [Laboratuvar (modül)](#laboratuvar-modül); 7/7; Lab/PACS/Xray operasyon modülleri ayrı |
| **Genel** (üst domain) | **REVIEWED / CLOSED** (2026-10-03) | Bkz. [Genel (modül)](#genel-modül); 12/12 üst menü |
| **Hasta Kabul** (global landing) | **PARTIAL** | Landing alanları; tam operasyon **TBD** |

---

## Next Review Queue

Ürün inceleme önceliği (architecture kararı **değil**):

**Sol operasyonel navigation (soldan aşağı):** **Hospitalizasyon** — **CLOSED** (2026-10-04). **VKY** — **CLOSED** (2026-10-04; [VKY (modül)](#vky-modül)). Bu eksende sıradaki **henüz incelenmemiş** modül: **HBS (Hayvan Bilgi Sistemi) — NEXT** (değişmedi). *(Aşağıdaki numaralı kuyruk farklı öncelik eksenidir; **14. e-Fatura / e-SMM — NEXT** korunur.)*

1. ~~Hospitalizasyon~~ — **CLOSED** ([Global Hospitalizasyon (modül)](#global-hospitalizasyon-modül); 2026-10-04)
2. ~~Takvim~~ — **CLOSED** ([Global Takvim (modül)](#global-takvim-modül); patient-context randevu [Randevular](#randevular))
3. ~~Doğrudan Satış~~ — **CLOSED** ([Global Doğrudan Satış (modül)](#global-doğrudan-satış-modül))
4. ~~Muayene Odası~~ — **CLOSED** ([Global Muayene Odası (modül)](#global-muayene-odası-modül))
5. ~~Lab İstekleri~~ — **CLOSED** ([Global Lab İstekleri (modül)](#global-lab-i̇stekleri-modül))
6. ~~Xray İstekleri~~ — **PARTIAL** ([Global Xray İstekleri (PARTIAL)](#global-xray-i̇stekleri-partial); result lifecycle incelenen klinikte doğrulanamadı — **CLOSED değil**)
7. ~~Pacs İstekleri~~ — **CLOSED** ([Global Pacs İstekleri (modül)](#global-pacs-i̇stekleri-modül))
8. ~~Rapor~~ — **CLOSED** ([Rapor](#rapor); erişilebilir ekran seti içinde; ACCESS-BLOCKED alt raporlar explicit)
9. ~~Stok~~ — **CLOSED** ([Stok (modül)](#stok-modül); güvenli/read-only kapsam; side-effect davranışları NOT OBSERVED)
10. ~~Finansal~~ — **CLOSED** ([Finansal (modül)](#finansal-modül); güvenli/read-only UI kapsamı; save/posting ve bakiye/ledger etkileri NOT VERIFIED)
11. ~~Ürün~~ — **CLOSED** ([Ürün (modül)](#ürün-modül); 6/6 menü; davranışsal TBD'ler CLOSED kapsamını engellemez)
12. ~~Müşteri~~ — **CLOSED** ([Müşteri (modül)](#müşteri-modül); 6/6 + Müşteri Kartı)
13. ~~Hasta~~ (üst domain — reference data) — **CLOSED** ([Hasta (modül)](#hasta-modül); 8/8; Patient Card ayrı **CLOSED**)
14. **e-Fatura / e-SMM** — **NEXT**
15. HBS
16. ~~VKY~~ — **CLOSED** ([VKY (modül)](#vky-modül); 2026-10-04; 3/3)
17. DataVet
18. İlaç Rehberi
19. Nekropsi
20. Mobil Uygulamalar
21. Katalog / Dokümanlar
22. ~~Genel~~ (üst domain — configuration) — **CLOSED** ([Genel (modül)](#genel-modül); 12/12)

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
- HBS, PACS, İlaç Rehberi entegrasyon/kapsam detayları; e-Fatura/e-SMM sağlayıcı ve mevzuat davranışı; DataVet ekran içi akışları; SmartVET / SmartIVET hedef kullanıcı ve capability kapsamı. *(VKY yönetim analitiği → [VKY (modül)](#vky-modül) **CLOSED** 2026-10-04.)*

**INFERRED (domain coverage — menü envanterinden):**

- Görünen menü kapsamı satın alma/stok/depo, finans, müşteri, hasta, klinik (muayene), laboratuvar/PACS ve raporlama alanlarına uzanıyor.

---

## VETINITY IMPLICATION

*(Minimum — deep-dive ilerledikçe genişletilecek.)*

- **TBD:** Navigation'da operasyon ile master-data birleşiminin Vetinity IA hedefleriyle nasıl karşılaştırılacağı ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md), [ADR-003](../decisions/ADR-003-report-center.md) — bu pass'te karar yok).
- **TBD:** Türkiye-local entegrasyon adları (HBS, e-Fatura/e-SMM, DataVet) için ayrı entegrasyon deep-dive. VKY → [VKY (modül)](#vky-modül) (analytics; entegrasyon adı değil).

---

## Ürün özeti / hedef kitle / güçlü-zayıf / backlog

**TBD** — Navigation IA tamamlandı; operasyon modülleri (Hospitalizasyon, Takvim, Doğrudan Satış, Muayene Odası, Lab, Pacs) **CLOSED**; **Xray** **PARTIAL**; **Rapor** üst domain **REVIEWED / CLOSED** (2026-09-29; erişilebilir ekran seti içinde); **Stok** üst domain **REVIEWED / CLOSED** (2026-09-30; güvenli/read-only kapsam); **Finansal** üst domain **REVIEWED / CLOSED** (2026-09-30; güvenli/read-only UI kapsamı); **Ürün** üst domain **REVIEWED / CLOSED** (2026-10-01; 6/6 menü); **Müşteri** üst domain **REVIEWED / CLOSED** (2026-10-01; 6/6 + Müşteri Kartı). Genel E-Vet özeti ilerledikçe doldurulacaktır ([Next Review Queue](#next-review-queue)).

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
