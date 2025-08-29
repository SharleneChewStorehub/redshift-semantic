# Business Metrics and Filters Discovery Report

**Analysis Date:** 2025-08-19 00:47:27
**Total Filters Discovered:** 15 unique filter types
**Total Metrics Discovered:** 14 unique metric types

## Executive Summary

This report presents a comprehensive analysis of approximately 1000 real-world Metabase queries to discover recurring business filters and metrics. The analysis follows specific SQL snippet dictionary rules and schema mapping conventions.

---

## Discovered Reusable Filters (Ranked by Frequency)

### **Filter: Exclude Internal Accounts**
* **Found:** 1145 times
* **Common Variations:**
    * `CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0 and b.subscriptionstatus = 'Active' and b.country <> '' and (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) ) union (select b.name as bo_name, b.subscriptionstatus, s.id as subscriptionid, b.country, b.planid, sa."id" as "Addon Id", sa.quantity from chargebeeusd.subscriptions s left join chargebeeusd.subscriptions__addons sa on s.id = sa."_sdc_source_key_id" left join storehub_mongo.businesses b on b.subscriptionid = s.id where (lower(sa."id") like '%number%' or lower(sa."id") like '%kitchen%') and s.status = 'active' and (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) AND b.subscriptionstatus = 'Active' AND b.country = 'PH' ), numbers AS ( SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 ), store_specific_qr AS ( SELECT DISTINCT TRIM(SPLIT_PART(bpo.stores, ',', numbers.n)) AS store_value FROM qr_ph_payment_options bpo JOIN numbers ON numbers.n <= LENGTH(bpo.stores) - LENGTH(REPLACE(bpo.stores, ',', '')) + 1 JOIN valid_businesses b ON b._id = bpo.businesses_foreignkey WHERE TRIM(SPLIT_PART(bpo.stores, ',', numbers.n)) <> '' AND bpo.stores IS NOT NULL AND bpo.stores != 'All' ), all_stores_qr AS ( SELECT DISTINCT BS._id AS store_id FROM qr_ph_payment_options bpo JOIN valid_businesses b ON b._id = bpo.businesses_foreignkey JOIN storehub_mongo.businesses__stores BS ON BS.businesses_foreignkey = b._id WHERE bpo.stores = 'All' ), TotalEnabledStores AS ( SELECT COUNT(DISTINCT store_id) AS total_enabled_count FROM ( SELECT store_value AS store_id FROM store_specific_qr UNION SELECT store_id FROM all_stores_qr ) b JOIN storehub_mongo.businesses__stores BS ON BS._id = b.store_id WHERE bs.isdeleted IS NOT TRUE AND bs.name NOT IN ('Digital Store') ), ActiveStoresLast7Days AS ( SELECT COUNT(DISTINCT TR.storeid) AS active_store_count FROM "storehub_mongo"."transactionrecords" TR JOIN "storehub_mongo"."transactionrecords__payments" TRP ON TR._id = TRP.transactionrecords_foreignkey JOIN storehub_mongo.businesses b ON b.name = TR.business JOIN qr_ph_payment_options PO ON PO.businesses_foreignkey = b._id AND PO.paymentid = trp.paymentmethod WHERE TR.createdtime >= dateadd(hour, -8, cast(getdate() - 7 AS date)) AND TR.iscancelled IS NOT TRUE AND TR.transactiontype = 'Sale' AND TR.status NOT IN ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification') AND TR.total < 10000000 AND b.country = 'PH' AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) AND c_ios.isactivated = TRUE AND c_ios.platform = 'iOS' ), StoreRegisterStats AS ( SELECT b.name AS "Merchant Name", b.country AS "Country", c.storeid AS "Store ID", mbs_store.name AS "Store Name", c.platform, c._id AS register_id, b.enablecashback, b.enableloyalty, b._id AS business_id FROM storehub_mongo.businesses__cashregisters AS c INNER JOIN storehub_mongo.businesses AS b ON c.businesses_foreignkey = b._id LEFT JOIN "transformations"."mask_businesses__stores" AS mbs_store ON c.storeid = mbs_store."_id" WHERE c.isactivated = TRUE AND b.subscriptionstatus != 'Expired' AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) AND c_ios.isactivated = TRUE AND c_ios.platform = 'iOS' ), StoreRegisterStats AS ( SELECT b.name AS "Merchant Name", b.country AS "Country", c.storeid AS "Store ID", mbs_store.name AS "Store Name", c.platform, c._id AS register_id, b.enablecashback, b.enableloyalty, b._id AS business_id FROM storehub_mongo.businesses__cashregisters AS c INNER JOIN storehub_mongo.businesses AS b ON c.businesses_foreignkey = b._id LEFT JOIN transformations.mask_businesses__stores AS mbs_store ON c.storeid = mbs_store."_id" WHERE c.isactivated = TRUE AND b.subscriptionstatus != 'Expired' AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Delete Item from a Saved Open Order' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"deleteItemOfSaved":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Refund' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"refund":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Cancel' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"cancel":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Discount' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"discount":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Re-print/Re-send Receipt' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"reprintReceipt":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'Open/Close Shift' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"openCloseShift":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0) UNION ALL SELECT 'View/Manage Transactions' AS action_type, SUM(CASE WHEN LOWER("transformations"."mask_businesses__stores"."cashieraccesses") LIKE '%"viewEditTransaction":"1"%' THEN 1 ELSE 0 END) AS count FROM "transformations"."mask_businesses__stores" LEFT JOIN "transformations"."mask_businesses" b ON "transformations"."mask_businesses__stores"."businesses_foreignkey" = b."_id" WHERE b.subscriptionstatus = 'Active' AND "transformations"."mask_businesses__stores"."isdeleted" IS NOT TRUE AND (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) and "membershipsetting.firstgoliveat" is not null [[and b.name = {{bo_account_name}}]] ), m as ( SELECT distinct b.name, c.customerid, c._id as customer_id, c.membershipjointime from storehub_mongo.businesses b left join storehub_mongo.customers c on c.business = b.name where (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) and b.country = 'PH' and tr.createdtime >= dateadd(hour,-8,'2025-03-01') and bpo.additionalinfo like '%"qrCodeType":"dynamic","qrCodeProvider":"Modulus Labs - QR Ph"%' ), businesses_po as ( select distinct b.name, bpo.businesses_foreignkey, bpo.name as payment_method, bpo._id as paymentid from storehub_mongo.businesses b left join storehub_mongo.businesses__paymentoptions bpo on bpo.businesses_foreignkey = b._id where (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * `CHARINDEX('@storehub.com', b.email) = 0) and cj.createdtime >= '2022-09-23' and cj.createdtime < '2023-05-05' [[and b.country = {{country}}]] [[and (cj.createdtime >= dateadd(hour,0,{{Start_Date}}) and cj.createdtime < dateadd(hour,24,{{End_Date}}))]] union select date_trunc('month', cast(dateadd(hour,8,cl.createdtime) as date)) as month, cl.business as active_merchant from storehub_mongo.campaignlogs cl left join storehub_mongo.businesses b on b.name = cl.business where (CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0`
    * ... and 36 more variations

---

### **Filter: Transaction Status Filter**
* **Found:** 582 times
* **Common Variations:**
    * `TR.status NOT IN ( 'cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification' )`
    * `TR.status NOT IN ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
    * `TR.status NOT IN ('created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
    * `status <> 'cancelled'`
    * `status NOT IN ( 'cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification' )`
    * `status NOT IN ( 'cancelled','created','failed', 'paymentCancelled','pendingPayment','pendingVerification' )`
    * `status NOT IN ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
    * `status NOT IN ('created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
    * `status not in ('cancelled')`
    * `status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
    * ... and 15 more variations

---

### **Filter: Date Filters**
* **Found:** 568 times
* **Common Variations:**
    * `CAST("Transaction Records - Businesses Stores Foreign Key"."createdtime" AS date) = CAST(dateadd('day', -1, CAST(getdate() AS timestamp)) AS date)`
    * `CAST("storehub_mongo"."transactionrecords"."createdtime" AS date) BETWEEN CAST(dateadd('day', -{{How_many_days}}, CAST(getdate() AS timestamp)) AS date) AND CAST(dateadd('day', -1, CAST(getdate() AS timestamp)) AS date)`
    * `CAST((getdate() + INTERVAL '-12 month') AS date))) and storehub_mongo.transactionrecords.createdtime < dateadd(hour,16,cast(getdate() as date)`
    * `CAST((getdate() + INTERVAL '-3 month') AS date))) and storehub_mongo.transactionrecords.createdtime < dateadd(hour,16,cast(getdate() as date)`
    * `CAST((getdate() + INTERVAL '-3 month') AS date))) and tr.createdtime < dateadd(hour,16,cast(getdate() as date)`
    * `CAST(DATEADD('day', -30, CAST(GETDATE() AS timestamp)) AS date)) AND ("transformations"."mask_customers"."createdtime" < CAST(GETDATE() AS date)`
    * `CAST(dateadd(hour,-8,storehub_mongo.transactionrecords.createdtime) as date) > CAST((getdate() + INTERVAL '-{{lastxdays}} day') AS date)`
    * `CAST(dateadd(hour,8,"storehub_mongo"."transactionrecords"."createdtime") AS date) = CAST(getdate() AS date)`
    * `CAST(dateadd(hour,8,"storehub_mongo"."transactionrecords"."createdtime") AS date) > '2022-03-19' [[and cast(dateadd(hour,8,"storehub_mongo"."transactionrecords"."createdtime") as date) between cast(dateadd(hour,8,{{Start_Date}}) as date) and cast(dateadd(hour,8,{{End_Date}}) as date)]] [[or cast(dateadd(hour,8,"storehub_mongo"."transactionrecords"."createdtime") as date) between cast(dateadd(hour,8,{{Start_Date}}) as date) and cast(dateadd(hour,8,{{End_Date}}) as date)`
    * `CAST(dateadd(hour,8,"storehub_mongo"."transactionrecords"."createdtime") AS date) > CAST('2022-03-19T16:00:00.000Z'::timestamp AS date)`
    * ... and 70 more variations

---

### **Filter: Subscription Status Active**
* **Found:** 456 times
* **Common Variations:**
    * `B.subscriptionstatus = 'Active'`
    * `b.subscriptionstatus = 'Active'`
    * `status = 'ACTIVE'`
    * `status = 'Active'`
    * `status = 'active'`
    * `subscriptionstatus = 'Active'`

---

### **Filter: Beep Transactions**
* **Found:** 402 times
* **Common Variations:**
    * `channel = 3`
    * `channel =3`
    * `tr.channel = 3`
    * `tr.channel =3`

---

### **Filter: Not Cancelled Transactions**
* **Found:** 324 times
* **Common Variations:**
    * `TR.iscancelled IS NOT TRUE`
    * `TR.iscancelled is not TRUE`
    * `iscancelled IS NOT TRUE`
    * `iscancelled is NOT TRUE`
    * `iscancelled is not TRUE`
    * `iscancelled is not True`
    * `iscancelled is not true`
    * `tr.iscancelled IS NOT TRUE`
    * `tr.iscancelled is NOT TRUE`
    * `tr.iscancelled is not TRUE`
    * ... and 2 more variations

---

### **Filter: Transaction Type Sale**
* **Found:** 275 times
* **Common Variations:**
    * `TR.transactiontype = 'Sale'`
    * `tr.transactiontype = 'Sale'`
    * `transactiontype = 'Sale'`

---

### **Filter: Offline Transactions**
* **Found:** 199 times
* **Common Variations:**
    * `channel = 2`
    * `channel IS NULL`
    * `channel is null`
    * `tr.channel IS NULL`
    * `tr.channel is null`

---

### **Filter: Country Filter**
* **Found:** 198 times
* **Common Variations:**
    * `B.country = 'PH'`
    * `b.country = 'MY'`
    * `b.country = 'PH'`
    * `b.country = 'TH'`
    * `country = 'MY'`
    * `country = 'PH'`
    * `country = 'TH'`

---

### **Filter: Online Transactions**
* **Found:** 146 times
* **Common Variations:**
    * `channel = 1`
    * `tr.channel = 1`

---

### **Filter: Delivery Shipping**
* **Found:** 132 times
* **Common Variations:**
    * `shippingtype = 'delivery'`
    * `shippingtype in ('delivery', 'pickup')`
    * `shippingtype in ('delivery', 'pickup', 'dineIn', 'takeaway')`
    * `shippingtype in ('delivery', 'pickup', 'takeaway', 'dineIn')`
    * `shippingtype in ('delivery', 'pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup')`
    * `shippingtype in ('delivery','pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup','takeaway','dineIn')`
    * `shippingtype in ('dineIn','takeaway','delivery')`
    * `shippingtype in ('pickup', 'delivery')`
    * ... and 2 more variations

---

### **Filter: Dinein Takeaway**
* **Found:** 130 times
* **Common Variations:**
    * `shippingtype in ('delivery', 'pickup', 'dineIn', 'takeaway')`
    * `shippingtype in ('delivery', 'pickup', 'takeaway', 'dineIn')`
    * `shippingtype in ('delivery', 'pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup','takeaway','dineIn')`
    * `shippingtype in ('dineIn', 'takeaway')`
    * `shippingtype in ('dineIn','takeaway')`
    * `shippingtype in ('dineIn','takeaway','delivery')`
    * `shippingtype in ('pickup', 'delivery', 'takeaway', 'dineIn')`
    * `shippingtype in ('takeaway', 'dineIn')`
    * ... and 4 more variations

---

### **Filter: Pickup Shipping**
* **Found:** 116 times
* **Common Variations:**
    * `shippingtype in ('delivery', 'pickup')`
    * `shippingtype in ('delivery', 'pickup', 'dineIn', 'takeaway')`
    * `shippingtype in ('delivery', 'pickup', 'takeaway', 'dineIn')`
    * `shippingtype in ('delivery', 'pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup')`
    * `shippingtype in ('delivery','pickup','dineIn','takeaway')`
    * `shippingtype in ('delivery','pickup','takeaway','dineIn')`
    * `shippingtype in ('pickup', 'delivery')`
    * `shippingtype in ('pickup', 'delivery', 'takeaway', 'dineIn')`
    * `shippingtype in('pickup', 'delivery')`

---

### **Filter: Business Type Filter**
* **Found:** 14 times
* **Common Variations:**
    * `b.businesstype in (`
    * `businesstype in (`

---

### **Filter: Qr Ordering Enabled**
* **Found:** 10 times
* **Common Variations:**
    * `b.isqrorderingenabled = TRUE`
    * `b.isqrorderingenabled = true`
    * `b.isqrorderingenabled=true`
    * `isqrorderingenabled = TRUE`
    * `isqrorderingenabled = true`
    * `isqrorderingenabled=true`

---


## Discovered Business Metrics (Ranked by Frequency)

### **Metric: Transaction Count**
* **Found:** 262 times
* **Common Calculations:**
    * `COUNT(*)`
    * `COUNT(DISTINCT TR._id)`
    * `COUNT(distinct TR._id) AS "Total Transactions", COUNT(distinct CASE WHEN PO."type" = 'paymentTerminal' THEN TR._id END) AS "GHL Transactions", ROUND(CAST(COUNT(distinct CASE WHEN PO."type" = 'paymentTerminal' THEN TR._id END) AS FLOAT) / COUNT(distinct TR._id)`
    * `Total Transactions`
    * `Transaction Count`
    * `Transaction count`
    * `Txn#`
    * `count(*)`
    * `count(distinct receiptnumber)`
    * `count(distinct tr._id)`
    * ... and 4 more variations

---

### **Metric: Subscription Metrics**
* **Found:** 200 times
* **Common Calculations:**
    * `Subscription Id", sa."id" as "Addon Id", sa.quantity as "Addon Quantity", s.currency_code as "Currency", cast(sa.unit_price as float)/100 as "Addon Unit Price", cast(sa.amount as float)/100 as "Addon Amount", '' as "Addon Amount In Decimal", '' as "Addon Quantity In Decimal", '' as "Addon Unit Price In Decimal", c.company as "bo_name", c.email as "CB account email", s.status as "CB Status`
    * `activated as "cash register activated", bcr.platform AS "cash register plat`
    * `activated register", storehub_mongo.businesses__stores.isonline, transactionrecords.count as "Last 30 days transactions", transactionrecords."# online transactions", transactionrecords."# beep transactions", transactionrecords."# POS transactions", storehub_mongo.businesses__stores.street1, storehub_mongo.businesses__stores.street2, storehub_mongo.businesses__stores.city, storehub_mongo.businesses__stores.postalcode, storehub_mongo.businesses__stores.stat`
    * `activated_at) AS date) as "Activated Dat`
    * `activated_at) as date) as acc_sub_currentactivat`
    * `activated_at) as timestamp) as activated_at, reg.plat`
    * `activated_at, cbrmc.billing_address__country, cbrms.next_billing_at`
    * `activated_at, cs1.plan_id, cs1.stat`
    * `activated_at, cs1.plan_id, cs1.status, cs1.next_billing_at`
    * `activated_at, cs2.plan_id, cs2.status, case when sa2."id" like '%engage%' then sa2."id" end as engage_sub, cs2.next_billing_at`
    * ... and 70 more variations

---

### **Metric: Revenue Total**
* **Found:** 98 times
* **Common Calculations:**
    * `SUM(TR.total)`
    * `SUM(tr.total)`
    * `sum(tr.total)`

---

### **Metric: Tax Amount**
* **Found:** 61 times
* **Common Calculations:**
    * `Tax`
    * `tax`

---

### **Metric: Net Sales**
* **Found:** 39 times
* **Common Calculations:**
    * `SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."quantity",0) ELSE COALESCE(+tri."quantity",0) END) AS salesItemsCount, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(0,0) ELSE COALESCE(+tri."total",0) END) AS sales, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(+tri."total",0) ELSE COALESCE(0,0) END) AS returns, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."discount",0) ELSE COALESCE(+tri."discount",0) END) AS discount, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."subtotal",0) ELSE COALESCE(+tri."subtotal",0) END) AS subtotal, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS returnsCount, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."tax",0) ELSE COALESCE(+tri."tax",0) END) AS tax, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."cost",0) ELSE COALESCE(+tri."cost",0) END) AS cost, SUM(CASE WHEN tr."transactiontype"='Return' THEN COALESCE(-tri."quantity",0) ELSE COALESCE(+tri."quantity",0) END)`
    * `SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(0,0) ELSE COALESCE(+tr.total,0) END) AS "Total Sales", COUNT(*) AS "Total Transactions", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.discount,0) ELSE COALESCE(+tr.discount,0) END) AS "Total Discount", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.tax,0) ELSE COALESCE(+tr.tax,0) END) AS "Tax", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.servicecharge,0) ELSE COALESCE(+tr.servicecharge,0) END) AS "Service Charge", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Count", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(+tr.total,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Amount", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.subtotal,0) ELSE COALESCE(+tr.subtotal,0) END) AS "SubTotal", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.roundedamount,0) ELSE COALESCE(+tr.roundedamount,0) END) AS "Rounding", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.cost,0) ELSE COALESCE(+tr.cost,0) END)`
    * `SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(0,0) ELSE COALESCE(+tr.total,0) END) AS "Total Sales", COUNT(*) AS "Total Transactions", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.discount,0) ELSE COALESCE(+tr.discount,0) END) AS "Total Discount", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.tax,0) ELSE COALESCE(+tr.tax,0) END) AS "Tax", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.shippingfee, 0) ELSE COALESCE(+ tr.shippingfee, 0) END) AS "Shipping Fee", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.servicecharge,0) ELSE COALESCE(+tr.servicecharge,0) END) AS "Service Charge", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Count", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(+tr.total,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Amount", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(0, 0) ELSE COALESCE(+ tr.pax, 0) END) AS "Pax", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.subtotal,0) ELSE COALESCE(+tr.subtotal,0) END) AS "SubTotal", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.roundedamount,0) ELSE COALESCE(+tr.roundedamount,0) END) AS "Rounding", SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.cost,0) ELSE COALESCE(+tr.cost,0) END)`
    * `SUM(CASE WHEN transactiontype='Return' THEN COALESCE(0,0) ELSE COALESCE(+total,0) END) AS "Total Sales" ,COUNT(*) AS "Total Transactions" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-discount,0) ELSE COALESCE(+discount,0) END) AS "Total Discount" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-tax,0) ELSE COALESCE(+tax,0) END) AS "Tax" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-servicecharge,0) ELSE COALESCE(+servicecharge,0) END) AS "Service Charge" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Count" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(+total,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Amount" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-subtotal,0) ELSE COALESCE(+subtotal,0) END) AS "SubTotal" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-roundedamount,0) ELSE COALESCE(+roundedamount,0) END) AS "Rounding" ,SUM(CASE WHEN transactiontype='Return' THEN COALESCE(-cost,0) ELSE COALESCE(+cost,0) END)`
    * `Total Sales`
    * `sum (case when tr.transactiontype = 'Sale' then tri.total else -tri.total end) as "Product total", sum (case when tr.transactiontype = 'Sale' then tri.tax else -tri.tax end)`
    * `sum(case when (tr.channel is null or tr.channel = 2) and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Offline (#)", sum(case when (tr.channel is null or tr.channel = 2) and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Offline ($)", sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Ecomm (#)", sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Ecomm ($)", sum(case when tr.channel = 3 then 1 else 0 end) as "All Beep (#)", sum(case when tr.channel = 3 then tr.total else 0 end) as "All Beep ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'delivery' then 1 else 0 end) as "Beep Delivery (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'delivery' then tr.total else 0 end) as "Beep Delivery ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'pickup' then 1 else 0 end) as "Beep Pick Up (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'pickup' then tr.total else 0 end) as "Beep Pick Up ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'dineIn' then 1 else 0 end) as "Beep Dine In (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'dineIn' then tr.total else 0 end) as "Beep Dine In ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'takeaway' then 1 else 0 end) as "Beep takeaway (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'takeaway' then tr.total else 0 end)`
    * `sum(case when (tr.channel is null or tr.channel = 2) and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Offline (#)", sum(case when (tr.channel is null or tr.channel = 2) and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Offline ($)", sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Ecomm (#)", sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Ecomm ($)", sum(case when tr.channel = 3 then 1 else 0 end) as "All Beep (#)", sum(case when tr.channel = 3 then tr.total else 0 end) as "All Beep ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'delivery' then 1 else 0 end) as "Beep Delivery (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'delivery' then tr.total else 0 end) as "Beep Delivery ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'pickup' then 1 else 0 end) as "Beep Pick Up (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'pickup' then tr.total else 0 end) as "Beep Pick Up ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'dineIn' then 1 else 0 end) as "Beep Dine In (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'dineIn' then tr.total else 0 end) as "Beep Dine In ($)", sum(case when tr.channel = 3 and tr.shippingtype = 'takeaway' then 1 else 0 end) as "Beep takeaway (#)", sum(case when tr.channel = 3 and tr.shippingtype = 'takeaway' then tr.total else 0 end) as "Beep takeaway ($)`
    * `sum(case when tr.channel is null and tr.transactiontype = 'Sale' then tr.total end) as "Offline Transaction GMV", count(distinct case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr.receiptnumber end) as "Beep QR Txn#", sum(case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr.total end) as "Total Beep QR GMV", count(distinct case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr.receiptnumber end) as "Beep delivery Txn#", sum(case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr.total end)`
    * `sum(case when tr.channel is null or tr.channel = 2 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Offline (#)" , sum(case when tr.channel is null or tr.channel = 2 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Offline ($)" , sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then 1 else 0 end) as "Ecomm (#)" , sum(case when tr.channel = 1 and tr.transactiontype = 'Sale' and tr.iscancelled is not true then tr.total else 0 end) as "Ecomm ($)" , sum(case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then 1 else 0 end) as "Beep QR (#)" , sum(case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr.total else 0 end) as "Beep QR ($)" , sum(case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then 1 else 0 end) as "Beep Delivery (#)" , sum(case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr.total else 0 end)`
    * ... and 5 more variations

---

### **Metric: Cashback Amount**
* **Found:** 23 times
* **Common Calculations:**
    * `Cashback reminder' when re.globalCampaignInformationId = '630eeb369ce7f44578cf2cac' then 'Win back lost customers' when re.globalCampaignInformationId = '630eeb369ce7f44578cf2cad' then 'Birthday promotion' end as campaign_name, count(distinct re.campaignjobId) as total_customer_reach, count(distinct re.customerphone) as total_unique_customer_reach, count(case when txncreatedtime BETWEEN re.createdtime and DATEADD('day', {{atrribution_days}}, re.createdtime) then re.txnCustomerid end) as total_return_customer, count(distinct re.txn`
    * `Cashback reminder' when re.globalCampaignInformationId = '630eeb369ce7f44578cf2cac' then 'Win back lost customers' when re.globalCampaignInformationId = '630eeb369ce7f44578cf2cad' then 'Birthday promotion' when re.globalCampaignInformationId = '640996dffd94756d7291de0e' then 'Welcome new customer' end as campaign_name, dateadd(hour,8,re.createdtime) as sms_sent_time, dateadd(hour,8,re.txncreatedtime) as repurchase_txn_time, DATEDIFF(day, re.createdtime, re.txncreatedtime) as days_since_receive_sms, re.total as order_value, ROW_NUMBER() OVER(PARTITION BY re.customerphone, campaign_name, re.createdtime ORDER BY re.txn`
    * `cashback_enabled" AS cashback_enabled, eb."beep_ordering_enabled" AS qr_enabled, eb."plan" AS subscription_plan, eb."qrdinein_txn_count_past30days" AS qr_txn_count_p30d, eb."qrdinein_txn_value_past30days" AS qr_gmv_p30d, eb."cashbackclaims_count_past30days" AS claimed_cb_count_p30d, eb."cashbackclaims_value_past30days" AS claimed_cb_amount_p30d, eb."qrdinein_txn_count_past7days" AS qr_txn_count_p7d, eb."qrdinein_txn_value_past7days" AS qr_gmv_p7d, eb."cashbackclaims_count_past7days" AS claimed_cb_count_p7d, eb."cashbackclaims_value_past7days" AS claimed_cb_amount_p7d, eb."cashback_campaignstatus", eb."winbacklostcustomers_campaignstatus", eb."birthdaypromotion_campaignstatus", eb."sms_sent_past30days" AS total_sms_sent_past30d, eb."sms_sent_past7days" AS total_sms_sent_p7d, eb."boostgooglereview_campaignstatus", eb."welcomenewcustomers_campaignstatus", eb."expiringcashbackalert_campaignstatus", eb."total_sms_sent_p180d" AS total_sms_sent_p6m, eb."campaign_published", eb."sms_credit_balance", eb."active_campaign_count", eb."engage_status", eb."cashbackexpiry_enabled", eb."crm_count_p7d", eb."crm_count_p30d", eb."bgr_total_sms_sent_p180d" AS bgr_total_sms_sent_p6m, eb."custom_total_sms_sent_p180d" AS custom_total_sms_sent_p6m, eb."engage_trial_end_date", eb."engage_trial_start_date", eb."pos_txn_count_past30days", eb."pos_txn_value_past30days" as offline_gmv_p30d, eb."beepdelivery_txn_count_past30days" AS bd_txn_count_p30d, eb."beepdelivery_txn`
    * `cashback_enabled, eb.beep_ordering_enabled, eb.beep_delivery_enabled, eb.first_enable_qrordering_date, eb.first_enable_cashback_date, eb.bdfirsttxndate, eb.beepqrfirsttxndate, eb.posfirsttxndate, eb.txnmorethanten, eb.pos_txn_count_past30days, eb.beepdelivery_txn_count_past30days, eb.qrdinein_txn_count_past30days, eb.pos_txn_value_past30days, eb.beepdelivery_txn_value_past30days, eb.qrdinein_txn_value_past30days, eb.cashbackclaims_count_past30days, eb.cashback_campaignstatus, eb.winbacklostcustomers_campaignstatus, eb.birthdaypromotion_campaignstatus, eb.boostgooglereview_campaignstatus, eb.welcomenewcustomers_campaignstatus, eb.expiringcashbackalert_campaignstatus, eb.sms_sent_past30days, eb.sms_sent_past7days, eb.pos_txn_count_past7days, eb.beepdelivery_txn_count_past7days, eb.qrdinein_txn_count_past7days, eb.pos_txn_value_past7days, eb.beepdelivery_txn_value_past7days, eb.qrdinein_txn_value_past7days, eb.cashbackclaims_count_past7days, eb.qr_gmv_usage_past30days, eb.qr_gmv_usage_past7days, eb.cashbackclaims_value_past30days, eb.cashbackclaims_value_past7days, eb.qr_txn_usage_past30days, eb.qr_txn`
    * `enablecashback`

---

### **Metric: Payment Gateway Metrics**
* **Found:** 10 times
* **Common Calculations:**
    * `Max Revenue`
    * `gateway, trp.paymentmethod, count(distinct payoutitems.receiptnumber) AS "# of txn", sum(case when gr._id is not null and payoutitems.reconstatus = 'pending' then 1 else 0 end) as "Total need recon", sum(case when gr._id is null then 1 else 0 end) as "Total no gateway records`
    * `paymentTerminal`
    * `paymentTerminal' THEN TR._id END) AS "GHL Transactions", ROUND(CAST(COUNT(distinct CASE WHEN PO."type" = 'paymentTerminal`
    * `paymentTerminal' THEN TRP.amount ELSE 0 END) AS "Total Amount transacted with GHL", SUM(CASE WHEN PO."type" = 'paymentTerminal`

---

### **Metric: Discount Amount**
* **Found:** 9 times
* **Common Calculations:**
    * `Total Discount`
    * `discount * trp.storehubpaidpercentage`
    * `discount is not null then round(trpr.discount * trpr.storehubpaidpercentage, 2) when trip.discount is not null then round(trip.discount * trip.storehubpaidpercentage`

---

### **Metric: Customer Count**
* **Found:** 8 times
* **Common Calculations:**
    * `count(distinct business)`
    * `customer_count`
    * `total_customers`
    * `unique_customers`

---

### **Metric: Average Order Value**
* **Found:** 7 times
* **Common Calculations:**
    * `AOV`

---

### **Metric: Service Charge**
* **Found:** 6 times
* **Common Calculations:**
    * `Service Charge`

---

### **Metric: Conversion Rate**
* **Found:** 6 times
* **Common Calculations:**
    * `claim_count , count (distinct t._id) txn_count , claim_count::float*100/txn_count claim_rate`
    * `claimed cashback #", sum(case when lc.eventtype = 'earned' then lc.amount end) as "claimed cashback amount", count(distinct case when lc.eventtype = 'expense' then lc.receiptnumber end) as "redeemed cashback #", -sum(case when lc.eventtype = 'expense' then lc.amount end) as "redeemed cashback amount", "redeemed cashback amount" / "claimed cashback amount" as "cashback utilisation rate`
    * `claimed cashback amount (SGD)", -sum(case when lc.eventtype = 'expense' and b.country = 'MY' then lc.amount * {{myr_rate}} when lc.eventtype = 'expense' and b.country = 'PH' then lc.amount * {{php_rate}} when lc.eventtype = 'expense' and b.country = 'TH' then lc.amount * {{thb_rate}} when lc.eventtype = 'expense' and b.country = 'SG' then lc.amount end) as "redeemed cashback amount (SGD)", "redeemed cashback amount (SGD)" / "claimed cashback amount (SGD)" as "cashback utilisation rate`

---

### **Metric: Active Merchants**
* **Found:** 4 times
* **Common Calculations:**
    * `active merchants`
    * `subscriptionstatus, b.smscredits, b.country, sum(case when c.globalcampaigninformationid <> '64d4d6b30f005152c96d10cb' and c.status = 'ACTIVE' then 1 else 0 end) as automated_active, sum(case when c.globalcampaigninformationid <> '64d4d6b30f005152c96d10cb' and c.status = 'DRAFT' then 1 else 0 end) as automated_draft, sum(case when c.globalcampaigninformationid <> '64d4d6b30f005152c96d10cb' and c.status = 'PAUSED' then 1 else 0 end) as automated_paused, sum(case when c.globalcampaigninformationid <> '64d4d6b30f005152c96d10cb' and c.status = 'SUSPENDED' then 1 else 0 end) as automated_suspended, sum(case when c.globalcampaigninformationid = '64d4d6b30f005152c96d10cb' and c.status = 'ACTIVE'`
    * `subscriptionstatus, b.smscredits, b.country, sum(case when c.status = 'ACTIVE'`

---

### **Metric: Shipping Fees**
* **Found:** 4 times
* **Common Calculations:**
    * `Shipping Fee`
    * `shipping fee`

---


## Applied Transformations

### SQL Snippet Dictionary Applied
The following SQL snippets were automatically replaced during analysis:
* `{{snippet: Eliminate Internal Accounts}}` → `(CHARINDEX('internal', b.planid) = 0 AND CHARINDEX('@storehub.com', b.email) = 0)`
* `{{snippet: Beep Delivery Transactions Filter}}` → `tr.shippingtype = 'delivery' AND tr.channel = 3 AND tr.status not in ('cancelled','created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
* `{{snippet: Beep QR Transactions Filter}}` → `tr.channel = 3 AND tr.shippingtype in ('dineIn','takeaway') AND tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
* `{{snippet: Beep Transactions Filter}}` → `tr.channel = 3 AND tr.shippingtype in ('delivery','pickup','dineIn','takeaway') AND tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`
* `{{snippet: Offline / POS Transaction filter}}` → `(tr.channel is null or tr.channel = 2) AND tr.transactiontype = 'Sale' AND tr.iscancelled is not TRUE AND tr.status not in ('cancelled','created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')`

### Schema Mapping Applied
The following schema mappings were applied during analysis:
* `transformations.mask_businesses` → `storehub_mongo.businesses`
* `transformations.mask_employees` → `storehub_mongo.employees`
* `transformations.mask_customers` → `storehub_mongo.customers`

## Methodology

### Pattern Recognition
- **Filters:** Extracted from WHERE clauses using regex patterns for common business logic
- **Metrics:** Identified from SELECT clauses focusing on aggregation functions and business calculations
- **Frequency Ranking:** Items sorted by occurrence count across all analyzed queries

### Limitations
* Complex nested subqueries may not be fully captured
* Dynamic SQL or programmatically generated queries may be missed
* Business logic embedded in application code is not included
