# 2026-11-28 — Yapay zekâ ayarları, Kolayvet'ten geçiş, kayıt sonrası giriş, lab Değerlendir

**Canlıda:** API ve DbMigrator `6358a6d6` (main-be), panel ve tanıtım `2db3001d` (main-fe, `main-BAGOSZ4W.js`). Portal ve klinik sitesi değişmedi.

**Migration:** `20261128104803_AddClinicAiAcknowledgement` — `ClinicAiSettings` tablosuna üç boş sütun (bilgilendirme kabulü sürümü, zamanı, kişisi). Veri silmez, değiştirmez. Uygulamadan önce elle yedek alındı (16:22, `/var/backups/vetinity/gunluk/2026-11-28/`).

## Ne değişti

- **Yapay zekâ ayarları (Ayarlar > Yapay zekâ):** Klinik yöneticisi bilgilendirmeyi kabul ederek yapay zekâyı açar ya da kapatır; bu ayın kullanımı ve eklenen krediler görünür; kota bildirimleri bu sayfaya götürür. Açık olan kliniklerde yapay zekâ açık kalır (kabul yalnız açarken istenir).
- **Kolayvet'ten geçiş:** İçe aktarma sihirbazında Kolayvet kaynağı; müşteri, hasta, aşı takvimi ve ayrıntılı hasta listesi Excel dosyalarından aktarım; parantezli ırk ve aşı adları ("Çin Aslanı (Chow Chow)", "İç Dış Multi") parçalanarak eşlenir. Program seçim ekranı sadeleşti (E-vet, Kolayvet, Excel; altta iletişim satırı). Tanıtım sitesinin geçiş sayfasında Kolayvet.
- **Kayıt sonrası otomatik giriş:** Deneme kaydı tamamlanınca az önce yazılan bilgilerle oturum açılır, kurulan klinik seçilir, panele geçilir. Olmazsa "Giriş yap" kartı kalır.
- **Lab Değerlendir:** Değerlendirme bekleyen sonuçta hem detayda ("Yorum yok" yanında) hem listede satır eylemi; düzenleme formu yorum alanında açılır.
- **Daha önce bugün ayrı yayınlanan panel düzeltmeleri main'e alındı:** Bugün ekranı grup kartları, muayene İşlemler satırında adın harf harf kırılması.
- **Demo klinik (backend):** `seed-demo-clinic` komutu, kiracı bazlı Nilvera test ortamı, test ortamında numaralanan e-Faturanın kesilmiş sayılması — canlıya daha önce bu daldan çıkmıştı, şimdi main'de.

## Testler

- Backend: Domain 1421, Application 4779, Integration 2283 (4 atlandı); hepsi geçti.
- Panel: 500 dosya / 4025 test; `vetinity-web` derlemesi başarılı.

## Doğrulama

- API açıldı, açılıştan sonraki 5 dakikada hata kaydı yok; `clinics/{id}/ai-settings` oturumsuz 401 (uç var).
- Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı; `/panel/today`, `/panel/settings/imports/new`, www, `/gecis` 200.
- Geri alma: `api-eski`, `dbmigrator-eski`, `web-eski`; şema için 16:22 yedeği.

## Açık

- Kayıt sonrası otomatik giriş ve yapay zekâ ayarları sayfası canlıda tarayıcıda denenmedi; kayıt sonrası giriş kullanıcıya yayından önce gösterilmedi (kullanıcı doğrudan yayın istedi).
- Kolayvet geçişi gerçek dosyayla canlıda denenmedi (yerelde denendi).
- Push yapılmadı.
