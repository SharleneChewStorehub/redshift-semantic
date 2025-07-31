#!/usr/bin/env python3
"""
Data Profiling Framework for Semantic Layer v2
Analyzes raw data to build accurate semantic mappings
"""

import json
import pandas as pd
from collections import defaultdict, Counter
from pathlib import Path


class SemanticDataProfiler:
    def __init__(self, connection):
        self.conn = connection
        self.profile_results = defaultdict(dict)
        
    def profile_all_tables(self):
        """Run comprehensive profiling on all key tables"""
        tables = [
            'storehub_mongo.businesses',
            'storehub_mongo.products', 
            'storehub_mongo.transactionrecords',
            'storehub_mongo.customers'
        ]
        
        for table in tables:
            print(f"Profiling {table}...")
            self.profile_table(table)
            
    def profile_table(self, table_name):
        """Profile a single table"""
        # Get basic stats
        self.profile_results[table_name]['row_count'] = self._get_row_count(table_name)
        self.profile_results[table_name]['columns'] = self._profile_columns(table_name)
        
        # Profile specific patterns based on table
        if 'businesses' in table_name:
            self._profile_business_patterns(table_name)
        elif 'products' in table_name:
            self._profile_product_patterns(table_name)
            
    def _profile_business_patterns(self, table):
        """Special profiling for business table"""
        # Country formats
        query = f"""
        SELECT country, COUNT(*) as cnt
        FROM {table}
        GROUP BY country
        ORDER BY cnt DESC
        """
        countries = pd.read_sql(query, self.conn)
        self.profile_results[table]['country_values'] = countries.to_dict('records')
        
        # Business types
        query = f"""
        SELECT businesstype, COUNT(*) as cnt
        FROM {table}
        WHERE businesstype IS NOT NULL
        GROUP BY businesstype
        ORDER BY cnt DESC
        LIMIT 50
        """
        types = pd.read_sql(query, self.conn)
        self.profile_results[table]['business_types'] = types.to_dict('records')
        
    def _profile_product_patterns(self, table):
        """Special profiling for products table"""
        # Find cigarette patterns
        query = f"""
        SELECT title
        FROM {table}
        WHERE isdeleted != true
          AND (LOWER(title) LIKE '%rokok%' 
               OR LOWER(title) LIKE '%cigarette%'
               OR LOWER(title) LIKE '%tobacco%')
        LIMIT 100
        """
        cigarettes = pd.read_sql(query, self.conn)
        
        # Extract patterns
        patterns = self._extract_name_patterns(cigarettes['title'].tolist())
        self.profile_results[table]['cigarette_patterns'] = patterns
        
    def _extract_name_patterns(self, product_names):
        """Extract common patterns from product names"""
        patterns = {
            'prefixes': Counter(),
            'suffixes': Counter(),
            'contains': Counter(),
            'formats': []
        }
        
        for name in product_names:
            if not name:
                continue
                
            # Common prefixes (first word)
            first_word = name.split()[0] if name.split() else ''
            patterns['prefixes'][first_word] += 1
            
            # Common suffixes (last word) 
            last_word = name.split()[-1] if name.split() else ''
            patterns['suffixes'][last_word] += 1
            
            # Numbers in names (like "20s", "14s")
            import re
            numbers = re.findall(r'\d+s?', name)
            for num in numbers:
                patterns['contains'][num] += 1
                
        return {
            'top_prefixes': patterns['prefixes'].most_common(10),
            'top_suffixes': patterns['suffixes'].most_common(10),
            'common_numbers': patterns['contains'].most_common(10)
        }
        
    def generate_enhanced_semantic_layer(self):
        """Generate enhanced semantic layer files based on profiling"""
        
        # Enhanced data catalog with discovered patterns
        data_catalog = {
            "version": "2.1.0",
            "generated_from": "data profiling",
            "business_entities": {}
        }
        
        # Add discovered patterns
        if 'storehub_mongo.businesses' in self.profile_results:
            data_catalog['discovered_values'] = {
                'country_codes': self.profile_results['storehub_mongo.businesses'].get('country_values', []),
                'business_types': self.profile_results['storehub_mongo.businesses'].get('business_types', [])
            }
            
        # Save enhanced files
        output_path = Path('semantic_layer_v2_enhanced')
        output_path.mkdir(exist_ok=True)
        
        with open(output_path / 'data_catalog_enhanced.json', 'w') as f:
            json.dump(data_catalog, f, indent=2)
            
        print(f"Enhanced semantic layer saved to {output_path}")
        
    def generate_validation_rules(self):
        """Generate validation rules from data patterns"""
        rules = {
            "version": "2.1.0",
            "auto_generated": True,
            "validation_rules": {}
        }
        
        # Generate enum validations for categorical fields
        for table, profile in self.profile_results.items():
            if 'country_values' in profile:
                valid_countries = [c['country'] for c in profile['country_values'] if c['cnt'] > 10]
                rules['validation_rules']['country'] = {
                    "type": "enum",
                    "valid_values": valid_countries,
                    "case_sensitive": False
                }
                
        return rules


# Example usage
if __name__ == "__main__":
    # This would need actual DB connection
    # conn = create_connection()
    # profiler = SemanticDataProfiler(conn)
    # profiler.profile_all_tables()
    # profiler.generate_enhanced_semantic_layer()
    pass