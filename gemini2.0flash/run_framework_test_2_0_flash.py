#!/usr/bin/env python3
"""
Framework Agent Test Automation Script - Gemini 2.0 Flash Version

This script automates the testing of a semantic framework-based AI agent by:
1. Reading golden SQL queries with business questions
2. Loading semantic framework JSON files as context
3. Using LangChain with Google Gemini 2.0 Flash to generate new SQL based on the framework
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
load_dotenv("../.env")

# Constants
GOLDEN_QUERIES_DIR = "../golden_queries"
RESULTS_DIR = "results_framework"
FRAMEWORK_DIR = "../source/sh-reports/semantic_layer_v2/core"

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
        "METABASE_API_KEY": METABASE_API_KEY,
        "METABASE_DATABASE_ID": METABASE_DATABASE_ID
    }
    
    # Check required vars
    missing_required = [k for k, v in required_vars.items() if not v]
    if missing_required:
        raise ValueError(f"Missing required environment variables: {missing_required}")
    
    # Check optional vars and warn
    missing_optional = [k for k, v in optional_vars.items() if not v]
    if missing_optional:
        print(f"Warning: Missing optional environment variables for Metabase testing: {missing_optional}")
        print("SQL will be generated but not tested against Metabase API")


def load_framework_file(file_path: str) -> Dict[str, Any]:
    """Load a single JSON framework file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Warning: Framework file not found: {file_path}")
        return {}
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON file {file_path}: {e}")
        return {}
    except Exception as e:
        print(f"Error loading framework file {file_path}: {e}")
        return {}


def load_semantic_framework() -> Dict[str, str]:
    """
    Load all semantic framework components and convert to formatted text.
    
    Returns:
        Dictionary containing formatted framework context and metadata
    """
    framework_files = {
        "semantic_context": "semantic_context.json",
        "data_catalog": "data_catalog.json", 
        "business_rules": "business_rules.json",
        "query_patterns": "query_patterns.json",
        "value_mappings": "value_mappings.json",
        "query_cookbook": "query_cookbook.json"
    }
    
    framework_context = ""
    loaded_files = []
    total_length = 0
    
    for component_name, filename in framework_files.items():
        file_path = os.path.join(FRAMEWORK_DIR, filename)
        framework_data = load_framework_file(file_path)
        
        if framework_data:
            loaded_files.append(component_name)
            
            # Format the component data
            component_text = f"\n# {component_name.upper().replace('_', ' ')}\n"
            component_text += "=" * 50 + "\n"
            component_text += json.dumps(framework_data, indent=2, ensure_ascii=False)
            component_text += "\n\n"
            
            framework_context += component_text
            total_length += len(component_text)
    
    return {
        "context": framework_context,
        "loaded_files": loaded_files,
        "total_length": total_length
    }


def extract_business_question(sql_content: str) -> str:
    """Extract the business question from SQL file comment."""
    lines = sql_content.strip().split('\n')
    for line in lines:
        if line.strip().startswith('--') and len(line.strip()) > 3:
            # Remove comment marker and clean up
            question = line.strip()[2:].strip()
            if question and not question.lower().startswith('for'):  # Skip structural comments
                return question
    return "No business question found in SQL file"


def read_golden_query(file_path: str) -> Dict[str, str]:
    """Read a golden SQL query file and extract business question and SQL."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        business_question = extract_business_question(sql_content)
        
        return {
            "file_name": os.path.basename(file_path),
            "business_question": business_question,
            "golden_sql": sql_content
        }
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return {}


def get_framework_agent_response(business_question: str, framework_context: str) -> str:
    """
    Generate SQL query using Framework agent based on business question and semantic framework.
    
    Args:
        business_question: The business question to answer
        framework_context: Rich context from the semantic framework JSON files
        
    Returns:
        AI-generated SQL query string
    """
    # Initialize the LLM (Google Gemini 2.0 Flash)
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.0-flash",
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
        
        ("human", """Business Question: {business_question}

Semantic Framework Context:
{framework_context}

