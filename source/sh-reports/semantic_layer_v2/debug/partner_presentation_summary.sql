-- PARTNER PRESENTATION SUMMARY QUERY
-- Optimized for P&G and British American Tobacco partnership discussions
-- Built using semantic_layer_v2 patterns

-- =============================================================================
-- EXECUTIVE SUMMARY FOR PARTNER PRESENTATION
-- =============================================================================

-- Quick Summary Metrics
WITH summary_metrics AS (
    SELECT 
        'Total Malaysian Retail Merchants' as metric,
        COUNT(*) as count,
        'Active retail businesses in Malaysia using StoreHub' as description
    FROM storehub_mongo.businesses b
    WHERE b.country = 'MY'
        AND LOWER(b.businesstype) IN ('retail', 'Retail')
        AND (b.subscriptionstatus IS NULL OR b.subscriptionstatus != 'Expired')
        AND (b.isdeleted IS NULL OR b.isdeleted != true)
        AND b.business = :business_id  -- Business isolation

    UNION ALL

    SELECT 
        'Merchants with Tobacco/Cigarette Products' as metric,
        COUNT(DISTINCT p.business) as count,
        'Merchants selling cigarette/tobacco products (potential partners)' as description
    FROM storehub_mongo.businesses b
    JOIN storehub_mongo.products p ON b.business = p.business
    WHERE b.country = 'MY'
        AND LOWER(b.businesstype) IN ('retail', 'Retail')
        AND (b.subscriptionstatus IS NULL OR b.subscriptionstatus != 'Expired')
        AND (b.isdeleted IS NULL OR b.isdeleted != true)
        AND (p.isdeleted IS NULL OR p.isdeleted != true)
        AND b.business = :business_id  -- Business isolation
        AND (
            -- High confidence brand detection
            LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament|555|lucky strike' OR
            -- Generic cigarette terms
            LOWER(p.title) ~ 'cigarette|cigar|tobacco|rokok|sigaret' OR
            -- Category-based detection
            LOWER(p.category) ~ 'cigarette|tobacco|smoking|rokok' OR
            -- Tag-based detection
            LOWER(p.tags) ~ 'cigarette|tobacco|smoking'
        )

    UNION ALL

    SELECT 
        'High-Confidence Tobacco Merchants' as metric,
        COUNT(DISTINCT p.business) as count,
        'Merchants with confirmed brand-name tobacco products' as description
    FROM storehub_mongo.businesses b
    JOIN storehub_mongo.products p ON b.business = p.business
    WHERE b.country = 'MY'
        AND LOWER(b.businesstype) IN ('retail', 'Retail')
        AND (b.subscriptionstatus IS NULL OR b.subscriptionstatus != 'Expired')
        AND (b.isdeleted IS NULL OR b.isdeleted != true)
        AND (p.isdeleted IS NULL OR p.isdeleted != true)
        AND b.business = :business_id  -- Business isolation
        AND LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament|555|lucky strike|mild seven'

    UNION ALL

    SELECT 
        'Total Tobacco Products Listed' as metric,
        COUNT(*) as count,
        'Individual tobacco/cigarette SKUs in system' as description
    FROM storehub_mongo.businesses b
    JOIN storehub_mongo.products p ON b.business = p.business
    WHERE b.country = 'MY'
        AND LOWER(b.businesstype) IN ('retail', 'Retail')
        AND (b.subscriptionstatus IS NULL OR b.subscriptionstatus != 'Expired')
        AND (b.isdeleted IS NULL OR b.isdeleted != true)
        AND (p.isdeleted IS NULL OR p.isdeleted != true)
        AND b.business = :business_id  -- Business isolation
        AND (
            LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament|555|lucky strike|cigarette|cigar|tobacco|rokok|sigaret' OR
            LOWER(p.category) ~ 'cigarette|tobacco|smoking|rokok' OR
            LOWER(p.tags) ~ 'cigarette|tobacco|smoking'
        )
)

-- Present summary for partners
SELECT 
    metric,
    count,
    description,
    -- Calculate percentages where relevant
    CASE 
        WHEN metric = 'Merchants with Tobacco/Cigarette Products' THEN
            ROUND(100.0 * count / FIRST_VALUE(count) OVER (ORDER BY metric), 2)
        WHEN metric = 'High-Confidence Tobacco Merchants' THEN
            ROUND(100.0 * count / FIRST_VALUE(count) OVER (ORDER BY metric), 2)
        ELSE NULL
    END as percentage_of_total
