# StoreHub Redshift Semantic Layer - AI SQL Generation Validation

[![Python 3.9](https://img.shields.io/badge/python-3.9-blue.svg)](https://www.python.org/downloads/release/python-390/)
[![LangChain](https://img.shields.io/badge/LangChain-0.2+-green.svg)](https://python.langchain.com/)
[![Google Gemini](https://img.shields.io/badge/Google%20Gemini-2.5%20Pro-orange.svg)](https://ai.google.dev/gemini-api/docs)

> **A comprehensive validation sprint comparing RAG vs Framework approaches for natural language to SQL generation in complex multi-tenant retail environments.**

## 🎯 **Project Overview**

This repository contains a complete validation sprint for an AI-powered natural language to SQL system designed for StoreHub's multi-country retail and F&B operations. The project tests two architectural approaches (RAG vs Semantic Framework) across multiple LLM models to determine the optimal solution for production deployment.

### **Key Results**
- **14 Golden Queries** tested across 4 different configurations
- **Multi-Model Testing**: Gemini 2.0 Flash vs 2.5 Pro comparison
- **Forensic Analysis**: Deep technical audits revealing critical architectural insights
- **Production Readiness Assessment**: Comprehensive evaluation for real-world deployment

## 🏗️ **Three-Loop Architecture Validation Results**

| Loop | Approach | Model | Execution Success | Logical Correctness | Production Ready |
|------|----------|-------|------------------|-------------------|------------------|
| **Loop 1** | **RAG Agent** | Gemini 2.5 Pro | **78.6%** (11/14) | **42.9%** (6/14) | ⚠️ Needs Enhancement |
| Loop 1 | RAG Agent | Gemini 2.0 Flash | 0% (0/14) | 0% (0/14) | ❌ Not Suitable |
| **Loop 2** | **Framework Agent** | Gemini 2.5 Pro | 0% (0/14) | 0% (0/14) | ❌ Complete Failure |
| Loop 2 | Framework Agent | Gemini 2.0 Flash | 100%* (14/14) | 0% (0/14) | ❌ False Success |
| **Loop 3** | **Multi-Agent** | Gemini 2.5 Pro | 0% (0/14) | 0% (0/14) | ❌ Architecture Failure |

*\*Framework with 2.0 Flash showed execution success but returned 0 rows - indicating systematic schema failures*

## 🔑 **Critical Findings**

### **RAG Approach (Gemini 2.5 Pro)**
✅ **Strengths:**
- 78.6% execution success rate
- Handles basic business logic patterns
- Efficient query generation with proper schema references

⚠️ **Limitations:**
- Only 42.9% logical correctness
- Missing critical business filters in 71% of cases
- Oversimplifies complex analytical frameworks

### **Framework Approach**
❌ **Complete Failure:**
- 162K character semantic context provides zero benefit
- Fundamental schema incompatibility with LLM training
- 80x more context overhead for 0% improvement

### **Model Comparison Insight**
**Critical Learning:** Model sophistication significantly impacts performance, but fundamental architectural problems persist regardless of model quality.

## 🚀 **Quick Start**

### **Prerequisites**
- Python 3.9+
- Google Gemini API Key
- (Optional) Metabase instance for live testing

### **Installation**
```bash
# Clone the repository
git clone https://github.com/SharleneChewStorehub/redshift-semantic.git
cd redshift-semantic

# Create virtual environment
python3.9 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp env_template.txt .env
# Edit .env with your Google API key
```

### **Run Tests**
```bash
# Loop 1: Test RAG approach
python run_rag_test.py

# Loop 2: Test Framework approach  
python run_framework_test.py

# Loop 3: Test Multi-Agent approach
python run_multi_agent_test.py
```

## 📊 **Project Structure**

```
redshift-semantic/
├── 📁 source/                          # Complete semantic layer (500+ files)
│   └── sh-reports/
│       ├── semantic_layer_v2/           # 6-layer JSON architecture
│       ├── report-api/                  # TypeScript API
│       └── database_schema/             # MongoDB schema docs
├── 📁 golden_queries/                   # 14 real business queries
├── 📁 results/                          # Loop 1: RAG test results  
├── 📁 results_framework/                # Loop 2: Framework test results
├── 📁 results_multi_agent/              # Loop 3: Multi-Agent test results
├── 📁 gemini2.0flash/                   # Baseline model results (all loops)
├── 📋 PROJECT_PROGRESS.md               # Complete documentation
├── 📋 08a_FINAL_SPRINT_REPORT.md        # Three-loop comparative analysis
├── 📋 07a_VALIDATION_RESULTS_LOOP1_RAG_AUDIT.md
├── 📋 07b_VALIDATION_RESULTS_LOOP2_FRAMEWORK_AUDIT.md
├── 🐍 run_rag_test.py                   # Loop 1: RAG validation script
├── 🐍 run_framework_test.py             # Loop 2: Framework validation script
├── 🐍 run_multi_agent_test.py           # Loop 3: Multi-Agent validation script
└── 📋 requirements.txt                  # Dependencies
```

## 📚 **Key Documentation**

### **Validation Reports**
- **[Complete Project Progress](PROJECT_PROGRESS.md)** - Comprehensive documentation
- **[Final Sprint Report](08a_FINAL_SPRINT_REPORT.md)** - Three-loop comparative analysis & strategic recommendations
- **[Loop 1: RAG Agent Forensic Audit](07a_VALIDATION_RESULTS_LOOP1_RAG_AUDIT.md)** - Deep technical analysis
- **[Loop 2: Framework Agent Audit](07b_VALIDATION_RESULTS_LOOP2_FRAMEWORK_AUDIT.md)** - Complete failure analysis

### **Business Context**
- **Multi-Country Operations**: Malaysia, Philippines, Thailand, Singapore
- **Complex Schema**: MongoDB-style document store with 172 tables
- **Real-World Queries**: Loyalty analysis, payment gateways, QR usage, campaigns

## 🧪 **Testing Framework Architecture & Methodology**

This project implements a comprehensive **3-Loop Validation Sprint** using different AI architectural approaches to test natural language to SQL generation. Each loop represents a distinct architectural philosophy, tested against the same 14 golden queries for consistent comparison.

### **🔄 Loop 1: RAG (Retrieval-Augmented Generation) Approach**

**Architecture**: Simple context-based SQL generation using example queries as reference patterns.

**Technical Implementation**:
- **Agent**: Single RAG agent (`run_rag_test.py`)
- **LLM**: Google Gemini 2.5 Pro (primary) / 2.0 Flash (baseline)
- **Context Strategy**: Uses golden SQL queries as few-shot examples
- **Prompt Engineering**: Business analyst persona with SQL generation guidelines
- **Temperature**: 0.1 (deterministic outputs)

**Key Features**:
- **Lightweight Architecture**: Minimal complexity, industry-standard approach
- **Pattern Matching**: Learns from similar query patterns in golden dataset
- **Direct Translation**: Business question → SQL with example-based guidance
- **No Schema Dependencies**: Relies on LLM's inherent SQL knowledge

**Results Summary**:
- ✅ **Execution Success**: 78.6% (11/14 queries executed successfully)
- ⚠️ **Logical Correctness**: 42.9% (6/14 business logic accurate)
- ⚠️ **Production Assessment**: Needs significant business rule enhancement

---

### **🏗️ Loop 2: Monolithic Framework Approach**

**Architecture**: Comprehensive semantic layer using structured business context for query generation.

**Technical Implementation**:
- **Agent**: Framework agent (`run_framework_test.py`) 
- **LLM**: Google Gemini 2.5 Pro (primary) / 2.0 Flash (baseline)
- **Context Strategy**: 162K character semantic framework (6 JSON files)
- **Business Context**: Rules, catalog, patterns, value mappings, cookbook, context
- **Temperature**: 0.1 (deterministic outputs)

**Semantic Framework Components**:
```
source/sh-reports/semantic_layer_v2/core/
├── business_rules.json       # Mandatory filters, business logic
├── data_catalog.json        # Table schemas, relationships 
├── query_patterns.json      # Common SQL patterns
├── value_mappings.json      # Status codes, enum translations
├── query_cookbook.json      # Example query patterns
└── semantic_context.json    # Domain knowledge
```

**Key Features**:
- **Comprehensive Context**: Complete business domain knowledge
- **Structured Schema**: Detailed table/column mappings
- **Business Rules**: Mandatory filters and calculations
- **Pattern Library**: Proven query structures and examples

**Results Summary**:
- ❌ **Execution Success**: 0% (0/14 queries executed)
- ❌ **Schema Comprehension**: Complete failure to understand database structure
- ❌ **Production Assessment**: Fundamental architecture incompatibility

---

### **🎯 Loop 3: Multi-Agent "Divide and Conquer" Approach** 

**Architecture**: Specialized agent coordination with distinct roles for different aspects of SQL generation.

**Technical Implementation**:
- **Orchestrator**: Multi-agent coordinator (`run_multi_agent_test.py`)
- **LLM**: Google Gemini 2.5 Pro for all agents
- **Architecture**: 4 specialized agents working in sequence
- **Temperature**: 0.1 across all agents (deterministic)

**Agent Specialization**:

**🎯 Intent Agent** (Sequential - Step 1):
- **Role**: Business question parser and intent extraction
- **Input**: Natural language business question
- **Output**: Structured intent analysis (INTENT, ENTITIES, METRICS, TIME_CONTEXT, ANALYSIS_TYPE, FILTERS)
- **Context**: Semantic interpretation guidelines

**🗄️ Schema Agent** (Parallel - Step 2A):
- **Role**: Database schema expert and table/column mapping
- **Input**: Intent analysis from Intent Agent
- **Output**: Exact table names, columns, joins, mandatory filters, value mappings
- **Context**: Data catalog + value mappings (A/B testing: original vs fixed catalog)

**📋 Logic Agent** (Parallel - Step 2B):
- **Role**: Business rules and SQL pattern expert
- **Input**: Intent analysis from Intent Agent  
- **Output**: Mandatory business rules, calculation logic, SQL patterns, best practices
- **Context**: Business rules + query patterns + cookbook

**🎼 Orchestrator Agent** (Integration - Step 3):
- **Role**: Final SQL generation using all expert guidance
- **Input**: Original question + Intent + Schema + Logic contexts
- **Output**: Final executable SQL query
- **Context**: Comprehensive prompt enforcing expert guidance

**Execution Flow**:
```
Business Question → Intent Agent → Structured Intent
                                      ↓
                   Schema Agent ← Intent Output → Logic Agent
                        ↓                           ↓
                   Schema Context ← Orchestrator → Logic Context
                                      ↓
                               Final SQL Query
```

**Key Features**:
- **Separation of Concerns**: Each agent has single responsibility
- **Expert Specialization**: Deep domain expertise per agent
- **Parallel Processing**: Schema + Logic analysis run concurrently
- **Structured Coordination**: Clear handoff points and information flow
- **Quality Control**: Orchestrator enforces expert guidance

**Results Summary**:
- ❌ **Execution Success**: 0% (0/14 queries executed)
- ❌ **Schema Comprehension**: Identical failure pattern as Framework approach
- ❌ **Production Assessment**: Architecture sophisticated but fundamental issues persist

---

### **🔬 Testing Methodology**

**Consistent Test Environment**:
- **Golden Queries**: Same 14 real-world business queries across all loops
- **Validation**: Metabase API integration for live query execution
- **Models**: Gemini 2.5 Pro (primary), 2.0 Flash (baseline comparison)
- **Metrics**: Execution success, logical correctness, business rule compliance
- **Documentation**: JSON results with comprehensive metadata

**Quality Assurance**:
- **Forensic Analysis**: Deep technical audits of generated SQL
- **Business Logic Validation**: Manual review of analytical correctness
- **Comparative Assessment**: Direct performance comparison across approaches
- **A/B Testing**: Original vs fixed catalog testing in multi-agent approach

**Key Learnings**:
1. **Architecture Complexity ≠ Better Results**: Most sophisticated approach (Multi-Agent) failed completely
2. **Schema Compatibility Critical**: MongoDB-style schema fundamentally challenging for LLMs
3. **Business Logic Gap**: All approaches struggle with complex analytical frameworks
4. **Model Quality Matters**: Gemini 2.5 Pro significantly outperforms 2.0 Flash, but can't solve architectural issues

## 🔄 **Current Status**

**Phase 4: Three-Loop Architectural Validation** ✅ **COMPLETED**
- [x] **Loop 1**: RAG approach testing (78.6% execution, 42.9% logic accuracy)
- [x] **Loop 2**: Framework approach testing (0% execution success)  
- [x] **Loop 3**: Multi-Agent approach testing (0% execution success)
- [x] Forensic-level technical audits across all approaches
- [x] Production readiness assessment with critical findings

**Phase 5: Strategic Decision** 🔄 **CURRENT**
- [x] Comprehensive comparative analysis completed
- [ ] Final architectural recommendation and implementation plan

## 🛠️ **Technology Stack**

- **Primary LLM**: Google Gemini 2.5 Pro
- **Baseline LLM**: Google Gemini 2.0 Flash  
- **Framework**: LangChain
- **Language**: Python 3.9
- **Database**: Amazon Redshift (MongoDB-style schema)
- **Testing**: Metabase API integration

## 📈 **Business Impact**

This comprehensive three-loop validation sprint evaluated architectural approaches:
1. **Complex 6-layer semantic architecture** (500+ files, comprehensive but high maintenance)
2. **Simplified RAG approach** (78.6% execution, 42.9% logic accuracy)
3. **Monolithic Framework approach** (0% execution success, architecture failure)
4. **Multi-agent specialized architecture** (0% execution success, schema incompatibility)

**Critical Finding**: None of the tested AI architectures achieved production readiness, revealing fundamental challenges with MongoDB-style schema compatibility and business logic preservation in LLM-based SQL generation.

**Strategic Outcome**: Results inform decisions about semantic layer complexity vs. alternative architectural approaches for complex retail analytics.

## 🤝 **Contributing**

This repository represents a completed validation sprint. Future contributions welcome for:
- Multi-agent architecture development
- Business rule enhancement
- Performance optimization
- Schema compatibility improvements

## 📞 **Contact**

- **Developer**: Sharlene Chew (@SharleneChewStorehub)
- **Organization**: StoreHub
- **Project Type**: Architectural Validation & Research

## 📄 **License**

This project contains proprietary business logic and is intended for research and validation purposes within StoreHub's architectural decision process.

---

**🔍 Explore the validation results and help shape the future of AI-powered SQL generation for complex business domains!** 