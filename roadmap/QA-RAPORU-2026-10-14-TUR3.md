# QA Raporu — 2026-10-14, Tur 3

Test ajanı (QA). Ürün kodu değiştirilmedi; yalnız tarayıcıdan (Claude in Chrome, yeni sekme, kullanıcının açık oturumu, yalnız localhost) test edildi. Önceki turlar: [Tur 1](QA-RAPORU-2026-10-13.md), [Tur 2](QA-RAPORU-2026-10-13-TUR2.md).

## Test ortamı
- Frontend `http://localhost:4200` (`C:\FrontEnd\veteriner-frontend`, dal `feat/muayene-defteri-tek-sutun`; çalışma ağacında yalnız `subscription-access.utils.ts` değişikliği vardı, bana ait değil), backend `https://localhost:7173` (`...\Veteriner\...\Backend.Veteriner.Api.exe`, dal `main`). İkisi de test boyunca ayaktaydı; hiçbir sunucu başlatılmadı/durdurulmadı.
- `/health` ve `/health/ready`: ikisi de **200** (curl, 14.10.2026 ~04:3x).
- Oturum: tarayıcıda açık olan oturum kullanıldı; parola girilmedi, giriş yapılmadı, jeton okunmadı/yazılmadı.
- Pencere iç boyutu 1536×674. `resize_window` bu turda da uygulanmadı (iç boyut değişmedi). Dar düzen, sayfa içine 420 px'lik aynı kökenli iframe konarak simüle edildi (gerçek mobil cihaz değildir).
- Ekran görüntüleri: `C:\Users\DELL\.claude\projects\C--Vetinity-vetinity-product--claude-worktrees-upbeat-haslett-af0d96\37f6e0cb-0eb2-4d00-a020-d9b70fc63d4a\tool-results\mcp-claude-in-chrome-blob-<zaman damgası>-*.jpg`. Bulguda yalnız zaman damgası verildi (dosya adı bu damgayla başlar).
- Kullanıcı hesabının rolü teyit edilmedi; rol testleri yapılmadı.

## Veri değişiklikleri (yalnız TEST kayıtları)
| İşlem | Kayıt | Durum |
|---|---|---|
| Stok girişi | "TEST Parti Asi" +3 doz, seri `TEST-LOT-ESKI`, SKT 01.01.2026 (geçmiş), firma "TEST Firma", fatura `TEST-F-1` | **Kaldı** (silme/geri alma yok); parti "süresi geçmiş" |
| Muayene (taslak) | TEST QA Müşteri / TEST QA Hasta, id `ad10771f-6d14-4eeb-ab33-3157af7105e3`, şikâyet "TEST QA parti stok testi" | **Taslak olarak kaldı** (kesinleştirilmedi) |
| Uygulama | TEST Parti Asi 2 doz (otomatik → `TEST-LOT-1`) | **İptal edildi, stoğa iade**; parti bakiyesi 5 doza döndü |
| Gerçek veriye dokunuş | Yok. "maksut kamit" taslak muayeneleri ve diğer gerçek kayıtlar yalnız okundu |
| Tema | Koyu temaya geçilip açığa geri alındı | Eski haline döndü |
| Dışa aktarma | CSV ve Excel düğmeleri çalıştırıldı; dosyalar diske **indirilmedi** (blob yakalanıp okundu) | — |

