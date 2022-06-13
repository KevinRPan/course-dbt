
{{
    config(
        materialized = 'view'
        
    )
}}
-- , unique_key = ''
with products as (
    select * from {{ source('src_greenery', 'products')}}
)

select price
       ,product_id
       ,inventory
       ,name
 from products
