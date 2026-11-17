# ADR-051 — Güncelleme aktarması: aynı programdan ikinci yedek

## Durum

**Önerildi (2026-11-17).** Görev koordinatör oturumundan geldi; kararlar rakip pratiğinden türetildi ("sor değil, öner"). Uygulama backend ve frontend `feature/guncelleme-aktarmasi` dallarında; canlıya uygulanmadı. Sözleşme: backend `docs/IMPORT_API_CONTRACT.md` bölüm 14.

## Bağlam

- Klinik eski programın (E-vet) yedeğiyle Vetinity'ye geçer, ama geçişte birkaç gün ya da bir hafta eski programda çalışmayı sürdürebilir. Ya da ilk yedek birkaç günlük eskidir. Sonra yeni bir tam yedek alıp yükler.
- Bugün ikinci yedek yeni dosya olduğu için içerik özeti korumasından geçer. Eşleşme ad + telefon, yoksa ad + e-posta ile yapılır (ADR-019 K4). Telefonu ve e-postası olmayan, adı ya da telefonu değişmiş müşteri ikinci kez oluşur. Yeni oluşan müşterinin hastaları ve bütün klinik geçmişi de ikinci kez yazılır.
- Klinik geçmişte mükerrer denetimi önizlemede vardır, ama yalnız hasta eşleşirse çalışır; uygulama anında yeniden denetlenmez.
- Açık bakiye yalnız yeni oluşan müşteride devir olarak açılır. Eşleşen müşterinin eski programdaki bakiyesi değişmişse fark kaybolur.
- Canlıdaki ilk pilot (DOGUSZONGULDAK) 16.11.2026'da bir yedek aktardı ve deneme amaçlı geri aldı; ikinci yükleme bekleniyor.

## Kararlar

1. **Kaynak kimliği kalıcı eşleme tablosunda saklanır.** Bir programın kendi numarası (E-vet protokol no: müşteri no, hasta no) uygulanan aktarmada oluşan ya da eşleşen kayda bağlanır. Bağ kiracı, partinin kliniği ve kaynak programla birlikte tutulur: aynı kiracının iki kliniği ayrı E-vet kullanıyorsa numaraları karışmaz. Satır kaydı (30 gün sonra temizlenir) ve varlık alanı (her müşteri/hastaya yalnız aktarma için alan) yerine ayrı tablo seçildi.
2. **Yalnız program profillerinde (E-vet, Kolayvet) kaynak kimliği kullanılır.** Genel Excel/CSV şablonundaki müşteri no kullanıcının dosyaya o an verdiği numara olabilir; kalıcı kimlik sayılmaz. E-vet'te aynı protokol no birden çok satırda geçiyorsa (dönüştürücü bunları `no#satır` diye ayırır) bağ yazılmaz: satır sırası sonraki yedekte değişir.
3. **Eşleşme önce kaynak kimliğiyle, bulunamazsa bugünkü kuralla yapılır.** Kaynak kimliğiyle bulunan kayıt eşleşir; adı, telefonu ya da sahibi değişmiş olsa da yeni kayıt açılmaz. Mevcut bilgiler değişmez (K4). Kaynak kimliği yalnız Vetinity'de hâlâ duran kayda bağlıysa geçerlidir; geri alınmış ya da silinmiş kaydın bağı yok sayılır ve yeni aktarmada yenilenir.
4. **Klinik kayıt mükerrer anahtarı:** aynı hasta + aynı gün + içerik özeti (içerik alanları, hekim, kilo, ateş). Kayıt türü bilerek anahtara alınmadı: mevcut kural aynı gün aynı içerikli türsüz ve türlü satırı tek kayıt sayıyor; tür aynı yedekten her seferinde aynı geldiği için ikinci yedekte ek koruma sağlamaz. Asıl açık hastanın eşleşmemesiydi; kaynak kimliği bunu kapatır. Önizlemede "daha önce aktarıldı, atlanacak" sayısı görünür. Uygulama anında da (eşleşen hastada) yeniden denetlenir. Eski programın klinik kaydı, aşısı ve randevusu için yedekte kalıcı numara yoktur; bunlarda içerik anahtarı kullanılır.
5. **Bakiye farkı otomatik değişmez, önerilir.** Eşleşen müşteride dosyadaki bakiye Vetinity'deki net bakiyeden (kalan borç − bağlanmamış ödeme − açık alacak, partinin kliniğinde) farklıysa önizlemede "bakiye farkı" listesi çıkar: müşteri, Vetinity'deki, dosyadaki, fark. Uygularken kullanıcı tek seçimle farkları açar ya da atlar; varsayılan atlamaktır. Açılırsa fark artıysa devir ücreti, eksiyse devir alacağı olur (ADR-048 T3 ile aynı yalıtım: ciro, gün sonu, kasa ve e-belge dışı). Önizlemede gösterilen tutar uygulanır.
6. **Önizlemede güncelleme özeti:** satırların yarısı ya da fazlası zaten Vetinity'de ise en üstte "Bu dosya önceki aktarmayla büyük ölçüde örtüşüyor: X yeni müşteri, Y yeni hasta, Z yeni aşı… gelecek; geri kalanı zaten var" özeti gösterilir.
7. **Geri alma kuralı korunur.** Eşleşen kayıt geri almada hiçbir zaman silinmez. Partinin eşleşen müşteriye açtığı bakiye farkı hareketi geri almada silinir; tahsis ya da mahsup görmüşse kalır. Kaynak bağları geri almada silinmez (3. madde gereği zararsızdır).
8. **Geriye dönük doldurma:** migration, satır verisi henüz temizlenmemiş partilerin oluşan/eşleşen müşteri ve hasta satırlarından bağları doldurur. Canlıdaki tek parti geri alındığı için orada oluşan kayıtlardan bağ çıkmaz; ilk gerçek bağlar ikinci yüklemede yazılır.

