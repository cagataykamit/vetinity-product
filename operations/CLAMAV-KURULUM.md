# ClamAV kurulumu (canlı sunucu)

Yüklenen dosyaların virüs taraması için clamd kurulumu. Backend kodu hazır (`feature/virus-tarama`): API her yüklemeyi (görüntüleme ve lab dosyası, klinik sitesi görseli, içe aktarma dosyası) kaydetmeden önce clamd'ye TCP ile gönderir (INSTREAM). Sözleşme: backend `docs/IMAGING_API_CONTRACT.md`, "Virüs taraması" satırı.

- Kullanıcı onayı: ClamAV kurulumu 2026-11-11 (CANLI-ISLETIM-KILAVUZU.md bölüm 11.2).
- Sunucu: Ubuntu 22.04, 8 GB bellek. Aynı makinede Zonguldak sitesi var. clamd yalnız `127.0.0.1`'de dinler, Zonguldak'ın dosyalarına ve ayarlarına dokunulmaz.
- Uygulandı: 2026-11-16 03:45–03:47 (ClamAV 1.5.4). Kurulumdan önce boş bellek 5,4 GB olduğu için `ConcurrentDatabaseReload` varsayılan (açık) kaldı. `StreamMaxLength 25M` paket ayarında zaten vardı; yalnız `TCPSocket` ve `TCPAddr` eklendi. Ölçülen bellek: clamd ~970 MB. EICAR yakalandı, `/health/ready` içinde `clamav` "clamd yanıt veriyor."

## 1. Önce bellek

clamd imza veritabanını bellekte tutar. Tahmin: 1–1,5 GB. İmza güncellemesinde yeni veritabanı eskisinin yanında yüklenir (`ConcurrentDatabaseReload yes`, varsayılan), bu sırada kısa süre yaklaşık iki katına çıkar. Bu sayılar ölçülmedi.

Kurmadan önce:

```bash
free -h
```

```bash
ps -eo rss,comm --sort=-rss | head -15
```

SQL Server en çok 3 GB kullanır (bölüm 1.4). `available` sütunu 3 GB'tan azsa bölüm 3'te `ConcurrentDatabaseReload no` seçilir. Bu, tepe kullanımı yarıya indirir; karşılığında imza yeniden yüklenirken (yaklaşık yarım-bir dakika, günde birkaç kez) tarama yapılamaz ve o anki yüklemeler "Dosya şu an taranamıyor" ile reddedilir.

## 2. Paketler

```bash
apt-get update
```

```bash
apt-get install -y clamav-daemon clamav-freshclam
```

```bash
clamd --version
```

## 3. clamd ayarı: yalnız 127.0.0.1

`/etc/clamav/clamd.conf` dosyasına eklenir (varsa değiştirilir). Önce yedek:

```bash
cp /etc/clamav/clamd.conf /root/clamd.conf.yedek-$(date +%F)
```

Eklenecek satırlar:

```
TCPSocket 3310
TCPAddr 127.0.0.1
StreamMaxLength 25M
```

- `TCPAddr 127.0.0.1` zorunludur; olmazsa clamd tüm arayüzlerde dinler. ufw 3310'u zaten dışarıya kapatır, ama ikisi birlikte tutulur.
- `StreamMaxLength`, API'deki `FileScanning__Clamd__MaxFileSizeMb` değerinden (varsayılan 25) küçük olmamalıdır. Yükleme sınırları bunun altındadır: dosya 15 MB, içe aktarma 10 MB, site görseli 5 MB.
- Bellek azsa (bölüm 1): `ConcurrentDatabaseReload no`.
- Ubuntu'da bu dosya paket ayarlarından üretilir. Paket güncellemesinden sonra satırların yerinde durduğu bölüm 6'daki kontrolle doğrulanır.

## 4. İmzalar (freshclam) ve başlatma

İlk indirme birkaç yüz MB'tır. İmza yoksa clamd açılmaz.

