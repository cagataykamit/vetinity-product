# Vetinity — Uçtan uca yol haritası ve ürün kararları

**Tarih:** 8 Ekim 2026  
**Hedef:** Küçük ve orta ölçekli companion animal klinikleri için ilk ticari sürüm; ardından kontrollü genişleme.  
**Belge türü:** Mevcut incelemeye dayanan ayrıntılı karar ve uygulama sırası önerisi.

## 1. Bu belgenin karar ve kanıt statüsü

Kabul edilmiş ADR-001–008 ürün yönünü oluşturur. Aşağıdaki yeni kapsam, durum, veri modeli ve sürüm önerileri bu yönün ayrıntılandırılmasıdır; product repository'ye henüz işlenmedi ve uygulandı anlamına gelmez. Uygulama geliştirmesi bu talebin parçası değildir.

Kod durumu, önceki bağımsız incelemenin şu checkpoint'lerine dayanır: product 8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54; frontend 0dde1770d50220a2c1dea1bdabdcf97deb20278d; backend af5c2ab8044bf5b025d4243bac294d67a2c0a87f. Bu belgede yeni build, test, migration, seed veya deploy çalıştırılmadı; yeni repository HEAD kontrolü ve rakip sitesi incelemesi yapılmadı.

“Mevcut” ifadesi belirtilen dar kapsamın kaynak kodunda bulunduğunu; “eksik” ifadesi incelenen ilgili kaynaklarda karşılığının bulunmadığını anlatır. Gerçek çalışma sonucu, test başarısı ve üretim veritabanı durumu ayrıca doğrulanmalıdır.

**“Rakipten daha iyi hale getirdik” ifadesini bugün tamamlanmamış işler için kullanmıyoruz.** Aşağıda daha iyi deneyim hedefini ve bunu hangi kabul senaryosuyla doğrulayacağımızı yazıyoruz. Bütün rakibin önüne geçildiği sonucu bu benchmark'tan çıkarılamaz.

## 2. Ürün yönü ve rakiplerin rolü

Vetinity'nin temel vaadi: hasta bulma, geliş, muayene, ilgili klinik işlemler, ücret, tahsilat ve takip boyunca aynı hasta ve ziyaret bağlamını koruyan; hekim ile resepsiyonun günlük işini tamamlayan sade bir klinik yönetimi.

| Kaynak | Kullanacağımız güçlü yön | Vetinity'ye uyarlama | Kanıt sınırı |
|---|---|---|---|
| DaySmart Vet | SOAP çalışma alanı, görünür hasta bağlamı, Census, geçmiş bağlantıları, arama, rapor katalogları, şablonlar | Türkçe klinik bölümler; kompakt bağlam; hafif geliş akışı; sade iç navigasyon | Canlı sandbox ile webinar/demo ayrı kanıtlardır; bütün durum geçişleri ve backend mimarisi doğrulanmış değildir. |
| E-Vet Smart+ | Hasta kabulde sahip–hasta hiyerarşisi, operasyon iş listeleri, lab istemleri, aşı/takip, yerel satış ve finans yüzeyleri | Az zorunlu alan; hasta içinden işlem; görünür bekleyen işler; sade temel ücret ve bakiye | UI gözlemleri. e-belge ve Xray kısmen doğrulanmış; muhasebe motoru, cihaz entegrasyonları ve resmi süreçler kesin değildir. |
| Provet Cloud | Muayene merkezli işlem, ücretlendirme ve taburculuk sürekliliği; eksikler için açıklanabilir öneriler | Muayeneden bağlı ücretlere geçiş; kısa bakım tamamlama kontrolü; hekim onayı | Eğitim/demo videosundaki sınırlı akış. Hastane, çok şube ve entegrasyonların tamamı incelenmedi. |
| Vetinity'nin kendi kararları | Self-service trial, örnek klinik, tutarlı menü, mevcut CQRS ve kayıt omurgası, tenant/clinic sınırı | Mevcut altyapı korunur; gerekli bağlantılar ve yeni iş akışları eklenir | Ürün ADR'leri var; her kararın uygulaması tamamlanmış değildir. |
| ezyVet ve diğer ürünler | İleride araştırma kaynağı | Bu planda ayrıntılı workflow dayanağı olarak kullanılmaz | ezyVet ayrıntılı kanıtı yetersiz; Digitail/Bulutvet için bu çalışmada yeni bağımsız workflow doğrulaması yapılmadı. |

DaySmart ve E-Vet ana benchmark kaynaklarıdır. Provet, belirli akışlarda tamamlayıcı kaynaktır. Bir rakipteki ekran, veri modeli veya durum listesinin tamamını alma kararı yoktur. Kaynaklar: [DaySmart][DS], [E-Vet][EV], [Provet][PV], [ürün ilkeleri][PRINCIPLES], [hedef pazar][MARKETS].

## 3. Başlangıç durumu

| Alan | Kod incelemesindeki durum | Yapılacak iş |
|---|---|---|
| Giriş, klinik seçimi, abonelik | Temel mevcut; ilgili abonelik expiry/renewal düzeltmeleri push edilmiş | Yeniden yazım yerine yeni akışlarda yetki, scope ve ReadOnly regresyonlarını kontrol et. |
| Sahip ve hasta | Temel kayıtlar mevcut | Günlük bulma/seçme, duplicate deneyimi, kritik uyarı ve tarihli ölçüm bağlamını tamamla. |
| Randevu | Takvim, çakışma kuralları, kayıtlar mevcut | Muayene CTA yetkisini düzelt; geliş/bakım durumlarını ayır; eski form korumasını ayrıca doğrula. |
| Muayene | Create/edit ve kaynak ilişkileri mevcut; hedef deneyim eksik | Çalışma alanı, anamnez/plan/vital alanlar, sürüm kontrolü ve bağlantı bütünlüğü. |
| Tedavi, reçete, aşı | Temel kayıtlar mevcut; reçete serbest metin | Hasta/ziyaret bağlantılı işlem; gereken dar ürün/reçete satırı ve stok bağlantısı. |
| Lab | Sonuç kaydı mevcut | İstem, bekleyen sonuç ve takip akışı; dosya eki. |
| Görüntüleme | Hedef klinik kayıt/dosya capability'si eksik | Manuel hasta ve muayene bağlantılı görüntüleme kayıtları. |
| Yatış/taburcu | Temel yaşam döngüsü mevcut | Aktif yatış görünürlüğü, kısa bakım/taburcu talimatları ve takip. |
| Tahsilat | Payment kayıtları ve ödenen toplamları mevcut | Ücret kaynağı, borç, kısmi ödeme ve kalan bakiye. |
| Stok | Temel hareket ve concurrency mevcut | Klinik kullanımın onaylı ve tekrar işlem üretmeyen bağlantısı. |
| Geçmiş | Modül bazlı history-summary mevcut | Birleşik, sayfalı, kaynağa bağlı timeline ve klinik revizyon. |
| Menü, rapor, trial | Kısmi; kabul edilmiş ürün yönü var | Rapor merkezi, Ayarlar > Tanımlar, örnek klinik ve anlamlı ilk kullanım. |
| AI | Strateji ve ADR var; uygulama bu kapsamda doğrulanmadı | İlk ticari klinik akıştan sonra onaylı yardımcılar. |
| Üyeler/roller/davet, dashboard, bütün modüllerin yetkileri | Kod karşılığı var; tam bağımsız doğrulama yapılmadı | Canlıya çıkış kapsamı içinde tamamını doğrula; otomatik “DONE” kabul etme. |

Frontend ağacında otomatik spec dosyaları görülmedi. Backend test kaynaklarının varlığı testlerin geçtiğini göstermiyor. Ayrıntılı kod kanıtları önceki değerlendirmede bulunur.

## 4. Baştan sona teslim sırası

Takvim tarihi veya hafta tahmini verilmemiştir. Sıra, tek geliştiricinin bir işi kabul edilebilir küçük parçalarla tamamlayabilmesi için düzenlenmiştir. Yetki, veri bütünlüğü, test, hata yönetimi ve erişilebilirlik her aşamanın kabulüne dahildir.

