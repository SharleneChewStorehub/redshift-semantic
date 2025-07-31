# Database Schema Files

This directory contains the complete database schema documentation for the StoreHub reporting system.

## Schema Files

### SQL Schema Dumps
- `storehub-table1.sql` - First part of the schema (tables A-P)
- `storehub-table2.sql` - Second part of the schema (tables P-Z)
- `storehub-table2-end.sql` - Final schema tables

These files contain INSERT statements that populate the `svv_columns` table with schema information:
- Total: 449 tables with 4,408 columns
- Format: `('schema','table','column','data_type')`

### Schema Documentation
- `database_schema.json` - JSON representation of the schema
- `database_schema_overview.md` - High-level overview and statistics
- `database_schema_detailed.md` - Detailed table and column documentation

## Key Tables

The most important tables for reporting:
1. `storehub_mongo.businesses` - Merchant/business profiles
2. `storehub_mongo.products` - Product catalog
3. `storehub_mongo.transactionrecords` - Sales transactions
4. `storehub_mongo.transaction_items` - Line items for transactions
5. `storehub_mongo.customers` - Customer profiles
6. `storehub_mongo.businesses__stores` - Store locations

## Usage

These schema files are used by:
- `semantic_layer_v2/validation/schema_lookup.py` - For validating SQL queries
- `semantic_layer_v2/validation/sql_builder_with_validation.py` - For building validated queries

## Important Notes

1. **Column Names**: All column names are lowercase in the actual database
2. **Schema Prefix**: Always use `storehub_mongo.` prefix for table names
3. **Missing Columns**: Some expected columns (like `businesses.isdeleted`) don't exist
4. **Product Names**: Product name is stored in `title` column, not `name`

## Common Gotchas

1. `businesses` table has no `isdeleted` column (use `status` or `businessstatus`)
2. `products.title` is the product name field (not `products.name`)
3. Join `businesses._id` with `products.business` for merchant products
4. Country values might be 'MY' instead of 'Malaysia'