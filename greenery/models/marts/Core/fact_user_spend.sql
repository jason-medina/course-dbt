{{
  config(
    materialized = "table"
  )
}}

with stg_orders as (
    select * from {{ ref('stg_orders') }}
)

select user_id,
min(created_at) AS first_order_at,
max(created_at) AS last_order_at,
count(0) AS order_count,
sum(order_cost) AS total_spend,
sum(order_cost) :: float / count(0) :: float AS avg_order_spend 
sum(case when promo_id is not null then order_cost else 0 end) promo_spend
from dbt_jason_m.stg_orders
group by user_id