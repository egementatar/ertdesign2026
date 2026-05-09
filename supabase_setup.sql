-- ═══════════════════════════════════════════════
--  ERT Design — Supabase Tam Kurulum
--  Bu SQL'i Supabase Dashboard → SQL Editor'da çalıştır
-- ═══════════════════════════════════════════════

-- 1) Eski tabloları sil (temiz başlangıç)
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS site_content CASCADE;
DROP TABLE IF EXISTS gallery CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS team CASCADE;

-- 2) Tabloları doğru tiplerde oluştur
CREATE TABLE messages (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text,
  email text,
  phone text,
  service text,
  message text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE site_content (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  key text UNIQUE NOT NULL,
  value text,
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE gallery (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title text,
  url text,
  "order" int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE services (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  icon text DEFAULT '✨',
  title text,
  description text,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE team (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text,
  role text,
  bio text,
  photo_url text,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- 3) RLS aç
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE team ENABLE ROW LEVEL SECURITY;

-- 4) RLS Politikaları — anon herkes okuyabilsin, mesaj gönderebilsin
CREATE POLICY "anon_insert_messages" ON messages FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "anon_select_messages" ON messages FOR SELECT TO anon USING (true);
CREATE POLICY "anon_delete_messages" ON messages FOR DELETE TO anon USING (true);

CREATE POLICY "anon_select_site_content" ON site_content FOR SELECT TO anon USING (true);
CREATE POLICY "anon_insert_site_content" ON site_content FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "anon_update_site_content" ON site_content FOR UPDATE TO anon USING (true);

CREATE POLICY "anon_select_gallery" ON gallery FOR SELECT TO anon USING (true);
CREATE POLICY "anon_insert_gallery" ON gallery FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "anon_update_gallery" ON gallery FOR UPDATE TO anon USING (true);
CREATE POLICY "anon_delete_gallery" ON gallery FOR DELETE TO anon USING (true);

CREATE POLICY "anon_select_services" ON services FOR SELECT TO anon USING (true);
CREATE POLICY "anon_insert_services" ON services FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "anon_update_services" ON services FOR UPDATE TO anon USING (true);
CREATE POLICY "anon_delete_services" ON services FOR DELETE TO anon USING (true);

CREATE POLICY "anon_select_team" ON team FOR SELECT TO anon USING (true);
CREATE POLICY "anon_insert_team" ON team FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "anon_update_team" ON team FOR UPDATE TO anon USING (true);
CREATE POLICY "anon_delete_team" ON team FOR DELETE TO anon USING (true);

-- 5) Örnek veriler
INSERT INTO site_content (key, value) VALUES
  ('hero_tag', 'ERT DESİGN'),
  ('hero_title', 'İÇ MEKANLARINIZI<br>BİZİMLE <span>DEKORE</span><br>EDİN'),
  ('hero_desc', 'Profesyonel iç mimari ve dekorasyon çözümleriyle mekanlarınıza değer katıyoruz.'),
  ('contact_address', 'Kulu, Konya, Türkiye'),
  ('contact_phone', '+90 332 000 00 00'),
  ('contact_email', 'info@ertdesign.com.tr'),
  ('contact_hours', 'Pzt – Cmt: 09:00 – 18:00'),
  ('location_desc', 'Konya Kulu''nda, size en yakın noktada hizmet veriyoruz.');

INSERT INTO services (icon, title, description, order_index) VALUES
  ('🛋️', 'İç Mekan Tasarımı', 'Yaşam alanlarınızı estetik ve fonksiyonel bir şekilde yeniden tasarlıyoruz.', 1),
  ('🏢', 'Ofis Düzenlemesi', 'Çalışma ortamınızı verimliliği artıracak şekilde profesyonelce dekore ediyoruz.', 2),
  ('🎨', 'Renk Danışmanlığı', 'Mekanınıza uygun renk paletleri ile atmosfer yaratıyoruz.', 3),
  ('🪟', 'Aydınlatma Tasarımı', 'Doğru aydınlatma planlamasıyla mekânınıza derinlik ve sıcaklık katıyoruz.', 4);

INSERT INTO gallery (title, url, "order") VALUES
  ('SALON TASARIMI', 'https://images.unsplash.com/photo-1631679706909-1844bbd07221?w=600&q=80', 1),
  ('MUTFAK',         'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&q=80', 2),
  ('YATAK ODASI',    'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=600&q=80', 3),
  ('OFİS',           'https://images.unsplash.com/photo-1615874959474-d609969a20ed?w=600&q=80', 4),
  ('BANYO',          'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=600&q=80', 5);

INSERT INTO team (name, role, bio, order_index) VALUES
  ('Osman Yılmaz', 'KURUCU & BAŞ MİMAR', '15 yıllık deneyimiyle iç mimari ve dekorasyon alanında öncü projeler hayata geçiriyor.', 1),
  ('Oğuz Yılmaz', 'İÇ MİMAR & TASARIM UZMANI', 'Modern ve özgün tasarım anlayışıyla mekanları yaşanabilir sanat eserlerine dönüştürüyor.', 2);
