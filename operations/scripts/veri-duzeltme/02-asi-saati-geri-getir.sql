/*
  Veri düzeltme B: E-vet aktarmasında kaybolan sonraki aşı saatini geri getirir (tek seferlik). Yalnız saat yazılır; tarih değişmez.
  Belge: operations/PILOT-VERI-DUZELTME.md. Veritabanı: VetinityCommandDb.

  Değer dosyası (DEGER_DOSYASI) yerel araçla E-vet yedeğinden üretilir ve #EvetSaat'e (Anahtar, Tarih, Saat) satır ekler.
  Anahtar = SHA-256(UTF-16LE: SahipAdSoyad U+001F HayvanAdi U+001F AsiAdi U+001F UygulamaTarihi); burada aynı özet
  ImportBatchRows.SourceJson'dan hesaplanır. Dosya kişisel veri taşımaz, depoya girmez.

  Güncellenen satır (hepsi birden):
    - ImportBatchRows: aşı tablosu ([Table] = 3), SourceJson dolu, hedefi bu satırın partisinin oluşturduğu aşı
      (TargetEntityId = Vaccinations.Id ve Vaccinations.ImportBatchId = BatchId).
    - Anahtar #EvetSaat'te var; kaynak satırdaki SonrakiAsiTarihi günü = dosyadaki gün.
    - Aşı iptal değil, DueTimeSpecified = 0, DueAtUtc'nin İstanbul günü = dosyadaki gün ve saati aktarmanın yazdığı 12:00
      (İstanbul; 09:00 UTC). Öğlen değilse saat sonradan elle değişmiştir: dokunulmaz.
  Değişiklik: DueAtUtc = gün + dosyadaki saat (İstanbul, UTC+3), DueTimeSpecified = 1, UpdatedAtUtc/ChangedAtUtc = işlem anı.
  E-vet görev saati 00:00 olsa da gerçek saat sayılır (APPOINTMENT_CALENDAR_API_CONTRACT.md §8.1, kullanıcı kararı 2026-11-18).

  Çalıştırma (sqlcmd; üç değişken zorunlu):
    Kuru:    -v UYGULA=HAYIR KLINIK_ID=HEPSI        DEGER_DOSYASI=<yol>/02-asi-saati-degerleri.sql
    Uygula:  -v UYGULA=EVET  KLINIK_ID=<klinik guid> DEGER_DOSYASI=<yol>/02-asi-saati-degerleri.sql
  Uygulamada önce ops_yedek.Vaccinations_20261121_AsiSaati önceki görüntü tablosu yazılır; geri alma 02-asi-saati-geri-getir-geri-al.sql.
*/
:on error exit
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Uygula bit = CASE WHEN N'$(UYGULA)' = N'EVET' THEN 1 ELSE 0 END;
DECLARE @KlinikMetin nvarchar(64) = N'$(KLINIK_ID)';
DECLARE @KlinikId uniqueidentifier = TRY_CONVERT(uniqueidentifier, @KlinikMetin);

IF @KlinikMetin <> N'HEPSI' AND @KlinikId IS NULL
    THROW 50021, N'KLINIK_ID bir klinik kimliği (guid) ya da HEPSI olmalı.', 1;
IF @Uygula = 1 AND @KlinikId IS NULL
    THROW 50022, N'Uygulama yalnız tek klinik için yapılır: KLINIK_ID=<klinik guid> verin.', 1;

DECLARE @SimdiUtc datetime2(7) = SYSUTCDATETIME();

CREATE TABLE #EvetSaat (Anahtar char(64) NOT NULL, Tarih date NOT NULL, Saat time(0) NOT NULL);

:r $(DEGER_DOSYASI)

