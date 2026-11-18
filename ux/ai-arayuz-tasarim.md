# Yapay zekâ arayüzü tasarım taslağı (2026-11-19)

**Durum:** Taslak, kullanıcı seçimi bekliyor. Kod yazılmadı.
**Kapsam:** Hasta geçmişi özeti (AI-002) ile ortak taslak → onay deseni (AI-009). Desen üç örnekte gösterildi: muayene notunu alanlara ayırma (AI-001), hasta sahibine sade açıklama (AI-003) ve taburcu / evde bakım talimatı (AI-004).
**Dayanak:** ADR-008 (AI yalnız taslak üretir, ayrı menü yok, AI durursa klinik akış sürer), ADR-044 (kota bitince yalnız AI durur), UX ilkeleri 11, 13 ve 14, backend sözleşmesi `docs/AI_HISTORY_SUMMARY_API_CONTRACT.md` (dal `feature/ai-gecmis-ozeti`).
**Taslak:** [`ai-arayuz-taslak/ai-arayuz-taslak.html`](ai-arayuz-taslak/ai-arayuz-taslak.html). Tıklanır, statik bir sayfadır ve veriler uydurmadır.
- Sol alttaki çizgili "Taslak" panelinde önce bölüm (Geçmiş özeti, Muayene notu, Sahibe açıklama, Taburcu talimatı), sonra seçenek (A, B, C) ve durum seçilir.
- Adresler `#G-A-sonuc`, `#M-B-taslak`, `#T-C-taslak` biçimindedir. Sona `-koyu` eklenirse koyu tema açılır. Panelde "Koyu / Açık" düğmesi de var.
- Sayfadaki düğmeler gerçekten çalışır: Geçmişi özetle → yükleniyor → özet. Alanlara ayır → taslak → Kabul et ve forma aktar → Kaydet → kayıtta iz. At, Geri al ve Yeniden düğmeleri de çalışır.
- C seçeneğinde muayene notu penceresinde bir alanın üstüne gelince, nottaki kaynak cümle vurgulanır.

**Ekran görüntüleri** (`ai-arayuz-taslak/`, 1536×730 CSS piksel, başsız Chrome):

| Dosya | Ne gösterir |
|---|---|
| `1536-G-A-ozet.png`, `1536-G-B-ozet.png`, `1536-G-C-ozet.png` | Geçmiş özeti, üç seçenek |
| `1536-G-A-eksik-kapsam-koyu.png` | Yetkisiz tür, sığmayan eski kayıtlar ve atılan madde (koyu tema) |
| `1536-G-A-hizmet-hatasi.png` | Sağlayıcı hatası; hasta kartı etkilenmez |
| `1536-G-B-kota-doldu.png` | Kota doldu: düğme soluk, nedeni altında |
| `1536-M-A-taslak.png`, `1536-M-B-taslak.png`, `1536-M-C-taslak.png` | Muayene notu taslağı, üç seçenek |
| `1536-M-A-forma-aktarildi.png` | Kabulden sonra form, "AI taslağından" işaretleriyle |
| `1536-M-kayitta-iz.png` | Kaydedilmiş muayenede iz |
| `1536-S-B-taslak.png` | Hasta sahibine açıklama, sayfa içi |
| `1536-T-B-taslak.png`, `1536-T-C-taslak.png` | Bakım talimatı, sayfa içi ve pencere |

## Sorun

- AI-002'nin backend'i hazır, ama panelde bir girişi yok. Sonucun nerede ve nasıl görüneceği, kapalı ya da kotası dolmuş klinikte ne olacağı belirsiz.
- Sırada üç özellik daha var (AI-001, AI-003, AI-004). Hepsi "taslak → kullanıcı inceler, düzenler → onay → kayda geçer" akışını kullanacak. Her ekran kendi desenini kurarsa hekim her seferinde yeni bir dil öğrenir. Ayrıca "bu metni ben mi yazdım, makine mi" sorusu kayıtta cevapsız kalır.
- AI hiçbir zaman klinik işi bozmamalı (ADR-008 madde 6). Hata, kota ve kapalı durumlar yalnız AI alanını etkilemeli.

