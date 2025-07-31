# AI AUDIT MANIFEST
**Project:** Redshift Semantic Layer  
**Audit Date:** January 25, 2025  
**Auditor:** AI Senior Engineering Auditor  

## COMPLETE DIRECTORY TREE STRUCTURE

```
redshift-semantic/
├── .DS_Store
└── source/
    └── sh-reports/
        ├── .DS_Store
        ├── database_schema_analysis.py
        ├── generate_172_tables.py
        ├── README_SEMANTIC_LAYER.md
        ├── REORGANIZATION_COMPLETE.md
        ├── database_schema/
        │   ├── README.md
        │   ├── database_schema.json
        │   ├── database_schema_detailed.md
        │   ├── database_schema_overview.md
        │   ├── storehub-table1.sql
        │   ├── storehub-table2.sql
        │   └── storehub-table2-end.sql
        ├── docs/
        │   ├── evolution.md
        │   ├── migration_guide.md
        │   └── totalreports.md
        ├── report-api/
        │   ├── .DS_Store
        │   ├── .dockerignore
        │   ├── .eslintignore
        │   ├── .eslintrc
        │   ├── .gitignore
        │   ├── .gitmodules
        │   ├── .prettierignore
        │   ├── .prettierrc
        │   ├── Dockerfile
        │   ├── Jenkinsfile
        │   ├── Jenkinsfile_no_sonar
        │   ├── README.md
        │   ├── jest.config.json
        │   ├── newrelic.js
        │   ├── package.json
        │   ├── sonar-project.properties
        │   ├── tsconfig.json
        │   ├── yarn.lock
        │   ├── git_hooks/
        │   │   ├── copy
        │   │   └── pre-push
        │   ├── src/
        │   │   ├── database.ts
        │   │   ├── index.ts
        │   │   ├── relations.ts
        │   │   ├── router.ts
        │   │   ├── schedulers.ts
        │   │   ├── stats.ts
        │   │   ├── builders/
        │   │   │   ├── dataset.ts
        │   │   │   └── timezone-name-offsets.d.ts
        │   │   ├── controllers/
        │   │   │   ├── context.ts
        │   │   │   ├── error.ts
        │   │   │   ├── stats.ts
        │   │   │   ├── utils.ts
        │   │   │   ├── beep/
        │   │   │   │   └── index.ts
        │   │   │   ├── businessTags/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── countCustomers/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── customers/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── dashboard/
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── employees/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── engageReport/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── feedbackReport/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── loyaltychangelogs/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── membersReport/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── newCustomers/
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── suggestions/
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   ├── transactionrecords/
        │   │   │   │   ├── constants.ts
        │   │   │   │   ├── index.ts
        │   │   │   │   └── router.ts
        │   │   │   └── transformations/
        │   │   │       ├── constants.ts
        │   │   │       ├── index.ts
        │   │   │       ├── jobs.ts
        │   │   │       └── router.ts
        │   │   ├── interfaces/
        │   │   │   └── dataset.ts
        │   │   ├── loaders/
        │   │   │   ├── business.ts
        │   │   │   ├── index.ts
        │   │   │   ├── sales.ts
        │   │   │   └── transaction.ts
        │   │   ├── redis/
        │   │   │   ├── index.ts
        │   │   │   └── redis.d.ts
        │   │   ├── utils/
        │   │   │   ├── request.ts
        │   │   │   └── timezones.ts
        │   │   └── warehouse/
        │   │       ├── index.ts
        │   │       └── redshift/
        │   │           ├── aws-redshift.d.ts
        │   │           ├── index.ts
        │   │           └── sql.ts
        │   └── test/
        │       ├── .DS_Store
        │       ├── builders/
        │       │   └── dataset.test.ts
        │       ├── controllers/
        │       │   ├── context.test.ts
        │       │   ├── utils.test.ts
        │       │   ├── customers/
        │       │   │   ├── case.ts
        │       │   │   ├── constants.test.ts
        │       │   │   └── index.test.ts
        │       │   ├── loyaltychangelogs/
        │       │   │   ├── case.ts
        │       │   │   ├── constants.test.ts
        │       │   │   └── index.test.ts
        │       │   └── transactionrecords/
        │       │       ├── case.ts
        │       │       ├── contants.test.ts
        │       │       └── index.test.ts
        │       └── warehouse/
        │           └── sql.test.ts
        └── semantic_layer_v2/
            ├── .DS_Store
            ├── README.md
            ├── SEMANTIC_LAYER_ASSESSMENT.md
            ├── Tables in Data Warehouse - Sheet1.csv
            ├── query_result_2025-07-09T07_23_29.784502Z.csv
            ├── core/
            │   ├── business_rules.json
            │   ├── data_catalog.json
            │   ├── query_cookbook.json
            │   ├── query_patterns.json
            │   ├── semantic_context.json
            │   └── value_mappings.json
            ├── data_samples/
            │   ├── .DS_Store
            │   ├── 172_TABLES_EXTRACTION_README.md
            │   ├── SAMPLING_STRATEGY.md
            │   ├── DATA_SAMPLES_ORGANIZATION.md
            │   ├── README.md
            │   ├── COMPLETE_130_TABLES_REPORT.md
            │   ├── [numerous .py, .json, .log, .md, .txt files...]
            │   ├── 172_data/
            │   ├── active_data/
            │   ├── archive/
            │   ├── latest_metabase_extractions/
            │   └── metabase_questions/
            ├── debug/
            │   ├── README.md
            │   ├── malaysian_retail_merchants_with_cigarettes.sql
            │   ├── partner_presentation_summary.sql
            │   └── cigarette_queries/
            │       ├── complete_validated_cigarette_query.sql
            │       ├── debug_cigarette_query.sql
            │       ├── debug_join_issue.sql
            │       └── [additional .sql files]
            ├── generated_queries/
            │   ├── monthly_sales_report_nasikukusnkb.sql
            │   ├── monthly_sales_report_nasikukusnkb_fixed.sql
            │   ├── monthly_sales_report_nasikukusnkb_final.sql
            │   └── mrr_arr_stores_query.sql
            ├── latestplan/
            │   ├── 172tables.md
            │   └── comprehensiveplan.md
            ├── profiling/
            │   ├── data_profiling_framework.py
            │   └── data_profiling_queries.sql
            ├── schema_extraction/
            │   ├── README.md
            │   ├── SCHEMA_EXTRACTION_SUMMARY.md
            │   ├── convert_to_svv_format.py
            │   ├── create_compact_schema.py
            │   ├── extract_172_tables_list.py
            │   ├── [numerous schema-related .py, .sql, .json, .md, .txt files...]
            └── validation/
                ├── README.md
                ├── example_integration.py
                ├── query_validator.py
                ├── quick_schema_check.sh
                ├── schema_lookup.py
                ├── schema_validation.json
                ├── sql_builder_with_validation.py
                └── [numerous validation .py and .json files...]
```

