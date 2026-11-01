# RECORD-006 — Birleşik kayıt modeli ve tip bazlı dinamik form: araştırma ve öneri — 2026-11

Tarih: 2026-11-01. Tetikleyen: [RECORD-006](../backlog/feature-backlog.md#record-006--birleşik-record-modeli-ve-tip-bazlı-dinamik-form) (P1, "Araştırılacak"), P1 tamamlama planı Dalga 4 ([P1-TAMAMLAMA-2026-10-30](../roadmap/P1-TAMAMLAMA-2026-10-30.md)). Fikir/desen: [IDEA-026](ideas.md#idea-026--unified-dynamic-record-model), [PATTERN-020](patterns.md#pattern-020--unified-record-with-dynamic-type-forms). Karar taslağı: [ADR-043](../decisions/ADR-043-birlesik-klinik-kayit-modeli.md).

Bu belge araştırmadır; **kod yazılmadı, kod depolarında dosya değiştirilmedi.** Yöntem: kodun okunması (backend worktree `C:\Vetinity\wt\dalga-4b-be`, HEAD `700a1675`; frontend worktree `C:\Vetinity\wt\dalga-4b-fe`, HEAD `9e6ed293`), backend sözleşmeleri ve ürün belgeleri. Test, build veya tarayıcı denemesi **yapılmadı**. Satır sayıları `wc -l` ile ölçüldü; zorluk ve süre tahminleri **ölçülmedi**.

---

## 1. Kısa sonuç

1. **Bugünkü model "parçalı" ama dağınık değil.** Sekiz klinik kayıt türü (muayene, tedavi, reçete, aşı, uygulama, lab, görüntüleme, yatış) ayrı aggregate ve tablolarda duruyor. Ortak kuralların bir kısmı zaten tek yerde: `CorrectionReason` (5–500 gerekçe), `HbsEntryRules`, `AdministrationRouteSite`, `ExaminationLinkedRecordLock` (kesinleşmiş muayene kilidi), `IClinicScoped`/`ITenantOwned`, `IPetTimelineSource` (timeline okuma modeli), `RecordHistorySaveChangesInterceptor` (değişiklik geçmişi). Yani **B seçeneğinin yarısı fiilen yapılmış.**
2. **Gerçek sorun tutarsızlık:** aynı yaşam döngüsü kavramı (iptal, geç kayıt, eşzamanlılık, geçmiş) türlere göre farklı ya da eksik uygulanmış (bölüm 2.2). Frontend'de her tür için iki ayrı form var (oluşturma + düzenleme) ve kilit kuralı frontend'de kopyalanmış; bu kopya backend'den geri kalmış (bölüm 2.3).
3. **Tek `ClinicalRecord` tablosu + JSON alanlar (A) önerilmez.** Kayıt defterleri (ADR-015, resmî biçim), HBS e-Reçete/ATS (ADR-036), stok/parti ve ücret önerisi tipli sütunlara ve tipli kurallara dayanıyor; JSON bu kuralları ortadan kaldırmaz, yalnız şema güvencesini kaldırır. Değişiklik geçmişi de JSON alanı tek alan gibi görür.
4. **Öneri: B — mevcut aggregate'ler kalır, "kayıt çekirdeği" tamamlanır.** Tek tür sözlüğü, tek kilit politikası tablosu (backend'de; frontend'e eylem izni olarak gelir), ortak iptal ve geç kayıt değer nesneleri, boşlukların kapatılması; frontend'de tür kayıt defteri + ortak form kabuğu + türe özel alan bölümü. Yeni türler (vital ölçümü, prosedür) gerekirse **aynı çekirdeğe uyan tipli aggregate** olarak eklenir; ayrı JSON modeli (C) kurulmaz.
5. **Karar gerektiren boşluklar** (bölüm 7): tedavi ve yatışta iptal yok, ürünsüz aşı gerekçesiz iptal edilebiliyor, görüntülemede geç kayıt gerekçesi yok, yeni türlerin kapsamı, klinik tanımlı ek alanlar.

---

## 2. Problem ve bugünkü durum

### 2.1 Problem (RECORD-006'nın iddiası ve gerçekte gözlenen)

Backlog problemi: "Aşı, ilaç, prosedür, diagnostik ve vital kayıtları parçalı modellerde tutuluyor." Kod incelemesinde bunun anlamı şu çıktı:

- **Kullanıcı açısından:** her kayıt türünün formu ayrı yazılmış; aynı kavram (iptal, "sonradan eklendi", kilit mesajı) türden türe farklı davranıyor. Örneğin reçete ve lab gerekçeyle iptal edilir, tedavi hiç iptal edilemez, ürünsüz aşı durum alanından gerekçesiz "İptal" yapılabilir.
- **Geliştirici açısından:** yeni bir tür eklemek ya da ortak bir kuralı değiştirmek çok sayıda yere dokunmayı gerektiriyor: timeline kaynağı, `PetRecordKind`, `RecordHistoryTypes` + interceptor eşlemesi, muayene `related-summary`, izin, frontend'de üç ayrı tür listesi (`PET_TIMELINE_TYPES`, `PROCEDURE_KINDS`, kayıt geçmişi etiketleri), iki form.
- **"Prosedür" ve "vital" türü yok:** vitaller muayenenin dört alanıdır (kilo, ateş, nabız, solunum); prosedür ayrı kayıt değil, serbest metin tedavi kaydı veya şablondan doğan `ExaminationService` ücret önerisi kalemidir.

### 2.2 Tür × özellik matrisi (backend, kod okunarak)

Kaynak: `src/Backend.Veteriner.Domain/{Examinations,Treatments,Prescriptions,Vaccinations,Administrations,LabResults,Imaging,Hospitalizations}`, `Application/Examinations/Access/ExaminationLinkedRecordLock.cs`, `Application/Pets/Timeline/*`, `Infrastructure/RecordHistory/RecordHistorySaveChangesInterceptor.cs`, sözleşmeler (bölüm 9).

| Özellik | Muayene | Tedavi | Reçete | Aşı | Uygulama | Lab | Görüntüleme | Yatış |
|---|---|---|---|---|---|---|---|---|
| **Temel alanlar** | şikâyet, anamnez, bulgu, değerlendirme, plan, not; 4 vital + ölçüm zamanı; randevu, geliş | başlık, açıklama, not, tarih, kontrol tarihi | başlık, içerik, not, tarih, kontrol, tedavi bağı; ≤30 satır (ad, ürün?, miktar, birim, doz, talimat, parti metni) | aşı tanımı + ad anlığı, durum, uygulama/vade tarihi, not, yol, bölge | ürün, miktar, zaman, not, yol, bölge, parti, tedavi, aşı ve paket bağı | test adı, durum, istek zamanı/eden, sonuç tarihi/metni, yorum, not, geliş | tür (modalite), tarih, açıklama, klinik not, dosyalar | neden, not, kabul, planlı/gerçek taburcu, taburcu notu, konum, oda, geliş |
| **Durum makinesi** | Taslak → Kesinleşti (geri yok) | yok | yok (iptal bayrağı) | Planlı / Uygulandı / İptal (güncellemeyle serbest geçiş) | Etkin → İptal | İstendi → Sonuçlandı; → İptal | Etkin → İptal | Yatışta → Taburcu (türetilmiş) |
| **İptal / düzeltme** | iptal yok; düzeltme **ek not** (addendum) | **yok** | gerekçeli iptal (RECORD-008) | ürünlüyse uygulama iptaliyle; **ürünsüzse güncellemede `Status=Cancelled`, gerekçesiz** | gerekçeli iptal + stok sonucu (iade / zarar) | gerekçeli iptal | gerekçeli iptal (dosya erişimi kapanır) | **yok** (yalnız taburcu) |
| **Silme ucu** | yok | yok | yok | yok | yok | yok | yok | yok |
| **Düzenleme** | taslakta kısmi PUT | serbest | iptal edilmemişse serbest | serbest; uygulamaya bağlıysa yalnız not ve sonraki doz | düzenlenmez | serbest; sonuç silinemez | hasta/klinik değişmez | taburcuya kadar |
| **Kesinleşmiş muayene kilidi** | içerik kilitli | yeni/değişiklik yok | yeni = gerekçeli geç kayıt; mevcut kilitli | yeni/değişiklik yok | yeni = gerekçeli geç kayıt | yeni serbest; sonuç alanları serbest; kimlik kilitli | yeni serbest (rozet); önceden var olan donuk | yeni kayıt bağlanamaz; bağ değişimi kilitli; diğer alanlar serbest |
| **Geç kayıt işareti** | — | — | var, **gerekçeli** | — | var, **gerekçeli** | — | var, **gerekçesiz** | — |
| **Eşzamanlılık (RowVersion)** | var | **yok** | **yok** | **yok** | var | var | var | var |
| **Finans bağı** | `Charge.ExaminationId`; şablondan `ExaminationService`/`ExaminationPackage` ücret önerisi | yok | yok | ürünlüyse bağlı uygulama üzerinden | `ChargeSuggestion` (fiyat > 0), pakete dahil işareti | yok | yok | yok |
| **Stok bağı** | yok | yok | **yok** (parti no serbest metin) | ürünlüyse bağlı uygulama üzerinden | `Out` hareketi, parti (FEFO), iptalde iade/zarar | yok | yok | yok |
| **Defter bağı** (ADR-015) | Muayene defteri satırı (bağlı tedavi başlıkları, reçeteler, uygulamalar tek sütunda) | muayene defterinde başlık | Reçete defteri; muayene defterinde | Aşı Bilgi raporu (satır = uygulama) | Aşı Bilgi raporu; stok defterleri hareketten | yok | yok | yok |
| **HBS** (ADR-036) | — | — | e-Reçete geri kaydı | ATS geri kaydı (yalnız uygulanmış) | — | — | — | — |
| **Değişiklik geçmişi** (RECORD-002) | var | var | var (satırlar tek alan) | var | var | var | **yok** | var |
| **Timeline** | var (`status` hep `null`) | var | var (iptal gizli; **geç kayıt rozeti yok**) | yalnız uygulanmış; planlı girmez | var; aşıya bağlı olan gizli | var | var (rozetli) | tek olay (kabul) |
| **Portal** (ADR-031) | yok | yok (v1 planlı) | yok (v1 planlı) | **var** (ayrı DTO) | yok | yok | yok | yok |
| **Dosya eki** (RECORD-003) | yok | yok | yok | yok | yok | var (backlog notu) | var | yok |

Kalın işaretli hücreler bölüm 7'deki kararların ve bölüm 5'teki dilimlerin kaynağıdır.

**Ek gözlemler (kod okunarak, test edilmedi):**

- `ImagingRecord` `IClinicScoped` uygulamıyor; değişiklik geçmişi yakalayıcısı yalnız `ITenantOwned` **ve** `IClinicScoped` olan türleri izliyor ve eşleme tablosunda görüntüleme yok. Görüntüleme düzenlemeleri bu yüzden geçmişe yazılmıyor. Timeline'da klinik kapsamı görüntüleme için ayrıca elle yazılmış.
- Tür adının kodda en az dört ayrı sözlüğü var: `PetRecordKind` (enum, timeline sıra numarası), `RecordHistoryTypes` (`"examination"`, `"labResult"` gibi camelCase metin), `ChargeSuggestion.SourceType` (`"Administration"`, `"ExaminationService"`, `"ExaminationPackage"`), `StockMovement.ReferenceType` (`"Administration"`). Değerler API sözleşmesinin parçası; ortak bir eşleme yok.
- **Timeline sözleşmesi koddan geri kalmış** (`docs/PET_TIMELINE_API_CONTRACT.md`): sözleşme lab olay tarihini `ResultDateUtc` diyor, kod `RequestedAtUtc` kullanıyor; görüntüleme türü sözleşmenin tür ve izin tablolarında yok, kodda var (`PetRecordKind.Imaging = 11`); `addedAfterFinalization` sözleşmede yalnız uygulama için, kodda görüntüleme için de dolu, reçete için dolmuyor; muayene `status` alanı kesinleştirme geldiği hâlde hâlâ `null`.

### 2.3 Frontend bugünkü durum

- **Her tür için iki form var.** Oluşturma formu `src/app/entities/procedure/components/*-form.component.ts` içinde (tedavi 441, reçete 762, aşı 694, lab 422, görüntüleme 356, yatış 588 satır); hem bağımsız "yeni" sayfasında hem muayene çalışma alanının işlem bölümünde (`examination-procedures-section.component.ts`) kullanılıyor. Düzenleme ayrı sayfada yeniden yazılmış (`features/*/pages/*-edit-page`: tedavi 504, reçete 655, aşı 585, lab 555, yatış 689 satır). Okunan örnekte (tedavi) müşteri/hasta/muayene seçimi, tarih doğrulaması, salt okunur uyarısı ve hata gösterimi iki dosyada benzer biçimde tekrar ediyor. Ortak kod oranı **ölçülmedi**.
- Ortaklaşmış parçalar: `ClientSearchComponent`, `PetSearchComponent`, `DateInputComponent`, `ReasonConfirmDialogComponent` (gerekçeli iptal diyalogları), `RecordHistoryButtonComponent`, tür başına `*-upsert-validation-parse.utils.ts` (aynı desen, ayrı dosyalar).
- **Kilit kuralı frontend'de kopyalanmış ve geride kalmış:** `features/examinations/utils/examination-procedures.utils.ts` `LOCKED_WHEN_FINALIZED = ['treatment', 'prescription', 'vaccination']` ve mesaj "tedavi, reçete ve aşı eklenemez". Backend ise RECORD-008 ile kesinleşmiş muayeneye gerekçeli reçeteye izin veriyor; bağımsız reçete formu bunu destekliyor (`prescription-form.component.ts`, `lateEntryReason`). Sonuç: muayene çalışma alanında "Reçete ekle" kesinleşmiş muayenede kapalı görünüyor olmalı (kod okunarak; **tarayıcıda doğrulanmadı**). Bu bir hata düzeltmesidir, ürün kararı gerektirmez (ADR-013 eki zaten karar).
- Tür sunumu üç yerde tanımlı: `PET_TIMELINE_TYPES` (etiket, simge, rota), `PROCEDURE_KINDS`/`PROCEDURE_LABEL`/`PROCEDURE_ROUTE_SEGMENT` (küçük harf anahtar, `'lab'`), kayıt geçmişi eşleyicisi.
- Form teknolojisi: Angular 22, PrimeNG 22, tipli Reactive Forms (`FormBuilder`); dinamik form kütüphanesi (formly, JSON şema) **yok**. `FormArray` reçete satırları, şablon editörü ve mal kabulünde kullanılıyor.
- Portal (`projects/portal`) yalnız hasta, aşı, randevu ve bakiye gösteriyor; klinik kayıt formu yok.

### 2.4 Muayene şablonu mekanizması ne yapıyor

`docs/EXAMINATION_TEMPLATE_API_CONTRACT.md` (ADR-020 S4): şablon = ad + şikâyet/bulgu/plan **metin ön dolumu** + en çok 20 **işlem satırı** (ürün veya hizmet + miktar) + isteğe bağlı paket fiyatı. Uygulanınca metin `ExaminationTextMerge` ile birleşir, satırlar uygulama kaydı ve ücret önerisi doğurur. Aşı ürünü satır olamaz. Yani şablon **alan şeması değil, içerik ön dolumu ve işlem paketi**dir; dinamik formla çakışmaz (bölüm 6.3).

---

## 3. Rakip gözlemi (DaySmart, problem odaklı)

Kaynak: [daysmart.md — Birleşik record modeli](../competitors/daysmart.md#birleşik-record-modeli-ve-dinamik-formlar), [Records](../competitors/daysmart.md#records), [Patient-scoped vs clinic-scoped read models](../competitors/daysmart.md#patient-scoped-vs-clinic-scoped-read-models). Gözlemler sandbox/demo düzeyindedir; **DaySmart'ın veritabanı yapısı bilinmiyor**, "tek tablo" kullandığı iddia edilmez.

| Gözlem | Çözdüğü problem | Vetinity çıkarımı |
|---|---|---|
| Tek "Record" kavramı altında Vaccine, Medication, Procedure, Diagnostic, Vital; tip değişince form alanları değişiyor | Kullanıcı tek giriş noktasından her klinik olayı kaydeder; ortak alanları (hasta, tarih, hekim, fatura) bir kez öğrenir | Değer **kullanıcı yüzeyinde**: tek "kayıt ekle" girişi + tipe göre değişen alan bölümü. Bunun için tek tablo gerekmez |
| History filtreleri: Records, Medical Notes, Pharmacy, Labs, Images, Vaccines, Vitals; her filtrede modüle özel sütunlar, Invoice + Reference bağı | Aynı klinik olaylar farklı bakışlarla okunur | Bizde karşılığı **timeline okuma modeli** (zaten var, 9 tür); eksik olan modüle özel sütunlu filtreli görünümler ve fatura bağının görünürlüğü (RECORD-001) |
| Record satırında lot, route, site, fiyat, invoice, audit, duplicate, print label | Klinik–finans–stok izlenebilirliği tek satırda | Bizde uygulama satırında var (RECORD-001/005); diğer türlerde ortak "kayıt satırı" sunumu yok |
| Apply Item Rule (ürün seçince next due, reminder, route, invoice, stok dolar) | Tekrarlı alan girişini azaltır | [EXAM-014](../backlog/feature-backlog.md) kapsamı; RECORD-006'ya bağımlı ama ayrı iş |
| Zayıf yön (bizim değerlendirmemiz): bilgi yoğun, eski görünüm; çok alanlı formlar | — | Kopyalanmaz. Bizim farkımız: kayıt türüne özgü **az alan**, bağlam (muayene, hasta) taşınır, kilit ve iptal kuralı her türde aynı dille anlatılır |

Sonuç: rakipte görülen değer, ortak **okuma modeli** ve ortak **giriş deneyimi**dir. Bunların ikisi de B seçeneğiyle elde edilir.

---

## 4. Seçenekler

### A) Tek `ClinicalRecord` tablosu + tip meta (JSON alanlar) + dinamik form

Ortak sütunlar (kiracı, klinik, hasta, muayene, tür, olay zamanı, durum, iptal, geç kayıt) + türe özel alanlar JSON; form tanımı tür metadatasından.

| | |
|---|---|
| **Artılar** | Timeline, geçmiş, kilit ve iptal tek tabloda doğal olarak ortak; yeni tür teorik olarak koda dokunmadan eklenebilir |
| **Eksiler** | Türe özel değişmezler (lab durum makinesi, uygulama–stok–parti, aşı vade/hatırlatma, reçete satırları, yatış oda/taburcu) JSON'da da kod ister; tek varlık ya "her şeyi bilen" sınıfa ya da türe göre strateji sınıflarına dönüşür — bugünkü kod aynı kalır, şema güvencesi gider. Hatırlatma (`DueAtUtc`), lab "yorum bekliyor" ifadesi, defter sorguları için JSON içinden indeks/sorgu gerekir |
| **Migration / veri taşıma** | **En yüksek risk.** 8 tablonun verisi tek tabloya taşınır; kayıt kimliğine bağlanan yerler: `Administration.VaccinationId`, `Administration.TreatmentId`, `Prescription.TreatmentId`, `PrescriptionItem`, `StockMovement` kaynak izi, `ChargeSuggestion (SourceType, SourceId)`, `StoredFile` sahibi, `RecordChanges (RecordType, RecordId)`, HBS alanları, içe aktarma partisi, hatırlatmalar. Kimlikler korunsa bile tür adları değişir. Üretimde veri olup olmadığı **doğrulanmadı** (bugünkü işler "main yerel, origin'e gönderilmedi") |
| **ADR-013 uyumu** | Kural metni tek yerde olabilir ama istisnalar türe özgü kalır (uygulama/reçete geç kayıt, lab sonuç alanları serbest, görüntüleme donma, yatış yalnız bağ kilidi) |
| **ADR-015 / defter** | Defter sütunları tipli alanlardan türetiliyor; JSON'dan çıkarım resmî biçim değişince kırılgan; aşı bilgi raporu stok hareketi ve partiye bağlı |
| **HBS / e-belge** | ADR-036 yapılandırılmış alan istiyor (reçete satırı, seri no); JSON'da zorunluluk ve biçim kodda ayrıca denetlenmeli |
| **Kayıt geçmişi** | Interceptor özellik bazlı fark üretiyor; JSON alanı tek alan görünür (bugün reçete satırlarındaki gibi), alan bazlı geçmiş kaybolur ya da özel kod gerekir |
| **Değerlendirme** | **Önerilmez.** Çözdüğü sorun (ortak okuma ve ortak kurallar) daha ucuz yolla çözülebiliyor; getirdiği risk geri dönüşü pahalı |

### B) Ayrı aggregate'ler kalır + ortak "kayıt çekirdeği" + frontend'de tür bazlı form metadatası

Backend:

1. **Tek tür sözlüğü** (`ClinicalRecordKind` veya mevcut `PetRecordKind` genişletilerek): her türün timeline sıra no'su, geçmiş adı, kaynak izi adı, izin adı tek tabloda; mevcut tel (wire) değerleri **korunur**, API kırılmaz.
2. **Ortak arayüz** (ör. `IClinicalRecord`: kiracı, klinik, hasta, muayene, olay zamanı, oluşturma/güncelleme) — timeline kaynakları, geçmiş, kilit buna dayanır. Görüntüleme `IClinicScoped` olur.
3. **Kesinleşmiş muayene politikası tek tablo:** tür → davranış (`Kilitli`, `GerekçeliGeçKayıt`, `SonuçAlanlarıSerbest`, `ÖncekilerDonuk`, `YalnızBağKilitli`). Bugünkü `ExaminationLinkedRecordLock` bu tabloyu okur. API, muayene için **izin verilen eylemleri** döner (ör. `related-summary` içinde `recordActions`); frontend kuralı kopyalamaz.
4. **Ortak değer nesneleri:** `RecordCancellation` (zaman, eden, gerekçe; `CorrectionReason` ile), `LateEntry` (işaret + gerekçe). Mevcut sütun adlarıyla eşlenerek migration'sız taşınması hedeflenir (EF owned type; **doğrulanmadı**).
5. **Boşlukların kapatılması** (karar gerektirir, bölüm 7): tedavi ve yatış iptali, ürünsüz aşı iptalinde gerekçe, görüntüleme geç kayıt gerekçesi, Tedavi/Reçete/Aşı'da RowVersion, görüntüleme geçmişi.
6. **Okuma modelleri** (timeline, related-summary, history-summary, açık işler, HBS yardımcısı, defterler) mevcut desenle kalır; yeni tür yalnız kaynak okuyucu ekler (`IPetTimelineSource` deseni).

Frontend: tür kayıt defteri + ortak form kabuğu + türe özel alan bölümü (bölüm 6).

| | |
|---|---|
| **Artılar** | Veri taşıma yok; tipli şema korunur (defter, HBS, stok, ücret); her dilim bağımsız ve geri alınabilir; mevcut desenlerle uyumlu (ADR-039 birim iş, ADR-040 global filtre, timeline kaynak deseni); kural tek yerde yaşar |
| **Eksiler** | Yeni tür hâlâ yeni aggregate + tablo + uç ister (ama ortak kabukla daha ucuz); "tek entity" hedefi gerçekleşmez; çekirdeğe uyum disiplin ister (çekirdek sözleşmesi ve testlerle korunmalı) |
| **Migration / veri taşıma** | Çekirdek ve sözlük: migration yok (hedef). Boşluk kapatma: eklemeli sütunlar (iptal alanları, RowVersion) — küçük ve geriye uyumlu; yine de paylaşılan DB'ye uygulama kullanıcı onayı ister |
| **ADR-013 uyumu** | Tam: kararın kendisi tür bazlı istisnalar içeriyor, B bunları tek tabloya yazar. Kesinleşmiş muayene kilidi değişmez, yalnız tek yerden okunur |
| **ADR-015 / defter** | Dokunulmaz; defter tanımları tek yerde kalır (`ExaminationRegisterColumns`, `register-definitions.ts`) |
| **HBS / e-belge** | Dokunulmaz; `HbsEntryRules` zaten ortak. Yeni bir HBS türü (ör. kimliklendirme) aynı deseni kullanır |
| **Kayıt geçmişi** | Değişmez; görüntüleme eklenir. Ortak iptal nesnesi geçmişte aynı alan adlarıyla görünür |
| **Değerlendirme** | **Önerilen.** |

### C) Hibrit: yeni türler (prosedür, vital ölçümü) birleşik JSON modelde, eski türler dokunulmaz

| | |
|---|---|
| **Artılar** | Eski türlere risk yok; yeni tür hızlı eklenir |
| **Eksiler** | **İki kalıcı model**: timeline, geçmiş, kilit, iptal, izin her ikisini de bilmek zorunda; toplam karmaşıklık artar ("Consistency Over Feature Count" ilkesine ters). Aday yeni türlerin kendisi tipli ihtiyaç taşıyor: vital ölçümü sayısal zaman serisi (grafik, aralık, kilo geçmişi D2 kuralı), prosedür hizmet ürünü → ücret önerisi, olası anestezi/kontrollü madde sarfı → stok. JSON burada az şey kazandırır |
| **Migration** | Eskiler için yok; yeni tablo + JSON |
| **ADR-013 / 015 / HBS** | Yeni türler için kuralların JSON üzerinde yeniden yazılması gerekir; defter/HBS'ye girecek bir yeni tür (ör. kontrollü madde içeren prosedür) çıkarsa tipli modele geri taşınır |
| **Değerlendirme** | **Önerilmez** bu biçimiyle. Dar bir türevi ("C′") ileride değerlendirilebilir: tipli kayıtlara **klinik tanımlı ek alanlar** (düzenleyici/finansal olmayan, JSON değer + backend alan tanımı). Bu ayrı ürün kararıdır (AK-7) |

---

## 5. Öneri ve aşamalı yol

### 5.1 Öneri

**B seçeneği.** Gerekçe:

1. Kullanıcı değeri (tek giriş deneyimi, tutarlı yaşam döngüsü, birleşik geçmiş) tek tablo gerektirmiyor; timeline okuma modeli bunun okuma tarafını zaten sağlıyor.
2. Vetinity'nin Türkiye'ye özgü yükümlülükleri (kayıt defterleri, HBS e-Reçete/ATS, e-belge) tipli alanlara dayanıyor; bunlar rakipte gözlenmeyen ve bizi tipli modele bağlayan kısıtlar.
3. Ortak kuralların çoğu zaten tek yerde; eksik olan tutarlılık. B bunu küçük, bağımsız ve geri alınabilir dilimlerle tamamlar; veri taşıma riski yok.
4. Yeni türler (vital, prosedür) gerektiğinde çekirdeğe uyan tipli aggregate olarak eklenir; çekirdek sayesinde timeline/geçmiş/kilit/iptal "bedava" gelir.

### 5.2 Dilimler (sıra önerisi; zorluklar **ölçülmedi**, kod okumasına dayalı tahmin)

| # | Dilim | Depo | Migration | Karar gerekir mi | Tahmini zorluk |
|---|---|---|---|---|---|
| D0 | **Çekirdek sözleşmesi**: backend `docs/` altında tür × kural matrisi tek belge (bölüm 2.2'nin teknik hâli); timeline sözleşmesinin koda göre düzeltilmesi (lab olay tarihi, görüntüleme türü ve izni, geç kayıt rozetinin kapsamı) | backend docs | yok | hayır | düşük |
| D1 | **Hata düzeltmesi**: muayene çalışma alanında kesinleşmiş muayeneye gerekçeli reçete (RECORD-008 ile uyum); timeline reçete satırında `addedAfterFinalization` | FE (+ BE timeline 1 satır) | yok | hayır (ADR-013 eki) | düşük |
| D2 | **Tür sözlüğü + ortak arayüz**: `ClinicalRecordKind` eşlemesi (tel değerleri korunur), `IClinicalRecord`; görüntüleme `IClinicScoped` ve değişiklik geçmişine eklenir | backend | yok (hedef; doğrulanmadı) | hayır | düşük–orta |
| D3 | **Kilit politikası tablosu + izin verilen eylemler**: `ExaminationLinkedRecordLock` tablodan okur; `related-summary` (veya muayene detayı) `recordActions` döner; frontend `LOCKED_WHEN_FINALIZED` kaldırılır | backend → FE | yok | hayır (davranış değişmez) | orta |
| D4 | **Ortak iptal ve geç kayıt nesneleri** (mevcut sütunlara eşleme) | backend | yok (hedef; doğrulanmadı) | hayır | orta |
| D5 | **Boşlukların kapatılması**: tedavi iptali, yatış yanlış kayıt iptali, ürünsüz aşı gerekçeli iptal, görüntüleme geç kayıt gerekçesi, Tedavi/Reçete/Aşı RowVersion | backend → FE | **var** (eklemeli sütunlar) | **evet** (AK-2…AK-6) | orta |
| D6 | **Frontend tür kayıt defteri** (`CLINICAL_RECORD_KINDS`: etiket, simge, rota, izin, form bileşeni); `PET_TIMELINE_TYPES`, `PROCEDURE_*`, kayıt geçmişi etiketleri buradan beslenir | FE | — | hayır | düşük |
| D7 | **Ortak form kabuğu** + tür başına alan bölümü; oluşturma ve düzenleme tek bileşen. Tür başına bir alt dilim, en basitten: tedavi → lab → görüntüleme → yatış → reçete → aşı | FE | — | hayır | orta–yüksek (toplam) |
| D8 | (İsteğe bağlı) **Tek "Kayıt ekle" girişi**: muayene çalışma alanı ve hasta kartında tür seçici + ilgili alan bölümü (bölüm 6.2) | FE | — | UX onayı (AK-8) | orta |
| D9 | (Ayrı backlog) Yeni türler: vital ölçümü, prosedür — çekirdeğe uyan tipli aggregate | backend → FE | var | **evet** (AK-9) | ayrı tahmin |

Bağımlılık: D0 her şeyden önce (sözleşme önce). D1 bağımsız, hemen yapılabilir. D3, D2'ye; D7, D6'ya ve D3'e (kilit/eylem bilgisi) bağlı. D5 karar sonrası, D4'ün üzerine. Ağır işler sırayla (bir backend + bir frontend).

### 5.3 Kapsam dışı (bu öneride)

Tek tablo; JSON klinik alanlar; formly/JSON şema kütüphanesi; kayıt kopyalama (RECORD-004), ek dosyanın tüm türlere yayılması (RECORD-003), item rules (EXAM-014), muayene yeniden açma (RECORD-007). Çekirdek bunları kolaylaştırır ama her biri kendi backlog maddesidir.

---

## 6. Dinamik form için frontend önerisi

### 6.1 Şema kaynağı: frontend (alanlar), backend (kurallar ve eylemler)

- **Alan tanımı ve yerleşim frontend'de**, tür başına tipli TypeScript bileşen/tanım olarak. Gerekçe: alanlar sabit ve tipli; backend sözleşmesi zaten alan adlarının, sınırların ve hata kodlarının tek doğruluk kaynağı; Türkçe etiket, yerleşim ve yardım metni frontend'de yaşıyor. Backend'den UI şeması üretmek aynı bilgiyi iki kez tanımlamak olur.
- **Davranışsal kurallar backend'den**: kesinleşmiş muayenede hangi eylemin açık olduğu, gerekçenin zorunlu olup olmadığı, iptal edilebilirlik — `recordActions` benzeri bir yanıtla (D3). Frontend bu kuralları **yeniden yazmaz** (bugünkü `LOCKED_WHEN_FINALIZED` sapması bunun nedenidir).
- **Backend kaynaklı alan şeması yalnız** klinik tanımlı ek alanlar kararı çıkarsa (AK-7): o zaman backend alan tanımı ucu + JSON değer; ek alanlar ortak kabuğun en altında, tipli alanlardan ayrı bölümde çizilir.

### 6.2 Yapı

- `ClinicalRecordFormShell` (ortak kabuk): hasta sahibi/hasta/muayene bağlamı (muayeneden açıldıysa kilitli), aktif klinik, salt okunur kiracı uyarısı, hasta uyarı bandı, kilit/geç kayıt gerekçesi alanı (`recordActions`'a göre), API alan hatası eşleme, kaydet/vazgeç, kayıt geçmişi düğmesi. Bugün her formda tekrarlanan bloklar buraya iner.
- **Tür alan bölümü**: tür başına bileşen (`TreatmentFields`, `LabResultFields` …), tipli `FormGroup` parçası ve eşleyici (bugünkü `*.mapper.ts` ve `*-upsert-validation-parse.utils.ts` korunur, gerekirse ortak yardımcıya çekilir).
- **Tür kayıt defteri** (`CLINICAL_RECORD_KINDS`): `kind`, etiket, simge, detay rotası, okuma/yazma izni, alan bölümü bileşeni, timeline durum etiketleri. Timeline, işlem bölümü ve geçmiş bunu kullanır.
- **Tür değişince** (D8 tek giriş): ortak alanlar (hasta, muayene, tarih) korunur, türe özel alanlar sıfırlanır; kullanıcıya veri kaybı uyarısı yalnız doldurulmuş türe özel alan varsa.
- **Bileşenler** (PrimeNG 22, mevcut kullanım): `p-select` (muayene, yol, modalite), `p-inputnumber` (miktar, vital), `pTextarea`, `app-date-input` (mevcut), ürün seçimi için mevcut ürün arama bileşeni, `p-dialog`/`p-drawer` (çalışma alanında gömülü form), `app-status-tag` (iptal / sonradan eklendi rozeti), `ReasonConfirmDialogComponent` (iptal). Yeni bağımlılık eklenmez.
- **Form API'si:** mevcut desen tipli Reactive Forms; ona uyulur. Angular Signal Forms'un Angular 22'deki kararlılığı **doğrulanmadı**; ayrı değerlendirme konusu.

### 6.3 Muayene şablonu ile ilişki

Şablon alan şeması değil, ön dolum + işlem paketi (bölüm 2.4). Dinamik formla çakışmaz. İleride şablon satırı "kayıt türü + ön değerler" taşıyabilir (ör. lab istemi, kontrol tarihi) — bu EXAM-014 (item rules) ile birlikte ve ayrı kararla ele alınır; şablonun aşıyı satır olarak kabul etmemesi gibi mevcut kurallar korunur.

---

## 7. Açık ürün kararları (kullanıcıya sorulacaklar)

| # | Soru | Öneri (ajan) | Etkisi |
|---|---|---|---|
| AK-1 | Yön olarak B (aggregate'ler kalır, ortak çekirdek) onaylanıyor mu; A (tek tablo) ve C (JSON hibrit) reddediliyor mu? | Evet, B | ADR-043'ün kabulü; dilim D0–D7 |
| AK-2 | Tedavi kaydı gerekçeyle iptal edilebilsin mi (bugün iptal yok, serbest düzenlenir)? | Evet; silme yok, gerekçe 5–500, iptal edilen timeline'da varsayılan gizli, muayene defterinde " (iptal)" ekiyle (reçeteyle aynı) | Migration; defter hücre biçimi |
| AK-3 | Ürünsüz aşı kaydının iptali gerekçeli ayrı eylem olsun mu (bugün durum alanından gerekçesiz "İptal" yapılabiliyor)? | Evet; güncellemede `Cancelled`'a geçiş kapanır | Migration; mevcut iptal aşılar gerekçesiz kalır |
| AK-4 | Görüntülemede "kesinleştirmeden sonra eklendi" kaydına gerekçe zorunlu olsun mu (uygulama ve reçetede zorunlu)? | Evet, yeni kayıtlarda; eskiler gerekçesiz kalır | Migration; FE gerekçe alanı |
| AK-5 | Yatış için "yanlış kayıt" gerekçeli iptali eklensin mi (taburcudan ayrı)? | Evet | Migration; aktif yatış ve oda doluluğu kuralları |
| AK-6 | Kesinleşmiş muayene kilidi tedavi ve aşı için aynı mı kalsın? (ADR-013: kilitli) | Aşı **ürünlüyse** uygulama gibi gerekçeli geç kayıt (gerçek olay + stok düşümü); tedavi kilitli kalsın (ek not yeterli) | ADR-013'e ek; politika tablosunda tek satır |
| AK-7 | Klinik tanımlı ek alanlar (kliniğin kendi alanlarını eklemesi, JSON) şimdi mi? | Hayır, ertele; ihtiyaç gerçek kullanımda görülürse ayrı backlog | C′ seçeneği |
| AK-8 | Muayene çalışma alanında ve hasta kartında tek "Kayıt ekle" girişi (tür seçici + alan bölümü) mi, bugünkü tür başına düğmeler mi? | Tek giriş + son kullanılan türler kısayolu; çalışma alanının işlem bölümü buna dönüşür | UX; D8 |
| AK-9 | "Vital ölçümü" (ör. yatış izlemi için zaman serisi) ve "Prosedür" (hizmet ürünü + ücret önerisi) ayrı kayıt türleri olarak backlog'a alınsın mı, RECORD-006 kapsamı dışında mı tutulsun? | Ayrı backlog maddeleri, P2; çekirdeğe uyan tipli aggregate; vitaller muayenede de kalır, kilo geçmişi kuralı (D2) iki kaynağı birleştirir | Yeni ADR gerekmeyebilir; backlog |

Not: bölüm 2.3'teki reçete kilit sapması (D1) karar değil, hata düzeltmesidir.

---

## 8. Doğrulanmayanlar

- Hiçbir test, build veya tarayıcı denemesi yapılmadı; matristeki davranışlar kod okumasına dayanır.
- EF owned type ile ortak iptal/geç kayıt nesnesinin mevcut sütunlara migration'sız eşlenebileceği **doğrulanmadı** (D4).
- Muayene çalışma alanında kesinleşmiş muayenede "Reçete ekle"nin kapalı göründüğü kod okumasından çıkarıldı; **tarayıcıda doğrulanmadı**.
- Lab kayıtlarında dosya eki backlog notuna (RECORD-003, 2026-10-24 kod incelemesi) dayanır; bu çalışmada kodu okunmadı.
- Üretimde veri olup olmadığı (A/C seçeneğinin taşıma riski) doğrulanmadı.
- DaySmart'ın veri modeli bilinmiyor; yalnız arayüz gözlemi.
- Zorluk tahminleri ölçülmedi.

---

## 9. Kaynaklar

**Ürün deposu:** [WORKFLOW.md](../WORKFLOW.md); [backlog — RECORD-001…008](../backlog/feature-backlog.md#record--klinik-kayıt-yaşam-döngüsü), [EXAM-014](../backlog/feature-backlog.md); [IDEA-026](ideas.md#idea-026--unified-dynamic-record-model); [PATTERN-020](patterns.md#pattern-020--unified-record-with-dynamic-type-forms), [PATTERN-021](patterns.md#pattern-021--item-rule-field-population); [competitors/daysmart.md](../competitors/daysmart.md) (Record lifecycle, 2026-08-02 bölüm 3, Patient Profile — History/Records); [ADR-006](../decisions/ADR-006-patient-timeline.md), [ADR-007](../decisions/ADR-007-imaging-module.md), [ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](../decisions/ADR-015-batch-based-stock-and-registers.md), [ADR-018](../decisions/ADR-018-charge-suggestion-and-service-catalog.md), [ADR-020](../decisions/ADR-020-clinic-staff-centered-patient-card.md), [ADR-031](../decisions/ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md), [ADR-036](../decisions/ADR-036-hbs-ve-e-belge-entegrasyonu.md), [ADR-039](../decisions/ADR-039-birim-is-tek-commit.md), [ADR-040](../decisions/ADR-040-kiraci-izolasyonu-global-filtre.md); [roadmap/AJAN-KUYRUGU.md](../roadmap/AJAN-KUYRUGU.md) (Aşama 4 D1–D5); [P1-TAMAMLAMA-2026-10-30](../roadmap/P1-TAMAMLAMA-2026-10-30.md).

**Backend** (`C:\Vetinity\wt\dalga-4b-be`, HEAD `700a1675`):
- Domain: `src/Backend.Veteriner.Domain/Examinations/{Examination,ExaminationAddendum,ExaminationStatus,ExaminationTextMerge}.cs`, `Treatments/Treatment.cs`, `Prescriptions/{Prescription,PrescriptionItem}.cs`, `Vaccinations/{Vaccination,VaccinationStatus}.cs`, `Administrations/{Administration,AdministrationRoute,AdministrationVoidStockOutcome}.cs`, `LabResults/{LabResult,LabResultStatus}.cs`, `Imaging/{ImagingRecord,ImagingRecordStatus,ImagingModality}.cs`, `Hospitalizations/Hospitalization.cs`, `RecordHistory/*`, `Hbs/*`, `Shared/{CorrectionReason,IClinicScoped}.cs`, `Charges/Charge.cs`, `ChargeSuggestions/ChargeSuggestion.cs`.
- Application: `Examinations/Access/ExaminationLinkedRecordLock.cs`; `Pets/Timeline/*` (`PetTimelineSources.cs`, `ImagingTimelineSource.cs`, `AdministrationTimelineSource.cs`, `PetTimelineConstants.cs`, `PetTimelineRow.cs`); `Pets/Access/PetRecordKind.cs`; `Vaccinations/Commands/Update/UpdateVaccinationCommandHandler.cs`, `Vaccinations/VaccinationStatusDateRules.cs`.
- Infrastructure: `RecordHistory/RecordHistorySaveChangesInterceptor.cs`.
- Sözleşmeler: `docs/RECORD_HISTORY_API_CONTRACT.md`, `docs/PET_TIMELINE_API_CONTRACT.md`, `docs/REGISTERS_API_CONTRACT.md`, `docs/EXAMINATION_TEMPLATE_API_CONTRACT.md`, `docs/CHARGE_SUGGESTION_API_CONTRACT.md`, `docs/ADMINISTRATIONS_API_CONTRACT.md` (§8–9), `docs/PORTAL_API_CONTRACT.md` (§6).

**Frontend** (`C:\Vetinity\wt\dalga-4b-fe`, HEAD `9e6ed293`):
- `src/app/entities/procedure/components/*-form.component.ts`; `src/app/features/{treatments,prescriptions,vaccinations,lab-results,hospitalizations}/pages/*-edit-page/*`; `src/app/features/imaging/*`; `src/app/features/administrations/*`, `src/app/entities/administration/components/*`.
- `src/app/features/examinations/utils/examination-procedures.utils.ts`, `features/examinations/components/examination-procedures-section.component.ts`.
- `src/app/features/pets/utils/pet-timeline.utils.ts`, `features/pets/components/pet-timeline-item.component.ts`, `entities/pet/data/pet-timeline.mapper.ts`.
- `src/app/entities/record-history/*`, `src/app/shared/ui/reason-confirm-dialog/*`, `src/app/shared/forms/*`.
- `package.json` (Angular 22.2, PrimeNG 22.1); `projects/portal/src/app/features/pets/*`.
