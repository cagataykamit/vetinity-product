# ADR-035 — Paketler ve fiyat (tanıtım sitesi, canlı yayın)

## Durum

**Kabul edildi (2026-10-17, kullanıcı: "pilot bölümümüz yok, tek paket olmasın, canlıya çıkıyormuş gibi hazırlanıyoruz; uygun bir şey belirle").** Kademe yapısını kullanıcı seçti (klinik sayısı + kullanıcı); **fiyat ve limit değerlerini kullanıcı koordinatöre bıraktı**, aşağıdaki değerler koordinatör önerisidir ve **ticari varsayımdır**: Türkiye'deki rakip fiyatları için güvenilir kaynak bulunamadı (rakipler fiyat yayımlamıyor), değerler pazar verisine dayanmaz. Kullanıcı istediği an değiştirir; fiyat/limit değerleri tek veri dosyasında yaşar (`pricing-plan.utils.ts`). Bu ADR [ADR-034](ADR-034-tanitim-sitesi-konumlandirma-fiyat-demo.md)'ün "pilot dönemi, tek paket" kısmını yerine geçer; deneme (14 gün ücretsiz, kart yok) ve demo kararı aynen kalır.

## Karar

Üç kademe, aylık fiyatlar KDV hariç, yıllık ödemede iki ay hediye (12 yerine 10 ay):

| | Temel | Profesyonel | Kurumsal |
|---|---|---|---|
| Fiyat (aylık, KDV hariç) | ₺1.490 | ₺2.990 | İletişime geçin |
| Yıllık ödeme | ₺14.900 / yıl | ₺29.900 / yıl | — |
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

- Frontend: `pricing-plan.utils.ts` bu tablodan beslenir; paketler sayfası 3 kademe, özellik karşılaştırma tablosu, aylık/yıllık seçici, SSS (fiyat, KDV, deneme, kademe geçişi); ana sayfa ve SEO/JSON-LD aynı verilerden.
- Fiyat ve limitler değişince tek dosya güncellenir; sitedeki sayılar kopyalanmaz.
- Faturalandırma/abonelik altyapısı (iyzico) bu kararın kapsamı dışındadır; kademe limitlerinin (kullanıcı/klinik sayısı) ürün içinde zorlanması ayrı iştir (backlog).
