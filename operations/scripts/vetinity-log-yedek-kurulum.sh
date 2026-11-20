#!/usr/bin/env bash
# Vetinity log yedeği ve canlı uyarı kurulumu (tek seferlik, tekrar çalıştırılabilir).
#   Kullanım: sudo ./vetinity-log-yedek-kurulum.sh            -> yalnız denetler ve planı yazar
#             sudo ./vetinity-log-yedek-kurulum.sh --uygula   -> planı uygular
# Yaptıkları (--uygula):
#   1. Betikleri /opt/vetinity/ops/ altına kopyalar (root, 700).
#   2. VetinityCommandDb ve VetinityQueryDb'yi FULL kurtarma modeline alır (FULL olanı geçer).
#   3. Log zinciri yoksa /opt/vetinity/yedek.sh ile hemen tam yedek alır (zincir başlar).
#   4. Log yedeğini bir kez elle çalıştırır, sonucu gösterir.
#   5. /etc/cron.d/vetinity-log-yedek, /etc/cron.d/vetinity-uyari ve logrotate dosyasını yazar.
#   6. Uyarı betiğini --deneme ile çalıştırır (posta göndermez).
# Gece tam yedeği (WITH INIT) aynen kalır: tam yedek log zincirini kırmaz.
# Başka uygulamaların veritabanına ve dosyalarına dokunmaz.
set -uo pipefail
umask 077

KAYNAK=$(dirname "$(readlink -f "$0")")
# shellcheck source=vetinity-ortak.sh
. "$KAYNAK/vetinity-ortak.sh"

HEDEF=/opt/vetinity/ops
UYARI_DURUM=/var/lib/vetinity-uyari
LOGROTATE=/etc/logrotate.d/vetinity-ops
BETIKLER=(vetinity-ortak.sh vetinity-log-yedek.sh vetinity-uyari.sh)

UYGULA=0
case "${1:-}" in
  --uygula) UYGULA=1 ;;
  "") ;;
  *) echo "kullanim: $0 [--uygula]" >&2; exit 2 ;;
esac

dur() { echo "DUR: $*" >&2; exit 1; }
bilgi() { echo "  - $*"; }

[[ $EUID -eq 0 ]] || dur "root olarak calistirin (sudo)"

echo "== On denetim"
eksik=0
for arac in "$SQLCMD" rclone flock curl pgrep runuser; do
  command -v "$arac" >/dev/null || { bilgi "EKSIK arac: $arac"; eksik=1; }
done
for b in "${BETIKLER[@]}"; do
  [[ -f $KAYNAK/$b ]] || { bilgi "EKSIK betik: $KAYNAK/$b"; eksik=1; }
done
[[ -x $GECE_YEDEK_BETIK ]] || { bilgi "EKSIK: $GECE_YEDEK_BETIK"; eksik=1; }
if [[ -f $OPS_ENV ]]; then
  izin=$(stat -c '%U %a' "$OPS_ENV")
  [[ $izin == "root 600" || $izin == "root 400" ]] || { bilgi "$OPS_ENV izni '$izin' (root 600 olmali)"; eksik=1; }
  for k in SQLCMDPASSWORD_APP SQLCMDPASSWORD_SA ALERT_TO; do
    [[ -n $(env_degeri "$OPS_ENV" "$k") ]] || { bilgi "$OPS_ENV: $k bos"; eksik=1; }
  done
else
  bilgi "EKSIK: $OPS_ENV (anahtarlar: SQLCMDPASSWORD_APP, SQLCMDPASSWORD_SA, ALERT_TO)"; eksik=1
fi
for k in Smtp__Host Smtp__Port Smtp__User Smtp__Pass Smtp__From; do
  [[ -n $(env_degeri "$API_ENV" "$k") ]] || { bilgi "$API_ENV: $k bos"; eksik=1; }
done
if rclone lsd "$DRIVE_UZAK:" >/dev/null 2>&1; then
  bilgi "rclone $DRIVE_UZAK: erisilebilir"
else
  bilgi "rclone $DRIVE_UZAK: erisilemedi"; eksik=1
fi
if runuser -u mssql -- test -x "$(dirname "$LOG_YEDEK_KOK")"; then
  bilgi "mssql $(dirname "$LOG_YEDEK_KOK") klasorune girebiliyor"
else
  bilgi "mssql $(dirname "$LOG_YEDEK_KOK") klasorune giremiyor (gece yedegi nasil yaziyor? kontrol edin)"; eksik=1
fi
[[ $eksik -eq 0 ]] || dur "on denetim basarisiz, once eksikleri giderin"

SA_PAROLA=$(ops_degeri SQLCMDPASSWORD_SA) || exit 1
db_listesi=$(printf "N'%s'," "${VETINITY_DBLER[@]}")

db_durumu() {
  sql_calistir "$SQL_SA_KULLANICI" "$SA_PAROLA" "
SELECT d.name COLLATE DATABASE_DEFAULT + '|' + d.recovery_model_desc COLLATE DATABASE_DEFAULT + '|' +
       CASE WHEN rs.last_log_backup_lsn IS NULL THEN '0' ELSE '1' END
FROM sys.databases d
JOIN sys.database_recovery_status rs ON rs.database_id = d.database_id
WHERE d.name IN (${db_listesi%,});"
}

durum=$(db_durumu) || dur "veritabani durumu okunamadi: $durum"
full_degil=()
zincirsiz=()
echo "== Veritabani durumu"
for db in "${VETINITY_DBLER[@]}"; do
  satir=$(grep -m1 "^${db}|" <<<"$durum") || dur "$db bulunamadi"
  IFS='|' read -r _ model zincir <<<"$satir"
  bilgi "$db: kurtarma modeli $model, log zinciri $([[ $zincir == 1 ]] && echo var || echo yok)"
  [[ $model == FULL ]] || full_degil+=("$db")
  [[ $model == FULL && $zincir == 1 ]] || zincirsiz+=("$db")
