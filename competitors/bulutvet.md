# Bulutvet — Rakip Analizi

## Ürün

Bulutvet (Türkiye pazarı veteriner klinik yönetim yazılımı)

## İncelenen alan

Türkiye pazarı özellikleri, modül kapsamı, entegrasyonlar

## Analiz durumu

**Kısmi** — Bilinen başlıklar kaydedildi; detaylı ekran bazlı analizler ileride belgeye eklenecektir.

---

## Bilinen gözlemler

| Alan | Gözlem |
|---|---|
| Pansiyon | Pansiyon yönetimi modülü |
| Tedarikçiler | Tedarikçi yönetimi |
| Kasa hareketleri | Kasa/mali hareket takibi |
| Senet portföyü | Senet yönetimi |
| Aşı takvimi | Aşı planlama ve takip |
| SMS/POS entegrasyonları | Dış sistem bağlantıları |
| Profil ve şirket ayarları | Klinik yapılandırması |
| Bildirim paneli | Sistem bildirimleri |
| Ekran kilidi | Oturum güvenliği |
| Şifre değiştirme | Hesap güvenliği |

## Kullanıcı problemi

Türkiye'deki veteriner kliniklerinin yerel muhasebe, fatura, SMS ve operasyonel gereksinimlerini tek platformda karşılama ihtiyacı.

## Güçlü yön

- Türkiye pazarına özel modüller (senet portföyü, kasa hareketleri, e-Fatura entegrasyonları)
- Yerel entegrasyon deneyimi (SMS, POS)
- Türkçe arayüz ve yerel iş pratiklerine uyum

## Zayıf yön

- Detaylı UI/UX analizi henüz yapılmadı
- Modern SaaS deneyimi açısından değerlendirme bekliyor

## Vetinity için çıkarım

| Alan | Vetinity yaklaşımı | Backlog |
|---|---|---|
| Yerel entegrasyonlar | e-Fatura, SMS, POS P2 roadmap'te | [INT-003](../backlog/feature-backlog.md)–[INT-006](../backlog/feature-backlog.md) |
| Aşı takvimi | Mevcut aşı modülü; hatırlatmalar P3 | [Roadmap P3](../roadmap/roadmap.md) |
| Self-service trial | Bulutvet'ten farklılaşma: doğrudan deneyim | [ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) |
| Modern UX | Sade, hızlı arayüz avantajı | [UX ilkeleri](../ux/ux-principles.md) |

## Kopyalanmaması gereken unsur

- Eski UI pattern'lerinin birebir taşınması
- Modül listesinin özellik sayısı yarışında kopyalanması

## Önemli kavramsal not

> **Pansiyon ≠ Yatış (Hospitalization)**
>
> Bulutvet'teki "pansiyon" modülü ile Vetinity'deki "yatış" (hospitalization) aynı ürün alanı **değildir**. Pansiyon, hayvanın klinikte konaklama/pet hotel hizmeti anlamına gelebilir; yatış ise tıbbi hospitalization sürecidir. Bu iki kavram dokümantasyonda birleştirilmemelidir.

Vetinity'de yatış modülü tıbbi hospitalization kapsamındadır. Pansiyon ihtiyacı ayrı bir ürün değerlendirmesi gerektirir; henüz roadmap'te yer almamaktadır.

## İlgili backlog maddesi

- [INT-005](../backlog/feature-backlog.md) — e-Fatura / e-SMM
- [INT-003](../backlog/feature-backlog.md) — SMS entegrasyonu
- [INT-006](../backlog/feature-backlog.md) — POS ve online ödeme

## İlgili ADR

[ADR-001](../decisions/ADR-001-self-service-trial-strategy.md) — Türkiye pazarında self-service farklılaşması

## Kanıt / ekran / kaynak notu

Genel pazar bilgisi ve modül listesi gözlemi. Detaylı ekran bazlı analizler ileride eklenecektir.

---

## İlgili belgeler

- [Rakip analizleri README](README.md)
- [Navigasyon — Yatış notu](../ux/navigation.md)
- [Roadmap P2 — Entegrasyonlar](../roadmap/roadmap.md#p2--entegrasyonlar-ve-gelişmiş-ai)
