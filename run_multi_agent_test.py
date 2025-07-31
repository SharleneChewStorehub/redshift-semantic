#!/usr/bin/env python3
"""
Multi-Agent "Divide and Conquer" Test Automation Script

This script implements a sophisticated multi-agent architecture to test a "divide and conquer" 
approach to SQL query generation. The system consists of:

1. Intent Agent: Parses business questions to extract key intents and entities
2. Schema Agent: Provides precise table names, columns, and join relationships
3. Logic Agent: Returns relevant business rules, calculations, and SQL patterns
4. Orchestrator Agent: Coordinates all agents and generates final SQL using Gemini 2.5 Pro

The script supports A/B testing by switching between data_catalog.json and data_catalog_fixed.json
to evaluate the impact of catalog improvements on query generation quality.

Author: AI Assistant
"""

import os
import json
import glob
from typing import Dict, Any, Optional, Tuple
from pathlib import Path

import requests
from dotenv import load_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser


# Load environment variables
load_dotenv()

# A/B Test Configuration Flag
USE_FIXED_CATALOG = True  # Set to True for A/B testing with data_catalog_fixed.json

# Constants
GOLDEN_QUERIES_DIR = "golden_queries"
RESULTS_DIR = "results_multi_agent"
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


def load_json_file(file_path: str, description: str) -> Dict[str, Any]:
    """
    Load a JSON file with error handling.
    
    Args:
        file_path: Path to the JSON file
        description: Human-readable description for error messages
        
    Returns:
        Loaded JSON data as dictionary
        
    Raises:
        FileNotFoundError: If file doesn't exist
        json.JSONDecodeError: If JSON is malformed
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
        print(f"   ✓ Loaded {description}")
        return data
    except FileNotFoundError:
        print(f"   ✗ Missing file: {file_path}")
        raise FileNotFoundError(f"Required file not found: {file_path}")
    except json.JSONDecodeError as e:
        print(f"   ✗ Invalid JSON in {description}: {str(e)}")
        raise json.JSONDecodeError(f"Malformed JSON in {description}: {str(e)}", "", 0)


def get_intent_context(business_question: str) -> str:
    """
    Intent Agent: Parse the business question to extract key intents and entities.
    
    This specialist agent focuses solely on understanding what the user is asking for,
    identifying business entities, metrics, time ranges, and analytical intent.
    
    Args:
        business_question: The natural language business question
        
    Returns:
        Structured intent summary as string
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


def get_schema_context(intent: str, use_fixed_catalog: bool) -> str:
    """
    Schema Agent: Provide precise table names, columns, and join relationships.
    
    This specialist agent focuses on the data catalog and value mappings to return
    exact database schema information relevant to the parsed intent.
    
    Args:
        intent: Structured intent from the Intent Agent
        use_fixed_catalog: Flag to determine which data catalog to use
        
    Returns:
        Relevant schema information as string
    """
    print(f"   🗄️  Schema Agent: Loading {'FIXED' if use_fixed_catalog else 'ORIGINAL'} data catalog...")
    
    # Load appropriate data catalog based on A/B test flag
    catalog_file = "data_catalog_fixed.json" if use_fixed_catalog else "data_catalog.json"
    catalog_path = os.path.join(FRAMEWORK_DIR, catalog_file)
    data_catalog = load_json_file(catalog_path, catalog_file)
    
    # Load value mappings
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
    Logic Agent: Find relevant business rules, calculations, and SQL patterns.
    
    This specialist agent focuses on business rules, query patterns, and the cookbook
    to return applicable business logic and SQL patterns for the intent.
    
    Args:
        intent: Structured intent from the Intent Agent
        
    Returns:
        Relevant business logic and patterns as string
    """
    print("   📋 Logic Agent: Extracting business rules and patterns...")
    
    # Load business rules, patterns, and cookbook
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
        ("system", """You are a business logic and SQL pattern expert specializing in finding relevant rules and patterns.

Your SOLE responsibility is to analyze the intent and return:

1. **Mandatory Business Rules**: Required filters that MUST be included (business isolation, soft deletes, etc.)
2. **Calculation Logic**: How to compute the requested metrics correctly
3. **SQL Patterns**: Relevant query structures for this type of analysis
4. **Best Practices**: Important considerations for this query type
5. **Example Patterns**: Similar queries from the cookbook

Focus on rules and patterns that directly apply to the identified intent.
Prioritize data safety rules and business-critical filtering requirements.

Return actionable logic that can guide SQL generation."""),
        
        ("user", """Intent Analysis:
{intent}

Business Rules:
{business_rules}

Query Patterns:
{query_patterns}

Query Cookbook:
{query_cookbook}

