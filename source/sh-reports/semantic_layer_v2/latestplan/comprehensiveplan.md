# 🚀 Comprehensive Semantic Layer Development Plan

## 🎯 **Mission Statement**

Build a production-ready semantic layer that enables accurate Natural Language to SQL translation for StoreHub's merchant reporting system. The semantic layer will bridge the gap between how business users ask questions and how data is stored, focusing on the 172 tables that are visible in Metabase and contain actual data.

## 📊 **Current State Assessment**

### **Data Sources Available**
1. **Database Schema**: 172 tables with data (6.2 billion rows total) - see `172tables.md`
2. **Sample Data**: 100+ records per table for ALL 172 tables (to be downloaded)
3. **Reports API**: 14 proven business endpoints (in `report-api/src/controllers/`)
4. **Metabase Questions**: 1,502 real user questions (1,301 SQL + 201 GUI) (in 'metabase_questions/slim_questions.json')

### **Current Semantic Layer (v2.0)**
Located in `semantic_layer_v2/core/`:
- `data_catalog.json` - Business entities → database mapping
- `business_rules.json` - Constraints and business logic
- `query_patterns.json` - Reusable SQL templates
- `semantic_context.json` - Natural language understanding
- `query_cookbook.json` - Complete worked examples

### **Key Intelligence Already Gathered**
✅ **LLM Analysis Complete**: Comprehensive analysis of 1,502 Metabase questions revealing:
- Multi-tenant security patterns (89% of queries use business isolation)
- Channel hierarchy and business logic
- Workflow intelligence (monitoring → investigation → comparison → action)
- Performance bottlenecks (UTC+8 timezone conversion in 41% of queries)

✅ **Table Validation Complete**: Comprehensive validation identified 172 tables with actual data:
- 6.2 billion rows across 172 production tables
- Complete inventory with row counts in `172tables.md`
- Tables organized by category (Transactions, Products, Payments, etc.)
- Top priority: transaction-related tables containing 5.6B rows

✅ **Data Patterns Discovered**:
- Denormalization pattern: `transactionrecords__pickupinformation__store` is a snapshot of `businesses__stores`
- Nested table structure: Double underscore (`__`) separates parent and child tables
- Column naming: `products.title` (not `name`), `businesses__stores.isdeleted` (not `businesses.isdeleted`)
- Schema prefix required: `storehub_mongo.tablename` for all queries

🆕 **New Capability - Comprehensive Sample Data**:
With samples from all 172 tables, we can now:
- Validate actual enum values and data distributions
- Discover data quality issues across all tables
- Verify foreign key relationships with real data
- Extract business logic patterns from actual values
- Build accurate value mappings for every field

## 🎯 **Core Development Strategy**

### **Phase 1: Foundation Validation (Week 1)**

#### **1.1 Complete Table Inventory** ✅ **COMPLETED**
**Objective**: Document all 172 tables that contain production data for comprehensive semantic layer coverage

**Completed Analysis**: See `172tables.md` for full inventory

#### **1.2 Comprehensive Sample Data Collection** 🆕 **NEW TASK**
**Objective**: Download 100+ sample records for all 172 tables

