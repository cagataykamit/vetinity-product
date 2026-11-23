# 2026-11-23 (3. yayın) — Giriş sayfaları A, tanıtım telefon görünümü, yapay zekâ tanıtımı, güncel görseller

**Canlıda (akşam):**
- API `6d6542ec`.
- Panel ve tanıtım `143e1385` (`main-ITVTRBOR.js`).
- Portal ve klinik sitesi değişmedi.

**Veritabanı:** Migration ve seed yok.

## Ne değişti

- **Giriş sayfaları (L-01, seçenek A):** Sabahki yayında kullanıcı onayı olmadan çıkan sıcak tema (A2 yönü) geri alındı; giriş, kayıt, şifremi unuttum, yeni şifre, klinik seçimi ve davet kabul sayfaları "Tanıtımın devamı" düzenine geçti: üstte logo ve "← Ana sayfa" şeridi, ortada kart, lacivert düğme, altta hukuki bağlantılar. Tıklanmayan süs etiketleri kaldırıldı. Alanlar ve akış aynı.
- **Tanıtım ana sayfası, telefon (T-03 B "Günün saatleri"):** 09:00 geliş, 09:20 muayene, 09:50 tahsilat, 19:00 gün sonu akışı; güncel telefon görselleri. Masaüstü düzen aynı.
- **Ürün görselleri (T-02):** `public/marketing/screens` güncel arayüzden yeniden çekildi (açık + koyu; yerel test kiracısı, örnek klinik sentetik verisi; gerçek kişi verisi ve e-posta yok). Klinik sitesi görselleri değişmedi (dört tasarım kararı bekliyor).
- **Yapay zekâ yardımcısı tanıtımda:** ana sayfa, Özellikler, SSS; "taslak, hekim onayı", "talep üzerine açılır". Paket karşılaştırmasında aylık yapay zekâ kredisi (Temel 0, Profesyonel 500, Kurumsal 2.000), değer API'den (`GET /public/subscription-plans` → `monthlyAiCredits`).
- **Olumlu dil ([ADR-035](../decisions/ADR-035-paketler-ve-fiyat.md) 2026-11-23 eki):** "Şu an olmayanlar" listesi ve "şu an yok" cümleleri kalktı; olan anlatılıyor. Karşılaştırma tablosundaki işaretler aynı.
- **SSS:** "Nasıl destek alırım?".

## Testler (birleşik main)

- Backend Application 4712/4712; ilgili Integration 3/3.
- Panel 500 dosya / 3919; portal 279; site 43. `vetinity-web` derlemesi başarılı.
- Görsel kontrol: yerel derleme canlı adreslere yönlendirilerek giriş, kayıt, şifre, ana sayfa, paketler 1280 ve 375 px'te görüntülendi; yatay taşma yok. Tanıtım ajanının denetimi telefon ana sayfasında 375/390, açık/koyu 0 sorun.

## Doğrulama

- `vetinity-api` aktif, `/health/ready` 200, günlükte hata yok. `monthlyAiCredits` canlıda 0/500/2000.
- Panel `main-*.js` ve `ngsw.json` yerel derlemeyle aynı. www, `/paketler`, portal 200; yeni görseller 200.
- Geri alma: `api-eski` (`60f84e5d`), `web-eski` sunucuda.

## Doğrulanmayanlar

- Canlıda girişle denenmedi. Koyu temada giriş sayfaları yalnız ekran görüntüsüyle bakıldı (panel kendi tema seçimini kullanıyor).
- Görsellerdeki örnek telefon numaraları (+90 532 100 10 xx) uydurma ama gerçek numara aralığında; maskelenmesi kullanıcıya soruldu.
