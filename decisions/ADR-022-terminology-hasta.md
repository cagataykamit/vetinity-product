# ADR-022 — Arayüz dili: hayvan kaydına "hasta" denir

## Durum

**Kabul edildi (2026-10-15, kullanıcı: "o zaman hasta yapalım").** Hedef kitle klinik çalışanı ([ADR-020](ADR-020-clinic-staff-centered-patient-card.md)); veteriner kliniğinde hayvan kaydına "hasta" denir. Rakip pratiği ve menü kararı ([ADR-017](ADR-017-workflow-centered-navigation.md): "Hastalar") ile tutarlı.

## Karar

1. **Arayüzde Pet varlığı her yerde "hasta"** olarak adlandırılır: Hasta, Hastalar, Yeni hasta, Hasta kartı, hasta adı, hasta seçici, hata ve bildirim metinleri, rapor ve defter sütunları, yazdırma.
2. **Menü/sekme:** menü öğesi "Hastalar" kalır; içindeki sekmeler "Ara · Müşteriler · Hastalar".
3. **Kalanlar (hayvan sınıflaması):** "Tür", "Irk", "Hayvan türleri" (Ayarlar > Tanımlar) hayvanın biyolojik sınıflamasıdır ve "hayvan" olarak kalır; "kısırlaştırılmış mı" gibi alan adları etkilenmez. Müşteriyle ilgili cümlelerde ("sahibin hayvanları") "hasta" kullanılır, tutarlılık için.
4. **Teknik adlar değişmez:** API, rota (`/panel/pets`), kod, veritabanı, izin ve alan adları `Pet` olarak kalır; yalnız kullanıcıya görünen metin değişir.
5. **Müşteriye giden metinler** (e-posta/SMS şablonları, KVKK formu): bu karar kapsamı dışı; müşteri dili ("hayvanınız") ayrı değerlendirilir ve pilot klinikle doğrulanır.

## Sonuçlar

- Frontend metin geçişi (panel-tr.ts, bileşen şablonları, spec'ler); başlık bileşeni kategori bağlantısının yazısı hedef listenin sekme adından türetilir (tek kural).
- Riskler: kısmi geçiş tutarsızlık yaratır; tüm görünür metinler tek işte taranır. Müşteriye giden şablonlar ayrı kalır.
