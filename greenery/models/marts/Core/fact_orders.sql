{{
  config(
    materialized = "table"
  )
}}

with stg_orders as (
    select * from {{ ref('stg_orders') }}
)

select
    order_id,
    user_id,
    promo_id,
    address_id,
    created_at_utc,
    tracking_id,
    order_cost,
    shipping_cost AS shipping_cost_usd,
    order_total AS total_order_cost_usd,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc
    status
from stg_orders