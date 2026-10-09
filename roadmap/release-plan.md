# Vetinity Release Plan

> **Not:** Bu belge kesin tarih taahhüdü içermez. Aşamalı yayın yaklaşımını, giriş/çıkış kriterlerini ve ölçülecek metrikleri tanımlar. Detaylı özellik listesi için [roadmap](roadmap.md) ve [feature backlog](../backlog/feature-backlog.md) kullanılır.

> **Ana plan (2026-10-09):** Bu release plan, [Uçtan uca yol haritası ve ürün kararları](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md) belgesine (8 Ekim 2026) hizalanır. Sıra veya kapsamda çelişki olursa **o belge geçerlidir**. Aşağıdaki "Yayın aşaması" yapısı silinmedi; "Önceki aşama yapısı (referans)" başlığı altında korunuyor. Karışıklık olmaması için ana plandaki numaralara "Ana plan Aşama N", bu belgedekilere "Yayın aşaması N" denir.

---

## Ana plana göre aşama eşlemesi

| Yayın aşaması (önceki) | Ana plandaki karşılığı | Değişiklik |
|---|---|---|
| 1 — Çıkış öncesi ürün tamamlama | Ana plan Aşama 0–3 (muayene, geliş/Bugün, temel ücret/bakiye); menü ve Rapor Merkezi Aşama 8'e kayar | "Menü sadeleştirme ve Rapor Merkezi uygulandı" çıkış kriteri Aşama 8'e taşındı. Geliş/Bugün ve temel finans yeni giriş kriterleri. |
| 2 — Kontrollü pilot | Ana plan Aşama 9 | Pilot tamamen bitişten sonra değil: Aşama 1–3 kabul edilince kapsamı açık sınırlı senaryolar pilot kullanıcıyla denenebilir. Aşama 4–8 gerçek geri bildirimle tamamlanır. |
| 3 — Self-service trial açılışı | Ana plan Aşama 8 | **Sıra değişti.** Trial ve örnek klinik, muayene/geliş/finans temelinden sonra teslim edilir ve pilot çıkış kapılarına dahildir. Dış kullanıcıya açılış kararı ayrıca verilir. |
| 4 — İlk ücretli müşteriler | Ana plan Aşama 9 (ilk ticari sürüm) | Abonelik ve ödeme akışı ana planda yalnızca "platform" kapısı olarak geçer; ayrıntılı zamanlama **açık soru**. |
| 5 — Premium klinik özellikleri | Ana plan Aşama 4 (özet, uyarı, timeline, revizyon), Aşama 6 (görüntüleme) ve Aşama 10 (şablon, paket, AI) | **Çelişki çözüldü:** temel timeline/özet/görüntüleme v1.0 kapsamında; ileri sürümleri, şablon/bundle/doz hesaplayıcı ve AI ilk ticari sürümden sonra (Aşama 10). |
| 6 — Entegrasyon genişlemesi | Ana plan Aşama 11 | Talebe göre. SMS/e-belge pilot için engelse erkene alınır. Cihaz entegrasyonları Aşama 12. |
| 7 — Mobil ve enterprise genişlemesi | Ana plan Aşama 12 (ve portal için Aşama 11) | İlk sürümde native mobil yok; enterprise ayrı araştırma ve pilot. |

### İlk ticari sürümün çıkış kapıları

Ana plan bölüm 14 on iki kapı tanımlar: hasta/ziyaret, muayene, işlem sürekliliği, finans, geçmiş/takip, klinik kayıt politikası, platform, rapor/iletişim, deneme/kullanım, canlı işletim, müşteri geçişi ve pilot kabulü. Bunlar yapılmış test sonuçları değil, önerilen çıkış koşullarıdır; seçilen pilot profiline göre daraltılıp ürün belgelerine yazılır. Aşağıdaki önceki çıkış kriterleri bu kapılarla birlikte okunur.

---

## Önceki aşama yapısı (referans)

> **Not:** Aşağıdaki yedi yayın aşaması 2026-10-09 öncesi yapıdır. Sıra için yukarıdaki eşlemeye bakın. Giriş/çıkış kriterleri ve metrikler geçerliliğini korur.

## Aşama 1 — Çıkış öncesi ürün tamamlama

### Amaç

