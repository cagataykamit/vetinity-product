# Product Patterns

Bu dosya **backlog değildir**.

Bu dosyada ürün tasarım kalıpları tutulur. Bir pattern:

- Birden fazla rakipte görülebilir
- Vetinity tarafından kullanılabilir veya kullanılmayabilir
- Ürün araştırması niteliğindedir; geliştirme kararı anlamına gelmez

Tekil fikir kayıtları için: [ideas.md](ideas.md)

---

## PATTERN-001 — Persistent Patient Context

| Alan | Değer |
|---|---|
| **ID** | PATTERN-001 |
| **Başlık** | Persistent Patient Context |
| **Problem** | Kullanıcı farklı klinik ekranlarda gezinirken hasta kimliği, kritik uyarılar ve temel bilgiler tekrar aranır; klinik bağlam kaybolur |
| **Pattern açıklaması** | Hasta özeti, sahip bilgisi, tür/ırk, kilo, mikroçip, alerji ve kritik uyarılar klinik iş akışı boyunca sabit veya kolayca erişilebilir bir alanda görünür tutulur |
| **Avantajları** | Bağlam korunur; kritik bilgi gözden kaçma riski azalır; ekranlar arası geçiş hızlanır |
| **Riskleri** | Ekran alanı daralır; bilgi yoğunluğu; güncelliğini yitiren uyarıların yanlış güven hissi yaratması |
| **Hangi rakiplerde görüldü** | ezyVet (gözlem), DaySmart Vet (Patient Dashboard header + Attention; **Patients Module** Overview snapshot + due list — [sandbox](../competitors/daysmart.md#patient-profile--header--overview)) |
| **Vetinity değerlendirmesi** | Muayene ve timeline akışlarında kompakt hasta özeti ve kritik uyarı bandı değerlendirilebilir. Uyarı yorgunluğunu önlemek için önem seviyesi ve geçerlilik tarihi düşünülmelidir |
| **Durum** | Research |

→ İlgili fikir: [IDEA-004](ideas.md#idea-004--persistent-patient-summary), [IDEA-005](ideas.md#idea-005--critical-patient-alerts)

---

## PATTERN-002 — Consultation-Centered Workflow

| Alan | Değer |
|---|---|
| **ID** | PATTERN-002 |
| **Başlık** | Consultation-Centered Workflow |
| **Problem** | Klinik not, tedavi, reçete, diagnostik işlem ve ücretlendirme ayrı modüllere dağıldığında kullanıcı bağlam kaybeder ve tekrarlayan navigasyon yapar |
| **Pattern açıklaması** | Tek bir klinik olay (konsültasyon/muayene) ana çalışma alanı olur; ilgili notlar, tedavi kalemleri, prosedürler, ilaçlar, diagnostik işlemler ve taburculuk talimatları aynı bağlam altında yönetilir |
| **Avantajları** | Uçtan uca klinik akış; bağlam sürekliliği; klinik ile finans arasında doğal geçiş |
| **Riskleri** | Tek ekranın aşırı uzun ve karmaşık hale gelmesi; öğrenme eğrisi; performans (çok kayıtlı vakalar) |
| **Hangi rakiplerde görüldü** | Provet Cloud (doğrudan gözlem), DaySmart Vet (SOAP çalışma alanı — kısmi analiz; check-in → medical note → billing bağlantısı — [2026-08-02 bölüm 2](../competitors/daysmart.md#check-in-orkestrasyonu), sandbox doğrulanmadı) |
| **Vetinity değerlendirmesi** | Modern muayene çalışma alanı hedefiyle uyumlu bir kalıp olarak değerlendirilebilir. Sade ve modüler alt bölümlerle karmaşıklık sınırlandırılmalıdır; kesintisiz tek sayfa kopyalanmamalıdır |
| **Durum** | Research |

→ İlgili fikir: [IDEA-001](ideas.md#idea-001--consultation-centered-clinical-workspace) · [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## PATTERN-003 — Suggestion-First Validation

| Alan | Değer |
|---|---|
| **ID** | PATTERN-003 |
| **Başlık** | Suggestion-First Validation |
| **Problem** | Sert validasyon iş akışını gereksiz keser; yalnızca pasif uyarılar ise önemli eksiklerin gözden kaçmasına yol açabilir |
| **Pattern açıklaması** | Sistem eksikliği tespit ettiğinde engelleyici hata yerine (kritik kurallar hariç) uyarır, nedeni açıklar, önerilen düzeltmeyi sunar; yetkili kullanıcı gerekçeyle devam edebilir |
| **Avantajları** | İş akışı kesintisi azalır; eksikler proaktif yakalanır; kullanıcı eğitici geri bildirim alır |
| **Riskleri** | Öneri motorunun opak olması; yanlış pozitifler; audit ve yetki modeli karmaşıklığı; kullanıcıların önerileri alışkanlıkla atlama eğilimi |
| **Hangi rakiplerde görüldü** | Provet Cloud (doğrudan gözlem — kural tabanlı veya karar destekli olabilir; AI doğrulanmadı) |
| **Vetinity değerlendirmesi** | Taburculuk ve faturalama öncesi eksik işlem kontrollerinde değerlendirilebilir. Önerilerin nedeni açıkça gösterilmeli; klinik karar hekimde kalmalıdır. Kural tabanlı ve AI destekli varyantlar ayrı değerlendirilmelidir |
| **Durum** | Research |

→ İlgili fikir: [IDEA-003](ideas.md#idea-003--suggestion-first-workflow-validation) · [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## PATTERN-004 — Discharge Checklist

| Alan | Değer |
|---|---|
| **ID** | PATTERN-004 |
| **Başlık** | Discharge Checklist |
| **Problem** | Vaka tamamlanırken klinik kayıt, reçete, ücret, takip randevusu veya hasta sahibi talimatı gibi adımlar unutulabilir |
| **Pattern açıklaması** | Tamamlama veya taburculuk öncesinde vaka bağlamına göre yapılandırılabilir kontrol listesi çalıştırılır; eksik maddeler gösterilir ve uygun olanlar hızlıca tamamlanabilir |
| **Avantajları** | Operasyonel eksiklikler azalır; taburculuk kalitesi artar; denetlenebilir tamamlama süreci |
| **Riskleri** | Aşırı uyarı; yanlış pozitifler; kontrol listesinin formaliteye dönüşmesi; farklı vaka türlerine uymayan sabit maddeler |
| **Hangi rakiplerde görüldü** | Provet Cloud (Ready for discharge akışı — doğrudan gözlem) |
| **Vetinity değerlendirmesi** | Muayene ve yatış tamamlama akışlarında değerlendirilebilir. Maddeler zorunlu olmamalı; klinik yapılandırması, vaka türü ve yetkiye göre esnek olmalıdır |
| **Durum** | Research |

→ İlgili fikir: [IDEA-002](ideas.md#idea-002--discharge-readiness-checklist) · [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## PATTERN-005 — Clinical-to-Financial Traceability

| Alan | Değer |
|---|---|
| **ID** | PATTERN-005 |
| **Başlık** | Clinical-to-Financial Traceability |
| **Problem** | Faturadaki bir kalemin hangi klinik işlemden doğduğu belirsizse eksik ücret kontrolü, denetim ve itiraz yönetimi zorlaşır |
| **Pattern açıklaması** | Her finansal kalem mümkün olduğunda kaynak klinik kaydıyla (muayene, prosedür, lab istemi, reçete, görüntüleme vb.) ilişkilendirilir; konsültasyondan faturaya süreklilik korunur |
| **Avantajları** | Denetlenebilirlik; eksik ücret tespiti; raporlama; müşteri itirazlarında açıklanabilirlik |
| **Riskleri** | İptal, iade, paket fiyat ve manuel düzenlemelerde veri modeli karmaşıklığı; ilişki kopukluğu senaryoları |
| **Hangi rakiplerde görüldü** | Provet Cloud (konsültasyon → taslak fatura — doğrudan gözlem), ezyVet (değerlendirme adayı — detaylı analiz bekliyor), DaySmart Vet (record satırında bağlı invoice; SOAP/Record → Invoice cross-navigation — [2026-08-02 bölüm 3](../competitors/daysmart.md#soap--record--invoice-cross-navigation)); **Clients Module** customer-scoped read-models ([sandbox](../competitors/daysmart.md#client-billing)); **Inventory Module** item Transactions ([sandbox](../competitors/daysmart.md#inventory-transactions)); **Billing Module** invoice workspace, payment allocation, Return/Refund ayrımı ([sandbox](../competitors/daysmart.md#sandbox--billing--financial-operations)) |
| **Vetinity değerlendirmesi** | Ödeme ve muayene modülleri arasında izlenebilir bağlantı değerlendirilebilir. Türkiye fatura/e-belge gereksinimleri ayrıca araştırılmalıdır |
| **Durum** | Research |

→ İlgili fikir: [IDEA-007](ideas.md#idea-007--clinical-to-financial-traceability) · [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## PATTERN-006 — Section Navigation for Long Clinical Records

| Alan | Değer |
|---|---|
| **ID** | PATTERN-006 |
| **Başlık** | Section Navigation for Long Clinical Records |
| **Problem** | Uzun klinik kayıtlarında kullanıcı ilgili bölüme ulaşmak için aşırı kaydırma yapar; bilişsel yük artar |
| **Pattern açıklaması** | Uzun klinik ekranlarda sticky bölüm navigasyonu, içindekiler veya benzeri bir mekanizma ile bölümler arası hızlı geçiş sağlanır |
| **Avantajları** | Uzun formlarda orientasyon; hızlı erişim; mevcut tek sayfa yapısını korurken gezinmeyi kolaylaştırır |
| **Riskleri** | Kötü bilgi mimarisini maskeleyen geçici çözüm; navigasyon öğesinin kendisi karmaşıklık yaratabilir; mobilde sticky davranış zorlukları |
| **Hangi rakiplerde görüldü** | Provet Cloud (sağ bölüm navigasyonu — doğrudan gözlem) |
| **Vetinity değerlendirmesi** | Muayene ekranında bölüm navigasyonu, sekmeler veya bağlama göre paneller birlikte değerlendirilebilir. Navigasyon, gereksiz uzun tek sayfa tasarımının gerekçesi olmamalıdır |
| **Durum** | Research |

→ İlgili fikir: [IDEA-006](ideas.md#idea-006--section-navigator-for-long-clinical-records) · [Provet Cloud analizi](../competitors/provet-cloud.md)

---

## PATTERN-007 — Context-Preserving Creation

| Alan | Değer |
|---|---|
| **ID** | PATTERN-007 |
| **Başlık** | Context-Preserving Creation |
| **Problem** | Yeni müşteri/hasta oluşturmak için ana iş akışından çıkmak bağlam kaybı ve yarım kalmış formlara yol açar |
| **Pattern açıklaması** | Kullanıcı aktif iş akışı içinde (ör. randevu) yeni varlık oluşturur; sistem oluşturulan kaydı otomatik olarak ana forma bağlar |
| **Avantajları** | Akış kesintisiz devam eder; duplicate arama azalır; hızlı operasyonel giriş |
| **Riskleri** | Üst üste modal yığını; minimum alan ile veri kalitesi dengesi; yetki ve duplicate kontrolü |
| **Rakipte gözlenen uygulama** | DaySmart — takvim/randevu akışında Add Client/Patient ([2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)); canlı sandbox: takvim hücresi + Add Patient modal ([sandbox](../competitors/daysmart.md#randevu-i̇çinden-hızlı-hasta-oluşturma)); **Boarding reservation** Add Client/Patient ([Boarding](../competitors/daysmart.md#new-reservation)); **Boarding Check In** inline Item oluşturma — inventory ([Inline Item](../competitors/daysmart.md#inline-item-creation)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Inline oluşturma drawer/stepper ile değerlendirilebilir; takvim hücresinden tarih/saat/kolon tohumu korunmalı; normal CRUD ekranları korunur |
| **Anti-pattern / dikkat** | Modal üstüne modal; uzun formların inline açılması; bağlam geri dönüşünün kırılması |
| **Durum** | Research |

→ [IDEA-009](ideas.md#idea-009--context-preserving-inline-entity-creation) · [APPT-017](../backlog/feature-backlog.md), [APPT-018](../backlog/feature-backlog.md), [APPT-019](../backlog/feature-backlog.md)

---

## PATTERN-008 — Request-to-Confirmation Workflow

| Alan | Değer |
|---|---|
| **ID** | PATTERN-008 |
| **Başlık** | Request-to-Confirmation Workflow |
| **Problem** | Self-service randevu doğrudan kesinleşirse klinik kapasite ve uygunluk kontrolü zayıflar |
| **Pattern açıklaması** | Dış kullanıcı talep oluşturur; klinik inceleme, kabul, red veya yeniden planlama ile kesinleştirir |
| **Avantajları** | Klinik kontrolü korunur; no-show ve uyumsuz slot riski azalır; audit izi oluşur |
| **Riskleri** | Bekleyen kuyruk yönetimi; hasta sahibi beklentisi; pending takvim karmaşası |
| **Rakipte gözlenen uygulama** | DaySmart PetCare — Appointment Request Submitted; Accept/Reject/Reschedule ([2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Online booking talep modeli + review queue değerlendirilebilir; doğrudan onay zorunlu değildir |
| **Anti-pattern / dikkat** | Talebin sessizce kaybolması; red gerekçesiz; pending'in filtresiz takvimi doldurması |
| **Durum** | Research |

→ [IDEA-011](ideas.md#idea-011--appointment-request-review-queue) · [APPT-009](../backlog/feature-backlog.md)–[APPT-011](../backlog/feature-backlog.md)

---

## PATTERN-009 — Availability-Driven Self-Service

| Alan | Değer |
|---|---|
| **ID** | PATTERN-009 |
| **Başlık** | Availability-Driven Self-Service |
| **Problem** | Tüm slotların gösterilmesi uyumsuz talep ve operasyonel yük yaratır |
| **Pattern açıklaması** | Hasta sahibi yalnızca müsait gün ve saatleri görür; müsaitlik kuralları arka planda hesaplanır |
| **Avantajları** | Daha az red; daha iyi hasta sahibi deneyimi; kapasite korunur |
| **Riskleri** | Yanlış müsaitlik kuralları; timezone; kaynak çakışması |
| **Rakipte gözlenen uygulama** | DaySmart online booking — uygun saat seçimi ([2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Randevu nedeni + süre + kaynak eşleştirmesi ile slot üretimi değerlendirilebilir |
| **Anti-pattern / dikkat** | Boş takvim hissi; gizli kurallar; müsaitlik hesabının açıklanmaması |
| **Durum** | Research |

→ [IDEA-012](ideas.md#idea-012--availability-only-booking) · [APPT-008](../backlog/feature-backlog.md)

---

## PATTERN-010 — Event-to-Notification Continuity

| Alan | Değer |
|---|---|
| **ID** | PATTERN-010 |
| **Başlık** | Event-to-Notification Continuity |
| **Problem** | Geçici uyarılar kaybolunca operasyonel olaylar kaçırılır |
| **Pattern açıklaması** | Olay oluştuğunda anlık uyarı + kalıcı bildirim kaydı + rozet; tür bazlı filtreleme |
| **Avantajları** | Hiçbir talep gözden kaçmaz; geçmiş olaylara dönülebilir |
| **Riskleri** | Bildirim yorgunluğu; gerçek zamanlı altyapı maliyeti (teknik çözüm kesinleştirilmemeli) |
| **Rakipte gözlenen uygulama** | DaySmart — online talep sonrası anlık bildirim + bildirim merkezi (sandbox doğrulanmadı); **canlı sandbox — Reminders** operasyonel reminder listesi, Last Sent, bulk resend/export — olay-sonrası iletişim izlenebilirliği paraleli ([Reminders](../competitors/daysmart.md#actions)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Toast + badge + merkez birlikte değerlendirilebilir; randevu dışı operasyonel olaylara genişletilebilir |
| **Anti-pattern / dikkat** | Yalnızca toast; rozet sayacının güncellenmemesi; filtresiz gürültü |
| **Durum** | Research |

→ [IDEA-015](ideas.md#idea-015--real-time-operational-notification-center) · [APPT-015](../backlog/feature-backlog.md)

---

## PATTERN-011 — Template-First Communication

| Alan | Değer |
|---|---|
| **ID** | PATTERN-011 |
| **Başlık** | Template-First Communication |
| **Problem** | Her işlemde açık metin editörü günlük hızı düşürür |
| **Pattern açıklaması** | Onay, red, hatırlatma için şablon varsayılan; önizleme ve isteğe bağlı düzenleme |
| **Avantajları** | Tutarlı iletişim; hız; marka dili korunur |
| **Riskleri** | Şablon bakımı; kişiselleştirme ihtiyacı; çok kanallı senkronizasyon |
| **Rakipte gözlenen uygulama** | DaySmart — hazır onay/red e-postası, hatırlatma günü ([2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)); **canlı sandbox — Boarding** reservation transactional HTML e-posta ([Notification flow](../competitors/daysmart.md#notification-flow)); **canlı sandbox — Reminders** Resend selected, çok kanallı Type (Email/Phone/SMS), relatif Send kuralı ([Reminders](../competitors/daysmart.md#send-kuralı-relatif-reminder-rule)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Randevu oluşturma ve kabul/red akışlarında şablon + önizleme değerlendirilebilir |
| **Anti-pattern / dikkat** | Her seferinde tam WYSIWYG editör; şablon olmadan zorunlu metin girişi |
| **Durum** | Research |

→ [IDEA-013](ideas.md#idea-013--template-based-appointment-communications) · [APPT-012](../backlog/feature-backlog.md)

---

## PATTERN-012 — Configurable Resource Calendar

| Alan | Değer |
|---|---|
| **ID** | PATTERN-012 |
| **Başlık** | Configurable Resource Calendar |
| **Problem** | Tek boyutlu hekim takvimi oda, walk-in ve ekipman planlamasını kapsamaz |
| **Pattern açıklaması** | Takvim kolonları yapılandırılabilir kaynaklara (hekim, oda, walk-in, ekipman) göre düzenlenir |
| **Avantajları** | Gerçek klinik operasyonuna uyum; çakışma görünürlüğü |
| **Riskleri** | UI karmaşıklığı; küçük klinikler için aşırı yapılandırma |
| **Rakipte gözlenen uygulama** | DaySmart — hekim/oda/walk-in kolonları ([2026-08-02](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)); canlı sandbox: hekim + Tech Appts kolonları, All Columns ([sandbox takvim](../competitors/daysmart.md#takvim-ana-görünümü)); **Boarding** oda-kaynak timeline, Max:N kapasite ([Reservation Calendar](../competitors/daysmart.md#reservation-calendar)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Kaynak bazlı takvim P2 adayı; sade varsayılan + isteğe bağlı genişletme değerlendirilebilir |
| **Anti-pattern / dikkat** | Her kaynak için ayrı menü; filtresiz 10+ kolon |
| **Durum** | Research |

→ [IDEA-014](ideas.md#idea-014--configurable-scheduling-resources) · [APPT-025](../backlog/feature-backlog.md)

---

## PATTERN-013 — Portal-to-Clinic Continuity

| Alan | Değer |
|---|---|
| **ID** | PATTERN-013 |
| **Başlık** | Portal-to-Clinic Continuity |
| **Problem** | Hasta sahibi portalı klinik kayıtlarından kopuk kalırsa randevu, hatırlatma ve fatura bilgisi tutarsız olur |
| **Pattern açıklaması** | Portal ana ekranı yaklaşan ziyaretler, hatırlatmalar, açık faturalar ve hayvan kartlarını klinik verisiyle senkron gösterir; ayrı web yüzeyi olsa da veri sürekliliği korunur |
| **Avantajları** | Hasta sahibi self-servis; resepsiyon yükü azalır; bilgi tutarlılığı |
| **Riskleri** | Çok yüzeyli UX; gecikmeli senkron; çok klinik bağlamı |
| **Rakipte gözlenen uygulama** | DaySmart PetCare — Home/Pets/Billing/Vets/Profile navigasyonu ([2026-08-02 bölüm 2](../competitors/daysmart.md#hasta-sahibi-portalı)) |
| **Vetinity'de uygulanabilecek yaklaşım** | v1.0 dışı aday; mobil-öncelikli sade portal değerlendirilebilir |
| **Durum** | Research |

→ [IDEA-017](ideas.md#idea-017--owner-portal-as-operational-extension)

---

## PATTERN-014 — Document-to-Signature Continuity

| Alan | Değer |
|---|---|
| **ID** | PATTERN-014 |
| **Başlık** | Document-to-Signature Continuity |
| **Problem** | Onam ve tahmin belgeleri basılı veya e-posta ile imzalandığında durum takibi zorlaşır |
| **Pattern açıklaması** | Belge listesi → görüntüleme → ekran imzası → durum etiketi (open/approved/paid) sürekliliği |
| **Avantajları** | Dijital süreç; durum görünürlüğü; resepsiyon tasarrufu |
| **Riskleri** | Hukuki geçerlilik; KVKK; sahtecilik |
| **Rakipte gözlenen uygulama** | DaySmart PetCare — consent form, estimate, invoice; imza belgeye işleniyor ([2026-08-02 bölüm 2](../competitors/daysmart.md#belge-ve-dijital-imza)); Draw/Type Signature; Lock Letter ([2026-08-02 bölüm 3](../competitors/daysmart.md#dijital-imza), sandbox observation) |
| **Vetinity'de uygulanabilecek yaklaşım** | v1.0 dışı aday; Türkiye hukuki gereksinimleri ayrı araştırılmalı |
| **Durum** | Research |

→ [IDEA-018](ideas.md#idea-018--consent-and-document-signature-workflow)

---

## PATTERN-015 — Conversation-to-Patient Context

| Alan | Değer |
|---|---|
| **ID** | PATTERN-015 |
| **Başlık** | Conversation-to-Patient Context |
| **Problem** | Mesajlaşma ekranında müşteri/hasta bağlamı görünmezse yanlış yanıt ve tekrarlayan sorular oluşur |
| **Pattern açıklaması** | Inbox konuşması yanında iletişim, adres, bakiye ve hayvan bilgileri panelde görünür; konuşma bir hasta ile ilişkilendirilebilir |
| **Avantajları** | Bağlam korunur; hızlı yanıt; hasta odaklı iletişim |
| **Riskleri** | Panel karmaşıklığı; KVKK; kanal parçalanması |
| **Rakipte gözlenen uygulama** | DaySmart inbox — sağ panel müşteri bağlamı ([2026-08-02 bölüm 2](../competitors/daysmart.md#klinik-inbox-ve-müşteri-i̇letişim-geçmişi)); **Clients Module** Client Profile ([sandbox](../competitors/daysmart.md#client-profile-header)); **Contacts Module** external person/company directory ([sandbox](../competitors/daysmart.md#person-contact-profile)) |
| **Vetinity'de uygulanabilecek yaklaşım** | v1.0 dışı aday; birleşik müşteri iletişim geçmişi ile birlikte değerlendirilebilir |
| **Durum** | Research |

→ [IDEA-019](ideas.md#idea-019--unified-client-communication-timeline)

---

## PATTERN-016 — Check-in as Workflow Orchestrator

| Alan | Değer |
|---|---|
| **ID** | PATTERN-016 |
| **Başlık** | Check-in as Workflow Orchestrator |
| **Problem** | Randevu geldiğinde klinik hazırlık adımları dağınık ekranlarda toplanır |
| **Pattern açıklaması** | Check-in tek adımda şikâyet, vital, form, muayene şablonu, bundle, billing ve notları toplar; tamamlanınca randevu durumu güncellenir ve kayıtlar bağlanır |
| **Avantajları** | Operasyonel hız; tek giriş noktası; randevu–muayene–fatura sürekliliği |
| **Riskleri** | Form aşırı yüklü; undo/check-out yan etkileri |
| **Rakipte gözlenen uygulama** | DaySmart — randevu kartından Check In; Checked In durumu; medical note ve billing bağlantısı ([2026-08-02 bölüm 2](../competitors/daysmart.md#check-in-orkestrasyonu)); ziyaret durumu zinciri Booked → Check Out ([2026-08-02 bölüm 3](../competitors/daysmart.md#ziyaret-durumu-i̇ş-akışı), sandbox observation); **canlı sandbox — Census** ([Census](../competitors/daysmart.md#census-operasyon-kuyruğu)); **Boarding** reservation → Check In sihirbazı ([Check In Wizard](../competitors/daysmart.md#check-in-wizard)) |
| **Vetinity'de uygulanabilecek yaklaşım** | P1 aday; progressive disclosure ile alan seti sınırlandırılabilir |
| **Durum** | Research |

→ [IDEA-020](ideas.md#idea-020--check-in-orchestration) · [CHECKIN-001](../backlog/feature-backlog.md)

---

## PATTERN-017 — Structured Clinical Snippets

| Alan | Değer |
|---|---|
| **ID** | PATTERN-017 |
| **Başlık** | Structured Clinical Snippets |
| **Problem** | Tekrarlayan anamnez soruları her seferinde elle yazılır |
| **Pattern açıklaması** | Tetikleyici (`#`) ile snippet listesi açılır; seçilen snippet yapılandırılmış metni ilgili alana yerleştirir; **AI değildir** |
| **Avantajları** | Hız; tutarlılık; düşük maliyet |
| **Riskleri** | Snippet ile AI karıştırılması; güncel olmayan şablonlar |
| **Rakipte gözlenen uygulama** | DaySmart — `#vomiting` → Subjective alanına soru seti ([2026-08-02 bölüm 2](../competitors/daysmart.md#snippet-ve-sesle-not)) |
| **Vetinity'de uygulanabilecek yaklaşım** | P1 aday; klinik bazlı snippet yönetimi |
| **Durum** | Research |

→ [IDEA-021](ideas.md#idea-021--clinical-snippet-library) · [EXAM-011](../backlog/feature-backlog.md)

---

## PATTERN-018 — Bundle-to-Record Expansion

| Alan | Değer |
|---|---|
| **ID** | PATTERN-018 |
| **Başlık** | Bundle-to-Record Expansion |
| **Problem** | Çok kalemli prosedürler tek tek eklenince hata ve zaman kaybı oluşur |
| **Pattern açıklaması** | Bundle seçimi → kalem dahil/hariç ve miktar düzenleme → kayıt → records ve billing'e otomatik yansıma |
| **Avantajları** | Hız; tutarlı paket uygulama; klinik-finans köprüsü |
| **Riskleri** | Item rule opaklığı; stok senkronizasyonu |
| **Rakipte gözlenen uygulama** | DaySmart — check-in ve medical note'tan bundle; invoice bağlantısı ([2026-08-02 bölüm 2](../competitors/daysmart.md#bundle-ve-doz-hesaplayıcı)); **canlı sandbox — Treatment Board** New Bundle sihirbazı ([Treatment Board](../competitors/daysmart.md#new-bundle-sihirbaz)); **Boarding Check In** bundle seçimi ([Bundle](../competitors/daysmart.md#bundle-check-in-bağlamı)); **Inventory Module** item detail Bundles tab ([inventory-bundles](../competitors/daysmart.md#inventory-bundles)) |
| **Vetinity'de uygulanabilecek yaklaşım** | [EXAM-007](../backlog/feature-backlog.md) genişletmesi |
| **Durum** | Research |

→ [IDEA-023](ideas.md#idea-023--configurable-clinical-bundles)

---

## PATTERN-019 — Auditable Record Actions

| Alan | Değer |
|---|---|
| **ID** | PATTERN-019 |
| **Başlık** | Auditable Record Actions |
| **Problem** | Klinik kayıt değişiklikleri izlenemezse denetim ve güvenlik zayıflar |
| **Pattern açıklaması** | Record satırında edit, duplicate, delete; view changes / audit history; lot, expiry, route, site detayları |
| **Avantajları** | Denetlenebilirlik; klinik güvenlik; itiraz yönetimi |
| **Riskleri** | Audit veri hacmi; retention |
| **Rakipte gözlenen uygulama** | DaySmart — view changes; lot/expiry/route alanları ([2026-08-02 bölüm 2](../competitors/daysmart.md#record-lifecycle-ve-finansal-i̇zlenebilirlik)); **Inventory Module** stock adjustment audit (Current/Actual balance, reason, Created By) — ([inventory-adjustments](../competitors/daysmart.md#inventory-adjustments)) |
| **Vetinity'de uygulanabilecek yaklaşım** | P1 temel audit history; P2 attachment/duplicate |
| **Durum** | Research |

→ [IDEA-025](ideas.md#idea-025--auditable-clinical-record-lifecycle) · [RECORD-002](../backlog/feature-backlog.md)

---

## PATTERN-020 — Unified Record with Dynamic Type Forms

| Alan | Değer |
|---|---|
| **ID** | PATTERN-020 |
| **Başlık** | Unified Record with Dynamic Type Forms |
| **Problem** | Klinik kayıt türleri (aşı, ilaç, prosedür, diagnostik, vital) ayrı modüllerde parçalanırsa model ve UX tutarsızlaşır |
| **Pattern açıklaması** | Tek record entity altında tip metadata ile Vaccine, Medication, Procedure, Diagnostic, Vital ayrımı; tip seçimine göre form alanları dinamik değişir |
| **Avantajları** | Tutarlı veri modeli; ortak lifecycle (audit, finans bağlantısı); tek öğrenme eğrisi |
| **Riskleri** | Metadata şema karmaşıklığı; tip-özel validasyon; aşırı generic form riski |
| **Rakipte gözlenen uygulama** | DaySmart — tek Record kavramı, tip-bazlı dinamik form ([2026-08-02 bölüm 3](../competitors/daysmart.md#birleşik-record-modeli-ve-dinamik-formlar)); **Patients Module** History Records/Pharmacy/Labs/Vaccines/Vitals filtreleri ([sandbox](../competitors/daysmart.md#records)) |
| **Vetinity'de uygulanabilecek yaklaşım** | Generic record + type-specific field sets değerlendirilebilir; ADR gerektirebilir |
| **Durum** | Research |

→ [IDEA-026](ideas.md#idea-026--unified-dynamic-record-model) · [RECORD-006](../backlog/feature-backlog.md)

---

## PATTERN-021 — Item Rule Field Population

| Alan | Değer |
|---|---|
| **ID** | PATTERN-021 |
| **Başlık** | Item Rule Field Population |
| **Problem** | Ürün/kalem seçildiğinde next due, reminder, route, invoice ve stok alanları elle doldurulursa hata ve gecikme oluşur |
| **Pattern açıklaması** | Ürün veya kalem seçiminde "Apply Item Rule" ile yapılandırılmış kurallar ilgili alanları otomatik doldurur |
| **Avantajları** | Hız; tutarlılık; stok-finans-klinik senkronizasyon adayı |
| **Riskleri** | Opak kurallar; yanlış otomatik doldurma; kural bakım yükü |
| **Rakipte gözlenen uygulama** | DaySmart — record oluşturmada Apply Item Rule; next due, reminder, quantity, route, invoice, stok ([2026-08-02 bölüm 3](../competitors/daysmart.md#item-rules), sandbox observation); **Boarding Check In** Apply Item Rule ([Apply Item Rule](../competitors/daysmart.md#apply-item-rule-check-in-bağlamı)); **Reminders Detail** Reminder For = klinik item due-date kayıtları (aşı, lab, follow-up vb.) operasyon listesinde ([Reminders](../competitors/daysmart.md#reminders-detail-ana-tablo)); **Inventory Module** Item Actions tab — usage → create alert/reminder/task, change patient status, print certificate; Low Balance threshold örneği ([inventory-item-actions](../competitors/daysmart.md#inventory-item-actions)) |
| **Vetinity'de uygulanabilecek yaklaşım** | [EXAM-014](../backlog/feature-backlog.md) kapsamında; kural özeti görünür olmalı → [Explainable Assistance](../vision/product-principles.md) |
| **Durum** | Research |

→ [EXAM-014](../backlog/feature-backlog.md)

---

## PATTERN-022 — Clinical Cross-Navigation

| Alan | Değer |
|---|---|
| **ID** | PATTERN-022 |
| **Başlık** | Clinical Cross-Navigation |
| **Problem** | SOAP, record ve invoice arasında geçişte bağlam kaybı ve tekrarlayan arama |
| **Pattern açıklaması** | SOAP ↔ Record ↔ Invoice arasında tek tıkla geçiş; invoice satırları kaynak klinik kalemlerle görünür; hasta geçmişinde record satırından SOAP ve faturaya **çift yönlü** navigasyon |
| **Avantajları** | Bağlam sürekliliği; eksik ücret kontrolü kolaylaşır; operasyonel hız |
| **Riskleri** | Derin link karmaşıklığı; çoklu sekme/pencere davranışı |
| **Rakipte gözlenen uygulama** | DaySmart — SOAP ve Record'tan Invoice; hasta geçmişinde record ↔ SOAP ↔ Invoice ([2026-08-02 bölüm 3](../competitors/daysmart.md#soap--record--invoice-cross-navigation)); **Patients Module** History Invoice + Reference kolonları ([sandbox](../competitors/daysmart.md#records)) |
| **Vetinity'de uygulanabilecek yaklaşım** | [PATTERN-005](#pattern-005--clinical-to-financial-traceability) ile birlikte UX katmanı |
| **Durum** | Research |

→ [IDEA-007](ideas.md#idea-007--clinical-to-financial-traceability) · [RECORD-001](../backlog/feature-backlog.md)

---

## PATTERN-023 — Post-Signature Document Immutability

| Alan | Değer |
|---|---|
| **ID** | PATTERN-023 |
| **Başlık** | Post-Signature Document Immutability |
| **Problem** | İmzalanan belge sonradan değiştirilirse medico-legal bütünlük ve audit güveni zayıflar |
| **Pattern açıklaması** | İmza tamamlandıktan sonra Lock Letter (veya eşdeğeri) ile belge kilitlenir; değişiklik kısıtlanır |
| **Avantajları** | Immutable document; audit integrity; medico-legal koruma adayı |
| **Riskleri** | Yanlış kilitleme; unlock yetki modeli; hukuki geçerlilik (Türkiye doğrulanmadı) |
| **Rakipte gözlenen uygulama** | DaySmart — Lock Letter after sign ([2026-08-02 bölüm 3](../competitors/daysmart.md#lock-letter), sandbox observation) |
| **Vetinity'de uygulanabilecek yaklaşım** | [IDEA-018](ideas.md#idea-018--consent-and-document-signature-workflow) ve [PORTAL-005](../backlog/feature-backlog.md) genişletmesi; v1.0 dışı aday |
| **Durum** | Research |

→ [IDEA-018](ideas.md#idea-018--consent-and-document-signature-workflow) · [PATTERN-014](#pattern-014--document-to-signature-continuity)

---

## PATTERN-024 — Event-to-Document Package

| Alan | Değer |
|---|---|
| **ID** | PATTERN-024 |
| **Başlık** | Event-to-Document Package |
| **Problem** | Ziyaret kapanışında aşı sertifikası, fatura, onam formu ve taburcu özeti ayrı ayrı üretilip gönderildiğinde operasyon yavaşlar ve bağlam kopar |
| **Pattern açıklaması** | Tek operasyonel olay (ör. check-out), birbiriyle ilişkili birden fazla çıktıyı aynı işlem bağlamında üretir ve teslim eder |
| **Avantajları** | Tek adımda kapanış; tutarlı hasta/ziyaret/finans bağlamı; çok kanallı teslim kolaylığı |
| **Riskleri** | Paketleme belgeleri tek değiştirilebilir kayda indirgerse audit zayıflar; yetki/imza/kilitleme kuralları karışabilir |
| **Rakipte gözlenen uygulama** | DaySmart — check-out → aşı sertifikası + ödenmiş fatura + imzalı onam → e-posta/SMS/yazdırma; gözlemlenen akışta ayrıca üç sayfalık tek PDF çıktısı (her durumda tek PDF olduğu doğrulanmadı) ([2026-08-02 ~28:13–35:25](../competitors/daysmart.md#tek-i̇şlemde-belge-paketi-üretimi), sandbox observation) |
| **Vetinity'de uygulanabilecek yaklaşım** | Ziyaret kapanışı, ödeme, reçete, aşı sertifikası, onam, taburcu özeti, lab sonucu, fatura/makbuz. Kurallar: aynı hasta/ziyaret/finans bağlamı; her belgenin bağımsız kimliği ve audit izi; paket yalnızca teslim kolaylığı; yetki/imza/kilitleme ayrı tanımlanır |
| **Durum** | Research |

→ [IDEA-018](ideas.md#idea-018--consent-and-document-signature-workflow) · [IDEA-027](ideas.md#idea-027--checkout-as-visit-completion-orchestrator) · [CHECKOUT-001](../backlog/feature-backlog.md)

---

## İlgili belgeler

- [Research README](README.md)
- [Product Research Ideas](ideas.md)
- [DaySmart Vet analizi](../competitors/daysmart.md)
- [Rakip analizleri](../competitors/README.md)
- [Provet Cloud analizi](../competitors/provet-cloud.md)
