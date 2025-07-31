#!/usr/bin/env python3
"""
Search for businesses by partial name match
"""

import urllib.request
import urllib.parse
import json
import ssl

# Configuration
METABASE_URL = "https://metabase.shub.us"
API_KEY = "mb_k+dE1B3lVyMn8Jc9k7gAkKkiTueya+8A81RnJzFyZgo="
DATABASE_ID = 2

def execute_metabase_query(query):
    """Execute a query via Metabase API using urllib"""
    url = f"{METABASE_URL}/api/dataset"
    
    data = {
        "database": DATABASE_ID,
        "type": "native",
        "native": {"query": query}
    }
    
    json_data = json.dumps(data).encode('utf-8')
    req = urllib.request.Request(
        url,
        data=json_data,
        headers={
            'Content-Type': 'application/json',
            'X-API-KEY': API_KEY
        }
    )
    
    ctx = ssl.create_default_context()
    
    try:
        with urllib.request.urlopen(req, context=ctx) as response:
            return json.loads(response.read().decode('utf-8'))
    except Exception as e:
        print(f"Error: {e}")
        return None

def main():
    # Search query to find businesses with names like the ones requested
    search_query = """
    SELECT 
        b.name AS business_name,
        b.displaybusinessname AS display_name,
        b.mrr AS monthly_recurring_revenue,
        b.subscriptionstatus AS subscription_status,
        b.country,
        b.businesstype
    FROM storehub_mongo.businesses b
    WHERE 
        LOWER(b.name) LIKE '%lekmassage%' 
        OR LOWER(b.name) LIKE '%withitstore%'
        OR LOWER(b.name) LIKE '%massage%'
        OR LOWER(b.name) LIKE '%withit%'
        OR LOWER(b.displaybusinessname) LIKE '%massage%'
        OR LOWER(b.displaybusinessname) LIKE '%withit%'
    LIMIT 20
    """
    
    print("=== Searching for businesses with similar names ===\n")
    
    # Execute search query
    result = execute_metabase_query(search_query)
    
    if result and 'data' in result:
        rows = result['data']['rows']
        columns = [col['name'] for col in result['data']['cols']]
        
        if rows:
            print(f"Found {len(rows)} businesses with similar names:\n")
            for row in rows:
                data = dict(zip(columns, row))
                mrr = data.get('monthly_recurring_revenue', 0) or 0
                print(f"- {data.get('business_name')} ({data.get('display_name')})")
                print(f"  MRR: ${mrr:,.2f}, Status: {data.get('subscription_status')}, Country: {data.get('country')}")
                print()
        else:
            print("No businesses found with names containing 'massage' or 'withit'")
            
    # Let's also check some sample businesses with MRR data
    print("\n=== Sample businesses with MRR data ===\n")
    
    sample_query = """
    SELECT 
        b.name AS business_name,
        b.displaybusinessname AS display_name,
        b.mrr AS monthly_recurring_revenue,
        b.subscriptionstatus AS subscription_status,
        COUNT(DISTINCT bs._id) AS store_count
    FROM storehub_mongo.businesses b
    LEFT JOIN storehub_mongo.businesses__stores bs ON b._id = bs.businesses_foreignkey
    WHERE b.mrr > 0
    GROUP BY b.name, b.displaybusinessname, b.mrr, b.subscriptionstatus
    ORDER BY b.mrr DESC
    LIMIT 10
    """
    
    result = execute_metabase_query(sample_query)
    
    if result and 'data' in result:
        rows = result['data']['rows']
        columns = [col['name'] for col in result['data']['cols']]
        
        if rows:
            print("Top 10 businesses by MRR:\n")
            for i, row in enumerate(rows, 1):
                data = dict(zip(columns, row))
                mrr = data.get('monthly_recurring_revenue', 0) or 0
                print(f"{i}. {data.get('business_name')} - MRR: ${mrr:,.2f}, Stores: {data.get('store_count', 0)}")

if __name__ == "__main__":
    main()