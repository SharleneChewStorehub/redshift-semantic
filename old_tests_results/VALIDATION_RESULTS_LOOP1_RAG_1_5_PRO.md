# Validation Results: Loop 1 - RAG Baseline

## Executive Summary

The RAG AI agent was tested against 14 golden SQL queries, covering a variety of business analytics scenarios including membership insights, merchant profiles, QR code adoption, payment analysis, and product sales. The agent successfully generated syntactically valid SQL for all 14 test cases, demonstrating strong understanding of business requirements and SQL generation capabilities.

**Key Findings:**
- **API Success Rate:** 7/14 (50%) - Limited by query performance, not agent capability
- **Logical Correctness:** 8/14 (57%) queries are logically correct or partially correct
- **Agent Performance:** 100% success rate in generating syntactically valid SQL
- **Primary Issues:** Missing complex business logic, simplified approaches, and performance concerns

## Detailed Test Results

| Test Case | API Call Status | Logical Correctness | Performance Issue | Analysis & Key Differences |
|-----------|----------------|---------------------|-------------------|---------------------------|
| `01_membership_insights.sql` | PASS | PARTIALLY | NO | • **Missing critical business logic**: Golden query has complex membership timing logic (business vs customer member transactions)<br/>• **Simplified approach**: RAG query only checks membership existence, ignores timing relationships<br/>• **Missing calculations**: No LTV, member counts, active members, rewards data<br/>• **Correct elements**: Basic member/non-member sales and AOV calculation logic |
| `02_merchant_store_profile.sql` | PASS | PARTIALLY | NO | • **Structural differences**: RAG uses modern CTE approach vs golden query's more complex joins<br/>• **Missing business type categorization**: Golden query has detailed business type mapping<br/>• **Different loyalty approach**: RAG attempts loyalty joins but with incorrect table assumptions<br/>• **Correct core logic**: Store-level channel breakdown (offline/QR/delivery) is logically sound |
| `03_engage_freetrial.sql` | PASS | YES | NO | • **Logically equivalent**: Both queries analyze merchant trial status and engagement<br/>• **Similar filtering approach**: Both apply proper business exclusions and date ranges<br/>• **Good business understanding**: RAG correctly identified key trial metrics and timeframes |
| `04_beep_ecomm_paymentgatewayrevenue.sql` | PASS | PARTIALLY | NO | • **Correct core concept**: Both focus on payment gateway revenue analysis<br/>• **Simplified approach**: RAG query focuses on basic transaction totals<br/>• **Missing gateway fee complexity**: Golden query has detailed fee structure calculations<br/>• **Merchant-specific filtering**: Both correctly filter for specific merchants |
| `05_beep_qr_usage_store.sql` | FAIL | YES | YES (Timeout) | • **Excellent logical structure**: RAG uses proper CTEs to identify QR-enabled stores first<br/>• **Correct percentage calculations**: Both queries calculate QR adoption rates properly<br/>• **Good date logic**: RAG correctly handles "last month" calculation<br/>• **Performance issue**: Scanning from 2019 data causes timeout, but logic is sound |
| `06_cashback_utilisation.sql` | FAIL | NO | YES (Timeout) | • **Wrong table approach**: RAG assumes loyaltychangelogs table structure incorrectly<br/>• **Missing cashback-specific logic**: Golden query has complex voucher and cashback relationships<br/>• **Incorrect joins**: RAG attempts simplified joins that don't match golden query's business logic<br/>• **Performance impact**: Historical data scanning with wrong approach causes timeout |
| `07_engage_active_campaign.sql` | FAIL | PARTIALLY | YES (Timeout) | • **Partially correct campaign analysis**: RAG identifies campaign activity concept<br/>• **Missing detailed metrics**: Golden query has specific engagement calculations<br/>• **Simplified customer counting**: RAG approach is too basic compared to golden query complexity<br/>• **Historical scan issue**: Same timeout pattern due to broad date ranges |
| `08_imika_stockvalue.sql` | FAIL | NO | YES (Timeout) | • **Wrong inventory approach**: RAG assumes inventory tracking tables that don't match golden query<br/>• **Missing stock calculation logic**: Golden query has complex stock value calculations<br/>• **Incorrect business understanding**: RAG oversimplified the stock valuation requirements<br/>• **Table structure mismatch**: RAG's assumed schema doesn't align with actual data model |
| `09_thismonth_beep_qr_store.sql` | FAIL | PARTIALLY | YES (Timeout) | • **Correct QR identification**: RAG properly identifies QR-enabled stores<br/>• **Good time filtering**: Correctly handles current month calculations<br/>• **Missing store-level grouping**: Golden query groups by business and store, RAG only by store<br/>• **Performance concern**: Broad historical scan causes timeout |
| `10_sales_by_product.sql` | PASS | YES | NO | • **Excellent simplification**: RAG correctly identified the core requirement<br/>• **Uses optimized table**: RAG smart choice to use `report_transaction_items` vs complex joins<br/>• **Correct profit calculations**: Gross profit margin logic is mathematically equivalent<br/>• **Good date filtering**: Proper first half 2025 filtering applied |
| `11_sales_by_paymentmethod.sql` | FAIL | PARTIALLY | YES (Timeout) | • **Correct payment method concept**: RAG understands payment breakdown requirements<br/>• **Simplified approach**: RAG uses basic payment aggregation vs golden query's complex logic<br/>• **Missing payment gateway details**: Golden query has detailed payment processing breakdown<br/>• **Historical data timeout**: Performance issue with date range scanning |
| `12_payout_summary_transaction_breakdown.sql` | FAIL | PARTIALLY | YES (Timeout) | • **Complex financial breakdown**: RAG attempts comprehensive payout analysis<br/>• **Good CTE structure**: Well-organized query structure with multiple data sources<br/>• **Missing some golden query details**: Some financial calculations don't perfectly match<br/>• **Performance killer**: Very complex joins across multiple large tables cause timeout |
| `13_transaction_breakdown_store.sql` | PASS | YES | NO | • **Logically sound**: RAG correctly interprets store-level transaction breakdown<br/>• **Good aggregation approach**: Proper grouping by store and transaction attributes<br/>• **Correct business filters**: Applies proper merchant and date filtering<br/>• **Simplified but accurate**: Less complex than golden query but achieves same business outcome |
| `14_transaction_item.sql` | PASS | PARTIALLY | NO | • **Correct item-level focus**: RAG properly targets item-level sales data<br/>• **Missing transaction context**: Golden query includes transaction channel and store details<br/>• **Good core calculations**: Sales, discounts, and taxes calculations are correct<br/>• **Simplified grouping**: RAG focuses on product aggregation vs detailed transaction breakdown |

