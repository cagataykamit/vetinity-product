# DaySmart Vet — Rakip Analizi

## Ürün

DaySmart Vet (uluslararası veteriner klinik yönetim platformu)

## İncelenen alan

Muayene deneyimi (SOAP / Medical Note), hasta geçmişi, klinik yardımcılar, mobil, randevu/online booking (2026-08-02 webinar), PetCare portal, check-in, bundle, klinik iletişim (2026-08-02 bölüm 2), birleşik record modeli, belge yaşam döngüsü, ziyaret durumu, finans cross-navigation (2026-08-02 bölüm 3), checkout, belge paketi, bağlamsal AI (2026-08-02 ~28:13–35:25), **canlı sandbox** — ilk giriş, erişilebilirlik, takvim, randevu, Census, Patients Module, Clients Module, Contacts Module, Inventory Module, Billing / Financial Operations, Reports / Reporting Module, **Settings / Configuration**, **Templates / Template System**, Treatment Board, Boarding, Reminders

## Analiz durumu

**Kısmi** — 2026-08-02 webinar benchmark (3 bölüm) ve **canlı sandbox** gözlemleri (takvim, randevu, ilk giriş, Census, Patients Module, Clients Module, Contacts Module, Inventory Module, Billing / Financial Operations, Reports / Reporting Module, **Settings / Configuration**, **Templates / Template System**, Treatment Board, Boarding, Reminders) mevcuttur. Sandbox doğrulaması bekleyen noktalar açıkça işaretlenmiştir.

---

## Bilinen gözlemler

| Alan | Gözlem |
|---|---|
| SOAP / Medical Note | Birleşik muayene çalışma alanı |
| Subjective / Objective | Yapılandırılmış muayene bölümleri |
| Vital bulgular | Muayene içinde vital değer girişi |
| Hazır bundle | Tedavi paketleri yaklaşımı |
| Doz hesaplayıcı | Muayene/tedavi akışına gömülü |
| Speech-to-text | Muayene notu için sesli giriş |
| Hasta kayıt timeline'ı | Kronolojik hasta geçmişi |
| Checkout iş akışı | Muayene sonrası ödeme akışı |
| Hasta sahibi mobil uygulaması | Pet owner mobil deneyimi |
| Kalıcı dikkat ve uyarı paneli | Kritik hasta uyarıları sürekli görünür |
| SOAP kilitleme | Aynı SOAP kaydında eşzamanlı çalışma ve kilitleme |

## Kullanıcı problemi

Veteriner hekimler muayene sırasında dağınık ekranlar arasında gezinmek, hasta geçmişini hızlıca taramak ve tekrarlayan tedavi kombinasyonlarını hızlı uygulamak zorundadır.

## Güçlü yön

- Birleşik ve güçlü muayene (SOAP) çalışma alanı
- Hasta timeline ile merkezi geçmiş görünümü
- Kalıcı kritik uyarı paneli
- Bundle ve şablonlarla hız kazancı
- İş akışına gömülü yardımcılar (doz hesaplayıcı, speech-to-text)

## Zayıf yön

- Arayüz modern SaaS standartlarının altında kalabilir (Vetinity fırsat alanı)
- Karmaşık arayüz yoğun kullanıcılar için öğrenme eğrisi

## Vetinity için çıkarım

| Problem | Vetinity yaklaşımı | Backlog / ADR |
|---|---|---|
| Birleşik muayene alanı | Modern muayene çalışma alanı; Türkçe terminoloji | [EXAM-001](../backlog/feature-backlog.md), [ADR-005](../decisions/ADR-005-modern-examination-experience.md) |
| Hasta geçmişi | Merkezi timeline; ayrı veri deposu yok | [TIMELINE-001](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md) |
| Kritik uyarılar | Kalıcı alerji ve dikkat uyarıları | [EXAM-009](../backlog/feature-backlog.md) |
| Tedavi hızı | Bundle/paketler, şablonlar, doz hesaplayıcı | [EXAM-006](../backlog/feature-backlog.md), [EXAM-007](../backlog/feature-backlog.md), [EXAM-008](../backlog/feature-backlog.md) |
| Sesli not | Speech-to-text değerlendirmesi | [AI-005](../backlog/feature-backlog.md) |
| Modern arayüz | Sade, hızlı, Tailwind/PrimeNG tabanlı UX | [UX ilkeleri](../ux/ux-principles.md) |

## Kopyalanmaması gereken unsur

- SOAP terminolojisinin birebir İngilizce kullanımı — Vetinity Türkçe ve doğal veteriner dili kullanır
- Arayüz layout'unun birebir kopyalanması
- SOAP kilitleme mekanizmasının aynen uygulanması (Vetinity kendi eşzamanlılık modelini değerlendirmeli)

## Kanıt / ekran / kaynak notu

