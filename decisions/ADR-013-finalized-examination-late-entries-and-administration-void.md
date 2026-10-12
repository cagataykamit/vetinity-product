# ADR-013 — Kesinleşmiş muayenede sonradan ekleme ve uygulama iptali

## Durum

**Kabul edildi (2026-10-12, kullanıcı onayı: "en iyi uygulamalarla uyumlu olsun, en iyisini yapalım").** Aşama 5 Uygulama kaydı (Dilim 2) açık noktalarını (backend `docs/ADMINISTRATIONS_API_CONTRACT.md` §8) kapatır. Dayanak: Aşama 4 kararları (kesinleşince kilit, yalnız ek not; bkz. [ADR-006](ADR-006-patient-timeline.md) ve `roadmap/AJAN-KUYRUGU.md`), Aşama 5 keşfi D3 (düzeltme yolu: gerekçeli iptal ve yeni kayıt), Aşama 6 D2 (geç gelen lab sonucu serbest).

## Bağlam

Kesinleşmiş muayeneye yeni uygulama kaydı bugün `Examinations.Finalized` ile reddediliyor. İlaç gerçekten verildiği hâlde kayıt yazılamazsa stok gerçekle uyuşmaz ve klinik kayıt dışı çözüme gider. Pasif yapılmış bir ürünün uygulaması da iptal edilemiyor (`Products.Inactive`); bu, stok iadesini engelliyor.

Sektör ve düzenleyici ilkeler (tıbbi kayıtta geç giriş/ek, finansal kayıtta silme yerine ters kayıt): orijinal kayıt korunur, ek ayrı kayıt olarak tarihli ve imzalı eklenir, nedeni yazılır, orijinalle karıştırılmaz, değişikliğin önceki hâli ve kimin yaptığı denetim izinde saklanır. Silme yerine ters hareket yazılır; iade edilen mal yalnızca kullanılabilir durumdaysa stoğa döner, bozuk/imha olan stoğa girmez.

## Karar

1. **Sonradan ekleme:** Kesinleşmiş muayeneye **uygulama kaydı** eklenebilir. Zorunlu **gerekçe** (5–500 karakter), kayıtta **"Kesinleştirmeden sonra eklendi"** işareti, ekleyen kullanıcı ve zaman damgası (denetim izi), yetki `Administrations.Create`. Orijinal muayene değişmez; ek kayıt ayrı görünür (muayene özeti ve timeline'da rozetli). Stok düşümü normal çalışır (Dilim 1 kuralları). Tedavi, reçete, aşı ve yatış için kilit aynen kalır (kesinleşmiş muayeneye yeni kayıt yok); lab sonuç girişi Aşama 6 D2 gibi serbest. Yeniden açma/revizyon geçmişi ertelenmiş kalır ([RECORD-007](../backlog/feature-backlog.md)).
2. **Onay iş akışı bu sürümde yok:** Ekleyenin muayene hekimi olması zorunlu değildir; kayıt ekleyeni ve gerekçeyi taşır, denetlenebilir. Hekime bildirim / onay akışı Aşama 8 bildirim ve açık işler kapsamında değerlendirilecek (backlog: sonradan eklenen kayıtlar için hekim bildirimi/onayı).
3. **Uygulama iptali pasif üründe de yapılabilir.** Silme yok; her zaman **ters hareket** yazılır, orijinal korunur. Ürün pasif kalır (yalnız yeni uygulamada seçilemez).
4. **İptalde stok sonucu seçilir:** (a) **Stoğa iade** (varsayılan; ilaç kullanılabilir durumda depoya döndü) veya (b) **Zarar/imha** (stok geri artmaz; kayıtta zarar olarak işaretlenir, gerekçe zorunlu). İptal edilenler varsayılan olarak gizli, süzgeçle görünür; iptal ve gerekçe izlenebilir.

## Sonuçlar

- Backend: Uygulama kaydında sonradan ekleme alanları (işaret, gerekçe), iptal sonucu alanı (iade / zarar), pasif ürün istisnası, denetim izi, sözleşme güncellemesi ve migration; yeni izin gerekmez.
- Frontend: Kesinleşmiş muayenede "Uygulama ekle (sonradan)" gerekçe diyaloğu ve rozet; iptal diyaloğunda "Stoğa iade et / Zarar yaz" seçimi; düzenleme dışı mesajlar.
- Ertelenen: hekim bildirimi/onayı, zarar raporu (Aşama 8 raporları).
