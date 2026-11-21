# Sürüm notu: vital ölçümü backend'i, hayalet geçmiş satırı, posta başlığı

> **Durum:** yayınlandı, 2026-11-21. Yedek 13:30, migration ve seed 13:30–13:31, API 13:31. Kullanıcı onayıyla.
> Yalnız backend; panel değişmedi. Migration var, yeni izin var (`seed` çalıştı); yeni izinler için çıkış-giriş gerekir.

## Yayınlanan sürüm

| | Commit | Not |
|---|---|---|
| Backend (`api`, `dbmigrator`) | `e667628d` (main) | Önceki canlı sürüm `6931231a` |

İçerik (first-parent):
- `749224e4` HOSP-004 vital ölçümü backend'i (`/api/v1/vital-measurements`, sözleşme `docs/VITAL_SIGNS_API_CONTRACT.md`). **Ekranı yok**; tasarım 3 seçenekle hazırlanıyor.
- `a51507bd` Eşzamanlılık çakışmasında hayalet değişiklik geçmişi satırı kalmaz (yatış güncelleme/taburcu/iptal, tedavi ve aşı iptali).
- `e667628d` Posta başlıkları: SMTP EHLO ve `Message-Id` makine adı yerine `Smtp:LocalDomain` (varsayılan `vetinity.com`). Canlı sunucunun adı başka bir uygulamanınki olduğu için alıcının ham başlıklarına geçiyordu.
- `17b9ff3f` (yalnız Development seed'i), `7baa16a7` (yalnız DbMigrator Development DI) canlıyı etkilemez.

## Migration ve seed

- `VetinityCommandDb`: `20261120094444_AddVitalMeasurements` (yalnız yeni tablo ve dizinler; Up'ta silme yok). `VetinityQueryDb`: değişiklik yok.
- `seed`: 10 rol-izin bağı eklendi. `VitalMeasurements.Read` 5 role, `Create` ve `Update` 4'er role bağlı.
- Değer sınırları (kilo ≤ 9.999,99 kg, ateş 25–45 °C, nabız 1–400, solunum 1–200) ve kayıt kuralları (yatışa ya da muayeneye bağlı, 7 gün geriye giriş) bu hâliyle canlıda; ürün soruları hâlâ açık.

## Testler (gerçek çıktı)

- `e667628d` dalında (`fix/posta-sunucu-adi`): Domain 1368, Application 4550 geçti. Integration 2245 geçti, 2 düştü, 4 atlandı; düşen ikisi ("dün/bugün" hesaplayan rapor ve geliş testleri) koşu gece yarısını geçtiği için tarih kaydı, ayrı koşuda ikisi de geçti. Yeni posta başlığı testleri (2) geçti.
- Birleşik main (`a51507bd`+`17b9ff3f`, birleştirme oturumu): Domain 1368, Application 4550, Integration 2245 geçti, 4 atlandı.

## Canlı doğrulama

- Önce tam yedek: `/opt/vetinity/yedek.sh` 13:30, `INFO: bitti`, Drive kopyası doğrulandı (`gunluk/2026-11-21`, `*_13-30.bak`).
- `migrate` → `AddVitalMeasurements` uygulandı; `migrate-query` → güncel; `seed` → tamamlandı.
- API: `vetinity-api` active; `/health/ready` 200; `GET /api/v1/vital-measurements` yetkisiz 401 (olmayan uç 404, yani uç yayında); `https://api.vetinity.com/health/live` 200; açılıştan sonra günlükte ERR/FTL 0 (yalnız EF'nin olağan açılış uyarıları).
- Veritabanı: üç `VitalMeasurements.*` izni var ve rollere bağlı; `VitalMeasurements` tablosu açıldı (0 satır).
- Geri alma: önceki paketler `api-eski` (`6931231a`) ve `dbmigrator-eski`; daha eskileri `api-eski-20261120b`, `dbmigrator-eski-20261120`. Migration geri alınmaz; gerekirse 13:30 yedeğinden dönüş (yeni tabloda veri yok).

## Doğrulanmayanlar

- Yeni posta başlıkları canlıda gerçek bir postayla görülmedi (API bu yayından beri posta göndermedi; uyarı betiği ayrı yoldan zaten `vetinity.com` ile gidiyor).
- Vital uçları canlıda girişle denenmedi.
- Gmail ham başlığa sunucu IP'sini yazar; IP'nin ters DNS kaydı başka uygulamanın alan adını gösterir. Bu yayın onu değiştirmez.
