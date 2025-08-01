#!/usr/bin/env python3
"""
Final Validation "Perfect Schema Test" Script

This script implements the final validation test with two architectures:
1. Single-Agent: Combines all 6 JSON files into one large context
2. Multi-Agent: Implements a 4-agent system (Intent, Schema, Logic, Orchestrator)

Both architectures MUST use the hardcoded "Perfect Schema" rule:
"IMPORTANT RULE: You MUST use the schema 'storehub_mongo' for all tables. 
For example, when you refer to the transactions table, you must write 
'storehub_mongo.transactionrecords'. This is a mandatory instruction."

The script saves results to results_perfect_schema/ with clear naming indicating
which agent architecture was used.

Author: AI Assistant
"""

import os
import json
import glob
from typing import Dict, Any, Optional, Tuple
from pathlib import Path
from datetime import datetime

import requests
from dotenv import load_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser


# Load environment variables
load_dotenv()

# ARCHITECTURE SELECTION FLAG
USE_MULTI_AGENT_MODEL = False  # Set to True for multi-agent, False for single-agent

# THE PERFECT SCHEMA HARDCODED INSTRUCTION
PERFECT_SCHEMA_RULE = """IMPORTANT RULE: You MUST use the schema 'storehub_mongo' for all tables. For example, when you refer to the transactions table, you must write 'storehub_mongo.transactionrecords'. This is a mandatory instruction."""

# Constants
GOLDEN_QUERIES_DIR = "golden_queries"
RESULTS_DIR = "results_perfect_schema"  # New unique directory
FRAMEWORK_DIR = "source/sh-reports/semantic_layer_v2/core"

# Environment variables  
METABASE_HOST = os.getenv("METABASE_HOST")
METABASE_API_KEY = os.getenv("METABASE_API_KEY").strip() if os.getenv("METABASE_API_KEY") else None
METABASE_DATABASE_ID = int(os.getenv("METABASE_DATABASE_ID", "2"))
GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY").strip() if os.getenv("GOOGLE_API_KEY") else None


def validate_environment() -> None:
    """Validate that all required environment variables and files are present."""
    print("🔍 Validating environment setup...")
    
    required_vars = ["GOOGLE_API_KEY"]
    missing_vars = [var for var in required_vars if not os.getenv(var)]
    
    if missing_vars:
        print(f"✗ Missing required environment variables: {', '.join(missing_vars)}")
        raise EnvironmentError(f"Please set the following environment variables: {', '.join(missing_vars)}")
    
    # Check framework files exist
    framework_files = [
        'semantic_context.json', 'data_catalog.json', 'business_rules.json',
        'query_patterns.json', 'value_mappings.json', 'query_cookbook.json'
    ]
    
    for filename in framework_files:
        file_path = os.path.join(FRAMEWORK_DIR, filename)
        if not os.path.exists(file_path):
            print(f"✗ Missing framework file: {file_path}")
            raise FileNotFoundError(f"Required framework file not found: {file_path}")
    
    print("✓ Environment validation complete")


def load_json_file(file_path: str, description: str) -> Dict[str, Any]:
    """Load and parse a JSON file with error handling."""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"✗ Missing file: {file_path}")
        raise FileNotFoundError(f"Required file not found: {file_path}")
    except json.JSONDecodeError as e:
        print(f"✗ Invalid JSON in {description}: {str(e)}")
        raise json.JSONDecodeError(f"Malformed JSON in {description}: {str(e)}", "", 0)


