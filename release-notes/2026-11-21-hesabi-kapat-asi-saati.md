# Sürüm notu (taslak): Hesabı kapat, aşı saati, kayıtlı takvim filtreleri

> **Durum:** taslak, **yayınlanmadı**. Dallar main'e alınmadı; birleştirme, push ve yayın kullanıcı onayıyla yapılır. Yayında commit'ler ve doğrulama bu nota yazılır.
> **Önce backend, sonra panel.** Migration yok, yeni izin yok, `seed` gerekmez.

## Dallar

| İş | Backend | Panel |
|---|---|---|
| CHECKOUT-001 Hesabı kapat | `feature/hesabi-kapat`: `b13cc6ec`, `f64b86c4`, `85d49188` | `feature/hesabi-kapat`: `ef4b971c`, `85b91d0b`, `f0cdf1f8`, `d8061439` |
| Aşı saati (form ve takvim) | `fix/asi-saat-belirtildi`: `762f43af`, `7a570508`, `96e423a6` | `fix/asi-saat-alani`: `388326d1`, `f1b7fafd` |
| APPT-026 kayıtlı takvim filtreleri | `docs/kayitli-filtre-ekran-anahtari`: `98a19316` (yalnız sözleşme) | `feature/kayitli-takvim-filtreleri`: `c048a151`, `039a9aee`, `ef41b3b6`, `317d49b5` |

Testler (dal başına, gerçek çıktı):
- Hesabı kapat: backend Domain 1360, Application 4523, Integration 2236 (4 atlandı); panel 463 dosya, 3675 test; `ng build` başarılı.
- Aşı saati: backend Domain 1361, Application 4522, Integration 2235 (4 atlandı); panel 463 dosya, 3666 test; `ng build` başarılı.
- APPT-026: panel 461 dosya, 3658 test; `ng build` başarılı.
- Dallar birleştikten sonra testler birlikte yeniden koşulmalı (birlikte koşulmadı).

## Hesabı kapat (CHECKOUT-001)

- Bugün satırında **Hesabı kapat**: tek yan panelde ücret bekleyen kalemler (çevir ya da gerekçeyle ücretsiz), açık ücretler (eski borçlar seçili gelmez), parçalı tahsilat (nakit, kart, havale; nakitte kasa), krediden ödeme, fazlası krediye, gelişi tamamlama (bekleyen geliş önce başlatılır), bilgi fişi ve kapanıştaki e-Belge önerisi (Bugün'deki **Tamamla** ile aynı bileşen ve kural).
- Okuma tek uçtan: `GET /visits/{id}/checkout-summary` (BE `docs/VISIT_CHECKOUT_API_CONTRACT.md`). Yazma mevcut uçlarla adım adım. Hata olursa panel durur; tekrar deneme aynı istek kimliğiyle gider, ödeme satırı borçla kapatılabilir.
- Ön büro yetkisinde (tahsilat ya da ücrete çevirme) satırın ana düğmesi **Hesabı kapat** olur; **Tamamla** ve **Ödeme al**'ın yerini alır (**Ödeme al** ⋯ menüsünde). Muayene ve ücreti olmayan muayenedeki hastada **Tamamla** kalır.

## Aşı saati

- Aşı formunda planlanan ve sonraki aşı tarihi saatiyle girilir; saat artık takvimde **saatiyle** durur. Önce kaydediliyor ama takvimde "Saatsiz" görünüyordu (pilot hazırlık kapı 3). `POST/PUT /vaccinations` gövdesinde isteğe bağlı `dueTimeSpecified` (BE `APPOINTMENT_CALENDAR_API_CONTRACT.md` §8.1).
- Tarih-saat alanında boş alanda Enter paneldeki tarih ve saati seçer (saat alanıyla aynı).
- Aktarılmış eski aşıların saati bu yayınla gelmez; ayrı veri düzeltme betiği var (`operations/PILOT-VERI-DUZELTME.md`, canlı veriye yazar, ayrı onay).

## Kayıtlı takvim filtreleri (APPT-026)

- Randevu takviminde hekim, tür ve durum filtreleri adla kaydedilir (tarih ve görünüm kaydedilmez); online talep listesinde durum. Mevcut kayıtlı filtre deposu kullanılır, backend değişmedi.

## Bilinen sınırlar

- Hesabı kapat muayene kesinleştirme sonrasından açılmıyor; yalnız Bugün'den.
- Ekranlar gerçek veriyle tarayıcıda denenmedi.
