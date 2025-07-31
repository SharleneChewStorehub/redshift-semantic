-- DEBUG: Check join fields and data issues

-- 1. Check if businesses._id has any data
SELECT COUNT(*) as total_businesses, 
       COUNT(_id) as non_null_ids,
       COUNT(DISTINCT _id) as unique_ids
FROM storehub_mongo.businesses
WHERE country = 'Malaysia';

-- 2. Check if products.business has matching values
SELECT COUNT(*) as total_products,
       COUNT(business) as non_null_business,
       COUNT(DISTINCT business) as unique_businesses
FROM storehub_mongo.products
WHERE isdeleted != true;

-- 3. Check if any businesses._id match products.business
SELECT COUNT(*) as matching_records
FROM storehub_mongo.businesses b
WHERE EXISTS (
    SELECT 1 
    FROM storehub_mongo.products p 
    WHERE p.business = b._id
);

-- 4. Sample the actual values to see format
SELECT 'Business ID Sample' as type, _id as value
FROM storehub_mongo.businesses
WHERE country = 'Malaysia'
LIMIT 5
UNION ALL
SELECT 'Product Business Sample' as type, business as value
FROM storehub_mongo.products
WHERE business IS NOT NULL
LIMIT 5;

-- 5. Try different join approaches
-- Option A: Direct string match
SELECT COUNT(*) as join_method_a
FROM storehub_mongo.businesses b
INNER JOIN storehub_mongo.products p ON b._id = p.business
WHERE b.country = 'Malaysia';

-- Option B: Case-insensitive match
SELECT COUNT(*) as join_method_b
FROM storehub_mongo.businesses b
INNER JOIN storehub_mongo.products p ON LOWER(b._id) = LOWER(p.business)
WHERE b.country = 'Malaysia';

-- 6. Check country values more carefully
SELECT DISTINCT 
    country,
    LENGTH(country) as country_length,
    ASCII(SUBSTRING(country, 1, 1)) as first_char_ascii,
    COUNT(*) as count
FROM storehub_mongo.businesses
WHERE country LIKE '%alay%' 
   OR country LIKE 'M%'
   OR country = 'MY'
   OR country = 'Malaysia'
GROUP BY country, LENGTH(country), ASCII(SUBSTRING(country, 1, 1))
ORDER BY count DESC;

-- 7. Find ANY cigarette products regardless of country
SELECT 
    p.title,
    p.business as product_business_id,
    b._id as business_id,
    b.country,
    b.name
FROM storehub_mongo.products p
LEFT JOIN storehub_mongo.businesses b ON p.business = b._id
WHERE p.isdeleted != true
  AND LOWER(p.title) LIKE '%rokok%'
LIMIT 10;