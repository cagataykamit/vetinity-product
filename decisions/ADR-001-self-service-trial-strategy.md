# ADR-001 — Self-service trial stratejisi

## Durum

Kabul edildi

## Bağlam

Veteriner klinik yönetim yazılımlarında yaygın müşteri edinme modeli, potansiyel müşterinin satış temsilcisiyle görüşmesi, demo planlaması ve ardından erişim almasıdır. Bu model:

- Ürün keşfini yavaşlatır
- Küçük klinikler için giriş bariyeri oluşturur
- Ürünün gerçek değerini deneyimlemeden karar vermeyi zorunlu kılar

Vetinity, gizlenen veya yalnızca satış temsilcisinin ekran paylaşımında gösterilen bir ürün olarak konumlandırılmayacaktır. Doğrudan deneyimlenebilen modern bir SaaS olarak konumlandırılacaktır.

## Karar

1. **Self-service trial** ana müşteri edinme kanallarından biri olacaktır.
2. Kullanıcı kendi hesabını oluşturabilecek; trial başlatmak için biriyle görüşmesi **gerekmeyecektir**.
3. Deneme süresi başlangıç kararı olarak **14 gündür**.
4. Canlı demo tamamen kaldırılmayacak; büyük klinikler, hastaneler ve kurumsal müşteriler için **isteğe bağlı** canlı demo sunulabilecektir.
5. Trial hesabı günlük kullanımın büyük bölümünü deneyimleyebilecektir; gerçek dış sistem işlemleri kısıtlanabilir (detay: trial kısıtlama politikası).

## Gerekçe

- Modern SaaS beklentisi: kullanıcı anında deneyimlemek ister
- Küçük klinikler satış sürecine katlanmak istemez
- Ürün kalitesi kendi kendini satmalıdır
- Canlı demo kurumsal satış için hâlâ değerlidir; ancak ana kanal olmamalıdır

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Yalnızca satış temsilcisi ile demo | Yüksek sürtünme; ölçeklenemez edinme |
| Sınırsız ücretsiz plan | Maliyet kontrolü zor; değer algısı düşer |
| Canlı demonun tamamen kaldırılması | Kurumsal müşteriler kişiselleştirilmiş demo isteyebilir |

## Olumlu sonuçlar

- Daha hızlı müşteri edinimi
- Ürün değerinin doğrudan deneyimlenmesi
- Trial metrikleri ile veri odaklı optimizasyon
- Modern SaaS konumlandırması

## Riskler ve olumsuz sonuçlar

- Trial kötüye kullanımı (sahte hesaplar, kaynak tüketimi)
- Düşük nitelikli trial kayıtları (satış ekibi yükü)
- Gerçek dış sistem işlemlerinin trial'da kısıtlanması kullanıcı beklentisi yaratabilir

## Uygulama etkileri

- Kayıt ve onboarding akışı self-service olmalı
- Trial süresi ve kısıtlamalar abonelik modülünde yönetilmeli
- Trial metrikleri toplanmalı ([TRIAL-008](../backlog/feature-backlog.md))
- Canlı demo akışı ayrı kanal olarak korunmalı ([TRIAL-005](../backlog/feature-backlog.md))

## İlgili belgeler

- [Feature backlog — TRIAL maddeleri](../backlog/feature-backlog.md)
- [Release plan — Aşama 3](../roadmap/release-plan.md#aşama-3--self-service-trial-açılışı)
- [Roadmap P0](../roadmap/roadmap.md#p0--çıkış-öncesi-ürün-deneyimi)
- [Ürün vizyonu](../vision/vision.md)
