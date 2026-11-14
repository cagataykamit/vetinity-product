# ADR-043 değerlendirmesi: kayıt modeli boşlukları ve en iyi çözüm yolu — 2026-11-14

Tetikleyen: [ADR-043 taslağı](../decisions/ADR-043-birlesik-klinik-kayit-modeli.md) ve [RECORD-006 araştırması](record-006-birlesik-kayit-modeli-2026-11.md) (2026-11-01, Opus 5.5). Bu belge aynı konunun Fable 5.2 ile ikinci değerlendirmesidir: boşluklar güncel kodda yeniden doğrulandı, AK-1…9 için bağımsız öneri verildi, mevcut öneriden farklar gerekçesiyle gösterildi.

**Yöntem:** yalnız kod ve belge okuma. Backend `C:\Users\DELL\source\repos\Veteriner` `main` `d56a01c5`; frontend `C:\FrontEnd\veteriner-frontend` `main` `9f49fb1c`; ürün deposu `main` `1f2967a`. **Derleme, test ve tarayıcı denemesi yapılmadı; kod yazılmadı.** Büyüklükler kod okumasına dayalı tahmindir, ölçülmedi.

**Bağlam:** pilot klinik canlıda değil, gerçek klinik verisi yok (2026-11-14). Davranış değişikliği ve migration bugün en ucuz hâlinde; eski veri için geçiş kuralı yazmak gerekmiyor.

---

## 1. Kısa sonuç

1. **Yön doğru (B): kayıtlar ayrı ve tipli kalsın.** Tek tablo ve JSON reddi yerinde. İtirazım yöne değil, ADR-043'ün içindeki üç şeye: ortak iptal/geç kayıt nesnesinin EF owned type olarak kurulması (K4), dört sözlüğün tek eşlemede birleştirilmesi (K2) ve frontend form birleştirmesinin (D7) öncelik sırası. Üçü de bugünkü sorunu çözmeden karmaşıklık ekliyor (bölüm 3).
2. **Altı boşluğun dördü doğrulandı, ikisi tespit edildiği gibi değil.** Görüntülemede klinik kapsamı eksik değil, elle kopyalanmış. Paneldeki kilit kopyası artık RECORD-008'in gerisinde değil (2 Kasım'da düzeltilmiş); kopya duruyor.
3. **En ciddi üç sorun:**
   - Tedavi, reçete ve aşı güncellemesinde eşzamanlılık belirteci yok; son kaydeden öncekini sessizce eziyor. Reçete resmî defter ve HBS kaydının kaynağı.
   - Düzeltme yolu türden türe yok ya da denetimsiz: yanlış açılan yatış kaldırılamıyor ve hayvanı yeni yatışa kapatıyor; kesinleşmiş muayeneye bağlı yanlış tedavi hiçbir yolla düzeltilemiyor; ürünsüz aşı gerekçesiz iptal edilip geri alınabiliyor ve bu durum hasta sahibinin portalında görünüyor.
   - Tespit listesinde olmayan yeni bulgu: tedavi, reçete, aşı, lab ve yatış güncellemesinde **hasta değiştirilebiliyor**; kayıt başka hayvana taşınıyor. Eşzamanlılık belirteci olmayan türlerde bu da sessiz.
4. **Önerilen yol:** pilot öncesi dört küçük backend dilimi, her biri tek aggregate, tek migration, tek sözleşme (bölüm 5). Sonra kilit kuralının sadeleştirilmesi ve API'den gelmesi. Frontend form birleştirmesi pilot geri bildirimine kadar bekler.

---

## 2. Boşlukların güncel durumu

Tespit tarihi 2026-11-01. "O tarihten beri bu konuda kod yazılmadı" bilgisi tam doğru değil: frontend `53d7f34e` (2 Kasım) kilit kopyasını RECORD-008'e uydurdu; backend'de `PetRecordKind.ImportedClinicalRecord = 12` eklendi (ADR-048); aşı kaydı `IChangeTracked` oldu (dış API). Aşağıdaki altı boşluğun backend tarafı değişmedi.

