# Ajan Kuyruğu

> Koordinatör tarafından tutulur. Kaynak: [Ana plan](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md), sıra: [roadmap.md](roadmap.md). Backend sözleşmesi tek doğruluk kaynağıdır; önce backend, sonra frontend.
> Durumlar: Bekliyor · Karar bekliyor · Geliştiriliyor · Doğrulama bekliyor · Kabul edildi.
> Onay gerektirenler (kullanıcı): migration'ı paylaşılan veritabanına uygulama, main'e merge, push, deploy, ADR gerektiren ürün kararları.

## Aşama 1 — Muayene çalışma alanı, dilim 1 (EXAM-001–005, ADR-005)

**Durum:** Kabul edildi (kullanıcı kararı, 2026-10-10). Üç depoda yerel `main`e fast-forward merge edildi; **push ve deploy yapılmadı** (push izin denetimi tarafından engellendi, kullanıcı elle yapacak). Kabul, kalan manuel senaryolar tamamlanmadan verildi; aşağıdaki "Kabul sırasında doğrulanmamış" listesi açık risktir.

**Son commitler:** Backend `b36eafc`. Frontend `a119e65` → `df2e906` (kayıt toast'ı) → `919ad0e` (kayıttan sonra detaya dönüş) → `ecb60ba` → `576d777` (İptal/Kaydet butonları son bölüm kartının içine; `576d777` ajan raporunda yoktu, sonradan eklenmiş). Frontend son durum: `ng build` hatasız, `ng test` 52/52 (ajan raporu).

**Kabul sırasında doğrulanmamış:** Kullanıcı yalnızca yeni muayene oluşturmayı denedi. Elle denenmeyenler: alan koruma (kısmi PUT), vitaller/`clearVitals`, iki sekmede çakışma, boş bulgular, tarih filtresi (İstanbul/UTC sınırı), randevudan açma ve eski kayıt/export. İptal butonunun görsel rengi tarayıcıda teyit edilmedi. HTTP uçtan uca PUT/409 ve Z'siz tarih `Kind` davranışı doğrulanmadı. ESLint çalışmıyor (karar bekliyor).

| Depo | Dal | Commit | Otomatik doğrulama (raporlanan) |
|---|---|---|---|
| Backend | `feature/muayene-dilim1` | `e1a8a04` (sözleşme + `UpdateExaminationCommandHandlerTests`; önceki commitler dalda) | Application `Examination` filtresi 118/118. Entegrasyon muayene 27/27 ve tam paket sonuçları daha önceki turdan, bu turda yeniden çalıştırılmadı; tam pakette 10 Payments/dashboard testi `main`'de de başarısız (dalla ilgisiz). |
| Frontend | `feature/muayene-dilim1` | `7b6de61` (24 dosya) | `ng build` hatasız; `ng test` 34/34. Lint çalışmadı (ESLint klasörleri ignore ediyor). |

Güncelleme (2026-10-10): Backend `b36eafc` — PUT kısmi güncelleme (metin: null=dokunma, ""=temizle; vital: null=dokunma, `clearVitals:true`=temizle; kural `Examination`/`ExaminationClinicalUpdate` içinde). Domain 26/26, Application muayene 122/122 (backend ajanı); entegrasyon 28/28 **kullanıcı çalıştırdı, ajan doğrulamadı**. HTTP uçtan uca ve Z'siz tarih `Kind` davranışı doğrulanmadı. Frontend `a119e65` — kısmi PUT uyumu (boş metin `""`, `clearVitals`, tek vitali silme formda engelli, docs kopyası backend `b36eafc` ile aynı blob). `ng build` ve `tsc` hatasız, `ng test` 45/45 (frontend ajanı). Doğrulanmadı: tarayıcıda elle deneme, gerçek backend'e HTTP. Açık: ESLint yapılandırması eski biçimde, hiçbir `.ts` dosyasına uygulanmıyor (karar bekliyor); `angular.json` test `styles` boşaltması geçici çözüm (webpack `@/` takma adını çözemiyor). Durum: **Doğrulama bekliyor (manuel test)**.

Push yok, merge yok. `subscription-access.utils.ts` frontend'de commit dışı, working tree'de duruyor.

### Kabul kriterleri (ana plan bölüm 6)
- [ ] Randevudan muayene aç → kaydet → tekrar düzenle; hasta ve randevu ilişkisi (appointmentId) değişmez.
- [ ] A ve B aynı kaydı açar; A kaydeder, B kaydettiğinde çakışma görür ve B'nin metni kaybolmaz.
- [ ] Eski kayıtlar ve export'lar açılır.
- [ ] Muayene CTA'sı create yetkisiyle görünür (reschedule yetkisiyle değil).
- [ ] Tarih filtresi FE–BE uyumlu; İstanbul günü/UTC sınırları doğru.
- [ ] Eski form/eksik sürüm ile güncelleme sessizce ezmez (rowVersion zorunlu).
- [ ] Boş bulgular kaydedilebilir (string API korunur).

### Açık noktalar (backend raporu; doğrulanmadı)
1. PUT'ta gövdede olmayan alanlar (`anamnesis`, `plan`, `assessment`, `notes`, vitaller) `null` geçiriliyor; `UpdateClinicalContent`'in bunu silme mi "dokunma" mı saydığı doğrulanmadı. **Veri kaybı riski; önce netleşmeli.**
2. Sözleşmede eksik: PUT'ta boş `findings`, liste yanıt şekli/sayfalama, `Examinations.RouteIdMismatch`, PUT'ta `complaint`, `Z`siz tarih yorumu, 409 sonrası birleştirme akışı.
3. Sözleşmenin son satırı "migration çalıştırılmadı" diyor; yerel geliştirme DB için artık yanlış.
4. HTTP üzerinden uçtan uca PUT/GET ve 409 denenmedi.
5. Frontend commit'inde `angular.json` (test hedefinde `styles` boşaltıldı) ve sözleşme dosyası var; ikincisi frontend ajanınca değiştirilmedi, dışarıdan senkronlanmış görünüyor.

## Aşama 2 — Hasta bulma, geliş, bekleme ve Bugün (P0)

**Durum:** Geliştirmeye hazır, başlanmadı. Backlog: CHECKIN-006, CHECKIN-007, SEARCH-001 (Planlandı). [ADR-009](../decisions/ADR-009-visit-model-and-arrival-flow.md) kabul edildi (2026-10-10): ayrı `Visit` varlığı; muayene→randevu otomatik tamamlama aynen korunur; `Visits.Correct` izni + zorunlu gerekçe + audit; randevu başına tek muayene kuralı bu işe girmez.

**Sıra:** (1) Backend: Visit modeli ve sözleşme dokümanı önce; geliş, durum geçişi (idempotent, DB düzeyinde benzersiz kural), düzeltme, Bugün sorgusu, `Examination.VisitId`, Query DB read modeli. (2) Frontend: Bugün yüzeyi, randevusuz geliş, muayeneye geçiş (backend sözleşmesi hazır olunca). (3) SEARCH-001 (bağımsız; mikroçip, Türkçe harf, telefon; ayrı worktree'de paralel yürütülebilir). Her iş: feature branch, ayrı commit, gerçek test sonucu; push/merge/migration/deploy kullanıcı onayıyla.

## Aşama 3 — Temel ücret, tahsilat ve bakiye (FIN-001…004, ADR-012)

**Durum:** ADR-012 kabul edildi (2026-10-10). Kod keşfi tamamlandı (backend `docs/FIN_DISCOVERY.md`, dal `feature/fin-kesif`). Kararlar: ücret müşteriye bağlı, geliş/muayene opsiyonel; düzeltme yalnız yönetici düzeyi; yalnız TRY; fazla ödeme reddedilir; eski ödemeler bağlanmamış. Ertelenenler (unutulmayacak): FIN-005 kredi/mahsup, FIN-006 çoklu para birimi, FIN-007 eski ödeme bağlama/açılış bakiyesi, FIN-008 hizmet kataloğu, FIN-009 düzeltme yetkisi gevşetme.

**Dilim sırası:** (0) kırık finans testlerini onar (`PaymentCommandHandlerOutboxEmissionTests` sabit tarih; `PaymentFinanceRolloutAcceptance` ve `DashboardFinanceQueryParity` kullanıcı bağlamı eksik) → (1) `Charge` → (2) `PaymentAllocation`, eşzamanlılık, idempotency → (3) `GET /clients/{id}/balance` → (4) Bugün satırında ücret/ödenen/kalan ve frontend akışı → (5) düzeltme, iptal, audit.

**Aşama 3 ilerleme (2026-10-12):** Backend Dilim 0-2 (`feature/fin-kesif`), Dilim 3 bakiye ucu (`feature/fin-bakiye`) ve frontend Ücret arayüzü (`feature/fin-ucret-fe`) tamam; hiçbiri main'e birleşmedi, push yok. Kullanıcı kararları (Dilim 4 hazırlık): Bugün satırında ziyaret ücret/ödenen/kalan + müşteri toplam borcu (`clientOutstandingAmount`), Veteriner de görür; müşteri listesi "borcu olanlar" filtresi yok. Sıradaki: Bugün alanları (backend), ödeme ekranı (frontend), Dilim 5. **Seed uyarısı:** farklı dallardan `DbMigrator seed` izinleri birbirinden siler (kesinleştirme dalının seed'i `Charges.*` izinlerini sildi); dallar birleşmeden izin seed'i yalnız tek dalda çalıştırılır.

## Aşama 4 — Hasta özeti, timeline, muayene kesinleştirme

**Durum:** Backend keşfi tamamlandı (backend `docs/ASAMA4_DISCOVERY.md`, dal `feature/asama4-kesif`, commit `4f886e4`, push yok). Kararlar (kullanıcı, 2026-10-11): D1 muayene kesinleştirince kilit, düzeltme yalnız ek not (addendum); yeniden açma ve revizyon geçmişi ertelendi ([RECORD-007](../backlog/feature-backlog.md)). D2 kilo geçmişi muayene vitallerinden türetilir. D3 tek özet ucu, bölüm bazlı durum. D4 timeline ilk kapsamı: muayene, tedavi, reçete, lab, uygulanan aşı, yatış, geliş (ödeme Aşama 3 sonrası; iptal/yanlış işaretli varsayılan gizli, filtreyle açılır). D5 eski muayeneler Taslak kalır, otomatik kilitlenmez.

**Dilimler:** Okuma grubu (migration yok): A özet ucu, B timeline, C derin bağlantı verisi, F izin süzmesi. Yazma grubu (migration var): D `Status` + `Finalize`, E addendum. İki grup ayrı dallarda paralel yürüyebilir. Ödeme türü Aşama 3 oturunca timeline'a eklenir.

## Bugün iyileştirmeleri

**Bugün iyileştirmeleri merge (2026-10-10, yerel, push yok):** CHECKIN-009 geri alma, 010 Gelmedi (ADR-010, B yolu), 011 uzun bekleme uyarısı, 012 acil, 013 hayvan uyarıları (ADR-011), 014 benim hastalarım, hekim varsayılan atama, hızlı kayıt keşfedilebilirliği, eylem menüsü. Backend `main` `8e4b0f8`, frontend `main` `6f1904d`. Doğrulama (birleşik main): backend build 0 hata/0 uyarı, Application filtreli 450/450, Domain 89/89; frontend `ng build` (development) hatasız, `ng test` 209/209. Entegrasyon testleri birleşik main'de yeniden çalıştırılmadı (ajan dalında geçti); tam pakette Payments/Dashboard finans parity testleri ve 2 ödeme outbox testi bilinen başarısızlıklar. Tarayıcıda kullanıcı: Bugün, acil, geri al, benim hastalarım (hekim) denendi; Gelmedi, hasta uyarıları, hızlı kayıt ve yeni eylem menüsü tam denenmedi. Sıradaki büyük iş: Aşama 3 (temel ücret/tahsilat/bakiye).

**Sıradaki iş paketi (kullanıcı onayı 2026-10-10, sırayla; tamamlandı, yukarıya bakın):** [CHECKIN-009](../backlog/feature-backlog.md) yanlış geliş geri alma → [CHECKIN-011](../backlog/feature-backlog.md) uzun bekleme uyarısı (yalnız frontend, hemen) → [CHECKIN-010](../backlog/feature-backlog.md) gelmedi (önce tasarım önerisi) → [CHECKIN-012](../backlog/feature-backlog.md) acil işareti → [CHECKIN-014](../backlog/feature-backlog.md) benim hastalarım → [CHECKIN-013](../backlog/feature-backlog.md) hasta uyarı rozetleri (önce veri kaynağı doğrulaması). Ödemeye geçiş kısayolu, sıra bildirimi ve mikroçip okuyucu ilgili aşamalarında kalır (backlog'a yazılmadı). Yeni iş paketi için temiz backend ve frontend oturumları, `main`'den yeni dallarla.

**Merge (2026-10-10, kullanıcı onaylı):** Backend `main` `8c1a55d` (SEARCH-001 + Visit/hekim/Bugün/hızlı kayıt) ve frontend `main` `4e6a14e` (ESLint + Bugün/geliş/hızlı kayıt) yerelde birleştirildi, **push yok**. Birleşik `main` doğrulaması: backend build 0 hata/0 uyarı, Application (Visit/QuickRegister/Arama/Muayene filtresi) 209/209, Domain 53/53; frontend `ng build` hatasız, `ng test` 148/148. Birleşik `main` üzerinde entegrasyon testleri yeniden çalıştırılmadı; tarayıcıda hızlı kayıt ve Bugün akışları kullanıcı tarafından tam denenmedi.

**Durum güncellemesi (2026-10-10, merge öncesi):** Backend Visit dalı `feature/visit-model` tamamlandı (domain 47/47, Application Visit+muayene 141/141, Visit entegrasyon LocalDB 23/23; merge/push yok; sözleşme `docs/VISITS_API_CONTRACT.md`). SEARCH-001 dalı `claude/hopeful-chebyshev-906416` (`047db36`, `0d67bb2`): birim testleri geçti, gerçek SQL Server doğrulaması sürüyor. ESLint dalı `chore/eslint-config` (`ee1e0b7`): lint çalışıyor (39 hata, 5.987 uyarı), merge yok. Hepsi push/merge bekliyor.

### Bilinen eksikler ve takip işleri (unutulmasın)
- **Hekim seçimi/adı (kullanıcı kararı, işleniyor):** Geliş kaydını resepsiyon açacağı için sorumlu hekim seçilebilmeli ve yanıtlarda hekim adı görünmeli. Backend ajanı mevcut hekim listesi kaynağını araştırıyor; randevulu gelişte randevudaki hekim varsayılan.
- **Hızlı müşteri+hasta kaydı (CHECKIN-008, kullanıcı kararı 2026-10-10: telefon zorunlu, "en doğrusu neyse o"):** Önce backend: müşteri+hasta tek işlemli kayıt ucu (yarım kayıt oluşmaz; yinelenen telefon kuralı; `Clients.Create`+`Pets.Create`; Visit ayrı idempotent çağrı). Sonra frontend: geliş diyaloğunda satır içi mini form. Frontend iki çağrıyı sırayla yapma yaklaşımı **iptal** (aynı gün ilk taslakta yazılmıştı, kullanıcı kararıyla değişti).
- **Açık iş göstergesi yok:** Lab/tedavi/reçetede açık-kapalı durumu tutulmuyor. Karar: ilk sürümde göstergesiz çıkılır; ürün tanımı sonra.
- **Randevu outbox olayı:** Muayene randevuyu `Completed` yapınca randevu olayı çıkmıyor. Query DB açıldığında randevu `Scheduled` görünür. Karar: ayrı iş.
- **Query DB read modeli (Visit, arama, mikroçip):** Bayraklar her ortamda kapalı; Bugün ve arama komut DB'den okuyor. Bayrak açılmadan önce read model/projeksiyon/backfill ayrı iş.
- **Yeni `Visits.*` izinleri:** Seeder ile gelir; mevcut özel roller elle almalı (deploy notu).
- **Bugün sorgusu sınırları:** 500 satır sınırı ve gün/saat dilimi sınırları yalnızca birim testle kapsandı.
- **Tam entegrasyon paketinde 18 başarısız test** (Dashboard/Payments/Query parity): Visit'ten bağımsızlığı temiz commit'le karşılaştırılarak doğrulanmadı. Application'daki 2 ödeme outbox testi (`PaymentCommandHandlerOutboxEmissionTests`) Visit öncesi `b36eafc`'de de başarısız (doğrulandı).
- **Arama:** Klinik filtresi yok (Client/Pet'te `ClinicId` yok; ürün kararı bekliyor); randevu/muayene/aşı/ödeme aramaları eski kuralla; Collate davranışı gerçek SQL Server'da doğrulanmadı (sürüyor).
- **ESLint:** 5.605 boş-satır ihlali ve 223 `member-ordering` uyarıya alındı (toplu temizlik ayrı iş); `p` öneki kuralı uyarıda (ürün kararı); `npm audit` uyarısına bakılmadı; lock güncellemesinden sonra `ng build`/`ng test` yeniden çalıştırılmadı; kalan 39 hata küçük temizlik işi.
- **Aşama 1'den devam eden:** Doğrulanmayan manuel senaryolar, `angular.json` test `styles` geçici çözümü, tek vitali silme formda engelli, `PUT /appointments/{id}` Status bypass bulgusu (HTTP ile doğrulanmadı, backlog'a işlenmedi).
- **Kullanıcı eylemleri:** Sızan Gmail uygulama parolası için kullanıcı kararı: önemli değil, iptal edilmeyecek (kabul edilen risk, 2026-10-10). `AddVisits` yalnızca yerel DB'ye (onaylandı), paylaşılan/üretim DB'ye ayrı onayla.

**Ayrı bug (çözüldü, 2026-10-12):** `PUT /appointments/{id}` ile durum değişimi şüphesi gerçek değil; `56a0368` ile kapalı (`EnsureCanApplyStatus`, 400 `InvalidStatusTransition`), entegrasyon testi 14/14. Frontend düzenleme sayfası durum değişimini ayrı uçlarla yapıyor; PUT gövdesinin her durumda mevcut durumu taşıdığı elle denenmedi.

Kabul (ana plan bölüm 7): Randevulu ve randevusuz iki hasta kabul edilir; resepsiyon ve hekim aynı güncel kuyruğu görür; muayeneye geçişte hasta tekrar seçilmez; ödeme eksikliği bakım durumunu yanlış göstermez. Ayrıca: tekrar tıklama iki ziyaret üretmez; randevusuz geliş sahte randevu olarak takvime yazılmaz; arama tenant/clinic filtresini değiştirmez.

## Menü ve genel yapı (karar notu, 2026-10-12)

Kullanıcı, menü ve genel bilgi mimarisinin hâlâ modül listesi (CRUD) görünümünde olduğunu, rakip analizindeki iş akışı odaklı yapıya geçilmesi gerekip gerekmediğini sordu. Seçenekler değerlendirildi (menü dilimini öne çekmek / tüm arayüzü yeniden tasarlamak / plana göre Aşama 8). **Karar: plan korunur, menü ve yapı düzenlemesi Aşama 8'de** (ana plan bölüm 13: ana menü günlük işe odaklı, Tür/Irk/ürün kategorisi Ayarlar > Tanımlar altında, tek Raporlar girişi, eski URL'ler korunur). Aşama 1–7 sırasında yeni sayfalar menüye eklenirken menü büyümesi bilinçli sınırlı tutulur; öne çekme ihtiyacı pilotta menü karmaşasından şikâyet gelirse yeniden değerlendirilir.

## Durum güncellemesi (2026-10-12, akşam)

**Push edildi (kullanıcı):** üç depo `main` (Dilim 4 dahil). Sonrası yerel, push yok.
**Yerel main'e birleşenler:** Backend: Aşama 5 keşif + Dilim 0 (kesinleşmiş muayeneye bağlı tedavi/reçete/aşı kilidi), timeline Visit→`relatedExaminationId`, Aşama 3 Dilim 5 (ücret düzeltme/iptal, ödeme iptali; migration `AddFinanceVoidAndReversal` yerel dev DB'ye uygulandı), Query DB pet sağlık kontrolü düzeltmesi. Frontend: timeline tarih aralığı süzgeci, "Bağlı muayene" bağlantısı, ücret/ödeme düzeltme-iptal arayüzü (`ng test` 538/538, tarayıcıda denenmedi).
**Kararlar:** Aşama 5 D1–D9 önerildiği gibi kabul (backend `docs/ASAMA5_DISCOVERY.md`). Kullanıcı genel yetki verdi: rutin yerel git/DB/API işleri sorulmadan yapılır; ürün kararı, paylaşılan/üretim DB, deploy, push'ta sorulur. Paralel ajan sınırı kullanıcı tarafından gevşetildi (gerekirse 100 dolarlık plana geçilecek).
**Devam eden:** Backend Aşama 5 Dilim 1 stok güvenliği (migration içerir).
**Sırada:** Dilim 2 (Uygulama kaydı) ve Dilim 3 (reçete satırları) paralel; Dilim 6 frontend. Dilim 5 arayüzünün gerçek iptal ile elle denenmesi (TEST kayıtlarla). Visit satırında başlığın da muayeneye bağlanması (ürün tercihi). Pet read model: bayrak açılırken backfill kararı (önerilen: şimdilik dokunma).
**Dev ortamı uyarısı:** `dotnet ef migrations list` bu makinede geçmişi yanlış okur (hepsi Pending); `sqlcmd` ile `__EFMigrationsHistory` doğrulanır, `database update <migration> --connection` kullanılır.