| Aşama | Öncelik | Teslim edilecek sonuç | Sürüm konumu |
|---|---|---|---|
| 0 | Başlangıç + sürekli | Mevcut kapsamı ve ürün belgelerini hizalama; çalışma durumunu koruma; temel release eksiklerini doğrulama | Her sürümün temeli |
| 1 | P0 | Güvenli, bağlamlı muayene çalışma alanı | İlk geliştirme işi |
| 2 | P0 | Hasta bulma, geliş, bekleme ve Bugün yüzeyi | Kontrollü pilotun operasyon temeli |
| 3 | P0 | Temel ücret, tahsilat, kısmi ödeme ve bakiye | Kontrollü pilotun finans temeli |
| 4 | P1 | Hasta özeti, kritik uyarılar, timeline, klinik revizyon/finalization | v1.0 klinik sürekliliği |
| 5 | P1 | Tedavi, reçete ve klinik stok kullanımının gereken dar bağlantısı | v1.0 günlük işlem bütünlüğü |
| 6 | P1 | Lab istem/bekleyen sonuç ve manuel görüntüleme/dosya kayıtları | v1.0 diagnostik katmanı |
| 7 | P1 | Yatış görünürlüğü, bakım tamamlama, taburcu talimatı ve takip | v1.0 bakım sürekliliği |
| 8 | P1 | Menü, rapor merkezi, bildirim/açık işler, örnek klinik ve onboarding | v1.0 kullanım ve keşif |
| 9 | Çıkış koşulu | Gerçek klinik senaryolarıyla pilot; sorunları kapatma; canlı işletim ve müşteri geçişini doğrulama | İlk ticari sürüm |
| 10 | P2 | Şablonlar/snippet, seçilmiş paketler ve onaylı AI yardımcıları | v1.x farklılaşma |
| 11 | P2 / ihtiyaca göre P1 | Online randevu, gelişmiş finans/kapanış, SMS/e-belge/POS/iletişim/portal | Talep doğrulanmış genişleme |
| 12 | Future | Cihaz/LIS/PACS, ileri yatış, mobil, hastane/enterprise ve yeni segmentler | İlk klinik sürümünden sonra |

2. aşamadaki günlük arama ve 4. aşamadaki kompakt hasta özeti için gereken küçük parça 1. aşamada da kullanılabilir. Bu tablo büyük arama veya tam timeline bitmeden muayenenin başlamasını engellemez. Mevcut altyapı eksikliği görülürse ilgili en küçük release blocker öne çekilir.

## 5. Aşama 0 — Başlangıç ve ürün belgelerinin hizalanması

**Kaynak:** Vetinity'nin kendi ürün ve teknik kararları. Rakip mimarisi alınmıyor.

**Karar:**

1. Başlangıçta mevcut yerel değişiklikler ve uzak sürümler kontrol edilip korunur. Push edilmiş abonelik düzeltmeleri tekrar yapılacak iş olarak yazılmaz.
2. “Kod mevcut”, “test edildi”, “pilot kabulü alındı” ve “yayınlandı” ayrı durumlar olarak tutulur.
3. Backlog, roadmap, v1 scope ve release-plan aynı kapsam/sırayı anlatır. EXAM parent–child ilişkisi teknik bağımlılık döngüsü olmaktan çıkarılır.
4. Check-in'in online booking bağımlılığı kaldırılır. Timeline'ın bütün yatış geçmişi ve her AI taslağı için zorunlu teknik ön koşul olduğu varsayılmaz.
5. Temel ücret/bakiye, dar front-desk araması, lab istemi ve reçete satırı gibi exact kaydı olmayan kapsamlar açık backlog işleri olarak tanımlanır. Komşu feature ID'siyle tamamlanmış sayılmaz.
6. Auth, clinic/tenant izolasyonu, üyeler/roller/davet, dashboard, hesap/organizasyon ayarları ve mevcut reminder'ın v1 release blocker kapsamı doğrulanır.

**Beklenen iyileşme:** Sırası uygulanabilir ve kabulü ölçülebilir plan; aynı işi tekrar yapmama.

**Kabul:** Bir geliştirici sıradaki işin ne olduğunu, ön koşulunu, kapsam dışını ve hangi senaryolarla biteceğini tek brief'ten anlayabilir.

**Kalan sınır:** Bu belgenin yazılması ürün repository'sinin güncellendiği veya testlerin tamamlandığı anlamına gelmez. [Ürün workflow'u][WORKFLOW], [backlog][BACKLOG], [release scope][SCOPE].

## 6. Aşama 1 — Muayene çalışma alanı

**Rakip seçimi:** DaySmart SOAP temel yapı; Provet hasta bağlamı ve bölüm navigasyonu tamamlayıcı. E-Vet Muayene Odası bu alanın modeli değildir; operasyon iş listesidir.

**Mevcut dayanak:** EXAM-001–005 ve kabul edilmiş ADR-005. Muayene create/edit var; anamnez, plan ve vital alanları eksik. [ADR-005][ADR5], [DaySmart SOAP][DS-SOAP], [Provet][PV].

**Ürün kararı:**

| Konu | İlk dilimdeki davranış |
|---|---|
| Ekran | Tam sayfa/geniş çalışma alanı; küçük modal içine klinik not sıkıştırılmaz. |
| Bölümler | Şikâyet ve anamnez; klinik bulgular ve vital değerler; değerlendirme/tanı; plan/tedavi planı. |
| Hasta başlığı | Hasta, sahip, tür/ırk, yaş, iletişim ve var olan klinik bağlam. Bilinmeyen ölçüm tarihi veya uyarı varmış gibi gösterilmez. |
| Ölçümler | Opsiyonel kilo, sıcaklık, kalp hızı, solunum sayısı; birim açık. Ölçüm tarih/kaynağı korunur. |
| Minimum kayıt | Doğru hasta/klinik, geçerli tarih ve şikâyetle düzenlenebilir kayıt. Eksik klinik alanlar açıklanır; otomatik klinik tamamlanma iddiası yoktur. |
| Findings | İlk dilimde mevcut string API karşılığı korunup boş değere izin verme tercih edilir. Nullable dönüşüm zorunlu kabul edilmez. |
| Kaydetme | Kayıt sonrası hasta bağlamında kalınır. Hata ve çakışmada kullanıcının metni korunur. |
| İlgili işlemler | Mevcut tedavi, reçete, aşı, lab, yatış ve ödeme yollarına kaynak muayene/hasta bağlamıyla geçilir. Tüm modüller ilk dilimde yeniden yazılmaz. |
| Veri güvenliği | GET'teki kayıt sürümü güncellemede zorunlu taşınır; eski form ve eksik sürüm korumayı geçemez. |
| Kayıt durumu | İlk dilim sunucuya kaydedilmiş düzenlenebilir kayıt sağlar. Gerçek Draft/Finalized ve revizyon politikası 4. aşamada tamamlanır. |

**Aynı işte kapanacak kaynak kod bulguları:**

- Metin düzenlemesinin appointmentId ilişkisini kaldırması riski.
- Muayene CTA'sının create yerine reschedule yetkisiyle gösterilmesi.
- Muayene tarih filtresinin FE–BE parametre uyuşmazlığı; İstanbul günü/UTC sınırları dahil.
- İki farklı zamanda kaydeden eski tarayıcı formlarında sessiz overwrite riski.

**Aldığımız güçlü yön:** Birleşik klinik not ve görünür hasta bağlamı.

**Vetinity'nin daha iyi deneyim hedefi:** Doğal Türkçe terminoloji, daha az görünür zorunlu alan, açıklanan kaydetme durumu ve çakışmada metin koruma. Rakibin “normal” metinlerini otomatik doldurup yapılmamış incelemeyi yapılmış gibi göstermeyiz. Klinik olarak doğrulanmamış %20 kilo uyarısı veya 1500 kg gibi sınırlar ilk dilime otomatik alınmaz.

**Kabul:** Randevudan muayene aç → kaydet → tekrar düzenle; hasta ve randevu ilişkisi değişmez. A ve B aynı kaydı açar; A'nın kaydı tamamlandıktan sonra B kaydettiğinde çakışma görür ve metni kaybolmaz. Eski kayıtlar ve export'lar açılır.

**Bu aşamadan sonra kalan:** Tam geliş/ziyaret, temel borç, timeline, kritik uyarı modeli, gerçek finalize/addendum, ürün bazlı reçete, stok tüketimi, AI ve görüntüleme.

## 7. Aşama 2 — Hasta bulma, geliş ve Bugün

**Rakip seçimi:** E-Vet Hasta Kabul + Muayene Odası; DaySmart Census ve arama. İkisinin operasyonel güçlü yönleri alınır; ağır check-in formu alınmaz. [E-Vet Hasta Kabul][EV-INTAKE], [E-Vet Muayene Odası][EV-QUEUE], [DaySmart Census][DS-CENSUS], [DaySmart arama][DS-SEARCH].

**Mevcut eksik:** Ayrı geliş zamanı, randevusuz geliş ve bekleme akışı yok. Randevusuz muayene kaydı tek başına bu ihtiyacı tamamlamıyor.

**Karar:**

