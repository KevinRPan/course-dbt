# Readme week 4 

## Part 1. dbt Snapshots
[x] Snapshotted 

## Part 2. Modeling challenge

Let’s say that the Director of Product at greenery comes to us (the head Analytics Engineer) and asks some questions:

How are our users moving through the product funnel?
> Quite quickly, about a minute and 12 seconds to add to cart, and two and a half minutes to checkout after in cart. 

```

with funnel as (
select product_session_id
       ,user_id
       ,product_name
       ,add_to_cart_at - view_at as time_to_cart_from_view
       ,checkout_at - add_to_cart_at as time_to_checkout_from_cart 
  from dbt_kevin_p.product__fact_page_views
 ) 
 select-- product_name
       avg(time_to_cart_from_view) as time_to_cart_from_view
       ,avg(time_to_checkout_from_cart) as time_to_checkout_from_cart
       ,count(*)
  from funnel
  -- group by 1 
```


```
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
```


Which steps in the funnel have largest drop off points?

> It appears most users checkout after adding to cart, which seems good. 

| Product             | checkouts | carts | views | checkout per view | cart per view | checkout per cart |
|---------------------|----|----|----|-------|-------|-------|
| ZZ Plant            | 30 | 31 | 48 | 0.625 | 0.646 | 0.968 |
| String of pearls    | 32 | 33 | 48 | 0.667 | 0.688 | 0.970 |
| Birds Nest Fern     | 28 | 29 | 47 | 0.596 | 0.617 | 0.966 |
| Ponytail Palm       | 28 | 29 | 47 | 0.596 | 0.617 | 0.966 |
| Majesty Palm        | 29 | 30 | 45 | 0.644 | 0.667 | 0.967 |
| Snake Plant         | 25 | 26 | 45 | 0.556 | 0.578 | 0.962 |
| Orchid              | 33 | 34 | 44 | 0.750 | 0.773 | 0.971 |
| Cactus              | 28 | 28 | 43 | 0.651 | 0.651 | 1.000 |
| Bamboo              | 31 | 32 | 43 | 0.721 | 0.744 | 0.969 |
| Fiddle Leaf Fig     | 24 | 25 | 43 | 0.558 | 0.581 | 0.960 |
| Pink Anthurium      | 24 | 25 | 43 | 0.558 | 0.581 | 0.960 |
| Peace Lily          | 24 | 25 | 42 | 0.571 | 0.595 | 0.960 |
| Ficus               | 27 | 28 | 42 | 0.643 | 0.667 | 0.964 |
| Spider Plant        | 25 | 26 | 41 | 0.610 | 0.634 | 0.962 |
| Dragon Tree         | 28 | 29 | 40 | 0.700 | 0.725 | 0.966 |
| Philodendron        | 25 | 26 | 40 | 0.625 | 0.650 | 0.962 |
| Bird of Paradise    | 24 | 25 | 40 | 0.600 | 0.625 | 0.960 |
| Pothos              | 21 | 22 | 39 | 0.538 | 0.564 | 0.955 |
| Pilea Peperomioides | 27 | 28 | 38 | 0.711 | 0.737 | 0.964 |
| Boston Fern         | 25 | 25 | 38 | 0.658 | 0.658 | 1.000 |
| Arrow Head          | 28 | 29 | 38 | 0.737 | 0.763 | 0.966 |
| Monstera            | 22 | 23 | 37 | 0.595 | 0.622 | 0.957 |
| Angel Wings Begonia | 19 | 20 | 37 | 0.514 | 0.541 | 0.950 |
| Aloe Vera           | 26 | 27 | 36 | 0.722 | 0.750 | 0.963 |
| Rubber Plant        | 26 | 27 | 36 | 0.722 | 0.750 | 0.963 |
| Calathea Makoyana   | 22 | 23 | 36 | 0.611 | 0.639 | 0.957 |
| Money Tree          | 22 | 22 | 36 | 0.611 | 0.611 | 1.000 |
| Devil's Ivy         | 22 | 23 | 32 | 0.688 | 0.719 | 0.957 |
| Jade Plant          | 22 | 22 | 30 | 0.733 | 0.733 | 1.000 |
| Alocasia Polly      | 19 | 20 | 29 | 0.655 | 0.690 | 0.950 |

Product funnel is defined with 3 levels for our dataset:

Sessions with any event of type page_view

Sessions with any event of type add_to_cart

Sessions with any event of type checkout

They need to understand how the product funnel is performing to set the roadmap for the next quarter. The Product and Engineering teams are asking what their projects will be, and they want to make data-informed decisions.

Thankfully, we can help using our data, and modeling it with dbt!

In addition to answering these questions right now, we want to be able to answer them at any time. The Product and Engineering teams will want to track how they are improving these metrics on an ongoing basis. As such, we need to think about how we can model the data in a way that allows us to set up reporting for the long-term tracking of our goals.

We’ll also want to make sure that any model feeding into this report is defined in an exposure (which we’ll cover in this week’s materials).

Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.

Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. Please reference the course content if you have questions.


## Part 3: Reflection questions -- please answer 3A or 3B, or both!

3A. dbt next steps for you 
Reflecting on your learning in this class...

if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

> dbt/analytics engineering empowers the end user to define and document their own data flows. It's powerful, flexible and builds off of existing skills for SQL and Python. 

it is _not_ the tool to create raw data (maybe stitch or fivetran for this), but rather to create the tables that analysts would use from this raw data. 

if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

> make sure we snapshot early, create appropriate documentation, and keep our dependencies clean 

if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

> it's very doable and there are many resources available 

3B. Setting up for production / scheduled dbt run of your project And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state? You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

> 


dbt seed # to set up any seeds
dbt snapshot # store any snapshots, daily or hourly depending? 
dbt run # run models
dbt test # test (and send alerts)
dbt docs generate # generate docs
dbt docs serve # show docs 


Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc.