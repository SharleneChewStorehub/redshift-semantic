# StoreHub Semantic Layer for NL-to-SQL

This repository contains the semantic layer that enables Natural Language to SQL translation for StoreHub's reporting system.

## 🚀 Quick Start

**Production semantic layer is in `/semantic_layer_v2/`**

```bash
# Example: Find Malaysian merchants with cigarette products
cd semantic_layer_v2/validation
python schema_lookup.py  # Validate schema first
```

## 📁 Directory Structure

```
sh-reportsapi/
├── semantic_layer_v2/           # ⭐ PRODUCTION - Current semantic layer
│   ├── core/                   # 5 core JSON files
│   ├── validation/             # Schema validation tools
│   ├── profiling/              # Data profiling framework
│   └── debug/                  # Debug queries and examples
│
├── archive/                     # Historical versions (for reference)
│   ├── v1_individual_reports/  # Original per-report approach
│   ├── v1.5_unified_attempt/   # First consolidation attempt
│   └── v1.8_true_dictionary/   # Business glossary approach
│
├── database_schema/             # Database schema documentation
│   ├── storehub-table*.sql     # Schema definitions
│   └── database_schema*.md     # Schema documentation
│
├── report-api/                  # Original TypeScript codebase
│   └── src/controllers/        # 14 report endpoints
│
└── docs/                        # Documentation
    ├── evolution.md            # How we got here
    ├── migration_guide.md      # Upgrading from older versions
    └── totalreports.md         # List of all reports
```

## 🎯 What is the Semantic Layer?

The semantic layer translates natural language queries into accurate SQL by providing:

1. **Data Catalog** - Maps business concepts to database tables/fields
2. **Business Rules** - Enforces constraints and multi-tenant safety
3. **Query Patterns** - Reusable SQL templates for common needs
4. **Semantic Context** - Handles natural language ambiguity
5. **Query Cookbook** - Complete worked examples

## 💡 Key Features

- **Answer NEW questions** - Not limited to predefined reports
- **Schema validation** - Catches errors before running SQL
- **Multi-tenant safe** - Automatic business isolation
- **Performance optimized** - Uses best data sources
- **LLM-ready** - Designed for AI consumption

## 📖 Documentation

- **[Evolution Guide](docs/evolution.md)** - Journey from v1 to v2
- **[Migration Guide](docs/migration_guide.md)** - Upgrade from older versions
- **[Semantic Layer README](semantic_layer_v2/README.md)** - Detailed v2 documentation

## 🛠️ Usage Example

```python
# 1. Validate schema
from semantic_layer_v2.validation.schema_lookup import SchemaLookup
lookup = SchemaLookup(['database_schema/storehub-table1.sql'])

# 2. Build validated SQL
from semantic_layer_v2.validation.sql_builder_with_validation import ValidatedSQLBuilder
builder = ValidatedSQLBuilder(schema_files, 'semantic_layer_v2')
query = builder.build_cigarette_query()

# 3. Use semantic context for NL
import json
with open('semantic_layer_v2/core/semantic_context.json') as f:
    context = json.load(f)
```

## 🔍 Finding Things

- **Current production files**: `/semantic_layer_v2/core/`
- **Schema information**: `/database_schema/`
- **Historical implementations**: `/archive/`
- **Debug queries**: `/semantic_layer_v2/debug/`

## ⚠️ Important Notes

1. Always use `semantic_layer_v2` - it's the production version
2. Validate schemas before generating SQL
3. Include mandatory business filters for multi-tenant safety
4. Check the cookbook for examples

## 🚀 Next Steps

1. Explore the [5 core files](semantic_layer_v2/core/)
2. Try the [validation tools](semantic_layer_v2/validation/)
3. Review [example queries](semantic_layer_v2/debug/)
4. Read about the [evolution](docs/evolution.md)

---

For questions or improvements, please contribute to the semantic_layer_v2!