**Script**: `sample_data_downloader.py`
```python
def download_all_samples():
    """Download sample data for all 172 tables"""
    
    # 1. Load table list from 172tables.md
    tables = load_172_tables_with_categories()
    
    # 2. For each table, download samples
    for table in tables:
        sample_data = download_table_samples(
            table_name=table['name'],
            sample_size=100,  # Or more for smaller tables
            include_empty_check=True,
            include_distinct_counts=True
        )
        
        # 3. Analyze and save
        save_sample_with_metadata(table, sample_data)
    
    return {
        'tables_sampled': 172,
        'total_records': sum(samples),
        'enum_candidates': identify_enum_columns(),
        'data_quality_insights': analyze_sample_quality()
    }
```
```python
def get_table_priorities():
    """Load the 172 validated tables with their row counts and categories"""
    
    # 1. Load 172 validated tables from 172tables.md
    validated_tables = load_validated_tables_with_row_counts()
    
    # 2. Tables are already validated and categorized
    # No need to query - we have comprehensive row counts
        
    # 3. Categorize tables (VALIDATED RESULTS)
    return {
        'total_tables': 172,               # All production tables
        'total_rows': 6_212_891_851,       # 6.2 billion rows
        'by_category': {                   # Tables grouped by business domain
            'Transactions': 29,            # 5.6B rows
            'Products': 11,                # 106M rows
            'Payments': 14,                # 137M rows
            'Inventory': 7,                # 24M rows
        }
        'coverage_approach': 'comprehensive',  # All 172 tables
        'largest_tables': [                    # For performance optimization
            'transactionrecords__items',       # 2.4B rows
            'transactionrecords__payments',    # 984M rows
            'transactionrecords',              # 971M rows
        ]
    }
```

**Expected Outcome**: 
- ✅ **VALIDATED**: 172 tables in Metabase contain 6.2 billion rows of production data
- Comprehensive coverage: All 172 tables will be included in semantic layer
- Performance focus on largest tables:
  - `transactionrecords__items` (2.4B rows)
  - `transactionrecords__payments` (984M rows) 
  - `transactionrecords` (971M rows)
  - `transactionrecords__items__selectedoptions` (956M rows)
**Key Finding**: With only 172 tables to cover, we can build a comprehensive semantic layer that handles ALL production data (6.2B rows), with special performance optimizations for the billion-row tables.

#### **1.3 Entity Documentation and Mapping**
**Objective**: Document comprehensive entity definitions using available data sources

**Approach**: Comprehensive analysis with full sample data
```
For each of the 172 tables:
1. Schema definition from database_schema/ (available for all)
2. Sample data analysis (100+ records for ALL 172 tables)
3. API implementations (where available)
4. Query patterns from Metabase SQL (extract from 1,502 questions)

Output: Rich entity documentation including:
- Complete column catalog with data types
- Actual value distributions and patterns
- Data quality insights (nulls, empty strings, outliers)
- Foreign key relationships validated with data
- Business meaning derived from actual values
- Common query patterns
```

**Script Support**: `entity_synthesizer.py`
```python
class EntitySynthesizer:
    def synthesize_entity(self, entity_name):
        # 1. Schema structure
        schema_def = self.schema_analyzer.get_table_definition(entity_name)
        
        # 2. Sample data patterns
        sample_patterns = self.sample_analyzer.analyze_data_patterns(entity_name)
        
        # 3. API business logic
        api_logic = self.api_analyzer.extract_entity_logic(entity_name)
        
        # 4. Synthesize comprehensive definition
        return self.create_unified_definition(
            schema_def, sample_patterns, api_logic
        )
```

#### **1.4 Business Rules Documentation**
**Objective**: Document enforceable constraints and business logic (not usage patterns)

**Focus Areas**:
```python
def document_business_rules():
    """Extract ACTUAL business rules, not patterns"""
    
    return {
        "multi_tenant_rules": {
            # Which tables require business isolation
            "requires_business_filter": identify_tables_with_business_column(),
            "shared_tables": identify_global_lookup_tables()
        },
        
        "data_validation_rules": {
            # From schema constraints and API validations
            "required_fields": extract_not_null_constraints(),
            "value_constraints": extract_check_constraints(),
            "valid_enums": extract_enum_values_from_all_172_tables()
        },
        
        "sql_dialect_constraints": {
            # Redshift-specific limitations
            "unsupported_functions": document_redshift_limitations(),
            "json_patterns": document_json_field_access()
        },
        
        "business_logic": {
            # From API implementations
            "currency_handling": extract_currency_rules(),
            "tax_calculations": extract_tax_logic(),
            "status_transitions": extract_valid_transitions()
        }
    }
```

### **Phase 2: Core File Enhancement (Week 2)**

#### **2.1 Data Catalog Builder**
**Objective**: Build authoritative business entity → database mapping

