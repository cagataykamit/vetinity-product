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
| TIMELINE- | Hasta timeline |
| IMG- | Görüntüleme |
| AI- | Yapay zeka |
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
| **Notlar** | Canlı demo büyük/kurumsal müşteriler için opsiyonel kalır → [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) |

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
| **Notlar** | → [ADR-003](../decisions/ADR-003-report-center.md) |

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
| **Notlar** | Derin linkler korunmalı |

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
| **Durum** | Planlandı |
| **Bağımlılıklar** | UX-002 |
| **Notlar** | Derin linkler korunmalı |

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
| **Notlar** | → [ADR-005](../decisions/ADR-005-modern-examination-experience.md) |

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
| **Notlar** | |

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
| **Notlar** | |

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
| **Notlar** | Stratejik hedef |

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
| **Notlar** | DaySmart bundle yaklaşımından ilham; kopyalama değil |

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
| **Notlar** | AI bağımsız doz kararı vermez |

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
| **Notlar** | DaySmart uyarı panelinden ilham |

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
| **Notlar** | → [ADR-006](../decisions/ADR-006-patient-timeline.md) |

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
| **Notlar** | Ayrı kopya yok |

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
| **Notlar** | |

### TIMELINE-004 — Timeline derin bağlantıları

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
| **Notlar** | Derin linkler genel prensip |

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
| **Notlar** | → [ADR-007](../decisions/ADR-007-imaging-module.md) |

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
| **Notlar** | |

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
| **Notlar** | → [AI roadmap Aşama 2](../ai/ai-roadmap.md) |

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
| **Notlar** | |

### INT-002 — Dijital röntgen entegrasyonu araştırması

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
| **Notlar** | Trial'da gerçek işlem sınırlandırılır |

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
