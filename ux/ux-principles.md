# UX İlkeleri

Vetinity'nin kullanıcı deneyimi kararlarında rehber olan temel ilkeler. Stratejik kararlar için [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) ve [ADR-005](../decisions/ADR-005-modern-examination-experience.md) ile birlikte okunmalıdır.

---

## 1. Menü sade kalmalıdır

Sidebar ve üst navigasyon, klinik personelin günlük iş akışında en sık kullandığı modüllere odaklanmalıdır. Tanım ekranları, rapor alt türleri ve nadir kullanılan ayarlar ana menüyü kalabalıklaştırmamalıdır.

**Uygulama:** Raporlar tek menü öğesi ([ADR-003](../decisions/ADR-003-report-center.md)); türler, ırklar ve ürün kategorileri Ayarlar > Tanımlar hedefi ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md)).

---

## 2. Yeni özellik eşittir yeni menü değildir

Her yeni özellik otomatik olarak sidebar'a yeni bir menü öğesi eklememelidir. Özellik, mevcut bir iş akışına, ayarlar bölümüne veya iç navigasyona doğal şekilde eklenebilir mi diye değerlendirilmelidir.

**Uygulama:** Yeni rapor eklemek sidebar'a yeni öğe eklemez; Rapor Merkezi iç navigasyonu genişler.

---

## 3. Sık kullanılan işlere 2–3 etkileşim içinde ulaşılabilmelidir

Dashboard'dan muayene başlatma, randevu oluşturma, hasta arama gibi günlük işlemler en fazla birkaç tıklama ile erişilebilir olmalıdır.

**Uygulama:** Hızlı aksiyonlar desteklenir; ancak ekran kalabalığı oluşturulmaz.

---

## 4. Hasta bağlamı işlem sırasında korunmalıdır

Muayene, tedavi veya reçete oluştururken hangi hayvan ve müşteri üzerinde çalışıldığı her zaman görünür olmalıdır. Kullanıcı bağlamı kaybetmemelidir.

**Uygulama:** Muayene çalışma alanında hayvan özeti ve kritik uyarılar görünür ([ADR-005](../decisions/ADR-005-modern-examination-experience.md)).

---

## 5. Klinik bağlam kaybolmamalıdır

Bir klinik kaydı (muayene, lab, görüntüleme) oluşturulurken ilgili muayene veya randevu bağlamı korunmalıdır. Kopuk ekranlar arasında gereksiz geçiş yapılmamalıdır.

---

## 6. İlişkili klinik veriler kopuk ekranlara dağıtılmamalıdır

Laboratuvar sonucu, reçete, görüntüleme ve tedavi aynı hasta hikâyesinin parçalarıdır. Mümkün olduğunca aynı çalışma alanından veya tek tıkla erişilebilir olmalıdır.

**Uygulama:** Muayene sırasında hızlı lab/reçete/görüntüleme bağlantısı ([EXAM-010](../backlog/feature-backlog.md)).

---

## 7. Timeline merkezi bağlam sağlamalıdır

Hasta geçmişi uzun vadede merkezi timeline görünümünde birleştirilecektir. Timeline, modüller arası gezinmede birincil referans noktası olacaktır ([ADR-006](../decisions/ADR-006-patient-timeline.md)).

---

## 8. Küçük ve zincirleme modal pencerelerden kaçınılmalıdır

Karmaşık klinik iş akışları (muayene, checkout, yatış) modal üstüne modal ile yönetilmemelidir. Gerektiğinde tam sayfa veya geniş çalışma alanı tercih edilmelidir.

---

## 9. Tam sayfa veya geniş çalışma alanı kullanılmalıdır

Muayene gibi yoğun veri girişi gerektiren ekranlar dar modal veya yan panel yerine geniş çalışma alanı sunmalıdır.

---

## 10. Hızlı aksiyonlar desteklenmeli; ekran kalabalığı oluşturulmamalıdır

Sık kullanılan kısayollar (yeni randevu, hızlı arama) erişilebilir olmalı; ancak her aksiyon için ayrı buton veya banner eklenmemelidir.

---

## 11. Claim'i olmayan işlevler gösterilmemelidir

Kullanıcının operation claim'i olmayan menü öğeleri, butonlar ve raporlar arayüzde hiç görünmemelidir. Devre dışı bırakılmış buton yerine gizleme tercih edilir.

**Uygulama:** Claim bazlı rapor görünürlüğü ([REPORT-006](../backlog/feature-backlog.md)).

---

## 12. Entegrasyonlar modüler olmalıdır

SMS, e-Fatura, POS gibi entegrasyonlar bağımsız modüller olarak tasarlanmalı; bir entegrasyonun olmaması diğer modülleri etkilememelidir.

---

## 13. Kullanılmayan entegrasyonlar arayüzü karmaşıklaştırmamalıdır

Klinik bir entegrasyonu aktif etmemişse, o entegrasyona ait UI öğeleri görünmemelidir.

---

## 14. AI yardımcı olmalı; kullanıcı kararını devralmamalıdır

AI çıktıları taslak statüsündedir; hekim onayı olmadan klinik kayıt olarak kaydedilmez. AI otomatik tanı, reçete veya doz kararı vermez ([ADR-008](../decisions/ADR-008-embedded-ai-assistant.md), [AI stratejisi](../ai/ai-strategy.md)).

---

## 15. Boş durumlar sonraki adımı öğretmelidir

Veri olmayan ekranlar (boş hasta listesi, rapor yok) kullanıcıya ne yapması gerektiğini açıkça göstermelidir.

**Uygulama:** Örnek klinik onboarding'de boş durum yerine sentetik veri ([ADR-002](../decisions/ADR-002-example-clinic-strategy.md)).

---

## 16. Demo ortamı yaşayan bir ürün hissi vermelidir

Trial ve örnek klinik, statik ekran görüntüsü değil; gerçek iş akışlarının denenebildiği canlı bir deneyim sunmalıdır.

---

## 17. Navigasyon uzun vadede sürdürülebilir kalmalıdır

Yıllar içinde onlarca özellik eklense bile sidebar ve menü yapısı yönetilebilir kalmalıdır. Bu, yukarıdaki menü sadeleştirme ve "yeni özellik ≠ yeni menü" ilkelerinin uzun vadeli taahhüdüdür.

---

## 18. Yeni ekran oluşturmadan önce mevcut akış değerlendirilmelidir

Her yeni özellik için önce "bu mevcut bir iş akışına eklenebilir mi?" sorusu sorulmalıdır. Yalnızca gerçekten bağımsız bir alan gerektiriyorsa yeni ekran oluşturulmalıdır.

---

## 19. Rakip arayüzleri birebir kopyalanmamalıdır

Rakip ürünler incelenirken hangi problemi çözdükleri anlaşılır; Vetinity'nin kendi UX dili ve iş akışı felsefesiyle ele alınır ([Rakip analizleri](../competitors/README.md)).

---

## İlgili belgeler

- [Navigasyon yapısı](navigation.md)
- [Tasarım kararları özeti](design-decisions.md)
- [ADR-004 — Navigasyon ve menü yaklaşımı](../decisions/ADR-004-navigation-and-menu-philosophy.md)
