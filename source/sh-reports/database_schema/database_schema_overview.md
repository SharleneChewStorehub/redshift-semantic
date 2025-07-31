# StoreHub MongoDB Database Schema Analysis

## Overview Statistics

- Total Tables: 449
- Total Columns: 4408
- Main Tables: 125
- Nested Tables: 218
- Staging Tables: 106

## Table Categories by Business Domain

- Other: 158 tables
- Commerce: 134 tables
- Logistics: 47 tables
- Business Management: 35 tables
- Inventory: 32 tables
- Marketing & Loyalty: 32 tables
- Customer Management: 11 tables

## Data Types Distribution

- character varying: 2412 columns
- timestamp without time zone: 802 columns
- double precision: 707 columns
- boolean: 361 columns
- numeric: 126 columns

## Main Tables Overview


### Commerce & Transactions
- **customtransactionfeerates** (5 columns)
- **data_analysis.business_first_transaction_time** (4 columns)
- **orderlogs** (11 columns)
- **purchaseorders** (20 columns)
- **receipttemplates** (16 columns)
- **shifts** (36 columns)
- **shiftsnapshots** (12 columns)
- **subscriptionorders** (22 columns)
- **thirdpartyonlineorders** (6 columns)
- **transactionloyalties** (6 columns)
- **transactionrecords** (132 columns)
  - Key columns:
    - _id (character varying)
    - addonbircompliance.athleteandcoachdiscount (double precision)
    - addonbircompliance.collectedinfo (character varying)
    - addonbircompliance.discounttype (character varying)
    - addonbircompliance.medalofvalordiscount (double precision)
    - addonbircompliance.soloparentdiscount (double precision)
    - amusementtax (double precision)
    - appversion (character varying)
    - business (character varying)
    - cancelledat (timestamp without time zone)
    - ... and 122 more columns
- **transactionrecordwithduplicatedids** (83 columns)
- **transactionstatistics** (7 columns)

### Customer Management
- **consumerfavoritestores** (8 columns)
- **consumers** (22 columns)
- **customerpoints** (13 columns)
- **customers** (53 columns)
  - Key columns:
    - _id (character varying)
    - birthday (timestamp without time zone)
    - business (character varying)
    - cashbackclaimcnt (double precision)
    - cashbackexpirationdate (timestamp without time zone)
    - city (character varying)
    - consumerid (character varying)
    - createdatstoreid (character varying)
    - createdtime (timestamp without time zone)
    - customerid (character varying)
    - ... and 43 more columns
- **membershiptiers** (11 columns)
- **promotioncustomers** (19 columns)
- **stripecustomers** (7 columns)
- **useractionlogs** (12 columns)
- **userjobs** (11 columns)

### Product & Inventory
- **inventorychangeevents** (24 columns)
- **inventorymanualupdatelogs** (13 columns)
- **products** (67 columns)
  - Key columns:
    - _id (character varying)
    - barcode (character varying)
    - beforegstadjustment (character varying)
    - business (character varying)
    - category (character varying)
    - classificationcode (character varying)
    - cost (numeric)
    - createdtime (timestamp without time zone)
    - data_modified_time (timestamp without time zone)
    - deletedbarcode (character varying)
    - ... and 57 more columns
- **qboproductsmappings** (4 columns)
- **stockreturns** (20 columns)
- **stocktakeitems** (6 columns)
- **stocktakes** (19 columns)
- **stocktransfers** (19 columns)
- **subscriptionproducts** (13 columns)
- **xeroproductsmappings** (4 columns)

### Business & Store Management
- **businesses** (165 columns)
  - Key columns:
    - _id (character varying)
    - activatedat (timestamp without time zone)
    - added60daysfreesmscredits (boolean)
    - addonids (character varying)
    - advanceinvoiceid (character varying)
    - allowanonymousqrordering (boolean)
    - alloweditproductsonpos (boolean)
    - assigntableid (boolean)
    - autocountaccountingcode (character varying)
    - autolowsmscredits (double precision)
    - ... and 155 more columns
- **businessuniversalpromoclaiminfos** (9 columns)
- **employees** (23 columns)
- **hourlystoresales** (16 columns)
- **onlinestoreinfos** (28 columns)
- **storereviews** (14 columns)