done

LOG_CRON_ICERIK="# Vetinity islem gunlugu yedegi (vetinity-log-yedek-kurulum.sh yazdi)
# Dakikalar gece yedeginin 02:30 baslangicina denk gelmesin diye kaydirildi.
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
7,22,37,52 * * * * root $HEDEF/vetinity-log-yedek.sh >> $LOG_YEDEK_LOG 2>&1"

UYARI_CRON_ICERIK="# Vetinity canli isletim uyarilari (vetinity-log-yedek-kurulum.sh yazdi)
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
*/5 * * * * root $HEDEF/vetinity-uyari.sh >> $UYARI_LOG 2>&1"

LOGROTATE_ICERIK="$LOG_YEDEK_LOG $UYARI_LOG {
    weekly
    rotate 8
    compress
    missingok
    notifempty
}"

echo "== Plan"
bilgi "betikleri kopyala: ${BETIKLER[*]} -> $HEDEF/ (root, 700)"
bilgi "klasorler: $LOG_YEDEK_KOK (root 711), $UYARI_DURUM (root 700)"
if [[ ${#full_degil[@]} -gt 0 ]]; then
  bilgi "FULL kurtarma modeline al: ${full_degil[*]}"
else
  bilgi "kurtarma modeli: degisiklik yok (ikisi de FULL)"
fi
if [[ ${#zincirsiz[@]} -gt 0 ]]; then
  bilgi "log zincirini baslatmak icin tam yedek: $GECE_YEDEK_BETIK (gunluk: $GECE_YEDEK_LOG)"
else
  bilgi "tam yedek: gerekmiyor (log zinciri var)"
fi
bilgi "log yedegini bir kez calistir: $HEDEF/vetinity-log-yedek.sh"
bilgi "cron yaz: $LOG_YEDEK_CRON (7,22,37,52 * * * *), $UYARI_CRON (*/5 * * * *)"
bilgi "logrotate yaz: $LOGROTATE"
bilgi "uyari betigini --deneme ile calistir (posta gondermez)"

if [[ $UYGULA -eq 0 ]]; then
  echo "Hicbir sey degistirilmedi. Uygulamak icin: $0 --uygula"
  exit 0
fi

echo "== Uygulaniyor"
install -d -m 755 -o root -g root "$HEDEF"
for b in "${BETIKLER[@]}"; do
  install -m 700 -o root -g root "$KAYNAK/$b" "$HEDEF/$b"
done
bilgi "betikler kopyalandi"
install -d -m 711 -o root -g root "$LOG_YEDEK_KOK"
install -d -m 700 -o root -g root "$UYARI_DURUM"
bilgi "klasorler hazir"

for db in "${full_degil[@]}"; do
  cikti=$(sql_calistir "$SQL_SA_KULLANICI" "$SA_PAROLA" "ALTER DATABASE [$db] SET RECOVERY FULL;") ||
    dur "$db FULL'e alinamadi: $cikti"
  bilgi "$db FULL kurtarma modeline alindi"
done

if [[ ${#zincirsiz[@]} -gt 0 ]]; then
  bilgi "tam yedek basliyor (birkac dakika surebilir)"
  # yedek.sh günlüğe kendisi yazıyorsa çıktı yeniden eklenmez (çift satır olmasın).
  if grep -q "$GECE_YEDEK_LOG" "$GECE_YEDEK_BETIK"; then
    flock "$YEDEK_KILIT" "$GECE_YEDEK_BETIK"
  else
    flock "$YEDEK_KILIT" "$GECE_YEDEK_BETIK" >>"$GECE_YEDEK_LOG" 2>&1
  fi
  kod=$?
  tail -5 "$GECE_YEDEK_LOG" | sed 's/^/    /'
  [[ $kod -eq 0 ]] || dur "tam yedek hata kodu $kod ile bitti; gunlugu inceleyin, cron kurulmadi"
  durum=$(db_durumu) || dur "veritabani durumu okunamadi: $durum"
  for db in "${VETINITY_DBLER[@]}"; do
    grep -q "^${db}|FULL|1$" <<<"$durum" || dur "$db icin log zinciri hala yok"
  done
  bilgi "log zinciri basladi"
fi

touch "$LOG_YEDEK_LOG"
chmod 640 "$LOG_YEDEK_LOG"
"$HEDEF/vetinity-log-yedek.sh" >>"$LOG_YEDEK_LOG" 2>&1
kod=$?
tail -8 "$LOG_YEDEK_LOG" | sed 's/^/    /'
[[ $kod -eq 0 ]] || dur "ilk log yedegi hata kodu $kod ile bitti; cron kurulmadi"
bilgi "ilk log yedegi alindi"

printf '%s\n' "$LOG_CRON_ICERIK" >"$LOG_YEDEK_CRON"
printf '%s\n' "$UYARI_CRON_ICERIK" >"$UYARI_CRON"
chmod 644 "$LOG_YEDEK_CRON" "$UYARI_CRON"
printf '%s\n' "$LOGROTATE_ICERIK" >"$LOGROTATE"
chmod 644 "$LOGROTATE"
bilgi "cron ve logrotate dosyalari yazildi"

echo "== Uyari denemesi (posta gonderilmez)"
"$HEDEF/vetinity-uyari.sh" --deneme
echo "Kurulum tamam. Ilk zamanlanmis log yedegi en gec 15 dk icinde: tail -f $LOG_YEDEK_LOG"
