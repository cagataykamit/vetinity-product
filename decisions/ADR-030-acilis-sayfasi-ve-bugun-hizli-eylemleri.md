# ADR-030 — Açılış sayfası role göre, Bugün sayfasında hızlı randevu ve muayene

## Durum

**Kabul edildi (2026-10-16, kullanıcı şikâyeti: "Özetten başlamasının bir anlamı vardı, istediği gibi randevu ve muayene açabiliyordu, şimdi açamıyor").** Aşama 8 kararı D-M2'yi (2026-10-13) geri getirir ve ADR-017 K5'in "menüdeki ilk erişilebilir öğe" kuralını değiştirir.

## Bağlam

Menü yeniden düzenlenince (ADR-017 C1, ADR-023) açılış sayfası "menüdeki ilk erişilebilir öğe" oldu; yöneticiler de Bugün'e düşüyor. Özet'teki hızlı işlemler (Yeni Randevu, Randevusuz geliş, Müşteriler, Hastalar, Ödemeler) ve Bugün'de yok: Bugün'de yalnız Randevusuz geliş ve Hızlı satış var.

## Karar

1. **Giriş sonrası açılış:** Yönetici düzeyi (Özet yetkisi olan, yönetici rolü) → **Özet**; Resepsiyon ve Hekim → **Bugün**; Bugün yetkisi yoksa Özet; ikisi de yoksa ilk erişilebilir öğe. Kural tek yerde (`panel-home.redirect`); yetki testle sabitlenir.
2. **Bugün sayfasında hızlı eylemler:** başlıktaki eylem çubuğuna **"Yeni randevu"** ve **"Yeni muayene"** eklenir (mevcut Randevusuz geliş ve Hızlı satış yanında); yeni sayfa/akış yok, mevcut "yeni randevu" ve hasta seçerek "yeni muayene" rotaları kullanılır; mevcut yetki koşulları geçerli. Birincil eylem vurgusu tek olur (en sık kullanılan), diğerleri ikincil düğme.
3. Özet'teki hızlı işlemler değişmez (Muayene eklenmez; Özet yönetici özetidir).

## Sonuçlar

- Frontend: açılış yönlendirmesi, Bugün başlık eylemleri, testler. Backend değişikliği yok.
