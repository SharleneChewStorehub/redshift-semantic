#!/usr/bin/env python3
"""
SQL Builder with Schema Validation
Always validates table and column names before generating queries
"""

import json
from pathlib import Path
from schema_lookup import SchemaLookup


class ValidatedSQLBuilder:
    def __init__(self, schema_files, semantic_layer_path):
        self.schema = SchemaLookup(schema_files)
        self.semantic_layer_path = Path(semantic_layer_path)
        self.data_catalog = self._load_json('data_catalog.json')
        self.business_rules = self._load_json('business_rules.json')
        self.query_patterns = self._load_json('query_patterns.json')
        
    def _load_json(self, filename):
        file_path = self.semantic_layer_path / filename
        if file_path.exists():
            with open(file_path, 'r') as f:
                return json.load(f)
        return {}
    
    def validate_table(self, table_name):
        """Validate table exists and return full name"""
        tables = self.schema.find_table(table_name)
        if not tables:
            raise ValueError(f"Table '{table_name}' not found in schema")
        if len(tables) > 1:
            print(f"Warning: Multiple tables found for '{table_name}': {tables}")
        return tables[0]
    
    def validate_column(self, table_name, column_name):
        """Validate column exists in table"""
        columns = self.schema.find_columns(table_name, column_name)
        if not columns:
            # Try to find similar columns
            all_cols = self.schema.find_columns(table_name)
            col_names = [c['column'] for c in all_cols]
            raise ValueError(f"Column '{column_name}' not found in table '{table_name}'. Available columns: {col_names[:10]}...")
        return columns[0]['column']
    
    def build_cigarette_query(self):
        """Build the cigarette products query with validation"""
        # Validate tables
        businesses_table = self.validate_table('businesses')
        products_table = self.validate_table('products')
        
        # Validate columns
        business_id_col = self.validate_column('businesses', '_id')
        business_name_col = self.validate_column('businesses', 'name')
        business_type_col = self.validate_column('businesses', 'businesstype')
        business_country_col = self.validate_column('businesses', 'country')
        business_deleted_col = self.validate_column('businesses', 'isdeleted')
        
        product_id_col = self.validate_column('products', '_id')
        product_business_col = self.validate_column('products', 'business')
        product_deleted_col = self.validate_column('products', 'isdeleted')
        
        # Find the correct product name column
        product_name_columns = self.schema.find_columns('products', 'title')
        if not product_name_columns:
            product_name_columns = self.schema.find_columns('products', 'name')
        if not product_name_columns:
            raise ValueError("Cannot find product name/title column")
        
        product_name_col = product_name_columns[0]['column']
        
        # Also check for SKU and price columns
        sku_columns = self.schema.find_columns('products', 'sku')
        sku_col = sku_columns[0]['column'] if sku_columns else 'skunumber'
        
        price_columns = self.schema.find_columns('products', 'price')
        price_col = price_columns[0]['column'] if price_columns else 'sellingprice'
        
        # Build the query
        query = f"""
-- Validated query for cigarette products in Malaysia
WITH cigarette_analysis AS (
    SELECT 
        b.{business_id_col},
        b.{business_name_col} as merchant_name,
        b.{business_type_col},
        COUNT(DISTINCT p.{product_id_col}) as cigarette_product_count,
        STRING_AGG(DISTINCT p.{product_name_col}, ', ') as cigarette_products
    FROM 
        {businesses_table} b
        INNER JOIN {products_table} p ON b.{business_id_col} = p.{product_business_col}
    WHERE 
        b.{business_country_col} = 'Malaysia'
        AND b.{business_deleted_col} != true
        AND p.{product_deleted_col} != true
        AND (
            LOWER(p.{product_name_col}) LIKE '%cigarette%' 
            OR LOWER(p.{product_name_col}) LIKE '%rokok%'
            OR LOWER(p.{product_name_col}) LIKE '%tobacco%'
            OR LOWER(p.{product_name_col}) LIKE '%marlboro%'
            OR LOWER(p.{product_name_col}) LIKE '%dunhill%'
            OR LOWER(p.{product_name_col}) LIKE '%winston%'
        )
    GROUP BY 
        b.{business_id_col}, b.{business_name_col}, b.{business_type_col}
)
SELECT 
    COUNT(DISTINCT {business_id_col}) as total_merchants_with_cigarettes,
    SUM(cigarette_product_count) as total_cigarette_products,
    COUNT(DISTINCT {business_type_col}) as unique_business_types,
    STRING_AGG(DISTINCT {business_type_col}, ', ') as business_types
FROM 
    cigarette_analysis;
"""
        
        return {
            'query': query,
            'validated_tables': {
                'businesses': businesses_table,
                'products': products_table
            },
            'validated_columns': {
                'businesses': {
                    'id': business_id_col,
                    'name': business_name_col,
                    'type': business_type_col,
                    'country': business_country_col,
                    'deleted': business_deleted_col
                },
                'products': {
                    'id': product_id_col,
                    'business': product_business_col,
                    'name': product_name_col,
                    'sku': sku_col,
                    'price': price_col,
                    'deleted': product_deleted_col
                }
            }
        }


def main():
    schema_files = [
        '/Users/fongy/Code/sh-reportsapi/storehub-table1.sql',
        '/Users/fongy/Code/sh-reportsapi/storehub-table2.sql'
    ]
    semantic_layer_path = '/Users/fongy/Code/sh-reportsapi/semantic_dictionary/semantic_layer_v2'
    
    builder = ValidatedSQLBuilder(schema_files, semantic_layer_path)
    
    try:
        result = builder.build_cigarette_query()
        print("=== Validated SQL Query ===")
        print(result['query'])
        print("\n=== Validation Summary ===")
        print(f"Tables validated: {result['validated_tables']}")
        print(f"Columns validated: {json.dumps(result['validated_columns'], indent=2)}")
    except ValueError as e:
        print(f"Validation Error: {e}")


if __name__ == "__main__":
    main()