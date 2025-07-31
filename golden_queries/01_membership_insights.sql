-- For the merchant 'starwise', compare the value of loyalty members vs. non-members for June 2025. I need a breakdown of their total sales, transaction counts, Average Order Value (AOV), and Lifetime Value (LTV).

with l as (
  select
    b.name,
    dateadd(hour,8,b."membershipsetting.firstgoliveat") as firstgoliveat
  from storehub_mongo.businesses b
  where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and "membershipsetting.firstgoliveat" is not null
    and b.name = 'starwise'
),

m as (
SELECT distinct
    b.name,
    c.customerid,
    c._id as customer_id,
    c.membershipjointime
from storehub_mongo.businesses b
left join storehub_mongo.customers c  
    on c.business = b.name
where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and c.membershipjointime is not null 
    and b.name = 'starwise'
),

ct as (
select 
    l.name,
    count(distinct m.customerid) as totalMembers,
    --sum(case when m.membershipjointime >= dateadd(hour,-8,cast(getdate()-1 as date)) and m.membershipjointime < dateadd(hour,-8,cast(getdate() as date)) then 1 else 0 end) as newMembersYesterday,
    --sum(case when m.membershipjointime >= dateadd(hour,-8,cast(getdate()-2 as date)) and m.membershipjointime < dateadd(hour,-8,cast(getdate()-1 as date)) then 1 else 0 end) as newMembersPrevDay,
    --sum(case when m.membershipjointime >= dateadd(hour,-8,cast(getdate()-30 as date)) and m.membershipjointime < dateadd(hour,-8,cast(getdate() as date)) then 1 else 0 end) as newMembersLast30Days,
    --sum(case when m.membershipjointime >= dateadd(hour,-8,cast(getdate()-60 as date)) and m.membershipjointime < dateadd(hour,-8,cast(getdate()-31 as date)) then 1 else 0 end) as newMembersPrev30Days
    sum(case when m.membershipjointime >= dateadd(hour,-8,'2025-06-01') and m.membershipjointime < dateadd(hour,-8,'2025-07-01') then 1 else 0 end) as newMembersDefinedPeriod
from l
left join m
    on m.name = l.name
group by 1
),

trx as (
select distinct 
    tr.business,
    b."membershipsetting.firstgoliveat" as firstGoLiveAt,
    tr.customerid,
    m.membershipjointime,
    tr.createdtime,
    tr.channel,
    tr.shippingtype,
    tr.total,
    case when tr.createdtime > b."membershipsetting.firstgoliveat" then 1 else 0 end as businessMemberTxn,
    case when tr.createdtime > m.membershipjointime then 1 else 0 end as customerMemberTxn

from storehub_mongo.transactionrecords tr

--left join storehub_mongo.rewardsettings r
--    on r.merchantname = tr.business

left join storehub_mongo.businesses b
    on b.name = tr.business
    
left join m
    on tr.business = m.name
    and tr.customerid = m.customerid

where (tr.channel is null or tr.channel in (2,3))
    and tr.transactiontype = 'Sale'
    and tr.iscancelled is not TRUE
    and tr.status not in ('cancelled','created', 'failed', 'paymentCancelled', 'pendingPayment', 'pendingVerification')
    and tr.createdtime >= dateadd(hour,-8,cast(getdate()-180 as date))
    and tr.business = 'starwise'
    
order by 3 ASC, 5 ASC 
)
/*,

rr as (
select 
    pc.business,
    sum(case when pc.restclaimcount = 0 then 1 else 0 end) as total_rewards_redeemed
from storehub_mongo.promotioncustomers pc
where pc.rewardsource IN ('welcomeNewMembershipReward', 'pointsReward', 'birthdayReward', 'tierUpgradeReward')
    [[and pc.business = {{bo_account_name}}]]
group by 1
)
*/


