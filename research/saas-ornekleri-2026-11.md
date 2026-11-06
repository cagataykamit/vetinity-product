# Farklı SaaS ürünlerinden örnek alınacak fikirler (2026-11-06)

Amaç: veteriner dışı ürünlerden fikir toplamak. Görünüm kopyalanmaz. Bir fikir buraya yazıldı diye karar değildir; backlog'a yalnız kullanıcının seçtikleri girer.

**Yöntem ve sınır:** Ajanlar yalnız herkese açık sayfaları WebFetch özeti üzerinden okudu; ürünlerin içi, görsel düzen ve gerçek davranış görülmedi. CodeBody tarayıcıda incelendi (ana sayfa, Uzman bul, örnek klinik sitesi). Büyüklükler tahmindir. Ajanlar bu sayfaları koordinatör ayrıca açarak doğrulamadı.

**Açılamayanlar:** Doctolib (403, yalnız dolaylı özet), Canva (403), Doktortakvimi il liste ve satış sayfaları, Fresha liste sayfası, Squarespace yardım makalelerinin çoğu, Notion kredi yardım sayfaları, Jane ve Cliniko'nun hatırlatma ayrıntı sayfaları. WhatsApp paylaşım önizlemesi için kanıt bulunamadı.

## Veteriner bul ve vitrin

| # | Fikir | Görüldü | Karar | Büyüklük | Not |
|---|---|---|---|---|---|
| 1 | Veteriner bul: il, ilçe, hizmet filtresi; il/ilçe/hizmet sayfaları | CodeBody, Doktortakvimi, Fresha | Alınır | Büyük | TIER-002 ve `www` geçişine bağlı; az klinikli ilçede ince içerik riski, boş sayfa dizine alınmaz. Filtre ayrıntısı Doctolib için dolaylı |
| 2 | Randevu talebinde kaynak: Veteriner bul, kendi sayfa, telefon; kliniğe "size ne getirdi" | Fresha | Alınır | Küçük | Vitrinin kanıtı; müşteri eşleme varsa KVKK aydınlatması |
| 3 | "Nasıl sıralıyoruz": ölçüt açık, ödemeyle değişmez | Doktortakvimi (yalnız feragat notu), CodeBody (günlük değişen sıra) | Uyarlanır | Küçük | Metin hukuk gözüyle yazılmalı |
| 4 | Kartta ve klinik sayfasında en yakın müsait saat, talep olarak | CodeBody; Doctolib dolaylı | Alınır | Orta | Herkese açık boş saat ucu; "kesin randevu" değil "talep" dili |
| 5 | Sonuç yoksa yakın ilçe önerisi | Doktortakvimi zayıf örnek | Uyarlanır | Küçük | "Haber ver" formu kişisel veri toplar, ilk sürüme koyma |

## Klinik işleyişi

| # | Fikir | Görüldü | Karar | Büyüklük | Not |
|---|---|---|---|---|---|
| 6 | Bekleme listesi: iptal olan saati otomatik teklif | Jane (üst paket) | Uyarlanır | Orta | Üst paket adayı; backlog'da yok. Mesaj işlem iletisi olarak ayrılmalı |
| 7 | Hatırlatmada onayla / iptal et bağlantısı | Jane (iki yönlü davranış doğrulanmadı) | Uyarlanır | Küçük-orta | Bekleme listesine akar |
| 8 | Hatırlatmada takvime ekle | CodeBody | Alınır | Küçük | APPT-032 ile ilişkili |
| 9 | Dönüş hatırlatması kuralı | Jane (üst paket) | Alınır | Orta | TIER-003 içine örnek kural |
| 10 | Rakip programdan veri aktarımı ve kurulum görüşmesi | Jane, Cliniko | Uyarlanır | Orta | BulutVet ve E-Vet geçişi; kişi süresi ve KVKK |
| 11 | Günlük kasa mutabakatı görünümü | Jane (eski rehber) | Uyarlanır | Küçük-orta | TIER-008'in ilk dilimi |
| 12 | Rol bazlı kısa "ilk hafta" rehberleri | Jane | Uyarlanır | Küçük | AI arama sonra |

## Klinik web sayfası ve sihirbaz (TIER-002)

