# ADR-037 — Satış ortağı ve indirim kodu

## Durum

**Kabul edildi (2026-10-22, kullanıcı: "tamam 12 ay sürsün, yıllık satışta da 1 kerelik"; diğer maddelerde koordinatör önerisi).** Bağlam: [ADR-035](ADR-035-paketler-ve-fiyat.md) (yıllık indirim kalktı; indirim yalnız satış ortağı kodu ile). Satış ortakları kendi kodlarını müşteriye verir; müşteri kodla indirim alır, ortak komisyon kazanır; platform yöneticisi her ortağın satışını görür.

## Karar

1. **Varlıklar:** *Satış ortağı* (ad, e-posta, telefon, aktif/pasif; kişisel veri asgari). *İndirim kodu* (kod, ortak, müşteriye **indirim yüzdesi**, ortağa **komisyon yüzdesi**, geçerlilik başlangıç/bitiş, isteğe bağlı kullanım limiti, aktif/pasif). Bir ortağın birden çok kodu olabilir. *Kod kullanımı* (kod, kiracı/klinik, tarih, paket, her tahsilat için indirim ve komisyon tutarı, durum).
2. **Yüzdeler kod başına ayarlanır** (varsayılan yok, platform yöneticisi her kodda girer; öneri varsayılan %10 indirim, %20 komisyon).
3. **İndirim süresi = ilk 12 ay.** Aylık faturalandırmada ilk 12 tahsilat, **yıllık ödemede tek tahsilat** indirimli olur. 12 ay dolunca fiyat normale döner.
4. **Komisyon süresi = ilk 12 ay, tahsilat bazlı.** Komisyon **yalnız gerçek tahsilat olduğunda** (deneme süresinde değil) ve net tutar (KDV hariç, indirim sonrası) üzerinden işlenir; aylık ödemede ilk 12 tahsilat, **yıllık ödemede tek seferlik** (yıllık tek tahsilat 12 ayı kapsar). Tahsilat iade/iptal edilirse ilgili komisyon geri alınır.
5. **Tek kod / kötüye kullanım:** bir kiracı yalnız bir kod kullanır (kayıtta ya da ilk abonelik öncesi); ortak kendi kliniği için kendi kodunu kullanamaz; süresi dolan, pasif, limiti dolan kod reddedilir; doğrulama ucu anonim ve hız sınırlı, numaralandırmaya karşı "geçersiz kod" tek tip yanıt verir.
6. **Giriş yolları:** kayıt/abonelik sayfasında "Ortak kodu" alanı ve hazır bağlantı `vetinity.com/r/KOD` (kod kayıt akışına taşınır; zorunlu olmayan çerez KULLANILMAZ, URL parametresi ve oturum belleği yeterli).
7. **Görünürlük:** ilk sürümde yalnız **platform yöneticisi** (Vetinity'nin kendi yönetimi) ortak listesini, ortak başına kullanım/ücretli müşteri sayısı/ciro/hak edilen-ödenen komisyonu ve kullanım satırlarını görür; klinikler ortakları ve diğer klinikleri göremez. Ortağın kendi satışlarını görmesi sonraki sürüm (yalnız sayı/tutar, klinik kimliği olmadan).
8. **Komisyon ödemesi** sistem dışıdır; yönetici kaydı "ödendi" işaretler (tarih, not). Hukuki/vergisel niteliği (ortak serbest meslek/şirket, fatura) hukuki/mali görüş konusu, kod bunu çözmez.

## Sonuçlar

- Backend: ortak/kod/kullanım tabloları (migration), platform yöneticisi uçları, anonim kod doğrulama, abonelik/ödeme akışına indirim ve komisyon hesabı (mevcut faturalandırma sağlayıcı soyutlamasıyla), rapor uçları.
- Frontend: kayıt/abonelik akışında kod alanı ve `/r/:kod` yönlendirmesi, platform yöneticisine "Satış ortakları" yönetim ekranı ve raporu.
- Açık: faturalandırma altyapısının (iyzico) indirimli tutarı çekebilmesi ve tahsilat olayını bildirmesi koddan doğrulanacak; yıllık ödeme seçeneği OLACAK ve **kendi indirimi vardır** (kullanıcı, 2026-10-22, "B mantıklı"): yıllık fiyat = 10 ay fiyatı ("2 ay hediye"; Temel ₺9.990, Profesyonel ₺19.900, KDV hariç), tek tahsilat. **Kod indirimi yıllık indirimin ÜZERİNE uygulanır (üst üste biner)**; örn. yıllık + %10 kod ≈ toplam %25 indirim. Komisyon tabanı tüm indirimler sonrası net tutardır (KDV hariç); komisyon tek seferliktir. Sitede yıllık seçenek, faturalandırma altyapısı yıllık dönemi destekleyince eklenir (keşif bulgusuna bağlı; ADR-035'te yıllık satırı geri eklendi).

## Uygulama notu (2026-10-22, dal `feat/satis-ortagi-indirim-kodu`, main'e alınmadı)

Ayrıntı ve uç sözleşmesi: backend `docs/SALES_PARTNER_DISCOUNT_API_CONTRACT.md` (§0 keşif). Migration `AddSalesPartnerDiscountCodes` yazıldı, **uygulanmadı**.

**Keşif bulguları (koddan):**

- **iyzico:** Checkout Form ile **tek seferlik** kart çekimi var (kart saklanmaz, tekrarlayan/otomatik yenileme yok). Ödeme sonucu imzası doğrulanan webhook ile gelir (`PaymentSucceeded`); callback yalnız yönlendirme. İndirimli tutar sağlayıcıya geçilebiliyor (tutar checkout'ta hesaplanıp gönderiliyor) → Sonuçlar'daki "indirimli tutarı çekebilmesi ve tahsilat olayını bildirmesi" açığı: **evet, iki koşul da sağlanıyor**.
- **Dönem:** yalnız **aylık** (aktivasyon + 1 ay); süre dolunca kiracı yeniden ödeme başlatır. **Yıllık dönem desteklenmiyor** (dönem sabit, fiyat yapılandırması plan başına tek tutar, checkout'ta dönem seçimi yok) → yıllık ödeme ayrı iş (backlog BILL-001). İndirim/komisyon kuralı yıllık dönemi hesaplayacak şekilde hazır ve testli: fiyat sırası plan → yıllık indirim (10 ay) → kod → net, komisyon net üzerinden tek seferlik.
- **Fiyat:** kodda değil yapılandırmada; ödemeye **KDV eklenmiyor** (çekilen tutar = yapılandırılan fiyat, KDV hariç kabul edildi).
- **İade/iptal:** sağlayıcıdan iade olayı ve abonelik iptal komutu **yok**.
- **Platform yöneticisi:** JWT'de `platform_admin` claim'i var ama bununla korunan uç yoktu; `PlatformAdmin` rolü tüm izinlere bağlı olduğundan izinle klinik yöneticisinden ayrılamıyordu → yeni izin yerine claim'e bakan politika eklendi.

**Sapmalar / uygulama kararları:**

1. 12 ay penceresi **ilk gerçek tahsilatla** başlar (deneme sayılmaz). Aylıkta kural "pencere içindeki tahsilat" olarak uygulandı (aylık yenilemede en çok 12 tahsilat); pencere içindeki plan yükseltme fark tahsilatları da indirimlidir.
2. Komisyon yalnız **imzası doğrulanan webhook** tahsilatında yazılır; doğrulamasız panel "finalize" ve test sağlayıcısı (Manual) komisyon üretmez.
3. İade/iptal sağlayıcıdan gelmediği için platform yöneticisi tahsilat satırını gerekçeyle "İptal" işaretler; ödenmiş komisyon "geri alınacak" toplamına girer.
4. Kendi kodunu kullanma engeli: ortak kaydında isteğe bağlı bağlı kurum kimliği **ve** e-posta karşılaştırması; ikisinde de tek tip "geçersiz kod".
5. Kod kayıttan sonra da girilebilir, ancak yalnız **ilk ücretli tahsilattan önce** (abonelik sayfası).
6. Menü: Yönetim grubunda yalnız platform yöneticisine görünen "Satış ortakları" öğesi (görev tanımına göre; ADR-023 madde 4 "yeni sayfa kendi satırını almaz" ile gerilim: klinik kullanıcısı bu satırı hiç görmez).

**Mevcut akışta görülen, bu işte düzeltilmeyen riskler:** (a) panel finalize ucu ödemeyi sağlayıcıdan doğrulamadan aboneliği etkinleştiriyor; (b) süresi dolmuş denemede üst plana geçişte fark deneme penceresine göre oranlanıyor ve çekilen tutar 1 kuruşa iniyor.
