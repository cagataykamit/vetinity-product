# ADR-026 — Liste satır eylemleri simge düğmesi olur, belirgin (dolu) simgeler

## Durum

**Kabul edildi (2026-10-16, kullanıcı kararı).** Menü simgeleriyle ([ADR-023](ADR-023-menu-grouping-and-placement-rule.md), Font Awesome) aynı simge ailesini kullanır. Rakip görünümü kopyalanmaz.

## Bağlam

Liste satırlarında "Detay" yazı bağlantısı var, düzenle/iptal simgeleri çok ince (outline) çizgili. Kullanıcı ikisinden de memnun değil: yazı yerine simge, simgeler daha belirgin.

## Karar

1. **Satır eylemleri simge düğmesidir:** "Detay" yazısı kalkar; Detay, Düzenle, Sil/İptal simge olarak gösterilir. Birincil metinli eylemler ("Ödeme al" vb.) olduğu gibi kalır.
2. **Simge ailesi Font Awesome Solid** (menüyle aynı; ince/outline simge yok): Detay `fa-eye`, Düzenle `fa-pen-to-square`, Sil `fa-trash-can`, İptal/geçersiz kıl `fa-ban`. Yalnız satırda gerçekten bulunan eylemler gösterilir.
3. **Erişilebilirlik zorunlu:** metin kalktığı için her düğmede `aria-label` ve fare/odakta ipucu (tooltip) bulunur; tıklanabilir alan en az 32×32 px (dokunmatikte 40).
4. **Renk:** Detay ve Düzenle nötr/ikincil vurgu, Sil/İptal tehlike rengi; üzerine gelince zemin tonu değişir. Renk tek başına anlam taşımaz (ipucu ve etiket var).
5. **Tek ortak bileşen:** satır eylemi düğmesi tek yerde yaşar (ortak bileşen + tek stil); sayfalar kendi ikon düğmesini yazmaz. Mevcut listeler bu bileşene taşınır.

6. **Düzenle her listede bulunur (2026-10-16, kullanıcı: "2 iş yaptırma"):** düzenleme sayfası/rotası olan her kaydın liste satırında, kullanıcının düzenleme yetkisi varsa **Düzenle** simgesi de bulunur; kullanıcı önce Detay'a girip sonra Düzenle'ye basmak zorunda kalmaz. Satırda Detay + Düzenle yan yana durur; kesinleşmiş/kilitli ya da salt okunur kayıtta mevcut koşula göre gizlenir veya pasif gösterilir (kural sayfanın mevcut düzenleme koşuluyla aynı).

7. **Sil/İptal listede de bulunur (2026-10-16, kullanıcı: "sil gerekiyorsa onu da yapalım"):** bir kaydın silme/iptal (geçersiz kıl) akışı **zaten varsa** (detay/düzenleme sayfasında ya da API'de) ve kullanıcının yetkisi varsa liste satırında da **Sil** (`fa-trash-can`) ya da **İptal** (`fa-ban`) simgesi bulunur. Simge, detaydaki eylemle **aynı onay penceresini, aynı yetkiyi ve aynı koşulu** kullanır (kural çoğaltılmaz). **Yeni silme yeteneği eklenmez:** silme akışı olmayan varlıkta (örn. müşteri/hasta, KVKK nedeniyle ayrı süreç; kesinleşmiş muayene; yasal kayıtlar) simge konmaz. Geri alınamaz silme onay penceresinde sonucu açıkça yazar; mali/klinik kayıtlarda mevcut davranış "sil" değil "iptal/geçersiz kıl" ise o kalır.

## Sonuçlar

- Frontend: ortak satır eylemi bileşeni ve tüm liste sayfalarının geçişi; spec'ler (aria-label, ipucu, eylem varlığı).
- Mevcut metin bağlantısı olarak "Detay"a güvenen testler güncellenir.
