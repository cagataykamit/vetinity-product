# ADR-017 — İş akışı merkezli yapı ve menü (Seçenek 2, kademeli)

## Durum

**Kısmen kabul edildi (2026-10-14, kullanıcı: "önerileri yap").** Kaynak: [ux/ARAYUZ-IS-AKISI-DENETIMI-2026-10.md](../ux/ARAYUZ-IS-AKISI-DENETIMI-2026-10.md) bölüm 5-7. Kabul edilenler: K3, K4, K5, K7, K9, K10 (önerilen cevaplarla). **Bekleyenler: K1, K2, K6, K8**; cevapları kliniğe bağlı, veteriner sorularından gelecek ([ux/KLINIK-SORULARI-2026-10.md](../ux/KLINIK-SORULARI-2026-10.md)). Menü satırları bu karar ile netleşir; [UX-009](../backlog/feature-backlog.md) görünümü ayrıca yeniden değerlendirilir.

## Karar

| # | Konu | Karar |
|---|---|---|
| K3 | Yapı | **Seçenek 2 "Bugün + hasta çalışma alanı"**, **kademeli**: önce Dilim A (küçük düzeltmeler), sonra B (akışı değiştirenler), sonra C (menü). Rol bazlı ayrı çalışma modları (Seçenek 3) pilot geri bildirimine kadar ertelenir (UX-007). |
| K4 | Kayıt listeleri | Menüden çıkan listeler (Muayene, Tedavi, Reçete, Aşı, Lab, Yatış, Uygulama) tek **"Kayıtlar"** öğesi altında, sekmeli; denetim, defter ve genel arama için global liste kalır. |
| K5 | Yönetici açılışı | **Bugün**; Özet ikinci yüz (yalnız yönetici düzeyi). Eski D-M2 kodu ile çelişki bununla kapanır. |
| K7 | Randevudan muayene | Randevu detayındaki "Muayene Oluştur" önce **geliş (Visit)** açar; tek yol. |
| K9 | Satış ekranı yeri | [ADR-016](ADR-016-direct-sale.md) arayüzü **Para** altında + **Bugün'den kısayol**. |
| K10 | Kesinleştirme kontrolü | Kesinleştirmeden önce "eklenmemiş/ücretlenmemiş kalem var" **uyarısı** (engel değil). Ücretlenmemiş kısmı K2'ye bağlıdır; metin uyarısı Dilim A4'te gelir. |

## Kalan kararlar (2026-10-14, kullanıcı: "rakip bu işi 12 senedir yapıyor, ona bakıp yapalım, bana sorma")

Klinik pratiği soruları için varsayılan kaynak **rakibin 12 yıllık pratiği** ([RAKIP-ANALIZI-2026-10.md](../roadmap/RAKIP-ANALIZI-2026-10.md): iş kapsamı ve veri akışı; görünüm kopyalanmaz). Veteriner soruları ([KLINIK-SORULARI-2026-10.md](../ux/KLINIK-SORULARI-2026-10.md)) pilotta doğrulama içindir, geliştirmeyi bekletmez. Önerilen cevaplarla kabul:

| # | Konu | Karar | Rakip dayanağı |
|---|---|---|---|
| K1 | Aşı | **Tek giriş**: aşı formunda ürün/parti seçilince hem aşı kaydı hem stoktan düşen uygulama yazılır; ürün seçilmezse yalnız aşı kaydı. ADR-005/D6 bu kapsam için değişir. | Rakipte Aşı Bilgi raporu ürün, seri no, SKT, miktar, fiyat taşır (aşı ürün bazlı) |
| K2 | Ücret önerisi | Hekimin yaptığı işlem/ürün **"ücret bekliyor"** olarak resepsiyona düşer; resepsiyon onaylayıp ücrete çevirir (hekim ücret ekleyemez, [ADR-012](ADR-012-fees-payments-balance.md) karar 2 korunur). | Rakipte muayenede "satışa eklenen ilaçlar" muayene içinde işlenir |
| K6 | Bugün'e açık işler | Bekleyen lab, borçlu çıkan ve tamamlanmamış geliş Bugün'de hesaplanan liste olarak ([Aşama 8 D-N1](../roadmap/AJAN-KUYRUGU.md) ile aynı). | — |
| K8 | Gün sonu | Rapor Merkezi'ne **"Günlük işlem dökümü"** (ücret, ödeme türüne göre tahsilat, satış, iptal/düzeltme) ve tarih aralığı **tahsilat/kasa özeti**; kasa/banka/gider (ön muhasebe) **kapsam dışı** kalır. | Rakipte "Günlük İşlem Dökümü", "Kasa tarih aralığı", "Tahsilat değişiklik raporu" var |

