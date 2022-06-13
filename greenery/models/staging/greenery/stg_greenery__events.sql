{{
    config(
        materialized = 'view'
        
    )
}}

select event_id as event_guid
       ,session_id as session_guid
       ,created_at as created_at_utc
       ,product_id as product_guid
       ,event_type
       ,page_url
       

  from {{(source('src_greenery','events'))}}

