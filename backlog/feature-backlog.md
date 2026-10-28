# Feature Backlog

> Bu belge tüm ürün fikirlerinin ve özellik maddelerinin detaylı kaynağıdır. Önceliklendirilmiş zaman çizelgesi için [roadmap](../roadmap/roadmap.md) kullanılır.

## Durum değerleri

Planlandı · Araştırılacak · Tasarlanacak · Geliştiriliyor · Kısmen geliştirildi (main'de, kapsamın bir kısmı eksik; eksik parantezde) · Geliştirildi (main'de; doğrulanmayan kısım parantezde) · Tamamlandı · Ertelendi

Kod-belge kuralı (WORKFLOW.md): kod main'e alınınca ilgili maddenin Durum satırı aynı commit dalgasında güncellenir. Son toplu senkron: 2026-10-24 kod incelemesi (bkz. roadmap/KOD-INCELEME-2026-10-24.md).

## Kategori kimlikleri

| Önek | Alan |
|---|---|
| TRIAL- | Trial ve onboarding |
| UX- | Kullanıcı deneyimi ve navigasyon |
| REPORT- | Raporlama |
| EXAM- | Muayene deneyimi |
| HOSP- | Hospitalization (yatış) |
| CHECKIN- | Check-in orkestrasyonu |
| SEARCH- | Günlük hasta/sahip arama (resepsiyon) |
| FIN- | Temel ücret, tahsilat ve bakiye (Aşama 3) |
| CHECKOUT- | Ziyaret kapanışı ve tahsilat |
| RECORD- | Klinik kayıt yaşam döngüsü |
| PORTAL- | Hasta sahibi portalı |
| MSG- | Klinik iletişim / inbox |
| TIMELINE- | Hasta timeline |
| IMG- | Görüntüleme |
| AI- | Yapay zeka |
| APPT- | Online booking ve randevu talepleri |
| INT- | Entegrasyonlar |
| MOBILE- | Mobil |
| ENT- | Enterprise |
| SEC- | Güvenlik ve sertleştirme |
| WEB- | Tanıtım sitesi (www) |

---

## TRIAL — Trial ve onboarding

### TRIAL-001 — 14 günlük self-service trial

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-001 |
| **Başlık** | 14 günlük self-service trial |
| **Kategori** | Trial |
| **Problem** | Klasik satış görüşmesi zorunluluğu ürün keşfini yavaşlatıyor |
| **Önerilen çözüm** | Kullanıcı kendi hesabını oluşturup 14 günlük trial başlatabilir |
| **Kullanıcı değeri** | Anında erişim; satış sürtünmesi olmadan değerlendirme |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | TRIAL-004, TRIAL-007 |
| **Notlar** | Canlı demo büyük/kurumsal müşteriler için opsiyonel kalır → [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md). Sürümlü kullanım şartları/hukuki metin kabulü (genel ürün yeteneği) → [IDEA-028](../research/ideas.md#idea-028--versioned-legal-terms-acceptance), [TRIAL-009](#trial-009--sürümlü-kullanım-şartları-ve-hukuki-metin-kabulü)

### TRIAL-002 — Örnek klinik onboarding seçimi

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-002 |
| **Başlık** | Örnek klinik onboarding seçimi |
| **Kategori** | Trial |
| **Problem** | Boş klinikle başlayan kullanıcı ürün değerini geç görür |
| **Önerilen çözüm** | Onboarding'de "Boş klinik" veya "Örnek Veteriner Kliniği" seçeneği; örnek klinik önerilen |
| **Kullanıcı değeri** | İlk 5–10 dakikada anlamlı keşif |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 gece): kayıtta "Nasıl başlayalım?" seçimi (örnek klinik önerilen/varsayılan, boş klinik), başarı ekranında yüklenen içerik kartı, abonelik sayfasında sonradan yükleme kartı; backend owner-signup startWithExampleClinic + POST /tenants/{id}/example-clinic. Tarayıcıda uçtan uca denendi (2026-10-25, kayıt → örnek klinikle panel): ilk denemede Pazar günü Bugün boş ve hastalarda cins/renk eksik çıktı, üretici düzeltildi (backend `6651f1b0`: yükleme günü her zaman randevulu, cins adı + renk) ve yeniden doğrulandı |
| **Bağımlılıklar** | TRIAL-003 |
| **Notlar** | → [ADR-002](../decisions/ADR-002-example-clinic-strategy.md) |

### TRIAL-003 — Örnek klinik sentetik seed verileri

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-003 |
| **Başlık** | Örnek klinik sentetik seed verileri |
| **Kategori** | Trial |
| **Problem** | Demo verisi gerçekçi olmadan ürün değeri anlaşılmaz |
| **Önerilen çözüm** | Müşteri, hayvan, randevu, muayene, aşı, tedavi, lab, ödeme, ürün, stok, rapor, takvim içeren sentetik veri seti |
| **Kullanıcı değeri** | Gerçek bir işletme gibi hissettiren deneyim |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 gece): sentetik örnek klinik seti (12 müşteri, 20 hayvan, ~40 randevu, ~25 muayene, aşı/tedavi/lab, ücret-ödeme, 10 ürün + stok), sabit tohum, ÖRNEK işaretli. **Temizleme (2026-10-26, `feature/example-clinic-cleanup`, main'e alınmadı):** kararlar (kullanıcı onayı, rakip pratiği): örnek müşteri/hastalar ve onlara bağlı her şey kalıcı silinir (kullanıcının örnek kayıtlara eklediği muayene/ödeme dahil), kullanılmış örnek ürün pasife alınır, kendi kayıtları etkilenmez; yetki `Subscriptions.Manage`, deneme ve ücretli abonelikte açık; panelde abonelik sayfasındaki örnek klinik kartı (onay diyaloğunda sayılar). Backend `GET`/`DELETE /tenants/{id}/example-clinic` (sözleşme §10), yeni `appointment.deleted.v1` projeksiyonu, migration yok. Doğrulama: backend build 0/0, Domain 708, Application 3625, entegrasyon 1612 (2 atlandı); frontend lint 0 hata, panel 1895 + portal 119 test, iki build temiz (bütçe uyarısı main ile aynı). Tarayıcıda denendi (2026-10-26, dalın API + paneliyle): kayıt → örnek klinik → abonelik kartında sayılar → onay diyaloğu → kalıcı silme; sonrası müşteri/hasta/randevu/ödeme/ürün listeleri (okuma modelleri dahil) boş, kullanıcının eklediği müşteri kaldı; Vazgeç hiçbir şey silmedi. Kullanılmış ürünün pasife alınması yalnız entegrasyon testinde |
| **Bağımlılıklar** | — |
| **Notlar** | Gerçek müşteri verisi kullanılmaz |

### TRIAL-004 — Trial kısıtlama politikası

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-004 |
| **Başlık** | Trial kısıtlama politikası |
| **Kategori** | Trial |
| **Problem** | Trial'da gerçek dış sistem işlemleri maliyet ve risk oluşturur |
| **Önerilen çözüm** | SMS, e-Fatura, POS, API anahtarı, toplu dışa aktarma ve yüksek maliyetli entegrasyon çağrılarını sınırla |
| **Kullanıcı değeri** | Günlük kullanımın büyük bölümü deneyimlenir; risk kontrol altında |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 gece, karar: Standart): denemede e-posta hatırlatma günde 20, dışa aktarma 1.000 satır, içe aktarma tablo başına 500 satır; 422 Trial.* kodları + kullanıcı mesajı + "Aboneliğe geç"; ücretli kiracıda kısıt yok |
| **Bağımlılıklar** | TRIAL-001 |
| **Notlar** | Kısıtlamalar kullanıcıya açık şekilde gösterilmeli |

### TRIAL-005 — Opsiyonel canlı demo akışı

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-005 |
| **Başlık** | Opsiyonel canlı demo akışı |
| **Kategori** | Trial |
| **Problem** | Büyük klinikler ve kurumsal müşteriler kişiselleştirilmiş demo isteyebilir |
| **Önerilen çözüm** | Self-service trial ana kanal; büyük/kurumsal müşteriler için isteğe bağlı canlı demo |
| **Kullanıcı değeri** | Kurumsal satış sürecinde esneklik |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (feature dalları `feat/trial-005-demo-request`, 2026-10-26; main'e alınınca "main + origin"): İletişim sayfasında herkese açık canlı demo talep formu (20 dk görüntülü görüşme, çok hekimli/şubeli vurgu, ana çağrı deneme) → anonim `POST /public/demo-requests` (doğrulama, tuzak alan, IP başına 10 dakikada 3), `DemoRequests` tablosu, `DemoRequests:NotifyEmail` doluysa outbox e-postası. Bildirim adresi AK-6 ile kullanıcıdan bekleniyor; boşken talepler yalnız DB'de birikir. Panelde liste yok (karar: ilk sürümde yalnız e-posta). Tarayıcıda dev ortamında form → kayıt denendi; e-posta gerçek SMTP ile denenmedi |
| **Bağımlılıklar** | — |
| **Notlar** | Ana edinme kanalı değil. Kararlar (kullanıcı, 2026-10-26): kapsam form + uç + e-posta; 20 dk görüntülü görüşme vaadi; herkese açık, çok şube vurgulu. Sözleşme backend `docs/TRIAL_DEMO_REQUEST_API_CONTRACT.md` (§7 kapsam dışı: panel listesi, takvim entegrasyonu, onay e-postası, saklama süresi) |

### TRIAL-006 — Trial kullanım kotası

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-006 |
| **Başlık** | Trial kullanım kotası |
| **Kategori** | Trial |
| **Problem** | Sınırsız trial kötüye kullanıma açık |
| **Önerilen çözüm** | Makul kullanım limitleri (kayıt sayısı, depolama vb.) tanımla |
| **Kullanıcı değeri** | Adil kullanım; platform sürdürülebilirliği |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TRIAL-001 |
| **Notlar** | Limitler günlük klinik deneyimini engellememeli |

### TRIAL-007 — Trial'dan ücretli plana dönüşüm

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-007 |
| **Başlık** | Trial'dan ücretli plana dönüşüm |
| **Kategori** | Trial |
| **Problem** | Trial bitiminde kullanıcı kaybedilebilir |
| **Önerilen çözüm** | Sorunsuz plan yükseltme akışı; veri kaybı olmadan geçiş |
| **Kullanıcı değeri** | Kesintisiz devam |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; gerçek sağlayıcıyla uçtan uca doğrulanmadı) |
| **Bağımlılıklar** | TRIAL-001, abonelik modülü |
| **Notlar** | Dönüşüm metrikleri tanımlanacak |

### TRIAL-008 — Trial aktivasyon ölçümleri

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-008 |
| **Başlık** | Trial aktivasyon ölçümleri |
| **Kategori** | Trial |
| **Problem** | Trial başarısı ölçülemeden optimize edilemez |
| **Önerilen çözüm** | Trial başlatma, örnek klinik seçimi, ilk 10 dk aksiyon, aktivasyon, dönüşüm metrikleri |
| **Kullanıcı değeri** | Ürün ekibi veri odaklı karar alır |
| **Öncelik** | P1 (roadmap 2026-10-09, ADR-001/002: P0 → P1; etiket 2026-10-24 düzeltildi) |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-25): `GET /admin/trial-metrics` (platform yöneticisi) kohort özeti — deneme başlatan, örnek klinik seçme oranı, aktivasyon, ilk 10 dk aktivasyon, ilk değer anına medyan süre, ücretli dönüşüm, ilk aksiyon dağılımı, örnek/boş klinik karşılaştırması; 9 komutta `IActivationSignalRequest` + `ActivationSignalBehavior` → `TenantActivations` (ilk aksiyon bir kez), örnek klinik yüklemesi işaretlenir; panelde "Deneme ölçümleri" sayfası (Satış ortaklarının yanında, 7/30/90 gün). Ziyaretçi→deneme oranı ve günlük zaman serisi yok (sözleşme §7). Tarayıcıda denenmedi (platform yöneticisi girişi kullanıcıda); migration yalnız test DB'de |
| **Bağımlılıklar** | TRIAL-001, TRIAL-002 |
| **Notlar** | → [Release plan](../roadmap/release-plan.md) metrikleri |

### TRIAL-009 — Sürümlü kullanım şartları ve hukuki metin kabulü

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-009 |
| **Başlık** | Sürümlü kullanım şartları ve hukuki metin kabulü |
| **Kategori** | Trial |
| **Problem** | Kullanım şartları veya hukuki metinler güncellendiğinde kabul kaydı, sürüm izi ve yeniden kabul gereksinimi yoksa hukuki/operasyonel risk oluşur |
| **Önerilen çözüm** | Genel ürün yeteneği: sürümlü ToS/hukuki metin kabulü; kullanıcı veya tenant bağlamı; kabul zamanı; metin sürümü; audit kaydı; yeniden kabul gerektiren güncellemeler için zorunlu akış |
| **Kullanıcı değeri** | Uyumluluk; şeffaf onboarding ve hesap erişimi |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Uygulandı (2026-10-16, ADR-029; metinler taslak, hukuki onay bekliyor) |
| **Bağımlılıklar** | TRIAL-001 |
| **Notlar** | Trial/onboarding girişinde de uygulanır; yalnızca trial'a özgü değildir. DaySmart sandbox gözlemi (giriş akışı) — tenant/kullanıcı kapsamı ve audit **doğrulanmadı** → [IDEA-028](../research/ideas.md#idea-028--versioned-legal-terms-acceptance) |

---

## REPORT — Raporlama