## HIGH_PRIORITY_FILES

### Documentation Files (.md)
- `source/sh-reports/README_SEMANTIC_LAYER.md`
- `source/sh-reports/REORGANIZATION_COMPLETE.md`
- `source/sh-reports/database_schema/README.md`
- `source/sh-reports/database_schema/database_schema_detailed.md`
- `source/sh-reports/database_schema/database_schema_overview.md`
- `source/sh-reports/docs/evolution.md`
- `source/sh-reports/docs/migration_guide.md`
- `source/sh-reports/docs/totalreports.md`
- `source/sh-reports/report-api/README.md`
- `source/sh-reports/semantic_layer_v2/README.md`
- `source/sh-reports/semantic_layer_v2/SEMANTIC_LAYER_ASSESSMENT.md`
- `source/sh-reports/semantic_layer_v2/data_samples/172_TABLES_EXTRACTION_README.md`
- `source/sh-reports/semantic_layer_v2/data_samples/SAMPLING_STRATEGY.md`
- `source/sh-reports/semantic_layer_v2/data_samples/DATA_SAMPLES_ORGANIZATION.md`
- `source/sh-reports/semantic_layer_v2/data_samples/COMPLETE_130_TABLES_REPORT.md`
- `source/sh-reports/semantic_layer_v2/debug/README.md`
- `source/sh-reports/semantic_layer_v2/latestplan/172tables.md`
- `source/sh-reports/semantic_layer_v2/latestplan/comprehensiveplan.md`
- `source/sh-reports/semantic_layer_v2/schema_extraction/README.md`
- `source/sh-reports/semantic_layer_v2/schema_extraction/SCHEMA_EXTRACTION_SUMMARY.md`
- `source/sh-reports/semantic_layer_v2/validation/README.md`

