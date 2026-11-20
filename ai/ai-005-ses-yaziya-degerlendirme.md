# AI-005 — Konuşmayı yazıya çevirme: değerlendirme (taslak)

**Durum:** Taslak, karar bekliyor (2026-11-19). Kod yok. Kaynaklar 2026-11-19'da okundu; fiyatlar değişebilir.
**İlgili:** [AI-005, AI-001](../backlog/feature-backlog.md), [ADR-008](../decisions/ADR-008-embedded-ai-assistant.md), [ADR-044](../decisions/ADR-044-ai-eklentisi-kredi-ve-fon.md), [AI roadmap Aşama 2](ai-roadmap.md).

Claude sesi yazıya çevirmez; ayrı bir konuşma→metin (STT) hizmeti gerekir. Yazıya çevrilen metni alanlara ayırmak AI-001'in işidir (Claude, mevcut kredi modeli).

## 1. Kullanım senaryosu

1. Hekim muayene ekranında "Sesle not" düğmesine basar, muayene sırasında ya da hemen sonra konuşur, durdurur.
2. Ses backend'e gider, STT metne çevirir, metin hekime **taslak** olarak gösterilir (düzeltilebilir).
3. Hekim isterse AI-001 metni şikâyet / bulgu / değerlendirme / plan alanlarına ayırır; yine taslak, onaysız kayda geçmez (AI-009).
4. Ses dosyası çeviriden sonra silinir (öneri; bkz. açık kararlar).

**Gereksinimler**

