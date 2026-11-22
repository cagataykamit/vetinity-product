# 2026-11-22 — Posta günlüğü ve iki panel düzeltmesi

**Canlıda:** API `ab708f5a` (07:40), panel `614647a0` (`main-3QMBNICD.js`, 07:41). Migration ve seed yok.

## Ne değişti

- **Posta günlüğü (backend):** Outbox'ta başarıyla gönderilen her mesaj için `Outbox message sent. Type=… Id=… Retry=…` satırı Information düzeyinde yazılır. Alıcı adresi yazılmaz. Önceden başarılı gönderim günlükte hiç görünmüyordu.
- **Gelişe bağlı olmayan borç (panel):** Hesap kapatma panelinde gelişe bağlı olmayan ücret artık "Gelişe bağlı olmayan borç" diye yazılır; gelişten kalan borç "Önceki gelişten kalan" olarak kalır. Fişteki toplam satırının adı "Diğer açık borç" oldu.
- **Kayıtlı filtre penceresi (panel):** Kaydet penceresi ve silme onayı gövdeye eklenir; karartma sol menüyü ve üst çubuğu da kaplar.

## Posta incelemesi (2026-11-22, salt okunur)

- Son 14 günde outbox'a hiç e-posta kaydı düşmedi. Postayı tetikleyecek tablolar boş: doğrulama, davet, demo ve hatırlatma gönderim kaydı.
- Kiracının hatırlatma ayarlarında e-posta kanalı, randevu hatırlatması ve aşı hatırlatması kapalı. **Pilot açılışında hatırlatmalar açılmalı.**
- SMTP ayarlarının hepsi dolu. Günlükteki 61 "Outbox loop error" satırının hepsi SQL Server bağlantı kesintisi; posta hatası değil.

## Karar

- Hekim rolü Rapor Merkezi'nde ödeme ve borç kartlarını görmeye devam eder. Kodda `Payments.Read` ve `Charges.Read` hekime bilerek verilmiş; hesap kapatma bu izinlere bağlı. Ayrı bir "finans raporları" izni ancak pilot klinik isterse açılacak.

## Testler

- Backend Integration, Outbox: 139/139.
- Panel tam takım: 470 dosya, 3740/3740.

## Doğrulama

- `vetinity-api` aktif, `/health/ready` 200.
- Paneldeki `main-*.js` ve `ngsw.json` zaman damgası yerel derlemeyle aynı; www 200.
- Geri alma için `api-eski` (`a7d548e0`) ve `web-eski` (`f8fb7ec5`) sunucuda saklı.

## Doğrulanmayanlar

- Uygulama üzerinden canlıda gerçek posta gönderimi denenmedi. Önerilen deneme: panelde "Şifremi unuttum".
- İki panel düzeltmesi tarayıcıda gözle denenmedi.