## Test sonuçları
| # | Test | Sonuç | Not |
|---|---|---|---|
| 1 | Menü: açık hâl (238 px), grup başlıkları, aktif öğe rengi (yeşil), Bugün rozeti ("3", sr-only "bekleyen") | **Geçti** | |
| 1 | Menü: kapalı hâl (64 px simge sütunu), rozet simgeye biner | **Geçti** | Kapalıyken grup adı yok, yalnız çizgi ayırıcı (bilinen UX-009, bulgu saymadım) |
| 1 | Hamburger ile açık/kapalı geçiş, tercih `vetinity.menu.collapsed.<kullanıcı>` | **Geçti** | Menü öğesine tıklayınca ve tam sayfa yenilemede kapalı kaldı |
| 1 | Tooltip (kapalıyken sağda koyu balon, "Müşteriler") | **Geçti** | |
| 1 | Aktif öğe rengi (açık ve koyu tema) | **Geçti** | Raporlar yeşil |
| 1 | Dikey kaydırma yok | **Geçti** (kısmen) | 730 px'te yok; 674 px'te açık menüde var: M3-1 |
| 1 | 992 px altı çekmece (420 px iframe) | **Geçti** | Menü ekran dışında (`translateX(-280px)`), hamburger ile açılıyor, sayfa yatay taşmıyor (scrollWidth 405 ≤ 420); çekmece uzun ekran yüksekliği gerektiriyor: M3-1 |
| 1 | Kapalı menüde erişilebilirlik adı | **Doğrulanamadı** | M3-5 |
| 2 | Rapor Merkezi: "Kayıt defterleri" bölümü | **Geçti** | Yalnız Muayene ve Reçete defteri kartı var |
| 2 | Aşı / ilaç / narkotik defter ekranları | **Atlandı** | Yok (başka ajan geliştiriyor) |
| 2 | Muayene defteri: birleşik hücreler (sahip adı+tel+adres; hasta adı+tür·ırk·cinsiyet·yaş) | **Geçti** | Ekran: `1791941989564` |
| 2 | Muayene defteri: tarih filtresi (20.10.2025–14.10.2026 → 5 kayıt; 01.10–14.10 → 3 kayıt) | **Geçti** | |
| 2 | Muayene defteri: boş durum ("Bu aralıkta kayıt bulunamadı"; Yazdır pasif) | **Geçti** | Ekran: `1791942000155` |
| 2 | Muayene defteri: 366 gün aşımı | **Geçti** (kısmen) | Sunucu "Tarih aralığı en fazla 366 gün olabilir" diyor ama başlık "Veri alınamadı": M3-4. Ekran: `1791942006393` |
| 2 | Muayene defteri: sayfalama (25/sayfa, "1 - 3 / 3") | **Geçti** (kısmen) | Veri 1 sayfadan az; çok sayfalı davranış **doğrulanamadı** |
| 2 | Hekim sütunu yalnız sorumlu hekim | **Geçti** | Geliş kaydında hekim olan satır "Dr. Test Hekim", diğerleri "—". Kesinleşmiş TEST QA muayenesi "—" |
| 2 | Yazdır | **Geçti** (kısmen) | `window.print` çağrıldı (yakalandı); gerçek yazdırma önizlemesi **görülmedi** |
| 2 | CSV | **Geçti** (kısmen) | `muayene-defteri-20261014.csv`, `;` ayraçlı, 18 sütun (son "Veteriner Hekimin Adı Soyadı"), her satır 18 alan, hasta bilgisi sütunlara ayrık; BOM yok: M3-3 |
| 2 | Excel | **Geçti** (kısmen) | `muayene-defteri-20261014.xlsx` 7,5 KB blob üretildi; dosya **açılıp incelenmedi** |
| 2 | Reçete defteri | **Doğrulanamadı** | Seçilebilir en geniş aralıkta (20.10.2025–14.10.2026) kayıt yok; yalnız boş durum görüldü. Reçete oluşturma arayüzü satır içermediği için veri üretilmedi |
| 2 | Koyu tema bakışı (defter) | **Geçti** | Okunur; Ekran: `1791942577823` |
| 3 | Stok girişi formu: seri/lot, SKT, firma, fatura no/tarihi, geliş, depo çıkış, nakil, soğuk zincir | **Geçti** | Aşı ürününde seri+SKT "zorunlu" etiketi ve açıklama çıkıyor; ürün seçilince form yerleşimi kayıyor |
| 3 | Geçmiş SKT'li parti girişi | **Soru** | Engellenmedi: M3-2 |
| 3 | Ürün detayı "Partiler" tablosu (seri, SKT, kalan, firma, fatura, geliş, "Süresi geçmiş") | **Geçti** | |
| 3 | Uygulamada parti seçimi: "Otomatik — SKT'si en yakın uygun parti", önerilen parti ve kalan | **Geçti** | Süresi geçmiş parti listede soluk; tıklanınca seçilmedi (UI engeli). Ekran: `1791942482346` |
| 3 | FEFO | **Geçti** | Otomatik, geçmiş SKT'liyi atlayıp `TEST-LOT-1`'i seçti; uygulama satırında "Seri: TEST-LOT-1 · SKT: 31.12.2027" |
| 3 | Yetersiz bakiye (6 doz > uygun parti 5) | **Geçti** (kısmen) | Engellendi, kayıt oluşmadı; mesaj yanıltıcı: M3-6. Ekran: `1791942498087` |
| 3 | SKT geçmiş parti engeli (sunucu tarafı) | **Doğrulanamadı** | Yalnız arayüz denendi; arayüzü atlayıp sunucuya doğrudan istek atılmadı (jeton kullanılmadı) |
| 3 | Ters hareket (uygulama iptali, "Stoğa iade") | **Geçti** | Parti 3→5 doz'a döndü; Stok hareketleri'nde ters satır var |
| 3 | Stok hareketleri listesi | **Geçti** (kısmen) | Parti bilgisi yok, ters hareket "Bilinmiyor" tipinde: M3-7 |
| 4 | `/health`, `/health/ready` | **Geçti** | İkisi 200 |
| 9 | Konsol / ağ hatası izleme | **Yapılmadı** | Bu turda konsol ve ağ izleme açılmadı; 5xx görsel olarak görülmedi ama **doğrulanmadı** |

