-- I need to get the current inventory valuation for the merchant 'imikaempiresdnbhd'. Can you give me a report that shows the total monetary value of all stock on hand for each of their stores, based on the latest inventory levels?

with s as (
select distinct
    bs._id,
    REGEXP_REPLACE (REGEXP_REPLACE (bs.name, '&#39;', ''''), '%7C;', ' - ') as storename
from storehub_mongo.businesses b
left join storehub_mongo.businesses__stores bs
    on b._id = bs.businesses_foreignkey
where b.name = 'imikaempiresdnbhd'
    --and bs._id in ('5a7815aecfe019834b13c699','65c4e47bff562e00072771b8','610c9bfd4be17100065080a2')
),

p as (
SELECT distinct
    a.original_id,
    a.cost
        
from storehub_mongo.products a 
    
left join storehub_mongo.businesses b 
    on a.business = b."name" 
        
left join storehub_mongo.businesses__stores c 
    on b."_id" = c.businesses_foreignkey 
    
/*left join storehub_mongo.serialnumbers s
    on s.business = a.business
    and s.productid = a.original_id*/
        
where a.isdeleted is not true 
    and a.trackInventory is true 
    and a.inventorytype <> 'Composite'
    and a.business ='imikaempiresdnbhd'      
    --and c."_id" in ('5a7815aecfe019834b13c699','65c4e47bff562e00072771b8','610c9bfd4be17100065080a2')
    and (a.productType = 'Simple' or a.parentProductId <> '' or a.parentProductId is not null or a.isChild is true)
),

se as (
select 
    s.productid, 
    s.storeid, 
    count(*) as "count"
from storehub_mongo.serialnumbers s
where s.business = 'imikaempiresdnbhd'
group by 1,2
)

select 
    tmp.storename,
    sum(tmp."quantityonhand") as total_items,
    sum(case 
            when tmp."quantityonhand" is not null then cast(tmp."quantityonhand" as float) * cast(tmp.cost as float)
            else 0
        end) as total_value
from (
    select 
        s.storename,
        i.productid,
        case 
            when i.isserialized = true then se."count"
            else i.quantityonhand
        end as "quantityonhand",
        p.cost
        /*case 
            when "quantityonhand" is not null then cast("quantityonhand" as float) * cast(p.cost as float)
            else 0
        end as value*/
        
    from storehub_mongo.inventories i
    
    left join s
        on i.storeid = s._id
    
    left join p
        on i.productid = p.original_id
    
    left join se
        on se.productid = i.productid
        and se.storeid = i.storeid
        
    where i.productid in (select p.original_id from p)
        and i.business = 'imikaempiresdnbhd'
        --and i.storeid in ('5a7815aecfe019834b13c699','65c4e47bff562e00072771b8','610c9bfd4be17100065080a2')
        --and i.productid in ('66ed3011df00fc00071d5acc','67074fef4a53790007f8212e')
    ) tmp

group by 1
order by 2 DESC