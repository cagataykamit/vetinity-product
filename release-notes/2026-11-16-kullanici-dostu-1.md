# 2026-11-16 — Sürüm notu (kullanıcı dostu 1. dalga, yükleme ekranı, sunucu güvenliği)

**Tarih:** 2026-11-16, 01:23 (TSİ)
**Yayınlanan:** backend `main` `5f9a7307`, panel `main` `5cb278f0` (`main-LXRG4QBO.js`), portal aynı commit (`main-ZS3H6KLO.js`). Klinik siteleri değişmedi.
**Migration:** Yok. Seed gerekmedi.
**Yedek:** Yayından önce elle yedek alındı (01:23, doğrulandı).
**Doğrulama:** API `/health/ready` 200, yayın sonrası günlükte hata yok, panel ve portal yeni `main` dosyalarıyla açılıyor, www 200.
**Kaynak:** [Kullanıcı dostu denetimi](../research/kullanici-dostu-denetim-2026-11-15.md), H1–H19 ve O4.

## Kullanıcı dostu düzeltmeler (1. dalga)

- **Varsayılanlar:**
  - Randevu, tedavi, reçete, yatış, mal kabul ve kasa hareketinde tarih bugün olarak geliyor.
  - Müşterinin tek hayvanı varsa o hayvan, tek seçenek varsa o seçenek kendiliğinden seçiliyor.
- **Ödeme al:** Toplam borç en üstte görünüyor ve "Tamamını al" düğmesi var. Bugün ekranındaki borç yazısı ödeme ekranını açıyor.
- **Diyaloglar:**
  - Enter ile kaydediliyor.
  - Hızlı kayıt diyalogları dışarı tıklayınca kaybolmuyor.
  - Sayfa formlarında ilk alana odaklanılıyor.
- **Boş listeler:** "Henüz kayıt yok" ile "Bu aramaya uyan kayıt yok" ayrıldı. Boş listede ilk kaydı açan düğme, aramada sonuç yoksa "Filtreleri temizle" düğmesi var.
- **Yetkisiz sayfa:** "Sayfa bulunamadı" yerine panel içinde "Bu sayfa için yetkiniz yok" ekranı açılıyor.
- **Portal:**
  - Ana sayfada "Randevu talep et" (klinik talep almıyorsa "Kliniği ara") düğmesi var. Gecikmiş aşı kartında da aynı eylemler var; talep formu hayvan ve "Aşı" nedeni seçili açılıyor.
  - Giriş kodunda odak kod alanına geçiyor; 6 hane girilince giriş kendiliğinden yapılıyor.
  - İptal edilmiş aşılar hasta sahibine gösterilmiyor (ADR-043 açık sorusu, kullanıcı kararı).
- **Hasta sahibine gösterilen aydınlatma metni:** Köşeli parantezli yer tutucular ve "hukuk danışmanınızca…" notu kalktı. Adres, telefon ve e-posta klinik kaydından yazılıyor, boş olan cümleden düşüyor. Eksik bilgi klinik sahibine bildiriliyor.
- **Müşteri telefonu:** Yeni müşteride zorunlu (içe aktarma hariç). Telefon "0532 111 22 33" biçimine çevriliyor. Eski müşterinin telefonu silinemiyor.
- **Hata metinleri:**
  - Backend'deki iş kuralı ve doğrulama metinleri Türkçe, hız sınırı metni Türkçe karakterli.
  - Panel, tanımadığı teknik hatada genel bir metin ve destek kodu gösteriyor.
- **Tutarlılık:** "Müşteri", "Hasta", "Vazgeç", "Ödeme al", cümle düzeni, "(isteğe bağlı)" ve "₺" her yerde aynı. Arayüzdeki teknik ifadeler kalktı. Kaldırma işlemleri onay istiyor. Kayıttan sonra "kaydedildi" bandı her ekranda çıkıyor.

## İçe aktarma

- **Yükleme adımı (taslak B, "her ekranda tek soru"):** Program seçimine göre yalnız ilgili adımlar ve dosya türü görünüyor. E-vet seçilince aynı adlı hayvanlar için ipucu çıkıyor.

## Sunucu (bu gece)

- **SSH:** Parola ile giriş kapatıldı. Root yalnız anahtarla girebiliyor; sağlayıcı kullanıcısı (`vrdyn`) için parola açık bırakıldı.
- **SQL Server:** 16.0.4325 (CU28) sürümüne güncellendi (00:16, öncesinde yedek alındı; yaklaşık bir dakikalık kesinti).
- **Cloudflare Turnstile:** Anahtarlar girildi ve insan doğrulaması etkin (2026-11-15 23:49).

## Bilinen sınırlar

- Ekranlar tarayıcıda denenmedi; doğrulama yalnız testlerle yapıldı.
- **Testler:**
  - Backend: 1314 domain, 4302 uygulama ve 2102 entegrasyon testi geçti, 3 test atlandı.
  - Panel: 3200 testin hepsi geçti.
  - Portal: 267 testin hepsi geçti.

## Ek yayın: 2026-11-16 02:02 (TSİ), E-vet aktarma ve görsel düzeltmeler

**Yayınlanan:**
- Backend `main` `9930dd02`.
- Panel `main` `7fa375e8` (`main-OKRAOFCU.js`).
- Klinik siteleri (`site`) aynı commit'ten.

Portal değişmedi. Migration yok. Yedek 02:02'de alındı. API ve site sağlıklı, günlükte hata yok.

- **E-vet aktarma:**
  - Kayıtsız günlerdeki boş muayene satırı, hastanın geçmişine tarih ve hekimle "Geliş" kaydı olarak aktarılıyor. Aynı gün başka kaydı olan satır yine atlanıyor. Gerçek dosyada 1.281 satır geliş olarak geliyor, 3.036 satır atlanıyor.
  - Mükerrer kontrolüne kilo, ateş ve hekim de katıldı.
  - Mükerrer nedeni ikiye ayrıldı: "Dosyada aynı satır iki kez var" ve "Daha önceki aktarmada geldi".
  - Aynı adlı hayvanlar tür, tarih, kilo, mikroçip ve Aşı Bilgi raporuyla kendiliğinden ayrılıyor.
  - Ayrılamayan satırlarda kullanıcıya soruluyor; soruda aşı ve muayene ayrıntısı gösteriliyor. "İkisi aynı hayvan" seçeneği türü farklı adaylarda çıkmıyor.
- **Görsel düzeltmeler:**
  - Koyu temada kart çerçevesi.
  - Görünür "Hayvan" yazıları "Hasta" oldu.
  - Özet sayfasındaki "Detay" bağlantıları tek biçimde.
  - Stoktaki mor "Dışa aktar" düğmeleri düzeltildi.
  - Klinik sitesi sihirbazında Türkçe adlar ve tasarım adları (Modern, Zarif, Samimi, Doğal).
  - Sihirbazın hazır paletleri tek kaynakta toplandı ve kontrast eşiğini (4,5:1) geçiyor.
- **Testler:**
  - Backend: 1315 domain, 4321 uygulama ve 2103 entegrasyon testi geçti, 3 test atlandı.
  - Panel: 3206 testin hepsi geçti.
  - Klinik sitesi: 42 testin hepsi geçti.