def execute_metabase_query(sql_query: str) -> Dict[str, Any]:
    """
    Execute a native SQL query against Metabase API.
    
    Args:
        sql_query: The SQL query string to execute
        
    Returns:
        Dictionary containing the API response
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


def parse_golden_query_file(file_path: str) -> Tuple[str, str]:
    """
    Parse a golden query SQL file to extract the business question and SQL query.
    
    Args:
        file_path: Path to the SQL file
        
    Returns:
        Tuple of (business_question, sql_query)
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read().strip()
        
        # Extract business question from comment at the top
        lines = content.split('\n')
        business_question = ""
        
        for line in lines:
            line = line.strip()
            if line.startswith('--') and not line.startswith('---'):
                # Remove comment markers and clean up
                question_part = line[2:].strip()
                if question_part and not question_part.startswith('='):
                    business_question += question_part + " "
            elif line and not line.startswith('--'):
                break
        
        business_question = business_question.strip()
        
        if not business_question:
            business_question = f"Business question from {os.path.basename(file_path)}"
        
        return business_question, content
        
    except Exception as e:
        print(f"✗ Error parsing {file_path}: {str(e)}")
        return f"Error parsing {os.path.basename(file_path)}", ""


def get_single_agent_response(business_question: str) -> str:
    """
    Single-Agent Architecture: Load all 6 JSON files, combine into one large context,
    and use that full context (plus the hardcoded schema rule) to generate SQL.
    
    Args:
        business_question: The natural language business question
        
    Returns:
        Generated SQL query string
    """
    print("   🤖 Single Agent: Loading all framework files...")
    
    # Load all 6 JSON framework files
    framework_files = {
        'semantic_context': 'semantic_context.json',
        'data_catalog': 'data_catalog.json', 
        'business_rules': 'business_rules.json',
        'query_patterns': 'query_patterns.json',
        'value_mappings': 'value_mappings.json',
        'query_cookbook': 'query_cookbook.json'
    }
    
    framework_data = {}
    
    for key, filename in framework_files.items():
        file_path = os.path.join(FRAMEWORK_DIR, filename)
        framework_data[key] = load_json_file(file_path, filename)
        print(f"   ✓ Loaded {filename}")
    
    # Construct comprehensive context from all files
    print("   🧠 Building comprehensive single-agent context...")
    
    context_parts = []
    
    # Add semantic context
    if 'semantic_context' in framework_data:
        context_parts.append("=== SEMANTIC CONTEXT ===")
        context_parts.append(json.dumps(framework_data['semantic_context'], indent=2))
    
    # Add data catalog  
    if 'data_catalog' in framework_data:
        context_parts.append("\n=== DATA CATALOG ===")
        context_parts.append(json.dumps(framework_data['data_catalog'], indent=2))
    
    # Add business rules
    if 'business_rules' in framework_data:
        context_parts.append("\n=== BUSINESS RULES ===")
        context_parts.append(json.dumps(framework_data['business_rules'], indent=2))
    
    # Add query patterns
    if 'query_patterns' in framework_data:
        context_parts.append("\n=== QUERY PATTERNS ===")
        context_parts.append(json.dumps(framework_data['query_patterns'], indent=2))
    
    # Add value mappings
    if 'value_mappings' in framework_data:
        context_parts.append("\n=== VALUE MAPPINGS ===")
        context_parts.append(json.dumps(framework_data['value_mappings'], indent=2))
    
    # Add query cookbook
    if 'query_cookbook' in framework_data:
        context_parts.append("\n=== QUERY COOKBOOK ===")
        context_parts.append(json.dumps(framework_data['query_cookbook'], indent=2))
    
    full_context = '\n'.join(context_parts)
    
    print(f"   ✓ Single-agent context prepared ({len(full_context)} characters)")
    
    # Initialize LLM
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create comprehensive single-agent prompt with PERFECT SCHEMA RULE
    single_agent_prompt = ChatPromptTemplate.from_messages([
        ("system", f"""{PERFECT_SCHEMA_RULE}

You are an expert business intelligence analyst and SQL developer specializing in StoreHub's merchant data platform.

Your task is to generate a precise SQL query based on the business question using the comprehensive semantic framework provided.

The framework includes:
- Semantic Context: Natural language interpretation rules
- Data Catalog: Business entities and table mappings  
- Business Rules: Mandatory filters and validation logic
- Query Patterns: Common SQL patterns and templates
- Value Mappings: Status codes and enum translations
- Query Cookbook: Curated examples

Generate a syntactically correct SQL query that:
1. Uses ONLY tables and columns that exist in the data catalog
2. Includes ALL mandatory business rules and filters
3. Applies appropriate value mappings for status codes
4. Follows proven query patterns from the cookbook
5. Handles time zones correctly (UTC+8 for StoreHub)
6. Uses proper joins and relationships as defined
7. CRITICALLY: Uses the 'storehub_mongo' schema prefix for ALL tables

Return ONLY the raw SQL query without any markdown formatting, backticks, or explanations."""),
        
        ("user", """Business Question: {business_question}

Comprehensive Semantic Framework:
{framework_context}

Generate the SQL query following all framework guidelines and the mandatory schema rule.""")
    ])
    
    # Generate SQL
    chain = single_agent_prompt | llm | StrOutputParser()
    
    try:
        sql_result = chain.invoke({
            "business_question": business_question,
            "framework_context": full_context
        })
        
        print("   ✓ Single Agent: SQL query generated successfully")
        # Clean up any markdown formatting from the SQL
        cleaned_sql = sql_result.strip()
        if cleaned_sql.startswith('```sql'):
            cleaned_sql = cleaned_sql[6:]  # Remove ```sql
        if cleaned_sql.startswith('```'):
            cleaned_sql = cleaned_sql[3:]   # Remove ```
        if cleaned_sql.endswith('```'):
            cleaned_sql = cleaned_sql[:-3]  # Remove trailing ```
        return cleaned_sql.strip()
        
    except Exception as e:
        print(f"   ✗ Error in Single Agent: {str(e)}")
        return f"-- Error generating SQL: {str(e)}"


