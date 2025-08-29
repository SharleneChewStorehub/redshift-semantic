#!/usr/bin/env python3
"""
Database Schema Business Description Enhancer

This script takes the existing database_schema.json and adds business descriptions
to each column based on a mapping Excel file with columns: table, field, comment.

Author: Generated for Semantic Layer Project
Date: 2025-01-15
"""

import json
import pandas as pd
from pathlib import Path
from typing import Dict, List, Any
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class DatabaseSchemaEnhancer:
    """Enhances database schema with business descriptions."""
    
    def __init__(self, base_path: str = None):
        """Initialize enhancer with base path."""
        self.base_path = Path(base_path) if base_path else Path.cwd()
        self.mapping_cache = {}
        
    def load_database_schema(self, schema_file: str = "database_schema.json") -> Dict[str, Any]:
        """Load the original database schema JSON file."""
        schema_path = self.base_path / schema_file
        
        if not schema_path.exists():
            raise FileNotFoundError(f"Database schema file not found: {schema_path}")
        
        logger.info(f"Loading database schema from: {schema_path}")
        
        with open(schema_path, 'r', encoding='utf-8') as file:
            schema = json.load(file)
        
        # Validate structure
        if 'tables' not in schema:
            raise ValueError("Invalid schema format: 'tables' key not found")
        
        table_count = len(schema['tables'])
        total_columns = sum(len(columns) for columns in schema['tables'].values())
        
        logger.info(f"Loaded schema with {table_count} tables and {total_columns} columns")
        return schema
    
    def load_business_mapping(self, mapping_file: str) -> pd.DataFrame:
        """Load the Excel file with business descriptions mapping."""
        mapping_path = self.base_path / mapping_file
        
        if not mapping_path.exists():
            raise FileNotFoundError(f"Mapping file not found: {mapping_path}")
        
        logger.info(f"Loading business mapping from: {mapping_path}")
        
        # Try to load Excel file
        try:
            df = pd.read_excel(mapping_path)
        except Exception as e:
            logger.error(f"Failed to read Excel file: {e}")
            raise
        
        logger.info(f"Raw Excel columns: {df.columns.tolist()}")
        logger.info(f"Raw Excel shape: {df.shape}")
        
        # Handle column name variations (Field vs field, Comment vs comment)
        column_mapping = {}
        for col in df.columns:
            if col.lower() == 'table':
                column_mapping['table'] = col
            elif col.lower() == 'field':
                column_mapping['field'] = col
            elif col.lower() == 'comment':
                column_mapping['comment'] = col
        
        # Check if we found all required columns
        required_keys = ['table', 'field', 'comment']
        missing_keys = [key for key in required_keys if key not in column_mapping]
        
        if missing_keys:
            raise ValueError(f"Missing required columns in mapping file. Found columns: {df.columns.tolist()}, Missing: {missing_keys}")
        
        # Rename columns to standardized names
        df = df.rename(columns={v: k for k, v in column_mapping.items()})
        
        # Check if there's a header row that needs to be removed
        # (This file doesn't have one, but keeping the check for safety)
        header_mask = (df['table'].astype(str).str.lower() == 'table') & \
                     (df['field'].astype(str).str.lower() == 'field') & \
                     (df['comment'].astype(str).str.lower() == 'comment')
        if header_mask.any():
            logger.info("Removing header row from data")
            df = df[~header_mask]
        else:
            logger.info("No header row detected - data starts immediately")
        
        # Clean up the data
        df = df.dropna(subset=['table', 'field'])  # Remove rows with missing table or field
        df['comment'] = df['comment'].fillna('')  # Fill missing comments with empty string
        df['table'] = df['table'].astype(str).str.strip()
        df['field'] = df['field'].astype(str).str.strip()
        df['comment'] = df['comment'].astype(str).str.strip()
        
        # Handle missing/empty comments (replace '-' with empty string)
        df['comment'] = df['comment'].replace(['-', 'nan', 'None'], '')
        
        # Filter out rows where comment is essentially empty
        meaningful_comments = df[df['comment'] != '']
        logger.info(f"Total mappings loaded: {len(df)}")
        logger.info(f"Mappings with meaningful comments: {len(meaningful_comments)} ({len(meaningful_comments)/len(df)*100:.1f}%)")
        logger.info(f"Tables covered: {df['table'].nunique()}")
        
        return df
    
    def create_mapping_cache(self, mapping_df: pd.DataFrame) -> Dict[str, Dict[str, str]]:
        """Create a lookup cache for quick mapping access."""
        cache = {}
        
        for _, row in mapping_df.iterrows():
            table_name = row['table']
            field_name = row['field']
            comment = row['comment']
            
            if table_name not in cache:
                cache[table_name] = {}
            
            cache[table_name][field_name] = comment
        
        table_count = len(cache)
        field_count = sum(len(fields) for fields in cache.values())
        logger.info(f"Created mapping cache with {table_count} tables and {field_count} field descriptions")
        
        return cache
    
    def enhance_schema_with_descriptions(self, schema: Dict[str, Any], mapping_cache: Dict[str, Dict[str, str]]) -> Dict[str, Any]:
        """Add business descriptions to the schema based on mapping cache."""
        enhanced_schema = schema.copy()
        
        stats = {
            'total_columns': 0,
            'columns_with_descriptions': 0,
            'columns_without_descriptions': 0,
            'tables_processed': 0
        }
        
        logger.info("Enhancing schema with business descriptions...")
        
        for table_name, columns in enhanced_schema['tables'].items():
            stats['tables_processed'] += 1
            table_mappings = mapping_cache.get(table_name, {})
            
            for column in columns:
                stats['total_columns'] += 1
                column_name = column['column_name']
                
                # Add business_description field
                if column_name in table_mappings:
                    column['business_description'] = table_mappings[column_name]
                    stats['columns_with_descriptions'] += 1
                else:
                    column['business_description'] = ""  # Default empty description
                    stats['columns_without_descriptions'] += 1
        
        # Update metadata
        enhanced_schema['enhancement_info'] = {
            'enhanced_date': pd.Timestamp.now().isoformat(),
            'business_descriptions_added': True,
            'mapping_stats': stats
        }
        
        logger.info(f"Enhancement complete:")
        logger.info(f"  - Tables processed: {stats['tables_processed']}")
        logger.info(f"  - Total columns: {stats['total_columns']}")
        logger.info(f"  - Columns with descriptions: {stats['columns_with_descriptions']}")
        logger.info(f"  - Columns without descriptions: {stats['columns_without_descriptions']}")
        logger.info(f"  - Coverage: {(stats['columns_with_descriptions']/stats['total_columns']*100):.1f}%")
        
        return enhanced_schema
    
    def save_enhanced_schema(self, enhanced_schema: Dict[str, Any], output_file: str = "database_schema_with_descriptions.json"):
        """Save the enhanced schema to a new JSON file."""
        output_path = self.base_path / output_file
        
        logger.info(f"Saving enhanced schema to: {output_path}")
        
        with open(output_path, 'w', encoding='utf-8') as file:
            json.dump(enhanced_schema, file, indent=2, ensure_ascii=False)
        
        logger.info(f"✅ Enhanced schema saved successfully!")
        return output_path
    
    def process(self, mapping_file: str, schema_file: str = "database_schema.json", output_file: str = "database_schema_with_descriptions.json"):
        """Complete process to enhance database schema with business descriptions."""
        try:
            # Load original schema
            schema = self.load_database_schema(schema_file)
            
            # Load business mapping
            mapping_df = self.load_business_mapping(mapping_file)
            
            # Create mapping cache
            mapping_cache = self.create_mapping_cache(mapping_df)
            
            # Enhance schema
            enhanced_schema = self.enhance_schema_with_descriptions(schema, mapping_cache)
            
            # Save enhanced schema
            output_path = self.save_enhanced_schema(enhanced_schema, output_file)
            
            return output_path
            
        except Exception as e:
            logger.error(f"❌ Failed to process schema enhancement: {e}")
            raise

def main():
    """Main function to enhance database schema with business descriptions."""
    enhancer = DatabaseSchemaEnhancer(base_path='/Users/sharlenechew/redshift-semantic')
    
    # Use the actual mapping file provided
    mapping_file = "sh_data_annotation.xlsx"
    
    try:
        output_path = enhancer.process(mapping_file)
        print(f"\n✅ Success! Enhanced database schema saved to: {output_path}")
    except FileNotFoundError as e:
        print(f"\n❌ File not found: {e}")
        print("Please provide the Excel mapping file with columns: table, field, comment")
    except Exception as e:
        print(f"\n❌ Error: {e}")

if __name__ == "__main__":
    main()