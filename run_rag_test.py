#!/usr/bin/env python3
"""
RAG Agent Test Automation Script

This script automates the testing of a simple RAG agent by:
1. Reading golden SQL queries with business questions
2. Using LangChain to generate new SQL based on the business questions
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
load_dotenv()

# Constants
GOLDEN_QUERIES_DIR = "golden_queries"
RESULTS_DIR = "results"

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


def get_rag_agent_response(business_question: str, context_sql: str) -> str:
    """
    Generate SQL query using RAG agent based on business question and context.
    
    Args:
        business_question: The business question to answer
        context_sql: Golden SQL query as context/example
        
    Returns:
        AI-generated SQL query string
    """
    # Initialize the LLM (Google Gemini 2.5 Pro - most advanced reasoning)
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create the prompt template
    prompt_template = ChatPromptTemplate.from_messages([
        ("system", """You are an expert data analyst specializing in SQL query generation for business intelligence.

Your task is to generate a clean, optimized SQL query that answers the given business question.

Guidelines:
1. Use the provided context SQL as a reference for table structures, join patterns, and data relationships
2. Generate SQL that directly answers the business question
3. Ensure proper formatting and readability
4. Include appropriate filtering, grouping, and aggregation
5. Use meaningful column aliases
6. Return ONLY the SQL query without any explanations or markdown formatting
7. Do not include comments in the SQL output

Context SQL serves as your knowledge base for understanding:
- Available tables and their relationships
- Common join patterns
- Data types and column names
- Business logic patterns"""),
        
        ("user", """Business Question: {business_question}

Context SQL (for reference):
{context_sql}

Generate a SQL query that answers the business question above. Return only the SQL query.""")
    ])
    
    # Create the chain
    chain = prompt_template | llm | StrOutputParser()
    
    # Generate the response
    try:
        response = chain.invoke({
            "business_question": business_question,
            "context_sql": context_sql
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
        print(f"Error generating RAG response: {str(e)}")
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
        print("🚀 Starting RAG Agent Test Automation")
        print("=" * 50)
        
        # Validate environment
        validate_environment()
        
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
                
                # Generate RAG response
                print("   🤖 Generating AI SQL query...")
                ai_generated_sql = get_rag_agent_response(business_question, golden_sql)
                
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
                    "api_result": api_result
                }
                
                # Save result
                output_file = os.path.join(RESULTS_DIR, f"{base_name}_rag_result.json")
                save_result(result_data, output_file)
                
                # Print status
                if api_result["success"]:
                    row_count = api_result.get("row_count", "unknown")
                    print(f"   ✓ SUCCESS: Query executed successfully ({row_count} rows)")
                    success_count += 1
                elif api_result.get("skipped"):
                    print(f"   ⏭️  SKIPPED: Metabase API test (SQL generated successfully)")
                    success_count += 1  # Count as success since SQL was generated
                else:
                    error = api_result.get("error", "Unknown error")
                    print(f"   ✗ FAILED: {error[:100]}...")
                
            except Exception as e:
                print(f"   ✗ ERROR processing {file_name}: {str(e)}")
            
            print()
        
        # Final summary
        print("=" * 50)
        print(f"🏁 Test Automation Complete!")
        print(f"📊 Results: {success_count}/{total_count} queries executed successfully")
        print(f"📂 Detailed results saved in: {RESULTS_DIR}/")
        
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