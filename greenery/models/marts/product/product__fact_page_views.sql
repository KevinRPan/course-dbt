{{
    config(
        materialized = 'view'
        , unique_key = 'session_guid'
        
    )
}}

WITH session_purchase as (
SELECT e.session_guid, 
       e.user_id,
       e.order_id,
       {{type_to_time('event_type', 'checkout', 'created_at_utc')}} as checkout_at,
    --    min(case when event_type = 'checkout' then created_at_utc end) as checkout_at,
       min(case when event_type = 'package_shipped' then created_at_utc end) as shipped_at
FROM {{ ref('stg_greenery__events')}} e 
GROUP BY 1,2,3
)

, products_purchased as (
SELECT session_purchase.*,
       oi.product_id,
    --    products.product_name,
       oi.quantity
FROM session_purchase
JOIN {{ ref('stg_greenery__order_items')}} oi 
  ON session_purchase.order_id = oi.order_id
-- JOIN {{ ref('stg_greenery__products')}} as products
--   ON oi.product_id = products.product_id
)

, session_events as (
SELECT session_guid
       , product_guid
       , products.product_name
       , user_id
       , min(case when event_type = 'page_view' then created_at_utc end) as view_at
       , min(case when event_type = 'add_to_cart' then created_at_utc end) as add_to_cart_at
  FROM {{ ref('stg_greenery__events')}} e
JOIN {{ ref('stg_greenery__products')}} as products
  ON e.product_guid = products.product_id
 WHERE product_guid is not null
 GROUP BY 1,2,3,4
)

SELECT  e.session_guid
       , e.user_id
       , e.product_guid
       , product_name
       , quantity
       , view_at
       , add_to_cart_at
       , order_id
       , checkout_at
       , shipped_at
  FROM session_events e
  LEFT JOIN products_purchased 
    ON e.session_guid = products_purchased.session_guid
   AND e.product_guid = products_purchased.product_id
