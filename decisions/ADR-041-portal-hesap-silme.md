# ADR-041 — Hasta sahibi portalında hesap silme: anonimleştirme ve bağ kapatma

## Durum

**Taslak (kullanıcı kabulü bekleniyor).** Öneri: seçenek C. İlgili: [ADR-031](ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) K4/K8 ve AK-4/AK-5, [ADR-029](ADR-029-surumlu-hukuki-kabul.md), [ADR-039](ADR-039-birim-is-tek-commit.md), [ADR-040](ADR-040-kiraci-izolasyonu-global-filtre.md); backlog [PORTAL-011](../backlog/feature-backlog.md#portal-011--portal-hesabını-silme-self-servis).

## Bağlam

- ADR-031 K4 "portal hesabını silme ayrı, klinik verisini silme klinik kararıdır" der ama akışı tanımlamaz. Portal sözleşmesi (backend `docs/PORTAL_API_CONTRACT.md` "kapsam dışı" bölümü) hesap silmeyi v1'e bırakmış.
- Hukuki metin taslakları silmeyi zaten vaat ediyor:
  - [Portal kullanım şartları](../legal/portal-kullanim-sartlari.md): "Hesabınızı istediğiniz zaman silebilirsiniz"; oturum, cihaz ve bildirim tercihi silinir, klinik kayıtları kalır.
  - [Portal gizlilik politikası](../legal/portal-gizlilik-politikasi.md) bölüm 6: hesap verileri silinince silinir; kabul kayıtları ispat için saklanır.
- Mağaza: ADR-031 AK-4 hasta sahibi uygulamasını mağazaya koyar. App Store ve Google Play, hesap açılan uygulamada uygulama içinden hesap silme başlatılmasını istiyor. Güncel kural mağaza başvurusundan önce resmî kaynaktan doğrulanmalı; bu belgede doğrulanmadı.
- Rakip gözlemi yok: DaySmart PetCare ve E-Vet incelemelerinde hasta sahibi hesap silme akışı gözlenmedi. Öneri genel sektör pratiğinden türetildi: self-servis silme, yeniden doğrulama, ne silinip ne kaldığını açıkça gösterme.
- **İki ayrı veri kümesi var:**
  - **Portal hesabı (kiracılar üstü, Vetinity tarafı):** `OwnerAccount` (e-posta, parola özeti, görünen ad, giriş zamanları, kilit sayaçları), `OwnerPortalRefreshToken`, `OwnerPortalCode`, hesaba bağlı `LegalAcceptance` satırları.
  - **Klinik kayıtları (kiracı, klinik tarafı):** `Client`, `Pet`, muayene, aşı, ücret, ödeme… Bunlara ek olarak portal izleri de kiracıdadır: `OwnerAccountClientLink` (davet eden, kapatma, aydınlatma metni onay zamanı) ve `OwnerPortalInvite` (gönderim anındaki müşteri e-postası).
- Mevcut kod (backend main `8ebbdf73`, salt okuma):
  - `OwnerAccount.Email` benzersiz ve zorunlu. `OwnerAccountStatus` yalnız `Active` / `Disabled`; `Disable()` var ama hiçbir uç çağırmıyor.
  - `OwnerAccountClientLink` → `OwnerAccount` ve `Client` FK'leri `Restrict`. Bağ silinmez, `Close(closedByUserId)` yalnız personelle çalışır.
  - Yenileme jetonu ve kod tabloları hesaba `Cascade` bağlı. `LegalAcceptance` hesaba FK'siz; yalnız denetim kısıtı var.
  - Portal erişimi her istekte hesabın `IsActive` durumundan ve bağdan çözülüyor (`OwnerPortalAccess`); bağ araması kiracılar arası `AsSystem()` ile yapılıyor (ADR-040).
  - Denetim kaydı (`AuditLogs`) IP ve tarayıcı bilgisini tutuyor; portal komutlarında hedef `OwnerAccountId=…`.

## Çalışma varsayımları (hukuki görüş beklenmeden; hukuk farklı derse yalnız işaretli madde değişir)

- **ÇV-1:** Portal hesabı verilerinin veri sorumlusu Vetinity'dir (portal gizlilik taslağıyla aynı; HUKUKI-ONAY-LISTESI C6, ADR-031 AK-5).
- **ÇV-2:** Klinik kayıtlarının veri sorumlusu kliniktir. Portal hesabının silinmesi bu kayıtları silmez, değiştirmez; saklama kliniğin politikasına ve mevzuata bağlıdır ([saklama ve imha politikası](../legal/saklama-ve-imha-politikasi.md)).
- **ÇV-3:** Hesabın kendi işlemiyle silinmesi KVKK m.11 başvurusu değildir; kişi istediği an yapar. Klinikteki veriler için başvuru ayrı yoldur (PORTAL-007 veri talebi).
- **ÇV-4:** Hukuki kabul kayıtları ispat amacıyla hesap silindikten sonra da saklanır. Satırda kimlik bilgisi yoktur, yalnız hesap kimliği (GUID) vardır. Süre hukukçu belirler (C6).
- **ÇV-5:** Denetim kayıtları (IP dahil) saklama politikasındaki süre boyunca kalır ([1–2 yıl], A5) ve hesap silinince ayrıca silinmez.
- **ÇV-6:** Silme onayı e-postası işlemsel iletidir, ticari ileti izni gerekmez.
- **ÇV-7:** Yedeklerdeki kopya, yedek saklama süresi dolunca kendiliğinden yok olur (ADR-014 K2: 30 gün); yedekten tek kayıt silinmez.

## Seçenekler

- **A. Anında fiziksel silme.** Hesap, jetonlar, kodlar, bağlar ve kabul satırları silinir.
  - Artı: en basit vaat ("hiçbir şey kalmaz").
  - Eksi: `Restrict` FK nedeniyle bağlar da silinmeli. Kliniğin tuttuğu iz kaybolur: kim davet etti, aydınlatma metni ne zaman onaylandı. Bu kliniğin kendi KVKK ispatıdır. Kabul kayıtlarının silinmesi ÇV-4 ile çelişir. Geri dönüşü yok.
- **B. Bekleme süreli silme (ör. 30 gün).** Hesap "silinecek" olur, giriş kapanır, süre sonunda bir arka plan işi A ya da C'yi uygular. Süre içinde kişi geri alabilir.
  - Artı: yanlışlıkla ya da ele geçirilmiş oturumla yapılan silme geri alınabilir.
  - Eksi: yeni durum makinesi, arka plan işi, hatırlatma e-postaları. Süre boyunca veri "silinmiş sayılır ama duruyor"; kullanıcıya ve hukuka anlatması zor. Geri alma değeri düşük: klinik aynı kişiyi tek tıkla yeniden davet edebilir.
- **C. Anında anonimleştirme + bağ kapatma (önerilen).** Hesap satırı kimliksiz bir iz olarak kalır, kişisel alanlar geri döndürülemez biçimde silinir, oturumlar ve kodlar silinir, tüm klinik bağları "hesap silindi" gerekçesiyle kapanır. Klinik kayıtlarına dokunulmaz.
  - Artı: vaat edilen her şey anında silinir. Kliniğin izi ve kabul kayıtları tutarlı kalır. Arka plan işi yok. E-posta serbest kalır; kişi yeniden davetle yeni hesap açabilir.
  - Eksi: geri alma yok (yeniden davet telafi eder). Ele geçirilmiş oturum riski yeniden doğrulamayla azaltılır.

## Karar (öneri: C)

1. **Kim, nereden:** yalnız hesap sahibi, portalda "Hesabım > Hesabı sil". Mağaza uygulaması aynı ekranı kullanır. Personel bir hasta sahibinin hesabını silemez; personelin aracı mevcut "erişimi kapat" (bağ kapatma) olarak kalır.
2. **Yeniden doğrulama:** silme, hesabın e-postasına gönderilen yeni tek kullanımlık kodla onaylanır (yeni kod amacı `AccountDeletion`; mevcut süre, deneme ve bekleme kuralları aynen). Parolalı hesapta da kod istenir: tek kural, kodla giren hesapta da çalışır.
3. **Silinenler (tek işlem, tek `SaveChanges`, ADR-039):**
   - `OwnerAccount` anonimleşir:
     - E-posta, parola özeti ve son giriş zamanı boşaltılır; görünen ad sabit "Silinmiş hesap" olur; kilit sayaçları sıfırlanır.
     - Durum yeni `Deleted` değerine geçer ve `DeletedAtUtc` yazılır. `Id` ve `CreatedAtUtc` kalır.
     - Kural tek yerde, `OwnerAccount.Delete(utcNow)` içinde yaşar.
   - Hesabın tüm `OwnerPortalRefreshToken` ve `OwnerPortalCode` satırları fiziksel olarak silinir.
4. **Kapananlar:** hesabın tüm aktif `OwnerAccountClientLink` satırları, kiracılar arası tek seferde (`AsSystem()`, izinli listeye eklenir) `Closed` olur. Kapatma gerekçesi alanı eklenir: `ClinicClosed` / `OwnerAccountDeleted`. Hasta sahibi kapatmasında `ClosedByUserId` boş kalır. Bağ satırı ve aydınlatma metni onay zamanı korunur.
5. **Kalanlar:**
   - Klinik kayıtları: değişmez (ÇV-2).
   - `LegalAcceptance` satırları: hesap kimliğiyle kalır (ÇV-4).
   - `OwnerPortalInvite`: kliniğin kaydı olarak kalır.
   - `AuditLogs`: politika süresince kalır (ÇV-5).
6. **Sonrası:**
   - `Deleted`, `Disabled` gibi pasif sayılır: giriş, kod, yenileme ve parola sıfırlama reddedilir. Yanıt, hesap yokmuş gibi genel kalır (e-posta numaralandırması yok).
   - Kalan kısa ömürlü erişim jetonu bağ kapsamlı uçlarda 404 alır, `me` ucu 401 döner.
   - Aynı e-postaya yeni davet gelirse yeni hesap açılır; eski bağlar kendiliğinden geri açılmaz.
7. **Klinik paneli:** müşteri kartındaki portal durumu "Hasta sahibi hesabını sildi (tarih)" gösterir. Klinik yeniden davet gönderebilir. Kliniğe ayrıca e-posta gitmez.
8. **Hasta sahibine bilgi:**
   - Silme ekranı, silinecekleri ve kalacakları sade dille sayar: klinik kayıtları kliniğin sorumluluğundadır. Ekranda bağlı kliniklerin iletişim bilgisi ve "klinikteki verilerim için talep" yolu gösterilir (PORTAL-007 hazır olana dek kliniğin iletişim bilgisi).
   - İşlem bitince eski adrese tek bir onay e-postası gider (ÇV-6). E-posta outbox'a silme işlemiyle aynı commit'te yazılır.
9. **Denetim:** `OwnerPortal.Account.Delete` eylemi, hedef `OwnerAccountId`. Yük ve hedefte e-posta yer almaz.

## Sonuçlar

- **Artı:**
  - Hukuki metin taslaklarındaki vaat karşılanır.
  - Mağaza koşulu için uygulama içi silme hazır olur.
  - Kliniğin KVKK izi bozulmaz.
  - Arka plan işi ve ek durum makinesi gerekmez.
- **Eksi ve riskler:**
  - Geri alma yok. Telafisi yeniden davettir; silme ekranı bunu açıkça yazar.
  - Migration gerekir: `Email` boş geçilebilir olur ve benzersiz indeks filtreli olur (`Email IS NOT NULL`); `DeletedAtUtc`, bağda kapatma gerekçesi ve boş geçilebilir `ClosedByUserId` eklenir. Migration yerel DB'de denenir; paylaşılan ya da üretim DB'ye kullanıcı onayıyla uygulanır.
  - `Email`'i zorunlu sayan okuma yerleri (personel tarafı portal durumu, davet önizleme, oturum üretimi) boş değeri ele almalıdır; tam entegrasyon paketi bunu yakalar.
  - Hukuk ÇV-4 ya da ÇV-5'i değiştirirse yalnız saklanan küme değişir. Akış ve uç değişmez.
- **Kapsam dışı:**
  - Klinikteki verilerin silinmesi ya da anonimleştirilmesi (KVKK talep süreci, PORTAL-007; ayrı karar).
  - Bekleme süresi ve geri alma.
  - Personelin hasta sahibi hesabını silmesi.
  - Push cihaz jetonları: MOBILE-003 eklendiğinde aynı silme kümesine girer.
- **Belgeler:** kabulden sonra portal gizlilik ve kullanım şartları taslaklarına "e-posta adresiniz silinir, aynı adresle yeniden davet alabilirsiniz" cümlesi eklenir (taslak uyarıları kalır). HUKUKI-ONAY-LISTESI C6 bu soruları zaten kapsıyor.

## Uygulama sırası (önce backend)

1. **Sözleşme:** backend `docs/PORTAL_API_CONTRACT.md`'ye uçlar ve hata kodları yazılır. Öneri:
   - `POST /api/portal/v1/me/deletion-code` → her durumda 204; bekleme süresindeyse yeni kod gitmez (mevcut `auth/code` deseni).
   - `DELETE /api/portal/v1/me` (gövde `{ "code": "123456" }`) → 204; geçersiz ya da süresi dolmuş kod 400 `Portal.Account.DeletionCodeInvalid`.
   - Personel tarafı `GET` portal durumuna kapatma gerekçesi eklenir.
2. **Domain:** `OwnerAccountStatus.Deleted`, `OwnerAccount.Delete`, `OwnerPortalCodePurpose.AccountDeletion`, `OwnerAccountClientLink.CloseByOwnerDeletion` ve kapatma gerekçesi. Domain testleri.
3. **Kalıcılık:** yapılandırma ve migration (yerel DB). `AsSystem()` izinli listesine silme komutu eklenir.
4. **Uygulama:** kod isteme ve silme komutları, denetim, onay e-postası, pasif hesap kontrollerinin `Deleted`'ı kapsadığının testi.
5. **Entegrasyon testleri:**
   - İki kiracıdaki bağların ikisi de kapanır.
   - Jeton ve kodlar silinir; kabul satırları kalır.
   - Silinen hesapla giriş genel hatayla reddedilir.
   - Aynı e-postayla yeniden davet yeni hesap açar.
   - Personel tarafında gerekçe görünür.
6. **Frontend:** portal "Hesabım > Hesabı sil" (bilgi, kod, son onay, çıkış) ve panel müşteri kartında durum metni.
7. **Belgeler:** backlog durumu, hukuki metin taslağı cümlesi, release notu.
