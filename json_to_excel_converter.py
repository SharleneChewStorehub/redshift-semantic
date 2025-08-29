#!/usr/bin/env python3
"""
JSON to Excel Converter for Semantic Layer Documentation

This script converts specific JSON files from the semantic layer project into 
human-readable Excel files with intelligent multi-sheet organization.

Author: Generated for Semantic Layer Project
Date: 2025-01-15
Version: 2.0 - Multi-sheet approach
"""

import json
import pandas as pd
import os
from pathlib import Path
from typing import Dict, List, Any, Union, Tuple
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class JSONToExcelConverter:
    """Converts JSON files to Excel with intelligent flattening of nested structures."""
    
    def __init__(self, base_path: str = None):
        """Initialize converter with base path."""
        self.base_path = Path(base_path) if base_path else Path.cwd()
        
        # Define target files with their full paths
        self.target_files = {
            # Semantic layer core files
            'business_rules.json': 'source/sh-reports/semantic_layer_v2/core/business_rules.json',
            'data_catalog.json': 'source/sh-reports/semantic_layer_v2/core/data_catalog.json',
            'query_cookbook.json': 'source/sh-reports/semantic_layer_v2/core/query_cookbook.json',
            'query_patterns.json': 'source/sh-reports/semantic_layer_v2/core/query_patterns.json',
            'semantic_context.json': 'source/sh-reports/semantic_layer_v2/core/semantic_context.json',
            'value_mappings.json': 'source/sh-reports/semantic_layer_v2/core/value_mappings.json',
            
            # Database schema file
            'database_schema.json': 'database_schema.json'
        }
        
        # Files to explicitly exclude
        self.excluded_files = {'data_catalog_fixed.json'}
    
    def extract_sheets_from_json(self, json_data: Union[Dict, List], filename: str) -> Dict[str, pd.DataFrame]:
        """
        Extract multiple sheets from JSON data based on structure.
        
        Args:
            json_data: The JSON data to convert
            filename: Source filename for context
            
        Returns:
            Dictionary mapping sheet names to DataFrames
        """
        sheets = {}
        
        if isinstance(json_data, dict):
            # Add metadata sheet
            metadata = {}
            for key in ['version', 'description', 'last_updated', 'created_by']:
                if key in json_data:
                    metadata[key] = json_data[key]
            
            if metadata:
                sheets['Metadata'] = pd.DataFrame([metadata])
            
            # Handle different file types
            if filename == 'business_rules.json':
                sheets.update(self._extract_business_rules_sheets(json_data))
            elif filename == 'data_catalog.json':
                sheets.update(self._extract_data_catalog_sheets(json_data))
            elif filename == 'query_cookbook.json':
                sheets.update(self._extract_cookbook_sheets(json_data))
            elif filename == 'query_patterns.json':
                sheets.update(self._extract_patterns_sheets(json_data))
            elif filename == 'semantic_context.json':
                sheets.update(self._extract_semantic_context_sheets(json_data))
            elif filename == 'value_mappings.json':
                sheets.update(self._extract_value_mappings_sheets(json_data))
            elif filename == 'database_schema.json':
                sheets.update(self._extract_database_schema_sheets(json_data))
            else:
                # Generic handling for unknown structures
                sheets.update(self._extract_generic_sheets(json_data))
                
        elif isinstance(json_data, list):
            # Handle top-level arrays
            sheets['Items'] = self._list_to_dataframe(json_data)
        
        return sheets
    
    def _extract_business_rules_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from business_rules.json"""
        sheets = {}
        
        # Mandatory Filters
        if 'mandatory_filters' in data:
            filters_data = []
            for category, filters in data['mandatory_filters'].items():
                for filter_name, filter_info in filters.items():
                    row = {
                        'category': category,
                        'filter_name': filter_name,
                        **self._flatten_simple_dict(filter_info)
                    }
                    filters_data.append(row)
            if filters_data:
                sheets['Mandatory_Filters'] = pd.DataFrame(filters_data)
        
        # Data Quality Rules
        if 'data_quality_rules' in data:
            quality_data = []
            for category, rules in data['data_quality_rules'].items():
                for rule_name, rule_info in rules.items():
                    row = {
                        'category': category,
                        'rule_name': rule_name,
                        **self._flatten_simple_dict(rule_info)
                    }
                    quality_data.append(row)
            if quality_data:
                sheets['Data_Quality_Rules'] = pd.DataFrame(quality_data)
        
        # Performance Constraints
        if 'performance_constraints' in data:
            perf_data = []
            for category, constraints in data['performance_constraints'].items():
                if isinstance(constraints, dict):
                    for constraint_name, constraint_info in constraints.items():
                        row = {
                            'category': category,
                            'constraint_name': constraint_name,
                            **self._flatten_simple_dict(constraint_info)
                        }
                        perf_data.append(row)
                else:
                    perf_data.append({'category': category, 'value': str(constraints)})
            if perf_data:
                sheets['Performance_Constraints'] = pd.DataFrame(perf_data)
        
        # Security Rules
        if 'security_rules' in data:
            security_data = []
            for category, rules in data['security_rules'].items():
                if isinstance(rules, dict):
                    for rule_name, rule_info in rules.items():
                        row = {
                            'category': category,
                            'rule_name': rule_name,
                            **self._flatten_simple_dict(rule_info)
                        }
                        security_data.append(row)
                else:
                    security_data.append({'category': category, 'value': str(rules)})
            if security_data:
                sheets['Security_Rules'] = pd.DataFrame(security_data)
        
        return sheets
    
    def _extract_data_catalog_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from data_catalog.json"""
        sheets = {}
        
        # Business Entities
        if 'business_entities' in data:
            entities_data = []
            for entity_name, entity_info in data['business_entities'].items():
                row = {
                    'entity_name': entity_name,
                    'description': entity_info.get('description', ''),
                    'primary_table': entity_info.get('primary_table', ''),
                    'related_tables': ', '.join(entity_info.get('related_tables', [])),
                }
                entities_data.append(row)
            if entities_data:
                sheets['Business_Entities'] = pd.DataFrame(entities_data)
            
            # Key Metrics from entities
            metrics_data = []
            for entity_name, entity_info in data['business_entities'].items():
                if 'key_metrics' in entity_info:
                    for metric_name, metric_info in entity_info['key_metrics'].items():
                        row = {
                            'entity': entity_name,
                            'metric_name': metric_name,
                            **self._flatten_simple_dict(metric_info)
                        }
                        metrics_data.append(row)
            if metrics_data:
                sheets['Key_Metrics'] = pd.DataFrame(metrics_data)
        
        # Tables
        if 'tables' in data:
            tables_data = []
            for table_name, table_info in data['tables'].items():
                row = {
                    'table_name': table_name,
                    **self._flatten_simple_dict(table_info)
                }
                tables_data.append(row)
            if tables_data:
                sheets['Tables'] = pd.DataFrame(tables_data)
        
        # Calculated Fields
        if 'calculated_fields' in data:
            calc_data = []
            for field_name, field_info in data['calculated_fields'].items():
                row = {
                    'field_name': field_name,
                    **self._flatten_simple_dict(field_info)
                }
                calc_data.append(row)
            if calc_data:
                sheets['Calculated_Fields'] = pd.DataFrame(calc_data)
        
        return sheets
    
    def _extract_cookbook_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from query_cookbook.json"""
        sheets = {}
        
        if 'examples' in data:
            examples_data = []
            for example in data['examples']:
                row = {
                    'id': example.get('id', ''),
                    'natural_language': example.get('natural_language', ''),
                    'sql_query': example.get('sql_query', ''),
                    'explains': example.get('explains', ''),
                }
                
                # Handle intent analysis
                if 'intent_analysis' in example:
                    for key, value in example['intent_analysis'].items():
                        row[f'intent_{key}'] = str(value)
                
                # Handle parameters
                if 'parameters' in example:
                    for key, value in example['parameters'].items():
                        row[f'param_{key}'] = str(value)
                
                examples_data.append(row)
            
            if examples_data:
                sheets['Query_Examples'] = pd.DataFrame(examples_data)
        
        return sheets
    
    def _extract_patterns_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from query_patterns.json"""
        sheets = {}
        
        # Core Patterns
        if 'core_patterns' in data:
            patterns_data = []
            for pattern_name, pattern_info in data['core_patterns'].items():
                row = {
                    'pattern_name': pattern_name,
                    'purpose': pattern_info.get('purpose', ''),
                    'template': pattern_info.get('template', ''),
                    'performance_notes': pattern_info.get('performance_notes', ''),
                }
                
                # Handle variations
                if 'variations' in pattern_info:
                    for var_key, var_value in pattern_info['variations'].items():
                        row[f'variation_{var_key}'] = str(var_value)
                
                # Handle use cases
                if 'use_cases' in pattern_info:
                    row['use_cases'] = ', '.join(pattern_info['use_cases'])
                
                # Handle parameters
                if 'parameters' in pattern_info:
                    for param_key, param_value in pattern_info['parameters'].items():
                        row[f'param_{param_key}'] = str(param_value)
                
                patterns_data.append(row)
            
            if patterns_data:
                sheets['Core_Patterns'] = pd.DataFrame(patterns_data)
        
        # Other pattern categories
        for key, value in data.items():
            if key not in ['core_patterns', 'version', 'description', 'last_updated'] and isinstance(value, dict):
                pattern_data = []
                for item_name, item_info in value.items():
                    row = {
                        'category': key,
                        'item_name': item_name,
                        **self._flatten_simple_dict(item_info)
                    }
                    pattern_data.append(row)
                
                if pattern_data:
                    sheet_name = key.replace('_', ' ').title().replace(' ', '_')
                    sheets[sheet_name] = pd.DataFrame(pattern_data)
        
        return sheets
    
    def _extract_semantic_context_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from semantic_context.json"""
        sheets = {}
        
        # Domain Concepts
        if 'domain_concepts' in data:
            concepts_data = []
            for concept_name, concept_info in data['domain_concepts'].items():
                row = {
                    'concept_name': concept_name,
                    **self._flatten_simple_dict(concept_info)
                }
                concepts_data.append(row)
            if concepts_data:
                sheets['Domain_Concepts'] = pd.DataFrame(concepts_data)
        
        # Business Terminology
        if 'business_terminology' in data:
            terms_data = []
            for term_name, term_info in data['business_terminology'].items():
                row = {
                    'term_name': term_name,
                    **self._flatten_simple_dict(term_info)
                }
                terms_data.append(row)
            if terms_data:
                sheets['Business_Terminology'] = pd.DataFrame(terms_data)
        
        # Handle other top-level sections
        for key, value in data.items():
            if key not in ['domain_concepts', 'business_terminology', 'version', 'description', 'last_updated'] and isinstance(value, dict):
                section_data = []
                for item_name, item_info in value.items():
                    row = {
                        'item_name': item_name,
                        **self._flatten_simple_dict(item_info)
                    }
                    section_data.append(row)
                
                if section_data:
                    sheet_name = key.replace('_', ' ').title().replace(' ', '_')
                    sheets[sheet_name] = pd.DataFrame(section_data)
        
        return sheets
    
    def _extract_value_mappings_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from value_mappings.json"""
        sheets = {}
        
        # Field Mappings
        if 'field_mappings' in data:
            mappings_data = []
            for field_name, mapping_info in data['field_mappings'].items():
                if isinstance(mapping_info, dict) and 'values' in mapping_info:
                    for value, description in mapping_info['values'].items():
                        row = {
                            'field_name': field_name,
                            'value': value,
                            'description': description,
                            'data_type': mapping_info.get('data_type', ''),
                            'source_table': mapping_info.get('source_table', ''),
                        }
                        mappings_data.append(row)
                else:
                    row = {
                        'field_name': field_name,
                        **self._flatten_simple_dict(mapping_info)
                    }
                    mappings_data.append(row)
            
            if mappings_data:
                sheets['Field_Mappings'] = pd.DataFrame(mappings_data)
        
        # Standard Values
        if 'standard_values' in data:
            standards_data = []
            for category, values in data['standard_values'].items():
                if isinstance(values, dict):
                    for value_name, value_info in values.items():
                        row = {
                            'category': category,
                            'value_name': value_name,
                            **self._flatten_simple_dict(value_info)
                        }
                        standards_data.append(row)
                else:
                    standards_data.append({
                        'category': category,
                        'value': str(values)
                    })
            
            if standards_data:
                sheets['Standard_Values'] = pd.DataFrame(standards_data)
        
        return sheets
    
    def _extract_database_schema_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Extract sheets from database_schema.json"""
        sheets = {}
        
        if 'tables' in data:
            # All columns in one sheet
            all_columns = []
            for table_name, columns in data['tables'].items():
                if isinstance(columns, list):
                    for column in columns:
                        if isinstance(column, dict):
                            row = {'table_name': table_name, **column}
                            all_columns.append(row)
            
            if all_columns:
                sheets['Database_Schema'] = pd.DataFrame(all_columns)
            
            # Summary sheet with table statistics
            table_summary = []
            for table_name, columns in data['tables'].items():
                if isinstance(columns, list):
                    column_count = len(columns)
                    nullable_count = sum(1 for col in columns if isinstance(col, dict) and col.get('is_nullable') == 'YES')
                    has_defaults = sum(1 for col in columns if isinstance(col, dict) and col.get('column_default') is not None)
                    
                    table_summary.append({
                        'table_name': table_name,
                        'column_count': column_count,
                        'nullable_columns': nullable_count,
                        'columns_with_defaults': has_defaults,
                        'nullable_percentage': round((nullable_count / column_count) * 100, 1) if column_count > 0 else 0
                    })
            
            if table_summary:
                sheets['Table_Summary'] = pd.DataFrame(table_summary)
        
        return sheets
    
    def _extract_generic_sheets(self, data: Dict) -> Dict[str, pd.DataFrame]:
        """Generic extraction for unknown JSON structures"""
        sheets = {}
        
        for key, value in data.items():
            if key in ['version', 'description', 'last_updated']:
                continue
                
            if isinstance(value, dict):
                items_data = []
                for item_name, item_info in value.items():
                    row = {
                        'item_name': item_name,
                        **self._flatten_simple_dict(item_info)
                    }
                    items_data.append(row)
                
                if items_data:
                    sheet_name = key.replace('_', ' ').title().replace(' ', '_')
                    sheets[sheet_name] = pd.DataFrame(items_data)
            
            elif isinstance(value, list):
                sheet_name = key.replace('_', ' ').title().replace(' ', '_')
                sheets[sheet_name] = self._list_to_dataframe(value)
        
        return sheets
    
    def _flatten_simple_dict(self, obj: Any, max_depth: int = 2) -> Dict[str, Any]:
        """Flatten a dictionary with limited depth to avoid too many columns"""
        if not isinstance(obj, dict):
            return {'value': str(obj)}
        
        result = {}
        for key, value in obj.items():
            if isinstance(value, dict) and max_depth > 0:
                # Flatten one level deeper
                for sub_key, sub_value in value.items():
                    if isinstance(sub_value, (list, dict)):
                        result[f"{key}_{sub_key}"] = str(sub_value)
                    else:
                        result[f"{key}_{sub_key}"] = sub_value
            elif isinstance(value, list):
                if value and isinstance(value[0], str):
                    result[key] = ', '.join(value)
                else:
                    result[key] = str(value)
            else:
                result[key] = value
        
        return result
    
    def _list_to_dataframe(self, items: List) -> pd.DataFrame:
        """Convert a list to DataFrame"""
        if not items:
            return pd.DataFrame()
        
        if isinstance(items[0], dict):
            # List of dictionaries
            flattened_items = []
            for i, item in enumerate(items):
                flattened = self._flatten_simple_dict(item)
                flattened['_index'] = i
                flattened_items.append(flattened)
            return pd.DataFrame(flattened_items)
        else:
            # List of primitives
            return pd.DataFrame({'value': items, 'index': range(len(items))})
    

    
    def load_json_file(self, file_path: Path) -> Dict[str, Any]:
        """
        Load and parse a JSON file.
        
        Args:
            file_path: Path to the JSON file
            
        Returns:
            Parsed JSON data
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                return json.load(file)
        except json.JSONDecodeError as e:
            logger.error(f"Invalid JSON in {file_path}: {e}")
            raise
        except FileNotFoundError:
            logger.error(f"File not found: {file_path}")
            raise
    
    def save_to_excel(self, sheets_data: Dict[str, pd.DataFrame], output_path: Path) -> None:
        """
        Save multiple DataFrames to Excel file with multiple sheets and formatting.
        
        Args:
            sheets_data: Dictionary mapping sheet names to DataFrames
            output_path: Path for the output Excel file
        """
        try:
            with pd.ExcelWriter(output_path, engine='openpyxl') as writer:
                sheet_count = 0
                
                for sheet_name, dataframe in sheets_data.items():
                    if dataframe.empty:
                        continue
                    
                    # Clean sheet name (Excel has limitations)
                    clean_sheet_name = self._clean_sheet_name(sheet_name)
                    
                    # Write to sheet
                    dataframe.to_excel(writer, sheet_name=clean_sheet_name, index=False)
                    sheet_count += 1
                    
                    # Get the worksheet for formatting
                    worksheet = writer.sheets[clean_sheet_name]
                    
                    # Auto-adjust column widths
                    for column in worksheet.columns:
                        max_length = 0
                        column_letter = column[0].column_letter
                        
                        for cell in column:
                            try:
                                cell_value = str(cell.value) if cell.value is not None else ''
                                if len(cell_value) > max_length:
                                    max_length = len(cell_value)
                            except:
                                pass
                        
                        # Set column width (with some padding and max limit)
                        adjusted_width = min(max(max_length + 2, 10), 100)
                        worksheet.column_dimensions[column_letter].width = adjusted_width
                
                logger.info(f"Successfully saved Excel file: {output_path} with {sheet_count} sheets")
                
        except Exception as e:
            logger.error(f"Failed to save Excel file {output_path}: {e}")
            raise
    
    def _clean_sheet_name(self, name: str) -> str:
        """Clean sheet name to meet Excel requirements"""
        # Excel sheet names cannot exceed 31 characters and cannot contain certain characters
        invalid_chars = ['\\', '/', '*', '[', ']', ':', '?']
        clean_name = name
        
        for char in invalid_chars:
            clean_name = clean_name.replace(char, '_')
        
        # Truncate if too long
        if len(clean_name) > 31:
            clean_name = clean_name[:31]
        
        return clean_name
    
    def convert_file(self, json_filename: str) -> bool:
        """
        Convert a single JSON file to Excel with multiple sheets.
        
        Args:
            json_filename: Name of the JSON file to convert
            
        Returns:
            True if successful, False otherwise
        """
        if json_filename in self.excluded_files:
            logger.info(f"Skipping excluded file: {json_filename}")
            return True
        
        if json_filename not in self.target_files:
            logger.warning(f"File {json_filename} not in target list")
            return False
        
        try:
            # Construct full path
            json_path = self.base_path / self.target_files[json_filename]
            
            if not json_path.exists():
                logger.error(f"File does not exist: {json_path}")
                return False
            
            logger.info(f"Processing: {json_filename}")
            
            # Load JSON data
            json_data = self.load_json_file(json_path)
            
            # Extract sheets from JSON
            sheets = self.extract_sheets_from_json(json_data, json_filename)
            
            if not sheets:
                logger.warning(f"No sheets extracted from {json_filename}")
                return False
            
            # Create output filename
            excel_filename = json_filename.replace('.json', '.xlsx')
            excel_path = self.base_path / excel_filename
            
            # Save to Excel
            self.save_to_excel(sheets, excel_path)
            
            # Calculate summary stats
            total_rows = sum(len(df) for df in sheets.values())
            sheet_info = [f"{name}({len(df)} rows)" for name, df in sheets.items() if not df.empty]
            
            logger.info(f"✅ Successfully converted {json_filename} to {excel_filename}")
            logger.info(f"   - Total sheets: {len(sheets)}")
            logger.info(f"   - Total rows: {total_rows}")
            logger.info(f"   - Sheets: {', '.join(sheet_info)}")
            
            return True
            
        except Exception as e:
            logger.error(f"❌ Failed to convert {json_filename}: {e}")
            return False
    
    def convert_all_files(self) -> Dict[str, bool]:
        """
        Convert all target JSON files to Excel.
        
        Returns:
            Dictionary with conversion results for each file
        """
        results = {}
        
        logger.info("Starting JSON to Excel conversion process...")
        logger.info(f"Base path: {self.base_path}")
        logger.info(f"Target files: {len(self.target_files)}")
        
        for json_filename in self.target_files.keys():
            results[json_filename] = self.convert_file(json_filename)
        
        # Summary
        successful = sum(1 for success in results.values() if success)
        total = len(results)
        
        logger.info(f"\n📊 Conversion Summary:")
        logger.info(f"   - Total files processed: {total}")
        logger.info(f"   - Successful conversions: {successful}")
        logger.info(f"   - Failed conversions: {total - successful}")
        
        if successful == total:
            logger.info("🎉 All files converted successfully!")
        else:
            logger.warning("⚠️ Some files failed to convert. Check the logs above for details.")
        
        return results


def main():
    """Main function to run the converter."""
    # Initialize converter with the project root path
    converter = JSONToExcelConverter(base_path='/Users/sharlenechew/redshift-semantic')
    
    # Convert all target files
    results = converter.convert_all_files()
    
    # Print final status
    failed_files = [filename for filename, success in results.items() if not success]
    if failed_files:
        print(f"\n❌ Failed to convert: {', '.join(failed_files)}")
        exit(1)
    else:
        print(f"\n✅ All {len(results)} files converted successfully!")


if __name__ == "__main__":
    main()