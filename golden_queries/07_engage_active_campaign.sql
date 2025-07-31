-- I need an operational dashboard to monitor all currently active Engage campaigns in Malaysia. For each campaign, I need to see its performance metrics like total SMS sent, the merchant's current SMS credit balance, and what percentage of the eligible customer base has been targeted.

select 
    c.business,
    b.businesstype,
    c.name as "campaign",
    count(distinct case when cj.pushstatus = 'SUCCESS' and cj.createdtime >= '2022-09-23' then cj._id end) as total_sms_sent,
    min(case when cj.createdtime >= '2022-09-23' then dateadd(hour,8,cj.createdtime) end) as first_sms_sent_time, -- start of Engage
    cust."phone" as customers_with_phones,
    cust."cb count" as customers_with_cashback,
    cust."bday count" as customers_with_birthday,
    b.smscredits as sms_credit_balance,
    case 
	    when total_sms_sent > 0 and customers_with_cashback > 0 and c.name in ('Cashback Reminder','Expiring Cashback Alert') then cast(total_sms_sent as float) / cast(customers_with_cashback as float) 
	    when total_sms_sent > 0 and c.name in ('Win Back Lost Customers','Boost Google Reviews','Welcome New Customers') then cast(total_sms_sent as float) / cast(customers_with_phones as float)
	    when total_sms_sent > 0 and customers_with_birthday > 0 and c.name = 'Birthday Promotion' then cast(total_sms_sent as float) / cast(customers_with_birthday as float) 
	    else 0
	end as "% customer targeted",
    --cast(total_sms_sent as float) / cast(customers_with_phones as float) as "% customer targeted",
    REGEXP_REPLACE (c.template, '&#39;', '''') as template,
    dateadd(hour,8,c.starttime) as campaign_start_time

from storehub_mongo.campaigns c

left join storehub_mongo.campaignjobs cj
    on c.business = cj.business
    and c.globalcampaigninformationid = cj.globalcampaigninformationid

left join storehub_mongo.businesses b
    on c.business = b.name
    
left join (
    SELECT 
        cu.business AS "business", 
        count(distinct cu.customerid) AS "count",
        count(distinct cu.phone) as "phone",
        count(distinct case when cu.storecreditsbalance > 0 then cu.customerid end) as "cb count",
        count(distinct case when (cu.birthday is not null or co.birthday is not null) then cu.customerid end) as "bday count"
    
    FROM transformations.mask_customers cu
    
    left join transformations.mask_consumers co
        on cu.consumerid = co._id
            
    where cu.isdeleted is NOT TRUE
    
    group by 1
    ) cust
    on cust."business" = b.name
    
where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and b.subscriptionstatus = 'Active'
    and c.status = 'ACTIVE'
    --and cj.pushstatus = 'SUCCESS'
    and b.country 'MY'

group by 1,2,3,6,7,8,9,11,12
order by 4 DESC