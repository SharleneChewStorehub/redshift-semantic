-- Monthly Sales Report for merchant: nasikukusnkb
-- Period: February 2023 to August 2023
-- Generated using StoreHub Reports API Semantic Layer v2
-- FINAL VERSION: Corrected all column names based on actual schema

-- Step 1: Get merchant info by matching business name or _id
WITH merchant_info AS (
  SELECT 
    b._id as business_id,
    b.name as business_name,
    COALESCE(b.timezone, 'Asia/Kuala_Lumpur') as timezone
  FROM storehub_mongo.businesses b
  WHERE b.name = 'nasikukusnkb' 
     OR b._id = 'nasikukusnkb'
  LIMIT 1
),

-- Step 2: Calculate monthly sales metrics
monthly_sales AS (
  SELECT 
    DATE_TRUNC('month', CONVERT_TIMEZONE(mi.timezone, 'UTC', tr.createdtime)) as sales_month,
    
    -- Gross Sales (before any deductions)
    -- Note: Need to verify what values transactiontype contains
    SUM(CASE WHEN tr.transactiontype = 'Sale' THEN tr.subtotal ELSE 0 END) as gross_sales,
    
    -- Returns (check if transactiontype = 'Return' or use returnstatus)
    SUM(CASE 
      WHEN tr.transactiontype = 'Return' THEN ABS(tr.subtotal)
      WHEN tr.returnstatus IS NOT NULL AND tr.returnstatus != '' THEN ABS(tr.subtotal) 
      ELSE 0 
    END) as returns,
    
    -- Discounts applied
    SUM(CASE WHEN tr.transactiontype = 'Sale' THEN COALESCE(tr.discount, 0) ELSE 0 END) as total_discounts,
    
    -- Tax collected
    SUM(CASE WHEN tr.transactiontype = 'Sale' THEN COALESCE(tr.tax, 0) ELSE 0 END) as tax_collected,
    
    -- Net Sales (Gross - Returns - Discounts)
    SUM(CASE 
      WHEN tr.transactiontype = 'Sale' THEN tr.subtotal - COALESCE(tr.discount, 0)
      WHEN tr.transactiontype = 'Return' THEN -ABS(tr.subtotal)
      WHEN tr.returnstatus IS NOT NULL AND tr.returnstatus != '' THEN -ABS(tr.subtotal)
      ELSE 0 
    END) as net_sales,
    
    -- Total amount (including tax) - using 'total' column not 'totalamount'
    SUM(CASE 
      WHEN tr.transactiontype = 'Sale' THEN tr.total
      WHEN tr.transactiontype = 'Return' THEN -ABS(tr.total)
      WHEN tr.returnstatus IS NOT NULL AND tr.returnstatus != '' THEN -ABS(tr.total)
      ELSE 0 
    END) as total_revenue,
    
    -- Transaction counts
    COUNT(DISTINCT CASE WHEN tr.transactiontype = 'Sale' THEN tr.receiptnumber END) as sale_transactions,
    COUNT(DISTINCT CASE 
      WHEN tr.transactiontype = 'Return' THEN tr.receiptnumber 
      WHEN tr.returnstatus IS NOT NULL AND tr.returnstatus != '' THEN tr.receiptnumber
    END) as return_transactions,
    COUNT(DISTINCT tr.receiptnumber) as total_transactions,
    
    -- Customer metrics
    COUNT(DISTINCT CASE WHEN tr.transactiontype = 'Sale' AND tr.customerid IS NOT NULL THEN tr.customerid END) as unique_customers
    
  FROM storehub_mongo.transactionrecords tr
  CROSS JOIN merchant_info mi
  WHERE 
    -- MANDATORY: Multi-tenant isolation using business ID from merchant_info
    tr.business = mi.business_id
    
    -- Note: No isdeleted column in transactionrecords table
    -- Filter by date range: February 2023 to August 2023
    AND tr.createdtime >= '2023-02-01 00:00:00'
    AND tr.createdtime < '2023-09-01 00:00:00'
    
  GROUP BY 1
)

-- Step 3: Format and calculate derived metrics
SELECT 
  -- Date formatting
  TO_CHAR(sales_month, 'YYYY-MM') as month_code,
  TO_CHAR(sales_month, 'Month YYYY') as month_name,
  
  -- Sales metrics
  ROUND(gross_sales, 2) as gross_sales,
  ROUND(returns, 2) as returns,
  ROUND(total_discounts, 2) as discounts,
  ROUND(tax_collected, 2) as tax,
  ROUND(net_sales, 2) as net_sales,
  ROUND(total_revenue, 2) as total_revenue,
  
  -- Transaction metrics
  sale_transactions,
  return_transactions,
  total_transactions,
  unique_customers,
  
  -- Calculated metrics
  ROUND(net_sales / NULLIF(sale_transactions, 0), 2) as avg_transaction_value,
  ROUND(returns / NULLIF(gross_sales, 0) * 100, 2) as return_rate_percent,
  ROUND(total_discounts / NULLIF(gross_sales, 0) * 100, 2) as discount_rate_percent,
  ROUND(unique_customers::DECIMAL / NULLIF(sale_transactions, 0), 2) as customers_per_transaction

FROM monthly_sales
ORDER BY sales_month;

-- Notes:
-- 1. Column 'type' changed to 'transactiontype'
-- 2. Column 'totalamount' changed to 'total'
-- 3. Removed isdeleted filter (column doesn't exist in transactionrecords)
-- 4. Added handling for returns using both transactiontype and returnstatus
-- 5. You may need to verify the exact values in transactiontype column