FROM summary_metrics
ORDER BY 
    CASE metric
        WHEN 'Total Malaysian Retail Merchants' THEN 1
        WHEN 'Merchants with Tobacco/Cigarette Products' THEN 2
        WHEN 'High-Confidence Tobacco Merchants' THEN 3
        WHEN 'Total Tobacco Products Listed' THEN 4
    END;

-- =============================================================================
-- PARTNER VALUE PROPOSITION DATA
-- =============================================================================

-- Sample of high-value tobacco merchants for partner discussions
SELECT 
    'SAMPLE_TOBACCO_MERCHANTS' as data_type,
    b.name as merchant_name,
    b.business as merchant_id,
    COUNT(DISTINCT p._id) as tobacco_product_count,
    STRING_AGG(
        DISTINCT 
        CASE 
            WHEN LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem' 
            THEN p.title 
        END, 
        ', '
    ) as sample_brand_products,
    -- Indicate readiness for stock monitoring integration
    'Ready for stock monitoring integration' as integration_status
FROM storehub_mongo.businesses b
JOIN storehub_mongo.products p ON b.business = p.business
WHERE b.country = 'MY'
    AND LOWER(b.businesstype) IN ('retail', 'Retail')
    AND (b.subscriptionstatus IS NULL OR b.subscriptionstatus != 'Expired')
    AND (b.isdeleted IS NULL OR b.isdeleted != true)
    AND (p.isdeleted IS NULL OR p.isdeleted != true)
    AND b.business = :business_id  -- Business isolation
    AND (
        LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament|cigarette|cigar|tobacco|rokok' OR
        LOWER(p.category) ~ 'cigarette|tobacco|smoking' OR
        LOWER(p.tags) ~ 'cigarette|tobacco|smoking'
    )
GROUP BY b.name, b.business
HAVING COUNT(DISTINCT p._id) >= 1
ORDER BY tobacco_product_count DESC
LIMIT 10;

-- =============================================================================
-- BUSINESS CASE METRICS
-- =============================================================================

-- Additional metrics for business case development
SELECT 
    'BUSINESS_OPPORTUNITY' as metric_type,
    'Malaysian Retail Market Size' as metric,
    COUNT(*) as value,
    'Total addressable market for POS partnerships' as insight
FROM storehub_mongo.businesses b
WHERE b.country = 'MY'
    AND LOWER(b.businesstype) IN ('retail', 'Retail')
    AND b.business = :business_id

UNION ALL

SELECT 
    'BUSINESS_OPPORTUNITY' as metric_type,
    'Active StoreHub Merchants' as metric,
    COUNT(*) as value,
    'Currently active merchant base for immediate partnership' as insight
FROM storehub_mongo.businesses b
WHERE b.country = 'MY'
    AND LOWER(b.businesstype) IN ('retail', 'Retail')
    AND b.subscriptionstatus = 'Active'
    AND b.business = :business_id

UNION ALL

SELECT 
    'BUSINESS_OPPORTUNITY' as metric_type,
    'Inventory Management Capability' as metric,
    COUNT(DISTINCT i.business) as value,
    'Merchants already using inventory tracking (ready for stock alerts)' as insight
FROM storehub_mongo.inventories i
JOIN storehub_mongo.businesses b ON i.business = b.business
WHERE b.country = 'MY'
    AND LOWER(b.businesstype) IN ('retail', 'Retail')
    AND b.business = :business_id;

-- =============================================================================
-- USAGE INSTRUCTIONS
-- =============================================================================
/*
PARTNER PRESENTATION TALKING POINTS:

1. MARKET SIZE: 
   - X Malaysian retail merchants using StoreHub
   - Y% already sell tobacco/cigarette products
   - Z merchants with confirmed brand products

2. PARTNERSHIP VALUE:
   - Immediate access to active merchant base
   - Real-time inventory tracking capability
   - Merchants already using digital POS systems

3. IMPLEMENTATION:
   - Stock level monitoring through existing inventory system
   - Automated alerts when tobacco products run low
   - Partner brand preference recommendations

4. MUTUAL BENEFITS:
   - Partners: Increased sales through better stock management
   - StoreHub: Enhanced value proposition for merchants
   - Merchants: Optimized inventory, reduced stockouts

TECHNICAL CAPABILITIES:
- Real-time inventory tracking
- Automated stock level alerts
- Product-specific monitoring
- Multi-brand support
- Merchant segmentation by product portfolio

Replace :business_id with actual business context before execution.
*/