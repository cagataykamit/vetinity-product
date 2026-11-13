# Durum panosu

> **Son güncelleme:** 2026-11-14 (durum panosu oturumu; koordinatör bildirimi: AI kota kararı, mobil, ilk hafta taslakları). Tek bakışta neredeyiz: P0–P3 işleri, yürüyenler, onay ve dış yanıt bekleyenler.
> **Kaynak:** [backlog](../backlog/feature-backlog.md) + git. "Canlıda" = commit, son canlı yayının (2026-11-14 00:13–00:16; backend `3c50d963`, panel `181b14ed`) atası. Canlı sunucuya ve veritabanına bakılmadı; ekranlar canlıda denenmedi.
> **Güncelleme kuralı:** iş bitince, canlıya çıkınca ya da karar verilince bu dosya ve backlog'daki Durum satırı aynı dalda, ayrı commit'le güncellenir.

**Pilot klinik henüz canlıda değil** (kullanıcı, 2026-11-14). Canlı ortamda yalnız E-vet yedeğinin doğrulama denemesi yapıldı; gerçek klinik kullanımı yok. "Canlıda" etiketi kodun yayında olduğunu söyler, klinikte kullanıldığını değil.

Durum etiketleri: Canlıda · Canlıda (kısmen) · Main'de, canlıya çıkmadı · Dalda, birleşmedi · Geliştiriliyor · Karar bekliyor (kullanıcı) · Dış yanıt bekliyor · Planlandı · Araştırılacak · Ertelendi.

## Özet

| Öncelik | Toplam | Canlıda | Kısmen canlıda | Açık (yürüyen, karar, planlı, araştırılacak) | Ertelendi |
|---|---|---|---|---|---|
| P0 | 27 | 27 | 0 | 0 | 0 |
| P1 | 105 | 90 | 4 | 3 (MOBILE-002 geliştiriliyor, RECORD-006 karar, AI-002 pilotta erken deneme) | 8 (AI) |
| P2 | 61 | 26 | 5 | 24 (14 planlı, 10 araştırılacak) | 6 |
| P3 | 10 | 0 | 0 | 9 (2 planlı, 7 araştırılacak) | 1 |
| Belirlenmemiş | 1 | 0 | 0 | 1 (UX-010 İngilizce) | 0 |

Backlog dışında yürüyen işler (E-vet aktarma düzeltmeleri, menü yolları, tasarım taslakları) aşağıda "Şu an yürüyenler"de.

## Şu an yürüyenler

| İş | Nerede | Durum | Not |
|---|---|---|---|
| E-vet pilot aktarma düzeltmeleri B1–B6 ([bulgular](../research/evet-pilot-aktarma-bulgulari-2026-11-14.md), ürün dalı `docs/evet-pilot-bulgulari`) | E-vet içe aktarma oturumu. BE `feature/evet-sahip-degisimi` (+6 commit: B1, B2, B3, B4, B5), FE aynı ad (+1: B6 çakışan satır) | Geliştiriliyor | Pilot aktarma bu düzeltmeler canlıya çıkınca yeniden yapılacak. Main'e alma ve canlı onay ister |
| E-vet menü yolları (B7) | BE/FE `fix/evet-menu-yollari` (BE `32b55ea7`, FE `f1ae8c57`) | Dalda, birleşmedi | Küçük düzeltme; B1–B6 ile birlikte çıkabilir |
| Hasta sahibi mobil uygulaması (MOBILE-002) | FE `feature/mobil-magaza` (+8, son `3c44efe5`), ürün `docs/mobil-magaza` (+1) | Geliştiriliyor | Android emülatörde giriş/kilit çalıştı. Kalan: Firebase ve gerçek push, iOS (Mac), App Links, imzalı paket, mağaza kaydı |
| İlk hafta rehberi kartı yeni tasarım (TIER-022) | İlk hafta tasarım oturumu, FE `taslak/ilk-hafta-rehberi` | Geliştiriliyor | Fable oturumu birkaç tasarım taslağı hazırlıyor; seçim kullanıcıda |
| Tanıtım sitesinde e-belge bölümü | FE `feature/ozellikler-e-belge` (+3, 2026-11-12) | Dalda, birleşmedi | Özellikler sayfasında e-Fatura/e-Arşiv/e-SMM bölümü, paket tablosu satırı, SSS düzeltmesi. Sahibi ve onay durumu doğrulanmadı |
| AI kota kararı (ADR-044 güncellemesi: her pakette kotalı AI, kullanıcı başına kota, ek kredi, pilotta Haiku ile erken deneme) | Ürün dalı `docs/ai-kota` (`ba01a24`) | Dalda, birleşmedi | TIER-013/014 satırları bu dalda güncellendi; main'e alma onayı |
| Nilvera e-Fatura ticari senaryo + bekleme listesi test düzeltmesi | BE main `6add514c`, panel main `7b53100b` | Main'de, canlıya çıkmadı | Migration var: `AddEDocumentBuyerAnswer`. Bekleme listesi değişikliği yalnız test |

