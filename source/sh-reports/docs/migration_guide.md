# Migration Guide to Semantic Layer v2

This guide helps you migrate from older semantic dictionary versions to the current semantic_layer_v2.

## Quick Start

### If you're building new queries:
Use `/semantic_layer_v2/` directly - it's the production version.

### If you have existing code using older versions:
See the migration instructions below for your version.

## Migration Instructions

### From v1 (Individual Report Dictionaries)

**Old approach**:
```json
// customers.json
{
  "endpoint": "/customers",
  "parameters": {...},
  "fields": {...}
}
```

**New approach**:
```json
// data_catalog.json
{
  "business_entities": {
    "customers": {
      "primary_table": "customers",
      "key_metrics": {...}
    }
  }
}
```

**Migration steps**:
1. Don't try to convert - the approaches are too different
2. Use data_catalog.json to understand the data model
3. Use query_cookbook.json for examples
4. Rebuild queries using query_patterns.json

### From v1.5 (Unified Dictionary)

**Mapping**:
- `field_definitions.json` → `data_catalog.json`
- `relationships.json` → `data_catalog.json` (relationship_map section)
- `business_rules.json` → `business_rules.json` (enhanced)
- `synonyms.json` → `semantic_context.json`
- `validation_rules.json` → `business_rules.json`

**Key changes**:
- Shift from API structure to data model focus
- Business rules now include mandatory filters
- Validation integrated into business rules

### From v1.8 (True Dictionary)

**Mapping**:
- `data_dictionary.json` → `data_catalog.json`
- `business_glossary.json` → Split between:
  - `data_catalog.json` (metrics)
  - `semantic_context.json` (terminology)
- `query_patterns.json` → `query_patterns.json` (refined)
- `synonym_dictionary.json` → `semantic_context.json`
- `temporal_expressions.json` → `semantic_context.json`
- `validation_rules.json` → `business_rules.json`
- `examples/` → `query_cookbook.json`

**Key improvements**:
- Consolidated from 10+ files to 5 files
- Added schema validation tools
- Better separation of concerns

## Using Semantic Layer v2

### 1. Understanding the Data

```python
# Read data catalog to understand what's available
with open('semantic_layer_v2/core/data_catalog.json') as f:
    catalog = json.load(f)
    
# Find customer-related tables and fields
customer_entity = catalog['business_entities']['customers']
```

### 2. Building Queries

```python
# Use query patterns as templates
with open('semantic_layer_v2/core/query_patterns.json') as f:
    patterns = json.load(f)
    
# Select appropriate pattern
time_series = patterns['core_patterns']['time_series_aggregation']
```

### 3. Validating Queries

```python
# Use schema validation before running
from semantic_layer_v2.validation.schema_lookup import SchemaLookup

lookup = SchemaLookup(['database_schema/storehub-table1.sql'])
table_exists = lookup.find_table('customers')
```

### 4. Natural Language Processing

```python
# Use semantic context for NL understanding
with open('semantic_layer_v2/core/semantic_context.json') as f:
    context = json.load(f)
    
# Handle ambiguous terms
sales_meaning = context['default_interpretations']['metrics']['sales']
```

## Common Pitfalls

### 1. Schema Assumptions
**Wrong**: Assuming `businesses.isdeleted` exists  
**Right**: Validate with schema_lookup.py first

### 2. Hard-coded Values
**Wrong**: `WHERE country = 'Malaysia'`  
**Right**: Check semantic_context.json for variations (MY, Malaysia, etc.)

### 3. Missing Mandatory Filters
**Wrong**: `SELECT * FROM transactionrecords`  
**Right**: Always include `business = :business_id` (see business_rules.json)

## Best Practices

1. **Always validate schemas** before generating SQL
2. **Use query patterns** as building blocks
3. **Check business rules** for mandatory filters
4. **Reference cookbook** for complete examples
5. **Profile your data** to understand actual values

## Getting Help

1. Check `query_cookbook.json` for similar examples
2. Review `docs/evolution.md` to understand the journey
3. Use validation tools to catch errors early
4. See debug queries in `semantic_layer_v2/debug/` for troubleshooting patterns

## Tools and Scripts

### Schema Validation
```bash
cd semantic_layer_v2/validation
python schema_lookup.py
```

### SQL Building with Validation
```python
from sql_builder_with_validation import ValidatedSQLBuilder
builder = ValidatedSQLBuilder(schema_files, semantic_layer_path)
```

### Data Profiling
```bash
cd semantic_layer_v2/profiling
# Run profiling queries from data_profiling_queries.sql
```

Remember: v2 is designed to answer NEW questions, not just replicate old reports!