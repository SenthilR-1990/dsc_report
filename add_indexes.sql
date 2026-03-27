-- ============================================================
--  DSC Incident Tracker — Additional Indexes
--  Run: mysql -u root -p dsc_incidents < add_indexes.sql
-- ============================================================

USE dsc_incidents;

-- ── Already exist (from schema.sql) ───────────────────────
-- idx_status          ON incidents(status)
-- idx_incident_date   ON incidents(incident_date)
-- idx_category        ON incidents(category_id)
-- idx_resource        ON incidents(resource_id)
-- idx_customer        ON incidents(customer_id)

-- ── New Indexes ────────────────────────────────────────────

-- 1. Full-text search on issue_reported, action_taken, remarks
--    Speeds up the search box in the incidents table
ALTER TABLE incidents
  ADD FULLTEXT INDEX ft_search (issue_reported, action_taken, remarks);

-- 2. Composite index: customer + status (common filter combo)
ALTER TABLE incidents
  ADD INDEX idx_customer_status (customer_id, status);

-- 3. Composite index: category + status
ALTER TABLE incidents
  ADD INDEX idx_category_status (category_id, status);

-- 4. Composite index: date range queries + status
ALTER TABLE incidents
  ADD INDEX idx_date_status (incident_date, status);

-- 5. Composite index: resource + date (for resource-wise reports)
ALTER TABLE incidents
  ADD INDEX idx_resource_date (resource_id, incident_date);

-- 6. created_at index (for sorting by newest)
ALTER TABLE incidents
  ADD INDEX idx_created_at (created_at);

-- 7. Users table — username lookup (login query)
ALTER TABLE users
  ADD INDEX idx_username (username);

-- 8. Users table — role lookup (admin checks)
ALTER TABLE users
  ADD INDEX idx_role (role);

-- ── Verify all indexes ─────────────────────────────────────
SHOW INDEX FROM incidents;
SHOW INDEX FROM users;
