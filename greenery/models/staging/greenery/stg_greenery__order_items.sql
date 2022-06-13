
{{
    config(
        materialized = 'view'
        
    )
}}
-- , unique_key = ''
with order_items as (
    select * from {{ source('src_greenery', 'order_items')}}
)

select product_id
       ,order_id
       ,quantity
 from order_items
