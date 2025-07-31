#!/usr/bin/env python3
"""
Test MRR/ARR query for lekmassage and withitstore via Metabase API
"""

import sys
import json
from pathlib import Path

# Add parent directory to path to import metabase modules
sys.path.append(str(Path(__file__).parent.parent / 'data_samples'))

from metabase_api_extractor import MetabaseAPIExtractor
from metabase_config import METABASE_URL, API_KEY, DATABASE_ID

def main():
    # Read the query
    query_path = Path(__file__).parent.parent / 'generated_queries' / 'mrr_arr_stores_query.sql'
    with open(query_path, 'r') as f:
        # Skip comments and get the actual query
        lines = f.readlines()
        query = ''.join([line for line in lines if not line.strip().startswith('--')])
    
    print("=== Testing MRR/ARR Query via Metabase API ===")
    print(f"Target accounts: lekmassage, withitstore\n")
    
    # Initialize Metabase API client
    extractor = MetabaseAPIExtractor(
        metabase_url=METABASE_URL,
        api_key=API_KEY,
        database_id=DATABASE_ID
    )
    
    # Authenticate
    if not extractor.authenticate():
        print("❌ Failed to authenticate with Metabase")
        return
    
    # Execute the query
    print("📊 Executing query...")
    result = extractor.execute_query(query)
    
    if result and 'data' in result:
        rows = result['data']['rows']
        columns = [col['name'] for col in result['data']['cols']]
        
        print(f"\n✅ Query successful! Found {len(rows)} results\n")
        
        # Display results in a formatted table
        if rows:
            # Print header
            print("-" * 120)
            print(f"{'Business Name':<20} {'MRR':<15} {'ARR':<15} {'Stores':<10} {'Status':<15} {'Type':<15} {'Country':<10}")
            print("-" * 120)
            
            # Print data
            for row in rows:
                data = dict(zip(columns, row))
                print(f"{data.get('business_name', 'N/A'):<20} "
                      f"${data.get('mrr', 0):>14,.2f} "
                      f"${data.get('arr', 0):>14,.2f} "
                      f"{data.get('number_of_stores', 0):>10} "
                      f"{data.get('subscription_status', 'N/A'):<15} "
                      f"{data.get('business_type', 'N/A'):<15} "
                      f"{data.get('country', 'N/A'):<10}")
            
            print("-" * 120)
            
            # Show additional details
            print("\n📋 Detailed Results:")
            for i, row in enumerate(rows):
                data = dict(zip(columns, row))
                print(f"\n{i+1}. {data.get('business_name', 'N/A')} ({data.get('display_name', 'N/A')})")
                print(f"   - Monthly Recurring Revenue (MRR): ${data.get('mrr', 0):,.2f} {data.get('currency', '')}")
                print(f"   - Annual Recurring Revenue (ARR): ${data.get('arr', 0):,.2f} {data.get('currency', '')}")
                print(f"   - Number of Stores: {data.get('number_of_stores', 0)}")
                print(f"   - Subscription Status: {data.get('subscription_status', 'N/A')}")
                print(f"   - Subscription Start: {data.get('subscription_start_date', 'N/A')}")
                print(f"   - Subscription End: {data.get('subscription_end_date', 'N/A')}")
                print(f"   - Business Type: {data.get('business_type', 'N/A')}")
                print(f"   - Country: {data.get('country', 'N/A')}")
        else:
            print("⚠️  No results found for 'lekmassage' or 'withitstore'")
            print("\nPossible reasons:")
            print("- The business names might be different in the database")
            print("- These businesses might not exist in the current dataset")
            print("- The businesses might have been deleted or marked as inactive")
            
    else:
        print("❌ Query execution failed")
        if result:
            print(f"Error: {result}")

if __name__ == "__main__":
    main()