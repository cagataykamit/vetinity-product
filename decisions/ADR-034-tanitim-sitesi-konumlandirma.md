# ADR-034 — Tanıtım sitesi konumlandırması, fiyat gösterimi ve deneme/demo modeli

## Durum

**TASLAK — kullanıcı onayı bekliyor (2026-10-16).** Hiçbir madde kabul edilmiş sayılmaz. Kaynak: [research/tanitim-sitesi-analizi-2026-10.md](../research/tanitim-sitesi-analizi-2026-10.md), [ux/tanitim-sitesi-onerisi.md](../ux/tanitim-sitesi-onerisi.md) (açık kararlar AK-1…AK-9). İlgili: [ADR-001](ADR-001-self-service-trial-strategy.md) (self-service trial), [ADR-002](ADR-002-example-clinic-strategy.md) (örnek klinik, ertelendi), [ADR-022](ADR-022-terminology-hasta.md), [ADR-024](ADR-024-hukuki-metin-taslaklari.md), [ADR-031](ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md), [ADR-033](ADR-033-alan-adi-ve-adres-duzeni.md).

## Bağlam

- `www.vetinity.com` bugün alan adı park sayfasına gidiyor; tanıtım sitesi yalnız `staging.vetinity.com`'da ve 2 Temmuz derlemesi. Site metni ürün dilinden (ADR-022) ve ürünün gerçek güçlü yanlarından (Bugün akışı, kayıt defterleri, KVKK formları, geçiş sihirbazı) kopuk; "Fiyat yakında" ve backend'le çelişen paket sınırları güveni düşürüyor.
- Rakip tanıtımları (E-vet Smart, DaySmart, VETport) fiyat gizler, demo + deneme sunar, entegrasyon listesi ve müşteri sayısı gösterir. Vetinity bugün entegrasyon, sayı ve referans gösteremez; gösterebileceği şey iş akışı, Türkiye'ye özgü yükümlülükler ve dürüstlüktür.
- Hedef kitle, fiyat gösterimi ve deneme/demo modeli WORKFLOW'a göre ADR gerektiren ürün kararlarıdır ("Trial, abonelik veya fiyatlandırma politikası").

## Öneri (karar değil)

| # | Konu | Öneri | Alternatifler |
|---|---|---|---|
| 1 | Ana hedef kitle | Türkiye'deki küçük klinik (1–5 kişi), kâğıt/Excel/eski programdan geçen; çok klinik ikincil satır; hastane sitede yok | Çok klinikli işletme ana kitle; hastane |
| 2 | Ana mesaj | "Kliniğinizin günü tek ekranda" (Bugün akışı); ikinci: "Defterler ve KVKK evrakı kendiliğinden" | "Modern yönetim platformu" (mevcut); "Kayıtlarınız güvende" |
| 3 | Ton ve dil | Sade klinik dili, "siz", ADR-022 terimleri, abartı ve sayı uydurma yok, "yapmıyoruz" listesi açık | Kurumsal/teknik; samimi "sen" |
| 4 | Fiyat gösterimi | Pilot fiyatı belirlenene kadar "Pilot dönemi fiyatı için yazın" (teklif al); belirlenince paket başına aylık TL açıkça yazılır. "Fiyat yakında" kaldırılır. Kullanıcı/klinik sınırlarının tek doğrusu backend kataloğu olur | Fiyat hiç yazılmaz (rakip modeli); tek paket |
| 5 | Deneme/demo | ADR-001 korunur (14 gün, kartsız) **ve** demo talebi eklenir; örnek klinik ertelendiği için pilot bitene kadar demo öne, deneme ikinci; panelde "ilk adımlar" kontrol listesi küçük iş olarak değerlendirilir | Yalnız deneme; yalnız demo |
| 6 | Söylenmeyecek iddialar | "Mevzuata uygun defter", "KVKK uyumlu", "SMS", "e-Fatura", "mobil uygulama", "Türkiye veri merkezi", müşteri sayısı: ilgili kanıt/onay gelene kadar sitede yer almaz; portal/mobil yalnız "geliştiriliyor" | — |
| 7 | Analitik | İlk sürümde yok (sunucu günlüğü); sonra kendi barındırılan çerezsiz sayaç; dış kaynak (GA/Pixel) yok | Dış analitik + çerez onayı |
| 8 | Adres düzeni etkisi | ADR-033 uygulanana kadar içerik işleri (WEB-001…007) aynı derlemede; tanıtımın ayrı/prerender derlemesi (WEB-008) ADR-033 ile birlikte | Tanıtım hemen ayrı projeye |

## Sonuçlar (kabul edilirse)

- Backlog WEB-001…008 sırayla açılır; D1–D2 küçük iş olarak hemen, D3–D6 kararlara bağlı.
- `pricing-plan.utils.ts` ve backend `SubscriptionPlanCatalog` tek kaynağa iner (sözleşme önce).
- Hukuki taslak bantları ve "resmî biçim doğrulanmadı" notları kalır (ADR-024/015).
- Kullanıcı eylemleri: alan adını siteye bağlama, iletişim bilgileri ve tüzel kişi adı, pilot fiyatı.

## Açık sorular

Öneri belgesi AK-1…AK-9. Kullanıcı onaylayınca bu ADR "Kabul edildi" olur ve seçilen seçenekler buraya yazılır.
