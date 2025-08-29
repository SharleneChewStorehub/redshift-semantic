# Database Schema Analysis Summary

## Overview
- **Total Tables**: 302
- **Total Columns**: 3,545
- **Both JSON files are identical** in structure and content

## Key Findings

### File Comparison
- `database_schema.json`: 25,431 lines
- `database_schema_with_descriptions.json`: 28,986 lines  
- **Difference**: The second file includes `business_description` fields for each column

### Schema Statistics Summary

| Table Name | Columns | Nullable | With Default |
|------------|---------|----------|--------------|
| customers | 33 | 32 | 5 |
| transactionrecords | 94 | 93 | 35 |
| transactionrecords__items | 46 | 45 | 26 |
| businesses | 137 | 136 | 34 |
| products | 67 | 65 | 13 |
| loyaltychangelogs | 14 | 13 | 3 |
| gatewayrecords | 16 | 15 | 3 |
| payoutitems | 34 | 33 | 16 |
| inventories | 19 | 18 | 3 |
| employees | 23 | 22 | 1 |
| promotions | 42 | 41 | 14 |
| campaigns | 24 | 23 | 1 |
| vouchers | 26 | 25 | 4 |
| onlinestoreinfos | 28 | 27 | 0 |
| logistics | 56 | 55 | 7 |

## Notable Tables by Column Count

### Largest Tables (>40 columns)
1. **businesses**: 137 columns (136 nullable, 34 with defaults)
2. **transactionrecords**: 94 columns (93 nullable, 35 with defaults)
3. **logistics**: 56 columns (55 nullable, 7 with defaults)  
4. **transactionrecords__items**: 46 columns (45 nullable, 26 with defaults)
5. **promotions**: 42 columns (41 nullable, 14 with defaults)

### Core Transaction Tables
- **transactionrecords**: 94 columns - Main transaction table
- **transactionrecords__items**: 46 columns - Transaction line items
- **transactionrecords__payments**: 15 columns - Payment details
- **transactionrecords__promotions**: 19 columns - Applied promotions

### Key Operational Tables
- **customers**: 33 columns - Customer profiles
- **products**: 67 columns - Product catalog
- **loyaltychangelogs**: 14 columns - Loyalty point transactions
- **gatewayrecords**: 16 columns - Payment gateway records
- **inventories**: 19 columns - Stock management

## Data Quality Insights

### Nullable Columns
- **High Nullable Rate**: Most tables have 95%+ nullable columns
- **Pattern**: Only business ID and primary keys are typically non-nullable

### Default Values
- **Low Default Usage**: Most tables have <20% columns with defaults
- **Exception Tables**: 
  - `batchpayouts`: 17/32 columns with defaults
  - `paymentsettlements`: 13/24 columns with defaults
  - `zreadings`: 22/34 columns with defaults

### Complex Nested Structure
- Many tables use double-underscore naming (e.g., `transactionrecords__items`)
- Indicates JSON-to-relational flattening from MongoDB source
- Deep nesting up to 4 levels (e.g., `businesses__stores__qrorderingsettings__vacations`)

## Schema Design Patterns

1. **MongoDB Flattening**: Tables represent flattened JSON documents
2. **Soft Deletes**: Pattern of nullable `isdeleted` columns
3. **Multi-tenant**: Business isolation through `business` columns
4. **Temporal Data**: Extensive use of timestamp fields
5. **Flexible Schema**: High nullability supports schema evolution