## Bulgular (önem sırasıyla)

Yüksek veya engelleyici bulgu yok.

### Orta
**M3-2. Süresi geçmiş partiye stok girişi uyarısız kabul ediliyor ve "eldeki stok"a dahil sayılıyor (ürün kararı sorusu)**
- Adımlar: Stok hareketleri → Yeni stok hareketi → TEST Parti Asi, Stok girişi, miktar 3, seri `TEST-LOT-ESKI`, SKT 01.01.2026 → Kaydet.
- Beklenen: geçmiş SKT için uyarı/engel (ya da en azından belirgin onay) ve "kullanılabilir" bakiyenin geçmiş partiyi saymaması.
- Gerçekleşen: kayıt oluştu, uyarı yok. Stok durumu/ürün detayı "Eldeki stok 8 doz" gösteriyor (3'ü süresi geçmiş; uygulanabilir yalnız 5). Uygulama sonrası bildirim "kalan stok 6 doz" geçmiş partiyi de sayıyor. Düşük stok uyarısı da geçmiş partiyi sayarsa yanlış güvence verir.
- Şiddet: orta (ürün kararı; klinik risk). Ekran: `1791942260437`, `1791942268211`, `1791942508244`.

**M3-3. CSV'de UTF-8 BOM yok (Excel'de Türkçe karakter bozulabilir)**
- Adımlar: Muayene defteri → CSV indir (blob yakalandı).
- Beklenen: `;` ayraçlı CSV'nin Excel'de doğru açılması (BOM'lu UTF-8) ya da bilinçli not.
- Gerçekleşen: blob `text/csv;charset=utf-8`, ilk karakter BOM değil. Excel'de açılmadığı için bozulma **doğrulanamadı**; bilinen davranış gereği riskli.
- Şiddet: düşük–orta.

### Düşük
**M3-1. Menü 674 px yükseklikte kaydırma çıkarıyor**
- Adımlar: 1536×674 pencere, menü açık, Bugün sayfası.
- Beklenen: dikey kaydırma yok (730 px'te yok, scrollHeight=clientHeight=646).
- Gerçekleşen: 674 px'te iç kaydırma (`overflow-y:auto`, 595 > 590), "Stok hareketleri" satırı alttaki Ayarlar çizgisinin altına sıkışıp yarı kesik. 420 px iframede çekmece de aynı satırı göstermiyor (kaydırma gerekir). Ekran: `1791941974610`, çekmece `1791942561583`.

**M3-4. 366 gün aşımı hatası "Veri alınamadı" + "Tekrar dene" olarak gösteriliyor**
- Adımlar: Defterde 01.01.2025–14.10.2026 → Filtrele.
- Gerçekleşen: başlık "Veri alınamadı", alt satır doğru mesaj, "Tekrar dene" düğmesi (aynı aralıkla tekrar hata verir). Excel/CSV düğmeleri bu hata ve boş sonuç durumunda **aktif** kalıyor (yalnız Yazdır pasif). Beklenen: hatalı aralıkta dışa aktarma pasif, tekrar dene yerine aralığı düzelt ipucu. Ekran: `1791942006393`.

**M3-5. Kapalı menüde bağlantıların erişilebilir adı yok (doğrulanamadı)**
- `read_page` kapalı menüde `link [ref_7] href=/panel/today` gibi adsız döndürdü; sayfa metninde adlar var (görsel olarak gizli). Etiket `display:none` ise ekran okuyucu adı göremez. Ekran okuyucuyla denenmedi.

**M3-6. Yetersiz bakiye mesajı yönlendirici değil**
- Adımlar: TEST Parti Asi uygulama, miktar 6 (uygun parti 5, geçmiş parti 3).
- Gerçekleşen: "Hiçbir parti bu miktarı tek başına karşılamıyor; miktarı azaltıp ayrı kayıt girin." Toplam uygun bakiye 5 olduğu için miktarı bölmek de karşılamıyor; "yetersiz bakiye (uygun 5 doz, süresi geçmiş 3 doz hariç)" daha doğru olur. Ekran: `1791942498087`.

**M3-7. Stok hareketleri listesinde parti bilgisi yok; ters hareket tipi "Bilinmiyor"**
- Liste yalnız Tarih/Ürün/Klinik/Tip/Miktar/Maliyet/Neden/Not. Seri, SKT, firma, fatura görünmüyor (yalnız ürün detayında). Uygulama iptali ters satırı "Bilinmiyor" rozeti taşıyor (Tur 2'de de iade satırı "Bilinmiyor" idi). Ekran: `1791942131396`.

**M3-8. Tarih seçici takvimi kapanmıyor**
- Defter ekranı (Filtrele'ye basınca), stok hareketi formu (SKT yazıp başka alana geçince), Yeni Muayene formu (tarih+saat): takvim paneli açık kalıyor, bazen iki panel aynı anda (tarih+saat listesi). DOM'da iki `.p-datepicker` `opacity:1;visibility:visible` kaldı. Ekran: `1791942023991`/`1791942241956`/`1791942346564`.

**M3-9. Telefon biçimi tutarsız (Tur 2 M-4 devam)**
- Defter ve muayene sayfalarında ham `905321119999`; müşteri/Bugün'de `+90 532 ...`. Resmi defterde ham tutulması bilinçli olabilir; karar gerek.

### Doğrulanamayan / yeniden üretilemeyen
**M3-10. Tarayıcı sekmesinde beklenmeyen gezinme ve menü tercihinin sıfırlanması**
- CSV/Excel/Yazdır düğmelerine basıp bir blob okuduktan sonra sekme kendiliğinden önce `/panel/examinations`, sonra `/panel/vaccinations`'a geçti ve `menu.collapsed` `true`'dan `false`'a döndü. O anda sekmeye kullanıcı ya da başka bir süreç dokunmuş olabilir; ya da `HTMLAnchorElement.click`'i susturan kendi test kancam yan etki yaptı. **Yeniden üretemedim** (sonraki denemelerde tercih kalıcıydı). Ürün hatası mı test artığı mı bilinmiyor.

## Denenmeyenler ve nedenleri
- Aşı/ilaç/narkotik defterleri: ekranlar yok.
- Reçete defteri satırları: veri yok (reçete oluşturma satırsız).
- Excel dosyasının içeriği, gerçek yazdırma önizlemesi, çok sayfalı sayfalama (veri az).
- Sunucu tarafında SKT geçmiş parti engeli ve doğrudan API istekleri (jeton kullanılmadı).
- Gerçek dar pencere (resize çalışmıyor); iframe simülasyonu yalnız defter sayfasında ve çekmecede; defter tablosunun 420 px'te yatay kaydırması ayrıca incelenmedi.
- Koyu temada menü/stok formları; yalnız defter ekranı koyuda bakıldı.
- Rol testleri; konsol/ağ hata izleme.
