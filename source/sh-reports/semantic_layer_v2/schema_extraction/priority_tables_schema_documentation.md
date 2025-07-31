# StoreHub Priority Tables Schema Documentation
Generated from 172 priority tables based on svv_columns metadata
Total tables documented: 172

## Overview Statistics
- **Total Tables:** 172
- **Total Columns:** 2,547
- **Total Rows:** 6,212,891,851
- **Average Columns per Table:** 14

## Categories Overview
| Category | Tables | Total Rows | % of Total |
|----------|--------|------------|------------|
| Transactions | 29 | 5,646,561,730 | 90.9% |
| Other | 43 | 153,270,160 | 2.5% |
| Payments | 14 | 137,749,178 | 2.2% |
| Products | 11 | 106,623,330 | 1.7% |
| Loyalty | 5 | 55,238,348 | 0.9% |
| Customers | 2 | 53,398,948 | 0.9% |
| Inventory | 9 | 38,235,412 | 0.6% |
| Marketing | 13 | 13,574,405 | 0.2% |
| Logistics | 11 | 6,573,122 | 0.1% |
| Employees | 2 | 775,458 | 0.0% |
| Businesses | 19 | 681,115 | 0.0% |
| Online Store | 11 | 185,922 | 0.0% |
| Digital Ordering | 3 | 24,723 | 0.0% |

---

## Key Relationships

### Primary Tables
- `businesses` - Core merchant/business entities
- `customers` - Customer profiles
- `products` - Product catalog
- `transactionrecords` - Sales transactions
- `employees` - Staff/user accounts

### Common Foreign Key Patterns
- `*_foreignkey` - Explicit foreign key to parent table
- `business`, `businessid` - Links to businesses._id
- `customerid` - Links to customers._id
- `productid` - Links to products._id
- `transactionid`, `receiptnumber` - Links to transactionrecords

---

## Transactions
**Tables:** 29 | **Total Rows:** 5,646,561,730

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `transactionrecords__items` | 2,434,587,238 | 50 | Line items for each transaction |
| `transactionrecords__payments` | 984,792,794 | 18 | Payment methods used in transactions |
| `transactionrecords` | 971,611,229 | 132 | Sales and return transactions |
| `transactionrecords__items__selectedoptions` | 956,891,680 | 8 | Line items for each transaction |
| `transactionrecords__items__componentsusages` | 72,349,548 | 8 | Line items for each transaction |
| `transactionrecords__items__productinfo` | 66,696,215 | 21 | Line items for each transaction |
| `transactionrecords__location` | 42,716,363 | 5 | Geographic location of transactions |
| `transactionrecords__items__promotions` | 30,836,822 | 22 | Line items for each transaction |
| `transactionrecords__contactdetail` | 22,804,306 | 7 | Transactionrecords  Contactdetail |
| `transactionrecords__suborders` | 13,576,743 | 11 | Transactionrecords  Suborders |
| `transactionrecords__promotions` | 12,139,704 | 21 | Promotions applied to transactions |
| `transactionrecords__loyaltydiscounts` | 8,004,277 | 8 | Transactionrecords  Loyaltydiscounts |
| `transactionrecords__deliveryinformation` | 6,578,078 | 17 | Transactionrecords  Deliveryinformation |
| `transactionrecords__deliveryinformation__address` | 6,578,025 | 17 | Transactionrecords  Deliveryinformation  Address |
| `transactionrecords__deliveryinformation__deliverymethodinfo` | 2,979,587 | 13 | Transactionrecords  Deliveryinformation  Deliverymethodinfo |
| `transactionrecords__deliveryinformation__address__location` | 2,634,226 | 6 | Transactionrecords  Deliveryinformation  Address  Location |
| `transactionrecords__fromlocation` | 2,554,263 | 5 | Transactionrecords  Fromlocation |
| `transactionrecords__returnprocess` | 2,506,561 | 12 | Transactionrecords  Returnprocess |
| `transactionrecords__pickupinformation__store__qrorderingsettings__vacations` | 891,916 | 6 | Transactionrecords  Pickupinformation  Store  Qrorderingsettings  Vacations |
| `transactionrecords__payments__manualapproveinfo` | 835,889 | 7 | Payment methods used in transactions |
| `transactionrecords__pickupinformation` | 829,856 | 3 | Transactionrecords  Pickupinformation |
| `transactionrecords__pickupinformation__store__pickupaddress__addresscomponents` | 760,012 | 9 | Transactionrecords  Pickupinformation  Store  Pickupaddress  Addresscomponents |
| `transactionrecords__pickupinformation__store__pickupaddress` | 759,993 | 9 | Transactionrecords  Pickupinformation  Store  Pickupaddress |
| `transactionrecords__pickupinformation__store__location` | 738,555 | 6 | Transactionrecords  Pickupinformation  Store  Location |
| `transactionrecords__pickupinformation__store__qrorderingsettings` | 714,331 | 18 | Transactionrecords  Pickupinformation  Store  Qrorderingsettings |
| `transactionrecords__returnprocess__selectedoptions` | 167,197 | 8 | Transactionrecords  Returnprocess  Selectedoptions |
| `transactionrecords__appliedvoucher` | 25,133 | 9 | Transactionrecords  Appliedvoucher |
| `transactionrecords__review` | 949 | 6 | Transactionrecords  Review |
| `transactionrecords__pickupinformation__store__reviewinfo` | 240 | 6 | Transactionrecords  Pickupinformation  Store  Reviewinfo |

### Detailed Schemas

#### transactionrecords__items
- **Row Count:** 2,434,587,238
- **Columns:** 50
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| originalitemid | character varying | FK | Reference to originalitem |
| productid | character varying | FK | Reference to product |
| submitid | character varying | FK | Reference to submit |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| adhocdiscount | double precision |  | Count/quantity |
| athleteandcoachdiscount | double precision |  | Count/quantity |
| comments | character varying |  |  |
| cost | numeric |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discount | numeric |  | Discount amount |
| discounttype | character varying |  |  |
| discountvalue | double precision |  |  |
| fullbilldiscount | double precision |  | Count/quantity |
| image | character varying |  |  |
| isamusementtax | boolean |  |  |
| ishalal | boolean |  |  |
| isservicechargenotapplicable | boolean |  |  |
| istakeaway | boolean |  |  |
| isvatexempted | boolean |  |  |
| itemchannel | double precision |  |  |
| itemtype | character varying |  |  |
| lockeddate | timestamp without time zone |  | Date |
| lockedquantity | double precision |  |  |
| loyaltydiscount | double precision |  | Count/quantity |
| medalofvalordiscount | double precision |  | Count/quantity |
| notes | character varying |  |  |
| orderingvalue | double precision |  |  |
| promotiondiscount | double precision |  | Count/quantity |
| pwddiscount | double precision |  | Count/quantity |
| quantity | double precision |  | Quantity |
| refundedquantity | double precision |  |  |
| seniordiscount | double precision |  | Count/quantity |
| sn | character varying |  |  |
| soloparentdiscount | double precision |  | Count/quantity |
| source | character varying |  |  |
| sourcevalue | character varying |  |  |
| status | character varying |  | Record status |
| subtotal | numeric |  | Subtotal before tax/discount |
| takeawaycharge | double precision |  |  |
| tax | numeric |  | Tax amount |
| taxableamount | double precision |  | Amount value |
| taxcode | character varying |  |  |
| taxexemptamount | double precision |  | Amount value |
| taxrate | double precision |  |  |
| title | character varying |  | Title or name |
| total | numeric |  | Total amount |
| totaldeductedtax | double precision |  |  |
| unitprice | double precision |  |  |
| zeroratedsales | double precision |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `productid` → `products._id` *(inferred)*

#### transactionrecords__payments
- **Row Count:** 984,792,794
- **Columns:** 18
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| mpostxnid | character varying | FK | Reference to mpostxn |
| paymentmethodid | character varying | FK | Reference to paymentmethod |
| paymentprovidermid | character varying | FK | Reference to paymentproviderm |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| amount | numeric |  | Monetary amount |
| cardname | character varying |  |  |
| cardno | character varying |  |  |
| cashtendered | double precision |  |  |
| changeamount | double precision |  | Amount value |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdeposit | boolean |  |  |
| isonline | boolean |  |  |
| paymentgateway | character varying |  |  |
| paymentmethod | character varying |  |  |
| paymentprovider | character varying |  |  |
| roundedamount | double precision |  | Amount value |
| subtype | character varying |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords
- **Row Count:** 971,611,229
- **Columns:** 132
- **Relationships:** 9

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| clientid | character varying | FK | Reference to client |
| consumerid | character varying | FK | Reference to consumer |
| customerid | character varying | FK | Reference to customer |
| deviceid | character varying | FK | Reference to device |
| einvoiceinfo.documentid | character varying | FK | Reference to einvoiceinfo.document |
| inventorychangemsgtrackinfo.eventid | character varying | FK | Reference to inventorychangemsgtrackinfo.event |
| issplittedfromreceiptnumber | character varying | FK |  |
| originalreceiptnumber | character varying | FK |  |
| pickupid | character varying | FK | Reference to pickup |
| preorderid | character varying | FK | Reference to preorder |
| receiptnumber | character varying | FK |  |
| registerid | character varying | FK | Reference to register |
| sessionid | character varying | FK | Reference to session |
| storeid | character varying | FK | Reference to store |
| tableid | character varying | FK | Reference to table |
| transactionid | character varying | FK | Reference to transaction |
| addonbircompliance.athleteandcoachdiscount | double precision |  | Count/quantity |
| addonbircompliance.collectedinfo | character varying |  |  |
| addonbircompliance.discounttype | character varying |  |  |
| addonbircompliance.medalofvalordiscount | double precision |  | Count/quantity |
| addonbircompliance.soloparentdiscount | double precision |  | Count/quantity |
| amusementtax | double precision |  |  |
| appversion | character varying |  |  |
| cancelledat | timestamp without time zone |  |  |
| cancelledby | character varying |  |  |
| cancelleddate | timestamp without time zone |  | Date |
| cancelledsource | character varying |  |  |
| cancelreason | character varying |  |  |
| cancelreasondetail | character varying |  |  |
| cashtendered | double precision |  |  |
| changedtoofflinepaymentnotifiedsmscount | double precision |  | Count/quantity |
| channel | double precision |  |  |
| comment | character varying |  |  |
| containerfee | double precision |  |  |
| containerfeetax | double precision |  |  |
| cost | numeric |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| createdvouchercodes | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deductinventorymethod | character varying |  |  |
| delaydetail | character varying |  |  |
| delayreason | character varying |  |  |
| depositamount | double precision |  | Amount value |
| discount | numeric |  | Discount amount |
| einvoiceinfo.documenttype | character varying |  |  |
| einvoiceinfo.einvoicestatus | character varying |  |  |
| einvoiceinfo.statusupdatedat | timestamp without time zone |  |  |
| emailreceipt | boolean |  |  |
| employeenumber | character varying |  |  |
| enablecashback | boolean |  |  |
| enabledgooglereviewsmscampaign | boolean |  |  |
| expectdeliverydatefrom | timestamp without time zone |  |  |
| expectdeliverydateto | timestamp without time zone |  |  |
| failedtosendmembershipstatsqueue | boolean |  |  |
| failedtoupdateinventory | boolean |  |  |
| failedtoupdateloyalty | boolean |  |  |
| fixedfee | double precision |  |  |
| fulfilldate | timestamp without time zone |  | Date |
| headcount | double precision |  | Count/quantity |
| inventorychangemsgtrackinfo.issendmsg | boolean |  |  |
| inventorychangemsgtrackinfo.sendmsgstartat | timestamp without time zone |  |  |
| invoiceseqnumber | double precision |  |  |
| iscancelled | boolean |  |  |
| isdisbursed | boolean |  |  |
| isnextdaypreorder | boolean |  |  |
| ispaidzero | boolean |  |  |
| ispaylater | boolean |  |  |
| issplittedby | character varying |  |  |
| lastuploadedtime | timestamp without time zone |  | Timestamp |
| minno | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| notifiedselfpickupsmscount | double precision |  | Count/quantity |
| onlinebirdate | timestamp without time zone |  | Date |
| ordersource | character varying |  |  |
| originalshippingtype | character varying |  |  |
| otherfee | double precision |  |  |
| otherreason | character varying |  |  |
| paiddate | timestamp without time zone |  | Date |
| pax | double precision |  |  |
| paymentmethod | character varying |  |  |
| pendingclaimcashback | double precision |  |  |
| pendingpaymentstarttime | timestamp without time zone |  | Timestamp |
| pendingtime | timestamp without time zone |  | Timestamp |
| pickupdate | timestamp without time zone |  | Date |
| platformservicefee | double precision |  |  |
| platformservicefeetax | double precision |  |  |
| preorderby | character varying |  |  |
| preorderdate | timestamp without time zone |  | Date |
| printkitchendocket | boolean |  |  |
| printreceipt | boolean |  |  |
| productsmanualdiscount | double precision |  | Count/quantity |
| prooffiles | character varying |  |  |
| pwdcount | double precision |  | Count/quantity |
| pwddiscount | double precision |  | Count/quantity |
| receiptnumbersbeforefix | character varying |  |  |
| registernumber | double precision |  |  |
| returnreason | character varying |  |  |
| returnstatus | character varying |  |  |
| revenue | double precision |  |  |
| roundedamount | double precision |  | Amount value |
| saleschannel | double precision |  |  |
| seniordiscount | double precision |  | Count/quantity |
| seniorscount | double precision |  | Count/quantity |
| seqnumbercreatedtime | timestamp without time zone |  | Timestamp |
| sequencenumber | double precision |  |  |
| servedtime | timestamp without time zone |  | Timestamp |
| servicecharge | numeric |  |  |
| servicechargerate | double precision |  |  |
| servicechargetax | double precision |  |  |
| shippingfee | numeric |  |  |
| shippingfeediscount | double precision |  | Count/quantity |
| shippingtype | character varying |  |  |
| smallorderfee | double precision |  |  |
| smallorderfeetax | double precision |  |  |
| status | character varying |  | Record status |
| subtotal | numeric |  | Subtotal before tax/discount |
| subtotaltax | double precision |  |  |
| takeawaycharges | double precision |  |  |
| tax | numeric |  | Tax amount |
| taxablesales | double precision |  |  |
| taxexemptedsales | double precision |  |  |
| total | numeric |  | Total amount |
| totaldeductedtax | double precision |  |  |
| transactiontype | character varying |  |  |
| urltype | character varying |  |  |
| version | double precision |  |  |
| voidnumber | character varying |  |  |
| voidseqnumber | double precision |  |  |
| vouchervaliddays | double precision |  |  |
| zeroratedsales | double precision |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `consumerid` → `consumers._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `issplittedfromreceiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `originalreceiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `preorderid` → `orders._id` *(inferred)*
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*
- `transactionid` → `transactionrecords.receiptnumber` *(inferred)*

#### transactionrecords__items__selectedoptions
- **Row Count:** 956,891,680
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| optionid | character varying | FK | Reference to option |
| transactionrecords__items_foreignkey | character varying | FK | Foreign key to transactionrecords__items |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| variationid | character varying | FK | Reference to variation |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| optionvalue | character varying |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `transactionrecords__items_foreignkey` → `transactionrecords__items._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__items__componentsusages
- **Row Count:** 72,349,548
- **Columns:** 8
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| transactionrecords__items_foreignkey | character varying | FK | Foreign key to transactionrecords__items |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| lockeddate | timestamp without time zone |  | Date |
| lockedquantity | double precision |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `transactionrecords__items_foreignkey` → `transactionrecords__items._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `productid` → `products._id` *(inferred)*

#### transactionrecords__items__productinfo
- **Row Count:** 66,696,215
- **Columns:** 21
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| productparentid | character varying | FK | Reference to productparent |
| transactionrecords__items_foreignkey | character varying | FK | Foreign key to transactionrecords__items |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| category | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| displayprice | double precision |  |  |
| image | character varying |  |  |
| inventorytype | character varying |  |  |
| isamusementtax | boolean |  |  |
| ishalal | boolean |  |  |
| isvatexempted | boolean |  |  |
| originaldisplayprice | double precision |  |  |
| originimage | character varying |  |  |
| tags | character varying |  |  |
| taxcode | character varying |  |  |
| taxrate | double precision |  |  |
| title | character varying |  | Title or name |
| trackinventory | boolean |  |  |
| unitprice | double precision |  |  |

**Relationships:**
- `transactionrecords__items_foreignkey` → `transactionrecords__items._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `productid` → `products._id` *(inferred)*

#### transactionrecords__location
- **Row Count:** 42,716,363
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__items__promotions
- **Row Count:** 30,836,822
- **Columns:** 22
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| promotionid | character varying | FK | Reference to promotion |
| transactionrecords__items_foreignkey | character varying | FK | Foreign key to transactionrecords__items |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| uniquepromotioncodeid | character varying | FK | Reference to uniquepromotioncode |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discount | numeric |  | Discount amount |
| discounttype | character varying |  |  |
| originaldiscounttype | character varying |  |  |
| promotioncode | character varying |  |  |
| promotionname | character varying |  |  |
| promotiontype | character varying |  |  |
| pwddiscount | double precision |  | Count/quantity |
| quantity | double precision |  | Quantity |
| seniordiscount | double precision |  | Count/quantity |
| shippingfeediscount | double precision |  | Count/quantity |
| storehubpaidpercentage | double precision |  |  |
| tax | numeric |  | Tax amount |
| taxableamount | double precision |  | Amount value |
| taxcode | character varying |  |  |
| taxexemptamount | double precision |  | Amount value |
| uniquepromotioncode | character varying |  |  |

