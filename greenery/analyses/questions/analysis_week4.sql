
with funnel as (
select product_session_id,
       user_id, 
       product_name, 
       case when checkout_at is not null then 'c. checked_out'
            when add_to_cart_at is not null then 'b. added_to_cart'
            when view_at is not null then 'a. viewed'
       end as funnel_state
  from dbt_kevin_p.product__fact_page_views
 ) 
 
 select funnel_state,
        count(distinct user_id)
  from funnel 
  group by 1 
  order by 2 desc 


-- c. checked_out
-- 124
-- a. viewed
-- 118
-- b. added_to_cart
-- 1


with txns as (
select product_name
       ,count(distinct case when checkout_at is not null then user_id end) as checked_out
       ,count(distinct case when add_to_cart_at is not null then user_id end) as added_to_cart
       ,count(distinct case when view_at is not null then user_id end) as viewed
  from dbt_kevin_p.product__fact_page_views
group by 1
)
select *
      , checked_out *1.0 / viewed as checkout_per_view
      , added_to_cart *1.0 / viewed as carts_per_view
      , checked_out *1.0 / added_to_cart as checkouts_per_cart 
from txns 
order by 4 desc 