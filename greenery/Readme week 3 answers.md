## PART 1: Create new models to answer the first two questions (answer questions in README file)

What is our overall conversion rate?

62.5% 

```
SELECT COUNT(distinct CASE WHEN order_id is not null THEN session_guid end) *1.0 / COUNT(distinct session_guid) as conversion_rate
FROM dbt_kevin_p.stg_greenery__events
```

What is our conversion rate by product?


```
select product_name
       ,ROUND(COUNT(distinct CASE WHEN order_id is not null THEN session_guid end) *1.0 / COUNT(distinct session_guid),3) as conversion_rate
  from dbt_kevin_p.product__fact_page_views 
group by 1
```

| Product Name | Conversion Rate |
| ------------------- | ----- |
| Alocasia Polly      | 0.412 |
| Aloe Vera           | 0.492 |
| Angel Wings Begonia | 0.393 |
| Arrow Head          | 0.556 |
| Bamboo              | 0.537 |
| Bird of Paradise    | 0.450 |
| Birds Nest Fern     | 0.423 |
| Boston Fern         | 0.413 |
| Cactus              | 0.545 |
| Calathea Makoyana   | 0.509 |
| Devil's Ivy         | 0.489 |
| Dragon Tree         | 0.468 |
| Ficus               | 0.426 |
| Fiddle Leaf Fig     | 0.500 |
| Jade Plant          | 0.478 |
| Majesty Palm        | 0.493 |
| Money Tree          | 0.464 |
| Monstera            | 0.510 |
| Orchid              | 0.453 |
| Peace Lily          | 0.409 |
| Philodendron        | 0.484 |
| Pilea Peperomioides | 0.475 |
| Pink Anthurium      | 0.419 |
| Ponytail Palm       | 0.400 |
| Pothos              | 0.344 |
| Rubber Plant        | 0.519 |
| Snake Plant         | 0.397 |
| Spider Plant        | 0.475 |
| String of pearls    | 0.609 |
| ZZ Plant            | 0.540 |


### A question to think about: Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 

Some products may have better images, better pricing, promotions, or are more popular on social media or ads or elsewhere. Worth looking into if our highest margin plants are low conversion. 

## PART 2: We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

> Added macro for time of events in sessions. 

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

Note: One potential macro in our data set is aggregating event types per session. Start here as your first macro and add other macros if you want to go further.

## PART 3: We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using an on-run-end hook

You can use the grant macro example from this week and make any necessary changes for postgres syntax

To check if your grants worked as expected, you can query the information schema like this (inputing the table name you want to check): 

SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name='mytable'

## PART 4:  After learning about dbt packages, we want to try one out and apply some macros or tests.

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

packages yml add:
packages:
  - package: dbt-labs/dbt_utils
    version: 0.8.6

then run 
dbt deps 

used surrogate key in product-session table 

## PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!

I am pleased with codegen generating templates for schemas. 

