/* =========================================================
   STAGE 1: SETUP
   Project: Online Retail II SQL Analysis
   Goal: Prepare dataset + validate import
   ========================================================= */

/* =========================================================
   ⚠️ WARNING
   Table was created via DBeaver import
   DO NOT run CREATE TABLE unless rebuilding
   ========================================================= */


/* =========================================================
   1. PROJECT NOTES
   ========================================================= */

-- Dataset: Online Retail II
-- Source: Kaggle (imported via CSV using DBeaver)
-- Main table: retail
-- Expected rows: ~541,910

-- Notes:
-- - Original Excel had multiple sheets
-- - Converted selected sheet to CSV before import
-- - Column names standardized to lowercase (PostgreSQL style)
-- - Invoice contains text (e.g. 'C536379') so stored as TEXT
-- - CustomerID mapped to NUMERIC
-- - Clean structure: lowercase, no spaces


/* =========================================================
   2. FINAL TABLE STRUCTURE (REFERENCE ONLY)
   DO NOT RUN unless rebuilding
   ========================================================= */

-- CREATE TABLE retail (
--     invoiceno TEXT,
--     stockcode TEXT,
--     description TEXT,
--     quantity INT,
--     invoicedate TIMESTAMP,
--     unitprice NUMERIC,
--     customerid NUMERIC,
--     country TEXT
-- );


/* =========================================================
   3. POST-IMPORT VALIDATION
   ========================================================= */

-- Check total rows
SELECT COUNT(*) AS total_rows
FROM retail;

-- Preview data
SELECT *
FROM retail
LIMIT 10;


/* =========================================================
   4. OPTIONAL REBUILD (ONLY IF NEEDED)
   ========================================================= */

-- DROP TABLE IF EXISTS retail;

-- CREATE TABLE retail (
--     invoiceno TEXT,
--     stockcode TEXT,
--     description TEXT,
--     quantity INT,
--     invoicedate TIMESTAMP,
--     unitprice NUMERIC,
--     customerid NUMERIC,
--     country TEXT
-- );