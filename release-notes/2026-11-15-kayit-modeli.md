# 2026-11-15 — Sürüm notu

**Tarih:** 2026-11-15, 03:31–03:35 (TSİ)
**Yayınlanan:** backend `main` `dc36b64d`, panel `main` `da734556` (`main-2FCBIK34.js`). Portal ve klinik siteleri değişmedi.
**Migration (komut DB):** `AddHospitalizationCancellation`, `AddVaccinationCancellationAndRowVersion`, `AddPrescriptionRowVersion`, `AddTreatmentCancellationAndRowVersion`, `AddTreatmentAndVaccinationLateEntry`, `AddLabResultLateEntryMark`. Hepsi eklemeli (yeni sütun, kural, indeks). Sorgu DB'de değişiklik yok, `seed` gerekmedi.
**Yedek:** Migration'dan önce elle yedek alındı (03:31; doğrulandı, Drive kopyası doğrulandı).
**Doğrulama:** API `/health/ready` 200, yayın sonrası günlükte hata yok, panel yeni `main` dosyasıyla açılıyor, www 200.

Önceki yayınlar: 2026-11-14 02:40 (E-vet aktarma düzeltmeleri B1–B7, e-Fatura ticari senaryo; backend `d56a01c5`, panel `9420ca94`) ve 2026-11-14 03:11 (ilk hafta karşılama afişi, portal mobil kodu; panel `main-IZZU74HA.js`, portal `main-ALYH5NUA.js`).

## Öne çıkanlar

- Klinik kayıtlarında düzeltme yolları ve veri güvenliği ([ADR-043](../decisions/ADR-043-birlesik-klinik-kayit-modeli.md), RECORD-006).

## Yeni özellikler

- **Gerekçeli iptal:**
  - **Yatış:** Yanlış açılan yatış iptal edilebiliyor, taburcu sonrası da.
  - **Aşı:** Ürünsüz aşı gerekçeyle iptal ediliyor; iptal geri alınamaz.
  - **Tedavi:** Gerekçeyle iptal ediliyor. Bağlı etkin reçete ya da uygulama varken iptal edilemiyor.
- **Kesinleşmiş muayeneye sonradan ekleme:** Tedavi ve aşı, reçetedeki gibi gerekçe yazılarak eklenebiliyor ve "sonradan eklendi" olarak işaretleniyor.
- **"Sonradan eklendi" rozeti:** Reçete ve lab kayıtlarında zaman çizelgesinde görünüyor.

## İyileştirmeler

- **Aynı anda düzenleme koruması:** Aşı, reçete ve tedavide iki kişi aynı kaydı düzenlerse ikinci kayıt öncekini sessizce ezmiyor; kullanıcıya kaydın değiştiği söyleniyor.
- **Hasta ve klinik değişmez:** Kayıt düzenlenirken hasta ve klinik değiştirilemiyor. Yanlış hastaya açılmış kayıt iptal edilip yeniden girilir.

## Düzeltmeler

- Muayene, lab, yatış ve görüntüleme düzenlemeleri değişiklik geçmişine yazılmıyordu; artık yazılıyor.
- Görüntüleme kayıtları değişiklik geçmişine giriyor.
- Muayene işlem listesi reçete iptalini ve "sonradan eklendi" bilgisini gösteriyor.

## Bilinen sınırlar

- Hasta sahibi portalı iptal edilen aşıyı geçmişte "İptal" olarak göstermeye devam ediyor; ayrı karar bekliyor.
- Tarayıcıda uçtan uca deneme yayından önce yapılmadı; testler: backend 1303 + 4256 birim, 2080 entegrasyon; panel 3390.
