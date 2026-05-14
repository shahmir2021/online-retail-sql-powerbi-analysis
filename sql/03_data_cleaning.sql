/* =========================================================
   STAGE 3: DATA CLEANING
   Project: Online Retail II SQL Analysis
   Goal: Create an analysis-ready dataset by removing
         invalid transactions and exact duplicate rows
   ========================================================= */


/* =========================================================
   1. REMOVE INVALID TRANSACTIONS
   ========================================================= */

-- Create a cleaned table by removing:
-- - rows where unit price is zero or negative
-- - rows where quantity is zero or negative
-- This keeps only valid sales transactions
CREATE TABLE retail_clean AS
SELECT *
FROM retail
WHERE unitprice > 0
  AND quantity > 0;

-- Validate the number of rows after removing invalid transactions
SELECT COUNT(*) AS cleaned_row_count
FROM retail_clean;


/* =========================================================
   2. IDENTIFY DUPLICATES IN CLEANED DATA
   ========================================================= */

-- Find duplicate transaction groups based on key transaction fields
SELECT
    invoiceno,
    stockcode,
    quantity,
    invoicedate,
    customerid,
    COUNT(*) AS duplicate_count
FROM retail_clean
GROUP BY
    invoiceno,
    stockcode,
    quantity,
    invoicedate,
    customerid
HAVING COUNT(*) > 1;

-- Count the total number of duplicate rows
-- duplicate_count - 1 shows how many extra repeated rows exist
SELECT
    SUM(duplicate_count - 1) AS total_duplicate_rows
FROM (
    SELECT
        COUNT(*) AS duplicate_count
    FROM retail_clean
    GROUP BY
        invoiceno,
        stockcode,
        quantity,
        invoicedate,
        customerid
    HAVING COUNT(*) > 1
) AS duplicate_summary;


/* =========================================================
   3. REMOVE EXACT DUPLICATES
   ========================================================= */

-- Create a deduplicated version of the cleaned table
-- DISTINCT removes rows that are identical across all columns
CREATE TABLE retail_clean_dedup AS
SELECT DISTINCT *
FROM retail_clean;

-- Validate row count after deduplication
SELECT COUNT(*) AS deduplicated_row_count
FROM retail_clean_dedup;


/* =========================================================
   4. REPLACE PREVIOUS CLEAN TABLE
   ========================================================= */

-- Replace the previous clean table with the deduplicated version
DROP TABLE retail_clean;

ALTER TABLE retail_clean_dedup
RENAME TO retail_clean;


/* =========================================================
   5. ASSESS REMAINING MISSING CUSTOMER IDS
   ========================================================= */

-- Count rows where customer ID is still missing
-- These rows are retained because they are still valid sales transactions
SELECT COUNT(*) AS missing_customerid_rows
FROM retail_clean
WHERE customerid IS NULL;

-- Preview rows with missing customer IDs
SELECT *
FROM retail_clean
WHERE customerid IS NULL
LIMIT 20;