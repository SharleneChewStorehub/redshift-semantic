#!/usr/bin/env python3
"""
Validate Monthly Sales SQL Query using Metabase API
Tests the generated SQL for the nasikukusnkb merchant
"""

import requests
import json
import sys
import os
from datetime import datetime

# Add parent directory to path for imports
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from data_samples.metabase_config import METABASE_URL, API_KEY, DATABASE_ID

def validate_sql_query(sql_query, limit=10):
    """
    Validate SQL query using Metabase's native query API
    
    Args:
        sql_query: The SQL query to validate
        limit: Number of rows to return (for testing)
    
    Returns:
        dict: Query results or error information
    """
    # Add LIMIT for testing to avoid large results
    # Remove trailing semicolon and whitespace
    clean_query = sql_query.rstrip().rstrip(';')
    test_query = f"{clean_query} LIMIT {limit};"
    
    # Prepare the native query payload
    payload = {
        "database": DATABASE_ID,
        "native": {
            "query": test_query
        },
        "type": "native"
    }
    
    # API endpoint for running queries
    url = f"{METABASE_URL}/api/dataset"
    
    # Headers with API key
    headers = {
        "X-API-KEY": API_KEY,
        "Content-Type": "application/json"
    }
    
    print(f"Validating SQL query against Metabase...")
    print(f"Database ID: {DATABASE_ID}")
    print(f"Query preview (first 200 chars): {test_query[:200]}...")
    
    try:
        # Execute the query
        response = requests.post(url, json=payload, headers=headers)
        
        if response.status_code in [200, 202]:
            result = response.json()
            
            # Handle async query execution (status code 202)
            if response.status_code == 202 and result.get('status') == 'completed':
                # Extract key information
                row_count = result.get('row_count', 0)
                columns = [col['name'] for col in result.get('data', {}).get('cols', [])]
                
                print(f"\n✅ Query executed successfully!")
                print(f"Status: {result.get('status')}")
                print(f"Execution time: {result.get('running_time')}ms")
                print(f"Columns returned: {len(columns)}")
                print(f"Column names: {', '.join(columns)}")
                print(f"Rows returned: {row_count}")
                
                if row_count == 0:
                    print("\n⚠️  No data returned. This could mean:")
                    print("   - The merchant 'nasikukusnkb' doesn't exist in the businesses table")
                    print("   - Or there are no transactions for this merchant in the specified period")
                else:
                    # Show first few rows if available
                    rows = result.get('data', {}).get('rows', [])[:3]
                    if rows:
                        print("\nSample data (first 3 rows):")
                        for i, row in enumerate(rows):
                            print(f"Row {i+1}: {dict(zip(columns, row))}")
                
                return {
                    "success": True,
                    "status": result.get('status'),
                    "execution_time_ms": result.get('running_time'),
                    "columns": columns,
                    "row_count": row_count,
                    "sample_data": result.get('data', {}).get('rows', [])[:3]
                }
            
            # Handle synchronous response (status code 200)
            elif response.status_code == 200:
                row_count = len(result.get('data', {}).get('rows', []))
                columns = [col['name'] for col in result.get('data', {}).get('cols', [])]
                
                print(f"\n✅ Query executed successfully!")
                print(f"Columns returned: {len(columns)}")
                print(f"Column names: {', '.join(columns)}")
                print(f"Rows returned (limited to {limit}): {row_count}")
                
                # Show first few rows if available
                if row_count > 0:
                    print("\nSample data (first 3 rows):")
                    rows = result['data']['rows'][:3]
                    for i, row in enumerate(rows):
                        print(f"Row {i+1}: {dict(zip(columns, row))}")
                
                return {
                    "success": True,
                    "columns": columns,
                    "row_count": row_count,
                    "sample_data": result['data']['rows'][:3] if row_count > 0 else []
                }
            
        else:
            error_msg = response.text
            try:
                error_json = response.json()
                error_msg = error_json.get('message', error_msg)
            except:
                pass
                
            print(f"\n❌ Query validation failed!")
            print(f"Status code: {response.status_code}")
            print(f"Error: {error_msg}")
            
            return {
                "success": False,
                "error": error_msg,
                "status_code": response.status_code
            }
            
    except Exception as e:
        print(f"\n❌ Exception during query validation: {str(e)}")
        return {
            "success": False,
            "error": str(e),
            "exception": True
        }

def main():
    """Main function to validate the monthly sales query"""
    
    # Read the generated SQL query
    query_file = os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
        'generated_queries',
        'monthly_sales_report_nasikukusnkb_final.sql'
    )
    
    if not os.path.exists(query_file):
        print(f"❌ Query file not found: {query_file}")
        return 1
    
    with open(query_file, 'r') as f:
        sql_query = f.read()
    
    # Remove comments for cleaner execution
    lines = sql_query.split('\n')
    clean_lines = [line for line in lines if not line.strip().startswith('--')]
    clean_query = '\n'.join(clean_lines)
    
    print(f"Loaded SQL query from: {query_file}")
    print("=" * 50)
    
    # Validate the query
    result = validate_sql_query(clean_query, limit=10)
    
    # Save validation results
    output_file = os.path.join(
        os.path.dirname(os.path.abspath(__file__)),
        f'validation_results_{datetime.now().strftime("%Y%m%d_%H%M%S")}.json'
    )
    
    with open(output_file, 'w') as f:
        json.dump(result, f, indent=2)
    
    print(f"\nValidation results saved to: {output_file}")
    
    return 0 if result['success'] else 1

if __name__ == "__main__":
    sys.exit(main())