-- I need a comprehensive monthly sales roll-up for Malaysia for January 2025. The report must provide a complete breakdown of GMV and transaction counts for every single sales channel, from in-store POS to all our third-party marketplace integrations like GrabFood and Shopify.


SELECT 
    b.name as "bo account name",
    b.subscriptionstatus,
    b.planid,
    case
        when b.businesstype in ('Bar','Cafe','Food Truck','Restaurant','Restuarant','cafe','restaurant','Cafe') then 'FnB'
        when b.businesstype in ('Retail','Retail Store','retail','E-Commerce','eCommerce','ecommerce') then 'Retail'
        when b.businesstype in ('Salon/Spa','Service','service') then 'Service' 
        else 'Other' 
    end as "Industry",
    tr.storeid,
    REGEXP_REPLACE (REGEXP_REPLACE (bs.name, '&#39;', ''''), '%7C;', ' - ') as "storename",
    bs.postalcode,
    bs.city,
    bs.state,
    date_trunc('month',cast(dateadd(hour,8,tr.createdtime) as date)) as "month",
    COUNT(distinct case when (tr.channel is null or tr.channel = 2) then tr._id end) as "offline txn#",
    sum(case when (tr.channel is null or tr.channel = 2) then tr.total end) as "offline gmv",
    --sum(case when (tr.channel is null or tr.channel = 2) then tr.pax end) as "pax",
    --count(distinct case when (tr.channel is null or tr.channel = 2) and tr.pax is null then tr._id end) as "one pax",
    --isnull("pax",0) + isnull("one pax",0) as "total pax#",
    count(distinct case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr._id end) as "qrtxn#",
    sum(case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr.total end) as "qr gmv",
    count(distinct case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr._id end) as "bdtxn#",
    sum(case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr.total end) as "bd gmv",
    count(distinct case when tr.channel = 1 then tr._id end) as "ecomm txn#",
    sum(case when tr.channel = 1 then tr.total end) as "ecomm gmv",
    count(distinct case when tr.channel = 10 then tr._id end) as "fdi grabfood txn#",
    sum(case when tr.channel = 10 then tr.total end) as "fdi grabfood gmv",
    count(distinct case when tr.channel = 11 then tr._id end) as "fdi shopeefood txn#",
    sum(case when tr.channel = 11 then tr.total end) as "fdi shopeefood gmv",
    count(distinct case when tr.channel = 12 then tr._id end) as "fdi foodpanda txn#",
    sum(case when tr.channel = 12 then tr.total end) as "fdi foodpanda gmv",
    count(distinct case when tr.channel = 100 then tr._id end) as "mpi lazada txn#",
    sum(case when tr.channel = 100 then tr.total end) as "mpi lazada gmv",
    count(distinct case when tr.channel = 101 then tr._id end) as "mpi shopee txn#",
    sum(case when tr.channel = 101 then tr.total end) as "mpi shopee gmv",
    count(distinct case when tr.channel = 102 then tr._id end) as "mpi zalora txn#",
    sum(case when tr.channel = 102 then tr.total end) as "mpi zalora gmv",
    count(distinct case when tr.channel = 103 then tr._id end) as "mpi woocommerce txn#",
    sum(case when tr.channel = 103 then tr.total end) as "mpi woocommerce gmv",
    count(distinct case when tr.channel = 104 then tr._id end) as "mpi shopify txn#",
    sum(case when tr.channel = 104 then tr.total end) as "mpi shopify gmv",
    count(distinct case when tr.channel = 105 then tr._id end) as "mpi tiktokshop txn#",
    sum(case when tr.channel = 105 then tr.total end) as "mpi tiktokshop gmv"
    --sum(t.total)/30 as "GMV"

from storehub_mongo.businesses b

left join storehub_mongo.transactionrecords tr
    on b.name = tr.business

left join storehub_mongo.businesses__stores bs
    on bs._id = tr.storeid
    
where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and b.country = 'MY'
    --and b.subscriptionstatus = 'Active'
    --and (tr.channel = 3 or tr.channel is null or tr.channel = 2)
    and tr.transactiontype = 'Sale'
    and tr.iscancelled is not true
    and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and tr.total<10000000
    and (tr.createdtime >= dateadd(hour,-8,'2025-01-01') and tr.createdtime < dateadd(hour,-8,'2025-02-01'))
    --and b.name = 'thecoffeeacademics'
    --and tr.business = 'ashhryshoshedap'

group by 1,2,3,4,5,6,7,8,9,10
order by "bo account name" ASC, "storename" ASC, "month" ASC

