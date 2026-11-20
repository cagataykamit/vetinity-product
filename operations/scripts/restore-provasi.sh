#!/usr/bin/env bash
# restore-provasi.sql'i rastgele adlı geçici veritabanıyla çalıştırır, sonra geçici
# veritabanlarını ve yedek dosyalarını siler. Canlı veritabanlarına dokunmaz.
#   Kullanım: restore-provasi.sh KLASOR [sqlcmd bağlantı argümanları...]
#   KLASOR = @varsayilan -> SQL Server'ın varsayılan yedek klasörü (hizmet hesabı yazabilir)
#   Windows (Git Bash): bash restore-provasi.sh @varsayilan -S . -E -C
#   Sunucu (isteğe bağlı): SQLCMD=/opt/mssql-tools18/bin/sqlcmd SQLCMDPASSWORD=<sa> \
#       ./restore-provasi.sh @varsayilan -S 127.0.0.1,1433 -U sa -C
# Dosyalar SQL Server üzerinden silinir (xp_delete_file); kabuğun klasöre erişimi gerekmez.
set -uo pipefail

[[ $# -ge 1 ]] || { echo "kullanim: $0 KLASOR|@varsayilan [sqlcmd argumanlari...]" >&2; exit 2; }
KLASOR=${1%/}
shift
SQLCMD_BIN=${SQLCMD:-sqlcmd}
SQL_DOSYA=$(dirname "$(readlink -f "$0")")/restore-provasi.sql
AD=VetinityLogProva_$(od -An -N4 -tx1 /dev/urandom | tr -d ' \n')

if [[ $KLASOR == @varsayilan ]]; then
  KLASOR=$("$SQLCMD_BIN" "$@" -b -h -1 -W -Q "SET NOCOUNT ON; SELECT CAST(SERVERPROPERTY('InstanceDefaultBackupPath') AS nvarchar(400));" | tr -d '\r')
  KLASOR=${KLASOR%[/\\]}
elif command -v cygpath >/dev/null; then
  KLASOR=$(cygpath -w "$KLASOR")
fi
if command -v cygpath >/dev/null; then
  SQL_DOSYA=$(cygpath -w "$SQL_DOSYA")
fi
[[ $KLASOR == *\\* ]] && AYIRICI='\' || AYIRICI=/
ONEK=$KLASOR$AYIRICI$AD
echo "Prova veritabani: $AD"
echo "Dosya oneki: $ONEK"

# Değişkenler -v yerine ortamdan verilir (Windows sqlcmd -v değerindeki ':' karakterini bölüyor).
ProvaDb=$AD Onek=$ONEK "$SQLCMD_BIN" "$@" -b -i "$SQL_DOSYA"
kod=$?

# Temizlik yalnız bu koşunun adlarıyla: yarıda kalan veritabanları ve yedek dosyaları.
"$SQLCMD_BIN" "$@" -b -h -1 -W -Q "SET NOCOUNT ON;
IF DB_ID(N'${AD}_An') IS NOT NULL DROP DATABASE [${AD}_An];
IF DB_ID(N'${AD}_Son') IS NOT NULL DROP DATABASE [${AD}_Son];
IF DB_ID(N'${AD}') IS NOT NULL DROP DATABASE [${AD}];
DECLARE @f nvarchar(400), @kalan int = 0;
DECLARE d CURSOR LOCAL FAST_FORWARD FOR
  SELECT N'${ONEK}' + s FROM (VALUES (N'.bak'), (N'_1.trn'), (N'_2.trn')) v(s);
OPEN d; FETCH NEXT FROM d INTO @f;
WHILE @@FETCH_STATUS = 0
BEGIN
  IF (SELECT file_exists FROM sys.dm_os_file_exists(@f)) = 1 EXEC master.sys.xp_delete_file 0, @f;
  SET @kalan += (SELECT file_exists FROM sys.dm_os_file_exists(@f));
  FETCH NEXT FROM d INTO @f;
END
CLOSE d; DEALLOCATE d;
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'${AD}';
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'${AD}_Son';
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'${AD}_An';
SELECT CONCAT(N'Temizlik: kalan prova veritabani=',
  (SELECT COUNT(*) FROM sys.databases WHERE name LIKE N'${AD}%'), N', kalan prova dosyasi=', @kalan);"

[[ $kod -eq 0 ]] && echo "SONUC: prova gecti" || echo "SONUC: prova BASARISIZ (kod $kod)"
exit "$kod"
