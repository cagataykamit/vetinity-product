# ADR-052 — Özet sayfası kaldırılır; işi Bugün'e ve Rapor Merkezi'ne dağıtılır

## Durum

**Kabul edildi (2026-11-20, kullanıcı: "Onaylıyorum").** Kullanıcının yönü: "gerekirse komple kaldıralım dert değil". Rapor Merkezi için B seçeneği seçildi: "b yi beğendim ben".

İlgili: [ADR-003](ADR-003-report-center.md) (Rapor Merkezi), [ADR-004](ADR-004-navigation-and-menu-philosophy.md), [ADR-017](ADR-017-workflow-centered-navigation.md) K5 ve "hiçbir rota silinmez" ilkesi, [ADR-030](ADR-030-acilis-sayfasi-ve-bugun-hizli-eylemleri.md) ve 2026-11-04 eki, [İşletme performans panosu](../ux/ISLETME-PERFORMANS-PANOSU-2026-10.md). Tasarım taslağı: FE deposu, `design/raporlar/B.html` ve `README.md` (dal `claude/raporlar-tasarim-7ebf18`).

## Bağlam

- **Özet** (`/panel/dashboard`) yalnız yönetici düzeyine görünür (`Visits.Correct`: Admin, Owner, ClinicAdmin). ADR-030 eki (2026-11-04) ile yönetici de dahil herkes **Bugün** ile açılıyor. Özet'e artık yalnız menüden gidiliyor.
- Üç yönetici rolünün de Bugün izni var (`Visits.Read`; BE `RolePermissionBindings`). Yönetici Bugün'ü ve randevuları zaten görüyor. ADR-030 ekindeki "Bugün yetkisi olmayan yönetici → Özet" kuralı yalnız uç durum için bir yedek.
- Kullanıcı Rapor Merkezi'ni "çok kullanışsız" buldu. Seçilen B tasarımında ana ekran soru kartlarından oluşuyor ("Bugünün kasası tuttu mu?", "Kimin bize borcu var?" vb.). Kartlarda özet sayı, eğilim çizgisi ve "Bakmanız gerekenler" bandı var. Bu, Özet'in sayı ve eğilim kısmıyla çakışıyor.
- Özet'in geri kalanı Bugün'le çakışıyor: bugünkü randevular, hızlı işlemler, uyarılar. Kullanıcı sordu: "özet ne işimize yarıyor, raporlardan ne farkı var?" Ayrı ve kendine ait bir iş akışı kalmadı (ADR-017 menü kuralı).

## Özet'in parçaları ve gideceği yer

FE kodundan çıkarıldı (`features/dashboard`, `features/visits/pages/today-page`), 2026-11-20.

| Özet parçası | Bugün başka yerde var mı | Gideceği yer |
|---|---|---|
| Bugünkü randevular listesi ve sayaçlar (bugün, tamamlanan, iptal, gelmedi) | Var: Bugün günlük listesi | Taşınmaz |
| Hızlı işlemler (Yeni randevu, Randevusuz geliş, Müşteriler, Hastalar, Ödemeler) | Var: Bugün başlığında Randevusuz geliş, Yeni randevu, Yeni muayene, Hızlı satış; diğerleri menüde | Taşınmaz |
| Bugün / hafta / ay tahsilatı, son 7 gün tahsilat ve randevu eğilimi | Kısmen: Ödeme Raporu, İşletme performansı | Rapor Merkezi B kartları |
| Uyarı: zamanı geçmiş randevular | **Yok** | Bugün, "Açık işler" satırı (resepsiyonun işi) |
| Uyarı: geciken aşı takipleri | **Uyarı yok**; aşı listesinde `overdue=true` filtresi var | Rapor Merkezi "Bakmanız gerekenler" → aşı listesi, geciken filtresi |
| Düşük stok uyarıları | **Uyarı yok**; Stok durumunda "Düşük stok" filtresi var | Rapor Merkezi "Bakmanız gerekenler" → Stok durumu, düşük stok filtresi |
| Uyarı: yaklaşan aşılar (7 gün) | Aşı Raporu | B "Klinikte ne kadar iş yaptık?" kartında planlı sayı |
| Uyarı: önümüzdeki 24 saatte randevular | Randevu takvimi | Taşınmaz |
| Uyarı: bugün iptal edilen randevular | Bugün listesinde gösterilip gösterilmediği **doğrulanmadı** | Uygulamada kontrol edilir; yoksa Bugün'e |
| Uyarı: hesap salt okunur | Var: Bugün ve form uyarıları | Taşınmaz |
| Son ödemeler / muayeneler / müşteriler / hastalar | İlgili liste sayfaları | Taşınmaz |
| Toplam müşteri ve hasta sayısı | Yok | Taşınmaz (karar değeri düşük) |

