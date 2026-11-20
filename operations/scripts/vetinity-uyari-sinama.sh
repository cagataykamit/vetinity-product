#!/usr/bin/env bash
# vetinity-uyari.sh karar mantığının sınaması: sahte günlük, sahte journal metni,
# sahte disk yüzdesi ve sağlık kodlarıyla --test modunda çalıştırır. Sunucuya,
# veritabanına ve postaya dokunmaz; yalnız geçici klasör kullanır.
#   Kullanım: bash vetinity-uyari-sinama.sh
set -uo pipefail

BETIK=$(dirname "$(readlink -f "$0")")/vetinity-uyari.sh
GECICI=$(mktemp -d)
trap 'rm -rf -- "$GECICI"' EXIT

gecen=0
kalan=0
CIKTI=""

sifirla() {
  rm -rf -- "${GECICI:?}"/*
  mkdir -p "$GECICI/durum" "$GECICI/log"
  export UYARI_DURUM_DIZIN=$GECICI/durum
  export OPS_ENV=$GECICI/ops.env
  export API_ENV=$GECICI/api.env
  export GECE_YEDEK_LOG=$GECICI/vetinity-yedek.log
  export LOG_YEDEK_KOK=$GECICI/log
  export LOG_YEDEK_LOG=$GECICI/vetinity-log-yedek.log
  export LOG_YEDEK_CRON=$GECICI/cron-vetinity-log-yedek
  export TEST_JOURNAL=$GECICI/journal.txt
  export TEST_SAGLIK_KODLARI=200 TEST_DISK_YUZDE=19
  unset TEST_SIMDI
  printf 'ALERT_TO=ops@example.invalid\n' >"$OPS_ENV"
  : >"$TEST_JOURNAL"
  printf '%s INFO: basladi\n%s INFO: bitti\n' "$(date -d '-1 hour -5 min' -Iseconds)" "$(date -d '-1 hour' -Iseconds)" >"$GECE_YEDEK_LOG"
}

calistir() { CIKTI=$(bash "$BETIK" --test 2>&1); }

# bekle AD DESEN  /  bekleme AD DESEN  (çıktıda desen olmalı / olmamalı)
bekle() {
  if grep -qE -- "$2" <<<"$CIKTI"; then
    echo "GECTI  $1"; gecen=$((gecen + 1))
  else
    echo "KALDI  $1"; echo "$CIKTI" | sed 's/^/       | /'; kalan=$((kalan + 1))
  fi
}
bekleme() {
  if grep -qE -- "$2" <<<"$CIKTI"; then
    echo "KALDI  $1"; echo "$CIKTI" | sed 's/^/       | /'; kalan=$((kalan + 1))
  else
    echo "GECTI  $1"; gecen=$((gecen + 1))
  fi
}

echo "== Hepsi normal"
sifirla; calistir
bekleme "sorun yokken posta yok" 'POSTA'

echo "== Saglik"
sifirla; TEST_SAGLIK_KODLARI="503 200"; calistir
bekleme "ilk deneme 503, yeniden denemede 200 -> uyari yok" 'POSTA'
TEST_SAGLIK_KODLARI="503 000 503"; calistir
bekle "3 deneme de basarisiz -> uyari" 'POSTA: \[Vetinity UYARI\] API saglik: /health/ready 503'
calistir
bekle "hemen tekrar -> kisildi" 'KISILDI: saglik'
bekleme "hemen tekrar -> posta yok" 'POSTA'
TEST_SIMDI=$(($(date +%s) + 3601)); export TEST_SIMDI; calistir
bekle "60 dk sonra -> yinelenir (suruyor)" 'UYARI\] API saglik \(suruyor\)'
TEST_SAGLIK_KODLARI=200; calistir
bekle "duzelince -> DUZELDI postasi" 'POSTA: \[Vetinity DÜZELDİ\] API saglik'
calistir
bekleme "duzeldikten sonra -> posta yok" 'POSTA'

echo "== Disk"
sifirla; TEST_DISK_YUZDE=84; calistir
bekleme "%84 -> uyari yok" 'POSTA'
TEST_DISK_YUZDE=85; calistir
bekle "%85 -> uyari" 'UYARI\] Disk: / diski %85 dolu'
sifirla; printf 'UYARI_DISK_ESIK=90\n' >>"$OPS_ENV"; TEST_DISK_YUZDE=85; calistir
bekleme "ops.env esigi 90 iken %85 -> uyari yok" 'POSTA'

echo "== Gece yedegi"
sifirla
printf '%s INFO: basladi\n%s INFO: bitti\n' "$(date -d '-27 hour -5 min' -Iseconds)" "$(date -d '-27 hour' -Iseconds)" >"$GECE_YEDEK_LOG"
calistir
bekle "son bitti 27 saat once -> uyari" 'Gece yedegi: son basarili gece yedegi 27 saat once'
sifirla
{
  printf '%s INFO: bitti\n' "$(date -d '-25 hour' -Iseconds)"
  printf '%s ERROR: Drive kopyasi basarisiz\n' "$(date -d '-9 hour' -Iseconds)"
  printf '%s INFO: basladi\n%s INFO: bitti\n' "$(date -d '-1 hour -5 min' -Iseconds)" "$(date -d '-1 hour' -Iseconds)"
} >"$GECE_YEDEK_LOG"
calistir
bekleme "eski basarisiz kosu, sonra basarili elle kosu -> uyari yok" 'POSTA'
sifirla
{
  printf '%s INFO: basladi\n' "$(date -d '-1 hour -10 min' -Iseconds)"
  printf '%s ERROR: Drive kopyasi basarisiz\n' "$(date -d '-1 hour -2 min' -Iseconds)"
  printf '%s INFO: bitti\n' "$(date -d '-1 hour' -Iseconds)"
} >"$GECE_YEDEK_LOG"
calistir
bekle "son kosuda ERROR, sonra bitti -> uyari" 'Gece yedegi: gece yedeginin son kosusunda ERROR'
sifirla
printf '%s ERROR: VetinityCommandDb yedegi alinamadi\n' "$(date -d '-5 min' -Iseconds)" >>"$GECE_YEDEK_LOG"
calistir
bekle "son bitti'den sonra ERROR (yarim kalan kosu) -> uyari" 'son kosusunda ERROR'
bekle "uyari govdesinde hata satiri" 'yedegi alinamadi'
sifirla; : >"$GECE_YEDEK_LOG"; calistir
bekle "hic bitti yok -> uyari" "hic 'INFO: bitti' yok"

echo "== Log yedegi"
sifirla; calistir
bekleme "kurulu degil (cron yok) -> denetlenmez" 'Log yedegi'
sifirla; : >"$LOG_YEDEK_CRON"; calistir
bekle "kurulu ama hic dosya yok -> uyari" 'Log yedegi: hic log yedegi dosyasi yok'
sifirla; : >"$LOG_YEDEK_CRON"; mkdir -p "$LOG_YEDEK_KOK/2026-11-20"
touch -d '-10 min' "$LOG_YEDEK_KOK/2026-11-20/VetinityCommandDb_x.trn"
printf '%s INFO: basladi\n%s ERROR: Drive kopyasi basarisiz: log/2026-11-20\n%s ERROR: hatalarla bitti\n%s INFO: basladi\n%s INFO: bitti\n' \
  "$(date -d '-25 min' -Iseconds)" "$(date -d '-24 min' -Iseconds)" "$(date -d '-24 min' -Iseconds)" \
  "$(date -d '-10 min' -Iseconds)" "$(date -d '-9 min' -Iseconds)" >"$LOG_YEDEK_LOG"
calistir
bekleme "dosya 10 dk, onceki kosu hatali ama son kosu temiz -> uyari yok" 'POSTA'
touch -d '-40 min' "$LOG_YEDEK_KOK/2026-11-20/VetinityCommandDb_x.trn"; calistir
bekle "en yeni dosya 40 dk -> uyari" 'Log yedegi: son log yedegi 40 dk once'
sifirla; : >"$LOG_YEDEK_CRON"; mkdir -p "$LOG_YEDEK_KOK/2026-11-20"
touch -d '-3 min' "$LOG_YEDEK_KOK/2026-11-20/VetinityQueryDb_x.trn"
printf '%s INFO: basladi\n%s ERROR: Drive kopyasi basarisiz: log/2026-11-20\n%s ERROR: hatalarla bitti\n' \
  "$(date -d '-3 min' -Iseconds)" "$(date -d '-2 min' -Iseconds)" "$(date -d '-2 min' -Iseconds)" >"$LOG_YEDEK_LOG"
calistir
bekle "dosya yeni ama son kosuda ERROR -> uyari" 'Log yedegi: log yedeginin son kosusunda ERROR'
sifirla; : >"$LOG_YEDEK_CRON"
printf '%s INFO: basladi\n%s INFO: VetinityCommandDb kurtarma modeli SIMPLE (FULL degil), log yedegi atlandi\n' \
  "$(date -d '-3 min' -Iseconds)" "$(date -d '-3 min' -Iseconds)" >"$LOG_YEDEK_LOG"
calistir
bekle "SIMPLE oldugu icin atlaniyor -> uyari, govdede neden" 'kurtarma modeli SIMPLE'

echo "== API hatalari"
sifirla
{
  for i in 1 2 3 4; do echo "[11:09:1$i ERR] Beklenmeyen hata"; done
  echo "[11:09:20 INF] HTTP GET /api/hasta/1?ara=ali responded 500 in 12.3 ms"
  echo "[11:09:21 INF] HTTP POST /api/odeme responded 502 in 3.1 ms"
  echo "[11:09:22 INF] HTTP GET /api/x responded 404 in 1.0 ms"
} >"$TEST_JOURNAL"
calistir
bekleme "4 ERR + 2 adet 5xx (esik alti) -> uyari yok" 'POSTA'
echo "[11:09:30 FTL] Coktu" >>"$TEST_JOURNAL"; calistir
bekle "5 ERR/FTL -> uyari" 'API hatalari: son 5 dk: 5 ERR/FTL, 2 adet 5xx'
bekle "govdede sorgu dizesi atilmis yol" 'HTTP GET /api/hasta/1 responded 500'
bekleme "govdede sorgu dizesi yok" 'ara=ali'
sifirla
for i in 1 2 3; do echo "Nov 20 11:09:2$i vps vetinity-api[1]: HTTP GET /api/y responded 503 in 5 ms"; done >"$TEST_JOURNAL"
calistir
bekle "3 adet 5xx (journal kisa bicim) -> uyari" 'API hatalari: son 5 dk: 0 ERR/FTL, 3 adet 5xx'

echo
echo "Sonuc: $gecen gecti, $kalan kaldi"
[[ $kalan -eq 0 ]]
