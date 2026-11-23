# ADR-054 — Müşteri ve hasta silme: yumuşak silme, engeller ve geri yükleme

## Durum

**Kabul edildi (2026-11-23).** Kullanıcı kararı: "Müşteri ve hasta için kalıcı silme olmasın. Soft delete koy, veritabanımızda kalsın." Ayrıntılar rakip pratiğinden ve mevcut koddan türetildi (klinik pratiği sorusu sorulmaz). Önce backend (`feature/musteri-hasta-yumusak-silme`), sonra panel. Backend dalında uygulandı (birleştirilmedi): migration'lar `AddClientPetSoftDelete` (komut DB) ve `AddClientPetReadModelIsDeleted` (Query DB) yalnız yerel geliştirme DB'sinde; sözleşme backend `docs/CLIENT_PET_DELETION_API_CONTRACT.md`. İlgili: [ADR-020](ADR-020-clinic-staff-centered-patient-card.md) S5 (vefat), [ADR-031](ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) (portal bağı), [ADR-040](ADR-040-kiraci-izolasyonu-global-filtre.md) (adlı sorgu filtreleri), [ADR-041](ADR-041-portal-hesap-silme.md) (bağ kapatma, anonimleştirme), [ADR-043](ADR-043-birlesik-klinik-kayit-modeli.md), [ADR-048](ADR-048-tam-veri-gecisi.md) (devir borcu/alacağı).

## Bağlam

- Panelde müşteri ve hasta silme hiç yok. Kalıcı silme yalnız iki sistem akışında var: içe aktarma geri alması (IMPORT_API_CONTRACT.md §9) ve örnek klinik temizliği. İkisi de satırı siler ve `client.deleted.v1` / `pet.deleted.v1` olayıyla okuma modeli satırını kaldırır.
- Rakip pratiği:
  - **E-Vet:** hasta kartında "Sil" → "Seçili kaydı silmek istediğinizden emin misiniz?" → kayıt aktif görünümden kalkar. Arka uç davranışı (kalıcı/yumuşak) gözlenemedi. Doğrudan satışta ilişkili ödeme varken silme "Bu kayıt silinemez, ilişkisi vardır" ile engelleniyor.
  - **DaySmart:** hasta listesinde Active / Deceased / Inactive süzgeçleri; "Inactive Client/Patient List" raporları; silinen finans işlemleri ayrı "Deleted Transactions" raporunda görünür.
  - Ortak: silinen kart günlük işten kalkar, bağlı geçmiş kayıt korunur; ilişkili açık iş silmeyi engeller.
- Mevcut kod (backend main `bcc964eb`):
  - Yumuşak silme deseni: `ClinicSiteImage` ve `StoredFile` `DeletedAtUtc` taşır, okuma sorguları `DeletedAtUtc == null` ile süzer (açık süzgeç). Ücret/ödeme iptali ise adlı genel filtre `Voided` kullanır (ADR-040).
  - `Client` ve `Pet`'e başka varlıklarda gezinme özelliği yok; müşteri/hasta adı geçmiş kayıtlara (ödeme, ücret, muayene, defterler, rapor merkezi, HBS) yaklaşık 230 yerde açık birleştirme ya da kimlikle toplu okuma ile bağlanıyor.
  - Bakım kuralı tek ifadede: `Pet.ReceivesCare` (hatırlatma adayları, gecikmiş/yaklaşan aşı, operasyonel uyarılar, yeni randevu/geliş/muayene kapısı `EnsureCanStartCare`). Hatırlatma izni `Client.AcceptsReminders`.
  - Kiracıda e-posta + telefon için filtreli benzersiz indeks var.
  - Portal bağı `OwnerAccountClientLink` silinmez, `Close…` ile gerekçeli kapanır (ADR-041 K4).
  - Okuma modelleri (`ClientReadModels`, `PetReadModels`) liste/arama ve ad eşlemesi (ödeme listesi, rapor) için kullanılır; liste yolu tüm ortamlarda kapalı (`QueryReadModels:*Enabled=false`) ama projeksiyon çalışır.

## Kararlar

### K1 — Silme yumuşak silmedir; kalıcı silme yok