## Kararlar

| # | Konu | Karar |
|---|---|---|
| K1 | Özet | Menüden kalkar, sayfa silinir. `/panel/dashboard` adresi `/panel/reports` adresine yönlenir; yer imleri bozulmaz (ADR-017: hiçbir rota silinmez; adres yönlendirilir) |
| K2 | Açılış yedeği | ADR-030 eki değişir. Bugün yetkisi yoksa ve rapor izni varsa **Raporlar**; yoksa ilk erişilebilir öğe; o da yoksa Ayarlar. Kural tek yerde kalır (`panel-home.redirect`) |
| K3 | Rapor Merkezi | Ana ekran B tasarımına geçer: soru kartları, Bugün / Bu hafta / Bu ay dönem seçici, favoriler, "Bakmanız gerekenler" bandı. Sayılar **seçili şubeye** göre hesaplanır. Eğilim çizgileri **ilk sürümde** olur. Soru ve sıklık metinleri taslaktaki gibi kalır, `panel-tr.ts` dosyasında tek yerde yaşar. ADR-003 madde 5 ile uyumludur (iç navigasyon). |
| K4 | Görünürlük | Her kart ve her uyarı, bağlandığı raporun ya da sayfanın izniyle görünür. Örnek: düşük stok için `Products.Read`, geciken aşı için `Vaccinations.Read`. İzni olmayan kart çizilmez. Sayısı sıfır olan uyarı da çizilmez. Kural tek yerde tutulur |
| K5 | Taşınan uyarılar | Zamanı geçmiş randevular Bugün'e gider. Geciken aşı ve düşük stok "Bakmanız gerekenler" bandına gider. Kartların yanında HBS'e girilmemiş reçete ve aşı ile gün sonu açık iş uyarıları da bu bantta durur |
| K6 | Backend | Önce BE sözleşmesi yazılır. Özet uçlarındaki sayı ve seriler yeniden kullanılır: `/dashboard/finance-summary` (bugün/hafta/ay tahsilat, `last7DaysPaid`), `/dashboard/summary` (`last7DaysAppointments`), `/dashboard/operational-alerts` (geciken randevu ve aşı sayıları). Bu uçlar ya Rapor Merkezi adına taşınır ya da tek bir `GET /reports/hub-summary?period=&clinicId=` ucu yazılır. Seçim sözleşme aşamasında yapılır. Eksik seriler (muayene, aşı, ciro) BE'de eklenir. Kullanılmayan dashboard uçları B yayına girdikten sonra kaldırılır |
| K7 | Yayın sırası | Önce B, taşınan uyarılarla birlikte yayına girer. Özet ancak ondan sonra kaldırılır. Böylece hiçbir uyarı arada kaybolmaz |

## Sonuçlar

