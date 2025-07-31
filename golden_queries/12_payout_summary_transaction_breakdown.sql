-- To perform a financial audit for the merchant 'piccolilotti' for January 2025, I need a transaction-level reconciliation report. For each online sale, please break down every financial component: gross transaction amount, all fees, logistic costs vs. profits, and the internal cost attribution for any vouchers used.

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
    --and tr.status not in ('created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and (tr.createdtime >= dateadd(hour,-8,'2025-01-01') and tr.createdtime < dateadd(hour,-8,'2025-02-01'))
    and tr.business = 'piccolilotti'
    and b.country = 'MY'
),

po as (
select 
    pi.*,
    bp.createdtime as bptime

from storehub_mongo.payoutitems pi

left join storehub_mongo.batchpayouts bp
    on bp._id = pi.batchpayoutid
)
/*,

promo as (
select 
    trpromo.transactionrecords_foreignkey,
    sum(trpromo.discount * trpromo.shpercent) as tot_disc
    
from (
    select 
        trp.transactionrecords_foreignkey,
        case 
            when trp.discount is not null and trp.shippingfeediscount is not null then trp.discount + trp.shippingfeediscount
            when trp.discount is not null then trp.discount
            when trp.shippingfeediscount is not null then trp.shippingfeediscount
            else 0 
        end as discount,
        trp.storehubpaidpercentage as shpercent
        --cast(discount as float) * cast(shpercent as float) as tot_discount
    from storehub_mongo.transactionrecords__promotions trp 
        
    union
        
    select
        trip.transactionrecords_foreignkey,
        trip.discount as discount,
        trip.storehubpaidpercentage as shpercent
        --sum(discount * shpercent) as tot_discount
    from storehub_mongo.transactionrecords__items__promotions trip
    
    where trip.promotiontype = 'universal' 
        and trip.storehubpaidpercentage > 0
    ) trpromo

group by 1
)
*/

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
    case
        when txn.channel = 3 and txn.shippingtype in ('delivery','pickup') then 'Beep Delivery'
        when txn.channel = 3 and txn.shippingtype in ('takeaway','dineIn') then 'Beep QR'
        when txn.channel = 1 then 'Ecomm'
    end as "channel2",
    txn.shippingtype,
    trdi.usestorehublogistics,
    trdi.courier,
    txn.isdisbursed,
    txn.total as "Transaction Amount",
    --trpm.paymentprovider,
    --trpm.paymentgateway,
    --gr.paymentgateway,
    po.paymentgateway as "payment gateway",
    po.cause as "Payout reason",
    po.amount as "Payout amount",
    --"Payout amount - Sell" + "Payout amount - Adjustment" as "Total Payout amount",
    -- sum(trav.value) as "Voucher value",
    case 
        when trav._id is not null and trav.purchasechannel = 'cleverTapWebhook' then trav.value
        when trav._id is not null and trav.purchasechannel = 'ist' and lower(trav.remarks) like 'marketing/%' and trav.remarks not like '%VBeepGiftVouchers/%' then trav.value
        else 0
    end as "Voucher payout - MKT",
    case
        when trav._id is not null and trav.purchasechannel = 'ist' and lower(trav.remarks) like 'people/%' then trav.value
        else 0
    end as "Voucher payout - People",
    case
        when trav._id is not null and trav.purchasechannel = 'ist' and lower(trav.remarks) like 'care/%' then trav.value
        when trav._id is not null and trav.purchasechannel = 'ist' and trav.remarks = '' then trav.value
        when trav._id is not null and trav.purchasechannel = 'systemRefund' then trav.value
        else 0
    end as "Voucher payout - Care",
    case
        when trav._id is not null and trav.purchasechannel = 'ist' and lower(trav.remarks) like 'product/%' then trav.value
        else 0
    end as "Voucher payout - Product",
    case
        when trav._id is not null and trav.purchasechannel = 'ist' and trav.remarks like '%VBeepGiftVouchers/%' then trav.value
        else 0
    end as "Voucher payout - Sold",
    case
        when trav._id is not null and trav.purchasechannel = 'ist' and trav.remarks <> '' and (lower(trav.remarks) not like 'product/%' and lower(trav.remarks) not like 'care/%' and lower(trav.remarks) not like 'marketing/%' and lower(trav.remarks) not like 'people/%' and trav.remarks not like '%VBeepGiftVouchers/%') then trav.value 
        when trav._id is not null and trav.purchasechannel = '' then trav.value
        else 0
    end as "Voucher payout - Others",
    case
        when trav._id is not null and trav.purchasechannel = 'beep' then trav.value
        else 0
    end as "Merchant Beep Voucher",
    trav.coveredbysh,
    /*sum(case 
            when trav.purchasechannel = 'beep' then 0
            when trav._id is not null then trav.value
            else 0 end) as "Total voucher payout",*/
    (case when po.cause = 'sell' then isnull(gr.fee,0) - isnull(pso.paymentgatewaycost,0) else 0 end) as "Payment Gateway Cost",
    isnull(po.paymentgatewayfee,0) as "Payment Gateway Fee",
    -("Payment Gateway Fee" - "Payment Gateway Cost") as "Payment Gateway Profit",
    (case when po.cause = 'sell' then trdi.shippingfee else 0 end) as "Customer paid delivery fee",
    -(case when po.cause = 'sell' and trdi.courier != 'onfleet' then trdi.deliveryfee else 0 end) as "Logistic Cost (OnFleet excluded)",
    (case when trdi.courier != 'onfleet' then po.logisticsfee else 0 end) as "Logistic Fee (OnFleet excluded)",
    -("Logistic Fee (OnFleet excluded)" - "Logistic Cost (OnFleet excluded)") as "Logistic Profit (Onfleet excluded)",
    -(po.transactionfee) as "Storehub Fee (Transaction Fee)",
    --count(distinct pi.receiptnumber) as "# of txn",
    (case when trdi.courier = 'onfleet' then po.logisticsfee else 0 end) as "Logistic Fee (OnFleet only)",
    --sum(case when pi.cause = 'adjustment' then pi.amount else 0 end) as "Adjustment Amount",
    --(case when po.cause = 'sell' then isnull(promo.tot_disc,0) else 0 end) as "Storehub Paid Promo Discount",
    (case when po.cause = 'sell' then isnull(po.promotionamount,0) else 0 end) as "Storehub Paid Promo Amount",
    --(case when po.cause = 'sell' then isnull(po.voucheramount,0) else 0 end) as "Storehub Paid Voucher Amount",
    (case when po.cause = 'sell' then isnull(po.refundedamount,0) else 0 end) as "Refunded Amount",
    (case when po.cause = 'sell' then po.pickupsmsfee else 0 end) as "pick up sms fee"

