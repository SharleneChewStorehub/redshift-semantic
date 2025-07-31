# Schema Extraction for StoreHub Semantic Layer

This directory contains the extracted schema information for the 172 priority tables identified for the StoreHub semantic layer.

## Files Overview

### Primary Schema File
- **`priority_tables_schema.sql`** (245 KB) - Complete schema in SQL INSERT format
  - Same format as the original database schema files
  - Contains all 172 priority tables with 2,547 columns
  - Organized by business category
  - Includes metadata and statistics

### Supporting Files
- **`priority_tables_list.sql`** - Compact list of table names by category
- **`priority_tables_schema.json`** - Machine-readable JSON format
- **`priority_tables_schema_documentation.md`** - Human-readable documentation
- **`SCHEMA_EXTRACTION_SUMMARY.md`** - Executive summary with insights

### Reference Files
- **`priority_172_tables.txt`** - Simple list of table names
- **`priority_172_tables.json`** - Table names with metadata

## How to Use

### 1. For SQL Query Generation
```sql
-- Reference the schema file to validate table/column names
-- Example: Check if a column exists
grep "transactionrecords" priority_tables_schema.sql | grep "customerid"
```

### 2. For Semantic Layer Development
The `priority_tables_schema.sql` file can be used as context when:
- Building SQL queries
- Validating column names
- Understanding relationships
- Checking data types

### 3. Key Patterns to Remember
- Schema prefix: `storehub_mongo`
- Primary keys: `_id` column
- Foreign keys: `*_foreignkey` or common suffixes (`businessid`, `customerid`, etc.)
- Timestamps: `createdtime`, `updatedtime`, `data_modified_time`

## Schema Statistics

| Metric | Value |
|--------|-------|
| Total Tables | 172 |
| Total Columns | 2,547 |
| Total Rows | 6.2 billion |
| Largest Table | transactionrecords__items (2.4B rows) |
| Most Columns | transactionrecords (132 columns) |

## Categories Distribution

| Category | Tables | % of Data |
|----------|--------|-----------|
| Transactions | 29 | 90.9% |
| Other | 43 | 2.5% |
| Payments | 14 | 2.2% |
| Products | 11 | 1.7% |
| Loyalty | 5 | 0.9% |

## Common Queries

### Find all columns for a table
```bash
grep -A 20 "Table: products (" priority_tables_schema.sql
```

### Search for specific column names
```bash
grep "customerid" priority_tables_schema.sql
```

### List all tables in a category
```bash
grep "^-- Table:" priority_tables_schema.sql | grep -A 1 "Category: Transactions"
```

## Updating the Schema

To regenerate the schema files:
```bash
python extract_schemas_from_svv.py
python convert_to_svv_format.py
```

## Integration with Semantic Layer

This schema file should be used as the source of truth for:
1. Query validation in `sql_builder_with_validation.py`
2. Natural language understanding in `semantic_context.json`
3. Query pattern development in `query_patterns.json`
4. Business rule validation in `business_rules.json`

---
Generated: 2025-07-16
Source: StoreHub Redshift database metadata (svv_columns)