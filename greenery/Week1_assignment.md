# Week 1 DBT assignment
## Build staging models


1. How many users do we have? **130 distinct user id**

~~~~sql
select count(distinct user_id) 
from dbt_jason_m.stg_users
~~~~

2. On average, how many orders do we receive per hour? **15 orders per hour**

~~~~sql
with average_hourly_order as( 
select extract(hour from created_at), count(0) hourly_order_count 
from dbt_jason_m.stg_orders 
group by extract(hour from created_at)
) 
select avg(hourly_order_count) 
from average_hourly_order`
~~~~

3. On average, how long does an order take from being placed to being delivered? **3.89 days on average to deliver**

~~~~sql
with avg_days_to_deliver as (
select order_id, extract(day from max(delivered_at)-min(created_at)) days_to_deliver 
from dbt_jason_m.stg_orders 
where delivered_at is not null
group by order_id
)
select avg(days_to_deliver) 
from avg_days_to_deliver
~~~~


4. How many users have only made one purchase? Two purchases? Three+ purchases? -- one purchase 25 two purchase 28 more than two purchase 71


~~~~sql
with order_count_by_user as (
select user_id, count(distinct order_id) orders_placed
from dbt_jason_m.stg_orders 
group by user_id
),
order_freq as (
select orders_placed,count(0) pur_freq 
from order_count_by_user
group by orders_placed
)
select 
  sum(case when orders_placed = 1 then pur_freq end) one_pur
, sum(case when orders_placed = 2 then pur_freq end) two_pur
, sum(case when orders_placed > 2 then pur_freq end) mt_two_pur 
from order_freq
~~~~

--Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

5. On average, how many unique sessions do we have per hour? - four sessions per hour

>`with average_session_counts as (
select extract(hour from created_at),session_id, count(0) hourly_session_count 
from dbt_jason_m.stg_events 
group by extract(hour from created_at), session_id)
select avg(hourly_session_count)
from average_session_counts`

-- Self review questions
Part 2: Were you able to create schema.yml files with model names and descriptions? Y/N
    --created for free in week 0 set up

Part 2: Were you able to run your dbt models against the data warehouse? Y/N
    --uncommented model one to enforce no nulls as seen in week 1 video

Part 3: Could you run the queries to answer key questions from the project instructions? Y/N
    --included answers above

Reflection: What was most challenging/surprising in completing this week’s project?
    --knowing what is sufficent for data explorations, definitions and documentation
    --helpful when purchases defined

Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
    --code review helped confirm project and staging tables missing
    --videos very helpful to identify and review when stuck
    --version control and commits, getting 8081 error after stopping work space first time
    --no exertnal blockers
