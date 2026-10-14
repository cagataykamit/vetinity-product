# Arayüz iş akışı denetimi (2026-10-14)

**Durum:** Denetim ve öneri. Ürün kararı değildir; kararlar bölüm 6'da öneriyle listelidir, kullanıcı onayı bekler. Kod yazılmadı, hiçbir şey çalıştırılmadı.

**Amaç (kullanıcı):** "Derdim beğenip beğenmemek değil, kliniklerin doğru bir sistemle çalışması. Tasarımımız hatalıysa yeniden düzenleyelim." Rakipten yalnız veri içeriği ve iş kapsamı alınır; görünüm kopyalanmaz ([WORKFLOW](../WORKFLOW.md), [UX ilkeleri](ux-principles.md) madde 19).

---

## 0. Özet

Sistemin parçaları tek tek çalışıyor (Bugün, muayene, ücret, ödeme, stok, parti, defterler). Sorun parçalar arasında: **iş, kayıt türüne göre bölünmüş ekranlara dağılmış; günün akışını bütün olarak yürüten bir yüzey yok.** Menü 19 öğe ve 10'u "kayıt türü listesi". Hasta ve müşteri sayfaları yalnızca okuma ucu; iş yapmak için yeniden Bugün'e dönmek gerekiyor.

En kritik 5 bulgu (ayrıntı bölüm 4):

1. **B-01 Aşı iki kez girilir.** Aşı kaydı stoğa ve partiye bağlı değil; stoktan düşen aşı ayrı "Uygulama" kaydı. Aşı Bilgi Raporu yalnız Uygulama'yı kapsıyor. Hekim ikisini de girmezse ya stok yanlış ya rapor boş.
2. **B-02 Hekim işlemi yapar, ücret kimsenin önüne düşmez.** Hekim ücret ekleyemez (ADR-012), resepsiyon neyin ücretleneceğini muayene/tedavi sayfalarını gezip bulmak zorunda, ücret önerisi ve "ücreti girilmemiş işlem" listesi yok. Unutulan ücret = kaybolan gelir.
3. **B-03 Ücret→ödeme döngüsü.** Ödeme formu "ücret yok" deyince ücret ekranına gönderir; ücret kaydedilince ödemeye dönülmez, ücret listesine düşülür. Bağlam kaybolur.
4. **B-05 Hasta ve müşteri sayfaları iş yaptırmıyor.** Global aramanın vardığı yerde yalnız "Düzenle" var: muayene başlat, randevu al, aşı ekle, yeni hayvan yok.
5. **B-08 Kesinleştirme sırası tuzağı.** "Kesinleştir" en öndeki düğme; kesinleşince tedavi/reçete/aşı/yatış eklenemez ve uyarı diyaloğu bunu söylemiyor.

Önerilen yön (bölüm 5): **Seçenek 2: "Bugün + hasta çalışma alanı" merkezli yapı**, önce küçük düzeltmelerle (Seçenek 1), rol bazlı ayrı menüler (Seçenek 3) pilot geri bildirimine kadar ertelenir. Karar listesi bölüm 6'da, pilot öncesi minimum dilim bölüm 7'de.

---

## 1. Kaynak, yöntem ve sınırlar

**Okunanlar:** `CLAUDE.md`, `WORKFLOW.md`, `ux/ux-principles.md`, `ux/navigation.md`, ADR-004/009/012/013/014/015/016, `roadmap/RAKIP-ANALIZI-2026-10.md`, `roadmap/AJAN-KUYRUGU.md`, ana plan (bölüm 6–14), backlog (UX-006…009, EXAM-010, CHECKOUT-001); backend `docs/ASAMA9_READINESS.md`, `ADMINISTRATIONS_API_CONTRACT.md`, `REGISTERS_API_CONTRACT.md`, `VISITS_API_CONTRACT.md`, `RolePermissionBindings.cs`, `ASAMA8_DISCOVERY.md`; frontend `panel-navigation.ts`, `panel.routes.ts`, tüm `*.routes.ts`, Bugün, muayene, hayvan, müşteri, ücret, ödeme, yatış, lab, stok, uygulama, global arama bileşenleri.

**Sınırlar (önemli):**

- **Yalnız kod ve belge okuma.** Uygulama çalıştırılmadı, tarayıcıda gezilmedi. Tıklama sayıları koddan çıkarım, kullanıcı gözlemi değil.
- Frontend, `C:\FrontEnd\veteriner-frontend` deposunun o anki çalışma ağacından (`feat/muayene-defteri-tek-sutun`; commit dışı tek değişiklik `subscription-access.utils.ts`, dokunulmadı) okundu. Defter ekranları bu dalda var, `AJAN-KUYRUGU.md:118` main'e alınmadığını söylüyor.
- **Klinik pratiği uydurulmadı.** Bölüm 2'deki sıralar belgelerdeki karar ve veri akışından kuruldu; belgelerde dayanağı olmayan her adım **(doğrulanmadı)** ile işaretli. Pilot klinikle doğrulanmalı.
- Roller `RolePermissionBindings.cs` varsayılanlarından okundu: **Yön** = Admin/Owner/ClinicAdmin (ClinicAdmin listesi satır satır okundu, Admin/Owner "aynı operasyonel paket" yorumuna güvenildi), **Hkm** = Veteriner, **Rsp** = Sekreter (resepsiyon). Özel roller ve gerçek kurulumdaki seed doğrulanmadı.
- Rakip bilgisi yalnız `RAKIP-ANALIZI-2026-10.md` içeriği; ekran/görünüm alınmadı.

---

## 2. Kliniğin gerçek günü: 10 senaryo

Her senaryoda: **Kim**, **hangi bilgi**, **hangi sırayla**. Sıra, belge dayanağı olan karar ve veri akışından kuruldu.

### S1. Randevu alma ve randevulu geliş

- **Kim:** Rsp randevu alır; geliş gününde Rsp "geldi" der; Hkm muayeneyi açar.
- **Bilgi:** müşteri, hayvan, tarih/saat, hekim (randevu); geliş zamanı, sorumlu hekim, acil işareti (geliş) — ADR-009, `VISITS_API_CONTRACT.md`.
- **Sıra:** randevu kaydı → geliş günü Bugün'de randevu satırı → "Geldi" (Visit açılır, hekim varsayılan randevudakidir) → bekleme → muayene → bakım tamamlama.
- **Doğrulanmadı:** randevunun kaç gün önceden, kim tarafından, telefonla mı alındığı; hatırlatma süreci.

### S2. Randevusuz geliş (yeni veya kayıtlı müşteri)

- **Kim:** Rsp (veya Hkm, kayıtlı hastada).
- **Bilgi:** hasta bulunur (ad, telefon, hayvan adı, mikroçip) veya yeni müşteri+hayvan (telefon zorunlu, CHECKIN-008); hekim; acil.
- **Sıra:** hasta ara → yoksa hızlı kayıt → geliş (Visit) → sıraya düşer → muayene. Takvime sahte randevu yazılmaz (ADR-009).
- **Doğrulanmadı:** yinelenen müşteri/telefon durumunda sahada ne yapıldığı.

