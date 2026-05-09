# ERT Design — Supabase Kurulum Kılavuzu

## 1. Supabase Projesi Oluştur

1. [supabase.com](https://supabase.com) adresine gidin
2. "New Project" ile yeni proje oluşturun
3. **Project Settings → API** bölümünden şunları kopyalayın:
   - **Project URL** → `https://locdxrtbzohuomuzjmff.supabase.co`
   - **anon public key** → `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxvY2R4cnRiem9odW9tdXptaWZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2Mzc4MzMsImV4cCI6MjA3ODIxMzgzM30.B0W8yHk7w1W5l50L_nE_5l0H8pB-X-4N6L7zR_c0Nzc`

---

## 2. Tabloları Oluştur (SQL Editor)

Supabase Dashboard → **SQL Editor** → aşağıdaki sorguyu çalıştırın:

```sql
-- ── MESAJLAR ──
CREATE TABLE IF NOT EXISTS messages (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text,
  email text,
  phone text,
  service text,
  message text,
  created_at timestamptz DEFAULT now()
);

-- ── SİTE İÇERİĞİ ──
CREATE TABLE IF NOT EXISTS site_content (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  key text UNIQUE NOT NULL,
  value text,
  updated_at timestamptz DEFAULT now()
);

-- ── GALERİ ──
CREATE TABLE IF NOT EXISTS gallery (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title text,
  url text,
  "order" int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- ── HİZMETLER ──
CREATE TABLE IF NOT EXISTS services (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  icon text DEFAULT '✨',
  title text,
  description text,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- ── EKİP ──
CREATE TABLE IF NOT EXISTS team (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text,
  role text,
  bio text,
  photo_url text,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- ── GÜVENLİK (RLS) ──
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE team ENABLE ROW LEVEL SECURITY;

-- Mesajlar: herkes gönderebilir, sadece yetkili okuyabilir
CREATE POLICY "anon insert messages" ON messages FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "auth read messages"   ON messages FOR SELECT TO authenticated USING (true);
CREATE POLICY "auth delete messages" ON messages FOR DELETE TO authenticated USING (true);

-- Site içeriği: herkes okuyabilir, sadece yetkili yazabilir
CREATE POLICY "anon read site_content" ON site_content FOR SELECT TO anon USING (true);
CREATE POLICY "auth write site_content" ON site_content FOR ALL TO authenticated USING (true);

-- Galeri: herkes okuyabilir
CREATE POLICY "anon read gallery" ON gallery FOR SELECT TO anon USING (true);
CREATE POLICY "auth write gallery" ON gallery FOR ALL TO authenticated USING (true);

-- Hizmetler: herkes okuyabilir
CREATE POLICY "anon read services" ON services FOR SELECT TO anon USING (true);
CREATE POLICY "auth write services" ON services FOR ALL TO authenticated USING (true);

-- Ekip: herkes okuyabilir
CREATE POLICY "anon read team" ON team FOR SELECT TO anon USING (true);
CREATE POLICY "auth write team" ON team FOR ALL TO authenticated USING (true);
```

---

## 3. Örnek Veri Ekle (İsteğe Bağlı)

```sql
-- Site içeriği
INSERT INTO site_content (key, value) VALUES
  ('hero_tag', 'ERT DESİGN'),
  ('hero_title', 'İÇ MEKANLARINIZI<br>BİZİMLE <span>DEKORE</span><br>EDİN'),
  ('hero_desc', 'Profesyonel iç mimari ve dekorasyon çözümleriyle mekanlarınıza değer katıyoruz.'),
  ('contact_address', 'Kulu, Konya, Türkiye'),
  ('contact_phone', '+90 332 000 00 00'),
  ('contact_email', 'info@ertdesign.com.tr'),
  ('contact_hours', 'Pzt – Cmt: 09:00 – 18:00'),
  ('location_desc', 'Konya Kulu''nda, size en yakın noktada hizmet veriyoruz.');

-- Hizmetler
INSERT INTO services (icon, title, description, order_index) VALUES
  ('🛋️', 'İç Mekan Tasarımı', 'Yaşam alanlarınızı estetik ve fonksiyonel bir şekilde yeniden tasarlıyoruz.', 1),
  ('🏢', 'Ofis Düzenlemesi', 'Çalışma ortamınızı verimliliği artıracak şekilde profesyonelce dekore ediyoruz.', 2),
  ('🎨', 'Renk Danışmanlığı', 'Mekanınıza uygun renk paletleri ile atmosfer yaratıyoruz.', 3),
  ('🪟', 'Aydınlatma Tasarımı', 'Doğru aydınlatma planlamasıyla mekânınıza derinlik ve sıcaklık katıyoruz.', 4);

-- Galeri
INSERT INTO gallery (title, url, "order") VALUES
  ('SALON TASARIMI', 'https://images.unsplash.com/photo-1631679706909-1844bbd07221?w=600&q=80', 1),
  ('MUTFAK',         'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&q=80', 2),
  ('YATAK ODASI',    'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=600&q=80', 3),
  ('OFİS',           'https://images.unsplash.com/photo-1615874959474-d609969a20ed?w=600&q=80', 4),
  ('BANYO',          'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=600&q=80', 5);

-- Ekip
INSERT INTO team (name, role, bio, order_index) VALUES
  ('Osman Yılmaz', 'KURUCU & BAŞ MİMAR', '15 yıllık deneyimiyle iç mimari ve dekorasyon alanında öncü projeler hayata geçiriyor.', 1),
  ('Oğuz Yılmaz', 'İÇ MİMAR & TASARIM UZMANI', 'Modern ve özgün tasarım anlayışıyla mekanları yaşanabilir sanat eserlerine dönüştürüyor.', 2);
```

---

## 4. Local'de Çalıştır

```bash
# Terminalde çalıştır:
bash /home/loufy/Masaüstü/files/start-server.sh
```

Ardından tarayıcınızda açın:
- **Ana Site:** http://localhost:8080/ert-design.html
- **Admin Panel:** http://localhost:8080/admin.html

---

## 5. Admin Panel'de Bağlan

1. `http://localhost:8080/admin.html` adresine gidin
2. **Kullanıcı adı:** `admin` | **Şifre:** `ert2024`
3. Sol menüden **"Supabase Ayarları"** seçin
4. Project URL ve Anon Key'i yapıştırıp **"BAĞLAN & KAYDET"** butonuna tıklayın

---

## Mimari

```
ert-design.html ──── Supabase JS SDK ────► Supabase Cloud
admin.html      ──── Supabase JS SDK ────► Supabase Cloud
```

- Tüm içerik (hero, hizmetler, galeri, ekip) `site_content`, `services`, `gallery`, `team` tablolarından gelir
- İletişim formu `messages` tablosuna yazar
- Admin paneli `messages` tablosunu okur/siler
