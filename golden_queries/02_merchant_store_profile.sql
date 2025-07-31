-- I need a comprehensive performance profile for all active stores in Malaysia for June 2025. Each profile should break down GMV and AOV by sales channel (offline, QR, delivery) and summarize key loyalty activity, including their active Engage campaigns and number of cashback transactions.

with
s as (
    SELECT 
        b.name bo_name,
        -- b.subscriptionstatus,
        b.planid,
        case
            when b.businesstype in ('Bar','Cafe','Food Truck','Restaurant','Restuarant','cafe','restaurant','Cafe') then 'FnB'
            when b.businesstype in ('Retail','Retail Store','retail','E-Commerce','eCommerce','ecommerce') then 'Retail'
            when b.businesstype in ('Salon/Spa','Service','service') then 'Service' 
            else 'Other' 
        end as biztype,
        tr.storeid,
        REGEXP_REPLACE (REGEXP_REPLACE (bs.name, '&#39;', ''''), '%7C;', ' - ') as storename,
        bs.postalcode,
        bs.city,
        bs.state,
        b.enablecashback,
        -- date_trunc('month',cast(dateadd(hour,8,tr.createdtime) as date)) as "month",
        COUNT(distinct case when (tr.channel is null or tr.channel = 2) then tr._id end) as "offline txn#",
        sum(case when (tr.channel is null or tr.channel = 2) then tr.total end) as "offline gmv",
        -- sum(case when tr.channel is null then tr.pax end) as "pax",
        -- count(distinct case when tr.channel is null and tr.pax is null then tr._id end) as "one pax",
        --isnull("pax",0) + isnull("one pax",0) as "total pax#",
        count(distinct case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr._id end) as "qr txn#",
        sum(case when tr.channel = 3 and tr.shippingtype in ('dineIn','takeaway') then tr.total end) as "qr gmv",
        count(distinct case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr._id end) as "bd txn#",
        sum(case when tr.channel = 3 and tr.shippingtype in ('delivery','pickup') then tr.total end) as "bd gmv"
        --sum(t.total)/30 as "GMV"
    from transformations.mask_businesses b
    left join storehub_mongo.transactionrecords tr on b.name = tr.business
    left join storehub_mongo.businesses__stores bs on bs._id = tr.storeid
    where CHARINDEX('internal', b.planid) = 0 
        and CHARINDEX('@storehub.com', b.email) = 0
        and b.country = 'MY'
        and b.subscriptionstatus = 'Active'
        and (tr.channel = 3 or tr.channel is null or tr.channel = 2)
        and tr.transactiontype = 'Sale'
        and tr.iscancelled is not true
        and tr.status not in ('cancelled', 'created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
        and tr.total<10000000
        and tr.createdtime >= dateadd(hour,-8,'2025-06-01') and tr.createdtime < dateadd(hour,-8,'2025-07-01')
    group by 1,2,3,4,5,6,7,8,9
)
, campaignjobs as ( --adopted from Year End Wrap - cust_engage - https://metabase.shub.us/question/3056
    select
        cj.business bo_name
        , count(distinct cj.customerid) engage_cust_count
    from storehub_mongo.campaignjobs cj
    -- left join storehub_mongo.businesses b on b.name = cj.business
    where 1=1
        and cj.createdtime >= dateadd(hour,-8,'2022-09-23') --engage inception date
        and lower(cj.pushstatus) in ('success')
        and cj.globalcampaigninformationid in ('630eeb369ce7f44578cf2cab','630eeb369ce7f44578cf2cac','630eeb369ce7f44578cf2cad')  --excluded google review (customer reach)
        and cj.createdtime >= dateadd(hour,-8,'2025-06-01') and cj.createdtime < dateadd(hour,-8,'2025-07-01')
        --'630eeb369ce7f44578cf2cab' 'Cashback reminder', '630eeb369ce7f44578cf2cac' 'Win back lost customers'
        --'630eeb369ce7f44578cf2cad' 'Birthday promotion', '634e466b83568a5b429f03f1' 'Boost Google Review'
    group by 1
)
, cashback as (
    select
        cb.business bo_name
        , txn.storeid
        -- , count(distinct cb.customerid) cb_cust_count
        , count(distinct cb.receiptnumber) cb_txn_count
    from storehub_mongo.loyaltychangelogs cb
    -- join (select * from bo_base where country in ('MY', 'TH', 'PH', 'SG')) b on cb.business = b.bo_name
    left join (
        select receiptnumber,status,storeid
        from storehub_mongo.transactionrecords
        where 1=1
        and createdtime >= dateadd(hour,-8,'2025-06-01') and createdtime < dateadd(hour,-8,'2025-07-01')
    ) txn on cb.receiptnumber = txn.receiptnumber
    where 1=1
        and cb.eventtype = 'earned'
        and cb.rewardtype = 'cashback'
        and txn.status not in ('cancelled','created','failed','paymentCancelled','pendingPayment','pendingVerification')
        and cb.eventtime >= dateadd(hour,-8,'2025-06-01') and cb.eventtime < >= dateadd(hour,-8,'2025-07-01')
    group by 1,2
)
select 
    s.bo_name,
    s.biztype,
    s.planid,
    s.storeid,
    s.storename,
    id.coordinates,
    s.state,
    s.postalcode,
    s.city,

    -- c.name engage_campaign,
    listagg(c.name, '|') as engage_campaign,
    cj.engage_cust_count,
    s.enablecashback,
    cb.cb_txn_count as "cb txn#",

    s."offline txn#",
    s."offline gmv",
    case when s."offline txn#" > 0 then isnull(s."offline gmv",0) / s."offline txn#" else null end as "offline aov", 
    s."qr txn#",
    s."qr gmv",
    case when s."qr txn#" > 0 then isnull(s."qr gmv",0) / s."qr txn#" else null end as "qr aov",
    s."bd txn#",
    s."bd gmv",
    case when s."bd txn#" > 0 then isnull(s."bd gmv",0) / s."bd txn#" else null end as "bd aov",
    isnull(s."offline gmv",0) + isnull(s."qr gmv",0) + isnull(s."bd gmv",0) as "total gmv"
from s
left join storehub_mongo.businesses__stores__location id on id.businesses__stores_foreignkey = s.storeid
left join storehub_mongo.campaigns c on c.business = s.bo_name and c.status = 'ACTIVE'
left join campaignjobs cj on cj.bo_name = s.bo_name
left join cashback cb on cb.bo_name = s.bo_name and cb.storeid = s.storeid
group by 1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22
