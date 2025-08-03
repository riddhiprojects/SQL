
with oc as (
select count(order_id) as total_orders
from orders )

select
case 
when order_id%2!=0 and order_id!=total_orders then order_id+1
when order_id%2!=0 and order_id=total_orders then order_id
else order_id-1
end as corr_order,
item 
from orders 
cross join oc
order by corr_order
