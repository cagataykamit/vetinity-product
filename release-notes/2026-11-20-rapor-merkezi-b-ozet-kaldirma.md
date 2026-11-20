# Sürüm notu (taslak): Rapor Merkezi yeni ana ekran, Özet sayfası kaldırıldı

> **Durum:** taslak, **yayınlanmadı**. Yayın kullanıcı onayıyla yapılır; yayınlanan commit'ler ve doğrulama yayında bu nota yazılır.
> ADR-052 K7 sırası: önce Rapor Merkezi ve taşınan uyarılar yayına girer, Özet ondan sonraki yayında kalkar.

**Dallar:** backend `feature/rapor-merkezi-ozet`, panel `feature/rapor-merkezi-b` (Rapor Merkezi ve Bugün), panel `feature/ozet-kaldirma` (Özet'in kaldırılması; ikinci yayın).
**Migration:** yok. İzin ve `seed` değişikliği yok.

## 1. yayın: Rapor Merkezi B ve taşınan uyarılar

- **Raporlar ana ekranı (ADR-052, tasarım B · Sorular):** raporlar sekiz iş sorusu altında toplandı ("Bugünün kasası tuttu mu?", "Kimin bize borcu var?" vb.). Her kartta özet sayı, eğilim çizgisi ve cevabı veren raporlar var. Üstte Bugün / Bu hafta / Bu ay seçicisi, rapor adıyla arama ve favoriler.
- **Bakmanız gerekenler:** HBS'e girilmemiş reçete ve aşı, bugün ücreti kapanmamış iş, zamanı geçmiş aşı, düşük stok. Yalnız sayı sıfırdan büyükse ve ilgili sayfayı açma izni varsa görünür.
- **Sayılar seçili şubeye göre** tek uçtan gelir (`GET /reports/hub-summary`); her sayı aynı veriyi gösteren raporla aynı kuraldır. Kart ve uyarı, bağlandığı raporun izniyle görünür.
- **Bugün:** Açık işler satırında **Gecikmiş randevu: N** (önceki 30 günden kalan, gelinmemiş, hâlâ planlı randevu; takvimde "Gecikmiş" süzgeciyle açılır). Gün listesinin başlığında **N randevu iptal edildi** (liste iptal edilen randevuyu göstermez).

## 2. yayın: Özet kaldırılır

- Menüden **Özet** kalktı. `/panel/dashboard` adresi **Raporlar**'ı açar; yer imleri bozulmaz.
- Açılış: Bugün izni olan herkes Bugün ile açılır; Bugün izni yoksa ve rapor izni varsa Raporlar; yoksa menüdeki ilk sayfa.
- Kullanılmayan `/dashboard/*` uçları sonraki temizlik işinde kaldırılır.

## Bilinen sınırlar

- Uyarı bandındaki HBS ve gün sonu bağlantıları raporu varsayılan tarih aralığıyla açar (rapor sayfaları adresten tarih okumuyor).
- Sorgu süresi gerçek veri hacminde ölçülmedi.
