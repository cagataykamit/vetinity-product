# ADR-019 — Veri içe aktarma (müşteri, hasta, aşı geçmişi)

## Durum

**Kabul edildi (2026-10-14, kullanıcı: "rakip pratiği/önerilere göre karar ver, bana sorma").** Kaynak: backend `docs/ASAMA9_IMPORT_DESIGN.md` bölüm 12 (K1–K12, hepsi önerilen cevapla). Kapsam: [ADR-014](ADR-014-pilot-and-production-operations.md) K8 (müşteri + hasta + aşı geçmişi; muayene/ödeme ilk sürümde yok). **Gerçek pilot dosya biçimi ve KVKK uzmanı çıktısı doğrulanmadı**; ilgili kararlar pilot klinik dosyası görüldüğünde gözden geçirilir.

## Kararlar

| # | Konu | Karar |
|---|---|---|
| K1 | Dosya biçimi | **Şablon + sütun eşleme:** klinik kendi Excel'ini yükler, sistem başlıkları tahmin eder, kullanıcı düzeltir. İlk sürüm: üç sayfalı şablon (müşteri / hasta / aşı); düz liste desteği pilot dosyası görülünce. |
| K2 | Hatalı satır | Doğru satırlar aktarılır, hatalılar atlanıp raporlanır (düzeltilip tekrar yüklenebilir; geri alma var). |
| K3 | Eski aşıların hatırlatma e-postaları | **Hiçbiri otomatik gitmez**; yönetici sayıyı görüp "hatırlatmaları aç" derse gider (gölge kullanım sonrası ve KVKK teyidiyle). |
| K4 | Aynı müşteri (aynı ad + telefon) | Mevcut müşteriyle eşleşir, yeni oluşmaz; hayvanlar ona bağlanır (tekrar yükleme güvenli, mevcut bilgi ezilmez). |
| K5 | Geçersiz/sabit hat telefonu | Telefonsuz aktarılır, raporda uyarı + özgün numara. |
| K6 | Bilinmeyen tür/aşı adı | İlk sürümde yeni tanım **oluşturulmaz**; klinik önce Ayarlar'dan ekler, yeniden doğrular ya da satır atlanır. |
| K7 | Geri alma | Bağı olan (geliş/ücret/muayene…) kayıt varsa hiçbir şey silinmez; kullanıcıya liste gösterilir. İsteğe bağlı: "bağı olanlar kalsın, gerisi silinsin". |
| K8 | Yetki | Yalnız yönetici düzeyi (`Imports.Read/Manage/Commit`). |
| K9 | Önizleme/hata dosyası saklama | İşlem bittikten 30 gün sonra silinir (sayılar ve özet kalır); KVKK danışmanı farklı süre derse değişir. |
| K10 | Aynı mikroçip iki hayvanda | Hata (satır aktarılmaz). |
| K11 | Çalışma biçimi | Arka plan işi: sekme kapansa da sürer, ilerleme ekranda izlenir. |
| K12 | Yaş sütunu | İlk sürümde desteklenmez (tahmini doğum tarihi uydurulmaz); yaş varsa `Not`'a düşer. |

## Sonuçlar

- Dilimler (backend `ASAMA9_IMPORT_DESIGN.md` bölüm 11): B1 temel + migration, B2 okuma/eşleme, B3 doğrulama/kuru çalıştırma, B4 uygulama (arka plan), B5 geri alma/temizlik, F1 frontend sihirbaz, T deneme/performans.
- Yeni izinler (`Imports.*`) ve migration yerel dev veritabanına doğrulanarak uygulanır; paylaşılan/üretim için ayrı onay.
- Riskler: pilot dosya biçimi tahminden farklı olabilir (R3), toplu hatırlatma e-postası (R1, K3 ile kapalı), outbox birikimi → sağlık 503 (R4, geri basınç).

## Ek karar (2026-10-14, kullanıcı: "baştan arka plana alalım")

