# Week 2 models and tests

## What is our user repeat rate? 79.8%

**79.8%** Repeat Rate = Users who purchased 2 or more times / users who purchased
~~~sql
--repeat order rate 
with user_order_counts as ( 
select user_id,count(distinct order_id) order_count
from dbt_jason_m.stg_orders
group by user_id 
--status, shipping_service order by count(distinct order_id) desc
)


select 
sum(case when order_count > 1 then 1 else 0 end) :: float  
/ count(0) :: float repeat_buyer_rate
from user_order_counts
~~~

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:

Core

Marketing

Product

Within each marts folder, create intermediate models and dimension/fact models.

NOTE: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data

For example, some “core” datasets could include fact_orders, dim_products, and dim_users

The marketing mart could contain a model like user_order_facts which contains order information at the user level

The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data

Explain the marts models you added. Why did you organize the models in the way you did?

Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

Paste in an image of your DAG from the docs. These commands will help you see the full DAG
$ dbt docs generate 
$ dbt docs serve --no-browser

