#!/usr/bin/env python3
"""
Simple query validator that can be dropped into existing query generation flows
"""

import re
from typing import List, Dict, Tuple, Optional
from schema_lookup import SchemaLookup


class QueryValidator:
    """
    Lightweight SQL query validator that can be added to any query generation pipeline
    """
    
    def __init__(self, schema_files: List[str]):
        self.schema = SchemaLookup(schema_files)
        self.validation_cache = {}
        
    def validate_query(self, sql_query: str) -> Dict[str, any]:
        """
        Validate a SQL query by checking all table and column references
        
        Args:
            sql_query: The SQL query to validate
            
        Returns:
            {
                'valid': bool,
                'errors': List[str],
                'warnings': List[str],
                'tables_found': List[str],
                'columns_found': List[Tuple[table, column]]
            }
        """
        result = {
            'valid': True,
            'errors': [],
            'warnings': [],
            'tables_found': [],
            'columns_found': []
        }
        
        # Extract table references
        tables = self._extract_tables_from_query(sql_query)
        
        # Validate each table
        for table in tables:
            validated_table = self._validate_table_reference(table)
            if validated_table:
                result['tables_found'].append(validated_table)
            else:
                result['errors'].append(f"Table not found: {table}")
                result['valid'] = False
        
        # Extract and validate column references
        columns = self._extract_columns_from_query(sql_query, tables)
        
        for table, column in columns:
            if self._validate_column_reference(table, column):
                result['columns_found'].append((table, column))
            else:
                # Try to find the column in any table
                possible_tables = self._find_column_in_any_table(column)
                if possible_tables:
                    result['warnings'].append(
                        f"Column '{column}' not found in '{table}', "
                        f"but exists in: {', '.join(possible_tables[:3])}"
                    )
                else:
                    result['errors'].append(f"Column not found: {table}.{column}")
                    result['valid'] = False
        
        return result
    
    def validate_table_column_pair(self, table: str, column: str) -> bool:
        """
        Quick validation of a table.column pair
        """
        cache_key = f"{table}.{column}"
        if cache_key in self.validation_cache:
            return self.validation_cache[cache_key]
        
        tables = self.schema.find_table(table)
        if not tables:
            self.validation_cache[cache_key] = False
            return False
            
        columns = self.schema.find_columns(tables[0], column)
        valid = len(columns) > 0
        self.validation_cache[cache_key] = valid
        return valid
    
    def suggest_corrections(self, invalid_reference: str) -> List[str]:
        """
        Suggest valid alternatives for an invalid table or column reference
        """
        suggestions = []
        
        # Check if it's a table
        tables = self.schema.find_table(invalid_reference)
        if tables:
            suggestions.extend([f"Did you mean table: {t}?" for t in tables[:3]])
        
        # Check if it's a column in any table
        possible_tables = self._find_column_in_any_table(invalid_reference)
        if possible_tables:
            suggestions.extend([
                f"Column '{invalid_reference}' exists in: {t}" 
                for t in possible_tables[:3]
            ])
        
        # Look for similar names
        similar = self._find_similar_names(invalid_reference)
        if similar:
            suggestions.append(f"Similar names: {', '.join(similar[:3])}")
        
        return suggestions
    
    def _extract_tables_from_query(self, sql_query: str) -> List[str]:
        """Extract table names from SQL query"""
        tables = []
        
        # Remove comments
        sql_clean = re.sub(r'--.*$', '', sql_query, flags=re.MULTILINE)
        sql_clean = re.sub(r'/\*.*?\*/', '', sql_clean, flags=re.DOTALL)
        
        # Find FROM and JOIN clauses
        from_pattern = r'(?:FROM|JOIN)\s+([^\s,]+)'
        matches = re.finditer(from_pattern, sql_clean, re.IGNORECASE)
        
        for match in matches:
            table = match.group(1).strip()
            # Remove alias if present
            table = re.split(r'\s+(?:AS\s+)?', table, flags=re.IGNORECASE)[0]
            # Remove quotes
            table = table.strip('"\'`')
            if table and not table.upper() in ['SELECT', 'WHERE', 'ON']:
                tables.append(table)
        
        return list(set(tables))
    
    def _extract_columns_from_query(self, sql_query: str, tables: List[str]) -> List[Tuple[str, str]]:
        """Extract column references from SQL query"""
        columns = []
        
        # This is a simplified extraction - real implementation would use SQL parser
        # Look for table.column patterns
        pattern = r'(\w+)\.(\w+)'
        matches = re.finditer(pattern, sql_query)
        
        for match in matches:
            table_alias = match.group(1)
            column = match.group(2)
            
            # Try to resolve alias to actual table
            actual_table = self._resolve_table_alias(table_alias, sql_query, tables)
            if actual_table:
                columns.append((actual_table, column))
        
        return list(set(columns))
    
    def _validate_table_reference(self, table: str) -> Optional[str]:
        """Validate and return canonical table name"""
        tables = self.schema.find_table(table)
        return tables[0] if tables else None
    
    def _validate_column_reference(self, table: str, column: str) -> bool:
        """Validate column exists in table"""
        columns = self.schema.find_columns(table, column)
        return len(columns) > 0
    
    def _find_column_in_any_table(self, column: str) -> List[str]:
        """Find which tables contain a column"""
        # This would need to be implemented in schema_lookup.py
        # For now, return empty list
        return []
    
    def _find_similar_names(self, name: str) -> List[str]:
        """Find similar table or column names"""
        # Simple implementation - could use edit distance
        suggestions = []
        name_lower = name.lower()
        
        # Check all tables
        all_tables = self.schema.schema_data.get('tables', {})
        for table in all_tables:
            if name_lower in table.lower() or table.lower() in name_lower:
                suggestions.append(table)
        
        return suggestions[:5]
    
    def _resolve_table_alias(self, alias: str, sql_query: str, tables: List[str]) -> Optional[str]:
        """Resolve table alias to actual table name"""
        # Look for alias definitions like "table_name alias" or "table_name AS alias"
        pattern = rf'(\w+)\s+(?:AS\s+)?{re.escape(alias)}\b'
        match = re.search(pattern, sql_query, re.IGNORECASE)
        
        if match:
            table = match.group(1)
            # Validate it's actually a table
            return self._validate_table_reference(table)
        
        # If no alias found, check if the alias itself is a table
        return self._validate_table_reference(alias)


