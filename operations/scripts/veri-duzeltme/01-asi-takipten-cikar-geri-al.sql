/*
  Veri düzeltme A'nın geri alması: ops_yedek.Vaccinations_20261121_TakipDisi önceki görüntüsünden DueAtUtc, DueTimeSpecified, Notes
  ve UpdatedAtUtc geri yazılır; ChangedAtUtc geri alma anı olur (dış API imleci değişikliği görsün).
  Yalnız düzeltmeden sonra elle değişmemiş satırlar geri alınır (vade hâlâ boş, not düzeltmenin yazdığı not, iptal değil);
  değişmiş satırlar listelenir ve dokunulmaz. Yinelenirse geri alınmış satırlar artık uymadığı için 0 satır değişir.

  Çalıştırma: -v UYGULA=HAYIR (kuru, varsayılan kullanım) | -v UYGULA=EVET (geri al)
*/
:on error exit
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Uygula bit = CASE WHEN N'$(UYGULA)' = N'EVET' THEN 1 ELSE 0 END;

IF OBJECT_ID(N'ops_yedek.Vaccinations_20261121_TakipDisi', N'U') IS NULL
    THROW 50011, N'ops_yedek.Vaccinations_20261121_TakipDisi yok: geri alınacak düzeltme bulunamadı.', 1;

SELECT
    b.Id,
    CASE
        WHEN v.Id IS NULL THEN N'kayıt silinmiş'
        WHEN v.DueAtUtc = b.DueAtUtc AND ISNULL(v.Notes, N'') COLLATE Latin1_General_BIN2 = ISNULL(b.Notes, N'') THEN N'zaten geri alınmış'
        WHEN v.Status <> 1 THEN N'durumu değişmiş (iptal)'
        WHEN v.DueAtUtc IS NOT NULL THEN N'vade sonradan girilmiş'
        WHEN ISNULL(v.Notes, N'') COLLATE Latin1_General_BIN2 <> ISNULL(b.YeniNotes, N'') THEN N'not sonradan değişmiş'
        ELSE N'geri alınabilir'
    END AS Durum
INTO #GeriAl
FROM ops_yedek.Vaccinations_20261121_TakipDisi b
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
    v.Notes = b.Notes,
    v.UpdatedAtUtc = b.UpdatedAtUtc,
    v.ChangedAtUtc = SYSUTCDATETIME()
FROM dbo.Vaccinations v WITH (UPDLOCK, HOLDLOCK)
JOIN ops_yedek.Vaccinations_20261121_TakipDisi b ON b.Id = v.Id
WHERE v.Status = 1
  AND v.DueAtUtc IS NULL
  AND ISNULL(v.Notes, N'') COLLATE Latin1_General_BIN2 = ISNULL(b.YeniNotes, N'');

SET @Geri = @@ROWCOUNT;

IF @Geri <> @Beklenen
BEGIN
    ROLLBACK TRANSACTION;
    DECLARE @Hata nvarchar(400) = CONCAT(N'Sayılar tutmadı (beklenen ', @Beklenen, N', değişen ', @Geri, N'); işlem geri alındı.');
    THROW 50012, @Hata, 1;
END;

COMMIT TRANSACTION;

PRINT CONCAT(N'GERİ ALINDI: ', @Geri, N' aşının vadesi ve notu önceki hâline döndü. Yedek tablo silinmedi.');
