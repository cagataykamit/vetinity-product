# ADR-020 — Klinik çalışanı odaklı hasta kartı ve muayene çalışma alanı düzeni

## Durum

**Kabul edildi (2026-10-14, kullanıcı: "evet bu düzen hoşuma gitti", taslak ekranlar sohbette gösterildi).** Hedef kitle: **klinik çalışanı** (hekim, resepsiyon, yardımcı personel birlikte). Uygulama kullanıcı onayıyla, dilim dilim başlar; bu ADR yalnız yönü kaydeder. İlgili: [ADR-017](ADR-017-workflow-centered-navigation.md), [ADR-018](ADR-018-charge-suggestion-and-service-catalog.md), [ADR-004](ADR-004-navigation-and-menu-philosophy.md), [ux/HEDEF-IS-AKISLARI-2026-10.md](../ux/HEDEF-IS-AKISLARI-2026-10.md).

## Bağlam

E-vet müşteri kartı veri girişi/düzenleme formu odaklı (okunacak özet yok; bilgi için ayrı sayfalara gidilir). DaySmart hasta profili okuma odaklı (vadesi gelen işler, vital özeti, açık tanılar, dikkat paneli, süzgeçli geçmiş) ama ABD odaklı alanlarla kalabalık. İkisinde de "şimdi ne yapılmalı" tek bakışta yok ve ücretlenmemiş işlem görünmüyor. Bizde müşteri ve hayvan sayfaları kayıt türüne göre kartlara bölünmüş (liste listesi).

## Karar

1. **Okuma-öncelikli 360 görünüm; düzenleme formu ikinci planda** (Düzenle düğmesi arkasında).
2. **Hasta kartı:** (a) başlık: kimlik, tür/ırk/yaş/kilo/çip, sahip ve telefon, **uyarı rozetleri** (ısırır, alerji vb.), hesap durumu (açık borç, son/sonraki ziyaret); (b) **eylem çubuğu her zaman görünür** (Geldi, Muayene başlat, Randevu al, Aşı, Lab, Ücret ekle, Ödeme al; izne göre); (c) **"Yapılacaklar" paneli:** gecikmiş/yaklaşan aşı, bekleyen lab, ücret bekleyen işlem, açık borç; her satırda tek tıkla eylem; (d) **klinik özet** (kilo, vital, açık tanı, aktif tedavi) ve **süzgeçli tek zaman çizelgesi** (tümü, muayene, aşı, lab, tedavi, ödeme).
3. **Aynı sayfa, rol bazlı vurgu:** hekim klinik bilgiyi, resepsiyon para ve randevuyu öne çıkarır (yeni ekran/menü yok; mevcut izinlerle; ayrı rol menüleri [UX-007](../backlog/feature-backlog.md) pilot sonrası).
4. **Muayene çalışma alanı:** solda **hasta bağlamı yan yana** (kilo, gecikmiş aşı, aktif tedavi, son muayeneler; sayfa değiştirmeden), ortada kayıt (şikâyet, bulgu, **vital satırı**, **tanı: kliniğin kendi listesinden arayarak**, işlemler listesi ve "+ Ekle"), üstte **şablon** (şikâyet/bulgu/işlem ön dolum), sağda kesinleştirme kontrol listesi (uyarılar engel değil; ADR-013 kilidi korunur).
5. **Hızlı giriş** (tanı/şikâyet sözlüğü, tedavi şablonu ve paketi) hedef kitle klinik çalışanı olduğu için **pilot öncesine alınır** (önceki "pilot sonrası": P7, P9).
6. Müşteri kartı aynı ilkeyle: üstte bakiye, açık borç, ücret bekleyenler, son/sonraki ziyaret; hayvanları (durum süzgeciyle); iletişim tercihi; düzenleme formu arka planda.

## Sonuçlar (önerilen dilimler, onayla başlar)

| # | Dilim | Tür |
|---|---|---|
| S1 | Hasta kartı yeniden düzeni: başlık, Yapılacaklar paneli, klinik özet, süzgeçli zaman çizelgesi (mevcut veriyle; hasta bazlı "yapılacaklar" için küçük okuma ucu gerekebilir) | FE (+ küçük BE-S) |
| S2 | Muayene çalışma alanında hasta bağlamı yan yana ve vital satırı | FE |
| S3 | Tanı/şikâyet sözlüğü (klinik listesi, aramalı seçim) | BE + MIG + FE |
| S4 | Tedavi şablonu ve paketi (ön dolum + ücret önerisi ile birlikte çalışır) | BE + MIG + FE |
| S5 | Müşteri kartı düzeni, rol bazlı vurgu ayarı | FE |

- Riskler: ekranlar yalnız taslakla gösterildi (gerçek kullanıcıda denenmedi); şablon/sözlük içeriği klinikler arasında değişir, başlangıç içeriği rakip pratiğinden türetilir, pilotta doğrulanır.
