# ADR-043 — Birleşik klinik kayıt modeli: ayrı kayıtlar, ortak kurallar

## Durum

**Kabul edildi (2026-11-14, kullanıcı: "fable ın önerilerini onaylıyorum").** İlk taslak 2026-11-01 (kaynak araştırma: [research/record-006-birlesik-kayit-modeli-2026-11.md](../research/record-006-birlesik-kayit-modeli-2026-11.md)); kabul edilen biçim ikinci değerlendirmenin önerileridir: [research/adr043-degerlendirme-fable-2026-11.md](../research/adr043-degerlendirme-fable-2026-11.md). İlk taslağa göre değişenler: K2 ve K4 daraltıldı; AK-4, AK-6, AK-8, AK-9 farklı karar aldı; AK-10 eklendi; form birleştirme pilot sonrasına alındı. Backlog: [RECORD-006](../backlog/feature-backlog.md#record-006--birleşik-record-modeli-ve-tip-bazlı-dinamik-form). İlgili: [ADR-006](ADR-006-patient-timeline.md), [ADR-013](ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](ADR-015-batch-based-stock-and-registers.md), [ADR-018](ADR-018-charge-suggestion-and-service-catalog.md), [ADR-036](ADR-036-hbs-ve-e-belge-entegrasyonu.md).

## Bağlam

- Klinik kayıtlar sekiz ayrı aggregate ve tabloda: muayene, tedavi, reçete, aşı, uygulama, lab, görüntüleme, yatış. Silme ucu hiçbirinde yok.
- Ortak kuralların bir kısmı tek yerde: gerekçe kuralı (`CorrectionReason`), HBS geri kaydı (`HbsEntryRules`), yol/bölge (`AdministrationRouteSite`), kesinleşmiş muayene kilidi (`ExaminationLinkedRecordLock`), klinik kapsamı (`IClinicScoped`), zaman çizelgesi okuma modeli (`IPetTimelineSource`), değişiklik geçmişi (EF kaydetme yakalayıcısı).
- Sorun tutarsızlık (2026-11-14 kod okuması, backend `d56a01c5`, frontend `9f49fb1c`): yatış ve tedavi iptal edilemiyor; ürünsüz aşı durum alanından gerekçesiz iptal edilip geri alınabiliyor; tedavi, reçete ve aşıda eşzamanlılık belirteci yok (son kaydeden sessizce ezer); görüntüleme değişiklik geçmişine yazılmıyor; güncellemede kayıt başka hastaya taşınabiliyor; kesinleşmiş muayene kilidi panelde beş yerde kopya.
- Rakip (DaySmart) tek "Record" kavramı ve tipe göre değişen form gösteriyor; veri modeli bilinmiyor. Değer kullanıcı yüzeyinde: ortak dil ve birleşik geçmiş. Tek form rakipte de bilgi yoğun ve çok alanlı; kopyalanmaz.
- Türkiye'ye özgü yükümlülükler (kayıt defterleri ADR-015, HBS e-Reçete/ATS ADR-036, stok/parti, ücret önerisi ADR-018) tipli alanlara ve tipli kurallara dayanıyor.

## Değerlendirilen seçenekler

- **A — Tek `ClinicalRecord` tablosu + JSON tür alanları + dinamik form.** Reddedildi: türe özgü değişmezler JSON'da da kod ister; defter, HBS ve stok sorguları JSON'dan çıkarıma döner; alan bazlı değişiklik geçmişi kaybolur; taşıma geri dönüşü pahalı.
- **B — Ayrı aggregate'ler kalır, ortak kurallar tek yerde, tutarsızlıklar dilimlerle kapanır.** Seçildi.
- **C — Yeni türler JSON tabanlı birleşik modelde, eskiler dokunulmaz.** Reddedildi: iki kalıcı model toplam karmaşıklığı artırır.

## Karar

### K1 — Kayıtlar ayrı ve tipli kalır

Her klinik kayıt türü kendi aggregate'i ve tablosuyla kalır. Tek tablo ve JSON klinik alanlar kullanılmaz. Yeni tür gerekirse aynı kurallara uyan tipli aggregate olarak eklenir.

### K2 — Tür sözlüğü yalnız panelde birleşir

Backend'de yeni bir tür eşlemesi kurulmaz. `PetRecordKind` ve `RecordHistoryTypes` olduğu gibi kalır; ücret önerisi `SourceType` ve stok `ReferenceType` kayıt türü sözlüğü değildir (finans ve stok alanlarının kendi kaynak izleri), bağlanmaz. Yeni tür değişiklik geçmişine eklenirken yakalayıcıdaki eşleme tablosuna bir satır yazılır.

Panelde tek tür kayıt defteri (etiket, simge, rota, geçmiş kaynağı) kurulur; zaman çizelgesi, muayene işlem bölümü ve geçmiş ekranı bunu kullanır (pilot sonrası).

### K3 — Kesinleşmiş muayene kuralı sade ve API'den gelir

Yeni kayıt için iki sınıf (AK-6):

- **Tedavi edici kayıtlar** (uygulama, reçete, tedavi, aşı): kesinleşmiş muayeneye zorunlu gerekçeyle (5–500) "Kesinleştirmeden sonra eklendi" olarak yazılır.
- **Tanısal kayıtlar** (lab, görüntüleme): serbest; kayıt "sonradan eklendi" rozeti taşır.
- Yatış kesinleşmiş muayeneye bağlanmaz (yatış muayenesiz başlar).

Mevcut kayıt için kural değişmez: kesinleşmiş muayeneye bağlı kayıt kilitlidir, düzeltme gerekçeli iptal ve yeni kayıttır; lab sonuç alanları ve yatışın canlı alanları serbesttir.

Pilot sonrası: kural tek yerde tutulur; API muayene özetinde tür başına oluşturma eylemini (`Allowed`, `AllowedWithReason`, `Blocked`), kayıt detayında düzenleme ve iptal iznini döner; panel kopyaları kaldırılır.

### K4 — İptal ve geç kayıt kuralı tek yerde, sütunlar türde

Gerekçeli iptal (zaman, eden, gerekçe) ve geç kayıt (işaret, gerekçe) her türde aynı anlamı taşır. Kural tek bir yardımcıda yaşar (`HbsEntryRules` deseni: kural doğrular, aggregate sonucu kendi sütunlarına yazar). EF owned/complex type kullanılmaz: değişiklik geçmişi yakalayıcısı alan farkını aggregate'in kendi özelliklerinden okur. Gerekçe kuralı `CorrectionReason` (5–500). Silme yoktur. İptal son durumdur, geri alınmaz. İptal edilen kayıt varsayılan gizli, filtreyle görünür; kayıt defterlerinde çıkarılmaz, işaretlenir (RECORD-008 deseni).

### K5 — Her klinik kayıt türü aynı tabana uyar

Her tür: kiracı ve klinik kapsamlıdır (`IClinicScoped`), değişiklik geçmişine yazılır, zaman çizelgesinde bir kaynak okuyucusu vardır, düzenlenebiliyorsa eşzamanlılık belirteci taşır ve güncelleme ile iptalde belirteç zorunludur, gerekçeyle iptal edilebilir.

### K6 — Hasta ve klinik güncellemede değişmez

Kayıt oluşturulduktan sonra hastası ve kliniği değişmez (AK-10). Yanlış hasta: gerekçeli iptal ve doğru hastaya yeni kayıt. Muayene bağı aynı hasta içinde değişebilir (kilit kuralına tabi).

### K7 — Formlar türe özel kalır; birleştirme fırsatçı

Alan tanımı ve yerleşim panelde tür başına tipli bileşen; davranışsal kurallar backend'den gelir. Dinamik form kütüphanesi eklenmez. Tek "Kayıt ekle" formu (tür seçici) yapılmaz; muayene çalışma alanında tür düğmeleri kalır, hasta kartına türleri listeleyen "Kayıt ekle" menüsü eklenir (AK-8). Oluşturma ve düzenleme formlarının tek bileşene inmesi toplu dilim değildir; bir türün formu yeni alan aldığında o tür birleştirilir (pilot sonrası).

## Kararlar (kullanıcı, 2026-11-14)

| # | Soru | Karar |
|---|---|---|
| AK-1 | B yönü (A ve C reddi) | Evet; K2 ve K4 yukarıdaki dar biçimde |
| AK-2 | Tedaviye gerekçeli iptal | Evet; tedaviye bağlı etkin reçete ya da uygulama varken reddedilir (önce onlar iptal edilir). Kesinleşmiş muayenede de yapılabilir; defterde işaretli kalır |
| AK-3 | Ürünsüz aşıda gerekçeli iptal | Evet; ayrı eylem, iptal son durum. Güncellemede izinli tek durum geçişi Planlı → Uygulandı; uygulamaya bağlı aşıda iptal uygulama iptaliyle olur |
| AK-4 | Görüntülemede geç kayıt gerekçesi | Hayır; tanısal kayıtta rozet yeter. Lab kaydı da "sonradan eklendi" rozeti alır |
| AK-5 | Yatışa gerekçeli iptal | Evet, pilot öncesi; etkin ve taburcu edilmiş yatışta. İptal edilen yatış etkin sayılmaz |
| AK-6 | Kesinleşmiş muayenede geç kayıt | Tedavi ve aşı (ürünlü, ürünsüz) reçeteyle aynı: zorunlu gerekçeli geç kayıt. ADR-013'e ikinci ek |
| AK-7 | Klinik tanımlı ek alanlar (JSON) | Hayır, ertelendi |
| AK-8 | Tek "Kayıt ekle" girişi | Tek form yok; hasta kartında "Kayıt ekle" menüsü, muayene çalışma alanında tür düğmeleri kalır |
| AK-9 | Vital ölçümü ve prosedür ayrı tür | Vital ölçümü ayrı P2 backlog maddesi (yatış izlemiyle); prosedür ayrı tür olarak açılmaz, ihtiyaç tedavi kaydına hizmet bağıyla karşılanır |
| AK-10 | Güncellemede hasta ve klinik değişimi | Kapanır (K6) |

## Uygulama sırası

Önce backend sözleşmesi, sonra panel. Her dilim tek aggregate, en çok bir migration.

**Pilot öncesi:** (1) yatış iptali; (2) aşı: eşzamanlılık belirteci, gerekçeli iptal, durum geçişi kısıtı; (3) reçete: eşzamanlılık belirteci, zaman çizelgesinde "sonradan eklendi" rozeti; (4) tedavi: eşzamanlılık belirteci, gerekçeli iptal; (5) görüntüleme: klinik kapsamı arayüzü ve değişiklik geçmişi. Ardından AK-6 (tedavi ve aşıya geç kayıt), AK-10 (hasta değişiminin kapanması), lab rozeti.

Belirteç güncelleme ve iptalde zorunlu olduğu için (2), (3) ve (4)'te backend ve panel **aynı yayında** çıkar.

**Pilot sonrası:** kilit kuralının tek yerde tutulması ve API'den eylem olarak gelmesi (K3); panel tür kayıt defteri (K2); hasta kartında "Kayıt ekle" menüsü (AK-8); fırsatçı form birleştirme (K7); vital ölçümü (AK-9).

## Sonuçlar

- **Backend:** tür başına eklemeli migration'lar (iptal sütunları, `rowversion`, geç kayıt sütunları); paylaşılan veya canlı veritabanına uygulama ayrı onayla. Sözleşmeler (`HOSPITALIZATION_MODEL`, `PRESCRIPTION_ITEMS`, `IMAGING`, `RECORD_HISTORY`, `PET_TIMELINE`, `PORTAL` ve tedavi/aşı) her dilimde önce güncellenir.
- **Panel:** iptal diyalogları (`ReasonConfirmDialogComponent`), çakışma mesajları, aşı durum seçeneklerinden "İptal"in kalkması, görüntülemede geçmiş düğmesi, düzenleme sayfalarında hasta seçiminin kalkması.
- **Değişmeyenler:** veri modeli tabloları, kayıt defteri biçimleri (iptal işareti dışında), HBS alanları, ücret önerisi ve stok kuralları, portal kapsamı (ADR-031).
- **Riskler:** zorunlu belirteç sözleşme kırıcıdır (backend ve panel birlikte yayınlanmalı); iptal edilen kayıtların tüm okuma yollarından (açık işler, hatırlatmalar, raporlar, dışa aktarma) doğru dışlanması dilim başına ayrıca denetlenmeli.
- **Ertelenen:** klinik tanımlı ek alanlar; şablonda kayıt türü satırları ve item rules (EXAM-014); tüm türlere dosya eki (RECORD-003); muayene yeniden açma (RECORD-007).

## Uygulama durumu (2026-11-14)

Pilot öncesi dilimler ve AK-6, AK-10, lab rozeti uygulandı; **main'e birleşmedi, push ve yayın yok**. Dal `feature/kayit-modeli-adr043` (backend ve panel).

- Backend: `18e6bcc1` iptal kuralı (K4), `50bd148d` yatış iptali, `e63e5f84` sürüm denetimli güncellemelerin değişiklik geçmişine yazılması (hata düzeltmesi), `7f3f5e6d` aşı, `9f21bb4b` reçete, `3f798cba` tedavi, `b2026314` görüntüleme geçmişi, `555c948d` AK-6, `3038c0d0` AK-10, `a8af1855` lab rozeti.
- Panel: `3fdc0500`, `a5249cf3`, `474d6732`, `9f443202`, `c25009d7`, `5b512cc1`, `fa047079`.
- Migration'lar (yalnız yerel): `AddHospitalizationCancellation`, `AddVaccinationCancellationAndRowVersion`, `AddPrescriptionRowVersion`, `AddTreatmentCancellationAndRowVersion`, `AddTreatmentAndVaccinationLateEntry`, `AddLabResultLateEntryMark`.
- **Yayın notu:** aşı, reçete ve tedavide `rowVersion` güncelleme ve iptalde zorunlu (sözleşme kırıcı); backend ve panel aynı yayında çıkmalıdır.
- Kapsam dışı bırakılan: hasta sahibi portalında iptal edilen aşının görünmesi (ADR-031 sözleşmesi; ayrı karar).