**Relationships:**
- `transactionrecords__items_foreignkey` → `transactionrecords__items._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `promotionid` → `promotions._id` *(inferred)*

#### transactionrecords__contactdetail
- **Row Count:** 22,804,306
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| info | character varying |  |  |
| name | character varying |  | Display name |
| phone | character varying |  | Phone number |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__suborders
- **Row Count:** 13,576,743
- **Columns:** 11
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| submitid | character varying | FK | Reference to submit |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| comments | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isprinted | boolean |  |  |
| printedtime | timestamp without time zone |  | Timestamp |
| submittedby | character varying |  |  |
| submittedbyphone | character varying |  |  |
| submittedfrom | character varying |  |  |
| submittedtime | timestamp without time zone |  | Timestamp |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__promotions
- **Row Count:** 12,139,704
- **Columns:** 21
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| promotionid | character varying | FK | Reference to promotion |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| uniquepromotioncodeid | character varying | FK | Reference to uniquepromotioncode |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discount | numeric |  | Discount amount |
| discounttype | character varying |  |  |
| originaldiscounttype | character varying |  |  |
| promotioncode | character varying |  |  |
| promotionname | character varying |  |  |
| promotiontype | character varying |  |  |
| pwddiscount | double precision |  | Count/quantity |
| quantity | double precision |  | Quantity |
| seniordiscount | double precision |  | Count/quantity |
| shippingfeediscount | double precision |  | Count/quantity |
| storehubpaidpercentage | double precision |  |  |
| tax | numeric |  | Tax amount |
| taxableamount | double precision |  | Amount value |
| taxcode | character varying |  |  |
| taxexemptamount | double precision |  | Amount value |
| uniquepromotioncode | character varying |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `promotionid` → `promotions._id` *(inferred)*

#### transactionrecords__loyaltydiscounts
- **Row Count:** 8,004,277
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discountedtax | double precision |  |  |
| displaydiscount | double precision |  | Count/quantity |
| loyaltytype | character varying |  |  |
| spentvalue | double precision |  |  |
| taxrate | double precision |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__deliveryinformation
- **Row Count:** 6,578,078
- **Columns:** 17
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| jobid | character varying | FK | Reference to job |
| trackingid | character varying | FK | Reference to tracking |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| bestlastmileeta | timestamp without time zone |  |  |
| comments | character varying |  |  |
| courier | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliverydistance | double precision |  |  |
| deliverydistanceunit | character varying |  |  |
| deliveryfee | double precision |  |  |
| driverphone | character varying |  |  |
| ridetypemerchantsetup | character varying |  |  |
| shippingfee | numeric |  |  |
| trackingurl | character varying |  |  |
| usestorehublogistics | boolean |  |  |
| worstlastmileeta | timestamp without time zone |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__deliveryinformation__address
- **Row Count:** 6,578,025
- **Columns:** 17
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| addressid | character varying | FK | Reference to address |
| transactionrecords__deliveryinformation_foreignkey | character varying | FK | Foreign key to transactionrecords__deliveryinformation |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| address | character varying |  | Address |
| addressdetails | character varying |  |  |
| city | character varying |  |  |
| companyname | character varying |  |  |
| country | character varying |  | Country code |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliveryto | character varying |  |  |
| name | character varying |  | Display name |
| phone | character varying |  | Phone number |
| postcode | character varying |  |  |
| state | character varying |  |  |
| updatedtime | timestamp without time zone |  | Last update timestamp |

**Relationships:**
- `transactionrecords__deliveryinformation_foreignkey` → `transactionrecords__deliveryinformation._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__deliveryinformation__deliverymethodinfo
- **Row Count:** 2,979,587
- **Columns:** 13
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| deliverymethodid | character varying | FK | Reference to deliverymethod |
| shippingzoneid | character varying | FK | Reference to shippingzone |
| transactionrecords__deliveryinformation_foreignkey | character varying | FK | Foreign key to transactionrecords__deliveryinformation |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliverymethodname | character varying |  |  |
| isfree | boolean |  |  |
| maxshippingtime | double precision |  | Timestamp |
| minshippingtime | double precision |  | Timestamp |
| rate | double precision |  |  |
| shippingtimeunit | character varying |  |  |
| shippingzonename | character varying |  |  |

**Relationships:**
- `transactionrecords__deliveryinformation_foreignkey` → `transactionrecords__deliveryinformation._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__deliveryinformation__address__location
- **Row Count:** 2,634,226
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__deliveryinformation__address_foreignkey | character varying | FK | Foreign key to transactionrecords__deliveryinformation__address |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `transactionrecords__deliveryinformation__address_foreignkey` → `transactionrecords__deliveryinformation__address._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__fromlocation
- **Row Count:** 2,554,263
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__returnprocess
- **Row Count:** 2,506,561
- **Columns:** 12
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| actionrequired | boolean |  |  |
| comment | character varying |  |  |
| completedtime | timestamp without time zone |  | Timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| failedtoupdateinventory | boolean |  |  |
| inventoryaction | character varying |  |  |
| skunumber | character varying |  |  |
| sn | character varying |  |  |
| title | character varying |  | Title or name |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`
- `productid` → `products._id` *(inferred)*

#### transactionrecords__pickupinformation__store__qrorderingsettings__vacations
- **Row Count:** 891,916
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__pickupinformation__store__qrorderingsettings_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store__qrorderingsettings |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| vacationtimefrom | character varying |  |  |
| vacationtimeto | character varying |  |  |

**Relationships:**
- `transactionrecords__pickupinformation__store__qrorderingsettings_foreignkey` → `transactionrecords__pickupinformation__store__qrorderingsettings._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__payments__manualapproveinfo
- **Row Count:** 835,889
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__payments_foreignkey | character varying | FK | Foreign key to transactionrecords__payments |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| approvedate | timestamp without time zone |  | Date |
| approver | character varying |  |  |
| approvereason | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `transactionrecords__payments_foreignkey` → `transactionrecords__payments._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation
- **Row Count:** 829,856
- **Columns:** 3
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation__store__pickupaddress__addresscomponents
- **Row Count:** 760,012
- **Columns:** 9
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__pickupinformation__store__pickupaddress_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store__pickupaddress |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| city | character varying |  |  |
| country | character varying |  | Country code |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| state | character varying |  |  |
| street1 | character varying |  |  |
| street2 | character varying |  |  |

**Relationships:**
- `transactionrecords__pickupinformation__store__pickupaddress_foreignkey` → `transactionrecords__pickupinformation__store__pickupaddress._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation__store__pickupaddress
- **Row Count:** 759,993
- **Columns:** 9
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| googlemapsplaceid | character varying | FK | Reference to googlemapsplace |
| transactionrecords__pickupinformation__store_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| coordinate | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| googlemapsurl | character varying |  |  |
| location | character varying |  |  |
| placename | character varying |  |  |

**Relationships:**
- `transactionrecords__pickupinformation__store_foreignkey` → `transactionrecords__pickupinformation__store._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation__store__location
- **Row Count:** 738,555
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__pickupinformation__store_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `transactionrecords__pickupinformation__store_foreignkey` → `transactionrecords__pickupinformation__store._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation__store__qrorderingsettings
- **Row Count:** 714,331
- **Columns:** 18
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__pickupinformation__store_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| breaktimefrom | character varying |  |  |
| breaktimeto | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| disableondemandorder | boolean |  |  |
| disabletodaypreorder | boolean |  |  |
| enablepertimeslotlimitforpreorder | boolean |  |  |
| enablepreorder | boolean |  |  |
| enableselfpickupalert | boolean |  |  |
| firstenablepreorderdeliverydate | timestamp without time zone |  | Date |
| maxpreorderspertimeslot | double precision |  |  |
| pausemodesettings.endingat | double precision |  |  |
| pausemodesettings.shippingtypes | character varying |  |  |
| validdays | character varying |  |  |
| validtimefrom | character varying |  |  |
| validtimeto | character varying |  |  |

**Relationships:**
- `transactionrecords__pickupinformation__store_foreignkey` → `transactionrecords__pickupinformation__store._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__returnprocess__selectedoptions
- **Row Count:** 167,197
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| optionid | character varying | FK | Reference to option |
| transactionrecords__returnprocess_foreignkey | character varying | FK | Foreign key to transactionrecords__returnprocess |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| variationid | character varying | FK | Reference to variation |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| optionvalue | character varying |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `transactionrecords__returnprocess_foreignkey` → `transactionrecords__returnprocess._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__appliedvoucher
- **Row Count:** 25,133
- **Columns:** 9
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| voucherid | character varying | FK | Reference to voucher |
| cost | numeric |  |  |
| coveredbysh | boolean |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| purchasechannel | character varying |  |  |
| value | double precision |  |  |
| vouchercode | character varying |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__review
- **Row Count:** 949
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| allowmerchantcontact | boolean |  |  |
| comments | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| rating | double precision |  |  |

**Relationships:**
- `transactionrecords_foreignkey` → `transactionrecords._id`

#### transactionrecords__pickupinformation__store__reviewinfo
- **Row Count:** 240
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| transactionrecords__pickupinformation__store_foreignkey | character varying | FK | Foreign key to transactionrecords__pickupinformation__store |
| transactionrecords_foreignkey | character varying | FK | Foreign key to transactionrecords |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| rating | double precision |  |  |
| ratingcount | double precision |  | Count/quantity |

**Relationships:**
- `transactionrecords__pickupinformation__store_foreignkey` → `transactionrecords__pickupinformation__store._id`
- `transactionrecords_foreignkey` → `transactionrecords._id`

---

## Other
**Tables:** 43 | **Total Rows:** 153,270,160

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `useractionlogs` | 60,089,080 | 12 | Useractionlogs |
| `inventories` | 58,541,689 | 19 | Stock levels and inventory tracking |
| `orderlogs` | 12,779,042 | 11 | Orderlogs |
| `messages` | 7,906,573 | 19 | Messages |
| `smscreditlogs` | 5,258,337 | 35 | Smscreditlogs |
| `purchaseorders__ordereditems` | 2,505,698 | 10 | Purchaseorders  Ordereditems |
| `serialnumbers__logs` | 1,811,210 | 8 | Serialnumbers  Logs |
| `serialnumbers` | 1,085,984 | 6 | Serialnumbers |
| `shifts__payins` | 879,020 | 9 | Shifts  Payins |
| `pointchangelogs` | 362,593 | 9 | Pointchangelogs |
| `zreadings` | 356,202 | 62 | Zreadings |
| `registerlocalsettings__localsettings` | 349,408 | 5 | Registerlocalsettings  Localsettings |
| `suppliers` | 300,459 | 15 | Suppliers |
| `purchaseorders` | 289,254 | 20 | Purchaseorders |
| `sharedmodifiers__optionvalues` | 172,384 | 10 | Sharedmodifiers  Optionvalues |
| `reviewinfohistories` | 128,507 | 11 | Reviewinfohistories |
| `subscriptions` | 59,084 | 10 | Subscriptions |
| `storereviews` | 52,469 | 14 | Storereviews |
| `comments` | 49,467 | 12 | Comments |
| `sharedmodifiers` | 40,830 | 13 | Sharedmodifiers |
| `feedbacks` | 34,308 | 12 | Feedbacks |
| `qbosettings__qboaccounts` | 29,017 | 6 | Qbosettings  Qboaccounts |
| `xerosettings__accounts` | 25,457 | 8 | Xerosettings  Accounts |
| `registerlocalsettings` | 21,748 | 4 | Registerlocalsettings |
| `purchaseorders__ordereditems__componentsusages` | 21,380 | 8 | Purchaseorders  Ordereditems  Componentsusages |
| `subscriptionorders` | 21,109 | 22 | Subscriptionorders |
| `einvoicerequestrecords` | 20,478 | 21 | Einvoicerequestrecords |
| `bankaccounts` | 17,812 | 12 | Bankaccounts |
| `shareinforequests` | 11,384 | 16 | Shareinforequests |
| `subscriptions__addons` | 11,129 | 5 | Subscriptions  Addons |
| `reviewinfos` | 7,525 | 11 | Reviewinfos |
| `customtransactionfeerates` | 6,757 | 5 | Customtransactionfeerates |
| `customtransactionfeerates__rateconfig` | 6,757 | 9 | Customtransactionfeerates  Rateconfig |
| `userjobs` | 5,589 | 11 | Userjobs |
| `qbosettings__qbotaxcodes` | 4,447 | 5 | Qbosettings  Qbotaxcodes |
| `timesheets` | 3,752 | 8 | Timesheets |
| `qbosettings` | 2,398 | 24 | Qbosettings |
| `xerosettings` | 539 | 29 | Xerosettings |
| `xerosettings__taxcodes` | 430 | 5 | Xerosettings  Taxcodes |
| `shifts` | 365 | 36 | Shifts |
| `shifts__taxsummary` | 282 | 7 | Shifts  Taxsummary |
| `searchingtags` | 151 | 7 | Searchingtags |
| `marketingtags` | 56 | 8 | Marketingtags |

### Detailed Schemas

