# Product Principles

Bu belge ürün özelliklerini değil, Vetinity geliştirilirken uyulacak **ürün tasarım ilkelerini** tanımlar.

Prensipler backlog, roadmap veya ADR değildir. Özellik kararlarında rehber olarak kullanılır; tek başına geliştirme taahhüdü anlamına gelmez.

---

## 1. Workflow First

**Principle:** Klinik iş akışı, özellik listesinden önce gelir.

**Why:** Veteriner hekimler yazılımı özellikleri kullanmak için değil, hasta bakmak için açar. Dağınık ekranlar ve kopuk adımlar günlük operasyonu yavaşlatır.

**Implication:** Yeni bir özellik eklemeden önce mevcut iş akışına doğal şekilde oturup oturmadığı değerlendirilmelidir. Modül sayısı artışı, akış bütünlüğünün gerekçesi olmamalıdır. Check-in ve checkout gibi orkestrasyon noktaları randevu, muayene, billing, belge ve form adımlarını tek akışta toplamayı hedeflemelidir. Bir ziyaretin tamamlanması; klinik durum, tahsilat, belge üretimi ve hasta sahibi iletişimini birbirinden kopuk ekranlar yerine izlenebilir tek operasyonel akışta koordine etmelidir.

---

## 2. Patient Context Always Visible

**Principle:** Hasta bağlamı, klinik işlem sırasında her zaman görünür veya tek adımda erişilebilir olmalıdır.

**Why:** Bağlam kaybı yanlış kayıt, eksik uyarı ve gereksiz ekran geçişine yol açar.

**Implication:** Muayene, tedavi, reçete ve benzeri ekranlarda hayvan özeti, kritik uyarılar ve temel kimlik bilgileri korunmalıdır. Farklı modüllere geçerken hasta hikâyesi sıfırdan aranmamalıdır. SOAP workspace üst bandı ve inbox müşteri bağlam paneli gibi kalıplar bu ilkeyi destekler.

---

## 3. Suggest Before Blocking

**Principle:** Kritik güvenlik kuralları dışında, eksik veya tutarsız durumlarda önce öner; gereksiz yere engelleme.

**Why:** Sert validasyon iş akışını keser; yalnızca uyarı veren sistemler ise önemli eksiklerin gözden kaçmasına neden olabilir.

**Implication:** Taburculuk, faturalama ve tamamlama adımlarında eksiklikler açıklanabilir önerilerle sunulmalıdır. Yetkili kullanıcı, gerekçe ile devam edebilmelidir. Her öneri zorunlu blokaj olmamalıdır.

---

## 4. Clinical Decision Belongs to the Veterinarian

**Principle:** Klinik kararın sorumluluğu veteriner hekimdedir; sistem karar vermez.

**Why:** Hasta güvenliği, mesleki sorumluluk ve düzenleyici gereksinimler otomatik klinik kararı dışlar.

**Implication:** AI ve kural tabanlı yardımcılar taslak üretir; otomatik tanı, reçete veya bağımsız doz kararı sunmamalıdır. Tüm klinik kayıtlar kullanıcı onayı olmadan kesinleşmemelidir. Doz hesaplayıcı gibi araçlar karar **desteği** sunar; nihai sorumluluk hekimdedir.

---

## 5. Embedded AI

**Principle:** Yapay zekâ ayrı bir modül veya sohbet ekranı değil; kullanıcının çalıştığı ekranların doğal parçasıdır.

**Why:** Ayrı AI ekranı iş akışından koparır ve benimsenmeyi zorlaştırır.

**Implication:** AI yetenekleri muayene, hasta geçmişi, timeline, laboratuvar ve dashboard gibi bağlamlara gömülü sunulmalıdır. Sidebar'a "AI modülü" eklenmemelidir. Klinik snippet (`#` tetiklemeli metin) AI değildir; voice dictation ayrı premium aday olarak değerlendirilmelidir.

---

## 6. Traceable Clinical Events

