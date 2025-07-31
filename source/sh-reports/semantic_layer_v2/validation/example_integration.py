#!/usr/bin/env python3
"""
Example integration of schema validation with semantic layer query generation
Shows how to wire validation into the main query flow
"""

import json
from pathlib import Path
from typing import Dict, Any, Optional
from sql_builder_with_validation import ValidatedSQLBuilder
from schema_lookup import SchemaLookup


class SemanticLayerWithValidation:
    """
    Enhanced semantic layer that includes schema validation
    """
    
    def __init__(self, semantic_layer_path: str, schema_files: list):
        self.semantic_path = Path(semantic_layer_path)
        self.validator = ValidatedSQLBuilder(schema_files, semantic_layer_path)
        
        # Load semantic layer components
        self.data_catalog = self._load_json('data_catalog.json')
        self.business_rules = self._load_json('business_rules.json')
        self.query_patterns = self._load_json('query_patterns.json')
        self.semantic_context = self._load_json('semantic_context.json')
        
    def _load_json(self, filename: str) -> Dict[str, Any]:
        """Load JSON file from semantic layer directory"""
        file_path = self.semantic_path / filename
        if file_path.exists():
            with open(file_path, 'r') as f:
                return json.load(f)
        return {}
    
    def generate_validated_query(self, natural_language: str, business_id: str) -> Dict[str, Any]:
        """
        Generate SQL query with full validation pipeline
        
        Returns:
            {
                'sql': 'Generated SQL query',
                'validation': {
                    'tables_validated': ['table1', 'table2'],
                    'columns_validated': ['col1', 'col2'],
                    'warnings': []
                },
                'metadata': {
                    'pattern_used': 'pattern_name',
                    'entities': ['entity1', 'entity2']
                }
            }
        """
        
        # Step 1: Parse intent using semantic context
        intent = self._parse_intent(natural_language)
        
        # Step 2: Map to data catalog entities
        entities = self._map_to_entities(intent)
        
        # Step 3: Apply business rules
        constraints = self._apply_business_rules(entities, business_id)
        
        # Step 4: Select query pattern
        pattern = self._select_pattern(intent, entities)
        
        # Step 5: Validate schema references
        validation_result = self._validate_schema_references(entities, pattern)
        
        # Step 6: Generate final SQL
        sql = self._generate_sql(entities, pattern, constraints, validation_result)
        
        return {
            'sql': sql,
            'validation': validation_result,
            'metadata': {
                'pattern_used': pattern.get('name', 'custom'),
                'entities': list(entities.keys()),
                'intent': intent
            }
        }
    
    def _validate_schema_references(self, entities: Dict, pattern: Dict) -> Dict[str, Any]:
        """
        Validate all table and column references
        """
        validation_result = {
            'tables_validated': [],
            'columns_validated': [],
            'warnings': [],
            'errors': []
        }
        
        # Validate tables from entities
        for entity_name, entity_config in entities.items():
            if 'primary_table' in entity_config:
                try:
                    table = self.validator.validate_table(entity_config['primary_table'])
                    validation_result['tables_validated'].append(table)
                except ValueError as e:
                    validation_result['errors'].append(str(e))
            
            # Validate columns
            if 'dimensions' in entity_config:
                for dim_name, dim_config in entity_config['dimensions'].items():
                    if 'field' in dim_config and 'primary_table' in entity_config:
                        try:
                            col = self.validator.validate_column(
                                entity_config['primary_table'], 
                                dim_config['field']
                            )
                            validation_result['columns_validated'].append(
                                f"{entity_config['primary_table']}.{col}"
                            )
                        except ValueError as e:
                            validation_result['warnings'].append(str(e))
        
        return validation_result
    
    def _parse_intent(self, natural_language: str) -> Dict[str, Any]:
        """Parse user intent from natural language"""
        # Simplified example - real implementation would use NLP
        intent = {
            'type': 'query',
            'timeframe': 'last_month',
            'metrics': ['sales'],
            'dimensions': ['product']
        }
        
        # Use semantic_context.json for disambiguation
        if 'top' in natural_language.lower():
            intent['pattern_hint'] = 'ranking'
        
        return intent
    
    def _map_to_entities(self, intent: Dict) -> Dict[str, Any]:
        """Map intent to data catalog entities"""
        entities = {}
        
        # Example mapping
        if 'sales' in intent.get('metrics', []):
            entities['sales'] = self.data_catalog.get('business_entities', {}).get('sales', {})
        
        if 'product' in intent.get('dimensions', []):
            entities['products'] = self.data_catalog.get('business_entities', {}).get('products', {})
        
        return entities
    
    def _apply_business_rules(self, entities: Dict, business_id: str) -> Dict[str, Any]:
        """Apply business rules and constraints"""
        constraints = {
            'filters': [
                f"business = '{business_id}'",  # Multi-tenant isolation
                "isdeleted != true"  # Soft delete handling
            ],
            'limits': {
                'max_date_range': 365,
                'max_results': 10000
            }
        }
        
        # Add entity-specific rules
        mandatory_filters = self.business_rules.get('mandatory_filters', {})
        constraints['filters'].extend(mandatory_filters.get('global', []))
        
        return constraints
    
    def _select_pattern(self, intent: Dict, entities: Dict) -> Dict[str, Any]:
        """Select appropriate query pattern"""
        pattern_hint = intent.get('pattern_hint', 'simple_aggregation')
        
        # Get pattern from query_patterns.json
        patterns = self.query_patterns.get('patterns', {})
        pattern = patterns.get(pattern_hint, patterns.get('simple_aggregation', {}))
        
        return pattern
    
    def _generate_sql(self, entities: Dict, pattern: Dict, 
                     constraints: Dict, validation: Dict) -> str:
        """Generate final SQL query"""
        # Check for validation errors
        if validation.get('errors'):
            raise ValueError(f"Schema validation failed: {validation['errors']}")
        
        # Example SQL generation (simplified)
        sql = """
        SELECT 
            p.name as product_name,
            SUM(ti.quantity * ti.unitprice) as total_sales
        FROM 
            storehub_mongo_test.transactionrecords t
            JOIN storehub_mongo_test.transactionrecords__items ti 
                ON t._id = ti.transactionrecords_foreignkey
            JOIN storehub_mongo_test.products p 
                ON ti.productid = p._id
        WHERE 
            {filters}
            AND t.createdtime >= DATEADD(month, -1, CURRENT_DATE)
            AND t.createdtime < CURRENT_DATE
        GROUP BY 
            p.name
        ORDER BY 
            total_sales DESC
        LIMIT 10
        """.format(filters=' AND '.join(constraints['filters']))
        
        return sql.strip()


# Example usage
if __name__ == "__main__":
    # Initialize with schema files
    schema_files = [
        '/path/to/redshift_schema.sql',
        '/path/to/custom_tables.sql'
    ]
    
    # Create integrated semantic layer
    semantic_layer = SemanticLayerWithValidation(
        semantic_layer_path='../',
        schema_files=schema_files
    )
    
    # Generate validated query
    try:
        result = semantic_layer.generate_validated_query(
            natural_language="Show me top selling products last month",
            business_id="test_merchant"
        )
        
        print("Generated SQL:")
        print(result['sql'])
        print("\nValidation Result:")
        print(json.dumps(result['validation'], indent=2))
        print("\nMetadata:")
        print(json.dumps(result['metadata'], indent=2))
        
    except ValueError as e:
        print(f"Query generation failed: {e}")