# Multi-Agent Architecture Functions

def get_intent_context(business_question: str) -> str:
    """
    Intent Agent: Parse the business question to extract key intents and entities.
    """
    print("   🎯 Intent Agent: Parsing business question...")
    
    # Load semantic context for intent parsing
    semantic_context_path = os.path.join(FRAMEWORK_DIR, "semantic_context.json")
    semantic_context = load_json_file(semantic_context_path, "semantic_context.json")
    
    # Initialize LLM for intent parsing
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create intent parsing prompt
    intent_prompt = ChatPromptTemplate.from_messages([
        ("system", """You are an expert business intelligence analyst specializing in interpreting natural language business questions.

Your SOLE responsibility is to analyze the business question and extract:

1. **Primary Business Intent**: What is the user trying to accomplish?
2. **Key Business Entities**: What business objects are involved (customers, transactions, products, stores, etc.)?
3. **Required Metrics**: What measurements or KPIs are needed (sales, counts, averages, etc.)?
4. **Time Context**: What time period or temporal analysis is requested?
5. **Analytical Type**: Is this a simple report, comparison, breakdown, trend analysis, etc.?
6. **Specific Filters**: Any explicit business names, product categories, or other filters mentioned?

Use the semantic context provided to interpret ambiguous terms correctly.

Return a structured summary in this exact format:
INTENT: [primary business intent]
ENTITIES: [comma-separated list of business entities]
METRICS: [comma-separated list of required metrics]  
TIME_CONTEXT: [time period or temporal requirements]
ANALYSIS_TYPE: [type of analysis needed]
FILTERS: [any specific filters or constraints]

Be precise and comprehensive. Your output will guide other specialist agents."""),
        
        ("user", """Business Question: {business_question}

Semantic Context for Interpretation:
{semantic_context}

Analyze this business question and extract the structured intent summary.""")
    ])
    
    # Generate intent analysis
    chain = intent_prompt | llm | StrOutputParser()
    
    try:
        # Prepare semantic context (simplified for intent parsing)
        context_summary = f"""
Default Metric Interpretations:
- sales/revenue -> net_sales (after deductions)
- customers -> unique_customer_count
- average -> context-dependent (transaction value, customer LTV, etc.)

Time Range Defaults:
- When not specified -> last 30 days
- "yesterday" -> previous complete day
- "last month" -> previous complete calendar month
- "this month" -> month to date

Common Business Entities:
- transactions, customers, products, stores, vouchers, promotions
- membership/loyalty programs, payments, logistics
"""
        
        intent_result = chain.invoke({
            "business_question": business_question,
            "semantic_context": context_summary
        })
        
        print(f"   ✓ Intent extracted: {intent_result.split('INTENT:')[1].split('ENTITIES:')[0].strip()[:50]}...")
        return intent_result.strip()
        
    except Exception as e:
        print(f"   ✗ Error in Intent Agent: {str(e)}")
        return f"INTENT: Error parsing intent\nENTITIES: unknown\nMETRICS: unknown\nTIME_CONTEXT: unknown\nANALYSIS_TYPE: unknown\nFILTERS: unknown"


