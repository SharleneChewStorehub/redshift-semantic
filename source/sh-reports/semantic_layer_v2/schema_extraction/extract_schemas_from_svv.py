#!/usr/bin/env python3
"""
Extract schemas for 172 priority tables from svv_columns INSERT statements
"""

import re
import json
import os
from collections import defaultdict

def load_priority_tables():
    """Load the list of priority tables with their row counts"""
    tables_info = {}
    
    with open('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/latestplan/172tables.md', 'r') as f:
        content = f.read()
    
    # Extract table info: | rank | `table_name` | row_count | category |
    pattern = r'\|\s*\d+\s*\|\s*`([^`]+)`\s*\|\s*([\d,]+)\s*\|\s*([^\|]+)\s*\|'
    
    for match in re.finditer(pattern, content):
        table_name = match.group(1)
        row_count = int(match.group(2).replace(',', ''))
        category = match.group(3).strip()
        tables_info[table_name] = {
            'row_count': row_count,
            'category': category
        }
    
    return tables_info

def parse_svv_columns_files(file_paths, priority_tables):
    """Parse svv_columns INSERT statements to extract schema information"""
    
    schemas = defaultdict(lambda: {
        'schema': 'storehub_mongo',
        'columns': [],
        'primary_keys': [],
        'foreign_keys': [],
        'indexes': []
    })
    
    # Pattern to match INSERT VALUES: ('schema','table','column','type')
    pattern = r"\('([^']+)','([^']+)','([^']+)','([^']+)'\)"
    
    for file_path in file_paths:
        print(f"Parsing {file_path}...")
        
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        # Find all column definitions
        matches = re.findall(pattern, content)
        
        for schema_name, table_name, column_name, data_type in matches:
            # Skip if not a priority table
            if table_name not in priority_tables:
                continue
            
            # Add column to table schema
            column_info = {
                'name': column_name,
                'type': data_type,
                'nullable': True,  # Default, since we don't have constraint info
                'is_primary_key': column_name == '_id',  # MongoDB convention
                'is_foreign_key': column_name.endswith('_foreignkey') or column_name.endswith('id')
            }
            
            schemas[table_name]['columns'].append(column_info)
            
            # Set primary key
            if column_name == '_id':
                schemas[table_name]['primary_keys'] = ['_id']
            
            # Detect foreign keys by naming convention
            if column_name.endswith('_foreignkey'):
                # Extract referenced table from column name
                ref_table = column_name.replace('_foreignkey', '')
                schemas[table_name]['foreign_keys'].append({
                    'column': column_name,
                    'references': f"{ref_table}._id"
                })
    
    # Convert to regular dict and add metadata
    result = {}
    for table_name, table_schema in schemas.items():
        if table_name in priority_tables:
            table_info = priority_tables[table_name]
            table_schema['table_name'] = table_name
            table_schema['row_count'] = table_info['row_count']
            table_schema['category'] = table_info['category']
            result[table_name] = dict(table_schema)
    
    return result

def analyze_relationships(schemas):
    """Analyze and enhance foreign key relationships based on naming patterns"""
    
    # Common relationship patterns in StoreHub
    relationship_patterns = [
        # Direct foreign keys
        (r'business$', 'businesses._id'),
        (r'businessid$', 'businesses._id'),
        (r'storeid$', 'businesses__stores._id'),
        (r'customerid$', 'customers._id'),
        (r'consumerid$', 'consumers._id'),
        (r'productid$', 'products._id'),
        (r'userid$', 'employees._id'),
        (r'employeeid$', 'employees._id'),
        (r'transactionid$', 'transactionrecords.receiptnumber'),
        (r'receiptnumber$', 'transactionrecords.receiptnumber'),
        (r'orderid$', 'orders._id'),
        (r'promotionid$', 'promotions._id'),
        (r'campaignid$', 'campaigns._id'),
        (r'supplierid$', 'suppliers._id'),
    ]
    
    for table_name, table_schema in schemas.items():
        existing_fks = {fk['column'] for fk in table_schema['foreign_keys']}
        
        for column in table_schema['columns']:
            col_name = column['name']
            
            # Skip if already identified as FK
            if col_name in existing_fks:
                continue
            
            # Check against patterns
            for pattern, reference in relationship_patterns:
                if re.search(pattern, col_name, re.IGNORECASE):
                    table_schema['foreign_keys'].append({
                        'column': col_name,
                        'references': reference,
                        'inferred': True
                    })
                    column['is_foreign_key'] = True
                    break

def save_schemas(schemas, output_file='priority_tables_schema.json'):
    """Save the extracted schemas to a JSON file"""
    
    output = {
        'total_tables': len(schemas),
        'extraction_date': str(os.popen('date').read().strip()),
        'source': 'svv_columns metadata',
        'tables': schemas
    }
    
    with open(output_file, 'w') as f:
        json.dump(output, f, indent=2)
    
    print(f"\nExtracted schemas for {len(schemas)} priority tables")
    print(f"Output saved to {output_file}")
    
    return output