Generate a SQL query that answers this business question using the semantic framework above.""")
    ])
    
    # Create the chain
    chain = prompt_template | llm | StrOutputParser()
    
    try:
        # Generate the SQL query
        sql_query = chain.invoke({
            "business_question": business_question,
            "framework_context": framework_context
        })
        
        # Clean up the response (remove any markdown formatting)
        sql_query = sql_query.strip()
        if sql_query.startswith("```sql"):
            sql_query = sql_query[6:]
        if sql_query.startswith("```"):
            sql_query = sql_query[3:]
        if sql_query.endswith("```"):
            sql_query = sql_query[:-3]
        
        return sql_query.strip()
        
    except Exception as e:
        print(f"Error generating SQL with Framework agent: {e}")
        return f"-- Error generating SQL: {str(e)}"


def test_sql_with_metabase(sql_query: str) -> Dict[str, Any]:
    """Test the generated SQL against Metabase API."""
    if not all([METABASE_HOST, METABASE_API_KEY]):
        return {
            "success": False,
            "error": "Metabase configuration not available",
            "row_count": 0
        }
    
    url = f"{METABASE_HOST}/api/dataset"
    
    payload = {
        "database": METABASE_DATABASE_ID,
        "type": "native",
        "native": {
            "query": sql_query
        },
        "middleware": {
            "js-int-to-string?": True,
            "add-default-userland-constraints?": True
        }
    }
    
    headers = {
        "Content-Type": "application/json",
        "X-API-KEY": METABASE_API_KEY
    }
    
    try:
        response = requests.post(url, json=payload, headers=headers, timeout=30)
        result_data = response.json()
        
        # Extract row count if available
        row_count = 0
        if "data" in result_data and "rows" in result_data["data"]:
            row_count = len(result_data["data"]["rows"])
        
        return {
            "success": response.status_code == 202,
            "status_code": response.status_code,
            "data": result_data,
            "row_count": row_count,
            "query": sql_query
        }
        
    except requests.exceptions.Timeout:
        return {
            "success": False,
            "error": "Request timeout",
            "row_count": 0,
            "query": sql_query
        }
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "row_count": 0,
            "query": sql_query
        }


def save_result(result: Dict[str, Any], output_dir: str) -> None:
    """Save the test result to a JSON file."""
    os.makedirs(output_dir, exist_ok=True)
    
    file_name = result["file_name"].replace(".sql", "_framework_result.json")
    output_path = os.path.join(output_dir, file_name)
    
    # Add timestamp
    from datetime import datetime
    result["timestamp"] = datetime.now().isoformat()
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2, default=str)
    
    print(f"Result saved to: {output_path}")


def run_single_test(sql_file_path: str, framework_info: Dict[str, Any], output_dir: str) -> Dict[str, Any]:
    """Run a single test case."""
    print(f"\n{'='*50}")
    print(f"Testing: {os.path.basename(sql_file_path)}")
    print(f"{'='*50}")
    
    # Read golden query
    golden_data = read_golden_query(sql_file_path)
    if not golden_data:
        return {}
    
    business_question = golden_data["business_question"]
    print(f"Business Question: {business_question}")
    
    # Generate SQL with Framework agent
    print("\nGenerating SQL with Gemini 2.0 Flash Framework agent...")
    ai_generated_sql = get_framework_agent_response(business_question, framework_info["context"])
    
    print(f"Generated SQL:\n{ai_generated_sql[:200]}...")
    
    # Test with Metabase
    print("\nTesting SQL with Metabase...")
    api_result = test_sql_with_metabase(ai_generated_sql)
    
    if api_result["success"]:
        print(f"✅ SQL executed successfully! Row count: {api_result['row_count']}")
    else:
        print(f"❌ SQL execution failed: {api_result.get('error', 'Unknown error')}")
    
    # Compile result with framework metadata
    result = {
        **golden_data,
        "ai_generated_sql": ai_generated_sql,
        "framework_context_length": framework_info["total_length"],
        "framework_files_loaded": framework_info["loaded_files"],
        "api_result": api_result
    }
    
    # Save result
    save_result(result, output_dir)
    
    return result


def main():
    """Main execution function."""
    print("🚀 Starting Framework Agent Testing with Gemini 2.0 Flash")
    print("="*65)
    
    # Validate environment
    try:
        validate_environment()
    except ValueError as e:
        print(f"❌ Environment validation failed: {e}")
        return
    
    # Load semantic framework
    print("📚 Loading semantic framework...")
    framework_info = load_semantic_framework()
    
    if not framework_info["loaded_files"]:
        print("❌ No framework files could be loaded. Check the framework directory.")
        return
    
    print(f"✅ Loaded framework components: {', '.join(framework_info['loaded_files'])}")
    print(f"📏 Total framework context length: {framework_info['total_length']:,} characters")
    
    # Find all SQL files
    sql_files = glob.glob(os.path.join(GOLDEN_QUERIES_DIR, "*.sql"))
    sql_files.sort()
    
    if not sql_files:
        print(f"❌ No SQL files found in {GOLDEN_QUERIES_DIR}")
        return
    
    print(f"📁 Found {len(sql_files)} SQL files to test")
    
    # Create output directory
    os.makedirs(RESULTS_DIR, exist_ok=True)
    
    # Run tests
    results = []
    successful_tests = 0
    
    for sql_file in sql_files:
        result = run_single_test(sql_file, framework_info, RESULTS_DIR)
        if result:
            results.append(result)
            if result.get("api_result", {}).get("success", False):
                successful_tests += 1
    
    # Summary
    print(f"\n{'='*65}")
    print(f"🏁 TESTING COMPLETE - Gemini 2.0 Flash Framework Agent")
    print(f"{'='*65}")
    print(f"Total tests: {len(results)}")
    print(f"Successful executions: {successful_tests}")
    print(f"Success rate: {(successful_tests/len(results)*100):.1f}%" if results else "0%")
    print(f"Framework components loaded: {len(framework_info['loaded_files'])}")
    print(f"Results saved in: {RESULTS_DIR}")


if __name__ == "__main__":
    main() 