def get_schema_context(intent: str) -> str:
    """
    Schema Agent: Provide precise table names, columns, and join relationships.
    """
    print("   🗄️  Schema Agent: Loading data catalog and value mappings...")
    
    # Load data catalog and value mappings
    catalog_path = os.path.join(FRAMEWORK_DIR, "data_catalog.json")
    data_catalog = load_json_file(catalog_path, "data_catalog.json")
    
    value_mappings_path = os.path.join(FRAMEWORK_DIR, "value_mappings.json")
    value_mappings = load_json_file(value_mappings_path, "value_mappings.json")
    
    # Initialize LLM for schema analysis
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create schema extraction prompt
    schema_prompt = ChatPromptTemplate.from_messages([
        ("system", """You are a database schema expert specializing in translating business intents into precise database schema requirements.

Your SOLE responsibility is to analyze the intent and return:

1. **Primary Tables**: Exact table names needed for this query
2. **Key Columns**: Essential columns with their fully-qualified names
3. **Join Relationships**: How tables should be connected
4. **Mandatory Filters**: Required WHERE clauses for data safety/business logic
5. **Value Mappings**: Any status codes or enum values that need translation

Use the data catalog and value mappings to provide EXACT table and column names.
Focus on the entities and metrics identified in the intent.

Return structured schema information that can be directly used in SQL generation."""),
        
        ("user", """Intent Analysis:
{intent}

Data Catalog:
{data_catalog}

Value Mappings:
{value_mappings}

Based on the intent, provide the precise schema information needed for SQL generation.""")
    ])
    
    # Generate schema analysis  
    chain = schema_prompt | llm | StrOutputParser()
    
    try:
        # Prepare condensed catalog info (first 15 business entities)
        catalog_summary = ""
        if 'business_entities' in data_catalog:
            catalog_summary += "Key Business Entities:\n"
            entities = data_catalog['business_entities']
            for i, (entity_name, entity_data) in enumerate(entities.items()):
                if i >= 15:  # Limit to prevent context overflow
                    catalog_summary += "... (and more entities)\n"
                    break
                if isinstance(entity_data, dict):
                    primary_table = entity_data.get('primary_table', 'N/A')
                    description = entity_data.get('description', 'N/A')
                    catalog_summary += f"- {entity_name}: {primary_table} ({description})\n"
        
        # Prepare condensed value mappings
        mappings_summary = ""
        if 'status_mappings' in value_mappings:
            mappings_summary += "Status Value Mappings:\n"
            status_maps = value_mappings['status_mappings']
            for mapping_name, mapping_data in list(status_maps.items())[:10]:  # First 10
                if isinstance(mapping_data, dict) and 'values' in mapping_data:
                    values = mapping_data['values']
                    value_list = list(values.keys())[:5]  # First 5 values
                    mappings_summary += f"- {mapping_name}: {', '.join(value_list)}...\n"
        
        schema_result = chain.invoke({
            "intent": intent,
            "data_catalog": catalog_summary,
            "value_mappings": mappings_summary
        })
        
        print(f"   ✓ Schema context extracted ({len(schema_result)} characters)")
        return schema_result.strip()
        
    except Exception as e:
        print(f"   ✗ Error in Schema Agent: {str(e)}")
        return f"Error extracting schema context: {str(e)}"


