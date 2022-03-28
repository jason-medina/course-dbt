# Week 3 Jinja, macros, packages, hooks and operations

## What is our overall conversion rate? 62.45%

**62.45%** Overall conversion rate = Checkout event types / unique sessions
~~~sql
select sum(case when event_type='checkout' then 1 else 0 end)/count(distinct session_id)::float 
from dbt_jason_m.fact_events
~~~

## What is our conversion rate by product?
~~~sql
with product_purchases as (
select product_id, count(distinct order_id) AS product_orders 
from dbt_jason_m.fact_orders_products 
group by 1
),
product_sessions as (
select product_id,count(distinct fe.session_id) unique_product_sessions
from dbt_jason_m.fact_events fe
left join (select session_id from dbt_jason_m.int_event_type_lta where checkout = 1) checkout_event
on fe.session_id = checkout_event.session_id
group by product_id
)

select product_name, product_orders, unique_product_sessions,
product_orders/unique_product_sessions::float AS product_conversion_rate
from product_purchases pp
join product_sessions ps on pp.product_id=ps.product_id
join dbt_jason_m.dim_products dp on pp.product_id=dp.product_id
order by 4 desc
~~~

![Screenshot 2022-03-27 161132](https://user-images.githubusercontent.com/20348624/160305299-58ec4611-1ea5-4c56-8d08-87a7683c9761.png)


A question to think about: Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 

PART 2: We’re getting really excited about dbt macros after learning more about them and want to apply them to improve our dbt project. 

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

Note: One potential macro in our data set is aggregating event types per session. Start here as your first macro and add other macros if you want to go further.

PART 3: We’re starting to think about granting permissions to our dbt models in our postgres database so that other roles can have access to them.

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

NOTE: After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using on-run-end

HINT: you can use the grant macro example from this week and make any necessary changes for postgres syntax

PART 4:  After learning about dbt packages, we want to try one out and apply some macros or tests.

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.






Paste in an image of your DAG from the docs. These commands will help you see the full DAG
$ dbt docs generate 
$ dbt docs serve --no-browser

![image](https://user-images.githubusercontent.com/20348624/159183904-0544dda0-d708-48f0-be45-5d837d276bae.png)

Submission Instructions

1. Post the link to your github repo in the projects channel. Add a readme file in your repo for short-answer questions
2. Tag your code review partners (we will reveal pairings in slack)
3. Attach an image of your DAG using dbt docs in a thread to your slack post to show how you simplified or improved a DAG using macros and/or dbt packages.
4. Answer the following self review questions

Self review questions due EOD Sunday: 

Part 1: Were you able to create new models to answer the data questions on conversion rate? Y

Part 2: Were you able to add a new macro to your dbt project? Y

Part 3: Were you able to add a post hook to your project to apply grants to the role “reporting”? N

Part 4: Were you able to install a package? Y/N (indicate what package you used) Y, dbt utils, dbt codegen

What was most challenging/surprising in completing this week’s project? Attempted to create macro similar to get column values

Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers? Readability and chances for new macro.  I did not create any product conversion models, but did attempt to create a macro to replace product sessions and product purchases with a select coulmn_name, count(distinct value) which felt similar to a get column values.  Should I be using dbt utils or another similar package? Or create new model?  Appreciate feedback as always. 

What are you most proud of about your project?  I am proud to be outside my comfortzone and testing myself.  Learning the language of DBT and thinking of real world macro use cases (such as converting SQL dialect) help rethink current work projects. 

--
When your partners post their projects, please peer review it by answering the following questions via a threaded reply on their Slack post (due EOD Monday)

What are 1 or 2 things they did well in the project? I.e. names and descriptions were clear, addressed misspelled column in staging

What are 1 or 2 concrete ways they could improve their work?

If they indicated that they were stuck and/or want focused feedback please provide responses if you can...

Any additional thoughts? Feel free to add words of encouragement as well!
