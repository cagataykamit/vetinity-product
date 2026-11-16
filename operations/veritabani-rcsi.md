# Veritabanında okuma sürümleme (RCSI): canlıya uygulama notu

Karar: [ADR-050](../decisions/ADR-050-veritabani-okuma-surumleme-ve-gecici-hata.md). Kod: backend migration `EnableReadCommittedSnapshot` (2026-11-16).

## Neden

2026-11-16 21:38'de içe aktarma geri alması yarıda kaldı. Yalnız okuyan bir sayım, outbox güncellemesiyle kilitlendi (SQL Server hatası 1205). READ_COMMITTED_SNAPSHOT açıkken okuma yazanı beklemez ve bu tür kilitlenme olmaz. Arka plan işlerine ayrıca kısa yeniden deneme eklendi.

## Ne yapar

- Migration yalnız `VetinityCommandDb` üzerinde, `ALTER DATABASE CURRENT ... SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE` çalıştırır. Veritabanı adı yazılmaz; Zonguldak veritabanına dokunmaz.
- Zaten açıksa bir şey yapmaz. Geri alma (Down) kapatır.
- `VetinityQueryDb` bu migration'la değişmez.

## Canlıya uygularken

1. **Zaman:** gece yayınıyla, bakım penceresinde (kılavuz bölüm 6). `WITH ROLLBACK IMMEDIATE` komut veritabanındaki açık işlemleri geri alır; birkaç saniye istekler hata alabilir, arka plan işleri kirası dolunca kaldığı yerden sürer.
2. **Önce yedek:** elle yedek al (kılavuz bölüm 9.3).
3. **Yetki:** `DbMigrator`'ın bağlandığı girişin veritabanında `ALTER DATABASE` yetkisi olmalı (örneğin `db_owner`). Uygulama girişi `vetinity_app` bu yetkiye sahip değilse migration o girişle çalıştırılmaz; yetkili girişle çalıştırılır. Yetki uygulamadan önce kontrol edilir.
4. **Uygula:** her zamanki gibi `DbMigrator` (kılavuz bölüm 5.3). Süren uzun bir iş (içe aktarma) varsa bitmesi beklenir.
5. **Doğrula:** `SELECT name, is_read_committed_snapshot_on FROM sys.databases WHERE name = 'VetinityCommandDb';` sonucu `1`. Zonguldak veritabanının satırı değişmemiş olmalı.
6. **İzle:** ilk gün günlüklerde `Transient SQL error; retrying` uyarılarını ve 1205 hatalarını say. tempdb boyutuna bir kez bak.

## Geri dönüş

Sorun olursa migration'ın Down adımı ya da elle `ALTER DATABASE CURRENT SET READ_COMMITTED_SNAPSHOT OFF WITH ROLLBACK IMMEDIATE` (yine birkaç saniyelik kesinti). Uygulama kodu iki durumda da çalışır.
