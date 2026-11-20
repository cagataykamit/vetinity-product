# Sürüm notu: 2026-11-20 11:09 (TSİ), Rapor Merkezi yeni ana ekran, Özet sayfası kaldırıldı

**Yayınlanan:** backend `main` `799e1cc7` (11:09, önce), panel `main` `ea668ab9` (`main-3A5QHQVF.js`, 11:09, sonra); panel `b4679184` (Rapor Merkezi ve Bugün) ile `ea668ab9` (Özet'in kaldırılması) aynı yayında, taşınan uyarılar Özet'le birlikte gitti (ADR-052 K7). Portal ve site değişmedi, yeniden yayınlanmadı. Önceki paketler sunucuda `api-eski` / `web-eski`.
**Migration:** yok. İzin ve `seed` değişikliği yok; yedek gerekmedi, çıkış-giriş gerekmez.
**Doğrulama:** API `/health/ready` 200, yayın sonrası günlükte ERR/FTL yok; `GET /api/v1/reports/hub-summary` kimliksiz 401 (uç yayında). Panel yeni `main` dosyasıyla açılıyor (`200 application/javascript`), canlı `ngsw.json` zaman damgası yerel build ile aynı, `Cache-Control: no-cache`; www 200. `/panel/dashboard` girişe `returnUrl=/panel/reports` ile yönleniyor.
**Testler:** backend 4522 uygulama, 1360 domain, 2233 entegrasyon (4 atlandı); panel 3654 testin (461 dosya) hepsi geçti; `ng build vetinity-web` başarılı.

## Rapor Merkezi B ve taşınan uyarılar

- **Raporlar ana ekranı (ADR-052, tasarım B · Sorular):** raporlar sekiz iş sorusu altında toplandı ("Bugünün kasası tuttu mu?", "Kimin bize borcu var?" vb.). Her kartta özet sayı, eğilim çizgisi ve cevabı veren raporlar var. Üstte Bugün / Bu hafta / Bu ay seçicisi, rapor adıyla arama ve favoriler.
- **Bakmanız gerekenler:** HBS'e girilmemiş reçete ve aşı, bugün ücreti kapanmamış iş, zamanı geçmiş aşı, düşük stok. Yalnız sayı sıfırdan büyükse ve ilgili sayfayı açma izni varsa görünür.
- **Sayılar seçili şubeye göre** tek uçtan gelir (`GET /reports/hub-summary`); her sayı aynı veriyi gösteren raporla aynı kuraldır. Kart ve uyarı, bağlandığı raporun izniyle görünür.
- **Bugün:** Açık işler satırında **Gecikmiş randevu: N** (önceki 30 günden kalan, gelinmemiş, hâlâ planlı randevu; takvimde "Gecikmiş" filtresiyle açılır). Gün listesinin başlığında **N randevu iptal edildi** (liste iptal edilen randevuyu göstermez).

## Özet kaldırılır

- Menüden **Özet** kalktı. `/panel/dashboard` adresi **Raporlar**'ı açar; yer imleri bozulmaz.
- Açılış: Bugün izni olan herkes Bugün ile açılır; Bugün izni yoksa ve rapor izni varsa Raporlar; yoksa menüdeki ilk sayfa.
- Kullanılmayan `/dashboard/*` uçları sonraki temizlik işinde kaldırılır.

## Bilinen sınırlar

- Uyarı bandındaki HBS ve gün sonu bağlantıları raporu varsayılan tarih aralığıyla açar (rapor sayfaları adresten tarih okumuyor).
- Sorgu süresi gerçek veri hacminde ölçülmedi.
- Canlıda oturum açılarak denenmedi: Raporlar ekranının gerçek sayılarla yüklenmesi ve Bugün'deki yeni sayılar tarayıcıda görülmedi (uç ve yönlendirme oturumsuz doğrulandı).
