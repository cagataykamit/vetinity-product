/*
  Veri düzeltme B'nin geri alması: ops_yedek.Vaccinations_20261121_AsiSaati önceki görüntüsünden DueAtUtc, DueTimeSpecified ve
  UpdatedAtUtc geri yazılır; ChangedAtUtc geri alma anı olur. Yalnız düzeltmeden sonra değişmemiş satırlar (vade düzeltmenin yazdığı
  değer, saat işaretli, iptal değil) geri alınır; değişmişler listelenir ve dokunulmaz. Yinelenirse 0 satır değişir.

  Çalıştırma: -v UYGULA=HAYIR (kuru) | -v UYGULA=EVET (geri al)
*/
:on error exit
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Uygula bit = CASE WHEN N'$(UYGULA)' = N'EVET' THEN 1 ELSE 0 END;

IF OBJECT_ID(N'ops_yedek.Vaccinations_20261121_AsiSaati', N'U') IS NULL
    THROW 50031, N'ops_yedek.Vaccinations_20261121_AsiSaati yok: geri alınacak düzeltme bulunamadı.', 1;

SELECT
    b.Id,
    CASE
        WHEN v.Id IS NULL THEN N'kayıt silinmiş'
        WHEN v.DueAtUtc = b.DueAtUtc AND v.DueTimeSpecified = b.DueTimeSpecified THEN N'zaten geri alınmış'
        WHEN v.Status = 2 THEN N'iptal edilmiş'
        WHEN v.DueAtUtc IS NULL OR v.DueAtUtc <> b.YeniDueAtUtc THEN N'vade sonradan değişmiş'
        WHEN v.DueTimeSpecified = 0 THEN N'saat işareti sonradan kalkmış'
        ELSE N'geri alınabilir'
    END AS Durum
INTO #GeriAl
FROM ops_yedek.Vaccinations_20261121_AsiSaati b
LEFT JOIN dbo.Vaccinations v ON v.Id = b.Id;

SELECT Durum, COUNT(*) AS Adet FROM #GeriAl GROUP BY Durum ORDER BY Durum;
SELECT Id, Durum FROM #GeriAl WHERE Durum <> N'geri alınabilir' ORDER BY Id;

IF @Uygula = 0
BEGIN
    PRINT N'KURU ÇALIŞTIRMA: hiçbir şey yazılmadı. Geri almak için -v UYGULA=EVET.';
    RETURN;
END;

DECLARE @Beklenen int = (SELECT COUNT(*) FROM #GeriAl WHERE Durum = N'geri alınabilir');
DECLARE @Geri int;

BEGIN TRANSACTION;

UPDATE v
SET v.DueAtUtc = b.DueAtUtc,
    v.DueTimeSpecified = b.DueTimeSpecified,
    v.UpdatedAtUtc = b.UpdatedAtUtc,
    v.ChangedAtUtc = SYSUTCDATETIME()
FROM dbo.Vaccinations v WITH (UPDLOCK, HOLDLOCK)
JOIN ops_yedek.Vaccinations_20261121_AsiSaati b ON b.Id = v.Id
WHERE v.Status <> 2
  AND v.DueAtUtc = b.YeniDueAtUtc
  AND v.DueTimeSpecified = 1;

SET @Geri = @@ROWCOUNT;

IF @Geri <> @Beklenen
BEGIN
    ROLLBACK TRANSACTION;
    DECLARE @Hata nvarchar(400) = CONCAT(N'Sayılar tutmadı (beklenen ', @Beklenen, N', değişen ', @Geri, N'); işlem geri alındı.');
    THROW 50032, @Hata, 1;
END;

COMMIT TRANSACTION;

PRINT CONCAT(N'GERİ ALINDI: ', @Geri, N' aşının vadesi saatsiz önceki hâline döndü. Yedek tablo silinmedi.');
