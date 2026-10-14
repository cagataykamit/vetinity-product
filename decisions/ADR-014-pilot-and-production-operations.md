# ADR-014 — Pilot ve canlı işletim kararları

## Durum

**Kabul edildi (2026-10-13, kullanıcı onayı: "tüm önerileri kabul ediyorum").** Kaynak: backend `docs/ASAMA9_READINESS.md` bölüm 6 (K1–K9). Ana plan Aşama 9.

## Kararlar

| # | Konu | Karar |
|---|---|---|
| K1 | Hosting | **DEĞİŞTİ (kullanıcı, 2026-10-14): "buluta ihtiyacımız yok, kendi online sunucumuz var".** Pilot ve canlı **kullanıcının kendi sunucusunda** çalışır. Yönetilen bulut kararı geçersiz; bulut hesabı/abonelik işi kalktı. Sunucu ayrıntıları (işletim sistemi, SQL Server, konum, ağ, alan adı/sertifika, yedek, yönetim) **doğrulanmadı, kullanıcıdan alınacak**; yedekleme, izleme ve güvenlik sorumlulukları (yama, yedek, güvenlik duvarı, sertifika) platformdan kullanıcıya/projeye geçer. Mevcut IIS (Windows) belgeleri bu seçeneğe uyar, Linux ise Serilog yolu ve runbook yeniden yazılır. |
| K2 | Yedekleme | Günlük tam + sık işlem günlüğü yedeği (veri kaybı hedefi dakikalar), 30 gün saklama, ayrı konum, ayda bir geri yükleme provası; yönetilen platformun otomatik yedeği (RPO/RTO değerleri Dilim 4'te yazılı kabul). Query DB yedeği zorunlu değil. |
| K3 | KVKK | Pilottan önce KVKK uzmanı/avukatla veri envanteri, aydınlatma metni, saklama/silme, veri işleyen sözleşmesi, VERBİS değerlendirmesi. Teknik KVKK dilimi (Dilim 8) bu çıktıya göre ADR ile şekillenir. Hukuki tavsiye ürün ekibince verilmez. |
| K4 | Pilot klinik | Küçük, tek şubeli, 2–5 kullanıcılı, kâğıt/Excel kullanan klinik; ilk 2 hafta **gölge kullanım** (gerçek iş eski yöntemle sürer, paralel girilir). Klinik seçimi ve veri biçimi kullanıcı işi; Dilim 7 bunu bekler. |
| K5 | E-posta | Alan adına bağlı e-posta gönderim hizmeti (SPF/DKIM); sızan Gmail uygulama parolası iptal edilir (önceki "kabul edilen risk" kararı geçersiz); D10 gerçek gönderim testi bu hesapla, parola yalnız gizli depoya girer, sohbete yazılmaz. |
| K6 | Query DB | Pilotta okuma bayrakları **kapalı**; pilot hacminde yavaşlık ölçülürse (Dilim 9) açılır. |
| K7 | Varsayılan yönetici | Sabit parolalı varsayılan yönetici üretimde oluşturulmaz; ilk yönetici güvenli kurulum komutuyla yaratılır (Dilim 1). |
| K8 | İçe aktarma | Müşteri + hasta + aşı geçmişi; tüm klinik geçmiş (muayene, ödeme) ilk sürümde yok. |
| K9 | Zamanlama | Pilot kapsamı önce Aşama 1–3 senaryoları (muayene, geliş, ücret ve ödeme); Aşama 4–8 kalanı pilotla paralel gelir. |

## Sonuçlar

- Üretime çıkış koşulu (go-live): Dilim 1 (sertleştirme), 3 (ortam), 4 (yedek + geri yükleme provası), 5 (izleme), 6 (e-posta), 7 (içe aktarma), KVKK danışmanlığı tamamlanmış ve Dilim 10 provası geçmiş olmalı.
- Kullanıcı eylemleri (ajan yapamaz): ~~bulut hesabı/abonelik~~ (K1 değişti: kendi sunucu; sunucu bilgilerini sağlamak), KVKK uzmanı, pilot klinik, alan adı ve e-posta gönderim hizmeti, sızan parolanın iptali, ödeme sandbox anahtarlarının yenilenmesi.
- Ertelenen: Query DB okuma modelleri, tüm geçmiş veri içe aktarma, hesap kilitleme ([SEC-001](../backlog/feature-backlog.md)), JWT yetki geri alma ([SEC-002](../backlog/feature-backlog.md)).
