# Gemini 2.0 Flash Testing Framework

This directory contains the complete testing framework for evaluating **Gemini 2.0 Flash** performance in SQL query generation using both RAG and semantic framework approaches.

## 🎯 Overview

This testing framework replicates the exact same methodology used for Gemini 2.5 Pro testing, allowing for direct performance comparison between the models. The testing follows a comprehensive 4-phase cycle:

1. **Loop 1**: RAG Agent Testing (Basic data catalog approach)
2. **Loop 1 Audit**: Critical analysis of RAG results  
3. **Loop 2**: Framework Agent Testing (Advanced semantic framework)
4. **Loop 2 Audit**: Comprehensive framework performance analysis

## 📁 Directory Structure

```
gemini2.0flash/
├── README.md                           # This file
├── GEMINI_2_0_FLASH_TEST_PLAN.md      # Detailed test plan
├── run_rag_test_2_0_flash.py           # Loop 1: RAG agent testing
├── run_framework_test_2_0_flash.py     # Loop 2: Framework agent testing  
├── run_complete_test_cycle.py          # Master orchestration script
├── results_rag/                        # Loop 1 test results (generated)
├── results_framework/                  # Loop 2 test results (generated)
├── LOOP1_RAG_AUDIT_GEMINI_2_0_FLASH.md       # Loop 1 audit (to be created)
└── LOOP2_FRAMEWORK_AUDIT_GEMINI_2_0_FLASH.md # Loop 2 audit (to be created)
```

## 🚀 Quick Start

### Prerequisites

1. **Environment Variables**: Ensure your `.env` file contains:
   ```
   GOOGLE_API_KEY=your_google_api_key
   METABASE_HOST=your_metabase_host
   METABASE_API_KEY=your_metabase_api_key
   METABASE_DATABASE_ID=2
   ```

2. **Dependencies**: Install required packages:
   ```bash
   pip install -r ../requirements.txt
   ```

3. **Golden Queries**: Ensure `../golden_queries/` contains 14 SQL test files

### Complete Test Cycle (Recommended)

Run the entire testing cycle with one command:

```bash
cd gemini2.0flash
python run_complete_test_cycle.py
```

This will:
- ✅ Validate environment setup
- 🔄 Execute Loop 1 (RAG testing)  
- 🔄 Execute Loop 2 (Framework testing)
- 📊 Generate results summary
- 📋 Provide next steps guidance

### Individual Test Phases

#### Loop 1: RAG Agent Testing
```bash
python run_rag_test_2_0_flash.py
```
- **Model**: `gemini-2.0-flash-exp`
- **Context**: Basic data catalog schema
- **Output**: `results_rag/` directory with 14 JSON files

#### Loop 2: Framework Agent Testing  
```bash
python run_framework_test_2_0_flash.py
```
- **Model**: `gemini-2.0-flash-exp`
- **Context**: Full semantic framework (6 JSON components)
- **Output**: `results_framework/` directory with 14 JSON files

## 📊 Expected Results

### Test Files (14 Golden Queries)
1. `01_membership_insights.sql` - Customer loyalty analysis
2. `02_merchant_store_profile.sql` - Store performance profiles  
3. `03_engage_freetrial.sql` - Trial conversion funnel
4. `04_beep_ecomm_paymentgatewayrevenue.sql` - Payment gateway revenue
5. `05_beep_qr_usage_store.sql` - QR code adoption metrics
6. `06_cashback_utilisation.sql` - Cashback program effectiveness
7. `07_engage_active_campaign.sql` - Campaign performance
8. `08_imika_stockvalue.sql` - Inventory valuation
9. `09_thismonth_beep_qr_store.sql` - Monthly QR metrics
10. `10_sales_by_product.sql` - Product sales analysis
11. `11_sales_by_paymentmethod.sql` - Payment method breakdown
12. `12_payout_summary_transaction_breakdown.sql` - Payout analysis
13. `13_transaction_breakdown_store.sql` - Store transaction analysis
14. `14_transaction_item.sql` - Transaction item details

### Success Metrics
- **Execution Success Rate**: % of queries that run without errors
- **Logic Correctness Rate**: % of queries that are functionally correct
- **Performance Comparison**: Gemini 2.0 Flash vs 2.5 Pro analysis

## 🔍 Critical Audit Process

After running the tests, perform detailed audits:

