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
