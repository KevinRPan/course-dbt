select 
       user_guid
       , count(distinct order_guid) as orders
       , sum(product_quantity_ordered) as total_products_ordered
       , sum(product_quantity_ordered * product_price ) as product_total_spend
       , max(created_at_utc) as most_recent_ordered_at_utc
       , min(created_at_utc) as first_ordered_at_utc
       , sum(product_quantity_ordered) *1.0/ count(distinct order_guid) as avg_products_ordered
       , sum(order_cost_usd) * 1.0/ count(distinct order_guid) as avg_order_size
from {{ref('core__fact_order_items')}}
group by 1