- Müşteri ve hastada `DeletedAtUtc` ve `DeletedByUserId`; hastada ek olarak `DeletedWithClient` (müşteriyle birlikte silindi). Satır ve tüm alanları veritabanında kalır.
- Kural tek yerde: `Client.Delete` / `Client.Restore`, `Pet.Delete` / `Pet.Restore`. Aktif kayıt koşulu `Client.NotDeleted` ve `Pet.NotDeleted` ifadeleridir.
- **Genel sorgu filtresi kullanılmaz.** Gerekçe: müşteri/hasta adı geçmiş kayıtlara açık birleştirmeyle bağlanıyor. Genel filtre bu birleştirmelerde ödeme, muayene ve defter satırlarını düşürür ya da adı boşaltır. Kimlikle okuma (`GET /clients/{id}`) da geçmiş bağlantıdan açılan kartı 404 yapar. Bunun yerine "aktif yüzey" sorguları ortak ifadeyi açıkça uygular (`ClinicSiteImage` deseni).
- Kalıcı silme akışları (içe aktarma geri alması, örnek klinik temizliği) değişmez; onlar sistemin kendi yazdığı kaydı geri alır.

### K2 — Silinen kayıt nerede görünmez, nerede görünür

- **Görünmez:** müşteri ve hasta listeleri ve aramaları (panel seçicileri bu listeleri kullanır), AI hasta arama, özet sayıları ve son kayıtlar, hatırlatma adayları (otomatik ve elle), gecikmiş/yaklaşan aşı listeleri ve operasyonel uyarılar (`Pet.ReceivesCare` silinmeyi de kapsar), portal hasta listesi ve hasta ayrıntısı, mükerrer kayıt denetimi.
- **Görünmeye devam eder:** geçmiş kayıtlar ve raporları (randevu, muayene, aşı, tedavi, reçete, lab, görüntüleme, yatış, ücret, ödeme, satış, belge, e-belge, kasa, defterler, HBS, rapor merkezi, borç raporu), bu listelerin ad araması, tam veri dışa aktarma. Ad ve hasta bilgisi bu yüzeylerde aynen görünür.
- **Dış API (TIER-009):** silinen müşteri ve hasta listede kalır, `deletedAtUtc` dolu gelir. Gerekçe: eşitleyen sistem silmeyi ancak böyle görür; kaydı listeden düşürmek karşı tarafta eski kaydı sonsuza dek bırakır.
- Kart kimlikle açılır: `GET /clients/{id}` ve `GET /pets/{id}` silinen kaydı `deletedAtUtc` dolu olarak döner. Panel kartta "Silindi" bandı gösterir.

### K3 — Silinen kayda yeni iş yazılmaz

- Silinen müşteride düzenleme, KVKK rıza işareti, yeni hasta, ücret, ödeme ve satış reddedilir: `409 Clients.Deleted`.
- Silinen hastada düzenleme, durum değişikliği, yeni randevu, geliş, muayene ve yatış reddedilir: `409 Pets.Deleted`. Randevu/geliş/muayene kapısı `EnsureCanStartCare` olduğu için kural orada yaşar.
- Var olan kayıtların düzeltme ve iptal akışları (ücret/ödeme iptali, e-belge iptali, düzeltme izinleri) açık kalır: geçmişin düzeltilmesi engellenmez.
- Diğer klinik kayıt girişleri (aşı, tedavi, reçete, lab, görüntüleme, uygulama) ilk dilimde ayrı API kapısı almaz. Bunlar açık muayene/geliş bağlamından ya da hasta seçiciden açılır; seçici silinen hastayı göstermez ve aktif yatış/gelecek randevu varken hasta silinemez (K5).

### K4 — Müşteri silinince hastaları da silinir

- Müşterinin silinmemiş tüm hastaları aynı işlemde (tek `SaveChanges`, ADR-039) `DeletedWithClient = true` ile silinir. Gerekçe: sahibi listede olmayan hasta seçicide ve hatırlatmada kalamaz; E-Vet'te hasta müşteri kartına bağlı.
- Daha önce tek başına silinmiş hastaya dokunulmaz.
- Hasta tek başına da silinebilir; müşteri kalır.

### K5 — Engeller: açık hesap, aktif yatış, gelecek randevu

Silme şu durumlarda `409 Clients.DeleteBlocked` / `409 Pets.DeleteBlocked` ile reddedilir. Yanıt nedenlerin tamamını tek seferde listeler (`reasons`), kullanıcı hepsini birden görür:

- **Açık hesap** (yalnız müşteri): kalan borçlu ücret (devir borcu dahil), tahsis edilmemiş ödeme ya da açık kredi (devir alacağı dahil). Hesap kiracı genelinde değerlendirilir. Gerekçe: kapanmamış alacak/verecek listeden kaybolursa tahsil ve iade izlenemez; E-Vet'in "ilişkisi vardır" engeliyle aynı aile.
- **Aktif yatış** (müşterinin herhangi bir hastası ya da silinen hasta): taburcu edilmemiş, iptal edilmemiş yatış.
- **Gelecek planlı randevu**: zamanı gelmemiş `Scheduled` randevu. **Engellenir, otomatik iptal edilmez.** Gerekçe:
  - Silme tam geri alınabilir kalmalı; otomatik iptal geri yüklemeyle geri gelmez.
  - İptal sahibine bildirim ve bekleme listesi teklifi tetikleyebilir; bunun kararı kullanıcınındır.
  - İptal nedeni kullanıcının seçtiği bir kayıttır; sistem uyduramaz.
- Peşin müşteri (doğrudan satış sistem kaydı) silinemez: `400 Clients.WalkInReadOnly` (mevcut kod).
- Vefat etmiş hasta silinebilir (engel değildir).
- Zaten silinmiş kaydı silmek ve silinmemiş kaydı geri yüklemek işlem yapmadan başarı döner (tekrar deneme güvenli).

### K6 — Geri yükleme: "Silinenler" listesi, süre sınırı yok

- Panelde Müşteriler ve Hastalar sayfasında "Silinenler" görünümü. Yönetici buradan geri yükler.
- **Süre sınırı yok.** Gerekçe: kayıt zaten veritabanında; otomatik kalıcı silme kullanıcı kararıyla çelişir ve arka plan işi gerektirir. Yanlış silme aylar sonra fark edilebilir (ör. hasta yeniden geldiğinde).
- Müşteri geri yüklenince onunla birlikte silinen hastalar da geri gelir; tek başına silinmiş hastalar silinmiş kalır.
- Hasta, müşterisi silinmişken geri yüklenemez: `409 Pets.ClientDeleted` ("Önce müşteriyi geri yükleyin").
- Aynı e-posta + telefonla aktif bir müşteri varsa geri yükleme reddedilir: `409 Clients.RestoreConflict`. Benzersiz indeks yalnız silinmemiş müşterilerde geçerli olur; silinen müşterinin bilgileriyle yeni kayıt açılabilir.
- Geri yükleme portal bağını açmaz (K9).

### K7 — KVKK: yumuşak silme KVKK silmesi değildir

- Yumuşak silme kaydı günlük işten kaldırır; kişisel veri **silinmez ve anonimleştirilmez**. Veri veritabanında, yedeklerde (ADR-014 K2) ve tam veri dışa aktarmada kalır.
- KVKK m.11 silme/anonimleştirme talebi ayrı akıştır: hasta sahibi veri talebi (PORTAL-007) ve kliniğin saklama ve imha politikası. Klinik verisinde anonimleştirme, ADR-041'deki hesap anonimleştirme desenine benzer ayrı bir kararla gelir.
- Panel onay metni bunu söyler: "Kayıt listelerden ve hatırlatmalardan kalkar. Muayene, ödeme ve belgeler korunur. Yönetici 'Silinenler'den geri yükleyebilir. KVKK silme talebi için bu işlem kullanılmaz."

### K8 — Yetki: yeni `Clients.Delete` ve `Pets.Delete`

- Silme, "Silinenler" listesi ve geri yükleme aynı izinle: müşteride `Clients.Delete`, hastada `Pets.Delete`.
- Varsayılan roller: işletme yöneticisi (`Admin`, `Owner`) ve klinik yöneticisi (`ClinicAdmin`). Hekim (`Veteriner`) ve sekreter (`Sekreter`) varsayılan olarak almaz; rol yönetiminden verilebilir.
- Gerekçe: silme listeleri ve hatırlatmayı etkiler, geri yükleme yönetici işidir; düzeltme izinleriyle (`*.Correct`) aynı yönetici düzeyi. Mevcut `Update` izinlerini genişletmek sekreterin silmesine yol açardı.
- Seed: `RolePermissionBindings` + açılıştaki idempotent izin tohumlaması; ayrı veri betiği gerekmez.

### K9 — Portal bağı kapanır

