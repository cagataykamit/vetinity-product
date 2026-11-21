# Pilot kliniğin aktarılmış verisi: tek seferlik düzeltmeler

Tarih: 2026-11-20 (uygulama 2026-11-21 sabahı planlandı). Canlı veriye yazar: **her uygulama adımı kullanıcı onayıyla**.

> **Durum (2026-11-21):** B canlıda uygulandı: pilot klinikte 5 745 aşı (değer dosyası 2026-11-18 yedeğinden), yedek 14:50.
> Ayrıntı: `release-notes/2026-11-21-panel-vital-asi-saati.md`. **A uygulanmadı ve uygulanmayacak** (kullanıcı kararı:
> toplu veri düzeltmesi yerine kodda "1 ay kuralı").
Dosyalar: `operations/scripts/veri-duzeltme/`.

| Dosya | Ne yapar |
|---|---|
| `01-asi-takipten-cikar.sql` | A: vadesi 1 yıldan uzun süredir geçmiş içe aktarılmış aşıları takipten çıkarır |
| `01-asi-takipten-cikar-geri-al.sql` | A'nın geri alması (önceki görüntüden) |
| `02-asi-saati-geri-getir.sql` | B: E-vet aktarmasında kaybolan sonraki aşı saatini geri yazar (yalnız saat) |
| `02-asi-saati-geri-getir-geri-al.sql` | B'nin geri alması |
| `asi-saat-araci.cs` | B'nin değer dosyasını E-vet yedeğinden üreten yerel aracın kaynağı (proje dosyası aşağıda) |

Kullanıcı kararları (2026-11-20, koordinatör aktardı): A için seçenek (b); B için hedefli düzeltme, yalnız saat, E-vet dosyasındaki
kaynakla eşleşerek.

## Ortak kurallar

- Tümü `VetinityCommandDb` üzerinde, `sqlcmd` betiği. Zorunlu değişkenler `-v` ile verilir; verilmezse sqlcmd hiçbir şey çalıştırmadan
  durur. `UYGULA=EVET` dışındaki her değer **kuru çalıştırmadır**: yalnız sayar, klinik kırılımını ve etkilenecek kimlikleri (yalnız
  kimlik ve tarih) listeler, hiçbir şey yazmaz.
- Uygulama yalnız `KLINIK_ID=<klinik guid>` ile (`HEPSI` reddedilir). Klinik kimliği kuru çalıştırmanın kırılım tablosundan okunur.
- Uygulama tek transaction'dır: önce **önceki görüntü tablosu** (`ops_yedek` şeması, betik yoksa açar), sonra güncelleme. Önceki
  görüntü kilitlenerek okunur; güncellenen sayı yedeklenen ve hedeflenen sayıya eşit değilse her şey geri alınır. Yedek tablo varsa
  betik durur (ikinci kez uygulanmaz).
- **Neden ayrı şema:** önceki görüntü veritabanında, gece yedeğinin içinde kalır ve geri alma betiği doğrudan okur. `dbo` dışında olduğu
  için EF modeline, dış API'ye ve veri dışa aktarmaya karışmaz. Şema açmak `sa` (ya da `db_owner`) ister; betikler `sa` ile çalıştırılır.
  Yedek tablolar pilotun ilk haftası sorunsuz geçince elle silinir (`DROP TABLE ops_yedek.<ad>`), sonra şema (`DROP SCHEMA ops_yedek`).
- Değişen satırda `UpdatedAtUtc` ve `ChangedAtUtc` işlem anı olur (uygulama `ChangedAtUtc`'yi kaydetmede yazar, toplu SQL'de elle;
  dış API `updatedSince` imleci bunu okur). `RowVersion` SQL Server'da kendiliğinden değişir: açık düzenleme formu kaydederken
  eşzamanlılık hatası alır, sayfa yenilenince düzelir.
- `RecordChanges` (kayıt geçmişi) yazılmaz: interceptor kullanıcısız değişikliği zaten yazmaz (içe aktarma gibi). A'da bilgi kaydın
  notunda kalır. Sorgu veritabanında (`VetinityQueryDb`) aşı verisi yok; projeksiyon ya da önbellek güncellemesi gerekmez.
- Hatırlatma: aşı hatırlatmasının tekrar anahtarı aşı kimliği + gün sayısıdır, vade saatine bağlı değildir; B yeniden hatırlatma
  göndermez. A'nın vadesini boşalttığı kayıt hatırlatma adayı olmaz (zaten 1 yıl önce geçmişti).