| # | Boşluk | Doğrulama | Pilot öncesi şart mı | Migration |
|---|---|---|---|---|
| 1a | Yatış iptal edilemiyor | Doğrulandı | **Evet** | Var (3 sütun) |
| 1b | Ürünsüz aşı gerekçesiz iptal | Doğrulandı; sorun daha geniş | **Evet** | Var (3 sütun) |
| 1c | Tedavi iptal edilemiyor | Doğrulandı | **Evet** | Var (3 sütun) |
| 2 | Görüntülemede geç kayıt gerekçesi yok | Doğrulandı; boşluk saymıyorum | Hayır | Önerimde yok |
| 3 | Tedavi, reçete, aşıda eşzamanlılık belirteci yok | Doğrulandı | **Evet** | Var (tür başına 1 sütun) |
| 4a | Görüntüleme değişiklik geçmişine yazılmıyor | Doğrulandı | Evet (küçük) | Yok |
| 4b | Görüntülemede klinik kapsamı eksik | **Doğrulanmadı: eksik değil**, kopya | Hayır | Yok |
| 5 | Panel kilit kopyası RECORD-008'in gerisinde | **Artık geçerli değil**; kopya duruyor | Hayır | Yok |
| 6 | Tür adları dört sözlükte | Kısmen; ikisi tür sözlüğü değil | Hayır | Yok |
| Ek-1 | Güncellemede hasta değişebiliyor | Yeni bulgu | Karar (AK-10) | Yok |
| Ek-2 | Zaman çizelgesinde reçete "sonradan eklendi" rozeti gelmiyor | Doğrulandı (hata) | Hayır (küçük) | Yok |

### 2.1 İptal boşlukları

**Yatış.** `Domain/Hospitalizations/Hospitalization.cs` içinde iptal yok; komutlar yalnız `Create`, `Update`, `Discharge`. `UpdateDetails` taburcudan sonra reddediyor, yani taburcu edilmiş kayıt tümüyle donuk. Aynı hayvan ve klinik için etkin yatış varken yenisi açılamıyor (`ActiveHospitalizationForPetClinicSpec`, hata `Hospitalizations.ActiveHospitalizationExists`). Sonuç: yanlışlıkla açılan yatışın tek çıkışı sahte taburcudur ve kayıt geçmişte "taburcu edilmiş yatış" olarak kalır. Pilotun ilk haftasında yaşanması olası bir durum.

Çözüm: `Hospitalization.Cancel(kullanıcı, gerekçe, zaman)`; etkin ve taburcu edilmiş kayıtta yapılabilir; iptal edilen kayıt değiştirilemez ve etkin yatış sayılmaz. `POST /hospitalizations/{id}/cancel`, yetki `Hospitalizations.Update` (lab ve reçete iptaliyle aynı desen), `rowVersion` zorunlu. İptal edilen kayıt zaman çizelgesinde varsayılan gizli, listede filtreyle görünür. Etkilenen okuma yolları (kod aramasıyla): etkin yatış kuralı, yatış listesi ve filtre spec'leri, muayene özeti, hasta özeti ve geçmiş özeti, zaman çizelgesi kaynağı. Bağlı bakım talimatı (`CareInstruction.HospitalizationId`) yerinde kalır. Büyüklük: orta (backend), küçük (frontend; `ReasonConfirmDialogComponent` hazır).

**Ürünsüz aşı.** `UpdateVaccinationCommandHandler` durum alanını istemciden olduğu gibi alıyor; `Vaccination.UpdateDetails` her geçişe izin veriyor. Yalnız uygulamaya (stok düşümüne) bağlı aşıda durum kilitli. Ürünsüz aşıda Uygulandı → İptal → Uygulandı → Planlı geçişlerinin hepsi gerekçesiz yapılabiliyor; panelde durum seçeneklerinde "İptal" var (`VACCINATION_WRITE_STATUS_OPTIONS`). Portal iptal edilen aşıyı sahibin geçmiş listesinde gösteriyor (`GetPortalPetVaccinationsQuery`: `Status != Scheduled`). HBS geri kaydı girilmiş aşı iptal edilirse HBS alanları kayıtta kalıyor. Sorun "gerekçe eksik"ten büyük: iptal geri alınabilir bir alan değeri, olay değil.

