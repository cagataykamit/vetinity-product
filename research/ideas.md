# Product Research Ideas

Bu dosya **backlog değildir**.

Buradaki maddeler:

- Rakip araştırmalarından çıkan ürün fikirleridir
- Otomatik olarak geliştirme kararı anlamına gelmez
- Backlog'a geçmeden önce problem, kullanıcı değeri, kapsam ve öncelik değerlendirmesi gerekir
- Aynı fikir birden fazla rakipte görüldüğünde kaynak listesine eklenir

---

## IDEA-001 — Consultation-Centered Clinical Workspace

| Alan | Değer |
|---|---|
| **ID** | IDEA-001 |
| **Başlık** | Consultation-Centered Clinical Workspace |
| **Kaynak** | Provet Cloud |
| **Gözlenen problem** | Klinik notlar, tedaviler, ilaçlar, diagnostik işlemler ve ücretlendirme farklı ekranlara dağıldığında kullanıcı bağlam kaybedebilir |
| **Fikir** | Tek bir klinik olayın tüm ilgili işlemleri ortak bağlam altında yönetilir |
| **Vetinity fırsatı** | Muayene ekranı; klinik not, tedavi, reçete, laboratuvar, görüntüleme ve finansal bağlantıların merkezi olabilir |
| **Riskler** | Tek ekranın aşırı uzun ve karmaşık hale gelmesi |
| **Durum** | Research |

**DaySmart gözlemi (2026-08-02 bölüm 2):** Medical Note/SOAP workspace'te üst bağlam bandı (hasta, sağlayıcı, bağlı fatura, hatırlatmalar), Subjective–Objective–Assessment–Plan–Client Communication yapısı, sistematik muayene bölümleri, lock/duplicate/export — konsültasyon merkezli workspace kalıbını destekler. Sandbox doğrulanmadı.

