-- I need a detailed, item-level sales breakdown for the merchant 'balqis' for last month. The report must show the total sales, discounts, and taxes for every product and custom item sold.

with products as (
    select distinct original_id as productid, title as item, category as product_category
    from storehub_mongo.products
    where business = 'balqis'
)
SELECT 
    date_trunc('month',DATEADD(hour, 8, tr.createdtime)) as "Month",
    -- tr.receiptnumber as "Receipt Number",
    -- tr.originalreceiptnumber as "Original Sale Receipt Number",
    -- bs._id,
    tr.business as "BO account name",
    bs.name as "Store",
    -- tr.registerid as "Register Id",
    -- CAST(e.firstname AS VARCHAR)+' '+CAST(e.lastname AS VARCHAR) as "Employee",
    tr.transactiontype as "Transaction Type",
    case 
        when tr.channel is null or tr.channel = 2 then 'Instore POS' 
        when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then 'Beep Delivery'
        when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then 'Beep QR'
        when tr.channel = 1 then 'Ecommerce'
        when tr.channel = 10 then 'GrabFood'
        when tr.channel = 11 then 'ShopeeFood'
        when tr.channel = 12 then 'FoodPanda'
    end as transaction_channel,
    -- null as "Customer",
    sum(i.subtotal) as "item subtotal",
    sum(i.discount) as "item discount",
    sum(i.total) as "item total",
    -- p.amount,
    sum(i.tax) as "item tax",
    -- i.total + i.tax amount_with_tax,
    -- p.paymentmethod,
    -- po.name paymentmethod,
    case when i.itemtype = '' then prod.item else i.itemtype end item,
    prod.product_category,
    sum(tr.servicecharge) receipt_servicecharge,
    sum(tr.roundedamount) receipt_roundedamount,
    sum(tr.total) receipt_total
    -- tr.comment
FROM storehub_mongo.transactionrecords tr 
left join storehub_mongo.businesses__stores bs on bs._id = tr.storeid
left join storehub_mongo.businesses__cashregisters bc on bc._id = tr.registerid
left join storehub_mongo.employees e on e._id = tr.employeenumber
left join storehub_mongo.transactionrecords__items i on i.transactionrecords_foreignkey = tr._id
left join products prod on prod.productid = i.productid
WHERE (tr."business" = 'balqis')
    --and (tr.createdtime >= dateadd(hour,-8,'2025-01-01') and tr.createdtime < dateadd(hour,-8,'2025-02-01'))
    and tr.iscancelled is not true
    and tr.transactiontype = 'Sale'
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification') 
    and tr.createdtime >= dateadd(hour,-8,'2022-01-01') 
    and tr.createdtime >= dateadd(hour,-8,dateadd('month',-1,date_trunc('month',current_date))) and tr.createdtime < dateadd(hour,-8,date_trunc('month',current_date))
group by 1,2,3,4,5,10,11
order by 5,3 desc