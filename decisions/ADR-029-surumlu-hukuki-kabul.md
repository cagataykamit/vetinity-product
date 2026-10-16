# ADR-029 — Sürümlü hukuki metin kabulü (TRIAL-009)

## Durum

**Kabul edildi (2026-10-16, kullanıcı: koordinatör önerisini onayladı).** [ADR-024](ADR-024-hukuki-metin-taslaklari.md) metinleri üretti; bu karar kabul mekanizmasıdır. İlgili: backlog TRIAL-009 / IDEA-028.

## Karar

1. **Üç Vetinity belgesi sürümlüdür:** Kullanım Şartları, Gizlilik Politikası, Veri İşleme Sözleşmesi. (Aydınlatma ve açık rıza klinik–müşteri belgeleridir, ADR-021'in konusu; bu mekanizmaya girmez.)
2. **Güncel sürüm numaraları backend'de tek yerde** tutulur (belge türü → sürüm, örn. `0.1` taslak). Sürüm yükseltilince kabul yeniden istenir. Taslak sürümler ("0.x") ürünün hukuki onay beklediğini gösterir.
3. **Kabul kaydı:** kullanıcı, klinik (tenant), belge türü, sürüm, kabul zamanı (UTC), kabul eden kullanıcı kimliği; silinmez, her kabul yeni satır. IP/cihaz bilgisi tutulmaz (veri azaltma).
4. **Kayıtta zorunlu kabul:** kayıt/klinik oluşturma akışında üç belge için tek onay kutusu (belgelere bağlantılı); sunucu da güncel sürümlerin kabulünü doğrular (yalnız arayüze güvenilmez).
5. **Güncelleme sonrası yeniden kabul:** giriş yapan kullanıcının kabul ettiği sürüm güncelin gerisindeyse uygulama, kabul edilene kadar paneli engelleyen bir kabul penceresi gösterir. Veri İşleme Sözleşmesi'ni yalnız klinik yöneticisi kabul eder; diğer kullanıcılar Kullanım Şartları ve Gizlilik'i kabul eder.
6. **Mevcut kullanıcılar** ilk girişte bekleyen kabul olarak görür (geriye dönük kayıt uydurulmaz).
7. Kapsam dışı: e-imza, PDF kopyası, kabul geçmişi ekranı (denetim kaydında görülür).

## Sonuçlar

- Backend: kabul kayıt tablosu (migration), güncel sürüm sabiti, kabul ve bekleyen-kabul uçları, kayıt akışına doğrulama, denetim kaydı.
- Frontend: kayıtta onay kutusu; girişte engelleyici kabul penceresi; hukuki sayfaların gösterdiği sürüm backend sürümüyle aynı kaynaktan.
