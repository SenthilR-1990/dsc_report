-- ============================================================
--  Migration: Add `ca` column to incidents table
--  Run ONCE: mysql -u root -p dsc_incidents < add_ca_column.sql
-- ============================================================

USE dsc_incidents;

-- 1. Add column (safe to run even if it already exists via IF NOT EXISTS workaround)
ALTER TABLE incidents
  ADD COLUMN IF NOT EXISTS ca VARCHAR(80) DEFAULT NULL
  AFTER incident_ref;

-- 2. Recreate view to include ca
CREATE OR REPLACE VIEW v_incidents AS
SELECT
  i.id,
  c.name              AS customer,
  i.incident_ref,
  i.ca,
  cat.name            AS category,
  i.incident_date,
  i.issue_reported,
  i.action_taken,
  r.name              AS resource,
  i.status,
  i.days_taken,
  i.hours_spent,
  i.device_model,
  i.firmware_version,
  i.remarks,
  i.created_at,
  i.updated_at
FROM incidents  i
JOIN customers  c   ON c.id   = i.customer_id
JOIN categories cat ON cat.id = i.category_id
JOIN resources  r   ON r.id   = i.resource_id;

SELECT 'CA column migration complete.' AS result;