### SQL Files (.sql)
- `source/sh-reports/database_schema/storehub-table1.sql`
- `source/sh-reports/database_schema/storehub-table2.sql`
- `source/sh-reports/database_schema/storehub-table2-end.sql`
- `source/sh-reports/semantic_layer_v2/debug/malaysian_retail_merchants_with_cigarettes.sql`
- `source/sh-reports/semantic_layer_v2/debug/partner_presentation_summary.sql`
- `source/sh-reports/semantic_layer_v2/debug/cigarette_queries/complete_validated_cigarette_query.sql`
- `source/sh-reports/semantic_layer_v2/debug/cigarette_queries/debug_cigarette_query.sql`
- `source/sh-reports/semantic_layer_v2/debug/cigarette_queries/debug_join_issue.sql`
- `source/sh-reports/semantic_layer_v2/generated_queries/monthly_sales_report_nasikukusnkb.sql`
- `source/sh-reports/semantic_layer_v2/generated_queries/monthly_sales_report_nasikukusnkb_fixed.sql`
- `source/sh-reports/semantic_layer_v2/generated_queries/monthly_sales_report_nasikukusnkb_final.sql`
- `source/sh-reports/semantic_layer_v2/generated_queries/mrr_arr_stores_query.sql`
- `source/sh-reports/semantic_layer_v2/profiling/data_profiling_queries.sql`
- `source/sh-reports/semantic_layer_v2/schema_extraction/priority_schema_compact.sql`
- `source/sh-reports/semantic_layer_v2/schema_extraction/priority_tables_schema.sql`
- `source/sh-reports/semantic_layer_v2/schema_extraction/priority_tables_list.sql`

### Core Logic JSON Files (.json)
- `source/sh-reports/database_schema/database_schema.json`
- `source/sh-reports/semantic_layer_v2/core/business_rules.json`
- `source/sh-reports/semantic_layer_v2/core/data_catalog.json`
- `source/sh-reports/semantic_layer_v2/core/query_cookbook.json`
- `source/sh-reports/semantic_layer_v2/core/query_patterns.json`
- `source/sh-reports/semantic_layer_v2/core/semantic_context.json`
- `source/sh-reports/semantic_layer_v2/core/value_mappings.json`
- `source/sh-reports/semantic_layer_v2/schema_extraction/priority_tables_schema.json`
- `source/sh-reports/semantic_layer_v2/schema_extraction/priority_172_tables.json`
- `source/sh-reports/semantic_layer_v2/validation/schema_validation.json`

### Core Python Logic Files (.py)
- `source/sh-reports/database_schema_analysis.py`
- `source/sh-reports/generate_172_tables.py`
- `source/sh-reports/semantic_layer_v2/profiling/data_profiling_framework.py`
- `source/sh-reports/semantic_layer_v2/schema_extraction/convert_to_svv_format.py`
- `source/sh-reports/semantic_layer_v2/schema_extraction/create_compact_schema.py`
- `source/sh-reports/semantic_layer_v2/schema_extraction/extract_172_tables_list.py`
- `source/sh-reports/semantic_layer_v2/validation/example_integration.py`
- `source/sh-reports/semantic_layer_v2/validation/query_validator.py`
- `source/sh-reports/semantic_layer_v2/validation/schema_lookup.py`
- `source/sh-reports/semantic_layer_v2/validation/sql_builder_with_validation.py`

### Core TypeScript API Files (.ts)
- `source/sh-reports/report-api/src/index.ts`
- `source/sh-reports/report-api/src/database.ts`
- `source/sh-reports/report-api/src/relations.ts`
- `source/sh-reports/report-api/src/router.ts`
- `source/sh-reports/report-api/src/builders/dataset.ts`
- `source/sh-reports/report-api/src/controllers/context.ts`
- `source/sh-reports/report-api/src/interfaces/dataset.ts`
- `source/sh-reports/report-api/src/warehouse/index.ts`
- `source/sh-reports/report-api/src/warehouse/redshift/index.ts`
- `source/sh-reports/report-api/src/warehouse/redshift/sql.ts`

## LOW_PRIORITY_FILES

