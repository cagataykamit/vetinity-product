# shellcheck shell=bash
# Vetinity işletim betiklerinin ortak parçası (source edilir, tek başına çalışmaz).
# Yalnız Vetinity veritabanlarına ve Vetinity yollarına dokunur; aynı sunucudaki
# başka uygulamaların (zonguldakminikpatiler) veritabanı ve dosyaları kapsam dışıdır.

VETINITY_DBLER=(VetinityCommandDb VetinityQueryDb)

SQLCMD=${SQLCMD:-/opt/mssql-tools18/bin/sqlcmd}
SQL_SUNUCU=${SQL_SUNUCU:-127.0.0.1,1433}
SQL_APP_KULLANICI=vetinity_app
SQL_SA_KULLANICI=sa

OPS_ENV=${OPS_ENV:-/etc/vetinity/production/ops.env}
API_ENV=${API_ENV:-/etc/vetinity/production/api.env}

# Yollar yerel sınama için ortam değişkeniyle değiştirilebilir; sunucuda varsayılanlar kullanılır.
GECE_YEDEK_BETIK=/opt/vetinity/yedek.sh
GECE_YEDEK_LOG=${GECE_YEDEK_LOG:-/var/log/vetinity-yedek.log}
LOG_YEDEK_KOK=${LOG_YEDEK_KOK:-/var/backups/vetinity/log}
LOG_YEDEK_LOG=${LOG_YEDEK_LOG:-/var/log/vetinity-log-yedek.log}
LOG_YEDEK_CRON=${LOG_YEDEK_CRON:-/etc/cron.d/vetinity-log-yedek}
UYARI_CRON=/etc/cron.d/vetinity-uyari
UYARI_LOG=/var/log/vetinity-uyari.log
YEDEK_KILIT=${YEDEK_KILIT:-/run/lock/vetinity-yedek.lock}
DRIVE_UZAK=${DRIVE_UZAK:-gcrypt}

# gunluk SEVIYE MESAJ  ->  "<iso> SEVIYE: MESAJ" (gece yedeğiyle aynı biçim)
gunluk() {
  printf '%s %s: %s\n' "$(date -Iseconds)" "$1" "$2"
}

# env_degeri DOSYA ANAHTAR -> değeri stdout'a yazar; anahtar yoksa 1 döner.
# KEY=VALUE satırlarını kabuk genişletmesi yapmadan okur (değerde $ " ' \ olabilir);
# baştaki "export " ve değeri saran tek/çift tırnak atılır (systemd EnvironmentFile gibi).
env_degeri() {
  local dosya=$1 anahtar=$2 satir deger
  [[ -r $dosya ]] || return 1
  satir=$(grep -m1 -E "^[[:space:]]*(export[[:space:]]+)?${anahtar}=" "$dosya") || return 1
  deger=${satir#*=}
  deger=${deger%$'\r'}
  if [[ ${#deger} -ge 2 ]]; then
    if [[ $deger == \"*\" || $deger == \'*\' ]]; then
      deger=${deger:1:${#deger}-2}
    fi
  fi
  printf '%s' "$deger"
}

# sql_calistir KULLANICI PAROLA SORGU -> başlıksız, boşlukları kırpılmış çıktı.
# Parola argüman olarak değil SQLCMDPASSWORD ortam değişkeniyle geçer (ps'te görünmez).
sql_calistir() {
  SQLCMDPASSWORD=$2 "$SQLCMD" -S "$SQL_SUNUCU" -U "$1" -C -b -h -1 -W -Q "SET NOCOUNT ON; $3"
}

# ops.env'den zorunlu anahtarı okur; boşsa hata yazar ve 1 döner.
ops_degeri() {
  local deger
  deger=$(env_degeri "$OPS_ENV" "$1") || deger=""
  if [[ -z $deger ]]; then
    gunluk ERROR "$OPS_ENV icinde $1 yok veya bos" >&2
    return 1
  fi
  printf '%s' "$deger"
}
