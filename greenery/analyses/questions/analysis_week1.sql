select count(*) as all_cnt, 
       count(distinct user_guid) as distinct_cnt
  from dbt_kevin_p.stg_greenery__users; 


with hourly_orders as (
select date_trunc('hour', created_at_utc) as hr, 
       count(order_guid) as orders
  from dbt_kevin_p.stg_greenery__orders
  group by 1 
)
select avg(orders) from hourly_orders 


select 
  avg(delivered_at_utc - created_at_utc) as avg_time_to_deliver
  from dbt_kevin_p.stg_greenery__orders



with orders_per_user as (
select user_guid, 
       count(distinct order_guid) as orders 
  from dbt_kevin_p.stg_greenery__orders 
 group by 1
)
select orders, 
       count(user_guid)
 from orders_per_user 
 group by 1 
 order by 1 


with session as (
select session_guid,
       date_trunc('hour', min(created_at_utc)) as hour_started
  from dbt_kevin_p.stg_greenery__events
 group by 1
)
, hour_sessions as 
(
select hour_started,
       count(distinct session_guid) as sessions
  from session 
  group by 1 
)

select avg(sessions) from hour_sessions