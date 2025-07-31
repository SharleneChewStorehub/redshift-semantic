-- I need to track the monthly performance of our Beep QR feature in Malaysia. Can you generate a report showing the total QR sales volume and transaction count for each of our QR-adopting stores for the last complete month?

with s as (
select
    b.country,
    b.subscriptionid,
    tr.business,
    tr.storeid,
    min(dateadd(hour,8,tr.createdtime)) as first_QRtxn

from storehub_mongo.transactionrecords tr

left join storehub_mongo.businesses b
    on b.name = tr.business

where tr.channel = 3
    and tr.shippingtype in ('dineIn','takeaway')
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and tr.createdtime >= dateadd(hour,-8,'2019-07-01') 
    and CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and b.country = 'MY'

group by 1,2,3,4
order by 5 DESC
)

select
    date_trunc('month', cast(dateadd(hour,8,tr.createdtime)as date)) as "month",
    s.country,
    tr.business,
    tr.storeid,
    cast(s.first_QRtxn as date) as firstqr,
    date_trunc('month', firstqr) as firstqr_month,
    count(distinct tr.receiptnumber) as qrtxn,
    sum(tr.total) as qrgmv

from storehub_mongo.transactionrecords tr

inner join s 
    on s.storeid = tr.storeid

where tr.channel = 3
    and tr.shippingtype in ('dineIn','takeaway')
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    --and tr.createdtime >= dateadd(hour,-8,date_trunc('month', cast(getdate() as date)))
    and tr.createdtime >= 
        CASE 
            WHEN date_trunc('month',dateadd(hour,-8,cast(getdate() as date))) = date_trunc('month',dateadd(hour,-8,cast(getdate()-7 as date))) THEN dateadd(hour,-8,date_trunc('month',cast(getdate() as date)))
            ELSE dateadd(hour,-8,date_trunc('month',cast(getdate() + INTERVAL '-1 month' as date)))
        END
    --and s.first_QRtxn >= date_trunc('month',CAST((getdate() + INTERVAL '-3 month') AS date))

group by 1,2,3,4,5,6
order by 1 ASC, 2 ASC