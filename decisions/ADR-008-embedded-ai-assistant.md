# ADR-008 — Gömülü AI yardımcısı

## Durum

Kabul edildi

## Bağlam

Veteriner SaaS pazarında AI yetenekleri giderek öne çıkmaktadır. AI'nin yanlış konumlandırılması (ayrı modül, otomatik klinik kararlar, frontend'den doğrudan çağrı) klinik güvenlik ve kullanıcı güveni riskleri taşır.

Vetinity AI'yi ayrı bir gösteri modülü olarak değil, günlük klinik iş akışlarına gömülü bir yardımcı olarak kullanacaktır.

## Karar

1. AI **ayrı bir ana sidebar menüsü** veya izole edilmiş "AI modülü" olarak konumlandırılmayacaktır.
2. AI, mevcut klinik iş akışlarına **gömülü yardımcı yeteneklerden** oluşacaktır.
3. Tüm AI çıktıları **taslak** statüsündedir; kullanıcı onayı olmadan kesin klinik kayıt olarak kaydedilmez.
4. AI ilk aşamada:
   - Otomatik kesin tanı **koymaz**
   - Otomatik reçete **oluşturmaz**
   - Bağımsız doz kararı **vermez**
5. Hekim nihai sorumluluğu ve kontrolü korunur.
6. AI servisinin kullanılamaması temel klinik iş akışını **durdurmaz**.
7. AI sağlayıcısı frontend'den doğrudan çağrılmaz; **provider-independent backend** yaklaşımı hedeflenir.
8. API anahtarları frontend'e verilmez.
9. Tenant verileri birbirinden izole tutulur.
10. Hassas klinik veriler normal uygulama loglarına açık şekilde yazılmaz.
11. Kullanım kotası ve maliyet takibi yapılmalıdır.
12. AI yetenekleri claim ve abonelik planı ile sınırlandırılabilir.

### İlk düşük riskli AI kullanım alanları

- Serbest muayene notunu yapılandırma
- Hasta geçmişini özetleme
- Hasta sahibine sade açıklama taslağı hazırlama
- Taburcu veya evde bakım talimatı taslağı hazırlama

## Gerekçe

- Klinik güvenlik: hekim kontrolü korunur
- UX tutarlılığı: AI ayrı modül menüyü şişirir ([ADR-004](ADR-004-navigation-and-menu-philosophy.md))
- Güvenlik: backend proxy, tenant izolasyonu, log kısıtlaması
- Operasyonel: kota ve maliyet kontrolü
- Dayanıklılık: AI başarısızlığı klinik akışı durdurmaz

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Ayrı AI sidebar menüsü | Menü şişmesi; gösteri modülü riski |
| Otomatik tanı/reçete (ilk faz) | Klinik güvenlik riski; düzenleyici sorun |
| Frontend'den doğrudan AI çağrısı | API anahtarı güvenliği; tenant izolasyonu |
| AI olmadan ürün | Rekabet dezavantajı; ancak AI opsiyonel kalmalı |

## Olumlu sonuçlar

- Klinik güvenlik korunur
- AI doğal iş akışına entegre
- Menü sade kalır
- Maliyet kontrol altında
- Sağlayıcı bağımsızlığı

## Riskler ve olumsuz sonuçlar

- AI çıktı kalitesi kullanıcı beklentisini karşılamayabilir
- Kota sınırları kullanıcı memnuniyetsizliği yaratabilir
- Backend AI proxy geliştirme maliyeti
- Yüksek riskli AI alanları (Aşama 3) ayrı değerlendirme gerektirir

## Uygulama etkileri

- AI altyapısı backend'de ([AI stratejisi](../ai/ai-strategy.md))
- İlk yetenekler Aşama 1 ([AI roadmap](../ai/ai-roadmap.md))
- Onay akışı, kota, maliyet, audit ([AI-007](../backlog/feature-backlog.md)–[AI-010](../backlog/feature-backlog.md))
- Navigasyonda AI menüsü olmayacak ([Navigasyon](../ux/navigation.md))

## İlgili belgeler

- [AI stratejisi](../ai/ai-strategy.md)
- [AI roadmap](../ai/ai-roadmap.md)
- [ADR-004 — Navigasyon](ADR-004-navigation-and-menu-philosophy.md)
- [ADR-005 — Modern muayene deneyimi](ADR-005-modern-examination-experience.md)
- [Feature backlog — AI maddeleri](../backlog/feature-backlog.md)
- [Digitail rakip analizi](../competitors/digitail.md) — AI yaklaşımı karşılaştırması
