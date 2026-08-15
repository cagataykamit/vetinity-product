# Provet Cloud

**Analiz durumu:** Kısmi

---

## Araştırma Kapsamı

Bu inceleme, herkese açık bir eğitim/demo videosundan alınan ekran görüntülerine dayanmaktadır. Gözlemler yalnızca videoda görünen akışlarla sınırlıdır; doğrulanmayan alanlar kesin ürün kapsamı olarak değerlendirilmemelidir.

**İncelenen akış:**

- Konsültasyon ekranı
- Klinik notlar
- Tedavi kalemleri
- Prosedür ekleme
- Taburculuğa hazır duruma getirme
- Eksik ücret/prosedür önerileri
- Taslak fatura
- Ödeme ve alacak özeti

**İncelenmeyen veya doğrulanmayan alanlar** (hospitalizasyon detayları, mobil, entegrasyonlar, raporlama, çok şubeli yönetim vb.) bu belgede eksiksiz ürün kapsamı olarak ele alınmamıştır.

**Kaynak türü:** Eğitim/demo videosu ekran görüntüleri (doğrudan gözlem)

---

## Doğrudan Gözlemler

Aşağıdaki maddeler videodan gözlemlenen davranışları tanımlar; Vetinity ürün kararı değildir.

### Consultation-first workflow

Konsültasyon ekranı hasta bakım sürecinin ana çalışma alanı olarak kullanılıyor.

Aynı ekran içinde veya bağlantılı bölümlerde şunlar bulunuyor:

- Konsültasyon detayları
- Klinik notlar
- Tedavi kalemleri
- Prosedürler
- İlaçlar
- Yazılı reçeteler
- Mamalar
- Sarf malzemeleri
- Vital bulgular
- Diagnostik işlemler
- Tanılar
- Taburculuk talimatları
- Planlanan sonraki işlemler

### Section navigation

Ekranın sağ tarafında, uzun konsültasyon sayfasındaki bölümlere hızlı geçiş sağlayan bir bölüm navigasyonu bulunuyor.

### Treatment item structure

Tedavi kalemleri farklı kategoriler altında ele alınıyor:

- Procedures
- Medicines
- Written prescriptions
- Foods
- Supplies

Ürün ve hizmetler konsültasyonla ilişkilendiriliyor ve fiyatlandırmaya aktarılıyor.

### Ready for discharge workflow

Konsültasyon doğrudan tamamlanmak yerine önce **Ready for discharge** durumuna getiriliyor.

Bu işlem sırasında sistem, olası eksik veya uyumsuz ücretlendirme kalemlerini kullanıcıya gösteriyor.

### Suggestions and review

Sistem, belirli bir prosedürün genellikle başka bir konsültasyon ücretiyle birlikte kullanılması gerektiğini belirten öneriler sunuyor.

Kullanıcı:

- Önerilen kalemi seçebiliyor
- Öneriyi inceleyip çözebiliyor
- Uygun yetki/akış kapsamında önerileri uygulamadan devam edebiliyor

> **Not:** Bu mekanizma kesin yapay zekâ olarak tanımlanamaz. Gözlemlenen davranış, kural tabanlı veya karar destekli bir iş akışı olabilir; video kaynağından AI kullanımı doğrulanmamıştır.

### Procedure entry

Prosedür ekleme formunda gözlemlenen alanlar:

- Tarih
- Klinisyen
- Miktar
- Fiyat
- Toplam
- Dahili talimat
- Açıklama

### Consultation-to-invoice continuity

Konsültasyona eklenen tedavi kalemleri taslak faturaya taşınıyor.

Fatura ekranında gözlemlenenler:

- Müşteri bilgileri
- Klinik bilgileri
- Hasta
- Fatura kalemleri
- Vergi
- İndirim veya fiyat değişimi
- Sigorta talebi
- Ödemeler
- Credit notes
- Toplam
- Ödenen
- Kalan borç
- E-posta
- Yazdırma
- Kart, nakit ve karma ödeme seçenekleri

### Persistent context

Hasta, müşteri, klinisyen, konsültasyon durumu ve bazı finansal bilgiler iş akışı boyunca görünür tutuluyor.

---

## Güçlü Yönler

*Ürün değerlendirmesi — gözlemlere dayalı yorum:*

- Konsültasyon merkezli uçtan uca iş akışı
- Klinik işlem ile ücretlendirme arasındaki güçlü bağlantı
- Taburculuk öncesi eksik işlem kontrolü
- Kullanıcıyı yalnızca hata mesajıyla durdurmak yerine öneri sunması
- Uzun ekranlarda bölüm navigasyonu
- Konsültasyondan faturaya bağlamın korunması
- Prosedür, ilaç, mama ve sarf malzemelerinin aynı klinik olay altında yönetilmesi

---

## Zayıf Yönler ve UX Riskleri

*Ürün değerlendirmesi — gözlemlere dayalı yorum:*

