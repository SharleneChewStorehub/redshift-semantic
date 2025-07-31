-- What was our total revenue from payment gateway fees for all online transactions in Malaysia for June 2025?

with txn as (
select distinct 
    tr.receiptnumber,
    tr.createdtime,
    tr.business,
    b.country,
    tr._id,
    tr.status,
    tr.channel,
    tr.shippingtype,
    tr.isdisbursed,
    tr.total
    
from storehub_mongo.transactionrecords tr

left join storehub_mongo.businesses b
    on b.name = tr.business
    
where (tr.channel = 1 or tr.channel = 3)
    and tr.business != 'merchandise'
    and tr.paymentmethod = 'Online'
    and CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and b.country = 'MY'
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and tr.total < 10000000
    and tr.createdtime >= dateadd(hour,-8,'2025-06-01') and tr.createdtime < dateadd(hour,-8,'2025-07-01')
),

po as (
select 
    pi.*,
    bp.createdtime as bptime

from storehub_mongo.payoutitems pi

left join storehub_mongo.batchpayouts bp
    on bp._id = pi.batchpayoutid
)


select 
    t.country,
    date_trunc('month', t."Transaction time") as "Month",
    count(distinct t."transaction id") as total_txn,
    sum(t."Transaction Amount") as total_txn_amt,
    sum(t."Payment Gateway Profit") as total_pg_revenue
from (
select distinct 
    dateadd(hour,8,txn.createdtime) as "Transaction time",
    dateadd(hour,8,po.bptime) as "Payout time",
    txn.country,
    txn.business, 
    txn.receiptnumber as "receipt number",
    txn._id as "transaction id",
    txn.status,
    case 
        when txn.channel = 1 then 'Ecomm'
        when txn.channel = 3 then 'Beep'
    end as "channel",
    txn.shippingtype,
    txn.isdisbursed,
    txn.total as "Transaction Amount",
    --trpm.paymentprovider,
    --trpm.paymentgateway,
    --gr.paymentgateway,
    po.paymentgateway as "payment gateway",
    po.cause as "Payout reason",
    po.amount as "Payout amount",
    --"Payout amount - Sell" + "Payout amount - Adjustment" as "Total Payout amount",
    (case when po.cause = 'sell' then isnull(gr.fee,0) - isnull(pso.paymentgatewaycost,0) else 0 end) as "Payment Gateway Cost",
    isnull(po.paymentgatewayfee,0) as "Payment Gateway Fee",
    -("Payment Gateway Fee" - "Payment Gateway Cost") as "Payment Gateway Profit",
    -(po.transactionfee) as "Storehub Fee (Transaction Fee)"
    --count(distinct pi.receiptnumber) as "# of txn",
    --sum(case when pi.cause = 'adjustment' then pi.amount else 0 end) as "Adjustment Amount",
    --(case when po.cause = 'sell' then isnull(po.refundedamount,0) else 0 end) as "Refunded Amount"

from txn
    
left join po 
    on po.receiptnumber = txn.receiptnumber

left join (
    select * 
    from storehub_mongo.gatewayrecords gr
    where gr.transactiontype = 'payment' 
        and gr.reconstatus = 'passed'
    ) gr 
    on gr.receiptnumber = po.receiptnumber

left join storehub_mongo.paymentsettlements__orders pso 
    on pso.receiptnumber = txn.receiptnumber
    --and (pi.cause = 'sell' or pi.cause = 'cancel')

--group by 1,2,3,4,5,6,7,8,9,10,11,12,13
order by "Transaction time" desc,  "receipt number" ASC, "Payout reason" DESC
) t

group by 1,2
order by 1 ASC, 2 ASC