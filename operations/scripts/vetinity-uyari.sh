#!/usr/bin/env bash
# Vetinity canlı işletim uyarıları — cron ile 5 dakikada bir.
# Denetimler (her biri ayrı uyarı türü):
#   saglik     /health/ready 200 değil (2 yeniden denemeden sonra)
#   disk       / doluluğu >= UYARI_DISK_ESIK (varsayılan %85)
#   gece-yedek son "INFO: bitti" 26 saatten eski veya son koşuda ERROR
#   log-yedek  (log yedeği kuruluysa) en yeni .trn 35 dakikadan eski veya son koşuda ERROR
#   api-hata   son 5 dakikada ERR/FTL >= UYARI_ERR_ESIK (5) veya 5xx >= UYARI_5XX_ESIK (3)
# Her tür için bir posta; sorun sürdükçe en çok 60 dakikada bir yinelenir, düzelince
# "DÜZELDİ" postası gider. Durum dosyaları /var/lib/vetinity-uyari/ altında.
# Posta: api.env'deki Smtp__* ayarlarıyla curl SMTP (TLS zorunlu); alıcı ops.env ALERT_TO.
#   --deneme  gerçek denetimler; posta yerine ekrana yazar, durum dosyalarına dokunmaz
#   --posta-dene  yalnız bir deneme postası gönderir (SMTP ayarlarını sınamak için)
#   --test    girdiler ortam değişkenlerinden (vetinity-uyari-sinama.sh kullanır)
set -uo pipefail
umask 077

BETIK_DIZINI=$(dirname "$(readlink -f "$0")")
# shellcheck source=vetinity-ortak.sh
. "$BETIK_DIZINI/vetinity-ortak.sh"

MOD=normal
case "${1:-}" in
  --deneme) MOD=deneme ;;
  --test) MOD=test ;;
  --posta-dene) MOD=posta-dene ;;
  "") ;;
  *) echo "kullanim: $0 [--deneme|--posta-dene]" >&2; exit 2 ;;
esac

DURUM_DIZIN=/var/lib/vetinity-uyari
SAGLIK_URL=http://127.0.0.1:5100/health/ready
SAGLIK_BEKLE=10
YINELEME_SN=3600
GECE_YEDEK_EN_COK_SN=$((26 * 3600))
LOG_YEDEK_EN_COK_SN=$((35 * 60))
SIMDI=$(date +%s)

if [[ $MOD == test ]]; then
  DURUM_DIZIN=${UYARI_DURUM_DIZIN:?test modunda UYARI_DURUM_DIZIN gerekli}
  SIMDI=${TEST_SIMDI:-$SIMDI}
  SAGLIK_BEKLE=0
else
  exec 8>/run/lock/vetinity-uyari.lock
  flock -n 8 || exit 0
  [[ $MOD == normal ]] && install -d -m 700 "$DURUM_DIZIN"
fi

# esik ANAHTAR VARSAYILAN -> ops.env'de sayı verilmişse o, yoksa varsayılan
esik() {
  local v
  v=$(env_degeri "$OPS_ENV" "$1") || v=""
  [[ $v =~ ^[0-9]+$ ]] && echo "$v" || echo "$2"
}
DISK_ESIK=$(esik UYARI_DISK_ESIK 85)
ERR_ESIK=$(esik UYARI_ERR_ESIK 5)
X5_ESIK=$(esik UYARI_5XX_ESIK 3)

# Postada görünen sunucu adı ve SMTP EHLO adı sistem hostname'inden gelmez (sunucu başka bir uygulamayla ortak, onun
# adını taşır): ops.env'deki değer, yoksa varsayılan. curl, URL'de yol verilmezse EHLO'da makinenin adını gönderir.
SUNUCU_ETIKETI=$(env_degeri "$OPS_ENV" SUNUCU_ETIKETI) || SUNUCU_ETIKETI=""
SUNUCU_ETIKETI=${SUNUCU_ETIKETI:-Vetinity canlı}
EHLO_ADI=$(env_degeri "$OPS_ENV" SMTP_EHLO_ADI) || EHLO_ADI=""
EHLO_ADI=${EHLO_ADI:-vetinity.com}

