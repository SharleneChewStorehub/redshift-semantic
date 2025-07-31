-- Data Profiling Queries to Enhance Semantic Layer v2
-- Run these to understand actual data patterns

-- ============================================
-- 1. BUSINESS ENTITY PROFILING
-- ============================================

-- Business Status Values
SELECT 
    'Business Status Distribution' as analysis_type,
    status,
    businessstatus,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM storehub_mongo.businesses
GROUP BY status, businessstatus
ORDER BY count DESC;

-- Business Types Actually Used
SELECT 
    'Business Types' as analysis_type,
    businesstype,
    COUNT(*) as merchant_count,
    COUNT(DISTINCT country) as countries_present
FROM storehub_mongo.businesses
WHERE businesstype IS NOT NULL
GROUP BY businesstype
ORDER BY merchant_count DESC
LIMIT 50;

-- Country Values and Formats
SELECT 
    'Country Formats' as analysis_type,
    country,
    LENGTH(country) as length,
    COUNT(*) as count
FROM storehub_mongo.businesses
GROUP BY country, LENGTH(country)
ORDER BY count DESC;

-- ============================================
-- 2. PRODUCT CATALOG PROFILING
-- ============================================

-- Product Categories Distribution
SELECT 
    'Product Categories' as analysis_type,
    category,
    COUNT(*) as product_count,
    COUNT(DISTINCT business) as merchant_count,
    AVG(CAST(sellingprice AS DECIMAL(10,2))) as avg_price
FROM storehub_mongo.products
WHERE isdeleted != true
GROUP BY category
ORDER BY product_count DESC
LIMIT 100;

-- Title vs OnlineTitle Usage
SELECT 
    'Title Fields Usage' as analysis_type,
    CASE 
        WHEN title IS NULL AND onlinetitle IS NULL THEN 'Both NULL'
        WHEN title IS NOT NULL AND onlinetitle IS NULL THEN 'Only title'
        WHEN title IS NULL AND onlinetitle IS NOT NULL THEN 'Only onlinetitle'
        WHEN title = onlinetitle THEN 'Same value'
        ELSE 'Different values'
    END as title_pattern,
    COUNT(*) as count
FROM storehub_mongo.products
GROUP BY title_pattern;

-- Common Product Name Patterns
SELECT 
    'Product Name Patterns' as analysis_type,
    CASE 
        WHEN LOWER(title) LIKE '%rokok%' THEN 'Cigarette (Malay)'
        WHEN LOWER(title) LIKE '%cigarette%' THEN 'Cigarette (English)'
        WHEN LOWER(title) LIKE '%beer%' OR LOWER(title) LIKE '%bir%' THEN 'Beer'
        WHEN LOWER(title) LIKE '%wine%' THEN 'Wine'
        WHEN LOWER(title) LIKE '%drink%' OR LOWER(title) LIKE '%minuman%' THEN 'Beverages'
        WHEN LOWER(title) LIKE '%food%' OR LOWER(title) LIKE '%makanan%' THEN 'Food'
        ELSE 'Other'
    END as product_type,
    COUNT(*) as count
FROM storehub_mongo.products
WHERE isdeleted != true
GROUP BY product_type
ORDER BY count DESC;

-- ============================================
-- 3. TRANSACTION PATTERNS
-- ============================================

-- Transaction Types Distribution
SELECT 
    'Transaction Types' as analysis_type,
    type,
    COUNT(*) as transaction_count,
    SUM(totalamount) as total_value,
    AVG(totalamount) as avg_value
FROM storehub_mongo.transactionrecords
WHERE createdtime >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY type;

-- Payment Methods Used
SELECT 
    'Payment Methods' as analysis_type,
    paymentmethod,
    COUNT(*) as usage_count,
    SUM(totalamount) as total_processed
FROM storehub_mongo.transactionrecords
WHERE type = 'Sale'
  AND createdtime >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY paymentmethod
ORDER BY usage_count DESC;

-- ============================================
-- 4. RELATIONSHIP VALIDATION
-- ============================================

-- Business to Products Join Success Rate
SELECT 
    'Join Success Rate' as analysis_type,
    CASE 
        WHEN b._id IS NOT NULL THEN 'Matched'
        ELSE 'Orphaned Product'
    END as join_status,
    COUNT(*) as count
FROM storehub_mongo.products p
LEFT JOIN storehub_mongo.businesses b ON p.business = b._id
GROUP BY join_status;

-- Transaction to Customer Join Rate
SELECT 
    'Customer Match Rate' as analysis_type,
    CASE 
        WHEN customerid IS NULL THEN 'Anonymous'
        WHEN c._id IS NOT NULL THEN 'Known Customer'
        ELSE 'Invalid Customer ID'
    END as customer_status,
    COUNT(*) as transaction_count
FROM storehub_mongo.transactionrecords t
LEFT JOIN storehub_mongo.customers c ON t.customerid = c._id
WHERE t.type = 'Sale'
  AND t.createdtime >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY customer_status;

-- ============================================
-- 5. DATA QUALITY INSIGHTS
-- ============================================

-- NULL Values Analysis
SELECT 
    'Products NULL Analysis' as analysis_type,
    COUNT(*) as total_records,
    COUNT(title) as has_title,
    COUNT(category) as has_category,
    COUNT(skunumber) as has_sku,
    COUNT(sellingprice) as has_price,
    COUNT(business) as has_business_ref
FROM storehub_mongo.products
WHERE isdeleted != true;

-- Duplicate Detection
SELECT 
    'Potential Duplicate Products' as analysis_type,
    title,
    business,
    COUNT(*) as duplicate_count
FROM storehub_mongo.products
WHERE isdeleted != true
  AND title IS NOT NULL
GROUP BY title, business
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
LIMIT 20;

-- ============================================
-- 6. TEMPORAL PATTERNS
-- ============================================

-- Business Hours Analysis
SELECT 
    'Peak Hours' as analysis_type,
    EXTRACT(hour FROM createdtime) as hour_of_day,
    COUNT(*) as transaction_count,
    AVG(totalamount) as avg_transaction_value
FROM storehub_mongo.transactionrecords
WHERE type = 'Sale'
  AND createdtime >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- ============================================
-- 7. EDGE CASES AND ANOMALIES
-- ============================================

-- Unusual Business Types
SELECT 
    'Edge Case Business Types' as analysis_type,
    businesstype,
    COUNT(*) as count
FROM storehub_mongo.businesses
WHERE businesstype IS NOT NULL
  AND LENGTH(businesstype) > 50
   OR businesstype LIKE '%test%'
   OR businesstype LIKE '%TEST%'
GROUP BY businesstype;

-- Unusual Price Points
SELECT 
    'Price Anomalies' as analysis_type,
    CASE 
        WHEN sellingprice < 0 THEN 'Negative Price'
        WHEN sellingprice = 0 THEN 'Free Item'
        WHEN sellingprice > 10000 THEN 'Very High Price'
        WHEN sellingprice BETWEEN 0.01 AND 0.99 THEN 'Under 1 unit'
        ELSE 'Normal Range'
    END as price_category,
    COUNT(*) as product_count
FROM storehub_mongo.products
WHERE isdeleted != true
GROUP BY price_category;