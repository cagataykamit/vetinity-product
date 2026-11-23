# Hukuki metinler

Bu klasör Vetinity'nin ve kliniklerin kullanacağı hukuki metinleri tutar; metinleri ürün ekibi yazar ([ADR-024](../decisions/ADR-024-hukuki-metin-taslaklari.md)). **Kullanıcı kararı (2026-11-09): hukukçu incelemesi beklenmez, metinler bu hâliyle yürürlüktedir (sürüm 1.0).**

> 2026-11-23 (kullanıcı kararı): kullanım şartları, gizlilik, veri işleme sözleşmesi ve iki portal belgesindeki köşeli parantezli alanlar dolduruldu (süreler, iade/iptal, iletişim e-postası; unvan yerine "Vetinity", MERSİS satırı yok, barındırma ülkesi yazılmadı). Unvan ve vergi bilgisi gelince eklenir. Aydınlatma metni, açık rıza ve saklama ve imha politikasındaki köşeli parantezli alanlar bu turda doldurulmadı. Eski inceleme listesi arşivdir: [roadmap/HUKUKI-ONAY-LISTESI.md](../roadmap/HUKUKI-ONAY-LISTESI.md).

## Taraflar (varsayım, A6)

- **Klinik** = veri sorumlusu (müşterisi/hasta sahibi verisini kendi amaçları için işler).
- **Vetinity** = veri işleyen (SaaS; klinik adına barındırır ve işler). Kendi kullanıcı hesapları (klinik çalışanı, site ziyaretçisi) bakımından ise Vetinity veri sorumlusudur.
- **Vetinity'nin hukuki yapısı (kullanıcı kararı, 2026-11-09): şahıs işletmesi.** Unvan bilinene kadar metinlerde taraf "Vetinity" yazar; unvan gelince işletme sahibinin adı soyadı ve işletme adı (frontend'de `VETINITY_LEGAL_ENTITY_NAME` ve portal `PORTAL_VETINITY_LEGAL_ENTITY_NAME`), vergi dairesi ve vergi numarası (ticaret sicil kaydı varsa o da) eklenir; aynı metnin kopyaları frontend'de de var (`legal-documents.utils.ts`, portal `portal-legal-documents.ts`) ve birlikte güncellenir, metin değişince sürüm numarası artar (TRIAL-009).

## Belgeler

| Belge | Kim kime | Ürün yeri | Durum |
|---|---|---|---|
| [aydinlatma-metni.md](aydinlatma-metni.md) | Klinik → müşteri (hayvan sahibi) | Müşteri kartı, yazdırma; Ayarlar'da klinik başına şablon | Yürürlükte (1.0) |
| [acik-riza-metni.md](acik-riza-metni.md) | Klinik → müşteri | ADR-021 formu; varsayılan metin (backend `ClinicKvkkFormTemplateDefaults`) | Yürürlükte (1.0) |
| [gizlilik-politikasi.md](gizlilik-politikasi.md) | Vetinity → kullanıcılar | Herkese açık sayfa ve kayıt/giriş bağlantısı | Yürürlükte (1.3, 2026-11-23: yer tutucular dolduruldu) |
| [kullanim-sartlari.md](kullanim-sartlari.md) | Vetinity ↔ klinik | Herkese açık sayfa, sürümlü kabul (TRIAL-009) | Yürürlükte (1.1, 2026-11-23: yer tutucular dolduruldu) |
| [veri-isleme-sozlesmesi.md](veri-isleme-sozlesmesi.md) | Klinik ↔ Vetinity | Kayıtta kabul edilir, PDF olarak indirilebilir | Yürürlükte (1.2, 2026-11-23: yer tutucular dolduruldu) |
| [saklama-ve-imha-politikasi.md](saklama-ve-imha-politikasi.md) | Klinik iç belgesi / Vetinity | Klinik için şablon, Vetinity için iç politika | Yürürlükte (1.0) |
| [portal-kullanim-sartlari.md](portal-kullanim-sartlari.md) | Vetinity ↔ hasta sahibi (portal kullanıcısı) | Hasta sahibi portalı/mobil uygulama: hesap açılışında ve güncellemede sürümlü kabul (ADR-031 K4, ADR-029) | Yürürlükte (1.1, 2026-11-23: yer tutucular dolduruldu) |
| [portal-gizlilik-politikasi.md](portal-gizlilik-politikasi.md) | Vetinity → hasta sahibi (portal hesabı) | Hasta sahibi portalı/mobil uygulama: hesap açılışında sürümlü kabul, portal içi bağlantı (ADR-031 K4, ADR-029) | Yürürlükte (1.2, 2026-11-23: yer tutucular dolduruldu) |

## Sürümleme

Her belgenin başında `Sürüm` ve `Tarih` bulunur. Yayımlanan her metin sürümü saklanır; kabul kayıtları sürüm numarasını tutar (TRIAL-009).
