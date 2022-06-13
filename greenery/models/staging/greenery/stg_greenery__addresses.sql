{{
    config(
        materialized = 'view'
    )
}}

with renamed_recast as (
    select 
        address_id
        , address
        , zipcode
        , state
        , country
    from {{(source('src_greenery','addresses'))}}
)

select * from renamed_recast 

-- models:
--     - name: stg_greenery_addresses
