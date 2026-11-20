/*
  Veri düzeltme A: içe aktarılmış, vadesi 1 yıldan uzun süredir geçmiş aşıları takipten çıkarır (tek seferlik).
  Belge: operations/PILOT-VERI-DUZELTME.md. Veritabanı: VetinityCommandDb (sorgu DB'sinde aşı verisi yok).

  Kapsam (paneldeki "gecikmiş sonraki aşı" kuralıyla aynı; VaccinationCalendarRules + GetVaccinationsCalendarQueryHandler):
    - İçe aktarılmış (ImportBatchId dolu), uygulanmış (Status = 1, AppliedAtUtc dolu), iptal değil, vadesi (DueAtUtc) dolu.
    - Vade bugünün (İstanbul günü) başından önce: gecikmiş (ADR-028, VaccinationDueRule).
    - Karşılanmamış: aynı hayvana aynı aşı (tanım kimliği; ikisinden biri tanımsızsa ad, Türkçe büyük/küçük harf duyarsız)
      bu uygulamadan sonra yeniden uygulanmamış.
    - Hayvan bakımda (Pets.Status = 1; vefat edenin vadesi panelde zaten gösterilmez, dokunulmaz).
    - Bunlardan vadesinin İstanbul günü (bugün - 1 yıl)'dan önce olanlar değişir; kalanı gecikmiş kalır.

  Değişiklik: DueAtUtc = NULL, DueTimeSpecified = 0, Notes'a satır eklenir
    "Sonraki aşı tarihi gg.aa.yyyy toplu işlemle takipten çıkarıldı (yyyy-aa-gg)."
    UpdatedAtUtc ve ChangedAtUtc işlem anı (ChangedAtUtc dış API imleci; uygulama bunu kaydetmede yazar, toplu SQL'de elle).
    RowVersion SQL Server'da kendiliğinden değişir. RecordChanges yazılmaz (kullanıcısız değişiklik, interceptor kuralıyla aynı).

  Çalıştırma (sqlcmd; iki değişken zorunlu, tanımsızsa sqlcmd hiçbir şey çalıştırmadan durur):
    Kuru çalıştırma: -v UYGULA=HAYIR KLINIK_ID=HEPSI      (yalnız sayar ve kimlikleri listeler; hiçbir şey yazmaz)
    Uygulama:        -v UYGULA=EVET  KLINIK_ID=<klinik guid>  (HEPSI ile uygulanmaz)
  Uygulamada önce ops_yedek.Vaccinations_20261121_TakipDisi önceki görüntü tablosu yazılır; geri alma 01-asi-takipten-cikar-geri-al.sql.
*/
:on error exit
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Uygula bit = CASE WHEN N'$(UYGULA)' = N'EVET' THEN 1 ELSE 0 END;
DECLARE @KlinikMetin nvarchar(64) = N'$(KLINIK_ID)';
DECLARE @KlinikId uniqueidentifier = TRY_CONVERT(uniqueidentifier, @KlinikMetin);

IF @KlinikMetin <> N'HEPSI' AND @KlinikId IS NULL
    THROW 50001, N'KLINIK_ID bir klinik kimliği (guid) ya da HEPSI olmalı.', 1;
IF @Uygula = 1 AND @KlinikId IS NULL
    THROW 50002, N'Uygulama yalnız tek klinik için yapılır: KLINIK_ID=<klinik guid> verin.', 1;

-- İstanbul UTC+3, yaz saati yok (OperationDayBounds ile aynı).
DECLARE @SimdiUtc datetime2(7) = SYSUTCDATETIME();
DECLARE @Bugun date = CAST(DATEADD(HOUR, 3, @SimdiUtc) AS date);
DECLARE @GecikmeSiniriUtc datetime2(7) = DATEADD(HOUR, -3, CAST(@Bugun AS datetime2(7)));
DECLARE @BirYilSiniriUtc datetime2(7) = DATEADD(HOUR, -3, CAST(DATEADD(YEAR, -1, @Bugun) AS datetime2(7)));

PRINT CONCAT(N'Mod: ', CASE WHEN @Uygula = 1 THEN N'UYGULA' ELSE N'KURU ÇALIŞTIRMA' END,
             N' | klinik: ', ISNULL(CONVERT(nvarchar(36), @KlinikId), N'HEPSI'),
             N' | İstanbul günü: ', CONVERT(char(10), @Bugun, 23),
             N' | takipten çıkma sınırı (vade günü bundan önce): ', CONVERT(char(10), DATEADD(YEAR, -1, @Bugun), 23));