### Configuration Files
- `source/sh-reports/report-api/.dockerignore`
- `source/sh-reports/report-api/.eslintignore`
- `source/sh-reports/report-api/.eslintrc`
- `source/sh-reports/report-api/.gitignore`
- `source/sh-reports/report-api/.gitmodules`
- `source/sh-reports/report-api/.prettierignore`
- `source/sh-reports/report-api/.prettierrc`
- `source/sh-reports/report-api/jest.config.json`
- `source/sh-reports/report-api/newrelic.js`
- `source/sh-reports/report-api/package.json`
- `source/sh-reports/report-api/sonar-project.properties`
- `source/sh-reports/report-api/tsconfig.json`
- `source/sh-reports/report-api/yarn.lock`

### Docker & CI/CD Files
- `source/sh-reports/report-api/Dockerfile`
- `source/sh-reports/report-api/Jenkinsfile`
- `source/sh-reports/report-api/Jenkinsfile_no_sonar`

### Git Hooks
- `source/sh-reports/report-api/git_hooks/copy`
- `source/sh-reports/report-api/git_hooks/pre-push`

### Test Files
- `source/sh-reports/report-api/test/builders/dataset.test.ts`
- `source/sh-reports/report-api/test/controllers/context.test.ts`
- `source/sh-reports/report-api/test/controllers/utils.test.ts`
- `source/sh-reports/report-api/test/controllers/customers/case.ts`
- `source/sh-reports/report-api/test/controllers/customers/constants.test.ts`
- `source/sh-reports/report-api/test/controllers/customers/index.test.ts`
- `source/sh-reports/report-api/test/controllers/loyaltychangelogs/case.ts`
- `source/sh-reports/report-api/test/controllers/loyaltychangelogs/constants.test.ts`
- `source/sh-reports/report-api/test/controllers/loyaltychangelogs/index.test.ts`
- `source/sh-reports/report-api/test/controllers/transactionrecords/case.ts`
- `source/sh-reports/report-api/test/controllers/transactionrecords/contants.test.ts`
- `source/sh-reports/report-api/test/controllers/transactionrecords/index.test.ts`
- `source/sh-reports/report-api/test/warehouse/sql.test.ts`

### Supporting TypeScript Files
- `source/sh-reports/report-api/src/schedulers.ts`
- `source/sh-reports/report-api/src/stats.ts`
- `source/sh-reports/report-api/src/builders/timezone-name-offsets.d.ts`
- `source/sh-reports/report-api/src/controllers/error.ts`
- `source/sh-reports/report-api/src/controllers/stats.ts`
- `source/sh-reports/report-api/src/controllers/utils.ts`
- `source/sh-reports/report-api/src/loaders/business.ts`
- `source/sh-reports/report-api/src/loaders/index.ts`
- `source/sh-reports/report-api/src/loaders/sales.ts`
- `source/sh-reports/report-api/src/loaders/transaction.ts`
- `source/sh-reports/report-api/src/redis/index.ts`
- `source/sh-reports/report-api/src/redis/redis.d.ts`
- `source/sh-reports/report-api/src/utils/request.ts`
- `source/sh-reports/report-api/src/utils/timezones.ts`
- `source/sh-reports/report-api/src/warehouse/redshift/aws-redshift.d.ts`

### Report Controller Files
- All individual controller module files in subdirectories of `source/sh-reports/report-api/src/controllers/`

### Data Processing & Extraction Scripts
- All `.py` files in `source/sh-reports/semantic_layer_v2/data_samples/`
- All validation `.py` files in `source/sh-reports/semantic_layer_v2/validation/`
- Supporting schema extraction scripts in `source/sh-reports/semantic_layer_v2/schema_extraction/`

### Data Files
- All `.csv` files
- All `.log` files  
- All `.txt` files
- All `.json` files not in the HIGH_PRIORITY list
- All `.DS_Store` files

### Shell Scripts
- `source/sh-reports/semantic_layer_v2/validation/quick_schema_check.sh`

---

**TOTAL FILES IDENTIFIED:** 500+ files across the entire project structure  
**HIGH PRIORITY FILES:** ~75 files  
**LOW PRIORITY FILES:** ~425+ files  

**Next Stage:** Exhaustive Analysis (Two-Pass Approach) 