#### useractionlogs
- **Row Count:** 60,089,080
- **Columns:** 12
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| registerid | double precision | FK | Reference to register |
| storeid | character varying | FK | Reference to store |
| action | character varying |  |  |
| additionalinfo | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| ipaddress | character varying |  |  |
| notes | character varying |  |  |
| source | character varying |  |  |
| time | timestamp without time zone |  | Timestamp |
| user | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### inventories
- **Row Count:** 58,541,689
- **Columns:** 19
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| productid | character varying | FK | Reference to product |
| storeid | character varying | FK | Reference to store |
| appliedeventids | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| desiredstocklevel | double precision |  |  |
| isserialized | boolean |  |  |
| pendingcancelledstocktransfers | character varying |  |  |
| pendingmanualupdatelogs | character varying |  |  |
| pendingpurchaseorders | character varying |  |  |
| pendingreturnprocess | character varying |  |  |
| pendingstockreturns | character varying |  |  |
| pendingstocktakes | character varying |  |  |
| pendingstocktransfers | character varying |  |  |
| pendingtransactions | character varying |  |  |
| quantityonhand | double precision |  |  |
| restocklevel | double precision |  |  |
| supplyneedsnotified | boolean |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `productid` → `products._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### orderlogs
- **Row Count:** 12,779,042
- **Columns:** 11
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| operatorid | character varying | FK | Reference to operator |
| receiptnumber | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| info | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| operatorname | character varying |  |  |
| operatortype | character varying |  |  |
| time | timestamp without time zone |  | Timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### messages
- **Row Count:** 7,906,573
- **Columns:** 19
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| msgid | character varying | FK | Reference to msg |
| templateid | character varying | FK | Reference to template |
| amount | numeric |  | Monetary amount |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| message | character varying |  |  |
| msgids | character varying |  |  |
| phone | character varying |  | Phone number |
| provider | character varying |  |  |
| rate | double precision |  |  |
| senttime | timestamp without time zone |  | Timestamp |
| senttimes | double precision |  |  |
| source | character varying |  |  |
| status | character varying |  | Record status |
| type | character varying |  | Type or category |
| units | double precision |  |  |
| updatedtime | timestamp without time zone |  | Last update timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### smscreditlogs
- **Row Count:** 5,258,337
- **Columns:** 35
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| extrainfo.campaignid | character varying | FK | Reference to extrainfo.campaign |
| extrainfo.campaignjobid | character varying | FK | Reference to extrainfo.campaignjob |
| extrainfo.campaignjoblaunchid | character varying | FK | Reference to extrainfo.campaignjoblaunch |
| extrainfo.lockfreesmscreditlogid | character varying | FK | Reference to extrainfo.lockfreesmscreditlog |
| extrainfo.lockpaidsmscreditlogid | character varying | FK | Reference to extrainfo.lockpaidsmscreditlog |
| extrainfo.purchasedid | character varying | FK | Reference to extrainfo.purchased |
| extrainfo.ticketid | character varying | FK | Reference to extrainfo.ticket |
| country | character varying |  | Country code |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| engagetrialsmscreditsbalance | double precision |  |  |
| engagetrialsmscreditschange | double precision |  |  |
| eventtime | timestamp without time zone |  | Timestamp |
| eventtype | character varying |  |  |
| extrainfo.campaignname | character varying |  |  |
| extrainfo.currency | character varying |  |  |
| extrainfo.paidamount | double precision |  | Amount value |
| extrainfo.smscount | double precision |  | Count/quantity |
| lockedengagetrialsmscreditsavailable | double precision |  |  |
| lockedengagetrialsmscreditschange | double precision |  |  |
| lockedmonthlysmscreditsavailable | double precision |  |  |
| lockedmonthlysmscreditschange | double precision |  |  |
| lockedsmscreditsavailable | double precision |  |  |
| lockedsmscreditschange | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| monthlysmscreditsbalance | double precision |  |  |
| monthlysmscreditschange | double precision |  |  |
| smscreditchange | double precision |  |  |
| smscreditsavgcost | double precision |  |  |
| smscreditsbalance | double precision |  |  |
| source | character varying |  |  |
| title | character varying |  | Title or name |
| type | character varying |  | Type or category |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `extrainfo.campaignid` → `campaigns._id` *(inferred)*

#### purchaseorders__ordereditems
- **Row Count:** 2,505,698
- **Columns:** 10
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| purchaseorders_foreignkey | character varying | FK | Foreign key to purchaseorders |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isserialized | boolean |  |  |
| orderedquantity | double precision |  |  |
| receivedquantity | double precision |  |  |
| serialnumbers | character varying |  |  |
| subtotal | numeric |  | Subtotal before tax/discount |
| supplierprice | double precision |  |  |

**Relationships:**
- `purchaseorders_foreignkey` → `purchaseorders._id`
- `productid` → `products._id` *(inferred)*

#### serialnumbers__logs
- **Row Count:** 1,811,210
- **Columns:** 8
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| docrefid | character varying | FK | Reference to docref |
| employeeid | character varying | FK | Reference to employee |
| serialnumbers_foreignkey | character varying | FK | Foreign key to serialnumbers |
| storeid | character varying | FK | Reference to store |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| eventtype | character varying |  |  |
| timestamp | timestamp without time zone |  |  |

**Relationships:**
- `serialnumbers_foreignkey` → `serialnumbers._id`
- `employeeid` → `employees._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### serialnumbers
- **Row Count:** 1,085,984
- **Columns:** 6
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| productid | character varying | FK | Reference to product |
| storeid | character varying | FK | Reference to store |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| serialnum | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `productid` → `products._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### shifts__payins
- **Row Count:** 879,020
- **Columns:** 9
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shifts_foreignkey | character varying | FK | Foreign key to shifts |
| actedby | character varying |  |  |
| amount | numeric |  | Monetary amount |
| comment | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| payouttime | timestamp without time zone |  | Timestamp |
| paytype | double precision |  |  |
| type | character varying |  | Type or category |

**Relationships:**
- `shifts_foreignkey` → `shifts._id`

#### pointchangelogs
- **Row Count:** 362,593
- **Columns:** 9
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| customerid | character varying | FK | Reference to customer |
| changeamount | double precision |  | Amount value |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| eventtime | timestamp without time zone |  | Timestamp |
| merchantname | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `customerid` → `customers._id` *(inferred)*

#### zreadings
- **Row Count:** 356,202
- **Columns:** 62
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| registerid | character varying | FK | Reference to register |
| storeid | character varying | FK | Reference to store |
| amusementtax | double precision |  |  |
| athleteandcoachdiscount | double precision |  | Count/quantity |
| closetime | timestamp without time zone |  | Timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| endornumber | character varying |  |  |
| endtrxnumber | character varying |  |  |
| extendedinfoformall.customercount | double precision |  | Count/quantity |
| extendedinfoformall.discountedtrxcount | double precision |  | Count/quantity |
| extendedinfoformall.newvoidamount | double precision |  | Amount value |
| extendedinfoformall.newvoidnumber | double precision |  |  |
| extendedinfoformall.oldvoidamount | double precision |  | Amount value |
| extendedinfoformall.oldvoidnumber | double precision |  |  |
| extendedinfoformall.vatablenewnet | double precision |  |  |
| extendedinfoformall.vatableoldnet | double precision |  |  |
| extendedinfoformall.vatablerefundamount | double precision |  | Amount value |
| extendedinfoformall.vatablevoidamount | double precision |  | Amount value |
| extendedinfoformall.vatexemptnewnet | double precision |  |  |
| extendedinfoformall.vatexemptoldnet | double precision |  |  |
| extendedinfoformall.vatexemptrefundamount | double precision |  | Amount value |
| extendedinfoformall.vatexemptvoidamount | double precision |  | Amount value |
| extendedinfoformall.voidamount | double precision |  | Amount value |
| extendedinfoformall.voidtrxcount | double precision |  | Count/quantity |
| grosssales | double precision |  |  |
| headcount | double precision |  | Count/quantity |
| medalofvalordiscount | double precision |  | Count/quantity |
| minno | character varying |  |  |
| netsales | double precision |  |  |
| newgross | double precision |  |  |
| newnet | double precision |  |  |
| oldgross | double precision |  |  |
| oldnet | double precision |  |  |
| ptu | character varying |  |  |
| pwddiscount | double precision |  | Count/quantity |
| refundamount | double precision |  | Amount value |
| refundtrxcount | double precision |  | Count/quantity |
| regulardiscount | double precision |  | Count/quantity |
| salestrxcount | double precision |  | Count/quantity |
| scdiscount | double precision |  | Count/quantity |
| serialno | character varying |  |  |
| servicecharge | numeric |  |  |
| servicechargetax | double precision |  |  |
| soloparentdiscount | double precision |  | Count/quantity |
| startornumber | character varying |  |  |
| starttrxnumber | character varying |  |  |
| tin | character varying |  |  |
| totaldeductedvat | double precision |  |  |
| transactionswithathleteandcoachdiscount | double precision |  | Count/quantity |
| transactionswithmedalofvalordiscount | double precision |  | Count/quantity |
| transactionswithpwddiscount | double precision |  | Count/quantity |
| transactionswithregulardiscount | double precision |  | Count/quantity |
| transactionswithscdiscount | double precision |  | Count/quantity |
| vatablesales | double precision |  |  |
| vatamount | double precision |  | Amount value |
| vatexemptsales | double precision |  |  |
| zcount | double precision |  | Count/quantity |
| zendtime | timestamp without time zone |  | Timestamp |
| zeroratedsales | double precision |  |  |
| zstarttime | timestamp without time zone |  | Timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### registerlocalsettings__localsettings
- **Row Count:** 349,408
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| registerlocalsettings_foreignkey | character varying | FK | Foreign key to registerlocalsettings |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| key | character varying |  |  |
| value | character varying |  |  |

**Relationships:**
- `registerlocalsettings_foreignkey` → `registerlocalsettings._id`

#### suppliers
- **Row Count:** 300,459
- **Columns:** 15
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| city | character varying |  |  |
| contactname | character varying |  |  |
| country | character varying |  | Country code |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| fax | character varying |  |  |
| name | character varying |  | Display name |
| phone | character varying |  | Phone number |
| postalcode | character varying |  |  |
| state | character varying |  |  |
| street1 | character varying |  |  |
| street2 | character varying |  |  |
| website | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### purchaseorders
- **Row Count:** 289,254
- **Columns:** 20
- **Relationships:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| inventorychangemsgtrackinfo.eventid | character varying | FK | Reference to inventorychangemsgtrackinfo.event |
| purchaseorderid | double precision | FK | Reference to purchaseorder |
| supplierid | character varying | FK | Reference to supplier |
| targetstoreid | character varying | FK | Reference to targetstore |
| completedby | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discount | numeric |  | Discount amount |
| expectedarrivaldate | timestamp without time zone |  | Date |
| failedtoupdateinventory | boolean |  |  |
| inventorychangemsgtrackinfo.issendmsg | boolean |  |  |
| inventorychangemsgtrackinfo.sendmsgstartat | timestamp without time zone |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| notes | character varying |  |  |
| status | character varying |  | Record status |
| subtotal | numeric |  | Subtotal before tax/discount |
| tax | numeric |  | Tax amount |
| total | numeric |  | Total amount |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `purchaseorderid` → `orders._id` *(inferred)*
- `supplierid` → `suppliers._id` *(inferred)*
- `targetstoreid` → `businesses__stores._id` *(inferred)*

#### sharedmodifiers__optionvalues
- **Row Count:** 172,384
- **Columns:** 10
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| sharedmodifiers_foreignkey | character varying | FK | Foreign key to sharedmodifiers |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdefault | boolean |  |  |
| markedsoldout | boolean |  |  |
| order | double precision |  |  |
| pricediff | double precision |  |  |
| pricediffbeforegstadjustment | double precision |  |  |
| soldoutstoreids | character varying |  |  |
| value | character varying |  |  |

**Relationships:**
- `sharedmodifiers_foreignkey` → `sharedmodifiers._id`

#### reviewinfohistories
- **Row Count:** 128,507
- **Columns:** 11
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| placeid | character varying | FK | Reference to place |
| refid | character varying | FK | Reference to ref |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| pricelevel | double precision |  |  |
| rating | double precision |  |  |
| ratingcount | double precision |  | Count/quantity |
| reftype | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### subscriptions
- **Row Count:** 59,084
- **Columns:** 10
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| softwareorderid | character varying | FK | Reference to softwareorder |
| subscriptionid | character varying | FK | Reference to subscription |
| creditcardaddedway | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| hasscheduledchanges | boolean |  |  |
| lasteventtime | timestamp without time zone |  | Timestamp |
| softwareorderamount | double precision |  | Amount value |
| subscriptioncreatedtime | timestamp without time zone |  | Timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `softwareorderid` → `orders._id` *(inferred)*

#### storereviews
- **Row Count:** 52,469
- **Columns:** 14
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| placeid | character varying | FK | Reference to place |
| receiptnumber | character varying | FK |  |
| storeid | character varying | FK | Reference to store |
| allowmerchantcontact | boolean |  |  |
| clickcount | double precision |  | Count/quantity |
| comments | character varying |  |  |
| contactname | character varying |  |  |
| contactphone | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| rating | double precision |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### comments
- **Row Count:** 49,467
- **Columns:** 12
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| refid | character varying | FK | Reference to ref |
| userid | character varying | FK | Reference to user |
| content | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdeleted | boolean |  | Soft delete flag |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| type | character varying |  | Type or category |
| useravatar | character varying |  |  |
| useremail | character varying |  |  |
| username | character varying |  |  |

**Relationships:**
- `userid` → `employees._id` *(inferred)*

#### sharedmodifiers
- **Row Count:** 40,830
- **Columns:** 13
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| sharedmodifierid | character varying | FK | Reference to sharedmodifier |
| allowmultiqty | boolean |  |  |
| createdat | timestamp without time zone |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enableselectionamountlimit | boolean |  |  |
| ismodifier | boolean |  |  |
| maxselectionamount | double precision |  | Amount value |
| minselectionamount | double precision |  | Amount value |
| name | character varying |  | Display name |
| updatedat | timestamp without time zone |  |  |
| variationtype | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### feedbacks
- **Row Count:** 34,308
- **Columns:** 12
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| receiptnumber | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| image | character varying |  |  |
| logisticsprovider | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| notes | character varying |  |  |
| reasoncode | character varying |  |  |
| reportertype | character varying |  |  |
| status | double precision |  | Record status |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### qbosettings__qboaccounts
- **Row Count:** 29,017
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| id | character varying | FK | Reference to  |
| qbosettings_foreignkey | character varying | FK | Foreign key to qbosettings |
| classification | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| name | character varying |  | Display name |

**Relationships:**
- `qbosettings_foreignkey` → `qbosettings._id`

#### xerosettings__accounts
- **Row Count:** 25,457
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| id | character varying | FK | Reference to  |
| xerosettings_foreignkey | character varying | FK | Foreign key to xerosettings |
| code | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enablepaymentstoaccount | boolean |  | Count/quantity |
| name | character varying |  | Display name |
| type | character varying |  | Type or category |

**Relationships:**
- `xerosettings_foreignkey` → `xerosettings._id`

#### registerlocalsettings
- **Row Count:** 21,748
- **Columns:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| registerid | character varying | FK | Reference to register |
| businessname | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

#### purchaseorders__ordereditems__componentsusages
- **Row Count:** 21,380
- **Columns:** 8
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| purchaseorders__ordereditems_foreignkey | character varying | FK | Foreign key to purchaseorders__ordereditems |
| purchaseorders_foreignkey | character varying | FK | Foreign key to purchaseorders |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| lockeddate | timestamp without time zone |  | Date |
| lockedquantity | double precision |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `purchaseorders__ordereditems_foreignkey` → `purchaseorders__ordereditems._id`
- `purchaseorders_foreignkey` → `purchaseorders._id`
- `productid` → `products._id` *(inferred)*

#### subscriptionorders
- **Row Count:** 21,109
- **Columns:** 22
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| paymentid | character varying | FK | Reference to payment |
| planid | character varying | FK | Reference to plan |
| shortid | character varying | FK | Reference to short |
| action | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discountamount | double precision |  | Amount value |
| errorcode | character varying |  |  |
| expirationseconds | double precision |  |  |
| isb2bpayment | boolean |  |  |
| numberofrenewals | double precision |  |  |
| ordertype | character varying |  |  |
| outdated | boolean |  |  |
| paymentgateway | character varying |  |  |
| paymentmethod | character varying |  |  |
| paymentprovider | character varying |  |  |
| price | double precision |  | Unit price |
| status | character varying |  | Record status |
| taxamount | double precision |  | Amount value |
| updatedtime | timestamp without time zone |  | Last update timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### einvoicerequestrecords
- **Row Count:** 20,478
- **Columns:** 21
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| requestor.requestorid | character varying | FK | Reference to requestor.requestor |
| requestresult.documentid | character varying | FK | Reference to requestresult.document |
| requestresult.documentlongid | character varying | FK | Reference to requestresult.documentlong |
| requestresult.submitid | character varying | FK | Reference to requestresult.submit |
| storeid | character varying | FK | Reference to store |
| addonrequestinfo | character varying |  |  |
| createdat | timestamp without time zone |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| einvoicedocumenttype | character varying |  |  |
| isonline | boolean |  |  |
| rawrequestinfo | character varying |  |  |
| receiptnumbers | character varying |  |  |
| requestor.requestortype | character varying |  |  |
| requestresult.einvoicestatus | character varying |  |  |
| requestresult.errormessage | character varying |  |  |
| requestresult.statusupdatedat | timestamp without time zone |  |  |
| requesttype | character varying |  |  |
| submitcontent | character varying |  |  |
| updatedat | timestamp without time zone |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### bankaccounts
- **Row Count:** 17,812
- **Columns:** 12
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| appliedstores | character varying |  |  |
| bankaccountnumber | character varying |  |  |
| bankcode | character varying |  |  |
| bankname | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| emails | character varying |  |  |
| holdername | character varying |  |  |
| isdeleted | boolean |  | Soft delete flag |
| updatedtime | timestamp without time zone |  | Last update timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### shareinforequests
- **Row Count:** 11,384
- **Columns:** 16
- **Relationships:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| consumerid | character varying | FK | Reference to consumer |
| customerid | character varying | FK | Reference to customer |
| employeeid | character varying | FK | Reference to employee |
| registerid | character varying | FK | Reference to register |
| storeid | character varying | FK | Reference to store |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| expireddate | timestamp without time zone |  | Date |
| isnewcustomer | boolean |  |  |
| isnewmember | boolean |  |  |
| merchantname | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| scanneddate | timestamp without time zone |  | Date |
| sharedinfodate | timestamp without time zone |  | Date |
| source | character varying |  |  |

**Relationships:**
- `consumerid` → `consumers._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `employeeid` → `employees._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### subscriptions__addons
- **Row Count:** 11,129
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| id | character varying | FK | Reference to  |
| subscriptions_foreignkey | character varying | FK | Foreign key to subscriptions |
| count | double precision |  | Count/quantity |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| unitprice | double precision |  |  |

**Relationships:**
- `subscriptions_foreignkey` → `subscriptions._id`

#### reviewinfos
- **Row Count:** 7,525
- **Columns:** 11
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| placeid | character varying | FK | Reference to place |
| refid | character varying | FK | Reference to ref |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| pricelevel | double precision |  |  |
| rating | double precision |  |  |
| ratingcount | double precision |  | Count/quantity |
| reftype | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### customtransactionfeerates
- **Row Count:** 6,757
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### customtransactionfeerates__rateconfig
- **Row Count:** 6,757
- **Columns:** 9
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| customtransactionfeerates_foreignkey | character varying | FK | Foreign key to customtransactionfeerates |
| beepdelivery | double precision |  |  |
| beepinstore | double precision |  |  |
| beeppickup | double precision |  |  |
| beepselfdelivery | double precision |  |  |
| beeptakeaway | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| ecommerce | double precision |  |  |

**Relationships:**
- `customtransactionfeerates_foreignkey` → `customtransactionfeerates._id`

#### userjobs
- **Row Count:** 5,589
- **Columns:** 11
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| employeeid | character varying | FK | Reference to employee |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| error | character varying |  |  |
| jobtype | character varying |  |  |
| progress | double precision |  |  |
| resultsfile | character varying |  |  |
| status | character varying |  | Record status |
| time | timestamp without time zone |  | Timestamp |
| uploadedfile | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `employeeid` → `employees._id` *(inferred)*

#### qbosettings__qbotaxcodes
- **Row Count:** 4,447
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| qbosettings_foreignkey | character varying | FK | Foreign key to qbosettings |
| taxcodeid | character varying | FK | Reference to taxcode |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| taxcodename | character varying |  |  |

**Relationships:**
- `qbosettings_foreignkey` → `qbosettings._id`

#### timesheets
- **Row Count:** 3,752
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| employeeid | character varying | FK | Reference to employee |
| storeid | character varying | FK | Reference to store |
| clockinimage | character varying |  |  |
| clockintime | timestamp without time zone |  | Timestamp |
| clockoutimage | character varying |  |  |
| clockouttime | timestamp without time zone |  | Timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `employeeid` → `employees._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### qbosettings
- **Row Count:** 2,398
- **Columns:** 24
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| companyid | character varying | FK | Reference to company |
| customerid | character varying | FK | Reference to customer |
| refundfromaccountid | character varying | FK | Reference to refundfromaccount |
| accesstoken | character varying |  |  |
| accesstokenexpiresin | double precision |  |  |
| accesstokensecret | character varying |  |  |
| accountmapping | character varying |  |  |
| businessname | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| firstconnected | boolean |  |  |
| hasrequestedstart | boolean |  |  |
| isallproductsmatched | boolean |  |  |
| pausereason | character varying |  |  |
| paymentmethodmapping | character varying |  |  |
| refreshtoken | character varying |  |  |
| refreshtokenexpiresin | double precision |  |  |
| requesttoken | character varying |  |  |
| requesttokensecret | character varying |  |  |
| starttime | timestamp without time zone |  | Timestamp |
| state | character varying |  |  |
| status | character varying |  | Record status |
| taxcodemapping | character varying |  |  |
| unmappedtaxcode | character varying |  |  |

