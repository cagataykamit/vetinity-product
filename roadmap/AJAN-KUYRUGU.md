# Ajan Kuyruğu

> Koordinatör tarafından tutulur. Kaynak: [Ana plan](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md), sıra: [roadmap.md](roadmap.md). Backend sözleşmesi tek doğruluk kaynağıdır; önce backend, sonra frontend.
> Durumlar: Bekliyor · Karar bekliyor · Geliştiriliyor · Doğrulama bekliyor · Kabul edildi.
> Onay gerektirenler (kullanıcı): migration'ı paylaşılan veritabanına uygulama, main'e merge, push, deploy, ADR gerektiren ürün kararları.

## Aşama 1 — Muayene çalışma alanı, dilim 1 (EXAM-001–005, ADR-005)

**Durum:** Kabul edildi (kullanıcı kararı, 2026-10-10). Kod commit'li, iki depoda `feature/muayene-dilim1` dalında; **merge, push ve deploy yapılmadı** (kullanıcı onayı bekliyor). Kabul, kalan manuel senaryolar tamamlanmadan verildi; aşağıdaki "Kabul sırasında doğrulanmamış" listesi açık risktir.

**Son commitler:** Backend `b36eafc`. Frontend `a119e65` → `df2e906` (kayıt toast'ı) → `919ad0e` (kayıttan sonra detaya dönüş) → `ecb60ba` (İptal/Kaydet butonları kart içine). Frontend son durum: `ng build` hatasız, `ng test` 52/52 (ajan raporu).

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

**Durum:** Karar bekliyor. Önce backlog kayıtları ve Visit modeli ADR'si gerekli (WORKFLOW); kod başlamaz.

Kabul (ana plan bölüm 7): Randevulu ve randevusuz iki hasta kabul edilir; resepsiyon ve hekim aynı güncel kuyruğu görür; muayeneye geçişte hasta tekrar seçilmez; ödeme eksikliği bakım durumunu yanlış göstermez. Ayrıca: tekrar tıklama iki ziyaret üretmez; randevusuz geliş sahte randevu olarak takvime yazılmaz; arama tenant/clinic filtresini değiştirmez.
