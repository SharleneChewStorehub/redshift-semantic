# Semantic Layer v2.0 - Production-Ready NL-to-SQL System

## Overview

A clean, maintainable 5-file architecture that enables accurate Natural Language to SQL translation for StoreHub's merchant reporting system. This design follows data architecture best practices: separation of concerns, single source of truth, and clear maintainability.

## Architecture Components

### Core Components (JSON Files)

#### 1. `data_catalog.json` - The What
**Purpose**: Authoritative mapping of business concepts to physical database objects

- **Business Entities**: Maps concepts like "sales" to tables and calculations
- **Table Definitions**: Documents what each table contains and means
- **Relationships**: How tables connect (foreign keys, join patterns)
- **Pre-aggregated Sources**: When to use optimized endpoints

**Key Insight**: This is the single source of truth for "what data exists and what it means"

#### 2. `business_rules.json` - The Rules  
**Purpose**: Constraints, validations, and business logic that ensure query correctness

- **Mandatory Filters**: Multi-tenant safety, soft deletes
- **Data Quality Rules**: Business logic validations
- **Performance Constraints**: Prevent runaway queries
- **Access Control**: Data classification and row-level security

**Key Insight**: Enforces safety and correctness - queries cannot violate these rules

#### 3. `query_patterns.json` - The How
**Purpose**: Reusable, tested SQL patterns for common analytical needs

- **Core Patterns**: Time series, rankings, comparisons
- **Advanced Patterns**: Cohort analysis, retention, ABC analysis
- **Optimization Patterns**: Performance best practices
- **Composition Rules**: How to combine patterns

**Key Insight**: Building blocks that can be parameterized and combined

#### 4. `semantic_context.json` - The Context
**Purpose**: Natural language understanding and disambiguation

- **Default Interpretations**: What "sales" means when not specified
- **Disambiguation Rules**: How to resolve ambiguous requests
- **Regional Context**: Currency, tax, timezone handling
- **Intent Patterns**: Recognizing query types from language

**Key Insight**: Bridges the gap between how humans ask and what they mean

#### 5. `query_cookbook.json` - The Examples
**Purpose**: Complete worked examples showing the system in action

- **Real Queries**: Natural language → SQL with full explanation
- **Pattern Usage**: When to use which pattern
- **Common Modifications**: How to adapt examples
- **Debugging Tips**: What to check when things go wrong

**Key Insight**: Learning by example - shows how all pieces work together

### Validation Components (Python Modules)

#### 6. `validation/` - The Safety Net
**Purpose**: Validate generated SQL against actual database schema

- **Schema Lookup**: Discovers and indexes available tables/columns
- **Query Validation**: Checks all references exist before execution
- **Error Prevention**: Catches issues at generation time, not runtime
- **Integration Ready**: Can be added to any query generation pipeline

**Key Insight**: Prevents runtime errors by validating against real schema

## How It Works

```
Natural Language: "Show me top selling products last month"
                            ↓
1. Semantic Context: Interpret intent and defaults
   - "top" → ranking pattern
   - "products" → product entity
   - "last month" → previous calendar month
                            ↓
2. Data Catalog: Find tables and fields
   - Products → products table + transaction_items
   - Sales data → transactionrecords
                            ↓
3. Business Rules: Apply constraints
   - Add mandatory filters (business, isdeleted)
   - Check date range limits
                            ↓
4. Query Patterns: Select and parameterize pattern
   - Use "top_n_ranking" pattern
   - Join transaction → items → products
                            ↓
5. Schema Validation: Verify tables and columns exist
   - Validate against actual database schema
   - Prevent runtime errors from invalid references
                            ↓
6. Generate SQL: Complete, safe, validated, optimized query
```

## Usage Guide

### For LLM/AI Systems

1. **Load all 5 JSON files** into context at startup
2. **Process queries** following this flow:
   - Parse intent using `semantic_context.json`
   - Map to data using `data_catalog.json`
   - Apply rules from `business_rules.json`
   - Build query using `query_patterns.json`
   - Reference `query_cookbook.json` for similar examples

3. **Handle ambiguity**:
   - Check confidence scoring in semantic_context
   - Apply default interpretations
   - Request clarification only when truly ambiguous

### For Developers

1. **Understanding the data**: Start with `data_catalog.json`
2. **Building queries**: Use patterns from `query_patterns.json`
3. **Ensuring correctness**: Follow rules in `business_rules.json`
4. **Learning by example**: Study `query_cookbook.json`