## Değerlendirilen seçenekler

- **Satır kaydında (`ImportBatchRow`) kalıcı sütun:** ek tablo gerekmezdi, ama satırlar partiye bağlıdır; aramada kiracının bütün partilerini taramak gerekir ve geri alma/temizlik kurallarıyla iç içe geçer. Reddedildi.
- **Müşteri ve hastada "eski program no" alanı:** ekranda gösterilebilirdi, ama tek kaynak varsayar ve iki kliniği ayırmaz. Reddedildi; gerekirse eşleme tablosundan okunabilir.
- **Bakiye farkını kendiliğinden uygulamak:** rakiplerde güncelleme aktarması bakiyeyi ezmez; klinik iki programda birden tahsilat almışsa yanlış borç oluşur. Reddedildi.

## Sonuçlar

- İkinci yedek mükerrer müşteri, hasta ve klinik kayıt üretmez; yalnız yeni gelenler eklenir.
- Telefonu ya da e-postası olmayan müşteri de ikinci yüklemede eşleşir (ilk yükleme bağı yazdıysa).
- Bakiye farkı görünür olur, kaybolmaz; karar kliniğindir.
- Yeni tablo için migration gerekir (canlıya uygulama kullanıcı onayıyla).
- Bilinen sınır: aynı protokol no'yu birden çok kayıtta kullanan E-vet satırları ve Genel şablon ikinci yüklemede bugünkü kurala düşer.

## Uygulama notu (2026-11-17)

- Backend `feature/guncelleme-aktarmasi`: `089c0017` (sözleşme bölüm 14), `04be90b6` (tablo + migration `AddImportSourceLinks`, geriye dönük doldurma), `d7a26f61` (eşleşme, bakiye farkı, önizleme özeti, uygulama anı klinik kayıt denetimi), `54521bc3` (geri almada fark hareketi), `d074aa78` (testler), `6aa2d267` (sözleşme düzeltmesi).
- Frontend `feature/guncelleme-aktarmasi`: `d96a0aaf` (özet), `3f5b88ff` (bakiye farkı seçimi, geri alma satırı), `db106994` (testler).
- Bilinen sınır: hiç yeni kayıt olmayan, yalnız bakiye farkı taşıyan dosya uygulanamaz (`canCommit` yeni kayıt ister). Gerekirse ayrı karar.
- Push, merge, canlı DB migration'ı yapılmadı.
