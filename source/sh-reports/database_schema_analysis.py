#!/usr/bin/env python3
"""
Database Schema Analysis Script
Analyzes the storehub MongoDB database schema from SQL export files
"""

import re
from collections import defaultdict, Counter
import json

def parse_sql_files(file1_path, file2_path):
    """Parse SQL files and extract table/column information"""
    tables = defaultdict(list)
    
    # Pattern to match INSERT statements
    pattern = r"\('storehub_mongo','([^']+)','([^']+)','([^']+)'\)"
    
    # Read and parse both files
    for file_path in [file1_path, file2_path]:
        try:
            with open(file_path, 'r') as f:
                content = f.read()
                matches = re.findall(pattern, content)
                
                for match in matches:
                    table_name = match[0]
                    column_name = match[1]
                    data_type = match[2]
                    
                    tables[table_name].append({
                        'column_name': column_name,
                        'data_type': data_type
                    })
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
    
    return tables

def analyze_schema(tables):
    """Analyze the database schema and generate statistics"""
    stats = {
        'total_tables': 0,
        'total_columns': 0,
        'table_categories': defaultdict(int),
        'data_types': Counter(),
        'staging_tables': [],
        'main_tables': [],
        'nested_tables': []
    }
    
    for table_name, columns in tables.items():
        stats['total_tables'] += 1
        stats['total_columns'] += len(columns)
        
        # Categorize tables
        if '__staging' in table_name:
            stats['staging_tables'].append(table_name)
        elif '__' in table_name:
            stats['nested_tables'].append(table_name)
        else:
            stats['main_tables'].append(table_name)
        
        # Count data types
        for col in columns:
            stats['data_types'][col['data_type']] += 1
        
        # Categorize by business domain
        if any(keyword in table_name.lower() for keyword in ['transaction', 'order', 'payment']):
            stats['table_categories']['Commerce'] += 1
        elif any(keyword in table_name.lower() for keyword in ['customer', 'consumer', 'member']):
            stats['table_categories']['Customer Management'] += 1
        elif any(keyword in table_name.lower() for keyword in ['product', 'inventory', 'stock']):
            stats['table_categories']['Inventory'] += 1
        elif any(keyword in table_name.lower() for keyword in ['business', 'store', 'merchant']):
            stats['table_categories']['Business Management'] += 1
        elif any(keyword in table_name.lower() for keyword in ['loyalty', 'promotion', 'campaign']):
            stats['table_categories']['Marketing & Loyalty'] += 1
        elif any(keyword in table_name.lower() for keyword in ['logistics', 'shipping', 'delivery']):
            stats['table_categories']['Logistics'] += 1
        else:
            stats['table_categories']['Other'] += 1
    
    return stats

def generate_report(tables, stats):
    """Generate a comprehensive report of the database schema"""
    report = []
    
    report.append("# StoreHub MongoDB Database Schema Analysis\n")
    report.append("## Overview Statistics\n")
    report.append(f"- Total Tables: {stats['total_tables']}")
    report.append(f"- Total Columns: {stats['total_columns']}")
    report.append(f"- Main Tables: {len(stats['main_tables'])}")
    report.append(f"- Nested Tables: {len(stats['nested_tables'])}")
    report.append(f"- Staging Tables: {len(stats['staging_tables'])}\n")
    
    report.append("## Table Categories by Business Domain\n")
    for category, count in sorted(stats['table_categories'].items(), key=lambda x: x[1], reverse=True):
        report.append(f"- {category}: {count} tables")
    
    report.append("\n## Data Types Distribution\n")
    for dtype, count in stats['data_types'].most_common():
        report.append(f"- {dtype}: {count} columns")
    
    report.append("\n## Main Tables Overview\n")
    
    # Group main tables by category
    categorized_tables = {
        'Commerce & Transactions': [],
        'Customer Management': [],
        'Product & Inventory': [],
        'Business & Store Management': [],
        'Marketing & Loyalty': [],
        'Logistics & Delivery': [],
        'Financial & Payments': [],
        'Other': []
    }
    
    for table in sorted(stats['main_tables']):
        if any(keyword in table.lower() for keyword in ['transaction', 'order', 'shift', 'receipt']):
            categorized_tables['Commerce & Transactions'].append(table)
        elif any(keyword in table.lower() for keyword in ['customer', 'consumer', 'member', 'user']):
            categorized_tables['Customer Management'].append(table)
        elif any(keyword in table.lower() for keyword in ['product', 'inventory', 'stock']):
            categorized_tables['Product & Inventory'].append(table)
        elif any(keyword in table.lower() for keyword in ['business', 'store', 'employee']):
            categorized_tables['Business & Store Management'].append(table)
        elif any(keyword in table.lower() for keyword in ['loyalty', 'promotion', 'campaign', 'reward']):
            categorized_tables['Marketing & Loyalty'].append(table)
        elif any(keyword in table.lower() for keyword in ['logistics', 'shipping', 'delivery']):
            categorized_tables['Logistics & Delivery'].append(table)
        elif any(keyword in table.lower() for keyword in ['payment', 'payout', 'gateway', 'settlement']):
            categorized_tables['Financial & Payments'].append(table)
        else:
            categorized_tables['Other'].append(table)
    
    for category, table_list in categorized_tables.items():
        if table_list:
            report.append(f"\n### {category}")
            for table in table_list:
                col_count = len(tables[table])
                report.append(f"- **{table}** ({col_count} columns)")
                
                # Show key columns for important tables
                if table in ['transactionrecords', 'customers', 'products', 'businesses', 'orders']:
                    report.append("  - Key columns:")
                    key_cols = [col for col in tables[table][:10]]  # Show first 10 columns
                    for col in key_cols:
                        report.append(f"    - {col['column_name']} ({col['data_type']})")
                    if len(tables[table]) > 10:
                        report.append(f"    - ... and {len(tables[table]) - 10} more columns")
    
    report.append("\n## Nested Tables Structure\n")
    
    # Group nested tables by parent
    nested_by_parent = defaultdict(list)
    for table in stats['nested_tables']:
        parent = table.split('__')[0]
        nested_by_parent[parent].append(table)
    
    for parent, nested_list in sorted(nested_by_parent.items()):
        if parent in stats['main_tables']:
            report.append(f"\n### {parent}")
            for nested in sorted(nested_list):
                nested_part = '__'.join(nested.split('__')[1:])
                col_count = len(tables[nested])
                report.append(f"  - {nested_part} ({col_count} columns)")
    
    return '\n'.join(report)

