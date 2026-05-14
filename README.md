# Online Retail SQL + Power BI Analysis

## Project Overview

This project analyzes transactional retail sales data using SQL and Power BI to uncover business insights related to revenue performance, customer behavior, product trends, and customer segmentation.

The project follows a complete end-to-end analytics workflow:
- Data cleaning
- Data transformation
- Feature engineering
- Exploratory SQL analysis
- Business insight generation
- Interactive dashboard development

The final Power BI dashboard was designed with a professional business intelligence reporting style and focuses on:
- Revenue performance
- Customer segmentation
- Pareto analysis
- Top-performing customers
- Geographic revenue analysis
- Product-level performance

---

# Tools Used

- PostgreSQL
- SQL
- Power BI
- DAX
- Git & GitHub

---

# Dataset

Dataset used:
- Online Retail II Dataset

The dataset contains transactional sales data from a UK-based online retail company between 2010 and 2013.

Main columns include:
- InvoiceNo
- StockCode
- Description
- Quantity
- InvoiceDate
- UnitPrice
- CustomerID
- Country

Dataset source:
- Kaggle

---

# Project Workflow

## 1. Data Cleaning

Performed using SQL.

Cleaning steps included:
- Removing null customer IDs
- Removing invalid quantities
- Removing negative revenue transactions
- Removing zero prices
- Removing duplicate rows
- Standardizing fields for analysis

---

## 2. Feature Engineering

Additional analytical features were created:
- Revenue column
- Invoice year
- Invoice month
- Customer-level revenue
- Customer segmentation fields

Example:
```sql
SELECT
    quantity * unitprice AS revenue
FROM retail_clean;
```

---

## 3. SQL Analysis

Business questions explored:
- Which products generate the highest revenue?
- Which countries contribute the most revenue?
- Who are the highest-value customers?
- How concentrated is customer revenue?
- What percentage of customers drive overall revenue?
- How does revenue change over time?

SQL techniques used:
- CTEs
- GROUP BY
- CASE WHEN
- Window functions
- Aggregate functions
- Date extraction
- Filtering and ranking

---

## 4. Power BI Dashboard

Created two interactive report pages:

### Retail Performance Overview
Includes:
- Total Revenue KPI
- Total Orders KPI
- Total Customers KPI
- Revenue Trend Over Time
- Top Products by Revenue
- Top Revenue-Generating Countries
- Repeat vs One-Time Customers

### Customer Value Analysis
Includes:
- Pareto customer segmentation
- Revenue concentration analysis
- Top customers by revenue
- High-value customer insights

---

# Dashboard Design

The dashboard was designed using:
- Consistent color palette
- Professional spacing and alignment
- Navigation tabs
- Rounded visual containers
- KPI-focused layout
- Executive-style business reporting design

Color theme:
- Background: Light grey
- Primary accent: Blue (#2563EB)

---

# Key Insights

## Revenue Concentration
A small percentage of customers generated the majority of total revenue, following the Pareto principle.

## Customer Behavior
Repeat customers contributed significantly more revenue compared to one-time customers.

## Geographic Analysis
The United Kingdom generated the highest overall revenue compared to other countries.

## Product Performance
A limited number of products accounted for a large share of total sales revenue.

---

# Repository Structure

```text
online-retail-sql-powerbi-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_setup.sql
│   ├── 02_data_understanding.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_feature_engineering.sql
│   ├── 05_analysis.sql
│   └── 06_value_insights.sql
│
├── powerbi/
│   └── online_retail_dashboard.pbix
│
├── images/
│   ├── retail_performance_overview.png
│   └── customer_value_analysis.png
│
└── data/
    └── README.md
```

---

# Dashboard Preview

## Retail Performance Overview

Add screenshot here.

## Customer Value Analysis

Add screenshot here.

---

# Skills Demonstrated

- SQL querying
- Data cleaning
- Feature engineering
- Business intelligence reporting
- Dashboard design
- Data storytelling
- DAX calculations
- Customer segmentation
- Pareto analysis
- GitHub project structuring

---

# Future Improvements

Potential future additions:
- RFM segmentation
- Customer lifetime value analysis
- Revenue forecasting
- Advanced DAX measures
- Drill-through reporting
- Dynamic tooltips
- Interactive filtering enhancements

---

# Author

Shahmir Ayub

GitHub:
https://github.com/shahmir2021
