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

**Durum güncellemesi (2026-10-10):** Backend Visit dalı `feature/visit-model` tamamlandı (domain 47/47, Application Visit+muayene 141/141, Visit entegrasyon LocalDB 23/23; merge/push yok; sözleşme `docs/VISITS_API_CONTRACT.md`). SEARCH-001 dalı `claude/hopeful-chebyshev-906416` (`047db36`, `0d67bb2`): birim testleri geçti, gerçek SQL Server doğrulaması sürüyor. ESLint dalı `chore/eslint-config` (`ee1e0b7`): lint çalışıyor (39 hata, 5.987 uyarı), merge yok. Hepsi push/merge bekliyor.

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

**Ayrı bug (Aşama 2'yi bekletmez, backlog'a işlenmedi):** `PUT /appointments/{id}` `Reschedule` izniyle gövdedeki `Status` ile `Completed/Cancelled` yapabiliyor görünüyor (koddan çıkarım, HTTP ile denenmedi).

Kabul (ana plan bölüm 7): Randevulu ve randevusuz iki hasta kabul edilir; resepsiyon ve hekim aynı güncel kuyruğu görür; muayeneye geçişte hasta tekrar seçilmez; ödeme eksikliği bakım durumunu yanlış göstermez. Ayrıca: tekrar tıklama iki ziyaret üretmez; randevusuz geliş sahte randevu olarak takvime yazılmaz; arama tenant/clinic filtresini değiştirmez.
