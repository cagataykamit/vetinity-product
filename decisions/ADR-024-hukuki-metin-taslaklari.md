# ADR-024 — Hukuki metin taslaklarını ürün ekibi yazar, uzman incelemesi sonra yapılır

## Durum

**Kabul edildi (2026-10-15, kullanıcı: "sen hukuka uygun olarak düzenle ve yerine koy, hukukçuya sonra sorarım").** [ADR-021](ADR-021-kvkk-consent-form.md) madde 2'yi değiştirir: orada "ürün kendi hukuki metnini yazmaz" denmişti; artık ürün taslakları yazar ve ürüne koyar, ama **hukuki onay olmadan canlı klinik verisine açılmaz**.

## Karar

1. Hukuki metinler ürün deposunda `legal/` altında taslak olarak tutulur: aydınlatma metni, açık rıza metni, gizlilik politikası, kullanım şartları, veri işleme sözleşmesi, saklama ve imha politikası.
2. KVKK ilkeleri: aydınlatma ile açık rıza ayrı belgelerdir; açık rıza yalnız başka hukuki sebebe dayanmayan işlemler için (hatırlatma/iletişim) ve hizmetin şartı olmadan alınır.
3. Metinler ürünün ilgili yerine konur: klinik şablonları (aydınlatma, açık rıza) Ayarlar'da klinik başına düzenlenir ve yazdırılır; Vetinity metinleri (gizlilik, kullanım şartları, veri işleme) herkese açık sayfa ve kayıtta sürümlü kabul olarak. Rakip metni kopyalanmaz.
4. Her metin sürüm numarası taşır; kabul kayıtları sürümü tutar (TRIAL-009).
5. `roadmap/HUKUKI-ONAY-LISTESI.md` açık kalır; durumlar "Onaylandı" olana dek "Onay bekliyor". Pilot canlı verisinden önce hukuki inceleme zorunludur.

## Sonuçlar

- Backend: açık rıza varsayılan metni güncellenir; klinik aydınlatma metni şablonu (ADR-021 ile aynı desen) eklenir.
- Frontend: Ayarlar'da aydınlatma metni, müşteri kartından yazdırma; herkese açık gizlilik/kullanım şartları sayfaları ve kayıtta kabul.
- Risk: metinler uzman onayından geçmedi; köşeli parantezli alanlar doldurulmadan yayımlanmaz.