Çözüm: `Vaccination.Cancel(kullanıcı, gerekçe, zaman)` ayrı eylem; iptal son durumdur. Güncellemede izinli tek durum geçişi Planlı → Uygulandı. Uygulamaya bağlı aşıda uç bugünkü kuralı korur (iptal uygulama iptaliyle olur, `Vaccinations.LinkedToAdministration`). Büyüklük: orta.

**Tedavi.** `Domain/Treatments/Treatment.cs` yalnız `UpdateDetails` taşıyor. Muayenesiz ya da taslak muayeneye bağlı tedavi sınırsız yeniden yazılabiliyor (değişiklik geçmişine düşüyor). Kesinleşmiş muayeneye bağlı tedavi ise `ExaminationLinkedRecordLock.EnsureOpenAsync` ile tümüyle kilitli ve iptali olmadığı için **hiçbir düzeltme yolu yok**; muayene defteri satırında başlığı kalıyor.

Çözüm: `Treatment.Cancel` reçeteyle aynı kural: kesinleşmiş muayenede de yapılabilir, iptal edilen değiştirilemez, defterde " (iptal)" ekiyle kalır. Ek kural: tedaviye bağlı etkin reçete ya da uygulama varken iptal reddedilir; önce onlar iptal edilir. Gerekçe: uygulama iptali stok sonucu seçimi ister (iade ya da zarar); bu karar tedavi iptalinin arkasına gizlenemez. Aşı ile uygulama arasındaki mevcut kuralın aynısıdır. Büyüklük: orta.

Üç iptalde gerekçe kuralı `CorrectionReason` (5–500) olarak kalır.

### 2.2 Görüntülemede geç kayıt gerekçesi

`ImagingRecord.AddedAfterExaminationFinalization` işareti var, gerekçe alanı yok. Lab kaydında işaret de yok, kesinleşmiş muayeneye yeni lab kaydı serbest. Bunu boşluk saymıyorum; gerekçesi AK-4'te. Önerim görüntülemeye gerekçe eklememek, lab kaydına rozet ekleyip iki tanısal türü eşitlemek (migration'sız: rozet, kaydın oluşturma zamanı ile muayenenin kesinleşme zamanından okuma anında türetilebilir; görüntülemedeki `IsFrozenBy` aynı karşılaştırmayı kullanıyor).

### 2.3 Eşzamanlılık belirteci

`RowVersion` olan türler: muayene, uygulama, lab, görüntüleme, yatış (`Infrastructure/Persistence/Configurations/*Configuration.cs`). Olmayanlar: `Treatment`, `Prescription`, `Vaccination`. Güncelleme işleyicileri kaydı okuyup üstüne yazıyor; iki sekme ya da resepsiyon ile hekim aynı kaydı açtığında ilk kaydedenin değişikliği kayboluyor. Reçetede satır listesi (`ReplaceItems`) de aynı yolla eziliyor. Değişiklik geçmişi ezilen değeri saklıyor ama kullanıcıya uyarı yok.

