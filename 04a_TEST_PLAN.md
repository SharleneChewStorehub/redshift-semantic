# TEST PLAN: StoreHub Redshift Semantic Layer Architectural Validation
**Test Plan Date:** January 25, 2025  
**Purpose:** Validate architectural risks identified in synthesis through real Metabase query analysis  
**Scope:** 5 Critical hypotheses requiring empirical validation through existing query patterns

---

## OVERVIEW

This test plan translates the theoretical architectural risks identified in the synthesis document into concrete, testable scenarios using existing Metabase queries. Each hypothesis will be validated by examining how current queries would interact with the proposed 5-layer semantic architecture.

**Testing Approach:** Find real business queries in Metabase that would stress-test each identified architectural risk, then analyze complexity, maintainability, and failure modes.

---

## Hypothesis 1: Five-Layer JSON Dependency Chain (CRITICAL RISK)

### 💡 Cues for Finding Queries

Based on the synthesis evidence that the 5-layer dependency chain creates fragile systems where "changes propagate unpredictably," look for these types of Metabase queries:

1. **Cross-Domain Analytics Queries**: Reports that combine data from multiple business domains (e.g., inventory + sales + customer loyalty) - these would require coordination across all 5 JSON layers and demonstrate cascade failure risks.

2. **Time-Based Trend Analysis**: Queries that analyze metrics over time periods with different business rules (e.g., monthly sales reports with varying tax calculations, seasonal promotions) - these test how schema evolution affects the dependency chain.

3. **Multi-Tenant Configuration Queries**: Reports that need to adapt behavior based on different business configurations (e.g., franchise-specific reporting, regional compliance variations) - these demonstrate how changes in business_rules.json propagate through the entire stack.

### 📝 Test Cases

