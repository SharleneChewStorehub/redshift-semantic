#!/usr/bin/env python3
"""
Convert the extracted schema JSON to SQL INSERT statements in svv_columns format
"""

import json
import os
from datetime import datetime

def load_schema_json():
    """Load the extracted schema from JSON"""
    with open('priority_tables_schema.json', 'r') as f:
        return json.load(f)

def generate_svv_inserts(schema_data):
    """Generate INSERT statements in the same format as the original SQL files"""
    
    inserts = []
    current_values = []
    
    # Header
    inserts.append("-- Priority Tables Schema for StoreHub Semantic Layer")
    inserts.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    inserts.append(f"-- Total Tables: {schema_data['total_tables']}")
    inserts.append("-- This file contains schema definitions for the 172 priority tables")
    inserts.append("-- identified for the semantic layer development")
    inserts.append("")
    
    # Sort tables by category and row count for better organization
    tables_by_category = {}
    for table_name, table_info in schema_data['tables'].items():
        category = table_info.get('category', 'Other')
        if category not in tables_by_category:
            tables_by_category[category] = []
        tables_by_category[category].append((table_name, table_info))
    
    # Process each category
    for category in sorted(tables_by_category.keys()):
        inserts.append(f"-- =====================================================")
        inserts.append(f"-- Category: {category}")
        inserts.append(f"-- =====================================================")
        inserts.append("")
        
        # Sort tables within category by row count (descending)
        tables = sorted(tables_by_category[category], 
                       key=lambda x: x[1].get('row_count', 0), 
                       reverse=True)
        
        for table_name, table_info in tables:
            # Add table comment
            row_count = table_info.get('row_count', 0)
            inserts.append(f"-- Table: {table_name} ({row_count:,} rows)")
            
            # Process columns
            columns = table_info.get('columns', [])
            
            # Group columns into batches of 10 (matching original format)
            for i in range(0, len(columns), 10):
                batch = columns[i:i+10]
                
                # Start INSERT statement
                if i == 0 or i % 10 == 0:
                    if current_values:
                        # Close previous INSERT
                        current_values[-1] = current_values[-1].rstrip(',') + ';'
                        inserts.extend(current_values)
                        current_values = []
                    
                    inserts.append("INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES")
                
                # Add column values
                for j, col in enumerate(batch):
                    schema_name = table_info.get('schema', 'storehub_mongo')
                    col_name = col['name']
                    col_type = col['type']
                    
                    # Format the value tuple
                    value_line = f"\t ('{schema_name}','{table_name}','{col_name}','{col_type}')"
                    
                    # Add comma except for last item
                    if j < len(batch) - 1 or i + len(batch) < len(columns):
                        value_line += ","
                    
                    current_values.append(value_line)
            
            # Close the last INSERT for this table
            if current_values:
                current_values[-1] = current_values[-1].rstrip(',') + ';'
                inserts.extend(current_values)
                current_values = []
            
            inserts.append("")  # Empty line between tables
    
    return inserts

def add_metadata_section(inserts, schema_data):
    """Add a metadata section with statistics and relationships"""
    
    inserts.append("")
    inserts.append("-- =====================================================")
    inserts.append("-- METADATA AND STATISTICS")
    inserts.append("-- =====================================================")
    inserts.append("")
    
    # Calculate statistics
    total_columns = sum(len(t.get('columns', [])) for t in schema_data['tables'].values())
    total_rows = sum(t.get('row_count', 0) for t in schema_data['tables'].values())
    
    inserts.append("-- Summary Statistics:")
    inserts.append(f"-- Total Tables: {len(schema_data['tables'])}")
    inserts.append(f"-- Total Columns: {total_columns:,}")
    inserts.append(f"-- Total Rows: {total_rows:,}")
    inserts.append("")
    
    # Add relationship information as comments
    inserts.append("-- Key Relationships:")
    inserts.append("-- Primary Keys: All tables use '_id' as primary key (MongoDB convention)")
    inserts.append("-- Foreign Keys: Identified by '_foreignkey' suffix or common patterns:")
    inserts.append("--   - business/businessid -> businesses._id")
    inserts.append("--   - customerid -> customers._id")
    inserts.append("--   - productid -> products._id")
    inserts.append("--   - transactionid/receiptnumber -> transactionrecords.receiptnumber")
    inserts.append("--   - storeid -> businesses__stores._id")
    inserts.append("")
    
    # Add top 10 largest tables
    inserts.append("-- Top 10 Largest Tables:")
    tables_by_size = sorted(
        [(name, info.get('row_count', 0)) for name, info in schema_data['tables'].items()],
        key=lambda x: x[1],
        reverse=True
    )
    
    for i, (table_name, row_count) in enumerate(tables_by_size[:10], 1):
        inserts.append(f"--   {i}. {table_name}: {row_count:,} rows")
    
    inserts.append("")
    
    return inserts

def save_svv_sql(inserts, output_file='priority_tables_schema.sql'):
    """Save the INSERT statements to a SQL file"""
    
    with open(output_file, 'w') as f:
        f.write('\n'.join(inserts))
        f.write('\n')  # Final newline
    
    print(f"Schema saved to {output_file}")
    print(f"Total lines: {len(inserts):,}")
    
    # Calculate file size
    file_size = os.path.getsize(output_file)
    print(f"File size: {file_size:,} bytes ({file_size / 1024:.1f} KB)")

def main():
    """Main function to convert schema to SQL format"""
    
    # Change to the schema extraction directory
    os.chdir('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction')
    
    print("Loading schema JSON...")
    schema_data = load_schema_json()
    
    print("Generating SQL INSERT statements...")
    inserts = generate_svv_inserts(schema_data)
    
    print("Adding metadata section...")
    inserts = add_metadata_section(inserts, schema_data)
    
    print("Saving SQL file...")
    save_svv_sql(inserts)
    
    # Also create a compact version with just table names for quick reference
    print("\nCreating compact reference file...")
    
    compact = []
    compact.append("-- Priority Tables Quick Reference")
    compact.append(f"-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    compact.append("")
    
    # Group by category
    tables_by_category = {}
    for table_name, table_info in schema_data['tables'].items():
        category = table_info.get('category', 'Other')
        if category not in tables_by_category:
            tables_by_category[category] = []
        tables_by_category[category].append(table_name)
    
    for category in sorted(tables_by_category.keys()):
        compact.append(f"-- {category} ({len(tables_by_category[category])} tables)")
        for table in sorted(tables_by_category[category]):
            compact.append(f"--   {table}")
        compact.append("")
    
    with open('priority_tables_list.sql', 'w') as f:
        f.write('\n'.join(compact))
        f.write('\n')
    
    print("Compact reference saved to priority_tables_list.sql")
    print("\nConversion complete!")

if __name__ == "__main__":
    main()