# ADR-050 — Veritabanında okuma sürümleme (RCSI) ve arka plan işlerinde geçici hata yeniden denemesi

## Durum

**Kabul edildi (2026-11-16, kullanıcı onayı koordinatör üzerinden).** Uygulama backend `feature/aktarma-geri-alma-suresi` dalında; canlıya uygulanmadı. Operasyon adımları: [operations/veritabani-rcsi.md](../operations/veritabani-rcsi.md).

## Bağlam

- 2026-11-16 21:38'de canlıda DOGUSZONGULDAK kiracısının içe aktarma partisi geri alınırken 8799 birimin 3750'sinde iş durdu ve parti "Geri alma başarısız" oldu.
- Neden: yalnız okuyan bir ölçüm (geri basınç için outbox kuyruğu sayımı), projeksiyon tüketicisinin outbox güncellemesiyle kilitlendi. SQL Server ölçüm okumasını kilitlenme kurbanı seçti (hata 1205). Arka plan işinde geçici hata için yeniden deneme yoktu; tek bir okuma bütün işi düşürdü.
- Veritabanında varsayılan kilitli READ COMMITTED açıktı: okuyan, yazanın işlemini bekliyor ve kilitlenmeye katılabiliyordu.

## Kararlar

1. **Komut veritabanında READ_COMMITTED_SNAPSHOT açılır.** READ COMMITTED okumaları yazanı beklemez, son onaylanmış sürümü okur. Okuma ile yazma arasındaki kilitlenme ve bekleme ortadan kalkar. Yazma ile yazma arasındaki kilitlenme sürer. Ayar migration ile gelir, yalnız uygulamanın kendi veritabanına uygulanır; aynı sunucudaki başka veritabanlarına dokunulmaz.
2. **Arka plan işlerinde geçici SQL hataları kısa bekleme ve sınırlı yeniden denemeyle karşılanır.** Kilitlenme kurbanı, kilit ya da komut zaman aşımı, bağlantı kopması gibi hatalar üç kez daha denenir (toplam yaklaşık 4 sn). Denemeler tükenirse işin kendi hata yolu çalışır. Kural tek yerdedir. Kapsam: içe aktarma uygulama ve geri alma işi (birimler, ölçüm, kira, tamamlama), outbox ve projeksiyon tüketicilerinin sonuç yazımı, projeksiyon uygulaması, hatırlatma işlemcisinin kayıt adımı.
3. **API isteklerinde genel yeniden deneme açılmaz.** Kullanıcı isteğinin işlem hattı, dıştan yeniden denemeyle çakışır. RCSI sonrası okuma kaynaklı kilitlenmeler beklenmez. Canlı günlüklerde istek kaynaklı 1205 görülürse ayrıca değerlendirilir.

## Sonuçlar

- Okuma ile yazma kilitlenmesi kalmaz; uzun yazma işlemleri (içe aktarma oluşturma, geri alma) sırasında ekranlar beklemez.
- tempdb'de sürüm deposu büyür; yük düşük olduğundan pilot hacminde önemsiz.
- Bazı "önce say, sonra yaz" kuralları RCSI'de eşzamanlı yazanı görmez. Açık taslak sınırı (kiracı başına 5) ve randevu onayındaki çakışma denetimi bunlardandır. İkisi de bugün de yarışa açıktı; RCSI pencereyi büyütür. Kesin güvence ayrı iş olarak backlog'a alınır (kiracı/hekim bazında uygulama kilidi).
- Sorgu veritabanında (okuma modelleri) RCSI bu kararla açılmadı; projeksiyon yazımı ile ekran okumaları arasında aynı fayda beklenir, ayrı karar olarak değerlendirilir.
- Canlıya uygularken veritabanındaki açık işlemler geri alınır: birkaç saniyelik kesinti, gece yayınıyla yapılır. Migrator kullanıcısının `ALTER DATABASE` yetkisi gerekir.