1. Günlük arama sahip adı, hasta adı, telefon ve mevcut mikroçip gibi kimliklerle çalışır. Sahip altında hastalar anlaşılır biçimde gösterilir.
2. Türkçe harf, ad/soyad sırası, boşluk/noktalama ve telefon formatlarını kapsayan somut arama senaryoları tanımlanır. Arama normalizasyonu tenant/clinic erişim filtresini değiştiremez.
3. Yeni sahip/hasta oluşturma akışı korunur. Sahip oluşmuşken hasta kaydı başarısız olursa aynı sahip üzerinden devam edilir.
4. Ziyaret operasyonu için ayrı Visit modeli bu belge kapsamında önerilir: hasta, klinik, geliş zamanı, sorumlu hekim, opsiyonel appointment ilişkisi. Uygulama öncesi mevcut ilişkiler/raporlarla birlikte ADR'de netleştirilir.
5. Randevusuz geliş sahte randevu olarak takvime yazılmaz. Planlı randevu ile gerçek geliş ayrı izlenir.
6. Bugün yüzeyi randevular, bekleyenler, bakım devam edenler ve ilgili açık işleri gösterir. Başlangıçtaki bakım durumları Bekliyor / Devam ediyor / Tamamlandı olarak sade tutulur; aktif yatış ayrıca görünürdür.
7. Bakım durumu, ödeme durumu ve açık iş göstergeleri ayrı tutulur. Hasta eve gönderilmişken bakiye veya sonuç bekleyebilir.
8. Gelişin yanlış işaretlenmesi ve durum düzeltmeleri yetki/gerekçeyle izlenir. Tekrar tıklama iki ziyaret üretmez.
9. Muayene kaydı oluşturmanın randevuyu otomatik tamamlama davranışı bu aşamada açıklanmış ziyaret politikasına uyarlanır; rapor etkileri kontrol edilir.

**Daha iyi deneyim hedefi:** Günlük iki işi — hastayı bulmak ve sırayı görmek — az alanla çözmek. DaySmart'ın check-in sırasında şablon/bundle/fatura/form/kafes kartı seçtiren kapsamı ilk gelişte gösterilmez.

**Kabul:** Randevulu ve randevusuz iki hasta kabul edilir; resepsiyon ve hekim aynı güncel kuyruğu görür; muayeneye geçişte hasta tekrar seçilmez; ödeme eksikliği bakım durumunu yanlış göstermemelidir.

**Kalan sınır:** Online booking, departman/oda yönetimi, kapsamlı triage, portal ve belge/imza sihirbazı sonraki işlerdir. CHECKIN-001/005 ile dar kapsam; front-desk aramasının exact backlog boşluğu ayrıca giderilir.

## 8. Aşama 3 — Temel ücret, tahsilat ve bakiye

**Rakip seçimi:** Provet muayene–ücret sürekliliği; DaySmart Billing'in ücret/ödeme ayrımı; E-Vet satış ve ekstre yüzeylerinin yerel operasyon bağlamı. Üç kaynağın sınırlı sentezi. [Provet][PV], [DaySmart Billing][DS-BILLING], [E-Vet][EV].

**Mevcut eksik:** Payment tahsil edilen tutarı kaydediyor; işlemden ücret/borç oluşturan kaynak yok. Toplam tahsilat müşterinin kalan borcunu vermiyor. [Payment modeli][B-PAYMENT], [ödeme özeti][B-PAYMENT-SUMMARY].

**Karar:**

| Konu | Temel kapsam |
|---|---|
| Ücret | Hasta/ziyaret veya kaynak klinik işlemle bağlı açıklama, miktar ve tutar. İlk dilim manuel satır destekler. |
| Katalog | Hizmet kataloğu faydalı geliştirmedir; ilk manuel ücretin teknik ön koşulu değildir. |
| Tahsilat | Mevcut ödeme temeli kullanılır; ödeme yöntemi, tarih, tutar ve ilişkiler korunur. |
| İlişkilendirme | Hangi tahsilatın hangi ücreti karşıladığı açık olur. Aynı para iki borcu kapatamaz. |
| Bakiye | Ücret, ödeme ve açık kalan ayrı gösterilir. Sahip bazında klinik kapsamlı hesap; hasta/ziyaret kırılımı. |
| Kısmi ödeme | Açık kalan sonraki tahsilatta kapanabilir. Bakımın tamamlanması borcun otomatik kapanması değildir. |
| Düzeltme | Tutar değiştirme, iptal/iade ve yetki/gerekçe kuralları tanımlanır; geçmiş işlem görünmez biçimde silinmez. |
| Para birimi | Farklı para birimleri tek toplamda karıştırılmaz; ilk kapsamda kur dönüşümü otomatik varsayılmaz. |
| Eski kayıt | Geçmiş payment kayıtlarından geriye dönük hayali satış/borç türetilmez. Açılış bakiyesi varsa açık kaynak ve yetkili kayıtla girilir. |
| Belge | Klinik ücret/tahsilat özeti ile resmi e-belge aynı capability sayılmaz. Vergi/yuvarlama ve belge alanları uygulama öncesi doğrulanır. |

**Örnek kabul:** 1.000 TL ücret, 400 TL tahsilat → 600 TL kalan. İkinci 600 TL tahsilat aynı borcu kapatır. Tekrar istek veya iki kullanıcı aynı ödemenin iki kez sayılmasına neden olmaz.

**Daha iyi deneyim hedefi:** Muayeneden ücrete ve bakiyeye bağlamı kaybetmeden ulaşmak; günlük tahsilatı çok sayıda muhasebe ekranına dağıtmamak. DaySmart'ın kredi/mahsup/write-off/karma gelişmiş finans kapsamı ilk dilime eklenmez.

**Kalan sınır:** Gelişmiş kredi, kasa mutabakatı, belge paketi, kapsamlı muhasebe ve resmi e-belge entegrasyonu sonraki kapsamdır. Temel finans için exact backlog kaydı/ADR gereklidir; RECORD-001 ve CHECKOUT-001 tek başına bütün bu tasarımı tanımlamaz.

## 9. Aşama 4 — Hasta özeti, uyarılar, timeline ve klinik revizyon

**Rakip seçimi:** DaySmart Header/Overview/History ana kaynak; E-Vet Hasta Kartı hasta odaklı kapsam için tamamlayıcı. Sürüm koruması ve revizyon politikası Vetinity'nin kendi veri bütünlüğü kararıdır. [DaySmart hasta profili][DS-PROFILE], [E-Vet][EV], [ADR-006][ADR6].

**Mevcut:** History-summary ve hasta detayları var. Birleşik, sayfalı timeline; alerji/kritik uyarı modeli; tarihli kilo geçmişi ve klinik revizyon/finalize kapsamı eksik.

**Karar:**

1. Kompakt özet gerçek kayıtlardan oluşturulur; AI gerektirmez. Kimlik, sahip, önemli uyarılar, aktif yatış, açık işler ve uygun ölçüm kaynağı görünürdür.
2. “Uyarı yok”, “uyarı verisi alınamadı” ve “bu bilgiye yetkin yok” birbirinden ayrılır.
3. Mevcut Pet.Weight için olmayan ölçüm tarihi üretilmez. Yeni ölçümlerin tarihi/kaynağı korunur. Yaklaşan aşı ile yapılmış aşı ayrı gösterilir.
4. Aktif yatış, en son 10 kaydın içinde bulunduğu varsayımıyla hesaplanmaz; aktiflik semantiğine uygun okunur.
5. Timeline mevcut kayıtların birleşik okuma görünümüdür. Ayrı veri kopyası ve bütün kayıtları tek generic entity'ye taşıma zorunluluğu yoktur.
6. Olay tarihi ve kayıt güncelleme tarihi ayrılır; sıralama tutarlı, sayfalama güvenilir, her satır kaynağına bağlıdır.
7. Önerilen klinik kayıt politikası: düzenlenebilir kayıt → yetkili hekim tarafından kesinleştirme → gerekçeli ek düzeltme/addendum. Kesinleştirilmiş içerik sessizce değiştirilmez.
8. Revizyon hangi içeriğin, kim tarafından ve ne zaman değiştiğini uygun erişimle saklar. Genel audit log metadata'sı bu klinik geçmişin yerine geçmez.
9. Eşzamanlı düzenleme koruması, klinik kesinleştirme ve ziyaret tamamlama ayrı kavramlardır.

**Daha iyi deneyim hedefi:** Dağınık sekmelerden hasta hikâyesini tek yerde toplamak; hangi bilginin nereden geldiğini ve neyin eksik olduğunu göstermek. Rakibin lock simgesine bakıp aynı geri alınamaz kilidi kopyalamamak.

**Kabul:** Çok kayıtlı bir hastada geçmiş sayfalı açılır; filtre/derin linkler doğru kaynağa gider; son düzeltmenin kim tarafından yapıldığı görülebilir; yetkisiz kişi klinik revizyon içeriğini okuyamaz.

**Kalan sınır:** Bu aşama AI özeti, kapsamlı ICD/tanı ontolojisi, tüm laboratuvar karşılaştırmaları veya her rapor türünü üretmez. TIMELINE-001–004, EXAM-009/015, RECORD-002; ölçüm/uyarı modelinin exact kapsamı netleştirilir.

## 10. Aşama 5 — Tedavi, reçete ve klinik stok bağlantısı

**Rakip seçimi:** Provet tedavi kalemi kategorileri ve klinik–finans sürekliliği; DaySmart ürün/record/usage bağlantıları; E-Vet stok ekranları yardımcı referans.

**Mevcut:** Tedavi, serbest metin reçete, aşı ve temel stok hareketi var. Yapılandırılmış reçete/ürün satırı ve klinik otomatik tüketim aynı kapsamda mevcut sayılmaz.

**Karar:**