## Key Design Principles

### 1. Separation of Concerns
- Each file has ONE clear purpose
- No mixing of different types of knowledge
- Easy to find what you need

### 2. Don't Document the Obvious
- LLMs already understand "revenue" = "sales"
- Focus on system-specific mappings
- Document what's unique to StoreHub

### 3. Practical Patterns
- Based on actual production queries
- Tested and optimized
- Cover 80% of real use cases

### 4. Safety First
- Mandatory multi-tenant isolation
- Performance guards
- Data access controls

## Maintenance Guide

### Adding New Metrics
1. Update `data_catalog.json` with calculation
2. Add validation rules if needed
3. Create example in cookbook
4. Test with sample queries

### Schema Changes
1. Update table definitions in data_catalog
2. Check if patterns need adjustment
3. Update examples if affected
4. Version the changes

### Performance Tuning
1. Add new optimization patterns
2. Update source selection logic
3. Document in pattern notes

## Common Queries Quick Reference

| Question Type | Pattern | Example |
|--------------|---------|---------|
| Current metrics | Simple aggregation | "What's today's revenue?" |
| Trends | Time series | "Show daily sales this month" |
| Rankings | Top N | "Top 10 customers by value" |
| Comparisons | Period over period | "This month vs last month" |
| Segmentation | Customer cohorts | "Customer retention by cohort" |

## Performance Tips

1. **Use pre-aggregated sources** when available (dashboard, transformations)
2. **Always include date filters** to limit data scanned
3. **Check indexes** - business and createdtime should be first
4. **Limit result sets** - pagination for large results

## Schema Validation Layer

### Overview
The `validation/` directory contains tools for validating generated SQL against the actual database schema. This provides an additional safety layer to prevent runtime errors.

### Components

#### 1. `schema_lookup.py` - Schema Discovery
- Loads and indexes database schema from SQL files
- Provides case-insensitive table and column lookup
- Handles schema variations and naming patterns

#### 2. `sql_builder_with_validation.py` - Validated SQL Builder
- Validates all table and column references before query generation
- Integrates with semantic layer JSON files
- Provides helpful error messages with available alternatives

#### 3. `schema_validation.json` - Configuration
- Defines schema sources and validation rules
- Maps semantic names to physical schema

### Usage

```python
from validation.sql_builder_with_validation import ValidatedSQLBuilder
from validation.schema_lookup import SchemaLookup

# Initialize with schema files
schema_files = ['path/to/schema.sql']
builder = ValidatedSQLBuilder(schema_files, 'semantic_layer_v2/')

# Validate table exists
try:
    table_name = builder.validate_table('businesses')
    # Returns: 'storehub_mongo_test.businesses'
except ValueError as e:
    print(f"Invalid table: {e}")

# Validate column exists in table
try:
    column_name = builder.validate_column('businesses', 'name')
    # Returns: 'name' (validated)
except ValueError as e:
    print(f"Invalid column: {e}")
    # Error includes list of valid columns

# Build validated queries
query = builder.build_sales_query(
    date_from='2024-01-01',
    date_to='2024-01-31',
    business_id='test_merchant'
)
```

### Integration Points

1. **Pre-execution Validation**: Run validation before query execution
2. **Development Time**: Validate during query pattern development
3. **Testing**: Ensure all query patterns use valid schema references
4. **CI/CD**: Automated validation of semantic layer against schema changes

### Current Status
⚠️ **Note**: The validation layer exists but is not yet fully integrated into the main query generation flow. It can be used standalone for validating queries during development.

## Security Reminders

- **Always include** `business = :business_id` filter
- **Default exclude** soft-deleted records
- **Check permissions** for sensitive fields
- **Audit log** access to PII data
- **Validate schema** before query execution

## Version History

- **v2.0.0** (2025-01-15): Clean architecture redesign
  - Reduced from 10+ files to 5 focused files
  - Clear separation of concerns
  - Production-ready patterns

## Future Enhancements

1. **Auto-learning**: Track successful queries to improve patterns
2. **Industry variants**: Retail vs F&B specific patterns  
3. **Multi-language**: Support queries in other languages
4. **Real-time updates**: Sync with schema changes automatically

---

This semantic layer provides everything needed for accurate NL-to-SQL translation while remaining simple, maintainable, and performant. The 5-file architecture balances completeness with practicality, focusing on what truly matters for production use.