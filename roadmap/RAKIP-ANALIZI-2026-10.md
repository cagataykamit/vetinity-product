# Rakip analizi: E-vet SMART ve DaySmart Vet (2026-10-13)

## Kaynak ve yöntem

Kullanıcının kendi bilgisayarında topladığı ekran görüntüleri: **E-vet SMART 1.122, DaySmart Vet 424 görsel**. Görseller Windows yerleşik OCR'ı (Türkçe) ile yerelde metne çevrildi; sayfa envanteri tarayıcı adres çubuğundan çıkarıldı. Ham OCR metni kişisel tarayıcı sekmesi içeriği taşıdığı için depoya alınmadı.

**Sınırlar (doğrulanmadı / dikkat):**
- Envanter yalnız kullanıcının ziyaret ettiği sayfaları kapsar; ürünün tamamı değildir. E-vet'te 1.122 görselin 575'inde okunabilir adres vardı (162 benzersiz sayfa), DaySmart'ta 387'sinde (92 benzersiz yol, bir kısmı kesik/şifreli kimlik).
- OCR hataları olabilir (örn. `Iab` yerine `lab`). Adlar ve işlevler adresten ve ekran başlığından çıkarıldı; işlevlerin gerçek davranışı **bilinmiyor**.
- Aşağıdaki "pilot için önem" sütunu bir **öneridir**, karar değildir; pilot klinik görüşmesiyle netleşir.
- Kısaltmalar (HBS, VKY, ATS) anlamı doğrulanmadı.

## E-vet SMART (Türkiye pazarı): 13 modül, ~160 sayfa

| Modül | Sayfa | İçerik (adreslerden) |
|---|---|---|
| Muayene (`examination`) | 32 | Muayene odası, doğrudan satış, reçete ve e-reçete, hospitalizasyon, tanı/semptom sözlükleri, tedavi şablonu ve paketleri, operasyon paketi, takip parametresi paketleri, aşı paketi/programı, aşısız hasta listesi, fatura yönetim paneli |
| Genel (`general`) | 24 | Personel, departman, iş tanımı, rol şablonu, oda, görev tipi, KDV oranı, birim, kullanıcı rehberi, sürüm notları, anlık durum ekranı, katalog |
| Finansal (`financial`) | 19 | Kasa, banka, kasa/banka hareketleri, tedarikçi ödemesi, cari (hesap) ödeme ve fatura listesi, işlem grupları ve türleri |
| Laboratuvar (`lab`) | 17 | Cihaz tanımı, lab istek/sonuç, sonuç karşılaştırıcı, test grupları ve referans aralıkları, Xray ve PACS istekleri |
| Hayvan (`animal`) | 15 | Tür, ırk, renk, cinsiyet, grup, beslenme türü, sahip değişikliği |
| Depo (`warehouse`) | 14 | Çoklu depo, stok girişi, sayım, transfer, stok sıfırlama, alış faturası, iade faturası |
| Ürün (`product`) | 11 | Ürün, grup/alt grup/tür, ürün indirimi, hızlı fiyat |
| Takvim (`calendar`) | 7 | Doğum günü listesi, toplu SMS, hatırlatma listesi, SMS geçmişi, görev listesi, şablonlar |
| Fatura (`invoice`) | 6 | Gelen/giden fatura, fatura siparişi, iade faturası |
| Cari (`account`) | 5 | Cari grup, cari liste, tedarikçi |
| DataVet | 4 | İlaç rehberi (vademecum), nekropsi, semptom, lab referansı |
| Rapor / VKY | 5 | Rapor özellik tanımı, VKY performans göstergeleri |

**Gözlem:** Sayfaların yarıdan fazlası **tanım (`-def`) ve liste** sayfaları: yapılandırma yüzeyi çok geniş. Finans, "ön muhasebe" kapsamında (kasa, banka, cari, alış/iade faturası, gider grupları).

## DaySmart Vet (ABD): ~90 yol

| Alan | İçerik |
|---|---|
| Schedule | Randevu, **boarding (pansiyon)** panosu ve rezervasyon, **census**, **inbox**, tedavi |
| Patients | Liste, analitik, tanılar, görüntü sonuçları, lab sonuçları, profil |
| Clients / Contacts | Müşteri paneli ve profil, kuruluş (company) |
| Billing | Pano, **tahmin/teklif (estimate)**, fatura, **iade**, **kredi (credits)** |
| Inventory | Ürün, **satın alma siparişi** |
| Settings (38 yol) | Randevu türleri, indirimler, çalışma saatleri, **pazarlama kampanyaları**, ödeme türleri, yazıcılar, odalar, SMS/e-posta varsayılanları, vergiler, **şablonlar** (form, mektup, tıbbi not, içerik kısa metni, özel alan, wellness planı, tahmin paketi, satın alma siparişi) |

## Karşılaştırma matrisi (bizim durumumuz, 2026-10-13)

Durum: **Var** = çalışıyor, **Yolda** = ajan/dilim sürüyor, **Planlı** = backlog/yol haritasında, **Yok** = planda yok, **?** = kontrol edilmedi.