def create_markdown_documentation(schemas):
    """Create a markdown documentation file for the schemas"""
    
    doc = []
    doc.append("# StoreHub Priority Tables Schema Documentation\n")
    doc.append(f"Generated from 172 priority tables based on svv_columns metadata\n")
    doc.append(f"Total tables documented: {len(schemas)}\n\n")
    
    # Calculate statistics
    total_columns = sum(len(t['columns']) for t in schemas.values())
    total_rows = sum(t['row_count'] for t in schemas.values())
    
    doc.append("## Overview Statistics\n")
    doc.append(f"- **Total Tables:** {len(schemas)}\n")
    doc.append(f"- **Total Columns:** {total_columns:,}\n")
    doc.append(f"- **Total Rows:** {total_rows:,}\n")
    doc.append(f"- **Average Columns per Table:** {total_columns // len(schemas)}\n\n")
    
    # Group by category
    categories = defaultdict(list)
    for table_name, table_info in schemas.items():
        categories[table_info['category']].append((table_name, table_info))
    
    # Sort categories by total row count
    category_stats = []
    for category, tables in categories.items():
        total_rows = sum(t[1]['row_count'] for t in tables)
        category_stats.append((category, tables, total_rows))
    
    category_stats.sort(key=lambda x: x[2], reverse=True)
    
    # Write table of contents
    doc.append("## Categories Overview\n")
    doc.append("| Category | Tables | Total Rows | % of Total |\n")
    doc.append("|----------|--------|------------|------------|\n")
    
    grand_total = sum(x[2] for x in category_stats)
    for category, tables, total_rows in category_stats:
        pct = (total_rows / grand_total) * 100 if grand_total > 0 else 0
        doc.append(f"| {category} | {len(tables)} | {total_rows:,} | {pct:.1f}% |\n")
    
    doc.append("\n---\n")
    
    # Key relationships section
    doc.append("\n## Key Relationships\n\n")
    doc.append("### Primary Tables\n")
    doc.append("- `businesses` - Core merchant/business entities\n")
    doc.append("- `customers` - Customer profiles\n") 
    doc.append("- `products` - Product catalog\n")
    doc.append("- `transactionrecords` - Sales transactions\n")
    doc.append("- `employees` - Staff/user accounts\n\n")
    
    doc.append("### Common Foreign Key Patterns\n")
    doc.append("- `*_foreignkey` - Explicit foreign key to parent table\n")
    doc.append("- `business`, `businessid` - Links to businesses._id\n")
    doc.append("- `customerid` - Links to customers._id\n")
    doc.append("- `productid` - Links to products._id\n")
    doc.append("- `transactionid`, `receiptnumber` - Links to transactionrecords\n\n")
    
    doc.append("---\n")
    
    # Document each category
    for category, tables, total_rows in category_stats:
        doc.append(f"\n## {category}\n")
        doc.append(f"**Tables:** {len(tables)} | **Total Rows:** {total_rows:,}\n\n")
        
        # Sort tables by row count
        tables.sort(key=lambda x: x[1]['row_count'], reverse=True)
        
        # Category summary table
        doc.append("| Table | Rows | Columns | Description |\n")
        doc.append("|-------|------|---------|-------------|\n")
        
        for table_name, table_info in tables:
            # Generate description based on table name
            desc = generate_table_description(table_name)
            doc.append(f"| `{table_name}` | {table_info['row_count']:,} | {len(table_info['columns'])} | {desc} |\n")
        
        doc.append("\n### Detailed Schemas\n")
        
        for table_name, table_info in tables:
            doc.append(f"\n#### {table_name}\n")
            doc.append(f"- **Row Count:** {table_info['row_count']:,}\n")
            doc.append(f"- **Columns:** {len(table_info['columns'])}\n")
            
            if table_info['foreign_keys']:
                doc.append(f"- **Relationships:** {len(table_info['foreign_keys'])}\n")
            
            # Column table
            doc.append("\n| Column | Type | Key | Description |\n")
            doc.append("|--------|------|-----|-------------|\n")
            
            # Sort columns: _id first, then foreign keys, then others
            sorted_columns = sorted(table_info['columns'], 
                key=lambda c: (c['name'] != '_id', not c['is_foreign_key'], c['name']))
            
            for col in sorted_columns:
                key_info = []
                if col.get('is_primary_key'):
                    key_info.append('PK')
                if col.get('is_foreign_key'):
                    key_info.append('FK')
                key = ', '.join(key_info) if key_info else ''
                
                # Generate column description
                col_desc = generate_column_description(col['name'], table_name)
                
                doc.append(f"| {col['name']} | {col['type']} | {key} | {col_desc} |\n")
            
            if table_info['foreign_keys']:
                doc.append("\n**Relationships:**\n")
                for fk in table_info['foreign_keys']:
                    inferred = " *(inferred)*" if fk.get('inferred') else ""
                    doc.append(f"- `{fk['column']}` → `{fk['references']}`{inferred}\n")
        
        doc.append("\n---\n")
    
    # Save documentation
    with open('priority_tables_schema_documentation.md', 'w') as f:
        f.writelines(doc)
    
    print("Documentation saved to priority_tables_schema_documentation.md")