## Ortak ilkeler (üç seçenekte aynı)

### Görsel dil

- **Simge:** `pi pi-sparkles` (PrimeIcons 8.0.2'de var, panel bu sürümü kullanıyor). Yalnız AI girişlerinde ve AI'dan gelen içerikte kullanılır.
- **Renk:** AI için yeni, sakin bir mor ton (`--ai`) eklenir. Bu ton yalnız "makineden geldi, henüz doğrulanmadı" işaretidir: simge, "Taslak" etiketi, kesik çerçeve ve "AI taslağından" çipi. Eylem düğmeleri her zaman ana renktir (teal). Böylece mor, tıklanacak bir şeyi değil, kontrol edilecek bir şeyi anlatır.
- **Kesik çerçeve = kaydedilmemiş.** Taslak metin, mor zeminli ve kesik çerçeveli bir alanda durur. Kullanıcı bir alanı düzenleyince çerçeve düz olur ve alan adının yanında "düzenlendi" yazar.
- **"Taslak — kontrol edin" şeridi** her taslağın başında durur. Tek cümleyle neye dayandığını ve neyi yapmadığını söyler (ör. "bilgi eklemez, tanı ya da doz önermez").

### Görünürlük (`GET /api/v1/ai/status`)

| Durum | Düğme | Gerekçe |
|---|---|---|
| Kullanıcıda `Ai.Use` yok (ör. sekreter) | Hiç görünmez | UX ilkesi 11 |
| `Ai.NotConfigured` ya da `Ai.ClinicNotEnabled` | Hiç görünmez | UX ilkesi 13: açılmamış eklentinin arayüzü görünmez |
| `Ai.ClinicQuotaExceeded` | Soluk; altında "Bu ayın AI kotası doldu · 1 Aralık'ta yenilenir" | Geçici bir durum. Kullanıcı düğmeyi aramasın, nedenini bilsin. |
| `Ai.SystemBudgetExhausted` | Soluk; altında "Yapay zekâ şu an kullanılamıyor" | Sistem bütçesi kliniğe açıklanmaz |
| `Clinics.ClinicSelectionRequired` | Soluk; "Önce klinik seçin" | Seyrek görülür |
| `clinicMonthUsedPercent ≥ 80` | Normal; sonucun altında amber not: "Kliniğin bu ayki AI kullanımı %84…" | ADR-044 madde 7 uyarısı. Düğmenin yanına konmaz, işi bölmez. |

### İstek durumları (yalnız AI alanında gösterilir)

| Durum / kod | Başlık | Metin ve eylem |
|---|---|---|
| Yükleniyor | Dönen simge ve satır iskeleti | "Kayıtlar okunuyor ve özetleniyor… Genellikle birkaç saniye sürer. Bu sırada sayfada çalışmaya devam edebilirsiniz." Vazgeç. |
| `NoRecords` (200) | Özetlenecek klinik kayıt yok | Neden yok olduğunu söyler ve kotanın harcanmadığını belirtir. |
| `Ai.RateLimited` (429) | Kısa sürede çok fazla istek gönderildi | "Bir dakika içinde yeniden deneyebilirsiniz." Yeniden dene düğmesi geri sayımla pasif durur. |
| `Ai.ClinicQuotaExceeded` (429), `Ai.SystemBudgetExhausted` (503) | (istek anında dolarsa) | Görünürlük tablosundaki metin kartta yazar; durum ucu yeniden sorulur, düğme soluklaşır. |
| `Ai.ProviderUnavailable` (503), `Ai.InvalidOutput` (502) | Özet şu an hazırlanamadı | "Hasta kartı ve kayıtlar etkilenmedi; birazdan yeniden deneyebilirsiniz." Tekrar dene. |
| `Ai.ProviderRejected` (502) | Yapay zekâ hizmeti isteği kabul etmedi | Tekrar dene yok; "Sorun sürerse destek ekibine yazın." |
| `Ai.Refused` (422) | Bu kayıtlar için özet üretilemedi | Tekrar dene yok. Kayıtlar her zamanki gibi okunabilir. |

Ton yardımcıdır: kırmızı ve "hata" sözcüğü kullanılmaz. Uyarı simgesi amber renktedir.

### Geçmiş özeti (AI-002)

- **Giriş:** "Geçmişi özetle". Kaydetme düğmesi yoktur, çünkü özet kayda geçmez (`isDraft: true`). Alt satırda "Özet kayda geçmez." yazar. Eylemler: Kopyala (kaynak tarihleriyle) ve Yeniden özetle (kota harcar).
- **Kapsam satırı:** `coverage.fromUtc – toUtc`, `recordCount` ve `recordCounts` (ör. "14 kayıt: 5 muayene · 3 reçete · 4 aşı · 2 laboratuvar") ile `generatedAtUtc` ("Hazırlandı 14:32").
- **Kapsam notları** (gri, küçük), yalnız gerektiğinde gösterilir:
  - `omittedTypes`: "Görme yetkiniz olmadığı için laboratuvar kayıtları özete girmedi."
  - `truncated`: "Geçmiş uzun olduğu için en eski kayıtlar özete sığmadı; özet 11 Ağu 2025'ten başlıyor."
  - `droppedItemCount > 0`: "Kaynağı doğrulanamayan 1 madde özetten çıkarıldı."
- **Bölümler** sözleşmedeki sabit sırayla gelir. Başlığı arayüz verir: Uyarılar, Süren sorunlar, Son muayeneler, İlaçlar, Aşılar, Laboratuvar, Takipler. Uyarılar kırmızı çizgiyle ayrışır. Her başlığın yanında madde sayısı durur.
- **Her maddenin altında kaynak çipleri** vardır: "Muayene · 10 Kas", "Hasta kartı". Çip kayda gider. Aşının gecikmiş olduğu biliniyorsa çip amber olur.

### Taslak → onay deseni (AI-009)

Dört adım vardır. Hepsi aynı görünür ve aynı sözcükleri kullanır.

1. **Hazırla.** Giriş düğmesi işin yanında durur: "Notu alanlara ayır" muayene formunun başında, "Taslak hazırla" ise açıklama ve talimat kartında.
2. **Taslak.** Düzenlenebilir alanlar kesik çerçeveyle gösterilir, en üstte şerit ve altta kaynak satırı ("Kaynak: yatış notları (17–19 Kas), 19 Kas reçetesi…") bulunur.
3. **Karar.** Altta solda **At** (çöp simgeli, metin düğmesi), sağda **Kabul et ve kaydet** (birincil) ve **Yeniden** düğmeleri durur.
   - Atınca toast çıkar: "Taslak atıldı; hiçbir şey kaydedilmedi."
   - **Form içinde (AI-001)** birincil düğmenin adı "Kabul et ve forma aktar"dır. Muayenenin kendi "Kaydet" düğmesi kalır; ikinci bir kayıt yolu açılmaz. Aktarımdan sonra formun üstünde "6 alan AI taslağından dolduruldu… [Geri al]" şeridi görünür.
4. **İz.** Kabul edilen içerik kayıtta "✦ AI taslağından" çipini taşır. Kabulden önce ya da sonra düzenlenmişse çipte "· düzenlendi" yazar.
   - Çipin ipucunda "Dr. Ayşe Kaya 19 Kas 14:36'da kabul etti." yazar.
   - Muayene özetinin başında tek satırlık bir özet de durur.
   - İz sonsuza dek kalır. Hekim metnin her harfini değiştirse de içeriğin AI taslağından başladığı bilinir. Bu dürüst bir kayıttır ve AI-010 denetim metadatasıyla örtüşür.

**AI-001'e özel kurallar:**
- Taslak, notta yazmayanı eklemez. Notta karşılığı olmayan alan "Notta karşılığı yok · boş kalır" diye gösterilir.
- **Formdaki metin siz seçmeden silinmez.** Alan doluysa (ör. randevudan gelen "Kulak kaşıntısı") seçim sunulur: **Sona ekle** (varsayılan) ya da **Yerine yaz**.
- Vital değerler dört ayrı sayı alanına gelir. Mevcut doğrulama kuralları aynen geçerlidir.

**AI-003 ve AI-004 tek bir metin alanıdır.** Kabul edilince ilgili kayıt oluşur:
- AI-004'te bakım talimatı (`care-instructions`) kaydı.
- AI-003'te kayıt yeri açık soru, aşağıya bakın.

Kaydedilmiş metinde Kopyala ve Yazdır düğmeleri durur.

## Seçenekler

| | Ne | İyi yanı | Zayıf yanı |
|---|---|---|---|
| **A · Yan panel** | Sağdan 440 px'lik, sayfayı örtmeyen bir panel açılır ve sayfa sola kayar. Geçmiş özeti tek sütundur. Muayene notunda panelde serbest not, sonra alan taslakları görünür. Açıklama ve talimat da aynı paneldedir. | Tek yer, tek bileşen: dört özellik aynı yerde açılır. Sayfa kullanılabilir kalır; özet muayene formunda da açık tutulabilir. ADR-008'in "gömülü yardımcı" fikrine en yakın seçenektir. | 1536 genişlikte sayfa 800 px'e iner ve iki sütunlu kartlar alt alta düşer. Dar ekranda panel sayfanın üstüne biner. Aktarılan alan ile formdaki yeri arasında göz gidip gelir. |
| **B · Sayfa içi** | AI içeriği işin olduğu yerde, sayfanın bir parçası olarak açılır. Geçmiş özeti eylem çubuğunun altında, tam genişlikte, iki sütunlu bir karttır; düğme "Klinik özet" kartının başlığındadır. Muayene notunda her alanın üstünde "Önerilen" kutusu ve alan başına Kabul / At düğmeleri görünür. Üstte yapışkan bir sayaç ("6 alan önerildi · 0 kabul") durur. Açıklama ve talimat kendi kartında taslak satırı olarak açılır. | En geniş okuma alanı bu seçenektedir. Hekim her alanı yerinde ve tek tek onaylar; "hangi metin nereye gitti" sorusu hiç oluşmaz. Yeni bir kap (panel, pencere) öğrenilmez. | Sayfa uzar ve özet okunurken aşağı itilir. Özet muayene formunda görünmez. Alan alan onay, 6 alanlık notta 6 tık ister (toplu kabul ile 1). Dört özelliğin dört farklı yerleşimi olur. |
| **C · Pencere** | Ortada 920 px'lik bir pencere açılır. Geçmiş özetinde solda bölüm listesi ve kapsam, sağda içerik bulunur; kaynaklar yeni sekmede açılır. Muayene notunda solda serbest not, sağda alanlar durur ve alanın üstüne gelince nottaki kaynak cümle vurgulanır. Açıklama ve talimatta solda kaynak kayıtlar, sağda düzenlenebilir taslak yer alır. | Odaklı ve en okunaklı seçenek. Karşılaştırma (not ↔ alan, kaynak ↔ taslak) en kolay burada yapılır. Bugünkü "Talimat ekle" penceresine en yakın olanıdır. | Pencere sayfayı kapatır: özet açıkken hasta kartı ya da form görülmez. Kaynağa gidince bağlam kaybolmasın diye yeni sekme gerekir. Muayene sırasında yan yana bakmak mümkün değildir. |

**Öneri (karar kullanıcının): A · Yan panel.**
- AI-002'nin değeri "muayene öncesi hızlı hazırlık". Hekim özete muayene formunu yazarken de bakar. Bunu yalnız A sağlar: aynı panel, muayene formunda da hastanın geçmiş özetini açar.
- Dört özellik tek bileşenle gelir. Sonraki AI işleri (AI-005 dikte, hatırlatma metni) için de yer hazırdır.
- B'nin alan alan onayı klinik güvenlik açısından çekicidir. Ama sayfayı uzatır ve her özelliği farklı bir yere koyar.
- C, en okunaklı seçenektir, ama hekimi sayfadan koparır.
- A seçilirse C'den bir parça da alınabilir: muayene notu panelinde bir alana gelince serbest nottaki kaynak cümleyi vurgulamak. Bu, panelin "Serbest not" açılır bölümünde yapılabilir.

## Kodlayacak kişi için notlar

### Frontend (`C:\FrontEnd\veteriner-frontend`)

- **Yer:** Yeni `entities/ai/` (diğer varlıklarla aynı düzen):
  - `models/ai-status.model.ts`, `models/pet-history-summary.model.ts` (sözleşme DTO'su ve VM)
  - `services/ai.service.ts`: `getStatus()` ve `summarizePetHistory(petId)`
  - `utils/ai-error.utils.ts`: kod → başlık, metin ve "tekrar denenebilir mi". Metinler tek yerde durur, yukarıdaki tabloyla aynıdır.
  - `utils/ai-labels.ts`: bölüm `kind` → Türkçe başlık.
- **Durum servisi:** `AiStatusService` (root, `signal`) oturumda bir kez sorar. 429 ya da 503 aldıktan sonra yeniden sorar. Düğmelerin hepsi `aiStatus().isAvailable` ve `unavailableCode`'a bakar; görünürlük kuralı tek yerde yaşar. `Ai.Use` denetimi `AuthService.hasOperationClaim(AI_USE_CLAIM)` ile yapılır; sabit `operation-claims.constants.ts`'e eklenir.
- **Paylaşılan bileşenler** (`entities/ai/components/`):
  - `app-ai-draft-notice`: "Taslak — kontrol edin" şeridi; metin girdi olarak verilir.
  - `app-ai-provenance-chip`: "AI taslağından · düzenlendi" çipi ve ipucu.
  - `app-ai-source-link`: `sources[].type` → rota. Eşleme yeniden yazılmaz; `features/pets/utils/pet-timeline.utils.ts` içindeki tür listesinin `detailPath` alanı kullanılır (Examination → `/panel/examinations`, Treatment → `/panel/treatments`, Prescription → `/panel/prescriptions`, LabResult → `/panel/lab-results`, Vaccination → `/panel/vaccinations`, Hospitalization → `/panel/hospitalizations`). `Pet` → `/panel/pets/:id`. Liste ortak bir yere (`entities/pet` ya da `shared`) taşınmalı ki `entities/ai` `features`'a bağlanmasın.
  - `app-ai-state`: yükleniyor, boş ve hata görünümleri.
  - `app-pet-history-summary`: sonucun gövdesi (kapsam, notlar, bölümler).
- **Seçeneğe göre kap:**
  - **A:** PrimeNG 22 `p-drawer`, `position="right"`, `[modal]="false"`, genişlik 440 px. Sayfa içeriğine sağ boşluk verilir. Açık panelin içeriği root bir `AiPanelService`'te tutulur; böylece hasta kartından muayene formuna geçince özet kaybolmaz. 64rem'den dar ekranda panel tam genişlikte üstte açılır.
  - **B:** Hasta kartında `PetDetailPageComponent` şablonunda eylem çubuğu ile ızgara arasına bir `@if` kart konur. Muayene formunda her `app-form-field`'ın içine bir öneri yuvası eklenir.
  - **C:** `p-dialog`, `[modal]="true"`, 920 px. Kaynak bağlantıları `target="_blank"` ile açılır.
- **Giriş düğmeleri:**
  - Hasta kartında `app-pet-card-header`'ın `[editAction]` yuvası kullanılır (A, C) ya da "Klinik özet" kartının başlığı (B).
  - Muayene formunda `app-page-header`'ın `actions` yuvası kullanılır.
  - Bakım talimatında `app-care-instructions-section`'ın başlığında "Talimat ekle"nin yanına konur.
  - Salt okunur kiracıda (`ro.mutationBlocked()`) yalnız AI-002 görünür. Yazma işi olan diğer üçü görünmez.
- **Kaydedilmemiş taslak:** Taslak açıkken sayfadan çıkılırsa mevcut `unsavedChangesGuard` / `DialogUnsavedChangesDirective` devreye girer. İleti "Kaydedilmemiş AI taslağı var" olur.
- **429 geri sayımı:** Sözleşmede `Retry-After` yok. İstemci 60 saniye sayar; backend başlık eklerse ona geçilir.
- **Kota yenilenme tarihi:** `status`'ta yok. İstemci İstanbul takvim ayının ilk gününü yazar ("1 Aralık'ta yenilenir"). Backend'e `quotaResetsAtUtc` eklenmesi önerilir.
- **Erişilebilirlik:** Panel ve kartlarda `aria-label` bulunur. Yükleniyor durumu `aria-live="polite"` ile duyurulur. Durum hiçbir yerde yalnız renkle anlatılmaz: mor tonun yanında hep "Taslak" ya da "AI taslağından" yazar.
- **Renk:** `vetinity-preset.ts`'e AI tonu eklenir (açık tema `#6d4fc2` / zemin `#f5f2ff` / çerçeve `#c9bbf5`; koyu tema `#c4b5fd` / `#1e1830` / `#4c3f78`). Başka hiçbir yerde kullanılmaz.

### Backend (AI-001, AI-003, AI-004 için gerekenler; önce sözleşme)

AI-002 dışında uç yok. Sözleşme önerisi:

- `POST /api/v1/pets/{petId}/ai/examination-note` (gövde `{ text }`) → `{ isDraft, fields: { visitReason, anamnesis, findings, weightKg, temperatureC, heartRateBpm, respiratoryRatePerMin, assessment, plan, notes }, unmatchedText? }`. Notta olmayan alan `null` döner. Model yalnız notu bölmelidir.
- `POST /api/v1/examinations/{id}/ai/owner-explanation` → `{ isDraft, text, sources[] }`.
- `POST /api/v1/hospitalizations/{id}/ai/care-instruction` → `{ isDraft, text, sources[] }`.
- **Kaynak ve iz:** Kayıt uçları (muayene güncelleme, bakım talimatı oluşturma, açıklama kaydı) isteğe bağlı bir `aiDraft: { feature, generatedAtUtc, edited }` alır. Muayenede bu alan başına bir eşlemedir (`aiDraftFields: { plan: { edited: true }, … }`). Backend bunu kayıtla birlikte saklar ve denetim kaydına yazar (AI-010). Kabul yalnız kullanıcının kendi kaydetme isteğiyle olur; AI ucu hiçbir zaman kayıt yazmaz (ADR-008 madde 3).
- **Hasta adı:** AI-002'de hasta adı modele gönderilmiyor. AI-003 metni ise adı kullanmalıdır ("Karamel'in sağ kulağında…"). Önerim: model `[hasta]` yer tutucusu yazsın, backend yanıtta onu hayvan adıyla değiştirsin. Ad yine sağlayıcıya gitmemiş olur.
- Hata kodları, sınırlar ve kullanım kaydı AI-002 ile aynıdır. Özellik adları `ExaminationNote`, `OwnerExplanation`, `CareInstruction` olur.

## Açık sorular (ürün kararı)

1. **Seçenek:** A, B ya da C?
2. **AI-003'ün kaydı nerede yaşar?** Önerim: muayeneye bağlı ayrı bir "Hasta sahibine açıklama" kaydı (yazdır, kopyala). Hasta sahibi portalında görünmesi ve WhatsApp ile gönderilmesi ayrı bir karar olarak sonraya kalır. Bugün buna karşılık gelen bir alan yok.
3. **AI-001'de serbest not saklansın mı?** Önerim: hayır. Yalnız kabul edilen alanlar ve iz saklansın. Ham not hem gereksiz bir kopya olur hem de KVKK yükünü artırır.
4. **Sekreter:** Backend'de `Ai.Use` sekretere verilmedi. Bakım talimatı (AI-004) sekreterin de yazdığı bir iş ise bu izin AI-004 için yeniden düşünülmeli.

**Rakip:** E-vet ya da Kolayvet görünümü kopyalanmadı. Tasarım panelin mevcut dilinden (kart, alan, şerit, çip) türetildi.
