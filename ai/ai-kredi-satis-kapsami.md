# Yapay zekâ: klinik ayarı ve ek kredi satışı — kapsam (TIER-013)

**Durum:** Kararlar alındı (kullanıcı, 2026-11-28). Dilim 1 geliştirildi (2026-11-28): BE `feature/ai-klinik-ayari` (`bd15662d`, `2f7b86a8`, `f63933d1`), FE `feature/ai-klinik-ayari` (`591c8927`, `7cc708d0`, `d8032fbe`, `4293be93`). Main'e birleşmedi, push yok. Migration `AddClinicAiAcknowledgement` yalnız yerel DB'de. Tarayıcıda yerel demo klinikte denendi (masaüstü ve 375 px). Dilim 2 ve 3 için kod yok. İlgili: [ADR-044](../decisions/ADR-044-ai-eklentisi-kredi-ve-fon.md), backlog TIER-013, TIER-014, AI-007, AI-008, TIER-001.

## Neden

AI kodu canlıda (AI-007/008, 2026-11-20): klinik başına aylık paket hediyesi (Temel 0, Profesyonel 500, Kurumsal 2.000; denemede 0), fon, %80 ve bitiş uyarısı, maliyet sınırları. Ancak:

- AI'yi kliniğin kendisi açamıyor. Açma ve fon ekleme yalnız platform yöneticisinde (`/panel/ai-admin`, `api/v1/admin/ai`). Demo klinikte de sunucu tarafında açıldı.
- Klinik kredi satın alamıyor. `BillingCheckoutSession` yalnız paket aboneliği için yapılmış. iyzico canlı anahtarı yok (`operations/CANLI-ISLETIM-KILAVUZU.md`).
- Klinik yalnız Ayarlar ana sayfasındaki kartta bu ayın yüzdesini görüyor (`ai-clinic-usage-card`). Kalan kredi, fon ve geçmiş görünmüyor.

## Kullanıcı kararları (2026-11-28)

| # | Konu | Karar |
|---|---|---|
| K1 | AI'yi kim açar | Klinik yöneticisi kendi kliniğinde açar ve kapatır (`Clinics.Update`: Admin, Owner, ClinicAdmin). İlk açılışta bir kez bilgilendirme kabul edilir. Platform yöneticisi yine kapatabilir |
| K2 | Ne satılır | Tek seferlik ek kredi paketleri, üç boy (örnek 1.500 / 5.000 / 20.000). Büyük pakette kredi başına fiyat daha düşüktür. Aylık eklenti yok. Otomatik para çekilmez |
| K3 | Ödeme yolu | İki yol birlikte yapılır. Havale yolu: klinik talep gönderir, platform yöneticisi elle fatura keser ve "Ödendi" deyince kredi otomatik eklenir. Kart yolu: iyzico'da tek seferlik ödeme, sandbox'ta uçtan uca denenir. Kart seçeneği canlı anahtar girilince görünür |
| K4 | Kredi ömrü | Satın alınan kredi 12 ay geçerlidir ve iade edilmez. Önce süresi en erken dolan harcanır. Teknik hatada kredi düşmez (mevcut kural) |

