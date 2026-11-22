# ADR-053 — Kaynak bazlı takvim: oda ve cihaz

## Durum

**Önerildi (2026-11-22).** Kullanıcı onayı bekliyor; onaylanmadan main'e alınmaz. Kararlar ajan önerisidir (rakip pratiğinden ve mevcut
desenlerden türetildi). Kullanıcı farklı derse yalnız ilgili K maddesi değişir. 1. dilim bu önerilerle `feature/appt-025-kaynak-takvim`
dallarında kodlandı (backend + panel); birleştirme onaydan sonra.

Kapsam: [APPT-025](../backlog/feature-backlog.md#appt-025--kaynak-bazlı-takvim), [PATTERN-012](../research/patterns.md#pattern-012--configurable-resource-calendar),
[IDEA-014](../research/ideas.md#idea-014--configurable-scheduling-resources). APPT-007'nin "kaynak" yarısı (neden → kaynak) sonraki dilimdir.

## Bağlam

- Takvim bugün yalnız hekim sütunlu (APPOINTMENT_CALENDAR_API_CONTRACT.md §1). Çakışma hekim, hasta ve (hekimsiz randevuda) klinik bazında
  denetlenir; hekim çakışması **engeldir** (409), klinik çakışması klinik ayarıyla (`allowOverlappingAppointments`) kapatılabilir.
- Ameliyathane, röntgen, ultrason gibi tek olan oda ve cihazlar planlanamıyor: iki hekim aynı saatte aynı ultrasonu randevuya yazabiliyor.
- Klinikte kayıtlı tek "oda" kavramı yatış konumlarıdır (bölüm + oda/kafes; çok günlük yatış). Randevu saatine bağlı değildir.
- Rakip pratiği:
  - **DaySmart:** takvim sütunları hekim ve operasyonel kaynak (oda, walk-in, Tech Appts); "All Columns" ve tek tek sütun seçimi; boş hücre
    sütun bağlamıyla randevu açar. Boarding'de oda-kaynak timeline'ı ve **Max:N kapasite**. Randevu formunda tek "Assign To".
  - **E-vet:** randevuda "Bölüm" + "Veteriner"; takvimde Bölüm filtresi; slot ızgarasında 0/1 doluluk. Yatışta ayrı Bölüm + Oda.
  - Ortak: randevu başına bir oda/bölüm; kaynak kapasitesi küçük ve tamsayı; kaynaklar klinik (şube) tanımı.

## Kararlar

### K1 — Kaynak türleri: Oda ve Cihaz

- İki tür: **Oda** (muayene odası, ameliyathane, röntgen odası) ve **Cihaz** (röntgen, ultrason, anestezi cihazı).
- Hekim kaynak değildir; hekim alanı ve hekim sütunu aynen kalır.
- **Walk-in sütunu yok:** randevusuz geliş takvime yazılmaz, Bugün'de izlenir (ADR-009 madde 3).
- Teknisyen/personel kaynağı yok (DaySmart "Tech Appts"); ihtiyaç doğarsa ayrı karar.
- **Yatış konumları ayrı kalır:** yatış çok günlük yerleşimdir, randevu kaynağı saat dilimidir. Birleştirmek iki kuralı karıştırır.

### K2 — Kapasite: kaynak başına N, varsayılan 1

- Her kaynağın tamsayı kapasitesi vardır (1–20, varsayılan 1). Aynı anda kapasite kadar planlı randevu o kaynağı kullanabilir.
- Çoğu oda ve cihaz 1'dir; "serum odası, 3 koltuk" gibi durumlar için N (DaySmart Max:N).

### K3 — Randevuda en çok bir oda ve bir cihaz, ikisi de isteğe bağlı

- Randevu formunda "Oda" ve "Cihaz" seçimleri; boş bırakılabilir. Klinikte aktif kaynak yoksa alanlar görünmez.
- Birden çok cihaz (ör. ameliyatta anestezi + monitör) ilk dilimde yok; rakiplerde de randevu başına tek oda/bölüm görüldü.
- Pasif kaynak yeni randevuda seçilemez; mevcut randevuda kalır (randevu nedeni ve hekim kuralıyla aynı).

### K4 — Çakışma: engel (409), uyarı değil

- Kaynağın o aralıktaki eşzamanlı planlı randevu sayısı kapasiteyi aşacaksa kayıt reddedilir: `409 Appointments.ResourceTimeConflict`.
- Gerekçe: fiziksel oda/cihaz iki yerde olamaz; hekim çakışması zaten engeldir; DaySmart kapasiteyi sınır olarak gösterir.
  "Uyarı ver, yine de kaydet" iki hekimin aynı cihazı yazmasını, yani çözmeye çalıştığımız sorunu açık bırakır.
- Klinik ayarı `allowOverlappingAppointments` kaynak kuralını **etkilemez** (hekim kuralında olduğu gibi).
- Kural oluşturma, düzenleme, yeniden zamanlama ve iptali geri almada aynı yerden uygulanır (`AppointmentSlotRules`).
- Takvim kapasite aşımını (kapasite sonradan düşürülmüşse) kırmızı "Çakışma" ile gösterir.

### K5 — Yönetim: Ayarlar > Tanımlar > Oda ve cihazlar

- Tanım kartı "Oda ve cihazlar" (ADR-023: yeni sayfa kendi menü satırını almaz). Liste, ekle, düzenle, pasife al; silme yok.
- Yazma `Clinics.Update` (randevu nedenleri ve yatış konumlarıyla aynı); okuma randevu planlama yetkisi (`Clinics_SchedulingRead`).
  Yeni izin yok.
- Alanlar: ad (aktifler arasında klinik içinde benzersiz), tür, kapasite, sıra, aktif.

### K6 — Kaynaklar klinik (şube) bazlıdır

- Oda ve cihaz fiziksel olarak bir şubededir; kaynak tek kliniğe aittir, randevu yalnız kendi kliniğinin kaynağını seçebilir.

### K7 — Online randevu: ilk dilimde etkisi yok

- Online talep kaynak seçmez; müsaitlik kaynağa bakmaz. Klinik onaydan sonra randevuyu düzenleyip kaynak atayabilir; kayıtta K4 denetlenir.
- Sonraki dilim: randevu nedenine varsayılan kaynak (APPT-007) ve online müsaitlikte kaynak kapasitesi. Sahibe kaynak adı gösterilmez.

### K8 — Takvim: gün görünümünde "Hekim / Oda ve cihaz"

- Gün görünümünde sütun seçimi: **Hekim** (bugünkü) ya da **Oda ve cihaz**. Kaynak görünümünde her aktif kaynak bir sütundur (önce odalar,
  sonra cihazlar, sıra numarasıyla); kaynaksız randevular "Oda/cihaz yok" sütununda. Hem oda hem cihazı olan randevu iki sütunda görünür.
- Klinikte aktif kaynak yoksa seçim hiç görünmez: küçük klinik bugünkü sade takvimle kalır (PATTERN-012 riski: aşırı yapılandırma).
- Boş hücreye tıklamak o kaynak seçili yeni randevu açar. Seçim adreste tutulur.
- Hafta, ay ve telefon ajandası değişmez; randevu balonunda oda ve cihaz adı görünür.

### K9 — Boş saat bulma: sonraki dilim

- "Boş saat bul" ve formdaki boş saat önerisi ilk dilimde kaynağa bakmaz; kaynak dolu saat önerilirse kayıt K4 ile reddedilir.
- Sonraki dilim: personel müsaitlik sorgusuna kaynak parametresi; hesap `AppointmentAvailabilityCalculator` içinde kapasiteyle.

### K10 — Paket: tüm paketlerde, sınırsız

- Randevu çekirdek klinik akıştır (ADR-035 tablosu "randevu" tüm paketlerde). Kaynak sayısına paket sınırı konmaz.

## Sonuçlar

- Backend: `AppointmentResource` varlığı (klinik bazlı), randevuda `RoomResourceId` ve `EquipmentResourceId`; tanım uçları
  `clinics/{clinicId}/appointment-resources`; çakışma kuralı ve takvim yanıtında kaynak alanları; tüm veri dışa aktarmada yeni dosya.
  Migration yerel DB'de; canlı listesi kılavuz §11.1'e yayın sırasında eklenir.
- Panel: Tanımlar > Oda ve cihazlar; randevu formunda oda ve cihaz; takvimde kaynak sütunları ve çakışma işareti.
- Okuma modeli (Query DB) şeması değişmez; takvim kaynakları hekim gibi komut veritabanından tamamlar.

## Değerlendirilen seçenekler

| Konu | Seçenek | Neden seçilmedi / seçildi |
|---|---|---|
| Çakışma | Uyarı ver, kaydet | Sorunu çözmez; hekim kuralıyla tutarsız |
| Çakışma | **Engel, kapasiteyle (seçilen)** | Fiziksel kısıtı yansıtır; Max:N ile esnek |
| Kapasite | Hep 1 | Serum/bekleme odası gibi çok yerli odayı modelleyemez |
| Randevuda kaynak | Sınırsız kaynak listesi | Form ve takvim karmaşıklaşır; rakiplerde de tek oda/bölüm |
| Randevuda kaynak | **Bir oda + bir cihaz (seçilen)** | Gerçek ihtiyacın çoğu; sade form |
| Oda | Yatış konumlarını yeniden kullanmak | Yatış çok günlük, randevu saat dilimi; kurallar karışır |
| Takvim | Hekim ve kaynak sütunları karışık tek görünüm | 10+ sütun riski (PATTERN-012 anti-pattern); seçimli iki görünüm daha sade |

## Açık sorular

- Paket farkı istenir mi (ör. kaynak takvimi yalnız Profesyonel ve üstü)? Öneri: hayır (K10).
- Online randevuda kaynağın sahibe hiç gösterilmemesi doğru mu? Öneri: evet, sahip yalnız saat görür (K7).
