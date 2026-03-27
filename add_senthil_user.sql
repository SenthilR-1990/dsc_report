-- ============================================================
--  Add can_delete privilege column + create Senthil user
--  Run: mysql -u root -p dsc_incidents < add_senthil_user.sql
-- ============================================================

USE dsc_incidents;

-- Add can_delete column to users table
ALTER TABLE users
  ADD COLUMN can_delete TINYINT(1) NOT NULL DEFAULT 0 AFTER role;

SELECT 'Migration complete. Now run: python app.py --create-senthil' AS next_step;
