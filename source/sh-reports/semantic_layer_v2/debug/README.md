# Debug Queries

This directory contains debug queries created during the development and testing of the semantic layer v2.

## cigarette_queries/

Contains various iterations of queries for finding Malaysian merchants selling cigarette products. These queries demonstrate:

- Schema validation issues discovered (e.g., businesses.isdeleted doesn't exist)
- Join debugging between businesses and products tables
- SQL dialect issues (STRING_AGG with DISTINCT not supported in Redshift)
- Progressive refinement from initial query to working solution

These queries are preserved as learning examples for:
1. How to debug join issues
2. Common schema assumptions that need validation
3. SQL dialect compatibility considerations
4. Iterative query development process