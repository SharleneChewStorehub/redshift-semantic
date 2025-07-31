#!/usr/bin/env python3
"""
Generate the list of 172 tables that are in Metabase and have data
"""

import json
from datetime import datetime

def generate_172_tables_list():
    """Generate the list of 172 tables with row counts"""
    
    # Load validation data
    with open('../data_samples/comprehensive_table_validation_20250711_184058.json', 'r') as f:
        validation_data = json.load(f)
    
    # Load Metabase tables
    with open('../data_samples/METABASE_TABLE_LIST_20250711_185326.json', 'r') as f:
        metabase_data = json.load(f)
    
    # Get Metabase storehub_mongo tables
    metabase_tables = set(t['name'] for t in metabase_data['tables_by_schema']['storehub_mongo'])
    
    # Get tables that are in Metabase AND have data
    tables_with_data = []
    
    for table_name in metabase_tables:
        if table_name in validation_data['table_details']:
            details = validation_data['table_details'][table_name]
            if details.get('has_data', False):
                tables_with_data.append({
                    'name': table_name,
                    'row_count': details.get('row_count', 0)
                })
    
    # Sort by row count (descending)
    tables_with_data.sort(key=lambda x: x['row_count'], reverse=True)
    
    # Generate markdown file
    with open('172tables.md', 'w') as f:
        f.write("# 172 Key Tables in Metabase with Data\n\n")
        f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("## Summary\n")
        f.write(f"- **Total tables**: 172\n")
        f.write(f"- **Total rows**: {sum(t['row_count'] for t in tables_with_data):,}\n")
        f.write(f"- **Largest table**: {tables_with_data[0]['name']} ({tables_with_data[0]['row_count']:,} rows)\n")
        f.write(f"- **Smallest table**: {tables_with_data[-1]['name']} ({tables_with_data[-1]['row_count']:,} rows)\n\n")
        
        f.write("## Complete Table List\n\n")
        f.write("| Rank | Table Name | Row Count | Category |\n")
        f.write("|------|------------|-----------|----------|\n")
        
        for i, table in enumerate(tables_with_data, 1):
            # Categorize tables
            category = categorize_table(table['name'])
            row_count_str = f"{table['row_count']:,}"
            f.write(f"| {i} | `{table['name']}` | {row_count_str} | {category} |\n")
        
        # Add category breakdown
        f.write("\n## Tables by Category\n\n")
        categories = {}
        for table in tables_with_data:
            cat = categorize_table(table['name'])
            if cat not in categories:
                categories[cat] = []
            categories[cat].append(table)
        
        for cat in sorted(categories.keys()):
            tables = categories[cat]
            total_rows = sum(t['row_count'] for t in tables)
            f.write(f"### {cat} ({len(tables)} tables, {total_rows:,} rows)\n")
            f.write("| Table | Row Count |\n")
            f.write("|-------|----------|\n")
            for table in sorted(tables, key=lambda x: x['row_count'], reverse=True)[:10]:
                f.write(f"| `{table['name']}` | {table['row_count']:,} |\n")
            if len(tables) > 10:
                f.write(f"| ... and {len(tables) - 10} more | |\n")
            f.write("\n")
    
    print(f"✅ Generated 172tables.md with {len(tables_with_data)} tables")
    return len(tables_with_data)

def categorize_table(table_name):
    """Categorize table based on name"""
    if table_name.startswith('transactionrecords'):
        return 'Transactions'
    elif table_name.startswith('businesses'):
        return 'Businesses'
    elif table_name.startswith('products'):
        return 'Products'
    elif table_name.startswith('customers') or table_name.startswith('consumers'):
        return 'Customers'
    elif 'payment' in table_name or 'payout' in table_name or 'gateway' in table_name:
        return 'Payments'
    elif 'campaign' in table_name or 'promotion' in table_name:
        return 'Marketing'
    elif 'stock' in table_name or 'inventory' in table_name:
        return 'Inventory'
    elif 'logistics' in table_name or 'shipping' in table_name:
        return 'Logistics'
    elif table_name.startswith('employees'):
        return 'Employees'
    elif 'loyalty' in table_name or 'points' in table_name or 'rewards' in table_name:
        return 'Loyalty'
    elif 'online' in table_name:
        return 'Online Store'
    elif 'qr' in table_name or 'fooddelivery' in table_name:
        return 'Digital Ordering'
    else:
        return 'Other'

if __name__ == "__main__":
    generate_172_tables_list()