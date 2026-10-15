# Koordinatör devir notu (2026-10-12) — ESKİ, güncel olan: roadmap/DEVIR-2026-10-15.md

Yeni koordinatör oturumu bu dosyayı, `CLAUDE.md`, `roadmap/AJAN-KUYRUGU.md` ve `decisions/` altındaki ADR'leri okuyarak başlar. Bu not **durum özetidir**; ayrıntı kaynak dosyalardadır.

## Rol ve çalışma biçimi
- Koordinatör ürün kodu yazmaz. Backend/frontend ajan oturumlarına görev verir (`SendMessage`, `spawn_task` kartları; yeni oturumu kullanıcı kart tıklayarak başlatır), raporlarını `list_events` ile okur, kullanıcıya **sade Türkçe** ve **karar maddeleri** getirir (`AskUserQuestion`).
- Ajanlar bittiğinde otomatik haber vermez: kullanıcı "bitti mi/ne durumdayız" demeden de proaktif kontrol et.
- Kullanıcı, ajan sorularının kendi penceresine değil bu oturuma getirilmesini ve rakip karşılaştırmalı sade açıklamayı ister. Rapor kısa, doğrulanmayan açıkça yazılır.

## Değişmez kurallar
- Backend sözleşmesi tek doğruluk kaynağı; önce backend, sonra frontend.
- Feature branch, dosyalar tek tek eklenir (`git add -A` yok), ayrı commit'ler.
- Kullanıcı açık onayı olmadan: **push, main'e merge, migration uygulama (yerel dev DB dahil, onay migration başına ve kullanıcıdan doğrudan), deploy, ADR gerektiren ürün kararı.** Ajanlar arası aktarılan onay geçerli sayılmaz.
- Doğrulanmamışı doğrulanmış söyleme. Gizli bilgi maskele, kimlik bilgisini sohbete yazma (test hekimi/diğer test kimlikleri backend `DevTestVeterinarianSeeder.cs` içinde).
- Ekonomi: Pro plan. Haftalık %45–60 kullanım normaldi; en fazla 3 paralel ajan. Uzun şişen oturumlara yeni iş yığma: tek konulu yeni oturum aç.
- Windows PowerShell 5.1: `&&` yok. Classifier merge/push'u engellerse atlatma, kullanıcıya komut ver.

