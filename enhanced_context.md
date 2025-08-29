# Enhanced Context for Redshift Semantic Layer

*Distilled from 6 semantic framework files - core business entities, metrics, and relationships*

## Entities/Tables

### Core Transaction & Revenue
- **storehub_mongo.transactionrecords**: Revenue-generating transactions including sales and returns
  - *Synonyms*: sales transactions, revenue records, transaction data
- **storehub_mongo.transaction_items**: Individual line items within each transaction
  - *Synonyms*: line items, transaction details, purchase items
- **storehub_mongo.gatewayrecords**: Payment processing and settlement tracking (10.2M records)
  - *Synonyms*: payment gateway, settlement records, payment processing

### Customer & Loyalty
- **storehub_mongo.customers**: Customer profiles and behavior tracking
  - *Synonyms*: customer profiles, customer data, client records
- **storehub_mongo.loyaltychangelogs**: Comprehensive loyalty points system (54.5M records)
  - *Synonyms*: loyalty transactions, points history, reward activity

### Product & Inventory
- **storehub_mongo.products**: Product catalog and performance data
  - *Synonyms*: product catalog, inventory items, SKU data
- **storehub_mongo.inventories**: Stock level tracking and management
  - *Synonyms*: stock levels, inventory tracking, stock management

### Business & Operations
- **storehub_mongo.businesses**: Merchant business profiles and configuration
  - *Synonyms*: merchants, business profiles, store operators
- **storehub_mongo.businesses__stores**: Individual store locations and settings
  - *Synonyms*: store locations, outlets, shop branches
- **storehub_mongo.employees**: Staff members and their access permissions
  - *Synonyms*: staff members, team members, workers

### Marketing & Promotions
- **storehub_mongo.promotions**: Discount and promotion management
  - *Synonyms*: discounts, offers, promotional campaigns
- **storehub_mongo.campaigns**: Customer messaging and campaign management
  - *Synonyms*: marketing campaigns, messaging, customer communications
- **storehub_mongo.vouchers**: Voucher creation and redemption tracking
  - *Synonyms*: coupons, voucher codes, redemption tracking

### Financial Operations
- **storehub_mongo.payoutitems**: Payment processing and payout management
  - *Synonyms*: payouts, settlements, financial reconciliation
- **storehub_mongo.businesses__paymentoptions**: Payment method configuration
  - *Synonyms*: payment methods, payment config, payment setup

### Operational Management
- **storehub_mongo.orderlogs**: Complete order lifecycle tracking
  - *Synonyms*: order status, order tracking, order management
- **storehub_mongo.stocktakes**: Physical inventory count and variance tracking
  - *Synonyms*: inventory counts, stock audits, physical counts
- **storehub_mongo.suppliers**: Supplier relationships and procurement
  - *Synonyms*: vendor management, supplier data, procurement

## Fields (Dimensions & Metrics)

### Part A: Key Dimensions

#### Transaction Records
- **createdtime**: Transaction timestamp (UTC, requires timezone conversion)
- **type**: Transaction type ('Sale', 'Return')
- **channel**: Sales channel (0=POS, 1=Online, 3=QR Order, 10=GrabFood, 11=ShopeeFood, 12=FoodPanda, 13=Beep)
- **storeid**: Store identifier for location analysis
- **customerid**: Customer identifier (nullable for walk-in sales)
- **receiptnumber**: Unique transaction identifier
- **subtotal**: Amount before tax and service charges
- **discount**: Discount amount applied
- **tax**: Tax amount collected
- **service_charge**: Service charge applied
- **totalamount**: Final transaction amount
- **business**: Business identifier (CRITICAL: required for all queries)

#### Customers
- **phone**: Primary customer identifier
- **firstname, lastname**: Customer name components
- **email**: Email address (optional)
- **points**: Current loyalty points balance
- **totalSpend**: Pre-calculated lifetime value
- **transactionCount**: Pre-calculated transaction count
- **lastTransactionTime**: Last purchase timestamp
- **createdtime**: Customer registration date

#### Products
- **name**: Product name
- **pricetype**: Pricing model ('fixed', 'variable')
- **tags**: Comma-separated tags for categorization
- **isongrabfood, isonshopeefood, etc.**: Platform availability flags
- **cost**: Product cost for margin calculations

