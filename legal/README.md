# Hukuki metin taslakları

Bu klasör Vetinity'nin ve kliniklerin kullanacağı hukuki metinlerin **ürün ekibi tarafından hazırlanmış taslaklarını** tutur. ([ADR-024](../decisions/ADR-024-hukuki-metin-taslaklari.md): kullanıcı kararıyla ürün taslakları kendisi yazar; uzman incelemesi sonra yapılır.)

> **Uyarı:** Hiçbiri hukuki tavsiye değildir ve hukukçu tarafından onaylanmamıştır. Canlı klinik verisiyle kullanılmadan önce KVKK/veteriner mevzuatı konusunda uzman bir hukukçunun incelemesi gerekir. Köşeli parantezli `[...]` alanlar bilgi/karar gerektirir, doldurulmadan yayımlanmaz. İnceleme listesi: [roadmap/HUKUKI-ONAY-LISTESI.md](../roadmap/HUKUKI-ONAY-LISTESI.md).

## Taraflar (varsayım, A6)

- **Klinik** = veri sorumlusu (müşterisi/hasta sahibi verisini kendi amaçları için işler).
- **Vetinity** = veri işleyen (SaaS; klinik adına barındırır ve işler). Kendi kullanıcı hesapları (klinik çalışanı, site ziyaretçisi) bakımından ise Vetinity veri sorumlusudur.

## Belgeler

| Belge | Kim kime | Ürün yeri | Durum |
|---|---|---|---|
| [aydinlatma-metni.md](aydinlatma-metni.md) | Klinik → müşteri (hayvan sahibi) | Müşteri kartı, yazdırma; Ayarlar'da klinik başına şablon | Taslak, onay bekliyor |
| [acik-riza-metni.md](acik-riza-metni.md) | Klinik → müşteri | ADR-021 formu; varsayılan metin (backend `ClinicKvkkFormTemplateDefaults`) | Taslak, onay bekliyor |
| [gizlilik-politikasi.md](gizlilik-politikasi.md) | Vetinity → kullanıcılar | Herkese açık sayfa ve kayıt/giriş bağlantısı | Taslak, onay bekliyor |
| [kullanim-sartlari.md](kullanim-sartlari.md) | Vetinity ↔ klinik | Herkese açık sayfa, sürümlü kabul (TRIAL-009) | Taslak, onay bekliyor |
| [veri-isleme-sozlesmesi.md](veri-isleme-sozlesmesi.md) | Klinik ↔ Vetinity | Kayıtta kabul edilir, PDF olarak indirilebilir | Taslak, onay bekliyor |
| [saklama-ve-imha-politikasi.md](saklama-ve-imha-politikasi.md) | Klinik iç belgesi / Vetinity | Klinik için şablon, Vetinity için iç politika | Taslak, onay bekliyor |

## Sürümleme

Her belgenin başında `Sürüm` ve `Taslak tarihi` bulunur. Yayımlanan her metin sürümü saklanır; kabul kayıtları sürüm numarasını tutar (TRIAL-009).
