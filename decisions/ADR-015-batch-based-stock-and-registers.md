# ADR-015 — Parti (lot) bazlı stok ve kayıt defterleri

## Durum

**Kabul edildi (2026-10-13, kullanıcı: "kayıt defteri zorunlu veya değil yapalım").** Kaynak: [roadmap/KAYIT-DEFTERLERI-RAKIP-BICIMI.md](../roadmap/KAYIT-DEFTERLERI-RAKIP-BICIMI.md). Aşama 5 keşfinin **D4** kararını ("birim/lot/son kullanma ilk sürümde yok") bu kapsam için **değiştirir**.

## Bağlam

Rakip yazılımdaki aşı, ilaç, narkotik/psikotropik defterleri ve Aşı Bilgi raporu, **ürün girişi** (seri no, son kullanma tarihi, tedarikçi firma, fatura, geliş/teslim tarihi, nakil ve soğuk zincir bilgisi) ve **hayvana uygulanan ürünün seri no ve SKT'si** üzerine kurulu. Bizde stok ürün bazlı tek bakiye, parti kavramı yok; uygulama kaydı partiye bağlı değil.

## Karar

1. **Her stok girişi bir parti (lot) kaydı oluşturur:** ürün, seri/lot no, son kullanma tarihi, miktar, tedarikçi firma, fatura no ve tarihi, geliş/teslim tarihi, depo çıkış tarihi, nakil şekli ve soğuk zincir izleme bilgisi (aşı/soğuk zincir ürünleri için). Alanların zorunluluğu ürün sınıfına bağlıdır (kontrollü ürün ve aşıda seri no ve SKT zorunlu; diğerlerinde opsiyonel).
2. **Uygulama kaydı bir partiden düşer** (varsayılan: son kullanma tarihi en yakın olan önce, kullanıcı değiştirebilir); yetersiz parti bakiyesi mevcut yetersiz stok kuralıyla engellenir. Mevcut stok ve uygulamalar için geriye uyumlu geçiş: parti bilgisi olmayan mevcut bakiye "partisiz/devir" olarak taşınır.
3. **Ürüne eklenecek alanlar:** farmakolojik şekil, takdim şekli, ambalaj, **kontrollü sınıf** (narkotik, psikotropik, diğer/yok).
4. **Defterler partiden ve kayıtlardan türetilir** (ayrı veri girişi yok): Aşı Kayıt Defteri, İlaç Kayıt Defteri, Narkotik ve Psikotropik Ürünler Stok ve Sarf Defteri, Aşı Bilgi raporu, Muayene ve Reçete defterleri. Çıktı: ekran, CSV/XLSX, yazdırma/PDF. Sütun tanımları tek yerde ve yapılandırılabilir.
5. **Resmî/yasal biçim doğrulanmadı:** sözleşme ve arayüzde "resmî biçime uygunluk doğrulanmadı" notu; biçim doğrulanınca yalnız sütun tanımı ve üstbilgi/imza alanı güncellenir.

## Kararlar (2026-10-14, QA tur 3 sonrası, kullanıcı: önerilere göre)

6. **Süresi geçmiş parti:** Stok girişinde SKT geçmişse uyarı ve açık onay istenir (engellenmez). Stok ekranlarında **"Kullanılabilir"** ve **"Süresi geçmiş"** miktarı ayrı gösterilir; düşük stok uyarısı ve uygulanabilir bakiye yalnız kullanılabilir miktara bakar.
7. **Telefon biçimi:** Ekranda ve yazdırmada okunur biçim (`+90 532 111 00 01`, tüm ekranlarda aynı); CSV/Excel çıktılarında ham rakam. Resmî biçim doğrulanınca çıktı biçimi değişebilir.

## Sonuçlar

- Backend: parti varlığı, stok giriş (alış) kaydı genişlemesi, uygulama–parti bağı, ürün alanları (migration), defter ve rapor uçları; sözleşme önce.
- Frontend: stok girişi formu (parti alanları), uygulama formunda parti seçimi, defter ekranları ve yazdırma görünümü.
- Ertelenen: tedarikçi/cari yönetimi (yalnız firma adı alanı ve fatura bilgisi tutulur), alış faturası modülü, depo sayımı/transferi, e-reçete kimliği, kart no.
- Riskler: mevcut stok verisinin partisiz devri; kontrollü ürün sınıfının mevcut ürünlere elle atanması; defter biçiminin resmî olup olmadığı.