Çözüm: üç türe `rowversion` sütunu; detay yanıtında `rowVersion`; `PUT` ve iptal uçlarında zorunlu; çakışmada 409 `<Tür>.ConcurrencyConflict`. Desen lab ve yatışta hazır (`ExaminationRowVersion.TryDecode`, `SetExpectedRowVersion`, izlenmeyen yükleme spec'i); panelde çakışma mesajı deseni de var. Sözleşme kırıcıdır (`rowVersion` zorunlu olur): backend ve panel birlikte yayınlanır. Canlı kullanıcı yokken yapmak en ucuzu. HBS geri kayıt `PATCH` uçları beklenen sürüm istemez (klinik içerik değil). Büyüklük: tür başına küçük–orta.

### 2.4 Görüntüleme: değişiklik geçmişi ve klinik kapsamı

**Geçmiş: doğrulandı.** `RecordHistorySaveChangesInterceptor.TrackedTypes` yedi tür içeriyor, görüntüleme yok; yakalayıcı ayrıca `IClinicScoped` istiyor ve `ImagingRecord` yalnız `ITenantOwned`. Görüntüleme kaydının tür, tarih, açıklama, klinik not ve muayene bağı değişiklikleri iz bırakmıyor. Panelde görüntüleme detayında "Değişiklikleri gör" yok.

**Klinik kapsamı: eksik değil.** `ImagingRecord`'u okuyan sekiz yerin hepsi klinik kapsamını uyguluyor (liste filtresi, `ImagingRecordReadScope`, güncelleme ve iptal işleyicileri, dosya erişimi, muayene özeti, zaman çizelgesi). Sorun, ortak `ApplyClinicScope` kullanılamadığı için kuralın iki yerde elle yazılmış olması (`ImagingRecordListFilterExtensions.Apply`, `ImagingTimelineSource.ApplyClinicScope`).

Çözüm (tek dilim, migration yok): `ImagingRecord : IClinicScoped`; iki el kopyası ortak yardımcıya döner; `RecordHistoryTypes.Imaging = "imaging"` ve `TrackedTypes` satırı; `GET /imaging-records/{id}/history`; panelde geçmiş düğmesi ve alan etiketleri. Büyüklük: küçük.

### 2.5 Panel kilit kopyası

`features/examinations/utils/examination-procedures.utils.ts` bugün `LOCKED_WHEN_FINALIZED = ['treatment', 'vaccination']` ve reçete için gerekçe notu içeriyor; backend ile uyumlu. "RECORD-008'in gerisinde" tespiti `53d7f34e` ile kapandı.

Kalan sorun kuralın panelde en az beş yerde kopya olması: yukarıdaki dosya, `treatment-form.component.ts` (kesinleşmiş muayene mesajı), `prescription-form.component.ts` (geç kayıt kararı), yatış formu ve düzenleme sayfası (bağ kilidi), lab düzenleme sayfası (kimlik alanları). Tedavi, reçete ve aşı düzenleme sayfaları kilidi hiç bilmiyor; kullanıcı formu doldurup kaydedince 409 alıyor. Kural her değiştiğinde bu kopyalar yeniden sapar. Çözüm bölüm 3 ve AK-6'da; pilot öncesi şart değil.

### 2.6 Tür sözlükleri

Backend'de dört sözlük sayılmış: `PetRecordKind`, `RecordHistoryTypes`, `ChargeSuggestion.SourceType`, `StockMovement.ReferenceType`. İlk ikisi gerçekten kayıt türü sözlüğü. Son ikisi değil: `SourceType` değerleri `Administration`, `ExaminationService`, `ExaminationPackage`; `ReferenceType` değerleri `Administration`, `SaleLine`. Bunlar finans ve stok alanlarının kendi kaynak izleri ve çoğu değer klinik kayıt türü değil; tek ortak değer "Administration". Panelde üç ayrı liste gerçek tekrar: `PET_TIMELINE_TYPES`, `PROCEDURE_KINDS`/`PROCEDURE_LABEL`/`PROCEDURE_ROUTE_SEGMENT`, `RecordHistoryResource`.

Çözüm: backend'de yeni sözlük soyutlaması kurulmaz (bkz. bölüm 3, K2). Panelde tek tür kayıt defteri (etiket, simge, rota, geçmiş kaynağı) pilot sonrası küçük bir dilimdir.

### 2.7 Ek bulgular

**Ek-1, hasta değişimi.** `Treatment.UpdateDetails`, `Prescription.UpdateDetails`, `Vaccination.UpdateDetails`, `Hospitalization.UpdateDetails` ve lab güncellemesi `petId` ve `clinicId` alıyor; düzenleme sayfalarında müşteri ve hasta seçilebiliyor (örnek: `treatment-edit-page.component.ts`). Kayıt başka hayvana taşınabiliyor; değişiklik geçmişinde yalnız iki kimlik değeri görünüyor. Görüntüleme bunu bilinçli kapatmış ("yanlış hasta: iptal + yeni kayıt"). İptal her türde olunca aynı kural hepsine uygulanabilir; karar AK-10.

**Ek-2, reçete rozeti.** `PrescriptionTimelineSource.ToRow` `AddedAfterFinalization` değerini satıra geçirmiyor; muayene özetinde geçiyor. Kesinleşmiş muayeneye sonradan eklenen reçete zaman çizelgesinde rozetsiz. Tek satırlık hata düzeltmesi; karar gerekmez. `docs/PET_TIMELINE_API_CONTRACT.md` aynı dilimde koda göre düzeltilir (bu çalışmada sözleşme metni yeniden okunmadı).

---

## 3. ADR-043 metnine itirazlar

**K4, ortak iptal ve geç kayıt nesnesi EF owned type olmasın.** Taslak, mevcut sütunların owned type'a "migration'sız (doğrulanmadı)" eşlenmesini hedefliyor. Üç somut sorun var: (1) değişiklik geçmişi yakalayıcısı alan farkını sahibin `entry.Properties` listesinden okuyor; owned ya da complex type alanları bu listede yer almaz, iptal alanları geçmişten sessizce düşer (EF davranışı bilgisine dayanır; denenmedi). (2) Sütun adları türden türe farklı (`Voided*` ve `Cancelled*`, `AddedAfterFinalization` ve `AddedAfterExaminationFinalization`); eşleme tür başına özel yapılandırma ister. (3) Kazanç yalnız sekiz satırlık `Cancel` gövdesinin tekrarını kaldırmak. Kod tabanında aynı ihtiyacın çözülmüş deseni var: `HbsEntryRules.Resolve` kuralı tek yerde tutar, aggregate sonucu kendi sütunlarına yazar. Öneri: `RecordCancellationRules` aynı desenle; yeni üç iptal bunu kullanır, eski dördü davranış değişmeden ona geçer. EF eşlemesine dokunulmaz.

**K2, backend'de tek tür eşlemesi kurulmasın.** Bölüm 2.6: dört sözlüğün ikisi tür sözlüğü değil; üç ayrı alanı tek tabloya bağlamak bir ortak değer için bağımlılık yaratır. Gerçek tekrar yakalayıcıdaki yedi satır. Görüntüleme eklenirken sekizinci satır yazılır; yeni soyutlama gerekmez. Paneldeki tür kayıt defteri (K2'nin ikinci yarısı) yerinde.