#### Businesses
- **businesstype**: Business category ('retail', 'cafe', 'restaurant')
- **country**: ISO country code (MY, CN, TH, SG, PH, KE, BD)
- **currency**: ISO currency code (MYR, CNY, THB, SGD, PHP, KES, BDT)
- **subscriptionstatus**: Account status ('Active', 'Trial', 'Expired')
- **timezone**: Business timezone for date calculations

### Part B: Critical Metrics

#### Revenue Metrics
- **net_sales**: Sales after returns and discounts
  - *Definition*: "Revenue after deducting returns and discounts"
  - *SQL*: `SUM(CASE WHEN type='Sale' THEN subtotal-discount WHEN type='Return' THEN -ABS(subtotal) ELSE 0 END)`

- **gross_sales**: Total sales before any deductions
  - *Definition*: "Total sales revenue before returns and discounts"
  - *SQL*: `SUM(subtotal) WHERE type = 'Sale'`

- **average_transaction_value**: Average sale amount per transaction
  - *Definition*: "Average revenue per sale transaction"
  - *SQL*: `SUM(totalamount) / COUNT(DISTINCT receiptnumber) WHERE type = 'Sale'`

#### Customer Metrics
- **active_customers**: Customers with recent purchases
  - *Definition*: "Customers with transactions in last 90 days"
  - *SQL*: `COUNT(DISTINCT customerid) WHERE lastTransactionTime >= CURRENT_DATE - INTERVAL '90 days'`

- **customer_lifetime_value**: Total customer spend
  - *Definition*: "Total amount spent by customer across all transactions"
  - *SQL*: `SUM(totalamount) GROUP BY customerid WHERE type = 'Sale'`

- **new_customers**: First-time customers in period
  - *Definition*: "Customers making their first purchase in the specified period"
  - *SQL*: `COUNT(*) WHERE createdtime BETWEEN :start_date AND :end_date`

#### Loyalty Metrics
- **points_earned**: Total loyalty points earned
  - *Definition*: "Total loyalty points earned by customers"
  - *SQL*: `SUM(amount) FROM loyaltychangelogs WHERE eventtype = 'earned'`

- **points_expired**: Total loyalty points expired
  - *Definition*: "Total loyalty points lost to expiration"
  - *SQL*: `SUM(ABS(amount)) FROM loyaltychangelogs WHERE eventtype = 'expired'`

#### Payment Gateway Metrics
- **gateway_fee_total**: Total payment processing fees
  - *Definition*: "Total fees charged by payment processors"
  - *SQL*: `SUM(ABS(fee)) FROM gatewayrecords`

- **gateway_success_rate**: Percentage of successful transactions
  - *Definition*: "Percentage of payment transactions that completed successfully"
  - *SQL*: `COUNT(*) FILTER (WHERE transferstatus = 'success') * 100.0 / COUNT(*) FROM gatewayrecords`

#### Inventory Metrics
- **current_stock**: Current quantity on hand
  - *Definition*: "Current inventory quantity available for sale"
  - *SQL*: `SUM(quantityonhand) FROM inventories`

- **low_stock_items**: Items below restock level
  - *Definition*: "Products that need restocking based on defined thresholds"
  - *SQL*: `COUNT(*) FROM inventories WHERE quantityonhand <= restocklevel`

#### Transaction Count Metrics
- **transaction_count**: Number of sales transactions
  - *Definition*: "Count of unique sale transactions"
  - *SQL*: `COUNT(DISTINCT receiptnumber) WHERE type = 'Sale'`

- **units_sold**: Total product units sold
  - *Definition*: "Total quantity of products sold across all transactions"
  - *SQL*: `SUM(quantity) FROM transaction_items`

## Relationships/Joins

### Core Transaction Relationships
- **From**: storehub_mongo.transactionrecords.customerid
- **To**: storehub_mongo.customers._id
- **Type**: many-to-one (nullable for walk-in sales)

- **From**: storehub_mongo.transactionrecords.storeid
- **To**: storehub_mongo.businesses__stores._id
- **Type**: many-to-one

- **From**: storehub_mongo.transactionrecords.receiptnumber
- **To**: storehub_mongo.transaction_items.transactionid
- **Type**: one-to-many

### Product Relationships
- **From**: storehub_mongo.transaction_items.productid
- **To**: storehub_mongo.products._id
- **Type**: many-to-one

