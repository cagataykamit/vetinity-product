# ADR-033 — Alan adı ve adres düzeni (www / panel / portal / api)

## Durum

**Kabul edildi (2026-10-16, kullanıcı: "bunu unutmayalım, bu şekilde yapalım").** Alan adı `vetinity.com`; bugün canlı kullanım `www.vetinity.com`, deneme ortamı `staging.vetinity.com` (panel şu an `staging.vetinity.com/panel/...`, tanıtım sitesiyle aynı Angular uygulamasının içinde). **Uygulama zamanı kullanıcıdadır** (sunucu/alan adı/dağıtım işleri; bkz. hafıza "VPS işlerine kullanıcı söyleyecek"); bu ADR hedef düzeni ve hazırlık işlerini sabitler, ajan kendiliğinden yayına/alan adına dokunmaz. İlgili: [ADR-031](ADR-031-hasta-sahibi-portali-ve-mobil-uygulama.md) AK-12, [ADR-014](ADR-014-pilot-and-production-operations.md).

## Karar

Her yüzey ayrı alt alan adında yaşar (ayrı origin = ayrı tarayıcı depolama ve güvenlik sınırı):

| Yüzey | Canlı | Staging |
|---|---|---|
| Tanıtım sitesi | `www.vetinity.com` | `staging.vetinity.com` |
| Klinik paneli (çalışanlar) | `panel.vetinity.com` | `panel-staging.vetinity.com` |
| Hasta sahibi portalı / mobil | `portal.vetinity.com` | `portal-staging.vetinity.com` |
| Backend API | `api.vetinity.com` | `api-staging.vetinity.com` (frontend `environment.staging.ts` adresi; doğrulanacak) |

Gerekçe: panel (klinik verisi, çalışan oturumu) ile tanıtım sitesi (analitik/çerez/üçüncü taraf betik) ve portal (müşteri oturumu) aynı origin'i paylaşmamalı; bağımsız yayın; akılda kalıcı adresler. Panel ile portal token'ları zaten ayrı depolama anahtarı kullanır, ayrı origin ek sınır sağlar.

## Hazırlık ve geçiş işleri (kullanıcı "başla" deyince)

1. Frontend: panel ve tanıtım sitesinin ayrı alt alan adlarından sunulması (aynı derleme iki adrese ya da tanıtımın ayrılması; seçim geçiş sırasında), eski `www…/panel/*` adreslerinden yeni panel adresine yönlendirme (yer imleri bozulmaz).
2. Backend: `AllowedOrigins` (panel + portal adresleri), `OwnerPortal:PortalBaseUrl` (davet bağlantısı), e-posta bağlantı tabanları (şifre sıfırlama, davet, hatırlatma) yeni adreslere.
3. Portal ve panel ortam dosyalarında API adresi `api…`; portal derlemesi (`dist/portal`) ayrı yayımlanır; mağaza paketi (Capacitor) portal adresine bağlanır.
4. Çerez/depolama kapsamı kontrolü, TLS sertifikaları (her alt alan adı), HSTS.
5. Sunucu ve alan adı işleri (DNS, sertifika, dağıtım) kullanıcı yönlendirmesiyle yapılır.
