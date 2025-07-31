#!/usr/bin/env python3
"""
Extract schemas for 172 priority tables using Gemini CLI
"""

import subprocess
import json
import os
import sys

def load_priority_tables():
    """Load the list of priority tables"""
    with open('priority_172_tables.json', 'r') as f:
        data = json.load(f)
    return data['priority_tables']

def create_gemini_prompt(tables_list):
    """Create a prompt for Gemini to extract schema information"""
    
    tables_str = '\n'.join(f"- {table}" for table in tables_list)
    
    prompt = f"""
Please analyze the SQL schema files and extract detailed schema information for the following 172 priority tables:

{tables_str}

For each table, please provide:
1. The exact CREATE TABLE statement
2. All column definitions with data types and constraints
3. Primary key and foreign key relationships
4. Indexes if any
5. Any CHECK constraints or triggers

Format the output as a JSON structure with the following format:
{{
  "tables": {{
    "table_name": {{
      "schema": "schema_name",
      "columns": [
        {{
          "name": "column_name",
          "type": "data_type",
          "nullable": true/false,
          "default": "default_value",
          "is_primary_key": true/false,
          "is_foreign_key": true/false,
          "references": "referenced_table.column"
        }}
      ],
      "primary_keys": ["col1", "col2"],
      "foreign_keys": [
        {{
          "column": "col_name",
          "references": "table.column"
        }}
      ],
      "indexes": ["index_name"],
      "row_count": number_from_172tables_md
    }}
  }}
}}

Focus only on these 172 priority tables. Skip any tables not in the list.
"""
    
    return prompt

def run_gemini_analysis():
    """Run Gemini CLI to analyze the schema files"""
    
    tables = load_priority_tables()
    prompt = create_gemini_prompt(tables)
    
    # Save prompt to a file for reference
    with open('gemini_prompt.txt', 'w') as f:
        f.write(prompt)
    
    print("Running Gemini analysis on schema files...")
    print("This may take a few minutes due to the large file size...")
    
    # Save prompt to a temporary file to avoid shell escaping issues
    prompt_file = 'gemini_prompt_temp.txt'
    with open(prompt_file, 'w') as f:
        f.write(prompt)
    
    # Construct the Gemini command using the prompt file
    cmd = [
        'gemini', '-y', '-p',
        f'"@{os.path.expanduser("~/Code/sh-reportsapi/database_schema/storehub-table1.sql")} '
        f'@{os.path.expanduser("~/Code/sh-reportsapi/database_schema/storehub-table2.sql")} '
        f'$(cat {prompt_file})"'
    ]
    
    try:
        # Run the command
        result = subprocess.run(
            ' '.join(cmd),
            shell=True,
            capture_output=True,
            text=True
        )
        
        if result.returncode == 0:
            # Save the raw output
            with open('gemini_raw_output.txt', 'w') as f:
                f.write(result.stdout)
            
            print("Gemini analysis completed successfully!")
            print("Output saved to gemini_raw_output.txt")
            
            # Try to extract JSON from the output
            try:
                # Find JSON content in the output
                output = result.stdout
                start = output.find('{')
                end = output.rfind('}') + 1
                
                if start != -1 and end > start:
                    json_str = output[start:end]
                    schema_data = json.loads(json_str)
                    
                    # Save the structured data
                    with open('priority_tables_schema.json', 'w') as f:
                        json.dump(schema_data, f, indent=2)
                    
                    print("Extracted schema data saved to priority_tables_schema.json")
                    return schema_data
                else:
                    print("Could not find JSON in Gemini output")
                    
            except json.JSONDecodeError as e:
                print(f"Error parsing JSON from Gemini output: {e}")
                
        else:
            print(f"Gemini command failed with return code: {result.returncode}")
            print(f"Error: {result.stderr}")
            
    except Exception as e:
        print(f"Error running Gemini: {e}")
        
    return None

def create_summary_report(schema_data):
    """Create a summary report of the extracted schemas"""
    
    if not schema_data:
        return
    
    report = []
    report.append("# Priority Tables Schema Summary\n")
    report.append(f"Total tables analyzed: {len(schema_data.get('tables', {}))}\n")
    
    # Group by schema
    schemas = {}
    for table_name, table_info in schema_data.get('tables', {}).items():
        schema = table_info.get('schema', 'unknown')
        if schema not in schemas:
            schemas[schema] = []
        schemas[schema].append(table_name)
    
    report.append("\n## Tables by Schema\n")
    for schema, tables in schemas.items():
        report.append(f"\n### {schema} ({len(tables)} tables)\n")
        for table in sorted(tables):
            report.append(f"- {table}\n")
    
    # Save report
    with open('priority_tables_schema_summary.md', 'w') as f:
        f.writelines(report)
    
    print("Summary report saved to priority_tables_schema_summary.md")

if __name__ == "__main__":
    # Change to the schema extraction directory
    os.chdir('/Users/fongy/Code/sh-reportsapi/semantic_layer_v2/schema_extraction')
    
    # Run the analysis
    schema_data = run_gemini_analysis()
    
    # Create summary report
    if schema_data:
        create_summary_report(schema_data)