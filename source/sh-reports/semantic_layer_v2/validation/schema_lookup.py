#!/usr/bin/env python3
"""
Schema Lookup Tool - Quick reference for table and column names
Use this before generating any SQL queries
"""

import re
import sys
from pathlib import Path


class SchemaLookup:
    def __init__(self, schema_files):
        self.schema_files = schema_files
        self.schema_data = {}
        self._load_schemas()
    
    def _load_schemas(self):
        """Load and parse schema files"""
        for file_path in self.schema_files:
            if Path(file_path).exists():
                with open(file_path, 'r') as f:
                    content = f.read()
                    # Extract schema information
                    pattern = r"\('([^']+)','([^']+)','([^']+)','([^']+)'\)"
                    matches = re.findall(pattern, content)
                    
                    for schema, table, column, dtype in matches:
                        if schema not in self.schema_data:
                            self.schema_data[schema] = {}
                        if table not in self.schema_data[schema]:
                            self.schema_data[schema][table] = []
                        self.schema_data[schema][table].append({
                            'column': column,
                            'type': dtype
                        })
    
    def find_table(self, table_name):
        """Find exact table name (case-insensitive)"""
        results = []
        for schema, tables in self.schema_data.items():
            for table in tables:
                if table.lower() == table_name.lower():
                    results.append(f"{schema}.{table}")
        return results
    
    def find_columns(self, table_name, column_pattern=None):
        """Find columns for a table, optionally filtered by pattern"""
        results = []
        for schema, tables in self.schema_data.items():
            for table, columns in tables.items():
                if table.lower() == table_name.lower():
                    for col_info in columns:
                        if column_pattern is None or column_pattern.lower() in col_info['column'].lower():
                            results.append({
                                'table': f"{schema}.{table}",
                                'column': col_info['column'],
                                'type': col_info['type']
                            })
        return results
    
    def search_column_across_tables(self, column_pattern):
        """Search for columns across all tables"""
        results = []
        for schema, tables in self.schema_data.items():
            for table, columns in tables.items():
                for col_info in columns:
                    if column_pattern.lower() in col_info['column'].lower():
                        results.append({
                            'table': f"{schema}.{table}",
                            'column': col_info['column'],
                            'type': col_info['type']
                        })
        return results
    
    def get_table_schema(self, table_name):
        """Get complete schema for a table"""
        for schema, tables in self.schema_data.items():
            for table, columns in tables.items():
                if table.lower() == table_name.lower():
                    return {
                        'table': f"{schema}.{table}",
                        'columns': columns
                    }
        return None


def main():
    # Example usage
    schema_files = [
        '/Users/fongy/Code/sh-reportsapi/storehub-table1.sql',
        '/Users/fongy/Code/sh-reportsapi/storehub-table2.sql'
    ]
    
    lookup = SchemaLookup(schema_files)
    
    # Example queries
    print("=== Finding products table ===")
    print(lookup.find_table('products'))
    
    print("\n=== Finding columns in products table ===")
    cols = lookup.find_columns('products', 'name')
    for col in cols[:5]:
        print(f"  {col['column']} ({col['type']})")
    
    print("\n=== Searching for 'title' columns across all tables ===")
    title_cols = lookup.search_column_across_tables('title')
    for col in title_cols[:5]:
        print(f"  {col['table']}.{col['column']}")
    
    print("\n=== Getting full schema for businesses table ===")
    schema = lookup.get_table_schema('businesses')
    if schema:
        print(f"Table: {schema['table']}")
        print(f"Columns: {len(schema['columns'])}")
        for col in schema['columns'][:10]:
            print(f"  - {col['column']} ({col['type']})")


if __name__ == "__main__":
    main()