**Principle:** Klinik olaylar, kaynak kayıtlarıyla izlenebilir olmalıdır; finansal kalemler mümkün olduğunda kaynak klinik işlemle ilişkilendirilmelidir.

**Why:** Eksik ücret kontrolü, denetim, itiraz yönetimi ve raporlama bağlantısız veriyle zorlaşır.

**Implication:** Muayene, laboratuvar, reçete, görüntüleme ve yatış kayıtları birbirine ve ilgili ödeme satırlarına bağlanabilmelidir. Timeline ayrı veri kopyası değil, mevcut kayıtların birleşik görünümü olmalıdır. Record audit history ve lot/expiry/route izlenebilirliği bu ilkeyi destekler. SOAP ↔ Record ↔ Invoice cross-navigation bağlam kopmadan izlenebilirlik sağlar.

---

## 7. Progressive Disclosure

**Principle:** Basit varsayılan deneyim sunulur; gelişmiş seçenekler isteğe bağlı olarak açılır.

**Why:** Her kullanıcı aynı karmaşıklık seviyesine ihtiyaç duymaz; aşırı görünür alan öğrenme yükünü artırır.

**Implication:** Günlük operasyon ekranları sade tutulmalı; nadir kullanılan tanımlar, gelişmiş filtreler ve yapılandırmalar Ayarlar veya isteğe bağlı panellerde sunulmalıdır. "Yeni özellik = yeni menü" yerine iç navigasyon tercih edilmelidir. Aşamalı yeniden tasarımda eski-yeni ekran birlikte yaşaması tutarlılık riski taşır; geçiş dönemi bilinçli yönetilmelidir.

---

## 8. Minimize Duplicate Data Entry

**Principle:** Aynı bilgi birden fazla kez girilmemelidir; bir kez girilen veri ilgili akışlarda yeniden kullanılmalıdır.

**Why:** Tekrarlayan veri girişi zaman kaybı, tutarsızlık ve kullanıcı memnuniyetsizliği yaratır.

**Implication:** Konsültasyon/muayene bağlamında girilen tedavi, prosedür ve tanı bilgileri fatura, reçete ve timeline'a taşınabilmelidir. Modüller arası manuel kopyalama minimize edilmelidir. Bundle genişlemesi ve check-in orkestrasyonu bu ilkeyi güçlendirir.

---

## 9. Explainable Assistance

**Principle:** Sistem önerileri ve uyarıları nedeniyle birlikte sunulmalıdır.

**Why:** Açıklanmayan öneriler güveni azaltır; kullanıcı sistemin kararını anlayamaz ve atlamaya eğilim gösterir.

**Implication:** Kural tabanlı veya AI destekli önerilerde "neden bu öneri?" görünür olmalıdır. Opak otomasyon kabul edilmemelidir. Bundle item rule gibi otomatik dahil/hariç kuralları uygulandığında kuralın özeti görünür olmalıdır.

---

## 10. Consistency Over Feature Count

**Principle:** Tutarlı ve sade deneyim, özellik sayısından önceliklidir.

**Why:** Özellik birikimi navigasyonu şişirir, UX tutarsızlığı yaratır ve uzun vadede sürdürülebilirliği zorlaştırır.

**Implication:** Rakip özellikleri problem odaklı değerlendirilmeli; birebir kopyalama yapılmamalıdır. Her yeni yetenek mevcut UX dili, terminoloji ve navigasyon felsefesiyle uyumlu olmalıdır. Benchmark sırasında özellik sayısı değil iş akışı kalitesi önceliklidir → [WORKFLOW.md — Benchmark değerlendirme prensipleri](../WORKFLOW.md#benchmark-değerlendirme-prensipleri)

---

## İlgili belgeler

- [Ürün vizyonu](vision.md)
- [Hedef pazarlar](target-markets.md)
- [UX ilkeleri](../ux/ux-principles.md)
- [Product Patterns](../research/patterns.md)
- [Benchmark değerlendirme prensipleri](../WORKFLOW.md#benchmark-değerlendirme-prensipleri)