def get_logic_context(intent: str) -> str:
    """
    Logic Agent: Return relevant business rules, calculations, and SQL patterns.
    """
    print("   📋 Logic Agent: Loading business rules, patterns, and cookbook...")
    
    # Load business rules, query patterns, and cookbook
    business_rules_path = os.path.join(FRAMEWORK_DIR, "business_rules.json")
    business_rules = load_json_file(business_rules_path, "business_rules.json")
    
    query_patterns_path = os.path.join(FRAMEWORK_DIR, "query_patterns.json")
    query_patterns = load_json_file(query_patterns_path, "query_patterns.json")
    
    query_cookbook_path = os.path.join(FRAMEWORK_DIR, "query_cookbook.json")
    query_cookbook = load_json_file(query_cookbook_path, "query_cookbook.json")
    
    # Initialize LLM for logic analysis
    llm = ChatGoogleGenerativeAI(
        model="gemini-2.5-pro",
        temperature=0.1,
        google_api_key=GOOGLE_API_KEY
    )
    
    # Create logic extraction prompt
    logic_prompt = ChatPromptTemplate.from_messages([
        ("system", """You are a business logic expert specializing in translating business intents into SQL logic requirements.

Your SOLE responsibility is to analyze the intent and return:

1. **Mandatory Business Rules**: Required filters and constraints that must be applied
2. **Calculation Logic**: How to compute metrics, aggregations, and derived fields
3. **SQL Patterns**: Relevant query structures and templates that fit this analysis
4. **Performance Considerations**: Optimization hints and indexing recommendations
5. **Example Patterns**: Similar queries from the cookbook that can be adapted

Use the business rules, query patterns, and cookbook to provide guidance for SQL generation.
Focus on the analytical type and metrics identified in the intent.

Return structured logic information that ensures business-compliant and performant SQL."""),
        
        ("user", """Intent Analysis:
{intent}

Business Rules:
{business_rules}

Query Patterns:
{query_patterns}

Query Cookbook:
{query_cookbook}

Based on the intent, provide the business logic and SQL patterns needed for query generation.""")
    ])
    
    # Generate logic analysis
    chain = logic_prompt | llm | StrOutputParser()
    
    try:
        # Prepare condensed business rules
        rules_summary = ""
        if 'mandatory_filters' in business_rules:
            rules_summary += "Mandatory Filters:\n"
            mandatory_filters = business_rules['mandatory_filters']
            if isinstance(mandatory_filters, dict):
                for filter_name, filter_data in mandatory_filters.items():
                    if isinstance(filter_data, dict):
                        description = filter_data.get('description', 'N/A')
                        rules_summary += f"- {filter_name}: {description}\n"
            else:
                rules_summary += "- mandatory_filters structure unexpected\n"
        
        # Prepare condensed patterns 
        patterns_summary = ""
        if 'core_patterns' in query_patterns:
            patterns_summary += "Core Query Patterns:\n"
            core_patterns = query_patterns['core_patterns']
            if isinstance(core_patterns, dict):
                for pattern_name, pattern_data in list(core_patterns.items())[:10]:
                    if isinstance(pattern_data, dict):
                        description = pattern_data.get('description', 'N/A')
                        patterns_summary += f"- {pattern_name}: {description}\n"
            else:
                patterns_summary += "- core_patterns structure unexpected\n"
        
        # Prepare condensed cookbook
        cookbook_summary = ""
        if 'examples' in query_cookbook:
            cookbook_summary += "Query Examples:\n"
            examples = query_cookbook['examples']
            if isinstance(examples, dict):
                for example_name, example_data in list(examples.items())[:5]:
                    if isinstance(example_data, dict):
                        description = example_data.get('description', 'N/A')
                        cookbook_summary += f"- {example_name}: {description}\n"
            else:
                cookbook_summary += "- examples structure unexpected\n"
        
        logic_result = chain.invoke({
            "intent": intent,
            "business_rules": rules_summary,
            "query_patterns": patterns_summary,
            "query_cookbook": cookbook_summary
        })
        
        print(f"   ✓ Logic context extracted ({len(logic_result)} characters)")
        return logic_result.strip()
        
    except Exception as e:
        print(f"   ✗ Error in Logic Agent: {str(e)}")
        return f"Error extracting logic context: {str(e)}"