- Konsültasyon ekranı çok uzun ve yoğun hale gelebiliyor
- Çok sayıda tablo, bölüm ve küçük buton öğrenme yükünü artırabilir
- Sağ bölüm navigasyonu yararlı olsa da temel ekranın karmaşıklığını tamamen çözmüyor
- Finans ekranında aynı anda çok fazla eylem gösteriliyor
- Sol ana navigasyon modül odaklı ve yoğun
- Kural önerileri yeterince açıklanmazsa kullanıcıya sistemin kararını anlamayı zorlaştırabilir
- Taburculuk sırasında öneri listesi fazla büyürse süreç yavaşlayabilir

---

## Vetinity İçin Çıkarımlar

Aşağıdaki maddeler kesin ürün kararı değildir; değerlendirme adayı olarak kaydedilmiştir. Detaylı fikir kayıtları: [research/ideas.md](../research/ideas.md).

### Consultation-centered clinical workspace

Vetinity'nin muayene/konsültasyon ekranı, klinik olayın ana çalışma alanı olabilir. Klinik not, tedavi, reçete, diagnostik işlem ve ücretlendirme arasında bağlam korunması değerlendirilmelidir.

→ Aday: [IDEA-001](../research/ideas.md#idea-001--consultation-centered-clinical-workspace)

### Discharge readiness checklist

Muayene veya yatış tamamlanmadan önce kontrol listesi değerlendirilmelidir.

Örnek kontrol alanları:

- Klinik not tamamlandı mı?
- Tanı veya problem kaydı var mı?
- Uygulanan işlem kaydedildi mi?
- Faturalanmamış işlem var mı?
- Reçete gerekiyorsa oluşturuldu mu?
- Kontrol randevusu gerekli mi?
- Hasta sahibi talimatı hazırlandı mı?
- Ödeme veya açık hesap durumu nedir?

Her madde zorunlu olmamalı; klinik yapılandırması, vaka türü ve kullanıcı yetkisine göre değişebilmelidir.

→ Aday: [IDEA-002](../research/ideas.md#idea-002--discharge-readiness-checklist)

### Suggestion-first validation

Kritik güvenlik kuralları dışındaki eksikler için yalnızca engelleyici hata göstermek yerine aşağıdaki yaklaşım değerlendirilmelidir:

- Uyar
- Nedenini açıkla
- Önerilen aksiyonu göster
- Uygulanabiliyorsa tek tıkla düzelt
- Yetki uygunsa gerekçe ile devam et

→ Aday: [IDEA-003](../research/ideas.md#idea-003--suggestion-first-workflow-validation)

### Section navigator

Uzun muayene ekranları için sticky bölüm navigasyonu veya benzer modern bir çözüm değerlendirilmelidir. Ancak navigasyon, gereksiz uzun tek sayfa tasarımının bahanesi olmamalıdır.

→ Aday: [IDEA-006](../research/ideas.md#idea-006--section-navigator-for-long-clinical-records)

### Clinical-to-financial traceability

Her ücret kalemi mümkün olduğunda kaynağı olan klinik işlemle ilişkilendirilmelidir.

Örnek:

- Muayene ücreti → ilgili muayene
- İlaç satırı → ilgili uygulama/reçete
- Laboratuvar ücreti → ilgili test istemi
- Görüntüleme ücreti → ilgili radyoloji istemi

Bu bağlantı denetlenebilirlik, eksik ücret kontrolü ve raporlama açısından değerlidir.

→ Aday: [IDEA-007](../research/ideas.md#idea-007--clinical-to-financial-traceability)

### Explainable workflow assistance

Vetinity ileride kural tabanlı veya AI destekli öneriler sunarsa, önerinin nedeni açıkça görünmelidir. Sistem klinik kararı hekimin yerine vermemelidir.

---

## Bilinçli Olarak Kopyalanmaması Gerekenler

- Çok uzun ve kesintisiz tek sayfa
- Aynı anda çok fazla küçük aksiyon butonu
- Yoğun tablo ağırlıklı ekranlar
- Kullanıcıya nedeni açıklanmayan öneriler
- Her öneriyi zorunlu blokaja çevirmek
- Klinik ve finansal süreci ayrı bağlamlara bölmek

---

## Açık Sorular

Aşağıdaki konular mevcut ekran görüntülerinden **doğrulanamamıştır**:

- Öneri motorunun kural tabanlı mı yoksa AI destekli mi olduğu
- Önerilerin klinik tarafından yapılandırılabilirliği
- Rol ve yetkiye göre öneriyi atlama davranışı
- Hospitalizasyon akışının ayrıntıları
- Mobil deneyim
- Offline davranış
- Türkiye'ye özel muhasebe ve e-belge uyumluluğu
- Klinik not şablonları ve SOAP desteği
- Audit log kapsamı

---

## Araştırma Sonucu

Provet Cloud'un en değerli yönü, gözlemlenen kapsamda, görsel tasarımdan çok **konsültasyon ile tedavi kalemleri, taburculuk kontrolü ve faturalama arasındaki süreklilik** olarak öne çıkmaktadır.

Vetinity için hedef, bu ekranı birebir kopyalamak değil; bu iş akışı bütünlüğünü daha sade, açıklanabilir ve modern bir deneyimle çözmek olmalıdır. İlgili fikirler [research/ideas.md](../research/ideas.md) arşivinde değerlendirme adayı olarak tutulmaktadır.

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
- [Product Research Ideas](../research/ideas.md)
