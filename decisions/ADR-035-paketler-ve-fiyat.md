# ADR-035 — Paketler ve fiyat (tanıtım sitesi, canlı yayın)

## Durum

**Kabul edildi (2026-10-17, kullanıcı: "pilot bölümümüz yok, tek paket olmasın, canlıya çıkıyormuş gibi hazırlanıyoruz; uygun bir şey belirle").** Kademe yapısını kullanıcı seçti (klinik sayısı + kullanıcı); **fiyat ve limit değerlerini kullanıcı koordinatöre bıraktı**, aşağıdaki değerler koordinatör önerisidir ve **ticari varsayımdır**. Tek gözlenen pazar verisi (kullanıcı, 2026-10-17, Kolayvet fiyat sayfası): Standart ₺999, Profesyonel ₺1.990, Plus ₺4.990 aylık (yıllıkta yaklaşık yarısı), Premium teklifle; onlarda SMS, e-fatura ve WhatsApp dahil, bizde yok; bu yüzden fiyatlar o seviyenin altına ve yakınına konuldu, yapı ve içerik kopyalanmadı. Kullanıcı istediği an değiştirir; fiyat/limit değerleri tek veri dosyasında yaşar (`pricing-plan.utils.ts`). Bu ADR [ADR-034](ADR-034-tanitim-sitesi-konumlandirma.md)'ün "pilot dönemi, tek paket" kısmını yerine geçer; deneme (14 gün ücretsiz, kart yok) ve demo kararı aynen kalır.

- 2026-10-22: yıllık ödeme ve indirim kaldırıldı (kullanıcı); satış ortağı indirim kodu ayrı ADR.

## Karar

Üç kademe, aylık fiyatlar KDV hariç; faturalandırma aylık:

| | Temel | Profesyonel | Kurumsal |
|---|---|---|---|
| Fiyat (aylık, KDV hariç) | ₺999 | ₺1.990 | İletişime geçin |
| Klinik | 1 | 1 | Çok klinik |
| Kullanıcı | 3 | 10 | Sınırsız |
| Çekirdek klinik akış: Bugün/geliş, randevu, muayene, hasta kartı ve zaman çizelgesi, aşı, tedavi/reçete, lab durumu, yatış | ✔ | ✔ | ✔ |
| Ücret, tahsilat, bakiye, gün sonu, stok ve satış | ✔ | ✔ | ✔ |
| Resmî kayıt defterleri, Aşı Bilgi Raporu, KVKK formları (aydınlatma/açık rıza), veri kopyası | ✔ | ✔ | ✔ |
| Eski sistemden veri aktarımı (içe aktarma sihirbazı) | ✔ | ✔ | ✔ |
| Rol bazlı yetki, denetim kaydı | ✔ | ✔ | ✔ |
| Hasta sahibi portalı (aşı, randevu, bakiye; telefonda ana ekrana eklenebilir) | — | ✔ | ✔ |
| Çok klinik yönetimi ve klinikler arası yetki | — | — | ✔ |
| Destek | E-posta | E-posta, öncelikli | Özel iletişim, kurulum desteği |

İlkeler: yasal zorunlu kayıt defterleri ve KVKK araçları hiçbir kademede kilitlenmez (mevzuata uyum ücretli basamak olmaz); fark kullanıcı sayısı, çok klinik ve hasta portalıdır. Hasta sahibi **mağaza uygulaması** yayına çıkana kadar sitede "mağazada" ifadesi kullanılmaz. SMS hatırlatma, e-fatura, online ödeme, online randevu yoktur ve sitede "yok/yakında" diye reklam edilmez; "Bugün yok" bölümü dürüst olarak kalır ("Şu an yok" kısa liste).

## Sonuçlar

- Frontend: `pricing-plan.utils.ts` bu tablodan beslenir; paketler sayfası 3 kademe, özellik karşılaştırma tablosu, yalnız aylık fiyat, SSS (fiyat, KDV, deneme, kademe geçişi); ana sayfa ve SEO/JSON-LD aynı verilerden.
- Fiyat ve limitler değişince tek dosya güncellenir; sitedeki sayılar kopyalanmaz.
- Faturalandırma/abonelik altyapısı (iyzico) bu kararın kapsamı dışındadır; kademe limitlerinin (kullanıcı/klinik sayısı) ürün içinde zorlanması ayrı iştir (backlog).