**Relationships:**
- `customerid` → `customers._id` *(inferred)*

#### xerosettings
- **Row Count:** 539
- **Columns:** 29
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| companyid | character varying | FK | Reference to company |
| customerid | character varying | FK | Reference to customer |
| refundfromaccountid | character varying | FK | Reference to refundfromaccount |
| accesstoken | character varying |  |  |
| accesstokenexpiresin | double precision |  |  |
| accesstokensecret | character varying |  |  |
| accountmapping | character varying |  |  |
| businessname | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| expiresat | double precision |  |  |
| firstconnected | boolean |  |  |
| hasrequestedstart | boolean |  |  |
| isallproductsmatched | boolean |  |  |
| oauthexpiresat | timestamp without time zone |  |  |
| oauthsessionhandle | character varying |  |  |
| organizationname | character varying |  |  |
| pausereason | character varying |  |  |
| paymentmethodmapping | character varying |  |  |
| previousstatus | character varying |  |  |
| refreshtoken | character varying |  |  |
| refreshtokenexpiresin | double precision |  |  |
| requesttoken | character varying |  |  |
| requesttokensecret | character varying |  |  |
| starttime | timestamp without time zone |  | Timestamp |
| state | character varying |  |  |
| status | character varying |  | Record status |
| taxcodemapping | character varying |  |  |
| unmappedtaxcode | character varying |  |  |

**Relationships:**
- `customerid` → `customers._id` *(inferred)*

#### xerosettings__taxcodes
- **Row Count:** 430
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| taxcodeid | character varying | FK | Reference to taxcode |
| xerosettings_foreignkey | character varying | FK | Foreign key to xerosettings |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| taxcodename | character varying |  |  |

**Relationships:**
- `xerosettings_foreignkey` → `xerosettings._id`

#### shifts
- **Row Count:** 365
- **Columns:** 36
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| qboinvoiceid | character varying | FK | Reference to qboinvoice |
| registerid | character varying | FK | Reference to register |
| registerobjectid | character varying | FK | Reference to registerobject |
| shiftid | character varying | FK | Reference to shift |
| storeid | character varying | FK | Reference to store |
| beeptransactionids | character varying |  |  |
| beeptransactions | character varying |  |  |
| cancelledamount | double precision |  | Amount value |
| cancelledcount | double precision |  | Count/quantity |
| cashreturnsroundedamount | double precision |  | Amount value |
| cashsalesroundedamount | double precision |  | Amount value |
| closeby | character varying |  |  |
| closetime | timestamp without time zone |  | Timestamp |
| closingamount | double precision |  | Amount value |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| detailaccountingsyncstatus | character varying |  |  |
| discountedamount | double precision |  | Amount value |
| discountedcount | double precision |  | Count/quantity |
| enablecashback | boolean |  |  |
| isaccountingsynced | boolean |  |  |
| loyaltydiscounts | character varying |  |  |
| minno | character varying |  |  |
| openby | character varying |  |  |
| openingamount | double precision |  | Amount value |
| opentime | timestamp without time zone |  | Timestamp |
| qbosynctime | double precision |  | Timestamp |
| registerappversion | character varying |  |  |
| registertransactionids | character varying |  |  |
| registertransactions | character varying |  |  |
| returnsroundedamount | double precision |  | Amount value |
| salesroundedamount | double precision |  | Amount value |
| servicecharge | character varying |  |  |
| totalsalesamount | double precision |  | Amount value |
| transactioncount | double precision |  | Count/quantity |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### shifts__taxsummary
- **Row Count:** 282
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shifts_foreignkey | character varying | FK | Foreign key to shifts |
| taxcodeid | character varying | FK | Reference to taxcode |
| amount | numeric |  | Monetary amount |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| name | character varying |  | Display name |
| rate | double precision |  |  |

**Relationships:**
- `shifts_foreignkey` → `shifts._id`

#### searchingtags
- **Row Count:** 151
- **Columns:** 7

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| createdby | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| tagname | character varying |  |  |
| tagtype | character varying |  |  |
| updatedtime | timestamp without time zone |  | Last update timestamp |

#### marketingtags
- **Row Count:** 56
- **Columns:** 8

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses | character varying |  |  |
| createdby | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedby | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| tagname | character varying |  |  |

---

## Payments
**Tables:** 14 | **Total Rows:** 137,749,178

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `paymentrecordlogs` | 72,977,328 | 12 | Paymentrecordlogs |
| `payoutitems` | 19,231,310 | 34 | Payoutitems |
| `payoutitems__storehubdetails` | 19,231,310 | 7 | Payoutitems  Storehubdetails |
| `paymentrecords` | 12,433,804 | 40 | Paymentrecords |
| `gatewayrecords` | 10,244,168 | 16 | Gatewayrecords |
| `zreadings__paymentcollections` | 2,775,077 | 6 | Zreadings  Paymentcollections |
| `batchpayouts` | 486,016 | 32 | Batchpayouts |
| `paymentsettlements__orders` | 268,970 | 17 | Paymentsettlements  Orders |
| `payoutitems__adjustmentdetails__adjustmentitems` | 50,257 | 10 | Payoutitems  Adjustmentdetails  Adjustmentitems |
| `payoutitems__adjustmentdetails` | 48,582 | 6 | Payoutitems  Adjustmentdetails |
| `qbosettings__qbopaymentmethods` | 1,375 | 5 | Qbosettings  Qbopaymentmethods |
| `onlinestoreinfos__offlinepaymentinstructions` | 470 | 5 | Onlinestoreinfos  Offlinepaymentinstructions |
| `onlinestoreinfos__offlinepaymentbankaccounts` | 437 | 7 | Onlinestoreinfos  Offlinepaymentbankaccounts |
| `onlinestoreinfos__onlinepaymentoptions` | 74 | 6 | Onlinestoreinfos  Onlinepaymentoptions |

### Detailed Schemas

#### paymentrecordlogs
- **Row Count:** 72,977,328
- **Columns:** 12
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| paymentrecordid | character varying | FK | Reference to paymentrecord |
| receiptnumber | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| logtime | timestamp without time zone |  | Timestamp |
| metadata | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| operator | character varying |  |  |
| remark | character varying |  |  |
| source | character varying |  |  |
| status | character varying |  | Record status |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### payoutitems
- **Row Count:** 19,231,310
- **Columns:** 34
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| batchpayoutid | character varying | FK | Reference to batchpayout |
| receiptnumber | character varying | FK |  |
| refid | character varying | FK | Reference to ref |
| storeid | character varying | FK | Reference to store |
| amount | numeric |  | Monetary amount |
| businessname | character varying |  |  |
| cause | character varying |  |  |
| countrycode | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliveryrevenue | double precision |  |  |
| logisticsfee | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| offlinepaidamount | double precision |  | Amount value |
| orderamount | double precision |  | Amount value |
| orderpromotionamount | double precision |  | Amount value |
| ordervoucheramount | double precision |  | Amount value |
| paidamount | double precision |  | Amount value |
| paymentgateway | character varying |  |  |
| paymentgatewayfee | double precision |  |  |
| payoutstatus | character varying |  |  |
| payouttype | character varying |  |  |
| pickupsmsfee | double precision |  |  |
| productrevenue | double precision |  |  |
| promotionamount | double precision |  | Amount value |
| reconstatus | character varying |  |  |
| reftype | character varying |  |  |
| refundedamount | double precision |  | Amount value |
| settledat | timestamp without time zone |  |  |
| shippingtype | character varying |  |  |
| transactionfee | double precision |  |  |
| transactionfeerate | double precision |  |  |
| voucheramount | double precision |  | Amount value |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### payoutitems__storehubdetails
- **Row Count:** 19,231,310
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| payoutitems_foreignkey | character varying | FK | Foreign key to payoutitems |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| paymentgatewaycost | double precision |  |  |
| paymentgatewayrevenue | double precision |  |  |
| storehublogisticscost | double precision |  |  |
| storehublogisticsrevenue | double precision |  |  |

**Relationships:**
- `payoutitems_foreignkey` → `payoutitems._id`

#### paymentrecords
- **Row Count:** 12,433,804
- **Columns:** 40
- **Relationships:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| paymentid | character varying | FK | Reference to payment |
| paymentmethodid | character varying | FK | Reference to paymentmethod |
| paymentrecordid | character varying | FK | Reference to paymentrecord |
| provideraccountid | character varying | FK | Reference to provideraccount |
| receiptnumber | character varying | FK |  |
| refundid | character varying | FK | Reference to refund |
| refundrequestid | character varying | FK | Reference to refundrequest |
| storeid | character varying | FK | Reference to store |
| userid | character varying | FK | Reference to user |
| amount | numeric |  | Monetary amount |
| cancelledat | timestamp without time zone |  |  |
| cardholdername | character varying |  |  |
| cardtoken | character varying |  |  |
| cardtype | character varying |  |  |
| createdat | timestamp without time zone |  |  |
| currency | character varying |  | Currency code |
| cvctoken | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| encryptedcardinfo | character varying |  |  |
| isinternal | boolean |  |  |
| issuercountry | character varying |  |  |
| issuername | character varying |  |  |
| lasterror | character varying |  |  |
| lasterrorcode | character varying |  |  |
| metadata | character varying |  |  |
| nonce | character varying |  |  |
| notificationack | boolean |  |  |
| payactionway | character varying |  |  |
| paymentoption | character varying |  |  |
| paymenttype | character varying |  |  |
| provider | character varying |  |  |
| provideroption | character varying |  |  |
| redirecturl | character varying |  |  |
| shippingtype | character varying |  |  |
| source | character varying |  |  |
| status | character varying |  | Record status |
| updatedat | timestamp without time zone |  |  |
| webhookurl | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*
- `userid` → `employees._id` *(inferred)*

#### gatewayrecords
- **Row Count:** 10,244,168
- **Columns:** 16
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| paymentrecordid | character varying | FK | Reference to paymentrecord |
| receiptnumber | character varying | FK |  |
| transactionid | character varying | FK | Reference to transaction |
| country | character varying |  | Country code |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| fee | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| net | double precision |  |  |
| paymentgateway | character varying |  |  |
| reconstatus | character varying |  |  |
| settlementtime | timestamp without time zone |  | Timestamp |
| transactionamount | double precision |  | Amount value |
| transactiontype | character varying |  |  |
| transferstatus | character varying |  |  |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `transactionid` → `transactionrecords.receiptnumber` *(inferred)*

#### zreadings__paymentcollections
- **Row Count:** 2,775,077
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| zreadings_foreignkey | character varying | FK | Foreign key to zreadings |
| amount | numeric |  | Monetary amount |
| count | double precision |  | Count/quantity |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| name | character varying |  | Display name |

**Relationships:**
- `zreadings_foreignkey` → `zreadings._id`

#### batchpayouts
- **Row Count:** 486,016
- **Columns:** 32

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| bankaccountid | character varying | FK | Reference to bankaccount |
| businessname | character varying |  |  |
| countrycode | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| currency | character varying |  | Currency code |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enddate | timestamp without time zone |  | Date |
| merchantbankaccountname | character varying |  |  |
| merchantbankaccountnumber | character varying |  |  |
| merchantbankcode | character varying |  |  |
| merchantbankname | character varying |  |  |
| merchanttotaldeliveryrevenue | double precision |  |  |
| merchanttotalproductrevenue | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| payoutitemcount | double precision |  | Count/quantity |
| startdate | timestamp without time zone |  | Date |
| storeids | character varying |  |  |
| totaladjustments | double precision |  |  |
| totalbanktransactionfee | double precision |  |  |
| totalofflinepaidamount | double precision |  | Amount value |
| totalorderamount | double precision |  | Amount value |
| totalorderpayout | double precision |  |  |
| totalorderpromotionamount | double precision |  | Amount value |
| totalordervoucheramount | double precision |  | Amount value |
| totalpaymentgatewayfee | double precision |  |  |
| totalpayout | double precision |  |  |
| totalpickupsmsfee | double precision |  |  |
| totalpromotionamount | double precision |  | Amount value |
| totalstorehubfee | double precision |  |  |
| totalstorehublogisticsfee | double precision |  |  |
| totalvoucheramount | double precision |  | Amount value |

#### paymentsettlements__orders
- **Row Count:** 268,970
- **Columns:** 17
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| paymentsettlements_foreignkey | character varying | FK | Foreign key to paymentsettlements |
| receiptnumber | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliveryrevenue | double precision |  |  |
| paymentgateway | character varying |  |  |
| paymentgatewaycost | double precision |  |  |
| paymentgatewayfee | double precision |  |  |
| paymentgatewayrevenue | double precision |  |  |
| payout | double precision |  |  |
| productrevenue | double precision |  |  |
| storehubfee | double precision |  |  |
| storehublogisticscost | double precision |  |  |
| storehublogisticsfee | double precision |  |  |
| storehublogisticsrevenue | double precision |  |  |
| total | numeric |  | Total amount |

**Relationships:**
- `paymentsettlements_foreignkey` → `paymentsettlements._id`
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### payoutitems__adjustmentdetails__adjustmentitems
- **Row Count:** 50,257
- **Columns:** 10
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| payoutitems__adjustmentdetails_foreignkey | character varying | FK | Foreign key to payoutitems__adjustmentdetails |
| payoutitems_foreignkey | character varying | FK | Foreign key to payoutitems |
| refid | character varying | FK | Reference to ref |
| amount | numeric |  | Monetary amount |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| quantity | double precision |  | Quantity |
| reftype | character varying |  |  |
| title | character varying |  | Title or name |
| type | character varying |  | Type or category |

**Relationships:**
- `payoutitems__adjustmentdetails_foreignkey` → `payoutitems__adjustmentdetails._id`
- `payoutitems_foreignkey` → `payoutitems._id`

#### payoutitems__adjustmentdetails
- **Row Count:** 48,582
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| payoutitems_foreignkey | character varying | FK | Foreign key to payoutitems |
| amount | numeric |  | Monetary amount |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| reason | character varying |  |  |
| remarks | character varying |  |  |

**Relationships:**
- `payoutitems_foreignkey` → `payoutitems._id`

#### qbosettings__qbopaymentmethods
- **Row Count:** 1,375
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| paymentmethodid | character varying | FK | Reference to paymentmethod |
| qbosettings_foreignkey | character varying | FK | Foreign key to qbosettings |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| paymentmethodname | character varying |  |  |

**Relationships:**
- `qbosettings_foreignkey` → `qbosettings._id`

#### onlinestoreinfos__offlinepaymentinstructions
- **Row Count:** 470
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| additionalnotes | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enabledcontactinfo | character varying |  |  |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__offlinepaymentbankaccounts
- **Row Count:** 437
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| bankaccountname | character varying |  |  |
| bankaccountnumber | character varying |  |  |
| bankname | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| ordering | double precision |  |  |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__onlinepaymentoptions
- **Row Count:** 74
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| additionalinfo | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdisabled | boolean |  |  |
| name | character varying |  | Display name |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

---

## Products
**Tables:** 11 | **Total Rows:** 106,623,330

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `products` | 33,301,429 | 67 | Product catalog and inventory |
| `products__variations__optionvalues` | 29,309,572 | 11 | Product variants (size, color, etc) |
| `products__variationvalues` | 19,545,805 | 5 | Products  Variationvalues |
| `products__variations` | 7,396,980 | 12 | Product variants (size, color, etc) |
| `products__quickselectpositions` | 6,043,581 | 8 | Products  Quickselectpositions |
| `products__stocktakes` | 5,717,724 | 8 | Products  Stocktakes |
| `products__pricebooks` | 2,967,002 | 8 | Pricing rules for products |
| `products__components` | 1,104,444 | 5 | Products  Components |
| `products__variations__optionvalues__soldoutstores` | 724,208 | 6 | Product variants (size, color, etc) |
| `products__soldoutstores` | 488,470 | 5 | Products  Soldoutstores |
| `products__beerdocketsettings` | 24,115 | 6 | Products  Beerdocketsettings |

### Detailed Schemas

