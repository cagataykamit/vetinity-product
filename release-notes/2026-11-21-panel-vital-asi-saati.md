# Sürüm notu: vital ölçümü ekranı, aşı saati düzeltmesi, uyarı postası denemesi

> **Durum:** yayınlandı, 2026-11-21. Panel 14:55; aşı saati düzeltmesi 14:50 yedeğinden sonra. Kullanıcı onayıyla.
> Yalnız ön yüz yayını (kesintisiz) ve tek seferlik veri düzeltmesi; API, migration ve seed bu adımda değişmedi.

## Yayınlanan sürüm

| | Commit | Not |
|---|---|---|
| Panel (`web`) | `dd8ad7e2` (main) | Önceki canlı sürüm `209307f8` |
| Backend (`api`, `dbmigrator`) | `e667628d` (main) | Değişmedi; 13:31 yayını (`2026-11-21-vital-olcumu-posta-basligi.md`). Sunucuda paket sürümü `1.0.0+e667628d` doğrulandı |

Panel içeriği (first-parent, `209307f8..dd8ad7e2`):
- `dd8ad7e2` HOSP-004 vital ölçümü ekranı: yatış detayı, muayene ve hasta kartında eğilim bölümü (hızlı giriş, dört grafik,
  düzenle ve gerekçeli iptal). Backend'i 13:31'den beri canlıda. Yeni izinler için kullanıcılar **çıkış yapıp yeniden girmeli**.

## Testler (gerçek çıktı)

- Panel `npx ng test vetinity-web --watch=false` (`dd8ad7e2`): 470 dosya, 3737 test; 3736 geçti, 1 düştü
  (`date-input-datetime.component.spec.ts`, "Önceki saat" düğmesi tıklanırken öğe DOM'dan ayrıldı). Aynı dosya tek başına
  7/7 geçti; tam koşudaki yük altında kararsız test.
- `npx ng build vetinity-web` başarılı.

## Panel canlı doğrulama

- `https://panel.vetinity.com/auth/login` → `main-7S43MJP5.js`, yerel `dist` ile aynı; dosya `200 application/javascript`.
- `ngsw.json` zaman damgası `1795262074383`, yerel ile aynı; `Cache-Control: no-cache`. `https://www.vetinity.com/` 200.
- Geri alma: `web-eski` (`209307f8`); daha eskiler `web-eski-20261120a`, `web-eski-20261120b` (önceki `web-eski` silinmedi, yeniden adlandırıldı).

## Aşı saati düzeltmesi (B, `operations/PILOT-VERI-DUZELTME.md`)

- Yedek: `/opt/vetinity/yedek.sh` 14:50, çıkış 0; `gunluk/2026-11-21/*_14-50.bak` (Command ve Query) ve dosya yedeği yazıldı.
- Kuru çalıştırma (değer dosyası `/root/veri-duzeltme/d1118/`, 2026-11-18 E-vet yedeği): değer dosyası 5 761, eşleşen anahtar
  5 756, güncellenecek 5 745 (12:00 olan 3, 00:00 olan 1), vade boş 11; tek klinik `D6777E9B…`. Kimlik listesi 2026-11-20 kuru
  çıktısıyla aynı.
- İlk uygulama "Msg 1934 QUOTED_IDENTIFIER" ile düştü; `XACT_ABORT` ile geri alındı, hiçbir satır değişmedi (yalnız boş `ops_yedek`
  şeması açıldı). sqlcmd'ye `-I` eklenerek yinelendi: `UYGULANDI: 5745`, önceki görüntü `ops_yedek.Vaccinations_20261121_AsiSaati`
  (5 745 satır).
- Doğrulama: pilot kliniğin vadeli aktarılmış aşılarının tümü (5 745) artık saatli (`DueTimeSpecified = 1`), saatsiz kalan 0; yedek
  satırların 5 745'i yeni değerde, **günü değişen 0**. En sık saatler (İstanbul) 10:30 (2 419), 09:05 (425), 10:10 (282).
- Geri alma hazır: `02-asi-saati-geri-getir-geri-al.sql` kuru çalıştırması 5 745 "geri alınabilir". Komut:
  `sq -i 02-asi-saati-geri-getir-geri-al.sql -v UYGULA=EVET` (`sq` tanımı `-I` ile, belge §Sabah adımları).
- A (1 yıldan eski gecikmiş vadeyi takipten çıkarma) **yapılmadı**; yerine kodda "1 ay kuralı" geliyor.

## Uyarı betiği

- Sunucudaki `/opt/vetinity/ops/vetinity-uyari.sh` `e170223` sürümü (md5 yerel `main` ile aynı; 2026-11-20 23:53'te kurulmuş).
- `vetinity-uyari.sh --posta-dene` 14:51: "deneme postasi gonderildi", çıkış 0.

## Doğrulanmayanlar

- Deneme postasının "Sunucu: Vetinity canlı" satırı ve ham başlıklardaki EHLO adı alıcı kutusunda görülmedi (kullanıcıya soruldu).
- Vital ölçümü ekranı canlıda girişle denenmedi; aşı saatleri panel takviminde gözle bakılmadı.
- 10:30 yığılması E-vet kaynağındaki saatten geliyor (değer dosyası); E-vet'in varsayılan görev saati olup olmadığı bilinmiyor.