### Marketing & Loyalty
- **campaignconditions** (5 columns)
- **campaigninformations** (23 columns)
- **campaignjobs** (30 columns)
- **campaignlogs** (12 columns)
- **campaigns** (25 columns)
- **campaignsegments** (6 columns)
- **failedloyaltyqrscans** (7 columns)
- **loyaltychangelogs** (14 columns)
- **pendingloyaltyqrscans** (8 columns)
- **promotionclaimcounts** (12 columns)
- **promotions** (44 columns)
- **rewardsettings** (17 columns)
- **rewardssets** (7 columns)

### Logistics & Delivery
- **fooddeliveryplatformsettings** (7 columns)
- **logistics** (56 columns)
- **logisticserrors** (6 columns)
- **logisticsglobalconfigs** (4 columns)
- **logisticsjoblogs** (13 columns)
- **logisticsjobrequests** (11 columns)
- **logisticslocations** (7 columns)
- **logisticslogs** (14 columns)
- **logisticsrequests** (11 columns)
- **shippingzones** (11 columns)

### Financial & Payments
- **batchpayouts** (32 columns)
- **custompaymentgatewayfees** (5 columns)
- **gatewayrecords** (16 columns)
- **gatewayretrievelogs** (11 columns)
- **merchantpaymentoptions** (11 columns)
- **paymentintents** (13 columns)
- **paymentmethods** (11 columns)
- **paymentprovidercredentials** (9 columns)
- **paymentrecordlogs** (12 columns)
- **paymentrecords** (40 columns)
- **paymentsettlements** (24 columns)
- **payoutitems** (34 columns)

### Other
- **addressbooks** (15 columns)
- **appnotifications** (11 columns)
- **bankaccounts** (12 columns)
- **beepaddresses** (21 columns)
- **beepcollections** (20 columns)
- **blockaccounts** (11 columns)
- **cfddisplays** (11 columns)
- **comments** (12 columns)
- **dailysales** (13 columns)
- **deletedregisters** (5 columns)
- **einvoiceconsolidationtasks** (17 columns)
- **einvoicerequestrecords** (21 columns)
- **feedbacks** (12 columns)
- **grabfoodsettings** (7 columns)
- **hourlysales** (14 columns)
- **inventories** (19 columns)
- **marketingtags** (8 columns)
- **merchantcashbackdaycounts** (5 columns)
- **messages** (19 columns)
- **messengermessages** (18 columns)
- **notifications** (6 columns)
- **onlinecategories** (14 columns)
- **pendingcashbacklogs** (9 columns)
- **pointchangelogs** (9 columns)
- **pricebooks** (11 columns)
- **qbosettings** (24 columns)
- **qrcoderecords** (11 columns)
- **quickselectlayouts** (5 columns)
- **recondiscrepancies** (7 columns)
- **reconexeclogs** (8 columns)
- **registerlocalsettings** (4 columns)
- **registervoidseqnumbers** (7 columns)
- **reviewinfohistories** (11 columns)
- **reviewinfos** (11 columns)
- **reviewupdateerrorlogs** (10 columns)
- **samples** (3 columns)
- **searchingtags** (7 columns)
- **serialnumbers** (6 columns)
- **sharedcatalogs** (4 columns)
- **sharedmodifiers** (13 columns)
- **shareinforequests** (16 columns)
- **smscreditlogs** (35 columns)
- **strategyrules** (11 columns)
- **subscriptioninvoices** (18 columns)
- **subscriptions** (10 columns)
- **suppliers** (15 columns)
- **tablelayouts** (5 columns)
- **tables** (7 columns)
- **timesheets** (8 columns)
- **vouchers** (24 columns)
- **xerosettings** (29 columns)
- **zreadings** (62 columns)

## Nested Tables Structure


### addressbooks
  - location (5 columns)

### beepaddresses
  - location (5 columns)

### businesses
  - addons (5 columns)
  - cashregisters (29 columns)
  - cashregisters__device (7 columns)
  - cashregisters__location (6 columns)
  - excludeservicechargeproductcondition (5 columns)
  - excludeservicechargeproductcondition__conditions (6 columns)
  - fixedfeesettings (7 columns)
  - freesmscredits (8 columns)
  - nagbar (5 columns)
  - ownertransfertokens (7 columns)
  - paymentoptions (13 columns)
  - qrorderingsettings (29 columns)
  - stores (54 columns)
  - stores__location (6 columns)
  - stores__pickupaddress (9 columns)
  - stores__pickupaddress__addresscomponents (9 columns)
  - stores__qrorderingsettings (18 columns)
  - stores__qrorderingsettings__vacations (6 columns)
  - stores__reviewinfo (6 columns)
  - taxcodes (8 columns)

