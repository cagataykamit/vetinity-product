-- Log yedeği zincirinin geri yükleme provası (sqlcmd betiği).
-- Kendi geçici veritabanını yaratır; başka hiçbir veritabanına dokunmaz.
-- Değişkenler: ProvaDb (VetinityLogProva_ ile başlamalı), Onek (yedek dosyalarının
-- yol öneki, örn. C:\yedek\VetinityLogProva_ab12 veya /var/opt/mssql/prova/VetinityLogProva_ab12)
-- Akış: FULL'e al -> tam yedek -> kayıt -> log 1 -> kayıt -> [an] -> kayıt -> log 2
--   Senaryo SON: tam + log1 + log2 (NORECOVERY), sonra RECOVERY      -> 100 kayıt beklenir
--   Senaryo AN : tam + log1 + log2 (NORECOVERY, STOPAT = an), RECOVERY -> 60 kayıt beklenir
-- Sonunda üç geçici veritabanı silinir; dosyaları çağıran betik siler.
:on error exit
SET NOCOUNT ON;
IF LEFT(N'$(ProvaDb)', 17) <> N'VetinityLogProva_'
    RAISERROR(N'ProvaDb VetinityLogProva_ ile baslamali', 16, 1);
GO
CREATE DATABASE [$(ProvaDb)];
GO
ALTER DATABASE [$(ProvaDb)] SET RECOVERY FULL;
GO
USE [$(ProvaDb)];
CREATE TABLE dbo.Kayit (Id int IDENTITY PRIMARY KEY, Parti int NOT NULL, Zaman datetime2 NOT NULL DEFAULT SYSDATETIME());
INSERT dbo.Kayit (Parti) SELECT TOP (10) 1 FROM sys.all_objects;
GO
BACKUP DATABASE [$(ProvaDb)] TO DISK = N'$(Onek).bak' WITH INIT, COMPRESSION, CHECKSUM;
GO
INSERT dbo.Kayit (Parti) SELECT TOP (20) 2 FROM sys.all_objects;
GO
BACKUP LOG [$(ProvaDb)] TO DISK = N'$(Onek)_1.trn' WITH INIT, COMPRESSION, CHECKSUM;
GO
INSERT dbo.Kayit (Parti) SELECT TOP (30) 3 FROM sys.all_objects;
WAITFOR DELAY '00:00:02';
CREATE TABLE #an (t datetime NOT NULL);
INSERT #an SELECT GETDATE();
WAITFOR DELAY '00:00:02';
INSERT dbo.Kayit (Parti) SELECT TOP (40) 4 FROM sys.all_objects;
GO
BACKUP LOG [$(ProvaDb)] TO DISK = N'$(Onek)_2.trn' WITH INIT, COMPRESSION, CHECKSUM;
GO
RESTORE VERIFYONLY FROM DISK = N'$(Onek).bak' WITH CHECKSUM;
RESTORE VERIFYONLY FROM DISK = N'$(Onek)_1.trn' WITH CHECKSUM;
RESTORE VERIFYONLY FROM DISK = N'$(Onek)_2.trn' WITH CHECKSUM;
GO
USE master;
DECLARE @veri nvarchar(400) = CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS nvarchar(400));
DECLARE @an datetime = (SELECT t FROM #an);
DECLARE @hedef sysname, @sql nvarchar(max);
DECLARE @senaryo TABLE (Ad sysname, StopAt bit);
INSERT @senaryo VALUES (N'$(ProvaDb)_Son', 0), (N'$(ProvaDb)_An', 1);
DECLARE s CURSOR LOCAL FAST_FORWARD FOR SELECT Ad, StopAt FROM @senaryo;
DECLARE @stopat bit;
OPEN s;
FETCH NEXT FROM s INTO @hedef, @stopat;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = N'RESTORE DATABASE ' + QUOTENAME(@hedef) + N' FROM DISK = N''$(Onek).bak''
        WITH NORECOVERY, CHECKSUM,
        MOVE N''$(ProvaDb)'' TO N''' + @veri + @hedef + N'.mdf'',
        MOVE N''$(ProvaDb)_log'' TO N''' + @veri + @hedef + N'_log.ldf'';';
    EXEC (@sql);
    IF @stopat = 1
    BEGIN
        -- Her log dosyasına aynı STOPAT verilir; an sonrası olan log yalnız o ana kadar uygulanır.
        SET @sql = N'RESTORE LOG ' + QUOTENAME(@hedef) + N' FROM DISK = N''$(Onek)_1.trn'' WITH NORECOVERY, CHECKSUM, STOPAT = @an;
                     RESTORE LOG ' + QUOTENAME(@hedef) + N' FROM DISK = N''$(Onek)_2.trn'' WITH NORECOVERY, CHECKSUM, STOPAT = @an;';
        EXEC sp_executesql @sql, N'@an datetime', @an = @an;
    END
    ELSE
    BEGIN
        SET @sql = N'RESTORE LOG ' + QUOTENAME(@hedef) + N' FROM DISK = N''$(Onek)_1.trn'' WITH NORECOVERY, CHECKSUM;
                     RESTORE LOG ' + QUOTENAME(@hedef) + N' FROM DISK = N''$(Onek)_2.trn'' WITH NORECOVERY, CHECKSUM;';
        EXEC (@sql);
    END
    SET @sql = N'RESTORE DATABASE ' + QUOTENAME(@hedef) + N' WITH RECOVERY;';
    EXEC (@sql);
    FETCH NEXT FROM s INTO @hedef, @stopat;
END
CLOSE s;
DEALLOCATE s;
PRINT N'STOPAT ani: ' + CONVERT(nvarchar(30), @an, 121);
GO
DECLARE @kaynak int = (SELECT COUNT(*) FROM [$(ProvaDb)].dbo.Kayit);
DECLARE @son int = (SELECT COUNT(*) FROM [$(ProvaDb)_Son].dbo.Kayit);
DECLARE @an int = (SELECT COUNT(*) FROM [$(ProvaDb)_An].dbo.Kayit);
DECLARE @anParti nvarchar(50) = (SELECT STRING_AGG(CONCAT(Parti, N':', n), N' ') FROM
    (SELECT Parti, COUNT(*) n FROM [$(ProvaDb)_An].dbo.Kayit GROUP BY Parti) x);
PRINT CONCAT(N'SONUC kaynak=', @kaynak, N' (beklenen 100), son=', @son, N' (beklenen 100), an=', @an,
             N' (beklenen 60; parti:adet ', @anParti, N')');
IF @kaynak <> 100 OR @son <> 100 OR @an <> 60
    RAISERROR(N'PROVA BASARISIZ: kayit sayilari beklenenden farkli', 16, 1);
ELSE
    PRINT N'PROVA GECTI';
GO
USE master;
DROP DATABASE [$(ProvaDb)_An];
DROP DATABASE [$(ProvaDb)_Son];
DROP DATABASE [$(ProvaDb)];
PRINT N'gecici veritabanlari silindi';
GO