- **Türkçe veteriner terimleri:** ilaç, etken madde, ırk ve aşı adları ("amoksisilin klavulanat", "Rabisin", "Golden Retriever", "FeLV"). Çoğu hizmet anahtar kelime ipucu kabul ediyor; listeyi stok/hizmet kataloğundan üretmek mümkün. Türkçe veteriner terimlerinde ölçülmüş kalite **hiçbir hizmet için yok**; pilotta kendi ses örneklerimizle denenmeli.
- **Mikrofon:** web'de `getUserMedia` + `MediaRecorder` (HTTPS gerekir). Mobilde aynı kod Capacitor WebView'da çalışmalı; iOS'ta `NSMicrophoneUsageDescription`, Android'de `RECORD_AUDIO` izni gerekir (WebView'da `getUserMedia` davranışı **doğrulanmadı**). Böylece web ve mobilde tek yol olur.
- **Kayıt süresi:** muayene başına 1–3 dk tipik (varsayım). Öneri: tek kayıt en çok 5 dk, sınıra yaklaşınca uyarı. DaySmart'ta ~20 dk pencere gözlenmişti. 2 dk Opus/WebM kayıt ~1 MB civarı (hesap, ölçülmedi); OpenAI'nin 25 MB dosya sınırının çok altında.

## 2. Seçenekler

### 2a. Bulut STT (dosya gönder, metin al)

| Hizmet | Türkçe | Fiyat (kayıt bitince) | Eğitim / saklama | AB bölgesi | Kaynak |
|---|---|---|---|---|---|
| **OpenAI** `gpt-transcribe` | Sayfada Türkçe listelenmiyor; Whisper 98 dil diyor (**Türkçe doğrulanmadı**) | $0,0045/dk (tahmini); `gpt-4o-mini-transcribe` $0,003/dk | API verisi eğitimde kullanılmaz; `/v1/audio/transcriptions` için kötüye kullanım saklaması "None"; sıfır saklama (ZDR) onayla | Avrupa (AEA+İsviçre) işleme; satışla görüşme, yeni projede seçilir, %10 ek ücret | [fiyat](https://developers.openai.com/api/docs/pricing), [veri](https://developers.openai.com/api/docs/guides/your-data), [bölge](https://developers.openai.com/api/docs/guides/data-residency), [STT](https://developers.openai.com/api/docs/guides/speech-to-text) |
| **Soniox** | Var (ayrı Türkçe sayfası) | $0,10/saat (~$0,0017/dk); canlı $0,12/saat | "Asla eğitimde kullanılmaz"; saklama süresi okunmadı | Var (AB, proje başına) | [fiyat](https://soniox.com/pricing), [bölge](https://docs.soniox.com/data-residency) |
| **ElevenLabs** Scribe v3 | Var; Scribe v2'de "≤%5 WER" sınıfında (üretici iddiası) | $0,20/saat (~$0,0033/dk) | Geçmiş saklama varsayılan açık; sıfır saklama **yalnız kurumsal**; eğitim koşulu bulunamadı | Yalnız kurumsal | [fiyat](https://elevenlabs.io/pricing/api), [diller](https://elevenlabs.io/docs/capabilities/speech-to-text), [ZRM](https://elevenlabs.io/docs/resources/zero-retention-mode) |
| **Deepgram** Nova-3 | Var (`tr`, tek dil ve çok dilli) | $0,0043/dk (tek dil) | **Varsayılan eğitimde kullanır**; istek başına `mip_opt_out=true` ile kapatılır | Var (`api.eu`) | [fiyat](https://deepgram.com/pricing), [diller](https://developers.deepgram.com/docs/models-languages-overview), [gizlilik](https://deepgram.com/privacy) |
| **AssemblyAI** Universal-2 | Var ("≤%10 WER" grubu); yeni STT-3.7'de **doğrulanmadı** | $0,15/saat (~$0,0025/dk) | Sözleşme eğitime izin veriyor; ücretli hesapta panelden kapatılır | Var (aynı fiyat) | [fiyat](https://www.assemblyai.com/pricing), [diller](https://www.assemblyai.com/docs/getting-started/supported-languages), [koşullar](https://www.assemblyai.com/legal/terms-of-service) |
| **Google** Chirp 3 | `tr-TR` listede; AB bölgesi satırı **doğrulanmadı** | Resmî sayfa okunamadı; arama özetinde $0,016/dk, toplu (24 saate kadar) $0,003/dk (**doğrulanmadı**) | Varsayılan kayıt yok; açılırsa eğitimde kullanılır | `eu` / `europe-west4` (**doğrulanmadı**) | [veri kaydı](https://docs.cloud.google.com/speech-to-text/docs/data-logging), [diller](https://docs.cloud.google.com/speech-to-text/v2/docs/speech-to-text-supported-languages) |
| **Azure** Speech | `tr-TR` var (canlı, toplu, hızlı) | Resmî sayfada fiyat görünmedi (**doğrulanmadı**); ayda 5 saat ücretsiz canlı | Canlı/hızlı çeviride veri saklanmaz; eğitim maddesi bulunamadı | Batı/Kuzey Avrupa bölgeleri var; STT kapsamı **doğrulanmadı** | [diller](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/language-support?tabs=stt), [gizlilik](https://learn.microsoft.com/en-us/legal/cognitive-services/speech-service/speech-to-text/data-privacy-security) |

- **Gecikme:** kayıt bitince 2 dk ses için birkaç saniye beklenir (**ölçülmedi**). Canlı akış (konuşurken yazı) daha pahalı (OpenAI $0,017/dk) ve WebSocket gerektirir; pilotta gerek yok.
- **Entegrasyon:** hepsi tek HTTP isteği (dosya yükle, metin al). Backend'de `ISpeechToText` arayüzü + tek sağlayıcı yeterli; sağlayıcı değişimi ayar işi.
- **Dikkat:** OpenAI `whisper-1`, `gpt-4o-transcribe`, `gpt-4o-mini-transcribe` 26 Şubat 2027'de kapanıyor; yalnız `gpt-transcribe` kullanılmalı.

### 2b. Kendi sunucumuzda açık kaynak (Whisper türevleri)

- Whisper, `large-v3-turbo`, `faster-whisper`, `whisper.cpp`: hepsi MIT lisanslı. Türkçe destekli; Türkçe doğruluk rakamı okunamadı (**doğrulanmadı**).
- **Donanım** ([whisper](https://github.com/openai/whisper), [faster-whisper](https://github.com/SYSTRAN/faster-whisper)): `turbo` ~6 GB, `large` ~10 GB GPU belleği. faster-whisper ölçümü (13 dk ses): GPU'da (RTX 3070 Ti, large-v2, int8) 59 sn; CPU'da (i7-12700K 8 çekirdek) yalnız `small` model 1 dk 42 sn. Küçük modellerin Türkçe terim kalitesi zayıf olabilir (**doğrulanmadı**).
- **Sonuç:** iyi kalite GPU ister. Mevcut canlı sunucu GPU'suz ve başka işler de taşıyor; CPU'da büyük model muayene akışına yetişmez (tahmin). GPU sunucu aylık sabit maliyettir (fiyat araştırılmadı) ve tek klinikte bile bulut STT'den çok pahalıdır.
- **Tek artısı:** ses Türkiye'de kalabilir (Türkiye'de GPU sunucu bulunursa) → KVKK yurt dışı aktarım yok. İşletme yükü (güncelleme, izleme, ölçekleme) bizde.

### 2c. Cihaz içi

| Yol | Durum | KVKK | Kaynak |
|---|---|---|---|
| **İşletim sistemi klavye diktesi** (iOS/Android/Windows/macOS mikrofon tuşu) | Bugün her metin kutusunda çalışır; **kod gerekmez** | Ses cihaz/OS sağlayıcısına gider; Vetinity veri işlemez | — |
| **Web Speech API** (`SpeechRecognition`) | Kısmi destek (caniuse: Chrome, Safari kısmi; Firefox kapalı). "Bazı tarayıcılar sesi sunucuya gönderir"; `processLocally` ile cihaz içi seçenek var ama sınırlı ve dil paketi indirmesi gerekir | Sunucu modunda ses tarayıcı sağlayıcısına sözleşmesiz gider (en zayıf durum); cihaz içi modda ses cihazdan çıkmaz (en iyi durum) | [MDN](https://developer.mozilla.org/en-US/docs/Web/API/SpeechRecognition), [kullanım](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API/Using_the_Web_Speech_API), [caniuse](https://caniuse.com/speech-recognition) |
| **Android `SpeechRecognizer`** | Cihaz içi tanıyıcı API 31+ (Android 12); varsayılan tanıyıcı sesi "büyük olasılıkla" sunucuya gönderir; Türkçe cihaz içi model **doğrulanmadı** | Cihaz içi modda iyi | [Android](https://developer.android.com/reference/android/speech/SpeechRecognizer) |
| **iOS Speech** (`SFSpeechRecognizer` / `SpeechAnalyzer`) | Apple sayfaları okunamadı; Türkçe ve cihaz içi destek **doğrulanmadı** | — | — |
| **Capacitor eklentisi** | `@capacitor-community/speech-recognition` (MIT): yalnız iOS/Android, web yok; cihaz içi mi sunucu mu belirtilmiyor | — | [GitHub](https://github.com/capacitor-community/speech-recognition) |

Cihaz içi yollar ücretsiz ama kalite tarayıcıya/telefona göre değişir, uzun konuşmada kesilir, anahtar kelime ipucu sınırlı ve web ile mobil ayrı kod ister.

## 3. Maliyet

Örnek klinik: günde 20 muayene × 2 dk = 40 dk/gün, ayda 22 gün → **880 dk (~14,7 saat)**.

| Seçenek | Aylık STT | Not |
|---|---|---|
| Soniox | ~$1,5 | |
| AssemblyAI Universal-2 | ~$2,2 | eğitim kapatılmalı |
| ElevenLabs Scribe v3 | ~$2,9 | |
| OpenAI `gpt-transcribe` | ~$4,0 | AB bölgesiyle ~$4,4 |
| Deepgram Nova-3 | ~$3,8 | eğitim kapatılmalı |
| Google Chirp (doğrulanmadı) | ~$14 | |
| AI-001 alan ayırma (Claude Haiku) | ~$0,2 | 440 istek × 1 kredi × $0,00045 |

**ADR-044'e bağlama önerisi**

- Ses "dakika" ile ölçülür, krediye çevrilir: **1 ses dakikası = sabit N kredi**, tek ayarda (`Ai:SpeechCreditsPerMinute` gibi), ADR-044 madde 9'daki gibi değer tek yerde yaşar.
- N, seçilen sağlayıcının dakika fiyatı / $0,00045 ile yukarı yuvarlanır. OpenAI `gpt-transcribe` (AB) ile tam 11 → küçük payla **N = 12**; Soniox ile ~4 → **N = 4**.
- Örnek klinikte (N = 12): 880 dk × 12 = 10.560 + AI-001 440 ≈ **11.000 kredi/ay** → Standart (10.000) yetmez, Yoğun (40.000) gerekir ya da ek fon. N = 4 ile ~4.000 kredi → Standart yeter. Sağlayıcı seçimi tarifeyi doğrudan etkiliyor.
- Saniye bazında yuvarlama (dakikaya yuvarlamayalım); başarısız çeviri kredi harcamaz. Kota bitince yalnız "Sesle not" kapanır, elle yazım sürer (ADR-008 madde 6).

## 4. Öneri

1. **Faz 0 — hemen, ücretsiz, kodsuz:** hekimler not alanında telefon/bilgisayar klavye diktesini kullanır; AI-001 açılınca bu metni alanlara ayırır. Yardım sayfasına kısa "sesle yazma" anlatımı yeterli. Sınır: kalite cihaza bağlı, ses OS sağlayıcısına gider ama Vetinity işlemez.
2. **Pilot — tek bulut sağlayıcı, kayıt bitince çeviri:**
   - **Birinci tercih: OpenAI `gpt-transcribe`.** Eğitim yok, bu uçta saklama yok, sıfır saklama ve AB işleme mümkün, büyük sağlayıcı, sözleşme olgun. Eksi: Türkçe kalite sayfada belirtilmiyor, daha pahalı (~$4/ay örnek klinik).
   - **İkinci aday: Soniox.** Türkçe açıkça var, eğitim yok, AB bölgesi var, en ucuz (~$1,5/ay). Eksi: küçük şirket, saklama koşulları tam okunmadı.
   - Pilotta ikisi aynı 20–30 gerçek (izinli, anonim) muayene kaydıyla karşılaştırılır; ölçü: veteriner terimi hatası ve hekimin düzeltme süresi. Kazanan tarifeyi (N) belirler.
3. **Önerilmeyenler (şimdilik):** kendi sunucumuzda Whisper (GPU maliyeti, işletme yükü); Web Speech API sunucu modu (sesi sözleşmesiz üçüncü tarafa gönderir); Deepgram/AssemblyAI (varsayılan eğitim; kapatılabilir ama hata riski); ElevenLabs (sıfır saklama ve AB yalnız kurumsal).
4. **Cihaz içi Web Speech (`processLocally`)** ileride ücretsiz bir "hafif dikte" olarak eklenebilir; yalnız cihaz içi mümkünse düğme görünür. Pilot için gerekli değil.

**KVKK (hukuki değerlendirme değil, çalışma notu):** ses kaydı hekimin ve çoğu zaman hasta sahibinin sesini içerir; ad, telefon gibi bilgiler geçebilir. Bulut STT, Claude'da olduğu gibi yurt dışına aktarım demektir; AB bölgesi de yurt dışıdır. 2024 KVKK değişikliğinin (standart sözleşme ve Kurul'a bildirim) bu duruma uygulanışı **doğrulanmadı**. Asgari önlemler: ses çeviriden sonra silinir, normal loglara yazılmaz (ADR-008 madde 10), aydınlatma metnine alt işleyen ve "muayenede sesle not" eklenir, klinik ayarından kapatılabilir.

## 5. Açık kararlar

1. **Faz 0 kabul mü?** Kodsuz klavye diktesi + AI-001 ile başlamak.
2. **Pilot sağlayıcı(lar):** OpenAI `gpt-transcribe` ve/veya Soniox; ücretli hesap ertelemesi kalkınca hangisi açılacak.
3. **Ses saklama:** çeviriden sonra hemen silinsin mi (öneri), yoksa hekim düzeltene kadar kısa süre (ör. 24 saat) tutulsun mu?
4. **AB bölgesi:** OpenAI'de %10 ek ücret ve satış görüşmesi gerektiriyor; pilotta istenecek mi?
5. **Kredi oranı:** ses dakikası başına sabit kredi (N) ve sesli notun hangi eklentide açılacağı; N = 12 ise örnek klinik Yoğun eklentiye düşüyor.
6. **Hasta sahibini bilgilendirme:** muayenede kayıt yapıldığını hekim mi söyler, yoksa ekranda/aydınlatma metninde yazılı bilgi yeterli mi?
7. **Kayıt sınırı:** tek kayıt 5 dk mı; canlı yazı (konuşurken) ileride istenecek mi?
