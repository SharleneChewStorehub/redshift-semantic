#!/usr/bin/env python3
"""
Create a compact schema file optimized for LLM reference
"""

import json
import os
from datetime import datetime

def load_schema_json():
    """Load the extracted schema from JSON"""
    with open('priority_tables_schema.json', 'r') as f:
        return json.load(f)

def generate_compact_schema(schema_data):
    """Generate a compact schema format optimized for LLM consumption"""
    
    lines = []
    
    # Minimal header
    lines.append(f"-- StoreHub Priority Tables Schema (172 tables, 2.5K columns, 6.2B rows)")
    lines.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d')}")
    lines.append("-- Schema: storehub_mongo (all tables)")
    lines.append("")
    
    # Sort tables by row count (descending) for importance
    tables_sorted = sorted(
        schema_data['tables'].items(),
        key=lambda x: x[1].get('row_count', 0),
        reverse=True
    )
    
    # Process each table in a compact format
    for table_name, table_info in tables_sorted:
        row_count = table_info.get('row_count', 0)
        category = table_info.get('category', 'Other')
        
        # Table header - single line
        lines.append(f"-- {table_name} ({row_count:,} rows, {category})")
        
        # Columns - batch format, multiple columns per line
        columns = table_info.get('columns', [])
        
        # Group columns by type for even more compact representation
        columns_by_type = {}
        for col in columns:
            col_type = col['type']
            if col_type not in columns_by_type:
                columns_by_type[col_type] = []
            columns_by_type[col_type].append(col['name'])
        
        # Output columns grouped by type
        for col_type, col_names in columns_by_type.items():
            # Put multiple columns of the same type on one line
            if col_type == 'character varying':
                col_type_short = 'varchar'
            elif col_type == 'timestamp without time zone':
                col_type_short = 'timestamp'
            elif col_type == 'double precision':
                col_type_short = 'double'
            else:
                col_type_short = col_type
            
            # Batch columns in groups of 5-8 for readability
            for i in range(0, len(col_names), 6):
                batch = col_names[i:i+6]
                lines.append(f"{col_type_short}: {', '.join(batch)}")
        
        lines.append("")  # Single blank line between tables
    
    # Compact metadata at the end
    lines.append("-- KEY PATTERNS:")
    lines.append("-- PK: _id | FK: *_foreignkey, businessid->businesses, customerid->customers, productid->products")
    lines.append("-- Dates: createdtime, updatedtime, data_modified_time | Flags: isdeleted, isactive")
    lines.append("-- Money: amount, total, subtotal, price, cost, discount, tax")
    
    return lines

def generate_ultra_compact_schema(schema_data):
    """Generate an ultra-compact single-line-per-table format"""
    
    lines = []
    
    # Ultra minimal header
    lines.append("# StoreHub Schema (storehub_mongo.* - 172 tables)")
    lines.append("")
    
    # Sort by row count
    tables_sorted = sorted(
        schema_data['tables'].items(),
        key=lambda x: x[1].get('row_count', 0),
        reverse=True
    )
    
    # One line per table with essential columns only
    for table_name, table_info in tables_sorted:
        columns = table_info.get('columns', [])
        row_count = table_info.get('row_count', 0)
        
        # Get key columns (id, foreign keys, important fields)
        key_columns = []
        other_columns = []
        
        for col in columns:
            col_name = col['name']
            if (col_name == '_id' or 
                col_name.endswith('_foreignkey') or 
                col_name.endswith('id') or
                col_name in ['name', 'title', 'type', 'status', 'amount', 'total', 'quantity', 'price']):
                key_columns.append(col_name)
            else:
                other_columns.append(col_name)
        
        # Format: table_name(row_count): key_cols... [+N more]
        if len(other_columns) > 0:
            cols_str = f"{', '.join(key_columns[:10])} [+{len(other_columns)} more]"
        else:
            cols_str = ', '.join(key_columns)
            
        lines.append(f"{table_name}({row_count:,}): {cols_str}")
    
    return lines

def save_schemas(schema_data):
    """Save multiple compact versions"""
    
    # Version 1: Compact but readable
    lines1 = generate_compact_schema(schema_data)
    with open('priority_schema_compact.sql', 'w') as f:
        f.write('\n'.join(lines1))
        f.write('\n')
    
    size1 = os.path.getsize('priority_schema_compact.sql')
    print(f"Compact version saved: {size1:,} bytes ({size1/1024:.1f} KB)")
    
    # Version 2: Ultra compact
    lines2 = generate_ultra_compact_schema(schema_data)
    with open('priority_schema_ultra_compact.txt', 'w') as f:
        f.write('\n'.join(lines2))
        f.write('\n')
    
    size2 = os.path.getsize('priority_schema_ultra_compact.txt')
    print(f"Ultra compact version saved: {size2:,} bytes ({size2/1024:.1f} KB)")
    
    # Compare to original
    original_size = 250523  # from previous run
    print(f"\nSize reduction:")
    print(f"Original SQL format: {original_size:,} bytes")
    print(f"Compact format: {size1:,} bytes ({(1-size1/original_size)*100:.1f}% reduction)")
    print(f"Ultra compact: {size2:,} bytes ({(1-size2/original_size)*100:.1f}% reduction)")

def main():
    """Main function"""
    
    # Change to the schema extraction directory
    os.chdir('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction')
    
    print("Loading schema JSON...")
    schema_data = load_schema_json()
    
    print("Generating compact schemas...")
    save_schemas(schema_data)
    
    print("\nDone! Created two compact versions:")
    print("1. priority_schema_compact.sql - Grouped by data type")
    print("2. priority_schema_ultra_compact.txt - One line per table")

if __name__ == "__main__":
    main()