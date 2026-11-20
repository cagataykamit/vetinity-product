// Aşı saati düzeltmesi (veri düzeltme B) için yerel araç: E-vet yedeğini ürünün kendi dönüştürücüsüyle (ImportUploadReader →
// EVetBackupConverter) okur, aşı satırlarının "Yapılacak" görev saatini (SonrakiAsiTarihi) çıkarır.
// Çıktı kişisel veri taşımaz: satır anahtarı SahipAdSoyad, HayvanAdi, AsiAdi, UygulamaTarihi değerlerinin SHA-256 özetidir
// (UTF-16LE, U+001F ayraçlı; SQL tarafı aynı özeti ImportBatchRows.SourceJson'dan HASHBYTES ile hesaplar).
// Konsola yalnız sayılar yazılır.
//
// Kullanım:
//   dotnet run -- --yedek <backup.xlsx> [--hasta "Hasta Listesi_*.csv"] [--asi "Aşı Bilgi_*.csv"]
//                 --simdi 2026-11-18T00:58 --cikti <klasör>
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using Backend.Veteriner.Application.Imports.Reading;
using Backend.Veteriner.Domain.Imports;
using Microsoft.Extensions.Options;

// Okuyucu istisnaları yutar ("XLSX okunamadı"). Tanı için ARAC_TANI=1: istisna türü ve iletisi yazılır (eksik paket gibi);
// ileti hücre değeri taşıyabilir, çıktıyı paylaşmayın.
AppDomain.CurrentDomain.FirstChanceException += (_, e) =>
{
    if (Environment.GetEnvironmentVariable("ARAC_TANI") == "1")
        Console.Error.WriteLine($"[yükleme] {e.Exception.GetType().Name}: {e.Exception.Message} | {e.Exception.InnerException?.GetType().Name}: {e.Exception.InnerException?.Message}");
};

var arg = ParseArgs(args);
if (!arg.TryGetValue("yedek", out var yedekYolu) || !arg.TryGetValue("simdi", out var simdiMetin) || !arg.TryGetValue("cikti", out var cikti))
{
    Console.Error.WriteLine("Kullanım: --yedek <xlsx> [--hasta <csv>] [--asi <csv>] --simdi yyyy-MM-ddTHH:mm (İstanbul) --cikti <klasör>");
    return 2;
}

// Dönüştürücünün "şimdi"si: erken tamamlanan görev ve geçmiş/gelecek ayrımı buna bağlı. Yedeğin alındığı an verilir.
var simdiYerel = DateTime.ParseExact(simdiMetin, "yyyy-MM-dd'T'HH:mm", CultureInfo.InvariantCulture);
var simdiUtc = DateTime.SpecifyKind(simdiYerel.AddHours(-3), DateTimeKind.Utc); // İstanbul UTC+3, yaz saati yok

static ImportUploadedFile Dosya(string yol, string tur) => new(Path.GetFileName(yol), tur, File.ReadAllBytes(yol));