Temel klinik modüllerinin tutarlı bir deneyimle bir araya getirilmesi; muayene deneyimi, menü sadeleştirme ve Rapor Merkezi yaklaşımının olgunlaştırılması.

### Giriş kriterleri

- Mevcut klinik modülleri (müşteri, hayvan, randevu, muayene, tedavi, stok vb.) kullanılabilir durumda
- Multi-tenant altyapı ve yetkilendirme çalışıyor

### Çıkış kriterleri

- Modern muayene çalışma alanı tasarımı onaylandı ve geliştirmeye alındı
- Menü sadeleştirme hedefi tanımlandı (Tanımlar merkezi)
- Rapor Merkezi yaklaşımı sidebar'da uygulandı
- İç test ortamında uçtan uca klinik akış doğrulandı

### Kritik riskler

- Muayene deneyimi gecikmesi tüm P0 takvimini etkileyebilir
- Mevcut kullanıcıların menü değişikliğine adaptasyonu

### Ölçülecek metrikler

- Muayene kaydı oluşturma süresi
- Kritik hata oranı
- Haftalık aktif klinik (iç test)

---

## Aşama 2 — Kontrollü pilot

### Amaç

Seçili kliniklerle kontrollü pilot program; gerçek kullanım geri bildirimi toplama.

### Giriş kriterleri

- Aşama 1 çıkış kriterleri karşılandı
- Pilot klinik listesi belirlendi
- Destek ve geri bildirim kanalları hazır

### Çıkış kriterleri

- En az bir pilot klinik günlük operasyonlarında Vetinity kullanıyor
- Kritik engelleyici hatalar giderildi
- Pilot geri bildirimleri backlog'a işlendi

### Kritik riskler

- Pilot kliniklerin yoğun dönemde adaptasyon zorluğu
- Eksik entegrasyonların (SMS, e-Fatura) pilot beklentilerini karşılamaması

### Ölçülecek metrikler

- Klinik başına aktif kullanıcı
- Destek talebi sayısı
- Kritik hata oranı
- Trial sırasında kullanılan ana modüller

---

## Aşama 3 — Self-service trial açılışı

### Amaç

Kullanıcıların satış görüşmesi olmadan 14 günlük trial başlatabilmesi; örnek klinik ile hızlı değer keşfi.

### Giriş kriterleri

- Self-service kayıt ve trial akışı hazır
- Örnek Veteriner Kliniği sentetik verisi yüklenebiliyor
- Trial kısıtlama politikası uygulandı

### Çıkış kriterleri

- Dış kullanıcılar self-service trial başlatabiliyor
- Örnek klinik onboarding seçeneği aktif
- Trial kısıtlamaları (SMS, e-Fatura, POS vb.) doğrulandı

### Kritik riskler

- Trial kötüye kullanımı ve maliyet kontrolü
- Örnek klinik verisinin yeterince gerçekçi olmaması

### Ölçülecek metrikler

- Trial başlatma oranı
- Örnek klinik seçme oranı
- İlk 10 dakikada tamamlanan anlamlı aksiyon sayısı
- Trial aktivasyon oranı
- İlk değer anına ulaşma süresi

→ [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) · [ADR-002](../decisions/ADR-002-example-clinic-strategy.md)

---

## Aşama 4 — İlk ücretli müşteriler

### Amaç

Trial'dan ücretli plana dönüşüm akışının çalışması; ilk ödeme yapan müşterilerin kazanılması.

### Giriş kriterleri

- Aşama 3 çıkış kriterleri karşılandı
- Abonelik ve ödeme akışı hazır
- Trial'dan ücretli plana dönüşüm UX tamamlandı

### Çıkış kriterleri

- İlk ücretli müşteriler aktif kullanıyor
- Dönüşüm akışı uçtan uca doğrulandı
- Temel destek süreci işliyor

### Kritik riskler

- Düşük trial-to-paid dönüşüm oranı
- Ödeme entegrasyonu sorunları

### Ölçülecek metrikler

- Trial-to-paid dönüşüm oranı
- Trial aktivasyon oranı
- Destek talebi sayısı
- Haftalık aktif klinik

---

## Aşama 5 — Premium klinik özellikleri

### Amaç

