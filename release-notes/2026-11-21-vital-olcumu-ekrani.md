# Sürüm notu: vital ölçümü ekranı (yatış, muayene, hasta kartı)

> **Durum:** yayınlandı, 2026-11-21 14:55 (panel `dd8ad7e2`). Yayın, testler ve canlı doğrulama: [panel yayın notu](2026-11-21-panel-vital-asi-saati.md). Bu dosya özelliğin içeriğini ve sınırlarını anlatır.
> Backend 2026-11-21 13:31'de yayınlandı ([sürüm notu](2026-11-21-vital-olcumu-posta-basligi.md)): uçlar, migration ve izin seed'i. Yeni izinler için kullanıcılar bir kez çıkış yapıp yeniden girmeli.

## Yayınlanan sürüm

| | Commit | Not |
|---|---|---|
| Panel (`vetinity-web`) | `dd8ad7e2` (main) | Önceki canlı sürüm `209307f8`. Dal `feature/vital-olcumu-ekrani` |

İçerik:
- `1174bcfb` veri katmanı: model, servis, değer ve zaman kuralları, hata metinleri.
- `c60249f0` eğilim bölümü (tasarım B · Eğilim).
- `64685255` yatış detayı, muayene ve hasta kartına bağlandı; zaman çizelgesinde "Vital ölçümü" türü, değişiklik geçmişi.
- `388c6109` sunucunun `Z`siz döndürdüğü zamanlar UTC olarak okunur (grafik 3 saat kaymaz); giriş satırında etiket taşması.
- `06f83e21` çok kısa aralıkta zaman ekseni boş kalmaz.

## Kullanıcı için ne değişti

- **Vital ölçümleri** bölümü üç yerde: yatış ayrıntısı, muayene ayrıntısı ve hasta kartı (**Vital ve kilo eğilimi**).
- **Hızlı giriş satırı** hep açık: ateş, nabız, solunum, kilo; boş alan kaydedilmez, ölçüm zamanı boşsa şimdi, Enter kaydeder.
- **Dört eğilim grafiği** aynı zaman ekseninde; son değer ve bir önceki ölçüme göre fark. Muayenedeki vital değerleri de grafikte (içi boş nokta).
- Noktaya tıklayınca ayrıntı: **Düzenle**, gerekçeli **İptal et**, **Değişiklikleri gör**. Altta tablo görünümü ve iptal edilenleri gösterme.
- Muayenenin ilk ölçümü eskisi gibi muayene formunda kalır; bölüm yeniden ölçümler içindir.
- Resepsiyon ölçümleri görür, ekleyemez. Kesinleşmiş muayeneye ölçüm gerekçeyle eklenir.
- Kullanıcı kılavuzu: [bölüm 7.1](../operations/KULLANICI-KILAVUZU-ROL-BAZLI.md#71-vital-ölçümü-ateş-nabız-solunum-kilo).

## Testler (gerçek çıktı)

- Panel tam takım (dalda, birleştirmeden önce; main ağacıyla aynı): 470 dosya, 3737 test geçti. Yayın oturumunun koşusunda 1 test düştü (tarih kutusu, tek başına geçiyor; ayrıntı panel yayın notunda).
- `ng build vetinity-web` başarılı. Değişen dosyalarda ESLint temiz.
- Yerelde gerçek backend'le (`main-be`, hekim test hesabı) denendi: hasta kartında ekleme, düzenleme, iptal, değişiklik geçmişi, iptal edilenleri gösterme; yatışta yatıştan önceki zamanın reddi ve yatışa bağlı ekleme; kesinleşmiş muayenede gerekçe alanı. 1280 ve 375 px.

## Bilinen sınırlar

- Ölçümü kimin girdiği bölümde yazmaz (uçlar yalnız kullanıcı kimliği döndürür); ad **Değişiklikleri gör** penceresinde görünür.
- Referans aralığı (tür bazlı normal değer) yok.
- Hasta kartındaki "Son kilo (muayeneden)" ve "Vital (son muayene)" satırları değişmedi; vital ölçümünü okumaz (backend sözleşmesi § 10, ayrı dilim).
- Hasta kartında ölçüm eklenince zaman çizelgesi kartı kendiliğinden yenilenmez; sayfa yenilenince görünür.

## Doğrulanmayanlar

- Resepsiyon (sekreter) hesabı, salt okunur kiracı ve koyu tema tarayıcıda denenmedi (birim testi var).
- İki kişinin aynı ölçümü aynı anda düzenlemesi (409) ve kesinleşmiş muayeneye bağlı ölçümün düzenleme reddi gerçek backend'le denenmedi (birim testi var).
- Canlıda oturum açılarak denenmedi (yayın oturumu dosyanın canlıda yüklendiğini doğruladı).
