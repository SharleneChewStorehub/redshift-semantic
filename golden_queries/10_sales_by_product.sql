-- I need a detailed product profitability report for 'signaturebeefnoodles' for the first half of 2025. Can you show me a monthly breakdown, per store, for each product, including their net sales, gross profit, and gross profit margin?

with transactions as (
select 
    tr._id as transactionid,
    tr.business,
    REGEXP_REPLACE (REGEXP_REPLACE (bs.name, '&#39;', ''''), '%7C;', ' - ') as storename,
    tr.storeid,
    tr.servicecharge,
    tr.total,
    tr.tax,
    tr.subtotal,
    tr.cost,
    tr.discount,
    CASE WHEN (tr.channel is null or tr.channel = 2) THEN 0 ELSE tr.channel END AS channel,
    tr.roundedamount,
    tr.paymentmethod,
    tr.employeenumber,
    tr.transactiontype,
    tr.status,
    tr.iscancelled,
    tr.createdtime,
    tr.modifiedtime,
    tr.customerid,
    tr.pax,
    --e.employee_firstname,
    --e.employee_lastname,
    --e.employee_name,
    --e.employee_email,
    --c.customer_totaltransactions,
    --c.customer_firstname,
    --c.customer_lastname,
    --c.customer_email,
    --c.customer_phone,
    --CASE WHEN tr.transactionid = c.firstpurchase_transactionid THEN c.firstpurchase_date ELSE NULL END AS customer_createdtime,
    --c.customer_tags,
    --bs.store_data_modified_time,
    --c.customer_data_modified_time,
    --e.employee_data_modified_time,
    tr.data_modified_time as real_data_modified_time,
    tr.shippingtype,
    CASE 
        WHEN (tr.channel is null or tr.channel = 2) THEN 0 
        WHEN tr.channel = 3 and tr.shippingtype in ('dineIn', 'takeaway') THEN 98
        WHEN tr.channel = 3 and tr.shippingtype in ('delivery', 'pickup') THEN 99
        ELSE tr.channel 
    END AS displaychannel,
    0.00 AS shippingfee

from storehub_mongo.transactionrecords tr

--left join storehub_mongo.employees e
--    on e.employeenumber = tr.employeenumber         
--    and tr.business = e.business

--left join storehub_mongo.customers c
--    on c.customerid = tr.customerid 
--    and tr.business = c.business

left join storehub_mongo.businesses__stores bs
    on bs._id = tr.storeid 

where tr.modifiedtime >= dateadd(hour,-8,'2022-01-01')
    and tr.modifiedtime >= dateadd(hour,-8,'2025-01-01') and tr.modifiedtime < dateadd(hour,-8,'2025-07-01')
    and tr.business = 'signaturebeefnoodles'
    --and tr._id in ('675fe430a740d9000728b780','675fbb3b510a3000073f61fb','675fbe8a2332d7000765c6e7','676142b6a422150007aeba56','675fc41f028abe00079b6796','6760ed9a068e5f000755a21c','675fd7fe06adff000607d2c5')
),

products as (
select
    products1._id as productid,
    products1.original_id as original_id,
    CASE WHEN products2.title is null THEN products1.title ELSE products2.title END AS parentproduct_title,
    products1.title as product_title,
    products1.skunumber,
    products1.cost,
    products1.category as product_category,
    products1.tags as product_tags,
    products1.supplierid + ',' + products1.supplierids as supplierids,
    products1.data_modified_time as product_data_modified_time

from storehub_mongo.products as products1

left join storehub_mongo.products as products2 
    on products1.parentproductid = products2.original_id

where products1.business = 'signaturebeefnoodles'
),

report_transaction_items as (
select 
    ti._id,
    ti.productid as productid,
    ti.total,
    ti.subtotal,
    ti.unitprice,
    CASE WHEN ti.cost is null THEN 0 ELSE ti.cost END AS cost,
    ti.tax,
    ti.discount,
    ti.quantity,
    ti.itemtype,
    ti.employeeid,
    ti.employeename,

    transactions.business + '_' + ti.productid as business_productid,
    transactions.pax,
    transactions.transactionid,
    transactions.transactiontype,
    transactions.createdtime,
    transactions.business,
    transactions.status,
    transactions.channel,
    transactions.iscancelled,
    transactions.paymentmethod,
    transactions.storeid,
    transactions.storename,
    transactions.employeenumber,
    transactions.customerid,
    --transactions.employee_firstname,
    --transactions.employee_lastname,
    --transactions.employee_name,
    --transactions.employee_email,
    --transactions.customer_createdtime,
    --transactions.customer_firstname,
    --transactions.customer_lastname,
    --transactions.customer_tags,
    --transactions.customer_name,
    --transactions.customer_email,
    --transactions.customer_phone,
    transactions.servicecharge,
    transactions.roundedamount,

    products.skunumber,
    products.product_tags,
    products.supplierids,
    products.product_title,
    products.parentproduct_title,
    products.product_category,
    products.productid as original_product_id,

    ti.data_modified_time as real_data_modified_time,
    products.product_data_modified_time as product_data_modified_time,

    transactions.shippingtype,
    transactions.displaychannel

from storehub_mongo.transactionrecords__items ti

inner join transactions 
    on ti.transactionrecords_foreignkey = transactions.transactionid

left join products 
    on ti.productid = products.original_id
)


select
    --b."Store ID"
    t.storename as "Store Name"
    , t."month"
    --, t.employeeid,
    --, t.employeename,
    , t.parentproduct_title as "Product Name"
    , t.product_category as "Product Category"
    , t.skunumber as "SKU"
    , t.salesItemsCount as "Total Item Sold"
    , t.sales + t.tax as "Total Sales"
    , t.returns as "Total Sales Returned"
    , t.discount as "Total Discount"
    , COALESCE(t.discount / NULLIF(t.subtotal,0) *100, 0) AS "Discount %"
    , t.sales as "Item Net Sales"
    , COALESCE(t.cost / NULLIF(t.quantity,0), 0) as "Average Cost" --Sum of Item Cost / Total Item Sold
    , COALESCE("Item Net Sales" / NULLIF(t."count",0), 0) AS "Average Net Sales" --Net Sales / Total Transaction * Total transaction includes both sale transactions and returned transactions
    , "Item Net Sales" - t.cost AS "Gross Profit"
    , COALESCE(("Item Net Sales" - t.cost) / NULLIF("Item Net Sales",0) * 100, 0) AS "Gross Profit %"
    
    --, t.salesSubtotal - t.salesDiscount + t.tax as "Total Sales2"
    --, t.returnsSubtotal - t.returnsDiscount as "Total Sales Returned2"
    --, t.sales - t.tax - t.serviceCharge - t.rounding - t.returns AS "Item Net Sales" 
    --, t.subtotal - t.discount as "Item Net Sales2"
    --, COALESCE(t.salesCost / NULLIF(t.quantity,0), 0) as "Average Cost2" 
    --, COALESCE("Item Net Sales2" / NULLIF(t."count",0), 0) AS "Average Net Sales2"
    
from (
    SELECT 
        rti.storename,
        date_trunc('month',cast(dateadd(hour,8,rti.createdtime) as date)) AS "month",
        --rti.product_title as "Product Name",
        COUNT(rti."*") AS "count", --total transaction
        --rti.employeeid,
        --rti.employeename,
        rti."parentproduct_title" AS parentproduct_title,
        rti."product_category" AS product_category,
        rti."skunumber" AS skunumber,
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."quantity",0) ELSE COALESCE(+rti."quantity",0) END) AS salesItemsCount, -- =sold items quantity - returned items quantity
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(0,0) ELSE COALESCE(+rti."total",0) END) AS sales, -- sold items sales
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(+rti."total",0) ELSE COALESCE(0,0) END) AS returns, -- returned items sales
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."discount",0) ELSE COALESCE(+rti."discount",0) END) AS discount, -- =sold items discount - returned items discount
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."subtotal",0) ELSE COALESCE(+rti."subtotal",0) END) AS subtotal, -- =sold items subtotal - returned items subtotal
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS returnsCount, -- returned items quantity
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."tax",0) ELSE COALESCE(+rti."tax",0) END) AS tax, -- =sold items tax - returned items tax
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."cost",0) ELSE COALESCE(+rti."cost",0) END) AS cost, -- =sold items cost - returned items cost
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."quantity",0) ELSE COALESCE(+rti."quantity",0) END) AS quantity, 
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."roundedamount",0) ELSE COALESCE(+rti."roundedamount",0) END) AS rounding, -- transaction level info: sales rounded amount - returned rounded amount
        SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(-rti."servicecharge",0) ELSE COALESCE(+rti."servicecharge",0) END) AS serviceCharge -- transaction level info: sales service charge - returned service charge
        
        --SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(0,0) ELSE COALESCE(+rti."discount",0) END) AS salesDiscount,  -- sold items discount
        --SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(0,0) ELSE COALESCE(+rti."subtotal",0) END) AS salesSubtotal, -- sold items subtotal
        --SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(+rti."discount",0) ELSE COALESCE(0,0) END) AS returnsDiscount, -- returned items discount
        --SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(+rti."subtotal",0) ELSE COALESCE(0,0) END) AS returnsSubtotal, -- returned items subtotal
        --SUM(CASE WHEN rti."transactiontype"='Return' THEN COALESCE(0,0) ELSE COALESCE(+rti."cost",0) END) AS salesCost -- sold items cost
        
    FROM report_transaction_items rti
    
    WHERE rti.status not in ('pendingPayment','failed','created','paymentCancelled') 
        AND rti.iscancelled is not true 
        AND rti.transactiontype <> 'PreOrder' 
        AND (rti.createdtime >= dateadd(hour,-8,'2025-01-01') and rti.createdtime < dateadd(hour,-8,'2025-07-01')) 
        AND rti.business = 'signaturebeefnoodles'
    
    GROUP BY rti.storename, "month", rti."parentproduct_title", rti."product_category", rti."skunumber"--, rti.employeeid, rti.employeename,
    --ORDER BY "variation_name" ASC
    ) t

ORDER BY t."month" ASC, 3 ASC