### campaignconditions
  - filters (8 columns)
  - output (6 columns)

### campaignjobs
  - additionalattributes (4 columns)

### campaignlogs
  - additionallogdata (5 columns)

### campaigns
  - promotion (6 columns)

### campaignsegments
  - filters (12 columns)
  - nestedsource (5 columns)
  - nestedsource__filters (13 columns)

### comments
  - attachments (6 columns)

### consumers
  - deletefeedback (5 columns)
  - facebook (5 columns)
  - notificationsettings (9 columns)

### custompaymentgatewayfees
  - feerules (7 columns)
  - feerules__chargingrules (6 columns)

### customtransactionfeerates
  - rateconfig (9 columns)

### einvoiceconsolidationtasks
  - errormessages (5 columns)

### employees
  - devices (8 columns)
  - passwordsettingtokens (6 columns)

### fooddeliveryplatformsettings
  - outlets (16 columns)
  - outlets__grabitemmappings (7 columns)
  - outlets__grabmodifiermappings (7 columns)

### grabfoodsettings
  - outlets (5 columns)

### inventorychangeevents
  - updates (20 columns)

### logistics
  - additionaldata (5 columns)

### onlinecategories
  - conditions (6 columns)

### onlinestoreinfos
  - analytictools (5 columns)
  - bankingdetails (10 columns)
  - banners (6 columns)
  - customizecommissionrates (8 columns)
  - offlinepaymentbankaccounts (7 columns)
  - offlinepaymentinstructions (5 columns)
  - onlinepaymentoptions (6 columns)
  - pages (7 columns)
  - socialmediainfo (7 columns)
  - socialmediainfo__facebook (8 columns)
  - socialmediainfo__line (7 columns)
  - socialmediainfo__viber (7 columns)

### paymentmethods
  - cardinfo (10 columns)

### paymentprovidercredentials
  - credential (9 columns)

### paymentsettlements
  - orders (17 columns)

### payoutitems
  - adjustmentdetails (6 columns)
  - adjustmentdetails__adjustmentitems (10 columns)
  - paymentgatewayfeedetail (6 columns)
  - storehubdetails (7 columns)

### pointchangelogs
  - extrainfo (7 columns)
  - points (5 columns)

### products
  - beerdocketsettings (6 columns)
  - components (5 columns)
  - pricebooks (8 columns)
  - quickselectpositions (8 columns)
  - soldoutstores (5 columns)
  - stocktakes (8 columns)
  - variations (12 columns)
  - variations__optionvalues (11 columns)
  - variations__optionvalues__conditionalpricediffs (8 columns)
  - variations__optionvalues__soldoutstores (6 columns)
  - variationvalues (5 columns)

### promotions
  - conditions (9 columns)
  - requiredproducts (9 columns)
  - rewardssettings (7 columns)

### purchaseorders
  - ordereditems (10 columns)
  - ordereditems__componentsusages (8 columns)
  - useractionlogs (13 columns)

### qbosettings
  - accounts (5 columns)
  - qboaccounts (6 columns)
  - qbopaymentmethods (5 columns)
  - qbotaxcodes (5 columns)
  - taxcodes (5 columns)

### quickselectlayouts
  - categories (6 columns)

### recondiscrepancies
  - logs (5 columns)
  - logs__gatewayrecords (8 columns)
  - logs__payoutitems (8 columns)

### registerlocalsettings
  - localsettings (5 columns)

### rewardssets
  - promotionconfigs (6 columns)

### serialnumbers
  - logs (8 columns)

### sharedmodifiers
  - optionvalues (10 columns)
  - optionvalues__conditionalpricediffs (8 columns)
  - optionvalues__soldoutstores (6 columns)

### shifts
  - beepshift (12 columns)
  - beepshift__discountsummary (4 columns)
  - beepshift__discountsummary__returns (6 columns)
  - beepshift__discountsummary__sales (6 columns)
  - beepshift__paymentsummary (4 columns)
  - beepshift__paymentsummary__returns (6 columns)
  - beepshift__paymentsummary__sales (6 columns)
  - beepshift__servicechargesummary (4 columns)
  - beepshift__servicechargesummary__returns (6 columns)
  - beepshift__servicechargesummary__sales (6 columns)
  - beepshift__taxsummary (8 columns)
  - deposits (6 columns)
  - payins (9 columns)
  - payouts (9 columns)
  - returns (6 columns)
  - sales (6 columns)
  - taxsummary (7 columns)