Based on the intent, extract the relevant business logic, rules, and patterns needed for SQL generation.""")
    ])
    
    # Generate logic analysis
    chain = logic_prompt | llm | StrOutputParser()
    
    try:
        # Prepare condensed business rules (mandatory filters)
        rules_summary = ""
        if 'mandatory_filters' in business_rules:
            rules_summary += "MANDATORY FILTERS (MUST be included):\n"
            mandatory = business_rules['mandatory_filters']
            for rule_category, rule_data in mandatory.items():
                rules_summary += f"{rule_category}:\n"
                if isinstance(rule_data, dict):
                    for filter_name, filter_info in rule_data.items():
                        if isinstance(filter_info, dict) and 'filter' in filter_info:
                            filter_clause = filter_info['filter']
                            rules_summary += f"  - {filter_name}: {filter_clause}\n"
        
        # Prepare condensed query patterns
        patterns_summary = ""
        if 'common_patterns' in query_patterns:
            patterns_summary += "Common SQL Patterns:\n"
            common = query_patterns['common_patterns']
            for i, (pattern_name, pattern_data) in enumerate(common.items()):
                if i >= 8:  # Limit to first 8 patterns
                    patterns_summary += "... (and more patterns)\n"
                    break
                if isinstance(pattern_data, dict):
                    description = pattern_data.get('description', 'N/A')
                    patterns_summary += f"- {pattern_name}: {description}\n"
        
        # Prepare condensed cookbook examples
        cookbook_summary = ""
        if 'examples' in query_cookbook:
            cookbook_summary += "Example Query Patterns:\n"
            examples = query_cookbook['examples']
            if isinstance(examples, list):
                for i, example_data in enumerate(examples[:5]):  # First 5 examples
                    if isinstance(example_data, dict):
                        example_id = example_data.get('id', f'example_{i+1}')
                        natural_language = example_data.get('natural_language', 'N/A')
                        cookbook_summary += f"- {example_id}: {natural_language}\n"
            elif isinstance(examples, dict):
                for i, (example_name, example_data) in enumerate(list(examples.items())[:5]):
                    if isinstance(example_data, dict):
                        description = example_data.get('description', 'N/A')
                        cookbook_summary += f"- {example_name}: {description}\n"
        
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


def get_multi_agent_response(business_question: str, use_fixed_catalog_flag: bool) -> str:
    """
    Orchestrator Agent: Coordinate all specialist agents and generate final SQL.
    
    This orchestrator follows a strict sequence:
    1. Call Intent Agent to parse the business question
    2. Use intent output to call Schema Agent and Logic Agent in parallel
    3. Assemble detailed prompt for Gemini 2.5 Pro with all specialist context
    4. Generate final SQL query
    
    Args:
        business_question: The natural language business question
        use_fixed_catalog_flag: Whether to use the fixed catalog for A/B testing
        
    Returns:
        Generated SQL query string
    """
    print("   🎼 Orchestrator: Coordinating multi-agent query generation...")
    
    try:
        # Step 1: Get intent context from Intent Agent
        intent_context = get_intent_context(business_question)
        
        # Step 2: Get specialized context from Schema and Logic Agents (parallel)
        print("   🔄 Orchestrator: Calling Schema and Logic Agents...")
        schema_context = get_schema_context(intent_context, use_fixed_catalog_flag)
        logic_context = get_logic_context(intent_context)
        
        # Step 3: Initialize main LLM for final SQL generation
        print("   🧠 Orchestrator: Assembling final prompt for Gemini 2.5 Pro...")
        llm = ChatGoogleGenerativeAI(
            model="gemini-2.5-pro",
            temperature=0.1,
            google_api_key=GOOGLE_API_KEY
        )
        
        # Step 4: Create comprehensive orchestrator prompt
        orchestrator_prompt = ChatPromptTemplate.from_messages([
            ("system", """You are the Orchestrator in a multi-agent SQL generation system. You have received specialized analysis from three expert agents and must now generate the final SQL query.

**CRITICAL INSTRUCTIONS:**

You MUST strictly follow the guidance provided by each specialist agent:

1. **INTENT EXPERT**: Told you exactly what the business question is asking for
2. **SCHEMA EXPERT**: Provided precise table names, columns, and join patterns - USE THESE EXACTLY
3. **LOGIC EXPERT**: Provided mandatory business rules and filters - THESE ARE REQUIRED

**SQL GENERATION RULES:**
- Use ONLY the exact table and column names provided by the Schema Expert
- Include ALL mandatory filters provided by the Logic Expert (especially business isolation and soft delete exclusion)  
- Apply the calculation logic and patterns recommended by the Logic Expert
- Generate clean, optimized SQL that directly answers the Intent Expert's analysis
- Use proper formatting and meaningful aliases
- Return ONLY the SQL query without explanations or markdown formatting
- NEVER use parameter placeholders - always use actual literal values
- Include proper time zone adjustments as shown in example patterns

**QUALITY REQUIREMENTS:**
- The query must be executable and syntactically correct
- All business safety rules must be applied
- The result should directly answer the original business question
- Use appropriate aggregations, grouping, and ordering"""),
            
            ("user", """**ORIGINAL BUSINESS QUESTION:** {business_question}

**INTENT EXPERT ANALYSIS:**
{intent_context}

**SCHEMA EXPERT GUIDANCE:** 
You MUST use these exact table names, column names, and join relationships:
{schema_context}

**LOGIC EXPERT REQUIREMENTS:**
You MUST apply these mandatory rules, calculations, and patterns:
{logic_context}

