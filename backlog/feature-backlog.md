# Feature Backlog

> Bu belge tüm ürün fikirlerinin ve özellik maddelerinin detaylı kaynağıdır. Önceliklendirilmiş zaman çizelgesi için [roadmap](../roadmap/roadmap.md) kullanılır.

## Durum değerleri

Planlandı · Araştırılacak · Tasarlanacak · Geliştiriliyor · Tamamlandı · Ertelendi

## Kategori kimlikleri

| Önek | Alan |
|---|---|
| TRIAL- | Trial ve onboarding |
| UX- | Kullanıcı deneyimi ve navigasyon |
| REPORT- | Raporlama |
| EXAM- | Muayene deneyimi |
| CHECKIN- | Check-in orkestrasyonu |
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
| **Durum** | Planlandı |
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
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
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
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
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
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
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
| **Öncelik** | P0 |
| **Tahmini zorluk** | Düşük |
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Ana edinme kanalı değil |

### TRIAL-006 — Trial kullanım kotası

| Alan | Değer |
|---|---|
| **Kimlik** | TRIAL-006 |
| **Başlık** | Trial kullanım kotası |
| **Kategori** | Trial |
| **Problem** | Sınırsız trial kötüye kullanıma açık |
| **Önerilen çözüm** | Makul kullanım limitleri (kayıt sayısı, depolama vb.) tanımla |
| **Kullanıcı değeri** | Adil kullanım; platform sürdürülebilirliği |
| **Öncelik** | P0 |
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
| **Durum** | Planlandı |
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
| **Öncelik** | P0 |
| **Tahmini zorluk** | Orta |
| **Durum** | Planlandı |
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
| **Durum** | Araştırılacak |
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
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | → [ADR-003](../decisions/ADR-003-report-center.md). **Clients Module:** Client Dashboard analytics P3. **Contacts Module:** Contact Dashboard analytics (New/Total Active Contacts) P3 — → [daysmart.md](../competitors/daysmart.md#contact-dashboard--contact-list) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Ödeme, randevu, muayene, aşı raporları kategoriler altında |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001 |
| **Notlar** | Gelecekte değerlendirilecek |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | REPORT-001, TRIAL-004 |
| **Notlar** | Gelecekte değerlendirilecek |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | → [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | UX-003, UX-004, UX-005 |
| **Notlar** | Kabul edilmiş hedef; henüz uygulanmadı |

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
| **Durum** | Planlandı |
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
| **Durum** | Planlandı |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı. DaySmart sandbox: breed aramada tür/grup etiketi birlikte; Vetinity species + breed ayrı model korunmalı |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı. **Inventory Module:** DaySmart Category Type Inventory vs Service; subcategory; paylaşılan katalog — kategori isimleri kopyalanmaz → [daysmart.md](../competitors/daysmart.md#inventory-categories) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-002–005 |
| **Notlar** | → [ADR-005](../decisions/ADR-005-modern-examination-experience.md). DaySmart (2026-08-02 bölüm 2): üst bağlam bandı, SOAP bölümleri, sistematik muayene, lock — sandbox doğrulanmadı |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | DaySmart sandbox — Treatment Board vital özet; **Patients Module** Overview snapshot (Weight, Temp, HR, RR) + Vitals History (Reference: SOAP) → [daysmart.md](../competitors/daysmart.md#patient-profile--header--overview) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | **Canlı sandbox — Patients Module:** Open Diagnoses (Overview); Custom Diagnoses clinic catalog ≠ patient diagnosis — hybrid catalog + free text adayı → [daysmart.md](../competitors/daysmart.md#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | Stratejik hedef. Muayene şablonları + check-in medical note şablonu. DaySmart: "within normal limit" varsayılanları — sandbox doğrulanmadı |

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
| **Notlar** | DaySmart (2026-08-02 bölüm 2): check-in ve medical note'tan seçim; kalem dahil/hariç; miktar; invoice bağlantısı; records+billing yansıması — sandbox doğrulanmadı. → [IDEA-023](../research/ideas.md#idea-023--configurable-clinical-bundles), [PATTERN-018](../research/patterns.md#pattern-018--bundle-to-record-expansion). **Canlı sandbox — Treatment Board:** New Bundle sihirbazı — [daysmart.md](../competitors/daysmart.md#new-bundle-sihirbaz). **Canlı sandbox — Boarding Check In:** Boarding + medical bundle listesi — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#bundle-check-in-bağlamı). **Inventory Module:** item detail Bundles tab; estimate/invoice bundle örnekleri — → [daysmart.md](../competitors/daysmart.md#inventory-bundles) |

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
| **Durum** | Planlandı |
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
| **Durum** | Planlandı |
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
| **Notlar** | **AI değildir**; snippet ile voice/AI karıştırılmamalı. DaySmart `#vomiting` örneği — sandbox doğrulanmadı → [IDEA-021](../research/ideas.md#idea-021--clinical-snippet-library), [PATTERN-017](../research/patterns.md#pattern-017--structured-clinical-snippets) |

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
| **Notlar** | DaySmart gözlemi — sandbox doğrulanmadı |

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
| **Notlar** | DaySmart sandbox observation (2026-08-02 bölüm 3): record oluşturmada Apply Item Rule; next due, reminder, quantity, route, invoice, stok. Bundle bağlamı bölüm 2'de gözlemlendi. Kural motoru doğrulanmadı → [PATTERN-021](../research/patterns.md#pattern-021--item-rule-field-population). **Boarding Check In** Apply Item Rule — [daysmart.md](../competitors/daysmart.md#apply-item-rule-check-in-bağlamı). **Reminders** due-date kaynakları — [daysmart.md](../competitors/daysmart.md#reminders-detail-ana-tablo). **Patients Module** Overview sağ panel due list (Given/Due) — [daysmart.md](../competitors/daysmart.md#patient-profile--header--overview). **Inventory Module** Item Actions tab (usage → reminder/task/status/certificate); Rules tab (species/weight/age eligibility); Low Balance action örneği — → [daysmart.md](../competitors/daysmart.md#inventory-item-actions), [daysmart.md](../competitors/daysmart.md#inventory-rules) |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | DaySmart lock aksiyonu gözlemlendi — sandbox doğrulanmadı. **Canlı sandbox — Patients Module:** Medical Notes History listesinde lock icon; signed/finalized anlamı **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#medical-notes) |

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
| **Notlar** | DaySmart gözlemi — sandbox doğrulanmadı. **Canlı sandbox — Boarding Check In:** Boarding Form template (Intake, Cage Card/Instructions, Behavior Observation vb.); Medical Note — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#boarding-form-template) |

| Alan | Değer |
|---|---|
| **Kimlik** | CHECKIN-003 |
| **Başlık** | Check-in sırasında bundle seçimi |
| **Kategori** | Check-in |
| **Problem** | Paket uygulama check-in aşamasında atlanabiliyor |
| **Önerilen çözüm** | Check-in formunda bundle seçimi ve invoice ilişkilendirme |
| **Kullanıcı değeri** | Erken paket planlama |
| **Öncelik** | P1 |
| **Tahmini zorluk** | Orta |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-001, EXAM-007 |
| **Notlar** | **Canlı sandbox — Boarding Check In:** Boarding Bundle + diğer medical bundle'lar — yansıma **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#bundle-check-in-bağlamı) |

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
| **Notlar** | → [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability). **Boarding Check In** New Invoice — [daysmart.md](../competitors/daysmart.md#check-in-wizard). **Clients Module:** Client-scoped Estimates — → [daysmart.md](../competitors/daysmart.md#client-billing). **Billing Module:** Estimate list/detail; Convert to Invoice (medical records, wellness plan, tax location); Approve/Duplicate/Email/Print — → [daysmart.md](../competitors/daysmart.md#billing-estimates) |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | CHECKIN-001 |
| **Notlar** | Kapsam durumları: Booked, Checked In, In Room, Visit Complete, Check Out. Bu kayıt yalnızca check-in işlemini değil, randevudan tamamlanmaya kadar tüm ziyaret/encounter yaşam döngüsünü temsil eder. DaySmart sandbox observation (~28:13–35:25): Visit Complete iken ayrı Check Out başlatılabiliyor → [CHECKOUT-001](#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu). Mevcut backlog ID'si CHECKIN-005 olarak korunur. İleride ziyaret/encounter alanı bağımsız bir ürün alanına dönüşürse kategori ve ID yapısı ayrıca değerlendirilebilir. DaySmart sandbox observation (2026-08-02 bölüm 3); SOAP ekranından durum değişimi gözlemlendi — doğrulanmadı. **Canlı sandbox — Census:** operasyon kuyruğu görünümü; satır bazlı status değişimi (gözlemlenen örnek: Not confirmed, Confirmed, Cancelled, Checked in); opsiyonel Notes — gözlemlenen seçeneklerin tam durum kümesi **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#sandbox--census-profiller-ve-operasyon-kuyruğu). **Canlı sandbox — Treatment Board:** aktif tedavi operasyon panosu — [daysmart.md](../competitors/daysmart.md#sandbox--treatment-board). **Canlı sandbox — Boarding Dashboard:** Checking In/Out/Checked In kolonları + durum legend — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#boarding-dashboard). **Patients Module:** Patient Profile Appointments + Boarding Reservation birleşik liste; domain ayrı — [daysmart.md](../competitors/daysmart.md#appointments-patient-profile). **Clients Module:** Client Appointments/Reservations unified query — [daysmart.md](../competitors/daysmart.md#appointments--reservations) |

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
| **Notlar** | DaySmart sandbox observation (~28:13–35:25). Belge paketi → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-024](../research/patterns.md#pattern-024--event-to-document-package), [PORTAL-005](#portal-005--dijital-onam-ve-imza). **Clients Module:** customer-scoped billing read-models — → [daysmart.md](../competitors/daysmart.md#client-billing). **Billing Module:** clinic-wide Invoices/Estimates/Payments/Returns/Credits/Refunds/Write-offs/Cash; invoice workspace tabs; multi-invoice payment allocation; Return≠Refund; returned≠restocked; credits; write-offs; cash reconciliation — → [daysmart.md](../competitors/daysmart.md#sandbox--billing--financial-operations). **Kapsam dışı:** POS, e-belge → [INT-005](#int-005--e-fatura--e-smm), [INT-006](#int-006--pos-ve-online-ödeme). → [IDEA-027](../research/ideas.md#idea-027--checkout-as-visit-completion-orchestrator) |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | EXAM-001 |
| **Notlar** | → [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability), [PATTERN-005](../research/patterns.md#pattern-005--clinical-to-financial-traceability). **Patients Module:** History Invoice + Reference. **Clients Module:** customer-scoped invoice list — → [daysmart.md](../competitors/daysmart.md#client-billing). **Inventory Module:** Item Transactions — → [daysmart.md](../competitors/daysmart.md#inventory-transactions). **Billing Module:** Invoice workspace (Items/Payments/Credits/Returns/Late Fees tabs); line-level Patient/Provider; finansal özet (Subtotal…Balance) — → [daysmart.md](../competitors/daysmart.md#billing-invoices) |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | DaySmart view changes gözlemlendi — sandbox doğrulanmadı → [IDEA-025](../research/ideas.md#idea-025--auditable-clinical-record-lifecycle), [PATTERN-019](../research/patterns.md#pattern-019--auditable-record-actions). **Inventory Module:** stock adjustment Current vs Actual balance + reason + Created By — auditable movement prensibi → [daysmart.md](../competitors/daysmart.md#inventory-adjustments) |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | |

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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | RECORD-001 |
| **Notlar** | DaySmart record satırı gözlemi. **Canlı sandbox — Patients Module:** Pharmacy/Vaccines History Lot, Route, Location; Records Summary — → [daysmart.md](../competitors/daysmart.md#pharmacy--labs--images--vaccines--vitals--communications). **Inventory Module:** Purchases/Transactions/Alerts lot+expiration; item master controlled/concentration/route — → [daysmart.md](../competitors/daysmart.md#inventory-purchases), [daysmart.md](../competitors/daysmart.md#inventory-transactions), [daysmart.md](../competitors/daysmart.md#inventory-alerts) |

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

---

## PORTAL — Hasta sahibi portalı

### PORTAL-001 — Hasta sahibi portalı

| Alan | Değer |
|---|---|
| **Kimlik** | PORTAL-001 |
| **Başlık** | Hasta sahibi portalı |
| **Kategori** | Portal |
| **Problem** | Hasta sahibi klinik bilgilerine self-servis erişemiyor |
| **Önerilen çözüm** | Ayrı web portalı; ana ekranda ziyaretler, hatırlatmalar, faturalar, hayvan kartları |
| **Kullanıcı değeri** | Self-servis; resepsiyon yükü azalır |
| **Öncelik** | P2 |
| **Tahmini zorluk** | Yüksek |
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | — |
| **Notlar** | **v1.0 dışı aday** → [IDEA-017](../research/ideas.md#idea-017--owner-portal-as-operational-extension), [PATTERN-013](../research/patterns.md#pattern-013--portal-to-clinic-continuity) |

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
| **Durum** | Araştırılacak |
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
| **Durum** | Araştırılacak |
| **Bağımlılıklar** | PORTAL-001 |
| **Notlar** | v1.0 dışı aday. **Canlı sandbox — Reminders:** Klinik operasyon Reminders Detail listesi PetCare portal reminder yüzeyinden ayrı modül; portal tarafı bu sandbox oturumunda **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#sandbox--reminders-reminders-detail) |

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
| **Durum** | Araştırılacak |
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
| **Notlar** | v1.0 dışı aday; Türkiye hukuki geçerlilik araştırılmalı → [IDEA-018](../research/ideas.md#idea-018--consent-and-document-signature-workflow), [PATTERN-014](../research/patterns.md#pattern-014--document-to-signature-continuity). DaySmart sandbox observation (bölüm 3): Draw/Type Signature; Lock Letter after sign → [PATTERN-023](../research/patterns.md#pattern-023--post-signature-document-immutability). Checkout belge paketi teslimi → [CHECKOUT-001](#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu), [PATTERN-024](../research/patterns.md#pattern-024--event-to-document-package) |

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
| **Notlar** | **v1.0 dışı aday** → [IDEA-019](../research/ideas.md#idea-019--unified-client-communication-timeline). **Clients Module:** Client Profile Communications; Communication Preferences; Contact Details (client multi-contact). **Contacts Module:** Contact/Company Communications; Log Communication; shared source client/patient/contact scopes — → [daysmart.md](../competitors/daysmart.md#contact-communications). **Patients Module:** Patient History Communications. Reminders Log call — [daysmart.md](../competitors/daysmart.md#log-call--communication-record) |

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
| **Notlar** | v1.0 dışı aday; SMS/e-posta entegrasyonu ayrı |

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
| **Notlar** | v1.0 dışı aday. **Clients Module:** Client Tasks. **Contacts Module:** Person Contact Tasks (aynı task domain; Staff, Repeat, Contact auto-bind); Company Tasks **gözlemlenmedi** — → [daysmart.md](../competitors/daysmart.md#contact-tasks). Reminder **değil**; inbox görevinden farklı — internal task/work-management domain adayı |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | TIMELINE-002 |
| **Notlar** | → [ADR-006](../decisions/ADR-006-patient-timeline.md). **Canlı sandbox — Patients Module:** Patient Dashboard klinik kayıt merkezi; Overview due list + snapshot vitals; History filtreleri (Records…Communications, More); patient-scoped read-models → [daysmart.md](../competitors/daysmart.md#sandbox--patients-module) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | Ayrı kopya yok. **Patients Module:** patient-scoped vs clinic-scoped. **Clients Module:** client-scoped vs patient-scoped. **Contacts Module:** contact/company-scoped Communication, Task, Relationship (external directory ≠ Customer) — → [daysmart.md](../competitors/daysmart.md#contact-cross-module-read-models), [ADR-006](../decisions/ADR-006-patient-timeline.md). **Inventory Module:** item usage/transactions/purchases/adjustments — same stock movement → patient timeline, invoice, item detail read-models → [daysmart.md](../competitors/daysmart.md#inventory-cross-module) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | TIMELINE-001 |
| **Notlar** | DaySmart sandbox — History filtreleri… **Clients Module:** Declined Items client billing + patient History More — shared source — → [daysmart.md](../competitors/daysmart.md#client-billing) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | — |
| **Notlar** | → [ADR-007](../decisions/ADR-007-imaging-module.md). **Canlı sandbox — Patients Module:** Patient History > Images; clinic-wide Images worklist (View Online NON_INTEGRATED) — patient vs clinic scope → [daysmart.md](../competitors/daysmart.md#clinic-wide-labs--images--rx-requests--custom-diagnoses--analytics) |

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
| **Durum** | Planlandı |
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
| **Durum** | Planlandı |
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
| **Durum** | Planlandı |
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
| **Notlar** | |

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
| **Durum** | Planlandı |
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
| **Durum** | Planlandı |
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
| **Notlar** | Equine vb. segmentler target-markets ile uyumlu değerlendirilmeli |

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
| **Notlar** | DaySmart sandbox: randevu türü varsayılan süre taşıyor (ör. 15 dk wellness) — sandbox gözlemi, doğrulanmadı |

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
| **Notlar** | → [IDEA-013](../research/ideas.md#idea-013--template-based-appointment-communications), [PATTERN-011](../research/patterns.md#pattern-011--template-first-communication). **Canlı sandbox — Boarding:** reservation kaydı sonrası HTML transactional e-posta şablonu — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#notification-flow) |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | APPT-013 |
| **Notlar** | Klinik içi randevu oluşturmada da geçerli olabilir. **Reminders Detail** (clinic-wide) — [daysmart.md](../competitors/daysmart.md#sandbox--reminders-reminders-detail). **Patient + Client Profile Reminders** patient-scoped/client-scoped — [Patients Module](../competitors/daysmart.md#documents--notes--relationships--reminders--wellness--tasks), [Clients Module Reminders](../competitors/daysmart.md#client-reminders). Reminder Bundle + multi schedule rule. Reminder ≠ Task. → [EXAM-014](#exam-014--item-rules-bundle-ve-record-oluşturma) |

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
| **Notlar** | Gerçek zamanlı teknik çözüm kesinleştirilmedi → [IDEA-015](../research/ideas.md#idea-015--real-time-operational-notification-center) |

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
| **Notlar** | → [PATTERN-012](../research/patterns.md#pattern-012--configurable-resource-calendar). DaySmart sandbox: gün/hafta, hekim + Tech Appts kolonları, All Columns, boş hücre → randevu modalı — sandbox gözlemi. **Canlı sandbox — Boarding:** oda-kaynak timeline; Max:N kapasite; gün/hafta/ay — **doğrulanmadı** → [daysmart.md](../competitors/daysmart.md#reservation-calendar) |

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
| **Durum** | Araştırılacak |
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
| **Notlar** | Trial'da gerçek SMS sınırlandırılır |

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
| **Notlar** | |

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
| **Notlar** | Trial'da gerçek işlem sınırlandırılır. **Inventory Module:** item-level tax applicability (US VAT/GST benchmark); Vetinity KDV/e-belge ürün vergi config — US taksonomisi kopyalanmaz → [daysmart.md](../competitors/daysmart.md#inventory-taxes) |

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

---

## İlgili belgeler

- [Roadmap](../roadmap/roadmap.md)
- [Stratejik kararlar (ADR)](../decisions/ADR-001-self-service-trial-strategy.md)
- [UX navigasyon](../ux/navigation.md)
