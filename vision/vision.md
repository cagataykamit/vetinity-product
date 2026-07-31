# Vetinity Ürün Vizyonu

## Özet

Vetinity, veteriner klinikleri ve veteriner hastaneleri için geliştirilen multi-tenant bir SaaS klinik yönetim platformudur. Uzun vadede Türkiye'nin en modern veteriner klinik yönetim platformlarından biri olmayı ve uluslararası ölçekte rekabet edebilen bir **Veterinary Operating System** yaklaşımına ilerlemeyi hedefler.

## Vizyon ifadesi

> Klinik operasyonlarını dağınık ekranlardan kurtarıp birbirine bağlı iş akışlarında toplayan; küçük kliniklerden çok şubeli veteriner hastanelerine kadar ölçeklenen; modern, sade, hızlı ve güvenilir bir veteriner klinik yönetim platformu olmak.

## Temel hedefler

### 1. Modern ve erişilebilir SaaS deneyimi

Vetinity, gizlenen veya yalnızca satış temsilcisinin ekran paylaşımında gösterilen bir ürün olarak konumlandırılmayacaktır. Kullanıcılar satış temsilcisi zorunluluğu olmadan ürünü doğrudan deneyebilecektir. Detaylar: [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md).

### 2. Ölçeklenebilir klinik operasyonları

Platform, günlük klinik iş akışlarını — randevu, muayene, tedavi, laboratuvar, stok, ödeme — birbirine bağlı ve tutarlı bir deneyimde sunar. Dağınık ekranlar yerine bağlam koruyan çalışma alanları hedeflenir.

### 3. Sürdürülebilir navigasyon

Yeni özellikler eklendikçe sidebar ve arayüzün şişmesi önlenir. "Yeni özellik eşittir yeni menü değildir" ilkesi ürünün temel UX felsefesidir. Detaylar: [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md), [UX ilkeleri](../ux/ux-principles.md).

### 4. Gömülü AI yaklaşımı

AI, ayrı bir gösteri modülü veya izole sidebar menüsü olarak değil; muayene, hasta geçmişi ve klinik iletişim gibi günlük iş akışlarına gömülü bir yardımcı olarak konumlandırılır. Detaylar: [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md), [AI stratejisi](../ai/ai-strategy.md).

### 5. Problem odaklı rekabet

Rakip özellikleri doğrudan kopyalamak yerine çözdükleri problem anlaşılır ve Vetinity'nin kendi UX ve iş akışı felsefesiyle ele alınır. Detaylar: [Rakip analizleri](../competitors/README.md).

## Mevcut ürün kapsamı

Platform şu anda aşağıdaki modülleri kapsamaktadır. Bu liste ürün bağlamı içindir; teknik uygulama detayları frontend ve backend repository'lerinde tutulur.

**Klinik operasyonlar:** Dashboard, müşteri yönetimi, hayvan yönetimi, randevular, randevu takvimi, muayeneler, tedaviler, reçeteler, laboratuvar sonuçları, yatışlar, aşılar, ödemeler, hatırlatmalar.

**Stok ve ürün:** Ürünler, stok durumu, stok hareketleri, ürün kategorileri.

**Raporlama:** Raporlar (Rapor Merkezi yaklaşımına dönüşüm hedeflenmektedir).

**Yönetim:** Hesap ayarları, şifre işlemleri, abonelik, klinik yönetimi, organizasyon yönetimi, üyeler, rol ve yetki matrisi, davet sistemi, tür ve ırk tanımları.

## Uzun vadeli yön

| Alan | Hedef |
|---|---|
| Muayene deneyimi | Kritik çalışma alanı; SOAP mantığı, Türkçe terminoloji, şablon ve bundle desteği |
| Hasta geçmişi | Merkezi timeline görünümü |
| Görüntüleme | Röntgen, ultrason, CT, MR, endoskopi, DICOM desteği |
| AI | Düşük riskli klinik yardımcılar → iş akışı desteği → kontrollü araştırma alanları |
| Entegrasyonlar | SMS, e-Fatura, POS, cihaz entegrasyonları |
| Mobil | Veteriner ve hasta sahibi uygulamaları |
| Enterprise | Çok şubeli yönetim, SSO, audit, workflow engine |

Detaylı önceliklendirme: [Roadmap](../roadmap/roadmap.md).

## Temel ilkeler

1. **Kullanıcı deneyimi** — Sade, hızlı, öğretici boş durumlar.
2. **Klinik güvenlik** — Hekim nihai sorumluluğu; AI taslak üretir, otomatik karar vermez.
3. **Veri izolasyonu** — Multi-tenant yapıda tenant verileri birbirinden izole tutulur.
4. **Sürdürülebilirlik** — Yıllar içinde özellik eklense bile navigasyon yönetilebilir kalır.

## İlgili belgeler

- [Roadmap](../roadmap/roadmap.md)
- [Feature backlog](../backlog/feature-backlog.md)
- [UX ilkeleri](../ux/ux-principles.md)
- [Stratejik kararlar (ADR)](../decisions/ADR-001-self-service-trial-strategy.md)