- Geri alma betikleri yalnız düzeltmeden sonra elle değişmemiş satırları geri yazar; değişmişleri listeler, dokunmaz. Geri alınan
  satırda `UpdatedAtUtc` önceki değerine döner, `ChangedAtUtc` geri alma anı olur. Yinelenirse 0 satır değişir.
- Dosyalar UTF-8 (BOM'lu); sqlcmd `-f 65001` ile çalıştırılır. Linux sqlcmd `-f`'yi kabul etmezse seçenek atılır (BOM yeter).

## A: takipten çıkarma (`01-asi-takipten-cikar.sql`)

Alan modelinde "takip edilmiyor" alanı yok. Takipten çıkarmak = sonraki tarihi boşaltmak ve bilgiyi nota yazmak.

- **Kapsam (panelin "gecikmiş" dediği küme, kod: `VaccinationCalendarRules`, `GetVaccinationsCalendarQueryHandler`,
  `VaccinationDueRule`):** içe aktarılmış (`ImportBatchId` dolu), uygulanmış (`Status = 1`, `AppliedAtUtc` dolu), vadesi bugünün
  (İstanbul günü) başından önce, **karşılanmamış** (aynı hayvana aynı aşı, tanım kimliğiyle; biri tanımsızsa adla, Türkçe büyük/küçük
  harf duyarsız, sonradan yeniden uygulanmamış), hayvan bakımda (`Pets.Status = 1`). İptal ve vefat eden hayvanın aşısı panelde
  gecikmiş görünmez; dokunulmaz, kuru çalıştırmada ayrıca sayılır.
- **Değişen:** bunlardan vade günü (İstanbul) `bugün − 1 yıl`'dan önce olanlar. Tam 1 yıl önce olan gecikmiş kalır.
- **Yazılan:** `DueAtUtc = NULL`, `DueTimeSpecified = 0`, nota yeni satır:
  `Sonraki aşı tarihi gg.aa.yyyy toplu işlemle takipten çıkarıldı (yyyy-aa-gg).` (parantez içi işlem günü). Not 4000 karakteri
  aşacaksa satır atlanır ve sayılır.
- Önceki görüntü: `ops_yedek.Vaccinations_20261121_TakipDisi` (vade, işaret, not, zamanlar, `RowVersion`, yeni not).

## B: aşı saatini geri getirme (`02-asi-saati-geri-getir.sql`)

E-vet dönüştürücüsü 2026-11-18'den beri "Yapılacak" aşı görevinin başlangıç saatini `SonrakiAsiTarihi`'ne yazar
(`APPOINTMENT_CALENDAR_API_CONTRACT.md` §8.1). Pilotun aktarması daha önce yapıldı: vadeler günün 12:00'si (İstanbul), işaret `false`.

- **Eşleşme anahtarı:** E-vet aşı satırının kalıcı kimliği yok. Satır numarası yedekten yedeğe kayar, `HayvanNo` dönüştürücü
  sürümüne göre değişebilir. Anahtar, `SourceJson`'da duran `SahipAdSoyad`, `HayvanAdi`, `AsiAdi`, `UygulamaTarihi` değerlerinin
  SHA-256 özetidir (UTF-16LE, U+001F ayraçlı; SQL `HASHBYTES` aynı özeti `ImportBatchRows.SourceJson`'dan hesaplar). Değer dosyası
  yalnız özet, gün ve saat taşır. Yine de klinik verisinden türediği için depoya girmez.
- **Güncellenen satır:** aşı tablosu kaynak satırı (`[Table] = 3`), hedefi o partinin oluşturduğu aşı
  (`TargetEntityId = Vaccinations.Id`, `Vaccinations.ImportBatchId = BatchId`), kaynak satırın `SonrakiAsiTarihi` günü = dosyadaki gün,
  aşı iptal değil, `DueTimeSpecified = 0`, vadenin İstanbul günü = dosyadaki gün ve saati aktarmanın yazdığı **12:00 (09:00 UTC)**.
  Saat 12:00 değilse kayıt sonradan elle değişmiştir: dokunulmaz. Gün hiç değişmez.
- **Yazılan:** `DueAtUtc = gün + saat − 3 saat`, `DueTimeSpecified = 1`. Saat 00:00 da gerçek sayılır (§8.1, kullanıcı kararı
  2026-11-18); saat 12:00 ise yalnız işaret değişir.
- Önceki görüntü: `ops_yedek.Vaccinations_20261121_AsiSaati`.

### Değer dosyasını üreten araç

Ürünün kendi okuyucusunu çalıştırır (`ImportUploadReader` → `EVetBackupConverter`, profil E-vet, yedek + Hasta Listesi + Aşı Bilgi
raporları). Depoya proje olarak girmez; geçici bir klasörde kurulur:

1. Klasöre `asi-saat-araci.cs`'i `Program.cs` adıyla koy; backend'in `src/Backend.Veteriner.Application/bin/Release/net10.0/`
   altındaki `Backend.Veteriner.Application.dll` ve `Backend.Veteriner.Domain.dll`'i `lib/`'e kopyala (2026-11-18 dönüştürücüsünü
   içeren derleme).
2. `AsiSaatAraci.csproj`: `net10.0` konsol uygulaması; `lib/` altındaki iki dll'e `Reference` (HintPath) ve Application ile aynı
   sürümde `ClosedXML 0.105.1`, `Microsoft.Extensions.Options 10.0.14`, `Microsoft.EntityFrameworkCore.Relational 10.0.14`,
   `Ardalis.Specification 9.3.1`, `FluentValidation 12.2.0`, `Mediator.Abstractions 3.0.2`.
3. `dotnet run -c Release -- --yedek backup_2026_11_18_00_58.xlsx --hasta "Hasta Listesi_181126005756.csv" --asi "Aşı Bilgi_181126010306.csv" --simdi 2026-11-18T00:58 --cikti <klasör>`
   (`--simdi` yedeğin alındığı an, İstanbul). Çıktı: `02-asi-saati-degerleri.sql` (betiğin `DEGER_DOSYASI`'sı) ve `asi-saatleri.csv`.
   Konsola yalnız sayılar yazılır. Aynı anahtarda farklı gün/saat çıkarsa ikisi de atılır.

2026-11-18 yedeğinden (00:58) sonuç: 16 844 aşı satırı; 5 761'inde saatli sonraki tarih, bunların 5 760'ının saati 00:00 değil
(1 tanesi 00:00); belirsiz anahtar 0; değer dosyasında 5 761 satır.

## Yerel prova (2026-11-20)

- Geçici veritabanında (`VetinityVeriProva_<rastgele>`, gerçek sütun adları/türleri, sentetik veri) 17 adım, beklenmeyen sonuç 0;
  veritabanı sonda silindi. A: 1 yıldan eski (hedef), 1 yıl içinde, tam 1 yıl sınırı, sonraki dozla karşılanmış (tanımla, adla,
  `KEDİ`/`kedi`), iptal, içe aktarılmamış, vefat eden hayvan, notlu kayıt, ikinci klinik; kuru 3, `HEPSI` ile uygulama reddedildi,
  klinikle 2 satır değişti, diğerleri aynı, ikinci uygulama reddedildi, geri alma 2 satırı tam döndürdü, yinelenen geri alma 0.
  B: eşleşen ve aynı gün (14:30), 00:00 (gün korundu), 12:00 (yalnız işaret), kaynak günü farklı, vade günü farklı, saat zaten
  belirtilmiş, iptal, öğlen olmayan saat, başka partinin kaydı, dosyada olup kaynakta olmayan anahtar, ikinci klinik; uygulamada
  3 satır, geri almada sonradan elle değişen satır korundu.
- Yerel geliştirme kopyasında (`VetinityCommandDb`, 2026-11-12'de içe aktarılmış E-vet partisi; **yalnız kuru çalıştırma, hiçbir şey
  yazılmadı**): A gecikmiş 4 568, takipten çıkacak 3 375, gecikmiş kalacak 1 193, karşılanmış 89. B (2026-11-18 değer dosyası)
  5 761 anahtarın 5 490'ı eşleşti, 5 479 güncellenebilir, 11 vadesi boş. Bu kopya canlıdaki aktarmayla aynı değil; sayılar canlıyı
  göstermez, yalnız özet eşleşmesinin gerçek veride (Türkçe adlar) çalıştığını gösterir.

## Sabah adımları (sunucu; her uygulama adımından önce kullanıcı onayı)

Sıra **önce B, sonra A**: A'nın önceki görüntüsü saatli vadeyi tutsun, A geri alınırsa saat de geri gelsin.

1. Dosyaları sunucuya kopyala (kullanıcı): dört `.sql` betiği ve yerelde üretilen `02-asi-saati-degerleri.sql` → ör. `/root/veri-duzeltme/`.
2. **Yedek:** `/opt/vetinity/yedek.sh`; `tail -5 /var/log/vetinity-yedek.log` içinde `INFO: bitti` görülmeden devam edilmez.
3. Oturum: `sa` parolası komut satırına yazılmaz, `SQLCMDPASSWORD` ortam değişkeniyle verilir (`/root/.vetinity-sa`'dan;
   örn. `read -rs SQLCMDPASSWORD && export SQLCMDPASSWORD`). Kısayol:
   `sq() { /opt/mssql-tools18/bin/sqlcmd -S 127.0.0.1,1433 -U sa -C -I -d VetinityCommandDb -f 65001 -b -W -s '|' "$@"; }`
   `-I` zorunlu: sqlcmd `QUOTED_IDENTIFIER`'ı kapalı açar; `Vaccinations`'taki filtreli dizin yüzünden UPDATE "Msg 1934" ile
   düşer (2026-11-21'de B'nin ilk denemesi böyle düştü, `XACT_ABORT` ile hiçbir şey yazılmadı).
4. **B kuru:** `sq -i 02-asi-saati-geri-getir.sql -v UYGULA=HAYIR KLINIK_ID=HEPSI DEGER_DOSYASI=/root/veri-duzeltme/02-asi-saati-degerleri.sql -o b-kuru.txt`
   Bak: pilot kliniğin kimliği (kırılım tablosu), "güncellenecek" sayısı, "kaynak satırın günü farklı" / "vade günü farklı" az mı.
   Eşleşme beklenenden çok düşükse dur ve sor.
5. **B uygula (onaydan sonra):** aynı komut, `UYGULA=EVET KLINIK_ID=<pilot klinik>`, `-o b-uygula.txt`. Son satır `UYGULANDI: N`
   ve N kuru sayıya eşit olmalı.
6. **A kuru:** `sq -i 01-asi-takipten-cikar.sql -v UYGULA=HAYIR KLINIK_ID=<pilot klinik> -o a-kuru.txt`. "Panelde gecikmiş" ve
   "takipten çıkacak" sayılarını koordinatörün 1099'uyla karşılaştır; belirgin farkta dur ve sor.
7. **A uygula (onaydan sonra):** `UYGULA=EVET KLINIK_ID=<pilot klinik>`, `-o a-uygula.txt`.
8. Doğrula: panel takviminde 1 yıldan eski bir ay (gecikmiş sonraki aşı kalmamalı) ve yakın bir ay (saatler görünmeli); birkaç
   kaydın notu. Not: pano ve Raporlar özetindeki "gecikmiş aşı" sayacı yalnız planlı (`Scheduled`) aşıyı sayar
   (`VaccinationDueRule.IsOverdue`); içe aktarılan aşılar uygulanmış olduğundan orada hiç görünmez, gecikmiş hâlleri takvimdedir.
9. Geri alma gerekirse: `sq -i 01-asi-takipten-cikar-geri-al.sql -v UYGULA=HAYIR` (sonra `EVET`), B için `02-...-geri-al.sql`
   aynı biçimde. A'yı geri almak için B'yi geri almak gerekmez; ikisi de alınacaksa önce A, sonra B.

## Doğrulanmayanlar

- Canlı sayılar (1099 dahil) sayılmadı; canlıya bağlanılmadı. Yerel kopyanın sayıları (4 568 / 3 375) canlıdan farklı olabilir.
- Canlı aktarmanın hangi yedek ve dönüştürücü sürümüyle yapıldığı bilinmiyor; B'nin eşleşme oranı sabah kuru çalıştırmada görülür.
  Saklama süresi dolup `SourceJson`'u temizlenmiş satır eşleşmez.
- Linux `sqlcmd` (mssql-tools18) ile `:r $(DEGER_DOSYASI)` ve `-f 65001` yerelde (Windows ODBC sqlcmd 17) sınandı, sunucuda sınanmadı.
- `Turkish_CI_AS` karşılaştırması uygulamanın `tr-TR` büyük/küçük harf duyarsız karşılaştırmasına yakındır, birebir aynı olduğu
  kanıtlanmadı (yalnız adla karşılanma kuralında, tanımsız eski kayıtlarda devreye girer).