1. Tedavi/reçete/aşı muayene ve hastaya bağlı başlatılır; aynı kimlik tekrar seçtirilmez.
2. Serbest metin reçete korunur. Gereken ilk satır kapsamı ürün/ilaç adı, hekim tarafından belirlenen kullanım talimatı ve miktarı taşır.
3. Klinik uygulama ile hastaya yazılan reçete ayrılır. Dışarıdan temin edilecek ilacı yazmak klinik stoktan otomatik düşmez.
4. Klinik stok tüketimi açık, yetkili kullanım işlemiyle oluşur. Tekrar kaydetme aynı stoğu yeniden azaltmaz; düzeltme/geri alma kaynakla izlenir.
5. Gerekli yerde ürün birimi ve stok birimi dönüşümü tanımlanır. Lot/son kullanma gibi izleme kapsamı pilot kullanılan ürünlerle netleştirilir; mevcut kodda tamamlanmış varsayılmaz.
6. Ücret satırı ilgili klinik işlemden önerilebilir; hekim/operatör onayı olmadan sessiz ücret veya tüketim üretilmez.
7. Tanı, doz ve tedavi seçimi hekime aittir. Doz hesaplayıcı ileriki ayrı doğrulanmış yardımcıdır.

**Daha iyi deneyim hedefi:** Bir işlem bilgisini bir kez girip ilgili klinik/finans/stok görünümünde tutarlı kullanmak. Büyük generic record dönüşümü veya kural motoru olmadan gereken günlük bağlantıyı kurmak.

**Kabul:** Uygulanan ürün bir kez tüketilir ve kaynak işlemde görünür. Dış reçete stok değiştirmez. İptal/düzeltme sonrası stok ve ücret ilişkileri tutarlı kalır.

**Kalan sınır:** Büyük tedavi bundle'ları, otomatik dahil/hariç kuralları, gelişmiş satın alma/tedarikçi/depo transferi, nursing/MAR ve bağımsız doz önerisi ilk kapsamın dışındadır.

## 11. Aşama 6 — Lab ve manuel görüntüleme/dosyalar

**Rakip seçimi:** E-Vet'in hasta içinden lab istemi ve merkezi bekleyen iş yüzeyi; DaySmart'ın hasta/muayene bağlantılı görüntü ve diagnostik geçmişi. E-Vet'in bütün cihaz/panel mimarisi ve DaySmart'ın generic record modeli alınmaz. [E-Vet Lab][EV-LAB], [DaySmart][DS], [ADR-007][ADR7].

**Mevcut eksik:** Sonuç kaydı var; sonuç gelmeden istemi izleme ve hedef görüntüleme/dosya katmanı yok.

**Karar:**

1. Hasta/muayene içinden test istemi açılır; test açıklaması, isteyen kişi, tarih ve bağlı ziyaret korunur.
2. İlk akış istenmiş/bekleyen, sonuç girilmiş ve iptal edilmiş durumu ayırt eder. Hekimin sonucu değerlendirmesi ayrıca açık takip işi olabilir.
3. Sonuç manuel metin ve izinli dosyayla girilebilir. İlk sürümde cihaz bağlantısı veya büyük test kataloğu zorunlu değildir.
4. Sonuç olmayan kayda “sonuç hazır” denmez. Sonuç var ama değerlendirme yoksa bunu ayrı gösteririz; E-Vet'teki Tamamlandı + boş değer örneğini aynı anlamla kopyalamayız.
5. Hasta ayrılmış veya bakım tamamlanmış olsa da bekleyen sonuç görünür kalır; sonuç beklemek her zaman ziyaretin kapanmasını engellemez.
6. Klinik fotoğraf/röntgen/ultrason gibi kayıtlar hasta, muayene, tarih, tür ve açıklama taşır. İlk dosya kapsamı görüntü ve PDF ile sınırlandırılabilir; video ve büyük dosyalar maliyet/ihtiyaçla genişler.
7. Dosya kaynağı, yükleyen kişi, tür/boyut sınırı ve erişim davranışı açıklanır. Başarısız yükleme klinik form metnini veya mevcut dosyayı kaybettirmez.
8. Orijinal dosya korunur; ekran önizlemesi ayrı olabilir. Basit görüntüleme arşivi ileri tanısal PACS işlevleri sunuyor gibi gösterilmez.
9. Lab/görüntü kaydı timeline'da görünür ve ücret satırına kaynak olabilir.

**Daha iyi deneyim hedefi:** Hasta bazında kayıt ile klinik genelindeki bekleyen işler aynı kaynağa dayanır. Yeni test açarken hasta tekrar seçilmez; boş/ulaşılamayan/sonuçlanmamış veri açıkça ayrılır.

**Kabul:** Sonucu henüz olmayan test kaydedilir ve bekleyenlerde görünür. Daha sonra sonuç/dosya eklenir; hasta geçmişi ve ilgili işlem aynı kaydı gösterir. Yetkisiz dosya erişimi reddedilir; upload hatasında kullanıcı girdisi korunur.

**Kalan sınır:** Yapılandırılmış bütün analyte'lar, tür/yaş bazlı referans aralıkları, test karşılaştırma grafikleri, LIS, cihazdan otomatik alma, DICOM ve ileri PACS ilk dilimin dışındadır. Pilotun manuel sonuçla çalışamayacağı cihaz ihtiyacı varsa entegrasyon ayrıca önceliklendirilir.

## 12. Aşama 7 — Yatış, bakım tamamlama ve takip

**Rakip seçimi:** E-Vet yatış ve hasta geçmişi; Provet ready-for-discharge ve açıklanabilir eksik kontrolü; DaySmart aşı/reminder görünürlüğü. DaySmart Boarding klinik yatışla eş tutulmaz. [E-Vet][EV], [Provet][PV], [DaySmart][DS].

**Mevcut:** Yatış açma/taburcu ve aşı kayıtları mevcut. Tedavide follow-up alanı, e-posta reminder altyapısı var; gerçek gönderim bu incelemede test edilmedi.

**Karar:**

1. Aktif yatış hastanın özetinde ve klinik operasyon yüzeyinde görünür. Giriş, planlanan çıkış ve gerçek çıkış ayrılır.
2. İlk yatış kapsamı klinik için gereken konum/kısa bakım notu ve talimat görünürlüğünü tamamlar; yoğun bakım/nursing modülü kurulmaz.
3. Ayaktan bakım tamamlama ve yatış taburcusu bağlama uygun eylemlerdir. Her hastaya “taburcu” terminolojisi zorunlu olmaz.
4. Kısa tamamlanma kontrolü: klinik kayıt, uygulanmış işlem, gerekiyorsa reçete, kontrol/takip, bekleyen sonuç, ücret ve açık hesap görünürlüğü.
5. Her alan koşulsuz engel değildir. Sistem eksikliği ve nedenini açıklar; yetkili kullanıcı uygun gerekçeyle devam eder. Yetki/veri bütünlüğü hataları bypass edilmez.
6. Hasta sahibine manuel, anlaşılır evde bakım/takip talimatı hazırlanabilir; yazdırma/dışa aktarma kaynağı izlenir.
7. Kontrol gereken vakada görev veya randevu seçeneği sunulur; her muayenede kontrol randevusu zorunlu değildir.
8. Planlı, yapılmış ve gecikmiş aşı ayrılır. Mevcut e-posta hatırlatması korunup uçtan uca doğrulanır; teslim durumunun bilinmediği yerde “ulaştı” denmez.
9. Bakım bitmişken ödeme veya lab takibi açık kalabilir; sorumlu kişi ve sonraki aksiyon görünür olur.

**Daha iyi deneyim hedefi:** Açıklanmayan zorunlu formlar yerine kısa, vaka odaklı tamamlanma; bakım ve finansın birbirini yanlış tamamlamaması.

**Kabul:** Yatış aç → bakım talimatı yaz → taburcu et; aktiflik doğru değişir. Ayaktan hasta için bekleyen lab sonucu ve kısmi borç takipte görünmeye devam eder. Uygun kontrol/aşı hatırlatması gerçek gönderim senaryosuyla doğrulanır.

**Kalan sınır:** Saatlik ilaç uygulama çizelgesi/MAR, kapsamlı hemşire bakım planı, yatak/oda kapasite yönetimi ve hastane sevk orkestrasyonu sonraki aşamadır.

## 13. Aşama 8 — Navigasyon, rapor, açık işler ve onboarding

### Navigasyon ve raporlar

**Rakip seçimi:** DaySmart rapor kategorileri ve ortak davranışlar; E-Vet'in alan kapsamı. Menü yapısı Vetinity ADR-003/004'üne dayanır; rakibin yoğun sidebar'ı alınmaz. [DaySmart raporlar][DS-REPORTS], [ADR-003][ADR3], [ADR-004][ADR4].

**Karar:**

