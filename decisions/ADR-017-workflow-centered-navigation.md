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

## Hedef menü (K3 + K4)

Bugün · Hastalar (Müşteri + Hayvan sekmeli) · Randevular (liste/takvim anahtarı) · Para (Ücret + Ödeme + Satış, sekmeli) · Stok (Ürün + Stok durumu + Stok hareketleri, sekmeli) · Kayıtlar (sekmeli) · Raporlar · Ayarlar (+ Özet yalnız yönetici). Hiçbir rota silinmez, yalnız menü girişi değişir (ADR-004 madde 5); birleşik sayfalar mevcut sayfa bileşenlerini yeniden kullanır.

## Sonuçlar

- Frontend: `panel-navigation.ts` (tek kayıt), sekmeli birleşik giriş sayfaları, `app.menu.spec`/`panel-navigation.spec` güncellemesi, giriş sonrası açılış kuralı, randevudan geliş yolu.
- Bekleyen: K1 (aşı tek giriş, ADR gerekir), K2 (ücret önerisi), K6 (Bugün'e açık işler), K8 (gün sonu özeti); Dilim B'nin bu kararlara bağlı parçaları.
- Riskler: menü yapısı pilot kullanıcılara alıştırıldıktan sonra değişmesin diye C1'in pilot öncesine alınması önerilir (denetim bölüm 7); geçiş maliyeti ölçülmedi.
