#!/usr/bin/env python3
"""
RAG Agent Test Automation Script - Gemini 2.0 Flash Version

This script automates the testing of a simple RAG agent by:
1. Reading golden SQL queries with business questions
2. Using LangChain with Gemini 2.0 Flash to generate new SQL based on the business questions
3. Testing the generated SQL against Metabase API
4. Saving results for analysis

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
RESULTS_DIR = "results_rag"

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


def load_data_catalog() -> str:
    """Load the data catalog for context."""
    catalog_path = "../data_catalog_fixed.json"
    try:
        with open(catalog_path, 'r', encoding='utf-8') as f:
            catalog_data = json.load(f)
        
        # Convert to readable format for the LLM
        catalog_text = "DATABASE SCHEMA AND TABLES:\n\n"
        
        for table_name, table_info in catalog_data.items():
            catalog_text += f"TABLE: {table_name}\n"
            catalog_text += f"Description: {table_info.get('description', 'No description available')}\n"
            
            columns = table_info.get('columns', {})
            if columns:
                catalog_text += "Columns:\n"
                for col_name, col_info in columns.items():
                    col_type = col_info.get('type', 'unknown')
                    col_desc = col_info.get('description', 'No description')
                    catalog_text += f"  - {col_name} ({col_type}): {col_desc}\n"
            
            catalog_text += "\n"
        
        return catalog_text
        
    except FileNotFoundError:
        print(f"Warning: Data catalog not found at {catalog_path}")
        return "No data catalog available"
    except Exception as e:
        print(f"Error loading data catalog: {e}")
        return "Error loading data catalog"


def generate_sql_with_gemini(business_question: str, data_catalog: str) -> str:
    """Generate SQL using Gemini 2.0 Flash based on business question and data catalog."""
    
    # Initialize the LLM with Gemini 2.0 Flash
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.0-flash-exp",
        google_api_key=GOOGLE_API_KEY,
        temperature=0.1
    )
    
    # Create the prompt template
    prompt = ChatPromptTemplate.from_messages([
        ("system", """You are an expert SQL analyst for a point-of-sale and e-commerce platform. Your task is to write SQL queries based on business questions using the provided database schema.

IMPORTANT GUIDELINES:
1. Use ONLY the tables and columns provided in the database schema
2. Follow proper SQL syntax for Amazon Redshift
3. Include appropriate JOINs, WHERE clauses, and aggregations
4. Handle date/time operations correctly with timezone considerations
5. Use proper filtering for business data (exclude internal/test accounts)
6. Return ONLY the SQL query without explanations or markdown formatting

Database Schema:
{data_catalog}"""),
        ("human", "Business Question: {business_question}\n\nGenerate the SQL query:")
    ])
    
    # Create the chain
    chain = prompt | llm | StrOutputParser()
    
    try:
        sql_query = chain.invoke({
            "business_question": business_question,
            "data_catalog": data_catalog
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
        print(f"Error generating SQL: {e}")
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
    
    file_name = result["file_name"].replace(".sql", "_rag_result.json")
    output_path = os.path.join(output_dir, file_name)
    
    # Add timestamp
    from datetime import datetime
    result["timestamp"] = datetime.now().isoformat()
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2, default=str)
    
    print(f"Result saved to: {output_path}")


def run_single_test(sql_file_path: str, data_catalog: str, output_dir: str) -> Dict[str, Any]:
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
    
    # Generate SQL with Gemini 2.0 Flash
    print("\nGenerating SQL with Gemini 2.0 Flash...")
    ai_generated_sql = generate_sql_with_gemini(business_question, data_catalog)
    
    print(f"Generated SQL:\n{ai_generated_sql[:200]}...")
    
    # Test with Metabase
    print("\nTesting SQL with Metabase...")
    api_result = test_sql_with_metabase(ai_generated_sql)
    
    if api_result["success"]:
        print(f"✅ SQL executed successfully! Row count: {api_result['row_count']}")
    else:
        print(f"❌ SQL execution failed: {api_result.get('error', 'Unknown error')}")
    
    # Compile result
    result = {
        **golden_data,
        "ai_generated_sql": ai_generated_sql,
        "api_result": api_result
    }
    
    # Save result
    save_result(result, output_dir)
    
    return result


def main():
    """Main execution function."""
    print("🚀 Starting RAG Agent Testing with Gemini 2.0 Flash")
    print("="*60)
    
    # Validate environment
    try:
        validate_environment()
    except ValueError as e:
        print(f"❌ Environment validation failed: {e}")
        return
    
    # Load data catalog
    print("📚 Loading data catalog...")
    data_catalog = load_data_catalog()
    
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
        result = run_single_test(sql_file, data_catalog, RESULTS_DIR)
        if result:
            results.append(result)
            if result.get("api_result", {}).get("success", False):
                successful_tests += 1
    
    # Summary
    print(f"\n{'='*60}")
    print(f"🏁 TESTING COMPLETE - Gemini 2.0 Flash")
    print(f"{'='*60}")
    print(f"Total tests: {len(results)}")
    print(f"Successful executions: {successful_tests}")
    print(f"Success rate: {(successful_tests/len(results)*100):.1f}%" if results else "0%")
    print(f"Results saved in: {RESULTS_DIR}")


if __name__ == "__main__":
    main() 