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

>NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
Consider the distance between days.  For example, if 80% of first time buyers buy again with N days (e.g. 14 days) then any first time buyer without a second purchase in N days is lapsed or at risk for not making another purchase.

## More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:

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

![image](https://user-images.githubusercontent.com/20348624/159183904-0544dda0-d708-48f0-be45-5d837d276bae.png)


# (Part 2) Tests 

We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

What assumptions are you making about each model? (i.e. why are you adding each test?)

>Tests to check for data freshness, nullability and uniqueness. Can events be tested to signal traffic drops, likewise monitor orders for delivery disruptions or backlog growth.  

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?  

>Yes relationship error between orders, promos and products needs fixing to determine if bad data (most likely bad code).
`Failure in test relationships_fact_orders_products_promo_id__promo_id__ref_stg_promos_ (models/marts/Core/schema.yml)`

Apply these changes to your github repo

# Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

Submission Instructions


1. Post the link to your github repo in the channel #projects-march2022 channel. Add a readme file in your repo for short-answer questions 
2. Attach an image of your DAG using dbt docs in a thread to your slack post
3. Tag both of your code review partners (we will reveal pairings in slack)
4. Answer the following self assessment questions

Self review questions due EOD Sunday: 

>Part 1: Were you able to answer the data question asked i.e. What is our user repeat rate? Yes, finding time between purchases and event dates for frequncy modeling might be useful.   

>Part 1: Were you able to create a marts folder for the three business lines? Yes mart folders created with models.

>Part 1: Were you able to create at least 1 intermediate model and 1 dimension/fact model within each marts model? Yes, both base and intermediate.

>Part 2: Were you able to apply dbt tests to your week 1 or week 2 models? Yes tests applied and failed!

>Reflection: What was most challenging/surprising in completing this week’s project? Contextualize data for business requirements to answer retention, frequency and monetization.  How to model events data for customer engagement.  Building repeatable models to eliminate ad hoc sql execution.  

>Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?

>Reflection: What are you most proud of about your project? The ERD lineage chart gave me smile! Researched slack channel for help with intermediate model and tests. Used reacji to spotlight dbt utils package.yml

 --
When your partners post their projects, please peer review it by answering the following questions via a threaded reply on their Slack post (due EOD Monday)

What are 1 or 2 things they did well in the project? I.e. names and descriptions were clear, addressed misspelled column in staging

What are 1 or 2 concrete ways they could improve their work?

If they indicated that they were stuck and/or want focused feedback please provide responses if you can...

Any additional thoughts? Feel free to add words of encouragement as well!