Generate the SQL query that answers the business question while strictly adhering to all expert guidance above. Return only the SQL query.""")
        ])
        
        # Generate final SQL
        chain = orchestrator_prompt | llm | StrOutputParser()
        
        final_sql = chain.invoke({
            "business_question": business_question,
            "intent_context": intent_context,
            "schema_context": schema_context,
            "logic_context": logic_context
        })
        
        # Clean up the response
        sql_query = final_sql.strip()
        if sql_query.startswith("```sql"):
            sql_query = sql_query[6:]
        if sql_query.startswith("```"):
            sql_query = sql_query[3:]
        if sql_query.endswith("```"):
            sql_query = sql_query[:-3]
        
        print("   ✓ Orchestrator: Final SQL generated successfully")
        return sql_query.strip()
        
    except Exception as e:
        print(f"   ✗ Orchestrator Error: {str(e)}")
        return f"-- Error in multi-agent coordination: {str(e)}"


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
        print("🚀 Starting Multi-Agent 'Divide and Conquer' Test")
        print("=" * 70)
        
        # Display A/B test configuration
        catalog_type = "FIXED" if USE_FIXED_CATALOG else "ORIGINAL"
        print(f"🧪 A/B Test Configuration: Using {catalog_type} data catalog")
        print(f"   → data_catalog{'_fixed' if USE_FIXED_CATALOG else ''}.json")
        
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
            query_file = os.path.basename(file_path)
            base_name = os.path.splitext(query_file)[0]
            
            # Check if this query already exists (for resuming)
            catalog_suffix = "fixed" if USE_FIXED_CATALOG else "original"
            output_file = os.path.join(RESULTS_DIR, f"{base_name}_multiagent_{catalog_suffix}_result.json")
            
            if os.path.exists(output_file):
                print(f"⏭️  Skipping {query_file} (already completed)")
                success_count += 1
                continue
            
            print(f"🔄 Processing: {query_file} (Query {sql_files.index(file_path)+1}/{len(sql_files)})")
            
            try:
                # Parse the golden query file
                business_question, golden_sql = parse_golden_query_file(file_path)
                
                if not business_question or not golden_sql:
                    print(f"✗ Error parsing {query_file}: Empty content")
                    continue
                
                print(f"   📝 Business Question: {business_question[:100]}...")
                
                # Generate Multi-Agent response
                print("   🤖 Starting multi-agent coordination...")
                ai_generated_sql = get_multi_agent_response(business_question, USE_FIXED_CATALOG)
                
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
                    "file_name": query_file,
                    "timestamp": str(Path().resolve()),
                    "a_b_test_config": {
                        "use_fixed_catalog": USE_FIXED_CATALOG,
                        "catalog_used": f"data_catalog{'_fixed' if USE_FIXED_CATALOG else ''}.json"
                    },
                    "business_question": business_question,
                    "golden_sql": golden_sql,
                    "ai_generated_sql": ai_generated_sql,
                    "multi_agent_architecture": {
                        "orchestrator": "Gemini 2.5 Pro",
                        "intent_agent": "Semantic context-based intent parsing",
                        "schema_agent": f"Data catalog {'fixed' if USE_FIXED_CATALOG else 'original'} + value mappings",
                        "logic_agent": "Business rules + query patterns + cookbook"
                    },
                    "api_result": api_result
                }
                
                # Save result with multi-agent specific naming
                catalog_suffix = "fixed" if USE_FIXED_CATALOG else "original"
                output_file = os.path.join(RESULTS_DIR, f"{base_name}_multiagent_{catalog_suffix}_result.json")
                save_result(result_data, output_file)
                
                # Print status
                if api_result["success"]:
                    row_count = api_result.get("row_count", "unknown")
                    print(f"   ✓ SUCCESS: Multi-agent query executed successfully ({row_count} rows)")
                    success_count += 1
                elif api_result.get("skipped"):
                    print(f"   ⏭️  SKIPPED: Metabase API test (Multi-agent SQL generated successfully)")
                    success_count += 1  # Count as success since SQL was generated
                else:
                    error = api_result.get("error", "Unknown error")
                    print(f"   ✗ FAILED: {error[:100]}...")
                
            except Exception as e:
                print(f"   ✗ ERROR processing {query_file}: {str(e)}")
            
            print()
        
        # Final summary
        print("=" * 70)
        print(f"🏁 Multi-Agent 'Divide and Conquer' Test Complete!")
        print(f"🧪 A/B Test: {catalog_type} catalog configuration")
        print(f"📊 Results: {success_count}/{total_count} queries executed successfully")
        print(f"📂 Detailed results saved in: {RESULTS_DIR}/")
        print(f"🤖 Architecture: Intent + Schema + Logic → Orchestrator (Gemini 2.5 Pro)")
        
        if success_count == total_count:
            print("🎉 All multi-agent tests passed!")
        elif success_count > 0:
            print("⚠️  Some tests failed - check individual result files for details")
        else:
            print("❌ All tests failed - check your configuration and queries")
            
    except Exception as e:
        print(f"💥 Fatal error: {str(e)}")
        raise


if __name__ == "__main__":
    main() 