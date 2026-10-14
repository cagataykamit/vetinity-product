# ADR-019 — Veri içe aktarma (müşteri, hasta, aşı geçmişi)

## Durum

**Kabul edildi (2026-10-14, kullanıcı: "rakip pratiği/önerilere göre karar ver, bana sorma").** Kaynak: backend `docs/ASAMA9_IMPORT_DESIGN.md` bölüm 12 (K1–K12, hepsi önerilen cevapla). Kapsam: [ADR-014](ADR-014-pilot-and-production-operations.md) K8 (müşteri + hasta + aşı geçmişi; muayene/ödeme ilk sürümde yok). **Gerçek pilot dosya biçimi ve KVKK uzmanı çıktısı doğrulanmadı**; ilgili kararlar pilot klinik dosyası görüldüğünde gözden geçirilir.

## Kararlar

| # | Konu | Karar |
|---|---|---|
| K1 | Dosya biçimi | **Şablon + sütun eşleme:** klinik kendi Excel'ini yükler, sistem başlıkları tahmin eder, kullanıcı düzeltir. İlk sürüm: üç sayfalı şablon (müşteri / hasta / aşı); düz liste desteği pilot dosyası görülünce. |
| K2 | Hatalı satır | Doğru satırlar aktarılır, hatalılar atlanıp raporlanır (düzeltilip tekrar yüklenebilir; geri alma var). |
| K3 | Eski aşıların hatırlatma e-postaları | **Hiçbiri otomatik gitmez**; yönetici sayıyı görüp "hatırlatmaları aç" derse gider (gölge kullanım sonrası ve KVKK teyidiyle). |
| K4 | Aynı müşteri (aynı ad + telefon) | Mevcut müşteriyle eşleşir, yeni oluşmaz; hayvanlar ona bağlanır (tekrar yükleme güvenli, mevcut bilgi ezilmez). |
| K5 | Geçersiz/sabit hat telefonu | Telefonsuz aktarılır, raporda uyarı + özgün numara. |
| K6 | Bilinmeyen tür/aşı adı | İlk sürümde yeni tanım **oluşturulmaz**; klinik önce Ayarlar'dan ekler, yeniden doğrular ya da satır atlanır. |
| K7 | Geri alma | Bağı olan (geliş/ücret/muayene…) kayıt varsa hiçbir şey silinmez; kullanıcıya liste gösterilir. İsteğe bağlı: "bağı olanlar kalsın, gerisi silinsin". |
| K8 | Yetki | Yalnız yönetici düzeyi (`Imports.Read/Manage/Commit`). |
| K9 | Önizleme/hata dosyası saklama | İşlem bittikten 30 gün sonra silinir (sayılar ve özet kalır); KVKK danışmanı farklı süre derse değişir. |
| K10 | Aynı mikroçip iki hayvanda | Hata (satır aktarılmaz). |
| K11 | Çalışma biçimi | Arka plan işi: sekme kapansa da sürer, ilerleme ekranda izlenir. |
| K12 | Yaş sütunu | İlk sürümde desteklenmez (tahmini doğum tarihi uydurulmaz); yaş varsa `Not`'a düşer. |

## Sonuçlar

- Dilimler (backend `ASAMA9_IMPORT_DESIGN.md` bölüm 11): B1 temel + migration, B2 okuma/eşleme, B3 doğrulama/kuru çalıştırma, B4 uygulama (arka plan), B5 geri alma/temizlik, F1 frontend sihirbaz, T deneme/performans.
- Yeni izinler (`Imports.*`) ve migration yerel dev veritabanına doğrulanarak uygulanır; paylaşılan/üretim için ayrı onay.
- Riskler: pilot dosya biçimi tahminden farklı olabilir (R3), toplu hatırlatma e-postası (R1, K3 ile kapalı), outbox birikimi → sağlık 503 (R4, geri basınç).
