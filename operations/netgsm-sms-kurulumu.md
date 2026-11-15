# Netgsm SMS kurulumu (deneme kaydı telefon doğrulaması)

Deneme kaydı, cep telefonuna gelen tek kullanımlık SMS koduyla doğrulanır ([TRIAL-001](../backlog/feature-backlog.md), [INT-003](../backlog/feature-backlog.md)). Kod Netgsm'in OTP SMS ürünüyle gönderilir. Sağlayıcı ayarlanmadan kod yayınlanırsa **yeni deneme kaydı durur** (kod gönder adımı "Telefon doğrulaması şu an kullanılamıyor" der). Mevcut hesaplar etkilenmez.

Kaynaklar 2026-11-15'te okundu: [OTP fiyatları](https://www.netgsm.com.tr/fiyatlar/otp-sms), [abonelik belgeleri](https://bilgibankasi.netgsm.com.tr/abonelik-islemleri/abonelik-icin-gerekli-belgeler), [gönderici adı talebi](https://bilgibankasi.netgsm.com.tr/toplu-sms/gonderici-adi-talebi), [OTP SSS](https://bilgibankasi.netgsm.com.tr/otp-sms/sikca-sorulan-sorular-otp-sms), [API belgesi](https://api-docs.netgsm.com.tr/send-otp/).

## Yapılacaklar (sırayla)

1. **Netgsm aboneliği (şahıs işletmesi adına).** Gerekenler: abonelik sözleşmesi kimlik bilgileri ve tercih formu, vergi levhası. Vekil başvuruyorsa vekâletname ve yerleşim yeri belgesi. Şahıs işletmesi için imza sirküleri listede yok.
2. **SMS başlığı (gönderici adı) başvurusu.** Panelde: Online İşlemler > Abonelik İşlemleri > Online Başvurular > Gönderici Adı Başvurusu. Kimliğin ön ve arka yüzü yüklenir; form **KEP** ile Netgsm'in KEP adresine gönderilir (kendi KEP adresiniz gerekir). Başlık 3–11 karakter, işletme adıyla bağlantılı olmalı; alan adı (ör. "vetinity.com") kullanılamaz. Ad-soyad içeren başlıkta soyad eksiksiz yazılır. Öneri: `VETINITY` (işletme adıyla bağlantısı Netgsm'ce kabul edilmeli). **Onay süresi doğrulanamadı** (Netgsm "en kısa sürede" diyor).
3. **OTP paketi.** OTP bakiyesi diğer SMS paketlerinden ayrıdır, satın almadan itibaren 1 yıl geçerlidir. Yeni abone fiyatları (ÖİV ve KDV dahil): 1.000 SMS 316 TL, 5.000 SMS 1.203 TL, 10.000 SMS 1.999 TL. Standart tarife adet başı 0,48 TL. Başlangıç için 1.000'lik paket yeter (her kayıt en az 1, genelde 1–2 SMS).
4. **API kullanıcısı.** Panelde: Abonelik işlemleri > Alt kullanıcı hesapları; türü **API Kullanıcısı** olan alt kullanıcı açılır (OTP için zorunlu). Ana hesap parolası kullanılmaz.
5. **API IP izni.** Panelde: Abonelik İşlemleri > API işlemleri; sunucunun çıkış IP adresi eklenir. Eklenmezse istek reddedilir.
6. **Sunucuya ayarlar** (gizli değerler depoya ve sohbete yazılmaz; sunucuda ortam değişkeni):

   ```
   Sms__Provider=Netgsm
   Sms__Netgsm__Username=<API kullanıcısı>
   Sms__Netgsm__Password=<API kullanıcısı parolası>
   Sms__Netgsm__Sender=<onaylı başlık>
   ```

   Kurumsal OTP hesabıysa `Sms__Netgsm__Enterprise=true`. Önce deneme ortamıyla denemek için `Sms__Netgsm__ApiBaseUrl=https://ext-sandbox.netgsm.com.tr`.
7. **İlk deneme.** Kendi numaranızla kayıt sayfasında "Kod gönder"; SMS gelmezse API günlüğünde `Netgsm OTP gönderimi reddedildi. Status=... Code=...` satırına bakılır (`REJECTED_HEADER` = başlık onaysız, `INSUFFICIENT_CREDIT` = OTP bakiyesi yok, 403 = IP izni ya da alt kullanıcı yetkisi).

## Notlar

- OTP SMS'te İYS sorgusu, kara liste ve mükerrer filtresi uygulanmaz; hizmet yalnız doğrulama içindir (Netgsm SSS). OTP'nin mevzuatta "bilgilendirme iletisi" sayıldığı resmî metinden **doğrulanmadı**.
- Gerçek Netgsm hesabıyla uçtan uca gönderim **denenmedi**; bağdaştırıcı API belgesine göre yazıldı. Jeton yanıtındaki `expires_in` ve hata gövdesindeki `code` alan adı ilk denemede doğrulanmalı.
- Hesap açılana kadar yayın gerekiyorsa seçenek: doğrulamayı geçici kapatan bir ayar eklenebilir (şu an yok; kapalıyken deneme yine numarasız açılır, toplu hesap riski geri gelir).