- ADR-017 K5'teki "Özet ikinci yüz (yalnız yönetici düzeyi)" maddesi ve ADR-030'un "Özet yönetici özetidir" ilkesi bu kararla kalkar.
- [İşletme performans panosu](../ux/ISLETME-PERFORMANS-PANOSU-2026-10.md) belgesindeki "Özet olduğu gibi kalır" ve "Özet'ten bağlantı" maddeleri geçersizleşir. Dönem karşılaştırması İşletme performansı raporunda kalır.
- Menü bir satır kısalır. Yöneticinin sayıya baktığı tek yer Raporlar olur.
- Güncellenecek belgeler: `operations/KULLANICI-KILAVUZU-ROL-BAZLI.md` (§ giriş sonrası sayfa, § 3.1 "Sabah: Özet ve Bugün"), `operations/CANLI-ISLETIM-KILAVUZU.md`, `operations/PILOT-KLINIK-GORUSME-PAKETI.md`. Ayrıca B yayınında sürüm notu yazılır.

## Açık noktalar

- ~~K6'da uç seçimi~~: tek uç `GET /reports/hub-summary` (sözleşme onaylandı 2026-11-20; aşağıda).
- ~~"Bugün iptal edilen randevular" Bugün listesinde görünüyor mu?~~ Görünmüyordu (`VisitTodayReader`, `Status != Cancelled`); gün listesi başlığına sayaç eklendi (kullanıcı: "açık noktaları da önerine göre yap").
- Pilot kliniklerde Özet'i düzenli açan bir yönetici var mı? Kullanım verisine bakılmadı.

## Uygulama notu (2026-11-20)

**`main`'e alındı** (kullanıcı, PR'sız: "birleştir mainler", "Şimdi al"): backend `main` `799e1cc7`; panel `main` `b4679184` (Rapor Merkezi B ve Bugün) ve `ea668ab9` (Özet kaldırma). Birleşik hâlde backend Application 4522, Domain 1360, ilgili entegrasyon 292; panel tam takım 3654 test geçti, üretim derlemesi temiz. **Yayın yapılmadı.**

K7 notu: Özet kaldırma da `main`'de olduğu için bir sonraki panel yayını ikisini birlikte götürür. Taşınan uyarılar (Bakmanız gerekenler, Bugün'deki gecikmiş randevu) aynı yayındadır, arada uyarı kaybolmaz. **Önce backend yayınlanmalı:** panel yeni `/reports/hub-summary` ve Bugün alanlarını kullanır; backend eskiyse Raporlar sayıları yüklenemez (bağlantılar yine çalışır).

- **BE** (`feature/rapor-merkezi-ozet`): sözleşme `docs/REPORT_HUB_SUMMARY_API_CONTRACT.md` (`3a33518b`, `2ebf269a`); uç ve testler (`39883c31`, `e4bef940`); Bugün `openItems.overdueAppointmentCount` ve `TodayDto.cancelledAppointmentCount` (`f4df3960`, `b4caf212`, `25e81b39`). Bölüm başına izin, tek şube; her sayı aynı veriyi gösteren raporun kuralıyla. Migration ve yeni izin yok. Testler: Domain 1360, Application 4513, entegrasyon 2232 (+4 atlanan) geçti.
- **Panel, 1. yayın** (`feature/rapor-merkezi-b`): B ana ekranı ve kurallar (`1bc754e0`, `bc2e0368`, düzeltme `4fffd95b`), Bugün çipi ve iptal sayacı (`715fc5e1`). Ekran yerel ortamda 1280 ve 375 px, açık ve koyu temada gerçek veriyle denendi.
- **Panel, 2. yayın** (`feature/ozet-kaldirma`, 1. yayının üstünde): Özet menüden kalktı, `/panel/dashboard` → `/panel/reports`, açılış yedeği Raporlar (`7458508d`); `features/dashboard` ve kullanılmayan uç/metinler silindi (`aa0d11a7`). K7 gereği 1. yayından sonra.
- **Kalan:** BE `/dashboard/*` uçlarının silinmesi (K6, ayrı iş). Aylık dönem yerel geliştirme veritabanında 2,5–6 sn sürdü (aynı ortamda basit sorgular da yavaş); gerçek veride ölçülmedi.
