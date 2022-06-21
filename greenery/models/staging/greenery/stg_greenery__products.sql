
{{
    config(
        materialized = 'view'
        
    )
}}
-- , unique_key = ''
with products as (
    select * from {{ source('src_greenery', 'products')}}
)

select price as product_price
       ,product_id
       ,inventory as product_inventory
       ,name as product_name
 from products
