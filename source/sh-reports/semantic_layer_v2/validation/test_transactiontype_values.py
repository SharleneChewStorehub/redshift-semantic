#!/usr/bin/env python3
"""
Test query to discover what values exist in transactiontype column
"""

import requests
import json
import sys
import os

# Add parent directory to path for imports
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from data_samples.metabase_config import METABASE_URL, API_KEY, DATABASE_ID

def test_transactiontype_values():
    """Test what values exist in the transactiontype column"""
    
    # Simple query to check distinct transactiontype values
    test_query = """
    SELECT DISTINCT 
        transactiontype,
        COUNT(*) as count
    FROM storehub_mongo.transactionrecords
    WHERE createdtime >= '2023-01-01'
    GROUP BY transactiontype
    ORDER BY count DESC
    LIMIT 20;
    """
    
    payload = {
        "database": DATABASE_ID,
        "native": {
            "query": test_query
        },
        "type": "native"
    }
    
    url = f"{METABASE_URL}/api/dataset"
    headers = {
        "X-API-KEY": API_KEY,
        "Content-Type": "application/json"
    }
    
    print("Testing transactiontype values...")
    
    try:
        response = requests.post(url, json=payload, headers=headers)
        
        if response.status_code == 200:
            result = response.json()
            rows = result.get('data', {}).get('rows', [])
            
            print("\n✅ Query executed successfully!")
            print("\nTransaction types found:")
            for row in rows:
                print(f"  - '{row[0]}': {row[1]:,} records")
            
            return rows
        else:
            print(f"❌ Error: {response.text}")
            return None
            
    except Exception as e:
        print(f"❌ Exception: {str(e)}")
        return None

if __name__ == "__main__":
    test_transactiontype_values()