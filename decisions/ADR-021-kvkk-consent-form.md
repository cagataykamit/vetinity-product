# ADR-021 — KVKK açık rıza formu (yazdırılabilir) ve rıza alındı işareti

## Durum

**Kabul edildi (2026-10-15, kullanıcı: rakipteki KVKK formu örneğini gösterdi; rakip pratiği varsayılan kaynak).** Hukuki metin **uzman onayı bekliyor**; ürün kendi hukuki metnini yazmaz, rakip metni kopyalanmaz. İlgili: [ADR-019](ADR-019-data-import.md) K3 (içe aktarılan müşterilere hatırlatma gitmez), backend `docs/PET_STATUS_CLIENT_CONTACT_API_CONTRACT.md` (`RemindersOptedOut`).

## Bağlam

Rakipte KVKK açık rıza belgesi, müşteri adı ve tarihi önceden doldurulmuş, **yazdırılıp müşteriye imzalatılan** bir rapor: başlıkta klinik adı, açık rıza metni, "Kabul ediyorum / Kabul etmiyorum" kutuları, "Veri Sahibi: Adı Soyadı, Tarih, İmza" bloğu. Sistemde bir "rıza kaydı" modeli görülmedi (yalnız görüntü incelendi; arka yüzü doğrulanmadı). Bizde şu an yalnız `RemindersOptedOut` (hatırlatma istemiyor) bayrağı var.

## Karar

1. **Yazdırılabilir açık rıza formu:** müşteri kartından "KVKK formu yazdır" eylemi; klinik adı, müşteri adı soyadı ve tarih önceden dolu; "Kabul ediyorum / Kabul etmiyorum" kutuları ve imza satırı; yazdırma/PDF.
2. **Metin klinik tarafından düzenlenir:** form metni Ayarlar'da klinik başına saklanan bir **şablon metindir** (yer tutucular: klinik adı, müşteri adı, tarih). Başlangıçta **yer tutucu metin** ("Bu metin hukuk danışmanınızca onaylanmış açık rıza metniyle değiştirilmelidir") gelir; hukuki metni ürün üretmez, rakip metni kopyalanmaz. Klinik KVKK danışmanının metnini yapıştırır.
3. **Rıza alındı işareti (basit kayıt):** müşteri kartında "KVKK formu imzalandı" bilgisi: **tarih** ve **Kabul / Ret**, kim işaretledi (denetim izi). Form kâğıtta kalır; sistem yalnız imzalı kopyanın alındığını ve tarihini tutar. Dosya/tarama ekleme ilk sürümde YOK (depolama ve KVKK saklama süresi kararı gerekir).
4. **Hatırlatma ilişkisi (şimdilik değişmez):** "Ret" işaretlenirse `RemindersOptedOut` otomatik açılmaz; bağ, hukuki görüşe göre sonra karar verilir. Mevcut kural aynı: işaretli müşteriye otomatik hatırlatma gitmez.
5. **Kapsam dışı:** rıza sürümleme, e-imza, SMS/e-posta ile onay, tarama yükleme, İYS (ticari ileti izni) entegrasyonu.

## Sonuçlar

- Backend: `Client` üzerinde `KvkkConsentStatus` (Yok/Kabul/Ret) + `KvkkConsentRecordedOn`; klinik ayarı olarak form şablon metni (yer tutuculu); izin: mevcut müşteri güncelleme izni; migration (yerel DB'ye koordinatör uygular).
- Frontend: müşteri kartında "KVKK formu yazdır" ve "Rıza durumu" bölümü; Ayarlar'da form metni düzenleme; yazdırma görünümü (`@media print`).
- Riskler: hukuki metin ve saklama süreleri doğrulanmadı; ürün hukuki tavsiye vermez. Pilot öncesi KVKK danışmanı metni onaylamalıdır.