**Test çalıştırma kuralı (ajanlar için, 2026-10-12):** Geliştirirken yalnız ilgili filtre (Domain, Application, ilgili entegrasyon sınıfı); TAM entegrasyon paketi yalnız birleştirmeden önce bir kez. Eşzamanlı LocalDB yükü "CREATE DATABASE failed" üretebilir: tekrar dene, değişiklikten bağımsız olduğunu açıkça yaz. Bilinen kırık: Dashboard/Payments parity, `OperationalListsEndpointPaginationTests`.

**Aşama 8 kararları (kullanıcı onayı 2026-10-13, açıklama sonrası; ertelenenler backlog'da: [UX-007](../backlog/feature-backlog.md) rol bazlı menü, [UX-008](../backlog/feature-backlog.md) kişiye özel bildirim ve onay, [RECORD-008](../backlog/feature-backlog.md) reçete iptali, [SEC-001/002](../backlog/feature-backlog.md) hesap kilitleme ve izin süresi; keşif `docs/ASAMA8_DISCOVERY.md` backend deposunda):** D-M1 menü: günlük işe göre ~16 öğe, 6 grup (Bugün/Özet, Klinik, Para, Stok, Raporlar, Ayarlar > Tanımlar); eski adresler değişmez, yalnız Tür/Irk/Kategori için yeni adres + eski adresten yönlendirme (ürün henüz canlıda değil, yer imi yok; adres değiştirmek gereksiz). D-M2 giriş sonrası: Resepsiyon/Hekim → Bugün, Yönetici → Özet (Bugün yetkisi yoksa Özet). D-N1 açık işler: kaynak kayıtlardan hesaplanan liste (kalıcı bildirim değil; kişiye özel olay bildirimi/hekim onayı sonra ayrı karar). D-O1 örnek klinik: ayrı örnek kiracı (çoklu kiracı geçişi teknik doğrulanacak). Kalan D-M3..M5, D-N2, D-O2..O5, D-T1..T6 ajan önerisiyle işlenir (trial/bildirim/örnek klinik dilimleri açılırken kullanıcıya ayrıca gösterilir).
**Güvenlik incelemesi (2026-10):** Kritik/Yüksek yok; Orta 6, Düşük 7 (`docs/SECURITY_REVIEW_2026-10.md`). O1 muayene related-summary izin süzmesi, O2 Swagger, O4 HSTS/başlıklar/AllowedOrigins, O5 izli appsettings.Development gizleri düzeltilecek; O3 hesap kilitleme (migration) sonra.

**Aşama 9 kararları (kullanıcı onayı 2026-10-13):** [ADR-014](../decisions/ADR-014-pilot-and-production-operations.md) K1–K9 (yönetilen bulut, dakikalar düzeyinde yedek + aylık dönüş provası, pilottan önce KVKK uzmanı, küçük kâğıt/Excel klinik + 2 hafta gölge, alan adlı e-posta hizmeti ve sızan parolanın iptali, Query DB pilotta kapalı, varsayılan yönetici kaldırılır, içe aktarma = müşteri+hasta+aşı geçmişi, pilot kapsamı Aşama 1–3). Hazırlık dilimleri `docs/ASAMA9_READINESS.md` bölüm 5. **Kullanıcı eylemleri:** bulut hesabı, KVKK uzmanı, pilot klinik, alan adı + e-posta hizmeti, sızan Gmail parolası iptali, ödeme sandbox anahtarlarını yenileme.
