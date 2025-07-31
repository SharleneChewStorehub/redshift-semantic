-- SQL Query for Malaysian Retail Merchants and Cigarette Products
-- Built using semantic_layer_v2 patterns and validation rules
-- Purpose: Partner presentation data for P&G, British American Tobacco partnerships

-- =============================================================================
-- MALAYSIAN RETAIL MERCHANTS WITH CIGARETTE PRODUCT IDENTIFICATION
-- =============================================================================

WITH malaysian_retail_merchants AS (
    -- Apply semantic layer business rules for merchant filtering
    SELECT 
        b.business,
        b.name as business_name,
        b.businesstype,
        b.country,
        b.subscriptionstatus
    FROM storehub_mongo.businesses b
    WHERE 
        -- Mandatory business isolation filter (semantic layer rule)
        b.business = :business_id
        -- Malaysia country filter (validated against value_mappings)
        AND b.country = 'MY'
        -- Retail business type filter (normalized from business_rules)
        AND LOWER(b.businesstype) IN ('retail', 'Retail')
        -- Active subscription filter (business rules)
        AND (b.subscriptionstatus IS NULL 
             OR b.subscriptionstatus != 'Expired')
        -- Soft delete exclusion (mandatory filter from business_rules)
        AND (b.isdeleted IS NULL OR b.isdeleted != true)
),

cigarette_product_detection AS (
    -- Product identification using semantic context patterns
    SELECT DISTINCT 
        p.business,
        p._id as product_id,
        p.title as product_name,
        p.category,
        p.tags,
        -- Confidence scoring for cigarette detection
        CASE 
            WHEN LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament' THEN 'HIGH'
            WHEN LOWER(p.title) ~ 'cigarette|cigar|tobacco|rokok|sigaret' THEN 'MEDIUM'
            WHEN LOWER(p.category) ~ 'cigarette|tobacco|smoking' THEN 'MEDIUM'
            WHEN LOWER(p.tags) ~ 'cigarette|tobacco|smoking' THEN 'LOW'
            ELSE 'NONE'
        END as detection_confidence
    FROM storehub_mongo.products p
    WHERE 
        -- Business isolation (mandatory filter)
        p.business = :business_id
        -- Soft delete exclusion
        AND (p.isdeleted IS NULL OR p.isdeleted != true)
        -- Cigarette detection patterns (comprehensive search)
        AND (
            -- Brand names (high confidence)
            LOWER(p.title) ~ 'marlboro|winston|dunhill|kent|salem|camel|parliament|555|lucky strike|mild seven' OR
            -- Generic terms (medium confidence)
            LOWER(p.title) ~ 'cigarette|cigar|tobacco|rokok|sigaret|smoking|tembakau' OR
            -- Category-based detection
            LOWER(p.category) ~ 'cigarette|tobacco|smoking|rokok' OR
            -- Tag-based detection
            LOWER(p.tags) ~ 'cigarette|tobacco|smoking|rokok'
        )
        -- Filter to merchants in our malaysian_retail_merchants set
        AND p.business IN (SELECT business FROM malaysian_retail_merchants)
),

merchant_cigarette_summary AS (
    -- Aggregate cigarette product data per merchant
    SELECT 
        cpd.business,
        COUNT(*) as total_cigarette_products,
        COUNT(CASE WHEN cpd.detection_confidence = 'HIGH' THEN 1 END) as high_confidence_products,
        COUNT(CASE WHEN cpd.detection_confidence = 'MEDIUM' THEN 1 END) as medium_confidence_products,
        COUNT(CASE WHEN cpd.detection_confidence = 'LOW' THEN 1 END) as low_confidence_products,
        STRING_AGG(
            DISTINCT cpd.product_name, 
            ', ' 
            ORDER BY cpd.product_name
        ) as sample_products
    FROM cigarette_product_detection cpd
    WHERE cpd.detection_confidence != 'NONE'
    GROUP BY cpd.business
),

final_results AS (
    -- Combine merchant and product data with semantic layer formatting
    SELECT 
        mrm.business as merchant_id,
        mrm.business_name,
        mrm.businesstype,
        mrm.country,
        mrm.subscriptionstatus,
        
        -- Cigarette product indicators
        CASE 
            WHEN mcs.business IS NOT NULL THEN 'YES'
            ELSE 'NO'
        END as has_cigarette_products,
        
        -- Product counts with confidence levels
        COALESCE(mcs.total_cigarette_products, 0) as total_cigarette_products,
        COALESCE(mcs.high_confidence_products, 0) as high_confidence_cigarette_products,
        COALESCE(mcs.medium_confidence_products, 0) as medium_confidence_cigarette_products,
        COALESCE(mcs.low_confidence_products, 0) as low_confidence_cigarette_products,
        
        -- Sample products for verification
        COALESCE(mcs.sample_products, 'None detected') as sample_cigarette_products,
        
        -- Classification for partner targeting
        CASE 
            WHEN mcs.high_confidence_products > 0 THEN 'PRIMARY_TARGET'
            WHEN mcs.medium_confidence_products > 0 THEN 'SECONDARY_TARGET'
            WHEN mcs.low_confidence_products > 0 THEN 'POTENTIAL_TARGET'
            ELSE 'NON_TARGET'
        END as partner_target_category
        
    FROM malaysian_retail_merchants mrm
    LEFT JOIN merchant_cigarette_summary mcs ON mrm.business = mcs.business
)

-- Main query results ordered for partner presentation
SELECT 
    -- Summary for presentation
    COUNT(*) as total_malaysian_retail_merchants,
    COUNT(CASE WHEN has_cigarette_products = 'YES' THEN 1 END) as merchants_with_cigarette_products,
    COUNT(CASE WHEN partner_target_category = 'PRIMARY_TARGET' THEN 1 END) as primary_targets,
    COUNT(CASE WHEN partner_target_category = 'SECONDARY_TARGET' THEN 1 END) as secondary_targets,
    COUNT(CASE WHEN partner_target_category = 'POTENTIAL_TARGET' THEN 1 END) as potential_targets,
    
    -- Percentages for presentation
    ROUND(
        100.0 * COUNT(CASE WHEN has_cigarette_products = 'YES' THEN 1 END) / 
        NULLIF(COUNT(*), 0), 
        2
    ) as percentage_with_cigarette_products
    
FROM final_results

UNION ALL

-- Detailed merchant list for further analysis
SELECT 
    merchant_id,
    business_name,
    businesstype,
    country,
    subscriptionstatus,
    has_cigarette_products,
    total_cigarette_products,
    high_confidence_cigarette_products,
    partner_target_category,
    sample_cigarette_products
FROM final_results
WHERE has_cigarette_products = 'YES'
ORDER BY 
    partner_target_category,
    total_cigarette_products DESC,
    business_name;

-- =============================================================================
-- USAGE NOTES FOR PRODUCTION
-- =============================================================================

-- 1. Replace :business_id with actual business parameter
-- 2. This query follows semantic layer v2 patterns:
--    - Mandatory business isolation filters
--    - Soft delete exclusion rules
--    - Value mapping normalizations
--    - Confidence scoring for detection
-- 3. Detection patterns include:
--    - Major cigarette brands (Marlboro, Winston, Dunhill, etc.)
--    - Generic terms in English and Malay
--    - Category and tag-based detection
-- 4. Results are classified for partner targeting:
--    - PRIMARY_TARGET: High confidence cigarette products
--    - SECONDARY_TARGET: Medium confidence products
--    - POTENTIAL_TARGET: Low confidence products
--    - NON_TARGET: No cigarette products detected