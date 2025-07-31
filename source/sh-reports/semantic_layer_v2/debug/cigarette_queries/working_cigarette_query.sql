-- WORKING Query - Fixed for Redshift/older PostgreSQL
-- Removed STRING_AGG with DISTINCT which is not supported

WITH cigarette_analysis AS (
    SELECT
        b._id,
        b.name as merchant_name,
        b.businesstype,
        COUNT(DISTINCT p._id) as cigarette_product_count
    FROM
        storehub_mongo.businesses b
        INNER JOIN storehub_mongo.products p ON b._id = p.business
    WHERE
        b.country = 'Malaysia'
        AND p.isdeleted != true
        AND (
            LOWER(p.title) LIKE '%cigarette%'
            OR LOWER(p.title) LIKE '%rokok%'
            OR LOWER(p.title) LIKE '%tobacco%'
            OR LOWER(p.title) LIKE '%marlboro%'
            OR LOWER(p.title) LIKE '%dunhill%'
            OR LOWER(p.title) LIKE '%winston%'
            OR LOWER(p.title) LIKE '%camel%'
            OR LOWER(p.title) LIKE '%salem%'
            OR LOWER(p.title) LIKE '%gudang garam%'
            OR LOWER(p.title) LIKE '%sampoerna%'
        )
    GROUP BY
        b._id, b.name, b.businesstype
)
SELECT
    COUNT(DISTINCT _id) as total_merchants_with_cigarettes,
    SUM(cigarette_product_count) as total_cigarette_products,
    COUNT(DISTINCT businesstype) as unique_business_types
FROM
    cigarette_analysis;

-- If you need to see the business types, run this separately:
/*
SELECT DISTINCT businesstype, COUNT(*) as merchant_count
FROM (
    SELECT DISTINCT b._id, b.businesstype
    FROM storehub_mongo.businesses b
    INNER JOIN storehub_mongo.products p ON b._id = p.business
    WHERE b.country = 'Malaysia'
        AND p.isdeleted != true
        AND (
            LOWER(p.title) LIKE '%cigarette%'
            OR LOWER(p.title) LIKE '%rokok%'
            OR LOWER(p.title) LIKE '%tobacco%'
            OR LOWER(p.title) LIKE '%marlboro%'
            OR LOWER(p.title) LIKE '%dunhill%'
            OR LOWER(p.title) LIKE '%winston%'
            OR LOWER(p.title) LIKE '%camel%'
            OR LOWER(p.title) LIKE '%salem%'
            OR LOWER(p.title) LIKE '%gudang garam%'
            OR LOWER(p.title) LIKE '%sampoerna%'
        )
) cigarette_merchants
GROUP BY businesstype
ORDER BY merchant_count DESC;
*/