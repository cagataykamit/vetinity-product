# Pilot hazırlık listesi — 2026-11-20

> Soru: "Ne zaman pilota hazır oluruz?" Bu belge tahmin değil, bugünkü kanıtla yazıldı.
> Ölçüt: [ana plan §14](Vetinity_Uctan_Uca_Yol_Haritasi_ve_Urun_Kararlari.md) 12 çıkış kapısı, [release-plan Aşama 2](release-plan.md), [pilot görüşme paketi](../operations/PILOT-KLINIK-GORUSME-PAKETI.md), [canlı işletim kılavuzu](../operations/CANLI-ISLETIM-KILAVUZU.md) §7.2, §9, §11–13, son [sürüm notları](../release-notes/).
> Kod kontrolü: backend `origin/main` `799e1cc7`, panel `origin/main` `ea668ab9`. İkisi de canlıdaki sürüm (2026-11-20 11:09). Main'e alınan her şey yayında.
> "Canlıda" kodun yayında olduğunu söyler. Hiçbir klinik henüz kullanmıyor. Pilot kliniğin E-vet verisi aktarıldı ama klinik devralmadı (2026-11-19).

Etiketler: **Hazır** (kanıtı yazılı) · **Eksik (ajan)** (kaba büyüklük) · **Kullanıcı** (yalnız kullanıcı yapabilir) · **Karar** (ürün kararı bekliyor).

## 1. Kapı tablosu