### shiftsnapshots
  - payments (11 columns)

### shippingzones
  - deliverymethods (10 columns)
  - deliverymethods__freeconditions (8 columns)
  - deliverymethods__ratecalculation (4 columns)
  - deliverymethods__ratecalculation__additions (6 columns)
  - deliverymethods__ratecalculation__additions__measure (8 columns)
  - deliverymethods__ratecalculation__firstbase (6 columns)
  - deliverymethods__ratecalculation__firstbase__measure (8 columns)
  - deliverymethods__ratecalculation__secondbase (6 columns)
  - deliverymethods__ratecalculation__secondbase__measure (8 columns)

### stockreturns
  - returneditems (9 columns)
  - returneditems__componentsusages (8 columns)
  - useractionlogs (13 columns)

### stocktakes
  - useractionlogs (13 columns)

### stocktransfers
  - ordereditems (7 columns)
  - ordereditems__componentsusages (8 columns)
  - useractionlogs (13 columns)

### strategyrules
  - timeline (4 columns)

### subscriptioninvoices
  - lineitems (14 columns)

### subscriptionorders
  - addons (4 columns)

### subscriptions
  - addons (5 columns)
  - coupons (4 columns)
  - plan (4 columns)

### tablelayouts
  - sections (6 columns)

### tables
  - frame (9 columns)

### transactionrecords
  - appliedvoucher (9 columns)
  - billingaddress (16 columns)
  - billingaddress__location (6 columns)
  - calculation (4 columns)
  - calculation__discounts (9 columns)
  - calculation__original (7 columns)
  - calculation__taxes (9 columns)
  - contactdetail (7 columns)
  - deliveryinformation (17 columns)
  - deliveryinformation__address (17 columns)
  - deliveryinformation__address__location (6 columns)
  - deliveryinformation__deliverymethodinfo (13 columns)
  - display (8 columns)
  - fromlocation (5 columns)
  - items (50 columns)
  - items__calculation (5 columns)
  - items__calculation__discounts (9 columns)
  - items__calculation__original (7 columns)
  - items__calculation__taxes (9 columns)
  - items__componentsusages (8 columns)
  - items__display (8 columns)
  - items__manualdiscount (6 columns)
  - items__productinfo (21 columns)
  - items__promotions (22 columns)
  - items__selectedoptions (8 columns)
  - items__servicechargeinfo (7 columns)
  - kdssyncinfo (5 columns)
  - location (5 columns)
  - loyaltydiscounts (8 columns)
  - merchantinfo (8 columns)
  - payments (18 columns)
  - payments__manualapproveinfo (7 columns)
  - pickupinformation (3 columns)
  - pickupinformation__store (55 columns)
  - pickupinformation__store__location (6 columns)
  - pickupinformation__store__pickupaddress (9 columns)
  - pickupinformation__store__pickupaddress__addresscomponents (9 columns)
  - pickupinformation__store__qrorderingsettings (18 columns)
  - pickupinformation__store__qrorderingsettings__vacations (6 columns)
  - pickupinformation__store__reviewinfo (6 columns)
  - promotions (21 columns)
  - returnprocess (12 columns)
  - returnprocess__selectedoptions (8 columns)
  - review (6 columns)
  - suborders (11 columns)

### transactionrecordwithduplicatedids
  - appliedvoucher (9 columns)
  - calculation (4 columns)
  - calculation__discounts (9 columns)
  - calculation__original (7 columns)
  - calculation__taxes (9 columns)
  - items (50 columns)
  - items__calculation (5 columns)
  - items__calculation__discounts (9 columns)
  - items__calculation__original (7 columns)
  - items__calculation__taxes (9 columns)
  - items__componentsusages (8 columns)
  - items__display (8 columns)
  - items__manualdiscount (6 columns)
  - items__productinfo (21 columns)
  - items__promotions (22 columns)
  - items__selectedoptions (8 columns)
  - items__servicechargeinfo (7 columns)
  - location (5 columns)
  - loyaltydiscounts (8 columns)
  - payments (18 columns)
  - payments__manualapproveinfo (7 columns)
  - promotions (21 columns)
  - returnprocess (12 columns)
  - returnprocess__selectedoptions (8 columns)

### xerosettings
  - accounts (8 columns)
  - qboaccounts (6 columns)
  - qbopaymentmethods (5 columns)
  - qbotaxcodes (5 columns)
  - taxcodes (5 columns)

### zreadings
  - paymentcollections (6 columns)