-- How is the adoption of our Beep QR ordering feature? For each store that has ever used it, show me what percentage of their total in-store sales and transactions came from QR orders last month.

with q as (
select distinct tr.storeid
    
from storehub_mongo.transactionrecords tr

left join storehub_mongo.businesses b
    on tr.business = b.name

where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and tr.channel = 3
    and tr.shippingtype in ('dineIn','takeaway')
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and b.country in ('MY')
    and tr.createdtime >= dateadd(hour,-8,'2019-07-01') -- start of Beep QR transactions

select 
    tr.business,
    tr.storeid,
    date_trunc('month', cast(dateadd(hour,8,tr.createdtime) as date)) as month,
    --count(distinct cast(dateadd(hour,8,tr.createdtime) as date)) as transacting_days,
    count(distinct tr.receiptnumber) as instore_txn,
    sum(tr.total) as instore_gmv,
    count(distinct case when tr.channel = 3 then tr.receiptnumber end) as qrtxn,
    sum(case when tr.channel = 3 then tr.total end) as qrgmv,
    case when (qrgmv is not null and instore_gmv > 0) then qrgmv / instore_gmv else 0 end as qr_usage_gmv,
    case when (qrtxn > 0 and instore_txn > 0) then cast(qrtxn as float) / cast(instore_txn as float) else 0 end as qr_usage_txn
    
from storehub_mongo.transactionrecords tr

where tr.storeid in (select q.storeid from q)
    and ((tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway')) or tr.channel is null or tr.channel = 2)
    and tr.transactiontype = 'Sale'
    and tr.iscancelled is not TRUE
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    --and tr.createdtime >= dateadd(hour,-8,date_trunc('month', cast(getdate() as date)))
    and tr.createdtime >= 
        CASE 
            WHEN date_trunc('month',dateadd(hour,-8,cast(getdate() as date))) = date_trunc('month',dateadd(hour,-8,cast(getdate()-7 as date))) THEN dateadd(hour,-8,date_trunc('month',cast(getdate() as date)))
            ELSE dateadd(hour,-8,date_trunc('month',cast(getdate() + INTERVAL '-1 month' as date)))
        END
    

group by 1,2,3
order by 3 ASC, 1 ASC
