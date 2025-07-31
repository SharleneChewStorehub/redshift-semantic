#!/usr/bin/env python3
"""Validate MRR/ARR query for lekmassage and withitstore"""

from schema_lookup import SchemaLookup
from query_validator import QueryValidator

# Initialize schema lookup
schema_files = [
    '/Users/fongy/Code/sh-reportsapi/database_schema/storehub-table1.sql',
    '/Users/fongy/Code/sh-reportsapi/database_schema/storehub-table2.sql'
]

lookup = SchemaLookup(schema_files)
validator = QueryValidator(schema_files)

# Read the query
with open('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/generated_queries/mrr_arr_stores_query.sql', 'r') as f:
    query = f.read()

# Validate the query
print("=== Validating MRR/ARR Query ===")
validation_result = validator.validate_query(query)

if validation_result['valid']:
    print("✅ Query is valid!")
else:
    print("❌ Query validation failed:")
    for error in validation_result['errors']:
        print(f"  - {error}")

# Check specific columns we're using
print("\n=== Checking specific columns ===")
columns_to_check = [
    ('businesses', 'name'),
    ('businesses', 'displaybusinessname'),
    ('businesses', 'mrr'),
    ('businesses', 'subscriptionstatus'),
    ('businesses', 'businesstype'),
    ('businesses', 'country'),
    ('businesses', 'currency'),
    ('businesses', 'isdeleted'),
    ('businesses__stores', 'businesses_foreignkey'),
    ('businesses__stores', 'isdeleted')
]

for table, column in columns_to_check:
    cols = lookup.find_columns(table, column)
    if cols:
        print(f"✅ {table}.{column} exists")
    else:
        print(f"❌ {table}.{column} NOT FOUND")