- **K13 Doğrulama çalışma biçimi:** doğrulama (kuru çalıştırma) de K11 gibi **arka plan işi** olur: kullanıcı "Doğrula"ya basınca iş kuyruğa alınır, ekranda ilerleme izlenir, sekme kapansa da sürer; senkron istek zaman aşımı riski kalkar. Gerekçe: T ölçümünde 5.000 müşteri / 8.000 hayvan / 20.000 aşı için doğrulama ~38 sn; pilot dosya boyutu bilinmiyor. Uygulama T performans düzeltmesi (karesel ikinci parti doğrulaması) birleştikten sonra backend + frontend dilimi olarak yapılır; uç sözleşmesi geriye dönük kırılmayacak şekilde (durum/ilerleme B4 ilerleme ucu deseniyle) tasarlanır.

## Ek (2026-11-10) — tam geçiş

Kapsam [ADR-048](ADR-048-tam-veri-gecisi.md) ile genişledi: klinik geçmiş (salt okunur eski program kaydı), açık bakiye (devir ücreti), hesap hareketleri (salt okunur), gelecek randevular, ürün ve hizmet kartları. K1–K13 aynen geçerli; K3 randevu hatırlatmalarını da kapsar; K7 yeni kayıt türleri için ADR-048 "Geri alma" bölümüyle yeniden yazıldı (partinin kendi kayıtları bağ sayılmaz, diğer her bağ engeldir).

## Ek (2026-11-16) — geri alma süresi ve sade liste

Kullanıcı kararı (2026-11-16). Canlıda ilk gerçek aktarma (E-vet yedeği, binlerce müşteri/hasta/aşı) sonrası iki risk görüldü: geri alma süresizdi, aylar sonra klinikte dokunulmamış binlerce kayıt tek tıkla silinebilirdi; geri alınmış deneme partileri listeyi kalabalıklaştırıyordu.

- **K7 eki — geri alma süresi:** geri alma uygulamadan sonra **30 gün** açık (2026-11-17 eki ile **15 gün**); süre dolunca aktarma **kesinleşir**. Süre uygulama anından (yarıda kalan uygulamada son doğrulama anından) sayılır ve bütün geri alınabilir durumlara uygulanır. Yarım kalmış geri alma (kısmen geri alınmış ya da hatayla durmuş) süre dolunca **yeniden denenemez**: kalan kayıtlar bağı olduğu için korunmuş ya da süre boyunca kullanılmıştır; onları sonradan silmek bu kuralın önlediği şeydir. Başlamış geri alma işi süre dolsa da biter. K9'daki 30 günlük satır verisi temizliği ayrı kuraldır.
- **Liste:** içe aktarma geçmişi varsayılan olarak yalnız geçerli partileri gösterir; geri alınan, silinen ve süresi dolan taslaklar "Durum" filtresinden ("Tümü" ya da kendi durumu) görülür.
- Kural tek yerde (backend domain); uç ayrıntısı backend `docs/IMPORT_API_CONTRACT.md` bölüm 7.5, 7.12 ve 9.1. Panelde süre içindeki partide son tarih, dolmuşta "Kesinleşti" görünür.

## Ek (2026-11-17) — geri alma süresi 15 gün

Kullanıcı kararı (2026-11-17): "30 gün çok uzun, 15 gün yapalım." Geri alma uygulamadan sonra **15 gün** açık; kural ve diğer ayrıntılar 2026-11-16 ekiyle aynı. K9'daki 30 günlük satır verisi saklaması değişmedi (ayrı kural). Süre backend'de tek sabittir; aynı süreye bağlı her kural (ör. güncelleme aktarmasının "geri alma süresi dolunca" adımı) bu sabiti okur, ayrı sayı yazmaz.

Panel kalan günü öne çıkarır, kesin tarih yanında durur: listede "12 gün daha geri alınabilir · 2 Aralık 15:57'ye kadar", son günde vurgulu "Bugün son gün"; geri al sayfasında "Bu aktarmayı 12 gün daha geri alabilirsiniz (2 Aralık 2026, 15:57'ye kadar)"; aktarmadan önce "Aktarmadan sonra 15 gün içinde geri alabilirsiniz". Gün İstanbul takvim gününe göre sayılır: son an yarınsa "1 gün daha", bugünse "bugün son gün".
