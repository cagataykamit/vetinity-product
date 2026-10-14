# ADR-023 — Menü gruplaması, "Müşteri ve Hasta" girişi ve yeni sayfa yerleştirme kuralı

## Durum

**Kabul edildi (2026-10-15, kullanıcı: "tamam yap").** [ADR-017](ADR-017-workflow-centered-navigation.md) menüsünün devamı; UX-009 ("menü görünümü son hali") bu karar ile netleşir. Hedef kitle klinik çalışanı ([ADR-020](ADR-020-clinic-staff-centered-patient-card.md)), arayüz dili [ADR-022](ADR-022-terminology-hasta.md).

## Bağlam

Menüde "Hastalar" satırının altında Ara · Müşteriler · Hastalar sekmeleri vardı: ad, içeriği yansıtmıyordu (müşteri hasta değil) ve satırın günlük işlevi "bul veya yeni kayıt aç" idi; tam liste gezmek günlük iş değil. Ayrıca ileride gelecek sayfalar için yerleşim kuralı yoktu. Menü yazı ve simgeleri küçük bulundu.

## Karar

1. **Tek giriş: "Müşteri ve Hasta"** (eski "Hastalar"). Açılış sayfası **Ara** (tek arama, müşteri ve hasta birlikte; bulunamazsa "Yeni müşteri / Yeni hasta"); **Müşteriler** ve **Hastalar** listeleri ikinci sekmeler. Ayrı iki menü satırı açılmaz.
2. **Gruplama (küçük bölüm başlıkları):** GÜNLÜK İŞ (Bugün, Randevular) · MÜŞTERİ VE HASTA · KLİNİK (Kayıtlar) · PARA VE STOK (Para, Stok) · YÖNETİM (Raporlar, Özet [yalnız yönetici], Ayarlar). Daraltılmış menüde başlıklar yerine ince ayırıcı.
3. **Okunabilirlik:** menü yazı ve simge boyutu büyütülür (satır yüksekliği ile birlikte), kısa ekranda kaydırmasız sığma kuralı (min. satır yüksekliği) korunur.
4. **Yeni sayfa yerleştirme kuralı:** yeni sayfa kendi menü satırını almaz, ilgili satırın **sekmesi** olur; yeni üst düzey satır yalnız kendi günlük iş akışı olan sayfa için açılır. Planlı yerleşim: Aranacaklar → Randevular; Hizmet kataloğu/fiyat listesi → Stok > Hizmetler; Fatura/e-belge → Para > Faturalar; Görüntüleme → Kayıtlar; Yardım, güncelleme notları, destek → kullanıcı menüsü (sağ üst); bildirimler → üst çubuk zili; KVKK form metni, abonelik, üyeler → Ayarlar; deneme/onboarding → üst şerit.
5. **Değişmeyenler:** rotalar ve izinler (`/panel/...`), "Yeni" yalnız bağlamdan ([ADR-017](ADR-017-workflow-centered-navigation.md) K4), tüm sayfalar aynı kalır; yalnız menü etiketi, gruplama ve boyut değişir.

## Sonuçlar

- Frontend: `panel-navigation.ts` (MENU_GROUPS, bölüm başlığı alanı), menü bileşeni/SCSS (başlık, boyut, daraltılmış hâl), `app.menu.spec`/`panel-navigation.spec`; sayfa başlık kategori satırı yeni adı kullanır.
- Riskler: menü yeniden alıştırma maliyeti (pilot öncesi yapıldığı için düşük); bölüm başlıkları kısa ekranda yer tüketir (başlıklar küçük ve katlanabilir/ince tutulur, kaydırmasız sığma testle korunur).
