-- Replace in post content
UPDATE wp3d_posts
SET post_content = REPLACE(post_content, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id');

-- Replace in post GUIDs (optional: avoid if you care about RSS consistency)
UPDATE wp3d_posts
SET guid = REPLACE(guid, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id');

-- Replace in options table (only if not serialized)
UPDATE wp3d_options
SET option_value = REPLACE(option_value, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id')
WHERE option_name IN ('home', 'siteurl');

-- Replace in postmeta (only if not serialized)
UPDATE wp3d_postmeta
SET meta_value = REPLACE(meta_value, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id');

-- Replace in usermeta (if needed)
UPDATE wp3d_usermeta
SET meta_value = REPLACE(meta_value, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id');

-- Replace in comments (optional)
UPDATE wp3d_comments
SET comment_content = REPLACE(comment_content, 'https://rspkujogja.com', 'https://rspkujogja.muhammadiyah.or.id');