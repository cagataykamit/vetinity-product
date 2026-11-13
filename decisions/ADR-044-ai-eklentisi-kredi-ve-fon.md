# ADR-044 — AI eklentisi: kredi, kota ve fon

## Durum

**Kabul edildi (2026-11-06, kullanıcı); değiştirildi (2026-11-14, kullanıcı: her pakette dahil, kullanıcı başına kota, ek kredi, pilotta erken deneme — bkz. "Değişiklik — 2026-11-14").** Model kabul edildi; aşağıdaki kredi miktarları ve satış fiyatları **örnek ve ticari varsayımdır**, gerçek kullanım ölçülünce kesinleşir. Kod yok. [ADR-008](ADR-008-embedded-ai-assistant.md)'in kota ve maliyet maddesini ve AI-007/AI-008'deki "kotalı, ücretli ek paket" kararını (2026-10-30) somutlaştırır; AI'nin yalnız taslak üretmesi kuralı aynen geçerlidir.

## Bağlam

AI maliyeti kullanım başına oluşur; pakete sınırsız gömülürse maliyet sınırsız kalır. Paketlerde genel kota istenmiyor; kota yalnız AI içindir ([ADR-035](ADR-035-paketler-ve-fiyat.md) 2026-11-06 notu). Bireysel Claude aboneliği müşterilere hizmet için uygun değildir: tüketici koşulları hesabı başkalarına açmayı ve anahtarsız otomatik erişimi yasaklar. Ticari API koşulları kendi müşterilerine sunulan ürünlerde kullanıma izin verir ve müşteri içeriğiyle model eğitimini yasaklar (anthropic.com/legal, okuma 2026-11-06). Kullanım politikası okunmadı.

## Karar

1. **Her pakete eklenebilen AI eklentisi.** Temel de alabilir. Tek API hesabı yalnız backend'de kullanılır, anahtar kliniğe ya da frontend'e verilmez (ADR-008).
2. **Ölçü kredidir.** Standart istek (varsayım: 2.000 token giriş, 500 token çıkış) Hızlı AI'da 1 kredi, Üst düzey AI'da 20 kredidir; daha uzun istek token'a göre daha çok harcar. Oran model fiyatından gelir.
3. **Modeller.** Hızlı AI: Claude Haiku 5.5 ($0,10 / $0,50, 1 milyon token). Üst düzey AI: Claude Sonnet 5.5 ($2 / $10). Opus eklenmez. Fiyatlar platform.claude.com, 2026-11-06. Hangi işte hangi modelin yeteceği denenerek belirlenir.
4. **Örnek tarife (KDV hariç, kesinleşmedi).** En yüksek maliyet, kredi başına $0,00045 varsayımının iki katıyla hesaplandı; ödeme komisyonu ve kur payı dahil değil.

| Eklenti | Aylık kredi | En yüksek maliyet | Örnek satış |
|---|---|---|---|
| Başlangıç | 2.000 | ~$1,80 | $5 |
| Standart | 10.000 | ~$9 | $19 |
| Yoğun | 40.000 | ~$36 | $69 |
| Ek fon (tek seferlik) | 1.500 | ~$1,35 | $5 |

5. **Üst paket hediyesi.** Temel 0, Profesyonel 500, Kurumsal 2.000 aylık kredi; eklentiyle toplanır.
6. **Fon.** Eklentiyi alırken ya da sonradan eklenir; otomatik para çekilmez. Önce aylık kota, sonra fon harcanır. Aylık kota devretmez, satın alınan fon devreder.
7. **Kota bitince** yalnız AI durur, klinik iş akışı devam eder (ADR-008 madde 6). %80'de ve bitişte uyarı verilir.
8. **Maliyet sınırları.** İstek başına en fazla token, kullanıcı başına dakikalık istek sınırı, klinik başına aylık kredi sınırı, tüm sistem için aylık harcama alarmı ve durdurma. Her isteğin gerçek token ve maliyeti kaydedilir (AI-008); klinik verisi normal loglara yazılmaz.
9. **Dolar bazlı hesap, TL satış.** Maliyet ve kredi değeri dolar üzerinden izlenir. Site ve ödeme TL'dir; TL tarifesi kura göre dönemsel güncellenir, alınmış dönem ve fon değişmez. Değerler tek yerde yaşar (backend ayarı), sitede kopyalanmaz.

## Değişiklik — 2026-11-14 (kullanıcı kararı): her pakette dahil, kullanıcı başına kota

Kullanıcı: "Her pakette küçük bir ücretsiz kota olsun, üst paketlerde kota büyüsün, yoğun kullanan klinik için ek kredi satılsın; bu yönde ilerleyelim." Madde 1, 5 ve 6 şöyle değişir; diğer maddeler geçerli.

