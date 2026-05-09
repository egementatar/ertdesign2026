-- ═══════════════════════════════════════════════
--  Storage (Depolama) İzinleri (RLS Politikaları)
--  Supabase Dashboard → SQL Editor'da çalıştırın
-- ═══════════════════════════════════════════════

-- 1. "images" bucket'ına herkesin dosya yükleyebilmesi (INSERT) için izin
CREATE POLICY "images_insert_policy" 
ON storage.objects FOR INSERT 
TO public 
WITH CHECK ( bucket_id = 'images' );

-- 2. "images" bucket'ındaki dosyaların güncellenebilmesi (UPDATE) için izin
CREATE POLICY "images_update_policy" 
ON storage.objects FOR UPDATE 
TO public 
USING ( bucket_id = 'images' );

-- 3. "images" bucket'ındaki dosyaların silinebilmesi (DELETE) için izin
CREATE POLICY "images_delete_policy" 
ON storage.objects FOR DELETE 
TO public 
USING ( bucket_id = 'images' );

-- 4. "images" bucket'ındaki dosyaların görüntülenebilmesi (SELECT) için izin
CREATE POLICY "images_select_policy" 
ON storage.objects FOR SELECT 
TO public 
USING ( bucket_id = 'images' );
