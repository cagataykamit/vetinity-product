# ADR-005 — Modern muayene deneyimi

## Durum

Kabul edildi

## Bağlam

Muayene ekranı Vetinity'nin en kritik çalışma alanlarından biridir. Veteriner hekimler günlük operasyonlarının büyük bölümünü muayene kaydı oluşturma, klinik bulgu girme, tanı koyma ve tedavi planlama üzerinde geçirir.

Mevcut muayene deneyimi, modüller arası bağlam kopukluğu ve dağınık ekranlar sorununa sahiptir. Uluslararası rakipler (DaySmart Vet) birleşik SOAP çalışma alanı ile güçlü deneyim sunmaktadır ([DaySmart analizi](../competitors/daysmart.md)).

## Karar

1. Muayene ekranı Vetinity'nin **en kritik çalışma alanı** olarak ele alınacaktır.
2. Uluslararası SOAP yaklaşımından yararlanılabilir; kullanıcılara Türkiye'de daha doğal olan terminoloji sunulacaktır:
   - **Şikâyet ve anamnez** (Subjective)
   - **Klinik bulgular** (Objective)
   - **Değerlendirme / tanı** (Assessment)
   - **Plan / tedavi planı** (Plan)
3. Muayene deneyimi **tam sayfa veya geniş çalışma alanı** kullanacaktır; küçük modal pencerelerden kaçınılacaktır.
4. Hasta bağlamı (hayvan özeti, alerjiler, uyarılar) muayene sırasında korunacaktır.

### Uzun vadede bağlanabilecek alanlar (henüz tamamlanmadı)

Aşağıdaki maddeler stratejik hedef veya backlog olarak sınıflandırılır; mevcut ve tamamlanmış özellik olarak gösterilmez:

- Hayvan özeti, kronik durumlar, alerjiler ve önemli uyarılar
- Vital bulgular, tanılar, tedaviler, reçeteler, laboratuvar, görüntüleme, aşı, kontrol planı
- Muayene şablonları, hazır tedavi paketleri, doz hesaplayıcı
- Dosya ekleri, AI destekli not işlemleri

## Gerekçe

- Muayene klinik operasyonun merkezidir
- SOAP yapısı uluslararası best practice; Türkçe adaptasyon kullanıcı dostu
- Birleşik çalışma alanı bağlam kopukluğunu önler
- Rakip analizi (DaySmart) birleşik muayene alanının değerini doğruluyor

## Değerlendirilen alternatifler

| Alternatif | Neden reddedildi |
|---|---|
| SOAP terminolojisinin birebir İngilizce kullanımı | Türk kullanıcılar için yabancı |
| Muayeneyi küçük modal ile yönetme | Karmaşık akış; bağlam kaybı |
| Her ilişkili modül için ayrı ekran | Dağınık deneyim |
| Serbest metin only | Yapılandırılmamış veri; raporlama zor |

## Olumlu sonuçlar

- Veteriner hekim verimliliği artar
- Klinik kayıt kalitesi ve tutarlılığı iyileşir
- Modüller arası geçiş azalır
- Vetinity'nin rekabet avantajı güçlenir

## Riskler ve olumsuz sonuçlar

- Geniş çalışma alanı tasarımı karmaşık olabilir
- Mevcut muayene verilerinin yeni yapıya geçişi
- Şablon/bundle/doz hesaplayıcı gecikmesi deneyimi eksik bırakabilir

## Uygulama etkileri

- Modern muayene çalışma alanı geliştirilmeli ([EXAM-001](../backlog/feature-backlog.md))
- SOAP bölümleri ayrı ayrı backlog'da ([EXAM-002](../backlog/feature-backlog.md)–[EXAM-005](../backlog/feature-backlog.md))
- P1 hedefleri: şablonlar, bundle'lar, doz hesaplayıcı ([EXAM-006](../backlog/feature-backlog.md)–[EXAM-008](../backlog/feature-backlog.md))
- AI muayene notu yapılandırma muayene akışına bağlanacak ([AI-001](../backlog/feature-backlog.md))

## İlgili belgeler

- [DaySmart rakip analizi](../competitors/daysmart.md)
- [UX ilkeleri](../ux/ux-principles.md)
- [Feature backlog — EXAM maddeleri](../backlog/feature-backlog.md)
- [Roadmap P0](../roadmap/roadmap.md#p0--çıkış-öncesi-ürün-deneyimi)
- [Tasarım kararları — Terminoloji](../ux/design-decisions.md)
