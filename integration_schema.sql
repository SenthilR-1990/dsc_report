-- ============================================================
--  DSC Integration Pending Tracker — Additional Tables
--  Run ONCE: mysql -u root -p dsc_incidents < integration_schema.sql
-- ============================================================

USE dsc_incidents;

-- ── CA Integration List ────────────────────────────────────
CREATE TABLE IF NOT EXISTS int_ca_list (
  id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name      VARCHAR(120) NOT NULL UNIQUE,
  status    ENUM('Pending','Completed','Partially Completed','Working In Progress') NOT NULL DEFAULT 'Pending',
  remarks   TEXT         DEFAULT NULL,
  created_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_ca_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Providers (Device + Sign Application) ─────────────────
CREATE TABLE IF NOT EXISTS int_providers (
  id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  provider_type ENUM('device','sign','service') NOT NULL DEFAULT 'device',
  name          VARCHAR(120) NOT NULL,
  status        ENUM('Pending','Completed','Partially Completed','Working In Progress') NOT NULL DEFAULT 'Pending',
  remarks       TEXT         DEFAULT NULL,
  created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_prov_type   (provider_type),
  INDEX idx_prov_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Issue Tracker ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS int_issues (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  customer   VARCHAR(100) NOT NULL,
  issue      TEXT         NOT NULL,
  remarks    TEXT         DEFAULT NULL,
  status     ENUM('Resolved','Un Resolved','Integration Required','On Hold','Devolopment team Is working On') NOT NULL DEFAULT 'On Hold',
  created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_issue_status   (status),
  INDEX idx_issue_customer (customer)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── Seed CA List ───────────────────────────────────────────
INSERT IGNORE INTO int_ca_list (name,status,remarks) VALUES
  ('Safescrypt','Pending',NULL),('IDRBT','Pending',NULL),
  ('(n)Code Solutions','Completed',NULL),('e-Mudhra','Completed',NULL),
  ('CDAC','Pending',NULL),('Capricorn','Pending',NULL),
  ('Protean (NSDL eGov)','Pending',NULL),('Vsign (Verasys)','Completed',NULL),
  ('Indian Air Force','Pending',NULL),('CSC','Pending',NULL),
  ('RISL (RajComp)','Pending',NULL),('Indian Army','Pending',NULL),
  ('IDSign','Pending',NULL),('CDSL Ventures','Pending',NULL),
  ('Panta Sign','Completed',NULL),('xtra Trust','Partially Completed','Customer Is not Responding'),
  ('Indian Navy','Pending',NULL),('ProDigiSign','Partially Completed','Not Gone for Production'),
  ('SignX','Pending',NULL),('JPSL','Pending',NULL),
  ('Care 4 Sign','Completed',NULL),('IGCAR','Pending',NULL),
  ('Speed Sign','Completed',NULL),('Assam Rifles','Pending',NULL);

-- ── Seed Providers ─────────────────────────────────────────
INSERT IGNORE INTO int_providers (provider_type,name,status,remarks) VALUES
  ('device','Andhra Pradesh Technology Services (APTS)','Working In Progress',NULL),
  ('device','QCID','Pending',NULL),
  ('device','MP Online','Completed',NULL),
  ('device','Efiling InfoTech','Completed',NULL),
  ('device','EncureIT','Pending',NULL),
  ('sign','NIC','Partially Completed','Windows is completed Android is Pending'),
  ('sign','Odyssey (xorkeesign)','Pending','Need Integration'),
  ('sign','AIM Techsoft','Completed',NULL),
  ('sign','ID Sign','Pending','Need Integration'),
  ('sign','etenders.unitedgroup.com','Pending','Need Integration');

-- ── Seed Issues ────────────────────────────────────────────
INSERT IGNORE INTO int_issues (customer,issue,remarks,status) VALUES
  ('E-Mudhra','Unable to use DSC on eproc.isro website — cannot read certificate details from USB token.','Issue Resolved: ISRO_EProcClient path, library=InnaITPKCS11Driver.dll','Resolved'),
  ('E-Mudhra','Antivirus scanned and found malware in our installer.',NULL,'Resolved'),
  ('E-Mudhra','Certificate details not reflected in Tally application.','Token works in Tally but customer uses Remote Desktop — smartcard not enabled for RDP forwarding.','Resolved'),
  ('E-Mudhra','Punjab & Sind Bank portal — unable to sign document, showing null in signature column.','Not Resolved — site uses Deprecated MD5 Algorithm.','Un Resolved'),
  ('E-Mudhra','MAC 10.12 and below — InnaIT token not supported.','Fixed in v3.7.9.1 — Mac above 10.7 now supported.','Resolved'),
  ('E-Mudhra','Unable to read token for certificate selection on coo.dgft.gov.in','Site needs Smart Card device (works with PK32XX).','Resolved'),
  ('E-Mudhra','Unable to read token on bpcltenders.eproc.in','Not Resolved — site uses Deprecated MD5 Algorithm.','Un Resolved'),
  ('E-Mudhra','Invalid Signature error when validating signed PDF in Adobe Reader.','Fixed in 32XX Model v3.7.9.1.','Resolved'),
  ('E-Mudhra','NDMS site — DSC unable to integrate with server.','Need to contact the site.','Integration Required'),
  ('E-Mudhra','(n)Procure Portal — Precision InnaIT token not detected/reflected.','Need to contact the site.','Integration Required'),
  ('E-Mudhra','Windows 7 — USB token not detected while signing PDF.','Currently not supported — Development team is working on it.','Devolopment team Is working On'),
  ('E-Mudhra','Unable to read token on prasarbharati.eproc.in','Need Integration.','Integration Required'),
  ('E-Mudhra','Unable to register DSC on app1.leegality.com','Need Integration.','Integration Required'),
  ('E-Mudhra','XPDF Signer showing No token found after adding DLL path.','Need to check.','Integration Required'),
  ('E-Mudhra','Unable to register DSC on priceagri.kerala.gov.in','Need to check.','Integration Required'),
  ('E-Mudhra','Unable to register DSC on Bharat Petroleum vendor portal.','Site needs Smart Card device (works with PK32XX).','Resolved'),
  ('E-Mudhra','SAP application — unable to map Precision token.','Need to check.','Resolved'),
  ('E-Mudhra','contractors.kerala.gov.in — device not detecting.','Need to check.','On Hold'),
  ('E-Mudhra','balmerlawrie.eproc.in — not detecting while registering.','Need to check.','On Hold'),
  ('E-Mudhra','etenders.unitedgroup.com — token not listed on their site.','Need integration team support.','On Hold'),
  ('Speed Sign','Prodigi Sign completed integration but not gone for production.','Need integration team support.','On Hold'),
  ('Speed Sign','Xorkey application not integrated with token.','Need integration team support.','On Hold');

SELECT 'Integration tables created and seeded successfully.' AS result;
