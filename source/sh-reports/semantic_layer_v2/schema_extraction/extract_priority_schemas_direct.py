#!/usr/bin/env python3
"""
Extract schemas for 172 priority tables by directly parsing SQL files
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

def parse_sql_files(file_paths, priority_tables):
    """Parse SQL files to extract schema information for priority tables"""
    
    schemas = {}
    current_table = None
    current_schema = None
    table_content = []
    in_table_def = False
    
    for file_path in file_paths:
        print(f"Parsing {file_path}...")
        
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
        
        for i, line in enumerate(lines):
            # Check for CREATE TABLE statement
            create_match = re.match(r'CREATE TABLE\s+(?:IF NOT EXISTS\s+)?([`"]?)(\w+)\.(\w+)\1', line, re.IGNORECASE)
            if create_match:
                # Save previous table if it was a priority table
                if current_table and current_table in priority_tables:
                    schemas[current_table] = parse_table_definition(
                        table_content, 
                        current_schema, 
                        current_table,
                        priority_tables[current_table]
                    )
                
                # Start new table
                current_schema = create_match.group(2)
                current_table = create_match.group(3)
                table_content = [line]
                in_table_def = True
                
            elif in_table_def:
                table_content.append(line)
                # Check if we've reached the end of table definition
                if ');' in line or ') ;' in line:
                    in_table_def = False
                    # Save if it's a priority table
                    if current_table and current_table in priority_tables:
                        schemas[current_table] = parse_table_definition(
                            table_content, 
                            current_schema, 
                            current_table,
                            priority_tables[current_table]
                        )
                    current_table = None
                    table_content = []
    
    return schemas

def parse_table_definition(lines, schema_name, table_name, table_info):
    """Parse a CREATE TABLE statement to extract column information"""
    
    table_def = {
        'schema': schema_name,
        'table_name': table_name,
        'columns': [],
        'primary_keys': [],
        'foreign_keys': [],
        'indexes': [],
        'row_count': table_info['row_count'],
        'category': table_info['category'],
        'create_statement': ''.join(lines)
    }
    
    # Join all lines for easier parsing
    full_text = ' '.join(lines)
    
    # Extract columns
    # Pattern: column_name data_type [constraints]
    column_pattern = r'[`"]?(\w+)[`"]?\s+(\w+(?:\([^)]+\))?)\s*([^,]*?)(?:,|(?=\s*(?:PRIMARY|FOREIGN|INDEX|UNIQUE|CHECK|\))))'
    
    in_columns = False
    for line in lines[1:-1]:  # Skip CREATE TABLE and closing );
        line = line.strip()
        if not line:
            continue
            
        # Skip constraint definitions
        if any(keyword in line.upper() for keyword in ['PRIMARY KEY', 'FOREIGN KEY', 'INDEX', 'UNIQUE KEY', 'CHECK']):
            # Extract primary key
            if 'PRIMARY KEY' in line.upper():
                pk_match = re.search(r'PRIMARY KEY\s*\(([^)]+)\)', line, re.IGNORECASE)
                if pk_match:
                    pk_cols = [col.strip().strip('`"') for col in pk_match.group(1).split(',')]
                    table_def['primary_keys'].extend(pk_cols)
            
            # Extract foreign key
            elif 'FOREIGN KEY' in line.upper():
                fk_match = re.search(r'FOREIGN KEY\s*\(([^)]+)\)\s*REFERENCES\s+([`"]?)(\w+)\.?(\w+)\2\s*\(([^)]+)\)', line, re.IGNORECASE)
                if fk_match:
                    fk_cols = fk_match.group(1).strip().strip('`"')
                    ref_table = fk_match.group(4) if fk_match.group(4) else fk_match.group(3)
                    ref_col = fk_match.group(5).strip().strip('`"')
                    table_def['foreign_keys'].append({
                        'column': fk_cols,
                        'references': f"{ref_table}.{ref_col}"
                    })
            continue
        
        # Parse column definition
        col_match = re.match(r'[`"]?(\w+)[`"]?\s+(\w+(?:\([^)]+\))?)\s*(.*?)(?:,\s*)?$', line)
        if col_match:
            col_name = col_match.group(1)
            col_type = col_match.group(2)
            col_constraints = col_match.group(3) if col_match.group(3) else ''
            
            column_info = {
                'name': col_name,
                'type': col_type,
                'nullable': 'NOT NULL' not in col_constraints.upper(),
                'is_primary_key': col_name in table_def['primary_keys']
            }
            
            # Check for default value
            default_match = re.search(r'DEFAULT\s+([^,\s]+)', col_constraints, re.IGNORECASE)
            if default_match:
                column_info['default'] = default_match.group(1)
            
            # Check if it's a foreign key column
            column_info['is_foreign_key'] = any(
                fk['column'] == col_name for fk in table_def['foreign_keys']
            )
            
            table_def['columns'].append(column_info)
    
    return table_def

def save_schemas(schemas, output_file='priority_tables_schema.json'):
    """Save the extracted schemas to a JSON file"""
    
    output = {
        'total_tables': len(schemas),
        'extraction_date': str(os.popen('date').read().strip()),
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
    doc.append("# Priority Tables Schema Documentation\n")
    doc.append(f"Generated from 172 priority tables\n")
    doc.append(f"Total tables documented: {len(schemas)}\n\n")
    
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
    doc.append("## Table of Contents\n")
    for category, tables, total_rows in category_stats:
        doc.append(f"- [{category}](#{category.lower().replace(' ', '-')}) ({len(tables)} tables, {total_rows:,} rows)\n")
    
    doc.append("\n---\n")
    
    # Document each category
    for category, tables, total_rows in category_stats:
        doc.append(f"\n## {category}\n")
        doc.append(f"**Tables:** {len(tables)} | **Total Rows:** {total_rows:,}\n\n")
        
        # Sort tables by row count
        tables.sort(key=lambda x: x[1]['row_count'], reverse=True)
        
        for table_name, table_info in tables:
            doc.append(f"### {table_name}\n")
            doc.append(f"- **Schema:** {table_info['schema']}\n")
            doc.append(f"- **Row Count:** {table_info['row_count']:,}\n")
            doc.append(f"- **Columns:** {len(table_info['columns'])}\n")
            
            if table_info['primary_keys']:
                doc.append(f"- **Primary Keys:** {', '.join(table_info['primary_keys'])}\n")
            
            if table_info['foreign_keys']:
                doc.append(f"- **Foreign Keys:** {len(table_info['foreign_keys'])}\n")
            
            doc.append("\n#### Column Details\n")
            doc.append("| Column | Type | Nullable | Key | Default |\n")
            doc.append("|--------|------|----------|-----|---------|\\n")
            
            for col in table_info['columns']:
                key_info = []
                if col.get('is_primary_key'):
                    key_info.append('PK')
                if col.get('is_foreign_key'):
                    key_info.append('FK')
                key = ', '.join(key_info) if key_info else '-'
                
                nullable = 'Yes' if col['nullable'] else 'No'
                default = col.get('default', '-')
                
                doc.append(f"| {col['name']} | {col['type']} | {nullable} | {key} | {default} |\n")
            
            if table_info['foreign_keys']:
                doc.append("\n#### Foreign Key Relationships\n")
                for fk in table_info['foreign_keys']:
                    doc.append(f"- `{fk['column']}` → `{fk['references']}`\n")
            
            doc.append("\n---\n")
    
    # Save documentation
    with open('priority_tables_schema_documentation.md', 'w') as f:
        f.writelines(doc)
    
    print("Documentation saved to priority_tables_schema_documentation.md")

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
    print("\nParsing SQL files...")
    schemas = parse_sql_files(sql_files, priority_tables)
    
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