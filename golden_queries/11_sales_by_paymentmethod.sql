-- I need a sales report for 'signaturebeefnoodles' for the first half of 2025, broken down by each payment method. Can you show me the final Net Sales for each payment type, making sure to correctly account for both returns and preorder deposits?

with base as (
SELECT
    dateadd(hour,8,tr.createdtime) as txn_createdtime,
    tr.storeid AS "Store ID",
    bs.name AS "Store Name",
    tr._id,
    tr.transactiontype,
    CASE 
        WHEN bpo.name <> '' THEN bpo.name
        ELSE trp.paymentmethod 
    END AS "Payment Method",
    /*CASE 
        WHEN trp.paymentmethod = '' or trp.paymentmethod is null THEN tr.paymentmethod 
        ELSE trp.paymentmethod 
    END AS "Payments paymentmethod",*/
    CASE 
        WHEN trp.paymentmethod = '' or trp.paymentmethod is null THEN tr.total 
        ELSE trp.amount 
    END AS "Payment Amount"
    
FROM storehub_mongo.transactionrecords tr

left join storehub_mongo.transactionrecords__payments trp 
    on trp.transactionrecords_foreignkey = tr._id

left join storehub_mongo.businesses b 
    on b.name = tr.business
    
left join storehub_mongo.businesses__paymentoptions bpo 
    on (bpo.businesses_foreignkey = b._id and bpo.paymentid = trp.paymentmethod)
    
left join storehub_mongo.businesses__stores bs
    on tr.storeid = bs._id

WHERE tr.business = 'signaturebeefnoodles'
    and (tr.createdtime >= dateadd(hour,-8,'2025-01-01') and tr.createdtime < dateadd(hour,-8,'2025-07-01')) 
    AND tr.status not in ('pendingPayment','failed','created','paymentCancelled')
    AND tr.iscancelled is not true
    --AND tr.transactiontype <> 'PreOrder'  

GROUP BY 1,2,3,4
ORDER BY "Store Name" ASC, txn_createdtime ASC 
-- LIMIT 50
-- OFFSET 0
)


select 
    --tmp."month",
    --tmp."Store Name",
    tmp."Payment Method",
    tmp."Total Sales",
    tmp."Total Transactions",
    tmp."Total Sales Returned",
    tmp."Total Items Returned",
    tmp."PreOrder Deposits",
    tmp."PreOrder Transactions",
    tmp."Total Sales" + tmp."PreOrder Deposits" - tmp."Total Sales Returned" AS "Net Sales" -- paymentNetSales
from (
    select
        --date_trunc('month',cast(base.txn_createdtime as date)) AS "month", -- change this line accordingly to get other time variable, eg. hourly, daily, weekly, etc
        --to_char(cast(base.txn_createdtime as date),'Day') as "day of week", -- use this instead of the date_trunc line to get day of week
        --base."Store Name",
        base."Payment Method",
        SUM(CASE WHEN base.transactiontype = 'Sale' THEN COALESCE(+ base."Payment Amount",0) ELSE COALESCE(0,0) END) AS "Total Sales", -- paymentSales
        SUM(CASE WHEN base.transactiontype = 'Sale' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "Total Transactions", -- salesCount
        SUM(CASE WHEN base.transactiontype = 'Return'THEN COALESCE(+ base."Payment Amount",0) ELSE COALESCE(0,0) END) AS "Total Sales Returned", -- paymentReturns
        SUM(CASE WHEN base.transactiontype = 'Return' THEN COALESCE(1,0) ELSE COALESCE(0, 0) END) AS "Total Items Returned", -- returnsCount
        SUM(CASE WHEN base.transactiontype = 'PreOrder' THEN COALESCE(+ base."Payment Amount",0) ELSE COALESCE(0,0) END) AS "PreOrder Deposits", -- preOrderDeposits
        SUM(CASE WHEN base.transactiontype = 'PreOrder' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "PreOrder Transactions" -- preorderCount

    from base
    
    group by 1--,2,3
    --order by "Store Name" asc, "month" asc
    ) tmp

--order by tmp."Store Name" asc, tmp."month" asc




------------------------------------------------------------------------------------------
-- Other useful sales report logic for ref (just not relevant to payment method report) --
------------------------------------------------------------------------------------------
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(0,0) ELSE COALESCE(+tr.total,0) END) AS "Total Sales", --sales
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.tax,0) ELSE COALESCE(+tr.tax,0) END) AS "Tax", --tax
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.servicecharge,0) ELSE COALESCE(+tr.servicecharge,0) END) AS "Service Charge", --serviceCharge
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.roundedamount,0) ELSE COALESCE(+tr.roundedamount,0) END) AS "Rounding" --rounding
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(+tr.total,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Amount" --returns
--COUNT(*) AS "Total Transactions", --count
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.discount,0) ELSE COALESCE(+tr.discount,0) END) AS "Total Discount", --discount
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(1,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Count", --returnsCount
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(+tr.total,0) ELSE COALESCE(0,0) END) AS "Total Sales Returned Amount", --returns
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.subtotal,0) ELSE COALESCE(+tr.subtotal,0) END) AS "SubTotal", --subtotal
--SUM(CASE WHEN tr.transactiontype = 'Return' THEN COALESCE(-tr.cost,0) ELSE COALESCE(+tr.cost,0) END) AS "Total Cost" --cost