### Test Case 1.1: Cross-Domain Membership & Sales Analysis
* **Metabase Query Found:** [Membership Insights Report](https://metabase.shub.us/question/4783-membership-insights-report)
* **Purpose of this Test:** This query combines customer loyalty data (memberships) with transactional data (sales). It's a perfect test for cross-domain analysis.
* **Risk Validation:** Requires `semantic_context` (for "insights"), `data_catalog` (linking members to sales), `business_rules` (defining membership tiers), `query_patterns` (aggregation), and `query_cookbook` (final SQL). A change in one domain risks breaking the entire report.
* **Complexity Assessment:** 5/5 - Touches all layers.

### Test Case 1.2: Comprehensive Store & Merchant Profiling
* **Metabase Query Found:** [Merchant and Store Profiling by Country](https://metabase.shub.us/question/3066-merchant-and-store-profiling-by-country)
* **Purpose of this Test:** This complex profiling report tests the framework's ability to pull and integrate data from many different business domains at once: transactions (sales), loyalty (cashback, engage), customers (customer count), and store configuration (address info).
* **Risk Validation:** This is a classic cross-domain query that forces dependencies across the entire 5-layer chain. A minor change to the definition of "cashback" in `business_rules.json` could have unforeseen impacts on how "transactions" are aggregated in `query_patterns.json`.
* **Complexity Assessment:** 5/5 - Touches all layers.

### Test Case 1.3: Time-Based Cohort Funnel Analysis
* **Metabase Query Found:** [Engage Cohort Funnel for Free Trial Merchants](https://metabase.shub.us/question/3745-for-engage-cohort-funnel-merchants-who-started-engage-free-trial)
* **Purpose of this Test:** This query validates how the framework handles complex, relative time-based logic (e.g., "14 days before an event," "7 days before," and "during the trial").
* **Risk Validation:** This stresses the `business_rules.json` (for defining the cohort time windows) and the `query_patterns.json` (for generating the necessary date calculations and window functions). A small change to the cohort definition (e.g., from 14 days to 30 days) tests the fragility of the dependency chain.
* **Complexity Assessment:** 4/5 - Primarily stresses the rules and patterns layers, but its complexity makes it a high-risk test.

---

## Hypothesis 2: Custom Natural Language Processing (HIGH RISK)

### 💡 Cues for Finding Queries

The synthesis shows that "mature off-the-shelf tools now offer sophisticated, out-of-the-box solutions" for NL→SQL. Look for these query patterns that would test custom NLP complexity:

1. **Business Metric Definition Queries**: Complex reports that require understanding business terminology (e.g., "net revenue," "active customers," "inventory turnover") - these test whether the custom semantic context layer adds value over existing tools.

2. **Ambiguous Intent Queries**: Reports where the same natural language could mean different things in different contexts (e.g., "sales by location" could mean store performance or delivery geography) - these test the intent classification complexity.

3. **Domain-Specific Business Logic Queries**: Reports with retail/F&B specific calculations (e.g., "food cost percentage," "table turnover rate," "loyalty point valuations") - these test whether custom NLP provides advantages over configuring existing semantic layers.

### 📝 Test Cases

### Test Case 2.1: Complex Business Metric Calculation (Payment Gateway Revenue)
* **Metabase Query Found:** [Monthly Payment Gateway Revenue Report](https://metabase.shub.us/question/4568-monthly-total-beep-ecomm-transactions-and-payment-gateway-revenue)
* **Purpose of this Test:** To validate the AI's ability to translate a simple business question ("What is our payment gateway revenue?") into a highly complex, multi-step SQL query involving joins across several financial and transactional tables.
* **NLP Complexity Assessment:** The AI must understand that "payment gateway revenue" is not a database column but a derived concept. It needs to learn the specific business logic for combining transaction totals, payout fees, and gateway costs to arrive at the correct number.
* **Off-the-Shelf Comparison:** This is a classic use case for a mature semantic layer. In dbt or Cube.dev, you would define the `payment_gateway_revenue` metric *once*. An AI could then simply ask for that metric by name, a much simpler and less error-prone task than generating the entire complex query from scratch.
* **Custom Build Justification:** This query demonstrates the high complexity and maintenance burden of a custom-built NLP system. Any change to how fees are calculated would require retraining or reprogramming the AI's logic.

### Test Case 2.2: Product Feature Adoption Metric (Beep QR)
* **Metabase Query Found:** [Beep QR Feature Adoption & Usage Rate](https://metabase.shub.us/question/3414-my-this-months-beep-qr-usage-by-store)
* **Purpose of this Test:** To measure the adoption of a specific, high-value product feature ("Beep QR"). This tests the AI's ability to understand product-specific jargon and calculate derived ratios that are not simple database columns.
* **NLP Complexity Assessment:** The AI must understand several distinct concepts: the cohort of "stores that have used QR", the definition of "in-store sales" (which includes both QR and non-QR transactions), and the final step of calculating a ratio (`QR GMV / In-Store GMV`). This requires complex, multi-step reasoning.
* **Off-the-Shelf Comparison:** In a semantic layer, you could pre-define metrics like `qr_sales` and `instore_sales`. The AI's task would then be simplified to asking for `SUM(qr_sales) / SUM(instore_sales)`, which is significantly less complex than generating the entire query from first principles.
* **Custom Build Justification:** This query highlights the challenge of teaching a custom NLP system about every specific product feature and the unique business logic associated with measuring its success.

### Test Case 2.3: Domain-Specific KPI with Business Rules (Cashback Utilization)
* **Metabase Query Found:** [QR Cashback Program Effectiveness Report](https://metabase.shub.us/question/2743-monthly-beep-cashback-utilisation-rate-in-past-12-months)
* **Purpose of this Test:** To validate the AI's ability to handle multiple layers of domain-specific business logic simultaneously: a core loyalty KPI (utilization rate), multi-currency conversions based on country, and filtering for a specific product feature (QR Ordering).
* **NLP Complexity Assessment:** This is extremely high. The AI must understand the formula for "utilization rate" (`redeemed / claimed`), know the specific, hardcoded currency conversion rates for each country, and know how to isolate only the cashback events that originated from `source = 'QR_ORDERING'`.
* **Off-the-Shelf Comparison:** A mature semantic layer excels at this. You would define `claimed_cashback_sgd` and `redeemed_cashback_sgd` once, with all the multi-currency `CASE` logic embedded. You could then define `utilization_rate` as the ratio of the two. The AI's task would be simplified to asking for the `utilization_rate` metric with a simple filter, which is far less risky.
* **Custom Build Justification:** This query is a strong argument against a custom build. The amount of domain-specific financial logic that would need to be programmed and maintained in a custom NLP system would be significant.


---

## Hypothesis 3: Dual Database Architecture with Manual Sync (HIGH RISK)

### 💡 Cues for Finding Queries

The synthesis confirms that "manual sync introduces data inconsistency risks." Look for these query patterns that expose synchronization vulnerabilities:

1. **Real-Time Operational Queries**: Reports that need recent data from MongoDB operations (e.g., today's transactions, current inventory levels, active promotions) - these test data latency and consistency issues.

2. **Cross-System Consistency Queries**: Reports that combine operational data (MongoDB) with historical analytics (Redshift) (e.g., comparing today's performance vs. historical trends) - these expose potential data inconsistencies.

3. **Time-Sensitive Business Intelligence**: Reports used for operational decision-making that require up-to-date data (e.g., inventory restocking alerts, daily sales targets, staff scheduling based on traffic) - these test the risk of manual sync delays.

### 📝 Test Cases

### Test Case 3.1: Real-Time Campaign Monitoring Dashboard
* **Metabase Query Found:** [Active Engage Campaigns - Operational Dashboard](https://metabase.shub.us/question/2850-engage-active-campaign-details)
* **Purpose of this Test:** To provide a real-time view of the performance and status of all currently active marketing campaigns, including critical operational metrics like the merchant's remaining SMS credit balance.
* **Data Freshness Requirement:** High. To be operationally useful, metrics like `total_sms_sent` and especially `sms_credit_balance` need to be fresh within minutes, not hours.
* **Sync Risk Assessment:** This query perfectly exposes the risk of manual sync. If the data sync from MongoDB (where campaign jobs run and credits are deducted) is delayed by several hours, a manager might see a high credit balance in this report and advise a merchant to run a new blast, when in reality the credits are already depleted. This would cause the campaign to fail, leading to merchant frustration and a loss of trust in the data.
* **CDC Migration Potential:** This is a prime use case for event-driven architecture. Every `campaignjob` event could be streamed via CDC (Change Data Capture) to Redshift in near real-time, ensuring the dashboard is always accurate and reliable for operational decisions.

### Test Case 3.2: Cross-System Consistency for Inventory Valuation
* **Metabase Query Found:** [Current Inventory Valuation Report](https://metabase.shub.us/question/4281-imikaempiresdnbhd-stock-value)
* **Purpose of this Test:** This is a critical financial and operational report that calculates the current monetary value of all stock on hand for a specific merchant, based on the latest inventory data from the operational system.
* **Data Freshness Requirement:** Very High. This report is only trustworthy if it reflects the inventory state from within the last few minutes. A delay of even an hour could make the valuation inaccurate due to sales or stock movements.
* **Sync Risk Assessment:** This query perfectly demonstrates the risk of data inconsistency. If the sync of the `inventories` and `products` tables from MongoDB to Redshift is delayed or misses data, this report will produce an incorrect valuation. This leads to incorrect financial statements, poor restocking decisions, and a complete loss of trust in the data platform for operational reporting.
* **CDC Migration Potential:** This is a prime use case for CDC. Every inventory change event (sale, return, transfer) in MongoDB could be streamed to Redshift in near real-time, ensuring the analytical view is always a trustworthy mirror of the operational reality.

### Test Case 3.3: Time-Sensitive Business Intelligence (Feature Performance)
* **Metabase Query Found:** [Monthly Beep QR Performance Report](https://metabase.shub.us/question/3119-my-this-months-beep-qr-txns-by-store)
* **Purpose of this Test:** To provide a monthly performance summary of the Beep QR product feature for the cohort of merchants who have adopted it. This is a typical report used in monthly business reviews.
* **Data Freshness Requirement:** Medium-High. For a "last month" performance report to be useful, the data needs to be complete and accurate shortly after the month ends. A sync that is delayed by several days into the new month would render this report unavailable for timely reviews.
* **Sync Risk Assessment:** The risk here is the timeliness and completeness of the sync from the operational database (MongoDB). If the manual sync process is slow or fails, the "last month" figures will be incorrect or incomplete. This could lead to a flawed understanding of the QR feature's performance and impact business decisions.
* **CDC Migration Potential:** A reliable, event-driven pipeline (like CDC) would ensure that as soon as a month closes, the data in Redshift is complete and accurate. This would allow this key performance report to be run reliably on the first business day of the new month.

---

## Hypothesis 4: Business Rules as Configuration (MEDIUM RISK)

### 💡 Cues for Finding Queries

The synthesis provides "nuanced support" for JSON configuration in multi-tenant environments but validates concerns about complexity. Look for these query patterns:

1. **Multi-Tenant Rule Variation Queries**: Reports that need different business logic per tenant (e.g., franchise-specific tax calculations, regional promotion rules, chain-specific loyalty programs) - these test the JSON configuration benefits.

2. **Complex Business Logic Queries**: Reports with intricate calculations that involve multiple business rules (e.g., tiered pricing with regional adjustments, loyalty point calculations with expiration rules) - these test the debugging and testing challenges.

3. **Regulatory Compliance Queries**: Reports that must follow specific business rules for audit purposes (e.g., tax reporting, inventory valuations, financial reconciliation) - these test the versioning and auditability concerns.

### 📝 Test Cases

### Test Case 4.1: Multi-Tenant Profitability Calculation
* **Metabase Query Found:** [Product Sales & Profitability Analysis](https://metabase.shub.us/question/4649-sales-by-product-report)
* **Purpose of this Test:** To calculate core profitability metrics (Net Sales, Gross Profit, Gross Profit Margin), which requires complex business logic, especially around the correct handling of returns. This tests the trade-offs of defining this logic in a configuration file.
* **Business Rule Complexity:** The core logic is the precise, multi-step definition of "Net Sales" (e.g., `sold items total - returned items total`) and "Gross Profit" (`Net Sales - Net Cost`). This involves conditional aggregation based on transaction type.
* **Multi-Tenant Benefit:** This is a strong example of the *benefit* of the JSON config approach. Different merchants (tenants) could have slightly different definitions of what's included in "cost." A configuration-driven model would allow this flexibility without requiring a new, custom SQL query for each merchant.
* **Testing/Debugging Challenge:** This query also highlights the *risk*. If this complex profit calculation was defined in a large JSON file instead of self-contained SQL, verifying its correctness and debugging a small error (e.g., forgetting to subtract returned taxes) would be extremely difficult.

### Test Case 4.2: Complex Business Logic for Net Sales by Payment Method
* **Metabase Query Found:** [Net Sales by Payment Method Report](https://metabase.shub.us/question/4406-merchants-sales-by-payment-method-report)
* **Purpose of this Test:** To validate the framework's ability to handle two types of complex business logic: mapping internal IDs to custom, merchant-defined names (for payment methods), and applying a specific, multi-part formula for a core KPI ("Net Sales").
* **Business Rule Complexity:** The logic involves both a conditional mapping for payment method names and the specific formula `Sales + PreOrders - Returns` to calculate Net Sales. This is non-trivial business logic.
* **Multi-Tenant Benefit:** This is a clear example of the benefit of a configuration-driven approach. A `business_rules.json` would allow each merchant to customize their payment method names (e.g., "Terminal 1 Visa") and potentially their Net Sales formula without requiring new code.
* **Testing/Debugging Challenge:** This query also highlights the significant risk. If a merchant reports that their "Visa" sales are wrong, debugging the JSON configuration to trace which transactions were included and how the Net Sales formula was applied would be extremely difficult compared to the transparency of this self-contained SQL query.

### Test Case 4.3: Regulatory Compliance & Financial Reconciliation
* **Metabase Query Found:** [Transaction-Level Financial Reconciliation Audit](https://metabase.shub.us/question/2462-payout-summary-transactions-breakdown)
* **Purpose of this Test:** To provide a detailed, transaction-level financial breakdown for auditing and reconciliation. This query requires dozens of complex, interdependent business rules to be applied to each transaction.
* **Business Rule Complexity:** Extremely High. The logic includes departmental cost attribution for vouchers based on text parsing in the `remarks` field, conditional profit calculations for logistics that exclude specific couriers, and the aggregation of numerous distinct fee types.
* **Multi-Tenant Benefit:** Theoretically, a JSON configuration could allow these complex financial rules to vary by merchant, which could be seen as a benefit.
* **Testing/Debugging Challenge:** This query is a powerful argument against embedding such critical logic in configuration. If a financial audit revealed a discrepancy, debugging the root cause by tracing the logic through a complex, nested JSON file would be a nightmare. The explicitness of SQL, while complex, is far more transparent and auditable for high-stakes financial calculations like these.

---

## Hypothesis 5: Query Pattern Template System (MEDIUM RISK)

### 💡 Cues for Finding Queries

The synthesis shows "implicit support" for concerns about template-based SQL generation. Look for these query patterns that would stress-test the template system:

1. **Performance-Critical Queries**: Reports that process large datasets or require complex aggregations (e.g., monthly sales rollups, customer lifetime value calculations) - these test the performance bottleneck risk.

2. **Edge Case Handling Queries**: Reports with unusual data patterns or complex filtering logic (e.g., handling refunds in sales calculations, dealing with partial transactions) - these test template flexibility limitations.

3. **Optimization-Dependent Queries**: Reports that rely on specific SQL optimizations for reasonable performance (e.g., queries with complex joins, window functions, or custom indexing strategies) - these test whether templates can generate optimized SQL.

### 📝 Test Cases

### Test Case 5.1: Performance-Critical Monthly Sales Roll-up
* **Metabase Query Found:** [Monthly Sales Roll-up by Channel (Malaysia)](https://metabase.shub.us/question/4127-monthly-transactions-breakdown-by-merchant-by-store)
* **Purpose of this Test:** This is a heavy, performance-critical report that aggregates all sales data for an entire country for a month, pivoting it into a wide table with dozens of columns for each distinct sales channel.
* **Template Complexity:** High. A template system would need to be very sophisticated to dynamically generate the large number of conditional aggregation columns required by this query. Adding or changing a channel would require complex template modifications.
* **Performance Risk:** This is the primary risk being tested. The query scans and aggregates a massive volume of data. If a template system generates SQL that is even slightly suboptimal (e.g., inefficient use of CASE statements vs. a pre-aggregated table), the query could be extremely slow, time out, or place a heavy load on the data warehouse, impacting all other users. This is a classic performance bottleneck scenario.
* **Edge Case Handling:** The template would need to gracefully handle stores that don't use all channels, ensuring that nulls or zeros are reported correctly without breaking the query.

### Test Case 5.2: Edge Case Handling in Item-Level Sales Reporting
* **Metabase Query Found:** [Detailed Item-Level Sales Report](https://metabase.shub.us/question/4011-vcr-transactions-by-items-summary-report-last-month)
* **Purpose of this Test:** To provide a granular, item-level sales report and specifically test the framework's ability to handle edge cases in the data, such as transactions containing custom items that don't exist in the main product catalog.
* **Template Complexity:** Medium-High. The template would need conditional logic (like the `CASE` statement in the query) to correctly display item names for both standard catalog products and custom, non-standard line items.
* **Performance Risk:** Lower than the previous test case as it's for a single merchant, but still present due to multiple joins and aggregations on the large transaction items table.
* **Edge Case Handling:** This is the primary risk being tested. A generic "sales by product" template would likely fail this test by either dropping the custom items entirely or showing them with null names, leading to an incomplete report. This query's logic demonstrates the kind of real-world data cleaning that rigid templates often struggle with, highlighting their inflexibility.

---

## TESTING METHODOLOGY

### Phase 1: Query Discovery
1. Search Metabase for queries matching the "cues" patterns above
2. Document each query with its current implementation approach
3. Categorize queries by complexity and business criticality

### Phase 2: Risk Validation
1. For each discovered query, complete the test case template
2. Analyze how the proposed 5-layer architecture would handle the query
3. Identify specific failure modes and complexity issues

### Phase 3: Alternative Analysis
1. Research how industry-standard tools (Cube.dev, dbt Semantic Layer) would handle each query
2. Compare complexity, maintainability, and performance implications
3. Validate synthesis recommendations through concrete examples

### Success Criteria
- **Risk Validation**: Each hypothesis should be supported by at least 3 real-world query examples
- **Architectural Impact**: Clear demonstration of how current queries would be affected by the proposed 5-layer system
- **Alternative Justification**: Evidence supporting the synthesis recommendation for industry-standard tools

---

## DELIVERABLES

1. **Completed Test Cases**: All templates filled with real Metabase queries
2. **Risk Assessment Matrix**: Quantified impact analysis for each hypothesis
3. **Migration Complexity Analysis**: Effort required to adapt current queries to different architectural approaches
4. **Tool Comparison Report**: Concrete evaluation of how alternative semantic layers would handle StoreHub's actual query patterns 