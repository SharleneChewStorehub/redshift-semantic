# StoreHub Schema Extraction Summary

## Overview

Successfully extracted and documented schema information for all **172 priority tables** from the StoreHub database, representing over **6.2 billion rows** of data across **2,547 columns**.

## Key Files Generated

1. **`priority_tables_schema.json`** - Complete schema data in JSON format
   - All 172 tables with column definitions
   - Data types for 2,547 columns
   - Foreign key relationships (both explicit and inferred)
   - Row counts from production data

2. **`priority_tables_schema_documentation.md`** - Human-readable documentation
   - Organized by business category
   - Column descriptions and relationships
   - Summary statistics and insights

3. **`priority_172_tables.txt`** - Simple list of table names for reference

## Key Insights

### Data Distribution
- **90.9%** of data is in transaction-related tables (5.6 billion rows)
- The largest table is `transactionrecords__items` with 2.4 billion rows
- Core business tables are relatively small but critical:
  - `businesses`: 58,138 merchants
  - `customers`: 47.7 million customers
  - `products`: 33.3 million products

### Schema Patterns

1. **Naming Conventions**
   - Double underscore (`__`) indicates sub-tables/nested data
   - `_foreignkey` suffix for explicit foreign keys
   - `_id` as primary key (MongoDB convention)

2. **Common Relationships**
   ```
   transactionrecords (receiptnumber) → transaction_items (transactionid)
   transaction_items (productid) → products (_id)
   transactionrecords (customerid) → customers (_id)
   transactionrecords (business) → businesses (_id)
   ```

3. **Data Types**
   - Most columns use `character varying` (strings)
   - Numeric types: `numeric`, `double precision`, `bigint`
   - Dates: `timestamp without time zone`
   - Flags: `boolean`

### Business Categories

| Category | Tables | Total Rows | Key Entities |
|----------|--------|------------|--------------|
| Transactions | 29 | 5.6B | Sales, returns, payments |
| Products | 11 | 106M | Catalog, variations, pricing |
| Customers | 2 | 53M | Profiles, consumers |
| Loyalty | 5 | 55M | Points, rewards, changes |
| Payments | 14 | 137M | Gateway records, settlements |
| Inventory | 9 | 38M | Stock levels, transfers |
| Marketing | 13 | 13M | Campaigns, promotions |

## Usage Recommendations

### For SQL Query Generation
1. Always validate table and column names against the schema
2. Use proper schema prefix: `storehub_mongo.table_name`
3. Remember multi-tenant isolation: filter by `business` field
4. Check for soft deletes: `isdeleted` column where present

### For Natural Language Understanding
1. Map business terms to technical names:
   - "merchant" → `businesses`
   - "sale" → `transactionrecords` where `transactiontype = 'Sale'`
   - "product variant" → `products__variations`
   - "line item" → `transactionrecords__items`

2. Common aggregations:
   - Net sales: `subtotal - discount` for sales minus returns
   - Customer count: `COUNT(DISTINCT customerid)`
   - Average order value: `total / COUNT(DISTINCT receiptnumber)`

### Performance Considerations
1. Large tables (>100M rows) need careful indexing:
   - `transactionrecords`: Index on business, createdtime
   - `transactionrecords__items`: Index on transactionrecords_foreignkey
   - `customers`: Index on business

2. Date filtering is critical for query performance
3. Consider pre-aggregated tables for common metrics

## Next Steps

1. **Validation**: Test schema against actual Metabase queries
2. **Enhancement**: Add more business logic and constraints
3. **Optimization**: Identify commonly joined tables for optimization
4. **Documentation**: Expand column descriptions with business context

---
Generated: 2025-07-16
Total extraction time: < 1 minute
Source: StoreHub Redshift database metadata (svv_columns)