#!/usr/bin/env python3
"""
Test MRR/ARR query using urllib (no external dependencies)
"""

import urllib.request
import urllib.parse
import json
import ssl
from pathlib import Path

# Configuration
METABASE_URL = "https://metabase.shub.us"
API_KEY = "mb_k+dE1B3lVyMn8Jc9k7gAkKkiTueya+8A81RnJzFyZgo="
DATABASE_ID = 2

def execute_metabase_query(query):
    """Execute a query via Metabase API using urllib"""
    
    # Prepare the request
    url = f"{METABASE_URL}/api/dataset"
    
    data = {
        "database": DATABASE_ID,
        "type": "native",
        "native": {
            "query": query
        }
    }
    
    # Convert data to JSON
    json_data = json.dumps(data).encode('utf-8')
    
    # Create request with headers
    req = urllib.request.Request(
        url,
        data=json_data,
        headers={
            'Content-Type': 'application/json',
            'X-API-KEY': API_KEY
        }
    )
    
    # Create SSL context (to handle HTTPS)
    ctx = ssl.create_default_context()
    
    try:
        # Execute request
        with urllib.request.urlopen(req, context=ctx) as response:
            result = json.loads(response.read().decode('utf-8'))
            return result
    except urllib.error.HTTPError as e:
        print(f"HTTP Error {e.code}: {e.reason}")
        print(f"Response: {e.read().decode('utf-8')}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None

def main():
    # Read the query
    query_path = Path(__file__).parent.parent / 'generated_queries' / 'mrr_arr_stores_query.sql'
    with open(query_path, 'r') as f:
        # Skip comments and get the actual query
        lines = f.readlines()
        query = ''.join([line for line in lines if not line.strip().startswith('--')])
    
    print("=== Testing MRR/ARR Query via Metabase API ===")
    print(f"Target accounts: lekmassage, withitstore\n")
    
    # Execute the query
    print("📊 Executing query...")
    result = execute_metabase_query(query)
    
    if result and 'data' in result:
        rows = result['data']['rows']
        columns = [col['name'] for col in result['data']['cols']]
        
        print(f"\n✅ Query successful! Found {len(rows)} results\n")
        
        # Display results
        if rows:
            # Print header
            print("-" * 100)
            print(f"{'Business':<15} {'MRR':<12} {'ARR':<12} {'Stores':<8} {'Status':<15} {'Type':<15}")
            print("-" * 100)
            
            # Print data
            for row in rows:
                data = dict(zip(columns, row))
                mrr = data.get('mrr', 0) or 0  # Handle None values
                arr = data.get('arr', 0) or 0
                
                print(f"{data.get('business_name', 'N/A'):<15} "
                      f"${mrr:>10,.2f} "
                      f"${arr:>10,.2f} "
                      f"{data.get('number_of_stores', 0):>8} "
                      f"{data.get('subscription_status', 'N/A'):<15} "
                      f"{data.get('business_type', 'N/A'):<15}")
            
            print("-" * 100)
            
            # Summary
            print(f"\n📊 Summary:")
            for row in rows:
                data = dict(zip(columns, row))
                mrr = data.get('mrr', 0) or 0
                arr = data.get('arr', 0) or 0
                print(f"\n{data.get('business_name', 'N/A')}:")
                print(f"  - MRR: ${mrr:,.2f} {data.get('currency', '')}")
                print(f"  - ARR: ${arr:,.2f} {data.get('currency', '')}")
                print(f"  - Stores: {data.get('number_of_stores', 0)}")
                print(f"  - Status: {data.get('subscription_status', 'N/A')}")
        else:
            print("⚠️  No results found for 'lekmassage' or 'withitstore'")
            print("\nPossible reasons:")
            print("- The business names might be different in the database")
            print("- These businesses might not exist in the current dataset")
            
    else:
        print("❌ Query execution failed")
        if result:
            print(f"Error details: {json.dumps(result, indent=2)}")

if __name__ == "__main__":
    main()