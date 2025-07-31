-- FULLY VALIDATED Query using schema validation tools
-- Complete query with all cigarette keywords

WITH cigarette_analysis AS (
    SELECT
        b._id,
        b.name as merchant_name,
        b.businesstype,
        COUNT(DISTINCT p._id) as cigarette_product_count,
        STRING_AGG(DISTINCT p.title, ', ') as cigarette_products
    FROM
        storehub_mongo.businesses b
        INNER JOIN storehub_mongo.products p ON b._id = p.business
    WHERE
        b.country = 'Malaysia'
        -- Note: businesses.isdeleted column does not exist (validated)
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
    COUNT(DISTINCT businesstype) as unique_business_types,
    STRING_AGG(DISTINCT businesstype, ', ') as business_types
FROM
    cigarette_analysis;