**LLM Task**: Complete catalog for all 172 tables
```
Prompt: "Using the 172tables.md inventory and multi-source entity analysis, 
create comprehensive data_catalog.json entries for ALL 172 production tables.

For each entity, include:
- Physical schema mapping (table.column → business concept)
- Relationship patterns (proven join paths from Metabase)
- Key metrics (calculations used in Reports API)
- Performance hints (based on Metabase query patterns)
- Regional variations (from sample data analysis)"
```

**Script Support**: `data_catalog_builder.py`
```python
def build_data_catalog():
    """Build comprehensive data catalog from all sources"""
    
    # 1. Get all 172 validated tables
    all_tables = load_validated_tables_from_172tables_md()
    
    # 2. For each table, build comprehensive entity
    entities = {}
    for table in all_tables:
        entity = {
            'schema_mapping': get_schema_mapping(table),
            'sample_data_insights': analyze_sample_data(table),  # Rich insights from 100+ records
            'api_business_logic': get_api_logic(table),
            'relationships': discover_relationships(table),
            'performance_hints': analyze_performance_patterns(table)
        }
        entities[table] = entity
    
    return {
        'version': '2.1.0',
        'validation_date': datetime.now().isoformat(),
        'source_data_validation': load_table_usage_validation(),
        'business_entities': entities
    }
```

#### **2.2 Query Patterns Validation & Enhancement**
**Objective**: Build proven query patterns from cross-source validation

**Script**: `query_pattern_prover.py`
```python
def prove_query_pattern(pattern_name):
    """Validate and enhance query patterns from multiple sources"""
    
    # 1. Find pattern implementation in Reports API
    api_implementation = find_api_pattern_implementation(pattern_name)
    
    # 2. Find usage examples in Metabase
    metabase_examples = find_metabase_pattern_examples(pattern_name)
    
    # 3. Validate against schema reality
    schema_validation = validate_pattern_against_schema(pattern_name)
    
    # 4. Test with sample data
    sample_data_test = test_pattern_with_samples(pattern_name)
    
    # 5. Calculate pattern confidence
    confidence = calculate_pattern_confidence([
        api_implementation, metabase_examples, 
        schema_validation, sample_data_test
    ])
    
    return {
        'pattern_name': pattern_name,
        'confidence_score': confidence,
        'example_count': len(metabase_examples),
        'api_proven': bool(api_implementation),
        'schema_valid': schema_validation,
        'sample_tested': sample_data_test,
        'sql_template': generate_validated_template(pattern_name),
        'business_use_cases': extract_use_cases(metabase_examples)
    }
```

#### **2.3 Value Mappings Documentation**
**Objective**: Document valid enum values and mappings from available data

**Approach**: Focus on actual enums found in data
```python
def extract_comprehensive_value_mappings():
    """Extract actual enum values from ALL 172 tables' sample data"""
    
    # 1. Extract distinct values from ALL 172 tables
    all_enums = {}
    for table in all_172_tables:
        table_enums = extract_distinct_values(table)
        all_enums[table] = table_enums
    
    # 2. Identify true enums (limited distinct values)
    true_enums = identify_enum_columns(all_enums)
    
    # 3. Build comprehensive mappings
    return {
        'discovered_enums': true_enums,
        'value_distributions': calculate_value_frequencies(),
        'cross_table_mappings': find_shared_enum_patterns(),
        'data_quality_flags': identify_inconsistent_values()
    }
```

### **Phase 3: Semantic Intelligence (Week 3)**

#### **3.1 Natural Language Understanding Enhancement**
**Objective**: Build sophisticated semantic context from real user language

**LLM Task**: User language pattern analysis
```
Prompt: "Analyze the 1,502 Metabase question names to extract:

1. Intent patterns: How users phrase different types of analytical questions
2. Business vocabulary: Terms users actually use vs technical database terms
3. Ambiguity patterns: When the same phrase could mean different things
4. Regional language variations: How Malaysian vs Singapore users phrase questions
5. Temporal expressions: How users express time periods and comparisons

Build semantic_context.json with sophisticated disambiguation rules."
```