| # | Kapı | Durum | Kanıt / eksik |
|---|---|---|---|
| 1 | Hasta/ziyaret | **Hazır** | Geliş modeli (ADR-009), Bugün listesi ve akışı (sürüm 2026-11-19 BE `0adbd22c`), gelişsiz muayene ve yatan hasta (2026-11-20 BE `a2c0ab2e`, panel `cd0ce138`). Not: sürüm notları "ekranlar canlıda tarayıcıda denenmedi" diyor; kabul için rol bazlı elle test gerekir (kapı 12). |
| 2 | Muayene | **Hazır** | Dört bölüm, rowVersion ile çakışma koruması, kısmi PUT (EXAM-001–005, BE `b36eafc`), kesinleştirme ve ek not (Aşama 4). [Ajan kuyruğu](AJAN-KUYRUGU.md) Aşama 1 kabul listesindeki elle senaryolar hâlâ işaretsiz (2026-10 kaydı, güncellenmemiş). |
| 3 | İşlem sürekliliği | **Hazır**, bir hata **Eksik (ajan)** | Tedavi, reçete, aşı, lab ve yatış muayeneye ve hastaya bağlı. Gerekçeli iptal, geç kayıt ve eşzamanlılık koruması canlıda (2026-11-15, BE `dc36b64d`). **Aşı saati hatası (koddan doğrulandı):** `Vaccination.DueTimeSpecified` yalnız `CreateImported` ile doluyor. Panelden girilen planlı aşıda formdaki saat kaydediliyor ama alan hep `false` kalıyor. Bu yüzden takvimde saatsiz görünüyor. Büyüklük S (BE kuralı ve sözleşme, FE gönderimi; migration yok): 0,5–1 gün. |
| 4 | Finans | **Hazır** (temel), CHECKOUT-001 **Eksik (ajan)**, e-Belge **Karar** | Ücret, kısmi ödeme, kalan, düzeltme ve iptal canlıda (ADR-012, Aşama 3 Dilim 0–5). Ödeme ekranında "Tamamını al" (2026-11-16). **CHECKOUT-001 "Hesabı kapat":** tasarım onaylı (`taslak/hesabi-kapat` `07e25890`), kodu yok (backend ve panel main'de iz yok). Sıraya alındı (ürün `docs/kuyruk-hesabi-kapat` `d5c51c0`, main'de değil). Yaklaşık 5 dilim: 4–5 gün. Backlog önceliği P2. **e-Belge:** kesme kodu ve hazırlık listesi canlıda (2026-11-19), Nilvera beklemede, canlıda gerçek belge kesilmedi. Görüşme paketi §6'ya göre gölge dönemde belge eski yerden kesilir. |
| 5 | Geçmiş/takip | **Hazır** (kod), pilot verisi **Karar** | Hasta özeti, timeline, açık işler çipleri, Rapor Merkezi "Bakmanız gerekenler" (2026-11-20 BE `799e1cc7`, panel `ea668ab9`). Pilot verisinde açık noktalar için bölüm 3'e bakın. |
| 6 | Klinik kayıt politikası | **Hazır** | Kesinleştirme ve ek not (Aşama 4, D1). Birleşik kayıt modeli (ADR-043). Muayene, lab, yatış ve görüntüleme değişiklikleri değişiklik geçmişine yazılıyor (2026-11-15). |
| 7 | Platform | **Hazır** (kod), doğrulama **Kullanıcı** | Giriş, klinik seçimi, roller, davet, deneme kaydında e-posta kodu ve tek deneme kuralı (2026-11-15 BE `e0994451`), paket ve yetki kilitleri (2026-11-16). **iyzico canlı anahtarı yok** (kılavuz §11.2). Pilot ücretsizse ilk gün gerekmez, deneme süreleri bitmeden gerekir. Turnstile anahtarının canlıda açık olup olmadığı doğrulanmadı. |
| 8 | Rapor/iletişim | Raporlar **Hazır**, iletişim **Eksik (ajan + kullanıcı)** | Rapor Merkezi B canlıda (2026-11-20). Kılavuz §11.2'ye göre gerçek bir e-postanın (davet, hatırlatma, parola sıfırlama) canlıdan gidip ulaştığı denenmedi. Arka plan işleri (hatırlatma gönderimi, içe aktarma, ödeme uzlaştırma) canlıda bir tur gözlenmedi. "Gönderildi" yalnız SMTP'ye iletildi demek; teslim izi yok. Ajan canlı günlüklerini salt okunur inceler, kullanıcı kendi adresine test e-postası alır: 0,5 gün. |
| 9 | Deneme/kullanım | **Hazır** (kod), belgeler **Eksik (ajan)** | Kullanıcı dostu dalgalar 1–4 canlıda (2026-11-16), örnek klinik akışı var (görüşme paketi §7 provası). [Rol bazlı kılavuz](../operations/KULLANICI-KILAVUZU-ROL-BAZLI.md) başlığı "Taslak v0.1 (2026-10-13)"; ADR-052 için güncellendi (`236d21e`) ama son bir haftanın değişiklikleri (Bugün akışı, takvim, Hesabı kapat) tam işlenmedi. Pilot paketinde eskimiş satırlar var: §4 "canlı sunucu henüz yok", §5 "metinler taslak, hukukçu onayı" (kullanıcı kararı 2026-11-09: metinler yayında, hukukçu beklenmez), §5 "tam veri dışa aktarma yok" ("Verimi dışa aktar" sayfası var). Güncelleme 1 gün. |
| 10 | Canlı işletim | **Hazır** (yedek), uyarılar **Eksik (ajan)**, RPO **Karar** | Gece yedeği, şifreli Drive kopyası, `RESTORE VERIFYONLY`, geri yükleme provası 2026-11-10'da geçti (kılavuz §9, §11.1). Her migration'dan önce elle yedek alınıyor (sürüm notları). UptimeRobot dört adresi izliyor. **Kurulmamış (kılavuz §7.2):** `/health/ready` dış uyarısı, hata izleme ve günlük toplama, yedek başarısızlığı uyarısı, disk doluluk uyarısı, e-posta hata uyarısı. Bunlar 1–1,5 gün sürer; sunucu değişikliği olduğu için onay gerekir. `api-eski` ile geri alma ve Drive yedeğinin başka makinede açılması denenmedi. Sonraki aylık prova ~2026-12-10. |
| 11 | Müşteri geçişi | **Hazır** (araç), pilot verisi **Karar + Eksik (ajan)** | E-vet aktarma (TIER-024, ADR-048) iki düzeltme turuyla canlıda (2026-11-14, 2026-11-15). Kullanıcı pilot verisini 2026-11-19'da aktardı. Açık noktalar bölüm 3'te. |
| 12 | Pilot kabulü | **Kullanıcı** | Başlamadı. Pilot klinikle görüşme, koşullarda anlaşma, kliniğe devir, eğitim, 2 hafta gölge dönem ve fark listesi (paket §5, ADR-014 K4). Rol bazlı elle testlerin yapılıp yapılmadığı bilinmiyor. |