### S3. Muayene + tedavi + reçete + aşı (+ stoktan uygulama)

- **Kim:** Hkm (kayıt), Rsp yalnız okur.
- **Bilgi:** hasta başlığı ve kritik uyarılar; şikâyet/anamnez; bulgu ve vital; değerlendirme; plan. İşlemler: tedavi (başlık, açıklama, takip tarihi), reçete (satırlar, dış reçete stok düşmez), aşı (aşı tanımı, tarih, sonraki tarih), uygulama (ürün, parti, miktar; stok düşer) — ana plan Aşama 1 ve 5, ADR-013.
- **Sıra:** muayene kaydı → işlemler (tedavi, reçete, aşı, uygulama, lab, yatış) → **kesinleştirme en sonda** (kesinleşince tedavi/reçete/aşı/yatış eklenemez, uygulama gerekçeyle eklenir, düzeltme ek notla) → bakım tamamlama.
- **Doğrulanmadı:** hekimin işlemleri muayene sırasında mı sonradan mı girdiği; aşının sahada tek kayıt mı iki kayıt mı sayıldığı (B-01).

### S4. Lab istemi ve bekleyen sonuç

- **Kim:** Hkm ister ve yorumlar; sonucu kim girer **(doğrulanmadı: klinik içi mi, dış lab mı)**.
- **Bilgi:** test adı, bağlı muayene; sonra sonuç metni/yorum. Durum: istendi → sonuç girildi (yorum bekleyen ayrı) → iptal (ana plan Aşama 6).
- **Sıra:** muayeneden istem → hasta ayrılır (sonuç beklerken ziyaret kapanabilir) → sonuç gelince girilir → hekim yorumlar → gerekirse sahip aranır **(doğrulanmadı)**.

### S5. Yatış

- **Kim:** Hkm açar ve taburcu eder; bakım talimatını Hkm girer; Rsp okur.
- **Bilgi:** yatış nedeni, giriş, planlı çıkış, konum, bağlı muayene, bakım talimatı; taburcuda çıkış zamanı.
- **Sıra:** muayene → yatış başlat → günlük bakım talimatı → taburcu → açık borç/sonuç takibi (ana plan Aşama 7).
- **Doğrulanmadı:** günlük yatış rutini (kim, ne sıklıkla kayıt giriyor).

### S6. Ücret, ödeme, borç

- **Kim:** Rsp ücret ve ödeme ekler; düzeltme/iptal yalnız Yön; Hkm yalnız okur (ADR-012 karar 2).
- **Bilgi:** ücret: müşteri (zorunlu), hayvan/geliş/muayene (opsiyonel), açıklama, miktar, birim fiyat (TRY). Ödeme: yöntem, tarih, hangi ücrete ne kadar (tahsis zorunlu), requestId.
- **Sıra:** işlem yapılır → ücret satırları → tahsilat (tam/kısmi) → kalan borç müşteri hesabında → sonraki gelişte tahsilat → gerekirse düzeltme.
- **Doğrulanmadı:** ücretin kim tarafından, hangi tabloya göre belirlendiği; fiyat listesi kullanımı; veresiye pratiği.

### S7. Stok girişi ve kullanım