- Ana menü günlük işe odaklanır. Tür, ırk ve ürün kategorisi gibi tanımlar Ayarlar > Tanımlar altında bulunur.
- Tek Raporlar girişinden kategoriler/kartlar üzerinden ilgili rapora gidilir. Mevcut route ve bookmark'lar korunur.
- İlk rapor seti klinikte gerçekten kullanılacak randevu, muayene, aşı, tahsilat/temel bakiye ve stok görünümlerini kapsar. Borç raporu ücret modelinden sonra anlamlıdır.
- Raporun klinik/tarih kapsamı, tarih semantiği, para birimi ve toplamları açık olur. Liste ve export aynı filtreyi kullanır.
- Bugün, bekleyen sonuç veya takip listesi günlük aksiyon yüzeyidir; geçmişe dönük raporla karıştırılmaz.
- Bildirim/açık işler katmanı gerçek kaynak kayıtlarına bağlanır; hedefler atanmış iş, zamanı gelen/gecikmiş takip ve başarısız önemli işlemi görünür kılmaktır. Tam mevcut notification capability'si bu incelemede doğrulanmadı.
- Ortak boş durum, hata, yeniden deneme, kaydetme ve dar ekran davranışı korunur. Masaüstü/tablet öncelikli responsive deneyim; native mobil ayrı aşamadır.

**Daha iyi deneyim hedefi:** Yeni özellik sayısı artsa da ana menünün sürekli büyümemesi; sık işlemler için 2–3 etkileşimde ilgili çalışma alanına ulaşmak. Bu ölçüm “ödeme formunu açma” ile “tahsilatı bitirme”yi aynı saymaz.

**Kabul:** Bir rapor veya tanım yer değiştirince eski URL çalışır; kullanıcı yetkisi olmayan raporu göremez; aynı tarih/klinik filtresi ekran ve export'ta aynı kaydı seçer.

### Trial ve ürün içi yardım

**Rakip seçimi:** Ana karar Vetinity'ye ait kabul edilmiş ADR-001/002. E-Vet Öğrenme Modu yalnızca bağlamsal ürün eğitimi için fikir kaynağıdır; bu gözlem klinik AI kanıtı değildir.

**Karar:**

- 14 günlük self-service trial ve isteğe bağlı canlı demo yönü korunur.
- Boş klinikle başla / örnek veteriner kliniğini yükle seçimi sunulur.
- Örnek veriler sentetik ve birbirine bağlıdır: bugün gelen hasta, muayene, ücret/kısmi tahsilat, bekleyen lab, aşı ve yatış/takip örneği.
- Örnek klinikten gerçek kullanıma geçiş açık olur; örnek ve gerçek veriler karıştırılmaz.
- İlk kullanımda kısa görevlerle ana akış gösterilir. İlk 5–10 dakikada anlamlı ürün keşfi ADR hedefidir; gerçek kullanıcıyla ölçülür.
- Bağlamsal yardım kısa açıklama ve “sonraki adım” sunar. İlk sürümde bu yardımın AI olması gerekmez.
- İlk muayene, ilk ücret/tahsilat ve örnek klinik seçimi gibi aktivasyon olayları uygun ölçümle izlenir.
- Abonelik bittiğinde ReadOnly ve yenileme davranışları kullanıcıya açıklanır; erişim/yenileme akışı güncel kodla doğrulanır.

**Daha iyi deneyim hedefi:** Kullanıcının satış görüşmesi olmadan ürünü deneyebilmesi ve boş ekranla karşılaşmadan bağlı iş akışını görmesi.

**Kabul:** Yeni kullanıcı örnek kliniği seçip anlamlı bir hasta senaryosunu tamamlayabilir; demo kaynaklı dış mesaj/gerçek finans işlemleri politikaya uygun ayrılır; yenileme ve ReadOnly senaryoları çalışır.

**Kalan sınır:** Tam AI eğitim asistanı, serbest form tasarımcısı, rapor builder, gelişmiş favoriler/filtreler ve tüm modülleri kapsayan arama sonraki kapsamdır.

## 14. Aşama 9 — Pilot ve ilk ticari sürüm

**Rakip seçimi:** Vetinity'nin kendi teslim ve işletim kararı. Rakibin feature sayısı çıkış kriteri yapılmaz.

Pilot geri bildirimi yalnızca bütün geliştirme bittikten sonra başlamaz. 1–3. aşamalar kabul edildiğinde, kapsamı açık sınırlı senaryolar pilot kullanıcıyla denenebilir. 4–8. aşamalar gerçek geri bildirimle tamamlanır. İlk ticari çıkış, aşağıdaki bütün gerekli kapılar kapandığında değerlendirilir.

### İlk ticari sürümün çıkış koşulları

| Kapı | Kabul edilecek davranış |
|---|---|
| Hasta/ziyaret | Planlı ve randevusuz hasta doğru klinik bağlamında bulunur, kabul edilir ve muayeneye geçer. |
| Muayene | Dört bölüm kaydolur; randevu/hasta ilişkisi korunur; eski form yeni sürümü ezmez; hata metni silmez. |
| İşlem sürekliliği | Tedavi, reçete, aşı, lab ve yatış gereken kaynak muayene/hastaya bağlıdır. |
| Finans | Ücret, kısmi ödeme ve kalan ayrı; tekrar işlem veya düzeltme tutarı bozmaz. |
| Geçmiş/takip | Sonraki gelişte kayıtlar bulunur; önemli uyarı ve bekleyen iş görünür; dosya ve kaynak bağlantıları erişilebilir. |
| Klinik kayıt politikası | Kesinleştirme/düzeltme açık; klinik değişiklik geçmişi uygun erişimle izlenebilir. |
| Platform | Giriş, klinik seçimi, üyeler/roller/davet, ayarlar, abonelik ve gerekli dashboard davranışları doğrulanır. |
| Rapor/iletişim | Gerekli raporlar doğru filtre ve tutarları verir; mevcut reminder için gerçek başarısızlık/başarı davranışı doğrulanır. |
| Deneme/kullanım | Self-service ve örnek klinik akışı anlamlı; günlük işler ve hata mesajları kullanıcı tarafından anlaşılır. |
| Canlı işletim | Yedekleme ve geri yükleme denenmiş; dosya/veri erişimi, hata takibi ve yayın/migration geri dönüş yaklaşımı doğrulanmış. |
| Müşteri geçişi | Pilotun mevcut müşteri/hasta verisini taşıma veya başlaması için gereken yöntem denenmiş; bu incelemede import/migration capability'si doğrulanmadı. |
| Pilot kabulü | Seçilen gerçek klinik senaryoları kullanıcıyla tamamlanır; veri kaybı, yanlış scope veya tutarsız bakiye gibi çıkış engelleri kapanır. |

Bu kapılar yapılmış test sonuçları değildir; önerilen çıkış koşullarıdır. Gerekli klinik segmenti ve pilot profiline göre daraltılıp ürün belgelerine yazılır.

### Gerçek pilotta denenecek ana senaryolar

1. Mevcut sahip/hasta bul; randevulu geliş ve muayene.
2. Yeni sahip/hasta; randevusuz geliş; ikinci kayıt denemesinde duplicate davranışı.
3. Muayene kaydet/edit; aynı hastada iki kullanıcının eski formu.
4. Tedavi ve dış reçete; klinik ürün kullanımı; tekrar kaydetme/iptal.
5. Ücret; kısmi ödeme; sonraki tahsilat; düzeltme/iptal.
6. Sonuç gelmeden lab istemi; hasta ayrıldıktan sonra sonuç ve takip.
7. Görüntü/dosya yükle; upload veya erişim hatası.
8. Yatış ve taburcu; manuel talimat; açık borç/sonuç takibi.
9. İkinci gelişte timeline ve geçmiş kaynakları; kesinleştirilmiş kayda düzeltme.
10. İkinci klinik, farklı rol, ReadOnly ve trial/yenileme; gerekli rapor/export.

Otomatik doğrulama veri bütünlüğü, kapsam, sürüm, tutar ve tekrar işlem davranışlarına odaklanır. Yalnızca form/mapper'ın yazıldığı gibi çalışmasını tekrar eden yüzeysel testlerle kabul verilmez.

**Daha iyi deneyim hedefi:** Pazarlama vaadi ile gerçekten tamamlanan günlük işin aynı olması.

**Kalan sınır:** Temel kapılar kapanınca hedef küçük/orta klinik kapsamı tamamlanabilir; daha ileri rakip yetenekleri bilinçli olarak sonraki sürümlerde kalır.

## 15. Aşama 10 — Şablonlar, paketler ve onaylı AI

### Klinik üretkenlik

**Rakip seçimi:** DaySmart şablon/snippet/bundle yaklaşımı; Provet işlem kalemleri. Büyük tasarımcı ve item-rule motoru ilk aşamada alınmaz.

**Karar:**

1. En çok kullanılan muayene tipleri için seçilen birkaç şablon; mevcut metni ezmeyen ekleme/uygulama davranışı.
2. Hekimin seçtiği kısa metin/snippet; otomatik normal muayene bulgusu üretmeme.
3. Seçilen paket uygulanırken içerik önizlenir. Her işlem, ücret ve stok etkisi kullanıcıya görünür; uygulanmış kayıt paketin sonraki düzenlemesiyle geçmişten değişmez.
4. Doz hesaplayıcı klinik olarak doğrulanmış ayrı kapsamdır; kilo kaynağı, birim ve hekim onayı gerekir. Genel AI hesaplaması yerine geçmez.

