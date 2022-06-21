{{
    config(
        materialized = 'view'
        , unique_key = 'order_guid'
        
    )
}}

select order_guid
       , user_guid
       , order_cost_usd
       , shipping_cost_usd
       , order_total_usd
       , order_status
       , orders.promo_id
       , created_at_utc
       ,estimated_delivery_at_utc
       ,delivered_at_utc
       ,address_id
       ,tracking_id
       ,shipping_service
       
       , count(order_items.product_id) as products_ordered
       , sum(quantity) as product_quantity_ordered_total

       , promo_status
       , promo_discount
 from {{ ref('stg_greenery__orders')}} as orders 
 join {{ ref('stg_greenery__order_items')}} as order_items
   on orders.order_guid = order_items.order_id
 join {{ ref('stg_greenery__promos')}} as promos
   on orders.promo_id = promos.promo_id 
 join {{ ref('stg_greenery__products')}} as products
   on order_items.product_id = products.product_id