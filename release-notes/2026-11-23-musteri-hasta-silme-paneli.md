# 2026-11-23 (2. yayın) — Müşteri ve hasta silme ekranı

**Canlıda (11:00 civarı):**
- API `60f84e5d`.
- Panel `9e017c08` (`main-PQUAYCFT.js`).
- Portal ve klinik sitesi değişmedi (`498bafa9`).

**Veritabanı:** Migration ve seed yok (yetkiler sabahki yayında eklendi).

## Ne değişti ([ADR-054](../decisions/ADR-054-musteri-hasta-yumusak-silme.md))

- Müşteri ve hasta kartındaki "…" menüsünde **Sil** (yalnız `Clients.Delete` / `Pets.Delete`: işletme yöneticisi, sahip, klinik yöneticisi).
- Onay penceresi ne olacağını söyler: kayıt listelerden kalkar, geçmiş kayıtlar silinmez, "Silinenler"den geri yüklenir; müşteride hastaları da silinir (sayıyla); yumuşak silme KVKK silmesi değildir.
- Engel varsa (açık hesap, aktif yatış, gelecek randevu, bugünkü açık geliş) nedenler bağlantılarıyla gösterilir.
- Silindikten sonra "X silindi · Geri al".
- Silinmiş kart açılırsa "Bu kayıt silindi · tarih · kim" bandı ve "Geri yükle"; yeni kayıt girişleri kapalı.
- **Müşteri ve Hasta › Silinenler** sekmesi: arama, sayfalama, silen kişi, geri yükleme; telefonda gün başlıklı liste.
- API: kart uçları silen kişiyi döndürür (`deletedByUserId`, `deletedByUserName`).

## Testler (birleşik main)

- Backend: Domain 1417/1417, Application 4710/4710, Integration (Clients, Pets, SoftDelete) 264/264. Sabahki tam Integration koşusu 2277 geçti.
- Panel 499 dosya / 3906; portal 279; site 43. `vetinity-web` derlemesi başarılı.

## Doğrulama

- `vetinity-api` aktif, `/health/ready` 200, günlükte hata yok.
- Panel `main-*.js` ve `ngsw.json` zaman damgası yerel derlemeyle aynı. www, portal 200.
- Geri alma: `api-eski` (`3ac749d1`), `web-eski` sunucuda.

## Notlar

- Silme yetkisi sabahki seed ile eklendi; yöneticiler bir kez çıkış yapıp yeniden girmeli.

## Doğrulanmayanlar

- Canlıda girişle silme ve geri yükleme denenmedi (yerelde denendi). Bantta silen kişi, silinmiş hastada gizlenen "+ Ekle" ve müşteri kartındaki hasta notu tarayıcıda gözle görülmedi; yalnız testlerle doğrulandı.
