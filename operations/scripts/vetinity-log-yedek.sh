#!/usr/bin/env bash
# Vetinity işlem günlüğü (transaction log) yedeği — cron ile 15 dakikada bir.
#   /var/backups/vetinity/log/<YYYY-AA-GG>/<DB>_<zaman>.trn  (COMPRESSION, CHECKSUM)
#   RESTORE VERIFYONLY (sa) -> rclone copy gcrypt:log/<gün> -> cryptcheck
# Yerelde 14 gün, Drive'da 30 gün saklanır. Yalnız VetinityCommandDb ve VetinityQueryDb.
# Veritabanı FULL kurtarma modelinde değilse veya FULL'e geçtikten sonra tam yedek
# alınmadıysa (log zinciri yok) o veritabanı atlanır ve günlüğe yazılır.
# Çıktı cron satırında /var/log/vetinity-log-yedek.log'a eklenir. Hata varsa çıkış kodu 1.
set -uo pipefail
umask 077

BETIK_DIZINI=$(dirname "$(readlink -f "$0")")
# shellcheck source=vetinity-ortak.sh
. "$BETIK_DIZINI/vetinity-ortak.sh"

YEREL_GUN=14
DRIVE_GUN=30

# Kendi koşularıyla ve elle/kurulumla başlatılan tam yedekle çakışmasın.
exec 9>"$YEDEK_KILIT"
if ! flock -n 9; then
  gunluk INFO "baska bir yedek kosusu suruyor, log yedegi atlandi"
  exit 0
fi
# Gece cron'u yedek.sh'ı kilitsiz çalıştırır; sürüyorsa bu koşu atlanır.
if pgrep -f "^([^ ]*/)?(ba)?sh ${GECE_YEDEK_BETIK}( |$)|^${GECE_YEDEK_BETIK}( |$)" >/dev/null; then
  gunluk INFO "gece tam yedegi suruyor, log yedegi atlandi"
  exit 0
fi

APP_PAROLA=$(ops_degeri SQLCMDPASSWORD_APP) || exit 1
SA_PAROLA=$(ops_degeri SQLCMDPASSWORD_SA) || exit 1

GUN=$(date +%F)
DUN=$(date -d yesterday +%F)
ZAMAN=$(date +%Y%m%d_%H%M%S)
DIZIN=$LOG_YEDEK_KOK/$GUN
hata=0

gunluk INFO "basladi"

# Kurtarma modeli ve log zinciri: last_log_backup_lsn NULL ise FULL'e geçtikten sonra
# tam yedek alınmamıştır; BACKUP LOG hata verir, zincir başlatılmalıdır.
db_listesi=$(printf "N'%s'," "${VETINITY_DBLER[@]}")
durum=$(sql_calistir "$SQL_SA_KULLANICI" "$SA_PAROLA" "
SELECT d.name + '|' + d.recovery_model_desc + '|' +
       CASE WHEN rs.last_log_backup_lsn IS NULL THEN '0' ELSE '1' END
FROM sys.databases d
JOIN sys.database_recovery_status rs ON rs.database_id = d.database_id
WHERE d.name IN (${db_listesi%,});") || {
  gunluk ERROR "veritabani durumu okunamadi: $durum"
  exit 1
}

alinacak=()
for db in "${VETINITY_DBLER[@]}"; do
  satir=$(grep -m1 "^${db}|" <<<"$durum") || {
    gunluk ERROR "$db bulunamadi"
    hata=1
    continue
  }
  IFS='|' read -r _ model zincir <<<"$satir"
  if [[ $model != FULL ]]; then
    gunluk INFO "$db kurtarma modeli $model (FULL degil), log yedegi atlandi"
  elif [[ $zincir != 1 ]]; then
    gunluk INFO "$db FULL ama sonrasinda tam yedek yok (log zinciri baslamadi), log yedegi atlandi"
  else
    alinacak+=("$db")
  fi
done

if [[ ${#alinacak[@]} -gt 0 ]]; then
  install -d -m 711 -o root -g root "$LOG_YEDEK_KOK"
  mkdir -p "$DIZIN"
  # SQL Server (mssql) dosyayı yazabilsin; yedekten sonra yeniden yalnız root.
  chown mssql:root "$DIZIN" && chmod 770 "$DIZIN"

  for db in "${alinacak[@]}"; do
    dosya=$DIZIN/${db}_${ZAMAN}.trn
    if ! cikti=$(sql_calistir "$SQL_APP_KULLANICI" "$APP_PAROLA" \
      "BACKUP LOG [$db] TO DISK = N'$dosya' WITH INIT, COMPRESSION, CHECKSUM, NAME = N'$db log $ZAMAN';"); then
      gunluk ERROR "$db log yedegi alinamadi: $cikti"
      rm -f -- "$dosya"
      hata=1
      continue
    fi
    if ! cikti=$(sql_calistir "$SQL_SA_KULLANICI" "$SA_PAROLA" \
      "RESTORE VERIFYONLY FROM DISK = N'$dosya' WITH CHECKSUM;"); then
      gunluk ERROR "$db log yedegi dogrulanamadi: $cikti"
      hata=1
      continue
    fi
    gunluk INFO "$db log yedegi alindi ve dogrulandi: $(basename "$dosya") ($(du -h "$dosya" | cut -f1))"
  done

  chown -R root:root "$DIZIN"
  chmod 700 "$DIZIN"
  find "$DIZIN" -type f -exec chmod 600 {} +

  # Dünün klasörü de kopyalanır: gece yarısından önceki son koşunun Drive kopyası
  # başarısız olduysa o dosyalar da gönderilmiş olur (rclone var olanı atlar).
  for gun in "$DUN" "$GUN"; do
    [[ -d $LOG_YEDEK_KOK/$gun ]] || continue
    if rclone copy "$LOG_YEDEK_KOK/$gun" "$DRIVE_UZAK:log/$gun" &&
       rclone cryptcheck "$LOG_YEDEK_KOK/$gun" "$DRIVE_UZAK:log/$gun" --one-way; then
      gunluk INFO "Drive kopyasi dogrulandi: log/$gun"
    else
      gunluk ERROR "Drive kopyasi basarisiz: log/$gun"
      hata=1
    fi
  done
else
  gunluk INFO "log yedegi alinacak veritabani yok"
fi

# Yerel saklama: adı 14 günden eski gün klasörleri silinir (yalnız log yedek kökü altında).
sinir=$(date -d "-$YEREL_GUN days" +%F)
for d in "$LOG_YEDEK_KOK"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]; do
  [[ -d $d ]] || continue
  if [[ $(basename "$d") < "$sinir" ]]; then
    rm -rf -- "$d" && gunluk INFO "yerel eski log yedegi silindi: $(basename "$d")"
  fi
done

# Drive saklama: günde bir kez (03:00–03:14 arasındaki koşu).
if [[ $(date +%H) == 03 && 10#$(date +%M) -lt 15 ]]; then
  if rclone delete "$DRIVE_UZAK:log" --min-age "${DRIVE_GUN}d"; then
    gunluk INFO "Drive'da ${DRIVE_GUN} gunden eski log yedekleri silindi"
  else
    gunluk ERROR "Drive eski log yedekleri silinemedi"
    hata=1
  fi
fi

if [[ $hata -eq 0 ]]; then
  gunluk INFO "bitti"
else
  gunluk ERROR "hatalarla bitti"
fi
exit "$hata"