**Beklenen iyileşme:** Aynı işi daha az tekrar veri girişiyle yapmak. Paket sayısı arttıkça ekranın karmaşıklaşmaması.

### AI yardımcıları

**Rakip seçimi:** DaySmart bağlamsal özet demo fikri; ana güvenlik, onay ve erişim tasarımı Vetinity ADR-008. E-Vet Öğrenme Modu klinik özet/tanı yeteneğinin kanıtı sayılmaz. [ADR-008][ADR8], [AI stratejisi][AI].

**İlk önerilen sıra:**

- Serbest muayene notunu mevcut dört bölüme düzenleyen taslak.
- Hasta sahibine anlaşılır açıklama/evde bakım talimatı taslağı.
- Yalnız yetkili kaynaklardan hasta geçmişi özeti; kapsam, tarih ve kaynak kayıtlar görünür.

**Karar:**

- Çıktı kullanıcıya önizletilir; kullanıcı açıkça uygulamadan klinik kayda yazılmaz.
- Eksik veri tamamlanmış gerçek gibi uydurulmaz; kaynak/kapsam sınırı gösterilir.
- AI ayrı ana menü değildir; ilgili çalışma alanında bulunur.
- Backend üzerinden sağlayıcı, tenant/clinic erişimi, kota, maliyet ve uygun log politikası yönetilir.
- AI kapalı, kota dolu veya sağlayıcı erişilemezken temel klinik iş devam eder.
- Timeline UI'ın tamamlanması her AI taslağının teknik ön koşulu değildir; uygun scoped kaynak verisi ve izin gerekir.

**Kabul:** Aynı klinik kaydı AI kullanmadan tamamlamak mümkün; taslak manuel onay olmadan kaydolmaz; başka tenant verisi kullanılamaz; kaynakta olmayan tanı/uygulama kesin veri gibi eklenmez.

**Kalan sınır:** Otomatik tanı, bağımsız reçete/doz, medikal görüntü yorumlama, sesli not/STT ve Business Copilot ileri ayrı kapsamdır.

## 16. Aşama 11 — Talebe göre entegrasyon ve genişleme

**Rakip seçimi:** DaySmart online randevu/portal/inbox/checkout; E-Vet yerel iletişim, resmi belge ve finans yüzeyleri. Gereken parça seçilir; bütün modüller birlikte alınmaz.

| Alan | Karar | Öncelik ve kalan sınır |
|---|---|---|
| SMS | Mevcut e-posta akışının yanında gereken kanal; teslim durumu, maliyet, tekrar gönderim ve tercih davranışı açık | Pilot için kullanım/satış engeliyse P1; aksi halde P2. |
| WhatsApp | İlk kullanım tipi açık seçilir: kullanıcı kontrollü Web yönlendirmesi veya gerçek Business API | Web handoff, API entegrasyonu tamamlandı anlamına gelmez. |
| e-belge | Klinik ücret kaydına bağlı sağlayıcı entegrasyonu; başarılı/başarısız durum ve kaynak ilişki | Pilot satın alma engeliyse P1. Provider, belge türü ve geçerli kurallar ayrıca doğrulanır; benchmark'tan çıkarılmaz. |
| Klinik POS | Hasta tahsilatıyla bağlantılı doğrulanmış süreç | SaaS abonelik checkout'uyla aynı sistem değildir; ihtiyaçla P2. |
| Online randevu | Mevcut takvim üzerine talep kabul/red/reschedule, uygun saat ve hasta eşleşmesi | P2; check-in'in teknik ön koşulu değildir. |
| Gelişmiş checkout | Kredi, mahsup, gerekli belge paketi ve gelişmiş kapanış | P2; temel ücret/bakiye zaten daha önce vardır. |
| Portal / inbox | Hasta sahibinin bilgi/talep/iletişim ihtiyacı doğrulanır; erişim ve kaynakları açık | P2; ilk klinik akışın yerine geçmez. |
| Geniş arama / recent navigation | Hasta aramasını bütün uygulama kayıtlarına genişletme | P2; permission-aware ve tutarlı sonuç normalizasyonu. |
| Rapor favorileri / filtreler / planlama | Kullanılan raporların tekrar erişimini kolaylaştırma | P2; bütün rakip raporlarını kopyalama yok. |
| Form/onam/dijital imza | Klinik ihtiyacı varsa belge türü, kaynak, sürüm ve imza süreci ayrı tasarlanır | Bu incelemede mevcut uygulama doğrulanmadı; gerekiyorsa pilot öncesi dar kapsam, aksi halde P2. |
| Barkod ve ileri tedarik | Ürün/stock kullanımında doğrulanmış ihtiyaç | Nice to Have / P2; ilk klinik akışın genel ön koşulu değildir. |

**Beklenen iyileşme:** Müşterinin gerçekten kullandığı entegrasyonu açık durum/maliyet/hata davranışıyla sunmak. Menüye yeni modül eklemeyi tek başarı ölçütü yapmamak.

## 17. Aşama 12 — İleri klinik ve segment genişlemesi

**Rakip seçimi:** Mevcut benchmark ileri architecture kararını vermeye yeterli değildir. Cihaz/protokol, gerçek hastane operasyonu ve yeni segmentler için ayrı araştırma/pilot gerekir.

| Genişleme | Ön koşul | İlk sürümde kalan eksik |
|---|---|---|
| LIS / cihaz entegrasyonu | Cihaz/partner/protokol ve hata/tekrar veri alma doğrulaması | Manuel sonuçla çalışma; otomatik cihaz aktarımı yok. |
| DICOM / PACS | Gerçek görüntüleme ihtiyaçları, format, depolama ve viewing doğrulaması | Basit görüntüleme arşivi; ileri PACS yok. |
| İleri yatış / MAR / nursing | Hastane pilotu, bakım rolleri, uygulama zamanları ve izlenebilirlik | Temel yatış/taburcu; saatlik bakım otomasyonu yok. |
| Native mobil | Hekim/hasta sahibi kullanım senaryosu ve API/erişim kapsamı | Responsive web; native ve offline-first kapsam yok. |
| Çok şube / enterprise / SSO | Gerçek organizasyon, rol, rapor ve operasyon ihtiyacı | Mevcut tenant/clinic temeli; tam enterprise olgunluğu iddia edilmez. |
| Üniversite | Sevk, branş, eğitim ve vezne süreçleri | İlk companion klinik hedefinin dışında. |
| Çiftlik/büyükbaş/sürü | Sürü, reprodüksiyon ve saha senaryoları | İlk companion klinik hedefinin dışında. |
| Equine | Ayrı müşteri/klinik gereksinimi ve araştırma | İlk sürüm alanları/eşikleri equine için genişletilmez. |
| STT / Business Copilot / görüntü AI | Veri, kalite, maliyet ve sorumluluk kapsamı | İlk klinik MVP'nin dışında; araştırma release taahhüdü değildir. |

Bu aşamanın tamamı için bugünden kesin teslim tarihi veya feature eşitliği taahhüdü verilmez. Çekirdek tamamlandıkça gerçek kullanım ile öncelik seçilir.

## 18. Hangi alanda hangi örneği seçtik?

Bu tablo ürün yönü seçimidir. “İyileştirme” sütunu uygulanmış başarı değil, hedef davranıştır.

