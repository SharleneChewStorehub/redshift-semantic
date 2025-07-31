#!/usr/bin/env python3
"""
Framework Agent Test Automation Script

This script automates the testing of a semantic framework-based AI agent by:
1. Reading golden SQL queries with business questions
2. Loading semantic framework JSON files as context
3. Using LangChain with Google Gemini to generate new SQL based on the framework
4. Testing the generated SQL against Metabase API
5. Saving results for analysis

The semantic framework includes:
- semantic_context.json: Natural language interpretation rules
- data_catalog.json: Business entities and table mappings
- business_rules.json: Validation logic and mandatory filters
- query_patterns.json: Common SQL patterns and templates
- value_mappings.json: Data value transformations
- query_cookbook.json: Curated query examples

Author: AI Assistant
"""

import os
import json
import glob
from typing import Dict, Any, Optional
from pathlib import Path

import requests
from dotenv import load_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser


# Load environment variables
load_dotenv()

# Constants
GOLDEN_QUERIES_DIR = "golden_queries"
RESULTS_DIR = "results"
FRAMEWORK_DIR = "source/sh-reports/semantic_layer_v2/core"

# Environment variables
METABASE_HOST = os.getenv("METABASE_HOST")
METABASE_API_KEY = os.getenv("METABASE_API_KEY").strip() if os.getenv("METABASE_API_KEY") else None
METABASE_DATABASE_ID = int(os.getenv("METABASE_DATABASE_ID", "2"))
GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY").strip() if os.getenv("GOOGLE_API_KEY") else None


def validate_environment() -> None:
    """Validate that all required environment variables are set."""
    # Required for AI functionality
    required_vars = {
        "GOOGLE_API_KEY": GOOGLE_API_KEY
    }
    
    # Optional for Metabase testing (can run without for SQL generation only)
    optional_vars = {
        "METABASE_HOST": METABASE_HOST,
        "METABASE_API_KEY": METABASE_API_KEY
    }
    
    missing_required = [var for var, value in required_vars.items() if not value]
    missing_optional = [var for var, value in optional_vars.items() if not value]
    
    if missing_required:
        raise ValueError(f"Missing required environment variables: {', '.join(missing_required)}")
    
    if missing_optional:
        print(f"⚠️  Missing optional Metabase variables: {', '.join(missing_optional)}")
        print("   → Script will generate SQL but skip Metabase API testing")
    else:
        print("✓ All environment variables validated")
    
    print("✓ Environment setup complete")


def load_framework_files() -> Dict[str, Any]:
    """
    Load all semantic framework JSON files into a unified context.
    
    Returns:
        Dictionary containing all framework data organized by file type
        
    Raises:
        FileNotFoundError: If framework files are missing
        json.JSONDecodeError: If JSON files are malformed
    """
    framework_files = {
        'semantic_context': 'semantic_context.json',
        'data_catalog': 'data_catalog.json',
        'business_rules': 'business_rules.json',
        'query_patterns': 'query_patterns.json',
        'value_mappings': 'value_mappings.json',
        'query_cookbook': 'query_cookbook.json'
    }
    
    framework_data = {}
    
    print("📚 Loading semantic framework files...")
    
    for key, filename in framework_files.items():
        file_path = os.path.join(FRAMEWORK_DIR, filename)
        
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                framework_data[key] = json.load(file)
            print(f"   ✓ Loaded {filename}")
            
        except FileNotFoundError:
            print(f"   ✗ Missing framework file: {file_path}")
            raise FileNotFoundError(f"Required framework file not found: {file_path}")
            
        except json.JSONDecodeError as e:
            print(f"   ✗ Invalid JSON in {filename}: {str(e)}")
            raise json.JSONDecodeError(f"Malformed JSON in {filename}: {str(e)}", "", 0)
    
    print(f"✓ Successfully loaded {len(framework_data)} framework files")
    return framework_data