-- Gecikmiş içe aktarılmış uygulanmış aşılar ve panelin onları neden göstermediği.
SELECT
    v.Id,
    v.TenantId,
    v.ClinicId,
    v.ImportBatchId,
    v.DueAtUtc,
    CAST(DATEADD(HOUR, 3, v.DueAtUtc) AS date) AS VadeGunu,
    CASE WHEN p.Status = 1 THEN 0 ELSE 1 END AS BakimDisi,
    CASE WHEN EXISTS (
        SELECT 1
        FROM dbo.Vaccinations s
        WHERE s.TenantId = v.TenantId
          AND s.PetId = v.PetId
          AND s.Id <> v.Id
          AND s.Status = 1
          AND s.AppliedAtUtc IS NOT NULL
          AND s.AppliedAtUtc > v.AppliedAtUtc
          AND ((s.VaccineDefinitionId IS NOT NULL AND v.VaccineDefinitionId IS NOT NULL AND s.VaccineDefinitionId = v.VaccineDefinitionId)
               OR ((s.VaccineDefinitionId IS NULL OR v.VaccineDefinitionId IS NULL)
                   AND LTRIM(RTRIM(s.VaccineName)) COLLATE Turkish_CI_AS = LTRIM(RTRIM(v.VaccineName)) COLLATE Turkish_CI_AS))
    ) THEN 1 ELSE 0 END AS Karsilandi,
    CASE
        WHEN v.Notes IS NULL OR LTRIM(RTRIM(v.Notes)) = N'' THEN N''
        ELSE v.Notes + NCHAR(10)
    END
    + N'Sonraki aşı tarihi ' + CONVERT(char(10), CAST(DATEADD(HOUR, 3, v.DueAtUtc) AS date), 104)
    + N' toplu işlemle takipten çıkarıldı (' + CONVERT(char(10), @Bugun, 23) + N').' AS YeniNotes
INTO #Aday
FROM dbo.Vaccinations v
JOIN dbo.Pets p ON p.Id = v.PetId
WHERE v.ImportBatchId IS NOT NULL
  AND v.Status = 1
  AND v.AppliedAtUtc IS NOT NULL
  AND v.DueAtUtc IS NOT NULL
  AND v.DueAtUtc < @GecikmeSiniriUtc
  AND (@KlinikId IS NULL OR v.ClinicId = @KlinikId);

SELECT a.Id, a.TenantId, a.ClinicId, a.DueAtUtc, a.VadeGunu, a.YeniNotes
INTO #Hedef
FROM #Aday a
WHERE a.BakimDisi = 0
  AND a.Karsilandi = 0
  AND a.DueAtUtc < @BirYilSiniriUtc
  AND LEN(a.YeniNotes) <= 4000;