## Depolar ve git durumu (hiçbiri push edilmedi)
- Ürün: `C:\Vetinity\vetinity-product`, `main` push edilmedi (origin'in 6 commit ilerisinde), `.claude/` izlenmiyor (launch.json).
- Backend: `C:\Users\DELL\source\repos\Veteriner`, `main` = `ca254b5`, origin'in 50 commit ilerisinde. Aşama 3 (Charge, PaymentAllocation, bakiye, Bugün tutarları), dev örnek veri komutu, Aşama 4 (özet, timeline, Finalize, addendum) **yerel main'e birleşti**.
- Frontend: `C:\FrontEnd\veteriner-frontend`, `main` = `cc8aae8`, origin'in 103 commit ilerisinde (Ücret, ortak arama ve tarih bileşenleri, Bugün düzeltmeleri, Klinikler düzeltmesi, Aşama 4 arayüzü birleşti). `src/app/features/subscriptions/utils/subscription-access.utils.ts` kullanıcıya ait **commit dışı değişiklik: asla commit'leme/geri alma/stash**.
- Açık frontend dalı: `fix/ui-rotuslar-2` (ajan oturumu `local_8387306a...` çalışıyor; birleşmedi).

## Çalışan ortam (yerel)
- Backend 7173: birleşik main'den, gizli arka plan süreci (log: `%TEMP%\vet-api.out.log`). Frontend 4200: ana depodan `npm start`, gizli süreç. İkisi de `preview_start` kapsamında değil; bilgisayar yeniden başlarsa tekrar başlat. `.claude\launch.json` backend için ana depoyu, frontend için eski worktree yolunu gösterebilir: kontrol et.
- Dev DB: `DESKTOP-2U2UUHO` / `VetinityCommandDb` (Windows auth). Üç dalın migration'ı uygulanmış durumda. İzin seed'i birleşik koddan **bir kez** çalıştırıldı. **Seed uyarısı:** farklı dallardan `DbMigrator seed` izinleri birbirinden siler; seed yalnız birleşik main'den çalıştırılır. Yeni izin sonrası kullanıcı çıkış-giriş yapmalı.
- Query DB sağlık kontrolü `/health` 503: pet projeksiyonunda bekleyen olaylar (okuma bayrakları kapalı, uygulamayı etkilemiyor, ayrıca temizlenecek).
- Claude in Chrome bağlı (kullanıcının gerçek Chrome'u). Ajanlar yalnız localhost, kendi sekmesi, çıkış yapmadan kullanır.
- Dev örnek veri: `DbMigrator seed-dev-sample-data` (ÖRNEK ücret/ödeme/randevu). Gelmedi testi için geçmiş saatli randevular klinik açıkken (≥ 11:00) komut tekrar çalıştırılarak oluşur. Bir ajan ayrıca "TEST …" ön ekli müşteri/geliş/ücret/ödeme kayıtlarını kullanıcının oturumuyla API'den oluşturdu.

## Tamamlanan (yerel main'de)
Aşama 1 (muayene), Aşama 2 (Bugün, Visit modeli, hızlı kayıt, Gelmedi, hayvan uyarıları, Acil), Aşama 3 backend Dilim 0–3 + Bugün tutar alanları (`chargedAmount/allocatedAmount/outstandingAmount/clientOutstandingAmount`), Aşama 3 frontend Ücret arayüzü, Aşama 4 backend (özet, timeline, Finalize, ek not) ve frontend arayüzü.

## Sıradaki işler (öncelik sırası)
1. **Frontend düzeltme listesi** (ajan çalışıyor): muayene tarihi saat dilimi tutarsızlığı (detay 11.10 01:00, liste 10.10, **gerçek hata**), sekme başlığı hep "Giriş yap", filtre satırı (dar tarih alanı, tek çerçeve), hayvan detayında boş alanları katla. Biten iş entegrasyon oturumuyla main'e alınır.
2. **Ödeme ekranı + Bugün'de ücret/ödenen/kalan (frontend Dilim 4)**: yeni temiz oturum. Backend sözleşmeleri: `docs/PAYMENT_ALLOCATION_API_CONTRACT.md`, `CLIENT_BALANCE_API_CONTRACT.md` (bölüm 7: Bugün alanları). Eski ödeme formu yeni kurala (requestId + tahsis zorunlu) uymuyor; muayene sayfasındaki "Ödeme Oluştur" düğmesi bu yüzden şimdilik hata verir. Bugün'deki "Ödeme kaydı yok" rozeti eski bağlantıya bakıyor, yeni alanlara bağlanacak.
3. **Dilim 5**: ücret/ödeme düzeltme, iptal, audit (`Charges.Correct`, `Payments.Correct`).
4. Kullanıcı testleri: Aşama 4 (ek not, kilitli düzenleme ekranı, hayvan timeline bağlantısı), Gelmedi gerçek senaryosu.
5. Aşama 4 küçük eksikler: timeline'da geliş satırı tıklanmaz, tarih aralığı süzgeci yok. Derleme uyarısı `UpdatePaymentCommandHandler.cs:254`. ESLint uyarı temizliği ayrı iş. Aşama 5 (tedavi/reçete/stok) backend keşfi hafta sıfırlanınca.
6. Kullanıcı push onayı vermedi: "ben kontrol ettikten sonra push ederiz". Push yalnız açık onayla.

## Kararlar (özet)
ADR-009 Visit modeli, ADR-010 NoShow, ADR-011 hayvan uyarıları, ADR-012 ücret/ödeme (TRY, tahsis zorunlu, requestId zorunlu, düzeltme yönetici düzeyi, FIN-005..009 ertelendi). Aşama 4: kesinleştirince kilit + yalnız ek not; yeniden aç/revizyon ertelendi ([RECORD-007](../backlog/feature-backlog.md)); kilo muayeneden türetilir; tek özet ucu bölüm bazlı durum; timeline kapsamı muayene/tedavi/reçete/lab/aşı/yatış/geliş, ödeme sonra, iptaller varsayılan gizli; eski muayeneler Taslak. Bugün tutarları Veteriner de görür. Yeni randevuda geçmiş saat seçilebilir (backend ile hizalı, en fazla 7 gün). Menü ve genel yapı yeniden düzenlemesi **Aşama 8'de** (kullanıcı 2026-10-12'de plana uyma kararı verdi); pilotta menü karmaşası şikâyeti gelirse öne çekilir.

## Kullanıcı tercihleri
Sade Türkçe, kısa raporlar, karşılaştırmalı rakip anlatımı, soruların bu oturuma getirilmesi, "en doğrusu neyse onu yap" (hızlı sürüm değil, kalıcı çözüm), ertelenen işlerin backlog'a yazılması (unutulmasın). Hata/UX bulgularını ekran görüntüsüyle atar; ajanlara iletilip bu oturumda özetlenir.

## Arşivlenen oturumlar
Aşama 1–2 ve "Bugün iyileştirmeleri" oturumları, Aşama 4 keşfi, Aşama 3 backend (Dilim 0–3), dev örnek veri, Aşama 4 backend (okuma, kesinleştirme), Aşama 4 frontend ve iki entegrasyon oturumu: işleri main'de. Dallar depolarda duruyor. Açık: `local_8387306a-363d-4b6e-b86e-643cc29b2732` (frontend düzeltmeleri).
