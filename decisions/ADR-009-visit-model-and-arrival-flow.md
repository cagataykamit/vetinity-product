# ADR-009 — Visit modeli ve geliş akışı

## Durum

Önerildi — **kullanıcı onayı bekliyor.** Onaylanmadan geliştirme başlamaz ([WORKFLOW](../WORKFLOW.md)). Aşağıdaki "Karar bekleyen noktalar" bölümü onaylanacak seçimleri içerir.

## Bağlam

Ana plan Aşama 2 ([yol haritası](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md), bölüm 7), hasta bulma, geliş, bekleme ve Bugün yüzeyini P0 olarak tanımlar. Bugünkü durum (backend kod keşfi, 2026-10-10; satır referansları backend deposunda):

- **Appointment** yalnızca planı temsil eder: `Scheduled → Completed` ve `Scheduled → Cancelled`; `NoShow` kaldırılmış. Ayrı geliş zamanı, bekleme veya "devam ediyor" durumu yok.
- **Muayene oluşturma randevuyu otomatik `Completed` yapar** (`CreateExaminationCommandHandler`). Randevusuz muayene mümkündür (`Examination.AppointmentId` nullable).
- Randevu başına tek muayene kuralı **kodda bulunamadı**; veritabanı indeksi benzersiz değil. Aynı randevuya birden fazla muayene açılabildiği çıkarımı çalıştırılarak doğrulanmadı.
- Dashboard sayıları, operasyonel uyarılar, slot doluluğu, hatırlatmalar, randevu raporu ve Query DB projeksiyonları randevu durumuna (`Scheduled/Completed/Cancelled`) bağlıdır.
- Tedavi, reçete, aşı, lab ve yatış kayıtları `petId`/`clinicId`/`examinationId` taşır; `appointmentId` taşımaz. Ödeme `appointmentId` ve `examinationId` taşır (ikisi de nullable).
- Randevu/muayene komutları audit mekanizmasına (`IAuditableRequest`) bağlı değildir; durum düzeltmeleri için kalıcı iz yoktur.
- `PUT /appointments/{id}` `Reschedule` izniyle korunuyor ve gövdedeki `Status` ile `Completed/Cancelled` geçişine izin veriyor görünüyor (koddan çıkarım, HTTP ile denenmedi).

Gereksinim: randevulu ve randevusuz geliş ayrı izlenir; randevusuz geliş sahte randevu olarak takvime yazılmaz; resepsiyon ve hekim aynı kuyruğu görür; ödeme eksikliği bakım durumunu yanlış göstermez; tekrar tıklama iki ziyaret üretmez.

## Karar (öneri)

1. **Ayrı `Visit` varlığı** eklenir: tenant, klinik, hasta, geliş zamanı (UTC), sorumlu hekim, opsiyonel `appointmentId`, bakım durumu, oluşturan kullanıcı. Appointment plan olarak kalır ve **değişmez**.
2. **Bakım durumu** sade: `Bekliyor → Devam ediyor → Tamamlandı`. Ödeme durumu ve açık iş göstergesi bakım durumundan **ayrı** alanlar/göstergelerdir; ödeme eksikliği bakım durumunu değiştirmez.
3. **Randevusuz geliş** Visit oluşturur, `appointmentId` null kalır; takvime randevu yazılmaz.
4. **Tekrar tıklama:** Aynı hasta için açık (Tamamlandı olmayan) tek aktif Visit kuralı ve aynı randevu için tek Visit kuralı, veritabanı düzeyinde benzersiz (filtreli) indeksle de korunur; ikinci istek mevcut Visit'i döndürür.
5. **Muayene bağlantısı:** `Examination.VisitId` nullable eklenir (eski kayıtlar etkilenmez). Visit'ten muayeneye geçişte hasta tekrar seçilmez.
6. **Bugün yüzeyi** Visit ve Appointment'ı birlikte okur (randevular, bekleyenler, bakım devam edenler, açık işler, aktif yatış). Geçmişe dönük raporla karıştırılmaz.
7. **Yanlış geliş/durum düzeltmesi** ayrı bir izinle yapılır, gerekçe zorunludur ve audit'e yazılır (`IAuditableRequest`).
8. **Arama (SEARCH-001)** ayrı iş olarak teslim edilir; Visit modelinden bağımsızdır (aşağıya bakın).

### Karar bekleyen noktalar (onayınız gerekir)

| # | Konu | Seçenekler | Öneri |
|---|---|---|---|
| K1 | Visit ayrı varlık mı? | **A:** Ayrı `Visit` (öneri). **B:** Appointment'a `CheckedIn/InRoom` durumları eklemek | A. B randevusuz geliş için sahte randevu gerektirir; plan ile gerçeği karıştırır ve dashboard/projeksiyon/rapor/slot kurallarını (hepsi Scheduled/Completed'a bağlı) kırar |
| K2 | Muayene oluşturma randevuyu otomatik tamamlasın mı? | **A:** Mevcut davranış korunur (muayene → randevu Completed), Visit'e bağımsız. **B:** Randevu, yalnızca Visit tamamlanınca Completed olur | Aşama 2 başlangıcında A; rapor etkisi ölçüldükten sonra B'ye geçiş ayrı karar. Ana plan "ziyaret politikasına uyarlanır" der; B daha doğru ama dashboard, uyarı ve rapor sayılarını değiştirir |
| K3 | Durum düzeltme yetkisi | **A:** Yeni `Visits.Correct` izni + zorunlu gerekçe + audit. **B:** Mevcut izinlerle | A |
| K4 | Randevu başına tek muayene kuralı | **A:** Aynı değişiklikte benzersiz kural (mevcut çift kayıtlar için önce veri kontrolü). **B:** Ayrı bakım işi | B; önce üretim verisinde çift kayıt var mı bakılır, sonra kural |

