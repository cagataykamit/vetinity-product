# ADR-047 — Veteriner bul

## Durum

**Kabul edildi (2026-11-08, kullanıcı: "Hepsi okey").** Kararlar koordinatör önerisidir, kullanıcı aynen onayladı. Hukuki görüş alınmadı; reklam ve tanıtım metni kuralları [klinik sitesi kuralları araştırmasıyla](../research/klinik-sitesi-kurallari-2026-11.md) aynı çalışma varsayımına dayanır.

İlgili: [TIER-015](../backlog/feature-backlog.md#tier-015--veteriner-bul), TIER-016, TIER-017, [ADR-033](ADR-033-alan-adi-ve-adres-duzeni.md), [ADR-035](ADR-035-paketler-ve-fiyat.md), [ADR-042](ADR-042-online-randevu-talebi.md), [ADR-045](ADR-045-klinik-web-sitesi-olusturucu.md). Fikir: CodeBody "Uzman bul"; görünüm kopyalanmaz.

## Bağlam

Hasta sahibi yakınındaki kliniği Vetinity üzerinden bulamıyor; klinik sitesinin (ADR-045) yeni müşteri getiren bir kanalı yok. Backlog'da paket, yeni müşteri ücreti ve sıralama kararları açıktı.

## Kararlar

| # | Konu | Karar |
|---|---|---|
| K1 | Paket | Tüm paketlerde (Temel, Profesyonel, Kurumsal). Ne kadar çok klinik listelenirse sayfa o kadar işe yarar; ADR-045 K13 ile aynı ilke |
| K2 | Yeni müşteri ücreti | Yok. Vitrin ücretsiz başlar; Veteriner bul'dan gelen müşteri için kliniğe ücret yansıtılmaz. Sonra ayrı karar konusu olabilir |
| K3 | Sıralama | Yakınlık ve "şu an açık" bilgisi. Sıra ödemeyle değişmez. Sayfada "Nasıl sıralıyoruz" notu bulunur |
| K4 | Katılım | Kliniğin seçimi, varsayılan kapalı. Klinik açınca listelenir, kapatınca hemen çıkar |
| K5 | Yorum ve puan | İlk sürümde yok |
| K6 | Metin | "En iyi", "en ucuz", "bir numara" gibi üstünlük ve karşılaştırma ifadeleri yok; kliniğin kendi bilgisi gösterilir |
| K7 | Adres | `vetinity.com/veteriner/{il}/{ilçe}` ve hizmet alt sayfaları. Sayfalar ADR-033 `www` geçişinden önce yapılabilir; yayın geçişle birlikte (kullanıcı söyleyince) |
| K8 | Boş sayfalar | Sonuç yoksa yakın ilçe önerilir; boş ve az klinikli sayfalar arama motoru dizinine alınmaz |
| K9 | En yakın saat | Kart TIER-017'nin herkese açık müsaitlik yolunu kullanır |

## TIER-016

Randevu talebinde kaynak bilgisi (kliniğin kendi sitesi, portal, bağlantı, telefon) Veteriner bul'u beklemeden yapılır; "Veteriner bul" kaynağı sayfa gelince eklenir.

## Sonuçlar

- Bir klinik listelendiği için ücret ödemez; sıralama tarafsızlığı satış iddiası olarak kullanılabilir.
- Yeni müşteri ücreti ileride konursa bu ADR'nin K2 ve K3'ü birlikte yeniden değerlendirilir.

## Uygulama notu

2026-11-08: yerel main'de (BE `cc5802a7`, FE `1fb0c3f8`); yayın ADR-033 geçişini bekliyor. K8 eşiği 3 klinik (`VetFinderPages.MinClinicsToIndex`). TIER-016 "Veteriner bul" kaynağı artık üretiliyor.