Hasta timeline, görüntüleme modülü, muayene şablonları, bundle'lar, doz hesaplayıcı ve ilk AI yardımcılarının sunulması.

### Giriş kriterleri

- Aşama 4 çıkış kriterleri karşılandı
- P1 roadmap maddeleri için tasarım/onay tamamlandı

### Çıkış kriterleri

- Hasta timeline temel görünümü kullanılabilir
- Görüntüleme modülü temel yükleme/görüntüleme destekliyor
- En az bir AI yardımcı yeteneği (muayene notu yapılandırma vb.) aktif

### Kritik riskler

- Timeline performansı (çok kayıtlı hastalar)
- AI maliyet kontrolü ve kota yönetimi

### Ölçülecek metrikler

- Muayene kaydı oluşturma süresi
- AI kullanım kotası ve maliyet takibi
- Haftalık aktif klinik
- Klinik başına aktif kullanıcı

→ [Roadmap P1](roadmap.md#p1--premium-klinik-deneyimi)

---

## Aşama 6 — Entegrasyon genişlemesi

### Amaç

e-Fatura, SMS, WhatsApp, POS ve cihaz entegrasyonlarının kademeli açılması.

### Giriş kriterleri

- Aşama 5 çıkış kriterleri karşılandı
- Entegrasyon partnerleri ve teknik gereksinimler netleşti

### Çıkış kriterleri

- En az iki entegrasyon (ör. SMS + e-Fatura) üretim ortamında
- Entegrasyon modüler yapısı doğrulandı; kullanılmayan entegrasyonlar arayüzü karmaşıklaştırmıyor

### Kritik riskler

- Üçüncü taraf API değişiklikleri
- Entegrasyon maliyetlerinin abonelik planına yansıması

### Ölçülecek metrikler

- Entegrasyon kullanım oranı (klinik başına)
- Destek talebi sayısı (entegrasyon kaynaklı)
- Kritik hata oranı

→ [Roadmap P2](roadmap.md#p2--entegrasyonlar-ve-gelişmiş-ai)

---

## Aşama 7 — Mobil ve enterprise genişlemesi

### Amaç

Veteriner mobil uygulaması, hasta sahibi deneyimi ve enterprise özelliklerinin (çok şube, SSO, audit) kademeli sunulması.

### Giriş kriterleri

- Aşama 6 çıkış kriterleri karşılandı
- Mobil ve enterprise gereksinimleri doğrulandı

### Çıkış kriterleri

- Veteriner mobil uygulaması temel işlevlerle yayında
- En az bir enterprise özelliği (ör. çok şubeli yönetim) pilot müşteride

### Kritik riskler

- Mobil geliştirme kaynak ihtiyacı
- Enterprise gereksinimlerinin ürün karmaşıklığını artırması

### Ölçülecek metrikler

- Mobil aktif kullanıcı oranı
- Enterprise müşteri sayısı
- Haftalık aktif klinik
- Kurumsal raporlama kullanımı

→ [Roadmap P3](roadmap.md#p3--mobil-ve-hasta-sahibi-deneyimi) · [Roadmap P4](roadmap.md#p4--enterprise)

---

## Genel metrik referansı

| Metrik | Açıklama |
|---|---|
| Trial başlatma oranı | Ziyaretçi → trial kaydı |
| Örnek klinik seçme oranı | Trial kullanıcılarının örnek klinik seçme yüzdesi |
| İlk 10 dakikada anlamlı aksiyon | Muayene, randevu, hayvan ekleme vb. |
| Trial aktivasyon oranı | Trial başlatanların en az bir modül kullanma oranı |
| Trial-to-paid dönüşüm | Trial bitiminde ücretli plana geçiş |
| Muayene kaydı oluşturma süresi | Ortalama süre |
| Haftalık aktif klinik | En az bir işlem yapan klinik sayısı |
| Klinik başına aktif kullanıcı | Ortalama |
| Destek talebi sayısı | Dönemsel |
| Kritik hata oranı | Engelleme düzeyinde hata |
| İlk değer anına ulaşma süresi | Kayıt → ilk anlamlı klinik işlem |

---

## İlgili belgeler

- [Uçtan uca yol haritası ve ürün kararları (ana plan)](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)
- [Roadmap](roadmap.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [Release notes](../release-notes/README.md)
