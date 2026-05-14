/* =========================================================
   STAGE 4: FEATURE ENGINEERING
   Project: Online Retail II SQL Analysis
   Goal: Create analysis-ready features from cleaned data
         to simplify downstream business analysis
   ========================================================= */


/* =========================================================
   1. CREATE FEATURE TABLE
   ========================================================= */

-- Create a new table with engineered features
-- This table extends the cleaned dataset with:
-- - revenue per transaction line
-- - extracted year and month for time-based analysis
CREATE TABLE retail_features AS
SELECT
    *,
    
    -- Revenue per row (core business metric)
    quantity * unitprice AS revenue,
    
    -- Extract year from invoice date (for yearly analysis)
    EXTRACT(YEAR FROM invoicedate) AS invoice_year,
    
    -- Extract month from invoice date (for monthly analysis)
    EXTRACT(MONTH FROM invoicedate) AS invoice_month

FROM retail_clean;


/* =========================================================
   2. VALIDATION CHECKS
   ========================================================= */

-- Preview data to confirm new columns are created correctly
SELECT *
FROM retail_features
LIMIT 10;

-- Validate row count matches cleaned dataset
SELECT COUNT(*) AS feature_row_count
FROM retail_features;


/* =========================================================
   3. OPTIONAL CHECKS (DATA SANITY)
   ========================================================= */

-- Check revenue distribution (min, max, average)
SELECT
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue,
    AVG(revenue) AS avg_revenue
FROM retail_features;

-- Verify extracted date components
SELECT
    MIN(invoice_year) AS min_year,
    MAX(invoice_year) AS max_year,
    MIN(invoice_month) AS min_month,
    MAX(invoice_month) AS max_month
FROM retail_features;


SELECT *
FROM retail_features
ORDER BY revenue DESC
LIMIT 10;