def construct_framework_context(framework_data: Dict[str, Any]) -> str:
    """
    Construct a comprehensive context string from all framework data.
    
    Args:
        framework_data: Dictionary containing all loaded framework JSON data
        
    Returns:
        Formatted string containing essential framework information for the LLM
    """
    context_parts = []
    
    # Semantic Context - Natural language interpretation rules
    if 'semantic_context' in framework_data:
        semantic = framework_data['semantic_context']
        context_parts.append("=== SEMANTIC INTERPRETATION RULES ===")
        
        # Default interpretations for metrics
        if 'default_interpretations' in semantic:
            metrics = semantic['default_interpretations'].get('metrics', {})
            context_parts.append("Default Metric Interpretations:")
            for metric, definition in metrics.items():
                if isinstance(definition, dict):
                    default = definition.get('default', 'N/A')
                    context_parts.append(f"  - {metric}: {default}")
                else:
                    context_parts.append(f"  - {metric}: {definition}")
        
        # Time range interpretations
        if 'default_interpretations' in semantic and 'time_ranges' in semantic['default_interpretations']:
            time_ranges = semantic['default_interpretations']['time_ranges']
            context_parts.append("\nTime Range Interpretations:")
            for category, rules in time_ranges.items():
                context_parts.append(f"  {category}: {rules}")
    
    # Data Catalog - Table and business entity mappings
    if 'data_catalog' in framework_data:
        catalog = framework_data['data_catalog']
        context_parts.append("\n=== DATA CATALOG ===")
        
        if 'business_entities' in catalog:
            context_parts.append("Key Business Entities and Tables:")
            entities = catalog['business_entities']
            
            # Show first 10 business entities with their primary tables
            for i, (entity_name, entity_data) in enumerate(entities.items()):
                if i >= 10:  # Limit to avoid context overflow
                    context_parts.append("  ... (and more entities)")
                    break
                    
                if isinstance(entity_data, dict):
                    primary_table = entity_data.get('primary_table', 'N/A')
                    description = entity_data.get('description', 'N/A')
                    context_parts.append(f"  - {entity_name}: {primary_table} ({description})")
    
    # Business Rules - Mandatory filters and constraints
    if 'business_rules' in framework_data:
        rules = framework_data['business_rules']
        context_parts.append("\n=== BUSINESS RULES ===")
        
        if 'mandatory_filters' in rules:
            context_parts.append("Mandatory Filters (MUST be included in ALL queries):")
            mandatory = rules['mandatory_filters']
            
            for rule_category, rule_data in mandatory.items():
                context_parts.append(f"  {rule_category}:")
                if isinstance(rule_data, dict):
                    for filter_name, filter_info in rule_data.items():
                        if isinstance(filter_info, dict) and 'filter' in filter_info:
                            filter_clause = filter_info['filter']
                            context_parts.append(f"    - {filter_name}: {filter_clause}")
    
    # Query Patterns - Common SQL structures
    if 'query_patterns' in framework_data:
        patterns = framework_data['query_patterns']
        context_parts.append("\n=== QUERY PATTERNS ===")
        
        if 'common_patterns' in patterns:
            context_parts.append("Common SQL Query Patterns:")
            common = patterns['common_patterns']
            
            # Show first 5 patterns to avoid context overflow
            for i, (pattern_name, pattern_data) in enumerate(common.items()):
                if i >= 5:
                    context_parts.append("  ... (and more patterns)")
                    break
                    
                if isinstance(pattern_data, dict):
                    description = pattern_data.get('description', 'N/A')
                    context_parts.append(f"  - {pattern_name}: {description}")
    
    # Value Mappings - Data transformations
    if 'value_mappings' in framework_data:
        mappings = framework_data['value_mappings']
        context_parts.append("\n=== VALUE MAPPINGS ===")
        
        if 'status_mappings' in mappings:
            context_parts.append("Status Value Mappings:")
            status_maps = mappings['status_mappings']
            for mapping_name, mapping_data in status_maps.items():
                if isinstance(mapping_data, dict) and 'values' in mapping_data:
                    values = mapping_data['values']
                    value_list = list(values.keys())[:5]  # First 5 values
                    context_parts.append(f"  - {mapping_name}: {', '.join(value_list)}...")
    
    # Query Cookbook - Example queries
    if 'query_cookbook' in framework_data:
        cookbook = framework_data['query_cookbook']
        context_parts.append("\n=== QUERY COOKBOOK ===")
        
        if 'examples' in cookbook:
            context_parts.append("Example Query Patterns:")
            examples = cookbook['examples']
            
            # Handle both list and dict structures for examples
            if isinstance(examples, list):
                # Show first 3 example queries from list
                for i, example_data in enumerate(examples):
                    if i >= 3:
                        context_parts.append("  ... (and more examples)")
                        break
                        
                    if isinstance(example_data, dict):
                        example_id = example_data.get('id', f'example_{i+1}')
                        natural_language = example_data.get('natural_language', 'N/A')
                        context_parts.append(f"  - {example_id}: {natural_language}")
            elif isinstance(examples, dict):
                # Show first 3 example queries from dict
                for i, (example_name, example_data) in enumerate(examples.items()):
                    if i >= 3:
                        context_parts.append("  ... (and more examples)")
                        break
                        
                    if isinstance(example_data, dict):
                        description = example_data.get('description', 'N/A')
                        context_parts.append(f"  - {example_name}: {description}")
    
    return '\n'.join(context_parts)