**K3, politika tablosu ve API'den gelen eylemler: evet, kural sadeleştikten sonra.** Bugünkü beş ayrı davranış (kilitli, gerekçeli geç kayıt, sonuç alanları serbest, öncekiler donuk, yalnız bağ kilitli) tabloya yazılırsa karmaşıklık korunmuş olur. AK-6 önerimle yeni kayıt kuralı ikiye iner (bölüm 4). Sonra API şunu döner: muayene özetinde tür başına `create: Allowed | AllowedWithReason | Blocked`; kayıt detayında `canEdit`, `canCancel` ve kilit nedeni. Panel kopyaları kaldırılır.

**D7, form birleştirme pilot sonrasına.** On iki dosyada yaklaşık altı bin satırlık yeniden yazım kullanıcıya görünen değer üretmiyor ve pilot hazırlığıyla aynı kişileri (ajan sırasını) kullanıyor. Yön doğru; zamanlaması fırsatçı olmalı: bir türün formu yeni alan aldığında (iptal, geç kayıt gerekçesi, `rowVersion`) o türün oluşturma ve düzenleme formu tek bileşene iner. Toplu dilim açılmaz.

**K1, K5, K6:** aynen katılıyorum.

---

## 4. AK-1…9: mevcut öneri ve bu değerlendirmenin önerisi