#### products
- **Row Count:** 33,301,429
- **Columns:** 67
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| externalid | character varying | FK | Reference to external |
| original_id | character varying | FK | Reference to original_ |
| originalid | character varying | FK | Reference to original |
| parentproductid | character varying | FK | Reference to parentproduct |
| supplierid | character varying | FK | Reference to supplier |
| barcode | character varying |  |  |
| beforegstadjustment | character varying |  |  |
| category | character varying |  |  |
| classificationcode | character varying |  |  |
| cost | numeric |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deletedbarcode | character varying |  |  |
| deletedskunumber | character varying |  |  |
| description | character varying |  | Description text |
| descriptionimages | character varying |  |  |
| detailedinfo | character varying |  |  |
| foodpandaprice | double precision |  |  |
| grabfoodprice | double precision |  |  |
| hasthumbnail | boolean |  |  |
| images | character varying |  |  |
| inventorystartdate | timestamp without time zone |  | Date |
| inventorytype | character varying |  |  |
| isbasicnecessitiesph | boolean |  |  |
| ischild | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| ishalal | boolean |  |  |
| isonbeep | boolean |  |  |
| isonfoodpanda | boolean |  |  |
| isongrabfood | boolean |  |  |
| isonline | boolean |  |  |
| isonshopeefood | boolean |  |  |
| issample | boolean |  |  |
| isserialized | boolean |  |  |
| issoloparentdiscountapplicable | boolean |  |  |
| kitchenprinter | character varying |  |  |
| lastsupplierprice | double precision |  |  |
| lastupdatethumbnail | timestamp without time zone |  |  |
| loyalty | double precision |  |  |
| markedsoldout | boolean |  |  |
| maxrefunitprice | double precision |  |  |
| minrefunitprice | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| onlinesaleprice | double precision |  |  |
| onlinetitle | character varying |  |  |
| onlineunitprice | double precision |  |  |
| onlyforpreorder | boolean |  |  |
| pricetype | character varying |  |  |
| producttype | character varying |  |  |
| shopeefoodprice | double precision |  |  |
| skunumber | character varying |  |  |
| slug | character varying |  |  |
| soldoutstoreids | character varying |  |  |
| supplierids | character varying |  |  |
| tags | character varying |  |  |
| taxcode | character varying |  |  |
| title | character varying |  | Title or name |
| trackinventory | boolean |  |  |
| unit | character varying |  |  |
| unitprice | double precision |  |  |
| validdays | character varying |  |  |
| validfrom | timestamp without time zone |  |  |
| validtimefrom | double precision |  |  |
| validtimeto | double precision |  |  |
| validto | timestamp without time zone |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `parentproductid` → `products._id` *(inferred)*
- `supplierid` → `suppliers._id` *(inferred)*

#### products__variations__optionvalues
- **Row Count:** 29,309,572
- **Columns:** 11
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products__variations_foreignkey | character varying | FK | Foreign key to products__variations |
| products_foreignkey | character varying | FK | Foreign key to products |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdefault | boolean |  |  |
| markedsoldout | boolean |  |  |
| order | double precision |  |  |
| pricediff | double precision |  |  |
| pricediffbeforegstadjustment | double precision |  |  |
| soldoutstoreids | character varying |  |  |
| value | character varying |  |  |

**Relationships:**
- `products__variations_foreignkey` → `products__variations._id`
- `products_foreignkey` → `products._id`

#### products__variationvalues
- **Row Count:** 19,545,805
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products_foreignkey | character varying | FK | Foreign key to products |
| variationid | character varying | FK | Reference to variation |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| value | character varying |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`

#### products__variations
- **Row Count:** 7,396,980
- **Columns:** 12
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products_foreignkey | character varying | FK | Foreign key to products |
| sharedmodifierid | character varying | FK | Reference to sharedmodifier |
| allowmultiqty | boolean |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enableselectionamountlimit | boolean |  |  |
| ismodifier | boolean |  |  |
| maxselectionamount | double precision |  | Amount value |
| minselectionamount | double precision |  | Amount value |
| name | character varying |  | Display name |
| order | double precision |  |  |
| variationtype | character varying |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`

#### products__quickselectpositions
- **Row Count:** 6,043,581
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| categoryid | character varying | FK | Reference to category |
| layoutid | character varying | FK | Reference to layout |
| products_foreignkey | character varying | FK | Foreign key to products |
| backgroundcolor | character varying |  |  |
| column | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| row | double precision |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`

#### products__stocktakes
- **Row Count:** 5,717,724
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products_foreignkey | character varying | FK | Foreign key to products |
| stocktakeid | character varying | FK | Reference to stocktake |
| countedat | timestamp without time zone |  |  |
| countedqty | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| failedtoupdateinventory | boolean |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `products_foreignkey` → `products._id`

#### products__pricebooks
- **Row Count:** 2,967,002
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| pricebookid | character varying | FK | Reference to pricebook |
| products_foreignkey | character varying | FK | Foreign key to products |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| max | double precision |  |  |
| min | double precision |  |  |
| taxcode | character varying |  |  |
| unitprice | double precision |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`

#### products__components
- **Row Count:** 1,104,444
- **Columns:** 5
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| products_foreignkey | character varying | FK | Foreign key to products |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| usages | character varying |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`
- `productid` → `products._id` *(inferred)*

#### products__variations__optionvalues__soldoutstores
- **Row Count:** 724,208
- **Columns:** 6
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products__variations__optionvalues_foreignkey | character varying | FK | Foreign key to products__variations__optionvalues |
| products_foreignkey | character varying | FK | Foreign key to products |
| storeid | character varying | FK | Reference to store |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| duration | double precision |  |  |

**Relationships:**
- `products__variations__optionvalues_foreignkey` → `products__variations__optionvalues._id`
- `products_foreignkey` → `products._id`
- `storeid` → `businesses__stores._id` *(inferred)*

#### products__soldoutstores
- **Row Count:** 488,470
- **Columns:** 5
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products_foreignkey | character varying | FK | Foreign key to products |
| storeid | character varying | FK | Reference to store |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| duration | double precision |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`
- `storeid` → `businesses__stores._id` *(inferred)*

#### products__beerdocketsettings
- **Row Count:** 24,115
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| products_foreignkey | character varying | FK | Foreign key to products |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| docketcount | double precision |  | Count/quantity |
| expirationdateduration | double precision |  |  |
| isenable | boolean |  |  |

**Relationships:**
- `products_foreignkey` → `products._id`

---

## Loyalty
**Tables:** 5 | **Total Rows:** 55,238,348

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `loyaltychangelogs` | 54,576,038 | 14 | Customer loyalty point transactions |
| `pointchangelogs__points` | 366,525 | 5 | Pointchangelogs  Points |
| `customerpoints` | 291,139 | 13 | Customerpoints |
| `rewardsettings` | 4,620 | 17 | Rewardsettings |
| `rewardssets` | 26 | 7 | Rewardssets |

### Detailed Schemas

#### loyaltychangelogs
- **Row Count:** 54,576,038
- **Columns:** 14
- **Relationships:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| customerid | character varying | FK | Reference to customer |
| receiptnumber | character varying | FK |  |
| transactionid | character varying | FK | Reference to transaction |
| amount | numeric |  | Monetary amount |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| dataversion | double precision |  |  |
| defaultloyaltyratio | double precision |  |  |
| eventtime | timestamp without time zone |  | Timestamp |
| eventtype | character varying |  |  |
| loyaltyperproduct | character varying |  |  |
| rewardtype | character varying |  |  |
| source | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `transactionid` → `transactionrecords.receiptnumber` *(inferred)*

#### pointchangelogs__points
- **Row Count:** 366,525
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| pointchangelogs_foreignkey | character varying | FK | Foreign key to pointchangelogs |
| pointid | character varying | FK | Reference to point |
| changeamount | double precision |  | Amount value |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `pointchangelogs_foreignkey` → `pointchangelogs._id`

#### customerpoints
- **Row Count:** 291,139
- **Columns:** 13
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| customerid | character varying | FK | Reference to customer |
| sourcerefid | character varying | FK | Reference to sourceref |
| balance | double precision |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| earnpointsunit | double precision |  |  |
| expirydate | timestamp without time zone |  | Date |
| merchantname | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| pointrate | double precision |  |  |
| source | character varying |  |  |
| total | numeric |  | Total amount |

**Relationships:**
- `customerid` → `customers._id` *(inferred)*

#### rewardsettings
- **Row Count:** 4,620
- **Columns:** 17

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| rewardgroupid | character varying | FK | Reference to rewardgroup |
| rewardrefid | character varying | FK | Reference to rewardref |
| aheadofdays | double precision |  |  |
| costofpoints | double precision |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdeleted | boolean |  | Soft delete flag |
| isenabled | boolean |  |  |
| isstackable | boolean |  |  |
| merchantname | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| rewardsource | character varying |  |  |
| rewardtype | character varying |  |  |
| tierlevel | double precision |  |  |
| validperiod | double precision |  |  |
| validperiodunit | character varying |  |  |

#### rewardssets
- **Row Count:** 26
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isenabled | boolean |  |  |
| type | character varying |  | Type or category |
| updatedtime | timestamp without time zone |  | Last update timestamp |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

---

## Customers
**Tables:** 2 | **Total Rows:** 53,398,948

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `customers` | 47,663,764 | 53 | Customer profiles and information |
| `consumers` | 5,735,184 | 22 | Consumers |

### Detailed Schemas

#### customers
- **Row Count:** 47,663,764
- **Columns:** 53
- **Relationships:** 9

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| consumerid | character varying | FK | Reference to consumer |
| createdatstoreid | character varying | FK | Reference to createdatstore |
| customerid | character varying | FK | Reference to customer |
| firstpurchaseinfo.employeeid | character varying | FK | Reference to firstpurchaseinfo.employee |
| firstpurchaseinfo.registerid | character varying | FK | Reference to firstpurchaseinfo.register |
| firstpurchaseinfo.storeid | character varying | FK | Reference to firstpurchaseinfo.store |
| firstpurchaseinfo.transactionid | character varying | FK | Reference to firstpurchaseinfo.transaction |
| memberid | character varying | FK | Reference to member |
| membershipcreatedatstoreid | character varying | FK | Reference to membershipcreatedatstore |
| membershiptierid | character varying | FK | Reference to membershiptier |
| originalconsumerid | character varying | FK | Reference to originalconsumer |
| sourcerefid | character varying | FK | Reference to sourceref |
| birthday | timestamp without time zone |  |  |
| cashbackclaimcnt | double precision |  |  |
| cashbackexpirationdate | timestamp without time zone |  | Date |
| city | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| facebook | character varying |  |  |
| firstname | character varying |  |  |
| firstpurchaseinfo.date | timestamp without time zone |  | Date |
| firstpurchaseinfo.flag | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| lastcashbackclaimdate | timestamp without time zone |  | Date |
| lastname | character varying |  |  |
| lastpurchasedate | timestamp without time zone |  | Date |
| membershipjointime | timestamp without time zone |  | Timestamp |
| membershipsource | character varying |  |  |
| membershiptierlastchangetime | timestamp without time zone |  | Timestamp |
| membershiptiernextreviewtime | timestamp without time zone |  | Timestamp |
| membershiptierstarttime | timestamp without time zone |  | Timestamp |
| membershiptiertotalspent | double precision |  |  |
| membershiptiertotalspentupdatedtime | timestamp without time zone |  | Timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| phone | character varying |  | Phone number |
| postalcode | character varying |  |  |
| purchasedinstores | character varying |  |  |
| signupbyemployee | character varying |  |  |
| signupfromstore | character varying |  |  |
| source | character varying |  |  |
| state | character varying |  |  |
| storecreditsbalance | double precision |  |  |
| storecreditsspent | double precision |  |  |
| street1 | character varying |  |  |
| street2 | character varying |  |  |
| tags | character varying |  |  |
| taxidno | character varying |  |  |
| tmpcashbackexpirationdate | timestamp without time zone |  | Date |
| totalspent | double precision |  |  |
| totaltransactions | double precision |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `consumerid` → `consumers._id` *(inferred)*
- `createdatstoreid` → `businesses__stores._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `firstpurchaseinfo.employeeid` → `employees._id` *(inferred)*
- `firstpurchaseinfo.storeid` → `businesses__stores._id` *(inferred)*
- `firstpurchaseinfo.transactionid` → `transactionrecords.receiptnumber` *(inferred)*
- `membershipcreatedatstoreid` → `businesses__stores._id` *(inferred)*
- `originalconsumerid` → `consumers._id` *(inferred)*

#### consumers
- **Row Count:** 5,735,184
- **Columns:** 22

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| defaultshippingaddressid | character varying | FK | Reference to defaultshippingaddress |
| alcoholconsenttime | timestamp without time zone |  | Timestamp |
| birthday | timestamp without time zone |  |  |
| birthdaymodifiedtime | timestamp without time zone |  | Timestamp |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| firstname | character varying |  |  |
| gender | character varying |  |  |
| hasusedclevertapversion | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| lastname | character varying |  |  |
| latestappversion | character varying |  |  |
| membership | character varying |  |  |
| mergedto | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| password | character varying |  |  |
| phone | character varying |  | Phone number |
| registrationsource | character varying |  |  |
| registrationtouchpoint | character varying |  |  |
| unverifiedphone | character varying |  |  |

---

## Inventory
**Tables:** 9 | **Total Rows:** 38,235,412

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `stocktransfers__ordereditems` | 18,498,656 | 7 | Stocktransfers  Ordereditems |
| `stocktakeitems` | 13,273,473 | 6 | Stocktakeitems |
| `stockreturns__returneditems` | 3,503,163 | 9 | Stockreturns  Returneditems |
| `stocktransfers` | 1,220,788 | 19 | Stocktransfers |
| `stocktakes` | 1,106,489 | 19 | Stocktakes |
| `stockreturns` | 444,590 | 20 | Stockreturns |
| `stocktransfers__ordereditems__componentsusages` | 139,083 | 8 | Stocktransfers  Ordereditems  Componentsusages |
| `inventorychangeevents` | 45,800 | 24 | Inventorychangeevents |
| `stockreturns__returneditems__componentsusages` | 3,370 | 8 | Stockreturns  Returneditems  Componentsusages |

### Detailed Schemas

#### stocktransfers__ordereditems
- **Row Count:** 18,498,656
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| stocktransfers_foreignkey | character varying | FK | Foreign key to stocktransfers |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isserialized | boolean |  |  |
| quantity | double precision |  | Quantity |
| serialnumbers | character varying |  |  |

**Relationships:**
- `stocktransfers_foreignkey` → `stocktransfers._id`
- `productid` → `products._id` *(inferred)*

#### stocktakeitems
- **Row Count:** 13,273,473
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| stocktakeid | character varying | FK | Reference to stocktake |
| countedqty | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| quantity | double precision |  | Quantity |

**Relationships:**
- `productid` → `products._id` *(inferred)*

#### stockreturns__returneditems
- **Row Count:** 3,503,163
- **Columns:** 9
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| stockreturns_foreignkey | character varying | FK | Foreign key to stockreturns |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isserialized | boolean |  |  |
| returnedquantity | double precision |  |  |
| serialnumbers | character varying |  |  |
| subtotal | numeric |  | Subtotal before tax/discount |
| supplierprice | double precision |  |  |

**Relationships:**
- `stockreturns_foreignkey` → `stockreturns._id`
- `productid` → `products._id` *(inferred)*

#### stocktransfers
- **Row Count:** 1,220,788
- **Columns:** 19
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| inventorychangemsgtrackinfo.eventid | character varying | FK | Reference to inventorychangemsgtrackinfo.event |
| sourcestoreid | character varying | FK | Reference to sourcestore |
| stocktransferid | double precision | FK | Reference to stocktransfer |
| targetstoreid | character varying | FK | Reference to targetstore |
| completedat | timestamp without time zone |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| failedtoupdateinventory | boolean |  |  |
| inventorychangemsgtrackinfo.issendmsg | boolean |  |  |
| inventorychangemsgtrackinfo.sendmsgstartat | timestamp without time zone |  |  |
| markshippedat | timestamp without time zone |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| notes | character varying |  |  |
| receivedby | character varying |  |  |
| shippedby | character varying |  |  |
| shippeddate | timestamp without time zone |  | Date |
| status | character varying |  | Record status |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `sourcestoreid` → `businesses__stores._id` *(inferred)*
- `targetstoreid` → `businesses__stores._id` *(inferred)*

#### stocktakes
- **Row Count:** 1,106,489
- **Columns:** 19
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| inventorychangemsgtrackinfo.eventid | character varying | FK | Reference to inventorychangemsgtrackinfo.event |
| storeid | character varying | FK | Reference to store |
| supplierid | character varying | FK | Reference to supplier |
| completedby | character varying |  |  |
| completetime | timestamp without time zone |  | Timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| description | character varying |  | Description text |
| inventorychangemsgtrackinfo.issendmsg | boolean |  |  |
| inventorychangemsgtrackinfo.sendmsgstartat | timestamp without time zone |  |  |
| iscountedonshmanager | boolean |  |  |
| ismovedtostocktakeitems | boolean |  |  |
| source | character varying |  |  |
| startedby | character varying |  |  |
| starttime | timestamp without time zone |  | Timestamp |
| status | character varying |  | Record status |
| totalcostdiff | double precision |  |  |
| totalqtydiff | double precision |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*
- `supplierid` → `suppliers._id` *(inferred)*

#### stockreturns
- **Row Count:** 444,590
- **Columns:** 20
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| inventorychangemsgtrackinfo.eventid | character varying | FK | Reference to inventorychangemsgtrackinfo.event |
| sourcestoreid | character varying | FK | Reference to sourcestore |
| stockreturnid | double precision | FK | Reference to stockreturn |
| supplierid | character varying | FK | Reference to supplier |
| completedby | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discount | numeric |  | Discount amount |
| failedtoupdateinventory | boolean |  |  |
| inventorychangemsgtrackinfo.issendmsg | boolean |  |  |
| inventorychangemsgtrackinfo.sendmsgstartat | timestamp without time zone |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| name | character varying |  | Display name |
| notes | character varying |  |  |
| status | character varying |  | Record status |
| subtotal | numeric |  | Subtotal before tax/discount |
| tax | numeric |  | Tax amount |
| total | numeric |  | Total amount |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `sourcestoreid` → `businesses__stores._id` *(inferred)*
- `supplierid` → `suppliers._id` *(inferred)*

#### stocktransfers__ordereditems__componentsusages
- **Row Count:** 139,083
- **Columns:** 8
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| stocktransfers__ordereditems_foreignkey | character varying | FK | Foreign key to stocktransfers__ordereditems |
| stocktransfers_foreignkey | character varying | FK | Foreign key to stocktransfers |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| lockeddate | timestamp without time zone |  | Date |
| lockedquantity | double precision |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `stocktransfers__ordereditems_foreignkey` → `stocktransfers__ordereditems._id`
- `stocktransfers_foreignkey` → `stocktransfers._id`
- `productid` → `products._id` *(inferred)*

#### inventorychangeevents
- **Row Count:** 45,800
- **Columns:** 24
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| eventid | character varying | FK | Reference to event |
| sourceinfo.refid | character varying | FK | Reference to sourceinfo.ref |
| storeid | character varying | FK | Reference to store |
| createdat | timestamp without time zone |  |  |
| createinvifnotexist | boolean |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| eventstartat | timestamp without time zone |  |  |
| eventtype | character varying |  |  |
| failedat | timestamp without time zone |  |  |
| failreason | character varying |  |  |
| iseventidscleared | boolean |  |  |
| isneedmanualcheck | boolean |  |  |
| needdedupmsg | boolean |  |  |
| retrycount | double precision |  | Count/quantity |
| rollbackedat | timestamp without time zone |  |  |
| rollbackfailedat | timestamp without time zone |  |  |
| rules | character varying |  |  |
| sourceinfo.customfields | character varying |  |  |
| status | character varying |  | Record status |
| succeededat | timestamp without time zone |  |  |
| updatedat | timestamp without time zone |  |  |
| updaterule | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `storeid` → `businesses__stores._id` *(inferred)*

#### stockreturns__returneditems__componentsusages
- **Row Count:** 3,370
- **Columns:** 8
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| productid | character varying | FK | Reference to product |
| stockreturns__returneditems_foreignkey | character varying | FK | Foreign key to stockreturns__returneditems |
| stockreturns_foreignkey | character varying | FK | Foreign key to stockreturns |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| lockeddate | timestamp without time zone |  | Date |
| lockedquantity | double precision |  |  |
| quantity | double precision |  | Quantity |

**Relationships:**
- `stockreturns__returneditems_foreignkey` → `stockreturns__returneditems._id`
- `stockreturns_foreignkey` → `stockreturns._id`
- `productid` → `products._id` *(inferred)*

---

## Marketing
**Tables:** 13 | **Total Rows:** 13,574,405

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `campaignjobs` | 6,076,635 | 30 | Campaignjobs |
| `campaignjobs__additionalattributes` | 5,529,934 | 4 | Campaignjobs  Additionalattributes |
| `campaignlogs` | 969,614 | 12 | Campaignlogs |
| `promotionclaimcounts` | 390,641 | 12 | Promotionclaimcounts |
| `promotioncustomers` | 274,759 | 19 | Promotioncustomers |
| `promotions` | 231,293 | 44 | Discount and promotion rules |
| `campaignsegments__nestedsource__filters` | 25,499 | 13 | Campaignsegments  Nestedsource  Filters |
| `promotions__requiredproducts` | 19,765 | 9 | Promotions  Requiredproducts |
| `campaignsegments` | 19,346 | 6 | Campaignsegments |
| `campaignsegments__nestedsource` | 19,346 | 5 | Campaignsegments  Nestedsource |
| `campaigns` | 17,481 | 25 | Marketing campaigns |
| `promotions__rewardssettings` | 49 | 7 | Promotions  Rewardssettings |
| `rewardssets__promotionconfigs` | 43 | 6 | Rewardssets  Promotionconfigs |

### Detailed Schemas

#### campaignjobs
- **Row Count:** 6,076,635
- **Columns:** 30
- **Relationships:** 5

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| campaignid | character varying | FK | Reference to campaign |
| consumerid | character varying | FK | Reference to consumer |
| customerid | character varying | FK | Reference to customer |
| globalcampaigninformationid | character varying | FK | Reference to globalcampaigninformation |
| launchid | character varying | FK | Reference to launch |
| lockfreesmscreditlogid | character varying | FK | Reference to lockfreesmscreditlog |
| lockpaidsmscreditlogid | character varying | FK | Reference to lockpaidsmscreditlog |
| messageid | character varying | FK | Reference to message |
| promotioncustomerid | character varying | FK | Reference to promotioncustomer |
| attributes | character varying |  |  |
| channel | character varying |  |  |
| content | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| customeremail | character varying |  |  |
| customerphone | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| delay | double precision |  |  |
| failedreason | character varying |  |  |
| freemessageamount | double precision |  | Amount value |
| messageamount | double precision |  | Amount value |
| messageprovider | character varying |  |  |
| messagestatus | character varying |  |  |
| messageunits | double precision |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| pushstatus | character varying |  |  |
| sendtime | timestamp without time zone |  | Timestamp |
| smsunitcredits | double precision |  |  |
| validations | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `campaignid` → `campaigns._id` *(inferred)*
- `consumerid` → `consumers._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `promotioncustomerid` → `customers._id` *(inferred)*

