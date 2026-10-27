# ADR-039 — Repository'ler kaydetmez: komut başına tek commit

## Durum

**Taslak (2026-10-27).** Kullanıcı Seçenek A'yı onayladı: "Seçenek A ile başla. ADR-039 taslağını da yaz." Uygulama backend `refactor/b1-unit-of-work` dalında; main'e alınmadı.

## Bağlam

- Denetim B1 (KOD-INCELEME 2026-10-24 ve 2026-10-27): `EfRepository<T>` Ardalis `RepositoryBase<T>`'yi override'sız sarıyordu.
  - Ardalis.Specification.EntityFrameworkCore 9.3.1'de `AddAsync`, `AddRangeAsync`, `UpdateAsync`, `UpdateRangeAsync`, `DeleteAsync`, `DeleteRangeAsync` her çağrıda `SaveChangesAsync` çalıştırıyor. Paket IL'i tarandı; hepsi `virtual`.
- Bu yüzden çok yazımlı bir komutun her yazımı ayrı commit'ti. Korunması `TransactionBehavior`'a bağlıydı: komutun `ITransactionalRequest` ya da `ITransactionalRollbackOnFailureRequest` ile işaretlenmesi gerekiyordu. İşareti unutan yeni handler yarım kayıt bırakabiliyordu.
- Ölçüm (main 3cdccd59):
  - 179 komutun 31'i işaretli.
  - Gerçek bölünmüş commit örneği: `CreateClient`, `UpdateClient`, `CreatePet`, `UpdatePet`, `CreateAppointment`, `UpdatePayment`, `EnsureWalkInClient`. Önce varlık kaydediliyor, entegrasyon olayı (outbox) ikinci kayıtta yazılıyor. Kodun yorumu iki yazımı "aynı SaveChanges/transaction sınırında" sayıyordu; doğru değildi.
- Elenen seçenek B: `Command` ile biten her isteği varsayılan transaction'a almak, `INonTransactionalRequest` ile dışarıda bırakmak.
  - Küçük bir değişiklikti, ama kök neden yerinde kalıyordu (komut başına birden fazla SaveChanges).
  - Dış IO yapan handler'da dışarıda bırakmayı unutmak uzun transaction ve kilit demekti.
  - Komut/sorgu ayrımı yalnız ad kuralına dayanıyordu.

## Karar

1. **Repository yazımları kaydetmez.** `EfRepository<T>` yazım metotlarını override eder: değişiklik yalnız izleyiciye işlenir. Commit noktası handler'daki `SaveChangesAsync` çağrısıdır; `IUnitOfWork` ve `IRepository<T>.SaveChangesAsync` aynı DbContext'i kaydeder. Tek SaveChanges, EF'nin kendi transaction'ında atomiktir. Dönen `int` değerleri etkilenen satır sayısı değildir.
2. **Başarısız commit iş birimini düşürür.** `EfUnitOfWork` ve `EfRepository` tek yardımcıdan (`UnitOfWorkCommit`) kaydeder. `DbUpdateException` (benzersizlik, eşzamanlılık) olursa izleyici boşaltılır. Böylece istisnayı yakalayıp yoluna devam eden handler, başarısız varlığı sonraki bir kayıtta yeniden yazmaz.
3. **Kayıt ağı.** Pipeline'ın en içine `UnsavedChangesGuardBehavior` girer. En dış istek başarılı döndüğünde izleyicide ya da outbox tamponunda kaydedilmemiş değişiklik kalmışsa `InvalidOperationException` fırlatılır. Sessiz veri kaybı yerine 500 alınır, transaction da geri alınır.
   - Başarısız `Result` dönen istekte bekleyen değişiklikler bilinçli olarak atılır.
   - İç içe `Send`'de yalnız en dış istek denetlenir.
4. **Ara commit açıkça yazılır.** Benzersizlik yarışını erken elemek (requestId), dış IO'dan önce satır bırakmak (dosya yükleme) ya da sonraki sorgunun yeni satırı görmesi gerekiyorsa handler `SaveChangesAsync`'i o noktada çağırır.
5. **İşaretler kalır, ama dar kapsamda.** `ITransactionalRequest` / `ITransactionalRollbackOnFailureRequest` yalnız iki durumda gerekir: birden fazla commit yapan orkestrasyon (iç `Send`, ara commit) ya da başarısız sonuçta geri alma. Tek commit yapan handler'ın işarete ihtiyacı yoktur.

## Sonuçlar

- Örtük kayda dayanan yerler açık `SaveChangesAsync` aldı:
  - 17 handler; bunların try blokları da dahil.
  - `catch (DbUpdate…)` ile benzersizlik/eşzamanlılık yakalayan 4 handler daha: `CreateExamination`, `CreateSale`, `CreateStockMovement`, `ReverseStockMovement`. Kayıt try bloğunun içine alındı.
  - Servisler: `OwnerPortalCodeService`, `OwnerPortalSessionIssuer`, `StoredFileMaintenanceProcessor`.
- `CreateExamination` artık muayene, geliş ve randevu tamamlamayı tek commit'te yazıyor.
- Yeni kural: handler yazımdan sonra `SaveChangesAsync` çağırır. Unutulursa kayıt ağı testte ve üretimde 500 ile yakalar.
- Eşzamanlılık (RowVersion) ve benzersizlik istisnaları artık `Add/Update` satırında değil `SaveChangesAsync` satırında fırlar. Yakalayan kod kaydı try bloğuna almalıdır.
- Kaydedilmemiş satır sorgularda görünmez. Eklenen satırı sorgulayacak kod önce kaydeder.
- Ardalis varsayılanından sapma `EfRepository` belgesinde yazılıdır. Paket güncellemesinde yeni bir yazım metodu eklenirse override edilmelidir.
- Kabul ölçütü: build 0/0; Domain, Application ve tam entegrasyon paketi geçer. Bölünmüş commit ve kayıt ağı için yeni entegrasyon testleri eklendi (`UnitOfWorkIntegrationTests`).
- Doğrulama (2026-10-27, backend 4110d6cc):
  - Build 0/0; Domain 720/720, Application 3656/3656.
  - Tam entegrasyon, yeni testler eklenmeden önce: 1644 geçti, 0 düştü, 2 atlandı.
  - Tam entegrasyon, son hâl: 1648 geçti, 1 düştü, 2 atlandı. Düşen `Concurrent_Same_RequestId_Out_On_Existing_Batch...`. Main'de de var olan çift düşüm yarışı; düzeltmesi `fix/stok-partisi-esz-idempotency` dalında. Tek başına 5 koşunun 4'ünde geçti.
- O dal `CreateStockMovement` / `ReverseStockMovement`'ı "önce hareketi tek başına yaz" desenine çeviriyor. Bu ADR ile birleştirilirken hareketin `AddAsync`'inden hemen sonra `SaveChangesAsync` çağrılmalıdır; aksi hâlde hareket artık tek başına yazılmaz.
- Doğrulanmayan: entegrasyon testi olmayan handler'larda gizli örtük kayıt bağımlılığı. Kayıt ağı bunu ilk başarılı çağrıda yakalar.