| # | Fikir | Görüldü | Karar | Büyüklük | Not |
|---|---|---|---|---|---|
| 13 | Yayın öncesi kısa zorunlu liste, gerisi sonra | Shopify | Uyarlanır | Küçük | Ad, telefon, adres, en az bir saat satırı önerisi |
| 14 | Taslak ve yayın ayrı; önceki yayına dön; "değişiklik var, yayında değil" | Shopify (geri alma çıkarım) | Uyarlanır | Orta | Sihirbaz verisi kararını etkiler; ADR'ye girer |
| 15 | Boş bölüm sayfada görünmez, bölüm anahtarı | Shopify | Alınır | Küçük | Kural tek yerde |
| 16 | Adres değişince eski bağlantı ve QR çalışır | Shopify'ın eksiği | Uyarlanır | Orta | Otomatik yönlendirme; eski adın başkasına verilmesi kararı |
| 17 | Sayfayı geçici kapat | Shopify (aç/kapa ekseni) | Uyarlanır | Küçük | Kapalıyken açıklayıcı sayfa |
| 18 | Google görünümü otomatik, ayar "Gelişmiş"te | Shopify | Uyarlanır | Küçük-orta | "Böyle görünebilir" denir |
| 19 | Önizleme önce telefon; bağlantı ve QR yayından sonra | Shopify, Squarespace | Uyarlanır | Küçük | Yayın ödemeye bağlanmaz |
| 20 | "Örnek siteyi görün" canlı örnek | CodeBody | Alınır | Küçük | Örnek veri, gerçek klinik değil |

## AI eklentisi (ADR-044)

| # | Fikir | Görüldü | Karar | Büyüklük | Not |
|---|---|---|---|---|---|
| 21 | Kullanım ekranı: kalan kredi, fon, özellik bazlı tüketim | Linear | Alınır | Orta | Hasta adı görünmez |
| 22 | Harcama sırası tek cümleyle yazılır | Linear | Alınır | Küçük | |
| 23 | Teknik hatada kredi düşmez, liste açık | Intercom | Uyarlanır | Orta | "Beğenmedim" kapsam dışı |
| 24 | "Kota bitince yalnız AI durur" her yerde aynı cümle; Fon ekle bağlantısı | Intercom'un eksiği | Alınır | Küçük | Durum görünümü tasarlanır |
| 25 | Fon ömrü ve iade kuralı düz cümleyle | Linear (12 ay, iade yok) | Karar gerekir | Küçük | Hukuk doğrulanmadı |
| 26 | Aylık eklenti ve ek fon yan yana, "otomatik para çekilmez" | Stripe | Uyarlanır | Küçük | |

## Paketler sayfası

| # | Fikir | Görüldü | Karar | Büyüklük | Not |
|---|---|---|---|---|---|
| 27 | Kartta "önceki paketin tümü +" | Linear | Alınır | Küçük | Veriden üretilir |
| 28 | Tabloda "Sadece farkları göster" | CodeBody | Alınır | Çok küçük | H tablosunu kısaltır |
| 29 | Kartta tek satır kimin için; AI satırında "Eklenti gerekir" | Notion | Uyarlanır | Küçük | Tablo zaten alan bantlı; AI çalışmadan yazılmaz |

## Ayrı ticari karar gerektirenler

- **Yeni müşteri başına ücret** (Fresha): mevcut müşteri ve kendi bağlantı ücretsiz. Büyük iş; tarafsız sıralamayla çelişebilir. Vitrin ücretsiz başlasın, sonra değerlendirilsin önerilir.
- **Resepsiyon ve yönetici ücretsiz kullanıcı** (Jane, Cliniko): 3/5/15 kullanıcı sınırını değiştirir.
- **Ziyaret sonrası memnuniyet isteği** (Jane): önce özel puan ya da Google'a yönlendirme; klinik sayfasında yorum yok kararıyla birlikte düşünülür.

## Alınmayanlar

- Kliniğin onayı olmadan profil üretip sahiplendirme (Doktortakvimi): katılım kliniğin seçimi.
- İlk sürümde herkese açık yorum ve puan: moderasyon, hukuk ve tarafsızlık yükü.
- "Özellik kısıtı yok" tek paket (Cliniko): üst paket kararına ters.
- AI ile site metni üretme (Squarespace): kayıttan ön doldurma yeterli.
- Sonuç başına AI ücreti (Intercom): taslak üreten üründe ölçü yok.
- Fiyat önerisi anketi (Stripe): kullanım ölçülmeden yanıltır, sonraya.
- Düşük sayaçlar, abartılı sosyal kanıt ve "KVKK uyumlu" sözü (ADR-034).

## Kullanıcı kararı ve backlog eşlemesi (2026-11-06)

Kullanıcı 29 fikrin hepsini aldı. Yapım sırası ve "Ayrı ticari karar gerektirenler" açık. "Alınmayanlar" değişmedi.

| Fikir | Backlog |
|---|---|
| 1, 3, 5 | TIER-015 |
| 2 | TIER-016 |
| 4 | TIER-017 |
| 6 | TIER-018 |
| 7 | TIER-019 |
| 8 | TIER-020 (APPT-032'nin ilk dilimi) |
| 9 | TIER-003 |
| 10 | TIER-021 |
| 11 | TIER-008 |
| 12 | TIER-022 |
| 13-20 | TIER-002 |
| 21-26 | TIER-013 (25 için karar açık) |
| 27-29 | TIER-023 |
