# ADR-003 — Rapor Merkezi

## Durum

Kabul edildi

## Bağlam

Vetinity'de ödeme raporu, randevu raporu, muayene raporu ve aşı raporu gibi raporlar mevcuttur. Her raporun sidebar'da ayrı menü öğesi olarak gösterilmesi:

- Sidebar'ı şişirir
- Yeni rapor eklendiğinde otomatik menü kalabalığı oluşturur
- "Yeni özellik eşittir yeni menü değildir" ilkesiyle çelişir ([ADR-004](ADR-004-navigation-and-menu-philosophy.md))

## Karar

1. Sidebar'da ödeme raporu, randevu raporu, muayene raporu ve aşı raporu **ayrı ayrı gösterilmeyecektir**.
2. Sidebar'da yalnızca **tek bir "Raporlar" menü öğesi** bulunacaktır.
3. `/panel/reports` uzun vadede bir **Rapor Merkezi** yaklaşımına dönüşecektir.
4. Teknik olarak ayrı rapor route'ları **korunabilir**.
5. Kullanıcı navigasyonu Rapor Merkezi içindeki kategori, kart, sekme veya benzeri bir **iç navigasyonla** sağlanabilir.
6. Yeni rapor eklemek otomatik olarak sidebar'a yeni öğe eklemek anlamına **gelmeyecektir**.

### Gelecekte değerlendirilecek özellikler (henüz tamamlanmadı)

- Rapor favorileri
- Kaydedilmiş filtreler
- Ortak filtre çubuğu
- Excel veya PDF dışa aktarma
- Claim bazlı rapor görünürlüğü

## Gerekçe

- Sidebar sürdürülebilirliği
- Rapor keşfinin tek merkezden yapılması
- Yeni rapor ekleme maliyetinin düşürülmesi
- Teknik route'ların korunması derin link ve bookmark uyumluluğunu sağlar

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| Her rapor ayrı sidebar öğesi | Menü şişmesi; sürdürülebilir değil |
| Raporları Ayarlar altına taşıma | Raporlar günlük operasyon aracı; Ayarlar uygun değil |
| Yalnızca dashboard widget'ları | Derinlemesine rapor analizi için yetersiz |

## Olumlu sonuçlar

- Sidebar sade kalır
- Rapor keşfi merkezi ve tutarlı
- Yeni rapor ekleme sidebar'ı etkilemez
- Derin linkler korunur

## Riskler ve olumsuz sonuçlar

- Kullanıcılar alışkın oldukları doğrudan menü erişimini kaybedebilir
- Rapor Merkezi iç navigasyonu iyi tasarlanmazsa keşif zorlaşır
- Mevcut bookmark'ların yönlendirmesi korunmalıdır

## Uygulama etkileri

- Sidebar'dan ayrı rapor menü öğeleri kaldırılmalı ([REPORT-001](../backlog/feature-backlog.md))
- Rapor Merkezi iç navigasyonu tasarlanmalı ([REPORT-002](../backlog/feature-backlog.md))
- Gelecek özellikler backlog'da planlanmıştır ([REPORT-003](../backlog/feature-backlog.md)–[REPORT-007](../backlog/feature-backlog.md))

## İlgili belgeler

- [ADR-004 — Navigasyon ve menü yaklaşımı](ADR-004-navigation-and-menu-philosophy.md)
- [Navigasyon yapısı](../ux/navigation.md)
- [Feature backlog — REPORT maddeleri](../backlog/feature-backlog.md)
- [Roadmap P0](../roadmap/roadmap.md#p0--çıkış-öncesi-ürün-deneyimi)
