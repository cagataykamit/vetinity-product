# Sürüm notu: Hesabı kapat, aşı saati, kayıtlı takvim filtreleri

> **Durum:** yayınlandı, 2026-11-20. API 20:27, panel 20:28. Kullanıcı onayıyla, önce backend, sonra panel.
> Migration yok, yeni izin yok, `seed` gerekmez.

## Yayınlanan sürüm

| | Commit | Not |
|---|---|---|
| Backend (`api`) | `6931231a` (main) | Sonraki `749224e4` (HOSP-004 vital ölçümü, migration'lı), `a51507bd` (eşzamanlılıkta hayalet geçmiş satırı), `17b9ff3f`, `7baa16a7` bu yayında **yok** |
| Panel (`web`) | `209307f8` (main) | `d5edb75a` birleştirmesi ve tarayıcı denemesinde bulunan iki düzeltme: `c237698c` (kapanıştan sonra panel başlığı "Tamamlandı"), `209307f8` (kayıtlı filtre "Filtreleri temizle" sonrası yeniden uygulanır; ortak bileşen, Rapor Merkezi'ni de etkiler) |

## Birleştirilen dallar

| İş | Backend | Panel |
|---|---|---|
| CHECKOUT-001 Hesabı kapat | `feature/hesabi-kapat`: `b13cc6ec`, `f64b86c4`, `85d49188` | `feature/hesabi-kapat`: `ef4b971c`, `85b91d0b`, `f0cdf1f8`, `d8061439`, `5ffc27c1`, `d23f7662`, `106224b8` |
| Aşı saati (form ve takvim) | `fix/asi-saat-belirtildi`: `762f43af`, `7a570508`, `96e423a6` | `fix/asi-saat-alani`: `388326d1`, `f1b7fafd` |
| APPT-026 kayıtlı takvim filtreleri | `docs/kayitli-filtre-ekran-anahtari`: `98a19316` (yalnız sözleşme) | `feature/kayitli-takvim-filtreleri`: `c048a151`, `039a9aee`, `ef41b3b6`, `317d49b5` |

## Testler (gerçek çıktı)

- Backend `6931231a`: Domain 1361, Application 4523 geçti. Integration ayrı worktree'de tek başına: 2238 geçti, 0 düştü, 4 atlandı (trx). Aynı commit'in ilk koşusunda 1 test düşmüştü; koşu sırasında aynı klasörde başka bir `dotnet build` çalışıyordu, düşen testin adı kaydedilmedi.
- Panel `209307f8`: 465 dosya, 3693 test geçti; `ng build` başarılı. ESLint'te tek hata `core/routing/panel-redirects.spec.ts` (önceki yayının `7458508d` commit'inden, yalnız test dosyası; bu yayınla gelmedi).

## Canlı doğrulama

- API: `vetinity-api` active, `/health/ready` 200; `GET /visits/{id}/checkout-summary` yetkisiz 401 (olmayan uç 404, yani yeni uç yayında); açılıştan sonra günlükte ERR/FTL yok.
- Panel: `panel.vetinity.com` `main-AQQRMM4W.js` (yerel derlemeyle aynı), dosya 200 `application/javascript`; `ngsw.json` zaman damgası `1795194651400` yerel derlemeyle aynı, `Cache-Control: no-cache`; `www.vetinity.com` 200.
- Geri alma: önceki paketler `api-eski` (`799e1cc7`) ve `web-eski` (`ea668ab9`); bir önceki yayının paketleri `api-eski-20261120a` ve `web-eski-20261120a` olarak saklandı.

## Hesabı kapat (CHECKOUT-001)

- Bugün satırında **Hesabı kapat**: tek yan panelde ücret bekleyen kalemler (çevir ya da gerekçeyle ücretsiz), açık ücretler (eski borçlar seçili gelmez), parçalı tahsilat (nakit, kart, havale; nakitte kasa), krediden ödeme, fazlası krediye, gelişi tamamlama (bekleyen geliş önce başlatılır), bilgi fişi ve kapanıştaki e-Belge önerisi (Bugün'deki **Tamamla** ile aynı bileşen ve kural).
- Okuma tek uçtan: `GET /visits/{id}/checkout-summary` (BE `docs/VISIT_CHECKOUT_API_CONTRACT.md`). Yazma mevcut uçlarla adım adım. Hata olursa panel durur; tekrar deneme aynı istek kimliğiyle gider, ödeme satırı borçla kapatılabilir.
- Kesinleşmiş, gelişe bağlı muayenenin eylem şeridinde de **Hesabı kapat** var.
- Ön büro yetkisinde (tahsilat ya da ücrete çevirme) satırın ana düğmesi **Hesabı kapat** olur; **Tamamla** ve **Ödeme al**'ın yerini alır (**Ödeme al** ⋯ menüsünde). Muayene ve ücreti olmayan muayenedeki hastada **Tamamla** kalır.

## Aşı saati

- Aşı formunda planlanan ve sonraki aşı tarihi saatiyle girilir; saat artık takvimde **saatiyle** durur. Önce kaydediliyor ama takvimde "Saatsiz" görünüyordu (pilot hazırlık kapı 3). `POST/PUT /vaccinations` gövdesinde isteğe bağlı `dueTimeSpecified` (BE `APPOINTMENT_CALENDAR_API_CONTRACT.md` §8.1).
- Tarih-saat alanında boş alanda Enter paneldeki tarih ve saati seçer (saat alanıyla aynı).
- Aktarılmış eski aşıların saati bu yayınla gelmez; ayrı veri düzeltme betiği var (`operations/PILOT-VERI-DUZELTME.md`, canlı veriye yazar, ayrı onay).

## Kayıtlı takvim filtreleri (APPT-026)

- Randevu takviminde hekim, tür ve durum filtreleri adla kaydedilir (tarih ve görünüm kaydedilmez); online talep listesinde durum. Mevcut kayıtlı filtre deposu kullanılır, backend değişmedi.

## Bilinen sınırlar

- Hesabı kapat Bugün satırından ve kesinleşmiş, gelişe bağlı muayeneden açılır.
- Tarayıcı denemesi yerelde yapıldı (iki hata bulunup düzeltildi); canlıda giriş yapılarak denenmedi.
- Backend ve panel `main`'leri push edilmedi; yayınlanan commit'ler yerel `main`'de.