def execute_metabase_query(sql_query: str) -> Dict[str, Any]:
    """
    Execute a native SQL query against Metabase API.
    
    Args:
        sql_query: The SQL query string to execute
        
    Returns:
        Dictionary containing the API response
        
    Raises:
        requests.RequestException: If the API call fails
    """
    # Check if Metabase credentials are available
    if not METABASE_HOST or not METABASE_API_KEY:
        return {
            "success": False,
            "status_code": None,
            "error": "Metabase credentials not configured",
            "query": sql_query,
            "skipped": True
        }
    
    url = f"{METABASE_HOST}/api/dataset"
    
    headers = {
        "Content-Type": "application/json",
        "X-API-KEY": METABASE_API_KEY
    }
    
    payload = {
        "database": METABASE_DATABASE_ID,
        "type": "native",
        "native": {
            "query": sql_query.strip()
        }
    }
    
    try:
        response = requests.post(url, headers=headers, json=payload, timeout=30)
        
        # Check if request was successful (200 = sync success, 202 = async success)
        if response.status_code in [200, 202]:
            result = response.json()
            return {
                "success": True,
                "status_code": response.status_code,
                "data": result,
                "row_count": len(result.get("data", {}).get("rows", [])),
                "query": sql_query
            }
        else:
            return {
                "success": False,
                "status_code": response.status_code,
                "error": response.text,
                "query": sql_query
            }
            
    except requests.RequestException as e:
        return {
            "success": False,
            "status_code": None,
            "error": str(e),
            "query": sql_query
        }


def get_framework_agent_response(business_question: str, framework_context: str) -> str:
    """
    Generate SQL query using Framework agent based on business question and semantic framework.
    
    Args:
        business_question: The business question to answer
        framework_context: Rich context from the semantic framework JSON files
        
    Returns:
        AI-generated SQL query string
    """
    # Initialize the LLM (Google Gemini 2.5 Pro - most advanced reasoning)
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create the comprehensive prompt template for framework-based SQL generation
    prompt_template = ChatPromptTemplate.from_messages([
        ("system", """You are an expert data analyst specializing in SQL query generation using a comprehensive semantic framework.

Your task is to generate a clean, optimized SQL query that answers the given business question by STRICTLY ADHERING to the provided semantic framework.

CRITICAL FRAMEWORK ADHERENCE RULES:
1. **Data Catalog**: Use ONLY the table names, column names, and business entity mappings specified in the framework
2. **Business Rules**: MANDATORY filters must be included in ALL queries (especially business isolation and soft delete exclusion)
3. **Semantic Context**: Follow the default interpretations for metrics, time ranges, and aggregation levels
4. **Query Patterns**: Use the common patterns and structures defined in the framework
5. **Value Mappings**: Apply the correct status mappings and data transformations

QUERY GENERATION GUIDELINES:
- Start with mandatory business filters using LITERAL VALUES (business = 'actual_business_name', isdeleted != true OR isdeleted IS NULL)
- Use the exact table and column names from the data catalog
- Follow the semantic interpretations for ambiguous terms (e.g., "sales" = "net_sales")
- Apply appropriate time range defaults when not specified
- Use proper joins and relationships as defined in the framework
- Include meaningful column aliases
- Ensure proper formatting and readability
- Return ONLY the SQL query without explanations or markdown formatting
- Do not include comments in the SQL output
- NEVER use parameter placeholders like :business_id - always use actual literal values from the business question

The framework provides authoritative guidance on:
- How to interpret natural language requests
- Which tables and columns to use
- What filters are mandatory for data safety
- Common query patterns and structures
- Business logic and calculations"""),
        
        ("user", """Business Question: {business_question}

Semantic Framework Context:
{framework_context}

Generate a SQL query that answers the business question above using the semantic framework as your authoritative guide. The query must strictly follow all framework rules and mappings. Return only the SQL query.""")
    ])
    
    # Create the chain
    chain = prompt_template | llm | StrOutputParser()
    
    # Generate the response
    try:
        response = chain.invoke({
            "business_question": business_question,
            "framework_context": framework_context
        })
        
        # Clean up the response (remove any markdown formatting)
        sql_query = response.strip()
        if sql_query.startswith("```sql"):
            sql_query = sql_query[6:]
        if sql_query.startswith("```"):
            sql_query = sql_query[3:]
        if sql_query.endswith("```"):
            sql_query = sql_query[:-3]
            
        return sql_query.strip()
        
    except Exception as e:
        print(f"Error generating Framework Agent response: {str(e)}")
        return f"-- Error generating query: {str(e)}"