def generate_table_description(table_name):
    """Generate a description based on table name patterns"""
    
    # Remove double underscores for analysis
    parts = table_name.split('__')
    
    if len(parts) > 1:
        parent = parts[0]
        child = parts[1]
        
        # Common patterns
        if parent == 'transactionrecords':
            if child == 'items':
                return "Line items for each transaction"
            elif child == 'payments':
                return "Payment methods used in transactions"
            elif child == 'location':
                return "Geographic location of transactions"
            elif child == 'promotions':
                return "Promotions applied to transactions"
        elif parent == 'products':
            if child == 'variations':
                return "Product variants (size, color, etc)"
            elif child == 'pricebooks':
                return "Pricing rules for products"
        elif parent == 'businesses':
            if child == 'stores':
                return "Physical store locations"
            elif child == 'paymentoptions':
                return "Payment methods accepted"
    
    # Single table descriptions
    descriptions = {
        'transactionrecords': 'Sales and return transactions',
        'customers': 'Customer profiles and information',
        'products': 'Product catalog and inventory',
        'businesses': 'Merchant/business accounts',
        'employees': 'Staff and user accounts',
        'orders': 'Online orders',
        'promotions': 'Discount and promotion rules',
        'campaigns': 'Marketing campaigns',
        'loyaltychangelogs': 'Customer loyalty point transactions',
        'inventories': 'Stock levels and inventory tracking'
    }
    
    return descriptions.get(table_name, table_name.replace('_', ' ').title())

def generate_column_description(column_name, table_name):
    """Generate a description based on column name patterns"""
    
    common_columns = {
        '_id': 'Unique identifier',
        'createdtime': 'Record creation timestamp',
        'updatedtime': 'Last update timestamp',
        'modifiedtime': 'Last modification timestamp',
        'data_modified_time': 'ETL update timestamp',
        'isdeleted': 'Soft delete flag',
        'status': 'Record status',
        'name': 'Display name',
        'title': 'Title or name',
        'description': 'Description text',
        'amount': 'Monetary amount',
        'total': 'Total amount',
        'subtotal': 'Subtotal before tax/discount',
        'tax': 'Tax amount',
        'discount': 'Discount amount',
        'quantity': 'Quantity',
        'price': 'Unit price',
        'currency': 'Currency code',
        'country': 'Country code',
        'email': 'Email address',
        'phone': 'Phone number',
        'address': 'Address',
        'type': 'Type or category'
    }
    
    # Check common columns first
    if column_name in common_columns:
        return common_columns[column_name]
    
    # Check suffixes
    if column_name.endswith('_foreignkey'):
        ref_table = column_name.replace('_foreignkey', '')
        return f"Foreign key to {ref_table}"
    elif column_name.endswith('id'):
        ref_entity = column_name[:-2]
        return f"Reference to {ref_entity}"
    elif column_name.endswith('time'):
        return "Timestamp"
    elif column_name.endswith('date'):
        return "Date"
    elif column_name.endswith('count'):
        return "Count/quantity"
    elif column_name.endswith('amount'):
        return "Amount value"
    
    return ""

def main():
    """Main function to extract and document schemas"""
    
    # Change to the schema extraction directory
    os.chdir('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction')
    
    # Load priority tables
    print("Loading priority tables...")
    priority_tables = load_priority_tables()
    print(f"Loaded {len(priority_tables)} priority tables")
    
    # Define SQL files to parse
    sql_files = [
        '/Users/fongy/Code/sh-reportsapi/database_schema/storehub-table1.sql',
        '/Users/fongy/Code/sh-reportsapi/database_schema/storehub-table2.sql'
    ]
    
    # Parse SQL files
    print("\nParsing svv_columns data...")
    schemas = parse_svv_columns_files(sql_files, priority_tables)
    
    # Analyze relationships
    print("Analyzing relationships...")
    analyze_relationships(schemas)
    
    # Save schemas
    schema_data = save_schemas(schemas)
    
    # Create documentation
    create_markdown_documentation(schemas)
    
    # Print summary
    print("\n=== Summary ===")
    print(f"Priority tables requested: {len(priority_tables)}")
    print(f"Tables found and extracted: {len(schemas)}")
    print(f"Tables not found: {len(priority_tables) - len(schemas)}")
    
    # List missing tables
    missing = set(priority_tables.keys()) - set(schemas.keys())
    if missing:
        print(f"\nMissing tables ({len(missing)}):")
        for table in sorted(missing)[:10]:
            print(f"  - {table}")
        if len(missing) > 10:
            print(f"  ... and {len(missing) - 10} more")

if __name__ == "__main__":
    main()