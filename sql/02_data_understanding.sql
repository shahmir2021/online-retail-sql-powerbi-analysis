/* =========================================================
   STAGE 2: DATA UNDERSTANDING
   Project: Online Retail II SQL Analysis
   Goal: Understand dataset structure, quality, anomalies,
         and business scale before cleaning
   ========================================================= */


/* =========================================================
   1. INITIAL DATA INSPECTION
   ========================================================= */

-- Count total number of rows in the dataset
SELECT COUNT(*) AS total_rows
FROM retail;

-- Preview the first 10 rows
SELECT *
FROM retail
LIMIT 10;

-- Check column names and data types
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'retail';


/* =========================================================
   2. MISSING VALUE CHECKS
   ========================================================= */

-- Count missing values in key columns
SELECT
    COUNT(*) FILTER (WHERE invoiceno IS NULL) AS missing_invoiceno,
    COUNT(*) FILTER (WHERE description IS NULL) AS missing_description,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
    COUNT(*) FILTER (WHERE invoicedate IS NULL) AS missing_invoicedate,
    COUNT(*) FILTER (WHERE unitprice IS NULL) AS missing_unitprice,
    COUNT(*) FILTER (WHERE customerid IS NULL) AS missing_customerid,
    COUNT(*) FILTER (WHERE country IS NULL) AS missing_country
FROM retail;


/* =========================================================
   3. DUPLICATE CHECKS
   ========================================================= */

-- Identify duplicate transaction groups based on core fields
SELECT
    invoiceno,
    stockcode,
    quantity,
    invoicedate,
    customerid,
    COUNT(*) AS duplicate_count
FROM retail
GROUP BY
    invoiceno,
    stockcode,
    quantity,
    invoicedate,
    customerid
HAVING COUNT(*) > 1;

-- Inspect the actual duplicate rows
SELECT *
FROM retail
WHERE (invoiceno, stockcode, quantity, invoicedate, customerid) IN (
    SELECT
        invoiceno,
        stockcode,
        quantity,
        invoicedate,
        customerid
    FROM retail
    GROUP BY
        invoiceno,
        stockcode,
        quantity,
        invoicedate,
        customerid
    HAVING COUNT(*) > 1
)
LIMIT 20;


/* =========================================================
   4. NEGATIVE VALUE CHECKS
   ========================================================= */

-- Count rows where quantity or unit price is negative
SELECT
    COUNT(*) FILTER (WHERE quantity < 0) AS negative_quantity,
    COUNT(*) FILTER (WHERE unitprice < 0) AS negative_price
FROM retail;

-- Inspect rows with negative quantity
SELECT *
FROM retail
WHERE quantity < 0
LIMIT 20;


/* =========================================================
   5. ZERO VALUE CHECKS
   ========================================================= */

-- Count rows where quantity or unit price equals zero
SELECT
    COUNT(*) FILTER (WHERE quantity = 0) AS zero_quantity,
    COUNT(*) FILTER (WHERE unitprice = 0) AS zero_unitprice
FROM retail;

-- Inspect rows with zero unit price
SELECT *
FROM retail
WHERE unitprice = 0
LIMIT 20;


/* =========================================================
   6. DATE RANGE CHECK
   ========================================================= */

-- Find earliest and latest transaction dates
SELECT
    MIN(invoicedate) AS earliest_date,
    MAX(invoicedate) AS latest_date
FROM retail;


/* =========================================================
   7. BUSINESS SCALE CHECKS
   ========================================================= */

-- Measure scale of invoices, products, customers, and countries
SELECT
    COUNT(DISTINCT invoiceno) AS distinct_invoices,
    COUNT(DISTINCT stockcode) AS distinct_stockcodes,
    COUNT(DISTINCT customerid) AS distinct_customers,
    COUNT(DISTINCT country) AS distinct_countries
FROM retail;

-- Count cancellation rows, invoice numbers starting with C
SELECT COUNT(*) AS cancellation_rows
FROM retail
WHERE invoiceno LIKE 'C%';

-- Count rows with missing customer IDs
SELECT COUNT(*) AS missing_customerid_rows
FROM retail
WHERE customerid IS NULL;


/* =========================================================
   8. BASIC DESCRIPTIVE STATISTICS
   ========================================================= */

-- Summary statistics for quantity and unit price
SELECT
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    AVG(quantity) AS avg_quantity,
    MIN(unitprice) AS min_unitprice,
    MAX(unitprice) AS max_unitprice,
    AVG(unitprice) AS avg_unitprice
FROM retail;