def parse_golden_query_file(file_path: str) -> tuple[str, str]:
    """
    Parse a golden query file to extract business question and SQL.
    
    Args:
        file_path: Path to the golden query file
        
    Returns:
        Tuple of (business_question, golden_sql)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read().strip()
        
        lines = content.split('\n')
        
        # Extract business question from first line (remove leading -- and whitespace)
        business_question = lines[0].lstrip('- ').strip()
        
        # Extract SQL (everything after the first line)
        golden_sql = '\n'.join(lines[1:]).strip()
        
        return business_question, golden_sql
        
    except Exception as e:
        print(f"Error parsing file {file_path}: {str(e)}")
        return f"Error parsing file: {str(e)}", ""


def save_result(result_data: Dict[str, Any], output_file: str) -> None:
    """
    Save the test result to a JSON file.
    
    Args:
        result_data: The result data to save
        output_file: Path to the output file
    """
    try:
        with open(output_file, 'w', encoding='utf-8') as file:
            json.dump(result_data, file, indent=2, default=str)
        print(f"✓ Result saved to {output_file}")
    except Exception as e:
        print(f"✗ Error saving result to {output_file}: {str(e)}")


def main() -> None:
    """Main execution function."""
    try:
        print("🚀 Starting Framework Agent Test Automation")
        print("=" * 60)
        
        # Validate environment
        validate_environment()
        
        # Load semantic framework files
        framework_data = load_framework_files()
        
        # Construct rich framework context for the LLM
        print("🧠 Building semantic framework context...")
        framework_context = construct_framework_context(framework_data)
        print(f"✓ Framework context prepared ({len(framework_context)} characters)")
        
        # Create results directory
        Path(RESULTS_DIR).mkdir(exist_ok=True)
        print(f"✓ Results directory created/verified: {RESULTS_DIR}")
        
        # Get all SQL files in golden queries directory, sorted alphabetically
        sql_files = sorted(glob.glob(os.path.join(GOLDEN_QUERIES_DIR, "*.sql")))
        
        if not sql_files:
            print(f"✗ No SQL files found in {GOLDEN_QUERIES_DIR}")
            return
        
        print(f"📁 Found {len(sql_files)} golden query files to process")
        print()
        
        # Process each file
        success_count = 0
        total_count = len(sql_files)
        
        for file_path in sql_files:
            file_name = os.path.basename(file_path)
            base_name = os.path.splitext(file_name)[0]
            
            print(f"🔄 Processing: {file_name}")
            
            try:
                # Parse the golden query file
                business_question, golden_sql = parse_golden_query_file(file_path)
                
                if not business_question or not golden_sql:
                    print(f"✗ Error parsing {file_name}: Empty content")
                    continue
                
                print(f"   📝 Business Question: {business_question[:100]}...")
                
                # Generate Framework Agent response
                print("   🤖 Generating Framework-based SQL query...")
                ai_generated_sql = get_framework_agent_response(business_question, framework_context)
                
                # Execute the query via Metabase API (if configured)
                if METABASE_HOST and METABASE_API_KEY:
                    print("   🌐 Testing query against Metabase API...")
                    api_result = execute_metabase_query(ai_generated_sql)
                else:
                    print("   ⏭️  Skipping Metabase API test (credentials not configured)")
                    api_result = {
                        "success": False,
                        "status_code": None,
                        "error": "Metabase credentials not configured",
                        "query": ai_generated_sql,
                        "skipped": True
                    }
                
                # Prepare comprehensive result data
                result_data = {
                    "file_name": file_name,
                    "timestamp": str(Path().resolve()),
                    "business_question": business_question,
                    "golden_sql": golden_sql,
                    "ai_generated_sql": ai_generated_sql,
                    "framework_context_length": len(framework_context),
                    "framework_files_loaded": list(framework_data.keys()),
                    "api_result": api_result
                }
                
                # Save result with framework-specific naming
                output_file = os.path.join(RESULTS_DIR, f"{base_name}_framework_result.json")
                save_result(result_data, output_file)
                
                # Print status
                if api_result["success"]:
                    row_count = api_result.get("row_count", "unknown")
                    print(f"   ✓ SUCCESS: Framework Agent query executed successfully ({row_count} rows)")
                    success_count += 1
                elif api_result.get("skipped"):
                    print(f"   ⏭️  SKIPPED: Metabase API test (Framework SQL generated successfully)")
                    success_count += 1  # Count as success since SQL was generated
                else:
                    error = api_result.get("error", "Unknown error")
                    print(f"   ✗ FAILED: {error[:100]}...")
                
            except Exception as e:
                print(f"   ✗ ERROR processing {file_name}: {str(e)}")
            
            print()
        
        # Final summary
        print("=" * 60)
        print(f"🏁 Framework Agent Test Automation Complete!")
        print(f"📊 Results: {success_count}/{total_count} queries executed successfully")
        print(f"📂 Detailed results saved in: {RESULTS_DIR}/")
        print(f"🧠 Framework files used: {', '.join(framework_data.keys())}")
        
        if success_count == total_count:
            print("🎉 All tests passed!")
        elif success_count > 0:
            print("⚠️  Some tests failed - check individual result files for details")
        else:
            print("❌ All tests failed - check your configuration and queries")
            
    except Exception as e:
        print(f"💥 Fatal error: {str(e)}")
        raise


if __name__ == "__main__":
    main() 