# --- Girdi kaynakları (test modunda ortam değişkenlerinden) ---

# saglik_kodu DENEME_NO
saglik_kodu() {
  if [[ $MOD == test ]]; then
    local kodlar
    read -ra kodlar <<<"${TEST_SAGLIK_KODLARI:-200}"
    local i=$(($1 - 1))
    [[ $i -lt ${#kodlar[@]} ]] || i=$((${#kodlar[@]} - 1))
    echo "${kodlar[$i]}"
  else
    curl -s -o /dev/null -w '%{http_code}' --max-time 10 "$SAGLIK_URL" || true
  fi
}

disk_yuzde() {
  if [[ $MOD == test ]]; then
    echo "${TEST_DISK_YUZDE:-10}"
  else
    df -P / | awk 'NR==2 { sub("%", "", $5); print $5 }'
  fi
}

api_gunlugu() {
  if [[ $MOD == test ]]; then
    cat "${TEST_JOURNAL:-/dev/null}"
  else
    journalctl -u vetinity-api --since "$(date -d '-5 min' '+%F %T')" --no-pager -o cat
  fi
}

# --- Denetimler: sorun varsa SORUN (tek satır) ve DETAY (gövde) doldurulur ---

SORUN=""
DETAY=""

kontrol_saglik() {
  local i kod
  for i in 1 2 3; do
    kod=$(saglik_kodu "$i")
    [[ $kod == 200 ]] && return
    [[ $i -lt 3 ]] && sleep "$SAGLIK_BEKLE"
  done
  SORUN="/health/ready $kod dondu (3 deneme)"
  DETAY="Bakin: curl -s $SAGLIK_URL ; systemctl status vetinity-api ; journalctl -u vetinity-api -n 200"
}

kontrol_disk() {
  local y
  y=$(disk_yuzde)
  if [[ $y =~ ^[0-9]+$ ]] && ((y >= DISK_ESIK)); then
    SORUN="/ diski %$y dolu (esik %$DISK_ESIK)"
    DETAY="Bakin: df -h / ; du -sh /var/backups/vetinity/* /var/log/journal
Yalniz Vetinity dosyalarina dokunun."
  elif ! [[ $y =~ ^[0-9]+$ ]]; then
    SORUN="disk dolulugu okunamadi"
  fi
}

# Son başarılı bitişin yaşı ve son koşunun hataları. Son koşu = son "INFO: bitti"den
# önceki 2 saat + o satırdan sonrası (başlangıç satırının metnine bağlı kalmamak için).
kontrol_gece_yedek() {
  local log=$GECE_YEDEK_LOG son_no son_ts ts no satir hatalar=""
  if [[ ! -r $log ]]; then
    SORUN="gece yedegi gunlugu okunamadi: $log"
    return
  fi
  son_no=$(grep -nE ' INFO: bitti$' "$log" | tail -1 | cut -d: -f1)
  if [[ -z $son_no ]]; then
    SORUN="gece yedeginde hic 'INFO: bitti' yok"
    DETAY="Bakin: tail -30 $log"
    return
  fi
  son_ts=$(date -d "$(sed -n "${son_no}p" "$log" | cut -d' ' -f1)" +%s 2>/dev/null) || son_ts=0
  while IFS= read -r satir; do
    no=${satir%%:*}
    satir=${satir#*:}
    if ((no > son_no)); then
      hatalar+="$satir"$'\n'
    else
      ts=$(date -d "${satir%% *}" +%s 2>/dev/null) || ts=0
      ((ts >= son_ts - 7200)) && hatalar+="$satir"$'\n'
    fi
  done < <(grep -nE ' ERROR: ' "$log" | tail -50)

  if ((SIMDI - son_ts > GECE_YEDEK_EN_COK_SN)); then
    SORUN="son basarili gece yedegi $(((SIMDI - son_ts) / 3600)) saat once"
  elif [[ -n $hatalar ]]; then
    SORUN="gece yedeginin son kosusunda ERROR var"
  else
    return
  fi
  DETAY="${hatalar}Bakin: tail -30 $log ; gerekirse $GECE_YEDEK_BETIK elle (kilavuz 9.3)"
}

kontrol_log_yedek() {
  [[ -f $LOG_YEDEK_CRON ]] || return
  local en_yeni yas blok
  en_yeni=$(find "$LOG_YEDEK_KOK" -type f -name '*.trn' -printf '%T@\n' 2>/dev/null | sort -n | tail -1)
  en_yeni=${en_yeni%.*}
  if [[ -r $LOG_YEDEK_LOG ]]; then
    blok=$(awk '/ INFO: basladi$/ { b = "" } { b = b $0 "\n" } END { printf "%s", b }' "$LOG_YEDEK_LOG" | tail -15)
  fi
  if [[ -z $en_yeni ]]; then
    SORUN="hic log yedegi dosyasi yok"
  elif ((SIMDI - en_yeni > LOG_YEDEK_EN_COK_SN)); then
    yas=$(((SIMDI - en_yeni) / 60))
    SORUN="son log yedegi $yas dk once"
  elif grep -q ' ERROR: ' <<<"${blok:-}"; then
    SORUN="log yedeginin son kosusunda ERROR var"
  else
    return
  fi
  DETAY="Son kosu:
${blok:-(gunluk yok)}
Bakin: tail -30 $LOG_YEDEK_LOG ; veritabanlari FULL mi? Log yedegi durursa LDF dosyalari buyur."
}

kontrol_api_hata() {
  local metin err x5
  metin=$(api_gunlugu)
  err=$(grep -cE '\[[0-9]{2}:[0-9]{2}:[0-9]{2} (ERR|FTL)\]' <<<"$metin")
  x5=$(grep -cE 'responded 5[0-9]{2} ' <<<"$metin")
  if ((err >= ERR_ESIK || x5 >= X5_ESIK)); then
    SORUN="son 5 dk: $err ERR/FTL, $x5 adet 5xx yanit"
    # Kişisel veri taşımasın diye yalnız yol (sorgu dizesi atılır) ve kısaltılmış hata başı.
    DETAY="5xx istekleri:
$(grep -oE 'HTTP [A-Z]+ [^ ?]+[^ ]* responded 5[0-9]{2}' <<<"$metin" | sed -E 's/\?[^ ]*//' | tail -5)
Hata satirlari (ilk 120 karakter):
$(grep -E '\[[0-9]{2}:[0-9]{2}:[0-9]{2} (ERR|FTL)\]' <<<"$metin" | tail -3 | cut -c1-120)
Bakin: journalctl -u vetinity-api --since -15min -p err ; traceId ile arayin."
  fi
}

# --- Posta ---

curl_kacis() {
  local s=${1//\\/\\\\}
  printf '%s' "${s//\"/\\\"}"
}

# posta_gonder KONU GOVDE
posta_gonder() {
  local konu=$1 govde=$2 host port user pass from ssl starttls url adres alici a dosya kod
  local -a alicilar rcpt=()
  alici=$(ops_degeri ALERT_TO) || return 1
  host=$(env_degeri "$API_ENV" Smtp__Host) || host=""
  port=$(env_degeri "$API_ENV" Smtp__Port) || port=""
  user=$(env_degeri "$API_ENV" Smtp__User) || user=""
  pass=$(env_degeri "$API_ENV" Smtp__Pass) || pass=""
  from=$(env_degeri "$API_ENV" Smtp__From) || from=""
  ssl=$(env_degeri "$API_ENV" Smtp__EnableSsl) || ssl=""
  starttls=$(env_degeri "$API_ENV" Smtp__UseStartTls) || starttls=""
  if [[ -z $host || -z $port || -z $from ]]; then
    gunluk ERROR "Smtp__Host/Port/From eksik, posta gonderilemedi"
    return 1
  fi
  if [[ ${starttls,,} == true ]]; then
    url="smtp://$host:$port/$EHLO_ADI"
  elif [[ ${ssl,,} == true ]]; then
    url="smtps://$host:$port/$EHLO_ADI"
  else
    gunluk ERROR "SMTP sifreli degil (EnableSsl/UseStartTls false), posta gonderilmedi"
    return 1
  fi
  adres=$from
  if [[ $from == *"<"*">"* ]]; then
    adres=${from##*<}
    adres=${adres%%>*}
  fi
  IFS=, read -ra alicilar <<<"$alici"
  for a in "${alicilar[@]}"; do
    a=${a//[[:space:]]/}
    [[ -n $a ]] && rcpt+=(--mail-rcpt "$a")
  done

  dosya=$(mktemp)
  {
    printf 'From: %s\r\n' "$from"
    printf 'To: %s\r\n' "$alici"
    printf 'Subject: =?UTF-8?B?%s?=\r\n' "$(printf '%s' "$konu" | base64 -w0)"
    printf 'Date: %s\r\n' "$(date -R)"
    printf 'MIME-Version: 1.0\r\nContent-Type: text/plain; charset=UTF-8\r\nContent-Transfer-Encoding: 8bit\r\n\r\n'
    printf '%s\n' "$govde" | sed 's/$/\r/'
  } >"$dosya"
  # Kullanıcı/parola argümanda değil, stdin'den curl yapılandırmasıyla geçer (ps'te görünmez).
  {
    [[ -n $user ]] && printf 'user = "%s"\n' "$(curl_kacis "$user:$pass")"
  } | curl --silent --show-error --ssl-reqd --max-time 30 --url "$url" \
    --mail-from "$adres" "${rcpt[@]}" --upload-file "$dosya" -K -
  kod=$?
  rm -f -- "$dosya"
  return "$kod"
}

# --- Durum ve kısma ---

posta_hatasi=0

# bildir TUR KONU GOVDE
bildir() {
  if [[ $MOD == normal ]]; then
    if posta_gonder "$2" "$3"; then
      gunluk INFO "posta gonderildi ($1): $2"
    else
      gunluk ERROR "posta gonderilemedi ($1): $2"
      posta_hatasi=1
      return 1
    fi
  else
    printf 'POSTA: %s\n%s\n' "$2" "$(sed 's/^/    /' <<<"$3")"
  fi
}

# isle TUR BASLIK -> SORUN/DETAY'a göre uyar, kıs ya da düzeldi bildir
isle() {
  local tur=$1 baslik=$2 dosya=$DURUM_DIZIN/$1 son=""
  [[ -f $dosya ]] && son=$(head -1 "$dosya")
  if [[ -n $SORUN ]]; then
    if [[ -z $son ]] || ((SIMDI - son >= YINELEME_SN)); then
      local ek=""
      [[ -n $son ]] && ek=" (suruyor)"
      if bildir "$tur" "[Vetinity UYARI] $baslik$ek: $SORUN" \
        "Sunucu: $SUNUCU_ETIKETI
Zaman: $(date -d "@$SIMDI" -Iseconds)
Sorun: $SORUN

$DETAY"; then
        [[ $MOD == deneme ]] || echo "$SIMDI" >"$dosya"
      fi
    elif [[ $MOD != normal ]]; then
      echo "KISILDI: $tur ($(((SIMDI - son) / 60)) dk once bildirildi)"
    fi
  elif [[ -n $son ]]; then
    if bildir "$tur" "[Vetinity DÜZELDİ] $baslik" \
      "Sunucu: $SUNUCU_ETIKETI
Zaman: $(date -d "@$SIMDI" -Iseconds)
$baslik denetimi yeniden normal."; then
      [[ $MOD == deneme ]] || rm -f -- "$dosya"
    fi
  fi
  SORUN=""
  DETAY=""
}

if [[ $MOD == posta-dene ]]; then
  if posta_gonder "[Vetinity] Uyari postasi denemesi" "Sunucu: $SUNUCU_ETIKETI
Zaman: $(date -Iseconds)
Bu posta vetinity-uyari.sh --posta-dene ile gonderildi; SMTP ayarlari calisiyor."; then
    echo "deneme postasi gonderildi"
    exit 0
  fi
  echo "deneme postasi gonderilemedi" >&2
  exit 1
fi

kontrol_saglik;     isle saglik "API saglik"
kontrol_disk;       isle disk "Disk"
kontrol_gece_yedek; isle gece-yedek "Gece yedegi"
kontrol_log_yedek;  isle log-yedek "Log yedegi"
kontrol_api_hata;   isle api-hata "API hatalari"

exit "$posta_hatasi"
