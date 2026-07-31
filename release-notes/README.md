# Release Notes

Bu klasör, Vetinity'nin kullanıcıya yönelik sürüm notlarını tutar.

## Amaç

Her anlamlı ürün sürümünde (yeni özellik, iyileştirme, düzeltme) kullanıcıların ve dahili ekiplerin ne değiştiğini takip edebilmesi için sürüm notları oluşturulur.

## Dosya yapısı

Sürüm notları aşağıdaki formatta adlandırılır:

```
release-notes/vX.Y.Z.md
```

Örnek: `release-notes/v1.0.0.md`

## Sürüm notu şablonu

Her sürüm notu aşağıdaki bölümleri içermelidir:

```markdown
# vX.Y.Z — Sürüm Notu

**Tarih:** YYYY-AA-GG

## Öne çıkanlar
- ...

## Yeni özellikler
- ...

## İyileştirmeler
- ...

## Düzeltmeler
- ...

## Bilinen sınırlamalar
- ...

## İlgili backlog / roadmap güncellemeleri
- ...
```

## Ne zaman sürüm notu oluşturulur?

- Kullanıcıya görünür bir özellik veya değişiklik üretim ortamına alındığında
- Trial, onboarding veya plan değişiklikleri yayınlandığında
- Önemli UX veya navigasyon değişiklikleri uygulandığında

## Sürüm notu ile diğer belgelerin ilişkisi

| Belge | Rol |
|---|---|
| **Release note** | Kullanıcıya ne değişti? |
| **Backlog** | İş maddesinin durumu "Tamamlandı" olarak güncellenir |
| **Roadmap** | İlgili madde durumu güncellenir |
| **ADR** | Karar uygulandıysa "Uygulama etkileri" bölümüne not düşülür |

## Kurallar

- Henüz gerçekleşmemiş sürümler için sahte release notu **oluşturulmaz**.
- Sürüm notları Türkçe yazılır.
- Teknik uygulama detayları (API, contract, deploy) frontend/backend repository'lerinde tutulur; burada yalnızca ürün değişiklikleri anlatılır.
- Her sürüm notu ilgili backlog maddelerine referans verir.

## Mevcut sürümler

Henüz yayınlanmış sürüm notu bulunmamaktadır. İlk sürüm yayınlandığında bu bölüm güncellenecektir.

---

## İlgili belgeler

- [Release plan](../roadmap/release-plan.md)
- [Roadmap](../roadmap/roadmap.md)
- [Feature backlog](../backlog/feature-backlog.md)
