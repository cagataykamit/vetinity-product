# ADR-012 — Temel ücret, tahsilat ve bakiye

## Durum

**Taslak (2026-10-10), kullanıcı onayı bekliyor.** Ana plan Aşama 3 ([bölüm 8](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)) kararlarına dayanır; kod keşfi tamamlanmadan kesinleşmez. Ürün canlıda değil, gerçek müşteri verisi yok (geriye dönük veri taşıma kısıtı yoktur).

## Bağlam

Mevcut `Payment` tahsil edilen tutarı kaydeder (ödeme yöntemi, tarih, tutar; `appointmentId` ve `examinationId` opsiyonel). İşlemden **ücret/borç** oluşturan bir kaynak yoktur; toplam tahsilat müşterinin kalan borcunu vermez. Bugün yüzeyinde "Ödeme kaydı yok" rozeti yalnızca bilgi verir, ödemeye geçilemez ([CHECKIN-007](../backlog/feature-backlog.md)). Rakip gözlemleri (DaySmart: ziyaret sonrası ayrı Check Out ve fatura seçimi; Provet; E-Vet; BulutVet): [competitors](../competitors/).

## Karar (öneri, ana plana dayalı)

| Konu | Karar |
|---|---|
| Ücret | Hasta/ziyaret veya klinik işlemle bağlı **Ücret** (Charge): açıklama, miktar, tutar, para birimi, ilişkili Visit/Muayene/Hasta/Sahip. İlk dilim **manuel satır**; hizmet kataloğu ön koşul değil |
| Tahsilat | Mevcut ödeme temeli kullanılır (yöntem, tarih, tutar, ilişkiler korunur) |
| İlişkilendirme | Hangi tahsilatın hangi ücreti karşıladığı **açık kayıt**; aynı para iki borcu kapatamaz; çift istek/eşzamanlı iki kullanıcı aynı ödemeyi iki kez saymaz |
| Bakiye | Ücret, ödeme ve açık kalan ayrı; **sahip bazında klinik kapsamlı** hesap, hasta/ziyaret kırılımı |
| Kısmi ödeme | Açık kalan sonraki tahsilatta kapanır. Bakım durumunun "Tamamlandı" olması borcu otomatik kapatmaz (ADR-009: ödeme durumu bakımdan ayrı) |
| Düzeltme | Tutar değiştirme, iptal/iade: yetki + zorunlu gerekçe + audit; geçmiş işlem silinmez (iptal veya ters kayıt) |
| Para birimi | Farklı para birimleri tek toplamda karıştırılmaz; kur dönüşümü otomatik varsayılmaz |
| Eski kayıt | Geçmiş payment kayıtlarından hayali ücret/borç türetilmez; açılış bakiyesi varsa açık kaynak ve yetkili kayıtla |
| Belge | Klinik ücret/tahsilat özeti ≠ resmi e-belge; vergi/yuvarlama ve belge alanları uygulamadan önce doğrulanır |
| Kapsam dışı | Gelişmiş kredi/mahsup/write-off, kasa mutabakatı, belge paketi, kapsamlı muhasebe, e-Fatura, POS ([CHECKOUT-001](../backlog/feature-backlog.md), INT-005/006) |

**Örnek kabul:** 1.000 TL ücret, 400 TL tahsilat → 600 TL kalan; ikinci 600 TL tahsilat aynı borcu kapatır; tekrar istek ödemeyi iki kez saymaz.

## Kod keşfi ile netleşecek noktalar (backend, salt okunur)

1. Mevcut `Payment` modeli, uçları, yetkileri, durum/iptal kuralları; `appointmentId`/`examinationId` ilişkileri; Query DB payment projeksiyonu ve rapor/dashboard finans yolları (finans rollout bayrakları, parity testleri).
2. Müşteri ödeme özeti (`ClientPaymentSummary`) ne hesaplıyor, bakiye için yeniden kullanılabilir mi.
3. Ücret modelinin Visit/Examination ile bağı: ücret hangi varlığa bağlanır (Visit mi, Muayene mi, ikisi mi), muayenesiz ücret mümkün mü.
4. Tahsilat–ücret ilişkilendirme için mevcut Payment'ta genişletme mi, ayrı ilişki tablosu mu (en küçük temiz tasarım).
5. Para birimi: mevcut para birimi alanı ve kural.
6. İzin kümesi: mevcut `Payments.*` yetkileri ve yeni ücret/bakiye/düzeltme yetkileri.

## Kullanıcıdan beklenen karar noktaları (keşiften sonra)

- İlk dilimde ücret bağı: Visit, Muayene veya ikisi.
- Düzeltme yetkisi hangi rollerde (öneri: Visits.Correct benzeri, yönetici düzeyi).
- Tek para birimi (TRY) varsayımı ilk dilimde yeterli mi.
- Fazla ödeme (ücretten fazla tahsilat) sonucu: reddet mi, sahip kredisi olarak mı tut (ana plan kredi/mahsubu kapsam dışı sayar; öneri: ilk dilimde reddet).

## Değerlendirilen alternatifler

| Alternatif | Sonuç |
|---|---|
| Fatura/e-belge odaklı model | Ertelendi: resmi e-belge ayrı capability (INT-005) |
| Ücreti hizmet kataloğu şart koşmak | Reddedildi: ilk manuel ücret için ön koşul değil |
| Bakiyeyi yalnızca ödeme toplamından türetmek | Reddedildi: ücret kaynağı olmadan borç bilinemez |

## Olumlu sonuçlar

- "Kalan borç" ve "hangi ödeme neyi kapattı" tek yerde cevaplanır.
- Bugün ve muayeneden ücret/ödeme akışına bağlam kopmadan geçilir (FIN-004).

## Riskler ve olumsuz sonuçlar

- Finans verisi: eşzamanlılık, yuvarlama, çift sayım ve iki veritabanı tutarlılığı (Query DB projeksiyonları) özenli test ister.
- Mevcut finans rapor/dashboard yolları ve bilinen parity test başarısızlıkları ([AJAN-KUYRUGU](../roadmap/AJAN-KUYRUGU.md)) bu işten önce/sırasında netleşmelidir.

## İlgili belgeler

- [Ana plan, Aşama 3](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)
- [FIN-001…004](../backlog/feature-backlog.md), [CHECKOUT-001](../backlog/feature-backlog.md), [RECORD-001](../backlog/feature-backlog.md)
- [ADR-009 — Visit modeli ve geliş akışı](ADR-009-visit-model-and-arrival-flow.md)
