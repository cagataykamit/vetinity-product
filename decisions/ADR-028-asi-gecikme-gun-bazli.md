# ADR-028 — Aşı "gecikmiş" ve "yaklaşan" tanımı gün bazlıdır

## Durum

**Kabul edildi (2026-10-16, kullanıcı kararı).** Klinik ayarı olarak seçtirilmez; tek tanım (ayar eklemek iki davranışı sürekli desteklemek demek, ADR-025'teki sadelik ilkesi). Pilotta bir klinik saat bazlı ister ise yeniden değerlendirilir.

## Karar

1. **Gün sınırı klinik yerel günüdür (Europe/Istanbul).** "Bugün" = o günün 00:00'ından 24:00'ına kadar.
2. **Gecikmiş aşı:** vadesi **bugünün başından önce** olan planlı aşı. Bugün vadesi olan aşı, saati geçmiş olsa bile "bugün" sayılır, gecikmiş sayılmaz; ertesi gün gecikmiş olur.
3. **Yaklaşan aşı (Pano uyarısı, "önümüzdeki 7 gün"):** vadesi bugünün başından itibaren bugün dahil 7 takvim günü içinde olan planlı aşı. Liste bağlantısı (başlangıç/bitiş tarihi) aynı aralığı taşır; sayı ile liste birebir uyuşur.
4. Vefat eden hastanın aşıları her iki tanımda da sayılmaz (değişmez).
5. Tanım **tek yerde** (backend) yaşar; sayaç, listeler, hasta özeti, hatırlatma işçisi ve frontend aynı kuralı kullanır.

## Sonuçlar

- Backend: tanımı kullanan her yerin envanteri ve tek kurala bağlanması; testler; sözleşme belgeleri.
- Frontend: Pano kartı/uyarısı ve liste bağlantısı aynı aralığı kullanır; yerel hesap varsa kaldırılır.
- Hatırlatma işçisi bu tanımı kullanıyorsa müşteriye giden mesajın zamanı değişebilir; etkisi raporlanır.
