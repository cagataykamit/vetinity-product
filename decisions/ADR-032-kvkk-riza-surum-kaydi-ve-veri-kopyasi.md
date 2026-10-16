# ADR-032 — KVKK rıza kaydına metin sürümü ve müşteri veri kopyası

## Durum

**Kabul edildi (2026-10-16, kullanıcı: önerilen ilk iki iş).** [ADR-021](ADR-021-kvkk-consent-form.md) rıza kaydını genişletir; [operations/kvkk-talep-sureci.md](../operations/kvkk-talep-sureci.md) "bilgi/kopya" adımını araçlandırır. Hukuki görüş beklenmeden çalışma varsayımıyla ilerler (HUKUKI-ONAY-LISTESI "Geliştirme varsayımı"). Anonimleştirme komutu bu ADR'de YOK (ayrı karar).

## Karar

1. **Rıza kaydına metin sürümü (A9):** müşteri KVKK durumu (Kabul/Ret) işaretlenirken, o anda geçerli klinik form metninin **sürümü** de kaydedilir: açık rıza şablon metninin değiştiği her kayıtta artan sürüm numarası (klinik başına, kaydedilen metin değişince +1; varsayılan metin = sürüm 0) ve kaydın tutulduğu andaki metnin özet değeri (SHA-256, metnin kendisi tekrar saklanmaz) — hangi metne rıza verildiği ispatlanabilir. Mevcut kayıtlar "sürüm bilinmiyor" kalır (geriye dönük uydurulmaz). Müşteri kartında rıza durumunun yanında "Metin sürümü" görünür.
2. **Müşteri veri kopyası (bilgi talebi):** müşteri kartından **"Veri kopyası"** eylemi (okuma yetkisi olan kullanıcı); tek, yazdırılabilir belge: müşteri bilgileri, KVKK rıza durumu ve sürümü, hastaları, randevuları, muayene özetleri, aşıları, ücret ve ödemeleri, iletişim tercihleri. **Salt okunur**; veri değiştirmez; erişim denetim kaydına yazılır (kim, hangi müşteri, ne zaman). Teknik not alanları ve iç denetim alanları dahil değildir; başka müşterinin verisi içermez. Çıktı JSON ve yazdırma görünümü (PDF yazdırma) olur.
3. Her ikisi mevcut izin sistemine uyar; yeni "silme" yeteneği yok.

## Sonuçlar

- Backend: rıza kaydına sürüm alanları (migration, koordinatör uygular), `GET /clients/{id}/data-export` ve audit; sözleşme belgeleri.
- Frontend: rıza sürümü gösterimi; "Veri kopyası" sayfası ve yazdırma.
