#!/usr/bin/env python3
"""
Extract the list of 172 priority tables from the markdown file
"""

import re
import json

def extract_priority_tables():
    """Extract the list of 172 priority tables from the markdown file"""
    
    with open('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/latestplan/172tables.md', 'r') as f:
        content = f.read()
    
    # Extract table names from the markdown table
    # Pattern: | number | `table_name` | row_count | category |
    pattern = r'\|\s*\d+\s*\|\s*`([^`]+)`\s*\|\s*[\d,]+\s*\|\s*[^\|]+\s*\|'
    
    tables = []
    for match in re.finditer(pattern, content):
        table_name = match.group(1)
        tables.append(table_name)
    
    return tables

def save_tables_list(tables):
    """Save the tables list to a JSON file"""
    output = {
        "total_tables": len(tables),
        "priority_tables": tables
    }
    
    with open('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction/priority_172_tables.json', 'w') as f:
        json.dump(output, f, indent=2)
    
    # Also save as a simple text file for easy use
    with open('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction/priority_172_tables.txt', 'w') as f:
        for table in tables:
            f.write(f"{table}\n")
    
    print(f"Extracted {len(tables)} priority tables")
    print(f"Saved to priority_172_tables.json and priority_172_tables.txt")
    
    return output

if __name__ == "__main__":
    tables = extract_priority_tables()
    save_tables_list(tables)
    
    # Print first 10 tables as verification
    print("\nFirst 10 tables:")
    for i, table in enumerate(tables[:10], 1):
        print(f"{i}. {table}")