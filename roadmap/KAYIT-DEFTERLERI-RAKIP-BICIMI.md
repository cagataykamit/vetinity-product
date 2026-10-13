# Kayıt defterleri: rakip (E-vet SMART) biçimi ve bizdeki karşılığı (2026-10-13)

**Kullanıcı doğruladı (2026-10-13): ekran görüntüleri TAM SAYFA, tablolarda gizli sağ sütun yoktur; aşağıdaki sütun listeleri eksiksizdir.**

**Karar (kullanıcı, 2026-10-14): muayene defterinde "Tedavi Şekli, Reçete Bilgileri, Satışa Eklenen İlaçlar" TEK SÜTUN (rakipteki gibi).**

Kaynak: kullanıcının E-vet SMART ekran görüntüleri (Rapor menüsü; adresler `report?code=...RECORDBOOKREPORT`). **Yasal dayanak ve resmî biçim DOĞRULANMADI.** Ekranlardaki "i" simgesinin metni görülmedi. Tüm defterlerde: tek süzgeç **tarih aralığı + Filtrele**; sağ üstte **PDF seçici, indir, Yazdır**; kırmızı başlık bandı; sıra no; sayfalı (muayene 297, reçete 480 sayfa); sağ altta üretici logosu.

## 1. Defterler ve sütunları

**Muayene Kayıt Defteri ("Hayvan Muayene Kayıt Defteri"):** (Ekran görüntüsü düzeltmesi 2026-10-14: rakip ekranında "Hasta" bilgileri GRUP DEĞİL, tek hücrede virgüllü metin, örn. "Oscar, Köpek, Maltese, Erkek, 8, , , 1071,"; boş alanlar ",,," kalıyor; ekran yine de yatay kaydırıyor.) Sıra No | Muayene Tarihi | Hasta Sahibinin Adı Soyadı | Telefonu | Adresi | Hasta (Ad, Tür, Irk, Cinsiyet, Yaş, Kart No, Çip No, Protokol No, e-Reçete Kimlik) | Hastanın Şikayeti | Teşhis Edilen Hastalık | Tedavi Şekli, Reçete Bilgileri, Satışa Eklenen İlaçlar | Veteriner Hekimin Adı Soyadı.

**Reçete Kayıt Defteri:** gruplu başlıklar: REÇETENİN (Tarihi, Sınıfı [örnekte "B"], Cilt/Sıra No) | VETERİNER HEKİMİN (Adı Soyadı, Adresi) | HAYVAN SAHİBİNİN (Adı Soyadı, Adresi) | HAYVANIN (Türü, Kulak/İşletme No, Sayısı) | tek sütun: "İlacın Adı, Farmakolojik Şekli, Ambalajı, Adedi" (hücrede birleşik metin, örn. "Dectomax"; reçete satırı başına bir satır değil, ilaçlar tek hücrede).

**Aşı Kayıt Defteri (aşı STOK/giriş defteri, hayvan kaydı DEĞİL):** Sıra No | Ticari Adı | Seri No | Son Kullanma Tarihi | Toplam Miktar (Doz) | Satın Alınan Firma | Nakil Şekli (Soğuk Zincir) | Nakilde Kullanılan İzleme Cihazı (Soğuk Zincir İndikatörü) | Depo Çıkış Tarihi | Teslim Tarihi | Fatura Tarihi | Fatura No.

**İlaç Kayıt Defteri (ilaç GİRİŞ defteri):** Sıra No | Ürün | Farmakolojik Şekli | Takdim Şekli | Adet | Birim | Firma Adı | Geldiği Tarih | Fatura Tarihi | Fatura No | Seri No.

**Narkotik ve Psikotropik Ürünler Stok ve Sarf Defteri:** Sıra No | Ürün Adı, Ticari Adı ve Farmakolojik Şekli | Ticari Takdim Şekli | Miktar | Seri No | SATIN/İADE/DEVİR ALINAN ÜRÜNÜN (Alındığı Yer, Tarih, Belge No) | SATILAN/İADE VEYA DEVREDİLEN ÜRÜNÜN (Çıkış Yapılan Yer, Tarih, Reçete/Belge No) (tablo burada biter; ayrı "kalan/bakiye" sütunu YOK, bakiye ayrıca hesaplanabilir).

**Aşı Bilgi Raporu (`VACCINEINFOREPORT`), hayvan bazlı aşı çıktısı:** süzgeçler Tarih aralığı, Ürün, Veteriner. Sütunlar: # | Tarih | Hasta Sahibi | T.C. | Hasta | Tür | Çip No | Ürün | **Seri No | S.K.T** | Birim | Miktar | Fiyat | Toplam. (Doğrudan satıştan da satırlar geliyor.)

## 2. Bizim verimizle karşılaştırma

| Sütun / veri | Bizde |
|---|---|
| Muayene tarihi, hasta ad/tür/ırk/cinsiyet/yaş/çip/protokol, sahip adı/telefon, şikâyet, teşhis, tedavi, reçete satırları, uygulama (ilaç), hekim adı | **Var** (muayene, tedavi, reçete satırları, uygulama, kullanıcı) |
| Sahip adresi | **?** (müşteri adres alanı kontrol edilecek) |
| Kart No, e-Reçete kimliği | **Yok** (e-reçete entegrasyonu yok) |
| Reçete sınıfı, cilt/sıra no, hekim adresi, kulak/işletme no, hayvan sayısı, ambalaj | **Yok** |
| Ürün: farmakolojik şekil, takdim şekli, ambalaj, **kontrollü sınıf (narkotik/psikotropik)** | **Yok** |
| Stok girişi: **firma (tedarikçi), seri/lot no, son kullanma tarihi, fatura no/tarihi, geldiği/teslim tarihi, depo çıkış tarihi, nakil şekli ve soğuk zincir izleme cihazı** | **Yok** (D4: "lot/SKT ilk sürümde yok" kararı bu defterler için DEĞİŞİYOR) |
| Hayvana uygulanan ürünün **seri no ve SKT** (Aşı Bilgi raporu, narkotik sarf) | **Yok**: uygulama kaydı partiye bağlı değil |
| Satış/iade/devir ve belge no | Doğrudan satış **yok**; iade/devir **yok** |

## 3. Çıkarım ve öneri

1. **Muayene ve reçete defterleri** mevcut verimizle büyük oranda çıkar; eksik alanlar ayrı küçük işler.
2. **Aşı, ilaç, narkotik/psikotropik defterleri ve Aşı Bilgi raporu için PARTİ (lot) bazlı stok gerekir:** her stok girişi bir parti (seri no, SKT, firma, fatura, geliş/teslim tarihi, nakil/soğuk zincir); uygulama kaydı bir partiden düşer (genelde SKT'si en yakın önce); defterler partiden türetilir. Bu, stok modelinde önemli bir değişikliktir (migration), sözleşme önce yazılır.
3. **Çıktı:** PDF/yazdır ve CSV/XLSX; defter sütun tanımları tek yerde ve yapılandırılabilir; sayfa üstbilgisi, imza ve sayfa numarası resmî biçim doğrulanınca netleşir.
4. **Dilimler (öneri):** (a) muayene + reçete defterleri (migration yok); (b) parti bazlı stok girişi + ürün alanları + uygulamanın partiye bağlanması (migration); (c) aşı, ilaç, narkotik/psikotropik defterleri ve Aşı Bilgi raporu; (d) frontend ekranları (stok girişi formu, defterler, yazdırma). (b) ADR gerektirir (D4 değişikliği).