def get_multi_agent_response(business_question: str) -> str:
    """
    Orchestrator Agent: Coordinate all specialist agents and generate final SQL.
    
    This orchestrator follows a strict sequence:
    1. Call Intent Agent to parse the business question
    2. Use intent output to call Schema Agent and Logic Agent in parallel
    3. Assemble detailed prompt for Gemini 2.5 Pro with all specialist context
    4. Generate final SQL query with PERFECT SCHEMA RULE
    
    Args:
        business_question: The natural language business question
        
    Returns:
        Generated SQL query string
    """
    print("   🎼 Orchestrator: Coordinating multi-agent query generation...")
    
    try:
        # Step 1: Get intent context from Intent Agent
        intent_context = get_intent_context(business_question)
        
        # Step 2: Get specialized context from Schema and Logic Agents (parallel)
        print("   🔄 Orchestrator: Calling Schema and Logic Agents...")
        schema_context = get_schema_context(intent_context)
        logic_context = get_logic_context(intent_context)
        
        # Step 3: Initialize main LLM for final SQL generation
        print("   🧠 Orchestrator: Assembling final prompt for Gemini 2.5 Pro...")
        llm = ChatGoogleGenerativeAI(
            model="gemini-2.5-pro",
            temperature=0.1,
            google_api_key=GOOGLE_API_KEY
        )
        
        # Step 4: Create comprehensive orchestrator prompt with PERFECT SCHEMA RULE
        orchestrator_prompt = ChatPromptTemplate.from_messages([
            ("system", f"""{PERFECT_SCHEMA_RULE}

You are the SQL Orchestrator Agent, responsible for generating the final SQL query using insights from specialist agents.

You have received specialized analysis from:
- Intent Agent: Parsed business requirements and entities
- Schema Agent: Precise table/column mappings and joins
- Logic Agent: Business rules, patterns, and optimization guidance

Your task is to synthesize all specialist input and generate a perfect SQL query that:
1. Satisfies the business intent completely
2. Uses correct schema information (tables, columns, joins)
3. Implements all mandatory business rules and filters
4. Follows proven SQL patterns for performance
5. CRITICALLY: Uses the 'storehub_mongo' schema prefix for ALL tables
6. Handles edge cases and data quality issues
7. Is syntactically correct and ready to execute

Generate ONLY the raw SQL query without any markdown formatting, backticks, explanations, or comments."""),
            
            ("user", """Business Question: {business_question}

SPECIALIST AGENT ANALYSIS:

=== INTENT AGENT OUTPUT ===
{intent_context}

=== SCHEMA AGENT OUTPUT ===
{schema_context}

=== LOGIC AGENT OUTPUT ===
{logic_context}

Synthesize all specialist input and generate the final SQL query following the mandatory schema rule.""")
        ])
        
        # Generate final SQL
        chain = orchestrator_prompt | llm | StrOutputParser()
        
        sql_result = chain.invoke({
            "business_question": business_question,
            "intent_context": intent_context,
            "schema_context": schema_context,
            "logic_context": logic_context
        })
        
        print("   ✓ Orchestrator: Final SQL query generated successfully")
        # Clean up any markdown formatting from the SQL
        cleaned_sql = sql_result.strip()
        if cleaned_sql.startswith('```sql'):
            cleaned_sql = cleaned_sql[6:]  # Remove ```sql
        if cleaned_sql.startswith('```'):
            cleaned_sql = cleaned_sql[3:]   # Remove ```
        if cleaned_sql.endswith('```'):
            cleaned_sql = cleaned_sql[:-3]  # Remove trailing ```
        return cleaned_sql.strip()
        
    except Exception as e:
        print(f"   ✗ Error in multi-agent coordination: {str(e)}")
        return f"-- Error in multi-agent coordination: {str(e)}"