**Script Support**: `semantic_context_builder.py`
```python
def build_semantic_context():
    """Build sophisticated semantic understanding from user language"""
    
    # 1. Analyze question names for intent patterns
    intent_patterns = analyze_question_intent_patterns()
    
    # 2. Extract business vocabulary mappings
    vocabulary_mappings = extract_business_vocabulary()
    
    # 3. Identify ambiguity patterns
    ambiguity_rules = identify_ambiguity_patterns()
    
    # 4. Analyze temporal expressions
    temporal_patterns = analyze_temporal_expressions()
    
    # 5. Build context intelligence
    return {
        'intent_detection': intent_patterns,
        'vocabulary_mappings': vocabulary_mappings,
        'ambiguity_resolution': ambiguity_rules,
        'temporal_understanding': temporal_patterns,
        'regional_variations': analyze_regional_language_patterns(),
        'workflow_intelligence': extract_workflow_patterns()
    }
```

#### **3.2 Query Cookbook Development**
**Objective**: Create comprehensive worked examples from real usage

**Script**: `query_cookbook_builder.py`
```python
def build_query_cookbook():
    """Build comprehensive cookbook from real-world examples"""
    
    # 1. Select representative examples from Metabase
    representative_examples = select_cookbook_examples()
    
    # 2. For each example, create complete worked solution
    cookbook_entries = []
    for example in representative_examples:
        entry = {
            'natural_language': example.question_name,
            'business_context': analyze_business_context(example),
            'semantic_parsing': show_semantic_parsing_steps(example),
            'sql_generation': show_sql_generation_process(example),
            'final_sql': example.sql,
            'explanation': generate_step_by_step_explanation(example),
            'variations': find_similar_questions(example),
            'troubleshooting': identify_common_issues(example)
        }
        cookbook_entries.append(entry)
    
    return {
        'version': '2.1.0',
        'examples_by_pattern': group_by_pattern(cookbook_entries),
        'examples_by_business_function': group_by_business_function(cookbook_entries),
        'debugging_guide': create_debugging_guide(cookbook_entries),
        'coverage_analysis': analyze_pattern_coverage(cookbook_entries)
    }
```

### **Phase 4: Production Integration & Testing (Week 4)**

#### **4.1 Comprehensive Validation System**
**Objective**: Ensure semantic layer handles real-world usage

**Script**: `semantic_layer_validator.py`
```python
class SemanticLayerValidator:
    def validate_against_metabase_questions(self):
        """Test semantic layer against all 1,502 Metabase questions"""
        
        results = {
            'total_questions': 1502,
            'successfully_parsed': 0,
            'sql_generated': 0,
            'sql_validated': 0,
            'business_rules_applied': 0,
            'performance_acceptable': 0
        }
        
        for question in self.load_metabase_questions():
            try:
                # 1. Parse natural language
                parsed = self.semantic_engine.parse_intent(question.name)
                results['successfully_parsed'] += 1
                
                # 2. Generate SQL (with correct schema)
                sql = self.semantic_engine.generate_sql(parsed)
                # Ensure: products.title (not products.name)
                # Ensure: storehub_mongo.businesses (not just businesses)
                # Ensure: businesses__stores.isdeleted (not businesses.isdeleted)
                results['sql_generated'] += 1
                
                # 3. Validate SQL syntax and schema
                if self.validator.validate_sql(sql):
                    results['sql_validated'] += 1
                
                # 4. Check business rules compliance
                if self.check_business_rules_compliance(sql):
                    results['business_rules_applied'] += 1
                
                # 5. Performance check
                if self.check_performance(sql):
                    results['performance_acceptable'] += 1
                    
            except Exception as e:
                self.log_validation_error(question, e)
        
        return results
    
    def validate_against_reports_api(self):
        """Ensure semantic layer can reproduce Reports API functionality"""
        
        for endpoint in self.load_reports_api_endpoints():
            # 1. Convert endpoint logic to natural language question
            nl_question = self.convert_endpoint_to_nl(endpoint)
            
            # 2. Generate SQL using semantic layer
            semantic_sql = self.semantic_engine.translate_to_sql(nl_question)
            
            # 3. Compare with original endpoint SQL
            original_sql = self.extract_endpoint_sql(endpoint)
            
            # 4. Validate results match
            results_match = self.compare_query_results(semantic_sql, original_sql)
            
            if not results_match:
                self.log_api_validation_error(endpoint, semantic_sql, original_sql)
        
        return self.generate_api_validation_report()
```

