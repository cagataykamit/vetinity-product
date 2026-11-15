# 2026-11-15 — Sürüm notu (deneme kaydı güvenliği, E-vet aktarma)

**Tarih:** 2026-11-15, 06:29–06:33 (TSİ)
**Yayınlanan:** backend `main` `e0994451`, panel `main` `5765fdc6` (`main-JSVG4Z5T.js`), portal aynı commit (`main-42Q2BAXM.js`). Klinik siteleri değişmedi.
**Migration (komut DB):** `20261115002059_AddTrialSignupEmailAndIdentity`. Yalnız eklemeli: iki yeni tablo (`SignupEmailVerifications`, `TrialSignupIdentities`) ve indeksleri. Sorgu DB'de değişiklik yok, `seed` gerekmedi.
**Yedek:** Migration'dan önce elle yedek alındı (06:29; doğrulandı, Drive kopyası doğrulandı).
**Doğrulama:** API `/health/ready` 200, yayın sonrası günlükte hata yok, panel ve portal yeni `main` dosyalarıyla açılıyor, www 200.

Önceki yayın: 2026-11-15 03:31 (kayıt modeli, [sürüm notu](2026-11-15-kayit-modeli.md)).

## Öne çıkanlar

- Deneme hesabı kötüye kullanımına karşı önlemler (TRIAL-001).
- E-vet aktarmasında pilot denemesinde bulunan sorunların düzeltmesi.

## Yeni özellikler

- **Deneme kaydında e-posta kodu:** Kayıt, e-postaya gelen kodla tamamlanıyor.
- **Tek deneme kuralı:** Bir e-posta adresi ve bir vergi numarasıyla yalnız bir deneme açılabiliyor. Vergi numarası kayıtta zorunlu (`TrialSignup:RequireTaxIdentityNumber`).
- **İnsan doğrulaması (Cloudflare Turnstile):** Kod hazır. Deneme kaydında, portal kodla girişte, parola sıfırlamada ve online randevu kodunda çalışacak.
- **Aktarma, belirsiz hasta seçimi:** Aynı müşteride aynı adlı birden çok hasta varsa kullanıcı satırın hangi hastaya ait olduğunu seçiyor ya da satırı atlıyor.
- **Aktarma, atlananlar:** Doğrulama ekranında "Atlanacak" filtresi var, nedenlere tıklanabiliyor. Atlanan satırlar dosya olarak indirilebiliyor.

## İyileştirmeler

- **Yükleme ilerlemesi:** Aktarma yüklemesinde yüzde ve "işleniyor" durumu görünüyor. Yarım kalan taslaklar listeleniyor. Aynı dosya ikinci kez yüklenirse uyarı çıkıyor.
- **Hız:** Aktarma satırları toplu yazılıyor.
- **Aynı adlı kopyalar:** Aynı adlı aktif kopya hastalar kendiliğinden birleşiyor.
- **Kısa adlı müşteri:** Bağlı kaydı olan kısa adlı müşteri uyarıyla aktarılıyor. Bağlı kaydı olmayan atlanıyor.

## Düzeltmeler

- Yükleme sürerken sayfa yenilenince boş sayfa geliyordu ve yükleme iptal oluyordu. Artık yükleme tamamlanıyor.

## Gizlilik

- Gizlilik metni ve portal gizlilik metni 1.1 sürümüne geçti. Mevcut kullanıcılar ve portal hesapları bir sonraki girişte metni yeniden kabul eder.

## Bilinen sınırlar

- **Turnstile kapalı:** Turnstile anahtarları henüz girilmedi. Bu yüzden insan doğrulaması atlanıyor; API başlangıçta bunu tek uyarıyla bildiriyor. Hız sınırları ve e-posta kodu çalışıyor. Anahtarlar `operations/cloudflare-turnstile-kurulumu.md`'ye göre girilince devreye girer.
- **Kalan aktarma hataları:** Gerçek E-vet dosyasında kalan 4 aşı hatası ve 15 klinik geçmiş hatası belirsiz hasta gruplarından geliyor. Seçim ekranında her grup çözülünce bu hatalar kalmıyor.
- **Tarayıcıda denenmedi:** Seçim ekranı, "Atlanacak" filtresi ve indirme tarayıcıda denenmedi.
- **Testler:**
  - Backend: 1314 domain ve 4291 uygulama testinin hepsi geçti; entegrasyonda 2102 geçti, 3 atlandı.
  - Panel: 3138 testin hepsi geçti.
  - Portal: 258 testin hepsi geçti.

## Ek yayın: 2026-11-15 20:53 (TSİ), aktarma doğrulama ekranı

**Yayınlanan:** panel `main` `8e8b8d92` (`main-Z4MWYXRK.js`). Yalnız panel; backend, migration ve portal değişmedi.

- **Doğrulama sonucu ekranı yeniden düzenlendi (taslak A):**
  - En üstte tek cümlelik sonuç ve oran çubuğu var. Hemen altında sizden seçim bekleyen değerler duruyor; yanlarında "Atla" ve "Geri al" düğmeleri var.
  - Ayrıntılar katlı duruyor. Üç sonuç her yerde aynı adla geçiyor: Aktarılacak, Bilerek atlanacak, Aktarılamayacak.
  - "Aktarılacak" bölümünde bir tabloya tıklayınca o tablonun satırları açılıyor.
  - Hatırlatmalar tek bir notta toplandı.
  - Alttaki düğme çubuğu ekrana yapışık. "Onay adımına geç" kapalıysa nedeni yanında yazıyor.
- **Testler:** Panelin 3152 testinin hepsi geçti. Ekran sahte veriyle masaüstü ve telefon genişliğinde denendi; gerçek arka uçla denenmedi.