Taslak dallar (main'e alınmaz, bilgi için): FE `taslak/hesabi-kapat` (CHECKOUT-001 tasarımı, onaylı), `taslak/klinik-web-sayfasi` (kliniğe özel web sayfası sihirbazı), `taslak/ozellik-tablosu`, `taslak/talep-baslik`.

Boşta, işi bitmiş oturumlar: Paraşüt e-belge oturumu (Paraşüt canlıda kapalı), E-fatura görüşmesi oturumu, Sistem katalogları oturumu (2026-11-14'te canlıya çıktı).

## Kullanıcının onayını bekleyenler

**Canlıya çıkış**
1. Backend `6add514c` + panel `7b53100b`: e-Fatura ticari senaryo, "Alıcı reddetti" durumu, e-Fatura düzeltme yolu. Migration `AddEDocumentBuyerAnswer` canlı DB'ye (önce elle yedek).
2. E-vet düzeltmeleri (B1–B7) bitince: main'e alma ve canlı. Ardından pilot aktarmanın yeniden yapılması.
3. FE `feature/ozellikler-e-belge` (tanıtım sitesi e-belge bölümü): main'e alma ve `www` yayını.

**Ürün kararı**
1. RECORD-006 / [ADR-043](../decisions/ADR-043-birlesik-klinik-kayit-modeli.md) birleşik kayıt modeli: AK-1…9 (taslak 2026-11-01'den beri bekliyor)). Pilot başlamadan çözülmesi öneriliyor: tedavi ve yatış iptal edilemiyor; tedavi, reçete ve aşıda aynı anda düzenlemeye karşı koruma yok. Kullanıcı en iyi yolu Fable oturumuna sormak istedi (oturum henüz açılmadı).
2. Mobil mağaza hesapları (ADR-031 AK-4): bireysel hesap mı, önce limited şirket kurmak mı? Apple'da şahıs işletmesi bireysel kaydolur (satıcı adı kişi adı görünür). Google Play'de kuruluş hesabı D-U-N-S ister; kişisel hesapta yayından önce 12 kişi/14 gün kapalı test zorunlu.
3. [Canlı işletim kılavuzu](../operations/CANLI-ISLETIM-KILAVUZU.md) bölüm 12: önem derecesi süreleri, destek kanalı ve mesai, nöbet, bakım penceresi, olay notlarının yeri, gölge dönem ölçütleri, RPO/RTO, ClamAV.
4. İlk hafta rehberi kartı: Fable taslaklarından birini seçmek.
5. Çalışma varsayımı olarak canlıda olan kurallar: TIER-004 kırılımlar, TIER-007 şubeler özeti, TIER-010 özel geliştirme talebi sınırı ve yetkisi.

**Sunucu ve hesap işleri (kullanıcıda)**
1. iyzico canlı anahtarı yok: vergi kaydı ve üye işyeri başvurusu. Bu olmadan denemeden ücretli plana geçiş (TRIAL-007, BILL-*) canlıda çalışmaz.
2. Claude Console API hesabı, kredi yükleme, harcama sınırı ve anahtarın sunucuya girilmesi (pilotta AI erken deneme için).
3. Firebase projesi ve FCM anahtarı (MOBILE-002/003; portal "henüz etkin değil" diyor).
4. SSH: anahtar kurulduktan sonra parola ve root girişini kapatma.
5. SQL Server güncellemesi (16.0.4195 → 16.0.4315): bakım penceresinde, yedekten sonra; Zonguldak veritabanını da etkiler.
6. Veteriner bul site haritasını `robots.txt`'ye ekleme.
7. Virüs taraması: dosya yüklemelerinde tarama yok (kod işi + ClamAV).
8. Canlıdan gerçek e-posta (davet, hatırlatma, parola sıfırlama) gidişi denenmedi.
9. Şahıs işletmesi unvanı ve vergi numarası gelince hukuki metinlerdeki yer tutucular doldurulacak.

## Dış yanıt bekleyenler

| Kim | Ne | Durum |
|---|---|---|
| Nilvera | Test hesabı; iş birliği / gelir payı programı | Test hesabı geldi (2026-11-12), canlıya Nilvera ile çıkıldı. İş birliği yanıtının durumu belgelerde yok, teyit edilecek |
| Paraşüt | Staging'de e-Arşiv iş hatası ve e-SMM'nin açılması | Destek yanıtı bekleniyor (2026-11-12 ayrıntılı yanıt gönderildi). Canlıda Paraşüt kapalı |
| Uyumsoft | Ortaklık | Sözleşmeli teklif reddedildi. Uyumsoft "sözleşmesiz, hak edişsiz iş ortaklığı" önerdi; plan: "desteklenen" sağlayıcı, API dokümanı ve test hesabı istenecek, entegrasyon Nilvera'dan sonra |
| NES | Test hesabı, API dokümanı, kontör fiyatı | Test hesabı istendi (2026-11-12), ekler gelmedi |
| BirFatura | Entegrasyon başvurusu | Yanıt bekleniyor (2026-11-12 yeniden gönderildi) |
| Sovos (Digital Planet) | İş ortaklığı | Yanıt bekleniyor (2026-11-10'dan beri) |
| Apple / Google | Geliştirici hesapları | Hesap türü kararı bekliyor (yukarıda), sonra kayıt |
| Tarım ve Orman Bakanlığı | HBS web servis sorusu (ADR-036 D9) | Yazının gönderilip gönderilmediği belgelerde yok |

## Öncelik başına durum

## P0 (27 madde)

Canlıda: 27


<details><summary>Canlıda olanlar (27)</summary>

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [TRIAL-001](../backlog/feature-backlog.md#trial-001--14-günlük-self-service-trial) | 14 günlük self-service trial | Canlıda |  |
| [TRIAL-007](../backlog/feature-backlog.md#trial-007--trialdan-ücretli-plana-dönüşüm) | Trial'dan ücretli plana dönüşüm | Canlıda | Ödeme canlıda çalışmaz: iyzico canlı anahtarı yok (vergi kaydı + üye işyeri başvurusu kullanıcıda) |
| [REPORT-001](../backlog/feature-backlog.md#report-001--rapor-merkezi) | Rapor Merkezi | Canlıda |  |
| [REPORT-002](../backlog/feature-backlog.md#report-002--rapor-kategorileri) | Rapor kategorileri | Canlıda |  |
| [UX-001](../backlog/feature-backlog.md#ux-001--sidebar-sadeleştirme) | Sidebar sadeleştirme | Canlıda |  |
| [UX-002](../backlog/feature-backlog.md#ux-002--ayarlar--tanımlar-merkezi) | Ayarlar > Tanımlar merkezi | Canlıda |  |
| [UX-003](../backlog/feature-backlog.md#ux-003--türlerin-tanımlar-altına-alınması) | Türlerin Tanımlar altına alınması | Canlıda |  |
| [UX-004](../backlog/feature-backlog.md#ux-004--irkların-tanımlar-altına-alınması) | Irkların Tanımlar altına alınması | Canlıda |  |
| [UX-005](../backlog/feature-backlog.md#ux-005--ürün-kategorilerinin-tanımlar-altına-alınması) | Ürün kategorilerinin Tanımlar altına alınması | Canlıda |  |
| [EXAM-001](../backlog/feature-backlog.md#exam-001--modern-muayene-çalışma-alanı) | Modern muayene çalışma alanı | Canlıda |  |
| [EXAM-002](../backlog/feature-backlog.md#exam-002--şikâyet-ve-anamnez-bölümü) | Şikâyet ve anamnez bölümü | Canlıda |  |
| [EXAM-003](../backlog/feature-backlog.md#exam-003--klinik-bulgular-ve-vital-değerler) | Klinik bulgular ve vital değerler | Canlıda |  |
| [EXAM-004](../backlog/feature-backlog.md#exam-004--değerlendirme--tanı-alanı) | Değerlendirme / tanı alanı | Canlıda |  |
| [EXAM-005](../backlog/feature-backlog.md#exam-005--tedavi-planı) | Tedavi planı | Canlıda |  |
| [HOSP-001](../backlog/feature-backlog.md#hosp-001--yatış-yaşam-döngüsü-ve-aktif-yatışlar) | Yatış yaşam döngüsü ve aktif yatışlar | Canlıda |  |
| [HOSP-002](../backlog/feature-backlog.md#hosp-002--yatış-konum-ataması) | Yatış konum ataması | Canlıda |  |
| [HOSP-003](../backlog/feature-backlog.md#hosp-003--hasta-yatış-geçmişi-ve-klinik-bağlam) | Hasta yatış geçmişi ve klinik bağlam | Canlıda |  |
| [CHECKIN-006](../backlog/feature-backlog.md#checkin-006--hafif-geliş-ve-bekleme-akışı-visit-randevulurandevusuz) | Hafif geliş ve bekleme akışı (Visit, randevulu/randevusuz) | Canlıda |  |
| [CHECKIN-007](../backlog/feature-backlog.md#checkin-007--bugün-yüzeyi-günlük-operasyon-görünümü) | Bugün yüzeyi (günlük operasyon görünümü) | Canlıda |  |
| [SEARCH-001](../backlog/feature-backlog.md#search-001--günlük-hastasahip-arama) | Günlük hasta/sahip arama | Canlıda |  |
| [CHECKIN-009](../backlog/feature-backlog.md#checkin-009--yanlış-geliş-işaretini-geri-alma) | Yanlış geliş işaretini geri alma | Canlıda |  |
| [CHECKIN-011](../backlog/feature-backlog.md#checkin-011--uzun-bekleme-uyarısı) | Uzun bekleme uyarısı | Canlıda |  |
| [CHECKIN-008](../backlog/feature-backlog.md#checkin-008--randevusuz-gelişte-hızlı-müşteri-ve-hasta-kaydı) | Randevusuz gelişte hızlı müşteri ve hasta kaydı | Canlıda |  |
| [FIN-001](../backlog/feature-backlog.md#fin-001--ücret-borç-kaydı-ve-manuel-ücret-satırı) | Ücret (borç) kaydı ve manuel ücret satırı | Canlıda |  |
| [FIN-002](../backlog/feature-backlog.md#fin-002--tahsilatücret-ilişkilendirme-ve-bakiye) | Tahsilat–ücret ilişkilendirme ve bakiye | Canlıda |  |
| [FIN-003](../backlog/feature-backlog.md#fin-003--ücret-ve-tahsilat-düzeltme) | Ücret ve tahsilat düzeltme | Canlıda |  |
| [FIN-004](../backlog/feature-backlog.md#fin-004--bugün-ve-muayeneden-ücretödeme-akışı-arayüz) | Bugün ve muayeneden ücret/ödeme akışı (arayüz) | Canlıda | Tarayıcıda elle denenmedi |

</details>

## P1 (105 madde)

Geliştiriliyor: 1 · Karar bekliyor (kullanıcı): 1 · Planlandı: 1 · Canlıda (kısmen): 4 · Canlıda: 90 · Ertelendi: 8

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [MOBILE-002](../backlog/feature-backlog.md#mobile-002--hasta-sahibi-mobil-uygulaması-capacitor-mağaza) | Hasta sahibi mobil uygulaması (Capacitor, mağaza) | Geliştiriliyor | FE dal `feature/mobil-magaza`; Apple/Google hesap türü kararı ve Firebase kullanıcıda |
| [RECORD-006](../backlog/feature-backlog.md#record-006--birleşik-record-modeli-ve-tip-bazlı-dinamik-form) | Birleşik record modeli ve tip-bazlı dinamik form | Karar bekliyor (kullanıcı) | ADR-043 taslak; AK-1…9 kararı bekliyor, kod yok |
| [AI-002](../backlog/feature-backlog.md#ai-002--ai-hasta-geçmişi-özeti) | AI hasta geçmişi özeti | Planlandı | Pilotta Haiku ile ücretsiz erken deneme (ADR-044 güncellemesi, dal `docs/ai-kota`); Claude API hesabı kullanıcıda |
| [REPORT-008](../backlog/feature-backlog.md#report-008--işletme-performansı-panosu) | İşletme performansı panosu | Canlıda (kısmen) | Dilim 1–3 canlıda; kalanı pilot geri bildirimine göre |
| [EXAM-015](../backlog/feature-backlog.md#exam-015--medical-note-lock) | Medical note lock | Canlıda (kısmen) | Kilit ve ek not var; kilit açma bilinçli yok (ADR-013) |
| [INT-005](../backlog/feature-backlog.md#int-005--e-fatura--e-smm) | e-Fatura / e-SMM | Canlıda (kısmen) | Nilvera ile canlıda (2026-11-14); ticari senaryo + "Alıcı reddetti" main'de, canlıya çıkmadı; Paraşüt kapalı |
| [INT-007](../backlog/feature-backlog.md#int-007--otomatik-fatura--e-belge-oluşturma) | Otomatik fatura / e-belge oluşturma | Canlıda (kısmen) | Elle kes + otomatik kesme (varsayılan kapalı) Nilvera ile canlıda |
| [AI-001](../backlog/feature-backlog.md#ai-001--ai-muayene-notu-yapılandırma) | AI muayene notu yapılandırma | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-003](../backlog/feature-backlog.md#ai-003--ai-hasta-sahibi-bilgilendirmesi) | AI hasta sahibi bilgilendirmesi | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-004](../backlog/feature-backlog.md#ai-004--ai-taburcu-talimatı) | AI taburcu talimatı | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-005](../backlog/feature-backlog.md#ai-005--speech-to-text) | Speech-to-text | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-007](../backlog/feature-backlog.md#ai-007--ai-kullanım-kotası) | AI kullanım kotası | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-008](../backlog/feature-backlog.md#ai-008--ai-maliyet-takibi) | AI maliyet takibi | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-009](../backlog/feature-backlog.md#ai-009--ai-çıktı-onay-akışı) | AI çıktı onay akışı | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |
| [AI-010](../backlog/feature-backlog.md#ai-010--ai-audit-metadatası) | AI audit metadatası | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |

<details><summary>Canlıda olanlar (90)</summary>

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [TRIAL-002](../backlog/feature-backlog.md#trial-002--örnek-klinik-onboarding-seçimi) | Örnek klinik onboarding seçimi | Canlıda |  |
| [TRIAL-003](../backlog/feature-backlog.md#trial-003--örnek-klinik-sentetik-seed-verileri) | Örnek klinik sentetik seed verileri | Canlıda |  |
| [TRIAL-004](../backlog/feature-backlog.md#trial-004--trial-kısıtlama-politikası) | Trial kısıtlama politikası | Canlıda |  |
| [TRIAL-005](../backlog/feature-backlog.md#trial-005--opsiyonel-canlı-demo-akışı) | Opsiyonel canlı demo akışı | Canlıda | Gerçek SMTP ile demo e-postası denenmedi |
| [TRIAL-006](../backlog/feature-backlog.md#trial-006--trial-kullanım-kotası) | Trial kullanım kotası | Canlıda |  |
| [TRIAL-008](../backlog/feature-backlog.md#trial-008--trial-aktivasyon-ölçümleri) | Trial aktivasyon ölçümleri | Canlıda |  |
| [REPORT-003](../backlog/feature-backlog.md#report-003--rapor-favorileri) | Rapor favorileri | Canlıda |  |
| [REPORT-004](../backlog/feature-backlog.md#report-004--kaydedilmiş-rapor-filtreleri) | Kaydedilmiş rapor filtreleri | Canlıda |  |
| [REPORT-005](../backlog/feature-backlog.md#report-005--ortak-rapor-filtre-çubuğu) | Ortak rapor filtre çubuğu | Canlıda |  |
| [REPORT-006](../backlog/feature-backlog.md#report-006--claim-bazlı-rapor-görünürlüğü) | Claim bazlı rapor görünürlüğü | Canlıda | Uç başına yetki ayrıntısı doğrulanmadı |
| [REPORT-007](../backlog/feature-backlog.md#report-007--excelpdf-dışa-aktarma-politikası) | Excel/PDF dışa aktarma politikası | Canlıda |  |
| [UX-006](../backlog/feature-backlog.md#ux-006--global-search-ve-recent-navigation) | Global search ve recent navigation | Canlıda |  |
| [UX-008](../backlog/feature-backlog.md#ux-008--kişiye-özel-bildirimler-ve-onay-akışı-kalıcı-bildirim-modeli) | Kişiye özel bildirimler ve onay akışı (kalıcı bildirim modeli) | Canlıda |  |
| [EXAM-006](../backlog/feature-backlog.md#exam-006--muayene-şablonları) | Muayene şablonları | Canlıda |  |
| [EXAM-007](../backlog/feature-backlog.md#exam-007--tedavi-bundlepaketleri) | Tedavi bundle/paketleri | Canlıda |  |
| [EXAM-008](../backlog/feature-backlog.md#exam-008--doz-hesaplayıcı) | Doz hesaplayıcı | Canlıda |  |
| [EXAM-009](../backlog/feature-backlog.md#exam-009--kalıcı-alerji-ve-dikkat-uyarıları) | Kalıcı alerji ve dikkat uyarıları | Canlıda |  |
| [EXAM-010](../backlog/feature-backlog.md#exam-010--muayene-sırasında-hızlı-labreçetegörüntüleme-bağlantısı) | Muayene sırasında hızlı lab/reçete/görüntüleme bağlantısı | Canlıda |  |
| [EXAM-011](../backlog/feature-backlog.md#exam-011--klinik-snippet-sistemi) | Klinik snippet sistemi | Canlıda |  |
| [EXAM-012](../backlog/feature-backlog.md#exam-012--klinik-bazlı-snippet-yönetimi) | Klinik bazlı snippet yönetimi | Canlıda |  |
| [CHECKIN-001](../backlog/feature-backlog.md#checkin-001--check-in-workflow) | Check-in workflow | Canlıda |  |
| [CHECKIN-002](../backlog/feature-backlog.md#checkin-002--check-in-sırasında-medical-note-şablonu) | Check-in sırasında medical note şablonu | Canlıda |  |
| [CHECKIN-003](../backlog/feature-backlog.md#checkin-003--check-in-sırasında-bundle-seçimi) | Check-in sırasında bundle seçimi | Canlıda |  |
| [CHECKIN-004](../backlog/feature-backlog.md#checkin-004--check-in-sırasında-invoiceestimate-seçimi-veya-oluşturma) | Check-in sırasında invoice/estimate seçimi veya oluşturma | Canlıda |  |
| [CHECKIN-005](../backlog/feature-backlog.md#checkin-005--ziyaret-yaşam-döngüsü-ve-durum-geçişleri) | Ziyaret yaşam döngüsü ve durum geçişleri | Canlıda |  |
| [CHECKIN-010](../backlog/feature-backlog.md#checkin-010--randevulu-hasta-gelmedi-no-show-işareti) | Randevulu hasta gelmedi (no-show) işareti | Canlıda |  |
| [CHECKIN-012](../backlog/feature-backlog.md#checkin-012--acil-işareti) | Acil işareti | Canlıda |  |
| [CHECKIN-013](../backlog/feature-backlog.md#checkin-013--bugün-satırında-hasta-uyarı-rozetleri) | Bugün satırında hasta uyarı rozetleri | Canlıda |  |
| [CHECKIN-014](../backlog/feature-backlog.md#checkin-014--hekim-için-benim-hastalarım-filtresi) | Hekim için "Benim hastalarım" filtresi | Canlıda |  |
| [FIN-005](../backlog/feature-backlog.md#fin-005--müşteri-kredisi-ve-mahsup-fazla-ödeme) | Müşteri kredisi ve mahsup (fazla ödeme) | Canlıda |  |
| [FIN-008](../backlog/feature-backlog.md#fin-008--hizmet-kataloğu) | Hizmet kataloğu | Canlıda |  |
| [RECORD-001](../backlog/feature-backlog.md#record-001--recordfinans-bağlantısı-görünürlüğü) | Record–finans bağlantısı görünürlüğü | Canlıda |  |
| [RECORD-002](../backlog/feature-backlog.md#record-002--record-audit-history) | Record audit history | Canlıda |  |
| [RECORD-005](../backlog/feature-backlog.md#record-005--lot-expiry-route-ve-site-izlenebilirliği) | Lot, expiry, route ve site izlenebilirliği | Canlıda |  |
| [RECORD-008](../backlog/feature-backlog.md#record-008--reçete-iptali-ve-kesinleşmiş-muayenede-düzeltme-yolu) | Reçete iptali ve kesinleşmiş muayenede düzeltme yolu | Canlıda |  |
| [PORTAL-001](../backlog/feature-backlog.md#portal-001--hasta-sahibi-portalı) | Hasta sahibi portalı | Canlıda |  |
| [PORTAL-006](../backlog/feature-backlog.md#portal-006--portal-kimliği-davet-ve-müşteri-bağı) | Portal kimliği, davet ve müşteri bağı | Canlıda |  |
| [PORTAL-007](../backlog/feature-backlog.md#portal-007--portal-kvkk-sürümlü-kabul-bildirim-tercihi-veri-talebi) | Portal KVKK: sürümlü kabul, bildirim tercihi, veri talebi | Canlıda |  |
| [PORTAL-008](../backlog/feature-backlog.md#portal-008--portal-api-ayrımı-ve-kiracı-izolasyonu) | Portal API ayrımı ve kiracı izolasyonu | Canlıda | Çapraz kiracı test kapsamı doğrulanmadı |
| [PORTAL-009](../backlog/feature-backlog.md#portal-009--klinik-panelinde-portal-yönetimi) | Klinik panelinde portal yönetimi | Canlıda |  |
| [PORTAL-010](../backlog/feature-backlog.md#portal-010--portal-bildirimleri-e-posta-whatsapp-bağlantısı-push) | Portal bildirimleri (e-posta, WhatsApp bağlantısı, push) | Canlıda |  |
| [PORTAL-011](../backlog/feature-backlog.md#portal-011--portal-hesabını-silme-self-servis) | Portal hesabını silme (self-servis) | Canlıda | Migration 2026-11-10 canlı kurulumda uygulandı |
| [TIMELINE-001](../backlog/feature-backlog.md#timeline-001--hasta-timeline) | Hasta timeline | Canlıda |  |
| [TIMELINE-002](../backlog/feature-backlog.md#timeline-002--timeline-olay-modeli) | Timeline olay modeli | Canlıda |  |
| [TIMELINE-003](../backlog/feature-backlog.md#timeline-003--timeline-filtreleri) | Timeline filtreleri | Canlıda |  |
| [TIMELINE-004](../backlog/feature-backlog.md#timeline-004--timeline-derin-bağlantıları) | Timeline derin bağlantıları | Canlıda |  |
| [IMG-001](../backlog/feature-backlog.md#img-001--görüntüleme-kayıtları) | Görüntüleme kayıtları | Canlıda | Tarayıcı denemesi doğrulanmadı |
| [IMG-002](../backlog/feature-backlog.md#img-002--röntgen-yükleme-ve-görüntüleme) | Röntgen yükleme ve görüntüleme | Canlıda |  |
| [IMG-003](../backlog/feature-backlog.md#img-003--ultrason-kayıtları) | Ultrason kayıtları | Canlıda |  |
| [IMG-004](../backlog/feature-backlog.md#img-004--klinik-fotoğraf-ve-video) | Klinik fotoğraf ve video | Canlıda |  |
| [IMG-007](../backlog/feature-backlog.md#img-007--görüntüleme-ile-muayene-bağlantısı) | Görüntüleme ile muayene bağlantısı | Canlıda |  |
| [IMG-008](../backlog/feature-backlog.md#img-008--görüntüleme-ile-timeline-bağlantısı) | Görüntüleme ile timeline bağlantısı | Canlıda |  |
| [APPT-001](../backlog/feature-backlog.md#appt-001--kliniğe-özel-online-randevu-sayfası) | Kliniğe özel online randevu sayfası | Canlıda |  |
| [APPT-002](../backlog/feature-backlog.md#appt-002--klinik-bazlı-benzersiz-randevu-bağlantısı) | Klinik bazlı benzersiz randevu bağlantısı | Canlıda |  |
| [APPT-003](../backlog/feature-backlog.md#appt-003--hasta-sahibi-kayıtlı-hayvan-seçimi) | Hasta sahibi kayıtlı hayvan seçimi | Canlıda |  |
| [APPT-004](../backlog/feature-backlog.md#appt-004--online-akışta-yeni-hayvan-ekleme) | Online akışta yeni hayvan ekleme | Canlıda |  |
| [APPT-005](../backlog/feature-backlog.md#appt-005--tanımlanabilir-randevu-nedenleri) | Tanımlanabilir randevu nedenleri | Canlıda |  |
| [APPT-006](../backlog/feature-backlog.md#appt-006--randevu-nedeni-varsayılan-süre) | Randevu nedeni varsayılan süre | Canlıda |  |
| [APPT-007](../backlog/feature-backlog.md#appt-007--neden-ile-hekimkaynak-eşleştirmesi) | Neden ile hekim/kaynak eşleştirmesi | Canlıda |  |
| [APPT-008](../backlog/feature-backlog.md#appt-008--yalnızca-müsait-gün-ve-saatler) | Yalnızca müsait gün ve saatler | Canlıda |  |
| [APPT-009](../backlog/feature-backlog.md#appt-009--randevu-talebi-oluşturma) | Randevu talebi oluşturma | Canlıda |  |
| [APPT-010](../backlog/feature-backlog.md#appt-010--bekleyen-randevu-talepleri-kuyruğu) | Bekleyen randevu talepleri kuyruğu | Canlıda |  |
| [APPT-011](../backlog/feature-backlog.md#appt-011--kabul-reddet-yeniden-planla) | Kabul, reddet, yeniden planla | Canlıda |  |
| [APPT-012](../backlog/feature-backlog.md#appt-012--onay-ve-red-mesaj-şablonları) | Onay ve red mesaj şablonları | Canlıda |  |
| [APPT-013](../backlog/feature-backlog.md#appt-013--e-posta-bildirimleri) | E-posta bildirimleri | Canlıda |  |
| [APPT-014](../backlog/feature-backlog.md#appt-014--randevu-hatırlatma-tercihleri) | Randevu hatırlatma tercihleri | Canlıda |  |
| [APPT-015](../backlog/feature-backlog.md#appt-015--bildirim-merkezi) | Bildirim merkezi | Canlıda |  |
| [APPT-016](../backlog/feature-backlog.md#appt-016--takvimde-filtrelenebilir-pending-görünüm) | Takvimde filtrelenebilir pending görünüm | Canlıda |  |
| [APPT-017](../backlog/feature-backlog.md#appt-017--inline-müşteri-oluşturma-klinik-içi) | Inline müşteri oluşturma (klinik içi) | Canlıda |  |
| [APPT-018](../backlog/feature-backlog.md#appt-018--inline-hasta-oluşturma-klinik-içi) | Inline hasta oluşturma (klinik içi) | Canlıda |  |
| [APPT-019](../backlog/feature-backlog.md#appt-019--oluşturulan-kaydın-randevu-bağlamına-geri-bağlanması) | Oluşturulan kaydın randevu bağlamına geri bağlanması | Canlıda |  |
| [INT-008](../backlog/feature-backlog.md#int-008--hbs-e-reçete-ve-ats-aşı-kaydı-yardımcısı) | HBS e-Reçete ve ATS aşı kaydı yardımcısı | Canlıda | Tarayıcıda ve pilot hekimle denenmedi |
| [MOBILE-001](../backlog/feature-backlog.md#mobile-001--hasta-sahibi-mobil-deneyimi-pwa) | Hasta sahibi mobil deneyimi (PWA) | Canlıda |  |
| [MOBILE-003](../backlog/feature-backlog.md#mobile-003--push-bildirim-altyapısı) | Push bildirim altyapısı | Canlıda | Kod canlıda ama kapalı: FCM anahtarı yok; MOBILE-002'ye bağlı |
| [MOBILE-004](../backlog/feature-backlog.md#mobile-004--veterinerçalışan-mobil-deneyimi) | Veteriner/çalışan mobil deneyimi | Canlıda | Gerçek cihazda denenmedi |
| [SEC-001](../backlog/feature-backlog.md#sec-001--hesap-kilitleme-ve-giriş-denemesi-koruması) | Hesap kilitleme ve giriş denemesi koruması | Canlıda |  |
| [WEB-001](../backlog/feature-backlog.md#web-001--tanıtım-sitesi-metin-ve-dil-düzeltmeleri-adr-022-boş-iddialar) | Tanıtım sitesi metin ve dil düzeltmeleri (ADR-022, boş iddialar) | Canlıda |  |
| [WEB-002](../backlog/feature-backlog.md#web-002--tanıtım-sitesi-mobil-menü-ve-erişilebilirlik) | Tanıtım sitesi mobil menü ve erişilebilirlik | Canlıda |  |
| [WEB-003](../backlog/feature-backlog.md#web-003--tanıtım-sitesi-teknik-seo-robots-sitemap-canonical-og-json-ld-prerender) | Tanıtım sitesi teknik SEO (robots, sitemap, canonical, OG, JSON-LD, prerender) | Canlıda |  |
| [WEB-004](../backlog/feature-backlog.md#web-004--ana-sayfanın-problem-odaklı-yeniden-yazımı) | Ana sayfanın problem odaklı yeniden yazımı | Canlıda |  |
| [WEB-005](../backlog/feature-backlog.md#web-005--tanıtım-için-gerçek-ekran-görüntüleri-anonim-test-verisi) | Tanıtım için gerçek ekran görüntüleri (anonim test verisi) | Canlıda |  |
| [WEB-007](../backlog/feature-backlog.md#web-007--paketler-sayfası-fiyat-kararı-ve-backend-plan-kataloğu-ile-tek-kaynak) | Paketler sayfası: fiyat kararı ve backend plan kataloğu ile tek kaynak | Canlıda |  |
| [PARTNER-001](../backlog/feature-backlog.md#partner-001--satış-ortağı-ve-indirim-kodu-v1) | Satış ortağı ve indirim kodu v1 | Canlıda | Satış ortakları ekranı tarayıcıda denenmedi |
| [BILL-001](../backlog/feature-backlog.md#bill-001--yıllık-ödeme-dönemi-faturalandırma) | Yıllık ödeme dönemi (faturalandırma) | Canlıda |  |
| [BILL-002](../backlog/feature-backlog.md#bill-002--panel-finalize-ucu-ödemeyi-doğrulamadan-aboneliği-etkinleştiriyor) | Panel "finalize" ucu ödemeyi doğrulamadan aboneliği etkinleştiriyor | Canlıda | Gerçek iyzico ile denenmedi; canlı anahtar yok |
| [BILL-003](../backlog/feature-backlog.md#bill-003--süresi-dolmuş-denemede-üst-plana-geçiş-1-kuruş-çekiyor) | Süresi dolmuş denemede üst plana geçiş 1 kuruş çekiyor | Canlıda | Gerçek iyzico ile denenmedi; canlı anahtar yok |
| [BILL-004](../backlog/feature-backlog.md#bill-004--ödeme-alınıyor-ama-abonelik-açılmıyor-iptal-sonrası-geçersiz-token) | Ödeme alınıyor ama abonelik açılmıyor; iptal sonrası "Geçersiz token" | Canlıda | iyzico sandbox'ta denendi; canlı anahtar yok |
| [BILL-005](../backlog/feature-backlog.md#bill-005--çift-ödeme-aynı-denemede-ikinci-ödeme-otomatik-iade) | Çift ödeme: aynı denemede ikinci ödeme otomatik iade | Canlıda | iyzico sandbox'ta denendi; canlı anahtar yok |
| [TIER-001](../backlog/feature-backlog.md#tier-001--paket-özelliklerinin-uygulamada-zorlanması) | Paket özelliklerinin uygulamada zorlanması | Canlıda | Panel ekranları tarayıcıda görülmedi |
| [TIER-024](../backlog/feature-backlog.md#tier-024--tam-veri-geçişi-klinik-geçmiş-bakiye-hesap-hareketleri-randevu-ürün) | Tam veri geçişi (klinik geçmiş, bakiye, hesap hareketleri, randevu, ürün) | Canlıda | E-vet pilot doğrulamasında B1–B7 çıktı; düzeltmeler dalda, aktarma onlardan sonra |

</details>

## P2 (61 madde)

Planlandı: 14 · Araştırılacak: 10 · Canlıda (kısmen): 5 · Canlıda: 26 · Ertelendi: 6

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [UX-009](../backlog/feature-backlog.md#ux-009--menü-görünümünün-son-hali-satırlar-netleşince) | Menü görünümünün son hali (satırlar netleşince) | Planlandı |  |
| [CHECKOUT-001](../backlog/feature-backlog.md#checkout-001--ziyaret-kapanışı-ve-tahsilat-orkestrasyonu) | Ziyaret kapanışı ve tahsilat orkestrasyonu | Planlandı | Tasarım onaylı (`taslak/hesabi-kapat`); kodlamaya hazır, ~5 dilim |
| [APPT-023](../backlog/feature-backlog.md#appt-023--sms-bildirimleri) | SMS bildirimleri | Planlandı |  |
| [APPT-024](../backlog/feature-backlog.md#appt-024--randevu-talebi-geçmişi-ve-denetim-izi) | Randevu talebi geçmişi ve denetim izi | Planlandı |  |
| [APPT-025](../backlog/feature-backlog.md#appt-025--kaynak-bazlı-takvim) | Kaynak bazlı takvim | Planlandı |  |
| [APPT-026](../backlog/feature-backlog.md#appt-026--kayıtlı-filtreler-ve-talep-görünüm-tercihleri) | Kayıtlı filtreler ve talep görünüm tercihleri | Planlandı |  |
| [INT-003](../backlog/feature-backlog.md#int-003--sms-entegrasyonu) | SMS entegrasyonu | Planlandı |  |
| [INT-004](../backlog/feature-backlog.md#int-004--whatsapp-entegrasyonu) | WhatsApp entegrasyonu | Planlandı |  |
| [INT-006](../backlog/feature-backlog.md#int-006--pos-ve-online-ödeme) | POS ve online ödeme | Planlandı |  |
| [WEB-008](../backlog/feature-backlog.md#web-008--tanıtım-sitesinin-ayrı-derlemesi-ve-çerezsiz-ziyaret-sayacı) | Tanıtım sitesinin ayrı derlemesi ve çerezsiz ziyaret sayacı | Planlandı |  |
| [TIER-011](../backlog/feature-backlog.md#tier-011--hekim-mobil-uygulaması) | Hekim mobil uygulaması | Planlandı |  |
| [TIER-012](../backlog/feature-backlog.md#tier-012--iys-ve-tarbil-araştırması) | İYS ve Tarbil araştırması | Planlandı | Araştırma bitti, ADR-046 kabul; ticari ileti gönderimi canlıda kapalı |
| [TIER-013](../backlog/feature-backlog.md#tier-013--ai-eklentisi-kredi-kota-ve-fon) | AI eklentisi: kredi, kota ve fon | Planlandı | ADR-044 güncellendi (dal `docs/ai-kota`, main'e alınmadı): her pakette kullanıcı başına kota (örnek Temel 100 / Profesyonel 300 / Kurumsal 800 kredi/ay), ek kredi satışı |
| [TIER-014](../backlog/feature-backlog.md#tier-014--ai-altyapısı-ve-ilk-özellik-denemesi) | AI altyapısı ve ilk özellik denemesi | Planlandı | ADR-044 güncellendi (dal `docs/ai-kota`, main'e alınmadı): her pakette kullanıcı başına kota (örnek Temel 100 / Profesyonel 300 / Kurumsal 800 kredi/ay), ek kredi satışı |
| [PORTAL-005](../backlog/feature-backlog.md#portal-005--dijital-onam-ve-imza) | Dijital onam ve imza | Araştırılacak |  |
| [MSG-001](../backlog/feature-backlog.md#msg-001--klinik-inbox) | Klinik inbox | Araştırılacak |  |
| [MSG-002](../backlog/feature-backlog.md#msg-002--iki-yönlü-mesajlaşma) | İki yönlü mesajlaşma | Araştırılacak |  |
| [MSG-003](../backlog/feature-backlog.md#msg-003--konuşmaya-attachment) | Konuşmaya attachment | Araştırılacak |  |
| [MSG-004](../backlog/feature-backlog.md#msg-004--konuşmadan-görev-oluşturma) | Konuşmadan görev oluşturma | Araştırılacak |  |
| [MSG-005](../backlog/feature-backlog.md#msg-005--konuşmayı-hasta-ile-ilişkilendirme) | Konuşmayı hasta ile ilişkilendirme | Araştırılacak |  |
| [MSG-006](../backlog/feature-backlog.md#msg-006--konuşma-arşivleme-ve-kapatma) | Konuşma arşivleme ve kapatma | Araştırılacak |  |
| [IMG-005](../backlog/feature-backlog.md#img-005--dicom-desteği-araştırması) | DICOM desteği araştırması | Araştırılacak |  |
| [IMG-006](../backlog/feature-backlog.md#img-006--dijital-röntgen-cihazı-entegrasyonu-araştırması) | Dijital röntgen cihazı entegrasyonu araştırması | Araştırılacak |  |
| [INT-001](../backlog/feature-backlog.md#int-001--laboratuvar-cihazı-entegrasyonu-araştırması) | Laboratuvar cihazı entegrasyonu araştırması | Araştırılacak |  |
| [RECORD-003](../backlog/feature-backlog.md#record-003--record-attachment) | Record attachment | Canlıda (kısmen) | Dosya eki yalnız görüntüleme ve lab kayıtlarında |
| [PORTAL-002](../backlog/feature-backlog.md#portal-002--portal-hayvan-profili) | Portal hayvan profili | Canlıda (kısmen) | Fotoğraf, belge, not, ziyaret yok |
| [PORTAL-003](../backlog/feature-backlog.md#portal-003--portal-reminders-visits-ve-documents) | Portal reminders, visits ve documents | Canlıda (kısmen) | Ziyaret ve belge listesi yok |
| [PORTAL-004](../backlog/feature-backlog.md#portal-004--açık-fatura-görüntüleme) | Açık fatura görüntüleme | Canlıda (kısmen) | Bakiye/ödeme var; fatura modeli yok (ADR-012) |
| [APPT-036](../backlog/feature-backlog.md#appt-036--provider-seçimlerinde-uygunluk-ve-rol-filtresi) | Provider seçimlerinde uygunluk ve rol filtresi | Canlıda (kısmen) | Hekim filtresi yalnız geliş diyaloğunda |
| [UX-007](../backlog/feature-backlog.md#ux-007--rol-bazlı-ayrı-menüler) | Rol bazlı ayrı menüler | Ertelendi |  |
| [FIN-006](../backlog/feature-backlog.md#fin-006--çoklu-para-birimi) | Çoklu para birimi | Ertelendi |  |
| [FIN-007](../backlog/feature-backlog.md#fin-007--eski-ödemelerin-bağlanması-ve-açılış-bakiyesi) | Eski ödemelerin bağlanması ve açılış bakiyesi | Ertelendi | İçe aktarmada açılış bakiyesi var (TIER-024); elle kayıt ertelendi |
| [FIN-009](../backlog/feature-backlog.md#fin-009--düzeltme-yetkisinin-kontrollü-gevşetilmesi) | Düzeltme yetkisinin kontrollü gevşetilmesi | Ertelendi |  |
| [RECORD-007](../backlog/feature-backlog.md#record-007--muayene-yeniden-açma-ve-revizyon-geçmişi) | Muayene yeniden açma ve revizyon geçmişi | Ertelendi |  |
| [AI-006](../backlog/feature-backlog.md#ai-006--doğal-dille-hasta-kayıtlarında-arama) | Doğal dille hasta kayıtlarında arama | Ertelendi | ADR-044 değişti (dal `docs/ai-kota`): her pakette kotalı dahil olacak; pilot sonrası |

<details><summary>Canlıda olanlar (26)</summary>

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [TRIAL-009](../backlog/feature-backlog.md#trial-009--sürümlü-kullanım-şartları-ve-hukuki-metin-kabulü) | Sürümlü kullanım şartları ve hukuki metin kabulü | Canlıda | Metinler yayında; hukukçu görüşü beklenmiyor (2026-11-09) |
| [EXAM-013](../backlog/feature-backlog.md#exam-013--bundle-kalem-seçimi-ve-miktar-düzenleme) | Bundle kalem seçimi ve miktar düzenleme | Canlıda | 2026-11-11 main, canlı sürümde |
| [RECORD-004](../backlog/feature-backlog.md#record-004--record-duplicate) | Record duplicate | Canlıda | Reçete/tedavi kopyası; canlı sürümde |
| [APPT-020](../backlog/feature-backlog.md#appt-020--kopyalanabilir-html-randevu-butonu) | Kopyalanabilir HTML randevu butonu | Canlıda |  |
| [APPT-021](../backlog/feature-backlog.md#appt-021--iframe-embed-kodu) | iframe embed kodu | Canlıda |  |
| [APPT-022](../backlog/feature-backlog.md#appt-022--klinik-logo-ve-renk-özelleştirmesi) | Klinik logo ve renk özelleştirmesi | Canlıda | Tarayıcıda görülmedi |
| [SEC-002](../backlog/feature-backlog.md#sec-002--izinlerin-jwtde-taşınması-ve-yetki-geri-alma-gecikmesi) | İzinlerin JWT'de taşınması ve yetki geri alma gecikmesi | Canlıda |  |
| [WEB-006](../backlog/feature-backlog.md#web-006--yeni-tanıtım-sayfaları-özellikler-defterler-ve-kvkk-geçiş-iletişimdemo-hakkımızdadestek) | Yeni tanıtım sayfaları: Özellikler, Defterler ve KVKK, Geçiş, İletişim/Demo, Hakkımızda/Destek | Canlıda | İçerik kalitesi doğrulanmadı |
| [TIER-002](../backlog/feature-backlog.md#tier-002--klinik-web-sitesi-oluşturucu) | Klinik web sitesi oluşturucu | Canlıda | Site Node süreci canlıda (`/k/*`); hazır fotoğraf setinin lisansı açık |
| [TIER-003](../backlog/feature-backlog.md#tier-003--otomatik-hatırlatıcılar) | Otomatik hatırlatıcılar | Canlıda | "Uzun süredir gelmedi" kuralı İYS/ticari ileti onayına kadar göndermez |
| [TIER-004](../backlog/feature-backlog.md#tier-004--gelişmiş-raporlar) | Gelişmiş raporlar | Canlıda | Varsayımlar kullanıcı onayı bekliyor |
| [TIER-005](../backlog/feature-backlog.md#tier-005--otomatik-aşı-sihirbazı) | Otomatik aşı sihirbazı | Canlıda |  |
| [TIER-006](../backlog/feature-backlog.md#tier-006--mobil-barkod) | Mobil barkod | Canlıda | Gerçek telefon kamerasıyla denenmedi |
| [TIER-007](../backlog/feature-backlog.md#tier-007--patron-ekranı) | Patron ekranı | Canlıda | Tarayıcıda görülmedi; varsayımlar onay bekliyor |
| [TIER-008](../backlog/feature-backlog.md#tier-008--çoklu-kasa-ve-nakit-yönetimi) | Çoklu kasa ve nakit yönetimi | Canlıda | Çoklu kasa; küçük açıklar backlog notunda |
| [TIER-009](../backlog/feature-backlog.md#tier-009--api-erişimi) | API erişimi | Canlıda | İlk dilim (salt okunur API anahtarı) |
| [TIER-010](../backlog/feature-backlog.md#tier-010--size-özel-geliştirmeler) | Size özel geliştirmeler | Canlıda | Sınır/yetki/durum akışı varsayım, onay bekliyor |
| [TIER-015](../backlog/feature-backlog.md#tier-015--veteriner-bul) | Veteriner bul | Canlıda | Veteriner bul site haritası robots.txt'ye eklenmedi |
| [TIER-016](../backlog/feature-backlog.md#tier-016--randevu-talebinde-kaynak-bilgisi) | Randevu talebinde kaynak bilgisi | Canlıda |  |
| [TIER-017](../backlog/feature-backlog.md#tier-017--herkese-açık-en-yakın-müsait-saat) | Herkese açık en yakın müsait saat | Canlıda |  |
| [TIER-018](../backlog/feature-backlog.md#tier-018--bekleme-listesi) | Bekleme listesi | Canlıda | Test düzeltmesi (İstanbul günü) main'de; yalnız test, canlıyı etkilemez |
| [TIER-019](../backlog/feature-backlog.md#tier-019--hatırlatmada-onayla--iptal-et) | Hatırlatmada onayla / iptal et | Canlıda |  |
| [TIER-020](../backlog/feature-backlog.md#tier-020--hatırlatmada-takvime-ekle) | Hatırlatmada takvime ekle | Canlıda |  |
| [TIER-021](../backlog/feature-backlog.md#tier-021--rakip-programdan-veri-aktarımı-ve-kurulum-görüşmesi) | Rakip programdan veri aktarımı ve kurulum görüşmesi | Canlıda | Panel tarayıcıda görülmedi |
| [TIER-022](../backlog/feature-backlog.md#tier-022--ilk-hafta-rehberleri) | İlk hafta rehberleri | Canlıda | Kartın yeni tasarımı taslakta (ilk hafta tasarım oturumu) |
| [TIER-023](../backlog/feature-backlog.md#tier-023--paketler-sayfası-okunurluğu) | Paketler sayfası okunurluğu | Canlıda |  |

</details>

## P3 (10 madde)

Planlandı: 2 · Araştırılacak: 7 · Ertelendi: 1

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [APPT-030](../backlog/feature-backlog.md#appt-030--whatsapp-bildirimleri) | WhatsApp bildirimleri | Planlandı |  |
| [APPT-033](../backlog/feature-backlog.md#appt-033--qr-kod-ile-randevu-sayfası) | QR kod ile randevu sayfası | Planlandı |  |
| [EXAM-014](../backlog/feature-backlog.md#exam-014--item-rules-bundle-ve-record-oluşturma) | Item rules (bundle ve record oluşturma) | Araştırılacak |  |
| [APPT-027](../backlog/feature-backlog.md#appt-027--javascript-booking-widget) | JavaScript booking widget | Araştırılacak |  |
| [APPT-028](../backlog/feature-backlog.md#appt-028--online-depozito) | Online depozito | Araştırılacak |  |
| [APPT-029](../backlog/feature-backlog.md#appt-029--depozito-iade-ve-iptal-politikaları) | Depozito iade ve iptal politikaları | Araştırılacak |  |
| [APPT-031](../backlog/feature-backlog.md#appt-031--google-calendar-senkronizasyonu) | Google Calendar senkronizasyonu | Araştırılacak |  |
| [APPT-032](../backlog/feature-backlog.md#appt-032--ics--apple-calendar--outlook-desteği) | .ics / Apple Calendar / Outlook desteği | Araştırılacak |  |
| [APPT-035](../backlog/feature-backlog.md#appt-035--ai-destekli-uygun-saat-önerisi) | AI destekli uygun saat önerisi | Araştırılacak |  |
| [APPT-034](../backlog/feature-backlog.md#appt-034--mini-klinik-sayfası) | Mini klinik sayfası | Ertelendi | TIER-002 kapsamına alındı |

## Belirlenmemiş (1 madde)

Planlandı: 1

| Kimlik | Başlık | Durum | Not |
|---|---|---|---|
| [UX-010](../backlog/feature-backlog.md#ux-010--ingilizce-dil-desteği) | İngilizce dil desteği | Planlandı | Kullanıcı isteği 2026-11-12; öncelik belirlenmedi |
