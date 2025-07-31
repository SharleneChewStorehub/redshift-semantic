-- Schema-Validated Query for Malaysian Merchants with Cigarette Products
-- Validated against storehub-table1.sql and storehub-table2.sql

WITH cigarette_analysis AS (
    SELECT
        b._id,
        b.name as merchant_name,
        b.businesstype,
        b.status,  -- Including status since there's no isdeleted column
        COUNT(DISTINCT p._id) as cigarette_product_count,
        STRING_AGG(DISTINCT p.title, ', ') as cigarette_products
    FROM
        storehub_mongo.businesses b
        INNER JOIN storehub_mongo.products p ON b._id = p.business
    WHERE
        b.country = 'Malaysia'
        -- Note: businesses table doesn't have isdeleted column
        -- You may want to filter by status or businessstatus instead
        -- AND b.status = 'active'  -- Uncomment if needed
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
        b._id, b.name, b.businesstype, b.status
)
SELECT
    COUNT(DISTINCT _id) as total_merchants_with_cigarettes,
    SUM(cigarette_product_count) as total_cigarette_products,
    COUNT(DISTINCT businesstype) as unique_business_types,
    STRING_AGG(DISTINCT businesstype, ', ') as business_types
FROM
    cigarette_analysis;

-- Alternative query if you need to filter active businesses
-- Uncomment and modify based on actual status values in your data
/*
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
        AND b.businessstatus IN ('live', 'active')  -- Adjust based on actual values
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
*/