# ADR-043 — Birleşik klinik kayıt modeli: ayrı kayıtlar, ortak çekirdek

## Durum

**Taslak — öneri; kullanıcı onayı bekler (2026-11-01).** Kabul edilmedi. Kaynak araştırma: [research/record-006-birlesik-kayit-modeli-2026-11.md](../research/record-006-birlesik-kayit-modeli-2026-11.md). Backlog: [RECORD-006](../backlog/feature-backlog.md#record-006--birleşik-record-modeli-ve-tip-bazlı-dinamik-form). İlgili: [ADR-006](ADR-006-patient-timeline.md), [ADR-013](ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](ADR-015-batch-based-stock-and-registers.md), [ADR-018](ADR-018-charge-suggestion-and-service-catalog.md), [ADR-036](ADR-036-hbs-ve-e-belge-entegrasyonu.md). Kullanıcı farklı karar verirse yalnız ilgili K maddesi değişir.

## Bağlam

- Klinik kayıtlar sekiz ayrı aggregate ve tabloda: muayene, tedavi, reçete, aşı, uygulama, lab, görüntüleme, yatış. Silme ucu hiçbirinde yok.
- Ortak kuralların bir kısmı zaten tek yerde: gerekçe kuralı (`CorrectionReason`), HBS geri kaydı (`HbsEntryRules`), yol/bölge (`AdministrationRouteSite`), kesinleşmiş muayene kilidi (`ExaminationLinkedRecordLock`), klinik kapsamı (`IClinicScoped`), timeline okuma modeli (`IPetTimelineSource`, 9 tür), değişiklik geçmişi (EF kaydetme yakalayıcısı, 7 tür).
- Sorun tutarsızlık: reçete, lab, görüntüleme ve uygulama gerekçeyle iptal edilir; tedavi ve yatış iptal edilemez; ürünsüz aşı durum alanından gerekçesiz iptal edilebilir. Geç kayıt gerekçesi uygulama ve reçetede zorunlu, görüntülemede yok. Eşzamanlılık belirteci tedavi, reçete ve aşıda yok. Görüntüleme değişiklik geçmişine yazılmıyor. Tür adının kodda dört ayrı sözlüğü var.
- Frontend'de her tür için ayrı oluşturma formu ve ayrı düzenleme sayfası var; kilit kuralı frontend'de kopyalanmış ve RECORD-008'den geri kalmış (muayene çalışma alanında kesinleşmiş muayeneye gerekçeli reçete açılmıyor; kod okunarak, tarayıcıda doğrulanmadı).
- Rakip (DaySmart) tek "Record" kavramı ve tipe göre değişen form gösteriyor; geçmiş ekranında modül filtreli görünümler aynı olaylardan okunuyor. Veri modeli bilinmiyor. Değer kullanıcı yüzeyinde: tek giriş, ortak dil, birleşik geçmiş.
- Türkiye'ye özgü yükümlülükler (kayıt defterleri ADR-015, HBS e-Reçete/ATS ADR-036, stok/parti, ücret önerisi ADR-018) tipli alanlara ve tipli kurallara dayanıyor.

## Değerlendirilen seçenekler

- **A — Tek `ClinicalRecord` tablosu + JSON tür alanları + dinamik form.** Reddedilir: türe özgü değişmezler JSON'da da kod ister; defter, HBS ve stok sorguları JSON'dan çıkarıma döner; alan bazlı değişiklik geçmişi kaybolur; sekiz tablonun ve onlara bağlanan izlerin (stok hareketi, ücret önerisi, dosya, geçmiş, aşı–uygulama bağı) taşınması geri dönüşü pahalı.
- **B — Ayrı aggregate'ler kalır, ortak kayıt çekirdeği tamamlanır, frontend'de tür kayıt defteri ve ortak form kabuğu.** Seçilir (aşağıda).
- **C — Yeni türler JSON tabanlı birleşik modelde, eskiler dokunulmaz.** Reddedilir: iki kalıcı model toplam karmaşıklığı artırır; aday yeni türler (vital ölçümü, prosedür) zaten tipli ihtiyaç taşıyor. Dar türevi (klinik tanımlı ek alanlar) ayrı karar olarak ertelenir (AK-7).

## Karar (öneri)

### K1 — Kayıtlar ayrı ve tipli kalır

Her klinik kayıt türü kendi aggregate'i ve tablosuyla kalır. Tek tablo ve JSON klinik alanlar kullanılmaz. Yeni tür gerekirse aynı çekirdeğe uyan tipli aggregate olarak eklenir.

### K2 — Tek tür sözlüğü

Kayıt türlerinin adı, timeline sıra numarası, değişiklik geçmişi adı, kaynak izi adı ve okuma/yazma izni tek bir eşlemede tutulur. Mevcut API değerleri (`PetRecordKind`, `RecordHistoryTypes`, ücret önerisi `sourceType`, stok `referenceType`) **değişmez**; eşleme bunları tek yerden üretir. Frontend'de karşılığı tek tür kayıt defteridir (etiket, simge, rota, izin, form bölümü); timeline, işlem bölümü ve geçmiş ekranı bunu kullanır.

### K3 — Kesinleşmiş muayene politikası tek tabloda ve API'den gelir

ADR-013'ün tür bazlı kuralları değişmeden tek bir politika tablosuna yazılır (tür → kilitli / gerekçeli geç kayıt / sonuç alanları serbest / önceden var olan donuk / yalnız bağ kilitli). Kilit denetimi bu tablodan okur. API, muayene için izin verilen kayıt eylemlerini döner; frontend kilit kuralını kopyalamaz.

### K4 — Ortak yaşam döngüsü nesneleri

Gerekçeli iptal (zaman, eden, gerekçe) ve geç kayıt (işaret, gerekçe) her türde aynı değer nesnesiyle ifade edilir; gerekçe kuralı `CorrectionReason` olarak kalır. Silme yoktur. İptal edilen kayıt varsayılan gizli, filtreyle görünür; kayıt defterlerinde çıkarılmaz, işaretlenir (RECORD-008 deseni). Mevcut sütunlar korunur; eşleme migration'sız hedeflenir (doğrulanmadı).

### K5 — Her klinik kayıt türü çekirdeğe uyar

Her tür: kiracı ve klinik kapsamlıdır, değişiklik geçmişine yazılır, timeline'da bir kaynak okuyucusu vardır, düzenlenebiliyorsa eşzamanlılık belirteci taşır. Bugünkü eksikler (görüntüleme geçmişi ve klinik kapsamı; tedavi, reçete, aşı eşzamanlılık belirteci) dilimlerle kapatılır.

### K6 — Dinamik form frontend'de, kurallar backend'de

Alan tanımı ve yerleşim frontend'de tür başına tipli bileşen olarak tutulur (ortak form kabuğu + tür alan bölümü; oluşturma ve düzenleme tek bileşen). Alan adları, sınırlar ve hata kodları backend sözleşmesindedir; davranışsal kurallar (K3 eylemleri) API'den gelir. Dinamik form kütüphanesi eklenmez; mevcut tipli Reactive Forms ve PrimeNG bileşenleri kullanılır. Muayene şablonu (ön dolum + işlem paketi) ayrı mekanizma olarak kalır.

### K7 — Boşlukların kapatılması kullanıcı kararıyla

Aşağıdaki davranış değişiklikleri bu ADR'nin kabulüyle **değil**, ilgili AK maddesinin onayıyla yapılır.

## Açık kararlar (kullanıcıya)

| # | Soru | Ajan önerisi |
|---|---|---|
| AK-1 | B yönü onaylanıyor mu (A ve C reddi)? | Evet |
| AK-2 | Tedavi kaydına gerekçeli iptal | Evet (reçeteyle aynı kural) |
| AK-3 | Ürünsüz aşının iptali gerekçeli ayrı eylem; güncellemede iptale geçiş kapanır | Evet |
| AK-4 | Görüntülemede geç kayıt gerekçesi zorunlu (yeni kayıtlarda) | Evet |
| AK-5 | Yatışa "yanlış kayıt" gerekçeli iptali (taburcudan ayrı) | Evet |
| AK-6 | Kesinleşmiş muayenede ürünlü aşıya gerekçeli geç kayıt (ADR-013 eki); tedavi kilitli kalır | Evet |
| AK-7 | Klinik tanımlı ek alanlar (JSON) | Hayır, ertele |
| AK-8 | Muayene çalışma alanı ve hasta kartında tek "Kayıt ekle" girişi (tür seçici) | Evet, son kullanılan türler kısayoluyla |
| AK-9 | Vital ölçümü ve prosedür ayrı kayıt türü olarak ayrı backlog maddeleri | Evet, P2, RECORD-006 dışında |

## Sonuçlar

- **Backend:** çekirdek sözleşmesi (`docs/` altında tür × kural matrisi) önce; timeline sözleşmesi koda göre düzeltilir (lab olay tarihi, görüntüleme türü, geç kayıt rozeti kapsamı). Tür sözlüğü, ortak arayüz, politika tablosu ve eylem yanıtı migration'sız (hedef). AK-2…AK-6 onaylanırsa eklemeli sütunlu migration'lar; paylaşılan veritabanına uygulama ayrı onayla.
- **Frontend:** tür kayıt defteri; muayene çalışma alanındaki kilit kopyasının kaldırılması (önce hata düzeltmesi olarak, kararsız yapılabilir); ortak form kabuğu ve tür başına alan bölümü, tür tür dilimlerle.
- **Değişmeyenler:** veri modeli tabloları, kayıt defteri biçimleri, HBS alanları, ücret önerisi ve stok kuralları, portal kapsamı (ADR-031), ADR-013 kilit kuralları (AK-6 hariç).
- **Riskler:** çekirdeğe uyum disiplin ister (çekirdek sözleşmesi ve tür başına testlerle korunmalı); EF owned type eşlemesinin migration'sız olacağı doğrulanmadı; frontend form birleştirmesi geniş yüzeyli (tür başına ayrı dilim, ayrı doğrulama).
- **Ertelenen:** klinik tanımlı ek alanlar; şablonda kayıt türü satırları ve item rules (EXAM-014); kayıt kopyalama (RECORD-004); tüm türlere dosya eki (RECORD-003); muayene yeniden açma (RECORD-007).
