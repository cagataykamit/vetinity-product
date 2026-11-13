# 2026-11-14 — Sürüm notu

**Tarih:** 2026-11-14, 00:13–00:16 (TSİ)
**Yayınlanan:** backend `main` `3c50d963`, panel `main` `181b14ed` (`main-2IR6MAPP.js`). Portal ve klinik siteleri değişmedi.
**Migration:** `AddEDocumentAutoIssuePause`, `AddChargeFullyPaidAt`, `AddPetCoatPatternAndVaccineCategory`. Ardından `seed` ve `backfill-pet-projections` çalıştırıldı.
**Yedek:** Migration'dan önce elle yedek alındı (00:14; Drive kopyası doğrulandı).

## Öne çıkanlar

- Ortak kataloglar kaynaklara dayanıyor: ırklar FCI, FIFe ve yerli ırk tescil adlarıyla; aşılar Türkiye'de ruhsatlı ürünlere ve WSAVA 2024'e göre.
  - Kaynaklar: [araştırma belgesi](../research/sistem-kataloglari-kaynak-arastirmasi-2026-11.md)
- e-Belge: canlıya yalnız Nilvera ile çıkıldı; otomatik kesme koruma ve durdurma eklendi.
  - Ayrıntı: backend `docs/E_DOCUMENTS_API_CONTRACT.md` §8

## Yeni özellikler

- **Hasta kaydında ayrı bir "Desen" alanı var:** tekir, kaplan çizgili, benekli, sivri renk, merle ve diğerleri. Renk alanında artık yalnız renkler var.
- **Aşı seçicisi aşıları gruplara ayırıyor:**
  - çekirdek
  - çekirdek dışı
  - antiparaziter uygulamalar
  - diğer
  - önerilmeyen
- **Yeni katalog satırları:**
  - Tür: Manda, Küçük Kemirgen
  - Köpek: 27 ırk; aralarında Japon Tosa ve Fila Brasileiro var (5199 sayılı Kanun'daki tehlikeli ırklar)
  - Kedi: 12 ırk
  - Tavşan, kobay ve çiftlik hayvanlarında yerli ırklar
- **Yeni aşı tanımları (18):** kedi klamidyozu, at herpesvirüsü, IBR, BVD, mavi dil ve diğerleri.
- **Klinik sözlük:** 30 şikâyet ve 58 tanı eklendi.
- **Muayene şablonları:** 9 yeni şablon eklendi. Yavru, yaşlı hayvan, anestezi öncesi, kulak, ağız-diş, dermatoloji, göz, ameliyat sonrası, tavşan/egzotik.

## İyileştirmeler

- **Irk adları netleşti.** Örnekler: Alman Çoban Köpeği (Alman Kurdu), Kangal Çoban Köpeği (Kangal), İngiliz Cocker Spaniel.
- **Karma aşı türe göre ikiye ayrıldı:** köpek için DHPPi±L, kedi için FVRCP.
- **Yeni aşı tanımlarında varsayılan aralık var:** kuduz 365 gün, yavru serisi 21 gün, iç parazit 90 gün.
- **"Aşı muayenesi" şablonunun adı "Sağlık kontrolü ve aşı" oldu.** Bu şablona ve iki eski şablona VKS, hidrasyon ve ağrı başlıkları eklendi.
- **Aşı takvimi başlangıç şablonu:** karma 8., 12. ve 16. haftada yapılıyor; köpek koronavirüs çıkarıldı (WSAVA önermiyor).

## Düzeltmeler

- **"Kırçıllı" artık "Kaplan Çizgili (Brindle)".** TDK'da "kırçıl" kırlaşmış anlamına geliyor, brindle karşılığı değil.
- **Tekir, Sarman ve Smokin ırk listesinden çıktı.** Bunlar kürk deseni ya da rengi; bu ırkla kayıtlı kediler seed sırasında "Ev Kedisi (Kısa Tüylü)" ırkına ve ilgili renk/desene geçer (canlıda henüz hasta kaydı yoktu).
- **FIV ve FIP aşıları listeden kaldırıldı.** Türkiye'de ruhsatlı ürünleri yok.
- **"Genel kontrol" şikâyet listesinden çıktı.** Bu bir ziyaret nedeni; şablonlarda kalıyor.

## Sunucu

- **`DataProtection__KeysPath` tanımlandı:** `/var/lib/vetinity/dataprotection-keys`. Mevcut anahtarlar buraya kopyalandı; gece yedeği bu klasörü de alıyor.
- **Önceki hâller saklandı:**
  - `api.env.bak-20261114`
  - `yedek.sh.bak-20261114`
  - Paketlerin önceki sürümleri `api-eski`, `web-eski` ve `dbmigrator-eski` klasörlerinde.

## Bilinen sınırlamalar

- **Desen hasta listesinde görünmüyor;** yalnız hasta detayında ve formda.
- **Kullanıcılar yeni paneli iki yenilemede görür:** Ctrl+F5'e iki kez basmak gerekir.
- **Doğrulama:** Yayından sonra canlıda giriş yapılarak ekran denenmedi. Kontrol edilenler şunlar:
  - `/health/ready` 200
  - panelin ana dosyası yerel derlemeyle aynı
  - `www` 200
  - canlı veritabanında katalog sayıları
