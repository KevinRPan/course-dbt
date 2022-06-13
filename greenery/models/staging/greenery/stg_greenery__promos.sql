
{{
    config(
        materialized = 'view'
        
    )
}}
-- , unique_key = ''
with promos as (
    select * from {{ source('src_greenery', 'promos')}}
)

select status as promo_status
       , promo_id
       , discount as promo_discount
 from promos
