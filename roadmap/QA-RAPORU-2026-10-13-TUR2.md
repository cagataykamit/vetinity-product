# QA Raporu — 2026-10-13, Tur 2

Test ajanı (QA). Kod değiştirilmedi; yalnız tarayıcıdan (Claude in Chrome, kullanıcının açık oturumu, yalnız localhost) test edildi. Önceki tur: [QA-RAPORU-2026-10-13.md](QA-RAPORU-2026-10-13.md).

## Test ortamı
- Frontend `http://localhost:4200`, backend `https://localhost:7173` (çalışıyordu; test boyunca 5xx görülmedi).
- Pencere iç boyutu 1536×730. `resize_window` yine uygulanmadı (iç genişlik 1536 kaldı); dar düzen, sayfa içine 400 px'lik aynı kökenli iframe konarak simüle edildi (medya sorguları iframe genişliğine göre çalışır; gerçek mobil cihaz değildir).
- Rol: oturumdaki mevcut kullanıcı. Başka rolle giriş yapılmadı, çıkış yapılmadı, ayar/parola değişmedi (açık tema tercihi koyuya çevrilip geri alındı). Rol testleri **denenmedi**.
- Saat: test sırasında yerel saat ≈ 19:05–19:30 (13.10.2026).
- Ekran görüntüleri yerel oturum klasöründedir: `C:\Users\DELL\.claude\projects\C--Vetinity-vetinity-product--claude-worktrees-vigilant-varahamihira-d4a0b3\961f583a-6189-4e5d-9b57-ec59bf23abe5\tool-results\` altında `mcp-claude-in-chrome-blob-<kod>.jpg` (bulguda kod verildi).
- Konsol hatası izleme aracı oturumun yalnız son bölümünde (raporlar, tedavi formu, tema) çalıştı; önceki ekranlar için konsol durumu **doğrulanamadı**. Ağ tarafında 4xx/5xx yalnız kendi `fetch` denemelerimden (jeton başlıkta olduğu için 401) geldi, uygulama kaynaklı değil.

## Veri değişiklikleri (yalnız TEST kayıtları)
| İşlem | Kayıt | Durum |
|---|---|---|
| Muayene oluşturuldu | "TEST QA Müşteri" / "TEST QA Hasta" (id `1712803b-0e6f-4ad7-b7a2-b07fee73e308`), şikâyet "TEST QA muayene şikâyeti" | **Kesinleştirildi**, kalıcı (geri alınamaz). Ek not eklendi (kalıcı) |
| Ürün oluşturuldu | "TEST QA Ürün" (₺50, Adet) | Kaldı (silme yok). Hareketler: giriş +5, uygulama −2, iade +2, sonradan uygulama −1, zarar yazma. **Son stok: 4** |
| Uygulama kayıtları | 2 Adet (taslakta) → "Stoğa iade" ile iptal; 1 Adet (kesinleştirme sonrası, gerekçeli) → "Zarar yaz" ile iptal | İki kayıt da iptalli olarak muayenede duruyor |
| Lab istemi | "TEST QA kan sayımı" | İstendi → **Sonuçlandı** ("TEST sonuç A"); iptal edilemedi (arayüz yok, bkz. O-1) |
| Yatış | "TEST QA yatış" (TEST Kafes 1→2, giriş notu, bakım talimatı) | **Taburcu edildi** (kapalı) |
| Ücret | "TEST QA ücret" ₺20 (TEST Mustafa Aydın / Zeytin) | **İptal edildi** |
| Ödeme | ₺20 (aynı müşteri, Bugün'den) | **İptal edildi** |
| **Yanlışlıkla** | TEST Mustafa Aydın / Zeytin geliş kaydı (12.10 01:32) | Satır kayması yüzünden "Başlat"a basıldı: **Bekliyor → Devam ediyor** oldu; geri alma yolu görmedim. Koordinatör bilsin |
| Tedavi | Kesinleşmiş muayeneye adresle ekleme denemesi | Sunucu **engelledi**, kayıt oluşmadı |

## Test sonuçları
| # | Test | Sonuç | Not |
|---|---|---|---|
| 1 | Menü: gruplar (Klinik/Para/Stok açılır-kapanır), Bugün/Özet/Ayarlar hizası, aktif vurgu | **Geçti** | Raporlar Para grubunda; aktif öğe tüm rotalarda doğru vurgulanıyor |
| 1 | Menü kaydırmasız sığma | **Kaldı (düşük)** | M-1 |
| 1 | Sayfa başlığı üst kategori etiketi / sekme başlığı | **Geçti** (kısmen) | M-2 |
| 1 | Global arama: `Ctrl+K`, `/`, müşteri/hayvan/telefon, Türkçe harf (ozturk→Öztürk), boş sonuç, <2 karakter, ↓+Enter ile gezinme, Esc | **Geçti** | A-1 (odak gecikmesi) |
| 1 | Arama: mikroçip, hata durumu | **Denenmedi** | Mikroçipli test verisi yok; hata simüle edilmedi |
| 1 | `/panel` yönlendirmesi | **Doğrulanamadı** | Bugün'e gitti; kullanıcı yönetici düzeyindeyse karar D-M2 Özet diyor (M-3) |
| 1 | Eski adresler (`/panel/species`, `/breeds`, `/product-categories`) | **Geçti** | `/panel/settings/definitions/...` adreslerine yönleniyor |
| 1 | 404 sayfası | **Geçti** | Artık panel içinde (önceki D-7 giderilmiş); sekme başlığı için M-2 |
| 2 | Kesinleştirme (onay diyaloğu, uyarı metni, "Kesinleşti" + kim/ne zaman) | **Geçti** | |
| 2 | Kesinleşmiş: Düzenle/Tedavi/Reçete/Aşı düğmeleri gizli, açıklayıcı mesaj | **Geçti** | Lab, Yatış, Ödeme düğmeleri açık kalıyor (T-1) |
| 2 | Ek not (gerekçe 5–500 zorunlu, kalıcılık uyarısı, kullanıcı+saat) | **Geçti** | |
| 2 | Adresle kesinleşmiş muayeneye tedavi ekleme (sunucu kilidi) | **Geçti** | Mesaj: "Bu muayene kesinleştirilmiş; bağlı kayıt eklenemez veya değiştirilemez…" (form dolduktan sonra, öncesinde uyarı yok: düşük) |
| 2 | "Oluştur" formlarında bağlam (Tedavi/Reçete/Lab/Ödeme) | **Geçti** | Müşteri, hayvan, muayene dolu ve kilitli (önceki O-2 giderilmiş). Yatış formu istisna (T-1) |
| 3 | Taslakta uygulama ekle, stok düşer | **Geçti** | 5→3; "Uygulama kaydedildi; kalan stok 3 Adet." Stok Durumu iade sonrası 5 gösterdi |
| 3 | Yetersiz stok engeli | **Geçti** | Miktar 10 > 5: anlaşılır mesaj, kayıt oluşmadı |
| 3 | Çift tıklama | **Geçti** | Ağda tek POST (201), tek kayıt |
| 3 | İptal: "Stoğa iade" ve "Zarar yaz" (gerekçe zorunlu) | **Geçti** | İade → stok 5; zarar → stok geri artmadı (mesaj açık) |
| 3 | Kesinleşmiş muayenede gerekçeli sonradan ekleme + rozet | **Geçti** | "Kesinleştirmeden sonra eklendi / Gerekçe: …"; stok 5→4 |
| 3 | İptal edilenlerin gizlenmesi | **Soru** | İptalliler soluk satır + rozetle listede kalıyor, gizleme anahtarı yok (A-2) |
| 4 | Reçete satırı ekle/sil, katalog ürünü seçimi | **Kaldı** | Reçete formunda satır bölümü yok (yalnız Başlık/İçerik): arayüz henüz yok (R-1) |
| 4 | Eski serbest metin reçete açılışı | **Denenmedi** | Listede eski reçete yoktu |
| 5 | Sonuçsuz lab istemi oluştur | **Geçti** | Durum "İstendi"; oluşturma sonrası "Kayıt güncellendi." (L-3) |
| 5 | Sonuç gir (İstendi→Sonuçlandı), rozetler | **Geçti** | Düzenleme adresi `/edit` ile; "Değerlendirme bekliyor" rozeti yeni sonuçta var. Gelecek saat reddi doğru ("06.10–13.10 arasında") |
| 5 | Durum süzgeci | **Geçti** (kısmen) | Varsayılan "İptaller hariç" var; diğer seçenekler denenmedi |
| 5 | İki sekmede çakışma (409) ve "güncel kaydı yükle" | **Geçti** | Uyarı bandı çıktı, yazılan metin korundu; "Yazdıklarımı atıp güncel kaydı yükle" sunucudaki değeri getirdi |
| 5 | Lab iptali (gerekçeli) | **Kaldı** | Arayüzde iptal ve "Düzenle/Sonuç gir" bağlantısı yok (L-1) |
| 5 | Kesinleşmiş muayenede lab | **Geçti** | Düğme açık, oluşturma ve sonuç girişi çalıştı; muayenede "Bağlı lab sonuçları" listeliyor |
| 5 | Eski kayıtlarda "değerlendirme bekliyor" rozeti yok | **Denenmedi** | Eski lab kaydı yok |
| 6 | Yatış oluştur/düzenle (konum, giriş notu) | **Geçti** | Detay ve Bugün "Aktif yatışlar" (süre, planlı taburcu, "Yatış detayı") doğru |
| 6 | Yatış–geliş bağı, muayene bağı | **Geçti** (kısmen) | Kesinleşmiş muayene seçilemez, açıklama var; TEST QA Hasta'nın bugün gelişi yok, "Geliş (bugün)" bağı denenmedi |
| 6 | Taburcu; taburcu notu giriş notunu ezmiyor | **Geçti** | Giriş notu "TEST giriş notu", taburcu notu ayrı |
| 6 | Bakım talimatı (ekle/düzenle bağlantısı) | **Geçti** | İzinler jetonda var; ekleme çalıştı, "Düzenle" bağlantısı görünüyor |
| 6 | Planlı taburcu < yatış hatası | **Geçti** (kısmen) | Hata var ama mesajı saat içermiyor (Y-1) |
| 6 | Saat atlama mesajı | **Denenmedi** | Taburcu'da saatsiz giriş ayrıca denenmedi (Y-1 gözlemi dışında) |
| 6 | İki sekmede yatış çakışması | **Denenmedi** | Süre |
| 7 | Bugün'den "Ödeme al" → ödeme formu bağlamı | **Geçti** | Müşteri dolu; ücret yoksa "önce ücret ekleyin" uyarısı; ücret varsa satır ve "Tamamı" |
| 7 | Ödemenin hayvan gösterimi | **Geçti** | Ücrete hayvan bağlıysa ödeme detayında "Hayvan: Zeytin" (önceki O-1 giderilmiş). 03:30 ₺100 eski kaydı hâlâ hayvansız |
| 7 | "Birden fazla hayvan" gösterimi | **Denenmedi** | Çok hayvanlı ücret oluşturulmadı |
| 7 | Ücret oluştur, Bugün tutarları, ödeme iptali (gerekçeli), ücret iptali | **Geçti** | Bugün satırı ₺20/₺0/₺20 göstermiş, müşteri borcu yansıdı; iptal sonrası liste temiz |
| 7 | Ücret düzeltme | **Denenmedi** | Bu turda (önceki turda geçmişti) |
| 8 | Rapor Merkezi hub | **Geçti** | 5 kart, izne göre; Randevu/Muayene/Aşı/Ödeme/Borç |
| 8 | Raporlar açılıyor, "← Raporlar" bağlantısı | **Geçti** | |
| 8 | Dışa aktarma (CSV ve Excel) | **Geçti** | Beş raporda da düğmeler `export` ve `export-xlsx` uçlarına istek attı, hepsi 200. Dosya içeriği açılıp incelenmedi |
| 8 | Borç raporu | **Geçti** | Altı müşteri, toplam ₺8.369,90 (satır toplamıyla uyumlu); telefon biçimi için M-4 |
| 8 | Ödeme raporu toplamı | **Geçti** | 6 kayıt, ₺2.700 (kalemlerle uyumlu); iptalli ödemeler hariç |
| 8 | Filtre alanları | **Geçti** (kısmen) | Alanlar görüldü; tarih/durum filtresi kombinasyonları ayrıca denenmedi |
| 9 | Konsol hataları | **Kısmen** | Yalnız oturumun son bölümünde izlendi: hata yok |
| 9 | Ağ 4xx/5xx | **Geçti** | Uygulama kaynaklı yok |
| 9 | Türkçe karakter / tarih / ₺ biçimleri | **Geçti** | |
| 9 | Açık/koyu tema | **Geçti** (kısmen) | Koyu temada okunur; gri düğme/sekme kontrastı düşük (M-5) |
| 9 | Dar pencere | **Kaldı (simülasyonla)** | M-6 |
| 9 | Diyalog açılınca sayfa kayması | **Geçti** (kısmen) | Uygulama/ek not/iptal diyaloglarında belirgin kayma gözlenmedi; Taburcu diyaloğu için Y-2 |

## Bulgular (önem sırasıyla)

### Orta
**L-1. Lab detayında eylem yok (düzenle/sonuç gir/iptal)**
- Adımlar: Lab sonuçları → kayıt → Detay.
- Beklenen: "Sonuç gir/Düzenle" ve gerekçeli "İptal et" eylemleri.
- Gerçekleşen: Detay sayfasında yalnız "Muayene kaydına git", müşteri ve hayvan bağlantıları var; listede de yalnız "Detay". Sonuç girişi yalnız `/panel/lab-results/{id}/edit` adresi elle yazılınca açılıyor (çalışıyor). Gerekçeli iptal için ekran hiç bulunamadı. İzin eksikliği mi (jeton) arayüz eksikliği mi **doğrulanmadı**; çıkış-giriş gerekebilir.
- Ekran: `mcp-claude-in-chrome-blob-1791908092475-ualpqu.jpg`.

**R-1. Reçete formunda satır bölümü yok**
- Adımlar: muayene → Reçete Oluştur (veya `/panel/prescriptions/new`).
- Beklenen: reçete satırı ekle/sil, katalog ürünü seçimi (Aşama 5 Dilim 3).
- Gerçekleşen: yalnız Başlık ve İçerik. Frontend dilimi gelmemiş olabilir; ürün "denenmedi" saymak yerine "arayüz yok" yazıldı.

**M-6. Dar ekranda Bugün tablosu kullanılamaz (simülasyon, 400 px)**
- Adımlar: 400 px genişlikte `/panel/today`.
- Beklenen: sütunlar okunur, eylem düğmeleri erişilebilir.
- Gerçekleşen: menü hamburgere iniyor, sayfa yatay taşmıyor (iyi); ama "Sahip/Hekim/Durum" başlıkları üst üste biniyor, hücreler kırpılıyor, "Muayene aç/Başlat" sütunu yalnız tablo içi yatay kaydırmayla ulaşılıyor. Dönüştürülmüş bir kart düzeni yok.
- Ekran: `mcp-claude-in-chrome-blob-1791908972938-bni5e0.jpg`.

**M-3. (Doğrulanamadı) Yönetici girişinde `/panel` Bugün'e gidiyor**
- Karar D-M2: Resepsiyon/Hekim → Bugün, Yönetici → Özet. Oturumdaki kullanıcının rolü bu testte teyit edilmedi (önceki tur "yönetici düzeyi" dedi). Kullanıcı yöneticiyse beklenen Özet. Kullanıcı kontrol etsin.

### Düşük
**M-1. Menü kaydırmasız sığma:** 730 px yüksekte tüm gruplar açıkken kenar çubuğu içeriği 717 px (kutu 618 px) → iç kaydırma çıkıyor; Klinik ve Para açık + Stok kapalıyken sığıyor. İlk açılışta Stok açık gelince 6 px taşma. Daha uzun ekranda sorun olmayabilir.

**M-2. Başlık/etiket tutarsızlıkları:** (a) Menüde "Özet", sayfa başlığı "Operasyon Özeti". (b) 404 sayfasında sekme başlığı önceki sayfada kalıyor (SPA içinde gidince "Ürün kategorileri"; tam yüklemede genel başlık). (c) "Stok hareketleri" kırıntısı "← Ürünler / Stok". (d) Rapor sayfalarının hepsinde üst etiket "Para" (Randevu/Muayene/Aşı raporu dahil); menüde Raporlar Para altında olduğundan tutarlı ama içerik para değil. (e) Menüdeki "Stok durumu" yazımı: Menü "Stok Durumu", sayfa "Stok durumu".

**M-4. Telefon biçimi tutarsız:** Borç raporunda ve "Yeni Muayene" hasta kartında ham `905321110004`, aramada ve Bugün'de `+90 532 111 00 04`.

**M-5. Koyu tema kontrastı:** "Yanlış işaretlenenler" sekmesi, "Yenile" ve "Başlat" düğmeleri gri üstüne gri, düşük kontrast. Ekran: `mcp-claude-in-chrome-blob-1791909015117-51lljs.jpg`.

**A-1. Ctrl+K arama odağı gecikmeli:** Kısayolla açılan diyalogda odak ~yarım sn sonra girişe geçiyor; hemen yazılan ilk karakterler kayboluyor ("TEST" yazıldı, kutu boş kaldı). `/` ile aynı.

**A-2. (Soru) İptal edilen uygulamalar:** Muayene sayfasında iptalliler soluk satır, "İptal / Stoğa iade edildi / gerekçe" rozetiyle listede kalıyor (istek `includeVoided=true`). Görev listesi "gizlenmesi" diyor; ürün beklentisi "varsayılan gizli" ise gizleme/gösterme anahtarı yok.

**A-3. Uygulama diyaloğu doğrulaması:** Ürün seçilince Miktar için "0'dan büyük, en fazla 3 ondalıklı…" hatası kullanıcı yazmadan görünüyor. Sunucudan gelen "stok yetersiz" hatası, miktar düşürülünce de ekranda kalıyor (önceki D-2 ile aynı kalıp).

**T-1. Kesinleşmiş muayenede "Yatış Başlat" açık ama bağlanmıyor:** Düğme formu açıyor, "Bağlı muayene" boş (açıklama: kesinleşmiş muayeneye yatış bağlanamaz). Tutarlı ama düğme gizli/pasif olsa daha az kafa karıştırır. Ayrıca tedavi formu adresle açılınca kilit uyarısı ancak Kaydet'ten sonra çıkıyor.

**Y-1. Yatış tarih mesajları:** Planlı taburcu 13.10.2026 18:00 (yatış 19:00) için "Tarih 13.10.2026 ile 13.10.2031 arasında olmalıdır." çıkıyor, mesaj saati göstermediği için hatalı görünmüyor. Taburcu diyaloğunda yatıştan önceki saat yazılınca alan sessizce temizlenip yalnız "Zorunlu." çıkıyor. Ekran: `mcp-claude-in-chrome-blob-1791908430769-llucu8.jpg`, `mcp-claude-in-chrome-blob-1791908543377-vhk08t.jpg`.

**Y-2. Taburcu diyaloğu:** Diyalog açılınca tarih seçici kendiliğinden açılıp diyaloğun üstüne biniyor (ilk görüntüde başlık ve alanlar kapanıyor). Ekran: `mcp-claude-in-chrome-blob-1791908519086-iliry3.jpg`.

**L-3. Başarı mesajı metni:** Lab istemi ve yatış *oluşturulunca* "Kayıt güncellendi." yazıyor ("oluşturuldu" beklenir).

**F-1. Bugün satır eylem menüsü hayalet kalıyor:** "…" menüsünden "Ödeme al" ile başka sayfaya geçilince "Ödeme al / Düzelt" menüsü yeni sayfanın sağ altında asılı kalıyor (DOM'da `menu` olarak duruyor; Ödeme, Yeni Ücret, Ücretler ve Ödeme detayı sayfalarında görüldü). Ekran: `mcp-claude-in-chrome-blob-1791908636385-2zlblt.jpg`. Ayrıca Bugün satır yüksekliği ücret eklenince değiştiği için eylem düğmesi kayıyor (yanlış satıra tıklama riski; ben Zeytin'i bu yüzden yanlışlıkla başlattım).

**F-2. "Ödeme al"→"ücret ekleyin" bağlamı:** Ödeme ekranındaki "ücret ekleyin" bağlantısı yalnız `clientId` taşıyor; geliş (`visitId`) ve hayvan Yeni Ücret'te boş geliyor, elle seçmek gerekiyor. "Geliş (bugün)" etiketi 12.10 tarihli kaydı da listeliyor.

**G-1. Stok menü öğeleri bir kez eksik göründü:** İkinci sekmede ilk açılışta kenar çubuğunda "Stok Durumu/Stok hareketleri" yoktu; yeniden üretemedim (geçici yükleme/izin sırası olabilir). Doğrulanmadı.

## Denenmeyenler ve nedenleri
- Rol testleri — talimat gereği kullanıcıya bırakıldı.
- Reçete satırları, eski serbest metin reçete — arayüz yok / eski reçete yok.
- Lab iptali — arayüz bulunamadı (L-1).
- Yatış iki sekme çakışması, Taburcu "saati de girin" mesajı, yatış "Geliş (bugün)" bağı — süre ve veri.
- Gelmedi, geri alma, mikroçip araması, arama hata durumu — veri/benzetim yok.
- "Birden fazla hayvan" ödeme gösterimi, ücret düzeltme — bu turda denenmedi.
- Dışa aktarılan dosya içeriği — yalnız uç çağrıları 200 olarak doğrulandı.
- Gerçek dar pencere — pencere boyutlandırma çalışmadı; iframe simülasyonu kullanıldı.
- Konsol hataları — izleme yalnız son bölümde; önceki ekranlar doğrulanamadı.