### Loyalty Relationships
- **From**: storehub_mongo.loyaltychangelogs.customerid
- **To**: storehub_mongo.customers._id
- **Type**: many-to-one

### Business Hierarchy
- **From**: storehub_mongo.businesses__stores.business
- **To**: storehub_mongo.businesses.business
- **Type**: many-to-one

### Order Management
- **From**: storehub_mongo.orderlogs.receiptnumber
- **To**: storehub_mongo.transactionrecords.receiptnumber
- **Type**: one-to-many

### Inventory Relationships
- **From**: storehub_mongo.inventories.productid
- **To**: storehub_mongo.products._id
- **Type**: one-to-one

## Critical Enums & Value Mappings

### Transaction Enums
- **type**: `'Sale'` (positive revenue, decreases inventory) | `'Return'` (negative revenue, increases inventory)
- **channel**: `0` (POS) | `1` (Online Store) | `3` (QR Order) | `10` (GrabFood) | `11` (ShopeeFood) | `12` (FoodPanda) | `13` (Beep)

### Geographic Enums
- **country**: `'MY'` (Malaysia) | `'CN'` (China) | `'TH'` (Thailand) | `'SG'` (Singapore) | `'PH'` (Philippines) | `'KE'` (Kenya) | `'BD'` (Bangladesh)
- **currency**: `'MYR'` (RM) | `'CNY'` (¥) | `'THB'` (฿) | `'SGD'` (S$) | `'PHP'` (₱) | `'KES'` (KSh) | `'BDT'` (৳)

### Business Enums
- **businesstype**: `'retail'` | `'cafe'` | `'restaurant'` | `''` (unspecified) *Note: 'Retail' normalizes to 'retail'*
- **subscriptionstatus**: `'Active'` | `'Trial'` | `'Expired'` | `''` (no subscription)

### Payment & Financial Enums
- **paymentgateway**: `'stripe'` (online international) | `'offline'` (manual processing)
- **transferstatus**: `'success'` | `'pending'` | `'failed'`
- **payoutstatus**: `'pending'` | `'completed'`
- **reconciliationstatus**: `'pending'` | `'passed'`

### Product & Pricing Enums
- **pricetype**: `'fixed'` (88%, no modification allowed) | `'variable'` (12%, modification allowed)
- **itemtype**: `''` (product item, affects inventory) | `'ServiceCharge'` (fee, no inventory impact)

### Loyalty System Enums
- **eventtype**: `'earned'` (+points from purchases) | `'expired'` (-points from time limit) | `'expense'` (-points spent) | `'return'` (-points from returns)
- **source**: `'REGISTER'` (POS transactions) | `'QR_ORDERING'` (self-service) | `'RECEIPT'` (manual claim)
- **rewardtype**: `'cashback'` (monetary) | `'points'` (virtual) | `''` (unspecified)

### Employee Access Enums
- **Access Levels**: `'manageraccess'` (level 3, full) | `'backofficeaccess'` (level 2, admin) | `'limitbackofficeaccess'` (level 1.5, restricted) | `'cashieraccess'` (level 1, POS only)

### Order Management Enums
- **Order Status Flow**: `'pendingPayment'` → `'paid'` → `'accepted'` → `'confirmed'` → `'logisticsConfirmed'` → `'pickedUp'` → `'delivered'` | `'cancelled'`
- **operator**: `'system'` (automated) | `'customer'` (manual)

### Tax System Enums
- **taxcode**: `'SR'` (Malaysia standard rate) | `'VAT'` (Thailand/Philippines VAT) | `'BIR'` (Philippines) | `'GST'` (Singapore) | `'ZR'` (zero-rated) | `'TX'` (tax exempt)

### Promotion & Marketing Enums
- **promotion type**: `'merchant'` (99%, business-specific) | `'universal'` (1%, platform-wide)
- **voucher status**: `'unused'` (active, can redeem) | `'used'` (redeemed) | `'expired'` (cannot redeem)
- **campaign status**: `'completed'` | `'failed'` | `'pending'` | `'processing'`

### Device & Platform Enums
- **platform**: `'android'` | `'ios'` | `'Android'` | `'iOS'` | `'RN-iOS'` (React Native)
- **pushplatform**: `'FCM'` (Firebase/Google) | `'HMS'` (Huawei) | `'IOS'` (Apple)