var files = new ImportFileSet(
    Dosya(yedekYolu, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"),
    null, null, null,
    EVetPatientReport: arg.TryGetValue("hasta", out var hasta) ? Dosya(hasta, "text/csv") : null,
    EVetVaccineReport: arg.TryGetValue("asi", out var asi) ? Dosya(asi, "text/csv") : null);

var limits = new ImportFileLimits { MaxFileBytes = 50 * 1024 * 1024, MaxRowsPerTable = 500_000, MaxTotalRows = 1_000_000 };
var reader = new ImportUploadReader(Options.Create(limits), new SabitSaat(simdiUtc));
var prepared = reader.Prepare(files, null, null, ImportSourceProfile.EVet);
if (!prepared.IsSuccess)
{
    Console.Error.WriteLine($"Hazırlık hatası: {prepared.Error.Code} {prepared.Error.Message}");
    return 1;
}

var read = reader.Read(prepared.Value!, trialTenant: false);
if (!read.IsSuccess)
{
    Console.Error.WriteLine($"Okuma hatası: {read.Error.Code} {read.Error.Message}");
    return 1;
}

var table = read.Value!.Tables.Single(t => t.Table == ImportTable.Vaccinations);
int Col(string name) => table.Headers.ToList().IndexOf(name) is >= 0 and var i ? i : throw new InvalidOperationException($"Sütun yok: {name}");
var cSahip = Col("SahipAdSoyad");
var cHayvan = Col("HayvanAdi");
var cAsi = Col("AsiAdi");
var cUygulama = Col("UygulamaTarihi");
var cSonraki = Col("SonrakiAsiTarihi");

var saatli = new List<(string Anahtar, DateOnly Tarih, TimeOnly Saat)>();
var tarihsiz = 0;
var saatsiz = 0;
foreach (var row in table.Rows)
{
    var sonraki = Cell(row, cSonraki);
    if (sonraki is null) { tarihsiz++; continue; }
    if (!DateTime.TryParseExact(sonraki, "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture, DateTimeStyles.None, out var due))
    {
        saatsiz++;
        continue;
    }

    var anahtar = Anahtar(Cell(row, cSahip), Cell(row, cHayvan), Cell(row, cAsi), Cell(row, cUygulama));
    saatli.Add((anahtar, DateOnly.FromDateTime(due), TimeOnly.FromDateTime(due)));
}

// Aynı anahtarda farklı tarih/saat: hangi kayda ait olduğu bilinemez, ikisi de çıkarılır. Aynı değer tekrarı tek satıra iner.
var gruplar = saatli.GroupBy(x => x.Anahtar, StringComparer.Ordinal).ToList();
var belirsiz = gruplar.Where(g => g.Select(x => (x.Tarih, x.Saat)).Distinct().Count() > 1).ToList();
var cikis = gruplar.Where(g => g.Select(x => (x.Tarih, x.Saat)).Distinct().Count() == 1).Select(g => g.First()).OrderBy(x => x.Anahtar, StringComparer.Ordinal).ToList();

Directory.CreateDirectory(cikti);
var csv = new StringBuilder("Anahtar;Tarih;Saat\n");
foreach (var x in cikis)
    csv.Append(CultureInfo.InvariantCulture, $"{x.Anahtar};{x.Tarih:yyyy-MM-dd};{x.Saat:HH\\:mm}\n");
File.WriteAllText(Path.Combine(cikti, "asi-saatleri.csv"), csv.ToString(), new UTF8Encoding(false));

var sql = new StringBuilder();
sql.AppendLine($"-- 02-asi-saati-geri-getir.sql için değer dosyası. Kaynak: {Path.GetFileName(yedekYolu)}; dönüştürücü anı {simdiMetin} (İstanbul).");
sql.AppendLine($"-- {cikis.Count} satır. Anahtar SHA-256 özetidir; dosya kişisel veri içermez ama klinik verisinden türetilmiştir: depoya girmez.");
for (var i = 0; i < cikis.Count; i += 500)
{
    sql.AppendLine("INSERT INTO #EvetSaat (Anahtar, Tarih, Saat) VALUES");
    var parca = cikis.Skip(i).Take(500).Select(x => string.Create(CultureInfo.InvariantCulture, $"('{x.Anahtar}', '{x.Tarih:yyyy-MM-dd}', '{x.Saat:HH\\:mm}')"));
    sql.AppendLine(string.Join(",\n", parca) + ";");
}

File.WriteAllText(Path.Combine(cikti, "02-asi-saati-degerleri.sql"), sql.ToString(), new UTF8Encoding(false));

Console.WriteLine($"Aşı satırı (dönüştürücü): {table.Rows.Count}");
Console.WriteLine($"Sonraki tarihi olmayan: {tarihsiz}");
Console.WriteLine($"Sonraki tarihi saatsiz (beklenmez): {saatsiz}");
Console.WriteLine($"Sonraki tarihi saatli: {saatli.Count}");
Console.WriteLine($"  bunlardan saati 00:00 olmayan: {saatli.Count(x => x.Saat != TimeOnly.MinValue)}");
Console.WriteLine($"  bunlardan saati 00:00: {saatli.Count(x => x.Saat == TimeOnly.MinValue)}");
Console.WriteLine($"Belirsiz anahtar (farklı tarih/saat, çıkarıldı): {belirsiz.Count} anahtar, {belirsiz.Sum(g => g.Count())} satır");
Console.WriteLine($"Değer dosyasına yazılan benzersiz anahtar: {cikis.Count}");
Console.WriteLine($"  bunlardan saati 00:00 olmayan: {cikis.Count(x => x.Saat != TimeOnly.MinValue)}");
return 0;

static string? Cell(ImportSourceRow row, int i) => i < row.Cells.Count ? row.Cells[i] : null;

static string Anahtar(string? sahip, string? hayvan, string? asi, string? uygulama)
{
    var metin = string.Join('\u001f', sahip ?? string.Empty, hayvan ?? string.Empty, asi ?? string.Empty, uygulama ?? string.Empty);
    return Convert.ToHexString(SHA256.HashData(Encoding.Unicode.GetBytes(metin)));
}

static Dictionary<string, string> ParseArgs(string[] args)
{
    var d = new Dictionary<string, string>(StringComparer.Ordinal);
    for (var i = 0; i + 1 < args.Length; i += 2)
        d[args[i].TrimStart('-')] = args[i + 1];
    return d;
}

sealed class SabitSaat(DateTime utc) : TimeProvider
{
    public override DateTimeOffset GetUtcNow() => new(utc, TimeSpan.Zero);
}