select 
    tmp.name as business,
    tmp.totalMembers,
    tmp.activeMembers,
    --tmp.newMembersYesterday,
    --tmp.newMembersPrevDay,
    --tmp.newMembersLast30Days,
    --tmp.newMembersPrev30Days,
    tmp.newMembersDefinedPeriod,
    cast(tmp.memberTransactions as float) / nullif(cast(tmp.totalTransactions as float),0) as percentMemberTransactions,
    tmp.memberTransactions,
    cast(tmp.memberSales as float) / nullif(cast(tmp.totalSales as float),0) as percentMemberSales,
    tmp.memberSales,
    tmp.memberCustomers,
    tmp.membersAverageLifeTimeValue,
    tmp.nonMembersAverageLifeTimeValue,
    tmp.memberAOV,
    tmp.nonMemberAOV,
    tmp.membersAverageTransactions,
    tmp.nonMembersAverageTransactions,
    tmp.totalRewardsRedeemed
from (
    select 
        ct.name,
        ct.totalMembers,
        count(distinct case when trx.createdtime >= dateadd(hour,-8,cast(getdate()-30 as date)) and trx.membershipjointime is not null then trx.customerid end) as activeMembers, 
        --ct.newMembersYesterday,
        --ct.newMembersPrevDay,
        --ct.newMembersLast30Days,
        --ct.newMembersPrev30Days,
        ct.newMembersDefinedPeriod,
        sum(case when trx.customerMemberTxn = 1 then 1 else 0 end) as memberTransactions,
        sum(case when trx.businessMemberTxn = 1 then 1 else 0 end) as totalTransactions,
        sum(case when trx.customerMemberTxn = 1 then trx.total else 0 end) as memberSales,
        sum(case when trx.businessMemberTxn = 1 then trx.total else 0 end) as totalSales,
        count(distinct case when trx.customerMemberTxn = 1 then trx.customerid end) as memberCustomers,
        sum(case when trx.businessMemberTxn = 1 and trx.customerMemberTxn = 0 then 1 else 0 end) as nonMemberTransactions,
        sum(case when trx.businessMemberTxn = 1 and trx.customerMemberTxn = 0 then trx.total else 0 end) as nonMemberSales,
        sum(case when trx.businessMemberTxn = 1 and trx.customerMemberTxn = 0 and trx.customerid = '' then 1 else 0 end) as nonMemberNoCustomerIdTransactions,
        count(distinct case when trx.businessMemberTxn = 1 and trx.customerMemberTxn = 0 and trx.customerid <> '' then trx.customerid end) as nonMemberCustomers,
        cast(memberSales as float) / nullif(cast(memberCustomers as float),0) membersAverageLifeTimeValue,
        cast(nonMemberSales as float) / nullif(cast(nonMemberNoCustomerIdTransactions + nonMemberCustomers as float), 0) as nonMembersAverageLifeTimeValue,
        cast(memberSales as float) / nullif(cast(memberTransactions as float), 0) as memberAOV,
        cast(nonMemberSales as float) / nullif(cast(nonMemberTransactions as float), 0) as nonMemberAOV,
        cast(memberTransactions as float) / nullif(cast(memberCustomers as float), 0) as membersAverageTransactions,
        cast(nonMemberTransactions as float) / nullif(cast(nonMemberNoCustomerIdTransactions + nonMemberCustomers as float), 0) as nonMembersAverageTransactions,
        rr2.totalRewardsRedeemed2 as totalRewardsRedeemed
    
    from ct
        
    left join trx
        on trx.business = ct.name
    
    --left join rr
    --    on rr.business = ct.name
    
    left join (
        select 
            r.business,
            sum(r.totalrewardsredeemed) as totalRewardsRedeemed2
        from "transformations"."report_members_rewards" r
        group by 1
        ) rr2
    on rr2.business = ct.name
    
    group by 1,2,4,rr2.totalRewardsRedeemed2--,5,6
    ) tmp
    