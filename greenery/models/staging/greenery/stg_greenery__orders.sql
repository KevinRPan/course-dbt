{{
    config(
        materialized = 'view'
        
    )
}}
-- , unique_key = ''
with orders_source as (
    select * from {{ source('src_greenery', 'orders')}}
)

, renamed_recast as (
    select 
        order_id as order_guid
        , user_id as user_guid
        , order_cost as order_cost_usd
        , shipping_cost as shipping_cost_usd
        , order_total as order_total_usd
        , status as order_status
        , promo_id::varchar as promo_desc
        , created_at as created_at_utc
        , estimated_delivery_at as estimated_delivery_at_utc
        , delivered_at as delivered_at_utc
    from orders_source
)

select * from renamed_recast