| # | Soru | Mevcut öneri (Opus, 2026-11-01) | Bu değerlendirme | Fark |
|---|---|---|---|---|
| AK-1 | B yönü (A ve C reddi) | Evet | **Evet** | Yön aynı; K2 daralır, K4 owned type yerine kural yardımcısı, D7 ertelenir |
| AK-2 | Tedaviye gerekçeli iptal | Evet | **Evet** | Ek kural: etkin bağlı reçete ya da uygulama varken reddedilir |
| AK-3 | Ürünsüz aşıda gerekçeli iptal eylemi | Evet | **Evet, genişletilmiş** | İptal son durum; Uygulandı → Planlı geçişi de kapanır |
| AK-4 | Görüntülemede geç kayıt gerekçesi zorunlu | Evet | **Hayır** | Tanısal kayıt; rozet yeter. Lab'a rozet eklenir |
| AK-5 | Yatışa "yanlış kayıt" iptali | Evet | **Evet, pilot öncesi** | Taburcudan sonra da yapılabilir |
| AK-6 | Kesinleşmiş muayenede ürünlü aşıya geç kayıt; tedavi kilitli | Evet | **Farklı** | Tedavi ve aşı (ürünlü, ürünsüz) reçeteyle aynı: gerekçeli geç kayıt |
| AK-7 | Klinik tanımlı ek alanlar | Hayır, ertele | **Hayır, ertele** | Yok |
| AK-8 | Tek "Kayıt ekle" girişi (tür seçici) | Evet, son kullanılan türlerle | **Kısmen** | Tek form yok. Muayene alanında tür düğmeleri kalır; hasta kartına menü |
| AK-9 | Vital ölçümü ve prosedür ayrı tür | Evet, P2 | **Vital evet; prosedür hayır** | Prosedür için yeni tür yerine tedavi kaydı genişler |
| AK-10 (yeni) | Güncellemede hasta ve klinik değişimi kapansın mı | — | **Evet** | Görüntüleme kuralı her türe: yanlış hasta = iptal + yeni kayıt |

### Farkların gerekçesi

**AK-4, görüntülemeye gerekçe eklenmesin.** Geç kayıt gerekçesi ilaç ve reçetede anlamlı: stok düşümü, kontrollü ürün defteri ve HBS kaydı o kayda bağlı; muayene defteri satırı da onlarla değişiyor. Görüntüleme ve lab tanısal kayıt; defterde yer almıyor, stok ve HBS bağı yok. Hekimin muayeneyi kesinleştirip görüntüleri sonra yüklemesi olağan akış; her yüklemede en az beş karakter gerekçe istemek denetim değeri üretmeden sürtünme ekler. Rozet, ekleyen ve zaman zaten kayıtlı. Lab kaydı bugün aynı durumda rozetsiz; tutarlılık oradan sağlanır. ADR-013 de lab için bu ayrımı bilinçli yapmış (Aşama 6 D2).

**AK-6, tedavi ve aşı reçeteyle aynı kurala girsin.** Bugünkü kilit kaydı engellemiyor, yalnız bağı engelliyor: `ExaminationId` isteğe bağlı olduğu için hekim aynı tedaviyi ya da aşıyı muayenesiz oluşturabiliyor. Sonuç daha az izlenebilir kayıt: muayeneyle ilişkisi kopuk, defter satırında yok, gerekçesiz. "Ürünlüyse" ayrımı stok kavramını klinik kurala taşıyor; sahibin getirdiği ya da stokta izlenmeyen aşı da aynı gerçek olaydır. Önerilen sade kural, yeni kayıt için iki sınıf:

- **Tedavi edici kayıtlar** (uygulama, reçete, tedavi, aşı): kesinleşmiş muayeneye zorunlu gerekçeyle "sonradan eklendi" olarak yazılır.
- **Tanısal kayıtlar** (lab, görüntüleme): serbest, rozetli.
- Yatış bağı kilitli kalır (yatış muayenesiz başlar).