def generate_detailed_schema(tables):
    """Generate detailed schema documentation for key tables"""
    key_tables = [
        'transactionrecords', 'customers', 'products', 'businesses', 
        'orders', 'inventories', 'promotions', 'logistics'
    ]
    
    detailed = []
    detailed.append("# Detailed Schema for Key Tables\n")
    
    for table_name in key_tables:
        if table_name in tables:
            detailed.append(f"\n## {table_name}")
            detailed.append(f"Total columns: {len(tables[table_name])}\n")
            
            # Group columns by category
            id_cols = []
            time_cols = []
            amount_cols = []
            status_cols = []
            ref_cols = []
            other_cols = []
            
            for col in tables[table_name]:
                col_name = col['column_name']
                if col_name in ['_id', 'id'] or col_name.endswith('id'):
                    id_cols.append(col)
                elif 'time' in col_name or 'date' in col_name:
                    time_cols.append(col)
                elif any(keyword in col_name for keyword in ['amount', 'price', 'cost', 'fee', 'total', 'tax']):
                    amount_cols.append(col)
                elif 'status' in col_name:
                    status_cols.append(col)
                elif any(keyword in col_name for keyword in ['ref', 'foreign']):
                    ref_cols.append(col)
                else:
                    other_cols.append(col)
            
            for category, cols in [
                ("### ID Fields", id_cols),
                ("### Date/Time Fields", time_cols),
                ("### Amount/Financial Fields", amount_cols),
                ("### Status Fields", status_cols),
                ("### Reference Fields", ref_cols),
                ("### Other Fields", other_cols[:20])  # Limit other fields
            ]:
                if cols:
                    detailed.append(f"\n{category}")
                    for col in cols:
                        detailed.append(f"- {col['column_name']} ({col['data_type']})")
                    
                    if category == "### Other Fields" and len(other_cols) > 20:
                        detailed.append(f"- ... and {len(other_cols) - 20} more fields")
    
    return '\n'.join(detailed)

if __name__ == "__main__":
    # Parse the SQL files
    tables = parse_sql_files('storehub-table1.sql', 'storehub-table2.sql')
    
    # Analyze the schema
    stats = analyze_schema(tables)
    
    # Generate reports
    overview_report = generate_report(tables, stats)
    detailed_report = generate_detailed_schema(tables)
    
    # Save reports
    with open('database_schema_overview.md', 'w') as f:
        f.write(overview_report)
    
    with open('database_schema_detailed.md', 'w') as f:
        f.write(detailed_report)
    
    # Save raw data as JSON for further analysis
    schema_data = {
        'tables': {name: cols for name, cols in tables.items()},
        'statistics': {
            'total_tables': stats['total_tables'],
            'total_columns': stats['total_columns'],
            'table_categories': dict(stats['table_categories']),
            'data_types': dict(stats['data_types']),
            'main_tables': sorted(stats['main_tables']),
            'nested_tables': sorted(stats['nested_tables']),
            'staging_tables': sorted(stats['staging_tables'])
        }
    }
    
    with open('database_schema.json', 'w') as f:
        json.dump(schema_data, f, indent=2)
    
    print("Analysis complete! Generated files:")
    print("- database_schema_overview.md")
    print("- database_schema_detailed.md") 
    print("- database_schema.json")