```bash
systemctl stop clamav-freshclam
```

```bash
freshclam
```

```bash
systemctl enable --now clamav-freshclam
```

```bash
systemctl enable clamav-daemon
```

```bash
systemctl restart clamav-daemon
```

- freshclam servisi imzaları kendiliğinden günceller (varsayılan günde 24 kez yoklama); günlük `/var/log/clamav/freshclam.log`.
- clamd'nin imzaları yüklemesi bir-iki dakika sürebilir.

## 5. Doğrulama

```bash
ss -ltnp | grep 3310
```

Beklenen: yalnız `127.0.0.1:3310`.

```bash
printf 'zPING\0' | nc -q1 127.0.0.1 3310
```

Beklenen: `PONG`.

EICAR test dosyası (zararsız, tüm tarayıcıların tanıdığı test dizesi; belgede bitişik yazılmadı ki bu dosya virüs koruması tarafından karantinaya alınmasın):

```bash
printf '%s%s' 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR' '-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > /tmp/eicar.txt
```

```bash
clamdscan --stream /tmp/eicar.txt
```

Beklenen: `... FOUND`. Ardından `rm /tmp/eicar.txt`.

Bellek, imzalar yüklendikten sonra:

```bash
ps -o rss,cmd -C clamd
```

Ölçülen değer bu belgeye ve CANLI-ISLETIM-KILAVUZU.md bölüm 11.2'ye yazılır.

## 6. API'de taramayı açma

clamd çalışıp `PONG` verdikten sonra yapılır. Tarama açıkken clamd'ye ulaşılamazsa yüklemeler reddedilir (taranmamış dosya kabul edilmez).

`/etc/vetinity/production/api.env` dosyasına eklenir:

```
FileScanning__Enabled=true
```

Diğerleri varsayılanla kalabilir: `FileScanning__Clamd__Host=127.0.0.1`, `__Port=3310`, `__TimeoutSeconds=30`, `__MaxFileSizeMb=25`.

```bash
systemctl restart vetinity-api
```

```bash
curl -s http://127.0.0.1:5100/health/ready
```

Beklenen: `clamav` girdisi `Healthy`, açıklama "clamd yanıt veriyor."

- Tarama kapalıyken `clamav` girdisi `Healthy` döner ama açıklamada "kapalı" yazar. Ayrıca açılış günlüğünde "FileScanning is disabled" uyarısı çıkar.
- clamd yanıt vermezse `clamav` girdisi `Degraded` olur ve `/health/ready` 503 döner. API çalışmaya devam eder, yalnız yüklemeler reddedilir.

Ardından panelde bir görüntüleme kaydına küçük bir JPEG yüklenir; başarılı olmalı.

## 7. Günlükler ve sorunlar

| Ne | Nerede |
|---|---|
| clamd | `journalctl -u clamav-daemon -n 100` |
| İmza güncellemesi | `/var/log/clamav/freshclam.log` |
| Reddedilen virüslü yükleme | API günlüğü `Malware detected; upload rejected` (uyarı) ve denetim kaydında `Action = Files.MalwareDetected` (imza adıyla) |
| Taranamayan yükleme | API günlüğü `File scan failed; upload rejected` (hata), `Reason` alanında neden |
| Bellek yetmedi | `dmesg -T \| grep -i -E "oom\|killed process"` |

- Bellek yetmezliğinde çekirdek önce en çok bellek kullananı durdurur; bu SQL Server da olabilir. Belirti görülürse önce `ConcurrentDatabaseReload no`, sonra gerekirse taramayı kapatmak (bölüm 8).

## 8. Geri alma

```
FileScanning__Enabled=false
```

`api.env`'de bu değer yapılır ve `systemctl restart vetinity-api`. Yüklemeler taranmadan kabul edilir (bugünkü düzen).

Belleği geri almak için:

```bash
systemctl disable --now clamav-daemon clamav-freshclam
```
