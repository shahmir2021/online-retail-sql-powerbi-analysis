/* =========================================================
   STAGE 5: BUSINESS ANALYSIS
   Project: Online Retail II SQL Analysis
   Goal: Answer key business questions using the
         feature-engineered dataset
   ========================================================= */


/* =========================================================
   1. TOTAL REVENUE
   ========================================================= */

-- Calculate total revenue across all valid transactions
SELECT 
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features;


/* =========================================================
   2. REVENUE OVER TIME (YEARLY)
   ========================================================= */

-- Calculate yearly revenue
-- Note:
-- 2010 and 2013 are partial years and should not be compared
-- directly with full-year periods
SELECT 
    invoice_year,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
GROUP BY invoice_year
ORDER BY invoice_year;


/* =========================================================
   3. REVENUE OVER TIME (MONTHLY)
   ========================================================= */

-- Calculate monthly revenue within each year
SELECT 
    invoice_year,
    invoice_month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
GROUP BY 
    invoice_year,
    invoice_month
ORDER BY 
    invoice_year,
    invoice_month;


/* =========================================================
   4. DATA PREVIEW
   ========================================================= */

-- Preview feature-engineered dataset
SELECT *
FROM retail_features
LIMIT 10;


/* =========================================================
   5. TOP REVENUE-GENERATING PRODUCTS
   ========================================================= */

-- Identify top products by revenue
SELECT 
    description,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;


/* =========================================================
   6. TOP REVENUE-GENERATING PRODUCTS (EXCLUDING NON-PRODUCTS)
   ========================================================= */

-- Remove non-product entries such as postage and manual charges
-- to focus on actual merchandise performance
SELECT 
    description,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
WHERE description NOT ILIKE '%postage%'
  AND description NOT ILIKE '%manual%'
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;


/* =========================================================
   7. TOP COUNTRIES BY REVENUE
   ========================================================= */

-- Identify countries contributing the highest revenue
SELECT 
    country,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;


/* =========================================================
   8. TOP CUSTOMERS BY REVENUE
   ========================================================= */

-- Identify highest-value customers
-- Exclude NULL customer IDs because customer-level analysis
-- requires identifiable customers
SELECT 
    customerid,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_features
WHERE customerid IS NOT NULL
GROUP BY customerid
ORDER BY total_revenue DESC
LIMIT 10;