### REPORT-001 — Rapor Merkezi

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-001 |
| **Başlık** | Rapor Merkezi |
| **Kategori** | Rapor |
| **Problem** | Her rapor sidebar'da ayrı menü öğesi oluşturuyor |
| **Önerilen çözüm** | Sidebar'da tek "Raporlar"; `/panel/reports` Rapor Merkezi; iç navigasyon |
| **Kullanıcı değeri** | Merkezi rapor keşfi; sidebar sade kalır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | — |
| **Notlar** | → [ADR-003](../decisions/ADR-003-report-center.md). **Clients Module:** Client Dashboard analytics P3. **Contacts Module:** Contact Dashboard analytics P3 — → [daysmart.md](../competitors/daysmart.md#contact-dashboard--contact-list). **Reports Module:** Reports Dashboard KPIs (Active Patients/Clients/Appointments); 9 category predefined catalog — → [daysmart.md](../competitors/daysmart.md#reports-dashboard) |

### REPORT-002 — Rapor kategorileri

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-002 |
| **Başlık** | Rapor kategorileri |
| **Kategori** | Rapor |
| **Problem** | Raporlar arasında gezinme zor |
| **Önerilen çözüm** | Rapor Merkezi içinde kategori, kart veya sekme yapısı |
| **Kullanıcı değeri** | Hızlı rapor bulma |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Ödeme, randevu, muayene, aşı raporları kategoriler altında. **Reports Module:** DaySmart 9 category catalog (Schedule, Patients, Clients, Communications, Contacts, Inventory, Billing, Staff, Wellness Plan) — predefined reports not generic builder — → [daysmart.md](../competitors/daysmart.md#reports-dashboard). **E-Vet SMART (2026-09-29):** Üst menü **Rapor** altında kategorize predefined report catalog — Genel, Randevu, Resmi, Depo, Finansal (+ Rapor Özellikleri layout/print config); custom report builder gözlemlenmedi — → [e-vet.md](../competitors/e-vet.md#rapor) |

### REPORT-003 — Rapor favorileri

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-003 |
| **Başlık** | Rapor favorileri |
| **Kategori** | Rapor |
| **Problem** | Sık kullanılan raporlara hızlı erişim yok |
| **Önerilen çözüm** | Kullanıcı raporları favorilere ekleyebilir |
| **Kullanıcı değeri** | 2–3 etkileşimde sık raporlara ulaşım |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek |

### REPORT-004 — Kaydedilmiş rapor filtreleri

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-004 |
| **Başlık** | Kaydedilmiş rapor filtreleri |
| **Kategori** | Rapor |
| **Problem** | Aynı filtreler her seferinde yeniden uygulanıyor |
| **Önerilen çözüm** | Filtre kombinasyonlarını kaydet ve yeniden kullan |
| **Kullanıcı değeri** | Tekrarlayan raporlama iş yükü azalır |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek |

### REPORT-005 — Ortak rapor filtre çubuğu

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-005 |
| **Başlık** | Ortak rapor filtre çubuğu |
| **Kategori** | Rapor |
| **Problem** | Her raporda farklı filtre UX'i |
| **Önerilen çözüm** | Rapor Merkezi genelinde tutarlı filtre bileşeni |
| **Kullanıcı değeri** | Öğrenme eğrisi düşer |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek. **Reports Module:** As Of, range period, location, provider/staff, date range — report-specific subset — → [daysmart.md](../competitors/daysmart.md#reports-shared-behavior). **E-Vet SMART (2026-09-29):** Rapor ekranlarında sol report-specific filtre paneli + sağ print-oriented report preview shell; filtre seti rapora göre değişiyor — → [e-vet.md](../competitors/e-vet.md#shared-report-presentation-shell) |

### REPORT-006 — Claim bazlı rapor görünürlüğü

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-006 |
| **Başlık** | Claim bazlı rapor görünürlüğü |
| **Kategori** | Rapor |
| **Problem** | Kullanıcı yetkisi olmayan raporlar görünüyor |
| **Önerilen çözüm** | Operation claim'e göre rapor görünürlüğü |
| **Kullanıcı değeri** | Güvenli ve sade arayüz |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; uç başına yetki ayrıntısı doğrulanmadı) |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek. **E-Vet SMART (2026-09-29):** **Laboratuvar Test Sayısı Raporu** menüde görünür; reviewed account navigasyon sonrası **403** — page/report-level access enforcement observed; exact role/permission model ve permission administration UI **not verified**. Depo altındaki dört rapor için kullanıcı erişim engelini doğruladı; ayrı 403 ekranı gözlemlenmedi — → [e-vet.md](../competitors/e-vet.md#rapor--open--access-limited-items) |

### REPORT-007 — Excel/PDF dışa aktarma politikası

| Alan | Değer |
|---|---|
| **Kimlik** | REPORT-007 |
| **Başlık** | Excel/PDF dışa aktarma politikası |
| **Kategori** | Rapor |
| **Problem** | Rapor dışa aktarma ihtiyacı var; trial'da kısıtlanabilir |
| **Önerilen çözüm** | Excel ve PDF dışa aktarma; trial'da toplu dışa aktarma kısıtı |
| **Kullanıcı değeri** | Ofis dışı rapor paylaşımı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): CSV/Excel var; gerçek PDF üretimi ve deneme sürümünde dışa aktarma kısıtı yok |
| **Bağımlılıklar** | REPORT-001, TRIAL-004 |
| **Notlar** | Gelecekte değerlendirilecek. **Reports Module:** Export observed across reports; exact format per report **doğrulanmadı** — → [daysmart.md](../competitors/daysmart.md#reports-shared-behavior). **E-Vet SMART:** Hesap ekstresi / müşteri-hasta hareketleri PDF+yazdır — → [e-vet.md](../competitors/e-vet.md#ekstreler--finansal-hareketler). **E-Vet SMART (2026-09-29):** Rapor ekranlarında shared shell — print-oriented preview + **Pdf** dropdown + download-like action + **Yazdır...**; Excel/CSV support not observed — → [e-vet.md](../competitors/e-vet.md#shared-report-presentation-shell) |

---

## UX — Kullanıcı deneyimi

### UX-001 — Sidebar sadeleştirme

| Alan | Değer |
|---|---|
| **Kimlik** | UX-001 |
| **Başlık** | Sidebar sadeleştirme |
| **Kategori** | UX |
| **Problem** | Sidebar zamanla şişiyor; tanım ekranları ana menüde |
| **Önerilen çözüm** | Günlük operasyon dışı tanımları Ayarlar altına taşı; menü grupları netleştir |
| **Kullanıcı değeri** | Daha az bilişsel yük |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | → [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md). **Platform Module:** Global Quick Create top bar — → [daysmart.md](../competitors/daysmart.md#platform-quick-create) |

### UX-002 — Ayarlar > Tanımlar merkezi

| Alan | Değer |
|---|---|
| **Kimlik** | UX-002 |
| **Başlık** | Ayarlar > Tanımlar merkezi |
| **Kategori** | UX |
| **Problem** | Türler, ırklar, ürün kategorileri sidebar'ı kalabalıklaştırıyor |
| **Önerilen çözüm** | Ayarlar > Tanımlar altında topla |
| **Kullanıcı değeri** | Ana menü sade kalır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | UX-003, UX-004, UX-005 |
| **Notlar** | Kabul edilmiş hedef; henüz uygulanmadı. **DaySmart (observed):** Settings ≠ tek key/value tablosu; searchable List of Configurations (Option/Value/Description). **Vetinity (implication):** Tanımlar merkezi domain ownership ile büyümeli; policy registry searchable + discoverable olmalı — alfabetik dev tablo UX hedefi değil. → [daysmart.md](../competitors/daysmart.md#config-list), [daysmart.md](../competitors/daysmart.md#sandbox--settings--configuration) |

### UX-003 — Türlerin Tanımlar altına alınması

| Alan | Değer |
|---|---|
| **Kimlik** | UX-003 |
| **Başlık** | Türlerin Tanımlar altına alınması |
| **Kategori** | UX |
| **Problem** | Türler günlük ana operasyon değil |
| **Önerilen çözüm** | Ayarlar > Tanımlar > Türler |
| **Kullanıcı değeri** | Sidebar sadeleşir |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı |

### UX-004 — Irkların Tanımlar altına alınması

| Alan | Değer |
|---|---|
| **Kimlik** | UX-004 |
| **Başlık** | Irkların Tanımlar altına alınması |
| **Kategori** | UX |
| **Problem** | Irklar günlük ana operasyon değil |
| **Önerilen çözüm** | Ayarlar > Tanımlar > Irklar |
| **Kullanıcı değeri** | Sidebar sadeleşir |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı. DaySmart sandbox: breed aramada tür/grup etiketi birlikte; Vetinity species + breed ayrı model korunmalı |

### UX-005 — Ürün kategorilerinin Tanımlar altına alınması

| Alan | Değer |
|---|---|
| **Kimlik** | UX-005 |
| **Başlık** | Ürün kategorilerinin Tanımlar altına alınması |
| **Kategori** | UX |
| **Problem** | Ürün kategorileri sidebar'ı kalabalıklaştırıyor |
| **Önerilen çözüm** | Ayarlar > Tanımlar > Ürün Kategorileri |
| **Kullanıcı değeri** | Sidebar sadeleşir |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı |

### UX-006 — Global search ve recent navigation

| Alan | Değer |
|---|---|
| **Kimlik** | UX-006 |
| **Başlık** | Global search ve recent navigation |
| **Kategori** | UX |
| **Problem** | Modüller arası geçiş ve entity bulma yavaş; hasta/müşteri araması günlük operasyonu yavaşlatır |
| **Önerilen çözüm** | Persistent global search yüzeyi; entity-aware sonuç gruplama/filtreleme; Recently Viewed; arama sonucundan doğrudan navigation |
| **Kullanıcı değeri** | Navigation maliyeti düşer; sık kullanılan kayıtlara hızlı dönüş |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): global arama (Ctrl/Cmd+K) var; "son görüntülenenler" yok |
| **Bağımlılıklar** | UX-001 |
| **Notlar** | **DaySmart (observed):** kategori ör. Schedule/Patients/Clients/Contacts/Inventory/Billing; Patient All/Name/Chip/Tag; Recently Viewed cross-entity; `LastName, FirstName` tam sorgu fail / partial success — → [daysmart.md](../competitors/daysmart.md#sandbox--global-search). **Vetinity (implication):** toleranslı kişi araması — ad-soyad sırası, soyad-ad, `Soyad, Ad`, partial, fazla/eksik boşluk, TR karakter, case-insensitive. → [PATTERN-025](../research/patterns.md#pattern-025--global-search-and-recent-navigation) |

### UX-007 — Rol bazlı ayrı menüler

| Alan | Değer |
|---|---|
| **Kimlik** | UX-007 |
| **Başlık** | Rol bazlı ayrı menüler (Resepsiyon / Hekim / Yönetici) |
| **Kategori** | UX |
| **Problem** | Aşama 8 menüsü izne göre süzülür ama her rol aynı grup yapısını görür; pilotta rol bazlı sadeleştirme ihtiyacı çıkabilir |
| **Önerilen çözüm** | Rol başına özel menü düzeni (grup sırası, varsayılan sayfa, kısayollar); izin altyapısı değişmeden üstüne ince bir katman |
| **Kullanıcı değeri** | Her kullanıcı yalnız kendi günlük işini görür; öğrenme maliyeti düşer |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Ertelendi (kullanıcı kararı 2026-10-13: önce izne göre süzülen 6 gruplu menü) |
| **Bağımlılıklar** | Aşama 8 Dilim 1 (menü ve gezinti kaydı) |
| **Notlar** | Pilot klinikte gerçek kullanıcı geri bildirimi gelmeden yapılmaz; keşif `docs/ASAMA8_DISCOVERY.md` D-M1 seçenek c |

### UX-008 — Kişiye özel bildirimler ve onay akışı (kalıcı bildirim modeli)

| Alan | Değer |
|---|---|
| **Kimlik** | UX-008 |
| **Başlık** | Kişiye özel bildirimler ve onay akışı |
| **Kategori** | UX |
| **Problem** | Açık işler ilk sürümde kaynak kayıtlardan hesaplanan liste olacak; kişiye özel olaylar (örn. kesinleşmiş muayeneye sonradan eklenen uygulama, atanan görev) bu modelle iletilemez |
| **Önerilen çözüm** | Kalıcı bildirim modeli (kime, olay, okundu/çözüldü); ilk kullanım: sonradan eklenen kayıtlar için muayene hekimine bildirim ve opsiyonel onay ([ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md)); topbar zil |
| **Kullanıcı değeri** | Hekim kendi hastasındaki sonradan değişiklikten haberdar olur; denetim izi iş akışına dönüşür |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin: backend model + migration + frontend; ölçülmedi) |
| **Durum** | Ertelendi (kullanıcı kararı 2026-10-13: açık işler önce hesaplanan liste) |
| **Bağımlılıklar** | Aşama 8 açık işler (hesaplanan liste); ADR-013 uygulaması |
| **Notlar** | Hesaplanan listeyle çelişmemesi için yalnız olay tabanlı/kişiye atanan işler bu modele girer; keşif `docs/ASAMA8_DISCOVERY.md` D-N1, D-N2 |

### UX-009 — Menü görünümünün son hali (satırlar netleşince)

| Alan | Değer |
|---|---|
| **Kimlik** | UX-009 |
| **Başlık** | Menü görünümü tekrar düzeltilecek (şu anki hali nihai değil) |
| **Kategori** | UX |
| **Problem** | Menü seçenek A (tek kenar çubuğu, sabit simge sütunu, etiketler sağa açılır) geçici olarak kabul edildi. Menü satırları (sayfalar ve gruplar) henüz netleşmedi; simge ağırlığı, şerit genişliği ve kapalı durumda grup adlarının anlaşılması açık |
| **Önerilen çözüm** | Menü satırları netleşince görünümü yeniden gözden geçir: simge boyutu/ağırlığı, şerit genişliği (şu an 80 px), kapalı durumda grup ayrımı (renk veya kısa etiket), satır aralıkları |
| **Kullanıcı değeri** | Kalıcı, tutarlı ve rahat okunan menü |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Planlandı (kullanıcı kararı 2026-10-13: "şu an nihai hali değil, menü satırları netleşince tekrar düzeltilecek") |
| **Bağımlılıklar** | Menü satırlarının (sayfa ve grup listesi) kesinleşmesi |
| **Notlar** | Frontend dalı `feature/menu-secenek-a`; kapalı şerit grup adı kaybı ve simge ağırlığı gözlemleri 2026-10-13 ekran görüntülerinden |

---

## EXAM — Muayene deneyimi

### EXAM-001 — Modern muayene çalışma alanı

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-001 |
| **Başlık** | Modern muayene çalışma alanı |
| **Kategori** | Muayene |
| **Problem** | Muayene Vetinity'nin en kritik alanı; mevcut deneyim yeterince birleşik değil |
| **Önerilen çözüm** | Tam sayfa veya geniş çalışma alanı; hasta bağlamı korunur |
| **Kullanıcı değeri** | Tek ekranda klinik akış |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-002–005 |
| **Notlar** | **Dilim 1 kabul edildi (2026-10-10, kullanıcı kararı); kod `feature/muayene-dilim1` dalında, main'e merge/deploy bekliyor — "Tamamlandı" değil.** Gerçek Draft/Finalized ve revizyon Aşama 4'te. Kalan doğrulamalar: [AJAN-KUYRUGU](../roadmap/AJAN-KUYRUGU.md). → [ADR-005](../decisions/ADR-005-modern-examination-experience.md). DaySmart (2026-08-02 bölüm 2): üst bağlam bandı, SOAP bölümleri, sistematik muayene, lock — sandbox doğrulanmadı |

### EXAM-002 — Şikâyet ve anamnez bölümü

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-002 |
| **Başlık** | Şikâyet ve anamnez bölümü |
| **Kategori** | Muayene |
| **Problem** | SOAP Subjective karşılığı Türkçe terminolojiyle sunulmalı |
| **Önerilen çözüm** | Şikâyet ve anamnez alanı |
| **Kullanıcı değeri** | Doğal veteriner dili |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Dilim 1 EXAM-001 ile kabul edildi (2026-10-10); merge/deploy bekliyor |

### EXAM-003 — Klinik bulgular ve vital değerler

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-003 |
| **Başlık** | Klinik bulgular ve vital değerler |
| **Kategori** | Muayene |
| **Problem** | Objective bulgular yapılandırılmış alanlarda tutulmalı |
| **Önerilen çözüm** | Klinik bulgular bölümü; vital değer girişi |
| **Kullanıcı değeri** | Standart kayıt; raporlama kolaylığı |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Dilim 1 kabul edildi (2026-10-10); merge/deploy bekliyor. Vitaller opsiyonel, kısmi güncellemede null=dokunma, `clearVitals` ile toptan temizleme. DaySmart sandbox — Treatment Board vital özet; **Patients Module** Overview snapshot (Weight, Temp, HR, RR) + Vitals History (Reference: SOAP) → [daysmart.md](../competitors/daysmart.md#patient-profile--header--overview) |

### EXAM-004 — Değerlendirme / tanı alanı

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-004 |
| **Başlık** | Değerlendirme / tanı alanı |
| **Kategori** | Muayene |
| **Problem** | Assessment karşılığı Türkçe sunulmalı |
| **Önerilen çözüm** | Değerlendirme / tanı alanı |
| **Kullanıcı değeri** | Klinik karar kaydı |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Dilim 1 kabul edildi (2026-10-10); merge/deploy bekliyor. **Canlı sandbox — Patients Module:** Open Diagnoses (Overview); Custom Diagnoses clinic catalog ≠ patient diagnosis — hybrid catalog + free text adayı → [daysmart.md](../competitors/daysmart.md#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics) |

### EXAM-005 — Tedavi planı

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-005 |
| **Başlık** | Tedavi planı |
| **Kategori** | Muayene |
| **Problem** | Plan bölümü muayene akışına entegre olmalı |
| **Önerilen çözüm** | Plan / tedavi planı alanı |
| **Kullanıcı değeri** | Muayeneden tedaviye kesintisiz geçiş |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Dilim 1 kabul edildi (2026-10-10); merge/deploy bekliyor. Plan alanı eklendi; tedavi/reçete/stok bağlantısı Aşama 5'te |

### EXAM-006 — Muayene şablonları

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-006 |
| **Başlık** | Muayene şablonları |
| **Kategori** | Muayene |
| **Problem** | Tekrarlayan muayene tipleri her seferinde sıfırdan yazılıyor |
| **Önerilen çözüm** | Önceden tanımlı muayene şablonları |
| **Kullanıcı değeri** | Hız; tutarlılık |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Stratejik hedef. **Settings/Templates Module:** Medical Note Templates — structured builder (Section→Group→Field); SOAP + Holistic + Client Communication; field types (numeric+unit, controlled score, multi-select); system-bound components (Diagnoses) — → [daysmart.md](../competitors/daysmart.md#templates-medical-notes). Template definition ≠ completed note — → [daysmart.md](../competitors/daysmart.md#templates-vs-runtime) |

### EXAM-007 — Tedavi bundle/paketleri

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-007 |
| **Başlık** | Tedavi bundle/paketleri |
| **Kategori** | Muayene |
| **Problem** | Sık uygulanan tedavi kombinasyonları tek tek ekleniyor |
| **Önerilen çözüm** | Hazır tedavi paketleri |
| **Kullanıcı değeri** | Hızlı uygulama |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | DaySmart (2026-08-02 bölüm 2): check-in ve medical note'tan seçim. **Templates Module:** Bundle Items/Activities/Actions üç katman; quantity/price ranges; clinical activity ≠ billable item; Bundle Action ≠ Form Logic — → [daysmart.md](../competitors/daysmart.md#templates-bundles). **Inventory/Boarding/Treatment Board** cross-ref korunur — → [daysmart.md](../competitors/daysmart.md#inventory-bundles), [daysmart.md](../competitors/daysmart.md#new-bundle-sihirbaz) |

### EXAM-008 — Doz hesaplayıcı

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-008 |
| **Başlık** | Doz hesaplayıcı |
| **Kategori** | Muayene |
| **Problem** | Manuel doz hesabı hata riski taşır |
| **Önerilen çözüm** | Muayene/tedavi akışına gömülü doz hesaplayıcı |
| **Kullanıcı değeri** | Güvenlik; hız |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | AI bağımsız doz kararı vermez; klinik karar hekimde kalır. DaySmart (2026-08-02 bölüm 2): kg, mg/kg, konsantrasyon, toplam doz/hacim — sandbox doğrulanmadı. P3 / araştırılacak aday olarak da değerlendirilebilir → [IDEA-024](../research/ideas.md#idea-024--embedded-dosage-support) |

### EXAM-009 — Kalıcı alerji ve dikkat uyarıları

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-009 |
| **Başlık** | Kalıcı alerji ve dikkat uyarıları |
| **Kategori** | Muayene |
| **Problem** | Kritik hasta bilgileri muayene sırasında kaybolabiliyor |
| **Önerilen çözüm** | Hayvan profilinde kalıcı uyarı paneli; muayenede görünür |
| **Kullanıcı değeri** | Klinik güvenlik |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | DaySmart uyarı panelinden ilham. **Patients Module:** Attention panel; Notes Priority. **Clients Module:** Client Notes (Profile Only, Pop-up) — clinical SOAP **değil** — → [daysmart.md](../competitors/daysmart.md#client-notes) |

### EXAM-010 — Muayene sırasında hızlı lab/reçete/görüntüleme bağlantısı

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-010 |
| **Başlık** | Muayene sırasında hızlı lab/reçete/görüntüleme bağlantısı |
| **Kategori** | Muayene |
| **Problem** | İlişkili kayıtlar kopuk ekranlarda |
| **Önerilen çözüm** | Muayene çalışma alanından lab, reçete, görüntüleme hızlı erişim |
| **Kullanıcı değeri** | Bağlam korunur |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): bağlı kayıt listeleri ve görüntüleme ekle var; lab/reçete hızlı oluşturma bağlantısı doğrulanmadı |
| **Bağımlılıklar** | EXAM-001, IMG-001 |
| **Notlar** | |

### EXAM-011 — Klinik snippet sistemi

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-011 |
| **Başlık** | Klinik snippet sistemi |
| **Kategori** | Muayene |
| **Problem** | Tekrarlayan anamnez soru setleri her muayenede elle yazılıyor |
| **Önerilen çözüm** | `#` tetiklemeli snippet listesi; seçilen snippet yapılandırılmış metni ilgili alana yerleştirir |
| **Kullanıcı değeri** | Hızlı yapılandırılmış veri girişi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-002 |
| **Notlar** | **AI değildir**. **Templates Module:** Snippets template catalog + hashtag/shortcut — Settings > Templates > Snippets — → [daysmart.md](../competitors/daysmart.md#templates-letters-snippets-attachments) |

### EXAM-012 — Klinik bazlı snippet yönetimi

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-012 |
| **Başlık** | Klinik bazlı snippet yönetimi |
| **Kategori** | Muayene |
| **Problem** | Snippet'lar merkezi yönetilmezse tutarsızlık oluşur |
| **Önerilen çözüm** | Klinik ayarlarında snippet oluşturma, düzenleme, paylaşım |
| **Kullanıcı değeri** | Tutarlı anamnez ve bulgu girişi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-011 |
| **Notlar** | Yönetim ekranı sandbox'ta doğrulanmadı |

### EXAM-013 — Bundle kalem seçimi ve miktar düzenleme

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-013 |
| **Başlık** | Bundle kalem seçimi ve miktar düzenleme |
| **Kategori** | Muayene |
| **Problem** | Paket içindeki tüm kalemler her vakada uygulanmayabilir |
| **Önerilen çözüm** | Bundle kalemlerini dahil/hariç bırakma ve miktar düzenleme |
| **Kullanıcı değeri** | Esnek paket uygulama |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-007 |
| **Notlar** | DaySmart gözlemi — sandbox doğrulanmadı. **Templates Module:** Bundle Items — dahil/hariç, quantity/price range (ör. 1–2 Tablets, $50–100) — → [daysmart.md](../competitors/daysmart.md#templates-bundles) |

### EXAM-014 — Item rules (bundle ve record oluşturma)

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-014 |
| **Başlık** | Item rules (bundle ve record oluşturma) |
| **Kategori** | Muayene |
| **Problem** | Ürün/kalem seçildiğinde next due, reminder, route, invoice ve stok alanları manuel dolduruluyor; bundle kalemlerinde otomatik kurallar yönetilemiyor |
| **Önerilen çözüm** | "Apply Item Rule" benzeri yapılandırılabilir kural; ürün seçiminde alan otomatik doldurma |
| **Kullanıcı değeri** | Tutarlı uygulama; hız; stok-finans-klinik senkronizasyon adayı |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-013, RECORD-006 |
| **Notlar** | DaySmart sandbox observation (2026-08-02 bölüm 3): record oluşturmada Apply Item Rule; next due, reminder, quantity, route, invoice, stok. Kural motoru doğrulanmadı → [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population). **Inventory Module** Item Actions; Rules (species/weight/age). **Templates Module:** Bundle Actions (Create form/reminder/task, Change patient status, Print certificate vb.); When Using item binding; **Bundle Action ≠ Form Logic** — → [daysmart.md](../competitors/daysmart.md#templates-bundles), [daysmart.md](../competitors/daysmart.md#inventory-item-actions) |

### EXAM-015 — Medical note lock

| Alan | Değer |
|---|---|
| **Kimlik** | EXAM-015 |
| **Başlık** | Medical note lock |
| **Kategori** | Muayene |
| **Problem** | Eşzamanlı düzenleme klinik not tutarsızlığına yol açabilir |
| **Önerilen çözüm** | Muayene notunu kilitleme; yetkili kullanıcı unlock |
| **Kullanıcı değeri** | Kayıt bütünlüğü |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): kesinleştirme kilidi ve ek not var; kilit açma yok (ADR-013 bilinçli) |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | DaySmart lock aksiyonu gözlemlendi — sandbox doğrulanmadı. **Patients Module:** Medical Notes History lock icon — finalized anlamı **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#medical-notes). **DaySmart (observed):** Lock Medical Notes clinic policy — → [daysmart.md](../competitors/daysmart.md#config-lock-medical-notes). **Vetinity (implication):** Draft → Finalized/Locked → audit-safe correction/addendum; DaySmart irreversible auto-lock otomatik requirement değil — → [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions) |

---

## HOSP — Hospitalization (Yatış)

> **Kaynak:** [v1-release-scope](../roadmap/v1-release-scope.md) (Release Blocker #14), [ux/navigation](../ux/navigation.md) (Yatışlar), [design-decisions](../ux/design-decisions.md) (Yatış ≠ pansiyon). Pansiyon/boarding kapsam dışı.

### HOSP-001 — Yatış yaşam döngüsü ve aktif yatışlar

| Alan | Değer |
|---|---|
| **Kimlik** | HOSP-001 |
| **Başlık** | Yatış yaşam döngüsü ve aktif yatışlar |
| **Kategori** | Hospitalization |
| **Problem** | Tıbbi yatış (hospitalization) kaydı oluşturulamıyor; klinikte aktif yatan hastalar operasyonel olarak görülemiyor |
| **Önerilen çözüm** | Hasta için yatış kaydı: kabul/başlangıç → aktif yatış → taburcu/çıkış; hasta, giriş/çıkış zamanı, durum. Sidebar **Yatışlar** modülünde aktif yatış listesi; satırdan hasta/yatış bağlamına geçiş |
| **Kullanıcı değeri** | v1 yatış modülü; resepsiyon/hekim operasyon görünürlüğü |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | — |
| **Notlar** | v1 Release Blocker → [v1-release-scope](../roadmap/v1-release-scope.md). Navigasyon → [ux/navigation.md](../ux/navigation.md). Raporlama: ayrı HOSP rapor epic değil; yatış verisi [REPORT-001](#report-001--rapor-merkezi) / [REPORT-002](#report-002--rapor-kategorileri) üzerinden erişilebilir olmalı (aktif/geçmiş yatış listesi — detay TBD). **TBD (v1 dışı / future):** medication administration, nursing sheet, treatment schedule gibi inpatient alt workflow'lar. **Competitor evidence (requirement değil):** E-Vet global Hospitalizasyonlar + hasta Hospitalizasyon Geçmişi — → [e-vet.md](../competitors/e-vet.md#global-hospitalizasyon-modül) · [geçmiş](../competitors/e-vet.md#hospitalizasyon-geçmişi) (2026-10-04 pass; scope değişmedi) |

### HOSP-002 — Yatış konum ataması

| Alan | Değer |
|---|---|
| **Kimlik** | HOSP-002 |
| **Başlık** | Yatış konum ataması |
| **Kategori** | Hospitalization |
| **Problem** | Aktif yatışın klinik içi yeri (bölüm/oda) takip edilemiyor |
| **Önerilen çözüm** | Yatış kaydına klinik tanımlı konum bağlantısı; minimum abstraction: bölüm/alan + oda veya klinik tarafından tanımlanan yatış konumu. Kaynak hiyerarşisi (oda/kafes/locate) **TBD** |
| **Kullanıcı değeri** | Yatış operasyonu; ekip koordinasyonu |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 gece): iki seviyeli Bölüm → Oda tanımları (Ayarlar > Tanımlar > Yatış konumları, klinik bazlı, pasife alma), yatış formunda oda seçimi, liste/detayda "Bölüm / Oda"; kapasite/çakışma yok (karar). Tarayıcıda denendi (2026-10-25): bölüm ve oda tanımı oluşturma, yatış formunda Bölüm → Oda; formda bulunan geliştirme-modu hatası (yatış tarihi alt sınırının her turda yeniden hesaplanması, NG0100) düzeltildi (frontend `72ce00e9`). Migration yerel dev DB'ye uygulandı; paylaşılan/üretim DB ayrı onay |
| **Bağımlılıklar** | HOSP-001 |
| **Notlar** | E-Vet UI örneği (Bölüm/Oda/Veteriner) Vetinity alan/requirement kopyası değildir — → [e-vet.md](../competitors/e-vet.md#global-hospitalizasyon-modül). Odalar/kaynak tanımları Ayarlar/Tanımlar ile ilişkilendirilebilir — kesin IA **TBD**; kapasite/conflict E-Vet’te **NOT VERIFIED** |

### HOSP-003 — Hasta yatış geçmişi ve klinik bağlam

| Alan | Değer |
|---|---|
| **Kimlik** | HOSP-003 |
| **Başlık** | Hasta yatış geçmişi ve klinik bağlam |
| **Kategori** | Hospitalization |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Problem** | Hasta kaydından aktif/geçmiş yatışlar ve yatış süresince klinik kayıtlara erişim dağınık |
| **Önerilen çözüm** | Patient-scoped read surface: aktif yatış + geçmiş yatış listesi ([TIMELINE-001](#timeline-001--hasta-timeline) read-model ile hizalanabilir; duplicate storage önerilmez). Yatış bağlamından ilgili muayene/tedavi/klinik kayıtlara geçiş — [EXAM-001](#exam-001--modern-muayene-çalışma-alanı), [RECORD-001](#record-001--recordfinans-bağlantısı-görünürlüğü) capability'lerini duplicate etmeden bağlam sağlar |
| **Kullanıcı değeri** | Hasta merkezli yatış geçmişi; yatış–klinik süreklilik |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Bağımlılıklar** | HOSP-001, TIMELINE-001 |
| **Notlar** | Filtre/tarih aralığı → [TIMELINE-003](#timeline-003--timeline-filtreleri). **Competitor evidence:** E-Vet hasta kartı Hospitalizasyon Geçmişi + global süreklilik — → [e-vet.md](../competitors/e-vet.md#hospitalizasyon-geçmişi) · [global modül](../competitors/e-vet.md#global-hospitalizasyon-modül). **TBD:** “Tedavisi var mı?” benzeri göstergenin veri kaynağı; inpatient treatment schedule |

---

## CHECKIN — Check-in orkestrasyonu

### CHECKIN-001 — Check-in workflow

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-001 |
| **Başlık** | Check-in workflow |
| **Kategori** | Check-in |
| **Problem** | Randevu geldiğinde hazırlık adımları dağınık ekranlarda toplanıyor |
| **Önerilen çözüm** | Randevu kartından check-in; tamamlanınca Checked In durumu; medical note ve billing bağlantısı |
| **Kullanıcı değeri** | Tek giriş noktası; operasyonel hız |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-001, APPT-001 |
| **Notlar** | Undo check-in / check-out yan etkileri değerlendirilmeli → [IDEA-020](../research/ideas.md#idea-020--check-in-orchestration), [PATTERN-016](../research/patterns.md#pattern-016--check-in-as-workflow-orchestrator). DaySmart sandbox observation (bölüm 3): ziyaret durumu Booked → Checked In → In Room → Visit Complete → Check Out; tam akış için [CHECKIN-005](#checkin-005--ziyaret-yaşam-döngüsü-ve-durum-geçişleri). **Canlı sandbox — Boarding:** reservation → Check In sihirbazı (billing, form, bundle, item rule, cage card, weight, medical note) — tamamlama **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#check-in-wizard) |

### CHECKIN-002 — Check-in sırasında medical note şablonu

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-002 |
| **Başlık** | Check-in sırasında medical note şablonu |
| **Kategori** | Check-in |
| **Problem** | Check-in ile muayene başlangıcı kopuk kalıyor |
| **Önerilen çözüm** | Check-in formunda medical note şablonu seçimi ve randevuya bağlama |
| **Kullanıcı değeri** | Muayeneye hazır başlangıç |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-001, EXAM-006 |
| **Notlar** | DaySmart gözlemi — sandbox doğrulanmadı. **Canlı sandbox — Boarding Check In:** Boarding Form template (Intake, Cage Card/Instructions, Behavior Observation vb.); Medical Note — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#boarding-form-template). **Settings Module:** Appointment Type preset → default medical note / check-in forms — → [daysmart.md](../competitors/daysmart.md#settings-appointment-types) |

### CHECKIN-003 — Check-in sırasında bundle seçimi
| **Kategori** | Check-in |
| **Problem** | Paket uygulama check-in aşamasında atlanabiliyor |
| **Önerilen çözüm** | Check-in formunda bundle seçimi ve invoice ilişkilendirme |
| **Kullanıcı değeri** | Erken paket planlama |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-001, EXAM-007 |
| **Notlar** | **Canlı sandbox — Boarding Check In:** Boarding Bundle + diğer medical bundle'lar — yansıma **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#bundle-check-in-bağlamı). **Templates Module:** Bundle Items/Activities/Actions; appointment type preset bundle binding — → [daysmart.md](../competitors/daysmart.md#templates-bundles) |

### CHECKIN-004 — Check-in sırasında invoice/estimate seçimi veya oluşturma

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-004 |
| **Başlık** | Check-in sırasında invoice/estimate seçimi veya oluşturma |
| **Kategori** | Check-in |
| **Problem** | Billing bağlantısı check-in sonrasına kalıyor |
| **Önerilen çözüm** | Yeni veya mevcut invoice/estimate seçimi veya oluşturma |
| **Kullanıcı değeri** | Klinik-finans sürekliliği |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-001 |
| **Notlar** | → [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability). **Boarding Check In** New Invoice — [daysmart.md](../competitors/daysmart.md#check-in-wizard). **Clients Module:** Client-scoped Estimates — → [daysmart.md](../competitors/daysmart.md#client-billing). **Billing Module:** Estimate list/detail — → [daysmart.md](../competitors/daysmart.md#billing-estimates). **DaySmart (observed):** Check In Billing default = Create invoice — → [daysmart.md](../competitors/daysmart.md#config-observed-rows) |

### CHECKIN-005 — Ziyaret yaşam döngüsü ve durum geçişleri

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-005 |
| **Başlık** | Ziyaret yaşam döngüsü ve durum geçişleri |
| **Kategori** | Check-in |
| **Problem** | Ziyaret/encounter yaşam döngüsü (randevudan tamamlanmaya kadar) operasyonel durumlarıyla takip edilemiyor; yalnızca check-in adımı yeterli değil |
| **Önerilen çözüm** | Randevudan check-out'a kadar ziyaret/encounter yaşam döngüsü; durum geçişleri: Booked → Checked In → In Room → Visit Complete → Check Out; geçişte opsiyonel not |
| **Kullanıcı değeri** | Operasyonel görünürlük; ekip koordinasyonu |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): ADR-009 sade model (Waiting/InProgress/Completed) uygulandı; Booked/In Room/Check Out geçişleri yok, CHECKIN-006 ile örtüşüyor |
| **Bağımlılıklar** | CHECKIN-001 |
| **Notlar** | Kapsam durumları: Booked, Checked In, In Room, Visit Complete, Check Out. Bu kayıt yalnızca check-in işlemini değil, randevudan tamamlanmaya kadar tüm ziyaret/encounter yaşam döngüsünü temsil eder. DaySmart sandbox observation (~28:13–35:25): Visit Complete iken ayrı Check Out başlatılabiliyor → [CHECKOUT-001](#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu). Mevcut backlog ID'si CHECKIN-005 olarak korunur. İleride ziyaret/encounter alanı bağımsız bir ürün alanına dönüşürse kategori ve ID yapısı ayrıca değerlendirilebilir. DaySmart sandbox observation (2026-08-02 bölüm 3); SOAP ekranından durum değişimi gözlemlendi — doğrulanmadı. **Canlı sandbox — Census:** operasyon kuyruğu görünümü; satır bazlı status değişimi (gözlemlenen örnek: Not confirmed, Confirmed, Cancelled, Checked in); opsiyonel Notes — gözlemlenen seçeneklerin tam durum kümesi **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#sandbox--census-profiller-ve-operasyon-kuyruğu). **Canlı sandbox — Treatment Board:** aktif tedavi operasyon panosu — [daysmart.md](../competitors/daysmart.md#sandbox--treatment-board). **Canlı sandbox — Boarding Dashboard:** Checking In/Out/Checked In kolonları + durum legend — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#boarding-dashboard). **Patients Module:** Patient Profile Appointments + Boarding Reservation birleşik liste; domain ayrı — [daysmart.md](../competitors/daysmart.md#appointments-patient-profile). **Clients Module:** Client Appointments/Reservations unified query — [daysmart.md](../competitors/daysmart.md#appointments--reservations). **E-Vet SMART (2026-09-24):** UI'da **Randevular** ile **Ziyaret Geçmişi** ayrı yüzeyler; randevu listesinde örnek durum `Gelmedi` — tam enum/backend modeli **doğrulanmadı** → [e-vet.md](../competitors/e-vet.md#ziyaret-geçmişi), [e-vet.md](../competitors/e-vet.md#randevular) |

### CHECKIN-006 — Hafif geliş ve bekleme akışı (Visit, randevulu/randevusuz)

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-006 |
| **Başlık** | Hafif geliş ve bekleme akışı (Visit, randevulu/randevusuz) |
| **Kategori** | Check-in |
| **Problem** | Ayrı geliş zamanı, randevusuz geliş ve bekleme akışı yok. Randevusuz muayene kaydı tek başına bu ihtiyacı karşılamıyor; planlı randevu ile gerçek geliş ayrı izlenmiyor |
| **Önerilen çözüm** | Ayrı Visit kaydı: hasta, klinik, geliş zamanı, sorumlu hekim, opsiyonel randevu ilişkisi. Randevusuz geliş sahte randevu olarak takvime yazılmaz. Bakım durumu sade: Bekliyor / Devam ediyor / Tamamlandı; ödeme durumu ve açık iş göstergesi bakım durumundan ayrı tutulur. Tekrar tıklama ikinci ziyaret üretmez. Yanlış geliş işareti ve durum düzeltmesi yetki ve gerekçeyle izlenir. Muayene oluşturmanın randevuyu otomatik tamamlama davranışı Visit politikasına uyarlanır |
| **Kullanıcı değeri** | Resepsiyon ve hekim aynı güncel sırayı görür; muayeneye geçişte hasta tekrar seçilmez |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | EXAM-001 (dilim 1 kabul edildi), ADR-009 |
| **Notlar** | Ana plan Aşama 2. CHECKIN-001/005 ile ilişkili; ağır check-in formu (şablon/bundle/fatura/form/kafes kartı seçimi) ilk gelişte **yok** → CHECKIN-002–004 kapsam dışı. Online randevu teknik ön koşul değildir ([APPT](#appt--online-booking-ve-randevu-talepleri)). Departman/oda yönetimi, kapsamlı triage, portal, belge/imza sonraki kapsam. Rapor etkisi ADR-009'da incelenir |

### CHECKIN-007 — Bugün yüzeyi (günlük operasyon görünümü)

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-007 |
| **Başlık** | Bugün yüzeyi (günlük operasyon görünümü) |
| **Kategori** | Check-in |
| **Problem** | Resepsiyon ve hekim günlük sırayı (randevular, bekleyenler, bakımı devam edenler, açık işler) tek yerde göremiyor |
| **Önerilen çözüm** | Bugün: randevular, bekleyenler, bakım devam edenler, ilgili açık işler; aktif yatış ayrıca görünür. Bakım, ödeme ve açık iş göstergeleri ayrı. Günlük aksiyon yüzeyidir, geçmişe dönük raporla karıştırılmaz. Mevcut dashboard korunur |
| **Kullanıcı değeri** | Günlük iş akışı tek ekranda; "sıra kimde" sorusu cevaplanır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006, ADR-009 |
| **Notlar** | Ana plan Aşama 2. Rakip ilham: DaySmart Census, E-Vet Muayene Odası (operasyon iş listesi) — kopyalanmaz. Ödeme göstergesi temel finans (Aşama 3) gelene kadar yalnızca mevcut ödeme verisini yanlış sonuç üretmeden gösterir; veri yoksa göstergeyi uydurmaz |

### SEARCH-001 — Günlük hasta/sahip arama

| Alan | Değer |
|---|---|
| **Kimlik** | SEARCH-001 |
| **Başlık** | Günlük hasta/sahip arama |
| **Kategori** | Arama |
| **Problem** | Resepsiyon sahibi ve hastasını hızlı bulamıyor; Türkçe harf, ad/soyad sırası, boşluk/noktalama ve telefon biçimi farkları aramayı kaçırıyor; exact backlog kaydı yoktu |
| **Önerilen çözüm** | Sahip adı, hasta adı, telefon ve mevcut mikroçip ile toleranslı dar arama; sonuçta sahip altında hastalar anlaşılır gösterilir. Yeni sahip/hasta oluşturma akışı korunur; sahip oluşmuş, hasta kaydı başarısız olmuşsa aynı sahip üzerinden devam edilir. Arama normalizasyonu tenant/clinic erişim filtresini değiştirmez |
| **Kullanıcı değeri** | Hastayı bulma süresi kısalır; yinelenen kayıt azalır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | — (CHECKIN-006 ile birlikte teslim edilir) |
| **Notlar** | Ana plan Aşama 2. Kabul senaryoları somutlaştırılacak: Türkçe karakter (ı/İ, ş, ğ), ad/soyad sırası, boşluk/noktalama, telefon biçimleri, mikroçip. Bütün entity'lerde gelişmiş/AI arama kapsam dışı (Aşama 8/10) |

### CHECKIN-009 — Yanlış geliş işaretini geri alma

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-009 |
| **Başlık** | Yanlış geliş işaretini geri alma |
| **Kategori** | Check-in |
| **Problem** | Yanlışlıkla "Yanlış geliş" işaretlenen kayıt arayüzden geri getirilemiyor; yanlış işaretlenenleri görmenin yolu yok |
| **Önerilen çözüm** | `Visits.Correct` yetkisiyle gerekçeli geri alma (audit'li); Bugün'de "Yanlış işaretlenenler" görünümü; geri alma aynı hayvan/randevu için başka aktif Visit varsa 409 verir |
| **Kullanıcı değeri** | Resepsiyon düzeltmeyi korkmadan kullanır; kayıt temiz kalır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006/007 |

### CHECKIN-010 — Randevulu hasta gelmedi (no-show) işareti

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-010 |
| **Başlık** | Randevulu hasta gelmedi (no-show) işareti |
| **Kategori** | Check-in |
| **Problem** | `NoShow` randevu durumundan kaldırılmış; gelmeyen hastayı işaretlemenin ve raporlamanın yolu yok |
| **Önerilen çözüm** | Karar: randevuya `NoShow` sonuç durumu eklenir, tüm tüketiciler (rapor, dashboard, takvim, hatırlatma, Query DB) birlikte güncellenir ([ADR-010](../decisions/ADR-010-appointment-no-show-status.md)); elle işaretleme, otomasyon yok |
| **Kullanıcı değeri** | Gelmeyen hasta takibi ve raporlanabilir bilgi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006/007, ADR-009 |

### CHECKIN-011 — Uzun bekleme uyarısı

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-011 |
| **Başlık** | Uzun bekleme uyarısı |
| **Kategori** | Check-in |
| **Problem** | Uzun bekleyen hasta sırada fark edilmiyor |
| **Önerilen çözüm** | Bugün'de bekleme süresi eşiği aşınca satır süresi renk değiştirir (örn. 30 dk uyarı, 60 dk kritik; eşik sabit, ayar sonraya) |
| **Kullanıcı değeri** | Resepsiyon bekleyeni geç bırakmaz |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; tasarım gereği yalnız frontend) |
| **Bağımlılıklar** | CHECKIN-007 |

### CHECKIN-012 — Acil işareti

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-012 |
| **Başlık** | Acil işareti (basit öncelik bayrağı) |
| **Kategori** | Check-in |
| **Problem** | Acil hasta sırada ayrışmıyor; kapsamlı triage ADR-009'da sonraya bırakıldı |
| **Önerilen çözüm** | Visit'e `Acil` bayrağı; gelişte veya sonradan işaretlenir; Bugün'de sıranın başında ve belirgin rozetle görünür; yalnızca bayrak, triage skoru yok |
| **Kullanıcı değeri** | Acil hasta kaçmaz |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük-Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006/007 |

### CHECKIN-013 — Bugün satırında hasta uyarı rozetleri

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-013 |
| **Başlık** | Bugün satırında hasta uyarı rozetleri (alerji, agresif, kronik) |
| **Kategori** | Check-in / Hasta bağlamı |
| **Problem** | Hekim muayeneye girmeden hastanın kritik uyarılarını görmüyor |
| **Önerilen çözüm** | Mevcut hasta uyarı/alerji verisi varsa Bugün satırında rozet; veri yoksa uydurulmaz. Önce veri kaynağı doğrulanır |
| **Kullanıcı değeri** | Klinik güvenlik |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): hasta uyarı verisi Bugün yanıtında; satırda rozet render'ı doğrulanmadı |
| **Bağımlılıklar** | CHECKIN-007 |

### CHECKIN-014 — Hekim için "Benim hastalarım" filtresi

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-014 |
| **Başlık** | Hekim için "Benim hastalarım" filtresi |
| **Kategori** | Check-in |
| **Problem** | Hekim Bugün'de yalnızca kendine atanmış satırları kolay göremiyor |
| **Önerilen çözüm** | Bugün sorgusuna sorumlu hekim filtresi; hekim rolü için varsayılan "Benim hastalarım", tümünü göster seçeneği |
| **Kullanıcı değeri** | Hekim kendi sırasına odaklanır |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-007, hekim seçimi |

### CHECKIN-008 — Randevusuz gelişte hızlı müşteri ve hasta kaydı

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-008 |
| **Başlık** | Randevusuz gelişte hızlı müşteri ve hasta kaydı |
| **Kategori** | Check-in |
| **Problem** | Randevusuz gelen yeni hasta kayıtlı değilse resepsiyon geliş diyaloğunda ilerleyemiyor; müşteri ve hasta için ayrı ekranlara gitmek gerekiyor |
| **Önerilen çözüm** | Geliş diyaloğunda arama sonuç vermezse satır içi mini form: sahip adı soyadı, telefon (zorunlu), hayvan adı, tür, opsiyonel mikroçip. Müşteri + hasta backend'de tek işlemle (transaction) oluşturulur; ardından idempotent geliş kaydı açılır. Aynı telefonla müşteri varsa uyarı ve mevcut müşteriyi seçme. Kayıtlı sahibe yeni hayvan: mevcut hasta oluşturma ucu |
| **Kullanıcı değeri** | Yeni hasta kabulü tek akışta; resepsiyon ekran değiştirmez; yinelenen kayıt azalır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006, SEARCH-001 |
| **Notlar** | Yarım kayıt (müşteri var, hasta yok) oluşmamalı. Yeni uç Clients.Create ve Pets.Create yetkilerini ister; yetkisi olmayana bağlantı görünmez. Query DB projeksiyon/outbox davranışı mevcut müşteri ve hasta oluşturma ile aynı olmalı. **Karar (2026-10-10):** yinelenen kural mevcut hâliyle kalır (aynı ad + aynı telefon → 409; yalnızca telefon aynıysa serbest, aile bireyleri paylaşabilir); telefon aramada mevcut müşteriyi gösterir. Telefon görünümü mevcut `+90 5XX …` biçimi |

---

## FIN — Temel ücret, tahsilat ve bakiye

> Ana plan Aşama 3 ([bölüm 8](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)); karar taslağı [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md). Gelişmiş kredi/mahsup, kasa mutabakatı, belge paketi, kapsamlı muhasebe ve resmi e-belge kapsam dışıdır ([CHECKOUT-001](#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu), [INT-005](#int-005--e-fatura--e-smm), [INT-006](#int-006--pos-ve-online-ödeme)).

### FIN-001 — Ücret (borç) kaydı ve manuel ücret satırı

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-001 |
| **Başlık** | Ücret kaydı ve manuel ücret satırı |
| **Kategori** | Finans |
| **Problem** | Payment tahsil edilen tutarı kaydediyor; muayene/ziyaret sonrası ücret (borç) oluşturan kaynak yok, bu yüzden "ne kadar borçlu" bilinemiyor |
| **Önerilen çözüm** | Hasta/ziyaret veya klinik işlemle bağlı ücret: açıklama, miktar, tutar, para birimi; ilk dilimde manuel satır. Hizmet kataloğu ön koşul değil |
| **Kullanıcı değeri** | Muayeneden ücrete bağlamı kaybetmeden geçiş |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta-Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | CHECKIN-006, ADR-012 |

### FIN-002 — Tahsilat–ücret ilişkilendirme ve bakiye

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-002 |
| **Başlık** | Tahsilat–ücret ilişkilendirme ve bakiye |
| **Kategori** | Finans |
| **Problem** | Toplam tahsilat müşterinin kalan borcunu vermiyor; hangi ödemenin hangi ücreti kapattığı belli değil |
| **Önerilen çözüm** | Açık ilişki (hangi tahsilat hangi ücreti karşılar, aynı para iki borcu kapatamaz); sahip bazında klinik kapsamlı bakiye: ücret, ödeme, açık kalan; kısmi ödeme ve sonraki tahsilatta kapanış; çift istek/iki kullanıcı aynı ödemeyi iki kez saymaz |
| **Kullanıcı değeri** | "Kalan borç" sorusu tek yerde cevaplanır |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | FIN-001, ADR-012 |

### FIN-003 — Ücret ve tahsilat düzeltme

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-003 |
| **Başlık** | Ücret/tahsilat düzeltme, iptal ve iade kuralları |
| **Kategori** | Finans |
| **Problem** | Yanlış girilen ücret veya ödeme düzeltilemez; geçmiş işlemin izi korunmalı |
| **Önerilen çözüm** | Tutar değiştirme, iptal ve iade; yetki + zorunlu gerekçe + audit; geçmiş işlem silinmez (iptal/ters kayıt) |
| **Kullanıcı değeri** | Denetlenebilir kasa; güvenli düzeltme |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta-Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | FIN-001, FIN-002 |

### FIN-004 — Bugün ve muayeneden ücret/ödeme akışı (arayüz)

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-004 |
| **Başlık** | Bugün ve muayeneden ücret ekleme ve ödeme alma |
| **Kategori** | Finans |
| **Problem** | Bugün satırındaki "Ödeme kaydı yok" rozeti bilgi veriyor ama ödemeye geçilemiyor |
| **Önerilen çözüm** | Muayene sonu ve Bugün satırında "Ücret ekle / Ödeme al" kısayolu; satırda ücret, ödenen, kalan görünümü; bakım durumu (Tamamlandı) borcu kapatmaz |
| **Kullanıcı değeri** | Hasta çıkarken tek akışta tahsilat |
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24): Bugün satırı menüsünde ve muayene detayında "Ücret ekle" (müşteri/hasta/geliş/muayene ön ayarlı), ödeme al mevcut; tarayıcıda elle denenmedi |
| **Bağımlılıklar** | FIN-001, FIN-002, CHECKIN-007 |

### FIN-005 — Müşteri kredisi ve mahsup (fazla ödeme)

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-005 |
| **Başlık** | Müşteri kredisi ve mahsup |
| **Kategori** | Finans |
| **Problem** | İlk sürümde borçtan fazla tahsilat reddedilir (para üstü); müşteri peşin bakiye/kredi bırakamaz, sonraki ücrete mahsup edilemez |
| **Önerilen çözüm** | Avans, depozito ve önceden ödeme dahil müşteri kredisi **ayrı bir Kredi kaydı** (müşteri, sebep, tutar, kalan bakiye) olarak tutulur; sonraki ücretlere kısmen mahsup edilir; kredi iade/iptal kuralları, kasa etkisi netleştirilir. Ödeme her zaman ücrete bağlı kalır (ADR-012 madde 6). DaySmart Credit kaydı gözlemi ([daysmart.md](../competitors/daysmart.md#billing-credits), sandbox gözlemi, doğrulanmadı) |
| **Kullanıcı değeri** | Peşin ödeme/avans ve fazla ödeme senaryoları |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Ertelendi (ADR-012 kararı: ilk sürümde kapsam dışı; unutulmayacak) |
| **Bağımlılıklar** | FIN-001, FIN-002, FIN-003 |

### FIN-006 — Çoklu para birimi

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-006 |
| **Başlık** | Çoklu para birimi |
| **Kategori** | Finans |
| **Problem** | İlk sürüm yalnızca TRY |
| **Önerilen çözüm** | Her ücret/ödeme kendi para biriminde; farklı para birimleri tek toplamda karıştırılmaz; kur dönüşümü otomatik varsayılmaz |
| **Kullanıcı değeri** | Döviz kullanan klinikler |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta-Yüksek |
| **Durum** | Ertelendi (ADR-012) |
| **Bağımlılıklar** | FIN-001, FIN-002 |

### FIN-007 — Eski ödemelerin bağlanması ve açılış bakiyesi

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-007 |
| **Başlık** | Eski ödemelerin ücretlere bağlanması ve açılış bakiyesi |
| **Kategori** | Finans |
| **Problem** | Ücret öncesi girilmiş ödemeler "bağlanmamış" kalır; müşteri açılış borcu/alacağı girilemez |
| **Önerilen çözüm** | Bağlanmamış ödemelerin sonradan ücretlere bağlanması; yetkili ve gerekçeli açılış bakiyesi kaydı; hayali borç türetilmez |
| **Kullanıcı değeri** | Mevcut müşteri verisiyle geçiş |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Ertelendi (ADR-012; canlıya geçişten önce yeniden değerlendirilir) |
| **Bağımlılıklar** | FIN-002 |

### FIN-008 — Hizmet kataloğu

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-008 |
| **Başlık** | Hizmet kataloğu ve fiyat listesi |
| **Kategori** | Finans |
| **Problem** | İlk dilimde ücret manuel satırdır; her seferinde açıklama ve tutar elle girilir |
| **Önerilen çözüm** | Klinik hizmet/ürün kataloğu ve varsayılan fiyatlar; ücret satırı katalogdan seçilir, tutar düzenlenebilir; stok `Product.UnitPrice` ile ilişki ayrıca değerlendirilir |
| **Kullanıcı değeri** | Hızlı ve tutarlı ücretlendirme |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta-Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | FIN-001 |

### FIN-009 — Düzeltme yetkisinin kontrollü gevşetilmesi

| Alan | Değer |
|---|---|
| **Kimlik** | FIN-009 |
| **Başlık** | Düzeltme yetkisinin kontrollü gevşetilmesi |
| **Kategori** | Finans |
| **Problem** | İlk sürümde yalnızca yönetici düzeyi düzeltir; küçük klinikte resepsiyon aynı gün kendi hatasını düzeltmek isteyebilir |
| **Önerilen çözüm** | Örn. kullanıcının kendi girdiği ve aynı gün içindeki kaydı gerekçeyle düzeltmesi; sınırlar ve audit netleştirilir |
| **Kullanıcı değeri** | Operasyon hızı, kasa güvenliğinden ödün vermeden |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük-Orta |
| **Durum** | Ertelendi (ADR-012) |
| **Bağımlılıklar** | FIN-003 |

---

## CHECKOUT — Ziyaret kapanışı ve tahsilat

### CHECKOUT-001 — Ziyaret kapanışı ve tahsilat orkestrasyonu

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKOUT-001 |
| **Başlık** | Ziyaret kapanışı ve tahsilat orkestrasyonu |
| **Kategori** | Checkout |
| **Problem** | Ziyaret kapanışında tahsilat, belge üretimi, teslim ve operasyonel durum kopuk ekranlarda toplanıyor |
| **Önerilen çözüm** | Ziyaret/encounter üzerinden checkout; açık fatura seçimi, tahsilat tutarı, ödeme yöntemi, kredi/mahsup, fazla tahsilat sonucu, checkout tarihi/kullanıcı, ziyaret durumu kapanışı, belge üretimi ve teslim tercihi, reminder görünürlüğü, audit izi |
| **Kullanıcı değeri** | Tek operasyonel kapanış; resepsiyon hızı; izlenebilirlik |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-005, RECORD-001 |
| **Notlar** | DaySmart sandbox observation (~28:13–35:25). Belge paketi → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-024](../research/patterns.md#pattern-024--event-to-document-package), [PORTAL-005](#portal-005--dijital-onam-ve-imza). **Clients Module:** customer-scoped billing — → [daysmart.md](../competitors/daysmart.md#client-billing). **Billing Module:** — → [daysmart.md](../competitors/daysmart.md#sandbox--billing--financial-operations). **Reports Module:** AR Reconciliation (reopened invoice warning), Accounts Receivable, EOD/Cash Reconciliation, Collections by Type — → [daysmart.md](../competitors/daysmart.md#reports-billing), [daysmart.md](../competitors/daysmart.md#reports-ar-reconciliation). **Kapsam dışı:** POS, e-belge → [INT-005](#int-005--e-fatura--e-smm), [INT-006](#int-006--pos-ve-online-ödeme). → [IDEA-027](../research/ideas.md#idea-027--checkout-as-visit-completion-orchestrator). **E-Vet SMART:** Yeni Ziyaret > Satış **Kaydet / Öde** — UI kopyalanmaz — → [e-vet.md](../competitors/e-vet.md#yeni-ziyaret). Global **Doğrudan Satış** **Kaydet / Öde** → Fatura Ödemesi; split tender (ör. Nakit + Kredi Kartı); linked payment blocks Direct Sale deletion; related payment removed → same sale record deletable (UI/product — FK/cascade **iddia edilmez**) — → [e-vet.md](../competitors/e-vet.md#ödeme-bağımlılığı-ve-silme-canlı-test) |

---

## RECORD — Klinik kayıt yaşam döngüsü

### RECORD-001 — Record–finans bağlantısı görünürlüğü

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-001 |
| **Başlık** | Record–finans bağlantısı görünürlüğü |
| **Kategori** | Record |
| **Problem** | Klinik kaydın hangi fatura satırına bağlandığı görünmez |
| **Önerilen çözüm** | Record satırında fiyat ve bağlı invoice görünürlüğü |
| **Kullanıcı değeri** | Eksik ücret kontrolü; denetlenebilirlik |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): "ücret bekliyor" kalemi ve açık işler var; satır bazında fiyat/fatura görünümü yok |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | → [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability). **Patients Module:** History Invoice + Reference. **Clients Module:** customer-scoped invoice list — → [daysmart.md](../competitors/daysmart.md#client-billing). **Inventory Module:** Item Transactions — → [daysmart.md](../competitors/daysmart.md#inventory-transactions). **Billing Module:** Invoice workspace (Items/Payments/Credits/Returns/Late Fees tabs); line-level Patient/Provider; finansal özet (Subtotal…Balance) — → [daysmart.md](../competitors/daysmart.md#billing-invoices). **E-Vet SMART (2026-09-24):** Ziyaret Geçmişi (Fatura No, Toplam, Ödeme); Yeni Ziyaret > Satış fatura satırları — backend entity ayrımı **iddia edilmez** → [e-vet.md](../competitors/e-vet.md#ziyaret-geçmişi), [e-vet.md](../competitors/e-vet.md#yeni-ziyaret) |

### RECORD-002 — Record audit history

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-002 |
| **Başlık** | Record audit history |
| **Kategori** | Record |
| **Problem** | Kayıt değişiklikleri izlenemiyor |
| **Önerilen çözüm** | View changes / audit history; kim, ne zaman, ne değiştirdi |
| **Kullanıcı değeri** | Denetlenebilirlik; güven |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): denetim yazımı var; okuma ucu ve "değişiklikleri gör" ekranı yok |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | DaySmart view changes gözlemlendi — sandbox doğrulanmadı → [IDEA-025](../research/ideas.md#idea-025--auditable-clinical-record-lifecycle), [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions). **Inventory Module:** stock adjustment audit — → [daysmart.md](../competitors/daysmart.md#inventory-adjustments). **Reports Module:** Staff > Deleted Transactions report — deleted financial/transaction visibility — → [daysmart.md](../competitors/daysmart.md#reports-deleted-transactions) |

### RECORD-003 — Record attachment

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-003 |
| **Başlık** | Record attachment |
| **Kategori** | Record |
| **Problem** | Klinik kayda ilişkin dosyalar ayrı tutuluyor |
| **Önerilen çözüm** | Record satırına attachment ekleme |
| **Kullanıcı değeri** | Bağlamlı dokümantasyon |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): yalnız görüntüleme ve lab kayıtlarında dosya eki; diğer kayıt türlerinde yok |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | **E-Vet SMART:** Hasta kartı **Dosyalarım** — generic dosya satırları (tarih, bilgi, dosya seç, liste arama); lab/PACS/clinical document ile aynı capability sayılmamalı — → [e-vet.md](../competitors/e-vet.md#dosyalarım-attachments) |

### RECORD-004 — Record duplicate

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-004 |
| **Başlık** | Record duplicate |
| **Kategori** | Record |
| **Problem** | Benzer kayıtlar sıfırdan giriliyor |
| **Önerilen çözüm** | Record duplicate aksiyonu |
| **Kullanıcı değeri** | Hız; tutarlılık |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | |

### RECORD-005 — Lot, expiry, route ve site izlenebilirliği

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-005 |
| **Başlık** | Lot, expiry, route ve site izlenebilirliği |
| **Kategori** | Record |
| **Problem** | İlaç ve aşı kayıtlarında lot/expiry/route detayları eksik kalabilir |
| **Önerilen çözüm** | Lot, üretici, son kullanma, uygulama yolu ve bölgesi alanları |
| **Kullanıcı değeri** | Klinik güvenlik; denetim |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): lot/parti ve son kullanma var; uygulama yolu, bölge, üretici yok |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | DaySmart record satırı gözlemi. **Patients Module:** Pharmacy/Vaccines lot/route. **Inventory Module:** Purchases/Transactions/Alerts — → [daysmart.md](../competitors/daysmart.md#inventory-purchases). **Reports Module:** Controlled Substances Log — TR regulatory TBD — → [daysmart.md](../competitors/daysmart.md#reports-controlled-substances-log). **DaySmart (observed):** Inventory Shelf Management = Soonest Expiring vs purchase-date FIFO — → [daysmart.md](../competitors/daysmart.md#config-inventory-shelf). **Vetinity (implication):** expiring inventory için FEFO/FIFO policy değerlendirilebilir |

### RECORD-006 — Birleşik record modeli ve tip-bazlı dinamik form

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-006 |
| **Başlık** | Birleşik record modeli ve tip-bazlı dinamik form |
| **Kategori** | Record |
| **Problem** | Aşı, ilaç, prosedür, diagnostik ve vital kayıtları parçalı modellerde tutuluyor |
| **Önerilen çözüm** | Tek record entity; Vaccine/Medication/Procedure/Diagnostic/Vital tip metadata; tip seçimine göre dinamik form |
| **Kullanıcı değeri** | Tutarlı klinik kayıt modeli; ortak lifecycle |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | DaySmart sandbox observation (2026-08-02 bölüm 3); generic record architecture adayı → [IDEA-026](../research/ideas.md#idea-026--unified-dynamic-record-model), [PATTERN-020](../research/patterns.md#pattern-020--unified-record-with-dynamic-type-forms). **Canlı sandbox — Patients Module:** Records/Pharmacy/Labs/Images/Vaccines/Vitals History filtreleri aynı timeline read-model → [daysmart.md](../competitors/daysmart.md#records) |

### RECORD-007 — Muayene yeniden açma ve revizyon geçmişi

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-007 |
| **Başlık** | Muayene yeniden açma ve revizyon geçmişi |
| **Kategori** | Record |
| **Problem** | İlk sürümde kesinleşen muayene kilitlenir ve yalnız ek notla (addendum) düzeltilir; yanlışlıkla kesinleştirilen kayıt açılamaz |
| **Önerilen çözüm** | Yetkili kişi gerekçeyle muayeneyi yeniden açar; her kesinleştirmede anlık görüntü (revizyon) saklanır; eski sürümler görüntülenir ve karşılaştırılır; yeni izin ve audit |
| **Kullanıcı değeri** | Hatalı kesinleştirmenin düzeltilebilmesi; denetlenebilirlik |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta (tahmin: ek 2 backend dilimi, migration var; ölçülmedi) |
| **Durum** | Ertelendi (kullanıcı kararı 2026-10-11: önce kilit + ek not) |
| **Bağımlılıklar** | Aşama 4 dilim D (kesinleştirme) ve E (addendum); [RECORD-002](#record-002--record-audit-history) |
| **Notlar** | Aşama 4 keşfi D1 seçenek (b). Gerçek kullanımda "yanlışlıkla kilitledim" ihtiyacı görülürse öne alınır. Rakip: DaySmart kilit ikonu ve Lock Letter gözlemlendi, kilit açma yetkisi doğrulanmadı — [EXAM-015](#exam-015--medical-note-lock) |


### RECORD-008 — Reçete iptali ve kesinleşmiş muayenede düzeltme yolu

| Alan | Değer |
|---|---|
| **Kimlik** | RECORD-008 |
| **Başlık** | Reçete iptali ve kesinleşmiş muayenede düzeltme yolu |
| **Kategori** | Record |
| **Problem** | Reçetede iptal/durum kavramı yok; Aşama 5 D3 "gerekçeli iptal ve yeni kayıt" kararı reçete için uygulanmadı. Reçete satırlarının kimliği her değişiklikte yeniden üretiliyor |
| **Önerilen çözüm** | Reçeteye iptal durumu (gerekçe, denetim izi, silme yok), kararlı satır kimlikleri, kesinleşmiş muayenede sonradan ekleme için ADR-013 ilkelerinin reçeteye uyarlanması |
| **Kullanıcı değeri** | Hatalı reçete düzeltilebilir ve izlenebilir |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | Aşama 5 Dilim 3 (reçete satırları); [ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md) |
| **Notlar** | Aşama 5 Dilim 3 raporu açık soruları; migration gerekir |
---

## PORTAL — Hasta sahibi portalı

### PORTAL-001 — Hasta sahibi portalı

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-001 |
| **Başlık** | Hasta sahibi portalı |
| **Kategori** | Portal |
| **Problem** | Hasta sahibi klinik bilgilerine self-servis erişemiyor |
| **Önerilen çözüm** | Ayrı mobil-öncelikli web portalı (PWA); v0: davetle hesap, hayvanlarım, randevularım, aşı geçmişi/yaklaşan aşı, bakiye, klinik bilgisi |
| **Kullanıcı değeri** | Self-servis; resepsiyon yükü azalır |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; v0 kapsamı) |
| **Bağımlılıklar** | — |
| **Notlar** | **Kullanıcı kararı (2026-10-16): zorunlu; P2→P1, pilot sonrası.** Kapsam, kimlik, KVKK, teknoloji ve açık kararlar → [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md). v1.0 dışı; rakip gözlemi → [IDEA-017](../research/ideas.md#idea-017--owner-portal-as-operational-extension), [PATTERN-013](../research/patterns.md#pattern-013--portal-to-clinic-continuity) |

### PORTAL-002 — Portal hayvan profili

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-002 |
| **Başlık** | Portal hayvan profili |
| **Kategori** | Portal |
| **Problem** | Hasta sahibi hayvan detaylarına portal üzerinden erişemiyor |
| **Önerilen çözüm** | Fotoğraf, ırk, kilo, renk, cinsiyet/kısırlaştırma, doğum tarihi, mikroçip; Certificates/Notes/Records/Reminders/Visits |
| **Kullanıcı değeri** | Merkezi hayvan bilgisi |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): temel profil ve aşılar var; fotoğraf, belgeler, notlar, ziyaretler yok |
| **Bağımlılıklar** | PORTAL-001 |
| **Notlar** | v1.0 dışı aday. Portal demografisi klinik hayvan kaydından türetilir. **Canlı sandbox — Patients Module:** Upload Photo modal; chip/birthdate Edit Profile — → [daysmart.md](../competitors/daysmart.md#edit-patient-profile) |

### PORTAL-003 — Portal reminders, visits ve documents

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-003 |
| **Başlık** | Portal reminders, visits ve documents |
| **Kategori** | Portal |
| **Problem** | Hatırlatma ve ziyaret bilgisi dağınık kanallarda |
| **Önerilen çözüm** | Portal ana ekran ve hayvan profilinde reminders/visits; klinik belge listesi |
| **Kullanıcı değeri** | Proaktif hasta sahibi bilgilendirmesi |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): yaklaşan aşı ve randevular var; ziyaret ve belge listesi yok |
| **Bağımlılıklar** | PORTAL-001 |
| **Notlar** | v1.0 dışı aday. **Reminders:** Klinik Reminders Detail ≠ portal reminder yüzeyi — → [daysmart.md](../competitors/daysmart.md#sandbox--reminders-reminders-detail). **DaySmart (observed):** Link Expiration policy — → [daysmart.md](../competitors/daysmart.md#config-observed-rows). **Vetinity (implication):** scoped access + expiration + revocation |

### PORTAL-004 — Açık fatura görüntüleme

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-004 |
| **Başlık** | Açık fatura görüntüleme |
| **Kategori** | Portal |
| **Problem** | Hasta sahibi ödeme durumunu göremiyor |
| **Önerilen çözüm** | Portal Billing bölümünde açık faturalar ve durum etiketleri |
| **Kullanıcı değeri** | Şeffaf faturalama |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): bakiye ve ödemeler var; fatura/durum etiketi modeli yok (ADR-012) |
| **Bağımlılıklar** | PORTAL-001 |
| **Notlar** | v1.0 dışı aday; online ödeme ayrı kapsam. **Clients Module:** Account Statement Email/Print; customer balance header — → [daysmart.md](../competitors/daysmart.md#client-billing) |

### PORTAL-005 — Dijital onam ve imza

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-005 |
| **Başlık** | Dijital onam ve imza |
| **Kategori** | Portal |
| **Problem** | Onam formları basılı veya ayrı kanalla imzalanıyor |
| **Önerilen çözüm** | Belge görüntüleme + ekran imzası + durum güncelleme (open/approved/paid) |
| **Kullanıcı değeri** | Dijital süreç; resepsiyon tasarrufu |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | PORTAL-003 |
| **Notlar** | v1.0 dışı aday; Türkiye hukuki geçerlilik araştırılmalı → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-014](../research/patterns.md#pattern-014--document-to-signature-continuity). DaySmart sandbox observation (bölüm 3): Draw/Type Signature; Lock Letter after sign → [PATTERN-023](../research/patterns.md#pattern-023--post-signature-document-immutability). **Templates Module:** Forms — Designer/Preview/Logic; conditional form logic; multi-page — → [daysmart.md](../competitors/daysmart.md#templates-forms). **Clients Module** form template örnekleri — → [daysmart.md](../competitors/daysmart.md#documents). **E-Vet SMART:** Anestezi İzin Formu — auto-fill owner/patient; imza + PDF/print; metin nihai şablon değil — → [e-vet.md](../competitors/e-vet.md#hasta-formları) |

### PORTAL-006 — Portal kimliği, davet ve müşteri bağı

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-006 |
| **Başlık** | Portal kimliği, davet ve müşteri bağı |
| **Kategori** | Portal |
| **Problem** | Hasta sahibinin sistemde kimliği yok; otomatik telefon eşleşmesi yanlış kişiye veri sızdırabilir |
| **Önerilen çözüm** | Ayrı hasta sahibi hesabı; klinik müşteri kartından süreli tek kullanımlık davet; SMS/e-posta kodu ile doğrulama; hesap↔Client bağı (kişi başına tek hesap, klinik başına bağ — AK-3); kod deneme sınırı, oturum/jeton yönetimi |
| **Kullanıcı değeri** | Güvenli ve doğru eşleşen self-servis giriş |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | PORTAL-001, SEC-001 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K3; giriş yöntemi AK-2. Backend önce, migration kullanıcı onayıyla |

### PORTAL-007 — Portal KVKK: sürümlü kabul, bildirim tercihi, veri talebi

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-007 |
| **Başlık** | Portal KVKK: sürümlü kabul, bildirim tercihi, veri talebi |
| **Kategori** | Portal |
| **Problem** | ADR-029 kabulü yalnız klinik kullanıcıları içindir; hasta sahibi aydınlatma/kabul/silme talebi yolu yok |
| **Önerilen çözüm** | ADR-029 mekanizmasını hasta sahibi hesabına genişlet; ilk girişte aydınlatma + hasta sahibi varyantı kabulü; ayrı ve geri alınabilir bildirim tercihi; portalda erişim/düzeltme/silme talebi → klinik KVKK talep süreci; Ret/RemindersOptedOut uyumu |
| **Kullanıcı değeri** | Yasal uyum; güven |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): sürümlü kabul ve aydınlatma var; bildirim tercihi ve veri talebi akışı doğrulanmadı |
| **Bağımlılıklar** | PORTAL-006, TRIAL-009 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K4; Vetinity'nin rolü ve İYS/ETK için hukuki görüş şart (AK-5); [HUKUKI-ONAY-LISTESI](../roadmap/HUKUKI-ONAY-LISTESI.md)'ne eklenir |

### PORTAL-008 — Portal API ayrımı ve kiracı izolasyonu

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-008 |
| **Başlık** | Portal API ayrımı ve kiracı izolasyonu |
| **Kategori** | Portal |
| **Problem** | Portal uçları personel yüzeyiyle karışırsa yetki ve veri sızıntısı riski |
| **Önerilen çözüm** | Ayrı yol öneki, kimlik şeması/token hedef kitlesi, portal DTO'ları, 'yalnız kendi Client kayıtlarım' sahiplik kontrolü tek yardımcıda, çapraz kiracı ve çapraz token testleri, okuma denetim kaydı, hız sınırı |
| **Kullanıcı değeri** | Güvenli, sürdürülebilir portal yüzeyi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; çapraz kiracı test kapsamı doğrulanmadı) |
| **Bağımlılıklar** | PORTAL-006 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K6; backend sözleşmesi tek doğruluk kaynağı, önce backend |

### PORTAL-009 — Klinik panelinde portal yönetimi

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-009 |
| **Başlık** | Klinik panelinde portal yönetimi |
| **Kategori** | Portal |
| **Problem** | Klinik hangi müşterinin portala davetli/bağlı olduğunu göremez, erişimi kapatamaz |
| **Önerilen çözüm** | Müşteri kartında portal durumu (davetli/bağlı/kapalı), davet gönder/iptal/yenile, erişimi kapat, klinik düzeyinde portalı aç/kapat (çıkış planı), portal talepleri için gelen kutusu girişi |
| **Kullanıcı değeri** | Klinik kontrolü; çıkış güvencesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): müşteri kartında durum/davet/iptal/kapat var; klinik düzeyi aç-kapat ve gelen kutusu yok |
| **Bağımlılıklar** | PORTAL-006 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K3/K8; yeni portal yönetim izni (izin kataloğu) |

### PORTAL-010 — Portal bildirimleri (e-posta, WhatsApp bağlantısı, push)

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-010 |
| **Başlık** | Portal bildirimleri (e-posta, WhatsApp bağlantısı, push) |
| **Kategori** | Portal |
| **Problem** | Hatırlatma ve doğrulama için kanal seçimi ve tercih yönetimi tanımsız |
| **Önerilen çözüm** | Bildirim türü × kanal kuralı tek yerde (backend); v0 e-posta; personel gönderimli WhatsApp bağlantısı (ücretsiz, otomatik gönderim yok); v1 push; SMS bu aşamada yok; minimum veri içerikli metin; teslim durumu ve tercih |
| **Kullanıcı değeri** | Hasta sahibi doğru kanaldan zamanında haberdar olur |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin; ölçülmedi) |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): yalnız davet e-postası; tür×kanal kuralı, WhatsApp, push yok |
| **Bağımlılıklar** | PORTAL-006, APPT-013, APPT-023, INT-003 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K7; Kullanıcı kararı 2026-10-21: SMS yerine WhatsApp (AK-6); Business API ve SMS sonraya, maliyet kararı ile |

### PORTAL-011 — Portal hesabını silme (self-servis)

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-011 |
| **Başlık** | Portal hesabını silme (self-servis) |
| **Kategori** | Portal |
| **Problem** | Hukuki metin taslakları "hesabınızı istediğiniz zaman silebilirsiniz" diyor ama silme yolu yok; mağaza uygulaması (AK-4) için uygulama içi silme gerekiyor; klinik kayıtlarının akıbeti tanımsız |
| **Önerilen çözüm** | Portalda "Hesabı sil": e-posta koduyla yeniden doğrulama; hesap anında anonimleşir (e-posta, parola, ad silinir), oturum ve kodlar silinir, tüm klinik bağları "hesap silindi" gerekçesiyle kapanır; klinik kayıtları, kabul kayıtları ve denetim kaydı kalır; klinik panelinde durum görünür, klinik yeniden davet edebilir |
| **Kullanıcı değeri** | Hasta sahibi verisi üzerinde denetim; mağaza koşulu; kliniğin KVKK izi bozulmaz |
| **Öncelik** | P1 (mağaza yayınından önce zorunlu; öneri) |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Tasarlanacak (ADR-041 taslak, kullanıcı kabulü bekleniyor) |
| **Bağımlılıklar** | PORTAL-006, PORTAL-009 |
| **Notlar** | [ADR-041](../decisions/ADR-041-portal-hesap-silme.md) (öneri seçenek C: anonimleştirme + bağ kapatma; bekleme süresi yok). Hukuki bağımlılıklar çalışma varsayımıyla (ÇV-1…7), HUKUKI-ONAY-LISTESI C6. Klinikteki verilerin silinmesi kapsam dışı → [PORTAL-007](#portal-007--portal-kvkk-sürümlü-kabul-bildirim-tercihi-veri-talebi). Backend önce; migration kullanıcı onayıyla |

---

## MSG — Klinik iletişim / inbox

### MSG-001 — Klinik inbox

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-001 |
| **Başlık** | Klinik inbox |
| **Kategori** | Messaging |
| **Problem** | Müşteri iletişimi dağınık kanallarda |
| **Önerilen çözüm** | Müşteri bazlı konuşma listesi; aktif inbox |
| **Kullanıcı değeri** | Merkezi iletişim |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | — |
| **Notlar** | **v1.0 dışı aday** → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline). Inbox (active workspace) ≠ Communication History — → [daysmart.md](../competitors/daysmart.md#platform-inbox), [PATTERN-015](../research/patterns.md#pattern-015--conversation-to-patient-context). Outbound auto history capture (BCC örneği) — → [daysmart.md](../competitors/daysmart.md#config-bcc-forwarding) |

### MSG-002 — İki yönlü mesajlaşma

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-002 |
| **Başlık** | İki yönlü mesajlaşma |
| **Kategori** | Messaging |
| **Problem** | Tek yönlü bildirimler diyalog sağlamıyor |
| **Önerilen çözüm** | Konuşma içinde iki yönlü mesajlaşma |
| **Kullanıcı değeri** | Etkileşimli iletişim |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | MSG-001 |
| **Notlar** | v1.0 dışı aday. **DaySmart (observed):** global Inbox + Two-Way SMS — → [daysmart.md](../competitors/daysmart.md#platform-inbox) |

### MSG-003 — Konuşmaya attachment

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-003 |
| **Başlık** | Konuşmaya attachment |
| **Kategori** | Messaging |
| **Problem** | Mesajla dosya paylaşımı yapılamıyor |
| **Önerilen çözüm** | Konuşmaya dosya ekleme |
| **Kullanıcı değeri** | Zengin iletişim |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | MSG-002 |
| **Notlar** | v1.0 dışı aday |

### MSG-004 — Konuşmadan görev oluşturma

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-004 |
| **Başlık** | Konuşmadan görev oluşturma |
| **Kategori** | Messaging |
| **Problem** | Mesajdan takip görevi manuel oluşturuluyor |
| **Önerilen çözüm** | Konuşmadan görev oluşturma aksiyonu |
| **Kullanıcı değeri** | Operasyonel takip |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | MSG-001 |
| **Notlar** | v1.0 dışı aday. Client/Contact/Global task read-models — shared Task domain (**implementation inferred**) — → [daysmart.md](../competitors/daysmart.md#platform-global-tasks), [PATTERN-026](../research/patterns.md#pattern-026--unified-task-worklist). Reminder **değil** |

### MSG-005 — Konuşmayı hasta ile ilişkilendirme

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-005 |
| **Başlık** | Konuşmayı hasta ile ilişkilendirme |
| **Kategori** | Messaging |
| **Problem** | Konuşma hangi hayvanla ilgili belirsiz kalabilir |
| **Önerilen çözüm** | Konuşmayı bir hasta kaydı ile ilişkilendirme |
| **Kullanıcı değeri** | Hasta odaklı iletişim |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | MSG-001 |
| **Notlar** | → [PATTERN-015](../research/patterns.md#pattern-015--conversation-to-patient-context) |

### MSG-006 — Konuşma arşivleme ve kapatma

| Alan | Değer |
|---|---|
| **Kimlik** | MSG-006 |
| **Başlık** | Konuşma arşivleme ve kapatma |
| **Kategori** | Messaging |
| **Problem** | Kapatılan konuşmalar kaybolabilir |
| **Önerilen çözüm** | Konuşmayı kapatma; müşteri iletişim geçmişine taşıma; silme |
| **Kullanıcı değeri** | Temiz inbox; erişilebilir geçmiş |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | MSG-001 |
| **Notlar** | Sağ panel müşteri bağlamı → [PATTERN-015](../research/patterns.md#pattern-015--conversation-to-patient-context). **Clients Module:** Client Communications geçmişi. **Contacts Module:** Contact/Company communication feed — shared source — → [daysmart.md](../competitors/daysmart.md#contact-communications) |

---

## TIMELINE — Hasta geçmişi

### TIMELINE-001 — Hasta timeline

| Alan | Değer |
|---|---|
| **Kimlik** | TIMELINE-001 |
| **Başlık** | Hasta timeline |
| **Kategori** | Timeline |
| **Problem** | Hasta geçmişi modüller arasında dağınık |
| **Önerilen çözüm** | Kronolojik birleşik timeline görünümü |
| **Kullanıcı değeri** | Tek bakışta hasta hikâyesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | TIMELINE-002 |
| **Notlar** | → [ADR-006](../decisions/ADR-006-patient-timeline.md). **Canlı sandbox — Patients Module:** Patient Dashboard klinik kayıt merkezi; Overview due list + snapshot vitals; History filtreleri (Records…Communications, More); patient-scoped read-models → [daysmart.md](../competitors/daysmart.md#sandbox--patients-module). **E-Vet SMART (2026-09-24):** hasta bağlamında sol nav (randevu/ziyaret, muayene/aşı, lab/xray/pacs, hospitalizasyon, ekstre, dosya, form); E-Vet IA kopyalanmaz — → [e-vet.md](../competitors/e-vet.md#hasta-kartı--patient-workspace) |

### TIMELINE-002 — Timeline olay modeli

| Alan | Değer |
|---|---|
| **Kimlik** | TIMELINE-002 |
| **Başlık** | Timeline olay modeli |
| **Kategori** | Timeline |
| **Problem** | Timeline ayrı veri deposu olmamalı |
| **Önerilen çözüm** | Mevcut modül kayıtlarının birleştirilmiş görünümü |
| **Kullanıcı değeri** | Veri tutarlılığı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | — |
| **Notlar** | Ayrı kopya yok. **Patients/Clients/Contacts/Inventory Modules** — scoped read-models. **Reports Module:** operational → entity read-model → clinic-wide report → dashboard KPI; report-only duplicate source yok — → [daysmart.md](../competitors/daysmart.md#reports-architecture), [ADR-006](../decisions/ADR-006-patient-timeline.md) |

### TIMELINE-003 — Timeline filtreleri

| Alan | Değer |
|---|---|
| **Kimlik** | TIMELINE-003 |
| **Başlık** | Timeline filtreleri |
| **Kategori** | Timeline |
| **Problem** | Uzun geçmişte kayıt bulmak zor |
| **Önerilen çözüm** | Olay türü, tarih aralığı filtreleri |
| **Kullanıcı değeri** | Hızlı geçmiş taraması |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): backend tür/tarih/iptal süzgeçleri tam; frontend tarih aralığı süzgeci doğrulanmadı |
| **Bağımlılıklar** | TIMELINE-001 |
| **Notlar** | DaySmart sandbox — History filtreleri… **Clients Module:** Declined Items client billing + patient History More — shared source — → [daysmart.md](../competitors/daysmart.md#client-billing). **E-Vet SMART:** Ziyaret Geçmişi tarih aralığı filtresi — → [e-vet.md](../competitors/e-vet.md#ziyaret-geçmişi) |

| Alan | Değer |
|---|---|
| **Kimlik** | TIMELINE-004 |
| **Başlık** | Timeline derin bağlantıları |
| **Kategori** | Timeline |
| **Problem** | Timeline'dan ilgili kayda geçiş gerekli |
| **Önerilen çözüm** | Her olay kaynağına derin link |
| **Kullanıcı değeri** | Keşiften detaya akış |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TIMELINE-001 |
| **Notlar** | Derin linkler genel prensip. **Canlı sandbox — Patients Module:** History Reference → medical note; Invoice kolonu; Communications dynamic content → [daysmart.md](../competitors/daysmart.md#patient-profile--history) |

---

## IMG — Görüntüleme

### IMG-001 — Görüntüleme kayıtları

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-001 |
| **Başlık** | Görüntüleme kayıtları |
| **Kategori** | Görüntüleme |
| **Problem** | Röntgen yalnızca dosya yükleme olarak düşünülmemeli |
| **Önerilen çözüm** | Imaging modülü; hayvan, muayene, timeline bağlantılı kayıtlar |
| **Kullanıcı değeri** | Klinik görüntü yönetimi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; migration uygulanması ve tarayıcı denemesi doğrulanmadı) |
| **Bağımlılıklar** | — |
| **Notlar** | → [ADR-007](../decisions/ADR-007-imaging-module.md). **Canlı sandbox — Patients Module:** Patient History > Images; clinic-wide Images worklist (View Online NON_INTEGRATED) — patient vs clinic scope → [daysmart.md](../competitors/daysmart.md#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics). **E-Vet SMART (2026-09-29):** Ayrı global **Pacs İstekleri** populated worklist + patient **Pacs Geçmişi** / **Yeni Pacs İstek**; **Xray İstekleri** ayrı yüzey ([PARTIAL](../competitors/e-vet.md#global-xray-i̇stekleri-partial)). Imaging operasyon ≠ generic **Dosyalarım** — → [e-vet.md](../competitors/e-vet.md#global-pacs-i̇stekleri-modül) |

### IMG-002 — Röntgen yükleme ve görüntüleme

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-002 |
| **Başlık** | Röntgen yükleme ve görüntüleme |
| **Kategori** | Görüntüleme |
| **Problem** | Röntgen kayıtları yapılandırılmamış |
| **Önerilen çözüm** | Röntgen türü; tarih, açıklama, klinik not |
| **Kullanıcı değeri** | Düzenli röntgen arşivi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | IMG-001 |
| **Notlar** | |

### IMG-003 — Ultrason kayıtları

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-003 |
| **Başlık** | Ultrason kayıtları |
| **Kategori** | Görüntüleme |
| **Problem** | Ultrason ayrı tür olarak desteklenmeli |
| **Önerilen çözüm** | Ultrason görüntü türü |
| **Kullanıcı değeri** | Tam görüntüleme kapsamı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | IMG-001 |
| **Notlar** | |

### IMG-004 — Klinik fotoğraf ve video

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-004 |
| **Başlık** | Klinik fotoğraf ve video |
| **Kategori** | Görüntüleme |
| **Problem** | Klinik fotoğraf/video genel dosya olarak kayboluyor |
| **Önerilen çözüm** | Klinik fotoğraf ve video türleri |
| **Kullanıcı değeri** | Görsel klinik kayıt |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; video kapsam dışı, ADR-007) |
| **Bağımlılıklar** | IMG-001 |
| **Notlar** | |

### IMG-005 — DICOM desteği araştırması

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-005 |
| **Başlık** | DICOM desteği araştırması |
| **Kategori** | Görüntüleme |
| **Problem** | DICOM standart veteriner görüntülemede yaygın |
| **Önerilen çözüm** | DICOM okuma/görüntüleme fizibilite çalışması |
| **Kullanıcı değeri** | Profesyonel görüntüleme |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | IMG-001 |
| **Notlar** | **E-Vet SMART (2026-09-29):** **Pacs İstekleri** > **İncele** on a **CR** record opened **Fujifilm Synapse Mobility** in a separate web viewer; real radiographic images and **DICOM-style** study/series/image metadata visible in the external viewer. Exact integration protocol / storage ownership **not verified** — → [e-vet.md](../competitors/e-vet.md#cr--external-pacs-viewer-handoff) |

### IMG-006 — Dijital röntgen cihazı entegrasyonu araştırması

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-006 |
| **Başlık** | Dijital röntgen cihazı entegrasyonu araştırması |
| **Kategori** | Görüntüleme |
| **Problem** | Cihazdan otomatik veri alma ayrı seviye |
| **Önerilen çözüm** | Partner ve protokol araştırması |
| **Kullanıcı değeri** | Manuel yükleme azalır |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | IMG-001, INT-002 |
| **Notlar** | Temel dosya yönetimiyle aynı özellik değil |

### IMG-007 — Görüntüleme ile muayene bağlantısı

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-007 |
| **Başlık** | Görüntüleme ile muayene bağlantısı |
| **Kategori** | Görüntüleme |
| **Problem** | Görüntüler muayeneden kopuk |
| **Önerilen çözüm** | Görüntüleme kaydı muayeneyle ilişkilendirilebilir |
| **Kullanıcı değeri** | Klinik bağlam |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | IMG-001, EXAM-001 |
| **Notlar** | |

### IMG-008 — Görüntüleme ile timeline bağlantısı

| Alan | Değer |
|---|---|
| **Kimlik** | IMG-008 |
| **Başlık** | Görüntüleme ile timeline bağlantısı |
| **Kategori** | Görüntüleme |
| **Problem** | Görüntüler timeline'da görünmeli |
| **Önerilen çözüm** | Görüntüleme olayları timeline'da |
| **Kullanıcı değeri** | Birleşik hasta geçmişi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | IMG-001, TIMELINE-001 |
| **Notlar** | **Canlı sandbox — Patients Module:** Images History filter; diagnostic record ≠ generic attachment — → [daysmart.md](../competitors/daysmart.md#pharmacy--labs--images--vaccines--vitals--communications) |

---

## AI — Yapay zeka

### AI-001 — AI muayene notu yapılandırma

| Alan | Değer |
|---|---|
| **Kimlik** | AI-001 |
| **Başlık** | AI muayene notu yapılandırma |
| **Kategori** | AI |
| **Problem** | Serbest metin muayene notları yapılandırılmamış kalıyor |
| **Önerilen çözüm** | Serbest notu şikâyet, bulgu, değerlendirme, plan alanlarına yapılandır |
| **Kullanıcı değeri** | Hız; tutarlı kayıt |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001, AI-009 |
| **Notlar** | → [AI roadmap Aşama 1](../ai/ai-roadmap.md) |

### AI-002 — AI hasta geçmişi özeti

| Alan | Değer |
|---|---|
| **Kimlik** | AI-002 |
| **Başlık** | AI hasta geçmişi özeti |
| **Kategori** | AI |
| **Problem** | Uzun hasta geçmişi hızlıca taranamıyor |
| **Önerilen çözüm** | Hasta geçmişini özetleyen AI yardımcı |
| **Kullanıcı değeri** | Muayene öncesi hızlı hazırlık |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TIMELINE-001, AI-009 |
| **Notlar** | Taslak; kullanıcı onayı gerekir |

### AI-003 — AI hasta sahibi bilgilendirmesi

| Alan | Değer |
|---|---|
| **Kimlik** | AI-003 |
| **Başlık** | AI hasta sahibi bilgilendirmesi |
| **Kategori** | AI |
| **Problem** | Teknik klinik notları hasta sahibine uygun değil |
| **Önerilen çözüm** | Sade açıklama taslağı hazırla |
| **Kullanıcı değeri** | İletişim hızı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-009 |
| **Notlar** | Taslak statüsü |

### AI-004 — AI taburcu talimatı

| Alan | Değer |
|---|---|
| **Kimlik** | AI-004 |
| **Başlık** | AI taburcu talimatı |
| **Kategori** | AI |
| **Problem** | Taburcu/evde bakım talimatları tekrarlı yazılıyor |
| **Önerilen çözüm** | Taburcu veya evde bakım talimatı taslağı |
| **Kullanıcı değeri** | Zaman tasarrufu |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-009 |
| **Notlar** | Taslak statüsü |

### AI-005 — Speech-to-text

| Alan | Değer |
|---|---|
| **Kimlik** | AI-005 |
| **Başlık** | Speech-to-text |
| **Kategori** | AI |
| **Problem** | Muayene sırasında yazmak zaman alıyor |
| **Önerilen çözüm** | Konuşmayı metne dönüştürme değerlendirmesi |
| **Kullanıcı değeri** | Eller serbest not alma |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | → [AI roadmap Aşama 2](../ai/ai-roadmap.md). DaySmart STT penceresi gözlemlendi (~20 dk süre); teknik sağlayıcı doğrulanmadı. **v1.0 dışı aday**; premium/ileri faz → [IDEA-022](../research/ideas.md#idea-022--voice-assisted-clinical-documentation). Snippet sisteminden ayrı. Bağlamsal özet yan paneli (Summarize/SOAP summary) STT değildir → [AI-102](#ai-102--patient-summary), [AI-103](#ai-103--examination-assistant), [IDEA-008](../research/ideas.md#idea-008--embedded-ai-instead-of-separate-ai-module) |

### AI-006 — Doğal dille hasta kayıtlarında arama

| Alan | Değer |
|---|---|
| **Kimlik** | AI-006 |
| **Başlık** | Doğal dille hasta kayıtlarında arama |
| **Kategori** | AI |
| **Problem** | Yapılandırılmış arama karmaşık sorguları desteklemiyor |
| **Önerilen çözüm** | Doğal dil arama |
| **Kullanıcı değeri** | Hızlı kayıt bulma |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | |

### AI-007 — AI kullanım kotası

| Alan | Değer |
|---|---|
| **Kimlik** | AI-007 |
| **Başlık** | AI kullanım kotası |
| **Kategori** | AI |
| **Problem** | AI maliyeti kontrolsüz artabilir |
| **Önerilen çözüm** | Tenant ve plan bazlı kullanım kotası |
| **Kullanıcı değeri** | Öngörülebilir maliyet |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Claim ve abonelik planı ile sınırlandırılabilir |

### AI-008 — AI maliyet takibi

| Alan | Değer |
|---|---|
| **Kimlik** | AI-008 |
| **Başlık** | AI maliyet takibi |
| **Kategori** | AI |
| **Problem** | AI maliyeti görünür olmalı |
| **Önerilen çözüm** | Kullanım ve maliyet metrikleri |
| **Kullanıcı değeri** | Operasyonel kontrol |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-007 |
| **Notlar** | |

### AI-009 — AI çıktı onay akışı

| Alan | Değer |
|---|---|
| **Kimlik** | AI-009 |
| **Başlık** | AI çıktı onay akışı |
| **Kategori** | AI |
| **Problem** | AI çıktıları otomatik kayıt olmamalı |
| **Önerilen çözüm** | Taslak → kullanıcı inceleme → onay → kayıt |
| **Kullanıcı değeri** | Klinik güvenlik |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | → [AI stratejisi](../ai/ai-strategy.md) |

### AI-010 — AI audit metadatası

| Alan | Değer |
|---|---|
| **Kimlik** | AI-010 |
| **Başlık** | AI audit metadatası |
| **Kategori** | AI |
| **Problem** | AI kullanımı izlenebilir olmalı |
| **Önerilen çözüm** | AI istek/yanıt audit kayıtları (hassas veri loglanmadan) |
| **Kullanıcı değeri** | Uyumluluk; sorun giderme |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Hassas klinik veriler normal loglara yazılmaz |

---

### Epic AI-100 — Embedded Clinical Intelligence

| Alan | Değer |
|---|---|
| **Kimlik** | AI-100 |
| **Başlık** | Embedded Clinical Intelligence |
| **Kategori** | AI (Epic) |
| **Açıklama** | Vetinity'de yapay zekâ ayrı bir modül veya sohbet ekranı olarak değil, kullanıcıların çalıştığı ekranların doğal bir parçası olarak konumlandırılır. AI, veri özetleme, doğal dil sorgulama, karar desteği ve iş akışı hızlandırma amacıyla kullanılır. Klinik kararın sorumluluğu her zaman veteriner hekime aittir. |
| **Öncelik** | P1 |
| **Durum** | Planlandı |
| **Alt maddeler** | AI-101, AI-102, AI-103, AI-104, AI-105, AI-106, AI-107, AI-108 |
| **Notlar** | Bu Epic, E-vet Smart Plus'ın SmartAI yaklaşımı incelendikten sonra oluşturulmuştur. Ancak Vetinity'nin hedefi AI'ı ayrı bir ekran yerine ürünün tamamına gömülü şekilde sunmaktır. SmartAI'daki doğal dil sorgulama ve hasta özeti yaklaşımları ürün vizyonu için referans alınmış, ancak kapsam muayene, timeline ve klinik iş akışlarını kapsayacak şekilde genişletilmiştir. → [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md), [AI stratejisi](../ai/ai-strategy.md) |

#### AI-101 — AI Business Copilot

| Alan | Değer |
|---|---|
| **Kimlik** | AI-101 |
| **Başlık** | AI Business Copilot |
| **Kategori** | AI |
| **Problem** | Klinik yöneticisi günlük işletme verilerine hızlı erişmek için birden fazla ekrana gitmek zorunda |
| **Önerilen çözüm** | Doğal dil ile işletme sorgulama: günlük ciro, bekleyen randevular, kritik stok, borç bakiyesi, günlük işletme özeti |
| **Kullanıcı değeri** | Dashboard ve raporlar arasında gezinmeden anlık işletme görünürlüğü |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009 |
| **Notlar** | Gömülü yardımcı; ayrı sohbet ekranı değil. **Inventory Module:** DaySmart Inventory Alerts (low balance, expiring); item Actions low-balance threshold — operasyonel alert UI ayrı değerlendirme → [daysmart.md](../competitors/daysmart.md#inventory-alerts) |

#### AI-102 — Patient Summary

| Alan | Değer |
|---|---|
| **Kimlik** | AI-102 |
| **Başlık** | Patient Summary |
| **Kategori** | AI |
| **Problem** | Uzun hasta geçmişi muayene öncesi hızlıca taranamıyor |
| **Önerilen çözüm** | Hasta geçmişini tek ekranda özetle: önemli olaylar, kronik problemler, tekrarlayan hastalıklar, aşı geçmişi, operasyon geçmişi, laboratuvar trendleri |
| **Kullanıcı değeri** | Muayene öncesi hızlı klinik hazırlık |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009, TIMELINE-001 |
| **Notlar** | AI-002 ile ilişkili; Epic kapsamında genişletilmiş hasta özeti. DaySmart sandbox observation (~28:13–35:25): hasta profilinde bağlamlı AI yan paneli; aktif hasta otomatik bağlam; Summarize aksiyonu; hasta geçmişi/SOAP/ilaçlar kapsamı; AI hata uyarısı. **v1.0 dışı aday**; insan doğrulaması → [AI-009](#ai-009--ai-çıktı-onay-akışı). Halüsinasyon/klinik güvenlik riski; kaynak kapsamı doğrulanmadı |

#### AI-103 — Examination Assistant

| Alan | Değer |
|---|---|
| **Kimlik** | AI-103 |
| **Başlık** | Examination Assistant |
| **Kategori** | AI |
| **Problem** | Muayene notları düzensiz, yapılandırılmamış veya iyileştirme gerektiriyor |
| **Önerilen çözüm** | Muayene notlarını düzenleme; yapısal özet oluşturma; hekimin notlarını iyileştirme |
| **Kullanıcı değeri** | Tutarlı ve okunabilir muayene kayıtları; zaman tasarrufu |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009, EXAM-001 |
| **Notlar** | AI-001 ile ilişkili; muayene ekranına gömülü. DaySmart sandbox observation (~28:13–35:25): SOAP summary hazır aksiyonu; klinik kaynaklarla sınırlı özet adayı. Çıktı doğrulanmadan kayda geçmemeli → [AI-009](#ai-009--ai-çıktı-onay-akışı). **v1.0 dışı aday** |

#### AI-104 — Timeline Insights

| Alan | Değer |
|---|---|
| **Kimlik** | AI-104 |
| **Başlık** | Timeline Insights |
| **Kategori** | AI |
| **Problem** | Uzun timeline'da kritik değişimler manuel taramayla bulunuyor |
| **Önerilen çözüm** | Timeline içerisindeki önemli değişimleri otomatik işaretleme |
| **Kullanıcı değeri** | Hasta hikâyesindeki dönüm noktalarının hızlı fark edilmesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009, TIMELINE-001 |
| **Notlar** | Tanı koymaz; önemli olay vurgusu |

#### AI-105 — Laboratory Summary

| Alan | Değer |
|---|---|
| **Kimlik** | AI-105 |
| **Başlık** | Laboratory Summary |
| **Kategori** | AI |
| **Problem** | Çok sayıda lab sonucu arasında anormal değerler hızlıca ayırt edilemiyor |
| **Önerilen çözüm** | Laboratuvar sonuçlarını özetleme; anormal değişimleri vurgulama |
| **Kullanıcı değeri** | Lab yorumlamasında hız; kritik değerlere odaklanma |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009 |
| **Notlar** | Kesin tanı veya tedavi önerisi vermez; taslak özet |

#### AI-106 — Imaging Summary

| Alan | Değer |
|---|---|
| **Kimlik** | AI-106 |
| **Başlık** | Imaging Summary |
| **Kategori** | AI |
| **Problem** | Görüntüleme kayıtları arasında bağlam ve özet eksik |
| **Önerilen çözüm** | Röntgen / görüntüleme kayıtları için özet oluşturma |
| **Kullanıcı değeri** | Görüntüleme geçmişinin hızlı taranması |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009, IMG-001 |
| **Notlar** | Tanı koymaz; yalnızca kayıt özeti |

#### AI-107 — Discharge Assistant

| Alan | Değer |
|---|---|
| **Kimlik** | AI-107 |
| **Başlık** | Discharge Assistant |
| **Kategori** | AI |
| **Problem** | Taburcu ve evde bakım talimatları tekrarlı ve zaman alıcı |
| **Önerilen çözüm** | Hasta sahibine uygun taburculuk ve bakım talimatı taslağı oluşturma |
| **Kullanıcı değeri** | İletişim hızı; tutarlı hasta sahibi bilgilendirmesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009 |
| **Notlar** | AI-004 ile ilişkili; taslak statüsü |

#### AI-108 — Client Communication Assistant

| Alan | Değer |
|---|---|
| **Kimlik** | AI-108 |
| **Başlık** | Client Communication Assistant |
| **Kategori** | AI |
| **Problem** | SMS, WhatsApp ve e-posta taslakları manuel yazılıyor |
| **Önerilen çözüm** | SMS / WhatsApp / e-posta taslakları oluşturma |
| **Kullanıcı değeri** | Hasta sahibi iletişiminde hız |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AI-100, AI-009, INT-003, INT-004 |
| **Notlar** | Gönderim kullanıcı onayı ile; trial'da gerçek gönderim kısıtlanabilir |

---

## APPT — Online booking ve randevu talepleri

> **Kaynak:** [DaySmart Vet — 2026-08-02 benchmark](../competitors/daysmart.md#2026-08-02--randevu-online-booking-ve-petcare-akışı)  
> **Not:** Online booking v1.0 Release Blocker değildir. SMS, WhatsApp, depozito ve widget ilk faza çekilmemiştir.

### APPT-001 — Kliniğe özel online randevu sayfası

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-001 |
| **Başlık** | Kliniğe özel online randevu sayfası |
| **Kategori** | Online booking |
| **Problem** | Hasta sahibi klinik dışı kanallardan randevu almak zorunda kalabilir |
| **Önerilen çözüm** | Klinik markasına ait public online randevu arayüzü |
| **Kullanıcı değeri** | 7/24 talep; klinik telefon yükü azalır |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-002, APPT-009 |
| **Notlar** | → [IDEA-010](../research/ideas.md#idea-010--clinic-branded-online-booking) |

### APPT-002 — Klinik bazlı benzersiz randevu bağlantısı

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-002 |
| **Başlık** | Klinik bazlı benzersiz randevu bağlantısı |
| **Kategori** | Online booking |
| **Problem** | Her klinik için paylaşılabilir tek giriş noktası gerekir |
| **Önerilen çözüm** | Tenant/klinik bazlı benzersiz URL veya token |
| **Kullanıcı değeri** | Web sitesi, sosyal medya ve QR ile paylaşım |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Widget/iframe öncesi minimum entegrasyon |

### APPT-003 — Hasta sahibi kayıtlı hayvan seçimi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-003 |
| **Başlık** | Hasta sahibi kayıtlı hayvan seçimi |
| **Kategori** | Online booking |
| **Problem** | Yanlış hayvan için talep oluşabilir |
| **Önerilen çözüm** | Oturum/kimlik sonrası kayıtlı hayvan listesinden seçim |
| **Kullanıcı değeri** | Doğru hasta bağlamı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001 |
| **Notlar** | Kimlik modeli araştırılacak |

### APPT-004 — Online akışta yeni hayvan ekleme

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-004 |
| **Başlık** | Online akışta yeni hayvan ekleme |
| **Kategori** | Online booking |
| **Problem** | Yeni hayvan için akıştan çıkmak gerekir |
| **Önerilen çözüm** | Online booking içinde minimal hayvan oluşturma |
| **Kullanıcı değeri** | Kesintisiz talep |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-003 |
| **Notlar** | → [IDEA-009](../research/ideas.md#idea-009--context-preserving-inline-entity-creation) |

### APPT-005 — Tanımlanabilir randevu nedenleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-005 |
| **Başlık** | Tanımlanabilir randevu nedenleri |
| **Kategori** | Online booking |
| **Problem** | Serbest metin talepler standartlaşmaz |
| **Önerilen çözüm** | Klinik yapılandırılabilir ziyaret nedeni listesi |
| **Kullanıcı değeri** | Doğru süre, kaynak ve iş akışı eşleşmesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Equine vb. segmentler target-markets ile uyumlu değerlendirilmeli. **Settings Module:** Appointment Types = workflow preset (medical note, bundle, forms, reminders, eligibility) — metadata-only değil — → [daysmart.md](../competitors/daysmart.md#settings-appointment-types) |

### APPT-006 — Randevu nedeni varsayılan süre

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-006 |
| **Başlık** | Randevu nedeni varsayılan süre |
| **Kategori** | Online booking |
| **Problem** | Yanlış slot süresi takvim çakışması yaratır |
| **Önerilen çözüm** | Neden bazlı varsayılan süre yapılandırması |
| **Kullanıcı değeri** | Doğru müsaitlik hesabı |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-005 |
| **Notlar** | DaySmart sandbox: randevu türü varsayılan süre taşıyor (ör. 15 dk wellness). **Settings Module:** Appointment Types — Name, Duration, Color, Book Online, Pre-visit Confirmation, Default, Rules; workflow preset (medical note, bundle, forms, reminders, eligibility species/weight/age) — → [daysmart.md](../competitors/daysmart.md#settings-appointment-types). **E-Vet SMART:** Yeni Randevu **Süre (dk)**; 30 dk slot ızgarası — kapasite kuralları **TBD** → [e-vet.md](../competitors/e-vet.md#randevular). Global Takvim Düzenle / **+ Yeni Randevu** **Süre (dk)** — slot ızgarası **gözlemlenmedi** → [e-vet.md](../competitors/e-vet.md#mevcut-randevu--düzenle-modal) |

### APPT-007 — Neden ile hekim/kaynak eşleştirmesi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-007 |
| **Başlık** | Neden ile hekim/kaynak eşleştirmesi |
| **Kategori** | Online booking |
| **Problem** | Her neden her hekime uygun değildir |
| **Önerilen çözüm** | Randevu nedeni → uygun hekim/kaynak kuralları |
| **Kullanıcı değeri** | Daha az red; doğru yönlendirme |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-005, APPT-025 |
| **Notlar** | → [IDEA-014](../research/ideas.md#idea-014--configurable-scheduling-resources) |

### APPT-008 — Yalnızca müsait gün ve saatler

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-008 |
| **Başlık** | Yalnızca müsait gün ve saatler |
| **Kategori** | Online booking |
| **Problem** | Uyumsuz slot talebi operasyonel yük |
| **Önerilen çözüm** | Müsaitlik motoru ile filtrelenmiş slot listesi |
| **Kullanıcı değeri** | Hızlı self-service; daha az red |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-006, APPT-007 |
| **Notlar** | → [IDEA-012](../research/ideas.md#idea-012--availability-only-booking), [PATTERN-009](../research/patterns.md#pattern-009--availability-driven-self-service) |

### APPT-009 — Randevu talebi oluşturma

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-009 |
| **Başlık** | Randevu talebi oluşturma |
| **Kategori** | Online booking |
| **Problem** | Online self-service kesin randevu riski |
| **Önerilen çözüm** | Hasta sahibi talep kaydı; klinik onayı bekleyen durum |
| **Kullanıcı değeri** | Klinik kontrolü korunur |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001, APPT-008 |
| **Notlar** | Doğrudan onaylı randevu zorunlu değil → [PATTERN-008](../research/patterns.md#pattern-008--request-to-confirmation-workflow) |

### APPT-010 — Bekleyen randevu talepleri kuyruğu

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-010 |
| **Başlık** | Bekleyen randevu talepleri kuyruğu |
| **Kategori** | Online booking |
| **Problem** | Talepler takvimde kaybolabilir |
| **Önerilen çözüm** | Ayrı inceleme kuyruğu listesi |
| **Kullanıcı değeri** | Resepsiyon/ekip için net iş listesi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-009 |
| **Notlar** | → [IDEA-011](../research/ideas.md#idea-011--appointment-request-review-queue) |

### APPT-011 — Kabul, reddet, yeniden planla

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-011 |
| **Başlık** | Kabul, reddet, yeniden planla |
| **Kategori** | Online booking |
| **Problem** | Talep işleme aksiyonları dağınık olabilir |
| **Önerilen çözüm** | Accept / Reject / Reschedule / History aksiyon seti |
| **Kullanıcı değeri** | Standart operasyonel akış |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-010 |
| **Notlar** | Yetki modeli değerlendirilmeli |

### APPT-012 — Onay ve red mesaj şablonları

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-012 |
| **Başlık** | Onay ve red mesaj şablonları |
| **Kategori** | Online booking |
| **Problem** | Her kabul/redde sıfırdan mesaj yazımı |
| **Önerilen çözüm** | Şablon + önizleme; isteğe bağlı düzenleme |
| **Kullanıcı değeri** | Hız ve tutarlılık |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-011, APPT-013 |
| **Notlar** | → [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications), [PATTERN-011](../research/patterns.md#pattern-011--template-first-communication). **Settings Module:** Email Defaults — event/workflow template binding (Appointment Accept/Confirmation/Decline/Reminder, Invoice, Labs, Medical Note vb.) — → [daysmart.md](../competitors/daysmart.md#settings-email-defaults) |

### APPT-013 — E-posta bildirimleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-013 |
| **Başlık** | E-posta bildirimleri |
| **Kategori** | Online booking |
| **Problem** | Talep/kabul/red sonrası hasta sahibi bilgilendirilmeyebilir |
| **Önerilen çözüm** | Onay, red, hatırlatma e-postaları |
| **Kullanıcı değeri** | Şeffaf iletişim |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-012 |
| **Notlar** | Trial'da gerçek gönderim kısıtlanabilir. **Canlı sandbox — Boarding:** reservation event → otomatik transactional e-posta; unsubscribe footer — SMS/Mail altyapı ilişkisi **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#notification-flow). **Canlı sandbox — Reminders:** Resend selected toplu yeniden gönderim; Last Sent sütunu; Export print/download — → [daysmart.md](../competitors/daysmart.md#actions) |

### APPT-014 — Randevu hatırlatma tercihleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-014 |
| **Başlık** | Randevu hatırlatma tercihleri |
| **Kategori** | Online booking |
| **Problem** | Hatırlatma zamanı ve kanalı standart değil |
| **Önerilen çözüm** | Gün/kanal tercihi; devre dışı bırakma |
| **Kullanıcı değeri** | No-show azaltma |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): klinik düzeyi ayar ve müşteri kanal tercihi var; sahip tarafı devre dışı bırakma yok |
| **Bağımlılıklar** | APPT-013 |
| **Notlar** | Klinik içi randevu oluşturmada da geçerli olabilir. Default reminder/confirmation clinic policy — → [daysmart.md](../competitors/daysmart.md#config-observed-rows). Pre-visit workflow — → [CHECKIN-002](#checkin-002--check-in-sırasında-medical-note-şablonu), [PORTAL-005](#portal-005--dijital-onam-ve-imza). Reminder ≠ Task |

### APPT-015 — Bildirim merkezi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-015 |
| **Başlık** | Bildirim merkezi |
| **Kategori** | Online booking |
| **Problem** | Geçici toast sonrası olay kaybolur |
| **Önerilen çözüm** | Kalıcı bildirim listesi, rozet, tür filtresi |
| **Kullanıcı değeri** | Operasyonel olayların kaçmaması |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-009 |
| **Notlar** | → [IDEA-015](../research/ideas.md#idea-015--real-time-operational-notification-center). **DaySmart (observed):** bell drawer ~30 gün — → [daysmart.md](../competitors/daysmart.md#platform-notification-center). Notification ≠ Task; notification→task workflow ayrı — → [IDEA-015](../research/ideas.md#idea-015--real-time-operational-notification-center) |

### APPT-016 — Takvimde filtrelenebilir pending görünüm

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-016 |
| **Başlık** | Takvimde filtrelenebilir pending görünüm |
| **Kategori** | Online booking |
| **Problem** | Pending talepler takvimi yoğunlaştırabilir |
| **Önerilen çözüm** | Pending durum + filtre/gizleme seçenekleri |
| **Kullanıcı değeri** | Yoğun kliniklerde okunabilir takvim |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-009, APPT-010 |
| **Notlar** | Kuyruk ile birlikte değerlendirilmeli |

### APPT-017 — Inline müşteri oluşturma (klinik içi)

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-017 |
| **Başlık** | Inline müşteri oluşturma (klinik içi) |
| **Kategori** | Online booking |
| **Problem** | Randevu sırasında müşteri bulunamazsa akış kopar |
| **Önerilen çözüm** | Takvim/randevu akışında hızlı müşteri oluşturma |
| **Kullanıcı değeri** | Kesintisiz klinik randevu girişi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Normal müşteri CRUD korunur → [PATTERN-007](../research/patterns.md#pattern-007--context-preserving-creation). **Clients Module:** Client List (A–Z, Pets, Status); Client Dashboard analytics P3 — → [daysmart.md](../competitors/daysmart.md#client-dashboard--client-list). **Boarding reservation:** Add Client — [daysmart.md](../competitors/daysmart.md#new-reservation) |

### APPT-018 — Inline hasta oluşturma (klinik içi)

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-018 |
| **Başlık** | Inline hasta oluşturma (klinik içi) |
| **Kategori** | Online booking |
| **Problem** | Randevu sırasında hasta bulunamazsa akış kopar |
| **Önerilen çözüm** | Seçili müşteriye bağlı hızlı hasta oluşturma |
| **Kullanıcı değeri** | Kesintisiz klinik randevu girişi |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-017 |
| **Notlar** | Progressive disclosure ile minimal alan seti değerlendirilmeli. DaySmart sandbox: iç içe modal — drawer/stepper tercih edilmeli. **Patients Module:** Patient List status (Active/Inactive/Deceased+date); Edit Profile demographics; Sex display birleşik (liste) vs ayrı (header) — domain model kopyalanmamalı. Yaş/birthdate SOT **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#sandbox--patients-module) |

### APPT-019 — Oluşturulan kaydın randevu bağlamına geri bağlanması

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-019 |
| **Başlık** | Oluşturulan kaydın randevu bağlamına geri bağlanması |
| **Kategori** | Online booking |
| **Problem** | Inline oluşturma sonrası seçim kaybolabilir |
| **Önerilen çözüm** | Yeni müşteri/hasta otomatik randevu formuna atanır |
| **Kullanıcı değeri** | Duplicate giriş önlenir |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-017, APPT-018 |
| **Notlar** | → [Product Principles — Minimize Duplicate Data Entry](../vision/product-principles.md) |

### APPT-020 — Kopyalanabilir HTML randevu butonu

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-020 |
| **Başlık** | Kopyalanabilir HTML randevu butonu |
| **Kategori** | Online booking |
| **Problem** | Klinik web sitesine entegrasyon zor |
| **Önerilen çözüm** | Book Appointment HTML snippet |
| **Kullanıcı değeri** | Hızlı web entegrasyonu |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001, APPT-002 |
| **Notlar** | — |

### APPT-021 — iframe embed kodu

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-021 |
| **Başlık** | iframe embed kodu |
| **Kategori** | Online booking |
| **Problem** | Bazı klinikler tam sayfa yönlendirme istemez |
| **Önerilen çözüm** | iframe embed snippet |
| **Kullanıcı değeri** | Site içi deneyim |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001 |
| **Notlar** | Güvenlik ve responsive davranış değerlendirilmeli |

### APPT-022 — Klinik logo ve renk özelleştirmesi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-022 |
| **Başlık** | Klinik logo ve renk özelleştirmesi |
| **Kategori** | Online booking |
| **Problem** | Generic booking sayfası marka güveni düşürür |
| **Önerilen çözüm** | Logo, renk ve temel marka alanları |
| **Kullanıcı değeri** | Klinik markası korunur |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001 |
| **Notlar** | — |

### APPT-023 — SMS bildirimleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-023 |
| **Başlık** | SMS bildirimleri |
| **Kategori** | Online booking |
| **Problem** | E-posta tek başına yetersiz kalabilir |
| **Önerilen çözüm** | Onay/hatırlatma SMS kanalı |
| **Kullanıcı değeri** | Daha yüksek ulaşılabilirlik |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-013, INT-003 |
| **Notlar** | İlk faz zorunluluğu değil; trial kısıtı. **Canlı sandbox — Reminders:** Type SMS (Text) reminder listesi ve Edit Reminder'da seçenek; Filter Types çoklu seçim — → [daysmart.md](../competitors/daysmart.md#reminders-detail-ana-tablo) |

### APPT-024 — Randevu talebi geçmişi ve denetim izi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-024 |
| **Başlık** | Randevu talebi geçmişi ve denetim izi |
| **Kategori** | Online booking |
| **Problem** | Kabul/red kararları izlenemeyebilir |
| **Önerilen çözüm** | Talep durum geçmişi ve audit metadata |
| **Kullanıcı değeri** | Hesap verebilirlik |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-011 |
| **Notlar** | DaySmart sandbox — Census satırından Appointment History: gözlemlenen örnekte created olayı, zaman ve kullanıcı; tam randevu yaşam döngüsü **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#appointment-history) |

### APPT-025 — Kaynak bazlı takvim

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-025 |
| **Başlık** | Kaynak bazlı takvim |
| **Kategori** | Online booking |
| **Problem** | Yalnızca hekim kolonu yetersiz kalabilir |
| **Önerilen çözüm** | Hekim, oda, walk-in, ekipman kolonları |
| **Kullanıcı değeri** | Gerçekçi planlama |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | → [PATTERN-012](../research/patterns.md#pattern-012--configurable-resource-calendar). DaySmart sandbox: gün/hafta, hekim + Tech Appts kolonları, All Columns, boş hücre → randevu modalı — sandbox gözlemi. **Canlı sandbox — Boarding:** oda-kaynak timeline; Max:N kapasite; gün/hafta/ay — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#reservation-calendar). **E-Vet SMART:** Yeni Randevu — Bölüm + Veteriner seçimi; slot ızgarası — → [e-vet.md](../competitors/e-vet.md#randevular). Global **Randevular** Ay/Hafta/Gün + Bölüm/Veteriner filtre — → [e-vet.md](../competitors/e-vet.md#randevular--global-calendar) |

### APPT-026 — Kayıtlı filtreler ve talep görünüm tercihleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-026 |
| **Başlık** | Kayıtlı filtreler ve talep görünüm tercihleri |
| **Kategori** | Online booking |
| **Problem** | Tekrarlayan filtreleme yükü |
| **Önerilen çözüm** | Kayıtlı takvim/kuyruk filtreleri |
| **Kullanıcı değeri** | Kişisel verimlilik |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-010, APPT-016 |
| **Notlar** | — |

### APPT-027 — JavaScript booking widget

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-027 |
| **Başlık** | JavaScript booking widget |
| **Kategori** | Online booking |
| **Problem** | iframe dışı esnek entegrasyon |
| **Önerilen çözüm** | JS embed widget |
| **Kullanıcı değeri** | Gelişmiş site entegrasyonu |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | APPT-021 |
| **Notlar** | İlk sürüm zorunluluğu değil |

### APPT-028 — Online depozito

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-028 |
| **Başlık** | Online depozito |
| **Kategori** | Online booking |
| **Problem** | No-show riski |
| **Önerilen çözüm** | Randevu nedeni bazlı depozito tahsilatı |
| **Kullanıcı değeri** | Klinik korunması |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | APPT-005, INT-006 |
| **Notlar** | → [IDEA-016](../research/ideas.md#idea-016--deposit-aware-appointment-types) |

### APPT-029 — Depozito iade ve iptal politikaları

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-029 |
| **Başlık** | Depozito iade ve iptal politikaları |
| **Kategori** | Online booking |
| **Problem** | Depozito operasyonel belirsizlik |
| **Önerilen çözüm** | İptal/iade kural yapılandırması |
| **Kullanıcı değeri** | Şeffaf hasta sahibi deneyimi |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | APPT-028 |
| **Notlar** | — |

### APPT-030 — WhatsApp bildirimleri

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-030 |
| **Başlık** | WhatsApp bildirimleri |
| **Kategori** | Online booking |
| **Problem** | Türkiye'de WhatsApp tercih edilir |
| **Önerilen çözüm** | Onay/hatırlatma WhatsApp kanalı |
| **Kullanıcı değeri** | Yüksek ulaşılabilirlik |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-013, INT-004 |
| **Notlar** | İlk faz dışı |

### APPT-031 — Google Calendar senkronizasyonu

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-031 |
| **Başlık** | Google Calendar senkronizasyonu |
| **Kategori** | Online booking |
| **Problem** | Hekim kişisel takviminde görünmez |
| **Önerilen çözüm** | Google Calendar sync |
| **Kullanıcı değeri** | Kişisel planlama uyumu |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | — |
| **Notlar** | — |

### APPT-032 — .ics / Apple Calendar / Outlook desteği

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-032 |
| **Başlık** | .ics / Apple Calendar / Outlook desteği |
| **Kategori** | Online booking |
| **Problem** | Takvim dışa aktarım ihtiyacı |
| **Önerilen çözüm** | .ics export veya abonelik |
| **Kullanıcı değeri** | Evrensel takvim uyumu |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | — |
| **Notlar** | — |

### APPT-033 — QR kod ile randevu sayfası

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-033 |
| **Başlık** | QR kod ile randevu sayfası |
| **Kategori** | Online booking |
| **Problem** | Fiziksel klinikte hızlı erişim |
| **Önerilen çözüm** | APPT-002 URL için QR üretimi |
| **Kullanıcı değeri** | Resepsiyon/klinik içi self-service |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-002 |
| **Notlar** | — |

### APPT-034 — Mini klinik sayfası

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-034 |
| **Başlık** | Mini klinik sayfası |
| **Kategori** | Online booking |
| **Problem** | Web sitesi olmayan klinikler entegre olamaz |
| **Önerilen çözüm** | Vetinity barındırmalı basit klinik landing + booking |
| **Kullanıcı değeri** | Dijital varlık + randevu tek yerde |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-001 |
| **Notlar** | — |

### APPT-035 — AI destekli uygun saat önerisi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-035 |
| **Başlık** | AI destekli uygun saat önerisi |
| **Kategori** | Online booking |
| **Problem** | Slot seçimi hasta sahibi için zor olabilir |
| **Önerilen çözüm** | Bağlamsal slot önerisi (taslak/yardımcı) |
| **Kullanıcı değeri** | Daha hızlı booking |
| **Öncelik** | P3 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | APPT-008, AI-009 |
| **Notlar** | Klinik karar hekimde; otomatik kesinleştirme yok |

### APPT-036 — Provider seçimlerinde uygunluk ve rol filtresi

| Alan | Değer |
|---|---|
| **Kimlik** | APPT-036 |
| **Başlık** | Provider seçimlerinde uygunluk ve rol filtresi |
| **Kategori** | Online booking |
| **Problem** | Provider/hekim atama alanlarında uygun olmayan kullanıcılar listelenirse veri kalitesi ve güven düşer; sorun yalnızca randevuya özgü değildir |
| **Önerilen çözüm** | Tüm provider seçimlerinde (Assign To, Primary Provider, muayene sağlayıcısı vb.) ortak uygunluk politikası: yalnızca aktif klinik üyeleri; yalnızca klinik hizmet sağlayıcısı/provider olarak yetkilendirilmiş kullanıcılar; mevcut klinik bağlamı; pasif kullanıcılar ve başka klinikteki kullanıcılar dışlanır; rol adı yerine capability/permission veya provider niteliği esas alınır |
| **Kullanıcı değeri** | Doğru atama; tutarlı seçim listeleri; rol netliği |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): geliş diyaloğunda hekim süzgeci var; tüm sağlayıcı seçimlerinde ortak politika doğrulanmadı |
| **Bağımlılıklar** | APPT-007 |
| **Notlar** | APPT kapsamında kayıtlı; randevu, hasta, muayene ve diğer klinik kayıtlarındaki provider seçimlerine uygulanır. DaySmart sandbox: veteriner olmayan hesap listede göründü — sandbox konfigürasyonu veya provider ataması doğrulanmadı; kesin yetkilendirme hatası iddiası yok |

---

## INT — Entegrasyonlar

### INT-001 — Laboratuvar cihazı entegrasyonu araştırması

| Alan | Değer |
|---|---|
| **Kimlik** | INT-001 |
| **Başlık** | Laboratuvar cihazı entegrasyonu araştırması |
| **Kategori** | Entegrasyon |
| **Problem** | Manuel lab sonuç girişi yavaş |
| **Önerilen çözüm** | Cihaz partner ve protokol araştırması |
| **Kullanıcı değeri** | Otomatik sonuç aktarımı |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | — |
| **Notlar** | **Canlı sandbox — Patients Module:** Patients > Labs clinic worklist (Lab Vendor, integration status); patient History > Labs ayrı scope — **P3** MVP dışı → [daysmart.md](../competitors/daysmart.md#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics) |

| Alan | Değer |
|---|---|
| **Kimlik** | INT-002 |
| **Başlık** | Dijital röntgen entegrasyonu araştırması |
| **Kategori** | Entegrasyon |
| **Problem** | Manuel röntgen yükleme verimsiz |
| **Önerilen çözüm** | Dijital röntgen cihaz entegrasyonu araştırması |
| **Kullanıcı değeri** | Doğrudan görüntü aktarımı |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | IMG-001 |
| **Notlar** | Temel dosya yönetiminden ayrı seviye |

### INT-003 — SMS entegrasyonu

| Alan | Değer |
|---|---|
| **Kimlik** | INT-003 |
| **Başlık** | SMS entegrasyonu |
| **Kategori** | Entegrasyon |
| **Problem** | Hatırlatma ve bildirimler SMS gerektirir |
| **Önerilen çözüm** | SMS sağlayıcı entegrasyonu |
| **Kullanıcı değeri** | Otomatik hatırlatmalar |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TRIAL-004 |
| **Notlar** | Trial'da gerçek SMS sınırlandırılır. **E-Vet SMART:** Takvim SMS bakiye; Hatırlatma / Düzenle modal gönder / Sms Geçmişi — → [e-vet.md](../competitors/e-vet.md#global-takvim-modül). **E-Vet SMART (2026-10-01):** Müşteri Kartı → Doğrudan Satış Geçmişi **Sms Gönder** → Durum modal (SMS Id + success indicator); carrier delivery **doğrulanmadı** — → [e-vet.md](../competitors/e-vet.md#müşteri-modül) |

### INT-004 — WhatsApp entegrasyonu

| Alan | Değer |
|---|---|
| **Kimlik** | INT-004 |
| **Başlık** | WhatsApp entegrasyonu |
| **Kategori** | Entegrasyon |
| **Problem** | Hasta sahibi iletişimi WhatsApp üzerinden yapılıyor |
| **Önerilen çözüm** | WhatsApp Business entegrasyonu değerlendirmesi |
| **Kullanıcı değeri** | Tanıdık iletişim kanalı |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | **E-Vet SMART (2026-09-27):** Takvim > Hatırlatma — WhatsApp Web handoff, prefilled reminder metni; Business API / server-side send **doğrulanmadı** — → [e-vet.md](../competitors/e-vet.md#whatsapp-web-handoff-hatırlatma). **E-Vet SMART (2026-10-01):** Müşteri Kartı → Whatsapp — person-message handoff (in-app inbox **gözlemlenmedi**); API/server-side **doğrulanmadı** — → [e-vet.md](../competitors/e-vet.md#müşteri-modül) |

### INT-005 — e-Fatura / e-SMM

| Alan | Değer |
|---|---|
| **Kimlik** | INT-005 |
| **Başlık** | e-Fatura / e-SMM |
| **Kategori** | Entegrasyon |
| **Problem** | Türkiye'de yasal fatura gereksinimleri |
| **Önerilen çözüm** | e-Fatura ve e-SMM entegrasyonu |
| **Kullanıcı değeri** | Yasal uyumluluk |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TRIAL-004 |
| **Notlar** | Trial'da gerçek işlem sınırlandırılır. **Settings Module:** Taxes config (rate, type, jurisdiction, applies-to) — US odaklı benchmark; Türkiye KDV/e-belge ayrı — → [daysmart.md](../competitors/daysmart.md#settings-taxes). **Inventory Module:** item-level tax applicability — → [daysmart.md](../competitors/daysmart.md#inventory-taxes). **E-Vet SMART (2026-09-27):** Doğrudan Satış e-Fatura\|SMM Notu alanları; **VIDEO OBSERVED** gelgeç müşteride e-Fatura düzenlenememe anlatımı — live kural **doğrulanmadı** — → [e-vet.md](../competitors/e-vet.md#ana-satış-ekranı). **E-Vet SMART (2026-10-04):** sol menü e-Fatura/e-SMM UI + Fatura Yönetim Paneli pre-send workflow; reviewed account config eksik → external lifecycle **NOT VERIFIED** — → [e-vet.md](../competitors/e-vet.md#e-fatura--e-smm-modül) (competitor evidence; scope değişmedi). **Keşif (2026-10-19):** kullanıcı beyanı "zorunlu"; serbest hekim hizmeti e-SMM, şirket klinik ve ayrı ticari satış fatura (e-Arşiv / e-Fatura), yol özel entegratör API'si — [keşif](../research/hbs-ve-e-belge-kesfi-2026-10.md), karar taslağı [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md) (Dilim 3–5). Öncelik önerisi P1, ilk ücretli canlı müşteriden önce (ADR-036 AK-7, karar bekliyor) |

### INT-006 — POS ve online ödeme

| Alan | Değer |
|---|---|
| **Kimlik** | INT-006 |
| **Başlık** | POS ve online ödeme |
| **Kategori** | Entegrasyon |
| **Problem** | Ödeme tahsilatı entegrasyon gerektirir |
| **Önerilen çözüm** | POS ve online ödeme entegrasyonu |
| **Kullanıcı değeri** | Kesintisiz tahsilat |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Planlandı |
| **Bağımlılıklar** | TRIAL-004 |
| **Notlar** | Trial'da gerçek POS sınırlandırılır |

### INT-007 — Otomatik fatura / e-belge oluşturma

| Alan | Değer |
|---|---|
| **Kimlik** | INT-007 |
| **Başlık** | Otomatik fatura / e-belge oluşturma (ücret ve tahsilattan) |
| **Kategori** | INT |
| **Problem** | Veteriner klinikleri e-Fatura / e-SMM'ye ek olarak ücret ve ödemeden **otomatik fatura oluşturan** bir yapı bekliyor (kullanıcı bilgisi, 2026-10-13). Bugün ücret/ödeme yalnız iç kayıt; resmi belge yok. Rakip (E-vet SMART) ana ekranında e-Fatura/e-SMM, müşteri kartında zorunlu Kimlik No ve doğum tarihi gösteriyor |
| **Önerilen çözüm** | Önce keşif: belge türleri (e-Fatura, e-Arşiv, e-SMM), entegratör seçenekleri, veri modeli eşleşmesi (KDV oranı/hizmet kataloğu [FIN-008](#), müşteri TC/vergi no ve fatura adresi, numaralandırma, iptal/iade [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md) ile uyum), otomatik kesme kuralı (ücret girilince / ödeme alınınca / ziyaret kapanınca / elle "fatura kes"). Sonra sözleşme ve dilimler |
| **Kullanıcı değeri** | Klinik, ayrı bir programda faturayı yeniden yazmaz; Vetinity eski sistemin yerini alabilir (canlıya geçiş koşulu) |
| **Öncelik** | P1 (pilotun gölge döneminde gerekmez; eski sistemi bırakma aşamasında gerekli) |
| **Tahmini zorluk** | Yüksek (tahmin: keşif + backend + entegratör + frontend; ölçülmedi) |
| **Durum** | Karar bekliyor (kullanıcı 2026-10-13: detaylar sonra netleştirilecek) |
| **Bağımlılıklar** | [INT-005](#int-005--e-fatura--e-smm), FIN-008 hizmet kataloğu, müşteri kimlik/adres alanları, ADR-014 (pilot) |
| **Notlar** | **Açık sorular (kullanıcıya, pilot kliniğe/muhasebeciye):** (1) hangi belge türü, (2) ne zaman kesilsin, (3) hangi entegratör, (4) hangi müşteriye hangi belge (bireysel/kurumsal). Hukuki/vergi tavsiyesi verilmez; ürün ekibi yalnız teknik uygunluğu çıkarır. Rakip ekran görüntüsü yorumu: Kimlik No zorunluluğu muhtemelen fatura ihtiyacından geliyor (doğrulanmadı). **2026-10-19:** açık sorular (1)–(4) [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md) AK-1…AK-4'e taşındı (öneri: elle "Belge kes" + kapanışta öneri v1, tam otomatik v2) |

### INT-008 — HBS e-Reçete ve ATS aşı kaydı yardımcısı

| Alan | Değer |
|---|---|
| **Kimlik** | INT-008 |
| **Başlık** | HBS e-Reçete ve ATS aşı kaydı yardımcısı |
| **Kategori** | Entegrasyon |
| **Problem** | Hekim reçeteyi (e-Reçete) ve aşıyı (ATS) Bakanlığın Hayvan Bilgi Sistemi'ne (HBS, e-Devlet girişi) ayrıca girmek zorunda; veri Vetinity'de yapılandırılmış ve hazır değilse iki kez yazar ve unutur. Kullanıcı beyanı (2026-10-19): HBS zorunlu. Klinik yazılımları için herkese açık resmî web servis bulunamadı (doğrulanmadı) |
| **Önerilen çözüm** | v1 manuel yardımcı: aşı/reçete kaydı kapanınca HBS'e girilecek veri tek ekranda alan alan, kopyalanabilir ve dışa aktarılabilir; HBS'ten dönen numaralar (e-Reçete No, aşı uygulama belgesi seri no, HBS hayvan kimlik no) geri kaydedilir; "HBS'e girilmedi" iş listesi. v2 otomatik gönderim yalnız resmî web servis izni çıkarsa. Portal otomasyonu/ekran kazıma yok |
| **Kullanıcı değeri** | Yasal kaydın unutulmaması, çift yazımın azalması; eski sistemi bırakma koşulu |
| **Öncelik** | P1 (pilot canlı veriden önce; ADR-036 AK-7 kabul edildi 2026-10-21) |
| **Tahmini zorluk** | Orta (tahmin; reçete kalemlerinin yapılandırılması dahil, ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; tarayıcı denemesi ve pilot hekim eşleşmesi doğrulanmadı) |
| **Bağımlılıklar** | [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md) Dilim 1–2, ADR-015 (parti/SKT), Aşama 5 reçete yapısı, müşteri TCKN alanı |
| **Notlar** | Keşif: [research/hbs-ve-e-belge-kesfi-2026-10.md](../research/hbs-ve-e-belge-kesfi-2026-10.md). Rakip E-vet: HBS menüsü = e-Reçete + ATS listeleri, Excel dışa aktarma; gönderim semantiği doğrulanmadı — → [e-vet.md](../competitors/e-vet.md#hbs-modül). Sahip değişikliği/ölüm/kayıp bildirimi sahibin yükümlülüğü görünüyor (doğrulanmadı); kapsam dışı, en fazla bilgi notu. Kullanıcı adımları: pilot hekimle HBS ekran gözlemi, Bakanlığa web servis sorusu |

---

## MOBILE — Mobil

### MOBILE-001 — Hasta sahibi mobil deneyimi (PWA)

| Alan | Değer |
|---|---|
| **Kimlik** | MOBILE-001 |
| **Başlık** | Hasta sahibi mobil deneyimi (PWA) |
| **Kategori** | Mobil |
| **Problem** | Hasta sahibi telefonundan kolay erişim bekler |
| **Önerilen çözüm** | Portalın mobil-öncelikli, ana ekrana eklenebilir PWA olarak yayını; çevrimdışı yalnız son görüntülenen veri önbelleği |
| **Kullanıcı değeri** | Telefonla kolay erişim, mağaza gerekmeden |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | PORTAL-001 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K5 (öneri: önce PWA); AK-4 |

### MOBILE-002 — Hasta sahibi mobil uygulaması (Capacitor, mağaza)

| Alan | Değer |
|---|---|
| **Kimlik** | MOBILE-002 |
| **Başlık** | Hasta sahibi mobil uygulaması (Capacitor, mağaza) |
| **Kategori** | Mobil |
| **Problem** | PWA'da iOS push ve mağaza varlığı sınırlı |
| **Önerilen çözüm** | Aynı Angular kod tabanını Capacitor ile iOS/Android paketle; yerel push, biyometrik kilit; mağaza hesabı şirket adına |
| **Kullanıcı değeri** | Mağazada bulunma, güvenilir push |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | MOBILE-001, MOBILE-003, PORTAL-011 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K5; mağaza/push davranışı uygulama aşamasında güncel kaynaktan doğrulanmalı; AK-4. Mağazalar uygulama içi hesap silme istiyor → PORTAL-011 ([ADR-041](../decisions/ADR-041-portal-hesap-silme.md)) |

### MOBILE-003 — Push bildirim altyapısı

| Alan | Değer |
|---|---|
| **Kimlik** | MOBILE-003 |
| **Başlık** | Push bildirim altyapısı |
| **Kategori** | Mobil |
| **Problem** | Randevu/aşı hatırlatması için anında kanal yok |
| **Önerilen çözüm** | Cihaz jetonu kaydı/iptali, bildirim izni ve KVKK tercihi, sağlayıcı arayüzü arkasında gönderim |
| **Kullanıcı değeri** | Zamanında hatırlatma |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Yüksek (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | PORTAL-010 |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K7; MOBILE-002 ile birlikte |

### MOBILE-004 — Veteriner/çalışan mobil deneyimi

| Alan | Değer |
|---|---|
| **Kimlik** | MOBILE-004 |
| **Başlık** | Klinik panelinin çalışan için mobil kullanımı |
| **Kategori** | Mobil |
| **Problem** | Çalışan (hekim, resepsiyon) telefondan aynı klinik paneline girip işini yapamıyor veya zor yapıyor |
| **Önerilen çözüm** | Mevcut paneli telefon genişliğinde tam kullanılabilir yap (responsive denetim: Bugün, randevu, hasta/müşteri, muayene, ödeme); ana ekrana eklenebilir PWA; ayrı mağaza uygulaması AK-1b ile karara bağlanır |
| **Kullanıcı değeri** | Esneklik |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) Kullanıcı kararı (2026-10-16): çalışan mobilden aynı siteye girebilmeli; mağaza uygulaması AK-1b |

---

## SEC — Güvenlik ve sertleştirme

### SEC-001 — Hesap kilitleme ve giriş denemesi koruması

| Alan | Değer |
|---|---|
| **Kimlik** | SEC-001 |
| **Başlık** | Hesap kilitleme ve giriş denemesi koruması |
| **Kategori** | SEC |
| **Problem** | Güvenlik incelemesi (O3): hesap kilitleme yok, giriş sınırı yalnız IP başına; olmayan kullanıcıda parola doğrulaması çalışmadığı için zamanlama farkı var |
| **Önerilen çözüm** | Başarısız deneme sayacı ve geçici kilit (migration), sabit zamanlı doğrulama, kilit olayı denetim kaydı |
| **Kullanıcı değeri** | Parola tahmin saldırısına karşı koruma (canlıya çıkış koşulu) |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | Aşama 9 canlıya çıkış kontrol listesi |
| **Notlar** | `docs/SECURITY_REVIEW_2026-10.md` O3; migration gerektirir |

### SEC-002 — İzinlerin JWT'de taşınması ve yetki geri alma gecikmesi

| Alan | Değer |
|---|---|
| **Kimlik** | SEC-002 |
| **Başlık** | Yetki geri alma gecikmesi (izinler JWT'de, ömrü 60 dk) |
| **Kategori** | SEC |
| **Problem** | Güvenlik incelemesi (O6): yetkisi alınan kullanıcı JWT ömrü boyunca eski yetkisini kullanır |
| **Önerilen çözüm** | Kısa ömürlü erişim jetonu + yenileme, ya da izin sürümü/oturum iptal kontrolü; seçenekler ürün kararı |
| **Kullanıcı değeri** | Yetki kaldırma anında etkili olur |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | Aşama 9 |
| **Notlar** | `docs/SECURITY_REVIEW_2026-10.md` O6; tasarım kararı gerekir |

---

## WEB — Tanıtım sitesi (www)

> Kaynak: [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md), [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md), [ux/tanitim-sitesi-tasarim.md](../ux/tanitim-sitesi-tasarim.md). Kararlar: [ADR-034](../decisions/ADR-034-tanitim-sitesi-konumlandirma.md) kabul edildi (2026-10-16); AK-6 iletişim bilgileri bekliyor; hastane sonraki hedef, ayrı paket.

### WEB-001 — Tanıtım sitesi metin ve dil düzeltmeleri (ADR-022, boş iddialar)

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-001 |
| **Başlık** | Tanıtım sitesi metin ve dil düzeltmeleri (ADR-022, boş iddialar) |
| **Kategori** | WEB |
| **Problem** | Sitede "pet", "Dashboard", "Admin/sekreter" gibi ADR-022'ye aykırı terimler; "öncelikli kullanım kapasitesi" gibi tanımsız iddialar; sahte "panel önizleme" kartı; ölü `pages/landing/*` kodu |
| **Önerilen çözüm** | ADR-022 diline geçiş, tanımsız iddiaların silinmesi, sahte önizleme kaldırma, `pages/landing/*` ve `public/demo` temizliği, `<title>`/`description` metnine "veteriner" |
| **Kullanıcı değeri** | Site ürünle aynı dili konuşur; yanıltıcı iddia kalmaz |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | — |
| **Notlar** | Analiz [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 3.5; öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) D1. Küçük iş (WORKFLOW), ADR gerekmez |

### WEB-002 — Tanıtım sitesi mobil menü ve erişilebilirlik

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-002 |
| **Başlık** | Tanıtım sitesi mobil menü ve erişilebilirlik |
| **Kategori** | WEB |
| **Problem** | 375 px'te üst menü tamamen gizli (hamburger yok): Paketler, SSS, Giriş, Ücretsiz başla ulaşılamaz; tema düğmelerinin erişilebilir adı boş; 7 dokunma hedefi 44 px altında; "içeriğe atla" yok |
| **Önerilen çözüm** | Hamburger menü (odak tuzağı, Escape ile kapanma), tema düğmesine gerçek `aria-label`, dokunma hedefi ≥44 px, atla bağlantısı |
| **Kullanıcı değeri** | Telefonla gelen ziyaretçi paketlere ve kayda ulaşır |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Geliştiriliyor (yerel frontend main'de, 2026-10-16; push yok, canlıda değil) |
| **Bağımlılıklar** | — |
| **Notlar** | Analiz [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 3.3–3.4. Devir notundaki "tema düğmesine aria-label" küçük işi buraya bağlanır |

### WEB-003 — Tanıtım sitesi teknik SEO (robots, sitemap, canonical, OG, JSON-LD, prerender)

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-003 |
| **Başlık** | Tanıtım sitesi teknik SEO (robots, sitemap, canonical, OG, JSON-LD, prerender) |
| **Kategori** | WEB |
| **Problem** | `robots.txt`/`sitemap.xml` yok (index.html dönüyor); canonical origin'den türetiliyor (staging kendini asıl sayıyor, noindex yok); `og:image`/twitter kartı yok; sunucu HTML'inde `<h1>` yok (tamamen istemci tarafı), ~782 KB JS |
| **Önerilen çözüm** | Sabit `https://www.vetinity.com` canonical, staging `noindex`, robots ve sitemap, OG görseli, JSON-LD (Organization, SoftwareApplication, FAQPage), tanıtım sayfaları için prerender/SSG değerlendirmesi (ADR-033 ayrımıyla birlikte) |
| **Kullanıcı değeri** | Arama motorunda görünürlük; paylaşımda doğru kart |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük–Orta (tahmin; ölçülmedi) |
| **Durum** | Kısmen geliştirildi (main, 2026-10-24 kod incelemesi): robots/sitemap/canonical/OG var; Organization ve FAQ JSON-LD, staging noindex, prerender yok |
| **Bağımlılıklar** | ADR-033 (prerender/ayrı derleme kısmı) |
| **Notlar** | Analiz [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 3.1–3.2; öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) bölüm 6. Yazı tipi yerelleştirme ayrı iş (wt-font) |

### WEB-004 — Ana sayfanın problem odaklı yeniden yazımı

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-004 |
| **Başlık** | Ana sayfanın problem odaklı yeniden yazımı |
| **Kategori** | WEB |
| **Problem** | Ana sayfa modül listesi ve jenerik sıfatlarla ürünün içini anlatıyor; kliniğin problemini, Türkiye'ye özgü güçlü yanları (defterler, KVKK, Bugün, geçiş) ve "ne yapmıyoruz"u anlatmıyor; gerçek ekran yok |
| **Önerilen çözüm** | Öneri belgesindeki 10 bölümlük omurga: kahraman (gerçek Bugün ekranı), kime göre, bir günün akışı, Türkiye'ye özgü (defter+KVKK), kayıt güvenliği, geçiş, yol haritası (dürüst), SSS 6–8, çağrı; yalnız doğrulanmış iddialar |
| **Kullanıcı değeri** | Ziyaretçi 30 saniyede "benim için mi" diyebilir; güven kurulur |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi) |
| **Bağımlılıklar** | WEB-005, AK-1/AK-3/AK-4/AK-5 kararları |
| **Notlar** | Öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) bölüm 3; iddia tablosu [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 4. "Mevzuata uygun"/"KVKK uyumlu" ifadeleri kullanılmaz |

### WEB-005 — Tanıtım için gerçek ekran görüntüleri (anonim test verisi)

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-005 |
| **Başlık** | Tanıtım için gerçek ekran görüntüleri (anonim test verisi) |
| **Kategori** | WEB |
| **Problem** | Sitede gerçek ürün görseli yok; sahte önizleme kartı var |
| **Önerilen çözüm** | Analiz belgesi bölüm 7 listesi: Bugün, muayene alanı, hasta kartı/zaman çizelgesi, Aşı Kayıt Defteri + yazdırma, KVKK formu, ödeme/bakiye ve gün sonu, veri aktarma sihirbazı, mal kabul; açık + koyu tema, 2×, WebP, `alt` metni; sentetik ad/telefon |
| **Kullanıcı değeri** | Somut kanıt; sahte görsel yok |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | Panelde sentetik veri (TEST kayıtları) |
| **Notlar** | [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 7. Portal görseli yayınlanana kadar yok |

### WEB-006 — Yeni tanıtım sayfaları: Özellikler, Defterler ve KVKK, Geçiş, İletişim/Demo, Hakkımızda/Destek

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-006 |
| **Başlık** | Yeni tanıtım sayfaları: Özellikler, Defterler ve KVKK, Geçiş, İletişim/Demo, Hakkımızda/Destek |
| **Kategori** | WEB |
| **Problem** | İletişim, demo talebi, hakkımızda, destek, güvenlik/KVKK ve geçiş sayfaları yok; ziyaretçinin soru soracağı yer yok |
| **Önerilen çözüm** | Beş sayfa (adresler öneri belgesinde); iletişim/demo ilk sürümde form yerine e-posta/telefon olabilir (backend ucu yok); SSS ayrı sayfa |
| **Kullanıcı değeri** | Sorusu olan klinik ulaşabilir; Türkiye'ye özgü değer ayrı sayfada anlatılır |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; içerik kalitesi doğrulanmadı) |
| **Bağımlılıklar** | AK-5, AK-6 (iletişim bilgileri, tüzel kişi) |
| **Notlar** | Öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) bölüm 2 ve 5. Blog şimdilik yok |

### WEB-007 — Paketler sayfası: fiyat kararı ve backend plan kataloğu ile tek kaynak

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-007 |
| **Başlık** | Paketler sayfası: fiyat kararı ve backend plan kataloğu ile tek kaynak |
| **Kategori** | WEB |
| **Problem** | Üç kartta "Fiyat yakında"; site kullanıcı sınırları (1/5/∞) backend `SubscriptionPlanCatalog` (3/10/50) ile çelişiyor; klinik sınırı backend'de yok; deneme sonrası ne olacağı tanımsız |
| **Önerilen çözüm** | AK-2 kararına göre fiyat ya da "teklif al"; sınırların tek doğrusu backend'den (katalog ucu ya da aynı sabit); /pricing → /paketler yönlendirme; deneme sonu kuralı (TRIAL-007) netleşmeden SSS'de yazılmaz |
| **Kullanıcı değeri** | Fiyat belirsizliği güven kaybına yol açmaz; site ürünle çelişmez |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Düşük–Orta (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | AK-2, TRIAL-004, TRIAL-007 |
| **Notlar** | [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md) bölüm 3.6 |

### WEB-008 — Tanıtım sitesinin ayrı derlemesi ve çerezsiz ziyaret sayacı

| Alan | Değer |
|---|---|
| **Kimlik** | WEB-008 |
| **Başlık** | Tanıtım sitesinin ayrı derlemesi ve çerezsiz ziyaret sayacı |
| **Kategori** | WEB |
| **Problem** | Tanıtım, panel ve portal aynı Angular derlemesinde; tanıtım ziyaretçisi panel JS'ini indiriyor; analitik yok, eklenirse KVKK/çerez sorusu |
| **Önerilen çözüm** | ADR-033 ile birlikte tanıtımın ayrı statik/prerender derlemesi; analitik: önce yok (sunucu günlüğü), sonra kendi barındırılan çerezsiz sayaç; dış kaynak (GA/Pixel) kullanılmaz; dönüşüm backend'den (TRIAL-008) |
| **Kullanıcı değeri** | Hızlı, hafif, KVKK açısından temiz tanıtım sitesi |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Planlandı |
| **Bağımlılıklar** | ADR-033 uygulaması (kullanıcı), AK-7, AK-8 |
| **Notlar** | Öneri [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) bölüm 6.3 ve 7 |

## Satış ortağı ve faturalandırma

### PARTNER-001 — Satış ortağı ve indirim kodu v1

| Alan | Değer |
|---|---|
| **Kimlik** | PARTNER-001 |
| **Başlık** | Satış ortağı ve indirim kodu v1 |
| **Kategori** | PARTNER |
| **Problem** | Satış ortakları müşteri getiriyor ama kod, indirim, komisyon ve ortak başına satış izlenemiyor |
| **Önerilen çözüm** | [ADR-037](../decisions/ADR-037-satis-ortagi-indirim-kodu.md): ortak/kod/kullanım kayıtları; kayıtta ve ilk ödemeden önce abonelikte "Ortak kodu"; `/r/KOD` bağlantısı (yalnız URL + oturum belleği); checkout'ta ilk 12 ay indirim; doğrulanmış tahsilatta net üzerinden komisyon, iadede geri alma; platform yöneticisine "Satış ortakları" ekranı (özet, kodlar, kullanım satırları, ödendi işareti, CSV) |
| **Kullanıcı değeri** | Ortak kanalıyla satış ölçülebilir; komisyon hesabı elle tablo tutmadan çıkar |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; satış ortakları tarayıcı denemesi doğrulanmadı) |
| **Bağımlılıklar** | ADR-035, ADR-037; yıllık seçenek için BILL-001 |
| **Notlar** | Uygulama notu ve keşif bulguları ADR-037 sonunda. Sağlayıcıdan iade olayı yok (elle işaretleme). Ortağın kendi satışını görmesi sonraki sürüm |

### BILL-001 — Yıllık ödeme dönemi (faturalandırma)

| Alan | Değer |
|---|---|
| **Kimlik** | BILL-001 |
| **Başlık** | Yıllık ödeme dönemi (faturalandırma) |
| **Kategori** | BILL |
| **Problem** | Ürün kararı yıllık ödeme (10 ay fiyatı, tek tahsilat) ama faturalandırma yalnız aylık dönem üretiyor |
| **Önerilen çözüm** | Abonelikte dönem (aylık/yıllık), yıllık dönem sonu, checkout'ta dönem seçimi; fiyat `SubscriptionPricing` (plan → yıllık → kod) üzerinden; satış ortağı komisyonu yıllıkta tek seferlik (kural hazır) |
| **Kullanıcı değeri** | Yıllık ödeyen klinik indirim alır, nakit akışı öne çekilir |
| **Öncelik** | P1 (sitede yıllık seçenek bu işe bağlı) |
| **Tahmini zorluk** | Orta (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (dal `feat/bill-001-yearly`, backend + frontend, 2026-10-26; main'e alınmadı, migration `AddBillingPeriod` yalnız yerel geliştirme veritabanına uygulandı) |
| **Bağımlılıklar** | ADR-035, ADR-037, PARTNER-001 |
| **Notlar** | Kullanıcı kararları (2026-10-26): aylıktan yıllığa hemen geçilir, mevcut ayın kalan günleri düşülür; yıllıktan aylığa dönem sonunda; dönem sonu aylıkla aynı (otomatik yenileme yok, salt okunur + yeniden ödeme); sağlayıcı iyzico + Manual (Stripe yıllıkta reddedilir); sitede Aylık/Yıllık anahtarı. Sözleşme: backend `docs/SUBSCRIPTION_YEARLY_BILLING_API_CONTRACT.md`. Tarayıcıda: paketler anahtarı ve abonelik sayfasında "Yıllığa geç" denendi; iyzico sandbox ödeme formu yerel ağdan açılamadı (DNS), yıllık ödeme ucu entegrasyon testiyle (Manual) doğrulandı. Ödeme akışı riskleri ayrı işlerde: BILL-002, BILL-003 |

### BILL-002 — Panel "finalize" ucu ödemeyi doğrulamadan aboneliği etkinleştiriyor

| Alan | Değer |
|---|---|
| **Kimlik** | BILL-002 |
| **Başlık** | Panel "finalize" ucu ödemeyi doğrulamadan aboneliği etkinleştiriyor |
| **Kategori** | BILL |
| **Problem** | `POST /tenants/{id}/subscription-checkout/{sessionId}/finalize` (`Subscriptions.Manage`) oturumu sağlayıcıdan doğrulamadan ücretli plana geçiriyor; arayüz yalnız Manual sağlayıcıda gösteriyor ama uç iyzico oturumunda da çağrılabiliyor → ödemesiz etkinleştirme |
| **Önerilen çözüm** | Finalize'ı yalnız Manual sağlayıcıya (geliştirme/test) sınırla ya da iyzico'da sonucu sağlayıcıdan sorgula (retrieve); üretimde etkinleştirme yalnız imzası doğrulanan webhook'tan |
| **Kullanıcı değeri** | Ödenmemiş abonelik açılmaz; gelir kaybı ve kötüye kullanım önlenir |
| **Öncelik** | P1 (ilk ücretli canlı müşteriden önce) |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; gerçek iyzico ile uçtan uca doğrulanmadı) |
| **Bağımlılıklar** | — |
| **Notlar** | Keşif (2026-10-22, PARTNER-001). Satış ortağı komisyonu zaten yalnız webhook tahsilatında yazılıyor |

### BILL-003 — Süresi dolmuş denemede üst plana geçiş 1 kuruş çekiyor

| Alan | Değer |
|---|---|
| **Kimlik** | BILL-003 |
| **Başlık** | Süresi dolmuş denemede üst plana geçiş 1 kuruş çekiyor |
| **Kategori** | BILL |
| **Problem** | Deneme bitmiş (salt okunur) kiracı üst plan seçince yükseltme farkı deneme penceresine göre oranlanıyor; kalan süre 0 olduğundan tutar 0'a, `Math.Max(1, …)` ile 1 kuruşa iniyor; kiracı ilk ayı neredeyse ücretsiz alıyor |
| **Önerilen çözüm** | Süresi dolmuş denemede (ve dolmuş ücretli dönemde) yükseltmeyi yenileme gibi hedef planın tam dönem fiyatıyla ücretlendir; oranlama yalnız etkin ücretli dönemde |
| **Kullanıcı değeri** | Denemeden ücretliye geçişte doğru tutar tahsil edilir |
| **Öncelik** | P1 (ilk ücretli canlı müşteriden önce) |
| **Tahmini zorluk** | Düşük (tahmin; ölçülmedi) |
| **Durum** | Geliştirildi (main + origin, 2026-10-24 kod incelemesi; gerçek iyzico ile uçtan uca doğrulanmadı) |
| **Bağımlılıklar** | — |
| **Notlar** | Keşif (2026-10-22, PARTNER-001): `StartSubscriptionCheckoutCommandHandler` + `SubscriptionProrationCalculator` |

## İlgili belgeler

- [Roadmap](../roadmap/roadmap.md)
- [Stratejik kararlar (ADR)](../decisions/ADR-001-self-service-trial-strategy.md)
- [UX navigasyon](../ux/navigation.md)
