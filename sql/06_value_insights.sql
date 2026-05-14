WITH customer_revenue AS (
    -- Step 1: Calculate total revenue per individual customer
    SELECT 
        customerid,
        SUM(revenue) AS total_revenue
    FROM retail_features
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
top_10 AS (
    -- Step 2: Isolate the top 10 customers by revenue
    SELECT 
        customerid,
        total_revenue
    FROM customer_revenue
    ORDER BY total_revenue DESC
    LIMIT 10
),
overall_revenue AS (
    -- Step 3: Calculate the grand total revenue across ALL customers
    SELECT 
        SUM(total_revenue) AS total_revenue
    FROM customer_revenue
)
-- Step 4: Final calculation
-- We use MAX(o.total_revenue) to satisfy SQL's requirement that all 
-- selected columns be aggregated when using SUM().
SELECT 
    ROUND(SUM(t.total_revenue), 2) AS top_10_revenue,
    ROUND((SUM(t.total_revenue) / MAX(o.total_revenue)) * 100, 2) AS top_10_percentage
FROM top_10 as t
CROSS JOIN overall_revenue as o;









WITH customer_orders AS (
    SELECT 
        customerid,
        COUNT(DISTINCT invoiceno) AS order_count
    FROM retail_features
    WHERE customerid IS NOT NULL
      -- Optional: Ensure we only count positive transactions
      AND quantity > 0 
      AND unitprice > 0
    GROUP BY customerid
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS number_of_customers,
    -- Added: Percentage of total base for better insight
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) || '%' AS pct_of_total
FROM customer_orders
GROUP BY 1
ORDER BY 2 DESC;



/* =========================================================
   VALUE INSIGHT: REVENUE SHARE BY CUSTOMER TYPE
   Goal: Compare the financial impact of One-time vs. Repeat buyers.
   ========================================================= */

WITH customer_counts AS (
    -- Step 1: Determine the frequency of orders for every customer
    SELECT 
        customerid,
        COUNT(DISTINCT invoiceno) AS total_customer_orders,
        SUM(revenue) AS total_customer_revenue
    FROM retail_features
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
classified_customers AS (
    -- Step 2: Assign the 'Type' based on the order count
    SELECT 
        total_customer_revenue,
        CASE 
            WHEN total_customer_orders = 1 THEN 'One-time'
            ELSE 'Repeat'
        END AS customer_type
    FROM customer_counts
),
summary_totals AS (
    -- Step 3: Sum the revenue per type
    SELECT 
        customer_type,
        SUM(total_customer_revenue) AS segment_revenue
    FROM classified_customers
    GROUP BY customer_type
)
-- Step 4: Final output with percentage calculation
SELECT 
    customer_type,
    ROUND(segment_revenue, 2) AS total_revenue,
    -- Calculate percentage by dividing segment by the sum of all segments
    ROUND(
        segment_revenue * 100.0 / (SELECT SUM(segment_revenue) FROM summary_totals), 
        2
    ) AS pct_of_total_revenue
FROM summary_totals
ORDER BY total_revenue DESC;

/* =========================================================
   VALUE INSIGHT: AVERAGE CUSTOMER VALUE (ARPU)
   Goal: Calculate the average total revenue per customer.
   ========================================================= */

WITH customer_revenue AS (
    -- Step 1: Aggregate revenue to the customer level
    SELECT
        customerid,
        SUM(revenue) AS total_revenue
    FROM retail_features
    WHERE customerid IS NOT NULL 
    GROUP BY customerid
)
-- Step 2: Calculate the average from the CTE above
SELECT
    ROUND(AVG(total_revenue), 2) AS avg_customer_revenue,
    COUNT(customerid) AS total_customer_count,
    ROUND(SUM(total_revenue), 2) AS total_revenue_base
FROM customer_revenue;



/* =========================================================
   VALUE INSIGHT: CUSTOMER VALUE DISTRIBUTION (PARETO)
   Goal: Identify revenue concentration across customer quintiles.
   ========================================================= */

WITH customer_revenue AS (
    -- Step 1: Calculate total spend per customer
    SELECT
        customerid,
        SUM(revenue) AS total_revenue
    FROM retail_features
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
ranked_customers AS (
    -- Step 2: Divide customers into 5 equal groups (Quintiles)
    -- Note the comma above after the closing parenthesis!
    SELECT
        total_revenue,
        NTILE(5) OVER (ORDER BY total_revenue DESC) AS quintile
    FROM customer_revenue
),
segmented_data AS (
    -- Step 3: Label buckets for readability
    SELECT
        total_revenue,
        CASE
            WHEN quintile = 1 THEN 'Top 20% (Whales)'
            WHEN quintile = 5 THEN 'Bottom 20% (Minnows)'
            ELSE 'Middle 60%'
        END AS segment
    FROM ranked_customers
)
-- Step 4: Final Summary
-- There is NO semicolon before this SELECT and NO comma after Step 3.
SELECT
    segment,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(
        SUM(total_revenue) * 100.0 / SUM(SUM(total_revenue)) OVER(), 
        2
    ) AS pct_of_total_revenue
FROM segmented_data
GROUP BY segment
ORDER BY total_revenue DESC;

