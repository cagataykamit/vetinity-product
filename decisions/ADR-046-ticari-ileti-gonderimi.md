# ADR-046 — Ticari ileti gönderimi

## Durum

**Kabul edildi (2026-11-08, kullanıcı kararı).** Kullanıcı: "kullanıcı epostaya izin verdiyse gönderebiliriz". Hukuki görüş alınmadı; aşağıdaki koşullar ajan araştırmasından gelir ([İYS ve Tarbil araştırması](../research/iys-ve-tarbil-arastirmasi-2026-11.md)) ve hukukçu onayına kadar çalışma varsayımıdır ([HUKUKI-ONAY-LISTESI](../roadmap/HUKUKI-ONAY-LISTESI.md) A4, C7).

İlgili: TIER-003 ("uzun süredir gelmedi" kuralı), TIER-012, ADR-031 (portal), ADR-035.

## Bağlam

TIER-003'ün "uzun süredir gelmedi" iletisi ticari elektronik ileti sayılır. Gönderim tek bir genel anahtarla (`MarketingSendingEnabled = false`) kapalıydı. Ticari ileti onayı portalda bağ başına kaydediliyor (`MarketingConsentAtUtc`). Araştırmaya göre İYS kaydı ve onayın İYS'ye yazılması kliniğin (hizmet sağlayıcı) yükümlülüğüdür. Vetinity klinik adına onay alamaz, yalnız araç sağlar.

## Karar

1. Ticari ileti, yalnız o klinik için ticari ileti onayı vermiş hasta sahibine gönderilir. Onayı olmayan sahibe hiçbir zaman gitmez.
2. Genel kapalı anahtar yerine **klinik başına kapı** olur. Varsayılan kapalıdır. Klinik yöneticisi açarken kliniğin İYS'ye kayıtlı olduğunu ve onayları İYS'ye yazmanın kendi yükümlülüğü olduğunu beyan eder (beyan kimin, ne zaman verdiğiyle tutulur ve denetim kaydına yazılır).
3. Her ticari iletide:
   - ücretsiz ve tek adımlık ret bağlantısı bulunur; ret aynı kanaldan alınır ve hemen uygulanır;
   - kliniğin kimlik bilgisi (unvan ya da ad) bulunur;
   - konu satırında ticari ileti olduğu belirtilir.
4. Ret, onay kaydını geri alır; ret zamanı tutulur.
5. Hatırlatmalar (randevu, aşı, kontrol, borç) ticari ileti sayılmaz; bu kapıdan bağımsızdır ve tanıtım içermez.

## Açık

- İYS'ye otomatik yazma (entegratör üzerinden) bu kararda yok. Bugün klinik İYS'ye kendisi işler; Vetinity onay ve ret kayıtlarını dışa aktarılabilir tutar. Entegratör seçimi ayrı karar.
- Hukukçu onayına kadar canlı kullanımda klinik başına kapı açılmamalıdır (pilot öncesi C7 kapanmalı).