→ [Provet Cloud analizi](../competitors/provet-cloud.md) · [DaySmart Vet — bölüm 2](../competitors/daysmart.md#2026-08-02--petcare-check-in-soap-bundle-ve-klinik-i̇letişim-akışı)

---

## IDEA-002 — Discharge Readiness Checklist

| Alan | Değer |
|---|---|
| **ID** | IDEA-002 |
| **Başlık** | Discharge Readiness Checklist |
| **Kaynak** | Provet Cloud |
| **Gözlenen problem** | Hasta tamamlanırken eksik klinik kayıtlar, reçeteler, ücretler veya takip işlemleri unutulabilir |
| **Fikir** | Tamamlama veya taburculuk öncesinde vaka bağlamına göre kontrol listesi çalıştırılır |
| **Vetinity fırsatı** | Eksik klinik ve operasyonel işlemler açıklanabilir şekilde gösterilebilir; uygun maddeler tek tıkla tamamlanabilir |
| **Riskler** | Aşırı uyarı, yanlış pozitifler ve kullanıcıların kontrol listesini alışkanlıkla atlaması |
| **Durum** | Research |

→ [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## IDEA-003 — Suggestion-First Workflow Validation

| Alan | Değer |
|---|---|
| **ID** | IDEA-003 |
| **Başlık** | Suggestion-First Workflow Validation |
| **Kaynak** | Provet Cloud |
| **Gözlenen problem** | Sert validasyonlar iş akışını gereksiz yere kesebilir; yalnızca uyarı veren sistemler ise önemli eksiklerin gözden kaçmasına neden olabilir |
| **Fikir** | Sistem eksikliği, nedenini ve önerilen düzeltmeyi gösterir; kritik olmayan durumlarda yetkili kullanıcı gerekçeyle devam edebilir |
| **Vetinity fırsatı** | Kural tabanlı kontroller ileride açıklanabilir AI önerileriyle desteklenebilir |
| **Riskler** | Yetki modeli, audit ihtiyacı ve klinik sorumluluk sınırları |
| **Durum** | Research |

→ [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## IDEA-004 — Persistent Patient Summary

| Alan | Değer |
|---|---|
| **ID** | IDEA-004 |
| **Başlık** | Persistent Patient Summary |
| **Kaynak** | ezyVet |
| **Gözlenen problem** | Kullanıcı farklı klinik ekranlarda hastanın temel bilgilerini ve kritik uyarılarını tekrar aramak zorunda kalabilir |
| **Fikir** | Hasta özeti ve kritik uyarılar klinik bağlam boyunca görünür kalır |
| **Vetinity fırsatı** | Kompakt hasta özeti; sahip, yaş, tür, kilo, mikroçip, alerji ve önemli uyarıları gösterebilir |
| **Riskler** | Ekran alanını daraltması ve bilgi yoğunluğu |
| **Durum** | Research |

**DaySmart sandbox gözlemi:** Patient Dashboard header'ında patient adı, owner, breed, species, sex, reproductive status (ayrı alan), age, weight birlikte gösteriliyor — tam alan seti **doğrulanmadı**

**DaySmart sandbox gözlemi (Patients Module):** Patient List status filtreleri + adet; Overview due list + overdue/upcoming badge; internal patient ID — → [daysmart.md](../competitors/daysmart.md#sandbox--patients-module)

---

## IDEA-005 — Critical Patient Alerts

| Alan | Değer |
|---|---|
| **ID** | IDEA-005 |
| **Başlık** | Critical Patient Alerts |
| **Kaynak** | ezyVet |
| **Gözlenen problem** | Alerji, agresyon veya kritik kronik durumlar rutin hasta bilgileri arasında kaybolabilir |
| **Fikir** | Kritik uyarılar hasta bağlamında yüksek görünürlükle sunulur |
| **Vetinity fırsatı** | Uyarılar önem seviyesi, geçerlilik tarihi, kaynağı ve oluşturan kullanıcı ile izlenebilir olabilir |
| **Riskler** | Uyarı yorgunluğu ve güncelliğini yitiren notlar |
| **Durum** | Research |

**DaySmart sandbox gözlemi:** Patient Dashboard sağ Attention paneli; gözlemlenen örnekte High / Bites — panel kapsamı **doğrulanmadı** → [EXAM-009](../backlog/feature-backlog.md)

---

## IDEA-006 — Section Navigator for Long Clinical Records

| Alan | Değer |
|---|---|
| **ID** | IDEA-006 |
| **Başlık** | Section Navigator for Long Clinical Records |
| **Kaynak** | Provet Cloud |
| **Gözlenen problem** | Uzun klinik ekranlarda kullanıcı ilgili bölüme ulaşmak için çok fazla kaydırma yapabilir |
| **Fikir** | Sticky bölüm navigasyonu kullanıcının ilgili klinik bölüme hızlı geçmesini sağlar |
| **Vetinity fırsatı** | Muayene ekranında bölüm navigasyonu, sekmeler veya bağlama göre açılan paneller birlikte değerlendirilebilir |
| **Riskler** | Kötü bilgi mimarisini gizleyen geçici bir çözüm haline gelmesi |
| **Durum** | Research |

→ [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## IDEA-007 — Clinical-to-Financial Traceability

| Alan | Değer |
|---|---|
| **ID** | IDEA-007 |
| **Başlık** | Clinical-to-Financial Traceability |
| **Kaynak** | Provet Cloud, ezyVet |
| **Gözlenen problem** | Faturadaki bir ücretin hangi klinik işlemden doğduğunun belirsiz olması denetimi ve eksik ücret kontrolünü zorlaştırır |
| **Fikir** | Finansal kalem ile kaynak klinik işlem arasında izlenebilir bağlantı kurulur |
| **Vetinity fırsatı** | Muayene, laboratuvar, reçete, görüntüleme ve yatış kalemleri kaynak kayıtlarıyla ilişkilendirilebilir |
| **Riskler** | İptal, iade, toplu paket ve manuel fiyat düzenlemelerinde karmaşık veri modeli |
| **Durum** | Research |

**DaySmart gözlemi (2026-08-02 bölüm 2):** Record satırında fiyat, bağlı invoice görünürlüğü ve view changes / audit history; bundle kaydı records ve billing'e yansıyor. Sandbox doğrulanmadı.

**DaySmart gözlemi (2026-08-02 bölüm 3 — sandbox observation):** SOAP ve Record'tan Invoice açılabiliyor; aynı faturada examination, vaccine, medication, procedure satırları birlikte görülebiliyor. Cross-navigation UX pattern.

**DaySmart gözlemi (Inventory Module — sandbox):** Item Transactions tab — patient, invoice, lot, expiration; cost-derived pricing (% of highest cost) — inventory-financial traceability read-model → [daysmart.md](../competitors/daysmart.md#inventory-transactions), [daysmart.md](../competitors/daysmart.md#inventory-item-detail)

**DaySmart gözlemi (2026-08-02 ~28:13–35:25 — sandbox observation):** Hasta geçmişinde record satırından SOAP ve faturaya çift yönlü navigasyon → [PATTERN-022](../research/patterns.md#pattern-022--clinical-cross-navigation)

**DaySmart sandbox gözlemi (Clients Module):** Client-scoped invoice/payment/estimate/credit read-models; Balance header aggregate; payment Applied To çoklu invoice — allocation gap adayı → [daysmart.md](../competitors/daysmart.md#client-billing)

**DaySmart sandbox gözlemi (Billing Module):** Clinic-wide Billing workspace; invoice finansal aggregate; Estimate→Invoice conversion workflow; Return≠Refund; returned≠restocked qty; credit Amount+Balance; write-off per invoice — → [daysmart.md](../competitors/daysmart.md#sandbox--billing--financial-operations)

→ [Provet Cloud analizi](../competitors/provet-cloud.md) · [DaySmart Vet — bölüm 2](../competitors/daysmart.md#record-lifecycle-ve-finansal-i̇zlenebilirlik)

---

## IDEA-008 — Embedded AI Instead of Separate AI Module

| Alan | Değer |
|---|---|
| **ID** | IDEA-008 |
| **Başlık** | Embedded AI Instead of Separate AI Module |
| **Kaynak** | E-vet Smart Plus analizi, Vetinity ürün vizyonu |
| **Gözlenen problem** | AI ayrı bir ekran olduğunda kullanıcının mevcut iş akışından kopması ve AI özelliğinin sınırlı kullanılması |
| **Fikir** | AI öneri ve özetleri kullanıcının çalıştığı hasta, muayene, timeline, laboratuvar ve dashboard ekranlarına gömülür |
| **Vetinity fırsatı** | Hasta özeti, muayene yardımcısı, laboratuvar özeti, günlük işletme özeti ve taburculuk taslağı gibi bağlamsal özellikler |
| **Riskler** | Yanlış öneri, açıklanabilirlik, maliyet, güvenlik ve klinik sorumluluk |
| **Durum** | Research |

**DaySmart gözlemi (2026-08-02 ~28:13–35:25 — sandbox observation):** Hasta profilinde bağlama duyarlı AI yan paneli; aktif hasta otomatik bağlam; Summarize ve SOAP summary hazır aksiyonları; hasta geçmişi/SOAP/ilaçlar üzerinden özet; AI hata uyarısı. Çıktılar doğrulanmadan kabul edilmemeli → [AI-102](../backlog/feature-backlog.md), [AI-103](../backlog/feature-backlog.md), [AI-009](../backlog/feature-backlog.md)

→ [AI stratejisi](../ai/ai-strategy.md)

---

## IDEA-009 — Context-Preserving Inline Entity Creation

| Alan | Değer |
|---|---|
| **ID** | IDEA-009 |
| **Başlık** | Context-Preserving Inline Entity Creation |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Randevu oluştururken müşteri veya hasta bulunamazsa kullanıcı takvim akışından ayrılıp ayrı ekrana gitmek zorunda kalabilir |
| **Gözlem** | DaySmart'ta arama sonucu yoksa Add Client/Patient ile ardışık modal akışı; oluşturulan kayıt randevu formuna geri bağlanıyor |
| **Vetinity fırsatı** | Takvim/randevu akışında inline müşteri/hasta oluşturma; drawer veya stepper ile modal yığını azaltılabilir |
| **Kapsam dışı / risk** | Mevcut müşteri/hasta CRUD ekranları ortadan kalkmaz; yalnızca hızlı oluşturma kısayolu. Yetki, duplicate kontrolü ve minimum zorunlu alan politikası netleştirilmeli |
| **Durum** | Research |

**Canlı sandbox gözlemi:** Takvim hücresinden New Appointment; Add Patient ikinci modal açıyor — bağlam korunuyor ancak **iç içe modal önerilen UX değil**; drawer/stepper değerlendirilmeli → [APPT-018](../backlog/feature-backlog.md)

→ [PATTERN-007](patterns.md#pattern-007--context-preserving-creation)

---

## IDEA-010 — Clinic-Branded Online Booking

| Alan | Değer |
|---|---|
| **ID** | IDEA-010 |
| **Başlık** | Clinic-Branded Online Booking |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Hasta sahibi randevu almak için kliniği aramak veya panel dışı kanallara yönelmek zorunda kalabilir |
| **Gözlem** | Klinik web sitesinde Book Appointment → bağımsız PetCare arayüzü; klinik panelinden ayrı frontend |
| **Vetinity fırsatı** | Kliniğe özel online randevu sayfası ve benzersiz bağlantı; klinik çalışanı hızlı randevu ile ayrı deneyimler |
| **Kapsam dışı / risk** | JavaScript widget ilk sürüm zorunluluğu değildir; özel bağlantı ile başlanabilir. Marka özelleştirme kapsamı aşamalı genişletilebilir |
| **Durum** | Research |

---

## IDEA-011 — Appointment Request Review Queue

| Alan | Değer |
|---|---|
| **ID** | IDEA-011 |
| **Başlık** | Appointment Request Review Queue |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Online talepler doğrudan kesin randevu olursa klinik kapasitesi ve uygunluk kontrolü zorlaşır |
| **Gözlem** | Talep klinik onayına gidiyor; Accept/Reject/Reschedule/History aksiyonları; takvimde pending durumu |
| **Vetinity fırsatı** | Ayrı bekleyen talepler kuyruğu ve takvimde filtrelenebilir pending görünümü değerlendirilebilir |
| **Kapsam dışı / risk** | Online booking doğrudan onaylanmış randevu olmak zorunda değildir. Yoğun kliniklerde pending takvimi kirletmemek için filtre şart |
| **Durum** | Research |

→ [PATTERN-008](patterns.md#pattern-008--request-to-confirmation-workflow)

---

## IDEA-012 — Availability-Only Booking

| Alan | Değer |
|---|---|
| **ID** | IDEA-012 |
| **Başlık** | Availability-Only Booking |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Hasta sahibine tüm slotlar gösterilirse uyumsuz talep ve red döngüsü artar |
| **Gözlem** | Hasta sahibi yalnızca uygun gün ve saatleri seçebiliyor |
| **Vetinity fırsatı** | Müsaitlik motoru randevu nedeni, süre, hekim/kaynak ve klinik takvimine göre slot üretebilir |
| **Kapsam dışı / risk** | Müsaitlik kuralları yanlış yapılandırılırsa çift rezervasyon veya boş slot riski. Sandbox doğrulaması gerekir |
| **Durum** | Research |

→ [PATTERN-009](patterns.md#pattern-009--availability-driven-self-service)

---

## IDEA-013 — Template-Based Appointment Communications

| Alan | Değer |
|---|---|
| **ID** | IDEA-013 |
| **Başlık** | Template-Based Appointment Communications |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Her randevuda tam metin editörü açık olursa günlük işlem yavaşlar |
| **Gözlem** | Onay/red/hatırlatma için hazır mesajlar görüntülenip düzenlenebiliyor; kanal ve gün seçimi yapılabiliyor |
| **Vetinity fırsatı** | Şablon + önizleme varsayılan; tam editör isteğe bağlı. Kabul/red mesajları tutarlı kalır |
| **Kapsam dışı / risk** | Şablon yönetimi ve çoklu dil ihtiyacı. SMS/WhatsApp ayrı entegrasyon gerektirir |
| **Durum** | Research |

**DaySmart sandbox gözlemi (Boarding):** Reservation kaydı → otomatik transactional HTML e-posta (client, patient, check-in/out, klinik iletişim); event tetikleyici — şablon yönetimi **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#notification-flow)

**DaySmart sandbox gözlemi (Reminders):** Reminders Detail operasyon listesi; Resend selected toplu gönderim; Type kanal seçimi (Email/Phone/SMS/No Reminder); relatif Send kuralı — şablon içeriği **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#sandbox--reminders-reminders-detail)

→ [PATTERN-011](patterns.md#pattern-011--template-first-communication)

---

## IDEA-014 — Configurable Scheduling Resources

| Alan | Değer |
|---|---|
| **ID** | IDEA-014 |
| **Başlık** | Configurable Scheduling Resources |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Yalnızca hekim kolonlu takvim oda, walk-in ve ekipman planlamasını kapsamaz |
| **Gözlem** | Hekim, oda, walk-in ayrı kolonlar; kaynak seçimi randevu oluşturmada mevcut |
| **Vetinity fırsatı** | Hekim, oda, walk-in ve gerektiğinde ekipman bazlı yapılandırılabilir takvim değerlendirilebilir |
| **Kapsam dışı / risk** | Kaynak modeli karmaşıklaşır; küçük klinikler için sade varsayılan gerekir |
| **Durum** | Research |

**Canlı sandbox gözlemi:** Gün/hafta görünümü; hekim ve Tech Appts kolonları; All Columns seçimi; boş hücre tıklanınca kolon+tarih+saat bağlamıyla randevu modalı — doğrulanmadı. **Boarding reservation calendar:** oda-kaynak timeline; Max:N kapasite; gün/hafta/ay — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#reservation-calendar)

→ [PATTERN-012](patterns.md#pattern-012--configurable-resource-calendar)

---

## IDEA-015 — Real-Time Operational Notification Center

| Alan | Değer |
|---|---|
| **ID** | IDEA-015 |
| **Başlık** | Real-Time Operational Notification Center |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Geçici toast kaybolunca online talep veya operasyonel olay kaçırılabilir |
| **Gözlem** | Anlık bildirim + kalıcı bildirim merkezi + rozet + tür filtresi (sandbox doğrulanmadı) |
| **Vetinity fırsatı** | Toast, badge ve bildirim merkezi birlikte değerlendirilebilir; randevu talebi dışında genişletilebilir |
| **Kapsam dışı / risk** | Gerçek zamanlı bildirimin teknik çözümü ürün belgesinde kesinleştirilmemelidir. Push/mobil kapsam dışı olabilir |
| **Durum** | Research |

→ [PATTERN-010](patterns.md#pattern-010--event-to-notification-continuity)

---

## IDEA-016 — Deposit-Aware Appointment Types

| Alan | Değer |
|---|---|
| **ID** | IDEA-016 |
| **Başlık** | Deposit-Aware Appointment Types |
| **Kaynak** | [DaySmart Vet — 2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı) |
| **Gözlenen problem** | Yüksek no-show riskli randevu tiplerinde klinik korunması zayıf kalabilir |
| **Gözlem** | Bazı ziyaret nedenlerinde depozito bilgisi gösterilebiliyor |
| **Vetinity fırsatı** | Randevu nedeni bazlı depozito politikası değerlendirilebilir |
| **Kapsam dışı / risk** | Depozito ayrı ödeme, iade ve iptal politikası gerektirir; v1.0 ve ilk faz zorunluluğu değildir |
| **Durum** | Research |

---

## IDEA-017 — Owner Portal as Operational Extension

| Alan | Değer |
|---|---|
| **ID** | IDEA-017 |
| **Başlık** | Owner Portal as Operational Extension |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#hasta-sahibi-portalı) |
| **Gözlenen problem** | Hasta sahibi randevu, hatırlatma, fatura ve belge bilgilerine klinik panelinden bağımsız erişmek zorunda kalabilir |
| **Gözlem** | PetCare portalı ana ekranda ziyaretler, hatırlatmalar, açık faturalar, hayvan kartları; alt navigasyon Home/Pets/Billing/Vets/Profile; klinik uygulamasından ayrı web yüzeyi |
| **Fikir** | Hasta sahibi portalı operasyonel uzantı olarak sunulur; klinik kayıtlarıyla senkron kalır |
| **Vetinity fırsatı** | v1.0 dışı aday; Türkiye pazarı için mobil-öncelikli sade portal değerlendirilebilir |
| **Riskler** | Çok yüzeyli UX tutarlılığı; kimlik doğrulama; çok klinik bağlamı |
| **Durum** | Research |

→ [PORTAL-001](../backlog/feature-backlog.md) · [PATTERN-013](patterns.md#pattern-013--portal-to-clinic-continuity)

---

## IDEA-018 — Consent and Document Signature Workflow

| Alan | Değer |
|---|---|
| **ID** | IDEA-018 |
| **Başlık** | Consent and Document Signature Workflow |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#belge-ve-dijital-imza) |
| **Gözlenen problem** | Onam formları ve tahmin/fatura belgeleri basılı imza veya ayrı kanallarla yönetildiğinde gecikme ve kayıp riski artar |
| **Gözlem** | Portalda invoice, estimate, take-home report card, consent form listeleniyor; open/approved/paid durumları; hasta sahibi belgeyi görüntüleyip ekranda imzalayabiliyor; imza belgeye işleniyor |
| **Fikir** | Belge görüntüleme → dijital imza → durum güncelleme sürekliliği |
| **Vetinity fırsatı** | v1.0 dışı aday; Türkiye hukuki geçerlilik ayrıca araştırılmalı |
| **Riskler** | Hukuki geçerlilik; KVKK; imza sahteciliği |
| **Durum** | Research |

**DaySmart sandbox gözlemi (Treatment Board):** Kart Documents popup; consent, rapor, invoice, treatment summary örnekleri — tam liste **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#documents-treatment-bağlamı)

**DaySmart gözlemi (2026-08-02 bölüm 3 — sandbox observation):**

- Klinik **Documents** menüsü: Letters, Attachments, Forms ayrımı
- Vaccination Consent benzeri belgeler; hasta + SOAP/ziyaret bağlantısı; oluşturucu bilgisi
- **Draw Signature** ve **Type Signature**; imza belgeye gömülü
- İmzalı belge **Lock Letter** ile kilitlenebiliyor (immutable document adayı)
- Elektronik onay / hasta onayı / medico-legal kayıt perspektifleri ayrı değerlendirilmeli; Türkiye kapsamı doğrulanmadı

**DaySmart gözlemi (2026-08-02 ~28:13–35:25 — sandbox observation):**

- Checkout sırasında Vaccine Certificate, Invoice, Vaccination Consent Form seçilebiliyor; teslim: None / Email / SMS / Print
- Gözlemlenen checkout akışında Vaccination Certificate + Paid Invoice + Signed Consent Form içeren üç sayfalık tek PDF çıktısı görüntülendi; her durumda tek PDF üretildiği doğrulanmadı
- Tek olaydan birden fazla klinik/finansal belgenin birlikte üretilmesi ve tek işlem bağlamında teslimi → [PATTERN-024](patterns.md#pattern-024--event-to-document-package)

**DaySmart sandbox gözlemi (Clients Module):** Client Documents — Attachments/Letters/Forms/Certificates; form template örnekleri (Intake, Waiver, Consent) — → [daysmart.md](../competitors/daysmart.md#documents)

→ [PORTAL-005](../backlog/feature-backlog.md) · [PATTERN-014](patterns.md#pattern-014--document-to-signature-continuity) · [CHECKOUT-001](../backlog/feature-backlog.md)

---

## IDEA-019 — Unified Client Communication Timeline

| Alan | Değer |
|---|---|
| **ID** | IDEA-019 |
| **Başlık** | Unified Client Communication Timeline |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#klinik-inbox-ve-müşteri-i̇letişim-geçmişi) |
| **Gözlenen problem** | Müşteri iletişimi farklı kanallarda dağınık kalır; kapatılan konuşmalar geçmişe kaybolabilir |
| **Gözlem** | Klinik inbox müşteri bazlı konuşma listesi; iki yönlü mesaj; sağ panelde iletişim/adres/bakiye/hayvan; kapatılan konuşma iletişim geçmişine taşınıyor |
| **Fikir** | Aktif inbox + arşivlenmiş iletişim geçmişi birleşik müşteri timeline'ında birleşir |
| **Vetinity fırsatı** | v1.0 dışı aday; SMS/e-posta entegrasyonu ayrı değerlendirme |
| **Riskler** | Kanal parçalanması; bildirim gürültüsü; KVKK |
| **Durum** | Research |

**DaySmart sandbox gözlemi:** Client profili Patient profilinden ayrı; Communication Preferences Transactional/Marketing ayrımı — kanal davranışı **doğrulanmadı**. **Patients/Clients Module:** scoped communication read-models. **Contacts Module:** Contact/Company Communications; Contact ≠ Client; referral relationships (Referred Patient); manual Log Communication — → [daysmart.md](../competitors/daysmart.md#sandbox--contacts--contact-module). **Reminders:** Log call — [daysmart.md](../competitors/daysmart.md#log-call--communication-record)

→ [MSG-001](../backlog/feature-backlog.md) · [PATTERN-015](patterns.md#pattern-015--conversation-to-patient-context)

---

## IDEA-020 — Check-in Orchestration

| Alan | Değer |
|---|---|
| **ID** | IDEA-020 |
| **Başlık** | Check-in Orchestration |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#check-in-orkestrasyonu) |
| **Gözlenen problem** | Randevu geldiğinde şikâyet, kilo, formlar, muayene şablonu, bundle ve billing ayrı ekranlarda toplanırsa operasyon yavaşlar |
| **Gözlem** | Randevu kartından Check In; şikâyet, kilo, mektup/form şablonları, yatış, medical note şablonu, bundle, billing, cage card; yeni veya mevcut invoice/estimate; tamamlanınca Checked In; undo check-in/check-out |
| **Fikir** | Check-in, randevu → muayene → billing → form akışının orkestratörü olur |
| **Vetinity fırsatı** | P1 aday; sade varsayılan alan seti + isteğe bağlı genişletme |
| **Riskler** | Form aşırı yüklü; undo yan etkileri (stok, billing) |
| **Durum** | Research |

**DaySmart gözlemi (2026-08-02 bölüm 3 — sandbox observation):** SOAP ekranında ziyaret durumları: Booked → Checked In → In Room → Visit Complete → Check Out; durum değişiminde opsiyonel not. Check-in tek adım; tam ziyaret yaşam döngüsü daha geniş.

**DaySmart gözlemi (2026-08-02 ~28:13–35:25 — sandbox observation):** Visit Complete durumundayken ayrı Check Out başlatılabiliyor; checkout tahsilat + belge + teslim orkestrasyonu → [IDEA-027](#idea-027--checkout-as-visit-completion-orchestrator)

**DaySmart sandbox gözlemi (Census):** Operasyon kuyruğu görünümü; satır bazlı status değişimi (Not confirmed, Confirmed, Cancelled, Checked in); opsiyonel Notes — tam durum kümesi **doğrulanmadı**

**DaySmart sandbox gözlemi (Boarding):** Reservation → Check In sihirbazı (billing, boarding form, apply item rule, daily rate, bundle, weight, cage card, medical note); inline item oluşturma — tamamlama **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#check-in-wizard)

→ [CHECKIN-001](../backlog/feature-backlog.md) · [PATTERN-016](patterns.md#pattern-016--check-in-as-workflow-orchestrator) · [CHECKOUT-001](../backlog/feature-backlog.md)

---

## IDEA-021 — Clinical Snippet Library

| Alan | Değer |
|---|---|
| **ID** | IDEA-021 |
| **Başlık** | Clinical Snippet Library |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#snippet-ve-sesle-not) |
| **Gözlenen problem** | Tekrarlayan anamnez soru setleri her muayenede elle yazılıyor |
| **Gözlem** | `#` yazıldığında snippet listesi açılıyor; `#vomiting` seçilince yapılandırılmış soru metni Subjective alanına yerleşiyor; **AI özelliği değil** |
| **Fikir** | Klinik bazlı yönetilebilir snippet kütüphanesi; hızlı yapılandırılmış veri girişi |
| **Vetinity fırsatı** | P1 aday; snippet yönetimi klinik ayarlarında |
| **Riskler** | Snippet ile AI karıştırılması; eski snippet'ların güncelliği |
| **Durum** | Research |

→ [EXAM-011](../backlog/feature-backlog.md) · [PATTERN-017](patterns.md#pattern-017--structured-clinical-snippets)

---

## IDEA-022 — Voice-Assisted Clinical Documentation

| Alan | Değer |
|---|---|
| **ID** | IDEA-022 |
| **Başlık** | Voice-Assisted Clinical Documentation |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#snippet-ve-sesle-not) |
| **Gözlenen problem** | Muayene sırasında yazılı not alma zaman alır |
| **Gözlem** | Daisy Voice / Speech to Text penceresi; kayıt/duraklat/oynat kontrolleri; ~20 dk kalan süre; diktasyon yazıya dönüşüyor; teknik sağlayıcı **doğrulanmadı** |
| **Fikir** | Sesle klinik not; premium/ileri faz aday |
| **Vetinity fırsatı** | [AI-005](../backlog/feature-backlog.md) ile ilişkili; v1.0 dışı aday; snippet sisteminden ayrı değerlendirilmeli |
| **Riskler** | Doğruluk; gizlilik; maliyet; hekim onayı zorunluluğu |
| **Durum** | Research |

→ [AI-005](../backlog/feature-backlog.md)

---

## IDEA-023 — Configurable Clinical Bundles

| Alan | Değer |
|---|---|
| **ID** | IDEA-023 |
| **Başlık** | Configurable Clinical Bundles |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#bundle-ve-doz-hesaplayıcı) |
| **Gözlenen problem** | Sık uygulanan muayene+aşı+ilaç+prosedür kombinasyonları tek tek ekleniyor |
| **Gözlem** | Check-in veya medical note'tan bundle; kalemler dahil/hariç; miktar düzenleme; apply item rule; invoice bağlantısı; kayıt sonrası records ve billing'e yansıma |
| **Fikir** | Yapılandırılabilir bundle klinik-stok-reçete-finans köprüsü kurar |
| **Vetinity fırsatı** | [EXAM-007](../backlog/feature-backlog.md) genişletmesi; kopyalama değil problem odaklı |
| **Riskler** | Item rule opaklığı; stok/fatura senkronizasyonu |
| **Durum** | Research |

**DaySmart sandbox gözlemi:** Treatment Board → New Bundle sihirbazı (template, invoice, provider, medical note) — kalem düzenleme ve kayıt yansıması **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#new-bundle-sihirbaz). **Boarding Check In:** Boarding Bundle + medical bundle'lar — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#bundle-check-in-bağlamı). **Inventory Module:** item ↔ bundle mapping; Print on Invoice/Estimate — → [daysmart.md](../competitors/daysmart.md#inventory-bundles)

→ [EXAM-007](../backlog/feature-backlog.md) · [PATTERN-018](patterns.md#pattern-018--bundle-to-record-expansion)

---

## IDEA-024 — Embedded Dosage Support

| Alan | Değer |
|---|---|
| **ID** | IDEA-024 |
| **Başlık** | Embedded Dosage Support |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#bundle-ve-doz-hesaplayıcı) |
| **Gözlenen problem** | mg/kg doz ve hacim hesabı manuel yapıldığında hata riski artar |
| **Gözlem** | Hayvan kilosu, mg/kg doz, doz aralığı, konsantrasyon, toplam doz, toplam hacim alanları |
| **Fikir** | Muayene/tedavi akışına gömülü doz hesaplayıcı; **klinik karar desteği**, veteriner kararının yerini almaz |
| **Vetinity fırsatı** | [EXAM-008](../backlog/feature-backlog.md) ile ilişkili; P3 / araştırılacak aday olarak değerlendirilebilir |
| **Riskler** | Yanlış güven; otomatik doz kararı algısı |
| **Durum** | Research |

→ [EXAM-008](../backlog/feature-backlog.md)

---

## IDEA-025 — Auditable Clinical Record Lifecycle

| Alan | Değer |
|---|---|
| **ID** | IDEA-025 |
| **Başlık** | Auditable Clinical Record Lifecycle |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 2](../competitors/daysmart.md#record-lifecycle-ve-finansal-i̇zlenebilirlik) |
| **Gözlenen problem** | İlaç/işlem kayıtlarında lot, expiry, route değişiklikleri izlenemezse denetim ve güvenlik zayıflar |
| **Gözlem** | İlaç, işlem, muayene, aşı ayrı satırlar; lot/üretici/expiry/route/site; edit/duplicate/print label/delete; view changes audit history |
| **Fikir** | Record lifecycle denetlenebilir; klinik-finans izlenebilirliği korunur |
| **Vetinity fırsatı** | P1 audit history; P2 attachment/duplicate |
| **Riskler** | Audit veri hacmi; retention politikası |
| **Durum** | Research |

**DaySmart gözlemi (2026-08-02 bölüm 3 — sandbox observation):** Tek Record kavramı altında Vaccine, Medication, Procedure, Diagnostic, Vital tipleri; tip değişince form dinamik. → [IDEA-026](#idea-026--unified-dynamic-record-model)

**DaySmart gözlemi (Inventory Module — sandbox):** Stock adjustment Current vs Actual balance + reason + audit — auditable movement prensibi record lifecycle ile paralel → [daysmart.md](../competitors/daysmart.md#inventory-adjustments)

→ [RECORD-002](../backlog/feature-backlog.md) · [PATTERN-019](patterns.md#pattern-019--auditable-record-actions)

---

## IDEA-026 — Unified Dynamic Record Model

| Alan | Değer |
|---|---|
| **ID** | IDEA-026 |
| **Başlık** | Unified Dynamic Record Model |
| **Kaynak** | [DaySmart Vet — 2026-08-02 bölüm 3](../competitors/daysmart.md#2026-08-02--record-belge-ziyaret-durumu-ve-finans-cross-navigation) |
| **Gözlenen problem** | Aşı, ilaç, prosedür, diagnostik ve vital kayıtları ayrı modüllerde tutulduğunda veri modeli ve UX parçalanır |
| **Gözlem (sandbox observation)** | Tek Record kavramı; Vaccine, Medication, Procedure, Diagnostic, Vital tipleri; tip değişince form dinamik olarak değişiyor |
| **Fikir** | Generic record architecture + type-specific dynamic form + tek entity/metadata yaklaşımı |
| **Vetinity fırsatı** | Tutarlı klinik kayıt modeli; timeline ve finans bağlantısı tek yapı üzerinden |
| **Riskler** | Metadata karmaşıklığı; tip-özel validasyon; performans |
| **Durum** | Research |

**DaySmart sandbox gözlemi (Patients Module):** History Records/Pharmacy/Labs/Vaccines/Vitals aynı clinical event'in modül filtreli read-model'leri; Invoice + Reference cross-link — → [daysmart.md](../competitors/daysmart.md#records)

→ [RECORD-006](../backlog/feature-backlog.md) · [PATTERN-020](patterns.md#pattern-020--unified-record-with-dynamic-type-forms)

---

## IDEA-027 — Checkout as Visit Completion Orchestrator

| Alan | Değer |
|---|---|
| **ID** | IDEA-027 |
| **Başlık** | Checkout as Visit Completion Orchestrator |
| **Kaynak** | [DaySmart Vet — 2026-08-02 ~28:13–35:25](../competitors/daysmart.md#checkout-finansal-kapanış-belge-paketi-ve-bağlamsal-ai) |
| **Gözlenen problem** | Ziyaret kapanışında tahsilat, belge üretimi, teslim kanalı ve operasyonel durum ayrı ekranlarda kopuk kalırsa resepsiyon yükü ve hata riski artar |
| **Gözlem (sandbox observation)** | Visit Complete iken Check Out başlatılabiliyor; açık fatura seçimi, kredi, tahsilat, ödeme yöntemi, fazla tahsilat sonucu, belge seçimi, çok kanallı teslim, reminder görünürlüğü tek checkout akışında |
| **Fikir** | Checkout yalnızca ödeme değil; ziyaretin operasyonel ve finansal kapanış orkestratörüdür |
| **Vetinity fırsatı** | CHECKOUT-001 kapsamında değerlendirilebilir; Türkiye e-Fatura/e-Arşiv/e-SMM ve POS ayrı doğrulama |
| **Riskler** | Parçalı ödeme, çoklu borç, iade, cari hesap, e-belge mevzuatı |
| **Durum** | Research |

**DaySmart sandbox gözlemi (Billing Module):** Payment multi-invoice allocation; Credits; Returns/Refunds ayrımı; Invoice workspace — checkout ile örtüşen finansal operasyonlar → [daysmart.md](../competitors/daysmart.md#billing-payments), [daysmart.md](../competitors/daysmart.md#billing-vetinity-implications)

→ [CHECKOUT-001](../backlog/feature-backlog.md) · [IDEA-018](#idea-018--consent-and-document-signature-workflow) · [CHECKIN-005](../backlog/feature-backlog.md)

---

## IDEA-028 — Versioned Legal Terms Acceptance

| Alan | Değer |
|---|---|
| **ID** | IDEA-028 |
| **Başlık** | Versioned Legal Terms Acceptance |
| **Kaynak** | [DaySmart Vet — canlı sandbox](../competitors/daysmart.md#sandbox--i̇lk-giriş-takvim-ve-randevu-oluşturma) |
| **Gözlenen problem** | Kullanım şartları güncellendiğinde kabul kaydı ve sürüm takibi yoksa hukuki/operasyonel risk oluşur |
| **Gözlem (sandbox gözlemi)** | İlk girişte ToS Updated modalı; kaydırarak okuma; süre/inceleme sonrası onay + I Accept |
| **Fikir** | Zorunlu sözleşme kabulü, sürümleme, kullanıcı/tenant onay kaydı ve yeniden kabul akışı |
| **Vetinity fırsatı** | SaaS onboarding, trial girişi ve genel hesap erişiminde değerlendirilebilir |
| **Riskler** | Tenant vs kullanıcı kapsamı; audit; hukuki metin yönetimi — **doğrulanmadı** |
| **Durum** | Research |

→ [TRIAL-009](../backlog/feature-backlog.md)

---

## İlgili belgeler

- [Rakip analizleri](../competitors/README.md)
- [DaySmart Vet analizi](../competitors/daysmart.md)
- [Product Patterns](patterns.md)
- [Provet Cloud analizi](../competitors/provet-cloud.md)
- [Ürün geliştirme akışı](../WORKFLOW.md)