### Loop 1 Audit (RAG Results)
Create `LOOP1_RAG_AUDIT_GEMINI_2_0_FLASH.md` with:
- Executive summary with success rates
- Detailed test results table analyzing:
  - **JOIN Logic**: Table relationships and join correctness
  - **Filtering Logic**: WHERE clause accuracy  
  - **Aggregation Logic**: SUM, COUNT, calculation correctness
  - **Grouping Logic**: GROUP BY clause accuracy
- Critical issues identification
- Recommendations for improvement

### Loop 2 Audit (Framework Results)  
Create `LOOP2_FRAMEWORK_AUDIT_GEMINI_2_0_FLASH.md` with:
- Comprehensive framework performance analysis
- Cross-loop comparison (Framework vs RAG)
- Cross-model comparison (2.0 Flash vs 2.5 Pro)
- Final recommendations and insights

## 🎛️ Configuration

### Model Configuration
```python
# Current settings in both test scripts
llm = ChatGoogleGenerativeAI(
    model="gemini-2.0-flash-exp",  # Can be changed to stable version
    temperature=0.1,               # Low temperature for consistent results
    google_api_key=GOOGLE_API_KEY
)
```

### Test Parameters
- **Timeout**: 30 seconds per API call
- **Retry Logic**: Built-in error handling
- **Output Format**: JSON with full API responses
- **Timestamp**: ISO format for result tracking

## 🔧 Troubleshooting

### Common Issues

1. **API Key Issues**
   ```
   Error: Missing required environment variables: ['GOOGLE_API_KEY']
   ```
   **Solution**: Check your `.env` file and ensure `GOOGLE_API_KEY` is set

2. **Model Not Found**
   ```
   Error: Model gemini-2.0-flash-exp not found
   ```
   **Solution**: Try alternative model names:
   - `gemini-2.0-flash`
   - `gemini-1.5-flash`

3. **Schema Errors**
   ```
   ERROR: relation "table_name" does not exist
   ```
   **Expected**: This indicates the model is generating incorrect table references

4. **Metabase Connection Issues**
   ```
   Error: Metabase configuration not available
   ```
   **Solution**: Check `METABASE_HOST` and `METABASE_API_KEY` in your `.env` file

### Debugging Tips

1. **Verbose Output**: Both scripts provide detailed console output
2. **Result Files**: Check JSON files for full API responses and error details
3. **Partial Runs**: Scripts can run without Metabase (SQL generation only)
4. **Log Analysis**: Review error patterns across multiple test cases

## 📈 Performance Analysis

### Expected Performance Patterns

Based on Gemini 2.5 Pro results, expect:

**Loop 1 (RAG)**:
- ❌ High schema-related failures
- ⚠️ Basic business logic understanding
- 📊 Success rate: 30-50%

**Loop 2 (Framework)**:
- ❌ Potential schema mapping improvements
- ✅ Better business rule adherence  
- 📊 Expected success rate: 40-60%

### Key Analysis Questions

1. **Schema Understanding**: Does 2.0 Flash handle complex table names better?
2. **Framework Effectiveness**: How much does the semantic framework help?
3. **Model Comparison**: Is 2.0 Flash comparable to 2.5 Pro for SQL generation?
4. **Cost Efficiency**: What's the performance/cost ratio compared to 2.5 Pro?

## 🎯 Success Criteria

### Phase Completion
- ✅ All 14 test cases executed for both loops
- ✅ Results saved with complete metadata
- ✅ Clear success/failure classification
- ✅ Detailed error analysis available

### Quality Assessment  
- 📊 Quantitative metrics (success rates)
- 🔍 Qualitative analysis (SQL correctness)
- 📈 Performance improvement measurement
- 🆚 Cross-model comparison insights

## 📚 Additional Resources

- **Test Plan**: `GEMINI_2_0_FLASH_TEST_PLAN.md` - Detailed methodology
- **Original Results**: `../results_framework/` - Gemini 2.5 Pro comparison data
- **Golden Queries**: `../golden_queries/` - Reference SQL implementations
- **Framework Files**: `../source/sh-reports/semantic_layer_v2/core/` - Semantic context

---

**Note**: This testing framework is designed to provide comprehensive insights into Gemini 2.0 Flash capabilities for complex SQL generation in real-world business scenarios. The results will help inform model selection decisions for production deployment. 