| Alan | Örnek seçimi | Vetinity kararı / iyileştirme hedefi | İlk ticari sürümde kalan sınır |
|---|---|---|---|
| Günlük hasta arama/kabul | E-Vet + DaySmart | Sahip–hasta hiyerarşisi; telefon/Türkçe/ad sırası senaryolarıyla toleranslı dar arama | Bütün entity'lerde gelişmiş arama daha sonra. |
| Hızlı sahip/hasta oluşturma | DaySmart + mevcut Vetinity | Bağlam korunur; yarım kalmış hasta kaydı sahibini tekrar oluşturmaz | Karmaşık form sihirbazları yok. |
| Randevu/takvim | DaySmart + E-Vet; mevcut temel korunur | Klinik içi planlama, çakışma ve doğru yetki | Online booking sonraki aşama. |
| Geliş/bekleme | DaySmart Census + E-Vet Muayene Odası | Hafif Bugün; randevusuz geliş; bakım/finans/açık iş ayrımı | Geniş triage/departman/oda sistemi yok. |
| Muayene çalışma alanı | DaySmart ana; Provet destek | Dört Türkçe bölüm; görünür hasta bağlamı; aşamalı alanlar | Büyük organ sistemi formu ve tüm şablonlar ilk dilimde yok. |
| Vital değer ve özet | DaySmart + Provet | Kaynak/tarih/birim; eksik veri açık; deterministik özet | Doğrulanmamış otomatik klinik eşikler yok. |
| Kayıt sürümü ve metin koruma | Vetinity'nin kendi kararı | Eski form reddi, metin koruma, klinik revizyon ve gerekçeli ek düzeltme | Rakibin backend koruması hakkında üstünlük iddiası yok. |
| Hasta geçmişi | DaySmart + E-Vet | Kronolojik kaynak görünümü; filtre/sayfalama/derin link | Her ileri karşılaştırma ve tüm analitik yok. |
| Alerji/kritik uyarı | DaySmart bağlam fikri; kendi modelimiz | Yetkili, açıklanmış, gerçek kaynağa dayalı uyarılar | Bağımsız klinik karar motoru yok. |
| Tedavi/reçete | Provet + DaySmart | Kaynak muayene; dar yapılandırılmış satır; mevcut metni koruma | Bağımsız doz ve tam e-reçete/ATS entegrasyonu tamamlanmış sayılmaz. |
| Klinik stok kullanımı | DaySmart + E-Vet stok kapsamı | Açık kullanım; tekrar tüketim yok; düzeltme kaynaklı | Geniş satın alma/depo/tedarik otomasyonu ayrı. |
| Aşı/takip | DaySmart + E-Vet | Yapılan, planlı/gecikmiş ve takip ayrı; mevcut reminder doğrulanır | Her kanal ve otomatik program/paket motoru yok. |
| Laboratuvar | E-Vet ana; DaySmart history destek | İstem/bekleyen/sonuç ayrımı; sonuçsuz kayıt hazır görünmez | Tüm cihaz/analyte/ref-range katmanı yok. |
| Görüntüleme/dosyalar | DaySmart + E-Vet; ADR-007 | Hasta/muayene/tarih/tür bağlantılı manuel kayıt | İleri PACS/DICOM/cihaz entegrasyonu yok. |
| Yatış | E-Vet; mevcut Vetinity korunur | Aktif yatış, temel bakım notu ve taburcu görünürlüğü | Nursing/MAR ve ileri hastane sistemi yok. |
| Bakım tamamlama/taburcu | Provet ana | Kısa vaka odaklı kontrol, açıklanmış eksikler, manuel talimat | Ağır belge/paket sihirbazı yok. |
| Ücret/tahsilat/bakiye | Provet + DaySmart + E-Vet | Klinik işlemle bağlantılı temel ücret, kısmi ödeme ve açık bakiye | Gelişmiş kredi/mahsup/muhasebe sonraki kapsam. |
| Rapor merkezi | DaySmart kategori fikri; kendi ADR-003 | Tek giriş; gerekli raporlar; ortak filtre ve yetki | Bütün rakip rapor kataloğu ve generic builder yok. |
| Menü/tanımlar | Vetinity ADR-004 | Günlük ana menü; nadir tanımlar Ayarlar'da; route korunur | Yoğun rakip sidebar'ı alınmıyor. |
| Trial/örnek klinik | Vetinity ADR-001/002 | 14 gün; sentetik bağlı senaryo; boş/örnek klinik seçimi | İki rakibe karşı trial üstünlüğü bu kanıtla ölçülmedi. |
| Ürün içi öğrenme | E-Vet training fikri; sade kendi yardımımız | Bağlamsal kısa yardım ve sonraki adım | Training asistanı klinik AI sayılmaz. |
| AI | DaySmart bağlamsal fikir; Vetinity ADR-008 | Onaylı not/talimat/özet; kaynak ve erişim görünür | İlk ticari sürümde zorunlu değil; otonom klinik karar yok. |
| Entegrasyonlar | DaySmart/E-Vet görünür akışlar; ayrı doğrulama | İhtiyaç ve provider bazında seçilen kanal | Menünün varlığı resmi/teknik entegrasyon kanıtı sayılmaz. |
| Platform mimarisi/izolasyon | Vetinity'nin mevcut mimarisi | Scope, CQRS, klinik bağımsız modeller ve uygun audit korunur | Benchmark UI'ından rakip DB modeli kopyalanmıyor. |
| Mobil/enterprise/yeni segment | Bu iki rakipten kesin seçim yapılmadı | Ayrı ihtiyaç araştırması ve pilot | İlk companion klinik sürümünün dışında. |

## 19. “Daha iyi seviyeye getirdik” ne zaman diyebiliriz?

| Farklılaşma hedefi | Karşılaştırmadaki dayanak | Vetinity için kanıtlanması gereken |
|---|---|---|
| Daha sade klinik ekran | DaySmart SOAP ve Provet consultation'ın yoğunluğu araştırma notlarında UX riski | Hekim dört bölümü ve ilgili işlemi tekrar hasta seçmeden tamamlar; gereksiz alanlarla durmaz. |
| Daha anlaşılır yerel dil | DaySmart SOAP terminolojisi; kabul edilmiş Türkçe ADR-005 | Pilot kullanıcı bölüm ve eylem adlarını yardım almadan doğru yorumlar. |
| Daha toleranslı günlük arama | DaySmart'ta görünen ad formatının bir örnekte sonuç vermemesi | Tanımlanmış ad/soyad/Türkçe/telefon senaryoları doğru sonuç verir; yetkisiz sonuç yoktur. |
| Daha açık işlem/sonuç durumu | E-Vet'te bir Tamamlandı kaydında boş lab değerleri gözlendi | Sonuç bulunmayan kayıtta sonuç hazır iddiası yok; değerlendirilmemiş sonuç takipte görünür. |
| Daha güvenilir kayıt düzenleme | Vetinity kodunda bağlantı kaybı ve eski form riski bulundu | Appointment ilişkisi korunur; eski form reddedilir; metin kaybolmaz. Rakibin unseen korumasına karşı üstünlük iddiası yapılmaz. |
| Daha az tekrar veri girişi | DaySmart/Provet bağlam ve kaynak sürekliliği | Hasta/ziyaret bir kez seçilir; klinik işlem, ücret ve stokta aynı kaynak ilişkisi korunur. |
| Daha kolay ürün keşfi | Vetinity self-service/örnek klinik ADR'leri | Yeni kullanıcı ilk 5–10 dakikada ana değeri deneyimler; öncesi/sonrası aktivasyon ve tamamlanma ölçülür. |

Bu hedefler uygun kullanıcı senaryoları ve pilot ölçümüyle doğrulanınca o dar alandaki iyileşme söylenebilir. Genel “E-Vet/DaySmart'tan daha iyi ürün” sonucu için bu inceleme yeterli değildir.

## 20. Eksik kalacak alanların açık sınıflandırması

### İlk ticari sürümde açık bırakamayacağımız işler

- Hasta/klinik ilişkileri; doğru izin; eski form veya hata nedeniyle veri kaybı.
- Klinik günlük kabul → muayene → gereken işlem → ücret/tahsilat → takip zinciri.
- Ücret ile ödeme ayrımı; tutarlı kısmi ödeme ve kalan bakiye.
- Hasta geçmişine erişim, kritik bilginin görünürlüğü ve düzeltme politikasının açıklanması.
- Bekleyen test/takibin hasta ayrılınca kaybolmaması.
- Mevcut v1 A release blocker'larının doğrulanması; yeni ekran yapmak bu gereklilikleri kaldırmaz.
- Örnek klinik, temel raporlar, günlük navigasyon ve canlı işletimin gerekli kapsamı.

### İlk sürümde bilinçli kalabilecek yetenek farkları

| Eksik kalacak ileri kapsam | İlk sürümdeki karşılık | Neden erteleniyor? |
|---|---|---|
| Tüm rakip şablon/bundle/item rules | Manuel klinik kayıt + sonraki seçilmiş şablonlar | Büyük yapılandırma motoru ilk günlük akışa gereksiz kapsam ekler. |
| Cihazdan otomatik lab aktarımı | Manuel istem/sonuç/dosya ve takip | Partner/protokol bağımlılığı; pilotun ihtiyacına göre seçilir. |
| İleri PACS/DICOM | Hasta bağlantılı manuel görüntüleme arşivi | Format/viewing/depolama ayrıntısı ayrı seviye. |
| Nursing/MAR/ileri hastane | Temel yatış, bakım notu, taburcu ve takip | İlk hedef küçük/orta companion klinik. |
| Kredi/mahsup/ileri muhasebe | Temel ücret, tahsilat, bakiye ve gereken düzeltme | Günlük finans ihtiyacı önce; tam muhasebe ürünü taahhüdü yok. |
| Portal/inbox/native mobil | Klinik web akışı ve mevcut hatırlatma | Ek persona/kanal/erişim karmaşıklığı; kullanım kanıtıyla ilerler. |
| Geniş arama/rapor builder | Günlük hasta arama ve gerekli rapor merkezi | İlk kullanıcının yüksek frekanslı işi yeterli kapsamla çözülür. |
| Otonom/ileri AI ve STT | Manuel klinik iş; sonradan onaylı taslaklar | Temel klinik akışın güvenilirliği ve veri kalitesi önce. |
| University/farm/equine/enterprise | Companion klinik çekirdeği | Yeni segment için ayrı kullanıcı ve operasyon doğrulaması. |

### Pilot ihtiyacıyla erkene alınacak koşullu işler

