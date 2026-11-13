# Sistem katalogları: kaynak araştırması (2026-11-12)

> Araştırma belgesidir; geliştirme kararı değildir ([README](README.md)). Koda ya da seed'e dokunulmadı. Öneriler backlog'a [WORKFLOW.md](../WORKFLOW.md) sürecine göre alınır.

**Soru:** Bütün kliniklerin ortak kullandığı sistem katalogları (tür, ırk, renk, aşı, şikâyet, tanı, muayene şablonu) nereden geldi, güvenilir bir kaynakla doğrulandı mı?

**Kısa yanıt:** Hayır, bugüne kadar doğrulanmadı. Kataloglar genel veteriner bilgisiyle ve pilot kliniğin E-vet verisindeki adlarla dolduruldu. Bu belge kataloğu kaynaklarla karşılaştırıyor, lisans durumunu çıkarıyor, düzeltme ve ekleme önerilerini her satırın kaynağıyla birlikte veriyor.

**Karşılaştırma tabanı:** Backend `feature/katalog-literatur` dalı, `dabbb21d` (henüz main'de değil). Bu dalda yapılan düzeltmeler §2'de "yapıldı" olarak ayrıldı ve tekrar önerilmedi.

**Yöntem:** Web araması ve sayfa okuma (2026-11-12). Giriş gerektiren sayfa açılmadı. Rakip yazılımlardan (E-vet, Kolayvet vb.) veri alınmadı.

**Kaynak etiketleri:**
- **[O]**: Sayfa ya da PDF okundu. Sayfalar bir özetleme aracıyla okundu, PDF'ler metne çevrildi.
- **[A]**: Bilgi yalnız arama sonucu özetine dayanıyor. Uygulamadan önce sayfası açılmalı.
- **[G]**: Genel veteriner bilgisi. Bu satırlar için kaynak okunmadı; sıklık ya da standart sözlükle doğrulanmalı.

---

## 1. Özet

| Katalog | Mevcut | Önerilen düzeltme | Önerilen ekleme | Ana kaynak |
|---|---|---|---|---|
| Tür | 27 | 1 (Sürüngen altındaki yinelenen 3 ırk) | 2 (Manda, Küçük kemirgen) | 2004/39 Tebliği, taksonomi |
| Köpek ırkı | 73 | 10 | 27 | FCI nomenklatürü, 5199 s. Kanun |
| Kedi ırkı | 26 | 6 | 12 | FIFe ırk listesi, TDK |
| Diğer türlerin ırkları | 127 | 12 | 49 (çoğu çiftlik, düşük öncelik) | ARBA, 2004/39 Tebliği, TÜBA |
| Renk | 34 | 3 | 23 | FIFe EMS, TDK |
| Aşı | 30 | 12 | 18 | HBS ruhsatlı biyolojik ürünler, Kuduz Yönetmeliği, WSAVA 2024 |
| Şikâyet | 30 | 5 | 30 | VetCompass sıklık çalışmaları, VeNom yapısı |
| Tanı | 43 | 2 | 58 | VetCompass, WOAH, ihbarı mecburi hastalıklar |
| Muayene şablonu | 3 | 2 | 9 | AAHA, WSAVA, VetCompass |
| **Toplam** | | **53** | **228** | |

Bunlara ek olarak 8 yapısal öneri var (§9). Bunların 6'sı ürün kararı ya da şema değişikliği gerektiriyor.

**En önemli üç bulgu:**
1. **Aşılarda `IsCore` "çekirdek aşı" anlamına gelmiyor.** Alan, "sistem satırı, klinik değiştiremez" anlamında kullanılıyor: Update, Activate ve Deactivate komutlarındaki koşul `TenantId is null || IsCore`. Seeder de her açılışta değeri `true` yapıyor. WSAVA'nın çekirdek / çekirdek dışı / önerilmeyen ayrımı için ayrı bir alan gerekiyor.
2. **Katalogda Türkiye'de ruhsatı olmayan aşılar var.** FIV ve FIP aşılarının HBS'de ruhsatlı ürünü yok. FIP aşısını WSAVA önermiyor. FIV aşısı AB'de hiç ruhsat almadı.
3. **VeNom ve SNOMED doğrudan kullanılamaz.** VeNom ücretsiz ama imzalı anlaşma istiyor ve terimlerde değişiklik yapılmasını yasaklıyor; Türkçe çeviri bu yasağa takılıyor. SNOMED Veterinary Extension ise Türkiye için yıllık ücretli. Kendi Türkçe listemizi olgu niteliğindeki adlarla sürdürmek doğru yol.

---

## 2. `feature/katalog-literatur` dalında zaten yapılanlar (tekrar önerilmez)

| Alan | Yapılan |
|---|---|
| Tür | Gelincik → Ferret (Gelincik). Sürüngen sırası 80 → 63; Kaz ile çakışma giderildi. |
| Köpek | Maltese Terrier → Maltese (FCI 65), Macar Tazısı (Vizsla) → Vizsla (Macar Kısa Tüylü Pointer) (FCI 57), Husky → Sibirya Kurdu (Siberian Husky) (FCI 270), Doberman → Dobermann (FCI 143), Drahthaar → Alman Tel Tüylü Pointer (Drahthaar) (FCI 98), Epanyöl Breton → Epanyol Breton, "Terrieri" yazımları → "Terrier" |
| Kedi | Norwegian Forest → Norwegian Forest Cat |
| Tavuk | Lohman Brown → Lohmann Brown |
| Aşı | Bronşin (Bordetella), Lösemi (FeLV), Koronavirüs, Lyme (Borelyoz), Mantar (Dermatofitoz), At İnfluenzası, Koyun ve Keçi Çiçeği, Sığırların Nodüler Ekzantemi (LSD), Küçük Ruminantların Vebası (PPR), Tavşanların Viral Hemorajik Hastalığı (RHD) |
| Renk | Alacalı (PIEBALD) ile Üç Renkli (Calico) ayrıldı |

**Bu daldaki iki adı yeniden ele almak gerekiyor:**
- **PPR:** Bakanlık "Küçük Ruminant(ların) Vebası" adını kullanmıyor. 2025 Hayvan Hastalıkları ile Mücadele Genelgesi'nde "Koyun-Keçi Vebası" 11 kez geçiyor, "Küçük Ruminant" hiç geçmiyor. HBS'deki ad da "KOYUN KEÇİ VEBASI" [O]. Öneri: **"Koyun ve Keçi Vebası (PPR)"**.
- **Epanyol Breton:** FCI 95'in adı "Epagneul Breton (Brittany Spaniel)" [O]. Fonetik yazım aramada bulunmuyor. Öneri: **"Epagneul Breton (Brittany)"**, eski yazım takma ad olarak kalsın.

---

## 3. Kaynaklar ve lisans durumu

### 3.1 Kaynak tablosu

| # | Kaynak | URL | Ne için | Lisans / kullanım şartı | Durum |
|---|---|---|---|---|---|
| S1 | FCI Nomenclature ve 10 grup sayfası | https://www.fci.be/en/Nomenclature/ | Köpek ırklarının resmî adları ve numaraları | Yeniden kullanım şartı yok. Legal notice yalnız künye içeriyor (https://www.fci.be/en/Legal-notice-97.html). | [O] |
| S2 | FCI 331 ad değişikliği (2018) | https://www.fci.be/en/COBAN-KOPEGI-331-change-in-the-breed-name-and-new-standard-2435.html | Kangal Çoban Köpeği | Aynı | [O] |
| S3 | Dogs Australia, Anatolian / Kangal açıklaması (2018) | https://dogsaustralia.org.au/members/member-news/the-future-of-the-anatolian-shepherd-dog-in-australia/ | Anadolu Çoban Köpeği ile Kangal'ın ayrımı | — | [O] |
| S4 | Ün ve ark. 2016, Malaklı gen bankası, Bahri Dağdaş Hay. Araşt. Derg. 5(1) | https://dergipark.org.tr/en/download/article-file/416877 | Türk köpek ırkları, standart durumu | Akademik | [O] |
| S5 | 5199 sayılı Hayvanları Koruma Kanunu | https://www.mevzuat.gov.tr/mevzuatmetin/1.5.5199.pdf | Geçici Md. 3, tehlikeli ırklar | Mevzuat (FSEK md. 31) | [O] |
| S6 | FIFe ırk listesi | https://fifeweb.org/cats/breeds/ | Kedi ırkları | Belirtilmemiş | [O] |
| S7 | FIFe EMS renk ve desen kodları | https://fifeweb.org/?p=1125 | Renk ve desen terimleri | "Creative Commons" yazıyor, sürüm belirtilmemiş | [O] |
| S8 | CFA ırklar ve kullanım şartları | https://cfa.org/breeds/ · https://cfa.org/terms-of-use/ | Kedi ırkları | "No material may be reproduced … without written permission" | Kısmen [O] |
| S9 | TICA | https://tica.org/ | Kedi ırkları | Site 403 verdi | [A] |
| S10 | ARBA tanınan ırklar ve kullanım şartları | https://arba.net/recognized-breeds/ · https://arba.net/terms-of-use/ | Tavşan ırkları | "may not be reproduced … except with the prior written permission" | [O] |
| S11 | Tebliğ 2004/39, Yerli Hayvan Irk ve Hatlarının Tescili (RG 12.12.2004/25668) | https://faolex.fao.org/docs/pdf/tur120468.pdf | Tescilli yerli çiftlik ırkları | Mevzuat | [O] |
| S12 | RG 16.05.2019/30776, Tescil Komitesi kararı | https://istanbul.tarimorman.gov.tr/BelgelerArsiv/SolMenu/RESMI%20GAZETE2019-2019/CUMHURBASKYONETIMSISTEMI2019/EvciilHayvanGenKaynak.pdf | Zerdava köpeği ve Ayvacık Atı tescilleri reddedildi | Mevzuat | [O] |
| S13 | TÜBA raporu, yerli ırklar bölümü | https://www.tuba.gov.tr/files/yayinlar/raporlar/TUBA-978-625-8352-58-0_ch12.pdf | Yerli koyun, keçi, sığır ve at ırkları | Kontrol edilmedi | [O] |
| S14 | TDK Güncel Türkçe Sözlük | https://sozluk.gov.tr/ | Kırçıl, alaca, boz, tekir, sarman | — | [O] |
| S15 | HBS, Ruhsatlı Veteriner Biyolojik Ürünler sorgusu | https://hbs.tarbil.gov.tr/Receipt/SearchVaccine | Türkiye'de ruhsatlı aşılar (2026-11-12 tarihinde 483 kayıt) | Kullanım şartı yok; canlı sorgu, güncelleme tarihi yok | [O] |
| S16 | Bakanlık, Pazarlama İzinleri | https://www.tarimorman.gov.tr/Konular/Veteriner-Hizmetleri/Veteriner-Saglik-Urunleri/pazarlama-izinleri | S15'e giden bağlantı | — | [O] |
| S17 | Kuduz Hastalığından Korunma ve Kuduz Hastalığı ile Mücadele Yönetmeliği (RG 18.01.2012/28177) | https://www.resmigazete.gov.tr/eskiler/2012/01/20120118-3.htm | Kuduz yaşı, aralığı, kayıt | Mevzuat | [O] (2025 tarihli kopya) |
| S18 | 2025 Yılı Hayvan Hastalıkları ile Mücadele ve Hayvan Hareketleri Kontrolü Genelgesi | https://etb.org.tr/public/30012/Cms/650c4e08-f2f2-5e80-fe5d-11de5870b814/2025%20Y%C4%B1l%C4%B1%20Hayvan%20Hastal%C4%B1klar%C4%B1%20ile%20M%C3%BCcadele%20ve%20Hayvan%20Hareketleri%20Kontrol%C3%BC%20Genelgesi.pdf | Programlı aşılar, resmî hastalık adları, serbest hekim izni | Resmî belge | [O] |
| S19 | Brusella Konjunktival Aşı Genelgesi 2019/6 | https://faolex.fao.org/docs/pdf/tur196615.pdf | S19 ve Rev-1 aşı yaşları | Resmî belge | [O] |
| S20 | WSAVA 2024 Aşılama Kılavuzu (Squires ve ark., JSAP 65(5):277-316) | https://wsava.org/wp-content/uploads/2024/04/WSAVA-Vaccination-guidelines-2024.pdf | Çekirdek / çekirdek dışı / önerilmeyen aşılar, aralıklar | Okuması ücretsiz, CC BY değil ("All Rights Reserved", Wiley şartları). Tablolar kopyalanmaz, kaynak gösterilip kendi metnimiz yazılır. | [O] |
| S21 | KHVHD Aşı Rehberi (Eylül 2018), WSAVA'nın Türkiye uyarlaması | https://tr.mypet.com/wp-content/uploads/sites/27/2023/11/04.MSD_Asi-Rehberi.pdf | Türkiye'de çekirdek / çekirdek dışı ayrımı | Belirtilmemiş; belge bir aşı firmasının sitesinde | [O] |
| S22 | ESCCAP GL1, 7. baskı (2025) | https://www.esccap.org/uploads/docs/ag51r456_0778_ESCCAP_GL1__English_2026_v23.pdf | Antiparaziter uygulama sıklığı | "© ESCCAP, All rights reserved" | [O] |
| S23 | AAHA köpek aşı kılavuzu (2022, 2024 güncellemesi); AAHA/AAFP kedi aşı kılavuzu (2020) | https://www.aaha.org/canine-vaccinations · https://aaha.org/resources/2020-aahaaafp-feline-vaccination-guidelines/ | Leptospira çekirdek; FIP önerilmez | — | [A] (403) |
| S24 | VeNom: ana sayfa, kod açıklaması, kullanım şartları, erişim | https://venomcoding.org/ · https://venomcoding.org/venom-codes/ · https://venomcoding.org/terms-and-conditions/ · https://venomcoding.org/ftp-download/ | Tanı, şikâyet ve ziyaret nedeni sözlüğü | §3.2 | [O] |
| S25 | SNOMED üyeleri ve lisans; Veterinary Extension erişimi | https://www.snomed.org/members · https://snomed.org/licensing · https://vtsl.vetmed.vt.edu/About/faq.cfm | Veteriner terminoloji | §3.2 | [O] |
| S26 | ICD-11 lisansı (WHO) | https://icd.who.int/en/docs/icd11-license.pdf | Genel patoloji adları | CC BY-ND 3.0 IGO; çeviri için ayrı WHO anlaşması gerekir | [O] |
| S27 | O'Neill ve ark. 2014, köpekte birinci basamak bozukluklar (PLoS One) | https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0090501 | En sık bozukluklar ve oranları | CC BY 4.0 | [O] |
| S28 | O'Neill ve ark. 2023, kedide birinci basamak bozukluklar (JFMS) | https://www.ebi.ac.uk/europepmc/webservices/rest/PMC10812063/fullTextXML | En sık 30 bozukluk | CC BY-NC 4.0 | [O] |
| S29 | O'Neill ve ark. 2020, tavşan (Vet Rec) | https://agris.fao.org/search/en/records/65df4b7d4c5aef494fe17ea2 | Tavşanda sık durumlar | Bilinmiyor | [A] |
| S30 | WOAH Karasal Kod Bölüm 1.3, listelenmiş hastalıklar | https://www.woah.org/fileadmin/Home/eng/Health_standards/tahc/current/chapitre_oie_listed_disease.pdf | Bildirime tabi hastalıklar | © WOAH; hastalık adları olgu bilgisi | [O] (2022 sürümü) |
| S31 | İhbarı mecburi hastalıklar listesi (MAKÜ Veteriner Fakültesi belgesi) | https://depo2.mehmetakif.edu.tr/storage/veteriner/contents/17743/26_17743_2024-07-25-12-22-19-498339_ihbari-zorunlu-hastaliklar.pdf | Türkiye'de ihbarı mecburi 34 hastalık (2020) | Dayandığı mevzuat serbest | [O] (ikincil kaynak) |
| S32 | MSD Veterinary Manual izinleri | https://www.msdvetmanual.com/content/permissions | Referans | "All rights reserved"; yeniden kullanım izne bağlı | [O] |
| S33 | WSAVA Global Nutrition Toolkit; Glasgow CMPS-SF | https://wsava.org/global-guidelines/global-nutrition-guidelines/ · https://wsava.org/wp-content/uploads/2020/01/Canine-CMPS-SF.pdf | VKS 1–9, kas kondisyonu, ağrı skoru | WSAVA telifli; Glasgow ölçeğinin ticari kullanımı ayrı lisans ister | [O] / [A] |
| S34 | AAHA 2020 Anestezi, AAHA 2023 Yaşlı Hayvan, AAHA/AAFP 2021 Kedi Yaşam Evreleri kılavuzları | https://www.aaha.org/resources/2020-aaha-anesthesia-and-monitoring-guidelines-for-dogs-and-cats/phase-1-preanesthesia/ · https://www.aaha.org/resources/2023-aaha-senior-care-guidelines-for-dogs-and-cats/ · https://www.aaha.org/resources/2021-aaha-aafp-feline-life-stage-guidelines/pe-and-history-focus/ | Şablon başlıkları | — | [A] |
| S35 | FSEK 5846 | https://www.mevzuat.gov.tr/mevzuatmetin/1.3.5846.pdf | md. 6/11, md. 21, md. 31, Ek md. 8 | Kanun | [O] |
| S36 | US Copyright Office, Circular 33 | https://www.copyright.gov/circs/circ33.pdf | Adların telif konusu olmaması | Kamu malı | [O] |

### 3.2 Lisans sonuçları

| Kaynak | Ne alınabilir | Ne alınamaz | Sonuç |
|---|---|---|---|
| FCI, FIFe, CFA, TICA, ARBA | Tek tek ırk adları. Adlar olgudur ve telif konusu değildir [S36]. | Standart metinleri, açıklamalar, görseller (CFA ve ARBA açıkça yasaklıyor). Listenin numara ve grup yapısıyla toptan aktarılması (FSEK Ek md. 8, AB 96/9 veri tabanı hakkı). | Klinik ihtiyaca göre seçilmiş, Türkçe adlandırılmış, birden çok kaynakla çapraz kontrol edilmiş ad listesi kullanılabilir. FCI numarası seed'de yalnız yorum olarak tutulsun. |
| Tebliğ 2004/39, Resmî Gazete, Bakanlık genelgeleri, Kuduz Yönetmeliği | Adlar ve kurallar | — | Serbest (FSEK md. 31). |
| HBS ruhsatlı ürün listesi | Hastalık ve antijen adları | Ticari ürün adları (öneri bunları kapsamıyor) | Kullanım şartı yazmıyor; yalnız olgu niteliğindeki hastalık adları alınır. |
| WSAVA 2024, KHVHD 2018, ESCCAP, AAHA | Sınıflama ve aralık bilgisi; kaynak gösterilerek kendi cümlemizle | Tablolar ve metin | Kılavuzlar okunur ve atıf yapılır, içerik kopyalanmaz. |
| **VeNom** | Kayıt ve imzalı mektup anlaşmasıyla kodlar ücretsiz. Ticari yazılımlarda kullanılıyor (RXWorks, Medsoft vb.). | Şartlarda şu madde var: "The end user will make no additions, subtractions, or changes to the terms." Toptan Türkçe çeviri bu maddeye ve FSEK md. 21'deki işleme hakkına takılıyor. Atıf yalnız anlaşma süresince yapılabiliyor. | **Önerilmez.** Kendi listemiz sürsün. Uluslararası eşleme gerekirse (sigorta, araştırma) VeNom'a başvurulur ve mektupta çeviri ile gömme izni açıkça sorulur: https://venomcoding.org/contact-us/ |
| **SNOMED CT Veterinary Extension** ve AAHA tanı terimleri | — | Türkiye SNOMED üyesi değil (54 üye). Üye olmayan ülkede affiliate lisans yıllık ve ücretli (USD, sistem başına; ör. muayenehane 652, Band B kurum 1.303). Web uygulaması için özel fiyat SNOMED'den isteniyor. | **Önerilmez.** Bugünkü ihtiyaç için gereksiz maliyet. |
| ICD-11 | Yazılıma gömülebilir. | Çeviri ayrı WHO anlaşması istiyor; içerik insan hekimliğine yönelik. | Önerilmez. |
| MSD Veterinary Manual | — | Bütün hakları saklı | Yalnız okuma kaynağı. |
| WSAVA VKS çizelgesi, Glasgow ağrı ölçeği | Başlık etiketi ("VKS (1–9):", "Ağrı skoru / kullanılan ölçek:") | Çizelge ve ölçek metni | Şablona yalnız etiket konur. |

Bu tablo bir bulgu özetidir, hukuki görüş değildir.

---

## 4. Tür ve ırk

**Adlandırma kuralı (öneri):** Görünen ad "Türkçe yaygın ad (resmî ya da uluslararası ad)" biçiminde olsun. Bu biçim `feature/katalog-literatur` dalında başladı. Eski adlar `ImportValueResolver` içinde takma ad olarak kalır.

### 4.1 Tür

| # | Satır | Öneri | Kaynak |
|---|---|---|---|
| T1 | REPTILE altındaki "Kaplumbağa", "Kertenkele", "Yılan" ırkları | Pasifleştirilsin. Bunlar TURTLE, LIZARD ve SNAKE ile yineleniyor. REPTILE yalnız "Bilinmeyen" ve "Diğer" ile kalsın (E-vet'ten gelen genel "sürüngen" kayıtları için). | Katalog içi tutarlılık |
| T-E1 | **Manda** (WATER_BUFFALO) eklensin; ırkı "Anadolu Mandası" | Tescilli yerli ırk, ekonomik önemi var. Katalogdaki en kritik tür eksiği. | S11 [O] |
| T-E2 | **Küçük Kemirgen** eklensin; ırkları "Sıçan", "Fare", "Gerbil", "Degu", "Diğer" | Pet kliniklerde görülen küçük memeliler; her biri için ayrı tür açmak gereksiz. | [G] |

Not: EXOTIC ile OTHER'ın ikisinde de "Bilinmeyen" ve "Diğer" ırkı var. EXOTIC, E-vet içe aktarmasında kullanılan bir tür; kalsın. Kuş, balık, sürüngen ve hamster altındaki "ırklar" aslında hayvan türleri. Bu kabul edilebilir bir sadeleştirme, değişiklik önerilmiyor.

### 4.2 Köpek: düzeltme (10)

| # | Mevcut | Öneri | Gerekçe | Kaynak |
|---|---|---|---|---|
| K1 | Alman Kurdu | Alman Çoban Köpeği (Alman Kurdu) | FCI 166 German Shepherd Dog | S1 [O] |
| K2 | Kangal | Kangal Çoban Köpeği (Kangal) | FCI 331. Kesin kabul 1989'da; ad ve standart 2018'de değişti. | S1, S2 [O] |
| K3 | Cocker Spaniel | İngiliz Cocker Spaniel | Belirsiz bir ad. FCI 5 English Cocker; Amerikan Cocker (FCI 167) zaten ayrı satırda. | S1 [O] |
| K4 | Pointer | İngiliz Pointer (Pointer) | FCI 1. Tek başına "Pointer" belirsiz; Alman pointer'lar da katalogda. | S1 [O] |
| K5 | Pinscher | Alman Pinscher | FCI 184. Minyatür Pinscher (FCI 185) ayrı satırda. | S1 [O] |
| K6 | Spitz | Alman Spitz | FCI 97, beş varyeteli. Japon Spitz (FCI 262) ayrı ırk (K-E7). Pomeranian, FCI 97'nin bir varyetesi ama klinik dilinde ayrı geçtiği için ayrı satır kalsın. | S1 [O] |
| K7 | Belçika Malinois | Belçika Çoban Köpeği (Malinois) | FCI 15'in varyetesi; ayrı FCI numarası yok. | S1 [O] |
| K8 | Mastiff | İngiliz Mastifi (Mastiff) | FCI 264. Napoliten (197) ve Tibet (230) mastiflerinden ayırmak için. | S1 [O] |
| K9 | Epanyol Breton | Epagneul Breton (Brittany) | FCI 95. §2'ye bakın. | S1 [O] |
| K10 | Polonya Av Köpeği | Polonya Av Köpeği (Gończy Polski) | FCI'da üç aday var: 354, 52, 333. Adı birebir karşılayan FCI 354. | S1 [O] |

**Kalanlar:** Pekingese, Pug, Chow Chow, Akita, Amerikan Akita, Dogo Argentino, Boxer, Rottweiler, Beagle, Border Collie, Chihuahua, Jack Russell Terrier, Shih Tzu, Yorkshire Terrier, Samoyed, Golden, Labrador, Afgan Tazısı, İngiliz Setter, Alman Kısa Tüylü Pointer, Dalmaçyalı, Saint Bernard, Amerikan Staffordshire, Bull Terrier, Airedale, Cavalier ve King Charles, Border Terrier, Avustralya Terrier, Affenpinscher, Tibet Terrier, Presa Canario, Beyaz İsviçre Çoban, Avustralya Çoban, Avustralya Sığır Köpeği, Bobtail, Rus Siyah Terrier ve Kafkas Çoban Köpeği FCI'da var. Hepsi doğru, kalıyor (S1 [O]).

**Özel durumlar:**
- **Anadolu Çoban Köpeği:** FCI 2018'de 331'in adını Anatolian'dan Kangal'a çevirdi. Avustralya (ANKC) iki ayrı kayıt tutuyor (S3 [O]). Yurt dışı kökenli kayıtlar için satır kalsın.
- **Pitbull Tipi:** FCI'da yok. 5199 Geçici Md. 3 "Pitbull Terrier" diyor (S5 [O]). Yasal kayıt için satır gerekli, kalsın.
- **Maltipoo:** Irk değil, melez. Klinikte sık geçtiği ve aramayı kolaylaştırdığı için kalsın.
- **Türk ırkları** (Akbaş, Aksaray Malaklısı, Kars, Tarsus Çatalburun, Türk Tazısı, Zağar): FCI'da yok. Bakanlık Tescil Komitesi'nin bunlar için bir tescil kararı bulunamadı. Malaklı'nın ırk standardı yok (S4 [O]). Yerel adlar olarak kalsınlar. Kangal FCI'nın tanıdığı tek Türk ırkı.

### 4.3 Köpek: ekleme (27)

Hepsi FCI'da kesin kabul görmüş ırklar (S1 [O]). Türkiye'de resmî ırk sıklığı istatistiği yok, PetVet dağılımı da yayımlanmamış. Bu yüzden seçim klinik yaygınlık varsayımına dayanıyor. Eklemeden önce Vetinity verisindeki serbest metin ırk sıklığıyla kontrol edilmeli (§10).

| # | Ad | FCI |
|---|---|---|
| K-E1 | Alaska Malamutu | 243 |
| K-E2 | Weimaraner | 99 |
| K-E3 | Bichon Frisé | 215 |
| K-E4 | Havanese | 250 |
| K-E5 | Lhasa Apso | 227 |
| K-E6 | Shiba | 257 |
| K-E7 | Japon Spitz | 262 |
| K-E8 | Welsh Corgi Pembroke | 39 |
| K-E9 | Danua (Great Dane) | 235 |
| K-E10 | Berner Dağ Köpeği | 45 |
| K-E11 | Newfoundland | 50 |
| K-E12 | Whippet | 162 |
| K-E13 | Greyhound | 158 |
| K-E14 | West Highland White Terrier | 85 |
| K-E15 | Minyatür Schnauzer | 183 |
| K-E16 | Schnauzer | 182 |
| K-E17 | Dev Schnauzer | 181 |
| K-E18 | Shar Pei | 309 |
| K-E19 | Bordo Dogu (Dogue de Bordeaux) | 116 |
| K-E20 | Shetland Çoban Köpeği | 88 |
| K-E21 | Collie (Uzun Tüylü) | 156 |
| K-E22 | İngiliz Springer Spaniel | 125 |
| K-E23 | Staffordshire Bull Terrier | 76 |
| K-E24 | Basset Hound | 163 |
| K-E25 | Orta Asya Çoban Köpeği | 335 |
| K-E26 | **Japon Tosa** | 260 |
| K-E27 | **Fila Brasileiro** | 225 |

K-E26 ve K-E27 yasal gerekçeyle eklenmeli. 5199 Geçici Md. 3, Pitbull Terrier ve Dogo Argentino ile birlikte bu iki ırkı ve melezlerini sayıyor (S5 [O]). Klinik kayıtta seçilebilmeleri gerekir.

### 4.4 Kedi: düzeltme (6)

| # | Mevcut | Öneri | Gerekçe | Kaynak |
|---|---|---|---|---|
| C1 | Tekir | Irk olarak pasifleştirilsin; renk kataloğuna "Tekir (Tabby)" deseni olarak eklensin (R-E1) | Irk değil desen. TDK: "Postu siyah çubuklarla ve beneklerle süslü, kül renginde veya boz olan (kedi)". | S14, S7 [O] |
| C2 | Sarman | Irk olarak pasifleştirilsin; renk kataloğuna "Sarman (Kızıl Tekir)" olarak eklensin (R-E2) | TDK: "Sarı tüylü kedi" | S14 [O] |
| C3 | Smokin | Irk olarak pasifleştirilsin; renk "Siyah-Beyaz" zaten var | Siyah-beyaz iki renkli kedi (tuxedo) | S7 [O] |
| C4 | Melez | "Ev Kedisi (Kısa Tüylü)" ve "Ev Kedisi (Uzun Tüylü)" olarak ikiye ayrılsın | C1–C3'ten gelen kayıtların ırkı bu olur. Uluslararası klinik kullanımda DSH/DLH ayrımı yaygın; bunun için resmî bir kaynak doğrulanmadı. | [G] |
| C5 | Ankara Kedisi | Ankara Kedisi (Turkish Angora) | FIFe TUA | S6 [O] |
| C6 | Oriental | Oriental Shorthair | FIFe OSH; uzun tüylüsü OLH ayrı ırk | S6 [O] |

**Kalanlar:** British Shorthair ve Longhair, Persian, Siyam, Maine Coon, Bengal, Russian Blue, Sphynx, Ragdoll, Exotic Shorthair, American Curl, Habeş ve Bombay kalıyor (FIFe ve CFA [O]). Bombay FIFe'de 2023–2027 ön kabulde.

Diğerlerinin durumu:
- **Scottish Fold:** FIFe tanımıyor, CFA tanıyor.
- **Scottish Straight:** TICA'da ayrı ırk. CFA'da Scottish Fold'un bir bölümü [A].
- **Khao Manee:** CFA'da "Miscellaneous" sınıfında [A].
- **American Shorthair:** CFA'da var.

Bu dört ırk Türkiye'de kullanıldığı için kalıyor.

**Van Kedisi:** Yerel tiptir (landrace). FIFe'nin TUV kodlu Turkish Van ırkı İngiltere'de geliştirildi; ikisi arasında bilinen bir bağ yok (S6 [O]). Öneri: "Van Kedisi" kalsın. Turkish Van eklenmesin; yurt dışı belgeli bir kayıt gelirse klinik kendi satırını ekler.

### 4.5 Kedi: ekleme (12)

Birman (SBI), Devon Rex (DRX), Cornish Rex (CRX), Sibirya Kedisi (SIB), Burmese (BUR), Somali (SOM), Selkirk Rex (SRS/SRL), Chartreux (CHA), Balinese (BAL), Burmilla (BML), Neva Masquerade (NEM): FIFe (S6 [O]). Himalayan: CFA'da Persian'ın bir bölümü [A].

### 4.6 Diğer türler: düzeltme (12)

| # | Tür | Mevcut | Öneri | Kaynak |
|---|---|---|---|---|
| D1 | Tavşan | Angora Tavşanı | Ankara Tavşanı (Angora) | Tescilli yerli ırk (S11 Ek-20 [O]). ARBA'da tek bir "Angora" yok, dört ayrı Angora ırkı var (S10 [O]). |
| D2 | Hamster | Cüce Hamster | "Campbell Cüce Hamsterı" ve "Kış Beyazı Cüce Hamsterı" olarak ayrılsın | Roborovski de cüce hamster, satırlar çakışıyor [G] |
| D3 | At | İngiliz Atı | Safkan İngiliz (Thoroughbred) | [A] |
| D4 | At | Arap Atı | Safkan Arap | TİGEM kullanımı [A] |
| D5 | At | Pony | Midilli (Pony) | [G] |
| D6 | Sığır | Holstein | Holştayn (Holstein) | [A] |
| D7 | Sığır | Montofon | Esmer (Montofon) | Türkçe kaynaklarda "Esmer" baskın [A] |
| D8 | Sığır | Yerli Irk | Pasifleştirilsin; yerine tescilli yerli ırklar (§4.7) | S11, S13 [O] |
| D9 | Koyun | Merinos | "Merinos (Diğer)" olsun; tescilli merinoslar ayrı eklensin (§4.7) | S11 [O] |
| D10 | Koyun | İvesi | İvesi (Anadolu İvesisi) | Tescil adı (S11 [O]) |
| D11 | Balık | Beta | Beta (Betta) | Betta splendens [G] |
| D12 | Balık | Ciklet | Çiklit | Yaygın yazım; doğrulanmadı [G] |

**Doğru olanlar:**
- Tavşan: Holland Lop, Netherland Dwarf, Lionhead, Rex, Mini Rex, Flemish Giant (ARBA [O]).
- Kobay: dört ırk (ARBA/ACBA [A]).
- Sığır: Simental, Şarole.
- Koyun: Dağlıç, Kıvırcık, Sakız, Karayaka, Morkaraman, Akkaraman (S11 ve S13 [O]).
- Keçi: Kıl Keçisi, Ankara Keçisi, Saanen, Şam, Malta.
- Tavuk: Atak-S. Ankara Tavukçuluk Araştırma Enstitüsü'nün yerli yumurtacı hibriti [A]; ırk değil ama klinikte bu adla geçiyor.

### 4.7 Diğer türler: ekleme (49)

**Öncelik 1 (pet):**
- **Tavşan (ARBA [O]):** Mini Lop, French Lop, English Lop, Dutch, New Zealand, Californian, Jersey Wooly, Dwarf Hotot, American Fuzzy Lop. Toplam 9.
- **Kobay (ARBA/ACBA [A]):** Silkie (Sheltie), Texel, Coronet, White Crested ve resmî ırk olmayan "Tüysüz (Skinny)". Toplam 5.
- **Hamster:** Campbell Cüce ve Kış Beyazı Cüce. Toplam 2 (D2'den gelir).

**Öncelik 2 (çiftlik; kaynak: S11, S13 [O], aksi belirtilmedikçe):**
- **Sığır:** Yerli Kara, Boz Irk, Doğu Anadolu Kırmızısı, Güney Anadolu Kırmızısı, Yerli Güney Sarısı, Zavot; ayrıca Limuzin ve Belçika Mavisi [A]. Toplam 8.
- **Koyun:** Karacabey Merinosu [O], Orta Anadolu Merinosu [A], Anadolu Merinosu [A], Gökçeada, Norduz, Tuj, Hemşin, Herik, Karagül, Çine Çaparı. Toplam 10.
- **Keçi:** Kilis Keçisi, Honamlı, Norduz Keçisi. Toplam 3.
- **At:** Ayvacık Midillisi, Canik, Malakan, Hınıs Kolu Kısası, Çukurova. Toplam 5.
  - "Rahvan" bir yürüyüş biçimi, ırk değil; eklenmez.
  - Ayvacık Atı'nın tescili 2018'de reddedildi (S12 [O]).
- **Tavuk:** Denizli ve Gerze tescilli (S11 [O]). Atak, Atabey ve Akbay yerli hibrit [A]. Bunlara "Etlik Piliç (Broiler)" eklenir. Toplam 6.
- **Manda:** Anadolu Mandası. Toplam 1 (T-E1'den gelir).

Hindi, ördek ve kaz için tescilli Türk ırkı bulunamadı.

---

## 5. Renk ve desen

Temel: FIFe EMS renk ve desen kodları (S7 [O]) ile TDK (S14 [O]).

### 5.1 Düzeltme (3)

| # | Mevcut | Sorun | Öneri |
|---|---|---|---|
| R1 | BRINDLE "Kırçıllı" | Yanlış eşleme. TDK'ya göre kırçıl "Kırlaşmaya başlamış, kır renkli", yani roan ya da grizzle anlamına geliyor. Brindle ise kızıl zemin üzerinde koyu çizgi. | Kaplan Çizgili (Brindle). Kod aynı kalır, ad değişir. |
| R2 | BRINDLE_WHITE "Kırçıllı-Beyaz" | Aynı | Kaplan Çizgili-Beyaz |
| R3 | BROWN_BRINDLE "Kahverengi-Kırçıllı" | Aynı | Kahverengi Kaplan Çizgili |

"Kaplan çizgili" karşılığı için resmî bir Türkçe veteriner kaynağı bulunamadı; öneri yaygın kullanıma dayanıyor. Renkler `HasData` ile geldiği için bu değişiklik migration gerektirir.

"Boz" (DUN) kalsın. TDK'ya göre boz "açık toprak rengi" ya da "kül rengi"; at için "Kula" ayrıca eklenir.

### 5.2 Ekleme (23)

**Kedi ve köpek (16; S7 [O]):**

| # | Ad | Not |
|---|---|---|
| R-E1 | Tekir (Tabby) | C1'den gelir |
| R-E2 | Sarman (Kızıl Tekir) | C2'den gelir |
| R-E3 | Kaplumbağa Kabuğu (Tortoiseshell) | |
| R-E4 | Sivri Renk (Colorpoint) | Siyam deseni |
| R-E5 | Van Deseni | |
| R-E6 | Dumanlı (Smoke) | |
| R-E7 | Gümüş (Silver) | |
| R-E8 | Lila (Lilac) | |
| R-E9 | Tarçın (Cinnamon) | |
| R-E10 | Fawn (Açık Sarı-Kahve) | |
| R-E11 | Merle | Köpek |
| R-E12 | Siyah-Beyaz-Kahve (Tricolor) | Köpek. "Üç Renkli (Calico)" ile karışmaması için bu adla. |
| R-E13 | Siyah-Bakır (Black and Tan) | |
| R-E14 | Samur (Sable) | |
| R-E15 | Harlequin | |
| R-E16 | Kırçıl (Roan) | R1'deki Türkçe terimin doğru yeri |

**At donları (7):** Doru, Al, Kır, Yağız, Kula, Ahreç, İzabel. Kaynak: Vet. Hek. Der. Derg. 2023, https://dergipark.org.tr/en/pub/vetheder/article/1225758 [A].

---

## 6. Aşı

### 6.1 Türkiye çerçevesi

- **Kuduz Yönetmeliği md. 9 (S17 [O]):**
  - Üç aydan büyük kedi ve köpekler yılda bir kez aşılanır.
  - İlk aşıdan sonra, üretici aksini belirtmedikçe, 21 gün içinde rapel yapılır.
  - Evcil hayvanda yalnız inaktif aşı kullanılır.
  - Hekim aşıyı kimlik belgesine ve Bakanlık veri tabanına işler.
  - Gelincik bu yönetmelikte geçmiyor.
- **2025 Genelgesi (S18 [O]):**
  - Programlı aşıların takvimini Genel Müdürlük belirler.
  - İhbarı zorunlu hastalıklarda (şap vb.) serbest hekim aşıdan önce il/ilçe müdürlüğünden izin alır. Kayıt VETBİS'te 10 gün içinde yapılır.
- **HBS ruhsatlı ürünler (S15 [O]):** Türkiye'de neyin aşı olarak var olduğunu gösteren tek resmî kaynak.
  - **Ruhsatlı ürünü olmayanlar:** FIV, FIP, RHD, miksomatoz, kedi Bordetella, köpek influenzası, Leishmania ve Batı Nil.
  - **İstisna:** RHD ve miksomatoz aşılarının özel izinle ithal edilip edilmediği doğrulanamadı.
- **TVHB ya da fakültelerin resmî aşı takvimi bulunamadı.** Türkiye için en yakın kurumsal kaynak KHVHD 2018 rehberi (S21).

### 6.2 Düzeltme (12)

| # | Kod / ad (`feature/katalog-literatur`) | Öneri | Kaynak |
|---|---|---|---|
| A1 | MIXED "Karma" | Belirsiz. **"Köpek Karma (DHPPi±L)"** ve **"Kedi Karma (FVRCP)"** olarak iki yeni koda ayrılsın; eski satır pasifleştirilsin. | S15, S20, S21 [O] |
| A2 | MIXED_RABIES "Karma + Kuduz" | Aynı şekilde: "Köpek Karma + Kuduz" ve "Kedi Karma + Kuduz". İki tür için de kombine ürün ruhsatlı. | S15 [O] |
| A3 | FIV | **Pasifleştirilsin.** HBS'de ruhsatlı ürün yok. WSAVA'ya göre tek ürün AB'de hiç ruhsat almadı ve 2017'de ABD/Kanada'dan çekildi. | S15, S20 [O] |
| A4 | FIP | **Pasifleştirilsin.** HBS'de ruhsatlı ürün yok. WSAVA "önerilmez" diyor. | S15, S20 [O], S23 [A] |
| A5 | CORONA "Koronavirüs" | "Köpek Koronavirüs Enteriti (CCoV)", türü köpek. WSAVA ve KHVHD önermiyor ama ruhsatlı 3 ürün var, satır kalsın. | S15, S20, S21 [O] |
| A6 | BRONCHINE "Bronşin (Bordetella)" | "Bordetella / Parainfluenza (Bronşin)", türü köpek. Ruhsatlı ürünlerin bir kısmında CPiV de var. | S15 [O] |
| A7 | LEUKEMIA "Lösemi (FeLV)" | "Kedi Lösemisi (FeLV)", türü kedi | S15, S20 [O] |
| A8 | DISTEMPER_PARVO | "Köpek DP (Distemper-Parvovirüs)", türü köpek | S15 [O] |
| A9 | PARVO | "Köpek Parvovirüs (CPV-2)", türü köpek | S15 [O] |
| A10 | BRUCELLOSIS "Brusella" | İki yeni koda ayrılsın: "Sığır Brusellozu (S19)" ve "Koyun-Keçi Brusellozu (Rev-1)". S19, 3–6 aylık dişi buzağıya yapılır; Rev-1, 3–6 aylık dişi kuzu ve oğlağa. | S19 [O] |
| A11 | PPR | "Koyun ve Keçi Vebası (PPR)". §2'ye bakın. | S18, S15 [O] |
| A12 | ANTHRAX "Şarbon" | "Şarbon (Antraks)". HBS'deki ad "ŞARBON HASTALIĞI (Antrax)". | S15 [O] |

**Doğru olanlar:**
- Adı ve ruhsatı olanlar: Kuduz, Leptospiroz, Lyme (Borelyoz), Tetanoz, At İnfluenzası, Şap, Enterotoksemi, Mastitis, Koyun ve Keçi Çiçeği, Yanıkara, Sığırların Nodüler Ekzantemi.
- Mastitis aşısının sığırda 4, koyun-keçide 1 ruhsatlı ürünü var.
- Mantar (Dermatofitoz): ruhsatlı ürün var. WSAVA önermiyor, KHVHD "aşı olarak tanımlanmamaktadır" diyor. Satır kalsın, sınıfı "çekirdek dışı" olsun.
- Newcastle: kanatlılar için çok sayıda ruhsatlı ürün var.
- RHD ve Miksomatoz: Türkiye'de ruhsatlı ürünleri yok. Yurt dışından getirilen ya da yurt dışında yapılmış aşıların kaydı için satırlar kalsın.

**İç Parazit, Dış Parazit, İç-Dış Parazit:** Bunlar aşı değil, antiparaziter uygulama. Bkz. §9 Y2.

### 6.3 Ekleme (18)

| # | Ad | Tür | Kaynak |
|---|---|---|---|
| A-E1 | Kedi Klamidyozu (Chlamydia felis) | Kedi | S15, S20 [O] |
| A-E2 | At Herpesvirüsü (EHV-1/4) | At | S15, S18 [O] |
| A-E3 | Güvercin Paramiksovirüs (PPMV-1) | Kuş | S15 [O] |
| A-E4 | IBR | Sığır | S15 [O] |
| A-E5 | BVD | Sığır | S15 [O] |
| A-E6 | Buzağı İshali (E. coli / Rota / Corona) | Sığır | S15 [O] |
| A-E7 | Pastörelloz (Pasteurella / Mannheimia) | Sığır, koyun | S15 [O] |
| A-E8 | Klostridyal Hastalıklar (malign ödem, gazlı gangren, bradzot) | Sığır, koyun | S15 [O] |
| A-E9 | Theileriozis | Sığır | S15 [O] |
| A-E10 | Mavi Dil | Koyun, sığır | S15, S18 [O] |
| A-E11 | Bulaşıcı Agalaksi | Koyun, keçi | S15 [O] |
| A-E12 | Ektima | Koyun, keçi | S15 [O] |
| A-E13 | Enzootik Abort | Koyun, keçi | S15 [O] |
| A-E14–18 | Marek, Gumboro, Enfeksiyöz Bronşit, Kanatlı Çiçeği, ILT | Kanatlı | S15 [O]. **Düşük öncelik**; pet kliniği hedef kitlesinin dışında kalabilir. |

### 6.4 Varsayılan aralık önerisi (`DefaultNextDueDays`)

| Grup | Gün | Kaynak |
|---|---|---|
| Kuduz | 365 | S17 (yasal). İlk dozdan sonraki 21 günlük rapel tek alanla ifade edilemiyor; seri için aşı takvimi kalemleri (`AddVaccinationScheduleItems`) kullanılmalı. |
| Leptospiroz, Bordetella, Lyme, Klamidyoz, FeLV | 365 | S20 |
| Köpek DP, Parvo (yavru serisi) | 21 | S20 (2–4 hafta), S21 (3 hafta) |
| Köpek Karma | 365 | Lepto bileşeni yıllık (S20, S21) |
| Kedi Karma | 365 | WSAVA'ya göre düşük riskte 3 yıl, yüksek riskte yıllık. Türkiye'de dışarı çıkan ve sahipsiz kedi teması yaygın olduğu için yüksek risk varsayıldı; klinik kendi satırında değiştirebilir. |
| İç parazit | 90 | ESCCAP: risk bilinmiyorsa yılda en az 4 kez (S22) |
| Dış parazit, devlet programındaki çiftlik aşıları | Boş | Ürün etiketine ya da Genel Müdürlük takvimine bağlı |

---

## 7. Şikâyet ve tanı

### 7.1 Şikâyet: düzeltme (5)

| # | Mevcut | Öneri | Kaynak |
|---|---|---|---|
| Ş1 | Genel kontrol | Şikâyetten pasifleştirilsin. Bu bir ziyaret nedeni; VeNom da ziyaret nedenini ayrı listede tutuyor. Şablonlarda zaten ziyaret nedeni olarak kullanılıyor. | S24 [O] |
| Ş2 | Kaşıntı | Kaşıntı (deri). "Kulak kaşıma / baş sallama" ile çakışmasın. | [G] |
| Ş3 | Deride kızarıklık / yara | "Deride kızarıklık" olsun; "Yara" ayrı eklensin. Kedide yara %2,1. | S28 [O] |
| Ş4 | İdrar yapamama | İdrar yapamama / ıkınma | [G] |
| Ş5 | Dengesizlik | Dengesizlik / koordinasyon bozukluğu | [G] |

### 7.2 Şikâyet: ekleme (30)

- **Sıklık çalışmalarından (8):**
  - Poposunu yere sürtme: köpekte anal kese %7,1 (S27 [O])
  - Tırnak uzaması / kırılması: köpekte %7,1 ve %2,7, kedide %5,2 (S27, S28 [O])
  - Aşırı yalama / tımarlanma (S28 [O])
  - Davranış değişikliği ve Saldırganlık: köpekte "Behavioural" %2,6 (S27 [O])
  - Yara (Ş3'ten)
  - Perine kirlenmesi ve Dışkı azalması / yokluğu: tavşan (S29 [A])
- **Kusma ayrımı (2):** Öğürme; Yiyeceği geri çıkarma (regürjitasyon) [G].
- **Genel bilgi (20) [G]:** Kanlı dışkı, Yutkunma güçlüğü, Karın şişliği, İdrar kaçırma, Sarılık, Solgunluk, Gözü kısma / göz kaşıma, Bayılma / çökme, Felç / yürüyememe, Titreme, Görme kaybı, Burun kanaması, Hırıltılı solunum, Aşırı iştah, Kilo alma, Vajinal akıntı, Doğum güçlüğü, Yumurtlama sorunu (kuş, sürüngen), Tüy yolma (kuş), Ağrı belirtisi.

### 7.3 Tanı: düzeltme (2)

| # | Mevcut | Öneri |
|---|---|---|
| N1 | Distemper | Gençlik Hastalığı (Distemper). Yaygın Türkçe ad; TDK ile karşılaştırılmadı. |
| N2 | Panlökopeni | Panlökopeni (Kedi Parvovirüs Enfeksiyonu) |

"Osteoartrit" kalsın; VetCompass'taki "degenerative joint disease" (köpekte %6,6) ile aynı kavram. Tanıdaki "Mastitis" ile aşıdaki "Mastitis" ayrı kataloglarda, gerçek bir çakışma değil.

### 7.4 Tanı: ekleme (58)

Öncelik sırası: A, sonra C, sonra B, sonra D. İlk dalga için A, C ve D'nin ilk 15'i yeterli (39 terim).

- **A. Birinci basamak sıklık çalışmaları (15; S27, S28 [O]):**
  - Anal kese tıkanıklığı / hastalığı: köpek %7,1
  - Tırnak uzaması
  - Tırnak yaralanması
  - Kalp üfürümü: köpek %3,9, kedi %4,4
  - Lipom: köpek %3,5
  - Deri kitlesi: köpek %2,8
  - Isırık yarası
  - Laserasyon / yara
  - Pire enfestasyonu: kedi %5,1
  - Diş hastalığı (periodontal dışı): kedi %8,2
  - Tüy örtüsü bozukluğu
  - Postoperatif yara komplikasyonu
  - Kardiyak aritmi
  - Psikojenik alopesi
  - Davranış bozukluğu
- **B. Tavşan (4; S29 [A]):** Azı dişi uzaması (%7,6), Kesici diş uzaması (%4,3), Miyazis, Gastrointestinal staz / ileus.
- **C. Bildirime tabi ve zoonoz (9; S30, S31 [O]):** Kuduz şüphesi, Leishmaniyoz (Türkiye'de endemik [A]), Ekinokokkoz / kist hidatik, Miksomatozis, Tavşan hemorajik hastalığı, Psittakoz, Kuş gribi, Newcastle hastalığı, Kedilerin süngerimsi beyin hastalığı.
- **D. Genel bilgi (30) [G]:**
  - Kedi üst solunum yolu enfeksiyonu (FHV-1/FCV)
  - Miksomatöz mitral kapak hastalığı
  - Hipertrofik kardiyomiyopati
  - FIP
  - FeLV enfeksiyonu
  - FIV enfeksiyonu
  - Giardiyoz
  - Babesiyoz
  - Erlihiyoz
  - Leptospiroz
  - İntervertebral disk hastalığı
  - Kalça displazisi
  - Hiperadrenokortisizm (Cushing)
  - Hipoadrenokortisizm (Addison)
  - Ürolitiyazis
  - Kriptorşidizm
  - Distosi
  - Eklampsi
  - Isı çarpması
  - Yanık
  - Megaözofagus
  - Hepatopati
  - Kedi kronik gingivostomatiti
  - Diş kırığı
  - Otitis media
  - Lenfoma
  - Meme tümörü
  - Mast hücre tümörü
  - Kuşta tüy yolma
  - Sürüngende metabolik kemik hastalığı

D grubundaki adlar standart ders kitabı terimleri; sıklık kaynağıyla doğrulanmadı.

---

## 8. Muayene şablonları

**Düzeltme (2):**

| # | Şablon | Öneri | Kaynak |
|---|---|---|---|
| M1 | "Aşı muayenesi" | Adı "Sağlık kontrolü ve aşı" olsun. "Vücut ısısı ve iştah" satırı "İştah / genel durum" olsun, çünkü ısı muayenede zaten vital alan olarak var (`Examination.TemperatureC`). | S20 (WSAVA 2024, "aşı konsültasyonu" yerine "sağlık kontrolü" çerçevesi) [A] |
| M2 | Üç şablonun hepsi | "VKS (1–9):", "Kas kondisyonu:", "Hidrasyon:", "Ağrı skoru / kullanılan ölçek:" satırları eklensin. Yalnız etiket konur, ölçek metni konmaz (§3.2). | S33, S34 [A] |

**Ekleme (9):**

| # | Şablon | Kaynak |
|---|---|---|
| M-E1 | Yavru ilk muayenesi: doğumsal bulgular (üfürüm, fıtık, kriptorşidizm, damak), parazit ve aşı geçmişi, beslenme, sosyalleşme | S34 [A], [G] |
| M-E2 | Yaşlı hayvan muayenesi: deri, tırnak, lenf, kedide tiroid, hidrasyon, kronik ağrı, bilişsel değişiklik, laboratuvar | S34 [A] |
| M-E3 | Anestezi öncesi değerlendirme: ASA 1–5 (+E), açlık süresi, laboratuvar, IV kateter, risk notu | S34 [A] |
| M-E4 | Kulak muayenesi: otoskopi, sitoloji | Otitis externa köpekte en sık bozukluk, %10,2 (S27 [O]) |
| M-E5 | Ağız-diş muayenesi | Periodontal hastalık köpekte %9,3, kedide %15,2 (S27, S28 [O]) |
| M-E6 | Dermatoloji muayenesi: dağılım, lezyon tipi, kaşıntı, parazit, kazıntı ve sitoloji | [G] |
| M-E7 | Göz muayenesi: Schirmer, floresein, göz içi basıncı | Konjonktivit köpekte %4,9 (S27 [O]) |
| M-E8 | Ameliyat ve kısırlaştırma sonrası kontrol: yara, dikiş, ağrı, iştah, dışkılama | S28 [O] |
| M-E9 | Tavşan / egzotik muayene: dişler, tırnak, perine, dışkı üretimi, beslenme, ortam | S29 [A] |

Şablonlar mevcut ilkeye uyar: başlıklar boş bırakılır, hazır sonuç yazılmaz, ürün bağı konmaz.

---

## 9. Yapısal öneriler (çoğu ürün kararı)

| # | Öneri | Neden | Onay |
|---|---|---|---|
| Y1 | **Aşı sınıfı için ayrı alan:** `Category = Core / NonCore / NotRecommended`. `IsCore` kilit anlamında kalır. Seeder'daki `coreRepair` döngüsü yeni alana dokunmaz. | WSAVA ayrımı (S20) bugün tutulamıyor; `IsCore`'a yazılırsa kilit bozulur ve seeder değeri geri çevirir. | Şema değişikliği; onay gerekir |
| Y2 | **Antiparaziter uygulama aşıdan ayrılsın:** ya ayrı katalog ya da `Kind = Vaccine / Antiparasitic` alanı. | İç ve dış parazit aşı değil. HBS'deki biyolojik ürün listesinde antiparaziter yok (S15). ESCCAP ayrı bir rehber (S22). | Şema değişikliği; onay gerekir |
| Y3 | **Aşılarda tür bağı:** türe özgü satırlar `SpeciesId` ile bağlansın. Kuduz, tetanoz ve dermatofitoz gibi çok türlü satırlar boş kalsın. | Bugün kanatlı aşıları kedi hastasında da listeleniyor. | Veri değişikliği, şema yok |
| Y4 | **Renk ve desen ayrı alan:** Tekir, kaplumbağa kabuğu, sivri renk ve merle bir desen; siyah, kızıl ve lila bir renk. | FIFe EMS ayrı kodluyor (S7). Bugünkü birleşik satırlar (Siyah-Beyaz vb.) sayıyı büyütüyor. | Şema değişikliği; onay gerekir. Kısa vadede §5.2'deki tek liste yeterli. |
| Y5 | **Klinik terimlere tür etiketi** (isteğe bağlı, çoklu) | Tavşan ve sürüngen terimleri kedi muayenesinde çıkmasın. | Şema değişikliği; onay gerekir |
| Y6 | **Zoonoz ve ihbar işareti** (`ClinicalTerm`) | Kuduz, şap, bruselloz, kuş gribi ihbarı mecburi; leishmaniyoz, leptospiroz, dermatofitoz zoonoz (S30, S31). Hekime uyarı göstermek için. | Şema değişikliği; onay gerekir |
| Y7 | **Seed'e pasifleştirme listesi:** her seeder için `Deactivations` dizisi. Yalnız sistem satırı ve hâlâ eski haliyle duruyorsa uygulanır. | Bugün seeder'lar yalnız ekliyor ya da yeniden adlandırıyor; T1, C1–C3, A3–A4, Ş1 ve D8 için pasifleştirme gerekiyor. | Kod deseni; ürün kararı değil |
| Y8 | **Irk ve hasta kaydı dönüşümü:** Tekir, Sarman ve Smokin ırklı hastalar "Ev Kedisi (Kısa Tüylü)" ırkına ve ilgili renge taşınsın. | C1–C4 | Veri dönüşümü (migration); onay gerekir |

---

## 10. Katalogları güncel tutma

### 10.1 Kaynak takvimi

| Kaynak | Ne değişir | Kontrol sıklığı | Nasıl |
|---|---|---|---|
| HBS ruhsatlı biyolojik ürünler (S15) | Yeni ruhsatlı hastalıklar, iptal edilen ürünler | 6 ayda bir | Sorgu ekranını hedef tür ve hastalık bazında sayıp önceki sayımla karşılaştır |
| Hayvan Hastalıkları ile Mücadele Genelgesi (S18) | Programlı aşılar, resmî adlar | Yılda bir (genelge her yıl başında çıkıyor) | Yeni yılın genelgesini oku; 2026 genelgesi bu araştırmada bulunamadı |
| Kuduz Yönetmeliği, 5199 s. Kanun | Kuduz kuralları, tehlikeli ırklar | Yılda bir | mevzuat.gov.tr güncel metnini kontrol et |
| İhbarı mecburi hastalıklar listesi | Y6 işaretleri | Yılda bir | mevzuat.gov.tr'deki güncel Ek-1 (bu araştırmada ikincil kaynaktan okundu) |
| WOAH listelenmiş hastalıklar (S30) | Y6 işaretleri | Yılda bir (Mayıs genel kurulu sonrası) | Bölüm 1.3'ün güncel sürümü |
| WSAVA aşılama kılavuzu (S20) | Aşı sınıfı, aralıklar | Yeni sürüm çıktığında (2010, 2015 ve 2024'te çıktı) | wsava.org kılavuz sayfası |
| FCI nomenklatürü (S1), FIFe ırk listesi (S6) | Yeni kabul edilen ve ad değiştiren ırklar | Yılda bir | Liste sayfası; yalnız Türkiye'de görülen ırklar eklenir |
| Bakanlık Tescil Komitesi kararları (Resmî Gazete) | Yeni tescilli yerli ırklar | Yılda bir | RG'de "Hayvan Genetik Kaynakları Tescil" araması |
| **Vetinity'nin kendi verisi** | Kataloğa bağlanamayan serbest metin ırk, renk, şikâyet ve tanılar; klinik kataloğuna eklenen satırlar | Çeyrekte bir | Tüm kiracılarda en sık 50 serbest metin değeri ve klinik satırı. Türkiye'de ırk istatistiği olmadığı için ekleme adaylarının ana kaynağı bu olur. Rakip verisi kullanılmaz. |

### 10.2 Değişiklik kuralları (mevcut desen)

1. **Ekleme:** Seed dizisine satır eklenir. Seeder idempotent:
   - Tür ve aşı kod üzerinden.
   - Irk tür + ad üzerinden.
   - Klinik terim ve şablon normalize edilmiş ad üzerinden.
2. **Ad düzeltme:** Dizideki adı değiştirmek tek başına yetmez. Irk ve terimde yeni bir satır açar; aşıda hiçbir etkisi olmaz. Bunun için `feature/katalog-literatur`'daki `BreedRenames` ve `Renames` deseni kullanılır: kayıt yalnız eski sistem adını taşıyorsa yeni ada geçer, yöneticinin verdiği ad korunur. Eski ad `ImportValueResolver`'a takma ad olarak eklenir.
3. **Pasifleştirme:** Silme yok. Geçmiş kayıtlar bağlı kalır. Y7'deki liste desenine göre `IsActive = false` yapılır.
4. **Renk:** `PetColorConfiguration.HasData` ile geldiği için her değişiklik bir migration ister.
5. **Kaynak izi:** Her yeni ya da düzeltilmiş seed satırının yanına kısa bir yorum konur (ör. `// FCI 166`, `// HBS 2026-11`, `// S27`). Ayrıntılı gerekçe bu belgede kalır.
6. **Değişiklik günlüğü:** Her katalog güncellemesi bu belgenin sonundaki günlüğe bir satırla yazılır: tarih, commit, kaynak.

---

## 11. Doğrulanamayanlar

- **VeNom:** mektup anlaşmasının tam metni yok; ücret, çeviri ve alt lisans konusu orada olabilir. Güncelleme tarihleri sitede tutarsız ("Codes last updated: January 2024" ve "February 2026 release" aynı sayfada).
- **SNOMED:** SaaS ücreti öğrenilemedi. Türkiye'nin Band B'de olduğu doğrulanmadı.
- **TICA ve AAHA:** siteler 403 verdi. CFA'nın ırk listesi tam okunamadı. Bu kaynaklara dayanan satırlar [A] olarak işaretli.
- **TAGEM:** Tanıtım Kataloğu 404 verdi. 2004 sonrasındaki güncel tescil listesine ulaşılamadı.
- **Türk köpek ırkları:** Kangal dışındakiler için Bakanlık tescil kararı bulunamadı. TSE 2002 standartlarının (TS 12891/12892) hangi ırka ait olduğu net değil.
- **Mevzuat:**
  - 2026 Hayvan Hastalıkları Genelgesi bulunamadı; 2025 genelgesi kullanıldı.
  - Kuduz Yönetmeliği'nin 2012 sonrası değişiklikleri tek tek kontrol edilmedi.
  - İhbar listesi resmî metinden değil, ikincil kaynaktan (2020) okundu.
- **HBS ruhsat listesi:**
  - Listede veri hatası olabilir; örneğin "Kedi, Köpek" hedefli Leptospira ürünü görünüyor.
  - Mastitis aşılarının antijen içeriği listede yok.
  - RHD ve miksomatoz aşılarının özel izinle ithali doğrulanmadı.
- **Kılavuzlar arasında çelişki:** Bordetella için KHVHD 2018 Türkiye'de "çekirdek", WSAVA 2024 "çekirdek dışı" diyor. Öneri: daha güncel olan WSAVA'ya göre çekirdek dışı. Bu da Y1 kararına bağlı.
- **Türkçe terimler:** "Kaplan çizgili", "Gençlik hastalığı" ve D grubu tanı adları TDK Veteriner Hekimliği Terimleri Sözlüğü ile karşılaştırılmadı.
- **Sıklık:** Türkiye'de ırk sıklığı istatistiği yok. Köpek ve kedi ekleme önerileri Vetinity verisiyle kontrol edilmeli.

---

## 12. Uygulama (2026-11-13)

Kullanıcı kararı (2026-11-13): öneriler uluslararası veteriner literatürüne göre uygulansın; aşı sınıfı ayrı alan olsun (Y1); renk ile desen ayrılsın (Y4).

**Dallar:** BE `feature/katalog-kaynak` (`3b15a349`, `606f6498`), FE `feature/katalog-kaynak` (`f7ff1a62`). İkisi de `feature/katalog-literatur` üzerine kuruldu. 2026-11-13'te `main`e birleştirildi, 2026-11-14'te canlıya yayınlandı ([sürüm notu](../release-notes/2026-11-14-katalog-ve-e-belge.md)). Sözleşme belgesi: BE `docs/CATALOG_COAT_AND_VACCINE_CATEGORY_API_CONTRACT.md`.

### Uygulananlar

- **Tür ve ırk:**
  - T1, T-E1, T-E2.
  - K1–K10 (K9 `feature/katalog-literatur`'da yapılmıştı), K-E1–K-E27.
  - C1–C6, kedi eklemeleri, D1–D12, §4.7 eklemeleri.
  - Tekir, Sarman ve Smokin ırklı kediler seed'le dönüştürülür. Irk "Ev Kedisi (Kısa Tüylü)" olur. Renk ve desen boşsa şöyle doldurulur:
    - Tekir: tekir deseni
    - Sarman: kızıl renk ve tekir deseni
    - Smokin: siyah-beyaz
- **Renk ve desen (Y4):**
  - Renk kataloğunda her satıra `Kind` (renk/desen) alanı geldi; hastaya `PatternId` eklendi.
  - Benekli, Çizgili, Alacalı, Kaplan Çizgili (eski Kırçıllı) ve Üç Renkli desen oldu. Bu renkleri taşıyan hastalarda değer desen alanına taşındı.
  - R1–R3: Kırçıllı-Beyaz ve Kahverengi-Kırçıllı satırları renk ve desene ayrıldı, sonra pasifleşti.
  - §5.2 eklendi; aşağıdaki iki sapma dışında.
- **Aşı (Y1, Y2, Y3):**
  - `Category` alanı eklendi: Core / NonCore / NotRecommended / ParasiteControl. `IsCore` kilit anlamında kaldı.
  - A1–A12 ve A-E1–A-E18 uygulandı.
  - §6.4'teki varsayılan aralıklar ve tür bağı uygulandı.
  - Antiparaziter uygulamalar ayrı katalog açmak yerine aynı katalogda `ParasiteControl` sınıfıyla ayrıldı. Böylece karne ve hatırlatma akışı değişmedi.
  - Aşı takvimi başlangıç şablonu WSAVA'ya uyarlandı: karma 8., 12. ve 16. hafta; köpek koronavirüs çıkarıldı.
- **Şikâyet ve tanı:** Ş1–Ş5, 30 şikâyet; N1–N2, 58 tanı.
- **Şablon:** M1, M2, M-E1–M-E9.
- **Seed mekanizması (Y7):**
  - Sistem kayıtları için yeniden adlandırma, pasifleştirme ve "boşsa doldur" listeleri eklendi (ırk, aşı, terim, şablon).
  - Güncellemede, hastada zaten kayıtlı olan pasif ırk, renk ya da desen değişmeden kalabilir.
- **İçe aktarma:**
  - Eski adlar takma ad oldu.
  - Desen değeri hastanın desen alanına yazılır.
  - `karma` gibi bir takma ad birden çok hedef verebilir; hastanın türündeki tek kayıt seçilir.

### §5–§7'den sapmalar

- **"Sarman (Kızıl Tekir)" renk olarak eklenmedi.** Renk ile desen ayrıldığı için sarman, kızıl renk ve tekir deseni olarak tutuluyor (FIFe: renk `d`, desen `21–25`).
- **"Ahreç" at donu eklenmedi.** Karşılığı kaynakla doğrulanamadı. Diğer altı don eklendi; at donlarının adına "(At)" eklendi.
- **Kedi "Melez" satırı kaldı.** Uzun tüylü melezi kısa tüylü saymamak için "Ev Kedisi (Kısa Tüylü / Uzun Tüylü)" ayrıca eklendi.

### Bu turda yapılmayanlar (öneri olarak açık)

- **Y5:** Klinik terimlere tür etiketi.
- **Y6:** Zoonoz ve ihbar işareti. İkisi de literatür uyumu değil, kullanım kolaylığı; ayrı bir iş olarak değerlendirilmeli.
- **Desen hasta listesinde ve okuma modelinde yok.** Yalnız detayda ve formda görünüyor.
- **İçe aktarmada kürk adı ırk olarak gelirse ("Tekir")** ırk "Ev Kedisi (Kısa Tüylü)" olur ama desen otomatik doldurulmaz. Seed dönüşümü yalnız mevcut kayıtlara uygulanır.

### Yayın sırası (canlı, onayla)

1. `DbMigrator migrate`
2. `DbMigrator seed`
3. `DbMigrator backfill-pet-projections`

Ayrıntı için BE sözleşmesinin §4 bölümüne bakın.

---

## 13. Değişiklik günlüğü

| Tarih | Değişiklik | Commit | Kaynak |
|---|---|---|---|
| 2026-11-12 | Literatüre göre ad düzeltmeleri (§2) | BE `2c1652d7`, `dabbb21d`, `7b8997ed` (`feature/katalog-literatur`, main'de değil) | FCI, FIFe, Bakanlık adları |
| 2026-11-12 | Bu araştırma | `e300a8c` | §3 |
| 2026-11-13 | Önerilerin uygulanması (§12) | BE `3b15a349`, `606f6498`; FE `f7ff1a62` (`feature/katalog-kaynak`) | §3 |
