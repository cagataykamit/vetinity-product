# İşletme performansı panosu: kapsam taslağı (2026-10-28)

**Durum:** Taslak öneri. Kod yazılmadı. Backlog: [REPORT-008](../backlog/feature-backlog.md#report-008--işletme-performansı-panosu). Kullanıcı kararı bekleyen noktalar bölüm 8'de.
**Kaynak:**
- [ADR-003](../decisions/ADR-003-report-center.md) (Rapor Merkezi), [ADR-030](../decisions/ADR-030-acilis-sayfasi-ve-bugun-hizli-eylemleri.md) (Özet = yönetici açılışı), [UX ilkeleri](ux-principles.md).
- Rakip gözlemleri: E-Vet [VKY](../competitors/e-vet.md#vky-modül), DaySmart [Reports Dashboard](../competitors/daysmart.md#reports-dashboard) ve [Billing Dashboard](../competitors/daysmart.md#billing-dashboard).
- Backend (salt okuma, main `8ebbdf73`): `DashboardController`, `ReportsController`, `EndOfDayReportsController`, `docs/DAILY_TRANSACTIONS_REPORT_API_CONTRACT.md`.

**Yöntem notu:** Rakipten yalnız çözülen problem ve metrik türü alındı. E-Vet'in sekme düzeni, pasta grafikleri ve "en'ler" listeleri kopyalanmaz. Klinik pratiği sorusu sorulmadı; kararlar öneri ve gerekçeyle yazıldı.

---

## 1. Problem ve değer

- Klinik sahibi ya da yöneticisi "bu ay nasıl gidiyoruz" sorusunu bugün tek yerde yanıtlayamıyor:
  - Özet (`/dashboard`) bugüne bakar: bugün/hafta/ay tahsilatı, randevu sayıları, son 7 gün.
  - Raporlar tek konuya bakar: gün sonu, kasa, muayene, aşı, randevu, alacak.
  - Dönemler karşılaştırılamıyor, ciro ve iş hacmi yan yana görülemiyor.
- Rakip pratiği: E-Vet'te raporlardan ayrı bir yönetim analitiği yüzeyi var (aylık ciro ve değişim, tahsilat değişimi, personel satışı, ürün tipi satışı, müşteri sayısı değişimi, aşı yapılan/bekleyen). DaySmart rapor ana sayfasında ve fatura alanında özet göstergeler gösteriyor.
- Vetinity farkı:
  - Panodaki her sayı tıklanınca **aynı filtreyle** ilgili rapora iner. Sayı ile rapor her zaman eşleşir, çünkü ikisi aynı hesaplamadan gelir.
  - Ayrı menü yok, ayrı veri kopyası yok.

## 2. Yer ve navigasyon (ADR gerekmez, bölüm 9)

- Rapor Merkezi'nde yeni **"Yönetim"** bölümü açılır; ilk kart **"İşletme performansı"** olur. Kenar menü değişmez (ADR-003, UX ilke 1–2).
- Özet olduğu gibi kalır: günlük işlerin yönetici görünümü. Özet'teki "Bu ay alınan ödeme" kartına "Dönem performansı" bağlantısı eklenir; yeni ekran ya da modal açılmaz.
- Adres: `/panel/reports/performance` (teknik rota frontend'de kesinleşir).

## 3. Metrikler

İşaretler:
- ✔ mevcut uç ya da okuyucu karşılıyor.
- ◐ mevcut veriden türetilebiliyor, tanım notu gerekiyor.
- ✘ yeni sorgu gerekiyor.

Tüm tutarlar TRY, günler Europe/Istanbul takvimine göredir. Tanımlar gün sonu raporuyla aynıdır (K-D6-1…8), yani bir olay bir kez sayılır ve iptal ayrı olaydır.

### 3.1 Para

| # | Metrik | Tanım | Kaynak | Durum |
|---|---|---|---|---|
| P1 | Ciro (net ücret) | Aralıkta yazılan ücret − aralıkta iptal edilen ücret | `reports/daily-transactions` → `totals.netChargeAmount` (`IDailyTransactionsReader`) | ✔ |
| P2 | Net tahsilat | Alınan − iptal edilen tahsilat | `reports/cash-summary` → `totals.netAmount` | ✔ |
| P3 | Ödeme türü kırılımı | Nakit / Kart / Havale-EFT net | `cash-summary.byMethod` | ✔ |
| P4 | Günlük tahsilat eğilimi | Gün başına net tahsilat | `cash-summary.byDay` (yalnız hareketli günler; boş günleri istemci 0 ile doldurur) | ✔ |
| P5 | Doğrudan satış payı | Satış ücreti ve tahsilatı | `totals.salesChargeAmount`, `salesCollectedAmount` | ✔ |
| P6 | Açık alacak (anlık) | Bugünkü toplam müşteri borcu; aralıktan bağımsız | `reports/outstanding-balances` → `totalOutstandingAmount` | ✔ |
| P7 | Tahsilat / ciro oranı | P2 ÷ P1 | Türetilir. Önceki dönem ücretinin tahsilatı da P2'ye girdiği için "tahsilat oranı" değil, "tahsilat / ciro" diye adlandırılır ve açıklama ipucu taşır | ◐ |
| P8 | Günlük ciro eğilimi | Gün başına net ücret | Döküm yalnız olay listesi ve tek toplam veriyor; gün kırılımı yok | ✘ |
| P9 | Hizmet / ürün kırılımı | Net ücretin `ChargeLineKind` (Hizmet/Ürün) dağılımı | Alan var (`Charge.LineKind`), toplayan sorgu yok | ✘ |
| P10 | En çok gelir getiren kalemler (ilk 10) | Açıklama ya da katalog kalemine göre net ücret | Katalog bağı ücrette tutarlı değil (ADR-018); sorgu yok | ✘ |
| P11 | Ortalama sepet | Net ücret ÷ ücretli ziyaret sayısı (doğrudan satış ayrı satır) | Ziyaret başına toplama yok | ✘ |

### 3.2 Klinik iş hacmi

| # | Metrik | Tanım | Kaynak | Durum |
|---|---|---|---|---|
| K1 | Muayene sayısı | Aralıkta muayene tarihi olan kayıtlar (taslak dahil) | `reports/examinations` → `totalCount` (`ExaminationsReportFilteredCountSpec`) | ✔ |
| K2 | Uygulanan aşı | `Applied` ve uygulama tarihi aralıkta | `reports/vaccinations?status=Applied` → `totalCount` | ✔ |
| K3 | Planlanan aşı (vadesi aralıkta) | `Scheduled` ve vade tarihi aralıkta | `reports/vaccinations?status=Scheduled` | ✔ |
| K4 | Randevu dağılımı | Planlı / tamamlandı / iptal / gelmedi; gelmedi ve iptal oranı türetilir | `reports/appointments` → `statusCounts` (`IAppointmentsReportStatusBreakdownReader`) | ✔ |
| K5 | Geliş (ziyaret) sayısı | Aralıkta gelen, iptal edilmemiş ziyaretler | Bugün yalnız tek gün okuyor; aralık sorgusu yok | ✘ |
| K6 | Yeni müşteri / yeni hasta | Aralıkta oluşturulan kayıtlar (içe aktarılanlar hariç) | Özet yalnız toplam sayı veriyor | ✘ |
| K7 | İşlem yapılan tekil müşteri | Aralıkta ücreti ya da ziyareti olan farklı müşteri | Yok | ✘ |

### 3.3 Kişi bazlı

| # | Metrik | Tanım | Kaynak | Durum |
|---|---|---|---|---|
| H1 | Kullanıcı bazlı tahsilat | Tahsilatı alan kullanıcıya göre net | `cash-summary.byUser` | ✔ |
| H2 | Hekim bazlı muayene | Hekime göre muayene sayısı | `Examination`'da hekim alanı yok. Hekim `Visit.ResponsibleVeterinarianUserId` üzerinden gelir; ziyaretsiz muayene için atama kuralı gerekir | ✘ |
| H3 | Hekim bazlı ciro | Ziyaretin sorumlu hekimine yazılan net ücret | `Charge.CreatedByUserId` hekim değil, girişi yapan kişi. Atama ziyaret üzerinden, satış "atanmamış" | ✘ |

### 3.4 Karşılaştırma

- **Önceki dönem:** aynı uzunlukta bir önceki aralık (bu ay ↔ geçen ay, son 30 gün ↔ önceki 30 gün). Her ✔ metrik için değer, fark ve yüzde gösterilir. Teknik olarak aynı okuyucuyu ikinci aralıkla çağırmaktır.
- Geçen yılın aynı dönemi: dilim 2.

## 4. Filtreler

- **Tarih aralığı:** hazır seçimler Bu ay (varsayılan), Geçen ay, Son 30 gün, Bu yıl, Özel. Ortak filtre çubuğu kullanılır (REPORT-005). Sınır 366 gündür, gün sonu ve defterlerle aynı (`Registers.RangeTooLong`).
- **Klinik:** mevcut klinik kapsam çözümleyicisi (`IClinicReadScopeResolver`).
  - Boşsa kullanıcının erişebildiği tüm klinikler gelir; Admin ve Owner için kiracı geneli.
  - Aktif klinik bağlamı varsayılan seçimdir.
- **Karşılaştırma:** aç/kapat; varsayılan açık.
- **Hekim filtresi:** dilim 3 (H2/H3 ile).
- Seçili filtre, inilen rapora sorgu parametresi olarak taşınır.

## 5. Yetki

- **Ekran:** "İşletme performansı" kartı yönetici düzeyine görünür (Özet ile aynı koşul, ADR-030). Resepsiyon ve hekim menüsü sade kalır.
- **Veri, bölüm bazlıdır** (UX ilke 11):
  - Para bölümü `Payments.Read` ve `Charges.Read` ister.
  - Açık alacak `Charges.Read`, muayene `Examinations.Read`, aşı `Vaccinations.Read`, randevu `Appointments.Read` ister.
  - İzni olmayan bölüm hiç çizilmez.
  - Backend özet ucunda bu alanlar izne göre `null` döner (`OpenItemsSummaryDto` deseni).
- **Yeni izin dilim 1'de gerekmez:** dilim 1'deki her sayı, aynı kullanıcının bugün açabildiği raporlarda zaten görünüyor, yani yeni veri açılmıyor.
- **Dilim 3:** hekim bazlı ciro yeni bir görünürlüktür (kişi performansı). Yeni `Reports.Performance` izni önerilir; varsayılan olarak yalnız Admin, Owner ve ClinicAdmin'de olur. Bölüm 8, S1.

## 6. UX kapsamı

- **Yerleşim:** tek sayfa, tam genişlik (ilke 9). Modal yok. Telefonda tek sütun (MOBILE-004).
- **Sıra:**
  1. Başlık ve filtre çubuğu.
  2. Gösterge kartları: P1 ciro, P2 net tahsilat, P6 açık alacak, K1 muayene, K2 uygulanan aşı, K4 tamamlanan randevu. Her kartta değer, önceki döneme göre fark (ok + yüzde) ve "nasıl hesaplanır" ipucu bulunur.
  3. Günlük tahsilat eğilimi (çizgi ya da sütun; P4).
  4. Ödeme türü dağılımı (yatay çubuk; pasta grafik yok).
  5. Randevu dağılımı ve gelmedi/iptal oranı.
  6. Kullanıcı bazlı tahsilat tablosu (H1).
- **İnme:** her kart ve grafik, ilgili rapora aynı tarih ve klinik filtresiyle gider. Eşlemeler:
  - Ciro → Gün sonu (`Charge` türü).
  - Tahsilat → Kasa özeti.
  - Alacak → Borç raporu.
  - Muayene, aşı ve randevu → kendi raporları.
- **Boş durum:** aralıkta hareket yoksa ne olduğunu ve ilk adımı söyler, ör. "Bu dönemde ücret yazılmamış; ücretler muayene ve satıştan oluşur" (ilke 15).
- **Tutarlılık:** sayı biçimi, renk ve kart dili Özet ile aynı. Kendi stilimiz; E-Vet VKY'nin sekme ve grafik düzeni alınmaz (ilke 19).
- **Dışa aktarma:** dilim 1'de yok; ayrıntı raporları zaten CSV/Excel veriyor. Pano PDF'i REPORT-007 ile birlikte değerlendirilir.
- **Deneme kiracısı:** pano açıktır; dışa aktarma kısıtı raporlardaki gibi geçerlidir.

## 7. Dilimler (önce backend)

**Dilim 1, MVP (migration yok, yeni izin yok, yeni hesap kuralı yok):**
- Backend: tek salt okuma uç, `GET /api/v1/reports/performance-summary?from&to&clinicId&compare`.
  - Mevcut okuyucuları çağırır: döküm toplamları, kasa olayları, muayene sayımı, aşı sayımı, randevu durum kırılımı, alacak toplamı.
  - Kural kopyalanmaz; bir metrik bir yerde hesaplanır.
  - Alanlar izne göre `null` döner. `compare=true` ise önceki dönem aynı yapıyla gelir.
  - Sözleşme backend `docs/`'ta önce yazılır.
  - Gerekçe: ekran başına 6–7 rapor çağrısı (karşılaştırmayla 12–14) yerine tek çağrı. Sayı için kişisel ya da klinik satır (ör. muayene bulguları) taşınmaz.
- Frontend: Rapor Merkezi "Yönetim" bölümü, pano sayfası, ortak filtre çubuğu, inme bağlantıları, Özet'ten bağlantı.
- Kapsadığı metrikler: P1–P7, K1–K4, H1 ve önceki dönem karşılaştırması.
- Kabul ölçütleri:
  - Panodaki her sayı, aynı filtreyle açılan raporun toplamına eşittir (entegrasyon testi).
  - İzni olmayan bölüm görünmez.
  - 366 gün sınırı ve klinik kapsamı raporlarla aynı hata kodlarını verir.

**Dilim 2 (yeni sorgular, migration beklenmez):** P8 günlük ciro, P9 hizmet/ürün kırılımı, P10 ilk 10 kalem, P11 ortalama sepet, K5 geliş sayısı, K6 yeni müşteri/hasta, K7 tekil müşteri, geçen yılın aynı dönemi.

**Dilim 3 (karar gerekir):**
- H2/H3 hekim bazlı metrikler, hekim filtresi ve `Reports.Performance` izni.
- Hekim atama kuralı: ziyaretin sorumlu hekimi; ziyaretsiz muayenede kesinleştiren hekim; satış "atanmamış".
- Atama için veri modeline alan eklenirse (ör. `Examination`'a hekim) bu "klinik veri modelini etkileyen karar" olur ve ADR ister.

**Sonra:** AI-101 (işletme sorgulama) aynı özet ucunu kaynak olarak kullanır; ayrı hesaplama yazmaz.

## 8. Açık sorular (kullanıcı)

| # | Soru | Öneri |
|---|---|---|
| S1 | Hekim bazlı ciro ve muayene (dilim 3) kime görünsün? | Yalnız Owner, Admin ve ClinicAdmin; yeni `Reports.Performance` izni. Hekim kendi satırını görsün mü kararı pilot geri bildirimine kalır |
| S2 | Pano ne zaman yapılsın? | Dilim 1 pilot verisiyle anlam kazanır. Öneri: pilot canlıya geçtikten sonra ilk iş (P1); dilim 2–3 pilot geri bildirimine göre |

Öneriyle karara bağlananlar (itiraz edilebilir):
- Ana gösterge çifti: "Ciro (net ücret)" ve "Net tahsilat" yan yana. Biri diğerinin yerine geçmez.
- Varsayılan dönem "Bu ay", karşılaştırma açık.
- Yer: Rapor Merkezi; Özet değişmez.

## 9. ADR değerlendirmesi (WORKFLOW)

- **Dilim 1 ve 2 için ADR gerekmez.** Gerekçe:
  - Yer ADR-003 kapsamında: Rapor Merkezi içi, menü değişikliği yok.
  - Salt okumadır.
  - Veri modeli, izin kataloğu ya da çok modüllü akış değişmez; geri dönüşü ucuzdur.
  - WORKFLOW'a göre yeni ana ekran için backlog maddesi yeterlidir: REPORT-008.
- **Dilim 3 ADR gerektirebilir.** Hekim ataması için klinik veri modeline alan eklenirse ya da kişi performansı görünürlüğü yeni bir rol kuralına dönüşürse ADR yazılır.