#### **4.2 Production Deployment Preparation**
**Objective**: Prepare for production deployment

**Components**:
1. **Configuration Management**: Environment-specific configurations
2. **Error Handling**: Graceful degradation strategies  
3. **Documentation**: Complete API documentation
4. **Security**: Multi-tenant isolation enforcement
5. **Testing**: Comprehensive test suite

## 📊 **Success Metrics & Quality Gates**

### **Phase 1 Success Criteria**
- [x] Table validation complete - 172 production tables identified (see `172tables.md`)
- [ ] Sample data downloaded for all 172 tables (100+ records each)
- [ ] Build semantic layer coverage for all 172 tables
- [ ] Cross-source entity synthesis for all 172 tables (with sample data)
- [ ] Business rules documented (enforceable constraints, not patterns)
- [ ] Multi-tenant isolation rules verified for all tables

### **Phase 2 Success Criteria**
- [ ] Data catalog covers all 172 tables with production data
- [ ] Query patterns proven by cross-source validation
- [ ] Value mappings extracted with confidence scores
- [ ] All core JSON files enhanced with multi-source intelligence
- [ ] Handle nested table structures (e.g., businesses__stores, transactionrecords__items)

### **Phase 3 Success Criteria**
- [ ] Semantic context handles 95% of user language patterns
- [ ] Query cookbook covers top 50 use cases
- [ ] Natural language understanding with ambiguity resolution
- [ ] Regional and workflow intelligence implemented

### **Phase 4 Success Criteria**
- [ ] 90% of Metabase questions successfully parsed
- [ ] 85% of generated SQL validates against schema
- [ ] 100% business rules compliance
- [ ] Reports API functionality reproducible
- [ ] Performance <2 seconds for 80% of queries

## 🎯 **Resource Requirements & Timeline**

### **Week 1: Foundation (40 hours)**
- LLM Analysis: 15 hours
- Script Development: 20 hours  
- Cross-validation: 5 hours

### **Week 2: Core Enhancement (40 hours)**
- LLM Tasks: 15 hours
- Script Development: 20 hours
- Integration Testing: 5 hours

### **Week 3: Intelligence (35 hours)**
- LLM Tasks: 15 hours
- Script Development: 15 hours
- Quality Assurance: 5 hours

### **Week 4: Production (40 hours)**
- Validation Systems: 20 hours
- Performance Optimization: 10 hours
- Deployment Preparation: 10 hours

**Total: 155 hours (4 weeks)**

## 🚀 **Expected Outcomes**

### **Technical Deliverables**
1. **Production-ready semantic layer** with 5 enhanced JSON files covering all 172 tables
2. **Comprehensive validation system** ensuring accuracy against Metabase questions
3. **Complete documentation** and deployment guides

### **Business Impact**
1. **90% query coverage** - Handle vast majority of business questions
2. **50% faster insights** - Reduce time from question to answer
3. **Self-service analytics** - Enable business users to answer own questions
4. **Reduced SQL development** - 80% fewer ad-hoc query requests

### **Quality Assurance**
1. **Multi-source validation** ensures accuracy
2. **Real-world testing** against 1,502 actual questions
3. **Performance optimization** for production workloads
4. **Security enforcement** with 100% multi-tenant compliance

This comprehensive plan leverages both LLM intelligence for pattern recognition and systematic scripting for validation and automation, ensuring our semantic layer is built on solid foundations while remaining current with evolving business needs.