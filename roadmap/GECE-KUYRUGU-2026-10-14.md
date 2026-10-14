# Gece kuyruğu (2026-10-14) — kullanıcı uyurken sırayla yürütülür

**Yetki (kullanıcı, 2026-10-14):** "Bir sürü kart aç, sırayla yap, ben uyuyacağım, durmanı istemiyorum." Ajanlar arka planda koordinatör tarafından başlatılır (kart/düğme gerekmez). **Yine de yasak:** push, uzak merge, paylaşılan/üretim veritabanına migration, deploy, gizli bilgi, kullanıcı parolası/`seed` komutu (kullanıcı sabah çalıştırır), ürün yönünü kökten değiştiren karar (rakip pratiği varsayılan, gerekçeyle ADR'ye yazılır).

**Veritabanı yetkisi (kullanıcı, 2026-10-14: "seed yapabilirsin", "veritabanını da düzenleyebilirsin"):** bu makinedeki **yerel geliştirme veritabanında** migration uygulama, `seed` çalıştırma ve test verisi düzeltme serbesttir (sunucunun bu makine olduğu her seferinde doğrulanır; bağlantı bilgisi yazdırılmaz; gerçek müşteri verisi yoktur). **Paylaşılan/üretim veritabanı (VPS dahil) kapsam dışıdır ve ayrı açık onay ister.**

**Kurallar:** aynı anda en fazla 3 ajan (RAM ~2 GB). Her biten iş: koordinatör gerçek test çalıştırır, geçerse yerel `main`'e birleştirir; backend ise API yeniden başlatılır; migration yalnız **yerel geliştirme veritabanına** (sunucunun bu makine olduğu kontrol edilerek) uygulanır. Başarısız/tıkanan işte: 1 kez düzeltme denenir, olmazsa kuyrukta işaretlenir ve sıradakine geçilir. Sabah özeti: bu dosyanın durum sütunu + AJAN-KUYRUGU.

## Kuyruk (sırayla; "Dalga" aynı anda başlayabilir)

| # | Dalga | İş | Tür | Bağımlılık | Durum |
|---|---|---|---|---|---|
| Q1 | 1 | Backend D2: Bugün açık işler ve ücretlenmemiş ziyaret (hesaplanan liste) | BE | — | Bekliyor |
| Q2 | 1 | Frontend D3: ziyaret çalışma alanı (İşlemler, yan panel) | FE | — | Bekliyor |
| Q3 | 1 | Backend D4: ücret önerisi + hizmet kataloğu (ADR-018) | BE+MIG | — | Bekliyor |
| Q4 | 2 | Frontend D2: Bugün satırında açık iş çipleri | FE | Q1 | Bekliyor |
| Q5 | 2 | Backend D6: gün sonu raporu (K8, Q1 sorgusunu paylaşır) | BE | Q1 | Bekliyor |
| Q6 | 2 | Frontend D4: Ücretlendir paneli ve ücret bekliyor | FE | Q3 | Bekliyor |
| Q7 | 3 | Backend + Frontend D5: mal kabul (çok satırlı stok girişi) | BE+FE | — | Bekliyor |
| Q8 | 3 | Frontend D6: gün sonu ekranı | FE | Q5 | Bekliyor |
| Q9 | 3 | Hastalar girişi arama-öncelikli (P5), randevudan geliş yolu (K7), yönetici açılışı Bugün (K5) | FE | Q2 | Bekliyor |
| Q10 | 4 | QA tur 4 (yeni akışlar), bulgu raporu | TEST | Q1-Q9 | Bekliyor |

Her işin ayrıntılı talimatı koordinatör oturumunda; sözleşme/ADR çıktıları ilgili depoda.

## Gece günlüğü

- **Q2 Frontend D3 (ziyaret çalışma alanı): TAMAM**, yerel main'e alındı (e0b1f4a). `ng test` 977/977; ekran görüntüsü alınamadı (giriş bilgisi yok, parola girilmedi). Bilinen eksik: aşı satırları yalnız oturumda eklenenler için görünür; backend `related-summary.vaccinations` ve aşı listesi `examinationId` süzgeci gerekir.
- **Q11 Backend muayene aşı özeti (D3 devamı):** başlatıldı (`feat/muayene-asi-ozeti`), sonra frontend tarafı (aşı satırlarının kalıcı görünmesi) kuyruğa eklenecek.
- D3 kararları (rakip pratiği, sorulmadı): "Yeni Muayene" bağlamsız düğmesi de kalktı (Bugün, randevu, hasta eylem çubuğunda duruyor); uygulama kendi bölümünde (iptal akışı); ücretlenmemiş işlem kontrolü ADR-018'e bağlı.