# Decorator for easy integration
def validate_sql(schema_files: List[str]):
    """
    Decorator to add SQL validation to any function that returns SQL
    
    Usage:
        @validate_sql(['/path/to/schema.sql'])
        def generate_query(params):
            return "SELECT * FROM businesses WHERE active = true"
    """
    validator = QueryValidator(schema_files)
    
    def decorator(func):
        def wrapper(*args, **kwargs):
            sql_query = func(*args, **kwargs)
            
            # Validate the query
            validation_result = validator.validate_query(sql_query)
            
            if not validation_result['valid']:
                raise ValueError(
                    f"Invalid SQL generated:\n"
                    f"Errors: {validation_result['errors']}\n"
                    f"Query: {sql_query}"
                )
            
            # Log warnings if any
            if validation_result['warnings']:
                print(f"SQL Validation Warnings: {validation_result['warnings']}")
            
            return sql_query
        
        return wrapper
    
    return decorator


# Example usage
if __name__ == "__main__":
    # Initialize validator
    validator = QueryValidator(['/path/to/schema.sql'])
    
    # Validate a query
    test_query = """
    SELECT 
        b.name,
        b.country,
        COUNT(t.id) as transaction_count
    FROM 
        businesses b
        LEFT JOIN transactionrecords t ON b.id = t.business_id
    WHERE 
        b.isdeleted != true
        AND b.country = 'MY'
    GROUP BY 
        b.name, b.country
    """
    
    result = validator.validate_query(test_query)
    print("Validation Result:")
    print(f"Valid: {result['valid']}")
    print(f"Tables: {result['tables_found']}")
    print(f"Errors: {result['errors']}")
    print(f"Warnings: {result['warnings']}")