-- Özet (sayılar).
SELECT Kalem, Adet FROM (VALUES
    (1, N'Panelde gecikmiş (içe aktarılmış, karşılanmamış, hayvan bakımda)',
        (SELECT COUNT(*) FROM #Aday WHERE BakimDisi = 0 AND Karsilandi = 0)),
    (2, N'  takipten çıkacak (vade 1 yıldan eski)', (SELECT COUNT(*) FROM #Hedef)),
    (3, N'  gecikmiş kalacak (vade son 1 yıl içinde)',
        (SELECT COUNT(*) FROM #Aday WHERE BakimDisi = 0 AND Karsilandi = 0 AND DueAtUtc >= @BirYilSiniriUtc)),
    (4, N'  not 4000 karakteri aşacağı için atlanan',
        (SELECT COUNT(*) FROM #Aday WHERE BakimDisi = 0 AND Karsilandi = 0 AND DueAtUtc < @BirYilSiniriUtc AND LEN(YeniNotes) > 4000)),
    (5, N'Dokunulmaz: sonraki doz uygulanmış (karşılanmış)', (SELECT COUNT(*) FROM #Aday WHERE Karsilandi = 1)),
    (6, N'Dokunulmaz: hayvan bakım dışı (vefat)', (SELECT COUNT(*) FROM #Aday WHERE BakimDisi = 1 AND Karsilandi = 0)),
    (7, N'Dokunulmaz: iptal edilmiş içe aktarılmış aşı (vadesi geçmiş)',
        (SELECT COUNT(*) FROM dbo.Vaccinations v
         WHERE v.ImportBatchId IS NOT NULL AND v.Status = 2 AND v.DueAtUtc < @GecikmeSiniriUtc
           AND (@KlinikId IS NULL OR v.ClinicId = @KlinikId)))
) AS t(Sira, Kalem, Adet)
ORDER BY Sira;

-- Klinik kırılımı (yalnız kimlik ve sayı).
SELECT TenantId, ClinicId, COUNT(*) AS TakiptenCikacak
FROM #Hedef
GROUP BY TenantId, ClinicId
ORDER BY TenantId, ClinicId;

-- Etkilenecek kayıtlar (yalnız kimlik ve vade günü).
SELECT Id, ClinicId, VadeGunu
FROM #Hedef
ORDER BY ClinicId, VadeGunu, Id;

IF @Uygula = 0
BEGIN
    PRINT N'KURU ÇALIŞTIRMA: hiçbir şey yazılmadı. Uygulamak için -v UYGULA=EVET KLINIK_ID=<klinik guid>.';
    RETURN;
END;

IF OBJECT_ID(N'ops_yedek.Vaccinations_20261121_TakipDisi', N'U') IS NOT NULL
    THROW 50003, N'ops_yedek.Vaccinations_20261121_TakipDisi zaten var: düzeltme daha önce uygulanmış. Önce tabloyu inceleyin.', 1;

IF SCHEMA_ID(N'ops_yedek') IS NULL
    EXEC (N'CREATE SCHEMA ops_yedek AUTHORIZATION dbo;');

DECLARE @Yedeklenen int, @Guncellenen int;

BEGIN TRANSACTION;

-- Önceki görüntü: kilitlenerek okunur; arada değişen satır güncellemede RowVersion eşitliğiyle elenir ve işlem geri döner.
SELECT
    v.Id, v.TenantId, v.ClinicId,
    v.DueAtUtc, v.DueTimeSpecified, v.Notes, v.UpdatedAtUtc, v.ChangedAtUtc,
    CAST(v.RowVersion AS binary(8)) AS RowVersionOnce,
    h.YeniNotes,
    @SimdiUtc AS IslemUtc
INTO ops_yedek.Vaccinations_20261121_TakipDisi
FROM dbo.Vaccinations v WITH (UPDLOCK, HOLDLOCK)
JOIN #Hedef h ON h.Id = v.Id AND h.DueAtUtc = v.DueAtUtc
WHERE v.Status = 1;

SET @Yedeklenen = @@ROWCOUNT;

UPDATE v
SET v.DueAtUtc = NULL,
    v.DueTimeSpecified = 0,
    v.Notes = b.YeniNotes,
    v.UpdatedAtUtc = @SimdiUtc,
    v.ChangedAtUtc = @SimdiUtc
FROM dbo.Vaccinations v
JOIN ops_yedek.Vaccinations_20261121_TakipDisi b ON b.Id = v.Id
WHERE v.RowVersion = b.RowVersionOnce
  AND v.DueAtUtc = b.DueAtUtc
  AND v.Status = 1;

SET @Guncellenen = @@ROWCOUNT;

IF @Yedeklenen <> (SELECT COUNT(*) FROM #Hedef) OR @Guncellenen <> @Yedeklenen
BEGIN
    ROLLBACK TRANSACTION;
    DECLARE @Hata nvarchar(400) = CONCAT(N'Sayılar tutmadı (hedef ', (SELECT COUNT(*) FROM #Hedef), N', yedek ', @Yedeklenen,
        N', güncellenen ', @Guncellenen, N'); işlem geri alındı, hiçbir şey yazılmadı. Kuru çalıştırmayı yineleyin.');
    THROW 50004, @Hata, 1;
END;

COMMIT TRANSACTION;

PRINT CONCAT(N'UYGULANDI: ', @Guncellenen, N' aşının sonraki tarihi takipten çıkarıldı. Önceki görüntü: ops_yedek.Vaccinations_20261121_TakipDisi (',
             @Yedeklenen, N' satır).');