#### campaignjobs__additionalattributes
- **Row Count:** 5,529,934
- **Columns:** 4
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| campaignjobs_foreignkey | character varying | FK | Foreign key to campaignjobs |
| receiptnumber | character varying | FK |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `campaignjobs_foreignkey` → `campaignjobs._id`
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### campaignlogs
- **Row Count:** 969,614
- **Columns:** 12
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| campaignid | character varying | FK | Reference to campaign |
| additionallogdata.creditsactualdeducted | double precision |  |  |
| additionallogdata.creditsduefordeduction | double precision |  |  |
| additionallogdata.customercount | double precision |  | Count/quantity |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| operation | character varying |  |  |
| reason | character varying |  |  |
| status | character varying |  | Record status |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `campaignid` → `campaigns._id` *(inferred)*

#### promotionclaimcounts
- **Row Count:** 390,641
- **Columns:** 12
- **Relationships:** 3

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| consumerid | character varying | FK | Reference to consumer |
| customerid | character varying | FK | Reference to customer |
| promotionid | character varying | FK | Reference to promotion |
| uniquepromotioncodeid | character varying | FK | Reference to uniquepromotioncode |
| businessname | character varying |  |  |
| count | double precision |  | Count/quantity |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| promotioncode | character varying |  |  |
| receiptnumbers | character varying |  |  |

**Relationships:**
- `consumerid` → `consumers._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `promotionid` → `promotions._id` *(inferred)*

#### promotioncustomers
- **Row Count:** 274,759
- **Columns:** 19
- **Relationships:** 4

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| consumerid | character varying | FK | Reference to consumer |
| customerid | character varying | FK | Reference to customer |
| promotionid | character varying | FK | Reference to promotion |
| rewardsettingid | character varying | FK | Reference to rewardsetting |
| rewardssetid | character varying | FK | Reference to rewardsset |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdeleted | boolean |  | Soft delete flag |
| lastredemptiontime | timestamp without time zone |  | Timestamp |
| promotioncode | character varying |  |  |
| restclaimcount | double precision |  | Count/quantity |
| rewardbirthdayrewardsyear | double precision |  |  |
| rewardsource | character varying |  |  |
| status | character varying |  | Record status |
| updatedat | timestamp without time zone |  |  |
| validfrom | timestamp without time zone |  |  |
| validto | timestamp without time zone |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `consumerid` → `consumers._id` *(inferred)*
- `customerid` → `customers._id` *(inferred)*
- `promotionid` → `promotions._id` *(inferred)*

#### promotions
- **Row Count:** 231,293
- **Columns:** 44
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| appliedclienttypes | character varying |  |  |
| appliedsources | character varying |  |  |
| appliedstores | character varying |  |  |
| applytoonlinestore | boolean |  |  |
| claimedcount | double precision |  | Count/quantity |
| costpersms | double precision |  |  |
| createdby | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| discounttype | character varying |  |  |
| discountvalue | double precision |  |  |
| enablebeeptagandbanner | boolean |  |  |
| enableclaimlimit | boolean |  |  |
| enableduniquepromotioncode | boolean |  |  |
| enableperbusinessclaimlimit | boolean |  |  |
| enablepercustomerclaimlimit | boolean |  |  |
| isbindcampaign | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| iseligibletoshowonbeep | boolean |  |  |
| isenabled | boolean |  |  |
| isrepeatable | boolean |  |  |
| maxclaimcount | double precision |  | Count/quantity |
| maxdiscountamount | double precision |  | Amount value |
| maxquantity | double precision |  |  |
| minquantity | double precision |  |  |
| modifiedby | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| name | character varying |  | Display name |
| ordering | double precision |  |  |
| perbusinessclaimlimit | double precision |  |  |
| percustomerclaimlimit | double precision |  |  |
| promotioncode | character varying |  |  |
| requirefirstpurchase | boolean |  |  |
| storehubpaidpercentage | double precision |  |  |
| taxcode | character varying |  |  |
| totalsmssent | double precision |  |  |
| type | character varying |  | Type or category |
| validdays | character varying |  |  |
| validfrom | timestamp without time zone |  |  |
| validtimefrom | double precision |  |  |
| validtimeto | double precision |  |  |
| validto | timestamp without time zone |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### campaignsegments__nestedsource__filters
- **Row Count:** 25,499
- **Columns:** 13
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| campaignsegments__nestedsource_foreignkey | character varying | FK | Foreign key to campaignsegments__nestedsource |
| campaignsegments_foreignkey | character varying | FK | Foreign key to campaignsegments |
| condition | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| defaultcomparedvalue | character varying |  |  |
| funcname | character varying |  |  |
| key | character varying |  |  |
| segmentruletype | character varying |  |  |
| symbol | character varying |  |  |
| valuedate | character varying |  | Date |
| valuenumber | character varying |  |  |
| valuestring | character varying |  |  |

**Relationships:**
- `campaignsegments__nestedsource_foreignkey` → `campaignsegments__nestedsource._id`
- `campaignsegments_foreignkey` → `campaignsegments._id`

#### promotions__requiredproducts
- **Row Count:** 19,765
- **Columns:** 9
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| promotions_foreignkey | character varying | FK | Foreign key to promotions |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| entity | character varying |  |  |
| maxquantity | double precision |  |  |
| minquantity | double precision |  |  |
| operand | character varying |  |  |
| operator | character varying |  |  |
| propertyname | character varying |  |  |

**Relationships:**
- `promotions_foreignkey` → `promotions._id`

#### campaignsegments
- **Row Count:** 19,346
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| name | character varying |  | Display name |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### campaignsegments__nestedsource
- **Row Count:** 19,346
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| campaignsegments_foreignkey | character varying | FK | Foreign key to campaignsegments |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| groupbys | character varying |  |  |
| source | character varying |  |  |

**Relationships:**
- `campaignsegments_foreignkey` → `campaignsegments._id`

#### campaigns
- **Row Count:** 17,481
- **Columns:** 25
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| globalcampaigninformationid | character varying | FK | Reference to globalcampaigninformation |
| initialsegmentid | character varying | FK | Reference to initialsegment |
| segmentid | character varying | FK | Reference to segment |
| brandname | character varying |  |  |
| campaigntype | character varying |  |  |
| channel | character varying |  |  |
| conditiontype | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| cron | character varying |  |  |
| cronjobkey | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| delay | double precision |  |  |
| endtime | timestamp without time zone |  | Timestamp |
| isactive | boolean |  |  |
| isinitial | boolean |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| name | character varying |  | Display name |
| selectedtemplatelanguage | character varying |  |  |
| starttime | timestamp without time zone |  | Timestamp |
| status | character varying |  | Record status |
| template | character varying |  |  |
| timezone | character varying |  |  |
| version | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### promotions__rewardssettings
- **Row Count:** 49
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| promotions_foreignkey | character varying | FK | Foreign key to promotions |
| costofpoints | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| rewardstype | character varying |  |  |
| validnumber | double precision |  |  |
| validunit | character varying |  |  |

**Relationships:**
- `promotions_foreignkey` → `promotions._id`

#### rewardssets__promotionconfigs
- **Row Count:** 43
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| promotionid | character varying | FK | Reference to promotion |
| rewardssets_foreignkey | character varying | FK | Foreign key to rewardssets |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| validnumber | double precision |  |  |
| validunit | character varying |  |  |

**Relationships:**
- `rewardssets_foreignkey` → `rewardssets._id`
- `promotionid` → `promotions._id` *(inferred)*

---

## Logistics
**Tables:** 11 | **Total Rows:** 6,573,122

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `logistics` | 5,299,975 | 56 | Logistics |
| `logisticsjoblogs` | 1,054,762 | 13 | Logisticsjoblogs |
| `shippingzones` | 31,338 | 11 | Shippingzones |
| `shippingzones__deliverymethods` | 31,338 | 10 | Shippingzones  Deliverymethods |
| `logisticslogs` | 27,258 | 14 | Logisticslogs |
| `shippingzones__deliverymethods__ratecalculation` | 22,638 | 4 | Shippingzones  Deliverymethods  Ratecalculation |
| `shippingzones__deliverymethods__ratecalculation__additions` | 22,638 | 6 | Shippingzones  Deliverymethods  Ratecalculation  Additions |
| `shippingzones__deliverymethods__ratecalculation__additions__measure` | 22,638 | 8 | Shippingzones  Deliverymethods  Ratecalculation  Additions  Measure |
| `shippingzones__deliverymethods__ratecalculation__firstbase` | 22,638 | 6 | Shippingzones  Deliverymethods  Ratecalculation  Firstbase |
| `shippingzones__deliverymethods__ratecalculation__firstbase__measure` | 22,638 | 8 | Shippingzones  Deliverymethods  Ratecalculation  Firstbase  Measure |
| `shippingzones__deliverymethods__freeconditions` | 15,261 | 8 | Shippingzones  Deliverymethods  Freeconditions |

### Detailed Schemas

#### logistics
- **Row Count:** 5,299,975
- **Columns:** 56
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| dependentid | character varying | FK | Reference to dependent |
| driverid | character varying | FK | Reference to driver |
| id | character varying | FK | Reference to  |
| receiptnumber | character varying | FK |  |
| riderid | character varying | FK | Reference to rider |
| teamid | character varying | FK | Reference to team |
| trackingid | character varying | FK | Reference to tracking |
| bestlastmileeta | timestamp without time zone |  |  |
| claimcheckpasscounts | double precision |  |  |
| claimedbefore | boolean |  |  |
| country | character varying |  | Country code |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliverydistance | double precision |  |  |
| deliveryfee | double precision |  |  |
| dropofflocation.coordinates | character varying |  |  |
| dropofflocation.type | character varying |  |  |
| expireat | timestamp without time zone |  |  |
| isexpress | boolean |  |  |
| ismanual | boolean |  |  |
| isoffstorebefore | boolean |  |  |
| ispickedupbefore | boolean |  |  |
| ispreorder | boolean |  |  |
| ispreorderconverted | boolean |  |  |
| issendpreordernotifications | boolean |  |  |
| istest | boolean |  |  |
| istimeoutsent | boolean |  |  |
| joburl | character varying |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| name | character varying |  | Display name |
| onfleetlastcheckcompletiontime | timestamp without time zone |  | Timestamp |
| onfleetunassignedcounts | double precision |  |  |
| originalfee | double precision |  |  |
| pickuplocation.coordinates | character varying |  |  |
| pickuplocation.type | character varying |  |  |
| preorderstartat | timestamp without time zone |  |  |
| riderclaimdistance | double precision |  |  |
| riderclaimlocation.coordinates | character varying |  |  |
| riderclaimlocation.type | character varying |  |  |
| ridercompletelocation.coordinates | character varying |  |  |
| ridercompletelocation.type | character varying |  |  |
| ridername | character varying |  |  |
| riderphone | character varying |  |  |
| riderpickeduplocation.coordinates | character varying |  |  |
| riderpickeduplocation.type | character varying |  |  |
| riderstraightdistancetodropoff | double precision |  |  |
| ridetype | character varying |  |  |
| ridetypemerchantsetup | character varying |  |  |
| startat | timestamp without time zone |  |  |
| state | character varying |  |  |
| status | character varying |  | Record status |
| trackingurl | character varying |  |  |
| upbidtype | character varying |  |  |
| worstlastmileeta | timestamp without time zone |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### logisticsjoblogs
- **Row Count:** 1,054,762
- **Columns:** 13
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| jobid | character varying | FK | Reference to job |
| receiptnumber | character varying | FK |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliverydistance | double precision |  |  |
| deliveryfee | double precision |  |  |
| operation | character varying |  |  |
| operator | character varying |  |  |
| operatorname | character varying |  |  |
| providername | character varying |  |  |
| ridetype | character varying |  |  |
| status | character varying |  | Record status |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### shippingzones
- **Row Count:** 31,338
- **Columns:** 11
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| country | character varying |  | Country code |
| coveredcountries | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| distance | double precision |  |  |
| logisticsridetype | character varying |  |  |
| name | character varying |  | Display name |
| postcodes | character varying |  |  |
| shippingtype | character varying |  |  |
| states | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### shippingzones__deliverymethods
- **Row Count:** 31,338
- **Columns:** 10
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| enableconditionalfreeshipping | boolean |  |  |
| maxshippingtime | double precision |  | Timestamp |
| minshippingtime | double precision |  | Timestamp |
| name | character varying |  | Display name |
| rate | double precision |  |  |
| shippingtimeunit | character varying |  |  |
| type | character varying |  | Type or category |

**Relationships:**
- `shippingzones_foreignkey` → `shippingzones._id`

#### logisticslogs
- **Row Count:** 27,258
- **Columns:** 14
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| id | character varying | FK | Reference to  |
| receiptnumber | character varying | FK |  |
| body | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliverydistance | double precision |  |  |
| deliveryfee | double precision |  |  |
| name | character varying |  | Display name |
| operationtype | character varying |  |  |
| operatorname | character varying |  |  |
| ridetype | character varying |  |  |
| status | character varying |  | Record status |
| time | timestamp without time zone |  | Timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `receiptnumber` → `transactionrecords.receiptnumber` *(inferred)*

#### shippingzones__deliverymethods__ratecalculation
- **Row Count:** 22,638
- **Columns:** 4
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `shippingzones__deliverymethods_foreignkey` → `shippingzones__deliverymethods._id`
- `shippingzones_foreignkey` → `shippingzones._id`

#### shippingzones__deliverymethods__ratecalculation__additions
- **Row Count:** 22,638
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods__ratecalculation_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods__ratecalculation |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| additionalmeasurevalue | double precision |  |  |
| additionalrate | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `shippingzones__deliverymethods__ratecalculation_foreignkey` → `shippingzones__deliverymethods__ratecalculation._id`
- `shippingzones_foreignkey` → `shippingzones._id`

#### shippingzones__deliverymethods__ratecalculation__additions__measure
- **Row Count:** 22,638
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods__ratecalculation__additions_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods__ratecalculation__additions |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| maxvalue | double precision |  |  |
| minvalue | double precision |  |  |
| type | character varying |  | Type or category |
| unit | character varying |  |  |

**Relationships:**
- `shippingzones__deliverymethods__ratecalculation__additions_foreignkey` → `shippingzones__deliverymethods__ratecalculation__additions._id`
- `shippingzones_foreignkey` → `shippingzones._id`

#### shippingzones__deliverymethods__ratecalculation__firstbase
- **Row Count:** 22,638
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods__ratecalculation_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods__ratecalculation |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| originalrate | double precision |  |  |
| rate | double precision |  |  |

**Relationships:**
- `shippingzones__deliverymethods__ratecalculation_foreignkey` → `shippingzones__deliverymethods__ratecalculation._id`
- `shippingzones_foreignkey` → `shippingzones._id`

#### shippingzones__deliverymethods__ratecalculation__firstbase__measure
- **Row Count:** 22,638
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods__ratecalculation__firstbase_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods__ratecalculation__firstbase |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| maxvalue | double precision |  |  |
| minvalue | double precision |  |  |
| type | character varying |  | Type or category |
| unit | character varying |  |  |

**Relationships:**
- `shippingzones__deliverymethods__ratecalculation__firstbase_foreignkey` → `shippingzones__deliverymethods__ratecalculation__firstbase._id`
- `shippingzones_foreignkey` → `shippingzones._id`

#### shippingzones__deliverymethods__freeconditions
- **Row Count:** 15,261
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| shippingzones__deliverymethods_foreignkey | character varying | FK | Foreign key to shippingzones__deliverymethods |
| shippingzones_foreignkey | character varying | FK | Foreign key to shippingzones |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| entity | character varying |  |  |
| operand | character varying |  |  |
| operator | character varying |  |  |
| propertyname | character varying |  |  |

**Relationships:**
- `shippingzones__deliverymethods_foreignkey` → `shippingzones__deliverymethods._id`
- `shippingzones_foreignkey` → `shippingzones._id`

---

## Employees
**Tables:** 2 | **Total Rows:** 775,458

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `employees` | 546,726 | 23 | Staff and user accounts |
| `employees__passwordsettingtokens` | 228,732 | 6 | Employees  Passwordsettingtokens |

### Detailed Schemas

#### employees
- **Row Count:** 546,726
- **Columns:** 23

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| accessallstores | boolean |  |  |
| assignedstores | character varying |  |  |
| backofficeaccess | boolean |  |  |
| backofficedetailaccesses | character varying |  |  |
| cashieraccess | boolean |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| emailnotifications | character varying |  |  |
| employeenumber | double precision |  |  |
| employername | character varying |  |  |
| firstname | character varying |  |  |
| isdeleted | boolean |  | Soft delete flag |
| istutorialdone | boolean |  |  |
| languagepreference | character varying |  |  |
| lastcheckalerts | timestamp without time zone |  |  |
| lastname | character varying |  |  |
| limitbackofficeaccess | boolean |  |  |
| manageraccess | boolean |  |  |
| modifiedtime | timestamp without time zone |  | Last modification timestamp |
| passwordhash | character varying |  |  |
| phone | character varying |  | Phone number |

#### employees__passwordsettingtokens
- **Row Count:** 228,732
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| employees_foreignkey | character varying | FK | Foreign key to employees |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| expirydate | timestamp without time zone |  | Date |
| isredeemed | boolean |  |  |
| token | character varying |  |  |

**Relationships:**
- `employees_foreignkey` → `employees._id`

---

## Businesses
**Tables:** 19 | **Total Rows:** 681,115

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `businesses__stores` | 125,809 | 54 | Physical store locations |
| `businesses__paymentoptions` | 100,919 | 13 | Payment methods accepted |
| `businesses__cashregisters` | 78,646 | 29 | Businesses  Cashregisters |
| `businesses__taxcodes` | 73,434 | 8 | Businesses  Taxcodes |
| `businesses` | 58,138 | 165 | Merchant/business accounts |
| `businesses__qrorderingsettings` | 45,612 | 29 | Businesses  Qrorderingsettings |
| `businesses__cashregisters__location` | 44,928 | 6 | Businesses  Cashregisters  Location |
| `businesses__stores__location` | 44,517 | 6 | Physical store locations |
| `businesses__stores__pickupaddress` | 33,643 | 9 | Physical store locations |
| `businesses__stores__pickupaddress__addresscomponents` | 30,429 | 9 | Physical store locations |
| `businesses__stores__qrorderingsettings` | 16,066 | 18 | Physical store locations |
| `businesses__cashregisters__device` | 11,032 | 7 | Businesses  Cashregisters  Device |
| `businesses__stores__qrorderingsettings__vacations` | 6,194 | 6 | Physical store locations |
| `businesses__addons` | 4,746 | 5 | Businesses  Addons |
| `businesses__nagbar` | 2,259 | 5 | Businesses  Nagbar |
| `businesses__ownertransfertokens` | 2,079 | 7 | Businesses  Ownertransfertokens |
| `businesses__excludeservicechargeproductcondition` | 1,427 | 5 | Businesses  Excludeservicechargeproductcondition |
| `businesses__stores__reviewinfo` | 1,234 | 6 | Physical store locations |
| `businesses__fixedfeesettings` | 3 | 7 | Businesses  Fixedfeesettings |

### Detailed Schemas

#### businesses__stores
- **Row Count:** 125,809
- **Columns:** 54
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| gstid | character varying | FK | Reference to gst |
| sstid | character varying | FK | Reference to sst |
| beepbrandname | character varying |  |  |
| beepstorenamelocationsuffix | character varying |  |  |
| birrequested | boolean |  |  |
| brn | character varying |  |  |
| cashieraccesses | character varying |  |  |
| city | character varying |  |  |
| companyname | character varying |  |  |
| confirmbirtoken | character varying |  |  |
| country | character varying |  | Country code |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| einvoicesetting.countrycode | character varying |  |  |
| einvoicesetting.industry | character varying |  |  |
| einvoicesetting.isconsolidationon | boolean |  |  |
| einvoicesetting.iseinvoiceready | boolean |  |  |
| einvoicesetting.msiccode | character varying |  |  |
| einvoicesetting.msicdescription | character varying |  |  |
| einvoicesetting.nric | character varying |  |  |
| einvoicesetting.statecode | character varying |  |  |
| einvoicesetting.tin | character varying |  |  |
| email | character varying |  | Email address |
| enabledigital | boolean |  |  |
| fax | character varying |  |  |
| firstaccreditbirtime | timestamp without time zone |  | Timestamp |
| fulfillmentoptions | character varying |  |  |
| hassupplyneeds | boolean |  |  |
| industry | double precision |  |  |
| isbiraccredited | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| ismallintegrationenabled | boolean |  |  |
| isonezreadingperdayenabled | boolean |  |  |
| isonline | boolean |  |  |
| isvatregistered | boolean |  |  |
| kds | boolean |  |  |
| mallintegrationchannel | character varying |  |  |
| name | character varying |  | Display name |
| ncs | boolean |  |  |
| notes | character varying |  |  |
| operationhours | character varying |  |  |
| ordernotificationemail | character varying |  |  |
| paidordernotification | boolean |  |  |
| pendingpaymentordernotification | boolean |  |  |
| pendingverificationordernotification | boolean |  |  |
| phone | character varying |  | Phone number |
| postalcode | character varying |  |  |
| qrregisters | character varying |  |  |
| receipttemplate | character varying |  |  |
| state | character varying |  |  |
| street1 | character varying |  |  |
| street2 | character varying |  |  |
| website | character varying |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__paymentoptions
- **Row Count:** 100,919
- **Columns:** 13
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| paymentid | double precision | FK | Reference to payment |
| additionalinfo | character varying |  |  |
| cashregisters | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isdeleted | boolean |  | Soft delete flag |
| isdisabled | boolean |  |  |
| isexcludedfromeinvoice | boolean |  |  |
| name | character varying |  | Display name |
| ordering | double precision |  |  |
| stores | character varying |  |  |
| type | character varying |  | Type or category |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__cashregisters
- **Row Count:** 78,646
- **Columns:** 29
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| quickselectlayoutid | character varying | FK | Reference to quickselectlayout |
| registerid | double precision | FK | Reference to register |
| storeid | character varying | FK | Reference to store |
| activationcode | double precision |  |  |
| apitoken | character varying |  |  |
| appversion | character varying |  |  |
| badgenumber | double precision |  |  |
| beepbadgenumber | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| defaulttablelayoutsection | character varying |  |  |
| ecommercebadgenumber | double precision |  |  |
| isactivated | boolean |  |  |
| minno | character varying |  |  |
| model | character varying |  |  |
| name | character varying |  | Display name |
| oldapitoken | character varying |  |  |
| onlinebadgenumber | double precision |  |  |
| platform | character varying |  |  |
| ptu | character varying |  |  |
| ptudateissued | character varying |  |  |
| ptuvalideuntil | character varying |  |  |
| pushprovider | character varying |  |  |
| serialno | character varying |  |  |
| snsendpointarn | character varying |  |  |
| tablelayoutenabled | boolean |  |  |
| token | character varying |  |  |
| trialperiod | double precision |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`
- `storeid` → `businesses__stores._id` *(inferred)*