IF EXISTS (SELECT 1 FROM #EvetSaat GROUP BY Anahtar HAVING COUNT(*) > 1)
    THROW 50023, N'Değer dosyasında aynı anahtar birden çok kez var; araç belirsiz anahtarları çıkarmalıydı. Dosyayı yeniden üretin.', 1;

DECLARE @DegerSayisi int = (SELECT COUNT(*) FROM #EvetSaat);
PRINT CONCAT(N'Mod: ', CASE WHEN @Uygula = 1 THEN N'UYGULA' ELSE N'KURU ÇALIŞTIRMA' END,
             N' | klinik: ', ISNULL(CONVERT(nvarchar(36), @KlinikId), N'HEPSI'),
             N' | değer dosyası satırı: ', @DegerSayisi);

-- Kaynak satır → aşı eşleşmesi ve her birinin durumu.
SELECT
    v.Id,
    v.ClinicId,
    v.DueAtUtc,
    e.Anahtar,
    e.Tarih,
    e.Saat,
    DATEADD(HOUR, -3, DATEADD(SECOND, DATEDIFF(SECOND, CAST('00:00' AS time(0)), e.Saat), CAST(e.Tarih AS datetime2(7)))) AS YeniDueAtUtc,
    CASE
        WHEN v.Status = 2 THEN N'atla: iptal'
        WHEN v.DueAtUtc IS NULL THEN N'atla: vade boş'
        WHEN v.DueTimeSpecified = 1 THEN N'atla: saat zaten belirtilmiş'
        WHEN k.KaynakTarih IS NULL OR k.KaynakTarih <> e.Tarih THEN N'atla: kaynak satırın günü farklı'
        WHEN CAST(DATEADD(HOUR, 3, v.DueAtUtc) AS date) <> e.Tarih THEN N'atla: vade günü farklı'
        WHEN CAST(v.DueAtUtc AS time(7)) <> CAST('09:00' AS time(7)) THEN N'atla: saat aktarma öğleni değil (elle değişmiş)'
        ELSE N'güncellenecek'
    END AS Durum
INTO #Eslesme
FROM dbo.ImportBatchRows r
JOIN dbo.Vaccinations v ON v.Id = r.TargetEntityId AND v.ImportBatchId = r.BatchId
CROSS APPLY (
    SELECT
        CONVERT(char(64), HASHBYTES('SHA2_256', CONCAT(
            ISNULL(JSON_VALUE(r.SourceJson, '$.SahipAdSoyad'), N''), NCHAR(31),
            ISNULL(JSON_VALUE(r.SourceJson, '$.HayvanAdi'), N''), NCHAR(31),
            ISNULL(JSON_VALUE(r.SourceJson, '$.AsiAdi'), N''), NCHAR(31),
            ISNULL(JSON_VALUE(r.SourceJson, '$.UygulamaTarihi'), N''))), 2) AS Anahtar,
        TRY_CONVERT(date, LEFT(JSON_VALUE(r.SourceJson, '$.SonrakiAsiTarihi'), 10), 23) AS KaynakTarih
) k
JOIN #EvetSaat e ON e.Anahtar = k.Anahtar
WHERE r.[Table] = 3
  AND r.SourceJson IS NOT NULL
  AND r.TargetEntityId IS NOT NULL
  AND (@KlinikId IS NULL OR v.ClinicId = @KlinikId);

-- Bir aşıya birden çok kaynak satır düşerse (beklenmez) hiçbiri güncellenmez.
UPDATE #Eslesme SET Durum = N'atla: birden çok kaynak satır'
WHERE Id IN (SELECT Id FROM #Eslesme GROUP BY Id HAVING COUNT(*) > 1);

SELECT Durum, COUNT(*) AS Adet FROM #Eslesme GROUP BY Durum ORDER BY Durum;

SELECT Kalem, Adet FROM (VALUES
    (1, N'Değer dosyası satırı', (SELECT COUNT(*) FROM #EvetSaat)),
    (2, N'Aşıyla eşleşen anahtar', (SELECT COUNT(DISTINCT Anahtar) FROM #Eslesme)),
    (3, N'Güncellenecek aşı', (SELECT COUNT(*) FROM #Eslesme WHERE Durum = N'güncellenecek')),
    (4, N'  bunlardan saat 12:00 (yalnız işaret değişir)', (SELECT COUNT(*) FROM #Eslesme WHERE Durum = N'güncellenecek' AND Saat = '12:00')),
    (5, N'  bunlardan saat 00:00', (SELECT COUNT(*) FROM #Eslesme WHERE Durum = N'güncellenecek' AND Saat = '00:00'))
) AS t(Sira, Kalem, Adet)
ORDER BY Sira;

SELECT ClinicId, COUNT(*) AS Guncellenecek
FROM #Eslesme WHERE Durum = N'güncellenecek'
GROUP BY ClinicId ORDER BY ClinicId;

-- Etkilenecek kayıtlar (yalnız kimlik, gün ve saat).
SELECT Id, ClinicId, Tarih, Saat
FROM #Eslesme WHERE Durum = N'güncellenecek'
ORDER BY ClinicId, Tarih, Saat, Id;

IF @Uygula = 0
BEGIN
    PRINT N'KURU ÇALIŞTIRMA: hiçbir şey yazılmadı. Uygulamak için -v UYGULA=EVET KLINIK_ID=<klinik guid>.';
    RETURN;
END;

IF OBJECT_ID(N'ops_yedek.Vaccinations_20261121_AsiSaati', N'U') IS NOT NULL
    THROW 50024, N'ops_yedek.Vaccinations_20261121_AsiSaati zaten var: düzeltme daha önce uygulanmış. Önce tabloyu inceleyin.', 1;

IF SCHEMA_ID(N'ops_yedek') IS NULL
    EXEC (N'CREATE SCHEMA ops_yedek AUTHORIZATION dbo;');

DECLARE @Hedef int = (SELECT COUNT(*) FROM #Eslesme WHERE Durum = N'güncellenecek');
DECLARE @Yedeklenen int, @Guncellenen int;

BEGIN TRANSACTION;

SELECT
    v.Id, v.TenantId, v.ClinicId,
    v.DueAtUtc, v.DueTimeSpecified, v.UpdatedAtUtc, v.ChangedAtUtc,
    CAST(v.RowVersion AS binary(8)) AS RowVersionOnce,
    m.YeniDueAtUtc,
    @SimdiUtc AS IslemUtc
INTO ops_yedek.Vaccinations_20261121_AsiSaati
FROM dbo.Vaccinations v WITH (UPDLOCK, HOLDLOCK)
JOIN #Eslesme m ON m.Id = v.Id AND m.Durum = N'güncellenecek' AND m.DueAtUtc = v.DueAtUtc
WHERE v.Status <> 2 AND v.DueTimeSpecified = 0;

SET @Yedeklenen = @@ROWCOUNT;

UPDATE v
SET v.DueAtUtc = b.YeniDueAtUtc,
    v.DueTimeSpecified = 1,
    v.UpdatedAtUtc = @SimdiUtc,
    v.ChangedAtUtc = @SimdiUtc
FROM dbo.Vaccinations v
JOIN ops_yedek.Vaccinations_20261121_AsiSaati b ON b.Id = v.Id
WHERE v.RowVersion = b.RowVersionOnce
  AND v.DueAtUtc = b.DueAtUtc
  AND v.DueTimeSpecified = 0
  AND v.Status <> 2
  AND CAST(DATEADD(HOUR, 3, b.YeniDueAtUtc) AS date) = CAST(DATEADD(HOUR, 3, b.DueAtUtc) AS date);

SET @Guncellenen = @@ROWCOUNT;

IF @Yedeklenen <> @Hedef OR @Guncellenen <> @Yedeklenen
BEGIN
    ROLLBACK TRANSACTION;
    DECLARE @Hata nvarchar(400) = CONCAT(N'Sayılar tutmadı (hedef ', @Hedef, N', yedek ', @Yedeklenen, N', güncellenen ', @Guncellenen,
        N'); işlem geri alındı, hiçbir şey yazılmadı. Kuru çalıştırmayı yineleyin.');
    THROW 50025, @Hata, 1;
END;

COMMIT TRANSACTION;

PRINT CONCAT(N'UYGULANDI: ', @Guncellenen, N' aşının sonraki tarihine saat yazıldı. Önceki görüntü: ops_yedek.Vaccinations_20261121_AsiSaati (',
             @Yedeklenen, N' satır).');
