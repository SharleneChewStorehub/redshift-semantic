-- Query to get MRR/ARR and number of stores for lekmassage and withitstore
-- Author: Claude
-- Created: 2025-07-18
-- Updated: 2025-07-18 - Removed isdeleted check for businesses table (column doesn't exist)
-- Description: Retrieves Monthly Recurring Revenue (MRR), Annual Recurring Revenue (ARR), 
--              and store count for specified merchant accounts
-- Note: The businesses table does not have an isdeleted column. 
--       Use subscriptionstatus to filter active/inactive merchants if needed.

WITH business_metrics AS (
  SELECT 
    b._id AS business_id,
    b.name AS business_name,
    b.displaybusinessname AS display_name,
    b.mrr AS monthly_recurring_revenue,
    b.mrr * 12 AS annual_recurring_revenue,  -- ARR calculated as MRR * 12
    b.subscriptionstatus AS subscription_status,
    b.subscriptionstartdate AS subscription_start_date,
    b.subscriptionenddate AS subscription_end_date,
    b.businesstype AS business_type,
    b.country AS country,
    b.currency AS currency
  FROM storehub_mongo.businesses b
  WHERE 
    LOWER(b.name) IN ('lakmassage', 'withit')
),
store_counts AS (
  SELECT 
    bs.businesses_foreignkey AS business_id,
    COUNT(DISTINCT bs._id) AS number_of_stores
  FROM storehub_mongo.businesses__stores bs
  WHERE 
    -- Only count active stores
    (bs.isdeleted IS NULL OR bs.isdeleted != true)
  GROUP BY bs.businesses_foreignkey
)
SELECT 
  bm.business_name,
  bm.display_name,
  bm.monthly_recurring_revenue AS mrr,
  bm.annual_recurring_revenue AS arr,
  COALESCE(sc.number_of_stores, 0) AS number_of_stores,
  bm.subscription_status,
  bm.subscription_start_date,
  bm.subscription_end_date,
  bm.business_type,
  bm.country,
  bm.currency
FROM business_metrics bm
LEFT JOIN store_counts sc ON bm.business_id = sc.business_id
ORDER BY bm.business_name;