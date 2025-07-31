# Schema Validation Tools

This directory contains tools for validating SQL queries against the actual database schema, providing an additional safety layer for the semantic layer system.

## Purpose

While the semantic layer JSON files define the business logic and query patterns, these validation tools ensure that generated SQL references only valid tables and columns that actually exist in the database. This prevents runtime errors and improves developer experience with helpful error messages.

## Components

### 1. `schema_lookup.py`
Core schema discovery and lookup functionality:
- Loads database schema from SQL DDL files
- Provides case-insensitive table and column search
- Handles schema namespaces (e.g., `storehub_mongo_test.businesses`)
- Caches schema information for performance

### 2. `sql_builder_with_validation.py`
SQL builder that validates all references:
- Integrates with semantic layer JSON files
- Validates tables and columns before query generation
- Provides specific error messages with available alternatives
- Example implementation of validated query building

### 3. `query_validator.py`
Standalone query validator for existing systems:
- Can validate any SQL query string
- Extracts and validates all table/column references
- Provides decorator for easy integration
- Returns detailed validation results with errors and warnings

### 4. `example_integration.py`
Shows how to integrate validation into the semantic layer:
- Complete example of validation in the query generation pipeline
- Demonstrates error handling and fallback strategies
- Shows how to wire validation into existing flows

## Usage Examples

### Basic Validation
```python
from validation.schema_lookup import SchemaLookup

# Initialize with schema files
schema = SchemaLookup(['path/to/schema.sql'])

# Find tables
tables = schema.find_table('businesses')
# Returns: ['storehub_mongo_test.businesses']

# Find columns
columns = schema.find_columns('businesses', 'name')
# Returns: [{'table': 'storehub_mongo_test.businesses', 'column': 'name', 'type': 'varchar(255)'}]
```

### Query Validation
```python
from validation.query_validator import QueryValidator

# Initialize validator
validator = QueryValidator(['path/to/schema.sql'])

# Validate a query
result = validator.validate_query("""
    SELECT b.name, COUNT(*)
    FROM businesses b
    WHERE b.country = 'MY'
    GROUP BY b.name
""")

if result['valid']:
    print("Query is valid!")
else:
    print(f"Errors: {result['errors']}")
```

### Using the Decorator
```python
from validation.query_validator import validate_sql

@validate_sql(['path/to/schema.sql'])
def generate_sales_query(date_from, date_to):
    return f"""
        SELECT SUM(amount) as total_sales
        FROM transactionrecords
        WHERE createdtime BETWEEN '{date_from}' AND '{date_to}'
    """

# Will raise ValueError if query references invalid tables/columns
query = generate_sales_query('2024-01-01', '2024-01-31')
```

### Integrated SQL Builder
```python
from validation.sql_builder_with_validation import ValidatedSQLBuilder

# Initialize with schema and semantic layer
builder = ValidatedSQLBuilder(
    schema_files=['path/to/schema.sql'],
    semantic_layer_path='../'
)

# Validate before building
try:
    table = builder.validate_table('businesses')
    column = builder.validate_column('businesses', 'name')
    
    # Build query with confidence
    query = builder.build_custom_query(table, column)
except ValueError as e:
    print(f"Validation error: {e}")
```

## Integration Strategy

### Option 1: Minimal Integration (Recommended for existing systems)
Add validation as a final step before query execution:
```python
# Existing query generation
sql = generate_query_from_nl(user_input)

# Add validation
validator = QueryValidator(schema_files)
result = validator.validate_query(sql)

if not result['valid']:
    raise QueryValidationError(result['errors'])

# Execute validated query
cursor.execute(sql)
```

### Option 2: Full Integration
Replace query generation with validated builder:
```python
# Instead of string manipulation
# sql = f"SELECT * FROM {table} WHERE {condition}"

# Use validated builder
sql = builder.build_query(
    table=builder.validate_table(table),
    condition=condition
)
```

### Option 3: Development-Time Validation
Use during development and testing only:
```python
if settings.DEBUG:
    validator = QueryValidator(schema_files)
    assert validator.validate_query(sql)['valid']
```

## Schema Files

The validation tools expect SQL DDL files with CREATE TABLE statements:
```sql
CREATE TABLE storehub_mongo_test.businesses (
    _id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    country VARCHAR(2),
    isdeleted BOOLEAN,
    ...
);
```

Place schema files in a designated directory and reference them when initializing the validators.

## Performance Considerations

- Schema is loaded and indexed once at initialization
- Table/column lookups are O(1) after initial indexing
- Validation adds minimal overhead (<10ms for typical queries)
- Cache validation results for repeated queries

## Future Enhancements

1. **Auto-update from Database**: Query system catalogs instead of static files
2. **Query Plan Validation**: Check estimated query cost
3. **Permission Validation**: Verify user has access to referenced tables
4. **Smart Suggestions**: Use edit distance for better "did you mean?" suggestions
5. **SQL Injection Detection**: Add security validation rules

## Troubleshooting

### "Table not found" errors
- Check schema files include all tables
- Verify table names include schema prefix
- Use case-insensitive search

### Performance issues
- Cache validator instances
- Pre-load schema at application startup
- Use validation in development only if needed

### Integration problems
- Start with the decorator approach
- Add logging to see what's being validated
- Test with known-good queries first