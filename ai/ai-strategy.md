# AI Stratejisi

Vetinity'de yapay zeka, ayrı bir ürün modülü veya gösteri alanı olarak değil; mevcut klinik iş akışlarına gömülü yardımcı yetenekler olarak konumlandırılır. Detaylı aşamalar [AI roadmap](ai-roadmap.md) belgesinde tutulur.

## AI'nin ürün içindeki rolü

AI, veteriner hekimin ve klinik personelin günlük iş yükünü hafifleten bir **yardımcı**dır. Tanı koymaz, reçete yazmaz, doz kararı vermez. Taslak üretir; nihai karar ve sorumluluk hekimdedir.

**Temel ilke:** AI yardımcı olmalı; kullanıcı kararını devralmamalıdır ([UX ilkeleri](../ux/ux-principles.md)).

Stratejik karar: [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md)

---

## Gömülü yardımcı yaklaşımı

AI, ayrı bir ana sidebar menüsü veya izole "AI modülü" **değildir**. Yetenekler ilgili ekranlarda sunulur:

| Ekran / Akış | AI yeteneği |
|---|---|
| Muayene | Serbest notu yapılandırma |
| Hasta profili / geçmiş | Geçmiş özeti |
| Muayene sonrası | Hasta sahibi açıklama taslağı |
| Taburcu | Evde bakım / taburcu talimatı taslağı |

Navigasyon etkisi: [Navigasyon yapısı](../ux/navigation.md)

---

## İnsan onayı ve taslak statüsü

Tüm AI çıktıları **taslak** statüsündedir.

1. AI çıktı üretir.
2. Kullanıcı çıktıyı inceler ve düzenler.
3. Kullanıcı açık onay verir.
4. Onaylanan içerik klinik kayıt olarak kaydedilir.

**Kullanıcı onayı olmadan kesin klinik kayıt olarak kaydedilmez.**

İlgili backlog: [AI-009](../backlog/feature-backlog.md)

---

## İlk aşamada kapsam dışı yetenekler

Aşağıdaki yetenekler bilinçli olarak ilk fazda **kapsam dışıdır**:

- Otomatik kesin tanı koyma
- Otomatik reçete oluşturma
- Bağımsız doz kararı verme

Bu sınırlar klinik güvenlik ve düzenleyici sorumluluk gereği konulmuştur. Yüksek riskli alanlar yalnızca araştırma kapsamında değerlendirilir ([AI roadmap Aşama 3](ai-roadmap.md)).

---

## Klinik güvenlik

- Hekim nihai sorumluluğu ve kontrolü korunur.
- AI çıktıları tıbbi tavsiye olarak sunulmaz; taslak ve düzenlenebilir içerik olarak sunulur.
- AI servisinin kullanılamaması temel klinik iş akışını **durdurmaz**. Muayene, reçete ve diğer modüller AI olmadan da tam işlevsel kalır.

---

## Tenant izolasyonu

Multi-tenant yapıda her klinik (tenant) verisi birbirinden izole tutulur. AI istekleri yalnızca ilgili tenant bağlamında işlenir; tenant verileri karışmaz.

---

## Provider-independent backend yaklaşımı

- AI sağlayıcısı **frontend'den doğrudan çağrılmaz**.
- Tüm AI istekleri backend üzerinden yönlendirilir.
- Sağlayıcı değişikliği backend katmanında yönetilir; frontend contract'ı stabil kalır.
- Teknik uygulama detayları backend repository'sinde tutulur.

---

## API anahtarı güvenliği

- API anahtarları frontend'e **verilmez**.
- Anahtarlar yalnızca backend ortamında saklanır.
- Trial hesaplarında API anahtarı yönetimi kısıtlanabilir ([TRIAL-004](../backlog/feature-backlog.md)).

---

## Hassas verilerin loglanmaması

Hassas klinik veriler (muayene notları, tanılar, lab sonuçları vb.) normal uygulama loglarına açık şekilde yazılmaz. AI audit kayıtları metadata odaklı tutulur ([AI-010](../backlog/feature-backlog.md)).

---

## Kullanım kotası

AI kullanımı tenant ve abonelik planı bazında kotayla sınırlandırılabilir. Kota aşımında kullanıcı bilgilendirilir; temel klinik akış etkilenmez.

İlgili backlog: [AI-007](../backlog/feature-backlog.md)

---

## Maliyet takibi

AI servis maliyeti tenant ve özellik bazında izlenir. Operasyonel kontrol ve fiyatlandırma kararları için metrik toplanır.

İlgili backlog: [AI-008](../backlog/feature-backlog.md)

---

## Claim ve abonelik planı bağlantısı

AI yetenekleri operation claim ve abonelik planı ile sınırlandırılabilir:

- Belirli AI özellikleri yalnızca üst planlarda sunulabilir.
- Claim'i olmayan kullanıcı AI butonlarını görmez.
- Trial'da sınırlı AI kotası uygulanabilir.

---

## AI servisi başarısız olduğunda

AI servisi geçici olarak kullanılamazsa:

- Kullanıcıya anlaşılır hata mesajı gösterilir.
- Manuel veri girişi ve mevcut iş akışları kesintisiz devam eder.
- AI butonu devre dışı bırakılabilir; ekranın geri kalanı çalışır.

---

## İlk düşük riskli kullanım alanları

| Alan | Açıklama | Backlog |
|---|---|---|
| Muayene notu yapılandırma | Serbest metni yapılandırılmış alanlara dönüştür | [AI-001](../backlog/feature-backlog.md) |
| Hasta geçmişi özeti | Kronolojik kayıtların özeti | [AI-002](../backlog/feature-backlog.md) |
| Hasta sahibi bilgilendirmesi | Sade açıklama taslağı | [AI-003](../backlog/feature-backlog.md) |
| Taburcu talimatı | Evde bakım talimatı taslağı | [AI-004](../backlog/feature-backlog.md) |

---

## İlgili belgeler

- [AI roadmap](ai-roadmap.md)
- [ADR-008 — Gömülü AI yardımcısı](../decisions/ADR-008-embedded-ai-assistant.md)
- [UX ilkeleri — AI ilkesi](../ux/ux-principles.md)
- [Feature backlog — AI maddeleri](../backlog/feature-backlog.md)