## Rakip iş akışı çalışması sonrası ayarlar (2026-10-14)

Kaynak: [ux/RAKIP-IS-AKISI-CALISMASI-2026-10.md](../ux/RAKIP-IS-AKISI-CALISMASI-2026-10.md) ve [ux/HEDEF-IS-AKISLARI-2026-10.md](../ux/HEDEF-IS-AKISLARI-2026-10.md) (rakip pratiği varsayılan kaynak; kullanıcıya sorulmaz). Kabul:

- **K4 ince ayar:** "Kayıtlar" sekmeleri **denetim/arama** amaçlıdır; **"Yeni" düğmesi yalnız bağlamdan** (ziyaret çalışma alanı, hasta eylem çubuğu) çalışır. Bağlamsız kayıt (müşteri+hayvan baştan) çift giriş üretir. Menü yapısı aynı kalır.
- **K3 ince ayar (P5):** "Hastalar" girişi **arama-öncelikli**, tablo ikinci düzey. Yeni menü öğesi eklenmez: Mal kabul = Stok sekmesi, Aranacaklar = Randevular sekmesi, Gün sonu = Raporlar kartı.
- **K2 kapsamı:** ücret önerisi için **hizmet kataloğu** gerekir; **FIN-008 yeniden açılır** (yalnız "Hizmet" ürün türü + fiyat; KDV/birim sonra). Model **ADR-018** (ücret önerisi) ile yazılır; pilot için asgari sürüm: uygulama ve aşı kalemleri, fiyatlı ürünlerle.
- **Uygulama sırası (HEDEF §4):** D2 Bugün açık işler (K6) → D1 aşı tek giriş ekranı (yapıldı) → D3 ziyaret çalışma alanı (İşlemler bölümü, yan panel) → D4 ücret önerisi + katalog (ADR-018, migration) → D5 mal kabul → D6 gün sonu (K8, D2 sorgusunu paylaşır).
- ADR-016 K9 (hekim satış yapmaz) **değişmez**; ücret önerisi aynı işi denetimli yapar, pilotta izlenir.

## Hedef menü (K3 + K4)

Bugün · Hastalar (Müşteri + Hayvan sekmeli) · Randevular (liste/takvim anahtarı) · Para (Ücret + Ödeme + Satış, sekmeli) · Stok (Ürün + Stok durumu + Stok hareketleri, sekmeli) · Kayıtlar (sekmeli) · Raporlar · Ayarlar (+ Özet yalnız yönetici). Hiçbir rota silinmez, yalnız menü girişi değişir (ADR-004 madde 5); birleşik sayfalar mevcut sayfa bileşenlerini yeniden kullanır.

## Sonuçlar

- Frontend: `panel-navigation.ts` (tek kayıt), sekmeli birleşik giriş sayfaları, `app.menu.spec`/`panel-navigation.spec` güncellemesi, giriş sonrası açılış kuralı, randevudan geliş yolu.
- Bekleyen: K1 (aşı tek giriş, ADR gerekir), K2 (ücret önerisi), K6 (Bugün'e açık işler), K8 (gün sonu özeti); Dilim B'nin bu kararlara bağlı parçaları.
- Riskler: menü yapısı pilot kullanıcılara alıştırıldıktan sonra değişmesin diye C1'in pilot öncesine alınması önerilir (denetim bölüm 7); geçiş maliyeti ölçülmedi.