- Muayene/SOAP: ürün gözlemi ve genel pazar bilgisi
- Randevu / online booking: [2026-08-02 benchmark — bölüm 1](#2026-08-02--randevu-online-booking-ve-petcare-akışı) — eğitim/demo videosu ekran görüntüleri
- PetCare / check-in / SOAP / bundle / iletişim: [2026-08-02 benchmark — bölüm 2](#2026-08-02--petcare-check-in-soap-bundle-ve-klinik-i̇letişim-akışı) — video ~11:37–22:43 ekran görüntüleri
- Record / belge / ziyaret durumu / finans cross-navigation: [2026-08-02 benchmark — bölüm 3](#2026-08-02--record-belge-ziyaret-durumu-ve-finans-cross-navigation) — sandbox observation (doğrulanmadı)
- Checkout / belge paketi / bağlamsal AI: [2026-08-02 bölüm 3 — checkout](#checkout-finansal-kapanış-belge-paketi-ve-bağlamsal-ai) — video ~28:13–35:25, sandbox observation (doğrulanmadı)
- Canlı sandbox — ilk giriş, takvim, randevu: [Sandbox — İlk giriş, takvim ve randevu oluşturma](#sandbox--i̇lk-giriş-takvim-ve-randevu-oluşturma) — gerçek ürün ekranları

---

## 2026-08-02 — Randevu, Online Booking ve PetCare Akışı

**Kaynak türü:**

- DaySmart Vet tarafından gönderilen kayıtlı ürün demo/webinar videosu
- Eğitim/demo videosundan alınan ekran görüntüleri
- Sandbox üzerinde henüz doğrulanmamış kısmi gözlemler (doğrulanmayan noktalar açık sorular bölümünde)

> Aşağıdaki maddeler **rakip davranışı** olarak kaydedilmiştir; Vetinity ürün kararı değildir.

### A. Klinik içi takvim ve randevu oluşturma

**Takvim (gözlem):**

- Gün ve hafta görünümü bulunuyor
- Hekimler ayrı kolonlar olarak gösterilebiliyor
- Oda, walk-in ve farklı kaynaklar ayrı kolon olarak kullanılabiliyor
- Randevu kartlarında hasta, müşteri, ziyaret nedeni, uyarı ve kısa not gibi bilgiler gösterilebiliyor
- Pending veya online oluşturulmuş randevular farklı durum/ikon ile ayrılabiliyor

**Klinik çalışanının randevu oluşturma akışı (gözlem):**

- Takvim üzerinde zaman aralığı seçilerek randevu formu açılıyor
- Randevu tipi ve varsayılan süre seçilebiliyor
- Şikâyet/ziyaret nedeni yazılabiliyor
- Atanan hekim veya kaynak seçilebiliyor
- Müşteri ve hasta aynı akış içinde aranabiliyor
- Tekrarlayan randevu desteği bulunuyor
- Not alanı bulunuyor
- Son adımda e-posta onayı ve hatırlatma seçenekleri yönetilebiliyor

**Inline müşteri/hasta oluşturma (gözlem):**

- Müşteri aramasında eşleşme bulunmazsa “Add Client” aksiyonu çıkıyor
- Kullanıcı takvim/randevu akışından ayrılmadan yeni müşteri oluşturabiliyor
- Müşteri oluşturulduktan sonra aynı randevu akışına geri dönülüyor
- Aynı yaklaşım hasta için de uygulanıyor; hasta mevcut müşteriye bağlanıyor
- Randevu, müşteri ve hasta işlemleri ardışık modal akışıyla yürütülüyor

**Müşteri formu (gözlem):**

- Ad, soyad, adres, posta kodu, şehir, eyalet, ülke, doğum tarihi, e-posta, kimlik/ehliyet ve birden fazla telefon alanı gibi geniş kapsamlı bilgiler içeriyor
- Form uzun ve yoğun; bazı iletişim ve hatırlatma tercihleri aynı formda yer alıyor

**Hasta formu (gözlem):**

- Ad, durum, ırk, renk, cinsiyet, yaşı, doğum tarihi, mikroçip numarası, birincil hekim

**Onay/haberdar etme (gözlem):**

- Randevu oluşturulurken onay kanalı seçilebiliyor
- E-posta metni görüntülenebiliyor ve düzenlenebiliyor
- Hatırlatmanın kaç gün önce gönderileceği belirlenebiliyor
- Onay ve hatırlatma devre dışı bırakılabiliyor
- Kayıt sonrası başarı bildirimi gösteriliyor

### B. Klinik web sitesi ve hasta sahibi online randevu akışı

**Klinik web sitesi (gözlem):**

- Klinik sitesinde “Book Appointment” butonu bulunuyor
- Buton ayrı bir PetCare/online booking arayüzüne yönlendiriyor
- Bu ekran klinik yönetim panelinden bağımsız bir frontend gibi çalışıyor

**Hasta sahibi akışı (gözlem):**

- Kayıtlı hayvan seçimi; aynı akışta yeni hayvan ekleme
- Klinik seçimi, ziyaret nedeni seçimi, hekim veya kaynak seçimi
- Tarih seçimi; yalnızca uygun saatlerden seçim
- Zorunlu açıklama/not; özet ve son onay
- “Appointment Request Submitted” başarı bildirimi

**Ziyaret nedeni örnekleri (videoda görülen):**

- Annual Wellness Exam & Vaccination, Equine Wellness, Sick Patient, Spay / Neuter, Acupuncture, Grooming, Telehealth Consult

**Ek davranışlar (gözlem):**

- Bazı ziyaret nedenlerinde depozito bilgisi gösterilebiliyor
- Randevu doğrudan kesinleşmiyor; klinik onayına gönderilen talep olarak oluşuyor
- Hasta sahibi panelinde yaklaşan ziyaret, hatırlatma, açık faturalar ve kayıtlı hayvanlar gösteriliyor

### C. Klinik tarafında online randevu talebinin işlenmesi

**Gerçek zamanlı davranış (gözlem — sandbox doğrulanmadı):**

- Hasta sahibi online talebi gönderdiğinde klinik panelinde anlık bildirim oluşuyor
- Toast/uyarı dışında bildirim merkezi içinde kalıcı kayıt tutuluyor
- Bildirimler tür bazında filtrelenebiliyor; bildirim rozeti ve liste görünümü bulunuyor

**Takvim davranışı (gözlem):**

- Online talep takvimde “Pending / Booked Online” benzeri durumda gösteriliyor
- Randevu detayında online geldiği anlaşılabiliyor

**Randevu talebi aksiyonları (gözlem):** Accept, Reject, Reschedule, History

**Kabul akışı (gözlem):** Tarih, müşteri, hasta, notlar; onay e-postası; hazır mesaj düzenleme; hatırlatma; kabul sonrası bilgilendirme

**Red akışı (gözlem):** Hazır red mesajı; ek not; e-posta ile bildirim

### D. UX değerlendirmesi

*Gözlemlere dayalı yorum — rakip değerlendirmesi:*

**Güçlü yönler:**

- Takvimden ayrılmadan müşteri ve hasta oluşturabilme
- Müşteri/hasta oluşturulduktan sonra ana randevu bağlamına geri dönme
- Hekim, oda ve walk-in gibi kaynakların aynı takvimde gösterilmesi
- Randevu onayı ve hatırlatmanın oluşturma/kabul akışına gömülü olması
- Hasta sahibi ile klinik arasındaki online talep ve onay döngüsünün uçtan uca kurulmuş olması
- Gerçek zamanlı bildirim ve kalıcı bildirim merkezi
- Yalnızca uygun saatlerin hasta sahibine gösterilmesi
- Kabul, red ve yeniden planlamanın ayrı aksiyonlar olarak sunulması

**Zayıf yönler:**

- Arayüz eski ve bilgi yoğun görünüyor
- Randevu kartları sıkışık ve okunabilirliği düşük
- Uzun müşteri formu gereksiz bilişsel yük oluşturuyor
- Birden fazla modal üst üste açılıyor
- Mesaj metni editörü her işlemde fazla görünür ve ağır
- Bazı ekranlarda geniş boş alanlar ile yoğun formlar dengesiz
- Online booking arayüzü işlevsel ancak görsel olarak oldukça temel
- Pending taleplerin doğrudan takvime düşmesi yoğun kliniklerde takvimi kirletebilir

### Vetinity İçin Çıkarımlar

*Aşağıdaki maddeler **değerlendirme adaylarıdır**; kesin ürün kararı değildir.*

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Takvim içi arama | Müşteri ve hasta arama randevu akışında sunulmalı | [IDEA-009](../research/ideas.md#idea-009--context-preserving-inline-entity-creation) |
| Inline oluşturma | Eşleşme yoksa aynı bağlamda hızlı müşteri/hasta oluşturma; yeni kayıt ana forma otomatik bağlanmalı | [IDEA-009](../research/ideas.md#idea-009--context-preserving-inline-entity-creation), [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation) |
| Modal yerine alternatif | Drawer, stepper veya bağlamsal side panel değerlendirilebilir | [Product Principles — Progressive Disclosure](../vision/product-principles.md) |
| Müşteri formu | Temel ve ileri bilgiler progressive disclosure ile ayrılabilir | [Product Principles — Progressive Disclosure](../vision/product-principles.md) |
| Randevu kartları | Modern, okunabilir, durum odaklı tasarım değerlendirilmeli | [Product Principles — Consistency Over Feature Count](../vision/product-principles.md) |
| Takvim kaynakları | Hekim, oda, walk-in, ekipman yapılandırılabilir olabilir | [IDEA-014](../research/ideas.md#idea-014--configurable-scheduling-resources), [APPT-025](../backlog/feature-backlog.md) |
| İletişim şablonları | Onay/hatırlatma şablon tabanlı; tam metin editörü varsayılan açılmamalı | [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications), [PATTERN-011](../research/patterns.md#pattern-011--template-first-communication) |
| İki ayrı deneyim | Klinik hızlı randevu vs hasta sahibi online talep ayrı tasarlanmalı | [IDEA-010](../research/ideas.md#idea-010--clinic-branded-online-booking) |
| Müsaitlik | Hasta sahibi yalnızca müsait gün/saat görmeli | [IDEA-012](../research/ideas.md#idea-012--availability-only-booking) |
| Talep modeli | Online randevu klinik onaylı talep olarak çalışabilir | [IDEA-011](../research/ideas.md#idea-011--appointment-request-review-queue), [PATTERN-008](../research/patterns.md#pattern-008--request-to-confirmation-workflow) |
| Bekleyen kuyruk | Ayrı “Bekleyen Randevu Talepleri” kuyruğu değerlendirilebilir | [IDEA-011](../research/ideas.md#idea-011--appointment-request-review-queue) |
| Pending takvim | Filtrelenebilir pending görünümü; yoğunluğu artırmamalı | [APPT-016](../backlog/feature-backlog.md) |
| Talep aksiyonları | Kabul, reddet, yeniden planla, geçmiş desteklenebilir | [APPT-011](../backlog/feature-backlog.md) |
| Bildirimler | Toast, badge ve bildirim merkezi birlikte değerlendirilebilir | [IDEA-015](../research/ideas.md#idea-015--real-time-operational-notification-center), [PATTERN-009](../research/patterns.md#pattern-009--event-to-notification-continuity) |
| Web entegrasyonu | Başlangıçta özel bağlantı; iframe/JS widget sonra genişletilebilir | [APPT-020](../backlog/feature-backlog.md), [APPT-027](../backlog/feature-backlog.md) |

**Product Principles uyumu:** [Workflow First](../vision/product-principles.md), [Patient Context Always Visible](../vision/product-principles.md), [Progressive Disclosure](../vision/product-principles.md), [Minimize Duplicate Data Entry](../vision/product-principles.md), [Suggest Before Blocking](../vision/product-principles.md), [Consistency Over Feature Count](../vision/product-principles.md)

### Açık sorular (sandbox doğrulanmadı)

- Gerçek zamanlı bildirimin teknik altyapısı
- PetCare oturum yönetimi ve hasta sahibi kimlik doğrulama detayları
- Depozito tahsilat ve iade akışının tam kapsamı
- Equine/Grooming gibi nedenlerin tüm klinik tiplerinde geçerliliği
- Tekrarlayan randevu kuralları ve istisnaları

---

## 2026-08-02 — PetCare, Check-in, SOAP, Bundle ve Klinik İletişim Akışı

**Kaynak türü:**

- DaySmart Vet tarafından gönderilen kayıtlı ürün demo/webinar videosu
- Eğitim/demo videosundan alınan ekran görüntüleri (yaklaşık **11:37–22:43** aralığı)
- Sandbox üzerinde henüz doğrulanmamış kısmi gözlemler

> Aşağıdaki maddeler **rakip davranışı** olarak kaydedilmiştir; Vetinity ürün kararı değildir.

### Hasta sahibi portalı

**PetCare portal (gözlem):**

- Ana ekranda yaklaşan ziyaretler, yaklaşan aşı/hatırlatmalar, açık faturalar, hayvan kartları, bağlı klinikler
- Alt navigasyon: Home, Pets, Billing, Vets, Profile
- Hayvan profilinde fotoğraf, ırk, kilo, renk, cinsiyet/kısırlaştırma durumu, doğum tarihi, mikroçip
- Certificates, Notes, Records, Reminders, Visits bölümleri
- Portal, klinik yönetim panelinden **ayrı bir web yüzeyi** olarak çalışıyor

### Belge ve dijital imza

**Belge akışı (gözlem):**

- Klinik belgeleri listesinde invoice, estimate, take-home report card, consent form
- Belge durumları open, approved, paid gibi etiketlerle gösteriliyor
- Hasta sahibi belgeyi görüntüleyip ekranda imzalayabiliyor
- İmza belge üzerine işleniyor

### Klinik inbox ve müşteri iletişim geçmişi

**Inbox (gözlem):**

- Müşteri bazlı konuşma listesi; konuşma içinde iki yönlü mesajlaşma
- Sağ panelde müşteri iletişim, adres, bakiye ve hayvan bilgileri
- Attachment ekleme; konuşmadan görev oluşturma
- Konuşmayı kapatma → kapatılan konuşma müşteri iletişim geçmişine taşınıyor
- Konuşmayı silme; konuşmayı bir hasta ile ilişkilendirme seçeneği

### Check-in orkestrasyonu

**Check-in akışı (gözlem):**

- Randevu kartından Check In
- Check-in sırasında: şikâyet, kilo, mektup şablonu, gönderilecek form, yatış durumu, medical note şablonu, bundle, billing seçimi, cage card, notlar
- Yeni invoice veya estimate açılabiliyor; var olan invoice/estimate ile ilişkilendirilebiliyor
- Tamamlanınca randevu durumu **Checked In**; medical note ve billing kaydı randevuya bağlanıyor
- Sonradan undo check-in ve check-out aksiyonları

### SOAP workspace

**Medical Note / SOAP (gözlem):**

- Üst bölüm: hasta özeti, muayene özeti, sağlayıcı, yönlendiren kurum, son güncelleyen, bağlı fatura
- Yaklaşan/gecikmiş hatırlatmalar görünür
- Subjective, Objective, Assessment, Plan, Client Communication yapısı
- Vital signs; abdomen, cardiovascular, lymph nodes, mucous membrane, musculoskeletal, oral, otic/ears gibi sistematik muayene bölümleri
- “Within normal limit” gibi varsayılan/şablon değerler
- Diagnosis geçmişi durum ve acuity ile gösteriliyor
- Plan altında kayıt ve bundle ekleme
- Not lock; duplicate, export, delete
- Record, diagnostic, vital ve bundle ekleme menüsü

### Snippet ve sesle not

**Snippet sistemi (gözlem):**

- `#` yazıldığında klinik snippet listesi açılıyor
- Örn. `#vomiting` → anamnez soru seti Subjective alanına yerleşiyor
- Yapılandırılmış soru metni ekleniyor
- **Not:** Snippet, AI özelliği değil; hızlı yapılandırılmış veri giriş pattern'ıdır

**Sesle klinik not (gözlem — premium aday):**

- Daisy Voice / Speech to Text penceresi
- Kayıt başlatma, duraklatma, oynatma/durdurma benzeri kontroller
- Yaklaşık 20 dakikalık kalan süre göstergesi
- Görüşme/diktasyonun yazıya dönüştürülmesi
- Teknik sağlayıcı veya altyapı **doğrulanmamıştır**; sandbox doğrulanmadı

### Bundle ve doz hesaplayıcı

**Bundle (gözlem):**

- Check-in veya medical note içinden bundle seçilebiliyor
- Muayene, aşı, ilaç, prosedür gibi birden fazla kalem içerebiliyor
- Kalemler tek tek dahil/hariç bırakılabiliyor; miktar düzenlenebiliyor
- “Apply item rule” seçeneği; seçili invoice ile ilişkilendirme
- Provider ve başlangıç tarihi seçimi
- Kaydedilince records ve billing tarafına kalemler yansıyor

**Doz hesaplayıcı (gözlem):**

- Hayvan kilosu, mg/kg doz, doz aralığı, konsantrasyon, toplam doz, toplam hacim
- **Yorum:** Klinik karar **desteği**; veteriner kararının yerini almaz

### Record lifecycle ve finansal izlenebilirlik

**Record yönetimi (gözlem):**

- İlaç, işlem, muayene, aşı kayıtları ayrı satırlar
- Lot, üretici, son kullanma, uygulama yolu, uygulama bölgesi
- Fiyat ve bağlı invoice görünürlüğü
- Attachment; edit, duplicate, print label, delete
- View changes / audit history
- Kayıtlar klinik-finans izlenebilirliği sağlıyor

### UX değerlendirmesi

*Gözlemlere dayalı yorum:*

**Güçlü yönler:**

- Check-in'in randevu, muayene, billing ve formları tek orkestrasyonda toplaması
- SOAP workspace'te üst bağlam bandı (hasta, fatura, hatırlatmalar)
- Snippet ile hızlı yapılandırılmış veri girişi (AI değil)
- Bundle'ın klinik kayıt ve fatura arasında köprü kurması
- Record satırında audit history ve finans bağlantısı
- PetCare portal ile klinik arasında belge/imza sürekliliği
- Inbox'ta müşteri bağlam paneli

**Zayıf yönler:**

- Arayüz bilgi yoğun ve eski görünüm
- Check-in formu çok fazla alan içeriyor
- SOAP ekranı uzun; sistematik muayene bölümleri öğrenme yükü
- Snippet ve voice ayrımı kullanıcıya net anlatılmazsa karışabilir
- Bundle UI karmaşık; item rule opak olabilir
- Portal ve klinik inbox ayrı yüzeyler — tutarlılık zorluğu

### Vetinity İçin Çıkarımlar

*Değerlendirme adayları — kesin ürün kararı değildir.*

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Hasta sahibi portal | Operasyonel uzantı; v1.0 dışı aday | [IDEA-017](../research/ideas.md#idea-017--owner-portal-as-operational-extension), [PORTAL-001](../backlog/feature-backlog.md) |
| Dijital onam/imza | Belge görüntüleme + ekran imzası | [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow) |
| Birleşik iletişim geçmişi | Inbox + arşiv + müşteri timeline | [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md) |
| Check-in orkestrasyonu | Randevu → muayene/billing/form köprüsü | [IDEA-020](../research/ideas.md#idea-020--check-in-orchestration), [CHECKIN-001](../backlog/feature-backlog.md) |
| SOAP workspace | Türkçe terminoloji; üst bağlam bandı | [IDEA-001](../research/ideas.md#idea-001--consultation-centered-clinical-workspace), [EXAM-001](../backlog/feature-backlog.md) |
| Snippet kütüphanesi | `#` tetiklemeli; AI'dan ayrı | [IDEA-021](../research/ideas.md#idea-021--clinical-snippet-library), [PATTERN-017](../research/patterns.md#pattern-017--structured-clinical-snippets) |
| Sesle not | Premium/ileri faz; AI-005 ile ilişkili | [AI-005](../backlog/feature-backlog.md), v1.0 dışı aday |
| Bundle genişletme | Kalem seçimi, invoice bağlantısı | [EXAM-007](../backlog/feature-backlog.md), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion) |
| Doz hesaplayıcı | Karar desteği; hekim sorumluluğu | [EXAM-008](../backlog/feature-backlog.md) |
| Record audit | view changes; lot/expiry/route | [IDEA-025](../research/ideas.md#idea-025--auditable-clinical-record-lifecycle), [RECORD-002](../backlog/feature-backlog.md) |
| Medical note lock | Eşzamanlı düzenleme koruması | [EXAM-015](../backlog/feature-backlog.md) |

**Product Principles:** [Workflow First](../vision/product-principles.md), [Patient Context Always Visible](../vision/product-principles.md), [Traceable Clinical Events](../vision/product-principles.md), [Minimize Duplicate Data Entry](../vision/product-principles.md), [Clinical Decision Belongs to the Veterinarian](../vision/product-principles.md), [Embedded AI](../vision/product-principles.md) (snippet/voice ayrımı), [Explainable Assistance](../vision/product-principles.md)

### Açık doğrulama soruları

- Daisy Voice / STT sağlayıcısı ve veri işleme politikası
- Snippet yönetim ekranı ve klinik bazlı paylaşım kuralları
- Bundle “item rule” motorunun yapılandırılabilirliği
- Dijital imzanın hukuki geçerlilik kapsamı (Türkiye)
- PetCare portal kimlik doğrulama ve çok klinik bağlamı
- Check-in undo/check-out yan etkileri (billing, stok)
- Inbox mesajlarının SMS/e-posta ile entegrasyonu
- Audit history detay seviyesi ve retention

---

## 2026-08-02 — Record, Belge, Ziyaret Durumu ve Finans Cross-Navigation

**Kaynak türü:**

- DaySmart Vet demo/webinar ekran görüntüleri (2026-08-02 benchmark serisinin devamı)
- **Sandbox observation** — sandbox üzerinde henüz doğrulanmamış gözlemler

> Aşağıdaki maddeler **rakip davranışı** olarak kaydedilmiştir; Vetinity ürün kararı değildir.

### Birleşik record modeli ve dinamik formlar

**Dynamic Record System (sandbox observation):**

- Tek bir **Record** kavramı altında Vaccine, Medication, Procedure, Diagnostic, Vital gibi farklı tipler bulunuyor
- Record tipi değiştikçe form alanları dinamik olarak değişiyor
- **Değerlendirme adayı:** generic record architecture · type-specific dynamic form · tek entity + metadata yaklaşımı

### Item rules

**Apply Item Rule (sandbox observation):**

- Yeni Record oluştururken **Apply Item Rule** seçeneği görülüyor
- Ürün/kalem seçildiğinde otomatik alan doldurma gözlemlendi; örnek alanlar: next due, reminder, quantity, varsayılan route, invoice bağlantısı, stok ilişkisi
- Bundle akışında da benzer “apply item rule” davranışı daha önce gözlemlenmişti
- **Değerlendirme adayı:** configurable item rule mantığı; kural yapılandırması sandbox'ta doğrulanmadı

### SOAP / Record / Invoice cross-navigation

**Cross-navigation (sandbox observation):**

- SOAP ekranından bağlı Invoice açılabiliyor
- Record satırından Invoice açılabiliyor
- Invoice ekranında ilgili satırlar (examination, vaccine, medication, procedure vb.) tekrar görülebiliyor
- **Değerlendirme adayı:** klinik-finans cross-navigation UX pattern; bağlam kopmadan geçiş

### Documents menüsü

**Documents yapısı (sandbox observation):**

- Documents menüsünde üç ayrı kavram: **Letters**, **Attachments**, **Forms**
- **Letters:** muhtemelen şablon tabanlı yazışma / rapor çıktıları (tam kapsam doğrulanmadı)
- **Attachments:** dosya eki odaklı kayıtlar
- **Forms:** yapılandırılmış form belgeleri (onam vb.)
- Fonksiyonel ayrım net; birbirinin yerine geçmiyor gibi görünüyor

### Onam formları (consent)

**Consent Forms (sandbox observation):**

- Vaccination Consent benzeri belgeler oluşturulabiliyor
- Belge hasta ile ilişkili; SOAP / ziyaret bağlamıyla ilişkili görünüyor
- Oluşturucu bilgisi tutuluyor
- PetCare portal tarafında imza akışı bölüm 2'de ayrıca gözlemlenmişti

### Dijital imza

**Digital Signature (sandbox observation):**

- Belge üzerinde **Draw Signature** ve **Type Signature** seçenekleri
- İmza belge üzerine gömülü şekilde saklanıyor
- **Değerlendirme perspektifleri:** elektronik onay · hasta sahibi onayı · medico-legal / hukuki kayıt (Türkiye kapsamı doğrulanmadı)

### Lock Letter

**Lock Letter (sandbox observation):**

- İmzalanan belge sonradan **Lock Letter** ile kilitlenebiliyor
- **Değerlendirme adayı:** immutable document · audit integrity · medico-legal protection
- Kilitleme sonrası düzenleme kısıtları sandbox'ta doğrulanmadı

### Ziyaret durumu iş akışı

**Visit Status Workflow (sandbox observation):**

- SOAP ekranında ziyaret durumları görünüyor
- Gözlemlenen akış: **Booked** → **Checked In** → **In Room** → **Visit Complete** → **Check Out**
- Durum değiştirirken opsiyonel not girilebiliyor
- Check-in orkestrasyonu (bölüm 2) ile ilişkili; durum geçişleri daha geniş ziyaret yaşam döngüsünü kapsıyor

### Invoice yapısı

**Invoice Structure (sandbox observation):**

- Aynı faturada birlikte bulunabiliyor: examination, vaccine, medication, procedure satırları
- Record/SOAP kaynaklı kalemler fatura satırında görünür kalıyor
- Yeni mimari fikir gerektirmiyor; klinik-finans izlenebilirliği gözlemini güçlendiriyor

### Checkout, finansal kapanış, belge paketi ve bağlamsal AI

**Kaynak:** Demo ekran görüntüleri ~**28:13–35:25** · **Sandbox observation** (doğrulanmadı)

> Ödeme sağlayıcı adları, buton konumları, modal görünümü, özel fon isimleri ve PDF viewer tasarımı **ürün kararı değildir**; yalnızca operasyonel kabiliyet gözlemlenmiştir.

#### Checkout finansal orkestrasyonu

**Sandbox observation:**

- Ziyaret **Visit Complete** durumundayken ayrıca **Check Out** işlemi başlatılabiliyor
- Checkout ekranında bir veya birden fazla açık fatura seçilebiliyor
- Kredi/mahsup kullanılabiliyor
- Tahsil edilen tutar giriliyor; ödeme yöntemi seçiliyor
- Checkout; yalnızca ödeme ekranı değil, ziyaretin operasyonel ve finansal kapanış adayı

#### Ödeme ve para üstü yönetimi

**Sandbox observation:**

- Fazla tahsilatta para üstü veya kredi benzeri farklı sonuçlar seçilebiliyor
- Muhasebeleştirme mantığı sandbox'ta doğrulanmadı

#### Checkout belge seçimi ve çok kanallı teslim

**Sandbox observation:**

- Checkout sırasında üretilecek belgeler seçilebiliyor; örnekler: Vaccine Certificate, Invoice, Vaccination Consent Form
- Teslim kanalları: None, Email, SMS, Print
- Belgeler tek işlem bağlamında dışa aktarılabiliyor

#### Tek işlemde belge paketi üretimi

**Sandbox observation:**

- Gözlemlenen akışta işlem sonunda Vaccination Certificate, Paid Invoice ve Signed Consent Form içeren **üç sayfalık tek PDF çıktısı** görüntülendi; sistemin her durumda belgeleri zorunlu olarak tek PDF halinde ürettiği **doğrulanmadı**
- Birleşik belge paketi teslim kolaylığı sağlıyor; belgelerin bağımsız kimlik/audit ihtiyacı ayrı değerlendirilmeli

#### Reminder görünürlüğü

**Sandbox observation:**

- Checkout ekranında geçmiş ve yaklaşan reminder sayıları görünür

#### Record–SOAP–Invoice çapraz navigasyonu

**Sandbox observation:**

- Hasta geçmiş ekranında record satırlarından ilgili SOAP ve faturaya **çift yönlü** navigasyon
- Bölüm 3'teki SOAP ↔ Invoice gözlemini hasta timeline bağlamında güçlendiriyor

#### Hasta bağlamlı AI yan paneli

**Sandbox observation:**

- Hasta profilinde bağlama duyarlı AI yan paneli; aktif hasta otomatik bağlam
- Hazır aksiyonlar: **Summarize**, **SOAP summary**
- AI; hasta geçmişi, SOAP, ilaçlar ve görünür klinik veriler üzerinden özet üretiyor
- Arayüz AI hataları / güvenilirlik konusunda uyarı gösteriyor
- Çıktılar doğru kabul edilmemeli; insan doğrulaması gerekir (halüsinasyon ve klinik güvenlik riski)
- Teknik sağlayıcı, veri kapsamı ve tenant izolasyonu doğrulanmadı

#### UX değerlendirmesi

*Sandbox observation yorumu:*

**Güçlü yönler:**

- Checkout'un tahsilat + belge + teslim + reminder'ı tek operasyonel kapanışta toplaması
- Birleşik belge paketi teslimi (gözlemlenen akışta üç sayfalık tek PDF çıktısı; genel kural doğrulanmadı)
- Record ↔ SOAP ↔ Invoice çift yönlü gezinme
- Hasta bağlamını taşıyan gömülü AI özet aksiyonları

**Zayıf yönler / dikkat:**

- Visit Complete ile Check Out ayrımı kullanıcıya karışabilir
- AI özetlerinin kaynak gösterimi ve onay akışı net olmalı
- Belge paketi ile bağımsız belge audit'i dengelenmeli
- Türkiye e-belge ve POS gereksinimleri ayrı doğrulama ister

#### Vetinity için çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Checkout orkestrasyonu | Ziyaret kapanışı + tahsilat + belge + teslim | [IDEA-027](../research/ideas.md#idea-027--checkout-as-visit-completion-orchestrator), [CHECKOUT-001](../backlog/feature-backlog.md) |
| Belge paketi | Tek olaydan çoklu belge üretimi/teslimi | [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-024](../research/patterns.md#pattern-024--event-to-document-package) |
| Çift yönlü cross-nav | Record ↔ SOAP ↔ Invoice | [PATTERN-022](../research/patterns.md#pattern-022--clinical-cross-navigation), [RECORD-001](../backlog/feature-backlog.md) |
| Bağlamsal AI özet | Summarize / SOAP summary yan panel | [IDEA-008](../research/ideas.md#idea-008--embedded-ai-instead-of-separate-ai-module), [AI-102](../backlog/feature-backlog.md), [AI-103](../backlog/feature-backlog.md) |
| Ziyaret kapanışı | Visit Complete → Check Out | [CHECKIN-005](../backlog/feature-backlog.md) |

#### Açık doğrulama soruları

- Checkout'ın çoklu açık faturaları tek işlemde tahsil edip etmediği
- Fazla tahsilatın kasa çıkışı, müşteri kredisi veya bağış hesabı olarak muhasebeleştirilmesi
- Parçalı ve çoklu ödeme desteği
- Checkout sonrası stok ve record kilitleme davranışı
- Belge paketinin tek PDF mi yoksa birleştirilmiş teslim paketi mi olduğu
- SMS ile PDF/link gönderim yöntemi
- İmzalı belgelerin yeniden üretim ve değişmezlik kuralları
- Türkiye e-Fatura/e-Arşiv/e-SMM uyumu
- AI'ın eriştiği veri kapsamı, tenant izolasyonu, loglama, saklama ve sağlayıcı modeli
- AI özetlerinin kaynak gösterip göstermediği

### UX değerlendirmesi

*Sandbox observation yorumu:*

**Güçlü yönler:**

- Tek record altyapısı altında tip-bazlı dinamik form — tutarlı veri modeli
- Item rule ile ürün seçiminden otomatik alan doldurma
- SOAP ↔ Record ↔ Invoice cross-navigation — bağlam sürekliliği
- Letters / Attachments / Forms ayrımı — belge türü netliği
- Draw + Type imza seçenekleri
- Lock Letter ile imzalı belge bütünlüğü
- Ziyaret durumu zinciri operasyonel görünürlük sağlıyor

**Zayıf yönler:**

- Item rule opaklığı (hangi kural uygulandığı belirsiz olabilir)
- Documents üçlüsü kullanıcıya öğretilmezse karışabilir
- Durum geçişleri çok adımlı; küçük klinikler için ağır olabilir
- Lock Letter ile unlock/yetki modeli görülmedi

### Vetinity İçin Çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Birleşik record + dinamik form | Generic record architecture | [IDEA-026](../research/ideas.md#idea-026--unified-dynamic-record-model), [RECORD-006](../backlog/feature-backlog.md), [PATTERN-020](../research/patterns.md#pattern-020--unified-record-with-dynamic-type-forms) |
| Item rules | Ürün seçiminde otomatik alan doldurma | [EXAM-014](../backlog/feature-backlog.md), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population) |
| Cross-navigation | SOAP ↔ Invoice ↔ Record | [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-022](../research/patterns.md#pattern-022--clinical-cross-navigation) |
| Documents taxonomy | Letters / Attachments / Forms | [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow) |
| Onam + imza + kilitleme | Consent → imza → Lock Letter | [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PORTAL-005](../backlog/feature-backlog.md), [PATTERN-014](../research/patterns.md#pattern-014--document-to-signature-continuity), [PATTERN-023](../research/patterns.md#pattern-023--post-signature-document-immutability) |
| Ziyaret durumu | Booked → Check Out zinciri | [IDEA-020](../research/ideas.md#idea-020--check-in-orchestration), [CHECKIN-005](../backlog/feature-backlog.md), [PATTERN-016](../research/patterns.md#pattern-016--check-in-as-workflow-orchestrator) |
| Karma fatura satırları | Exam + aşı + ilaç + prosedür | [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability) |

### Açık doğrulama soruları

- Record tip metadata şeması ve genişletilebilirlik modeli
- Item rule yapılandırma ekranı ve kural öncelikleri
- Lock Letter sonrası düzenleme/unlock yetki modeli
- Draw vs Type imzanın hukuki eşdeğerliği (Türkiye)
- Letters / Attachments / Forms arası dönüşüm veya birleşik arama
- Visit status geçişlerinin billing/stok yan etkileri
- Consent form şablon kütüphanesi kapsamı
- Cross-navigation derin link davranışı (yeni sekme vs aynı bağlam)

---

## Sandbox — İlk giriş, takvim ve randevu oluşturma

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir; doğrulanmayan teknik/yetkilendirme davranışları kesin ifade edilmemiştir. UI ayrıntıları, alan sırası ve rakibe özgü kopyalar ürün kararı değildir.

### İlk giriş ve kullanım şartları

**Sandbox gözlemi:**

- İlk açılışta “Terms of Service Updated” modalı
- Metin içeride kaydırılarak okunuyor; belirli süre/inceleme sonrası onay kutusu ve “I Accept” kullanılabilir hale geliyor
- **Değerlendirme:** Zorunlu sözleşme kabulü, sürümleme ve kullanıcı onay kaydı adayı — hukuki metin kopyası değil
- Onayın tenant bazlı mı kullanıcı bazlı mı olduğu **doğrulanmadı**
- Yeniden kabul gerektiren sürüm takibi ve audit davranışı **doğrulanmadı**

### Erişilebilirlik menüsü

**Sandbox gözlemi:**

- Sol altta erişilebilirlik düğmesi; üçüncü taraf görünümlü kapsamlı panel (ekranda AllAccessible sağlayıcı adı göründü; entegrasyon detayı **araştırılmadı**)
- Renk körlüğü, nöbet güvenli mod, bilişsel engel, ADHD/focus, ekran okuyucu/klavye, disleksi yazı tipi, vurgulama, metin/ölçek/font/satır/harf/hizalama kontrolleri
- **Vetinity değerlendirmesi (aday):** Üçüncü taraf widget kopyası yerine temel erişilebilirlik standardı (WCAG odaklı) ve kritik kullanıcı tercihleri değerlendirilebilir

### Yeni sandbox navigasyonu ve arayüz

**Sandbox gözlemi:**

- Ana alanlar: Schedule, Patients, Clients, **Contacts**, Inventory, Billing, Reports, Settings
- Schedule altı: Appointments, Census, Treatment, Boarding, Reminders
- Patients altı: List, Labs, Images, Diagnoses, Rx Requests, Analytics
- **Contacts altı:** List (Contact Dashboard + Contact List)
- **Inventory altı:** List, Alerts, Categories, Orders, Receipts
- **Billing altı:** Invoices, Estimates, Payments, Returns, Credits, Refunds, Write-offs, Cash
- **Reports altı:** kategori bazlı predefined report kataloğu (Schedule, Patients, Clients, Communications, Contacts, Inventory, Billing, Staff, Wellness Plan)
- **Settings altı:** Configurations, Templates, Add-ons, PetCare, Payments, Permissions, Subscriptions (sandbox erişimine göre)
- Eski ve yenilenmiş hasta profili birlikte; “Switch to Previous Layout” benzeri geçiş
- **Değerlendirme:** Aşamalı yeniden tasarım ve eski-yeni ekran birlikte yaşama tutarlılık riski — doğrudan kopyalanacak UX değil

### Takvim ana görünümü

**Sandbox gözlemi:**

- Gün/hafta görünümü; kolonlar provider/operasyonel kaynak bazlı (ör. hekim kolonları, Tech Appts)
- All Columns ve tek tek kolon seçimi
- Boş hücre tıklanınca seçilen kolon + tarih/saat bağlamıyla New Appointment modalı
- Randevu türü varsayılan süre taşıyor (ör. “Annual Wellness Exam & Vaccination (15 minutes)”)
- **Değerlendirme:** Kaynak bazlı takvim, hücre bağlamından randevu tohumu, randevu türünden süre türetme

### Yeni randevu formu

**Sandbox gözlemi — alanlar:** Type, Complaint (required), Assign To, Client (optional), Patient (optional), Location, Referred By, From/To, Repeat, Notes

- Takvim hücresi başlangıç/bitiş saatlerini önceden dolduruyor
- Assign To seçilen kolonla önceden doluyor
- Client aranabiliyor; Patient müşteri bağlamında; uygun hasta yoksa Add Patient
- Randevu müşteri/hasta olmadan oluşturulabilir **görünüyor**; kaydetme **test edilmedi**
- Location’da sandbox’ta yalnızca “In Clinic” görüldü — genel ürün sınırı mı sandbox konfigürasyonu mu **doğrulanmadı**
- Repeat tekrarlayan randevu adayı; seçenekler/üretim **incelenmedi**

### Randevu içinden hızlı hasta oluşturma

**Sandbox gözlemi:**

- Add Patient → randevu modalı üzerinde ikinci New Patient modalı; alt randevu bağlamı korunuyor
- Alanlar: Name, Status, Breed (required), Color, Sex, Age (yıl/ay/hafta), Birthdate, Chip, Primary Provider
- **Değerlendirme (aday):** Context-preserving creation — iç içe modal UX riski; drawer/stepper değerlendirilebilir

### Irk ve tür modeli

**Sandbox gözlemi:**

- Breed ≥3 karakter arama; sonuçta ırk + tür/grup birlikte (ör. “Akbash Dog (canine)”)
- Ayrı species alanı hızlı formda görünmüyor; breed token/chip olarak yerleşiyor
- breed → species ilişkisi **doğrulanmadı**
- **Vetinity değerlendirmesi (aday):** Mevcut species + breed modeli korunabilir; rakip ekranı doğrudan kopyalanmamalı

### Cinsiyet ve kısırlaştırma durumu

**Sandbox gözlemi — hızlı hasta oluşturma formu (Add Patient), Sex seçenekleri:** Female/Male (intact, spayed/neutered, unknown), Hermaphrodite (Altered), Unknown

- Gözlemlenen örnekte biyolojik cinsiyet + reproductive status **tek listede** sunuluyor
- **Vetinity değerlendirmesi (aday):** Hızlı formda birleşik enum kopyalanmamalı; ayrı alan yaklaşımı değerlendirilebilir → [APPT-018](../backlog/feature-backlog.md#appt-018--inline-hasta-oluşturma-klinik-içi). Patient Dashboard header'ında Sex ile Reproductive status ayrı alanlar olarak da gözlemlendi — aynı ürün içinde farklı yüzeyler

### Yaş ve doğum tarihi

**Sandbox gözlemi:**

- Yaş yıl/ay/hafta; doğum tarihi opsiyonel
- Yaş ↔ doğum tarihi senkronizasyonu, yaklaşık tarih veya çelişki yönetimi **test edilmedi**
- Doğum tarihi bilinmeyen hayvanlarda hızlı kayıt adayı

### Primary Provider alanı

**Sandbox gözlemi:**

- “No primary provider” + çok sayıda kullanıcı; veteriner olmayan sandbox hesabı listede göründü
- Neden: tüm kullanıcılar, sandbox rolü veya ayrı provider ataması olabilir — **kesin rol filtresi yok denmez**
- **Vetinity değerlendirmesi (aday):** Provider/hekim atama listelerinde yalnızca yetkilendirilmiş klinik hizmet sağlayıcılarının gösterilmesi değerlendirilebilir → [APPT-036](../backlog/feature-backlog.md)

### UX değerlendirmesi

**Güçlü yönler:** Takvim hücre bağlamı; kaynak kolonları; randevu türünden süre; inline hasta oluşturma bağlamı

**Zayıf yönler / dikkat:** İç içe modal; hızlı formda birleşik sex listesi (Dashboard header'da ayrı alanlar da gözlemlendi); provider listesi belirsizliği; eski-yeni layout birlikte yaşama; üçüncü taraf erişilebilirlik overlay bağımlılığı

### Vetinity için çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Kullanım şartları kabulü | Sürümleme + onay kaydı | [IDEA-028](../research/ideas.md#idea-028--versioned-legal-terms-acceptance), [TRIAL-009](../backlog/feature-backlog.md) |
| Takvim + kaynak kolonları | Provider/teknisyen kolonları | [IDEA-014](../research/ideas.md#idea-014--configurable-scheduling-resources), [APPT-025](../backlog/feature-backlog.md) |
| Hücre bağlamından randevu | Tarih/saat/kolon tohumu | [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation), [APPT-006](../backlog/feature-backlog.md) |
| Inline hasta oluşturma | Drawer/stepper; modal yığını değil | [IDEA-009](../research/ideas.md#idea-009--context-preserving-inline-entity-creation), [APPT-018](../backlog/feature-backlog.md) |
| Cinsiyet/kısırlaştırma | Ayrı alanlar (hasta domain) | [APPT-018](../backlog/feature-backlog.md#appt-018--inline-hasta-oluşturma-klinik-içi) |
| Provider filtresi | Ortak uygunluk politikası | [APPT-036](../backlog/feature-backlog.md) |
| Irk/tür | Species + breed modeli | [UX-003](../backlog/feature-backlog.md), [UX-004](../backlog/feature-backlog.md) |

### Açık doğrulama soruları

- ToS onayı tenant mı kullanıcı mı; sürüm yenileme ve audit
- Randevu müşteri/hasta olmadan kaydedilebilir mi
- Location seçenekleri sandbox mı ürün mü
- Repeat randevu kuralları ve üretim davranışı
- Breed → species veri modeli
- Yaş/doğum tarihi senkronizasyonu
- Primary Provider listesinin rol filtresi
- AllAccessible entegrasyon kapsamı ve alternatifleri

---

## Sandbox — Census, profiller ve operasyon kuyruğu

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir; doğrulanmayan teknik davranışlar kesin ifade edilmemiştir.

### Census (operasyon kuyruğu)

**Gözlemlenen sandbox akışında** Census ekranı operasyon kuyruğu **görünümünde** görünüyor.

**Gözlemlenen kolonlar:** Status, Triage, Time, Assigned To, Provider, Complaint, Patient, Client, Medical Note, Documents, Billing

- Status alanı satır üzerinden değiştirilebiliyor
- Status değiştirme ekranında gözlemlenen seçenekler: Not confirmed, Confirmed, Cancelled, Checked in
- Geçiş sırasında isteğe bağlı Notes alanı bulunuyor
- Gözlemlenen seçeneklerin sistemdeki **tüm** ziyaret/randevu durumlarını temsil ettiği **doğrulanmadı** (webinar/bölüm 3’te Booked → In Room → Visit Complete → Check Out zinciri ayrıca gözlemlenmişti)

**Vetinity değerlendirmesi (aday):** Operasyon görünürlüğü ve satır bazlı durum güncelleme; Census benzeri ekranın ayrı modül olarak kopyalanması yerine operasyon kuyruğu + durum geçişleri birlikte değerlendirilebilir → aşağıdaki çıkarımlar tablosu

### Appointment History

**Sandbox gözlemi:**

- Census satırındaki sağ ikon Appointment History açıyor
- Gözlemlenen örnekte: Appointment created, event zamanı, işlemi yapan kullanıcı gösteriliyor
- Tüm appointment yaşam döngüsünün burada tutulduğu **doğrulanmadı**

### Patient Profile (Patient Dashboard)

Patient Profile ve clinic-wide Patients Module sandbox gözlemlerinin tamamı → [Sandbox — Patients Module](#sandbox--patients-module)

### Client Profile

Client Profile ve clinic-wide Clients Module sandbox gözlemlerinin tamamı → [Sandbox — Clients / Client Module](#sandbox--clients--client-module)

### Genel mimari gözlemler

**Gözlemlenen sandbox akışında** ilişkiler:

```
Census → Patient Profile
Census → Client Profile
Patient Record → Invoice
```

- Appointment yaşam döngüsü ekranları ile Patient Dashboard **gözlemlenen akışta ayrı ekranlar** olarak görünüyor
- Census **operasyon kuyruğu** rolünde görünüyor
- Patient Dashboard **klinik kayıt merkezi** rolünde konumlandırılmış **görünüyor**

**Vetinity değerlendirmesi (aday):** → aşağıdaki çıkarımlar tablosu

### Vetinity için çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Operasyon kuyruğu (Census) | Satır bazlı durum + opsiyonel not | [CHECKIN-005](../backlog/feature-backlog.md), [CHECKIN-001](../backlog/feature-backlog.md), [PATTERN-016](../research/patterns.md#pattern-016--check-in-as-workflow-orchestrator) |
| Appointment event geçmişi | Olay + kullanıcı + zaman | [APPT-024](../backlog/feature-backlog.md) |
| Hasta kayıt merkezi | Dashboard + History filtreleri | [TIMELINE-001](../backlog/feature-backlog.md), [TIMELINE-003](../backlog/feature-backlog.md) |
| Hasta header + uyarılar | Özet bandı + Attention | [IDEA-004](../research/ideas.md#idea-004--persistent-patient-summary), [PATTERN-001](../research/patterns.md#pattern-001--persistent-patient-context), [EXAM-009](../backlog/feature-backlog.md) |
| Record ↔ Invoice | Satır referansı + cross-nav | [RECORD-001](../backlog/feature-backlog.md), [PATTERN-022](../research/patterns.md#pattern-022--clinical-cross-navigation) |
| Genel mimari | Operasyon kuyruğu ↔ kayıt merkezi ayrımı | [CHECKIN-005](../backlog/feature-backlog.md), [TIMELINE-001](../backlog/feature-backlog.md), [RECORD-001](../backlog/feature-backlog.md) |
| Müşteri profili ayrımı | Client ≠ Patient | [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md) |
| Client-scoped read-models | Billing, comm, appt, reminder | [Clients Module](#sandbox--clients--client-module), [TIMELINE-002](../backlog/feature-backlog.md) |
| Patient-scoped vs clinic-scoped | Aynı domain, farklı read-model | [TIMELINE-002](../backlog/feature-backlog.md), [Patients Module](#sandbox--patients-module) |

### Açık doğrulama soruları

- Census status seçeneklerinin tam listesi ve SOAP/ziyaret durumlarıyla eşleşmesi
- Census satırından Patient/Client profile geçiş davranışı (yeni sekme vs aynı bağlam)
- Appointment History kapsamı (yalnızca oluşturma mı, tüm durum değişimleri mi)
- Attention paneli veri kaynağı, önem seviyesi kuralları ve tüm senaryolar
- History alt filtrelerinin tam listesi ve kaynak modül eşlemesi
- Provider vs Created By ayrımının yetki/audit modeli
- Client Communication Preferences kanal ve opt-in/out davranışı
- Wellness Plans / Tasks sekmelerinin kapsamı (sandbox’ta yalnızca navigasyon gözlemlendi)

---

---

## Sandbox — Patients Module

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. UI layout birebir kopya önerisi değildir. ABD/enterprise özellikleri otomatik Vetinity gereksinimi sayılmaz.

**Temel ayrım:**

| Kapsam | Rol |
|---|---|
| **Patient Profile** | Tek hastanın longitudinal klinik dosyası |
| **Patients Module (clinic-wide)** | Tüm hastalar üzerinde operasyon listeleri, kataloglar, analytics |

Aynı domain verisinin patient-scoped ve clinic-scoped **read-model** olarak tekrar gösterildiği gözlemlendi → [TIMELINE-002](../backlog/feature-backlog.md), [Patient-scoped vs clinic-scoped](#patient-scoped-vs-clinic-scoped-read-models)

### Patient List — clinic-wide directory

**Ekran:** Patients > Patient List

**Üst durum filtreleri (sandbox gözlemi):** All Patients, Active, Deceased, Inactive — her birinin yanında adet

**Alfabetik filtre:** #, A–Z

**Liste kolonları:** Name, Breed, Sex, Color, Status

**Status örnekleri:** Active; Deceased + tarih; Inactive + tarih

**Sex (sandbox gözlemi):** reproductive status birlikte — ör. Female (intact), Female (spayed), Male (neutered), Female (unknown)

**Name** → Patient Profile geçişi

**Vetinity değerlendirmesi (aday):** Birleşik Sex display domain modeli olarak kopyalanmamalı → [APPT-018](../backlog/feature-backlog.md), [IDEA-004](../research/ideas.md#idea-004--persistent-patient-summary)

### Patient Profile — Header / Overview {#patient-profile-patient-dashboard}

**Sandbox gözleminde** Patient Dashboard ayrı ekran.

**Header:** Patient adı, Client/owner, internal patient ID, status, overdue/upcoming sayısı, breed + species, sex + reproductive status, age, current weight, profile photo

**Üst aksiyonlar:** +, Edit Profile, Print, Export, fullscreen/expand, overflow menu. **Upload Photo** ayrı modal.

**Overview — sol:** Name, Status, Breed, Color, Sex, Age, Birthdate, Chip, Weight (+ ölçüm tarihi), Next Visit, Primary Provider

**Overview — sağ:** preventive/medical due listesi (item, Given, Due) — medication, vaccine, exam, diagnostic vb. → [APPT-014](../backlog/feature-backlog.md), [EXAM-014](../backlog/feature-backlog.md)

**Snapshot:** Weight, Temperature, Heart Rate, Respiration

**Recent Medical Notes;** Current Plan (refills); Recent Communications; Open Diagnoses (diagnosis, acuity, opened)

**Attention paneli (örnek):** High / Bites — kapsam **doğrulanmadı** → [EXAM-009](../backlog/feature-backlog.md)

**Sekmeler:** Overview, History, Appointments, Documents, Notes, Relationships, Reminders, Wellness Plans, Tasks

### Edit Patient Profile

**Düzenlenebilir:** Name, Status, Breed, Color, Sex, Age, Birthdate, Chip, Primary Provider. Weight vital/record kaynaklı **görünüyor** — **doğrulanmadı**. Age + Birthdate source-of-truth **doğrulanmadı** → [APPT-018](../backlog/feature-backlog.md), [APPT-036](../backlog/feature-backlog.md)

### Patient Profile — History

**Alt filtreler:** All, Records, Medical Notes, Pharmacy, Labs, Images, Vaccines, Vitals, Communications, More (Diagnoses, Diagnostics, Problems, Rx Requests, Declined Items)

#### Records

Record, Added, Summary, Reference, Provider, Created By, Invoice. Summary: Assessment, Given, Lot, Route, Prescription # vb. Reference → medical note. **Mimari gözlem:** tek clinical event → çoklu read-model → [TIMELINE-002](../backlog/feature-backlog.md), [RECORD-006](../backlog/feature-backlog.md), [PATTERN-020](../research/patterns.md#pattern-020--unified-record-with-dynamic-type-forms)

#### Medical Notes

Lock icon gözlemlendi — finalized anlamı **doğrulanmadı** → [EXAM-015](../backlog/feature-backlog.md)

#### Pharmacy / Labs / Images / Vaccines / Vitals / Communications

Modül-specific kolon setleri; Invoice + Reference cross-link. Pharmacy: Rx #, Refills, Lot. Labs: Status Draft. Communications: Type, Automatic creator, dynamic content → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md)

### Appointments (Patient Profile)

Appointments & Reservations / Appointments / Reservations filtreleri. Status ör.: Checked in/out. Appointment + Boarding Reservation birleşik liste; domain ayrı → [CHECKIN-005](../backlog/feature-backlog.md)

### Documents / Notes / Relationships / Reminders / Wellness / Tasks

- **Documents:** Letters, Attachments, Forms, Certificates; New Letter/Form/Certificate → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow)
- **Notes:** Notes, PetCare Notes, PetCare Logs — clinical medical note **değil**; Priority, Profile Only notification
- **Relationships:** Owner + primary indicator; co-owner vb. MVP **zorunlu değil**
- **Reminders:** patient-scoped due list; clinic Reminders Detail ile aynı source → [APPT-014](../backlog/feature-backlog.md)
- **Wellness Plans:** Enroll In Plan; sandbox detay yok — **P3**
- **Tasks:** internal clinic tasks; Reminder **değil** → [MSG-004](../backlog/feature-backlog.md) (inbox görevi farklı kapsam)

### Quick Create / "+" menu

New History (Bundle, Medical Note, Record, Communication, Diagnosis, Diagnostic, Problem, Vital), Appointment, Document, Note, Relationship, Task, Reminder Bundle, Reminder, Wellness Plan → [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation)

### Clinic-wide: Labs / Images / Rx Requests / Custom Diagnoses / Analytics

- **Labs worklist:** Patient ID, Test, Lab Vendor, Lab Status, integration filtreleri — patient history'den farklı scope → [INT-001](../backlog/feature-backlog.md) **P3**
- **Images worklist:** View Online (NON_INTEGRATED) → [IMG-001](../backlog/feature-backlog.md), [IMG-005](../backlog/feature-backlog.md) **P3**
- **Rx Requests:** Pending queue; sandbox boş — refill request workflow **P3**
- **Custom Diagnoses:** clinic catalog ≠ patient diagnosis → [EXAM-004](../backlog/feature-backlog.md)
- **Analytics:** species/new/active charts — ayrı domain gerekmez **P3**

### Patient-scoped vs clinic-scoped read models {#patient-scoped-vs-clinic-scoped-read-models}

| Domain source | Patient-scoped | Clinic-scoped |
|---|---|---|
| Lab | Patient Lab History | Clinic Lab Worklist |
| Appointment | Patient Appt History | Schedule / Census |
| Communication | Patient Comm History | Client Comm History |
| Reminder | Patient Reminder List | Clinic Reminder Ops |
| Diagnosis | Patient Diagnosis | Diagnosis Catalog |
| Record | Patient History | Modül lists |

→ [TIMELINE-002](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md)

### Patient Gap Analysis {#patient-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Architecture | Priority |
|---|---|---|---|---|---|---|
| Patient List | Status+count; A–Z filter | Kısmi | APPT-018, IDEA-004 | Status lifecycle + tarih | Pet aggregate + query | P1 |
| Patient History | Unified filtered timeline | Planlandı | TIMELINE-001/003, ADR-006 | Filtre kapsamı | CQRS read-model | P0/P1 |
| Overview | Due list, vitals, notes, dx | Kısmi/yok | IDEA-004, EXAM-014, AI-102 | Klinik özet paneli | Aggregated read-model | P1 |
| Records cross-nav | Invoice+Reference | Kısmi | RECORD-001, PATTERN-022 | Deep link | Event + read-models | P1 |
| Pharmacy/Lab/Vaccine | Typed history rows | Kısmi | RECORD-006, RECORD-005 | Entity birleştirme yok | Unified record types | P1 |
| Communications | Patient+client context | Araştırılacak | MSG-001, IDEA-019 | Shared comm entity | Scoped queries | P2 |
| Diagnosis catalog | Custom Diagnoses screen | Yok | EXAM-004 | Catalog vs patient dx | Reference data | P2 |
| Wellness / Rx queue / Analytics | Enterprise features | Yok | — | Tam gap | Ayrı modül/workflow | P3 |
| Clinic lab/image worklist | Integration queue | Yok/kısmi | INT-001, IMG-001 | Operasyon listesi | Clinic-scoped query | P3 |

### Açık doğrulama soruları (Patients Module)

- Medical note lock semantics; Weight master vs vital; Age↔birthdate SOT
- PetCare Notes portal entegrasyonu; Wellness Plan faturalama
- Rx Request workflow; Lab NON_INTEGRATED operasyonel anlamı
- Overview overdue/upcoming hesaplama; primary relationship star kuralı

---

## Sandbox — Treatment Board

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir; doğrulanmayan davranışlar kesin ifade edilmemiştir.

### Treatment Board (operasyon ekranı)

**Sandbox gözleminde** Treatment Board, Census’ten ayrı bir operasyon ekranı olarak görünüyor.

**Kart üzerinde gözlemlenen bilgiler:** Patient, Breed, Age, Assigned provider, Admission duration, Treatment status, Overnight Stay, Documents overdue sayısı

**Kart aksiyonları:** New Activity, New Bundle, Documents, End

- Karttan detay ekranına geçiş gözlemlendi
- End aksiyonunun kapsamı (yatış kapanışı, ziyaret tamamlama vb.) **doğrulanmadı**

### Treatment detay ekranı

**Sandbox gözleminde** detay ekranı iki bölümden oluşuyor:

**Üst bölüm:** Patient, Admitted For, Assigned To, Overnight Stay, In Treatment süresi, Documents sayısı, vital özet alanları (weight, HR, RR, temperature vb.)

**Alt bölüm:** Kategori bazlı timeline görünümü; gözlemlenen kategoriler: Vitals, Medical, Other

**Activity kartları:** Due, Note, Complete, Context menu — tam activity tipleri ve Complete davranışı **doğrulanmadı**

### Documents (treatment bağlamı)

**Sandbox gözleminde** Treatment kartındaki Documents bağlantısı popup açıyor; ilgili treatment’a ait belgeler listeleniyor.

**Gözlemlenen örnekler:** Holistic Exam, Take Home Report Card, Dental Exam Consent, Invoice, Treatment Summary

- Belge listesinin tam kapsamı ve overdue sayacı ile ilişkisi **doğrulanmadı**

### New Activity

**Sandbox gözleminde** activity oluşturma alanları: Patient, Type, Notes, Due, Occurrence

- **Type seçenekleri (gözlemlenen):** Medical, Vitals, Other
- **Occurrence:** Not recurring, Recurring
- **Due modu:** At specific time, After start of treatment
- Recurring kuralları ve üretim davranışı **incelenmedi**

### New Bundle (sihirbaz)

**Sandbox gözleminde** bundle sihirbazı ilk adımda: Patient, Template, Invoice, Provider, Medical Note, Start

**Gözlemlenen template örnekleri:** Annual Wellness Exam, Boarding Bundle, Dental Bundle, Drug Administration, Equine Wellness, Acupuncture vb.

- Sihirbazın sonraki adımları, kalem düzenleme ve kayıt/fatura yansıması **doğrulanmadı**
- Gözlemlenen akış, tek tek aktivite yerine önceden tanımlı tedavi paketlerinin treatment bağlamında kullanılabildiğini gösteriyor

### Vetinity için çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Aktif tedavi operasyon panosu | Census benzeri ayrı operasyon yüzeyi; yatış/tedavi süresi boyunca görünürlük | [CHECKIN-005](../backlog/feature-backlog.md) |
| Vital özet + activity timeline | Kategori bazlı görev/zaman çizelgesi | [EXAM-003](../backlog/feature-backlog.md), [TIMELINE-003](../backlog/feature-backlog.md) |
| Treatment bağlamında bundle | Template sihirbazı; invoice + medical note | [EXAM-007](../backlog/feature-backlog.md), [IDEA-023](../research/ideas.md#idea-023--configurable-clinical-bundles), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion) |
| Treatment belgeleri | Popup liste; consent, rapor, invoice | [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [RECORD-001](../backlog/feature-backlog.md) |
| Zamanlanmış activity | Due, recurring, treatment başlangıcına göre | [CHECKIN-005](../backlog/feature-backlog.md) (açık doğrulama) |

### Açık doğrulama soruları

- Treatment Board ile Boarding modülü ilişkisi; Overnight Stay anlamı
- Treatment status değerleri ve Census/ziyaret durumlarıyla eşleşmesi
- End aksiyonunun operasyonel ve finansal yan etkileri
- Documents overdue sayacının hesaplama kuralı
- Activity Complete davranışı ve audit izi
- Recurring activity üretim kuralları
- Bundle sihirbazının kalem seçimi, item rule ve fatura yansıması
- Treatment Board ↔ Patient Dashboard / SOAP cross-navigation

---

## Sandbox — Boarding

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. DaySmart Boarding gözlemleri pet boarding/konaklama operasyonuna işaret ediyor; Vetinity'de yatış (hospitalization) ile pansiyon/konaklama farklı ürün alanlarıdır ([Bulutvet notu](bulutvet.md)). Sandbox kaydı rakip davranış içindir; doğrudan modül kopyası değildir.

### Boarding Dashboard

**Sandbox gözleminde** dashboard üç operasyon kolonu içeriyor:

- Checking In
- Checking Out
- Checked In

**Üstte durum legend'i (gözlemlenen):** Arriving Today, Overdue Check-in, Pending Checkout, Checked Out, Checked In

- Dashboard operasyon görünümü olarak kullanılıyor
- Legend değerlerinin tam listesi ve Census/ziyaret durumlarıyla ilişkisi **doğrulanmadı**

### Reservation Calendar

**Sandbox gözleminde** room-resource timeline kullanılıyor.

- Oda bazlı kapasite gösterimi; gözlemlenen örnek: Max:1, Max:2
- Gün / Hafta / Ay görünümü mevcut
- Timeline yatay kaydırılabiliyor
- Oda listesinin tam kapsamı ve çift rezervasyon kuralları **doğrulanmadı**

### New Reservation

**Sandbox gözleminde** reservation oluşturma alanları: Client, Guest (Patient), Check In, Check Out, Room, Provider, Notes

- Client ve Guest **ayrı entity** olarak seçiliyor
- Autocomplete boşsa Add Client / Add Patient aksiyonları sunuluyor
- Room dropdown ile seçiliyor; Provider rezervasyona atanabiliyor
- Kaydetme sonrası davranış → [Reservation lifecycle](#reservation-lifecycle)

### Reservation lifecycle

**Sandbox gözleminde** reservation oluşturulduktan sonra:

- Timeline üzerinde reservation kartı oluşuyor
- Kart seçildiğinde ayrı sayfa yerine **popover** açılıyor
- Popover içeriği: Room, Check In, Check Out, Provider, Client, Guest, Notes; Client yanında telefon numarası
- Popover aksiyonları: Edit, Check In, Cancel
- Reservation → Calendar → Check In operasyon akışı gözlemlendi
- **Check In** seçildiğinde ayrı bir **Check In sihirbazı** açılıyor — popover kapanıp sihirbaz mı yoksa üst üste mi **doğrulanmadı**
- Cancel yan etkileri (billing, oda durumu vb.) **doğrulanmadı**

### Check In Wizard

**Sandbox gözleminde** reservation detayından (popover Check In) ayrı bir Check In sihirbazı başlatılıyor.

**Gözlemlenen alanlar:**

- Billing (New Invoice / mevcut invoice)
- Boarding Form (template)
- Apply Item Rule
- Daily Rate
- Provider
- Medical Note
- Bundle
- Weight (+ unit)
- Cage Card
- Notes

- Sihirbaz adım sayısı, zorunlu alanlar ve tamamlama sonrası dashboard kolon değişimi **doğrulanmadı**

### Boarding Form (template)

**Sandbox gözleminde** Boarding Form alanında template seçimi mevcut.

**Gözlemlenen örnekler:** Boarding Intake Form, Boarding Cage Card / Instructions, Appointment Confirmation, Behavior Observation vb.

- Template listesinin tam kapsamı ve oluşturulan belgenin kayıt bağlantısı **doğrulanmadı**

### Bundle (Check In bağlamı)

**Sandbox gözleminde** Boarding Check In sırasında bundle seçilebiliyor.

- Boarding Bundle yanında diğer medical bundle'lar da listede göründü
- Bundle → invoice / record yansıması bu akışta **test edilmedi**

### Apply Item Rule (Check In bağlamı)

**Sandbox gözleminde** Check In sihirbazında Apply Item Rule seçeneği bulunuyor.

- Otomatik ücret, stok veya hizmet satırı üretimi **gözlemlenen akışta olası**; kural motoru ve yan etkiler **doğrulanmadı**

### Cage Card

**Sandbox gözleminde** Cage Card alanında yazıcı/çıktı seçenekleri:

- Printer seçimi
- Zebra Label
- Generate PDF

- Etiket şablonu, varsayılan yazıcı ve PDF içeriği **doğrulanmadı**

### Medical Note (Check In bağlamı)

**Sandbox gözleminde** Check In sihirbazında Medical Note oluşturma/seçimi mevcut.

- Oluşturulan notun SOAP/record bağlantısı **doğrulanmadı**

### Inline Item Creation

**Sandbox gözleminde** Check In ekranından eksik **Item** (envanter kalemi) oluşturulabiliyor.

- Inventory modülü entegrasyonu **gözlemlendi**; oluşturulan kalemin fatura/stok yansıması **doğrulanmadı**

### Notification flow

**Sandbox gözleminde** reservation kaydedildiğinde otomatik **transactional** e-posta gönderiliyor.

**Mail içeriği (gözlemlenen):** Client adı, Patient adı, Check In, Check Out, klinik iletişim bilgileri; HTML template; footer'da unsubscribe bağlantısı

- Reservation event notification tetikleyicisi gözlemlendi
- Reservation ekranındaki Mail / SMS seçeneklerinin aynı notification altyapısını kullandığı **gözlemlendi** — teknik doğrulama yapılmadı
- SMS içeriği, şablon yönetimi ve opt-in/out kuralları **doğrulanmadı**

### Vetinity için çıkarımlar

| Konu | Değerlendirme adayı | İlgili kayıt |
|---|---|---|
| Boarding operasyon dashboard | Check-in/out kolonları + durum legend | [CHECKIN-005](../backlog/feature-backlog.md), [CHECKIN-001](../backlog/feature-backlog.md) |
| Oda-kaynak rezervasyon takvimi | Kapasite + gün/hafta/ay timeline | [IDEA-014](../research/ideas.md#idea-014--configurable-scheduling-resources), [APPT-025](../backlog/feature-backlog.md), [PATTERN-012](../research/patterns.md#pattern-012--configurable-resource-calendar) |
| Reservation oluşturma | Client/Guest ayrımı; inline Add Client/Patient | [APPT-017](../backlog/feature-backlog.md), [APPT-018](../backlog/feature-backlog.md), [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation) |
| Reservation → Check In | Popover → Check In sihirbazı | [CHECKIN-001](../backlog/feature-backlog.md), [PATTERN-016](../research/patterns.md#pattern-016--check-in-as-workflow-orchestrator) |
| Check In orkestrasyonu | Billing, form, bundle, item rule, cage card | [CHECKIN-002](../backlog/feature-backlog.md)–[CHECKIN-004](../backlog/feature-backlog.md), [IDEA-020](../research/ideas.md#idea-020--check-in-orchestration) |
| Boarding Form template | Intake, cage card, behavior vb. | [CHECKIN-002](../backlog/feature-backlog.md), [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow) |
| Bundle + Item Rule | Boarding ve medical bundle; Apply Item Rule | [CHECKIN-003](../backlog/feature-backlog.md), [EXAM-007](../backlog/feature-backlog.md), [EXAM-014](../backlog/feature-backlog.md), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population) |
| Cage Card çıktı | Printer / Zebra / PDF | [CHECKIN-001](../backlog/feature-backlog.md) (açık doğrulama) |
| Inline Item | Check In'den envanter kalemi oluşturma | [EXAM-014](../backlog/feature-backlog.md), [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation) |
| Transactional e-posta | HTML şablon; event tetikleyici | [APPT-013](../backlog/feature-backlog.md), [APPT-012](../backlog/feature-backlog.md), [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications), [PATTERN-011](../research/patterns.md#pattern-011--template-first-communication) |

### Açık doğrulama soruları

- Boarding Dashboard legend değerlerinin tam listesi ve geçiş kuralları
- Checking In / Checking Out / Checked In kolonları ile legend eşleşmesi
- Oda kapasitesi (Max:N) aşımında rezervasyon davranışı
- Room resource çakışma ve bekleme listesi kuralları
- Popover Check In → Boarding Dashboard kolon değişimi
- Cancel reservation operasyonel/finansal yan etkileri
- Transactional e-posta şablon yönetimi ve Mail/SMS kanal ayrımı
- Unsubscribe ve transactional/marketing opt-in kuralları
- Boarding reservation ↔ Treatment Board Overnight Stay ilişkisi
- Check In sihirbazı adım yapısı ve zorunlu alanlar
- Daily Rate → invoice satırı üretim davranışı
- Apply Item Rule: hangi kurallar tetikleniyor; stok/fatura otomasyonu
- Boarding Form template → kayıt/belge çıktısı
- Cage Card Zebra/PDF şablon içeriği
- Inline Item oluşturma → inventory ve billing bağlantısı
- Medical Note oluşturma → SOAP/record ilişkisi
- Bundle seçiminin Boarding vs medical ayrımı

---

## Sandbox — Reminders (Reminders Detail)

**Ekran:** DaySmart Vet > Reminders > Reminders Detail

Genel Reminders modülü; Boarding veya yalnızca randevu hatırlatması kapsamı dışındadır.

### Reminders Detail ana tablo

**Sandbox gözlemi — tablo sütunları:**

| Sütun | Not |
|---|---|
| Seçim checkbox | Satır seçimi; kayıt açmaz (→ [Satır seçim davranışı](#satır-seçim-davranışı)) |
| Due | Vade tarihi |
| Type | İletişim kanalı/türü (ör. Email, SMS (Text)) |
| Owner | Müşteri |
| Patient | Hasta |
| Reminder For | Hatırlatmanın hedefi; yeşil bağlantı → Edit Reminder |
| Notes | Serbest not |
| Last Sent | Son gönderim |
| Client Next Visit | Müşterinin yaklaşan ziyareti |
| Home / Mobile / Email | İletişim bilgileri |

**Sandbox gözlemi — Reminder For yalnızca appointment değil:**

Örnek `Reminder For` değerleri:

- Appointment
- Follow up visit
- Farm Call
- Annual Exam
- Antigen Canine Heartworm Test
- Bordetella
- DHPP 1yr
- LD Rabies 1 Year

**Çıkarım (doğrulanmadı):** Reminder altyapısı randevu bildiriminden daha genel görünüyor — randevu, takip, muayene, aşı, laboratuvar/diagnostic ve diğer due-date taşıyan klinik kayıtlar aynı operasyonel listede toplanıyor olabilir. Kaynak kayıt silme veya otomatik oluşturma kuralları sandbox'tan **doğrulanmadı**.

**Sandbox gözlemi — Type (liste):** Email, SMS (Text)

**Sandbox gözlemi — Type (Edit Reminder):** Email, Phone, SMS (Text), No Reminder

Phone otomatik telefon araması anlamına gelmez; yalnızca kanal/tür seçeneği olarak gözlemlendi.

Mail (filtre) ile Email (liste/edit) arasındaki fark sandbox'tan **doğrulanmadı**.

### Filter Reminders

**Sandbox gözlemi — Filter modal alanları:**

| Boyut | Gözlem |
|---|---|
| Date Range | Preset + başlangıç/bitiş tarihi |
| Category | "Display all categories" vb. |
| Types | Çoklu seçim: Email, Phone, Mail, SMS (Text) |
| Next Visit | Örnek: "Include if next visit scheduled" |
| Patient Status | Çoklu seçim: Active, Inactive |

Update ile filtre uygulanıyor.

**Operasyonel filtre boyutları (sandbox kanıtı):** iletişim kanalı, next visit, patient status, category, date range.

### Satır seçim davranışı

| Etkileşim | Davranış |
|---|---|
| Checkbox | Reminder kaydını doğrudan açmaz; Actions / Export toplu işlemlerinin hedef kümesini belirler |
| Reminder For (yeşil bağlantı) | Edit Reminder modalını açar |

İki etkileşim birbirinden ayrıdır.

### Actions

Seçili reminder kayıtları için **Actions** menüsü (sandbox gözlemi):

- Print cards for selected
- **Resend selected** — toplu yeniden gönderim
- Log call for selected

### Log call / communication record

**Sandbox gözlemi:**

- Modal seçili kayıt sayısını belirtiyor
- Optional Notes alanı
- Create / Cancel
- Metin communication record oluşturulacağını açıkça belirtiyor

→ Vetinity iletişim geçmişi adayı: [MSG-001](../backlog/feature-backlog.md), [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline)

### Export

**Sandbox gözlemi — Export menüsü:**

- Download for all
- Download for selected
- Print for all
- Print for selected

**Açık soru:** "All" filtrelenmiş dataset mi yoksa tüm reminder dataset mi? Sandbox ekranından **kesin kanıtlanmadı**.

Download dosya formatı (CSV/XLSX vb.) sandbox'tan **doğrulanmadı**.

### Edit Reminder

Reminder For bağlantısından açılıyor.

**Read-only / bağlam alanları:** Client, Patient, Item, Given, Due

**Düzenlenebilir alanlar:** Type, Send, Notes, Apply To Record Given Date

**Type seçenekleri:** Email, Phone, SMS (Text), No Reminder

**No Reminder (çıkarım, doğrulanmadı):** Due-date/klinik kaydın silinmesi yerine reminder iletişiminin kapatılabildiğini **işaret ediyor olabilir**. Persistence ve domain davranışı sandbox'ta **doğrulanmadı** — kayıt listede kalıp kalması, Last Sent etkisi vb. bilinmiyor.

### Send kuralı (relatif reminder rule)

Send tek tarih alanı değil; relatif kural yapısı:

`[number]` + `[unit]` + `[direction]`

| Bileşen | Sandbox gözlemi |
|---|---|
| Number | Serbest sayısal değer (ör. 2) |
| Unit | Day(s), Week(s), Month(s), Year(s) |
| Direction | Before Due, After Due |

**Örnek:** 2 Week(s) Before Due

**Önemli pattern (sandbox kanıtı + çıkarım):** Reminder motoru yalnızca appointment başlangıç saatine bağlı görünmüyor; item'ın **Due** tarihine göre önce/sonra relatif reminder üretilebiliyor.

**Araştırma seviyesi domain modeli (implementasyon kararı değil):**

```
ReminderRule (çıkarım)
- channel/type
- offsetValue, offsetUnit, direction
- dueDate / referenceDate
- notes
- enabled / no-reminder state
```

→ Mevcut kayıtlar: [APPT-014](../backlog/feature-backlog.md), [EXAM-014](../backlog/feature-backlog.md), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population)

### Apply To Record Given Date

Edit Reminder'da checkbox mevcut; örnekte işaretli.

**Gerçek etkisi sandbox'tan doğrulanmadı — tahmin edilmedi.**

**Açık doğrulama soruları:**

- Given date ile Due date arasındaki ilişki nedir?
- Checkbox reminder değişikliğini kaynak medical/item record'un given date'ine mi uygular?
- Recurrence / due-date yeniden hesaplama etkisi var mı?
- Sadece mevcut reminder mı yoksa bağlı klinik kayıt da mı güncelleniyor?

### Tasarım çıkarımları (DaySmart → Vetinity değerlendirme)

| # | Sandbox evidence | Product implication | Vetinity relevance |
|---|---|---|---|
| A | Reminder For: appointment, aşı, lab, follow-up, farm call vb. | Due-date taşıyan klinik kayıtlar için genel reminder listesi | Randevu hatırlatması ([APPT-014](../backlog/feature-backlog.md)) ile klinik due-date reminder'ı ([EXAM-014](../backlog/feature-backlog.md), v1 Reminder System) ayrı kavramlar olarak değerlendirilebilir |
| B | Type: Email, Phone, SMS, No Reminder | Reminder mantığı ile delivery channel ayrılmış | [APPT-013](../backlog/feature-backlog.md), [APPT-023](../backlog/feature-backlog.md), [INT-003](../backlog/feature-backlog.md) kanal genişletmesi adayı |
| C | Send: N Unit Before/After Due | Relatif zamanlama due-date referanslı | [APPT-014](../backlog/feature-backlog.md) tercih modeli genişletme adayı |
| D | Resend, print cards, export, log call — seçili kayıtlar | Operasyonel reminder listesi bulk action destekliyor | Toplu iletişim ve export ihtiyacı; şablon/kanal [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications) |
| E | Log call → communication record | Reminder/contact attempt iletişim geçmişine bağlanıyor | [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md) |
| F | Client Next Visit sütunu | Yaklaşan ziyareti olan müşteride gereksiz hatırlatma değerlendirmesi | Next Visit filtresi ile birlikte operasyonel karar desteği adayı |

**Not:** Tablo "DaySmart'ta var → Vetinity aynısını yapmalı" iddiası taşımaz; sandbox kanıtı, ürün çıkarımı ve Vetinity ilişkilendirmesi ayrı sütunlarda tutulmuştur.

### İlgili Vetinity kayıtları

- [APPT-014](../backlog/feature-backlog.md) — hatırlatma tercihleri (kapsam genişletme notu)
- [APPT-013](../backlog/feature-backlog.md), [APPT-023](../backlog/feature-backlog.md) — kanallar, resend
- [EXAM-014](../backlog/feature-backlog.md), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population) — item/due-date reminder kaynağı
- [MSG-001](../backlog/feature-backlog.md), [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline) — log call / communication record
- [PORTAL-003](../backlog/feature-backlog.md) — portal reminder yüzeyi (klinik operasyon listesinden ayrı)
- [TIMELINE-003](../backlog/feature-backlog.md) — operasyonel liste filtre boyutları paraleli

### Açık doğrulama soruları (özet)

- Export "all" kapsamı: filtrelenmiş set mi, tüm dataset mi?
- Download formatı nedir?
- Mail vs Email Type farkı
- No Reminder persistence: kayıt listede kalır mı; due-date kaynağı etkilenir mi?
- Apply To Record Given Date tam davranışı (yukarıdaki alt maddeler)
- Phone Type operasyonel anlamı (manuel arama kaydı mı, otomatik arama mı?)
- Resend selected: aynı kanal mı; şablon override var mı?
- Reminder For yeşil bağlantı: her zaman Edit mi yoksa kaynak kayda deep link var mı?

---

## Sandbox — Clients / Client Module

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. DaySmart UI/IA birebir kopya önerisi değildir. ABD/enterprise alanları (Driver License, County, tax exemption vb.) benchmark olarak belgelenir; Vetinity MVP zorunluluğu **değildir**.

**Temel ayrım:** Client (customer) clinic operasyonunda Patient'tan **ayrı ana entity/read-model**. → [Patients Module](#sandbox--patients-module), [Patient-scoped vs client-scoped](#client-scoped-vs-patient-scoped-read-models)

### Client Dashboard / Client List

**Client Dashboard (sandbox gözlemi):** Total Active Clients, New Clients, Total Appointments grafikleri + altında Client List

**Client List kolonları:** Name, Home, Work, Mobile, Address, City, Pets, Status

**Filtreler:** alfabetik A–Z

**Name** → Client Profile; **Pets** → ilişkili patient kayıtları

**Vetinity değerlendirmesi (aday):** Temel müşteri listesi P1; analytics grafikleri P3 — aynı öncelik değil → [APPT-017](../backlog/feature-backlog.md), [REPORT-001](../backlog/feature-backlog.md)

### Client Profile — Header / Demographics {#client-profile-header}

**Sandbox gözleminde görülen alanlar (tam set değil, seçici liste):**

- Client adı + numeric ID, fotoğraf/avatar
- First/Last Name, Address, Zipcode, City, County, State, Country, Birthdate
- Home, Mobile, Work, Fax, Email
- Reminders, Driver License, Referred By, Balance, Payment Terms, Exempt From, Status, Discounts, Home Location
- **Last Visit**, **Next Visit** (derived read-model adayı)

**Türkiye/Vetinity için değerlendirilebilir (aday):** ad/soyad, telefon, e-posta, adres, durum, last/next visit, bakiye, iletişim tercihleri

**ABD/enterprise (benchmark only):** Driver License, County, Payment Terms, Exempt From — MVP **değil**

### Communication Preferences

**Sandbox gözlemi — ayrı bölüm:**

| Kategori | Gözlem |
|---|---|
| Transactional | Email |
| Marketing | None |

**SMS Send ekranı:** "The client has opted out of receiving communications via SMS" uyarısı; **Send Anyway** override seçeneği

**Domain ayrımı (çıkarım + sandbox kanıtı):**

- Contact detail ≠ communication consent/preference
- Transactional ≠ marketing communication
- Reminder tercihi ≠ marketing consent
- Override → audit adayı

**Türkiye:** ticari elektronik ileti/onay süreçleri ayrı research/gap; bu görevde hukuki implementasyon **tasarlanmadı** → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md)

### Relationships (Client → Pets)

**Kolonlar:** Name, Type, Breed, Sex, Color, Age, Assigned

Patient Profile > Relationships (owner) ile **aynı domain ilişkisinin** farklı read-model'i → duplicate entity **değil**

```
Customer ↔ Patient (tek domain ilişkisi)
  → customer-scoped pets query
  → patient-scoped owners query
```

### Contact Details

**Liste:** Contact, Type, Primary, Receive Automated Reminders, Description

**New Contact Detail:** Type, Contact, Primary, Receive Automated Reminders, Description

**Sandbox kanıtı:** birden fazla email/telefon; primary flag; automated reminders flag

**Vetinity:** tek phone/email MVP yeterliyse P2/P3 genişleme — gereksiz MVP karmaşıklığı **not edildi**

### Documents

**Alt kategoriler:** Attachments, Letters, Forms, Certificates

**New Attachment:** Source, file upload, Summary, Reference

**New Letter:** Template, Title, Date, Author, Patient, Reference/Medical Note

**New Form:** Template, Title, Patient — ör. Emergency Intake, Anesthesia Waiver, Boarding Waiver, New Client Intake, CPR Consent vb.

**Architectural ayrım:** attachment ≠ generated letter ≠ structured form ≠ certificate → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow)

MVP: attachment upload P1/P2; template engine / certificates P2/P3

### Billing — Client-scoped financial view {#client-billing}

Client Profile altında geniş Billing menüsü (sandbox gözlemi). Bunların çoğu **customer-scoped read-model**; her biri için yeni domain entity **önerilmez**.

**Modül düzeyinde detay (clinic-wide Billing workspace):** → [Sandbox — Billing / Financial Operations](#sandbox--billing--financial-operations)

| Menü / görünüm | Sandbox gözlemi | Vetinity eşleştirme |
|---|---|---|
| Balance header | $0.00; multi-clinic "(1 clinics)" | Customer balance aggregate — tenant/clinic semantics **doğrulanmadı** → [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [CHECKOUT-001](../backlog/feature-backlog.md) |
| Estimates | Reference, Title, Status, Total, Created, Notes; New: Patient/Provider optional, Valid Until, Bundle | → [CHECKIN-004](../backlog/feature-backlog.md), [billing-estimates](#billing-estimates) |
| Invoices | Reference, Total, Balance, Created; Open/Paid/Locked/Reopen; New: Patient optional, Medical Note, Bundle | → [RECORD-001](../backlog/feature-backlog.md), [billing-invoices](#billing-invoices) |
| Payments | Payment, Amount, Type, Date, **Applied To**, Notes — çoklu invoice allocation | → [billing-payments](#billing-payments), [CHECKOUT-001](../backlog/feature-backlog.md) |
| Credits | Reference, Total, Balance, Applied To | → [billing-credits](#billing-credits) |
| Refunds / Returns / Write Offs | Ayrı listeler | → [billing-returns](#billing-returns), [billing-refunds](#billing-refunds), [billing-write-offs](#billing-write-offs) |
| Late Fees | Applied, Invoice, Fee Applied/Waived, Balance Due | → [billing-invoices](#billing-invoices) (invoice alt sekmesi) |
| Declined Items | Declined, Patient, Item, Quantity, Reason — patient History > Declined Items ile **aynı source** | → [TIMELINE-003](../backlog/feature-backlog.md) |
| Account Statement | Email/Print; period, transaction detail, supporting invoices | P2 customer statement adayı → [PORTAL-004](../backlog/feature-backlog.md), [CHECKOUT-001](../backlog/feature-backlog.md) |

**Önemli çıkarım:** Invoice customer'a bağlı; patient ve medical note linkage **optional** olabilir.

### Communications {#client-communications}

**Menü:** View Communications, Log Communication, Send Email, Send SMS

**Liste:** Date, Communication, Patient, Attachments, Added By, Status

**Log Communication:** Patient optional, Date, Time, Type, Message

**Send Email:** Patients optional, To, Subject, rich text

**Send SMS:** opt-out warning + Send Anyway override

Communication ana olarak **client/contact** ile ilişkili; optional patient context. Patient History > Communications ile **aynı source** → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md)

### Appointments / Reservations

**Menü:** View All Appointments and Reservations; Appointments (All/Future/Past/Cancelled); Reservations (All/Future/Past/Cancelled); New Appointment

**Liste:** Type, Appointment, Patient, Description, Created, Created By, Status

Appointment + Boarding Reservation birleşik görünüm; domain **ayrı** → [CHECKIN-005](../backlog/feature-backlog.md), [Patients Module Appointments](#appointments-patient-profile)

### Reminders {#client-reminders}

**Liste:** Patient, Item, Due, Type, Remind, Notes, Last Sent — timing ör.: 1 week before due, 1 month before due, 1 week after due

**Menü:** View Reminders, New Reminder Bundle, New Reminder

**New Reminder Bundle:** Patient + Bundle (Annual Wellness, Boarding Bundle, Dental, Spay package vb.)

**New Reminder:** Patient, Item optional, Given, Due, Type, Send (quantity + unit + before/after due), Notes

**Reminder ≠ Task.** Patient/Client Profile Reminders = clinic Reminders Detail'in farklı query scope'u → [APPT-014](../backlog/feature-backlog.md), [Reminders sandbox](#sandbox--reminders-reminders-detail)

### Notes {#client-notes}

**Liste:** Title, Notification, Note, Date Added

**New Note:** Title, Notification (Profile Only, Pop-up), Note

**Clinical Medical Note / SOAP ≠ Customer operational note** — Patient Profile Notes ile semantik benzerlik; visibility/permission riski → [EXAM-009](../backlog/feature-backlog.md)

Pop-up notification UX pattern adayı — P2/P3

### Tasks {#client-tasks}

**Status:** Open, In Progress, Complete

**Liste:** Due, Status, Assigned To, Patient, Task, Created

**New Task:** Task, Priority (Normal/High), Staff, Due date/time, Contact, Patient optional, Item(s) optional, Repeat (Daily…Custom), Notes

**Task ≠ Reminder.** Staff workflow; recurring task MVP **değil** → [MSG-004](../backlog/feature-backlog.md) (inbox görevi farklı kapsam)

### Client-scoped vs Patient-scoped read models {#client-scoped-vs-patient-scoped-read-models}

| Domain source | Client-scoped | Patient-scoped |
|---|---|---|
| Communication | Client Profile > Communications | Patient History > Communications |
| Appointment/Reservation | Client Appointments | Patient Appointments |
| Reminder | Client Reminders | Patient Reminders |
| Document | Client Documents | Patient Documents |
| Billing | Client invoices/payments | History Invoice/Reference links |
| Relationship | Client → Pets | Patient → Owners |
| Task | Client Tasks | Patient reference optional |
| Declined Item | Client Billing > Declined | Patient History > Declined Items |

→ [TIMELINE-002](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md) (timeline read-model prensibi genişletme adayı)

### DaySmart'tan kopyalanmaması gerekenler

- Aşırı dropdown nesting ("View X" menü yığını)
- Eski desktop-style yoğun finans menüsü
- ABD'ye özgü demografi alanları

**Korunacak benchmark:** domain coverage, cross-navigation, customer↔patient↔invoice↔appointment bağlantıları

### Client Gap Analysis {#client-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Priority |
|---|---|---|---|---|---|
| Client List | A–Z; Pets column; Status | Kısmi | APPT-017 | Liste + lifecycle + pets summary | P1 |
| Client Dashboard analytics | 3 chart | Yok/kısmi | REPORT-001 | Read-model metrics | P3 |
| Client Profile header | Balance, last/next visit | Kısmi | IDEA-007, MSG-001 | Customer 360 summary | P1 |
| Communication Preferences | Transactional/Marketing; SMS opt-out | Yok | IDEA-019, MSG-001 | Consent vs contact; KVKK research | P1/P2 |
| Contact Details (multi) | Primary; reminder flag | Belirsiz | MSG-001 | Multi-contact P2/P3 | P2 |
| Client Documents | Attach/Letter/Form/Cert | Araştırılacak | IDEA-018 | Subtype model | P2 |
| Customer balance | Header aggregate | Belirsiz | IDEA-007, CHECKOUT-001 | Clinic vs tenant scope TBD | P1 |
| Invoice history (client) | Open/Paid/Locked | Kısmi | RECORD-001, IDEA-007 | Customer-scoped query | P1 |
| Payment allocation | Multi-invoice Applied To | Belirsiz | CHECKOUT-001 | Allocation model gap | P1/P2 |
| Estimates | New Estimate flow | Kısmi | CHECKIN-004 | Teklif lifecycle | P1/P2 |
| Account Statement | Email/Print | Yok | PORTAL-004, CHECKOUT-001 | Statement extract | P2 |
| Declined Items | Client + Patient view | Yok | TIMELINE-003 | Shared source read-model | P2 |
| Client Communications | Log/Send Email/SMS | Araştırılacak | MSG-001, IDEA-019 | Shared comm entity | P1/P2 |
| Client Appointments | Appt + Reservation | Kısmi | CHECKIN-005 | Unified query | P1 |
| Client Reminders | Bundle + multi schedule | Kısmi | APPT-014, EXAM-014 | Scoped queries | P1 |
| Client Notes | Pop-up notification | Yok | EXAM-009 | Operational note domain | P2 |
| Client Tasks | Recurring staff task | Yok | MSG-004 | Task domain (≠ reminder) | P2/P3 |
| Credits/Refunds/Late Fees | Ayrı read-models | Yok/kısmi | CHECKOUT-001 | Advanced billing | P2/P3 |

### Açık doğrulama soruları (Clients Module)

- Balance multi-clinic aggregate semantics
- Payment allocation kuralları ve partial apply
- Send Anyway override audit trail
- Locked/Reopen invoice iş kuralları
- Reminder bundle → kaç reminder rule üretiyor
- Pop-up note visibility scope (kullanıcı/rol)
- Recurring task üretim davranışı
- Marketing vs transactional channel enforcement backend'de mi UI'da mı

---

## Sandbox — Contacts / Contact Module

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. Contact ≠ Client ≠ Patient domain ayrımı korunur. Navigation/IA birebir kopya önerisi değildir.

**Temel ayrım (benchmark + çıkarım):**

| Kavram | DaySmart rolü | Vetinity değerlendirmesi (aday) |
|---|---|---|
| **Client** | Müşteri / pet owner / billing & operasyon merkezi | Mevcut **Customer** ana kavramı |
| **Contact** | Dış CRM/adres defteri — kişi veya şirket | External person/company directory — **Client'tan ayrı** |
| **Patient** | Klinik hayvan kaydı | Mevcut **Pet/Patient** |

→ [Clients Module](#sandbox--clients--client-module), [Patients Module](#sandbox--patients-module)

### Contact Dashboard / Contact List

**Ekran:** Contacts > List (Contact Dashboard)

**Üst aksiyonlar:** New Contact, New Company

**Analytics (sandbox gözlemi):** New Contacts, Total Active Contacts; üçüncü grafikte Total Active Contacts benzeri label tekrarı — UI anomalisi olabilir; **kesin domain anlamı çıkarılmadı**

**Contact List:** A–Z alfabetik filtre

**Kolonlar:** Name, Title, Address, Office, Email

**Liste:** kişi ve şirket kayıtları **aynı dizinde** — ör. ABC Clinic, abc farm, Angela Dugan

**Name** → Contact veya Company profile

**Vetinity:** Analytics P3; rehber/list P2 — aynı priority değil → [REPORT-001](../backlog/feature-backlog.md)

### New Contact (person)

**Alanlar (sandbox gözlemi):** Salutation, First Name (required), Last Name (required), Title, Address, Zipcode, City, State, Country, Email, Phone/Office Phone, Mobile Phone, Fax Phone — telefonlarda country code selector

External person profile; ABD adres detayları MVP **değil**

### New Company

**Alanlar:** Company/Name (required), Address, Zipcode, City, State, Country, Phone, Fax, Email, Website, Account (optional)

Kişi + şirket ortak directory; profil yapıları **farklı**

### Company Profile {#company-profile}

**Örnek:** ABC Clinic

**Alanlar:** Name, Phone, Fax, Website, Email, Address, Zipcode, City, County, State, Country, Account

**Aksiyonlar:** Edit Company, Delete Company

**Alt modüller:** Relationships, Communications — **Tasks gözlemlenmedi**

Client billing profile **değil**

### Person Contact Profile {#person-contact-profile}

**Örnek:** Angela Dugan

**Alanlar:** Salutation, First/Last Name, Title, Address, County, Phone, Mobile, Fax, Email

**Aksiyonlar:** Edit Contact, Delete Contact

**Alt modüller:** Relationships, Communications, **Tasks**

### Relationships {#contact-relationships}

**Menü:** View Relationships, New Relationship

**Liste:** Name, Type, Address, Phone, Email

**Company örneği — Type:** Referred Patient (Charleigh S, Jinseng Lee, Spot Soong deceased vb.)

**New Relationship:** Contact (profile otomatik), Relation (type), Name (hedef entity)

**Gözlenen type örnekleri (tam taxonomy değil):** Boards, Cares For (Primary/Specialty), Clinic, Grooms, Is Adopter Of, Is Affiliated With, Is Business Owner Of, Is Caretaker For, Is Colleague Of, Is Emergency Contact For, Is Employed By, Is Farrier For, Is Former Clinic For, Is Fosterer Of, Is Insurance Provider For, Is Owned By, Is Pharmacist For, Is Pharmacy For, Is Previously Fostered By, Referred Patient, …

**Çıkarım:** generic typed relationship graph adayı — Vetinity MVP'de tam taxonomy **gerekli değil**

**Öncelik (değerlendirme adayı):** referring clinic/veterinarian P1/P2; generic CRM graph P2/P3

**Customer↔Pet ownership ile duplicate domain yok** — external contact/company ↔ patient referral ayrı ilişki tipi olabilir

### Company Communications {#contact-communications}

**Menü:** View Communications, Log Communication, Send Email — **Send SMS sandbox'ta görülmedi**

**Liste:** Date, Type, Patient, Communication, Reference, Add By, Status

**Örnek satırlar:** "Purchased 10 Cydectin Oral Drench…", "Purchased 1 Bravecto…" — kaynak communication mı system-generated activity mi **doğrulanmadı**; operational feed'de birleşik görünüm **çıkarım**

**Log Communication:** Patient optional, Date, Time, Type (default Phone), Message required

**Send Email:** Patient(s) optional, To, Subject, Message (rich text)

### Person Contact Communications

Aynı liste shape; **Send SMS** mevcut — ör. Type = SMS (Text)

Client / Patient / Contact / Company → **shared communication source**, farklı scoped read-model → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline), [MSG-001](../backlog/feature-backlog.md), [TIMELINE-002](../backlog/feature-backlog.md)

### Contact Tasks {#contact-tasks}

**Person Contact'ta** Tasks; Company profile'da **gözlemlenmedi**

**Status:** Open, In Progress, Complete

**Liste:** Due, Status, Assigned To, Patient, Task, Created

**New Task:** Task (required), Priority (Normal/High), Staff, Due date+time, Contact (auto), Patient optional, Item(s) optional, Repeat, Notes

**Repeat seçenekleri:** Does not repeat, Every day, Every weekday, Every weekend, MW/F, Tu/Th, Every Week, 2/3/4 Weeks, Every Month, Every Year, Custom

**Task ≠ Reminder ≠ Note** — Client Tasks ile **aynı task domain**; duplicate entity **değil** → [MSG-004](../backlog/feature-backlog.md)

### Patient / Client / Contact — cross-module read-models {#contact-cross-module-read-models}

| Capability | Patient | Client | Contact/Company |
|---|---|---|---|
| Relationships | Owners | Pets | External ↔ Patient referral vb. |
| Communications | History | Profile | Profile |
| Tasks | (ref optional) | Profile | Person profile |
| Documents | ✓ | ✓ | gözlemlenmedi |
| Appointments | ✓ | ✓ | — |
| Reminders | ✓ | ✓ | — |
| Billing | History links | Primary | — |

**Prensip:** same source/domain → context-specific query/read-model → [TIMELINE-002](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md)

### Contact Gap Analysis {#contact-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Priority |
|---|---|---|---|---|---|
| Contact directory (person+company) | Unified list; New Contact/Company | Yok | MSG-001, TIMELINE-002 | External CRM directory | P2 |
| Contact ≠ Client | Ayrı nav ve domain | Kısmi (Customer var) | APPT-017, Clients Module | Domain boundary doc | P1 (kavram) |
| Referral relationships | Referred Patient type | Yok/kısmi | Randevu Referred By alanı | Typed referral link | P1/P2 |
| Contact Communications | Log/Send Email/SMS | Araştırılacak | MSG-001, IDEA-019 | Shared comm + contact scope | P2 |
| Manual comm log | Phone default Type | Yok | MSG-001 | In-person/phone log | P2 |
| Contact Tasks | Staff assign, repeat | Yok | MSG-004 | General task domain | P2/P3 |
| Contact analytics | Dashboard charts | Yok | REPORT-001 | P3 metrics | P3 |
| Generic relationship taxonomy | 20+ types | Yok | — | Full CRM graph | P3 |

### Açık doğrulama soruları (Contacts Module)

- Dashboard üçüncü grafik label tekrarı anlamı
- Company Communications'da satış açıklamalarının kaynak entity'si
- Relationship type listesinin profile tipine göre filtrelenmesi
- Company'de Tasks yokluğu ürün kuralı mı sandbox eksikliği mi
- Account alanı (Company) finansal bağ mı serbest metin mi
- Delete Contact/Company cascade kuralları

---

## Sandbox — Inventory / Inventory Module

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. Catalog Item ≠ Stock Balance ≠ Stock Movement; Purchase Order ≠ Receipt; Supplier ≠ Customer ≠ arbitrary Contact; Service ≠ physical stock item. Navigation/IA ve US-specific alanlar (NDC, eyalet/ilçe vergileri) birebir kopya önerisi **değildir**.

**Temel domain ayrımları (benchmark + Vetinity çıkarımı):**

| Kavram | DaySmart rolü | Vetinity değerlendirmesi (aday) |
|---|---|---|
| **Catalog Item** | Kimlik, kategori, fiyat, klinik metadata, billing davranışı | Ürün/hizmet kataloğu master — [ux/navigation.md](../ux/navigation.md) Ürünler |
| **Stock Balance** | Stok takipli kalemlerde anlık miktar | Stok durumu ekranı |
| **Stock Movement / Ledger** | Purchase, usage, adjustment, return vb. denetlenebilir hareket | Stok hareketleri — sessiz bakiye overwrite **değil** |
| **Purchase Order** | Tedarikçiye sipariş niyeti; kısmi teslim | v1 Stock Management kapsam adayı — ayrı backlog ID yok |
| **Receipt / Goods Receipt** | Fiili mal kabul; PO'ya bağlanabilir; Posted | PO'dan ayrı entity |
| **Supplier** | Procurement dropdown; Contact/Company kaynaklı görünüm | Supplier ≠ Client; Contacts Module ile ilişki → [Contacts Module](#sandbox--contacts--contact-module) |
| **Service vs Stock Item** | Category Type: Inventory veya Service; tek liste | Katalog birleşik olabilir; stok takibi ayrı flag |

→ [Patients Module](#sandbox--patients-module) (item usage → patient), [Clients Module](#sandbox--clients--client-module) (returns/billing), [Contacts Module](#contact-gap-analysis) (supplier directory)

### Inventory Dashboard {#inventory-dashboard}

**Ekran:** Inventory ana modülü

**Sol navigasyon (sandbox gözlemi):** List, Alerts, Categories, Orders, Receipts

**Dashboard analytics:** Inventory Distribution (pasta), Orders Created, Receipts Created

**Dashboard sekmeler/aksiyonlar:** Alerts, Categories, Orders, Receipts, Quick Edit

**Üst aksiyonlar:** New Item, Bulk Update

**Gözlem:** Operasyonel stok yönetimi, tedarik/alım ve raporlama widget'ları **aynı dashboard'da** birleşik.

**Vetinity değerlendirmesi:** Operasyonel stok ve tedarik akışları öncelikli; analytics grafikleri P3. DaySmart navigasyonu birebir kopyalanmamalı → [AI-101](../backlog/feature-backlog.md) kritik stok sorgusu ayrı kanal.

### Inventory List / Quick Edit {#inventory-list-quick-edit}

**Ekran:** Inventory > List (dashboard Quick Edit/list görünümü)

**Kolonlar:** Item, Subcategory, Controlled, Price/UOM, Balance

**Sandbox örnekleri:**
- Aktif ve **inactive** kalemler aynı listede
- Fiziksel stok kalemleri (ör. şişe başına shampoo)
- **Service-benzeri** kalemler — balance unavailable veya **negatif** (ör. X-Ray balance -1)

**Önemli domain gözlemi:** DaySmart Inventory yalnızca fiziksel stok değil; aynı katalogda **stocked goods, pharmacy, supplies, services, fees, diagnostic, professional services** bir arada.

**Vetinity çıkarımı (3 katman):**
1. Catalog / item master
2. Stock-tracked inventory items
3. Services / non-stock items

Tek liste gösterimi mümkün; **duplicate entity üretilmemeli**.

### New Item / Item Master {#inventory-new-item}

**Ekran:** New Item

**Identity (sandbox gözlemi):**
- Name — required
- Display Name — optional
- Status — Active/Inactive
- Category — required

**Clinical/pharmacy:**
- Controlled — Yes/No
- Concentration, concentration UOM
- Dose Range min/max, dose UOM
- Dose
- National Drug Code (NDC) — **US-specific; Vetinity MVP alanı değil**
- Route, Instructions

**Pricing:**
- Base Price; pricing mode (ör. Fixed)
- Minimum Price; minimum-price basis (ör. Per Item Total)
- Fees, Base Quantity, UOM

**Printing/billing:**
- Print Label, Print on Invoice, Next Due

**Stock:**
- Starting Balance
- Transactions, Purchased, Restocked, Adjustment, Current Balance, Note

**Location:** Location

**Vetinity çıkarımı:** NDC kopyalanmaz; generic **pharmaceutical identifier / barcode / product code**, lot/batch, expiration, controlled medicine, dosage metadata korunur. Türkiye tıbbi/regülasyon tanımlayıcıları → **research/TBD** (bu görevde mevzuat araştırması yapılmadı).

### Item Detail Page {#inventory-item-detail}

**Ekran:** Item profile — master + stock özeti birleşik

**Gözlenen alanlar:** Name, Display Name, Status, Category, Controlled, Concentration, Dose Range, Dose, NDC, Base Price, Base Quantity, Unit Cost, Minimum Price, Fees, Print Label, Print on Invoice, Next Due, Route, Location, Instructions, Starting Balance, Transactions, Purchased, Restocked, Adjustment, Current Balance, Note

**Costing gözlemi (sandbox örneği):**
- Base Price: $15.00 (**200% of highest cost**)
- Unit Cost: $7.50 / Bottle(s) (**based on highest cost**)

**Çıkarım:** DaySmart sabit satış fiyatına ek olarak **cost-derived pricing** destekliyor. Vetinity "highest cost" kuralını birebir kopyalamamalı; benchmark olarak **fixed price, cost-derived price, markup/percentage pricing** stratejileri dokümante edilir → [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability).

**Alt modüller (tabs):** Price Tiers, Actions, Transactions, Purchases, Adjustments, Returns, Taxes, Uses, Bundles, Discounts, Production Credit, Rules — **11 ayrı Vetinity modülü olarak kopyalanmamalı**; mevcut backlog kavramlarına map edilir (aşağıda).

### Price Tiers {#inventory-price-tiers}

**Ekran:** Item detail > Price Tiers

**New Pricing Tier:** Max Quantity, Discount %, Notes

**Örnek:** Max Quantity = 1, Discount off base = 0%

**Çıkarım:** Item-specific **quantity-based pricing tiers**.

**Ayrım (Vetinity):**
- Item price tier ≠ customer discount ≠ campaign/promotion ≠ bundle pricing

**Öncelik:** P2/P3 — dedicated backlog kaydı yok.

### Item Actions (Automation) {#inventory-item-actions}

**Ekran:** Item detail > Actions

**Mevcut örnek:** Action: Create alerts; When Using: This item; For: This item; Value: Low Balance: 5 remaining

**New Action türleri (sandbox gözlemi):** Add attachment, Change patient status, Create alerts, Create form, Create letter, Create reminder, Create task, Disable reminder, Print certificate, Set patient sex to desexed

**Bundle propagation:** Update all bundles / Update specific bundles / Do not update bundles

**Architectural gözlem:** Item/service **usage → workflow side effects** (reminder, task, patient status, certificate). Bu yalnızca inventory değil; rule/workflow automation kavramı.

**Vetinity:** [EXAM-014](../backlog/feature-backlog.md), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population) genişletmesi; Item Action ≠ Reminder; tam workflow engine P3.

### Transactions {#inventory-transactions}

**Ekran:** Item detail > Transactions

**Kolonlar:** Given, Patient, Quantity, Price, Invoice, Lot No, Manufacturer, Expiration

**Örnek:** 1 bottle → patient → Invoice #1849

**Domain gözlemi:** catalog → patient → invoice → quantity → lot/batch → manufacturer → expiration **tek usage hattında** bağlanıyor.

**Vetinity prensibi:** Aynı kaynak hareket / fatura satırı / klinik usage şu read-model'lerde görünebilir: item history, patient history, invoice, inventory ledger — **duplicate source entity yok** → [TIMELINE-002](../backlog/feature-backlog.md), [RECORD-001](../backlog/feature-backlog.md), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability), [ADR-006](../decisions/ADR-006-patient-timeline.md).

### Purchases (Item procurement history) {#inventory-purchases}

**Ekran:** Item detail > Purchases

**Liste kolonları:** Supplier, Manufacturer, Quantity, Total Cost, Unit Cost, Lot No, Expires, Balance, Posted, Order, Receipt, Posted By

**New Purchase modal:** Supplier (required), Manufacturer, Date, NDC, Lot No, Expires, Quantity, Cost, Shipping, Tax

**Supplier dropdown:** External company/contact-type kayıtlarına benziyor — **Supplier ≠ arbitrary Contact** → [Contacts Module](#company-profile)

**Stock kavramı:** Purchase = supplier + quantity + unit/total cost + batch/lot + expiration + shipping/tax + posting status.

**Öncelik:** P1/P2 — v1 [Stock Management](../roadmap/v1-release-scope.md) release blocker; detaylı backlog maddesi henüz yok.

### Adjustments {#inventory-adjustments}

**Ekran:** Item detail > Adjustments

**History kolonları:** Adjustment, Lot, Reason, Notes, Date, Created By

**New Adjustment:** Item, Current Balance, Actual Balance, Date, Reason, Notes

**Gözlenen reason örnekleri:** Discarded, Missing, Defect, Other, Clinic Use, Monthly Adjustment, Donation, Expired, Free Goods, Returned to Vendor

**Vetinity prensibi:** Adjustment = **auditable stock movement**; sessiz bakiye overwrite **değil**. En az: önceki/beklenen bakiye, gerçek/sonuç bakiye veya delta, reason, timestamp, user, lot (varsa), notes → [RECORD-002](../backlog/feature-backlog.md), [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions), [IDEA-025](../research/ideas.md#idea-025--auditable-clinical-record-lifecycle).

### Returns {#inventory-returns}

**Ekran:** Item detail > Returns

**Kolonlar:** Return, Client, Quantity, Total, Reason, Notes, Issued, Date

**Sandbox:** Return satırı **gözlemlenmedi** — yalnızca yüzey var.

**Çıkarım:** Returns client/customer ve finansal değerlerle ilişkili görünüyor. İade kuralları **doğrulanmadı** → [CHECKOUT-001](../backlog/feature-backlog.md), [Billing Module — Returns](#billing-returns), [Clients Module](#client-billing)

### Taxes {#inventory-taxes}

**Ekran:** Item detail > Taxes

**Liste:** Name, Applicable / Not Applicable — örnekler: VAT, GST, City Tax, State/County taxes (US sandbox)

**Vetinity:** US vergi taksonomisi kopyalanmaz. Generic: item/service → applicable tax config. Türkiye: **KDV**, e-Fatura/e-SMM → [INT-005](../backlog/feature-backlog.md). Localization **research/TBD**.

### Uses (Alternate billable configurations) {#inventory-uses}

**Ekran:** Item detail > Uses

**New Use:** Name, Display Name, Base Price, pricing strategy (ör. % of highest cost), Minimum Price, Fees, Base Quantity, Next Due, Print Label, Print on Invoice

**Fees selector:** Diğer catalog/service/fee kalemlerine referans

**Çıkarım:** Tek base item → birden fazla **billable use/variant** (dispensing, procedure, admin fee, farklı sunum fiyatı).

**Vetinity:** DaySmart "Uses" abstraction'ı hemen benimsenmemeli; P2/P3 advanced catalog/pricing pattern olarak kayıt.

### Bundles (Item ↔ bundle mapping) {#inventory-bundles}

**Ekran:** Item detail > Bundles

**Kolonlar:** Bundle, Quantity, Total, Print on Invoice/Estimate, Added

**Add to bundle:** bundle seçimi

**Örnek bundle türleri:** wellness exams, vaccination, boarding, dental, neuter/spay, invoice bundles, estimate bundles

**Vetinity cross-ref:** [EXAM-007](../backlog/feature-backlog.md), [EXAM-013](../backlog/feature-backlog.md), [IDEA-023](../research/ideas.md#idea-023--configurable-clinical-bundles), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion), [CHECKIN-004](../backlog/feature-backlog.md). Bundle ≠ product category.

### Discounts (Item eligibility) {#inventory-discounts}

**Ekran:** Item detail > Discounts

**Liste:** Name, Applicable / Not Applicable — örnek isimler (5%, Cash, Dental, Employee Discount vb.) **kopyalanmaz**

**Ayrım:** discount definition ≠ item applicability ≠ customer eligibility ≠ price tier ≠ promotion

**Öncelik:** P2 — dedicated backlog yok.

### Production Credit {#inventory-production-credit}

**Ekran:** Item detail > Production Credit

**Sandbox:** Tab mevcut; kayıt **gözlemlenmedi**. İş kuralı **doğrulanmadı**.

**Öncelik:** P3 / unresolved — veteriner/staff production compensation mevcut gereksinimde yok.

### Rules — Species / Weight / Age {#inventory-rules}

**Ekran:** Item detail > Rules

**Rule türleri:** Species, Weight, Age

**Species rule:** species + breeds (hiyerarşik seçici) + sex; örnek: tüm breed / tüm sex

**Çıkarım:** Item/service eligibility → patient attributes (species/breed, sex, weight, age). Klinik güvenlik (vaccine, medicine, species-specific product).

**Vetinity:** Generic rules engine **bu dokümandan türetilmemeli**. [EXAM-014](../backlog/feature-backlog.md) item rule kapsamına yakın ama eligibility ≠ field population. P2/P3.

### Inventory Alerts {#inventory-alerts}

**Menü:** Inventory > Alerts — View All Alerts, View Expiring, View Low Balance

**Kolonlar:** Item, Type, Lot, Balance, Expire, Notes, Order, Last Order, Last Quantity

**Sandbox:** Low-balance kayıtları gözlemlendi

**Vetinity ayrımı:** low stock, expiring lot, expired inventory, negative/inconsistent stock

**Cross-ref:** critical stock → [AI-101](../backlog/feature-backlog.md); lot/expiry → [RECORD-005](../backlog/feature-backlog.md). Likely P1 critical stock; P1/P2 lot/expiration.

### Categories / Subcategories {#inventory-categories}

**Menü:** Inventory > Categories

**Gözlenen üst kategoriler (örnekler, Vetinity default değil):** Administrative Fees, Ancillary, Anesthesia, Boarding, Dentistry, Diagnostic Imaging, Dietary Products, Equipment, Grooming, Hospitalization / Inpatient, Immunizations, Laboratory / Diagnostics, Mortuary, Other Medical, Other Non-Medical, Outpatient Services, Pharmacy, Professional Services, Surgery

**New Category:** Type (**Inventory** veya **Service**), Category, Sub Category, Description

**Çıkarım:** Paylaşılan kategorizasyon + **Type ayrımı** (Inventory vs Service) — unified catalog destekler.

**Vetinity:** [UX-005](../backlog/feature-backlog.md) ürün kategorileri; Type (stock vs service) metadata eklenebilir.

### Purchase Orders {#inventory-purchase-orders}

**Menü:** Inventory > Orders

**Filtreler:** View All, Open, Submitted, Partially Received, Closed, New Order

**Liste kolonları:** Order, Created, Supplier, Items, Amount, Status, Updated

**New Order:** Template, Supplier (required), Account No, Date, Ship To, Bill To, Notes

**Order detail:** Supplier, Account No, Date, Ship To, Bill To, Status, Items amount, Shipping, Total, Notes

**Order line:** Item, Quantity, Cost, Received, Back Ordered, Receipts, Notes

**Aksiyonlar:** Edit Order, Export, Save As Template

**Lifecycle gözlemi:**

```
Purchase Order → (partial) Receipt(s) → per-line received qty + back-order → Closed
```

**Gözlenen status örnekleri:** Open, Submitted, Partially Received, Closed — geçiş kuralları **doğrulanmadı**

**Vetinity:** Procurement lifecycle; PO ≠ stock increase → [v1 Stock Management](../roadmap/v1-release-scope.md).

### Receipts / Goods Receiving {#inventory-receipts}

**Menü:** Inventory > Receipts

**Filtreler:** View All, In Process, Posted, New Receipt

**Liste:** Receipt, Supplier, Status, Items, Total, Created, Last Updated

**Receipt detail:** Supplier, Status, Invoice, Date, Cost, Shipping, Tax, Total, Notes

**Receipt lines:** Item, Post To, Reference, Received Qty, Stock Qty, Cost, Tax, Manufacturer, Lot #, Expiration

**PO bağlantısı örneği:** Order #82 → Receipt #61 → çoklu kalem → Posted

**Domain prensibi:**

```
Purchase Order ≠ Receipt ≠ Stock Movement
PO → Receipt / Goods Receipt → Posted Receipt → Stock movement(s) → Balance update
```

Kısmi teslim ve audit için entity'ler **collapse edilmemeli**.

### Bulk Update {#inventory-bulk-update}

**Aksiyon:** Inventory dashboard Bulk Update

**Apply To:** Specific Items, Specific Categories (çoklu seçim)

**Update seçenekleri:** Change Controlled Status, Change Fees, Change Next Due, Change Print on Invoice Status, Create Action, Increase Price, Remove Action, Set Price

**Vetinity:** P2/P3 admin productivity; Türkiye'de sık fiyat güncellemesi operasyonel ihtiyaç olabilir — implementasyon **değil**, benchmark.

### Domain Model Summary {#inventory-domain-model}

| Entity | Rol |
|---|---|
| A. Catalog Item | Identity, type, category, billing, clinical/pricing metadata |
| B. Stock Balance | Stock-tracked items quantity on hand |
| C. Stock Movement / Ledger | Auditable quantity changes |
| D. Purchase Order | Supplier order intent |
| E. Receipt | Actual goods received (partial OK) |
| F. Supplier | Procurement relationship — not every Contact |
| G. Lot / Batch | Optional traceability |
| H. Item Pricing | Fixed, cost-derived, tiers, minimum, discount eligibility |
| I. Item Automation / Rule | Usage-triggered workflow |
| J. Bundle | Reusable item/service set |
| K. Service vs Stock Item | Shared catalog, distinct tracking |

### Turkey Localization {#inventory-turkey-localization}

**Kopyalanmaz:** NDC, US state/county tax, US controlled-drug semantics, US-specific address/account fields

**Research/TBD (bu görevde mevzuat araştırması yapılmadı):** KDV, medicine/product identifiers, controlled medicines, lot/batch traceability, expiration, e-Fatura/e-SMM, veterinary medicine regulations → [INT-005](../backlog/feature-backlog.md)

### Cross-Module Integration {#inventory-cross-module}

| Domain | Inventory bağlantısı |
|---|---|
| **Patients** | Item use / medication / procedure → patient history, lot/route |
| **Clinical** | Medication metadata, controlled, dose, route |
| **Billing** | Invoice lines, sale price, discount, tax, returns |
| **Client** | Customer purchase/return relationships |
| **Contacts** | Supplier/vendor — external directory; ≠ Client |
| **Timeline** | Same usage → patient timeline, invoice, item transactions, product detail |
| **Reminders/Tasks** | Item Actions → create reminder/task |
| **Estimates** | Bundles on estimate |

**Prensip:** same source/domain → context-specific read-model → [TIMELINE-002](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md)

### Inventory Gap Analysis {#inventory-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Priority |
|---|---|---|---|---|---|
| Item/product master | New Item; unified catalog | Planlı (v1 Products) | [v1 scope](../roadmap/v1-release-scope.md), [UX-005](../backlog/feature-backlog.md) | Catalog fields (controlled, dose, UOM) | P0/P1 |
| Service vs stock distinction | Category Type Inventory/Service | Kısmi (nav ayrımı yok) | UX-005 | Type metadata | P0/P1 |
| Category/subcategory | 19+ categories | UX-005 Tanımlar | UX-005 | Subcategory | P0/P1 |
| Stock balance & tracking | Balance column; negative possible | Planlı | v1 Stock Management | Enable/disable tracking | P0/P1 |
| Stock movement ledger | Transactions, Purchases, Adjustments | Planlı (Stok hareketleri) | v1 scope | Auditable ledger | P0/P1 |
| Manual adjustment + reason | Current vs Actual balance | Yok | RECORD-002 pattern | Adjustment entity | P1 |
| Critical/low stock alert | Alerts; item Actions | Yok | AI-101 (query) | Operational alerts UI | P1 |
| Lot/batch/expiration | Purchases, Transactions, Alerts | Kısmi (record) | RECORD-005 | Inventory-level lot | P1/P2 |
| Supplier procurement | Purchases, PO, Receipt | Yok | Contacts Module | Supplier domain | P1/P2 |
| PO lifecycle | Open→Submitted→Partial→Closed | Yok | v1 Stock Management | Full PO workflow | P1/P2 |
| Goods receipt posting | Posted receipt → stock qty | Yok | v1 scope | Receipt ≠ PO | P1/P2 |
| Partial receive / back-order | Order line Received/Back Ordered | Yok | — | Line-level tracking | P1/P2 |
| Item usage → patient/invoice | Transactions tab | Kısmi (RECORD-001) | PATTERN-005, TIMELINE-002 | Inventory read-model | P1 |
| Cost-derived pricing | % of highest cost | Yok | IDEA-007 | Pricing strategy | P2 |
| Price tiers | Quantity discount tiers | Yok | — | Item tiers | P2/P3 |
| Bundles on item | Item ↔ bundle map | Planlı | EXAM-007, PATTERN-018 | Estimate/invoice bundle | P2 |
| Item Actions automation | Usage → reminder/task/status | Araştırılacak | EXAM-014, PATTERN-021 | Workflow triggers | P2/P3 |
| Species/weight/age rules | Item eligibility | Yok | EXAM-014 (related) | Eligibility rules | P2/P3 |
| Uses (billable variants) | Alternate pricing per use | Yok | — | Advanced catalog | P2/P3 |
| Bulk catalog update | Bulk Update | Yok | — | Admin productivity | P2/P3 |
| Discount applicability | Per-item discount flags | Yok | — | vs price tier | P2 |
| Returns | Client-linked returns tab | Yok | CHECKOUT-001 | Refund rules TBD | P1/P2 |
| Tax per item | VAT/GST applicable flags | Planlı (KDV) | INT-005 | TR localization | P2 |
| Inventory dashboard charts | Pie + order/receipt charts | Yok | REPORT-001 | Analytics | P3 |
| Production Credit | Tab only | Yok | — | Semantics unknown | P3 |
| NDC / US drug ID | Item field | N/A | — | TR identifier TBD | Research |

### Açık doğrulama soruları (Inventory Module)

- Negatif balance: izinli mi yoksa veri tutarsızlığı mı?
- Cost-derived pricing: hangi cost kaynağı (FIFO, highest, average)?
- Receipt "Post To" ve "Reference" alanlarının tam semantics
- Purchase Posted vs Receipt Posted ilişkisi
- Item Actions tetiklenme anı (invoice, record, dispensing?)
- Uses vs Base Item stok düşümü hangi use'tan?
- Supplier dropdown = Contact Company mi ayrı Supplier entity mi?
- Production Credit iş kuralı
- Bulk Update "Increase Price" yüzde mi sabit mi?
- Service item'da Transactions sekmesi davranışı
- Order template Save As Template kapsamı

---

## Sandbox — Billing / Financial Operations

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. Invoice ≠ Payment ≠ Credit ≠ Return ≠ Refund ≠ Write-off; Return ≠ Refund; returned quantity ≠ restocked quantity. UI/IA birebir kopya önerisi değildir. Client Profile altındaki customer-scoped billing görünümleri → [client-billing](#client-billing); bu bölüm **clinic-wide Billing modülü** odaklıdır.

**Temel domain ayrımları (benchmark + Vetinity çıkarımı):**

| Kavram | DaySmart rolü | Vetinity değerlendirmesi (aday) |
|---|---|---|
| **Invoice** | Finansal aggregate/workspace; kalemler + ilişkili hareketler | Tahsilat merkezi; statik belge değil |
| **Estimate** | Teklif; Convert → Invoice workflow | Tedavi planı/teklif lifecycle |
| **Payment** | Tahsilat; birden fazla invoice'a allocation | Payment application ilişkisi |
| **Return** | Operasyonel iade; returned vs restocked qty ayrı | Stok hareketi ile ilişkili olabilir |
| **Refund** | Para iadesi finansal hareketi | Return'tan ayrı entity |
| **Credit** | Müşteri kredisi/deposit; Amount + Balance | Cari alacak/avans — TR mapping TBD |
| **Write-off** | Invoice bakiyesinin tahsil edilemez kısmını kapatma | Refund/discount değil |
| **Cash Reconciliation** | Fiziksel kasa açılış/kapanış mutabakatı | Payment method ≠ reconciliation workflow |

→ [Clients Module](#client-billing) (customer-scoped read-models), [Inventory Module](#inventory-returns) (return/restock), [CHECKOUT-001](../backlog/feature-backlog.md) (visit checkout)

### Billing Dashboard {#billing-dashboard}

**Ekran:** Billing ana modülü

**Sol navigasyon (sandbox gözlemi):** Invoices, Estimates, Payments, Returns, Credits, Refunds, Write-offs, Cash

**Dashboard analytics (son 30 gün — sandbox gözlemi):**
- Sales by Category
- Sales by Species
- Payment by Type

**Gözlem:** Finansal operasyonlar tek Billing çalışma alanında toplanmış.

**Vetinity değerlendirmesi (aday):** Unified financial workspace prensibi; pie chart analytics P2/P3 — operasyonel doğruluk öncelikli.

### Invoices {#billing-invoices}

**Liste kolonları:** Invoice number, Client, Item count, Total, Balance, Outstanding, Created, Updated

**New Invoice:** Client (required), Patient (optional), Location, Medical Note, Bundle (optional), Created date, Notes (optional)

**Invoice detail — client/account:**
- Client, Account Balance, Status, Payment Terms, Created, Location, Notes

**Finansal özet:**
- Subtotal, Discount, Tax, Late Fee, Total, Payment, Return, Credit, Balance

**Invoice satırları:** Item, Patient, Provider, Quantity, Price, Discount, Tax, Line Total, Print

**Aksiyonlar:** Edit Invoice, Export, Apply Discount, Write Off, Delete Invoice, Share to PetCare

**Alt sekmeler (ilişkili kayıtlar):** Items, Payments, Credits, Returns, Declined, Late Fees

**Benchmark noktası:** Invoice yalnızca statik belge değil; ödeme, kredi, iade, late fee vb. hareketlerin **merkezindeki finansal workspace**.

**Edit Invoice alanları:** Client, Status, Payment Terms, Created, Location, Notes

→ [RECORD-001](../backlog/feature-backlog.md), [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability)

### Estimates {#billing-estimates}

**Liste kolonları:** Estimate number, Title, Client, Items, Total, Created, Valid Until, Status

**Estimate detail:** Title, Client, Created, Valid Until, Status, Location, Notes, Medical Note, Signature

**Finansal özet:** Subtotal, Discount, Tax, Total

**Estimate satırları:** Item, Patient, Provider, Quantity, Price, Discount, Tax, Line Total, Print

**Aksiyonlar:** Edit Estimate, Export, Approve Estimate, Duplicate, Delete Estimate, Apply Discount, Convert Estimate, Email Estimate, Print Estimate

**Convert to Invoice (sandbox gözlemi):**
- Seçenekler: Medical Note, Medical Records, target Invoice
- Açıklama metninden gözlemlenen davranışlar (iş kuralı **tam doğrulanmadı**):
  - Patient'a atanmamış item'lar için medical record oluşturulmuyor
  - Zero quantity item discount'larının yeniden dağıtılması söz konusu
  - Patient wellness plan içindeyse plan terms estimate item'larına uygulanabiliyor
  - Actions invoice'a uygulanıyor
  - Tax hesaplamasında seçilen invoice'ın service location bilgisi kullanılabiliyor

**Çıkarım:** Estimate → Invoice basit belge kopyası değil; klinik kayıt, hasta, wellness plan ve vergi davranışıyla ilişkili **business workflow**.

→ [CHECKIN-004](../backlog/feature-backlog.md), [EXAM-007](../backlog/feature-backlog.md)

### Payments {#billing-payments}

**Liste kolonları:** Payment number, Client, Amount, Type, Date, Applied to, Notes

**Payment type örnekleri:** Cash, Check, Credit Card

**Kritik gözlem:** Tek payment **birden fazla invoice'a dağıtılabiliyor** — Applied To alanında her invoice ve uygulanan tutar ayrı gösterilebiliyor.

**Aksiyonlar:** Email Receipt, Print Receipt, Delete Payment

→ [CHECKOUT-001](../backlog/feature-backlog.md), [IDEA-027](../research/ideas.md#idea-027--checkout-as-visit-completion-orchestrator)

### Returns {#billing-returns}

**Return ayrı finansal/operasyonel entity.**

**Return detail:** Date, Client, Amount, Notes, Credit Issued, Refund Issued, Post Date

**Return item satırları:** Item, Patient, Returned quantity, Restocked quantity, Amount, Invoice, Reason, Notes

**Reason örneği:** Change Mind

**Kritik gözlem:** **Returned quantity ≠ Restocked quantity** — müşteriden geri alma ile stoğa dönüş aynı kabul edilmiyor.

**Return → Refund bağlantısı örneği:** Return amount $114.88 → Refund Issued $114.88 (Refund #5)

**Ayrım:** Return = operasyonel iade; Refund = para iadesi finansal hareketi → [Inventory Module](#inventory-returns)

### Credits {#billing-credits}

**Credit ayrı kayıt tipi.**

**Liste:** Credit, Client, Reason, Amount, Balance, Notes, Date

**Reason örnekleri:** Deposit, Client Relations

**New Credit:** Date, Client, Reason, Amount, Notes

**Edit uyarısı (sandbox gözlemi):** *"Editing this record will affect the related payment record"*

**Domain inference (kesin implementasyon değil):** Credit ile payment arasında finansal bağlantı var; Amount + Balance alanları kredinin kısmen kullanılabilen müşteri bakiyesi gibi davranabildiğine işaret ediyor.

### Refunds {#billing-refunds}

**Refund ayrı finansal kayıt tipi.**

**Liste:** Refund, Client, Return, Amount, Type, Notes, Date

**Type örnekleri:** Cash, Credit Card

**Return ile ilişkilendirilebilir** (liste Return kolonu).

**Edit Refund:** Date, Client, Amount, Type, Notes — bazı alanlar read-only, Type ve Notes düzenlenebilir (sandbox gözlemi).

### Write-offs {#billing-write-offs}

**Write-off ayrı finansal kayıt tipi.**

**Liste:** Client, Invoice, Amount, Note, Write Off Date

**New Write Off:** Date, Client, Invoice, Amount, Notes

**Örnek notlar:** "Balance of $171.38 written off...", "wont pay"

**Çıkarım:** Belirli invoice bakiyesinin tahsil edilemeyen kısmını kapatma — refund veya discount ile **aynı kavram değil**.

### Cash / Reconciliation {#billing-cash-reconciliation}

**Menü:** Billing > Cash

**Liste:** Date, Starting Balance, Ending Balance, Note

**New Reconciliation:** Date, Starting Balance, Ending Balance, Note

**Gözlem:** Cash yalnızca payment method değil; **reconciliation workflow** olarak da ele alınmış — fiziksel kasa mutabakatı.

### Domain İlişkileri {#billing-domain-relationships}

Ekranlardan doğrulanabilen kavramsal ilişkiler (DB/schema uydurması yok):

```
Estimate ──Convert──► Invoice
                         ├── Payment allocation(s)
                         ├── Credit(s)
                         ├── Return(s)
                         ├── Late Fee(s)
                         ├── Write-off
                         └── Discount

Return ──► Credit issued  veya  Refund issued

Payment ──► bir veya birden fazla Invoice (allocation)

Invoice item / Estimate item ──► Patient, Provider, service/product/item
```

### Vetinity Implications / Opportunities {#billing-vetinity-implications}

> Aşağıdaki maddeler **Vetinity ürün çıkarımı/adayı**dır; DaySmart sandbox gözlemi değildir.

**A) Unified Financial Workspace** — Finansal operasyonlar kopuk CRUD ekranları olmamalı. Önerilen akış: Estimate/Treatment Plan → Invoice → Payment/Allocation → Financial Ledger. Invoice çevresinde payments, credits, returns, refunds, discounts, write-offs, taxes, outstanding balance izlenebilir olmalı.

**B) Estimate → Invoice** — Conversion sırasında hasta, hizmet/ürün, provider, quantities, discounts, taxes, clinical records ilişkileri korunmalı.

**C) Payment Allocation** — Tek tahsilatın çoklu açık faturaya dağıtımı değerlendirilmeli.

**D) Return / Refund ayrımı** — Aynı entity olmamalı; returned qty ≠ restocked qty senaryosu desteklenebilir.

**E) Client Credit** — Avans/cari alacak/müşteri bakiyesi; Türkiye kavram eşlemesi ayrı tasarlanmalı (**requires Turkey-specific regulatory/accounting analysis**).

**F) Write-off** — Kontrollü alacak kapatma; audit trail, permission, reason zorunluluğu DaySmart'tan daha güçlü tasarlanabilir.

**G) Cash Reconciliation** — opening/expected/counted/difference/closing balance, user, timestamp, note — DaySmart'tan daha gelişmiş model değerlendirilebilir.

**H) Türkiye üstünlük fırsatı** — KDV, e-Fatura, e-Arşiv, e-SMM, POS, cari hesap, stok hareketi uyumu; mevzuat doğrulanmamış detaylar kesin gereksinim yazılmamalı → [INT-005](../backlog/feature-backlog.md), [INT-006](../backlog/feature-backlog.md)

### UX / Product Benchmark {#billing-ux-benchmark}

**DaySmart güçlü yönler (sandbox gözlemi):**
- Finansal kayıtların birbirleriyle ilişkili olması
- Invoice merkezli hareket geçmişi (Payments, Credits, Returns, Late Fees sekmeleri)
- Estimate → Invoice conversion
- Multi-invoice payment allocation
- Return / Refund ayrımı; returned / restocked quantity ayrımı
- Client credits; write-offs; cash reconciliation
- Receipt email/print; estimate email/print/duplicate
- Clinical context (Medical Note, Patient, Provider on lines)

**Zayıf / geliştirilebilir (değerlendirme — rakip gözlemi + UX çıkarımı):**
- UI eski ve yoğun
- Çok sayıda finansal kavram yatay tab yapısına sıkışmış
- Pie chart dashboard modern analytics için sınırlı
- Bazı aksiyonlar küçük dropdown/gear menülerinde
- Finansal workflow süreç olarak yeterince görselleştirilmiyor
- Contextual actions, drill-down analytics, güçlü search/filter fırsatı

**Vetinity hedefi (çıkarım):** Domain derinliğini koruyup daha modern, anlaşılır ve hızlı UX.

### Priority Recommendations {#billing-priority-recommendations}

> Benchmark önerisi; mevcut roadmap ile otomatik merge edilmez. v1 [Payments](../roadmap/v1-release-scope.md) release blocker ile uyumlu alanlar işaretlenmiştir.

| Öncelik | Yetenekler |
|---|---|
| **P1 / Core** | Invoice + items; Payments; payment allocation; client outstanding balance; discounts; taxes; Estimate → Invoice temel akış; basic returns/refunds; auditability |
| **P1/P2** | Client credits/deposits; partial payments; multi-invoice allocation; return + restock separation; invoice write-off; receipt generation |
| **P2** | Cash reconciliation; advanced estimate workflows; email estimate/receipt; late fees; advanced financial analytics |
| **Turkey workstream** | e-Fatura/e-Arşiv/e-SMM; POS/payment provider; accounting/export — [INT-005](../backlog/feature-backlog.md), [INT-006](../backlog/feature-backlog.md) |

### Billing Gap Analysis {#billing-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Priority |
|---|---|---|---|---|---|
| Billing module workspace | Invoices…Cash nav + dashboard | Kısmi (nav planı yok) | CHECKOUT-001, v1 Payments | Clinic-wide financial hub | P1 |
| Invoice as workspace | Items + Payments/Credits/Returns/Late Fees tabs | Kısmi | RECORD-001, IDEA-007 | Invoice aggregate model | P1 |
| Invoice lines (patient/provider) | Line-level clinical context | Kısmi | RECORD-001, PATTERN-005 | Line traceability | P1 |
| Estimate lifecycle | Approve, Duplicate, Convert | Kısmi | CHECKIN-004 | Conversion workflow | P1/P2 |
| Estimate → Invoice rules | Medical records, wellness, tax location | Yok | CHECKIN-004, EXAM-007 | Business workflow depth | P1/P2 |
| Payment allocation | Multi-invoice Applied To | Belirsiz | CHECKOUT-001 | Allocation entity | P1/P2 |
| Returns | Separate entity; returned≠restocked | Yok | CHECKOUT-001, Inventory | Return/restock split | P1/P2 |
| Refunds | Linked to Return | Yok | CHECKOUT-001 | Refund ≠ Return | P1/P2 |
| Credits | Amount + Balance; payment link | Yok/kısmi | CHECKOUT-001 | Customer credit balance | P1/P2 |
| Write-offs | Per-invoice balance close | Yok | CHECKOUT-001 | Controlled write-off | P1/P2 |
| Cash reconciliation | Starting/Ending balance | Yok | — | Kasa mutabakatı | P2 |
| Late fees | Invoice sub-tab | Yok | CHECKOUT-001 | Advanced billing | P2/P3 |
| Billing analytics | Category/Species/Type charts | Yok | REPORT-001 | Dashboard metrics | P3 |
| Share to PetCare | Invoice action | Portal adayı | PORTAL-004 | Owner portal billing | P2 |

### Açık doğrulama soruları (Billing Module)

- Invoice Status geçiş kuralları (Open/Paid/Locked/Reopen)
- Convert Estimate: wellness plan terms tam kapsamı
- Credit Balance vs Amount kullanım/kapanış kuralları
- Credit edit → payment etkisi cascade detayı
- Partial payment + multi-invoice allocation sırası
- Return Credit Issued vs Refund Issued seçim kuralı
- Restocked quantity stok hareketi tetikleme anı
- Write-off sonrası invoice status
- Cash reconciliation vs payment ledger ilişkisi
- Late fee otomatik mi manuel mi uygulanıyor
- Declined Items → invoice line ilişkisi

---

## Sandbox — Reports / Reporting Module

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. Generic report builder olduğu **doğrulanmadı** — gözlem, domain bazlı **predefined report kataloğu**. Inventory/Billing/Patient/Client/Contact/Reminder domain tanımları tekrar edilmez; cross-ref kullanılır. US tax/controlled-substance varsayımları kopyalanmaz.

**Temel pattern (benchmark):**

```
report category → select predefined report → report-specific filters → Generate/Refresh
→ table and/or chart → Export → (some) entity drill-down
```

**Prensip:** same transactional/domain source → operational screen → entity-scoped read-model → clinic-wide report → dashboard/KPI — **report-only duplicate entity yok** → [TIMELINE-002](../backlog/feature-backlog.md), [ADR-006](../decisions/ADR-006-patient-timeline.md)

→ [Inventory Module](#sandbox--inventory--inventory-module), [Billing Module](#sandbox--billing--financial-operations), [Patients Module](#sandbox--patients-module), [Clients Module](#sandbox--clients--client-module), [Contacts Module](#sandbox--contacts--contact-module), [Reminders](#sandbox--reminders-reminders-detail)

### Reports Dashboard {#reports-dashboard}

**Ekran:** Reports ana modülü

**Dashboard KPI'lar (sandbox gözlemi):** Total Active Patients, Total Active Clients, Total Appointments

**Report kategorileri (sandbox gözlemi):** Schedule, Patients, Clients, Communications, Contacts, Inventory, Billing, Staff, Wellness Plan

**Gözlem:** Tek generic builder değil; geniş **predefined operational/clinical/financial/management** report kataloğu.

### Shared Report Behavior {#reports-shared-behavior}

**Ortak davranışlar (sandbox gözlemi — tüm raporlarda garanti değil):**
- Report-specific filters
- Date range / **As Of** / range period
- Clinic/home location (where relevant)
- Provider/staff dimensions (where relevant)
- **Generate / Refresh**
- Tabular results; selected reports → charts
- Summary KPI values
- **Export** (exact format **doğrulanmadı**)
- Entity drill-down (ör. Deceased Patient List → Patient Profile)

**Vetinity aday shell (çıkarım — rakip gözlemi değil):** title, description, filters, KPIs, visualization, table, drill-down, export — DaySmart desktop catalog UI kopyalanmamalı → [REPORT-001](../backlog/feature-backlog.md), [REPORT-005](../backlog/feature-backlog.md)

### Schedule Reports {#reports-schedule}

**Gözlemlenen rapor adları:**
- Appointment Duration
- Appointment Log
- Appointments By Status
- Pending Appointments
- Referral Source Summary
- Sales By Appointment Type

**Pending Appointments:** Operasyonel tablo; export destekli — pending appointment listesi.

**Appointment Duration / Log / By Status:** Süre, geçmiş ve lifecycle/status raporlaması.

**Referral Source Summary:** Randevu/müşteri edinim kaynağı.

**Sales By Appointment Type:** Schedule/appointment type → finansal çıktı bağlantısı.

**Vetinity aday boyutlar (çıkarım):** appointment type, provider, status, duration, referral source, revenue — her biri ayrı mimari sistem değil.

### Patient Reports {#reports-patients}

**Gözlemlenen rapor adları:**
- Active Engaged Patients
- Active Patient List
- Deceased Patient List
- Diagnosis Summary
- In Process Medical Notes
- Inactive Patient List
- New Patients

**Active Engaged Patients — filtreler:** As Of, Range Period (ör. 18 months), Home Location. "Active" vs "engaged/recently active" ayrımı; engagement kuralı **tam doğrulanmadı**.

**Deceased Patient List:** Date range; kolonlar — patient, breed/species-type, chip, owner/client, deceased date, home location; **patient name drill-down** → Patient Profile.

**Diagnosis Summary:** Diagnosis dağılım/özet → [Patients Module Diagnoses](#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics).

**In Process Medical Notes:** Tamamlanmamış klinik dokümantasyon — reporting **operasyonel eksik iş** yüzeyi olabilir; ayrı worklist ile overlap değerlendirilmeli.

### Client Reports {#reports-clients}

**Gözlemlenen rapor adları:**
- Active Client List
- Active Clients Summary
- Active Engaged Clients
- Cards Stored On File
- Inactive Client List
- Lapsed Clients
- New Clients

**Active Client List:** Operasyonel/export raporu; client master + communication preferences — Primary Reminder Preference, Referred By, Transactional Email, Transactional SMS. **Duplicate Client entity yok** → [Clients Module](#client-communications).

**Active Engaged Clients:** Engaged patient raporuna paralel; hesaplama kuralı **doğrulanmadı**.

**Lapsed Clients:** Retention/churn odaklı — P2/P3 aday.

### Communication Reports {#reports-communications}

**Gözlemlenen rapor adları:**
- Email And SMS Reminders Sent
- Failed Emails
- Reminders Created
- Reminders Detail

**Failed Emails — kolonlar:** recipient, email, status (ör. Bounce), failure type (ör. Transient), subject. Operasyonel **delivery diagnostics** — volume-only değil.

**Reminders Detail:** Clinic-wide reminder operasyon listesi ile **aynı source** → [Reminders Detail](#reminders-detail-ana-tablo), [APPT-014](../backlog/feature-backlog.md). Duplicate reminder tanımı yok.

→ [MSG-001](../backlog/feature-backlog.md), [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline)

### Contact / Referral Reports {#reports-contacts}

**Gözlemlenen rapor adları:**
- Referred Patients by RDVM
- Referring Doctors by Clinic
- Referring Veterinarians List

**Referring Doctors by Clinic:** Clinic gruplu; doctor/contact, phone, email. Contacts referral network → [Contacts Module Relationships](#contact-relationships). **Ayrı referral entity yok.**

**Vetinity relevance:** Referral hospital/specialty — universal MVP **değil**; P2/P3 benchmark.

### Inventory Reports {#reports-inventory}

**Gözlemlenen rapor adları (tam liste):**
- Best Selling Inventory Items
- Controlled Substances Log
- Inventory Adjustments
- Inventory Alerts
- Inventory Log
- Inventory Summary
- Inventory Value / Cost Of Goods Sold
- Items By Price Type
- Profit Margins
- Purchases From Supplier
- Sales By Category
- Sales By Item
- Unique Dispensing Log

Domain detay → [Inventory Module](#sandbox--inventory--inventory-module). Stok kaynağı **auditable ledger** read-model olmalı; sessiz quantity overwrite **değil**.

**Best Selling Inventory Items:** Product mix / commercial analysis — date range, qty, amount, category, item (alanlar **kısmen gözlemlendi**).

**Controlled Substances Log {#reports-controlled-substances-log}:** En kritik inventory raporlarından biri. Controlled-drug **audit trail** — starting balance, patient, owner/client, prescription, invoice, ordered by, administered by, quantity used, remaining balance, purchases, ending balance. Stock ↔ purchase ↔ prescription ↔ patient ↔ provider ↔ usage ↔ invoice ↔ running balance. **US-oriented** — Türkiye controlled medicine → **requires Turkey-specific regulatory research**. NDC/US semantics kopyalanmaz → [RECORD-005](../backlog/feature-backlog.md).

**Inventory Adjustments / Log / Summary:** Adjustment reason/audit cross-ref → [inventory-adjustments](#inventory-adjustments). Log = movement activity. Summary = current stock state.

**Inventory Alerts:** Low stock, expiring — **aynı source** as operational alerts → [inventory-alerts](#inventory-alerts).

**Inventory Value / COGS:** Finansal envanter değerleme/cost analysis. Costing method (FIFO/highest/avg) **doğrulanmadı** — item pricing'te "highest cost" gözlemi COGS formülünü kanıtlamaz.

**Profit Margins:** Selling price vs cost; low-margin item identification — margin formülü **doğrulanmadı**. Procurement/cost data dependency.

**Purchases From Supplier:** Supplier spend/procurement analysis → [inventory-purchases](#inventory-purchases), [inventory-purchase-orders](#inventory-purchase-orders).

**Sales By Category / Item:** Invoice/sales source → [Billing Module](#billing-invoices), [Inventory Transactions](#inventory-transactions).

**Unique Dispensing Log:** Dispensing-focused report; semantics **doğrulanmadı** — pharmacy/medication traceability adayı.

### Billing Reports {#reports-billing}

**Gözlemlenen rapor adları (tam liste):**
- Account Receivable Reconciliation
- Accounts Receivable
- Accounts Receivable Out Of Period Sales
- Annual Billing Comparison
- Average Client Transaction
- Billing Detail By Invoice
- Cash Reconciliation
- Collections Detail By Type
- Declined Items
- Discount Details
- Discount Summary
- Donations
- End Of Day Detail
- End Of Day Reconciliation
- Monthly Billing Summary
- Monthly Payments Summary
- Payment By Provider
- Production Credit based on Payments
- Production Credit based on Sales
- Returns
- Sales By Provider Detail
- Sales By Provider Summary
- Sales Tax Summary
- Transactions By Provider
- Write Off

Domain detay → [Billing Module](#sandbox--billing--financial-operations). **Return ≠ Refund; Write-off ≠ Discount** — tekrar tanımlanmaz.

**Account Receivable Reconciliation {#reports-ar-reconciliation}:** Starting/ending receivable balance, change/delta, financial/provider breakdown, list price, discounts, taxes, late fees, total. **Uyarı:** Reopened invoices period tutarlılığını bozabilir — reconciliation güvenilir olmayabilir. Finansal integrity prensibi: reopened/backdated/late adjustment disclosure → [CHECKOUT-001](../backlog/feature-backlog.md).

**Accounts Receivable:** Outstanding customer balances — customer balance, invoice, payment allocation, credits, write-offs **aynı source**.

**Accounts Receivable Out Of Period Sales:** Period dışı etkileyen işlemler — financial control P2/P3.

**Annual / Monthly summaries:** Trend/period comparison — her period chart için ayrı backlog **değil**.

**Average Client Transaction:** Client economics KPI — düşük öncelik vs transactional correctness.

**Billing Detail By Invoice:** Invoice read-model export/audit.

**Cash Reconciliation / End Of Day:** → [billing-cash-reconciliation](#billing-cash-reconciliation). Same ledger/reconciliation source.

**Collections Detail By Type:** Tahsilat by payment/collection type — TR: cash, card, transfer, POS (integration ayrı → [INT-006](../backlog/feature-backlog.md)).

**Declined Items:** → [client-billing](#client-billing) Declined Items + Patient History — **shared source** → [TIMELINE-003](../backlog/feature-backlog.md).

**Discount Details / Summary:** Invoice line + item/client discount policies — single rule engine **varsayılmaz**.

**Returns / Write Off reports:** Billing entity cross-ref only.

**Sales / Payment / Transactions By Provider:** Provider/staff revenue/production dimensions. **Attribution rules doğrulanmadı** — invoice creator ≠ clinical provider ≠ revenue owner olabilir.

**Production Credit (Payments / Sales):** Item-level Production Credit tab ile ilişkili olabilir; semantics **doğrulanmadı** — P3/unresolved.

**Sales Tax Summary:** US tax taxonomy kopyalanmaz; generic tax summary — KDV/e-belge → [INT-005](../backlog/feature-backlog.md), **requires Turkey-specific regulatory/accounting research**.

### Staff Reports {#reports-staff}

**Gözlemlenen rapor adları:**
- Completed Tasks
- Deleted Transactions
- Open Tasks
- Tasks Summary
- Time Sheets

**Completed Tasks:** Chart + staff × period/month matrix — internal task performance → [MSG-004](../backlog/feature-backlog.md), [Client Tasks](#client-tasks), [Contact Tasks](#contact-tasks). **Task source shared.**

**Open Tasks / Tasks Summary:** Workload reporting.

**Deleted Transactions {#reports-deleted-transactions}:** Silinen finansal/transactional activity — audit/security surface. Voided/reversed/deleted financial ops visibility → [RECORD-002](../backlog/feature-backlog.md), [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions).

**Time Sheets:** Staff time report — workflow/source **doğrulanmadı**; attendance/payroll **varsayılmaz**.

### Wellness Plan Reports {#reports-wellness}

**Gözlemlenen rapor adları:**
- Billing Transactions
- Enrollment Detail
- Enrollment Summary
- New Enrollments
- New Enrollments By Staff
- Wellness Plan Production
- Wellness Plan Production Summary

**New Enrollments By Staff:** Chart + staff breakdown table. Enrollment + billing + staff attribution + production.

**Vetinity:** Wellness Plans **P3/future** → [Patients Module Wellness](#documents--notes--relationships--reminders--wellness--tasks). Benchmark evidence only; current backlog requirement **değil**.

### Reporting Architecture {#reports-architecture}

| Domain source | Operational | Entity read-model | Clinic report | Dashboard |
|---|---|---|---|---|
| Appointment | Schedule/Census | Patient/Client Appointments | Schedule reports | Total Appointments KPI |
| Communication | Comm history, Reminders | Client/Patient comm | Failed Email, Reminders | — |
| Inventory movement | Item tabs, Alerts | Item Transactions | Inventory Log, COGS, Controlled Log | Inventory dashboard |
| Invoice/Payment | Billing module, Client Billing | Invoice/payment scoped | AR, EOD, Sales by Provider | Billing dashboard |
| Task | Client/Contact Tasks | Task optional patient ref | Staff Task reports | — |
| Contact referral | Relationships | Contact profile | Referring Doctors by Clinic | — |

**CQRS/read-model:** Report-specific source table **oluşturulmaz** → [ADR-006](../decisions/ADR-006-patient-timeline.md)

### Operational Worklist vs Report {#reports-worklist-vs-report}

| Surface | DaySmart örnek | Vetinity değerlendirmesi |
|---|---|---|
| **Report** | Annual Billing Comparison, Diagnosis Summary | Historical/analytic/export |
| **Worklist/queue** | Pending Appointments, In Process Medical Notes, Inventory Alerts, Open Tasks, Failed Emails | Proactive operational — report **veya** dedicated queue |

Her operasyonel kuyruk ayrı "report" olmak zorunda değil.

### Vetinity Implications {#reports-vetinity-implications}

> **Vetinity ürün çıkarımı** — DaySmart sandbox gözlemi değildir.

**A) Categorized Report Center** — Clinical, Clients, Appointments, Communications, Inventory, Finance, Staff/Operations, Advanced/future → [REPORT-001](../backlog/feature-backlog.md), [REPORT-002](../backlog/feature-backlog.md), [ADR-003](../decisions/ADR-003-report-center.md)

**B) Shared filter framework** — date, location, provider, staff, patient, client, status, category, item, payment method — report-relevant subset only → [REPORT-005](../backlog/feature-backlog.md)

**C) Consistent result structure** — filters → KPI → viz → table → drill-down → export

**D) Export policy** — [REPORT-007](../backlog/feature-backlog.md); format TBD

**E) Financial integrity** — AR reconciliation warnings; deleted transaction visibility; period consistency

**F) Turkey** — KDV, e-Fatura/e-Arşiv/e-SMM, POS, controlled medicine — **requires Turkey-specific regulatory/accounting research** → [INT-005](../backlog/feature-backlog.md)

### Strengths / Weaknesses {#reports-strengths-weaknesses}

**DaySmart güçlü yönler (sandbox gözlemi):**
- Broad domain coverage; predefined clinic-relevant reports
- Cross-domain reporting; financial reconciliation depth
- Stock/controlled substance auditability; staff/task reporting; referral reporting
- Export; entity drill-down; operational + management in one module

**Zayıf / fırsat (değerlendirme):**
- Very long static catalog; discovery zor
- Many narrowly named reports; legacy desktop IA
- Similar reports → parameterized variants potential
- Charts functional but dated; limited favorites/scheduling **gözlemlenmedi**
- Several operational queues surfaced as "reports" not proactive workflows

**Vetinity hedefi:** Depth koru; modern IA, search/filter, favorites → [REPORT-003](../backlog/feature-backlog.md), [REPORT-004](../backlog/feature-backlog.md)

### Reports Gap Analysis {#reports-gap-analysis}

| Capability | DaySmart Observation | Vetinity State | Backlog/Pattern | Gap | Priority |
|---|---|---|---|---|---|
| Report Center + categories | 9 domain categories | Planlı | REPORT-001/002, ADR-003, v1 Reports Center | Framework | P0/P1 |
| Shared filters + export | Per-report filters, Export | Planlı | REPORT-005/007 | Shell | P0/P1 |
| Report permissions | Not fully observed | Planlı | REPORT-006 | Access control TBD | P1 |
| Dashboard KPIs | Active patients/clients/appts | Kısmi | REPORT-001, AI-101 | Metrics layer | P1/P3 |
| AR / receivables | Accounts Receivable | Kısmi | CHECKOUT-001, Billing | AR read-model | P1 |
| AR reconciliation + warnings | Reopened invoice warning | Yok | CHECKOUT-001 | Period integrity | P1/P2 |
| EOD / cash reconciliation | EOD + Cash reports | Yok | CHECKOUT-001, Billing | Daily close | P1/P2 |
| Invoice/payment summaries | Monthly/annual | Yok | REPORT-001 | Period reports | P1/P2 |
| Inventory summary/movements | Log, Summary, Adjustments | Planlı | v1 Stock Mgmt | Ledger-based reports | P1 |
| Critical stock / alerts report | Inventory Alerts report | Yok | AI-101, Inventory | Shared alert source | P1 |
| Controlled substance log | Full audit trail report | Yok | RECORD-005 | TR regulatory TBD | P1/P2 |
| COGS / inventory value | Financial inventory | Yok | — | Costing TBD | P1/P2 |
| Profit margins | Margin report | Yok | — | Depends on cost data | P2 |
| Failed email diagnostics | Bounce/transient | Yok | MSG-001 | Delivery ops | P1/P2 |
| Deleted transactions report | Staff report | Yok | RECORD-002, PATTERN-019 | Audit | P1 |
| Provider sales/production | By provider reports | Yok | — | Attribution TBD | P2 |
| Referral reports | RDVM/clinic | Yok | Contacts Module | P2/P3 |
| In-process medical notes | Incomplete docs | Yok | EXAM-015 lock? | Worklist vs report | P1/P2 |
| Wellness plan analytics | 7 reports | Yok | P3 wellness | Future | P3 |
| Production credit reports | Payments/Sales based | Yok | Inventory P3 | Unresolved | P3 |
| Favorites / saved filters | Not observed | Planlı | REPORT-003/004 | UX | P1/P2 |

### Açık doğrulama soruları (Reports Module)

- Active Engaged Patient/Client exact calculation rules
- Inventory Value/COGS costing methodology
- Unique Dispensing Log vs Inventory Log distinction
- Production Credit report vs item-level tab semantics
- Provider attribution rules (sales/payment/transactions by provider)
- Time Sheets data source and workflow
- Export formats (Excel/CSV/PDF) per report
- Saved filters / favorites / scheduled reports — **gözlemlenmedi**
- Report-level permission/access controls — **kısmen doğrulanmadı**
- Donations report business semantics

---

## Sandbox — Settings / Configuration

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Tüm maddeler **sandbox gözlemi**dir. Settings = clinic-wide operational configuration merkezi; **tek dev ayarlar tablosu değil**. Domain ownership korunur. US tax/jurisdiction/terminology kopyalanmaz.

**Domain ownership (Vetinity çıkarımı — rakip gözlemi değil):**

| DaySmart Settings alanı | Önerilen bounded context |
|---|---|
| Appointment Types, Clinic Hours, Blocked Time, Schedule Columns | Scheduling |
| Rooms | Resource / Boarding / Census operations |
| Discounts, Taxes, Payment Types | Billing / Catalog |
| Production Credits | Staff performance — P3 |
| Email/SMS Defaults, Marketing | Messaging |
| Printers | Clinic ops / printing — P2/P3 |
| Permissions | Authorization |
| PetCare, Payments, Subscriptions, Add-ons | Platform/account/SaaS — benchmark only |

→ [Schedule sandbox](#sandbox--i̇lk-giriş-takvim-ve-randevu-oluşturma), [Boarding](#sandbox--boarding), [Billing](#sandbox--billing--financial-operations), [Inventory](#sandbox--inventory--inventory-module)

### Configurations catalog {#settings-configurations}

**Settings > Configurations** altında gözlemlenen başlıklar:

- Appointment Types
- Configurations (general)
- Clinic Hours
- Discounts
- Email Defaults
- SMS Defaults
- Marketing Campaigns
- Payment Types
- Printers
- Production Credits
- Rooms
- Schedule Columns
- Taxes

**Vetinity:** Birebir Settings IA zorunlu değil → [UX-002](../backlog/feature-backlog.md) Ayarlar > Tanımlar merkezi.

### Other Settings top-level areas {#settings-top-level}

Sandbox'ta Configuration dışında gözlemlenen üst seviye alanlar:

- Add-ons
- PetCare
- Payments
- Permissions
- Subscriptions
- **Templates** (ayrı modül — aşağıda)

**Ayrım (çıkarım):** A) clinic product config · B) platform admin · C) commercial subscription · D) integrations/add-ons · E) portal · F) authorization — hepsi Vetinity feature sayılmaz.

### Appointment Types {#settings-appointment-types}

**Liste kolonları (sandbox gözlemi):** Name, Duration, Color, Book Online, Pre-visit Confirmation, Default, Rules

**Workflow/template bağlantıları (type başına yapılandırılabilir):**
- Medical Note template
- Bundle
- Checkout Documents
- Confirmation / Reminder
- Check-In Letters / Forms
- Pre-visit communication / Letters / Forms

**Eligibility rules (sandbox gözlemi):** Species, Weight, Age

**Örnek type adları:** Annual Wellness Exam & Vaccination, Equine Wellness Exam, Spay/Neuter, Block, Euthanasia, Behaviour, Dental Exam, Urgent Care, Feline Wellness Exam, Sick Patient, Emergency Exam, Anesthesia/Procedure Drop-Off, Feline Spay Drop-Off, Mass Removal, Recheck, Vaccine Clinic

**Benchmark noktası:** Appointment Type yalnızca scheduling metadata değil — **appointment workflow preset** adayı.

**Vetinity:** Tam preset MVP değil → [APPT-005](../backlog/feature-backlog.md), [APPT-006](../backlog/feature-backlog.md), [CHECKIN-001](../backlog/feature-backlog.md), [EXAM-006](../backlog/feature-backlog.md), [EXAM-014](../backlog/feature-backlog.md)

### Clinic Hours / Blocked Time {#settings-clinic-hours-blocked}

**Clinic Hours:** Çalışma saatleri configuration.

**Blocked Time:** Schedule availability/capacity kısıtı — **Appointment ≠ Blocked Time**. Recurring block desteği gözlemlendi.

→ [APPT-008](../backlog/feature-backlog.md), [Schedule sandbox](#takvim-ana-görünümü)

### Schedule Columns {#settings-schedule-columns}

**Kavramlar:** Staff, Non-Staff, schedule'da gösterilen resource/column, online appointment type ilişkileri.

**Kritik ayrım:** **Schedule Column ≠ Room** — column = takvimde görünen mantıksal/personel/resource kolonu.

→ [Schedule sandbox](#takvim-ana-görünümü), [Census](#census-operasyon-kuyruğu)

### Rooms {#settings-rooms}

**Alanlar:** Name, Type, Description

**Room type örnekleri:**
- **BOARDING:** Boarding, Cat condo, Dog run, Grooming, Kennel — Max Guests, Daily Rate, **Divisible**
- **CENSUS / IN ROOM:** Reception, Treatment

**Ayrımlar:** Room ≠ Schedule Column; **Boarding ≠ Hospitalization** → [Boarding Module](#sandbox--boarding), [Treatment Board](#sandbox--treatment-board)

**Divisible:** P3 benchmark — MVP zorunlu değil.

### Discounts {#settings-discounts}

**Form:** Name, Applies To, Amount, Notes

**Amount types:** Percentage (%) · Fixed monetary amount (US $ benchmark — currency hard-code etme)

**Applies To:** Inventory/catalog kategorileri

**Lifecycle:** Kullanılmış discount'ta delete yerine **Disable** — finansal geçmiş bütünlüğü

→ [Billing discounts](#billing-discounts), [Inventory discounts](#inventory-discounts)

### Taxes {#settings-taxes}

**Form:** Tax, Rate (%), Type, Jurisdiction, Applies To

**US-specific:** country/state/county/city jurisdiction — **Türkiye'ye taşınmaz**

**Reusable concept:** tax definition → rate → category applicability → [INT-005](../backlog/feature-backlog.md), **requires Turkey-specific regulatory/accounting research**

### Payment Types {#settings-payment-types}

**Gözlem:** Liste mevcut; sandbox'ta yeni payment type oluşturma **erişilemedi/gözlemlenmedi**.

**Problem (çıkarım):** Ödeme yöntemlerinin checkout/payment'ta kontrollü sınıflandırılması → [CHECKOUT-001](../backlog/feature-backlog.md), [INT-006](../backlog/feature-backlog.md)

### Production Credits {#settings-production-credits}

**Form:** Name, Applies To (all/specific inventory categories), Amount (%), Notes

**Vetinity:** Staff production/commission benzeri — **P3 benchmark**; DaySmart terminolojisi kopyalanmaz → [Inventory Production Credit](#inventory-production-credit), [Reports production credit](#reports-billing)

### Email Defaults {#settings-email-defaults}

**Event/workflow bazlı default communication templates.**

**Örnek use-case alanları:** Appointment Accept/Confirmation/Decline/Reminder/Reschedule, Boarding, Certificate, Checkout Documents, Deposit, Estimate, Invoice, Labs, Medical Note

**Pattern:** communication template → event binding → [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications), [APPT-012](../backlog/feature-backlog.md), [PATTERN-011](../research/patterns.md#pattern-011--template-first-communication)

Template domain ≠ delivery domain.

### SMS Defaults {#settings-sms-defaults}

**Merge tokens (sandbox gözlemi):** Clinic Name, Clinic Phone, Client First Name, Patient Name, Appointment Date, Appointment Time, Appointment Type

**Capability:** reusable template + controlled merge fields + event binding

**Vetinity:** Typed token catalog vs serbest string — KVKK transactional vs marketing → [MSG-001](../backlog/feature-backlog.md), [Clients communication preferences](#client-communications)

### Marketing Campaigns {#settings-marketing}

**Settings > Marketing Campaigns** gözlemlendi.

**Ayrım:** Marketing ≠ transactional clinical communication → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline). Türkiye ticari elektronik ileti/onay — **requires regulatory research**. MVP değil.

### Printers {#settings-printers}

Fiziksel clinic printing configuration — certificate, invoice, label cross-ref.

**Vetinity cloud-first:** Dedicated printer management erken roadmap değil; ihtiyaç doğrulanınca değerlendirilir.

### Settings Gap Analysis {#settings-gap-analysis}

| Capability | DaySmart | Vetinity | Backlog | Priority |
|---|---|---|---|---|
| Configurations hub | Settings > Configurations | Kısmi | UX-002 | P0/P1 |
| Appointment types + duration/color | List + rules | Kısmi | APPT-005/006 | P1 |
| Appointment workflow preset | Templates/bundle/forms on type | Yok | CHECKIN, EXAM-006, EXAM-014 | P1/P2 |
| Clinic hours / blocked time | Yes | Belirsiz | APPT-008 | P1 |
| Schedule columns | Staff/non-staff | Kısmi | Schedule sandbox | P1 |
| Rooms (boarding + census) | Types + rates | Kısmi | Boarding, CHECKIN-005 | P1/P2 |
| Discounts config | %/fixed + category | Yok | Billing | P1/P2 |
| Tax config | US jurisdiction | Planlı TR | INT-005 | P1/P2 |
| Payment types | List only observed | Belirsiz | CHECKOUT, INT-006 | P1 |
| Email/SMS defaults + tokens | Event templates | Kısmi | APPT-012, MSG-001, IDEA-013 | P1/P2 |
| Production credits | % on categories | Yok | P3 | P3 |
| Marketing campaigns | Settings | Yok | MSG, KVKK TBD | P3 |
| Printers | Settings | Yok | P2/P3 | P2/P3 |

### Açık doğrulama soruları (Settings)

- Appointment type Rules tam kapsamı ve tetiklenme anı
- Blocked Time vs Appointment conflict kuralları
- Schedule Column ↔ online booking resource mapping
- Room Divisible semantics
- Payment type create/edit yetkisi sandbox'ta neden yok
- Email/SMS default template versioning
- Permissions granularity per Settings area

---

## Sandbox — Templates / Template System

**Kaynak türü:** DaySmart Vet **canlı sandbox** (gerçek ürün ekranları)

> Templates Configuration içindeki sıradan key/value **değil** — ayrı **reusable content/workflow capability family**. Template definition ≠ runtime record. Yüzlerce Objective field DB kolonu olarak kopyalanmaz.

**Gözlemlenen template kategorileri:**
- Attachments
- Bundles (Invoice)
- Bundles (Estimates)
- Custom Fields
- Letters
- Snippets
- Purchase Orders
- Medical Notes
- Forms
- Wellness Plans
- **All Templates** (unified catalog navigation/read-model)

→ [Settings](#sandbox--settings--configuration), [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [EXAM-006](../backlog/feature-backlog.md), [EXAM-007](../backlog/feature-backlog.md)

### Template common metadata / lifecycle {#templates-lifecycle}

**Ortak metadata (sandbox gözlemi):** Name, Type, Description, Created, Updated, Last Used, Total Use

**Aksiyonlar:** Edit Template, Duplicate, Delete

**Risk (çıkarım):** Template değişikliği geçmiş medical record'u sessizce değiştirmemeli — version/snapshot ihtiyacı → [IDEA-025](../research/ideas.md#idea-025--auditable-clinical-record-lifecycle), [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions), [PATTERN-023](../research/patterns.md#pattern-023--post-signature-document-immutability)

**Açık sorular:** clinic vs multi-clinic scope; disable vs hard delete; used template delete; permissions by template type — **doğrulanmadı**

### Medical Note Templates {#templates-medical-notes}

**Structured clinical note template/builder** — basit hazır metin değil.

**Sections (enable/disable):** Subjective, Objective, Assessment, Plan, Holistic, Client Communication — SOAP hard-coded tek yapı değil; additional/custom sections.

**Nested structure:** Template → Section → Group/Subsection → Field (reorder edilebilir)

**Objective field behaviors (representative — full field catalog kopyalanmaz):**

| Behavior | Örnek |
|---|---|
| Single-line / long text | Free clinical notes |
| Dropdown / multi-select / chips | Clinical/behavioral observations |
| Numeric + unit | Temperature (C), Weight (Kg), Respiration (rpm) |
| Controlled score | BCS (3/9) |
| Controlled value | MM Color (Pink), Reflex (absent) |
| Dental indices | Tooth Condition, Calculus Index |
| Species-specific | Equine Hoof Tester |
| Structured value + optional note | Many clinical fields |

**System-bound components ≠ generic custom field:** Assessment → Diagnoses picker; medication selector; patient status vb.

→ [EXAM-006](../backlog/feature-backlog.md), [ADR-005](../decisions/ADR-005-modern-examination-experience.md), [RECORD-006](../backlog/feature-backlog.md)

### Custom Fields {#templates-custom-fields}

Templates altında **ayrı capability** — Medical Note structured fields ile **karıştırılmaz**.

Generic custom fields vs domain-bound components ayrımı korunur.

### Forms — Designer / Preview / Logic {#templates-forms}

**Örnek:** Emergency Intake Form

**Sekmeler:** Designer · Preview · Logic

**Designer:** drag/drop; multi-page; Page structure; title; description; rich text; variable insertion (@); properties panel

**Field/component örnekleri (MVP requirement değil):** Formatted Text, Single-Line Input, Long Text, Multiple Textboxes, Radio, Yes/No, Checkboxes, Dropdown, Multi-Select, File Upload, Image Picker, Rating Scale

**Preview:** multi-page; progress; Next; required (*); Yes/No + conditional detail (ör. trauma/allergy açıklama)

**Logic tab:** IF question/condition/value → THEN field behavior/action — örnek: Yes → başka soruyu required yap. **Form Logic ≠ Bundle Action.**

→ [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PORTAL-005](../backlog/feature-backlog.md), [Clients Documents Forms](#documents)

### Letters / Snippets / Attachments {#templates-letters-snippets-attachments}

**Letters:** Reusable document/communication templates — Medical Note/Form değil → checkout/consent cross-ref

**Snippets:** Reusable kısa içerik; hashtag/shortcut hızlı kullanım → [EXAM-011](../backlog/feature-backlog.md), [PATTERN-017](../research/patterns.md#pattern-017--structured-clinical-snippets)

**Attachments:** Template catalog type; bundle/appointment/workflow ile hazır attachment ilişkilendirme — attachment template ≠ uploaded patient document → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow)

### Bundles — Items / Activities / Actions {#templates-bundles}

**İki katalog:** Bundles (Invoice) · Bundles (Estimates) — ayrı entity mi shared template farklı context mi **kesin doğrulanmadı**

**Üç katman (benchmark):**

| Katman | Rol |
|---|---|
| **A) Items** | Ticari/faturalandırılabilir içerik |
| **B) Activities** | Klinik uygulama/protokol |
| **C) Actions** | Workflow automation side effects |

**Items (ör. Canine Neuter):** Name, Type, Quantity, Total, Print On Estimate, Added — quantity/price **range** (ör. Rimadyl 1–2 Tablets $10; Anesthesia 5–10 min $50–100; total $210–$260)

**Activities types:** Medical · Vitals · Other

**Medical activity form:** Medication, Quantity, Route, Location, Due, timing (offset from treatment start / specific time), Occurrence (Not recurring / Recurring). Route catalog geniş (IV, IM, SC, PO, intranasal, intraosseous…)

**KRİTİK ayrım:** Catalog/billable **Item** ≠ **Clinical Activity** (administration). Ör: Midazolam item ≠ Midazolam 5mg/mL + route + location + time administration.

Activity template → runtime clinical activity; uygun bounded context'te yaşamalı (treatment, hospitalization, anesthesia protocol) — bundle içinde gömülü runtime record varsayımı yapma.

**Actions types:** Add attachment, Change Patient Status, Create form, Create letter, Create reminder, Create task, Disable reminder, Print certificate, Set patient sex to desexed

**Action binding örneği:** When Using: Midazolam 5mg/mL → Create form → Boarding Waiver and Consent

**Ayrım:** Bundle Action (operational side-effect) ≠ Form Logic (UI during fill) ≠ Item Action ([inventory-item-actions](#inventory-item-actions))

→ [EXAM-007](../backlog/feature-backlog.md), [EXAM-013](../backlog/feature-backlog.md), [EXAM-014](../backlog/feature-backlog.md), [IDEA-023](../research/ideas.md#idea-023--configurable-clinical-bundles), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion), [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population)

### Purchase Order Templates {#templates-purchase-orders}

Templates > Purchase Orders — reusable PO preset → [inventory-purchase-orders](#inventory-purchase-orders). Duplicate procurement entity **açılmaz**.

### Wellness Plans {#templates-wellness-plans}

Templates > Wellness Plans — Reports'ta wellness analytics de gözlemlendi.

**Bundle ≠ Wellness Plan:** Bundle tek işlem/estimate/protocol paketi olabilir; Wellness Plan zaman yayılmış preventive/subscription lifecycle — sandbox lifecycle **doğrulanmadı** — **P3** → [reports-wellness](#reports-wellness)

### Template vs Runtime {#templates-vs-runtime}

| Template definition | Runtime record |
|---|---|
| Medical Note Template | Completed Medical Note |
| Form Template | Submitted Form |
| Bundle Template | Estimate / Invoice / applied protocol |
| Activity (in bundle) | Performed medication administration |
| Letter Template | Generated/sent Letter |
| Appointment Type preset | Concrete Appointment |

**Prensip:** Template sonradan değiştirildiğinde geçmiş hasta kaydı **değişmemeli** → snapshot/version ihtiyacı.

### Vetinity Implications {#templates-vetinity-implications}

> **Vetinity ürün çıkarımı** — sandbox gözlemi değildir.

**P0/P1 aday:** temel clinic config; appointment types; clinic hours; payment/tax/discount config (TR); temel medical note templates

**P1/P2:** appointment workflow presets; structured note builder; reusable forms; bundles; comm defaults/tokens; room/resource config

**P2:** advanced form builder; conditional form logic; bundle clinical activities; workflow actions; snippets; document generation

**P3:** production credits; wellness plans; advanced marketing; generic automation engine; room divisibility

Mevcut roadmap/backlog **üstün gelir** — otomatik taşınmaz.

### Templates Gap Analysis {#templates-gap-analysis}

| Capability | DaySmart | Vetinity | Backlog | Priority |
|---|---|---|---|---|
| Template catalog + lifecycle | All Templates; metadata | Kısmi | EXAM-006, UX-002 | P1 |
| Structured medical note builder | Sections/groups/field types | Yok | EXAM-006, ADR-005 | P1/P2 |
| System-bound clinical components | Diagnoses picker etc. | Kısmi | EXAM-004, RECORD-006 | P1 |
| Form builder + logic | Designer/Preview/Logic | Yok | IDEA-018, PORTAL-005 | P2 |
| Bundle Items (ranges) | Estimate/Invoice bundles | Kısmi | EXAM-007/013 | P1/P2 |
| Bundle Activities (clinical protocol) | Medical/Vitals activities | Yok | — conceptual | P2 |
| Bundle Actions | Workflow side effects | Araştırılacak | EXAM-014, PATTERN-021 | P2/P3 |
| Snippets | Templates > Snippets | Planlı | EXAM-011 | P1/P2 |
| Letters/Attachments templates | Separate types | Araştırılacak | IDEA-018 | P2 |
| Template immutability/versioning | Usage count; edit risk | Yok | IDEA-025, PATTERN-023 | P1/P2 |
| PO templates | Purchase Orders | Yok | Inventory PO | P2 |
| Wellness plan templates | Templates + Reports | Yok | P3 | P3 |

### Açık doğrulama soruları (Templates)

- Invoice vs Estimate bundle aynı template entity mi
- Activity runtime nerede persist ediliyor
- Form Logic rule engine kapsamı
- Template delete vs disable when Total Use > 0
- Multi-clinic template sharing
- Custom Fields applicable entities
- Medical note template change → historical note behavior

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
- [Product Research Ideas](../research/ideas.md)
- [Product Patterns](../research/patterns.md)
- [ADR-005 — Modern muayene deneyimi](../decisions/ADR-005-modern-examination-experience.md)
- [ADR-006 — Hasta timeline](../decisions/ADR-006-patient-timeline.md)