- Müşteri silinince aktif tüm portal bağları yeni gerekçe `ClientDeleted` ile kapanır (ADR-031, ADR-041 K4 bağ kapatma). Bağ satırı ve aydınlatma onay zamanı korunur. Panel müşteri kartında portal durumu "Müşteri silindi" gösterir.
- Geri yükleme bağı açmaz; klinik yeniden davet eder (ADR-041 K6 ile aynı kural).
- Silinen hasta portalda listelenmez ve ayrıntısı açılmaz; geri yüklenince yeniden görünür.

### K10 — Vefat ayrı kalır

- Vefat (`PetStatus.Deceased`) yaşam durumudur, silme değildir: vefat eden hasta listede "Vefat" olarak görünür ve geçmişi açıktır. Silme yanlış/mükerrer kaydın kaldırılmasıdır. İkisi ayrı alanlarda tutulur, birbirine dönüşmez.

### K11 — Okuma modeli ve olaylar

- Yumuşak silme ve geri yükleme mevcut `client.updated.v1` / `pet.updated.v1` olayını yeni `isDeleted` alanıyla üretir. Okuma modeli satırı **silinmez**, `IsDeleted` taşır. Liste ve metin araması silinenleri dışlar; kimlikle ad eşlemesi dışlamaz (geçmiş listelerde ad kalır).
- `client.deleted.v1` / `pet.deleted.v1` yalnız kalıcı silme (içe aktarma geri alması, örnek klinik) içindir.
- Kayıt geçmişi (`IChangeTracked`, RECORD_HISTORY) silme ve geri yükleme alan değişimini kendiliğinden yazar; kim sildi `DeletedByUserId`'dedir.

## Sonuçlar

- **Artı:**
  - Yanlış/mükerrer kart günlük işten kalkar; geçmiş, finans ve yasal defterler bozulmaz.
  - Silme tam geri alınabilir; veri kaybı yok.
  - Bakım ve hatırlatma dışlaması mevcut tek kurala (`ReceivesCare`) eklenir; yeni bir dışlama yeri açılmaz.
- **Eksi ve riskler:**
  - Açık süzgeç, yeni bir "aktif yüzey" sorgusunda unutulabilir. Azaltma: ortak ifade (`NotDeleted`) ve entegrasyon testleri; yeni liste/seçici sorgusu yazan ajan bu ADR'ye bakar.
  - K3'teki kapı her yazma ucunda yok; silinen hastaya doğrudan API ile aşı/tedavi girilebilir. Arayüzden açılamaz. Gerekirse sonraki dilimde ortak hasta kapısına taşınır.
  - Migration gerekir: müşteri ve hastaya silme sütunları, benzersiz e-posta+telefon indeksine `DeletedAtUtc IS NULL` koşulu; Query DB'de okuma modellerine `IsDeleted`. Yerel DB'de denenir; canlıya kullanıcı onayıyla.
- **Kapsam dışı:**
  - KVKK anonimleştirme (K7).
  - Mükerrer müşteri birleştirme (merge): ayrı iş.
  - Silinen kayıtlar raporu (DaySmart "Deleted Transactions" benzeri): "Silinenler" listesi ilk dilimde yeterli.
  - Silme gerekçesi alanı: rakiplerde gözlenmedi; kayıt geçmişi kim/ne zaman bilgisini tutar.

## Uygulama sırası (önce backend)

1. **Sözleşme:** backend `docs/CLIENT_PET_DELETION_API_CONTRACT.md`: `DELETE /clients/{id}`, `POST /clients/{id}/restore`, `GET /clients/deleted`; hasta için aynı üçlü; hata kodları ve `reasons`.
2. **Domain:** silme alanları, `Delete`/`Restore`, `NotDeleted`, `ReceivesCare` genişlemesi, `EnsureCanStartCare` → `Pets.Deleted`, bağ kapatma gerekçesi `ClientDeleted`. Domain testleri.
3. **Kalıcılık:** yapılandırma, komut DB migration'ı, Query DB migration'ı (yerel DB).
4. **Uygulama:** komutlar, engel okuyucusu, aktif yüzey süzgeçleri, yazma kapıları, izinler ve rol bağları, olay/projeksiyon.
5. **Entegrasyon testleri:** listede/aramada yok, hatırlatma gitmez, bağlı muayene/ödeme okunur ve adı görünür, engeller, geri yükleme, izin.
6. **Panel:** kartta "Sil" (onay metni K7), 409 nedenlerinin gösterimi, "Silinenler" görünümü ve geri yükleme, kartta "Silindi" bandı.
