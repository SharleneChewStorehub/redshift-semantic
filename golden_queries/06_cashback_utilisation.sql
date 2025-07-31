-- How effective is the cashback program at driving repeat business from our QR ordering feature in Malaysia? I need to see the cashback utilization rate for Beep orders over the last 12 months, with the total amounts claimed and redeemed standardized in SGD.

select 
    date_trunc('month', cast(dateadd(hour,8,lc.eventtime) as date)) as month,
    --count(distinct lc.receiptnumber) as "claimed cashback #",
    --count(distinct tr.receiptnumber) as bdtxn_count,
    --count(distinct tr.consumerid) as "claimed cashback unique consumer #",
    sum(case
            when lc.eventtype = 'earned' and b.country = 'MY' then lc.amount * 0.31
            when lc.eventtype = 'earned' and b.country = 'PH' then lc.amount * 0.025
            when lc.eventtype = 'earned' and b.country = 'TH' then lc.amount * 0.039
            when lc.eventtype = 'earned' and b.country = 'SG' then lc.amount
        end) as "claimed cashback amount (SGD)",
    -sum(case
            when lc.eventtype = 'expense' and b.country = 'MY' then lc.amount * 0.31
            when lc.eventtype = 'expense' and b.country = 'PH' then lc.amount * 0.025
            when lc.eventtype = 'expense' and b.country = 'TH' then lc.amount * 0.03
            when lc.eventtype = 'expense' and b.country = 'SG' then lc.amount
        end) as "redeemed cashback amount (SGD)",
    "redeemed cashback amount (SGD)" / "claimed cashback amount (SGD)" as "cashback utilisation rate"
    --cast("claimed cashback amount (SGD)" as float) / cast("claimed cashback unique consumer #" as float) as "avg claimed cashback amount per consumer (SGD)"
        
from storehub_mongo.loyaltychangelogs lc

left join transformations.mask_businesses b
    on lc.business = b.name

left join storehub_mongo.transactionrecords tr
    on lc.receiptnumber = tr.receiptnumber
    
where lc.eventtype in ('earned','expense')
    and lc.rewardtype = 'cashback' 
    and lc.source = 'QR_ORDERING'
    and CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and tr.channel = 3 
    and tr.shippingtype in ('delivery', 'pickup', 'dineIn', 'takeaway') 
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and b.country in ('MY')
    and lc.eventtime BETWEEN dateadd(hour,-8,date_trunc('month', cast(getdate() + INTERVAL '-12 month' as date))) and dateadd(hour,16,cast(getdate() as date))


group by 1
order by 1 DESC