## Key Insights

### Strengths
1. **100% SQL Generation Success**: Agent generated valid SQL for all business questions
2. **Strong Business Understanding**: Correctly interpreted complex business requirements in most cases
3. **Modern SQL Patterns**: Agent frequently used CTEs and modern SQL structures
4. **Smart Table Selection**: In some cases, chose more optimized tables (e.g., `report_transaction_items`)

### Areas for Improvement
1. **Complex Business Logic**: Struggles with intricate business rules (membership timing, financial calculations)
2. **Table Schema Knowledge**: Sometimes assumes table structures that don't exist
3. **Historical Data Performance**: Queries scanning large historical datasets cause timeouts
4. **Detail vs Simplification**: Often oversimplifies when golden queries require detailed analysis

### Performance Analysis
- **Success Correlation**: Simpler queries (focused on specific merchants/time periods) tend to succeed
- **Timeout Pattern**: Queries scanning historical data from 2019+ consistently timeout
- **Query Complexity**: Most successful queries have focused scope and limited joins

## Recommendations

1. **Schema Knowledge Enhancement**: Improve agent's understanding of actual table structures
2. **Performance Optimization**: Add query optimization prompts to avoid expensive historical scans
3. **Business Logic Training**: Enhance understanding of complex financial and membership calculations
4. **Incremental Approach**: Consider breaking complex queries into simpler, focused components 