| Özellik | Rakip | Bizde | Pilot için önem (öneri) |
|---|---|---|---|
| Hasta kabul / günün kuyruğu (Bugün) | E-vet "Hasta Kabul" (arama+kayıt), Day: Schedule | **Var** (Bugün: kuyruk, bekleme, borç, acil) | Çekirdek |
| Global arama (üst çubuk) | E-vet: var | **Yok** (UX-006 backlog P1) | **Yüksek** |
| Randevu + takvim | İkisi de | **Var** | Çekirdek |
| Muayene (kesinleştirme, ek not) | İkisi de | **Var** | Çekirdek |
| Reçete (satırlı) | E-vet: reçete + e-reçete | **Var** (satırlı), e-reçete **Yok** | Orta, e-reçete **?** |
| Tedavi / uygulama + stok düşümü | E-vet | **Var** | Çekirdek |
| Hospitalizasyon / yatış | İkisi de (Day: boarding, census) | **Var**, Aşama 7 yolda | Çekirdek |
| Lab istek + sonuç | İkisi de | **Var** (durumlu); karşılaştırıcı, cihaz **Yok** | Yüksek (karşılaştırıcı sonra) |
| Görüntü / PACS / Xray | E-vet; Day: image-results | Dosya yükleme **Planlı** (Aşama 6), PACS **Planlı** (Aşama 12) | Orta |
| Ücret + ödeme + bakiye | İkisi de | **Var** (düzeltme/iptal dahil) | Çekirdek |
| Doğrudan satış (hastasız ürün satışı, stok düşer) | E-vet: var | **Yok**: ücret var ama stok bağı yok | **Yüksek** (mama/ilaç satışı) |
| Fatura / e-Fatura / e-SMM / otomatik fatura | E-vet: var; Day: invoice | **Planlı** (INT-005, INT-007) | **Yüksek** (canlıya geçiş koşulu olabilir) |
| Kasa / banka / cari / gider grupları | E-vet: kapsamlı | **Yok**, planda yok | Orta, klinik beklentisi **?** |
| Alış faturası / iade faturası / tedarikçi | E-vet, Day: purchase order | **Yok** | Orta |
| Çoklu depo / sayım / transfer | E-vet | **Yok** | Düşük–orta |
| KDV oranı / birim tanımı | E-vet: tax-ratio, unit | **Yok** (FIN-008 ertelendi) | Fatura ile birlikte |
| Müşteri kredisi / mahsup | Day: credits | **Ertelendi** (FIN-005) | Düşük |
| Teklif (estimate / tedavi öncesi fiyat) | Day: estimate | **Yok** | Orta |
| Tedavi şablonu/paketi, aşı programı/paketi, operasyon paketi | E-vet | **Yok**, Aşama 10 (P2) | Orta (zaman kazandırır) |
| Tanı / semptom sözlüğü | E-vet | **Yok** | Orta |
| Form/mektup/tıbbi not şablonları | Day | **Yok**, Aşama 10 | Düşük–orta |
| Aşı hatırlatma (e-posta) | İkisi de | **Var** (gerçek gönderim doğrulanmadı) | Yüksek |
| SMS, toplu SMS, kampanya, doğum günü | E-vet, Day: marketing | **Planlı** (INT-003), kampanya **Yok** | Orta |
| Görev listesi | E-vet | **Yok** | Düşük |
| Rapor merkezi + borç/stok raporu | İkisi de | Hub **Var**, borç raporu **onay bekliyor** | Yüksek |
| Tür, ırk, renk, cinsiyet, grup | E-vet | Tür, ırk **Var**; diğerleri **?** | Düşük |
| Sahip değişikliği | E-vet | **?** | Orta |
| Personel, departman, rol şablonu, görev tipi | E-vet | Roller, izinler, kurum üyeleri **Var**; departman/görev **Yok** | Düşük |
| Boarding (pansiyon), census | Day | **Yok** | Düşük |
| Inbox / mesajlaşma | Day; E-vet: ? | **Planlı** (MSG-) | Düşük |
| İlaç rehberi, nekropsi, semptom referansı (DataVet) | E-vet | **Yok** | Düşük–orta |
| HBS (devlet hayvan bilgi sistemi) | E-vet: menüde | **Yok**, planda **yok** | **?** (pilot kliniğe sorulacak) |
| VKY performans göstergeleri | E-vet | **Yok** | **?** |
| Mobil uygulama | E-vet: var | **Planlı** (Aşama 12) | Düşük |
| Yazdırma / yazıcı ayarı | Day: printers | Yatış talimat çıktısı **Planlı** (Aşama 7) | Orta |
| Online ödeme / entegrasyon | Day: payments, integrations | **Planlı** (INT-006) | Düşük |
| Kullanıcı rehberi / sürüm notları / öğrenme modu | E-vet | Kılavuz **yazıldı** (operations/), uygulama içi **Yok** | Düşük |

## Çıkarımlar (öneri)

1. **Çekirdekte eşitiz veya yoldayız:** kabul, muayene, lab, yatış, ücret ve ödeme, stok, takvim, rapor.
2. **Pilot için en olası "geçiş engelleri":** global arama, doğrudan satış (stoktan düşen ürün satışı), fatura / e-belge, borç raporu, HBS (**?**). Bunlar sayfa sayısından çok günlük iş akışını etkiliyor.
3. **Rakibin en büyük yüzeyi tanım sayfaları** (şablon, paket, sözlük, KDV, birim): bunlar zaman kazandırır ama çoğu klinikte ilk gün gerekli değildir. Bizde Aşama 10 (P2) ve backlog'da.
4. **Rakibin finans kapsamı ön muhasebeye uzanıyor** (kasa, banka, cari, gider): bu bilinçli olarak kapsam dışı bıraktığımız bir alan. Klinik bunu kullanıyorsa ya entegre ya da basit bir kasa/gider modeli gerekebilir. **Karar gerektirir**, pilot klinikle konuşulur.
5. **Sayfa sayısını yakalamak hedef olmamalı.** Hedef: pilot kliniğin günlük, haftalık, aylık gerçekten yaptığı işlerin listesini çıkarıp bunu karşılamak.

## Sonraki adım (önerilen)

Pilot klinikle (K4) bu matrisi birlikte gözden geçirmek; "bunu kullanıyoruz / kullanmıyoruz" işaretletmek. Yanıtlara göre backlog öncelikleri güncellenir.