Mevcut kayıt için kural değişmez: kesinleşmiş muayeneye bağlı kayıt kilitlidir, düzeltme gerekçeli iptal ve yeni kayıttır; lab sonuç alanları ve yatışın canlı alanları serbest kalır. Bu ADR-013'e ikinci ektir; ADR-013 "en iyi uygulamalarla uyumlu" hedefiyle kabul edilmişti ve reçete için aynı genişleme 2026-10-30'da yapıldı. Maliyet: tedavi ve aşıya iki sütun (işaret, gerekçe); iptal ve `rowVersion` ile aynı migration'a girer.

**AK-8, tek form değil, tek menü.** Rakipteki tek "Record" formu tek varlık modelinin yüzüdür; kendi notumuzda zayıf yönü yazılı (bilgi yoğun, çok alanlı). Muayene çalışma alanında altı tür düğmesi tek tıkla doğru formu açıyor; tür seçici aynı işi iki tıka çıkarır. Tür değişince ortak alanları koruyup özel alanları sıfırlayan tek form, D8'in pahalı ve hataya açık kısmı; karşılığında kazanılan bir şey yok. Hasta kartında "Kayıt ekle" menüsü (türleri listeler, mevcut formu hasta bağlamıyla açar) aynı keşfedilebilirliği menü maliyetiyle verir. Hasta kartında bugün hangi ekleme eylemlerinin bulunduğu bu çalışmada okunmadı; dilim açılırken bakılır.

**AK-9, prosedür ayrı tür olmasın.** RECORD-006'nın şikâyeti parçalı model. Prosedürü ayrı aggregate yapmak, serbest metinli tedavi kaydının yanına ona çok benzeyen dokuzuncu türü ekler. İhtiyaç (hizmet kalemi, ücret önerisi) tedavi kaydına isteğe bağlı hizmet bağı eklenerek karşılanır; gerçek kullanımda görülürse ayrı backlog maddesi olur. Vital ölçümü farklı: sayısal zaman serisi, yatış izlemi için gerçek ihtiyaç ve rakipte ayrı görünüm. P2, yatış izlemiyle birlikte ele alınır.

**AK-10, hasta değişimi kapansın.** İptal her türde olunca "yanlış hasta" için tek ve izlenebilir yol olur. Güncellemede hasta ve klinik değişmez; muayene bağı değişebilir (aynı hasta içinde). Karar gerektirir çünkü bugün çalışan bir düzeltme yolunu kapatır.

---

## 5. Sıra

Önce backend sözleşmesi, sonra panel. Her dilim tek aggregate, tek migration, tek sözleşme belgesi; ağır işler sırayla.

### Pilot öncesi

| # | Dilim | Depo | Migration | Karar | Büyüklük |
|---|---|---|---|---|---|
| P1 | **Yatış iptali** | backend → panel | 3 sütun | AK-5 | Orta + küçük |
| P2 | **Aşı**: `rowVersion`, iptal eylemi, durum geçişi kısıtı (+ AK-6 onaylanırsa geç kayıt) | backend → panel | 4 sütun (+2) | AK-3 (AK-6) | Orta + orta |
| P3 | **Reçete**: `rowVersion`; zaman çizelgesi rozeti (Ek-2) | backend → panel | 1 sütun | Yok | Küçük + küçük |
| P4 | **Tedavi**: `rowVersion`, iptal (+ AK-6 onaylanırsa geç kayıt) | backend → panel | 4 sütun (+2) | AK-2 (AK-6) | Orta + orta |
| P5 | **Görüntüleme**: `IClinicScoped`, değişiklik geçmişi | backend → panel | Yok | Yok | Küçük + küçük |

Notlar:

- İlk backend dilimi `RecordCancellationRules` yardımcısını getirir; sonrakiler kullanır. Mevcut dört iptalin ona geçişi davranış değiştirmez, ayrı küçük commit.
- Her dilimde ilgili sözleşme önce güncellenir (`HOSPITALIZATION_MODEL_API_CONTRACT.md`, `PRESCRIPTION_ITEMS_API_CONTRACT.md`, `IMAGING_API_CONTRACT.md`, `RECORD_HISTORY_API_CONTRACT.md`, `PET_TIMELINE_API_CONTRACT.md`, `PORTAL_API_CONTRACT.md`; tedavi ve aşı için ayrı sözleşme belgesi görmedim, dilim açılırken yazılır).
- `rowVersion` zorunlu hâle geldiği için P2, P3 ve P4'te backend ile panel aynı yayında çıkar.
- P3 ve P5 karar beklemez; hemen başlayabilir. P1, P2, P4 ilgili AK onayıyla.
- AK-10 onaylanırsa hasta ve klinik değişiminin kapanması her türün kendi diliminde yapılır (yatış P1, aşı P2, reçete P3, tedavi P4); lab için ayrı küçük dilim.

### Pilot sonrası

| # | Dilim | Karar | Büyüklük |
|---|---|---|---|
| S1 | Kilit politikası tek yerde; API'den `create` eylemi ve kayıt detayında `canEdit`/`canCancel`; panel kopyaları kaldırılır | AK-6 | Orta + orta |
| S2 | Lab kaydına "sonradan eklendi" rozeti | AK-4 | Küçük |
| S3 | Panelde tek tür kayıt defteri | Yok | Küçük |
| S4 | Hasta kartında "Kayıt ekle" menüsü | AK-8 | Küçük |
| S5 | Form birleştirme, tür tür ve fırsatçı | Yok | Tür başına orta |
| S6 | Vital ölçümü (yatış izlemi) backlog maddesi | AK-9 | Ayrı tahmin |

---

## 6. Kullanıcıdan beklenen kararlar

1. **AK-1:** B yönü onayı ve ADR-043'te K2 ile K4'ün bölüm 3'teki biçimde daraltılması.
2. **AK-2, AK-3, AK-5:** üç iptal eylemi (pilot öncesi).
3. **AK-6:** tedavi ve aşının kesinleşmiş muayeneye gerekçeyle eklenebilmesi. Mevcut öneriden en büyük fark; onaylanırsa sütunlar P2 ve P4'ün migration'ına girer.
4. **AK-4:** görüntülemeye gerekçe eklenmemesi.
5. **AK-10:** güncellemede hasta ve klinik değişiminin kapanması.
6. **AK-8, AK-9:** tek form yerine menü; prosedür türü açılmaması, vital ölçümünün P2 backlog maddesi olması.
7. Ayrıca onay isteyenler: migration'ların paylaşılan ya da canlı veritabanına uygulanması, yayın.

AK-7 için karar değişmiyor (ertelenir).

---

## 7. Doğrulanmayanlar

- Derleme, test ve tarayıcı denemesi yapılmadı; bütün bulgular kod okumasıdır.
- Owned ya da complex type alanlarının değişiklik geçmişi yakalayıcısından düşeceği EF davranışı bilgisine dayanır; denenmedi (EF Core 10.0.14).
- Lab kaydında rozetin migration'sız türetilebileceği tasarım önerisidir; sorgu maliyeti ölçülmedi.
- İptalin etkilediği okuma yolları kod aramasıyla listelendi; açık işler (`OPEN_ITEMS`), hatırlatmalar, raporlar ve veri dışa aktarma yolları tek tek okunmadı. Her dilim kendi etki listesini çıkarmalı.
- Hasta kartındaki mevcut kayıt ekleme eylemleri okunmadı (AK-8).
- `docs/PET_TIMELINE_API_CONTRACT.md` ile kod arasındaki 1 Kasım'da not edilen farklar yeniden karşılaştırılmadı.
- Rakip pratiği DaySmart arayüz gözlemine ve ürün deposundaki notlara dayanır; yeni rakip incelemesi yapılmadı.
