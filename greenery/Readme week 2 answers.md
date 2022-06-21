
# Part 1 

## What is our user repeat rate?

79.8%

```
with user_orders as (
select user_guid
       , count(order_guid) as orders
  from dbt_kevin_p.stg_greenery__orders
 group by 1 
)
select count(case when orders > 1 then user_guid end) as repeat_order_users
       , count(user_guid) as users
       , count(case when orders > 1 then user_guid end) *1.0/count(user_guid) as repeat_order_rate
  from user_orders
```

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

A user who has already purchased before, or has purchased recently, or has purchased a large amount (Recency, frequency, monetary amount) would indicate likelihood of purchasing again. 
The opposite for likely not to purchase again - i.e., long time since order, only one purchase, low amount. 

With more data, we might look at customer ratings, reviews, touchpoints, responsiveness, social media interactions. 

# Part 2

## What assumptions are you making about each model? (i.e. why are you adding each test?)



## Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?



## Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

We would set tests on columns to receive alerts if something broke. 
