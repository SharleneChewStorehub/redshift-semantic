#!/bin/bash
# Quick schema check before writing SQL

echo "=== Quick Schema Reference ==="
echo ""
echo "To find a table:"
echo "grep \"'storehub_mongo','TABLENAME'\" storehub-table*.sql | head -5"
echo ""
echo "To find columns in a table:"
echo "grep \"'storehub_mongo','products','\" storehub-table*.sql | grep -v '__' | head -20"
echo ""
echo "Common tables:"
echo "- storehub_mongo.businesses"
echo "- storehub_mongo.products (note: name column is 'title')"
echo "- storehub_mongo.transactionrecords"
echo "- storehub_mongo.customers"
echo "- storehub_mongo.transaction_items"
echo ""
echo "Always use lowercase for column names!"