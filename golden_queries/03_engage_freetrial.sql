-- I need to see an activity funnel for all Malaysian merchants who started an Engage trial this year. For each merchant, show their new customer acquisition momentum in the two weeks leading up to the trial start, and on how many days they sent automated SMS campaigns during the first 30 days of their trial.

select distinct
    b.name,
    b._id,
    b.country,
    b.subscriptionstatus,
    dateadd(hour,8,b.campaigntrialstartdate) as engage_trial_start_date,
    count(distinct case when c.createdtime > dateadd(day,-14,b.campaigntrialstartdate) and c.createdtime <= dateadd(day,-7,b.campaigntrialstartdate) then c."_id" end) as p14d_newcust,
    count(distinct case when c.createdtime > dateadd(day,-7,b.campaigntrialstartdate) and c.createdtime <= b.campaigntrialstartdate then c."_id" end) as p7d_newcust,
    count(distinct case when sms."day" > engage_trial_start_date and sms."day" <= dateadd(day,30,engage_trial_start_date) then sms."day" end) as auto_sms_sent_days_within_trial
    /*case 
        when p14d_newcust >= 10 and p17d_newcust >= 10 then 1
        else 0
    end as product_qualified_lead*/
    
from storehub_mongo.businesses b

left join transformations.mask_customers c
    on b.name = c.business
    
left join (
    select distinct
    cj.business,
    cast(dateadd(hour,8,cj.createdtime) as date) as "day"
    --count(distinct case when cj.globalcampaigninformationid <> '64d4d6b30f005152c96d10cb' then cj._id end) as automated_sms_sent
    
    from storehub_mongo.campaignjobs cj
    
    where cj.createdtime >= '2022-09-23'
        and cj.pushstatus = 'SUCCESS'
        
    --group by 1,2
    ) sms
    on sms.business = b.name

where CHARINDEX('internal', b.planid) = 0 
    and CHARINDEX('@storehub.com', b.email) = 0
    and b.campaigntrialstartdate is not null
    and b.country in ('MY')
    and c.createdtime >= '2022-12-14' -- 2 weeks before the earliest recorded Engage trial start date
    and b.campaigntrialstartdate >= '2025-01-01'
    
group by 1,2,3,4,5
order by 5 ASC
