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

## 🏗️ **Architecture Validation Results**

| Approach | Model | Execution Success | Logical Correctness | Production Ready |
|----------|-------|------------------|-------------------|------------------|
| **RAG Agent** | Gemini 2.5 Pro | **78.6%** (11/14) | **42.9%** (6/14) | ⚠️ Needs Enhancement |
| **RAG Agent** | Gemini 2.0 Flash | 0% (0/14) | 0% (0/14) | ❌ Not Suitable |
| **Framework Agent** | Gemini 2.5 Pro | 0% (0/14) | 0% (0/14) | ❌ Complete Failure |
| **Framework Agent** | Gemini 2.0 Flash | 100%* (14/14) | 0% (0/14) | ❌ False Success |

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
# Test RAG approach
python run_rag_test.py

# Test Framework approach
python run_framework_test.py
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
├── 📁 results/                          # RAG test results
├── 📁 results_framework/                # Framework test results
├── 📁 gemini2.0flash/                   # Baseline model results
├── 📋 PROJECT_PROGRESS.md               # Complete documentation
├── 📋 07a_VALIDATION_RESULTS_LOOP1_RAG_AUDIT.md
├── 📋 07b_VALIDATION_RESULTS_LOOP2_FRAMEWORK_AUDIT.md
├── 🐍 run_rag_test.py                   # RAG validation script
├── 🐍 run_framework_test.py             # Framework validation script
└── 📋 requirements.txt                  # Dependencies
```

## 📚 **Key Documentation**

### **Validation Reports**
- **[Complete Project Progress](PROJECT_PROGRESS.md)** - Comprehensive documentation
- **[RAG Agent Forensic Audit](07a_VALIDATION_RESULTS_LOOP1_RAG_AUDIT.md)** - Deep technical analysis
- **[Framework Agent Audit](07b_VALIDATION_RESULTS_LOOP2_FRAMEWORK_AUDIT.md)** - Complete failure analysis

### **Business Context**
- **Multi-Country Operations**: Malaysia, Philippines, Thailand, Singapore
- **Complex Schema**: MongoDB-style document store with 172 tables
- **Real-World Queries**: Loyalty analysis, payment gateways, QR usage, campaigns

## 🔄 **Current Status**

**Phase 4: Architectural Validation** ✅ **COMPLETED**
- [x] Multi-model testing across both approaches
- [x] Forensic-level technical audits
- [x] Production readiness assessment

**Phase 5: Next Steps** 🔄 **PLANNED**
- [ ] **Loop 3: Multi-Agent System Test** - Testing specialized agent architecture
- [ ] Final architectural decision based on validation results

## 🛠️ **Technology Stack**

- **Primary LLM**: Google Gemini 2.5 Pro
- **Baseline LLM**: Google Gemini 2.0 Flash  
- **Framework**: LangChain
- **Language**: Python 3.9
- **Database**: Amazon Redshift (MongoDB-style schema)
- **Testing**: Metabase API integration

## 📈 **Business Impact**

This validation sprint is part of a larger decision between:
1. **Complex 6-layer semantic architecture** (500+ files, comprehensive but high maintenance)
2. **Simplified RAG approach** (basic but requiring enhancement)
3. **Multi-agent specialized architecture** (next phase testing)

**Goal**: Production-ready natural language to SQL system for complex retail analytics.

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