SMS, e-belge, gerekli onam/belge çıktısı, klinik POS veya mevcut veriyi aktarma; ancak seçilen kliniğin günlük çalışmasını/ürüne geçmesini/satın almasını engellediği doğrulanırsa öncelik kazanır. Bu durumda en dar gereken kapsam v1'e alınır. Feature adı rakip menüsünde bulunduğu için bütün ileri modül zorunlu yapılmaz.

## 21. Mevcut v1 scope ile eşleme

Bu öneri mevcut v1 A/B kapsamını sessizce kaldırmaz. Mevcut belgedeki bazı geniş etiketler aşağıdaki uygulanabilir dar kapsamla netleştirilmelidir. [v1 scope][SCOPE].

| Mevcut kapsam | Bu plandaki karşılık | Açık doğrulama |
|---|---|---|
| Authentication; Tenant/Organization; Clinic Management | Aşama 0 ve her aşamadaki erişim; aşama 9 platform kapısı | Bütün rol/scope/senaryolar bu incelemede test edilmedi. |
| Role & Permission; User Management; Invitation System | Aşama 0/9 | Kod karşılığı var; tüm kullanıcı/davet/rol akışı doğrulanmalı. |
| Dashboard | Bugün için gereken operasyon görünümü + mevcut dashboard korunur | Dashboard'un tamamı bağımsız incelenmiş değil. |
| Clients; Patients; Appointments | Aşama 1/2 | Arama, bağlam ve geliş ayrımı tamamlanmalı. |
| Examinations; Clinical Notes; SOAP | Aşama 1/4 | İlk dilim ile finalize/revizyon ayrı kabul edilir. |
| Treatments; Prescriptions; Vaccinations | Aşama 5/7 | Serbest metin çekirdeği ile gereken yapılandırılmış/bağlı parça ayrı. |
| Hospitalization | Aşama 7 | Temel lifecycle korunur; ileri nursing zorunlu değil. |
| Payments | Aşama 3 | Tahsilatın yanında eksik ücret/bakiye tasarımı tamamlanır. |
| Products; Stock Management | Mevcut çekirdek + aşama 5 | Temel stok ile klinik kullanım bağlantısı ayrı doğrulanır. |
| Reports Center; Unified Report Center | Aşama 8 | Route'lar korunur; hub ve gerekli raporlar tamamlanır. |
| Account Settings; Organization Settings | Aşama 0/9 | Mevcut olması tam kabul anlamına gelmez. |
| Reminder System | Aşama 7/8 | E-posta altyapısı gerçek sonuçla doğrulanmalı. |
| Audit & Security | Aşama 0/1/4/9 | Metadata audit, klinik revizyon ve tenant erişimi ayrı kapsamlar. |
| Responsive Desktop Experience | Her aşama + aşama 8/9 | Klinik masaüstü/tablet akışı; native mobil değil. |
| Patient Timeline; Patient Summary; Critical Alerts | Aşama 1'de dar bağlam; aşama 4'te temel genişleme | AI summary zorunlu değil; gerçek uyarı/ölçüm modeli eksikleri tamamlanır. |
| Laboratory Results; Imaging Records | Aşama 6 | Manuel istem/sonuç ve klinik dosya; cihaz/PACS ileri kapsam. |
| Quick Actions | Aşama 1/2/8 | Hasta/ziyaret kaynak bağlamı korunur. |
| Notification Center | Aşama 8 | Mevcut tam uygulama doğrulanmadı; gereken açık iş/bildirim dilimi tanımlanır. |
| C — Nice to Have | Aşama 10/11 | AI, SMS/WhatsApp, barkod ve ileri arama ilk çıkışı koşulsuz büyütmez. |
| D — Out of Scope | Aşama 12 | Ayrı araştırma ve genişleme. |

Timeline/summary/imaging için “v1 core” ile “ilk ücretli müşteriden sonra” çelişkisi giderilmelidir: temel gereken dilimler ticari kapsamda, ileri sürümler sonrasında. Tam template/bundle veya klinik integration suite ilk muayene işinin ön koşulu değildir.

## 22. Cursor ile uzlaşı ve revize edilecek kararlar

**Uzlaşı:** İlk iş EXAM-001–005; ardından CHECKIN ve temel ücret/bakiye. Hasta bağlamı, timeline, sade menü ve AI'nin kontrollü sonraki aşama olması.

| Konu | Bu planın düzeltmesi | Etki |
|---|---|---|
| Eski backend checkpoint | af5c2ab esas; abonelik düzeltmeleri kaynakta mevcut | Tekrar commit/düzeltme ön koşulu kaldırılır. |
| Muayene edit ilişkisi | appointmentId GET → edit → update boyunca korunur | Veri bağlantısı kaybı ilk işte kapanır. |
| Tarih filtresi | Gerçek FE–BE contract ve İstanbul UTC sınırları | Filtre/toplam/rapor tutarlılığı. |
| Concurrency | İstemcinin açtığı sürüm zorunlu; DB token ile birlikte | Eski tarayıcı formu güvenliği. |
| Findings | İlk dilimde string korunup boş değere izin verme | Nullable response etkisi gereksiz büyümez. |
| “Her an sunucu taslağı” | Düzenlenebilir kayıt ile gerçek lifecycle ayrı | Kayıt açmak bakım/ödeme bitti diye sunulmaz. |
| Kilo/aşı/yatış summary | Gerçek kaynak ve tarih/aktiflik semantiği | Bilinmeyen tarih veya yanlış klinik özet üretme engellenir. |
| Katalog ön koşulu | Manuel ücret başlayabilir | Finans ilk dilimi gereksiz kataloğa bağlanmaz. |
| Metadata audit | Ayrı erişim kontrollü klinik revizyon gerekir | Değişen klinik içeriğin izlenebilirliği. |
| Global search P2 | Dar hasta/sahip araması erken, geniş arama sonra | Günlük kabul akışı gecikmez. |
| Genel additive/rollback iddiası | Zorunlu version ve API/nullability etkisi açık; eski istemci/yeni alan politikası | Yayın sırası ve veri koruma doğru planlanır. |

## 23. Sıradaki somut geliştirme brief'i

**İlk iş:** Muayene kayıt bütünlüğü ve bağlamlı çalışma alanı, dilim 1.

**Teslim:** Hasta başlığı; dört Türkçe klinik bölüm; opsiyonel vital değerler; aynı bağlamda kaydet/edit; doğru CTA; randevu bağlantısının korunması; tarih contract düzeltmesi; eski form sürüm kontrolü; hata/çakışmada metin koruma; eski kayıt/export uyumu.

**Bu işe eklenmeyecek:** Tam Visit, timeline, alerji veri modeli, gerçek finalize/addendum, ücret/bakiye, ürün stok tüketimi, AI, cihaz entegrasyonu ve genel menü yeniden tasarımı.

**Başlatma hazırlığı:** Ürün kapsam notları ve gerekli ADR kararları bu belgeyle hizalanır; mevcut yerel değişiklikler korunur; backend/FE rollout ve anlamlı kabul senaryoları brief'te yazılır. Bu raporda kod veya product dosyası değiştirilmedi.

## 24. Kaynaklar

Bağlantılar incelenen checkpoint'lere sabitlenmiştir. Rakip dokümanındaki UI gözlemi, rakibin DB modeli veya bugünkü bütün ürün kapsamını doğrulamaz.

[DS]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md
[DS-SOAP]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L290
[DS-CENSUS]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L771
[DS-PROFILE]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L884
[DS-SEARCH]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L3370
[DS-BILLING]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L2202
[DS-REPORTS]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/daysmart.md#L2471
[EV]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/e-vet.md
[EV-INTAKE]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/e-vet.md#L243
[EV-QUEUE]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/e-vet.md#L1081
[EV-LAB]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/e-vet.md#L1200
[PV]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/competitors/provet-cloud.md
[PRINCIPLES]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/vision/product-principles.md
[MARKETS]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/vision/target-markets.md
[WORKFLOW]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/WORKFLOW.md
[BACKLOG]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/backlog/feature-backlog.md
[SCOPE]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/roadmap/v1-release-scope.md
[ADR3]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-003-report-center.md
[ADR4]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-004-navigation-and-menu-philosophy.md
[ADR5]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-005-modern-examination-experience.md
[ADR6]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-006-patient-timeline.md
[ADR7]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-007-imaging-module.md
[ADR8]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/decisions/ADR-008-embedded-ai-assistant.md
[AI]: https://github.com/cagataykamit/vetinity-product/blob/8fc81eb3d3ded4aaf0313b76d7cc26572e22fb54/ai/ai-strategy.md
[B-PAYMENT]: https://github.com/cagataykamit/backend-veteriner/blob/af5c2ab8044bf5b025d4243bac294d67a2c0a87f/src/Backend.Veteriner.Domain/Payments/Payment.cs
[B-PAYMENT-SUMMARY]: https://github.com/cagataykamit/backend-veteriner/blob/af5c2ab8044bf5b025d4243bac294d67a2c0a87f/src/Backend.Veteriner.Application/Clients/Queries/GetPaymentSummary/GetClientPaymentSummaryQueryHandler.cs