## Gerekçe

- Planlı randevu ile gerçek gelişi ayrı tutmak, takvimi ve mevcut raporları bozmadan randevusuz akışı mümkün kılar.
- Appointment'ı değiştirmemek, Scheduled/Completed/Cancelled'a bağlı dashboard, uyarı, slot ve hatırlatma davranışını korur.
- Bakım, ödeme ve açık iş durumlarının ayrı tutulması, "eve gönderilmiş ama bakiyesi var" gibi gerçek durumları doğru gösterir.
- Veritabanı düzeyinde benzersizlik, çift tıklama ve eşzamanlı isteklerde iki ziyaret oluşmasını uygulama koduna bırakmaz.

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Appointment'a yeni durumlar eklemek (K1-B) | Randevusuz geliş için sahte randevu gerekir; dashboard, uyarılar, slot doluluğu, hatırlatma, rapor ve iki veritabanındaki projeksiyonlar etkilenir; `NoShow` kalıntısı gibi enum riskleri |
| Randevusuz akışı yalnızca "randevusuz muayene" ile çözmek | Bekleme/sıra görünürlüğü ve geliş zamanı olmaz |
| Ağır check-in formu (şablon/bundle/fatura/form/kafes kartı) | Ana plan: ilk gelişte gösterilmez; günlük iki iş (hastayı bulmak, sırayı görmek) az alanla çözülür |
| Online randevuyu ön koşul yapmak | Teknik ön koşul değildir (ana plan, bölüm 4) |

## Olumlu sonuçlar

- Resepsiyon ve hekim aynı güncel kuyruğu görür; muayeneye geçişte hasta yeniden seçilmez.
- Mevcut randevu, dashboard ve rapor davranışı korunur (K2-A).
- Durum düzeltmeleri izlenebilir olur.

## Riskler ve olumsuz sonuçlar

- Yeni varlık yeni yazma/okuma yolu demektir: komut DB, Query DB read modeli ve projeksiyon/rebuild yolları güncellenmeli (iki veritabanı tutarlılığı).
- Randevu ile Visit'in aynı gün çift gösterimi: Bugün yüzeyi bunu birleştirmeli (randevulu Visit tek satır).
- K2-A'da randevu ile Visit durumları kısa süre ayrışabilir (ör. muayene açıldı ama Visit "Bekliyor"); bakım durumu geçişi muayene başlangıcıyla ilişkilendirilmeli.
- Randevu başına çoklu muayene riski (K4) çözülene kadar Visit–muayene ilişkisi bire-çok olabilir.
- Mevcut `PUT /appointments/{id}` ile durum atlatma (izin ayrımının dolanılması) Visit'ten bağımsız bir güvenlik/yetki bulgusudur; ayrı bug olarak ele alınmalı, Aşama 2 kabulünü bekletmemeli.

## Arama (SEARCH-001) için koddan çıkan notlar

- Sahip aramasında `FullName/Email/Phone/PhoneNormalized` üzerinde `LIKE %terim%`; hasta aramasında `Name/Breed/Species/BreedRef`. **Mikroçip aranmıyor**, indeksi yok.
- Normalizasyon yalnızca `Trim` ve LIKE kaçışı; Türkçe harf katlama, boşluk/noktalama temizliği yok. Telefonun `905XXXXXXXXX` normalizasyonuyla eşleşme ve collation davranışı doğrulanmadı.
- Tenant filtresi var; klinik filtresinin pet/client aramasında uygulandığı doğrulanmadı. Normalizasyon bu filtreleri değiştirmemelidir.

## Uygulama etkileri

- Backend: `Visit` entity/konfigürasyon/migration, komutlar (geliş, durum geçişi, düzeltme), Bugün sorgusu, `Examination.VisitId`, yeni izinler, audit, Query DB read modeli.
- Frontend: Bugün yüzeyi, randevusuz geliş, muayeneye geçiş (bağlam korunur).
- Doğrulama: ana plan Aşama 2 kabulü: randevulu ve randevusuz iki hasta kabul edilir; iki kullanıcı aynı kuyruğu görür; muayeneye geçişte hasta tekrar seçilmez; ödeme eksikliği bakım durumunu yanlış göstermez; tekrar tıklama ikinci Visit üretmez.
- Backlog: [CHECKIN-006](../backlog/feature-backlog.md), [CHECKIN-007](../backlog/feature-backlog.md), [SEARCH-001](../backlog/feature-backlog.md).

## İlgili belgeler

- [Ana plan, Aşama 2](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)
- [ADR-005 — Modern muayene deneyimi](ADR-005-modern-examination-experience.md)
- [CHECKIN-001](../backlog/feature-backlog.md), [CHECKIN-005](../backlog/feature-backlog.md)
- [Ajan kuyruğu](../roadmap/AJAN-KUYRUGU.md)