TL fiyatları backend ayarında tek yerde durur (ADR-044 madde 9). Rakamları kullanıcı yayından önce ayrıca onaylar. Fiyatı girilmemiş paket listelenmez. Örnek fiyatlar (ADR'deki kredi değeriyle, KDV hariç): 1.500 kredi $5, 5.000 kredi $15, 20.000 kredi $50.

## Çalışma varsayımları (mevcut desenden; itiraz yoksa geçerli)

- **Satın alma yetkisi** `Subscriptions.Manage` (Admin, Owner), yani abonelik ödemesiyle aynı. Klinik yöneticisi paketleri görür, ama satın alma düğmesi yerine "Satın almayı işletme sahibi yapar" yazar.
- **Kredi klinik başınadır**, bugünkü fon gibi. Birden çok kliniği olan işletme her klinik için ayrı alır.
- **Elle eklenen fon süresizdir.** Bugünkü kayıtlar da süresiz kalır. 12 ay kuralı yalnız satın alınan krediye uygulanır.
- **Denemede satın alma açıktır.** Denemede paket hediyesi 0'dır ama fon çalışır. Süresi dolmuş, salt okunur abonelikte satın alma kapalıdır (mevcut yazma koruması).
- **Havale bilgisi panelde gösterilmez.** Fatura ve ödeme bilgisi e-postayla gönderilir. Aynı klinikte aynı anda en çok bir açık havale talebi olabilir.
- **Bilgilendirme metni kısadır:** veri yurt dışındaki sağlayıcıya gider, kimlik bilgisi mümkün olduğunca gönderilmez, çıktı taslaktır ve hekim kontrol eder. Metin sürüm numarasıyla kaydedilir; kimin ne zaman kabul ettiği tutulur.
- **Sitede yazılmaz.** Satış çalışmadan paketler sayfasına satır eklenmez (ADR-034 karar 6).

## Kapsam

### 1. Klinik ayarlarında "Yapay zekâ" sayfası (`/panel/settings/ai`)

Ayarlar > Klinik ve kurum altında bir kart. Sayfayı `Clinics.Read` yetkisi olan görür.

- **Durum:** açık ya da kapalı. Kullanılamıyorsa nedeni tek cümleyle yazılır: sistemde kapalı, sistem bütçesi doldu ya da kredi bitti.
- **Bu ay:** paket kredisi, harcanan, kalan, satın alınan kredi bakiyesi ve yenilenme günü. Harcama sırası tek cümleyle anlatılır. Dolar gösterilmez.
- **Aç/kapa:** yalnız `Clinics.Update` yetkisi olan görür. İlk açılışta bilgilendirme penceresi çıkar. Kapatmak veriyi silmez.
- **Kredi geçmişi:** satın alma ve elle eklemeler, her birinin kalanı ve son geçerlilik tarihi. Platform yöneticisinin iç notu gösterilmez.
- **Ek kredi** (Dilim 2'den sonra): üç paket kartı ve ödeme yolu (havale; kart canlıysa kart). Açık talebin durumu görünür ve iptal edilebilir.
- **Bağlantılar:** Ayarlar ana sayfasındaki kullanım kartı, AI düğmesinin "kapalı" ve "kredi bitti" durumları ve %80 / bitiş bildirimleri bu sayfaya götürür.

### 2. Ek kredi satın alma akışı

1. Klinik bir paket seçer. Fiyat sunucudan okunur.
2. **Havale:** sipariş "Ödeme bekleniyor" durumuna geçer ve platform yöneticisine bildirim gider. Yönetici `/panel/ai-admin` > Kredi talepleri ekranında faturayı elle keser, ödeme gelince "Ödendi" der. Kredi 12 ay geçerli olarak eklenir. Yönetici gerekçe yazarak reddedebilir.
3. **Kart:** sipariş bir iyzico oturumu açar. Ödemenin imzası doğrulanan bildirimi (webhook) gelince kredi eklenir. Aynı bildirim iki kez gelirse kredi iki kez eklenmez. Çift ödeme mevcut iade akışına girer (BILL-005).
4. Kredinin eklendiği kliniğin yöneticilerine bildirim gider.

### 3. Backend uçları ve migration

Sözleşme backend'de `docs/AI_HISTORY_SUMMARY_API_CONTRACT.md`'ye yeni bölüm olarak eklenir (ya da ayrı `AI_CREDITS_API_CONTRACT.md`). Önce backend, sonra panel.

**Klinik uçları** (ayar uçları portal ve online randevu ayarları gibi klinik kimliğini adreste alır; sipariş uçları aktif kliniğe yazar):

| Uç | İzin | Ne yapar |
|---|---|---|
| `GET /api/v1/clinics/{clinicId}/ai-settings` | `Clinics.Read` | Durum, kredi alanları (`/ai/status` ile aynı hesap), bilgilendirme metni ve sürümü, eklenen krediler. Dilim 2'de kredi dilimleri (kalan, son tarih), paketler, açık sipariş ve `cardPaymentAvailable` eklenir |
| `PUT /api/v1/clinics/{clinicId}/ai-settings` | `Clinics.Update` | `{ isEnabled, acknowledgementVersion }`. Açarken güncel sürüm kabul edilmemişse `400 Ai.AcknowledgementRequired`. Denetim kaydına yazılır |
| `POST /api/v1/ai/credit-orders` | `Subscriptions.Manage` | `{ packCode, paymentMethod: BankTransfer \| Card }`. Havalede sipariş döner; kartta `checkoutUrl` döner |
| `GET /api/v1/ai/credit-orders` | `Subscriptions.Read` | Kliniğin son siparişleri |
| `POST /api/v1/ai/credit-orders/{id}/cancel` | `Subscriptions.Manage` | Açık havale talebini iptal eder |

**Platform uçları (`api/v1/admin/ai`):** `GET credit-orders?status=`, `POST credit-orders/{id}/fulfill`, `POST credit-orders/{id}/reject { reason }`. Mevcut `PUT clinics/{id}` (aç/kapa) ve elle fon ekleme kalır.

**Kural yerleri:**

- Paket kataloğu `Ai:CreditPacks` ayarında durur: kod, kredi, TL tutar (kuruş).
- 12 ay ve "önce en erken süresi dolan" kuralı tek bir fon defteri hesabında yaşar. Fon kayıtları ve fondan harcanan kullanım kronolojik işlenir. Süresi dolanın kalanı düşer. Eksiye düşen bakiye sonraki kredi eklemesinde kapanır.
- Bugünkü "bakiye = eklenen − harcanan" hesabı bu deftere taşınır. `AiClinicQuota` ve `AiCreditAccount` defterin sonucunu kullanır. Tek kaynak kalır.
- Kart ödemesinde `BillingCheckoutSession`'a amaç alanı eklenir (abonelik ya da AI kredisi). Etkinleştirme bu alana göre siparişi tamamlar. Böylece webhook, sorguyla doğrulama, çift ödeme ve iade akışları ortak kalır. Bunun mevcut sağlayıcı arayüzüyle (`IBillingCheckoutProvider`) sorunsuz çalıştığı uygulamada doğrulanacak.

**Migration'lar** (yalnız yerel DB; canlıya kullanıcı onayıyla):

| Dilim | Migration | Değişiklik |
|---|---|---|
| 1 | `AddClinicAiAcknowledgement` | `ClinicAiSettings`: `AcknowledgedVersion`, `AcknowledgedAtUtc`, `AcknowledgedByUserId` |
| 2 | `AddAiCreditOrders` | Yeni `AiCreditOrders` tablosu: klinik, paket, kredi, tutar, para birimi, ödeme yolu, durum, açan, karar veren, gerekçe, fon kaydı. `AiCreditGrants`'e `ExpiresAtUtc` (boşsa süresiz) ve `OrderId` (benzersiz, boş olabilir) eklenir. `AiCreditGrantKind.Purchase = 2` |
| 3 | `AddBillingCheckoutPurpose` | `BillingCheckoutSessions`'a `Purpose` (varsayılan abonelik) ve `AiCreditOrderId` eklenir |

Yeni izin yok; mevcut izinler kullanılır.

## Dilimler

| Dilim | İçerik | Bağımlılık |
|---|---|---|
| **1** | Yapay zekâ sayfası: durum, kredi, kredi geçmişi (salt okunur), klinik aç/kapa ve bilgilendirme kabulü; bağlantılar | Yok |
| **2** | Paket kataloğu, havale talebi, platform yöneticisi talep ekranı, satın alınan krediye 12 ay ve "önce en erken süresi dolan" kuralı | Dilim 1; TL fiyatlar (kullanıcı) |
| **3** | iyzico kart ödemesi, sandbox'ta uçtan uca | Dilim 2; canlı anahtar gelince yalnız ayar değişir |

## İlk dilim planı (Dilim 1)

**Backend** (`feature/ai-klinik-ayari`, main'den ayrı çalışma ağacında):

1. `ClinicAiSettings`'e bilgilendirme kabulü eklenir: `SetEnabledByClinic(enabled, requiredVersion, acceptedVersion, userId, now)`. Güncel sürüm kabul edilmeden açılamaz. Migration `AddClinicAiAcknowledgement` yazılır.
2. Klinik uçları yazılır: `GetClinicAiSettingsQuery` ve `UpdateClinicAiSettingsCommand` (denetim kaydıyla). Bilgilendirme metni backend'de tek yerde durur (`AiAcknowledgement`). Kredi alanları mevcut `AiCreditAccount` hesabından gelir. Fon hareketleri kliniğe kendi kapsamında, iç not olmadan döner.
3. Platformun aç/kapa ucu aynen kalır. Ayar kaydını kimin değiştirdiği zaten tutuluyor.
4. Birim ve entegrasyon testleri yazılır: yetki (Sekreter ve Veteriner açamaz, `Clinics.Read` okur), kabulsüz açma, kiracı izolasyonu, yanıtta dolar olmaması.
5. Sözleşme güncellenir.

**Panel** (`feature/ai-klinik-ayari`, `C:\wt\main-fe`'den ayrı çalışma ağacında; backend bittikten sonra):

1. `/panel/settings/ai` sayfası ve Ayarlar kartı yapılır.
2. Durum, bu ay ve kredi geçmişi bölümleri, aç/kapa ve bilgilendirme penceresi eklenir.
3. Kullanım kartından, AI düğmesinin kapalı / kredi bitti durumlarından ve bildirimlerden sayfaya bağlantı verilir.
4. Birim testleri yazılır. Sayfa masaüstünde ve 375 px'te tarayıcıda denenir. Görünüm yayından önce kullanıcıya ayrıca gösterilir.

**Bitti sayılması için:** testler geçer, iki dal yerel main'e birleşir, migration yalnız yerel DB'dedir. Push ve yayın kullanıcı onayıyla yapılır.

## Kapsam dışı

- Aylık eklenti ve otomatik yenileme.
- Kullanıcı başına kota (ADR-044 D1 sayıları kodda yok; geçerli olan klinik başına paket hediyesi).
- Kendiliğinden kredi alma (otomatik yükleme).
- Sitede satış metni.
- İade akışı (iade yok; yalnız çift ödeme iadesi mevcut akışta).
