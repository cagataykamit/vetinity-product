# Pilot işletim betikleri: 15 dakikalık log yedeği ve canlı uyarılar

Amaç: pilot öncesi veri kaybı penceresini 1 günden **~15 dakikaya** indirmek ve sorunları
kendiliğinden haber vermek. Gece tam yedeği (`/opt/vetinity/yedek.sh`, 02:30) **aynen kalır**.
Betikler yalnız `VetinityCommandDb`, `VetinityQueryDb` ve Vetinity yollarına dokunur; aynı
sunucudaki başka uygulamanın veritabanı ve dosyaları kapsam dışıdır. `sqlservr` çalıştırılmaz.

Kaynak: `operations/scripts/` (bu belgeyle aynı dal). Kurulumdan sonra betikler sunucuda
`/opt/vetinity/ops/` altında durur.

## 1. Dosyalar

| Dosya | Ne yapar |
|---|---|
| `vetinity-ortak.sh` | Ortak parça: veritabanı listesi, yollar, `KEY=VALUE` okuyucu, `sqlcmd` çağrısı, günlük biçimi. Tek başına çalışmaz. |
| `vetinity-log-yedek.sh` | Cron ile 15 dk'da bir. İki veritabanı için `BACKUP LOG ... WITH COMPRESSION, CHECKSUM` → `/var/backups/vetinity/log/<gün>/<DB>_<zaman>.trn`, `RESTORE VERIFYONLY` (sa), `rclone copy` → `gcrypt:log/<gün>` + `rclone cryptcheck --one-way` (bugün ve dün klasörü). Yerelde 14 gün, Drive'da 30 gün (Drive temizliği günde bir, 03:00–03:14 koşusunda). Veritabanı FULL değilse ya da FULL'e geçtikten sonra tam yedek yoksa o veritabanını **atlar ve günlüğe yazar**. `flock` ile kendi koşularıyla çakışmaz; gece yedeği sürüyorsa koşuyu atlar. Hata varsa çıkış kodu 1. Günlük: `/var/log/vetinity-log-yedek.log` (`<iso> INFO/ERROR: ...`, her koşu `INFO: basladi` ile başlar, `INFO: bitti` ya da `ERROR: hatalarla bitti` ile biter). |
| `vetinity-log-yedek-kurulum.sh` | Tek seferlik kurulum, tekrar çalıştırılabilir. Parametresiz: ön denetim + plan, **hiçbir şey değiştirmez**. `--uygula`: betikleri `/opt/vetinity/ops/`'a kopyalar, iki veritabanını FULL'e alır, log zinciri yoksa `yedek.sh` ile hemen tam yedek alır, log yedeğini bir kez çalıştırır, cron ve logrotate dosyalarını yazar, uyarıyı `--deneme` ile çalıştırır. |
| `vetinity-uyari.sh` | Cron ile 5 dk'da bir; aşağıdaki 5 denetim. `--deneme`: posta yerine ekrana yazar, durum dosyalarına dokunmaz. `--posta-dene`: tek bir deneme postası gönderir. Günlük: `/var/log/vetinity-uyari.log` (yalnız gönderilen postalar ve hatalar). |
| `vetinity-uyari-sinama.sh` | Uyarı karar mantığının sınaması (sahte günlük, sahte journal, sahte disk/sağlık). Sunucuya ve postaya dokunmaz. |
| `restore-provasi.sql` + `restore-provasi.sh` | Log zinciriyle geri yükleme provası: geçici `VetinityLogProva_<rastgele>` veritabanı yaratır, tam + 2 log yedeği alır, (a) en son ana, (b) `STOPAT` ile ara bir ana geri yükler, kayıt sayılarını doğrular, sonra geçici veritabanlarını, yedek dosyalarını ve msdb yedek geçmişini siler. |

### Uyarı denetimleri

| Tür | Koşul | Alınınca |
|---|---|---|
| `saglik` | `http://127.0.0.1:5100/health/ready` 3 denemede (10 sn arayla) 200 değil | `curl -s http://127.0.0.1:5100/health/ready`; `systemctl status vetinity-api`; `journalctl -u vetinity-api -n 200` |
| `disk` | `/` doluluğu ≥ %85 | `df -h /`; `du -sh /var/backups/vetinity/* /var/log/journal` (yalnız Vetinity dosyaları) |
| `gece-yedek` | Son `INFO: bitti` 26 saatten eski, ya da son koşuda `ERROR` (son `bitti`den önceki 2 saat + sonrası) | `tail -30 /var/log/vetinity-yedek.log`; gerekirse elle yedek (kılavuz 9.3) |
| `log-yedek` | Yalnız `/etc/cron.d/vetinity-log-yedek` varsa: en yeni `.trn` 35 dk'dan eski, ya da son koşuda `ERROR` | `tail -30 /var/log/vetinity-log-yedek.log`; veritabanları FULL mi? Log yedeği durursa LDF dosyaları büyür |
| `api-hata` | Son 5 dk journal'da `[hh:mm:ss ERR\|FTL]` ≥ 5 ya da `responded 5xx` ≥ 3 | `journalctl -u vetinity-api --since -15min -p err`; traceId ile arama |