#### businesses__taxcodes
- **Row Count:** 73,434
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isamusementtax | boolean |  |  |
| isdeleted | boolean |  | Soft delete flag |
| isvatexempted | boolean |  |  |
| name | character varying |  | Display name |
| rate | double precision |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses
- **Row Count:** 58,138
- **Columns:** 165
- **Relationships:** 5

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| advanceinvoiceid | character varying | FK | Reference to advanceinvoice |
| assigntableid | boolean | FK | Reference to assigntable |
| autoorderid | boolean | FK | Reference to autoorder |
| autosmscreditsdiscountinfoid | character varying | FK | Reference to autosmscreditsdiscountinfo |
| chargebeecustomerid | character varying | FK | Reference to chargebeecustomer |
| facebookid | character varying | FK | Reference to facebook |
| hubspotdealid | double precision | FK | Reference to hubspotdeal |
| ongoingsubscriptionorderid | character varying | FK | Reference to ongoingsubscriptionorder |
| planid | character varying | FK | Reference to plan |
| plivoauthid | character varying | FK | Reference to plivoauth |
| salesforceopportunityid | character varying | FK | Reference to salesforceopportunity |
| sequentialreceiptnumber | boolean | FK |  |
| softwareorderid | character varying | FK | Reference to softwareorder |
| subscriptionid | character varying | FK | Reference to subscription |
| totalsubfeepaid | double precision | FK | Reference to totalsubfeepa |
| activatedat | timestamp without time zone |  |  |
| added60daysfreesmscredits | boolean |  |  |
| addonids | character varying |  |  |
| allowanonymousqrordering | boolean |  |  |
| alloweditproductsonpos | boolean |  |  |
| autocountaccountingcode | character varying |  |  |
| autolowsmscredits | double precision |  |  |
| autorechargesmscredits | double precision |  |  |
| billingcurrency | character varying |  |  |
| billingperiodchanged | boolean |  |  |
| businessstatus | character varying |  |  |
| businesstype | character varying |  |  |
| campaignenabledtime | double precision |  | Timestamp |
| campaigntrialendtime | double precision |  | Timestamp |
| campaigntrialstartdate | timestamp without time zone |  | Date |
| cashbackclaimautorefill | boolean |  |  |
| cashbackclaimplanused | double precision |  |  |
| cashbackclaimtopuptotal | double precision |  |  |
| cashbackclaimtopupused | double precision |  |  |
| cashbackclaimtrailcount | double precision |  | Count/quantity |
| cashbackexpirationduration.durationnumber | double precision |  |  |
| cashbackexpirationduration.durationunit | character varying |  |  |
| cashbackpopedupemployees | character varying |  |  |
| cashbacktrailexpiredalertclosed | boolean |  |  |
| cashbacktrailstartedalertclosed | boolean |  |  |
| cashbacktrialexpirydate | timestamp without time zone |  | Date |
| claimcashbackcountperday | double precision |  |  |
| claimcashbacklimit | boolean |  |  |
| claimpointscountperday | double precision |  |  |
| country | character varying |  | Country code |
| coupon | character varying |  |  |
| createdtime | timestamp without time zone |  | Record creation timestamp |
| creditcardexpirydate | character varying |  | Date |
| creditcardmodifieddate | timestamp without time zone |  | Date |
| creditcardtype | character varying |  |  |
| currency | character varying |  | Currency code |
| customerexceedthreshold | boolean |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| defaultkitchenprinter | character varying |  |  |
| defaultloyaltyratio | double precision |  |  |
| defaultproductclassificationcode | character varying |  |  |
| defaulttaxcode | character varying |  |  |
| disablecashbackfrompos | boolean |  |  |
| disableddefaultpayments | character varying |  |  |
| displaybusinessname | character varying |  |  |
| email | character varying |  | Email address |
| enablecashback | boolean |  |  |
| enablegroupitem | boolean |  |  |
| enableloyalty | boolean |  |  |
| enablemultipleipads | boolean |  |  |
| enableonlinechannelsinpaymentsreport | boolean |  |  |
| enableonlinestorefeature | boolean |  |  |
| enablepax | boolean |  |  |
| enableqrorderingfeature | boolean |  |  |
| enablereportdriver | boolean |  |  |
| enablerounding | boolean |  |  |
| enableservicecharge | boolean |  |  |
| enablesmsnotifications | boolean |  |  |
| enabletakeaway | boolean |  |  |
| enablethirdparty | character varying |  |  |
| enableweights | boolean |  |  |
| existingcampaignuser | boolean |  |  |
| extrastoreoldpricingquota | double precision |  |  |
| firstenablecashbackdate | timestamp without time zone |  | Date |
| firstenableqrorderingdate | timestamp without time zone |  | Date |
| firstmembershipenabledtime | timestamp without time zone |  | Timestamp |
| firstpointsenabledtime | timestamp without time zone |  | Timestamp |
| hascreditedreferrer | boolean |  |  |
| hasdevicetype | character varying |  |  |
| includingtaxindisplay | boolean |  |  |
| industry | character varying |  |  |
| integrationapitoken | character varying |  |  |
| isautosms | boolean |  |  |
| iseinvoiceenabled | boolean |  |  |
| isenablebeepqremailsent | boolean |  |  |
| isinitializing | boolean |  |  |
| isinventorywebhookenabled | boolean |  |  |
| isonjimacforbir | boolean |  |  |
| isonline | boolean |  |  |
| isonlinestorepublished | boolean |  |  |
| isonlinestorerequested | boolean |  |  |
| ispositiveinvstockmanageenabled | boolean |  |  |
| isqrorderingenabled | boolean |  |  |
| issupplierpricefixedforallstores | boolean |  |  |
| kitchenprinters | character varying |  |  |
| lastchargebeeeventtime | timestamp without time zone |  | Timestamp |
| lastenablecashbackdate | timestamp without time zone |  | Date |
| lastenableqrorderingdate | timestamp without time zone |  | Date |
| lastmaxbarcode | double precision |  |  |
| lastpointsdisabledtime | timestamp without time zone |  | Timestamp |
| lastpopupeasyenablement | double precision |  |  |
| lastrevenuecheckingtime | double precision |  | Timestamp |
| liteplanexceedlimitmonths | double precision |  |  |
| lockedsmscredits | double precision |  |  |
| maskedcardnumber | character varying |  |  |
| maxofflinedays | double precision |  |  |
| membershipenabled | boolean |  |  |
| membershipsetting.activatedat | timestamp without time zone |  |  |
| membershipsetting.firstgoliveat | timestamp without time zone |  |  |
| membershipsetting.islive | boolean |  |  |
| membershipsetting.trialendat | timestamp without time zone |  |  |
| mrr | double precision |  |  |
| name | character varying |  | Display name |
| nextbillingdate | timestamp without time zone |  | Date |
| notrenewing | boolean |  |  |
| numberofstores | double precision |  |  |
| operationhours | double precision |  |  |
| ordersummaryprinter | character varying |  |  |
| othermposenabled | boolean |  |  |
| paidextraregisters | double precision |  |  |
| paidextrastores | double precision |  |  |
| paidregisters | double precision |  |  |
| permanentoldpricingextrastores | boolean |  |  |
| phone | character varying |  | Phone number |
| plivoauthtoken | character varying |  |  |
| pointsenabled | boolean |  |  |
| pointsexpirationduration.durationnumber | double precision |  |  |
| pointsexpirationduration.durationunit | character varying |  |  |
| pointsexpirationduration.lastupdatetime | timestamp without time zone |  | Timestamp |
| remainingtrialperiod | double precision |  |  |
| remainingtrialperiodadded | boolean |  |  |
| roundalltransactions | boolean |  |  |
| roundingto | double precision |  |  |
| scheduledactivationtime | double precision |  | Timestamp |
| scheduledby | character varying |  |  |
| separatekitchenitems | boolean |  |  |
| servicechargerate | double precision |  |  |
| servicechargetax | character varying |  |  |
| skipeasyenablement | boolean |  |  |
| smscredits | double precision |  |  |
| smscreditsavgcost | double precision |  |  |
| smscreditslow | boolean |  |  |
| smsfrom | character varying |  |  |
| smsnotifications | character varying |  |  |
| softwareorderamount | double precision |  | Amount value |
| softwareorderpaymentapproved | boolean |  |  |
| specialsubscription | boolean |  |  |
| sqlaccoutingcode | character varying |  |  |
| status | character varying |  | Record status |
| storeswithfixedsupplierprice | character varying |  |  |
| subscriptionenddate | timestamp without time zone |  | Date |
| subscriptionstartdate | timestamp without time zone |  | Date |
| subscriptionstatus | character varying |  |  |
| takeawaycharge | double precision |  |  |
| taxrate | double precision |  |  |
| timezone | character varying |  |  |
| trialends | timestamp without time zone |  |  |
| trialextraregister | double precision |  |  |
| usestorehubpay | boolean |  |  |