## 2. Kapılar dışındaki bilinen işler

| İş | Durum | Pilota etkisi |
|---|---|---|
| Telefon ajandası (`appointment-day-agenda`) | **Eksik (ajan)**, S, 0,5–1 gün. Koddan doğrulandı: hâlâ ayrı `app-calendar-vaccine-strip` kullanıyor. Masaüstünde randevu ve aşı tek akışta (takvim tasarımı "Telefon: ayrı Aşılar kutusu kalmaz"). | Engel değil. Hekim telefondan bakacaksa ilk hafta içinde yapılmalı. |
| Yapay zekâ | Canlıda, her klinikte kapalı. Console bakiyesi 0 $, anahtar yok. Gerçek AI isteği ve `anthropic-version` başlığı doğrulanmadı. KVKK m.9 yurt dışı aktarım koşulu doğrulanmadı. | İsteğe bağlı. Ücretli hesaplar ertelendi (2026-11-15). Pilotta açılmadan önce KVKK m.9 ele alınmalı. |
| ADR-049 ilaç rehberi | Kabul edildi, kod yok. Bakanlık izin talebi CİMER'e gönderildi (2026-11-17), yanıt bekleniyor. Dal `docs/adr-049-klinik-basvuru` main'e alınmadı (11 commit). | Engel değil (E-vet'teki DataVet karşılığı; pilot sonrası). |
| Hukuki metin yer tutucuları | Unvan ve vergi numarası şahıs işletmesi kaydı tamamlanınca doldurulacak. | Klinikle yazılı anlaşma öncesi gerekir (kullanıcı). |

## 3. Pilot kliniğin aktarılmış verisi

| Nokta | Durum |
|---|---|
| Geçmiş randevular alınmadı | Tasarım gereği (ADR-048 T5). E-vet'in geçmiş görevleri klinik geçmiş satırına çevriliyor (ADR-048 2026-11-12 eki). Kliniğe "geçmiş randevu listesi gelmez, geçmiş klinikte görünür" diye anlatılmalı. Kod işi yok. |
| 1099 zamanı geçmiş içe aktarılmış aşı | **Karar.** Seçenekler: (a) olduğu gibi kalsın; Raporlar ve takvim "gecikmiş" der, klinik temizler. (b) Belli bir tarihten eski vadeleri tek seferde "takip edilmiyor" yap. (c) Kliniğe liste ver, birlikte ayıklayın. (b) seçilirse işlem canlı veriye yazar: 0,5–1 gün ve ayrı onay. |
| Aşı saatlerini geri getirme | **Karar + onay.** Kayıtlar `AddVaccinationDueTimeSpecified` migration'ından önce aktarıldı. Yeniden aktarma ya da hedefli düzeltme gerekir; canlı veriye yazar. Büyüklük 0,5–1 gün. |
| Çomar'ın eski geliş kaydı | **Kullanıcı** (ya da onaylı ajan): panelde Düzelt (`Visits.Correct`, gerekçeli) ile kapatılır. Kod işi yok. |

## 4. Kritik yol (pilotu başlatmak için en az)

Gölge dönemle başlanırsa (ilk 2 hafta resmî kayıt ve belge eski yerde) aşağıdakiler yeterlidir:

**Ajan:**
1. Aşı saati hatası (kapı 3): 0,5–1 gün.
2. Pilot verisi: aşı saatlerini geri getirme ve 1099 aşı için verilen kararın uygulanması: 1 gün. Kararlar ve canlı veri onayı gerekir.
3. Canlı işletim uyarıları (kapı 10: yedek başarısızlığı, `/health/ready`, disk, 5xx/hata e-postası): 1–1,5 gün. Sunucu onayı gerekir.
4. İletişim doğrulaması (kapı 8: arka plan işlerinin canlı günlükte bir turu, test e-postası): 0,5 gün, kullanıcıyla.
5. Kılavuz ve pilot paketinin güncellenmesi (kapı 9): 1 gün.
6. Uçtan uca pilot provası (§14'teki 10 senaryo, örnek klinikte, rol rol): 1 gün.

**Kullanıcı:** pilot klinikle görüşme ve koşullar (paket §1: ücret, süre, destek saatleri, bakım saati, RPO/RTO), rol bazlı elle testler, test e-postasının ulaştığını görmek, eğitim günü, kliniğe devir.

**Pilot öncesi gerekmez (gölge dönemle):** e-Belge kesme, iyzico, AI, ADR-049, CHECKOUT-001 (kullanıcı kararına bağlı, bölüm 6), telefon ajandası (ilk hafta içinde önerilir).

## 5. Tahmin (iş günü)

| Kapsam | Ajan tarafı | Not |
|---|---|---|
| En az (bölüm 4, madde 1–6) | **5 iş günü (4–6)** | Ağır işler sırayla yürür (16 GB makine; aynı anda bir backend + bir frontend). Paralel oturumla takvim süresi 3–4 güne iner. |
| + CHECKOUT-001 Hesabı kapat | +4–5 gün → **9–11 gün** | ~5 dilim, önce backend sözleşmesi. |
| + telefon ajandası | +0,5–1 gün | |
| + AI ilk deneme | +0,5 gün | Kullanıcı anahtar ve bakiye girdikten sonra. |

- Ajan tarafı 2026-11-23 (Pazartesi) başlarsa en az kapsam **en erken 2026-11-27**'de, CHECKOUT-001 dahil **en erken 2026-12-04**'te biter. Varsayım: kararlar ve onaylar gününde gelir.
- **Kliniğin başlangıç tarihi kullanıcı adımlarına bağlıdır.** Görüşme, devir ve eğitim günü ajan tahmininin dışında. Paket §1 madde 3'e göre kurulum ve doğrulamadan sonra en az 1 hafta pay bırakılır. Gölge dönem 2 hafta, ardından 4 hafta gerçek kullanım.

## 6. Kullanıcıya açık sorular

1. **CHECKOUT-001** pilottan önce mi, gölge dönem sırasında mı yapılsın? Backlog'da P2; sıraya alındı.
2. **e-Belge:** pilot ilk günden Vetinity'den belge kesecek mi, yoksa klinik gölge dönem ve ilk ay mevcut sağlayıcısıyla mı devam edecek?
3. **1099 gecikmiş aşı:** bölüm 3'teki (a), (b) ya da (c)?
4. **Aşı saatlerinin geri getirilmesi:** yeniden aktarma mı, hedefli düzeltme mi? Canlı veriye yazma onayı.
5. **Rol bazlı elle testler** yapıldı mı? Hangi roller kaldı?
6. **Pilot klinik eğitimi ve devri:** görüşme tarihi, eğitim günü, iletişim kişisi belli mi? Paket §1 kararları (ücret, süre, destek saatleri, bakım saati) verildi mi?
7. **RPO:** bugün veri kaybı en çok 1 gün (gece yedeği). ADR-014 K2 "dakikalar düzeyi" diyor. Pilot için gece yedeği kabul mü, işlem günlüğü yedeği mi?
8. **Canlı işletim uyarıları** (kapı 10) sunucuda kurulsun mu? Sunucu değişikliği olduğu için onay gerekir.

## 7. Doğrulanmayanlar

- Ekranların hiçbiri bu çalışmada tarayıcıda açılmadı. Kapı durumları sürüm notlarına, belgelere ve `origin/main` kod okumasına dayanıyor.
- 1099 aşı sayısı ve Çomar kaydı koordinatörün aktardığı bilgi; canlı veritabanında sayılmadı.
- Turnstile'ın canlıda açık olup olmadığı, gece yedeğinin bugünkü günlüğü ve UptimeRobot durumu bu çalışmada kontrol edilmedi (sunucuya bağlanılmadı).
- Rol bazlı kılavuzun güncel ekranlarla ne kadar uyuştuğu satır satır karşılaştırılmadı.