from txn
    
left join po 
    on po.receiptnumber = txn.receiptnumber

--left join promo
--    on promo.transactionrecords_foreignkey = txn._id

left join (
    select 
        ta._id,
        ta.voucherid,
        ta.purchasechannel,
        vc.remarks, 
        ta.value,
        ta.transactionrecords_foreignkey,
        ta.coveredbysh
    from storehub_mongo.transactionrecords__appliedvoucher ta
    left join storehub_mongo.vouchers vc
        on ta.voucherid = vc._id
    ) trav
    on trav.transactionrecords_foreignkey = txn._id

left join storehub_mongo.transactionrecords__deliveryinformation trdi 
    on trdi.transactionrecords_foreignkey = txn._id
    
left join (
    select * 
    from storehub_mongo.gatewayrecords gr
    where gr.transactiontype = 'payment' 
        and gr.reconstatus = 'passed'
    ) gr 
    on gr.receiptnumber = po.receiptnumber

left join storehub_mongo.paymentsettlements__orders pso 
    on pso.receiptnumber = txn.receiptnumber

left join storehub_mongo.transactionrecords__payments trpm 
    on trpm.transactionrecords_foreignkey = txn._id

where txn.status not in ('created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    --and (tr.channel = 1 or tr.channel = 3)
    --and (pi.cause = 'sell' or pi.cause = 'cancel')
    --and tr.business != 'merchandise'
    --and NOT (lower(b."planid") like '%internal%')
    --AND tr."status" <> 'cancelled' AND tr."status" <> 'failed' AND tr."status" <> 'paymentCancelled' AND tr."status" <> 'pendingPayment' AND tr."status" <> 'pendingVerification' AND tr."status" <> 'created'
    --and tr.receiptnumber in ('803984100346862','802709001037705','803678576452200','802351208741894','803917265829970','803614169112991','803539823849427')
    --and txn.receiptnumber in ('807865893205675','807247408750412','807247613545480')

--group by 1,2,3,4,5,6,7,8,9,10,11,12,13
order by "Transaction time" desc,  "receipt number" ASC, "Payout reason" DESC