**Relationships:**
- `autoorderid` → `orders._id` *(inferred)*
- `chargebeecustomerid` → `customers._id` *(inferred)*
- `ongoingsubscriptionorderid` → `orders._id` *(inferred)*
- `sequentialreceiptnumber` → `transactionrecords.receiptnumber` *(inferred)*
- `softwareorderid` → `orders._id` *(inferred)*

#### businesses__qrorderingsettings
- **Row Count:** 45,612
- **Columns:** 29
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| defaultshippingzoneid | character varying | FK | Reference to defaultshippingzone |
| defaultshippingzonemethodid | character varying | FK | Reference to defaultshippingzonemethod |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| deliveryradius | double precision |  |  |
| disableguestlogin | boolean |  |  |
| disabletodaypreorder | boolean |  |  |
| enabledelivery | boolean |  |  |
| enabledeliveryliveonline | boolean |  |  |
| enableliveonline | boolean |  |  |
| enablepaybycash | boolean |  |  |
| enablepaylater | boolean |  |  |
| enablepreorder | boolean |  |  |
| firstenabledeliverydate | timestamp without time zone |  | Date |
| firstenablepreorderdeliverydate | timestamp without time zone |  | Date |
| hidefrombeepcom | boolean |  |  |
| marketingtags | character varying |  |  |
| minimumconsumption | double precision |  |  |
| searchingtags | character varying |  |  |
| sellalcohol | boolean |  |  |
| sellnonhalalfood | boolean |  |  |
| sellpork | boolean |  |  |
| storesenabledpaybycash | character varying |  |  |
| storesenabledpaylater | character varying |  |  |
| usestorehublogistics | boolean |  |  |
| validdays | character varying |  |  |
| validtimefrom | character varying |  |  |
| validtimeto | character varying |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__cashregisters__location
- **Row Count:** 44,928
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__cashregisters_foreignkey | character varying | FK | Foreign key to businesses__cashregisters |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `businesses__cashregisters_foreignkey` → `businesses__cashregisters._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__location
- **Row Count:** 44,517
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores_foreignkey | character varying | FK | Foreign key to businesses__stores |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| coordinates | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| type | character varying |  | Type or category |

**Relationships:**
- `businesses__stores_foreignkey` → `businesses__stores._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__pickupaddress
- **Row Count:** 33,643
- **Columns:** 9
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores_foreignkey | character varying | FK | Foreign key to businesses__stores |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| googlemapsplaceid | character varying | FK | Reference to googlemapsplace |
| coordinate | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| googlemapsurl | character varying |  |  |
| location | character varying |  |  |
| placename | character varying |  |  |

**Relationships:**
- `businesses__stores_foreignkey` → `businesses__stores._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__pickupaddress__addresscomponents
- **Row Count:** 30,429
- **Columns:** 9
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores__pickupaddress_foreignkey | character varying | FK | Foreign key to businesses__stores__pickupaddress |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| city | character varying |  |  |
| country | character varying |  | Country code |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| state | character varying |  |  |
| street1 | character varying |  |  |
| street2 | character varying |  |  |

**Relationships:**
- `businesses__stores__pickupaddress_foreignkey` → `businesses__stores__pickupaddress._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__qrorderingsettings
- **Row Count:** 16,066
- **Columns:** 18
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores_foreignkey | character varying | FK | Foreign key to businesses__stores |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| breaktimefrom | character varying |  |  |
| breaktimeto | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| disableondemandorder | boolean |  |  |
| disabletodaypreorder | boolean |  |  |
| enablepertimeslotlimitforpreorder | boolean |  |  |
| enablepreorder | boolean |  |  |
| enableselfpickupalert | boolean |  |  |
| firstenablepreorderdeliverydate | timestamp without time zone |  | Date |
| maxpreorderspertimeslot | double precision |  |  |
| pausemodesettings.endingat | double precision |  |  |
| pausemodesettings.shippingtypes | character varying |  |  |
| validdays | character varying |  |  |
| validtimefrom | character varying |  |  |
| validtimeto | character varying |  |  |

**Relationships:**
- `businesses__stores_foreignkey` → `businesses__stores._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__cashregisters__device
- **Row Count:** 11,032
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__cashregisters_foreignkey | character varying | FK | Foreign key to businesses__cashregisters |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| model | character varying |  |  |
| platform | character varying |  |  |
| version | character varying |  |  |

**Relationships:**
- `businesses__cashregisters_foreignkey` → `businesses__cashregisters._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__qrorderingsettings__vacations
- **Row Count:** 6,194
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores__qrorderingsettings_foreignkey | character varying | FK | Foreign key to businesses__stores__qrorderingsettings |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| vacationtimefrom | character varying |  |  |
| vacationtimeto | character varying |  |  |

**Relationships:**
- `businesses__stores__qrorderingsettings_foreignkey` → `businesses__stores__qrorderingsettings._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__addons
- **Row Count:** 4,746
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| id | character varying | FK | Reference to  |
| count | double precision |  | Count/quantity |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__nagbar
- **Row Count:** 2,259
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isnagbarhide | boolean |  |  |
| ispickuponly | boolean |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__ownertransfertokens
- **Row Count:** 2,079
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| newownerid | character varying | FK | Reference to newowner |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| expirydate | timestamp without time zone |  | Date |
| status | character varying |  | Record status |
| token | character varying |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__excludeservicechargeproductcondition
- **Row Count:** 1,427
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| conditionsmatch | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| isenabled | boolean |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

#### businesses__stores__reviewinfo
- **Row Count:** 1,234
- **Columns:** 6
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses__stores_foreignkey | character varying | FK | Foreign key to businesses__stores |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| rating | double precision |  |  |
| ratingcount | double precision |  | Count/quantity |

**Relationships:**
- `businesses__stores_foreignkey` → `businesses__stores._id`
- `businesses_foreignkey` → `businesses._id`

#### businesses__fixedfeesettings
- **Row Count:** 3
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| businesses_foreignkey | character varying | FK | Foreign key to businesses |
| amount | numeric |  | Monetary amount |
| appliedstores | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| fulfillmentoption | character varying |  |  |
| isenabled | boolean |  |  |

**Relationships:**
- `businesses_foreignkey` → `businesses._id`

---

## Online Store
**Tables:** 11 | **Total Rows:** 185,922

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `onlinecategories__conditions` | 131,359 | 6 | Onlinecategories  Conditions |
| `onlinestoreinfos` | 37,258 | 28 | Onlinestoreinfos |
| `onlinestoreinfos__socialmediainfo` | 3,450 | 7 | Onlinestoreinfos  Socialmediainfo |
| `onlinestoreinfos__socialmediainfo__facebook` | 3,450 | 8 | Onlinestoreinfos  Socialmediainfo  Facebook |
| `onlinestoreinfos__socialmediainfo__line` | 3,450 | 7 | Onlinestoreinfos  Socialmediainfo  Line |
| `onlinestoreinfos__socialmediainfo__viber` | 3,450 | 7 | Onlinestoreinfos  Socialmediainfo  Viber |
| `onlinestoreinfos__customizecommissionrates` | 1,176 | 8 | Onlinestoreinfos  Customizecommissionrates |
| `onlinestoreinfos__analytictools` | 972 | 5 | Onlinestoreinfos  Analytictools |
| `thirdpartyonlineorders` | 701 | 6 | Thirdpartyonlineorders |
| `onlinestoreinfos__bankingdetails` | 617 | 10 | Onlinestoreinfos  Bankingdetails |
| `onlinecategories` | 39 | 14 | Onlinecategories |

### Detailed Schemas

#### onlinecategories__conditions
- **Row Count:** 131,359
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinecategories_foreignkey | character varying | FK | Foreign key to onlinecategories |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| operand | character varying |  |  |
| operator | character varying |  |  |
| type | character varying |  | Type or category |

**Relationships:**
- `onlinecategories_foreignkey` → `onlinecategories._id`

#### onlinestoreinfos
- **Row Count:** 37,258
- **Columns:** 28
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| aboutstore | character varying |  |  |
| alternatephone1 | character varying |  |  |
| alternatephone2 | character varying |  |  |
| beepbrandname | character varying |  |  |
| beepprofileimage | character varying |  |  |
| connectstatus | character varying |  |  |
| customdomain | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| email | character varying |  | Email address |
| enabledchattype | character varying |  |  |
| facebookdomainverification | character varying |  |  |
| favicon | character varying |  |  |
| featuredproducts | character varying |  |  |
| firstenabledate | timestamp without time zone |  | Date |
| firstpublishdate | timestamp without time zone |  | Date |
| haslogo | boolean |  |  |
| lastenabledate | timestamp without time zone |  | Date |
| lastpublishdate | timestamp without time zone |  | Date |
| logo | character varying |  |  |
| operationhours | character varying |  |  |
| phone | character varying |  | Phone number |
| postcode | character varying |  |  |
| state | character varying |  |  |
| storename | character varying |  |  |
| street | character varying |  |  |
| themecolor | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### onlinestoreinfos__socialmediainfo
- **Row Count:** 3,450
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| instagram | character varying |  |  |
| twitter | character varying |  |  |
| whatsapp | character varying |  |  |
| youtube | character varying |  |  |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__socialmediainfo__facebook
- **Row Count:** 3,450
- **Columns:** 8
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos__socialmediainfo_foreignkey | character varying | FK | Foreign key to onlinestoreinfos__socialmediainfo |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| pageid | character varying | FK | Reference to page |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| greetingmessage | character varying |  |  |
| language | character varying |  |  |
| themecolor | character varying |  |  |

**Relationships:**
- `onlinestoreinfos__socialmediainfo_foreignkey` → `onlinestoreinfos__socialmediainfo._id`
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__socialmediainfo__line
- **Row Count:** 3,450
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos__socialmediainfo_foreignkey | character varying | FK | Foreign key to onlinestoreinfos__socialmediainfo |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| officialline | character varying |  |  |
| personalline | character varying |  |  |
| usepersonalline | boolean |  |  |

**Relationships:**
- `onlinestoreinfos__socialmediainfo_foreignkey` → `onlinestoreinfos__socialmediainfo._id`
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__socialmediainfo__viber
- **Row Count:** 3,450
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos__socialmediainfo_foreignkey | character varying | FK | Foreign key to onlinestoreinfos__socialmediainfo |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| officialviber | character varying |  |  |
| personalviber | character varying |  |  |
| usepersonalviber | boolean |  |  |

**Relationships:**
- `onlinestoreinfos__socialmediainfo_foreignkey` → `onlinestoreinfos__socialmediainfo._id`
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__customizecommissionrates
- **Row Count:** 1,176
- **Columns:** 8
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| beepdelivery | double precision |  |  |
| beepinstore | double precision |  |  |
| beeppickup | double precision |  |  |
| beeptakeaway | double precision |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| ecommerce | double precision |  |  |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinestoreinfos__analytictools
- **Row Count:** 972
- **Columns:** 5
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| trackingid | character varying | FK | Reference to tracking |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| name | character varying |  | Display name |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### thirdpartyonlineorders
- **Row Count:** 701
- **Columns:** 6
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| orderid | character varying | FK | Reference to order |
| channel | double precision |  |  |
| content | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| iscancellationnottakeeffect | boolean |  |  |

**Relationships:**
- `orderid` → `orders._id` *(inferred)*

#### onlinestoreinfos__bankingdetails
- **Row Count:** 617
- **Columns:** 10
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| onlinestoreinfos_foreignkey | character varying | FK | Foreign key to onlinestoreinfos |
| bankaccountnumber | character varying |  |  |
| bankaddress | character varying |  |  |
| bankcode | character varying |  |  |
| bankname | character varying |  |  |
| beneficiaryaccountname | character varying |  |  |
| beneficiaryaddress | character varying |  |  |
| beneficiaryphonenumber | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `onlinestoreinfos_foreignkey` → `onlinestoreinfos._id`

#### onlinecategories
- **Row Count:** 39
- **Columns:** 14
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| appliedsources | character varying |  |  |
| appliedstores | character varying |  |  |
| channels | character varying |  |  |
| conditionsmatch | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| iseditable | boolean |  |  |
| isenabled | boolean |  |  |
| name | character varying |  | Display name |
| ordering | double precision |  |  |
| slug | character varying |  |  |
| sortordering | character varying |  |  |
| sorttype | character varying |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

---

## Digital Ordering
**Tables:** 3 | **Total Rows:** 24,723

| Table | Rows | Columns | Description |
|-------|------|---------|-------------|
| `fooddeliveryplatformsettings__outlets__grabitemmappings` | 20,492 | 7 | Fooddeliveryplatformsettings  Outlets  Grabitemmappings |
| `fooddeliveryplatformsettings` | 2,514 | 7 | Fooddeliveryplatformsettings |
| `fooddeliveryplatformsettings__outlets` | 1,717 | 16 | Fooddeliveryplatformsettings  Outlets |

### Detailed Schemas

#### fooddeliveryplatformsettings__outlets__grabitemmappings
- **Row Count:** 20,492
- **Columns:** 7
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| fooddeliveryplatformsettings__outlets_foreignkey | character varying | FK | Foreign key to fooddeliveryplatformsettings__outlets |
| fooddeliveryplatformsettings_foreignkey | character varying | FK | Foreign key to fooddeliveryplatformsettings |
| grabitemid | character varying | FK | Reference to grabitem |
| sectionid | character varying | FK | Reference to section |
| storehubitemid | character varying | FK | Reference to storehubitem |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |

**Relationships:**
- `fooddeliveryplatformsettings__outlets_foreignkey` → `fooddeliveryplatformsettings__outlets._id`
- `fooddeliveryplatformsettings_foreignkey` → `fooddeliveryplatformsettings._id`

#### fooddeliveryplatformsettings
- **Row Count:** 2,514
- **Columns:** 7
- **Relationships:** 1

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| business | character varying | FK |  |
| addonversion | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| hadenabled | boolean |  |  |
| isenabled | boolean |  |  |
| platform | double precision |  |  |

**Relationships:**
- `business` → `businesses._id` *(inferred)*

#### fooddeliveryplatformsettings__outlets
- **Row Count:** 1,717
- **Columns:** 16
- **Relationships:** 2

| Column | Type | Key | Description |
|--------|------|-----|-------------|
| _id | character varying | PK, FK | Unique identifier |
| fooddeliveryplatformsettings_foreignkey | character varying | FK | Foreign key to fooddeliveryplatformsettings |
| outletid | character varying | FK | Reference to outlet |
| storeid | character varying | FK | Reference to store |
| addonaccount | character varying |  | Count/quantity |
| addonpwd | character varying |  |  |
| data_modified_time | timestamp without time zone |  | ETL update timestamp |
| grabportalorderpollendat | character varying |  |  |
| grabportalorderpollstartat | character varying |  |  |
| hadenabled | boolean |  |  |
| isenabled | boolean |  |  |
| islived | boolean |  |  |
| isrequested | boolean |  |  |
| issynctaxexclusiveprice | boolean |  |  |
| sectionids | character varying |  |  |
| taxcode | character varying |  |  |

**Relationships:**
- `fooddeliveryplatformsettings_foreignkey` → `fooddeliveryplatformsettings._id`
- `storeid` → `businesses__stores._id` *(inferred)*

---