def save_result(result_data: Dict[str, Any], output_file: str) -> None:
    """Save the test result to a JSON file with error handling."""
    try:
        with open(output_file, 'w', encoding='utf-8') as file:
            json.dump(result_data, file, indent=2, ensure_ascii=False)
        
        success_indicator = "✓" if result_data.get("api_result", {}).get("success", False) else "✗"
        row_count = result_data.get("api_result", {}).get("row_count", 0)
        print(f"   {success_indicator} Result saved to {output_file} ({row_count} rows)")

    except Exception as e:
        print(f"   ✗ Error saving result to {output_file}: {str(e)}")


def main() -> None:
    """Main execution function."""
    try:
        architecture_name = "Multi-Agent" if USE_MULTI_AGENT_MODEL else "Single-Agent"
        print(f"🚀 Starting Final Validation - {architecture_name} Perfect Schema Test")
        print("=" * 70)
        
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
        print(f"🏗️  Architecture: {architecture_name}")
        print(f"🔒 Perfect Schema Rule: ACTIVE (storehub_mongo prefix mandatory)")
        print()
        
        # Process each file
        success_count = 0
        total_count = len(sql_files)
        
        for file_path in sql_files:
            query_file = os.path.basename(file_path)
            print(f"🔄 Processing: {query_file}")
            
            try:
                # Parse the golden query file
                business_question, golden_sql = parse_golden_query_file(file_path)
                print(f"   📝 Business Question: {business_question[:100]}...")
                
                # Generate AI SQL query using selected architecture
                print(f"   🤖 Generating AI SQL query using {architecture_name}...")
                
                if USE_MULTI_AGENT_MODEL:
                    ai_generated_sql = get_multi_agent_response(business_question)
                    agent_suffix = "multi_agent"
                else:
                    ai_generated_sql = get_single_agent_response(business_question)
                    agent_suffix = "single_agent"
                
                # Execute the query via Metabase API (if configured)
                if METABASE_HOST and METABASE_API_KEY:
                    print("   🌐 Testing query against Metabase API...")
                    api_result = execute_metabase_query(ai_generated_sql)
                    
                    if api_result.get("success", False):
                        success_count += 1
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
                    "file_name": query_file,
                    "timestamp": datetime.now().isoformat(),
                    "test_type": "perfect_schema_validation",
                    "architecture": {
                        "type": architecture_name.lower().replace("-", "_"),
                        "model": "gemini-2.5-pro",
                        "temperature": 0.1,
                        "perfect_schema_rule_applied": True
                    },
                    "business_question": business_question,
                    "golden_sql": golden_sql,
                    "ai_generated_sql": ai_generated_sql,
                    "api_result": api_result
                }
                
                # Save result with clear agent architecture naming
                file_base = os.path.splitext(query_file)[0]
                output_file = os.path.join(RESULTS_DIR, f"{file_base}_{agent_suffix}_result.json")
                save_result(result_data, output_file)
                
            except Exception as e:
                print(f"   ✗ Error processing {query_file}: {str(e)}")
                continue
            
            print()  # Add spacing between files
        
        # Final summary
        print("=" * 70)
        print(f"🏁 Final Validation Complete!")
        print(f"📊 Results: {success_count}/{total_count} queries executed successfully")
        print(f"📂 Detailed results saved in: {RESULTS_DIR}/")
        print(f"🏗️  Architecture used: {architecture_name}")
        print(f"🔒 Perfect Schema Rule: Applied to all queries")
        
        if success_count == total_count:
            print("🎉 All tests passed!")
        else:
            print(f"⚠️  {total_count - success_count} tests failed - check individual result files")
            
    except Exception as e:
        print(f"✗ Fatal error in main execution: {str(e)}")
        raise


if __name__ == "__main__":
    main() 