- **Kim:** giriş Rsp/Yön (`StockMovements.Create`); kullanım Hkm (uygulama).
- **Bilgi:** giriş: ürün, parti (seri/lot no, SKT, firma, fatura no/tarih, miktar), kontrollü sınıf ürünlerde seri ve SKT zorunlu (ADR-015). Kullanım: hayvan, ürün, parti (varsayılan SKT en yakın), miktar.
- **Sıra:** mal gelir → stok girişi (parti kaydı) → klinikte uygulama partiden düşer → düşük stok uyarısı → defterler (aşı, ilaç, narkotik) bu kayıtlardan türer.
- **Doğrulanmadı:** malın kim tarafından teslim alındığı; sayım yapılıp yapılmadığı (sayım ADR-015'te ertelendi).

### S8. Doğrudan ürün satışı (muayenesiz)

- **Kim:** Rsp (ADR-016 karar 9). Hkm şimdilik satış yapmaz.
- **Bilgi:** ürün/parti, miktar, fiyat (satırda düzenlenebilir), müşteri veya "Peşin müşteri", ödeme (Peşin müşteride zorunlu).
- **Sıra (ADR-016):** sepet → parti önerisi → ödeme → tek ücret "Ürün satışı" + stok hareketi. Aşı ve narkotik satılamaz, süresi geçmiş parti engellenir.
- **Durum:** karar kabul edildi, **arayüz ve uç yok** (bölüm 3, B-14).

### S9. Gün sonu ve rapor

- **Kim:** Yön (ve kasadan sorumlu Rsp **(doğrulanmadı)**).
- **Bilgi (belgelerde olan):** ödeme yöntemine göre tahsilat toplamı, müşteri borçları, günün randevu/muayene sayıları, açıkta kalan bakım/lab.
- **Sıra:** günün açıkları (bitmemiş geliş, bekleyen lab) → tahsilat toplamı → borç → defterler/raporlar (aylık).
- **Not:** "Kasa mutabakatı" bilinçli kapsam dışı (ADR-012). Klinik gün sonunda gerçekte ne yapıyor **(doğrulanmadı, pilot klinikle sorulacak)**.

### S10. İkinci geliş: geçmiş, uyarı ve aşı takibi

- **Kim:** Rsp bulur; Hkm geçmişe bakar.
- **Bilgi:** kritik uyarılar, kilo, son geliş/muayene, yapılan ve planlı/gecikmiş aşı, aktif yatış, bakiye; zaman çizelgesi (ana plan Aşama 4, ADR-006).
- **Sıra:** arama → hasta özeti → geçmiş → yeni muayene; aşı hatırlatması e-postayla (gerçek gönderim doğrulanmadı, `RAKIP-ANALIZI` satır 70).

---

## 3. Mevcut sayfa envanteri ve tıklama sayımı

### 3.1 Sayım yöntemi

- Başlangıç: oturum açık, kullanıcı panel açılış ekranında. Açılış ekranı koddan: `Visits.Read` izni olana **Bugün**, yoksa Özet (`FE:core/routing/panel-home.redirect.ts`; `FE:` = `C:FrontEndeteriner-frontendsrcpp`). Yön rolleri `Visits.Read`'e sahip (ClinicAdmin doğrulandı) olduğundan onlar da Bugün'e düşer, ASAMA8 D-M2 "Yönetici → Özet" ile çelişir (B-11).
- **T = tıklama** (menü, bağlantı, düğme, seçim, diyalog onayı). Alana yazmak sayılmaz; "Kaydet" sayılır.
- **G = ekran geçişi** (rota değişimi; diyalog açmak geçiş sayılmaz).
- Sayım, ilgili bileşenin şablonunda düğme/bağlantıyı ve `router.navigate`/`routerLink` hedefini okuyarak yapıldı. Düğme etiketi doğrulanamayan yerler işaretli. **Kullanıcıyla ölçülmedi; alt sınır sayılmalı** (arama, kaydırma, hata, yeniden deneme yok).
- Referans: [UX ilkeleri](ux-principles.md) madde 3: sık işe 2–3 etkileşim. Bu ölçüt "formu açma" ile "işi bitirme"yi ayırmıyor (ana plan bölüm 13 bunu ayırır); aşağıda **işin bitişi** sayıldı.

### 3.2 Envanter

Menü: `FE:core/routing/panel-navigation.ts:187-240` — 19 öğe: Panel 2, Klinik 10, Para 3, Stok 3, Ayarlar 1. Rota kaydı: `features/panel/panel.routes.ts`. Rol sütunu: **okuma / yazma** (bölüm 1'deki kısaltmalar). Tüm sayfalar claim guard'lıdır (yoksa `/notfound`).

| Rota | Menü yeri | Ne yapıyor | Rol (okuma / yazma) |
|---|---|---|---|
| `/panel/today` | Panel › Bugün (rozet: bekleyen) | Günün kuyruğu: randevu+gelen hasta, geldi/başlat/tamamla/gelmedi/acil/düzelt/ödeme al, randevusuz geliş, aktif yatışlar | Rsp,Hkm,Yön / Visits.Create-Update: Rsp,Hkm,Yön; düzeltme: Yön |
| `/panel/dashboard` | Panel › Özet | Sayılar, uyarılar, öncelikli işler, hızlı eylem, düşük stok, 7 gün grafiği, bugünkü randevular, yaklaşan aşılar, son muayene/ödeme | herkes (`Dashboard.Read`) |
| `/panel/appointments` (+`new`, `:id`, `:id/edit`) | Klinik › Randevular | Randevu listesi, oluştur, detay, düzenle, gelmedi, muayene oluştur | Rsp,Hkm,Yön / Create: Rsp,Hkm,Yön; İptal/Gelmedi: Rsp,Yön; Complete: Hkm,Yön |
| `/panel/appointments/calendar` | Klinik › Randevu Takvimi | Takvim görünümü | aynı |
| `/panel/clients` (+`new`,`:id`,`:id/edit`) | Klinik › Müşteriler | Müşteri liste/detay; detayda hayvanlar, randevu, muayene, ödeme özeti, ücretler, ücret ekle | okuma: hepsi / yazma: Rsp,Yön |
| `/panel/pets` (+`new`,`:id`,`:id/edit`,`:id/timeline`) | Klinik › Hayvanlar | Hayvan liste/detay; özet kartı (uyarı, yatış, aşı, kilo, son geliş), geçmiş blokları, zaman çizelgesi | okuma: hepsi / Create: Rsp,Yön; Update: hepsi |
| `/panel/examinations` (+`new`,`:id`,`:id/edit`) | Klinik › Muayeneler | Liste; çalışma alanı (4 bölüm); detay: kesinleştir, ek not, uygulama bölümü, ilgili kayıtlar, tedavi/reçete/aşı/lab/yatış/ödeme başlat | okuma: hepsi / Hkm,Yön |
| `/panel/hospitalizations` (+`new`,`:id`,`:id/edit`) | Klinik › Yatışlar | Liste, başlat, bakım talimatı, taburcu, ödeme oluştur | okuma: hepsi / Hkm,Yön |
| `/panel/vaccinations` (+`new`,`:id`,`:id/edit`) | Klinik › Aşılar | Aşı kayıt/plan listesi (gecikmiş süzgeci) | okuma: hepsi / Hkm,Yön |
| `/panel/lab-results` (+`new`,`:id`,`:id/edit`) | Klinik › Lab sonuçları (rozet: bekleyen) | İstem, sonuç girişi, iptal | okuma: hepsi / Hkm,Yön |
| `/panel/treatments` (+`new`,`:id`,`:id/edit`) | Klinik › Tedaviler | Tedavi liste/detay; detayda uygulama bölümü | okuma: hepsi / Hkm,Yön |
| `/panel/prescriptions` (+`new`,`:id`,`:id/edit`) | Klinik › Reçeteler | Satırlı reçete (dış ilaç stok düşmez) | okuma: hepsi / Hkm,Yön |
| `/panel/charges` (+`new`) | Para › Ücretler | Ücret listesi (müşteri süzgeci), yeni ücret, düzelt/iptal | okuma: hepsi / Create: Rsp,Yön; Correct: Yön |
| `/panel/payments` (+`new`,`:id`,`:id/edit`) | Para › Ödemeler | Ödeme listesi, yeni ödeme (açık ücretlere tahsis), iptal | okuma: hepsi / Create-Update: Rsp,Yön; Correct: Yön |
| `/panel/reports` (+11 alt rota) | Para › Raporlar | Tek giriş, 11 kart: randevu, muayene, aşı, ödeme, borç, 6 defter | claim'e göre kart |
| `/panel/products` (+`new`,`:id`,`:id/edit`,`:id/stock-movements`) | Stok › Ürünler | Katalog; detayda **Stok işlemi** (giriş/çıkış diyaloğu) | okuma: hepsi / Yön |
| `/panel/stocks` | Stok › Stok durumu | Anlık stok, kullanılabilir/süresi geçmiş, düşük stok, dışa aktar | okuma: hepsi |
| `/panel/stock-movements` | Stok › Stok hareketleri | Hareket listesi + giriş diyaloğu | okuma: hepsi / Create: Rsp,Yön |
| `/panel/settings` (+`account`,`subscription`,`clinics`,`organization`,`members`,`invites`,`reminders`,`definitions/*`) | Ayarlar | Hesap, abonelik, klinik, üyeler/davet, hatırlatma, tür/ırk/kategori | karışık (Yön ağırlıklı) |
| `/panel/administrations` | **menüde yok** | Uygulama listesi; yalnız muayene/tedavi detayındaki "Tümü →" ile | okuma: hepsi |

Eksik rota: **satış yok** (`panel.routes.ts` içinde satış rotası aranıp bulunamadı).

### 3.3 Senaryo başına bugünkü sayım

Tüm değerler alt sınır ve koddan çıkarım. "Rsp"/"Hkm" kimin yaptığını gösterir.

| Senaryo | Bugünkü yol | T | G |
|---|---|---|---|
| S1 randevulu geliş (Rsp) | Bugün › **Geldi** › diyalog kaydet | 2 | 0 |
| S1 randevu al | Randevular (veya Özet › Yeni Randevu) › form › kaydet | 2 | 1–2 (kayıt sonrası hedef doğrulanmadı) |
| S2 randevusuz, kayıtlı hasta | Randevusuz geliş › ara+seç › kaydet | 3 | 0 |
| S2 randevusuz, yeni müşteri+hasta | Randevusuz geliş › Yeni müşteri ve hasta ekle › mini form kaydet (geliş otomatik açılır) | 3 | 0 |
| S3 muayene kaydı (Hkm) | Bugün › Muayene aç › form kaydet | 2 | 2 (`/examinations/new` → detay) |
| S3 + tedavi | Tedavi Oluştur › kaydet › "Bağlı muayene" ile dönüş | 3 | 3 |
| S3 + reçete | Reçete Oluştur › kaydet › "Bağlı muayene" ile dönüş | 3 | 3 |
| S3 + aşı | Aşı Oluştur › kaydet › **dönüş bağlantısı yok** (menü/tarayıcı geri) | ≥4 | ≥3 |
| S3 + stoktan uygulama | Muayene detayı › Uygulama ekle › kaydet (diyalog) | 2 | 0 |
| S3 kesinleştir + bakım tamamla | Kesinleştir › onay; Bugün'e menüyle dön › Tamamla | 4 | 1 |
| **S3 tam muayene** (muayene+tedavi+reçete+aşı+1 uygulama+kesinleştir+tamamla) | toplam | **≈ 18** | **≈ 12** |
| S4 lab istemi | Lab İstemi Oluştur › kaydet | 2 | 2 |
| S4 sonuç girişi | Lab sonuçları (rozet) › satır › sonuç gir › kaydet | 4 | 3–4 |
| S5 yatış başlat | Yatış Başlat › kaydet | 2 | 2 |
| S5 taburcu | Bugün › Yatış detayı › Taburcu et › diyalog kaydet | 3 | 1 |
| S6 tek kalem ücret (Rsp) | Ücretler › Yeni Ücret › müşteri/hayvan/geliş seç › kaydet (düşer `/charges`) | 3 | 3 |
| S6 ödeme (ücret var) | Bugün › ⋯ › Ödeme al › tutar › kaydet | 3 | 2 |
| S6 ödeme (ücret yok) | ödeme formu › "ücret ekleyin" › ücret kaydet › **ödemeye dönmez**, Bugün'e dön › ⋯ › Ödeme al › kaydet | ≈ 8 | ≈ 6 |
| S7 stok girişi | Ürünler › ürün › Stok işlemi › diyalog kaydet; veya Stok hareketleri › giriş diyaloğu (düğme etiketi doğrulanmadı) | 3–4 | 1–2 |
| S8 doğrudan satış | **yok**; ücret elle yazılır, stok ayrı çıkış hareketiyle düşürülür (türler doğrulanmadı) | ≥ 7 | ≥ 3 |
| S9 gün sonu | Raporlar › Ödeme Raporu › tarih; Borç Raporu için tekrar | ≥ 4 | ≥ 4 |
| S10 ikinci geliş | Ara › sonuç › hayvan özeti › Zaman çizelgesi | 4 | 2 |

**Okuma:** tek tek işlemler 2–3 etkileşim hedefine yakın, ama **bir muayenenin bütünü ≈ 18 tıklama ve ≈ 12 ekran geçişi**; bunun çoğu "forma git, kaydet, geri dön" döngüsü. Yük, tek tek tıklamadan çok geçişlerin sayısında ve dönüş yolunun eksikliğinde.

---

## 4. Bulgular

Şiddet: **Kritik** = veri/gelir kaybı veya yanlış kayıt riski; **Yüksek** = günlük işi belirgin yavaşlatır veya yanlış yönlendirir; **Orta** = tutarsızlık/bağlam kaybı; **Düşük** = kozmetik/keşfedilebilirlik. Kanıt yolları kısa biçimde: `FE:` = `C:\FrontEnd\veteriner-frontend\src\app\features\`, `BE:` = `C:\Users\DELL\source\repos\Veteriner\`.

### 4.1 Kritik

**B-01 Aşı iki kez girilir (çift giriş).**
- Aşı kaydı (`Vaccination`) aşı tanımı, tarih, sonraki tarih taşır; ürün, parti, stok yok. Stoktan düşen aşı **ayrı** bir Uygulama kaydı. Aşı Bilgi Raporu yalnız stoktan düşen uygulamaları kapsar.
- Kanıt: `BE:docs/REGISTERS_API_CONTRACT.md:344`, `BE:docs/ADMINISTRATIONS_API_CONTRACT.md:5,180` (D6: aşıda stok tüketimi yok); form alanları `FE:vaccinations/pages/vaccination-new-page/…component.ts` (müşteri, hayvan, durum, tarihler, not; ürün yok).
- Etki: S3, S7, S10. Hekim yalnız aşı kaydı girerse hatırlatma çalışır ama stok ve aşı defteri eksik; yalnız uygulama girerse hatırlatma/aşı takvimi eksik.
- Doğrulanmadı: sahada iki kaydın birlikte girileceği (koddan çıkarım); aşı defterinin yasal geçerliliği (ADR-015 madde 5).

**B-02 Ücret, işlemi yapanın değil yazanın önüne düşer ve önerilmez.**
- Hkm `Charges.Create` iznine sahip değil (ADR-012 karar 2). Rsp neyin ücretleneceğini bulmak için muayene/tedavi/uygulama sayfalarını gezmek zorunda; "ücreti girilmemiş işlem" listesi yok; ücret formu manuel (açıklama, miktar, birim fiyat) ve ürün/hizmet kataloğuna bağlı değil (FIN-008 ertelendi). Ana plan Aşama 5 madde 6 ("ücret satırı işlemden önerilebilir") ve uygulama sözleşmesindeki "ücret önerisi Dilim 5" **yapılmadı**.
- Kanıt: `BE:src/…/Auth/RolePermissionBindings.cs:376-443` (Veteriner'de `Charges.Read`, `Charges.Create` yok); `FE:charges/pages/charge-new-page/…component.ts` (alanlar: müşteri, hayvan, geliş, muayene, açıklama, miktar, birim fiyat); frontend'de ücret önerisi aranıp bulunamadı; `AJAN-KUYRUGU.md:73` (açık iş göstergesi yok).
- Etki: S3, S6, S9. Unutulan ücret görünmez; gün sonu raporu "ücretlenmemiş"i göstermez.

### 4.2 Yüksek

**B-03 Ücret → ödeme döngüsü.** Ödeme formu açık ücret yoksa "ücret ekleyin" bağlantısı verir ve müşteri+geliş bağlamını taşır; ücret kaydedilince `/panel/charges?clientId` listesine düşer, ödemeye dönülmez. Ücret listesinde "Ödeme al" yok.
- Kanıt: `FE:payments/pages/payment-new-page/…:98-99,244-245`; `FE:charges/pages/charge-new-page/…:307`; `FE:charges/pages/charges-list-page/…` (satır eylemleri yalnız Düzelt/İptal et).
- Etki: S6. Ek: Bugün'den ödemeye geçiş ⋯ menüsünün içinde (`FE:visits/pages/today-page/…:792,874-876`), yani en sık para eylemi 2 tık derinde.

**B-04 Muayene detayında "Ödeme Oluştur" claim kontrolü yok (UX ilkesi 11 ihlali).** Düğme yalnız `Examinations.Update` ile görünür; Hkm'de `Payments.Create` yok, tıklayınca rota guard'ı `/notfound`'a atar. Yatış detayı aynı düğmede doğru kontrol yapıyor.
- Kanıt: `FE:examinations/pages/examination-detail-page/…:179-191` ve `:690-692` (yalnız EXAMINATIONS claim'leri); `FE:payments/routes/payments.routes.ts:25-29`; `FE:hospitalizations/pages/hospitalization-detail-page/…:110-113` (doğru örnek); bindings (Hkm'de Payments.Create yok).
- Etki: S3, S6 (Hkm). **Küçük hata, doğrudan düzeltilebilir** (WORKFLOW).

**B-05 Hasta ve müşteri sayfaları "ölü uç".** Global arama (üst çubuk) hayvan/müşteri detayına gider. Hayvan detayında tek eylem "Düzenle"; müşteri detayında "Ücret ekle" dışında eylem yok: muayene başlat, geldi, randevu al, aşı/lab ekle, müşteriye yeni hayvan eklemek yok. Hayvan eklemek için Hayvanlar › Yeni Hayvan, müşteri yeniden aranıp seçilmeli.
- Kanıt: `FE:pets/pages/pet-detail-page/…:66-91`; `FE:clients/pages/client-detail-page/…` (`pets/new`, `appointments/new`, `examinations/new` hedefi aranıp bulunamadı); `FE:pets/pages/pet-new-page/…:70-71` (müşteri alanı elle seçilir); `FE:layout/component/app-global-search.component.ts:190-191` (sonuç yalnız detay rotası).
- Etki: S2, S10. UX-006'nın amacı "navigasyon maliyetini düşürmek"; arama sonrası iş başlatılamıyor.

**B-06 "Tümü →" bağlantıları bağlamı atar.** Hayvan, müşteri ve muayene detaylarındaki "Tümü →" bağlantıları filtresiz genel listeye gider; liste sayfaları `petId`/`clientId` sorgusunu okumuyor (yalnız Ücretler `clientId`, Aşılar `overdue`).
- Kanıt: `FE:pets/pages/pet-detail-page/…:182,219,253,287,321,356,391`; `FE:clients/pages/client-detail-page/…:106,137,176,213`; liste sayfalarında `queryParamMap` taraması.
- Etki: S10, S3. UX ilkesi 4–6 ("bağlam korunmalı").

**B-07 İşlem kaydedince muayeneye dönüş yok; aşıda dönüş bağlantısı da yok.** Tedavi, reçete, aşı, lab, yatış formları kayıt sonrası kendi detayına gider; muayeneye dönüş detaydaki "Bağlı muayene" bağlantısıyla (tedavi, reçete, lab, yatış var). **Aşı detayında yok.**
- Kanıt: `FE:treatments/…/treatment-new-page/…:344`, `FE:vaccinations/…/vaccination-new-page/…:456`; bağlantı: `treatment-detail…:129`, `prescription-detail…:106`, `lab-result-detail…:109`, `hospitalization-detail…:171`; aşı detayında `/panel/examinations` bağlantısı aranıp bulunamadı.
- Etki: S3 (≈12 geçişin nedeni). EXAM-010 "muayene sırasında hızlı erişim" bu haliyle yarım.

**B-08 Kesinleştirme sırası tuzağı.** "Kesinleştir" muayene detayındaki ilk düğme. Kesinleşince tedavi/reçete/aşı eklenemez, yatış muayeneye bağlanamaz; yalnız uygulama gerekçeyle eklenir. Onay diyaloğu içeriğin değişmeyeceğini söyler ama bağlı kayıtların eklenemeyeceğini söylemez; eksik kalan kalem de kontrol edilmez. Kilit mesajı ancak kesinleştikten sonra görünür.
- Kanıt: `FE:examinations/pages/examination-detail-page/…:86-95,148-151`; `FE:examinations/components/examination-finalize-dialog.component.ts:25-28`; ADR-013.
- Etki: S3. Yanlış sırada kesinleştirilen muayenenin tedavi/aşısı muayeneden kopuk girilir. Ana plan Aşama 7 "kısa tamamlanma kontrolü" bunu hedefliyor, henüz yok.

**B-14 Doğrudan satış yok.** ADR-016 kabul edildi, ne uç ne arayüz var. Mama/ilaç satışı bugün: elle ücret + ayrı stok çıkışı; stok bağı yok. Uygulama hayvan zorunlu ve yalnız muayene/tedavi detayından açılıyor.
- Kanıt: `FE:panel/panel.routes.ts` (satış rotası yok); `FE:administrations/components/administrations-section.component.ts` (yalnız muayene ve tedavi detayında kullanılıyor); `RAKIP-ANALIZI-2026-10.md:59` (geçiş engeli adayı).
- Etki: S8, S7.

### 4.3 Orta

**B-09 Bugün'de hasta/sahip adı bağlantı değil; var olan muayeneye gidilmiyor.** "Muayene aç" her zaman `/examinations/new` açar; Bugün satırı muayene kimliği taşımıyor. Aynı geliş için ikinci tıklama ikinci muayene açabilir (ADR-009 K4: randevu başına tek muayene kuralı yok). Hasta/sahip adı düz metin; hasta özeti (uyarı, aşı, geçmiş) bir tık uzakta değil.
- Kanıt: `FE:visits/pages/today-page/…:250-251,264` (düz metin), `:858-863`; `FE:visits/models/visit-vm.model.ts` (`examinationId` aranıp bulunamadı); `ADR-009:39`.
- Doğrulanmadı: ikinci muayenenin gerçekten oluştuğu (denenmedi). Etki: S1, S2, S3.

**B-10 Kritik uyarı görünürlüğü 3 yerde.** Uyarı rozeti yalnız Bugün, muayene başlığı ve hayvan detayında. Tedavi/reçete/aşı/lab/yatış/randevu formlarında ve detaylarında yok; reçete ve ilaç uygulaması uyarının en çok gerektiği yer.
- Kanıt: `FE` genelinde `app-pet-alert-badges` taraması: `examination-patient-header`, `pet-detail-page`, `today-page`.
- Doğrulanmadı: uyarı türleri ve ciddiyeti (ADR-011). Etki: S3, S5.

**B-11 Menü rolü yansıtmıyor; açılış belgeyle çelişiyor.** Hkm ve Rsp varsayılan paketlerinde tüm klinik modüller `Read`'de olduğundan **ikisi de aynı 19 öğeyi görür**. ASAMA8 D-M1 gerekçesi "Sekreter Hekim menüsünü görmez" kodla tutmuyor; D-M1 "≈16 öğe" demişti, gerçek 19. D-M2 "Yönetici → Özet" demişti, kod izne göre açar (Yön de Bugün'e düşer).
- Kanıt: `FE:core/routing/panel-navigation.ts:187-240`; `BE:src/…/Auth/RolePermissionBindings.cs:273-375,376-443,444-503`; `BE:docs/ASAMA8_DISCOVERY.md:321`; `FE:core/routing/panel-home.redirect.ts`.
- Etki: tüm roller; öğrenme maliyeti. UX-007 ertelenmişti; asıl sorun rolden önce menünün kayıt-türü yapısı (B-12).

**B-12 Menü kayıt türüne göre, iş akışına göre değil.** Klinik grubu 10 öğe (Randevular, Takvim, Müşteriler, Hayvanlar, Muayeneler, Yatışlar, Aşılar, Lab, Tedaviler, Reçeteler); hasta hikâyesi (zaman çizelgesi) menüde yok, hayvan detayından bir bağlantıyla. Randevu yüzeyi dört yerde: Randevular, Takvim, Bugün, Özet "Bugünkü randevular". "Aşılar", "Tedaviler", "Reçeteler" sayfaları çoğunlukla başka bir ekrandan gelen bağlamla anlamlı; menüden tek başına girildiğinde müşteri+hayvan baştan seçilir.
- Kanıt: `FE:core/routing/panel-navigation.ts:196-211`; `FE:pets/components/pet-summary-card.component.ts:43`; `FE:dashboard/pages/dashboard-page.component.ts:487`.
- Etki: tüm senaryolar. ADR-004 "menü sade kalmalı" hedefiyle çelişir.

**B-13 Stok girişi gömülü.** Giriş yalnız ürün detayındaki "Stok işlemi" veya Stok hareketleri sayfasındaki diyalogla; "Stok durumu" sayfasında eylem yok, düşük stok uyarısı ürün detayına götürüyor (giriş orada). Mal geldiğinde en sık iş 3–4 tık.
- Kanıt: `FE:inventory/pages/product-detail-page/…:139`, `FE:inventory/pages/stock-movements-page/…:267`, `FE:inventory/pages/product-stocks-page/…` (satır eylemi yalnız ürün bağlantısı), `FE:dashboard/pages/dashboard-page.component.ts:262,280`.
- Etki: S7.

**B-15 Bekleyen işler dağınık; Bugün'de lab ve borç görünmüyor.** Lab bekleyen yalnız menü rozeti; Bugün'de ödeme rozeti var, lab yok; hasta ayrılmış ve sonuç/borç bekliyorsa "açık iş" listesi yok ("açık iş göstergesi backend'de yoktur").
- Kanıt: `FE:visits/pages/today-page/…:72-73`; `AJAN-KUYRUGU.md:73`; ana plan bölüm 12 madde 9 ("sorumlu kişi ve sonraki aksiyon görünür olur") henüz karşılanmadı.
- Etki: S4, S6, S9.

**B-16 Aynı bilgi iki kez / elle eşleştirme.** Tedavi, reçete, aşı, lab muayeneden `examinationId` taşır ama `visitId` taşımaz; ücret formunda geliş ve muayene ayrı açılır listelerden elle seçilir; yatış formu Bugün dışından açılınca "Geliş (bugün)" ayrıca seçilir.
- Kanıt: `FE:examinations/pages/examination-detail-page/…:111-115` (queryParams: clientId, petId, examinationId); `FE:charges/pages/charge-new-page/…:71,86`; `FE:hospitalizations/pages/hospitalization-new-page/…:166-178`.
- Etki: S3, S5, S6.

**B-17 Randevudan muayene ile Bugün'den muayene iki ayrı yol.** Randevu detayı "Muayene Oluştur" `appointmentId` taşır, `visitId` taşımaz; Bugün'ün "Muayene aç"ı `visitId` taşır. İlki Visit açmadan muayene yaratır; Bugün satırının bu durumda ne gösterdiği doğrulanmadı (ADR-009 K2: muayene randevuyu `Completed` yapar).
- Kanıt: `FE:appointments/pages/appointment-detail-page/…:120-135` ve `FE:visits/pages/today-page/…:858-863`; `ADR-009:37`.
- Etki: S1. **Doğrulanmadı** (denenmedi).

### 4.4 Düşük

**B-18 Uygulama listesi menüde yok.** `/panel/administrations` (iptal/zarar görünümü) yalnız muayene/tedavi detayındaki "Tümü →" ile bulunur. Kanıt: `FE:administrations/components/administrations-section.component.ts:52`, `panel-navigation.ts` (giriş yok).

**B-19 Rapor Merkezi'nde "gün sonu" tanımı yok.** 11 kart var; günün tahsilat/açık iş/ücretsiz işlem özeti tek yerde değil. Klinik gün sonunu nasıl yapıyor bilinmiyor (bölüm 6, K8). Kanıt: `FE:core/routing/panel-navigation.ts:85-185`.

### 4.5 İyi çalışanlar (korunmalı)

- **Bugün:** randevulu/randevusuz tek kuyruk, hekim varsayılanı, "benim hastalarım", acil, bekleme uyarısı, ücret/ödenen/kalan ve müşteri borcu aynı satırda.
- **Hızlı kayıt:** claim'e göre gizleme ve açıklama ("kaydı resepsiyon oluşturur") (`FE:visits/components/visit-arrival-dialog.component.ts:91-98,165-166`).
- **Bağlam taşıma (iyi örnek):** Bugün → ödeme (müşteri+geliş, açık ücretler dolu), muayene → tedavi/reçete/aşı/lab/yatış (müşteri, hayvan, muayene salt okunur dolu).
- Stok güvenliği (SKT, parti önerisi), ek not, gerekçeli iptal, rowVersion çakışma koruması.

---

## 5. Önerilen yapı

### 5.1 İlke

Yapı **"kayıt türü" yerine "iş" etrafında** kurulur: *Günün akışı* (Bugün), *hasta* (hayvan+sahip tek bağlam), *muayene içi işlemler*, *hesap* (ücret+ödeme), *stok ve satış*. Kayıt türü listeleri silinmez; menünün ana yolu olmaktan çıkar, **arama/denetim aracı** olur. Mevcut rotalar korunur ([ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md) madde 5).

### 5.2 Yapı taşları (seçeneklerden bağımsız)

1. **Hasta çalışma alanı** (mevcut hayvan detayı + özet + zaman çizelgesi birleşir): üstte kimlik+uyarı+bakiye, altında *geçmiş (zaman çizelgesi)*, *aşılar*, *açık işler*; **eylem çubuğu**: Geldi / Muayene başlat / Randevu al / Aşı / Lab / Yatış / Ücret ekle / Ödeme al, hepsi hayvan+müşteri bağlamını taşır. Müşteri sayfası aynı yapının müşteri yüzü: hayvanlar, hesap, **Yeni hayvan**.
2. **Muayene içinde işlemler:** muayene sayfasında *İşlemler* bölümü: tedavi, reçete, aşı, lab, yatış, uygulama tek listede; "+ Ekle" geniş çalışma alanında (yan panel/aynı sayfa), kayıt sonrası **aynı muayenede kalınır** (B-07). Aşı ve uygulama tek girişte (B-01, K1). Kesinleştirmeden önce "Eklenmemiş/ücretlenmemiş kalem var" kontrolü (B-08, B-02).
3. **Ücret önerisi ve bekleyen ücret:** hekimin yaptığı işlem "ücret bekliyor" olarak resepsiyona düşer; resepsiyon onaylayıp ücrete çevirir (hekim ücret ekleyemez kararı korunur) (B-02).
4. **Hesap paneli:** ücretler+ödemeler müşteri bağlamında tek ekran; ücret kaydı sonrası ödemeye devam eder, "Ödeme al" birincil eylem (B-03).
5. **Bugün'e açık işler:** bekleyen lab, borçlu çıkan, tamamlanmamış geliş (ADR/ana plan Aşama 8 "hesaplanan liste" kararıyla uyumlu) (B-15).
6. **Satış ve stok:** hızlı satış ekranı (ADR-016) ve stok girişi birinci sınıf eylem (B-13, B-14).

### 5.3 Seçenekler

| | **Seçenek 1: Yerinde düzelt** | **Seçenek 2: Bugün + hasta çalışma alanı (önerilen)** | **Seçenek 3: Rol bazlı çalışma modları** |
|---|---|---|---|
| Fikir | Menü ve sayfalar aynı kalır; bulgular tek tek giderilir (dönüş bağlantıları, filtreli "Tümü", claim gizleme, ödeme döngüsü, uyarı rozeti) | Yukarıdaki 6 yapı taşı + menü 19 → 8–9 öğe | Resepsiyon masası / Hekim odası / Yönetici ayrı açılış + menü (UX-007 genişletilmiş) |
| Menü | 19 öğe | Bugün · Hastalar (Müşteri+Hayvan sekmeli) · Randevular (liste/takvim anahtarı) · Para (Ücret+Ödeme+Satış) · Stok (Ürün/Durum/Hareket) · **Kayıtlar** (muayene, tedavi, reçete, aşı, lab, yatış; sekmeli, arama/denetim için) · Raporlar · Ayarlar (+ Özet yönetici için) | Her rol için ayrı sıra/öğe |
| Artı | En düşük risk; hemen faydalı; yeni kavram yok | İş akışını yansıtır; geçiş sayısı belirgin düşer; menü ADR-004'e uyar; mevcut sayfalar yeniden kullanılır | Her kullanıcı yalnız kendi işini görür |
| Eksi | Parçalı yapı kalır; B-01/B-02/B-12 çözülmez (K1/K2 gerekir) | Daha çok iş; hasta çalışma alanı yeni bir birleşik yüzey; K1–K4 kararları gerekir | Yapı iki kez değişir; rol farklarının gerçek ihtiyacı pilotsuz bilinmiyor; bakım maliyeti |
| Geçiş maliyeti | Düşük (**ölçülmedi**) | Orta (**ölçülmedi**): menü tek dosyada, hasta alanı ve muayene "İşlemler" bölümü yeni arayüz | Orta–yüksek (**ölçülmedi**) |
| Rota/yer imi etkisi | Yok | Rotalar korunur, yalnız menü değişir (`panel-navigation.ts` tek kayıt); ürün canlıda değil, yer imi yok (`AJAN-KUYRUGU.md:103`); `app.menu.spec`/`panel-navigation.spec` testleri güncellenir | Aynı, ek olarak rol başına açılış kuralı |
| Çözdüğü bulgular | B-03/04/06/07/08/10 kısmen | B-01…B-17 büyük çoğunluğu | B-11 |

**Öneri:** Seçenek 2, **kademeli**: önce Seçenek 1'in küçük düzeltmeleri (bölüm 7 Dilim A), sonra hasta çalışma alanı ve muayene "İşlemler" bölümü (Dilim B), menü yeniden gruplama (Dilim C). Seçenek 3 pilotta gerçek rol geri bildirimi gelene kadar ertelenir (UX-007 kararıyla tutarlı).

### 5.4 Mevcut sayfaların akıbeti (Seçenek 2)

| Sayfa | Akıbet |
|---|---|
| Bugün | Kalır, merkez olur; hasta/sahip adı bağlantı, var olan muayeneye git, açık işler |
| Özet | Kalır (yönetici için), Bugün'ün üstüne ikinci yüz; "Bugünkü randevular" bloğu Bugün'e bırakılır |
| Randevular + Takvim | **Birleşir** (tek menü öğesi, liste/takvim anahtarı) |
| Müşteriler + Hayvanlar | **Birleşir** ("Hastalar", iki sekme); detaylar hasta çalışma alanı olur |
| Muayeneler (liste) | Menüden çıkar, **Kayıtlar** altına; çalışma alanı/detay kalır |
| Tedaviler, Reçeteler, Aşılar, Lab, Yatışlar (liste) | Menüden çıkar, **Kayıtlar** altına; lab bekleyenler ve aktif yatışlar Bugün'e **bekleyen** olarak da yansır; rotalar aynen çalışır |
| Ücretler + Ödemeler | **Birleşir** ("Para", sekmeli) + hesap paneli |
| Ürünler + Stok durumu + Stok hareketleri | **Birleşir** ("Stok", sekmeli) + giriş birinci eylem |
| Satış (ADR-016) | **Yeni**, Para altında + Bugün'den kısayol |
| Raporlar | Kalır; "gün sonu" özeti eklenebilir (K8) |
| Uygulamalar listesi | Kayıtlar altına |
| Ayarlar | Aynen |

Hiçbir rota silinmez; kaldırılan yalnız menü girişidir.

### 5.5 Rol bazlı farklar (öneri; izin altyapısı değişmeden)

| Rol | Açılış | Ağırlıklı yüzey | Gizli kalır |
|---|---|---|---|
| Resepsiyon (Rsp) | Bugün | Geliş, kuyruk, Hastalar (yeni hayvan/müşteri), Randevular, Para (ücret onay, ödeme, satış), Stok girişi | Muayene/uygulama yazma (zaten izinsiz) |
| Hekim (Hkm) | Bugün (varsayılan "benim hastalarım") | Hasta çalışma alanı, muayene + işlemler, lab sonucu yorum, yatış | Ücret/ödeme/stok girişi eylemleri (izinsiz); **B-04 giderilir** |
| Yönetici (Yön) | Bugün veya Özet (K5) | Özet, Raporlar, düzeltme/iptal, Ayarlar | — |

---

## 6. Kullanıcıya sorulacak kararlar (öneriyle)

| # | Soru | Öneri | Dayanak |
|---|---|---|---|
| K1 | **Aşı tek girişte mi olsun?** Aşı formunda ürün/parti seçilince hem aşı kaydı hem stoktan düşen uygulama yazılsın mı (D6 değişir, ADR gerekir)? | **Evet**, tek giriş; ürün seçilmezse yalnız aşı kaydı | B-01 |
| K2 | **Ücret önerisi:** hekimin işlemi "ücret bekliyor" olarak resepsiyona düşsün; resepsiyon onaylayıp ücrete çevirsin mi (hekim ücret ekleyemez kararı korunur)? | **Evet** | B-02, ADR-012 karar 2, ana plan Aşama 5 madde 6 |
| K3 | **Yapı:** Seçenek 1 / 2 / 3? | **Seçenek 2, kademeli** (önce Dilim A, B, sonra C); 3 pilotta | bölüm 5 |
| K4 | Menüden çıkan kayıt listeleri tek **"Kayıtlar"** öğesi altında mı, yoksa yalnız hasta/muayene içinden ve Raporlar'dan mı erişilsin? | **Tek "Kayıtlar"** (denetim, defter ve genel arama için global liste gerekli) | B-12 |
| K5 | Yönetici açılışı **Özet mi, Bugün mü?** (D-M2 ile kod çelişiyor) | **Bugün**; Özet ikinci sekme | B-11 |
| K6 | **Bugün'e açık işler** (bekleyen lab, borçlu, tamamlanmamış geliş) pilot öncesi girsin mi? | **Evet**, hesaplanan liste (D-N1 kararı) ile, lab+borç yeterli | B-15 |
| K7 | Randevu detayından "Muayene Oluştur" önce **geliş (Visit)** açsın mı? | **Evet**, tek yol | B-17 |
| K8 | **Gün sonu:** klinik gün sonunda gerçekte ne yapıyor (kasa kapama, tahsilat sayımı, açık iş)? Rapor Merkezi'ne "gün sonu özeti" gerekir mi? | Öneri yok; **pilot klinikle sorulacak** | S9, B-19, ADR-012 (kasa mutabakatı kapsam dışı) |
| K9 | **Satış ekranı yeri** (ADR-016 arayüzü): Para altında + Bugün'den kısayol mu? | **Evet** | S8 |
| K10 | **Kesinleştirme öncesi kontrol:** eklenmemiş/ücretlenmemiş kalem uyarısı eklensin mi? | **Evet**, engel değil uyarı | B-08, ana plan Aşama 7 madde 4–5 |

---

## 7. Pilot öncesi minimum dilim (öneri)

Pilot kapsamı ADR-014 K9: önce muayene, geliş, ücret-ödeme senaryoları. Sıra, **doğruluk riski** → **sürtünme** → **yapı**.

**Dilim A: küçük düzeltmeler (ürün kararı gerekmez; kod deposunda doğrudan yapılabilir, WORKFLOW "küçük işler")**
- A1 Muayene detayında "Ödeme Oluştur"ı `Payments.Create`'e bağla (B-04).
- A2 Aşı detayına "Bağlı muayene" bağlantısı (B-07); işlem kaydı sonrası muayeneye dönüş (B-07).
- A3 "Tümü →" bağlantılarına `petId`/`clientId` süzgeci ve liste sayfalarında okuma (B-06).
- A4 Kesinleştirme diyaloğuna "tedavi, reçete, aşı ve yatış eklenemez" cümlesi (B-08).
- A5 Bugün'de hasta/sahip adını bağlantı yap (B-09, yalnız bağlantı kısmı).

**Dilim B: akışı değiştiren (bu belgenin onayı + ilgili kararlar gerekir)**
- B1 Ücret kaydından sonra ödeme formuna dönüş; Ücret listesine "Ödeme al" (B-03).
- B2 Hasta/müşteri sayfalarına eylem çubuğu: Muayene başlat, Randevu al, Aşı, Yeni hayvan (B-05).
- B3 Uyarı rozetini tedavi/reçete/aşı/lab/yatış formlarına ve detaylarına (B-10).
- B4 K1 (aşı tek giriş) ve K2 (ücret önerisi) kararları ve ADR'leri.
- B5 Doğrudan satış (ADR-016) arayüzü ve ucu (B-14).
- B6 Bugün'den var olan muayeneye git (backend alanı) ve K7 (B-09, B-17).

**Dilim C: yapı (Seçenek 2 menü)**
- C1 Menü gruplama ve "Kayıtlar", "Hastalar", "Para", "Stok" birleşimleri (K3, K4).
- C2 Bugün'e açık işler (K6) ve muayene "İşlemler" bölümü (B-07, B-08).

Pilot başlamadan **A tamamı**, **B1, B2, B3, B4, B5** ve K8'in cevabı; C pilotla paralel ya da hemen sonrasında, ama menü yapısı pilot kullanıcılara alıştırıldıktan sonra değişmesin diye **C1'in pilot öncesine alınması önerilir** (menü tek dosyada olduğu için maliyeti düşük görünüyor; **ölçülmedi**).

---

## 8. Doğrulanmayanlar

- Uygulama hiç çalıştırılmadı; tüm tıklama/geçiş sayıları koddan çıkarım ve alt sınır; gerçek kullanıcıyla ölçülmedi.
- Düğme etiketi doğrulanamayanlar: Stok hareketleri sayfasındaki giriş diyaloğunu açan düğme, lab detayında sonuç girişi düğmesi, randevu kaydı sonrası hedef ekran, geliş diyaloğunun son onay adımı.
- B-09 ve B-17'deki ikinci muayene / Bugün satırı davranışı denenmedi.
- Admin ve Owner izin listeleri satır satır okunmadı (ClinicAdmin okundu, dosya yorumu "aynı paket" diyor).
- Özel rollerin ve gerçek kurulumdaki seed'in izinleri bilinmiyor.
- Klinik pratiği (bölüm 2'deki **doğrulanmadı** işaretleri): randevu alma, lab sonuç girişi kim, yatış rutini, fiyatlandırma, gün sonu.
- Aşı defterinin yasal gerekliliği ve biçimi doğrulanmadı (ADR-015).
- Rakip bilgisi yalnız `RAKIP-ANALIZI-2026-10.md`'den; rakip arayüzü incelenmedi, görünüm alınmadı.
- Geçiş maliyetleri (bölüm 5.3) tahmindir, ölçülmedi.

---

## İlgili belgeler

- [UX ilkeleri](ux-principles.md), [Navigasyon](navigation.md), [Tasarım kararları](design-decisions.md)
- [ADR-004](../decisions/ADR-004-navigation-and-menu-philosophy.md), [ADR-009](../decisions/ADR-009-visit-model-and-arrival-flow.md), [ADR-012](../decisions/ADR-012-basic-charges-payments-balance.md), [ADR-013](../decisions/ADR-013-finalized-examination-late-entries-and-administration-void.md), [ADR-015](../decisions/ADR-015-batch-based-stock-and-registers.md), [ADR-016](../decisions/ADR-016-direct-sale.md)
- [Rakip analizi](../roadmap/RAKIP-ANALIZI-2026-10.md), [Ajan kuyruğu](../roadmap/AJAN-KUYRUGU.md), [Ana plan](../roadmap/Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md)
