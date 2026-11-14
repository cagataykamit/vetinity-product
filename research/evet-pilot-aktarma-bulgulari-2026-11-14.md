# E-vet pilot aktarma bulguları (2026-11-14)

Kaynak: pilot klinik, canlı ortamda E-vet yedeğinin **doğrulama** adımı (aktarma yapılmadı, parti iptal edildi). Bulgular kullanıcının doğrulama ekranı ve E-vet ekranı incelemesinden; kişisel veri bu belgeye yazılmaz. İlgili: TIER-024, TIER-021, ADR-048, backend `docs/IMPORT_API_CONTRACT.md` §13.

## Doğrulama sonucu (özet)

| Tablo | Satır | Oluşturulacak | Aktarılmayacak |
|---|---|---|---|
| Müşteriler | 4.377 | 4.356 | 21 |
| Hastalar | 6.536 | 6.523 | 13 |
| Aşılar | 16.817 | 16.616 | 201 |
| Klinik geçmiş | 17.372 | 12.828 | 4.544 |
| Randevular | 57 | 57 | 0 |
| Ürünler | 4.451 | 4.442 | 9 |

Aktarmayı engelleyen eşleme: tür "ARABA" (3 satır), aşı "KÖPEK KARMA 1" (1 satır). 34 ırk/renk adı eşleşmedi (isteğe bağlı).

Asıl sorun: "Aktarılmayacak" sayısı bilerek atlananlarla (boş muayene, tekrar) hataları birlikte sayıyor; en büyük kalem kapalı "Bilgi notları" bölümünde. Kullanıcıda "veri kayboluyor" izlenimi doğuyor.

## Bulgular ve kararlar

Sıra, veri kaybının büyüklüğüne göre; her madde bir düzeltme dilimidir.

### B1 — Sahibi değişen hayvanlar (mikroçip çakışması)
- **Gözlem:** E-vet sahibi değişince eski sahipte hayvanı pasif "[Sahibi değişti]" bırakır, yeni sahipte yeni kayıt açar (aynı mikroçip). Dışa aktarmada eski kayıt `Durum = Vefat` görünüyor. Zincir ve geri dönüş var: bir hayvan = 1 aktif + birden çok eski kayıt (A → B → A).
- **Bugün:** eski kayıt "Aynı mikroçip başka bir hastada var" ile reddediliyor; ona bağlı aşı ve klinik geçmiş de düşüyor. Mikroçipsizlerde çakışma yakalanmıyor: hayvan iki kez geliyor, eski sahipte yanlışlıkla vefat.
- **Karar:** aynı mikroçipli kayıtlar tek hayvan; hedef aktif kayıt (yoksa en son tarihli). Tüm eski kayıtların aşı ve klinik geçmişi hedefe birleşir; hiçbiri vefat gelmez; önceki sahiplikler hayvan notunda kalır. Mikroçipsiz tek pasif kayıt gerçek vefat sayılır (yanlış birleştirme yok).

### B2 — Aynı sahipte aynı adlı iki hasta (belirsiz bağlantı)
- **Gözlem:** Yedeğin aşı sayfası hastayı sahip adı + hayvan adıyla verir. Aynı adlı iki kayıt olunca (çoğu yanlış açılıp vefat yapılmış kopya) aşılar "Satırın hastası bulunamadı (Belirsiz: …)" ile düşüyor. Aşılardaki 201'in çoğu.
- **Karar:** adaylardan yalnız biri aktifse ona bağla; değilse uygulama tarihini yaşam aralığıyla ayır; aynı tür + doğum tarihli kopyayı aktif kayda birleştir (B1 mekanizması); hâlâ çözülmeyenlerde doğrulama ekranında grup bazında kullanıcıya sor (seçim gruptaki tüm satırlara uygulanır, "atla" seçeneğiyle). Aşı Bilgisi raporunda hasta numarası varsa onu kullan. İki aday birden asla atılmaz.

### B3 — Zincirleme eleme ("Hasta satırı hatalı olduğu için aktarılamaz")
- **Gözlem:** Hasta reddedilince dolu muayeneleri (şikâyet, tanı, tedavi, not) de düşüyor; ekran asıl nedeni söylemiyor.
- **Karar:** zincirleme elenen satırda hastanın asıl hatası yazsın ("Hasta aktarılmadı: … (Hastalar satır N)"). Alan düzeyindeki sorunlarda (ad çok kısa, doğum tarihi gelecekte, tanınmayan ırk/renk) hasta reddedilmesin; alan boş/olduğu gibi bırakılıp "göz atmanız önerilenler" uyarısıyla aktarılsın, geçmiş korunsun.

### B4 — Sahipsiz hasta kayıtları
- **Gözlem:** `SahipAdSoyad = "."`, müşteri no boş, `Durum = Vefat`; büyük olasılıkla E-vet'te müşteri kartı silinmiş.
- **Karar:** geçmişi olmayan sahipsiz hasta "atlanacak" (bilgi notu). Geçmişi olan sahipsiz hasta, partide tek bir yer tutucu müşteri altında ("Sahibi kayıtlı olmayan hastalar (E-vet aktarımı)", hatırlatma ve ticari ileti kapalı, geri alma partisine dahil). Sayı ihmal edilebilirse yer tutucu yapılmaz.

### B5 — Erken tamamlanmış, gelecek tarihli görev
- **Gözlem:** Kontrol muayenesi planlanan tarihten önce yapılmış (kilo yazılmış), E-vet görevi planlanan tarihle "Tamamlandı" duruyor; bizde "Tarih gelecekte" ile düşüyor.
- **Karar:** klinik geçmişe aktarma günü tarihiyle ve "E-vet'te planlanan tarih: gg.aa.yyyy; erken tamamlanmış" notuyla gelsin. "Randevu" durumundaki gelecek görev randevu olarak gelmeye devam eder.

### B6 — Doğrulama ekranının anlaşılırlığı
- Her tablo kartında "Aktarılmayacak" ikiye ayrılsın: **Atlanacak** (bilerek: boş muayene, tekrar, kullanıcının atladığı değer) ve **Hatalı**; altında nedene göre kısa satırlar. Backend neden sayılarını tablo başına verir.
- Mikroçip çakışmasında çakışan yer görünsün ("N. satırdaki hasta" / "sistemde kayıtlı hasta").
- Kullanıcının "Bu değeri atla" dediği değere bağlı satırlar hatalı değil, "Atlandı: tür atlandı (…)" olarak görünsün.

### B7 — Küçükler
- E-vet menü yolları: "Rapor > Genel > Hasta Listesi", "Rapor > Resmi > Aşı Bilgisi" (düzeltildi: backend `32b55ea7`, panel `f1ae8c57`, dal `fix/evet-menu-yollari`; canlıda değil).
- "KÖPEK KARMA 1" gibi numaralı karma yazımları otomatik eşlensin.
- "ARABA" türü: klinik E-vet'e araç muayene hatırlatması girmiş; kod değişikliği yok, eşlemede "Bu değeri atla".

## Durum

Düzeltmeler E-vet aktarma oturumunda B1 → B6 sırasıyla, feature dalında; push, ana dala alma ve canlıya çıkış kullanıcı onayıyla. Pilot aktarma bu düzeltmeler canlıya çıktıktan sonra yeniden yapılır.
