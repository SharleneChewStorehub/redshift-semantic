-- DEBUGGING: Why are we getting 0 results?

-- Step 1: Check if we have Malaysian businesses at all
SELECT COUNT(DISTINCT _id) as total_malaysian_businesses
FROM storehub_mongo.businesses
WHERE country = 'Malaysia';

-- Step 2: Check what country values actually exist (case sensitivity?)
SELECT DISTINCT country, COUNT(*) as count
FROM storehub_mongo.businesses
WHERE country LIKE '%malay%' OR country LIKE '%Malay%' OR country LIKE '%MY%' OR country LIKE '%my%'
GROUP BY country
ORDER BY count DESC
LIMIT 20;

-- Step 3: Check if products table has data
SELECT COUNT(*) as total_products
FROM storehub_mongo.products
WHERE isdeleted != true
LIMIT 10;

-- Step 4: Check if join works at all
SELECT COUNT(*) as joined_records
FROM storehub_mongo.businesses b
INNER JOIN storehub_mongo.products p ON b._id = p.business
WHERE b.country = 'Malaysia'
LIMIT 10;

-- Step 5: Look for ANY tobacco/cigarette products (without country filter)
SELECT p.title, b.country, b.name
FROM storehub_mongo.products p
INNER JOIN storehub_mongo.businesses b ON p.business = b._id
WHERE p.isdeleted != true
  AND (
    LOWER(p.title) LIKE '%cigarette%'
    OR LOWER(p.title) LIKE '%rokok%'
    OR LOWER(p.title) LIKE '%tobacco%'
  )
LIMIT 20;

-- Step 6: Check exact country values in businesses with products
SELECT DISTINCT b.country, COUNT(DISTINCT b._id) as business_count
FROM storehub_mongo.businesses b
INNER JOIN storehub_mongo.products p ON b._id = p.business
GROUP BY b.country
ORDER BY business_count DESC
LIMIT 20;

-- Step 7: Sample product titles to see naming patterns
SELECT DISTINCT p.title
FROM storehub_mongo.products p
INNER JOIN storehub_mongo.businesses b ON p.business = b._id
WHERE b.country IN ('Malaysia', 'MY', 'malaysia', 'MALAYSIA')
  AND p.isdeleted != true
  AND (
    LOWER(p.title) LIKE '%smoke%'
    OR LOWER(p.title) LIKE '%cig%'
    OR LOWER(p.title) LIKE '%tob%'
    OR p.title LIKE '%20%' -- Common in cigarette names like "Marlboro 20s"
    OR p.title LIKE '%king%'
    OR p.title LIKE '%light%'
  )
LIMIT 50;