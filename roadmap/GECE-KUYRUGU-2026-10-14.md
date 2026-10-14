# Gece kuyruğu (2026-10-14) — kullanıcı uyurken sırayla yürütülür

**Yetki (kullanıcı, 2026-10-14):** "Bir sürü kart aç, sırayla yap, ben uyuyacağım, durmanı istemiyorum." Ajanlar arka planda koordinatör tarafından başlatılır (kart/düğme gerekmez). **Yine de yasak:** push, uzak merge, paylaşılan/üretim veritabanına migration, deploy, gizli bilgi, kullanıcı parolası/`seed` komutu (kullanıcı sabah çalıştırır), ürün yönünü kökten değiştiren karar (rakip pratiği varsayılan, gerekçeyle ADR'ye yazılır).

**Veritabanı yetkisi (kullanıcı, 2026-10-14: "seed yapabilirsin", "veritabanını da düzenleyebilirsin"):** bu makinedeki **yerel geliştirme veritabanında** migration uygulama, `seed` çalıştırma ve test verisi düzeltme serbesttir (sunucunun bu makine olduğu her seferinde doğrulanır; bağlantı bilgisi yazdırılmaz; gerçek müşteri verisi yoktur). **Paylaşılan/üretim veritabanı (VPS dahil) kapsam dışıdır ve ayrı açık onay ister.**

**Kurallar:** aynı anda en fazla 3 ajan (RAM ~2 GB). Her biten iş: koordinatör gerçek test çalıştırır, geçerse yerel `main`'e birleştirir; backend ise API yeniden başlatılır; migration yalnız **yerel geliştirme veritabanına** (sunucunun bu makine olduğu kontrol edilerek) uygulanır. Başarısız/tıkanan işte: 1 kez düzeltme denenir, olmazsa kuyrukta işaretlenir ve sıradakine geçilir. Sabah özeti: bu dosyanın durum sütunu + AJAN-KUYRUGU.

## Kuyruk (sırayla; "Dalga" aynı anda başlayabilir)

| # | Dalga | İş | Tür | Bağımlılık | Durum |
|---|---|---|---|---|---|
| Q1 | 1 | Backend D2: Bugün açık işler ve ücretlenmemiş ziyaret (hesaplanan liste) | BE | — | Bekliyor |
| Q2 | 1 | Frontend D3: ziyaret çalışma alanı (İşlemler, yan panel) | FE | — | Bekliyor |
| Q3 | 1 | Backend D4: ücret önerisi + hizmet kataloğu (ADR-018) | BE+MIG | — | Bekliyor |
| Q4 | 2 | Frontend D2: Bugün satırında açık iş çipleri | FE | Q1 | Bekliyor |
| Q5 | 2 | Backend D6: gün sonu raporu (K8, Q1 sorgusunu paylaşır) | BE | Q1 | Bekliyor |
| Q6 | 2 | Frontend D4: Ücretlendir paneli ve ücret bekliyor | FE | Q3 | Bekliyor |
| Q7 | 3 | Backend + Frontend D5: mal kabul (çok satırlı stok girişi) | BE+FE | — | Bekliyor |
| Q8 | 3 | Frontend D6: gün sonu ekranı | FE | Q5 | Bekliyor |
| Q9 | 3 | Hastalar girişi arama-öncelikli (P5), randevudan geliş yolu (K7), yönetici açılışı Bugün (K5) | FE | Q2 | Bekliyor |
| Q10 | 4 | QA tur 4 (yeni akışlar), bulgu raporu | TEST | Q1-Q9 | Bekliyor |

Her işin ayrıntılı talimatı koordinatör oturumunda; sözleşme/ADR çıktıları ilgili depoda.

## Gece günlüğü

- **Q2 Frontend D3 (ziyaret çalışma alanı): TAMAM**, yerel main'e alındı (e0b1f4a). `ng test` 977/977; ekran görüntüsü alınamadı (giriş bilgisi yok, parola girilmedi). Bilinen eksik: aşı satırları yalnız oturumda eklenenler için görünür; backend `related-summary.vaccinations` ve aşı listesi `examinationId` süzgeci gerekir.
- **Q11 Backend muayene aşı özeti (D3 devamı):** başlatıldı (`feat/muayene-asi-ozeti`), sonra frontend tarafı (aşı satırlarının kalıcı görünmesi) kuyruğa eklenecek.
- D3 kararları (rakip pratiği, sorulmadı): "Yeni Muayene" bağlamsız düğmesi de kalktı (Bugün, randevu, hasta eylem çubuğunda duruyor); uygulama kendi bölümünde (iptal akışı); ücretlenmemiş işlem kontrolü ADR-018'e bağlı.
- **Q11 aşı özeti (backend+frontend): TAMAM**, main'de (backend 66a9ae4, frontend 2cc389a).
- **Q1 Backend D2 (Bugün açık işler): TAMAM**, backend main'de (cadf7a2). **Q4 Frontend D2 (çipler, şerit): TAMAM**, frontend main'de (fcbd792), `ng test` 996/996.
- **Q3 Backend D4 (ücret önerisi + hizmet kataloğu): TAMAM**, backend main'de (7a39e79). Opus: model "hesaplanan öneri"den kalıcı `ChargeSuggestion` kaydına çevrildi (gerekçe ADR-018: geçmiş kayıt seli, eşzamanlılık, ileride yeni kaynaklar); bedelsiz ürün kalem doğurmaz. Migration `20261014043646_AddChargeSuggestions` yerel dev DB'ye uygulandı; API yeniden başlatıldı (health/ready 200). Yeni izin yok (seed gerekmez). D2 ile 5 dosyada çakışma Opus ajanıyla çözüldü, testler yeşil.
- **Q6 Frontend D4 (Ücretlendir paneli):** başlatıldı (`feat/ucretlendir-paneli`). **Q5 Backend D6 (gün sonu):** devam ediyor (`feat/gun-sonu-raporlari`).
- Bilinen: tam entegrasyon paketinde `OutboxPending_Http...` testi arada kırılıyor, tek başına geçiyor (kararsız test, kök neden araştırılmadı).
- **Q5 Backend D6 (gün sonu raporları): TAMAM**, backend main'de (5315eef): daily-transactions, cash-summary, end-of-day/open-items; testler yeşil; migration/izin yok.
- **Q6 Frontend D4 (Ücretlendir paneli): TAMAM**, main'de (68aaa05), `ng test` 1050/1050.
- **Q8 Frontend D6 (gün sonu ekranı): TAMAM**, main'de, `ng test` 1064/1064 (birleşik).
- **Q7 mal kabul (backend)** ve **Q9 Hastalar girişi/açılış/randevudan geliş (frontend):** devam ediyor.
- **Q9 Frontend (Hastalar girişi arama-öncelikli, randevudan geliş, açılış): TAMAM**, main'de (166c7f8), `ng test` 1080/1080. K5 (yönetici açılışı Bugün) zaten yapılmıştı.
- **Q7 Mal kabul: TAMAM**, backend main'de (174ebf3, `POST /goods-receipts`, atomik; entegrasyon paketi 1322/0 hata), frontend main'de (`feat/mal-kabul-ekrani`), `ng test` 1090/1090. Migration/izin yok.
- **Q10 QA tur 4:** tarayıcı ve kullanıcı oturumu gerektirir, **kullanıcı bekliyor**. Sabah için önerilen gözle kontrol listesi: Bugün çipleri ve açık işler şeridi; muayene çalışma alanı (+Ekle yan panel, aşı satırları yenileme sonrası); Ücret bekleyenler sekmesi (çevir, ücretsiz say, Ödeme al); Satışlar (hızlı satış, iptal, fiş); Mal kabul (çok satır, düşük stoktan Giriş); Gün sonu kartı; Hastalar arama; randevudan Muayene Oluştur.
- **Gece özeti:** kuyruğun tamamı bitti (Q1-Q9, Q11). Açık notlar: tüm yeni ekranlar yalnız birim/bileşen testleriyle doğrulandı, tarayıcıda görülmedi; bundle bütçe uyarısı (1.08/1.00 MB) kaynağı ölçülmedi; outbox testi kararsız; ESLint worktree'lerde çalışmadı.

## Gece 2. kuyruk: veri içe aktarma (ADR-019, kullanıcı: "rakip pratiği/önerilere göre karar ver")

Outbox testi kararsızlığı çözüldü (backend main `be24108`: test paylaşılan DB'de 100'ü aşan bekleyen mesajlar yüzünden mesajı listede bulamıyordu; yalnız test düzeltildi, ürün kodu temiz).

| # | Dalga | İş | Tür | Bağımlılık | Durum |
|---|---|---|---|---|---|
| Q12 | 1 | İçe aktarma B1: temel (ImportBatch varlıkları, durum makinesi, Imports.* izinleri, migration, iskelet uçlar) | BE+MIG (Opus) | — | Bekliyor |
| Q13 | 2 | B2: okuma ve eşleme (XLSX/CSV, kanonik başlık, şablon üretimi, mapping) | BE | Q12 | Bekliyor |
| Q14 | 3 | B3: doğrulama / kuru çalıştırma (satır kuralları, mükerrer, reminderImpact, hata raporu) | BE | Q13 | Bekliyor |
| Q15 | 4 | B4: uygulama (arka plan işi, sahip bazlı işlem, hatırlatma dışlama, idempotency) | BE (Opus) | Q14 | Bekliyor |
| Q16 | 5 | B5: geri alma ve temizlik | BE (Opus) | Q15 | Bekliyor |
| Q17 | 3+ | F1: frontend sihirbaz (şablon indir → yükle → eşle → doğrula → onay → ilerleme → rapor → geri alma) | FE | Q14 sözleşmesi | Bekliyor |
| Q18 | 6 | T: sentetik pilot verisi, uçtan uca ve performans (yalnız yerel/izole test DB) | TEST | Q16, Q17 | Bekliyor |
- **Q12 B1 temel: TAMAM**, backend main'de (67d1563); migration `AddDataImportBatches` yerel dev DB'ye uygulandı; seed çalıştırıldı (Imports.Read/Manage/Commit, 3 role); API yeniden başlatıldı.
- **Q13 B2 okuma/eşleme: TAMAM** (601b9d6). **Q14 B3 doğrulama/kuru çalıştırma: TAMAM** (79c7716; 25.000 satır ~1,3 sn, N+1 yok). Tam entegrasyon 1402/0 hata.
- **Q17 F1 frontend sihirbaz: TAMAM**, frontend main'de (`feat/import-sihirbaz`), `ng test` 1112/1112. Onay adımı B4 uçları gelene kadar 'henüz etkin değil' gösterir (sahte başarı yok).
- **Q15 B4 uygulama (Opus):** devam ediyor. Sonra B5 (geri alma), T (deneme), ve yeni küçük iş Q19: müşteri mükerrer ad karşılaştırmasını Türkçe duyarlı yap ('AYŞE YILMAZ' = 'Ayşe Yılmaz'; bugün ToLowerInvariant, mükerrer kaçıyor).

## Durdurma (kullanıcı, 2026-10-14 öğleden sonra)

**"Şimdi bunlar bitince yeni görev açma."** 15 dakikalık otomatik tur kapatıldı; yeni görev AÇILMAZ. Yalnızca çalışmakta olan işler (içe aktarma deneme/performans ölçümü) bitince doğrulanır ve birleştirilir. Bekleyen küçük notlar: muayene sayfasında boş bölümlerin gereksiz uzunluğu; kullanıcının QA turundan gelecek bulgular.

## ADR-020 uygulaması (kullanıcı: "başla", 2026-10-14)

- **T içe aktarma deneme/performans: TAMAM**, backend main'de (ff9c425). İki gerçek hata düzeltildi (sahte 503 sağlık kuralı, hatırlatma açlığı). Ölçüm: 5.000 müşteri / 8.000 hasta / 20.000 aşı → doğrulama ~38 sn, uygulama 150–216 sn, geri alma 74–110 sn. Bulgu: backend `docs/IMPORT_PERFORMANCE_FINDINGS.md`. Uygulanmayan öneriler: ikinci parti doğrulaması karesel (~22 sn), mikroçip indeksi (migration onayı ister), 10.000 satır tablo sınırı, partiler ters sırayla geri alınmalı. **Açık karar:** doğrulama senkron mu arka plan mı (öneri: hazırlık >60 sn ise arka plan; frontend zaman aşımı ≥120 sn).
- **S2 muayene alanı hasta bağlamı: TAMAM**, frontend main'de (e39c492). Üç sütun, vital satırı, boş bölüm sıkıştırma. `ng test` 1150.
- **S1 hasta kartı: TAMAM**, frontend main'de (e1a4be0, birleşik `ng test` 1184). Aktif tedavi kuralı tek yerde (`pet-card.utils`). Hasta bazlı yapılacaklar ucu yok (istemcide birleşik; sınır: lab/randevu son 10 kayıt) → ileride `GET /pets/{id}/open-items`. S1 commit'lerinde imza "Opus 5.5" (push yok, kozmetik).
- **S3 tanı/şikâyet sözlüğü backend: TAMAM**, backend main'de (54cfef3). Tam entegrasyon 1451 geçti / 0 hata. Migration `AddClinicalTerms` yerel dev DB'ye uygulandı, seed çalıştı (30 şikâyet + 43 tanı, ClinicalTerms.* izinleri). Sözleşme: backend `docs/DIAGNOSIS_DICTIONARY_API_CONTRACT.md`. Sınırlar: klinik sistem terimini gizleyemez; tohum liste pilotta doğrulanmalı.
- **Devam eden (bu not yazılırken çalışıyor):** S3 frontend (`feat/tani-sozlugu-fe`, worktree `C:\FrontEnd\veteriner-frontend-w-s3`), S5 müşteri kartı (`feat/musteri-karti-s5`, `...-w-s5`), S4 muayene şablonu backend (`feat/muayene-sablonu`, `C:\Users\DELL\source\repos\Veteriner-w-s4`). Bitince: gerçek test → yerel main'e ff birleştirme (frontend ana checkout dalı `feat/muayene-defteri-tek-sutun` ve `main` birlikte ilerletilir) → S4 migration yerel dev DB'ye (`DbMigrator -- all`, sunucu DESKTOP-2U2UUHO doğrulanarak) → API yeniden başlat. Sonra S4 frontend açılır.
- **Bekleyen kullanıcı kararları:** "aktif tedavi" tanımı (takip tarihi mi, tedaviye durum alanı mı); Kesinleştir düğmesi kontrol listesi paneline de konsun mu; rol vurgusu kuralı; doğrulama senkron/arka plan.
- **Altyapı notu:** C: diski dar (~8 GB boş). Biten backend worktree'lerinin bin/obj klasörleri silindi (yeniden üretilir). Asıl yer kaplayan şey aranmadı.
- **Doğrulanmayan:** S1/S2 ekranları tarayıcıda görülmedi (sabit eylem çubuğu, dar ekran); ESLint worktree'lerde çalışmıyor (typescript-eslint bulunamadı).

## ADR-020 tamamlandı (2026-10-14 akşam) — S1..S5 hepsi yerel main'de

- **S3 tanı/şikâyet sözlüğü:** backend 54cfef3, frontend 24559cb + seçici düzeltmeleri (33d7785: arama yalnız aktif; pasif terim yalnız "Sözlüğe ekle" çakışınca "pasif kayıtlı" + Etkinleştir). Sözleşmedeki `includeInactive=false` notu geçerli. Sınır: istemci `clinicalTermNameKey` kopyası sunucu ad kuralını yineliyor (kaldırmak için backend'e tam-ad arama parametresi gerekir).
- **S4 muayene şablonu:** backend 50d7e19 (migration AddExaminationTemplates yerel DB'ye uygulandı; `POST /examinations/{id}/apply-template`; ExaminationTemplates.* izinleri; 3 sistem şablonu), frontend d0ea317 (muayene özet sayfasında "Şablon uygula", Ayarlar>Tanımlar>Muayene şablonları). Sınırlar: ikinci uygulama uyarısı yalnız oturumda (sunucu iz tutmuyor); geri alma ucu yok; ürün seçici 200 ürünle sınırlı; kontrollü/partili ürünlü şablon uçtan uca test edilmedi.
- **S5 müşteri kartı + hayvan durumu + iletişim tercihi:** backend (migration AddPetStatusAndClientContactPreferences yerel DB'ye uygulandı; `PUT /pets/{id}/status`, `GET /pets?status=`, `GET /charge-suggestions?clientId=`, Client.PreferredContactChannel + RemindersOptedOut; vefat kapısı Pets.Deceased; hatırlatma dışlaması; sözleşme docs/PET_STATUS_CLIENT_CONTACT_API_CONTRACT.md K1-K11), frontend cc79bd7 (müşteri kartı, vefat rozeti ve eylemleri, durum süzgeci, iletişim tercihi formu, ücret bekleyenler tek istek).
- **Testler (son):** frontend `ng test` 1301/1301; backend tam entegrasyon 1468 geçti / 0 hata / 2 atlandı (ilk koşuda 1 hata vardı, tekrarlanmadı, test adı yakalanamadı — kararsız test şüphesi, doğrulanmadı).
- **Doğrulanmayan:** tüm yeni ekranlar yalnız birim testleriyle; tarayıcıda gerçek API ile görülmedi. ESLint çalışmıyor (typescript-eslint worktree'lerde bulunamıyor). Bundle bütçe uyarısı (1.09 MB / 1.00).
- **Kullanıcı kararı bekleyen:** (1) vefat edenin açık randevuları otomatik iptal edilmesin, elle iptal — kabul mü; (2) KVKK açık rıza kaydı ayrı model gerekli mi (uzman görüşü yok); (3) hayvan listesi varsayılanı "Tümü" mü "Aktif" mi (şu an Tümü); (4) "aktif tedavi" tanımı / Kesinleştir düğmesi kontrol listesine de; (5) rol vurgusu kuralı; (6) içe aktarma doğrulama senkron/arka plan; (7) çoklu terim ayırıcı (virgül mü satır mı).
- **Küçük bilinen eksikler:** hasta özeti ucu vefat edende gecikmiş aşı işareti hesaplıyor; pano gecikmiş randevu sayısı vefat edenin açık randevusunu sayıyor; üst çubuk global aramada vefat rozeti yok; vefat edenin Yapılacaklar aşı satırları gizlenmiyor; hayvan listesi durum süzgecinin birim testi yok; S1 commit imzaları "Opus 5.5" (push yok).
- **Altyapı:** C: diski dar (~8 GB boş), asıl yer kaplayan şey bulunmadı. Frontend ana checkout dalı `feat/muayene-defteri-tek-sutun` ve `main` birlikte ilerletiliyor; ana checkout'ta başkasına ait commit edilmemiş `subscription-access.utils.ts` değişikliği var (dokunulmadı).
- **Çalışan ajan yok.** Sıradaki iş kullanıcının kararına bağlı: QA turu (kullanıcı), ADR-020 sonrası S-dilimleri yok.