Her tür ayrı posta. Sorun sürerse en çok **60 dk'da bir** yinelenir (`(suruyor)`), düzelince
`[Vetinity DÜZELDİ]` postası gider. Durum: `/var/lib/vetinity-uyari/<tür>` (son bildirim zamanı).
Posta gövdesine kişisel veri taşımamak için 5xx satırlarından yalnız yol (sorgu dizesi atılır) ve
hata satırlarının ilk 120 karakteri konur.

## 2. Gizli bilgiler: `/etc/vetinity/production/ops.env`

`root:root`, izin `600`. Biçim `ANAHTAR=değer` (kabuk genişletmesi yok; değeri saran tırnak atılır,
ters bölü kaçışları işlenmez). Kurulum ön denetimi izni ve zorunlu anahtarları kontrol eder.

| Anahtar | Zorunlu | Açıklama |
|---|---|---|
| `SQLCMDPASSWORD_APP` | evet | `vetinity_app` parolası (BACKUP LOG) |
| `SQLCMDPASSWORD_SA` | evet | `sa` parolası (durum sorgusu, RESTORE VERIFYONLY, kurulumda `ALTER DATABASE ... SET RECOVERY FULL`) |
| `ALERT_TO` | evet | Uyarı alıcısı; birden çoksa virgülle |
| `UYARI_DISK_ESIK` | hayır | Varsayılan 85 |
| `UYARI_ERR_ESIK` | hayır | Varsayılan 5 (5 dk'da ERR/FTL) |
| `UYARI_5XX_ESIK` | hayır | Varsayılan 3 (5 dk'da 5xx) |
| `SUNUCU_ETIKETI` | hayır | Uyarı postasındaki "Sunucu:" satırı. Varsayılan `Vetinity canlı`. Sistem hostname'i kullanılmaz: sunucu başka bir uygulamayla ortak ve onun adını taşır |
| `SMTP_EHLO_ADI` | hayır | SMTP EHLO'da gönderilen ad (alıcının ham başlıklarında `Received: from ...` olarak görünür). Varsayılan `vetinity.com` |

Parolaları ekrana basmadan doldurmak için (önce `grep -n 'db-pass\|vetinity-sa' /opt/vetinity/yedek.sh`
ile mevcut betiğin bu dosyaları düz `cat` ile okuduğunu doğrulayın; dosyalar yalnız parolayı içermelidir):

```bash
install -m 600 -o root -g root /dev/null /etc/vetinity/production/ops.env
{
  printf 'SQLCMDPASSWORD_APP=%s\n' "$(cat /etc/vetinity/production/.db-pass)"
  printf 'SQLCMDPASSWORD_SA=%s\n' "$(cat /root/.vetinity-sa)"
  printf 'ALERT_TO=%s\n' '<alıcı adresi>'
} > /etc/vetinity/production/ops.env
```

Posta ayarları `api.env`'den yalnız okunur: `Smtp__Host`, `Smtp__Port`, `Smtp__User`, `Smtp__Pass`,
`Smtp__From`, `Smtp__EnableSsl`, `Smtp__UseStartTls`. `UseStartTls=true` → `smtp://` + STARTTLS,
değilse `EnableSsl=true` → `smtps://`; ikisi de false ise posta gönderilmez (şifresiz SMTP yok).
Parola `curl`'e argümanla değil stdin yapılandırmasıyla verilir.

## 3. Kurulum sırası (sabah, tek pencere)

1. Betikleri sunucuya kopyala (ör. `/root/ops-betikleri/`) ve satır sonlarını kontrol et:
   `grep -lU $'\r' /root/ops-betikleri/*.sh || echo LF-tamam`; `chmod 700 /root/ops-betikleri/*.sh`
2. `ops.env`'i oluştur (bölüm 2).
3. **Önce elle tam yedek** (kılavuz 9.3): `/opt/vetinity/yedek.sh` (gece cron'uyla aynı biçimde) ve
   `tail -5 /var/log/vetinity-yedek.log` → `INFO: bitti`.
4. Plan (değişiklik yapmaz): `/root/ops-betikleri/vetinity-log-yedek-kurulum.sh`
   Ön denetim `DUR` derse eksik giderilir. Planda iki veritabanının kurtarma modeli görünür.
5. Uygula: `/root/ops-betikleri/vetinity-log-yedek-kurulum.sh --uygula`
   (FULL'e geçiş + log zinciri için tam yedek birkaç dakika sürer; tam yedek hatayla biterse cron kurulmaz.)
6. Posta yolu: `/opt/vetinity/ops/vetinity-uyari.sh --posta-dene` → posta kutusuna deneme postası.

Cron dakikaları `7,22,37,52` (02:30 gece yedeği başlangıcına denk gelmesin diye kaydırıldı); uyarı `*/5`.
Logrotate: `/etc/logrotate.d/vetinity-ops` (iki yeni günlük, haftalık, 8 kopya).

Notlar: Gece tam yedeğinin `WITH INIT` kullanması sorun değildir; tam yedek log zincirini kırmaz,
zincir tam yedeklerin üzerinden devam eder. Kurulum betiği tekrar çalıştırılabilir: FULL olanı tekrar
değiştirmez, zincir varsa tam yedek almaz, dosyaları aynı içerikle yeniden yazar.

## 4. Kurulum sonrası doğrulama

- 15 dk içinde ilk zamanlanmış koşu: `tail -20 /var/log/vetinity-log-yedek.log` → her veritabanı için
  `log yedegi alindi ve dogrulandi`, `Drive kopyasi dogrulandi: log/<gün>`, `INFO: bitti`.
- Yerel: `ls -la /var/backups/vetinity/log/$(date +%F)/` (iki `.trn`, root 600).
- Drive: `rclone lsl gcrypt:log/$(date +%F)`.
- Kurtarma modeli: `SELECT name, recovery_model_desc FROM sys.databases WHERE name LIKE 'Vetinity%'` → FULL.
- Uyarı: `/opt/vetinity/ops/vetinity-uyari.sh --deneme` → sorun yoksa çıktı boş.
- Ertesi sabah: `tail -5 /var/log/vetinity-yedek.log` (gece yedeği bozulmadı) ve log yedekleri 02:30
  civarında da kesintisiz mi (`ls /var/backups/vetinity/log/<gün>/`).

**RPO kurulumdan sonra ~15 dk** (yerel ve Drive aynı sıklıkta; sunucu tümden kaybolursa son Drive
kopyası). Kılavuz bölüm 7.2 ve 9.1 kurulumdan sonra güncellenir.

## 5. Belirli bir ana geri yükleme (point-in-time)

Karar: olay yöneticisi + ürün sahibi (kılavuz 9.4/5.4). İki veritabanı **aynı ana** döndürülür.
`STOPAT` sunucunun yerel saatiyle yorumlanır (`SELECT SYSDATETIMEOFFSET()` ile kontrol edin);
dosya adlarındaki zaman da yerel saattir.

1. Hedef an `T` belirlenir (ör. `2026-11-21T14:05:00`).
2. `T`'den önceki **son tam yedek** seçilir: `/var/backups/vetinity/gunluk/<gün>/<DB>_<TS>.bak`.
   Sunucu kaybında Drive'dan: `rclone copy gcrypt:gunluk/<gün> /var/opt/mssql/geri-yukle/`.
3. Log dosyaları: o tam yedeğin zamanından **sonra** alınmış `.trn`'ler, `T`'yi geçen **ilk** dosya dâhil
   (adına göre sıralı). Yerelde `/var/backups/vetinity/log/<gün>/`; Drive'dan gerekli her gün için
   `rclone copy gcrypt:log/<gün> /var/opt/mssql/geri-yukle/log/<gün>`. Sonra
   `chown -R mssql:mssql /var/opt/mssql/geri-yukle`.
4. Mümkünse (veritabanı hâlâ açılıyorsa) son ana kadar kaybı azaltmak için kuyruk yedeği:
   `BACKUP LOG [VetinityCommandDb] TO DISK = N'/var/opt/mssql/geri-yukle/VetinityCommandDb_kuyruk.trn' WITH NORECOVERY, CHECKSUM`
   (veritabanını geri yükleme durumuna alır; yalnız gerçek geri yüklemede).
5. `systemctl stop vetinity-api vetinity-site`
6. Her veritabanı için `sa` ile (prova için `[VetinityProva_<tarih>]` adı ve `WITH MOVE`; dosya adları
   `RESTORE FILELISTONLY` ile görülür):

   ```sql
   RESTORE DATABASE [VetinityCommandDb] FROM DISK = N'/var/opt/mssql/geri-yukle/VetinityCommandDb_<TS>.bak'
     WITH NORECOVERY, REPLACE, CHECKSUM;
   RESTORE LOG [VetinityCommandDb] FROM DISK = N'/var/opt/mssql/geri-yukle/log/<gün>/VetinityCommandDb_<zaman1>.trn'
     WITH NORECOVERY, CHECKSUM, STOPAT = '2026-11-21T14:05:00';
   -- ... sıradaki her .trn aynı STOPAT ile, T'yi geçen ilk dosyaya kadar
   RESTORE DATABASE [VetinityCommandDb] WITH RECOVERY;
   ```

   Her log dosyasına aynı `STOPAT` verilir: `T`'den önce biten dosyalar tümüyle uygulanır, `T`'yi
   içeren dosya o anda durur. "too early to apply" hatası tam yedekten önceki bir log seçildiğini gösterir.
7. `systemctl start vetinity-api vetinity-site`; `/health/ready`, giriş, örnek kayıtlar.
8. Geri yükleme klasörü silinir; olay kaydına `T` ve kullanılan dosyalar yazılır.

Bu sıra `restore-provasi.sql` ile yerelde sınandı (bölüm 7). Sunucuda aynı prova isteğe bağlı:
`SQLCMD=/opt/mssql-tools18/bin/sqlcmd SQLCMDPASSWORD=<sa> ./restore-provasi.sh @varsayilan -S 127.0.0.1,1433 -U sa -C`
(yalnız `VetinityLogProva_*` yaratır ve siler).

## 6. Geri alma

```bash
rm -f /etc/cron.d/vetinity-log-yedek /etc/cron.d/vetinity-uyari /etc/logrotate.d/vetinity-ops
```

Log yedeği durdurulup veritabanları FULL'de bırakılırsa LDF dosyaları sürekli büyür. Log yedeği
istenmiyorsa (zinciri bitirir; mevcut `.trn` dosyaları o ana kadar kullanılabilir kalır):

```sql
ALTER DATABASE [VetinityCommandDb] SET RECOVERY SIMPLE;
ALTER DATABASE [VetinityQueryDb] SET RECOVERY SIMPLE;
```

`/opt/vetinity/ops/`, `/var/lib/vetinity-uyari/` ve `/var/backups/vetinity/log/` istenirse silinir;
gece yedeği bunlardan etkilenmez.

## 7. Sınama durumu (2026-11-20, yerel)

- `bash -n`: tüm `.sh` dosyaları geçti. `shellcheck` makinede yok, çalıştırılmadı.
- `vetinity-uyari-sinama.sh`: 28 durum geçti, 0 kaldı (yeniden deneme, kısma, 60 dk yineleme, düzeldi,
  disk eşiği ve ops.env eşiği, gece yedeği yaşı/hata penceresi, log yedeği kurulu değil/eski/hatalı/SIMPLE,
  API ERR/5xx eşikleri ve sorgu dizesinin gövdeden atılması).
- `vetinity-log-yedek.sh`: sahte `sqlcmd`/`rclone`/`flock`/`pgrep` ile akış sınandı (SIMPLE ve zincirsiz
  atlama, doğrulama ve Drive hatasında çıkış kodu 1, veritabanı bulunamadı, kilit ve gece yedeği sürerken
  atlama, 14 günden eski klasör silme, ops.env eksik).
- Posta iletisi sahte `curl` ile kuruldu (UTF-8 konu, CRLF, çoklu alıcı, özel karakterli parola stdin'de).
- `restore-provasi.sh @varsayilan -S . -E -C` (SQL Server 2022 Developer): kaynak 100, son ana 100,
  STOPAT ile 60 kayıt (parti 1:10 2:20 3:30) — geçti; geçici veritabanı/dosya/msdb geçmişi kalmadı.

**Sınanmayanlar:** sunucuda gerçek `BACKUP LOG` yetkisi (`vetinity_app`), mssql'in `/var/backups/vetinity`
altına yazabilmesi (kurulum ön denetimi bakar), gerçek `rclone`/Drive kopyası, gerçek SMTP gönderimi
(`--posta-dene` ile sabah), gerçek journal biçimi, cron ortamı ve logrotate.