- **D1 — Her pakette dahil kota (madde 5'in yerine).** AI her pakette, kotalı olarak dahildir; satışta "yapay zekâ dahil" denir. Kota **kullanıcı başına** tanımlanır, klinikte havuzlanır: klinik havuzu = paket kotası × aktif kullanıcı sayısı. Bir kullanıcı ayda kendi payının en çok 2 katını harcayabilir; böylece tek kişi havuzu bitiremez. Yönetici kullanıcı başına sınırı düşürebilir.

| Paket | Aylık kredi / kullanıcı (örnek) | Yaklaşık kullanım | En yüksek maliyet / kullanıcı |
|---|---|---|---|
| Temel | 100 | günde ~5 standart istek | ~$0,09 |
| Profesyonel | 300 | günde ~14 | ~$0,27 |
| Kurumsal | 800 | günde ~36 | ~$0,72 |

  Hesap madde 2 ve 4'teki varsayımla: 1 kredi = Hızlı AI (Haiku) standart istek, en yüksek maliyet kredi başına ~$0,0009. Rakamlar örnektir; pilot ölçümüyle kesinleşir.
- **D2 — Ek kredi (madde 1 ve 6'nın yerine).** Ayrı aylık "eklenti" zorunlu değildir; dahil kotayı aşan klinik **ek kredi paketi** alır (madde 4'teki tablo ek kredi fiyatlaması için örnek kalır; "Ek fon" satırı esas alınır). Ek kredi devreder, dahil kota devretmez. Önce kullanıcının dahil payı, sonra klinik havuzu, sonra ek kredi harcanır.
- **D3 — Üst düzey AI (Sonnet).** Dahil kota yalnız Hızlı AI (Haiku) içindir; Üst düzey AI ek krediyle kullanılır (madde 2'deki 20 kredi oranı).
- **D4 — Pilotta erken deneme.** Ücretli ödeme canlıya açılmadan, pilot klinikte ücretsiz deneme yapılır: yalnız Hızlı AI, ilk özellik hasta geçmişi özeti (AI-002), pilot kliniğe özel açma ayarı, tüm sistem için düşük aylık harcama sınırı (Console'da ve backend'de). Amaç gerçek token/maliyet ölçümü ve kalite karşılaştırması (birkaç örnekte Sonnet ile).
- **D5 — API hesabı.** Kullanıcı Claude Console'da (platform.claude.com) kuruluş hesabı açar, kredi yükler, aylık harcama sınırı koyar ve API anahtarını sunucuya kendisi girer; anahtar sohbete ve depoya yazılmaz. Bireysel Claude aboneliği kullanılmaz (Bağlam).
- **D6 — Kendi sunucuda açık model kullanılmaz** (2026-11-14 değerlendirmesi): canlı sunucuda çalıştırmak API/SQL'i yavaşlatır, ekran kartlı sunucu API maliyetinin çok üstündedir, küçük açık modeller Türkçe tıbbi metinde zayıftır. Yerel işleme yasal zorunluluk olursa yeniden değerlendirilir.

## Riskler ve açık noktalar

- **Hukuk (doğrulanmadı):** dövizle fiyatlama kısıtı (32 sayılı Karar, hatırlanan bilgi), yurt dışına veri aktarımı (KVKK), fonun iade koşulları ve satış metinleri. Çalışma varsayımı: TL satış; mümkün olduğunca kimlik bilgisi gönderilmez; klinik açıkça bilgilendirilir; çıktının hatalı olabileceği ve kontrol gerektiği söylenir (ticari koşullar D.3).
- **Maliyet varsayımı ölçülmedi.** Düşünme payı, uzun hasta geçmişi ve yeniden denemeler maliyeti artırır. Az sayıda klinikle deneme yapılır, tarife gerçek veriyle kesinleşir.
- **Hız sınırları incelenmedi.** Tek hesabın aynı anda taşıyacağı yük denemede görülür.
- **Çalışmayan özellik sitede yazılmaz** (ADR-034 karar 6): eklenti çalışmadan paketler sayfasında yer almaz.

## Uygulama

Backlog TIER-013 ve TIER-014; bağımlılıklar TIER-001 ve ücretli ödemenin canlıya açılması. İlk özellik hasta geçmişi özetidir (AI-002; kullanıcı kararı 2026-11-06): her bilgiden kayda bağlantı, yalnız taslak. Sesli not (AI-005 + AI-001) sonraya kalır; ses yazıya çevirme maliyeti bu hesapta yoktur ve ayrı hizmet gerektirebilir (doğrulanmadı).
