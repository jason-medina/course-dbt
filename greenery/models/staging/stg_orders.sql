{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,                   -- UUID for each unique order on platform
    promo_id,                   -- PromoId if any was used in the order
    user_id,                    -- UserId of the user that placed this order
    address_id,                 -- Delivery address for this order             
    created_at,                 -- Timestamp when the order was created
    order_cost,                 -- Dollar about of the items in the order
    shipping_cost,              -- Cost of shipping for the order
    order_total,                -- Total cost of the order including shipping
    tracking_id,                -- Tracking number for the order/package
    shipping_service,           -- Company that was used for shipping
    estimated_delivery_at,      -- Estimated date of delivery
    delivered_at,               -- Actual timestamp of delivery
    status                      -- Status of the order
FROM {{source('greenery','orders')}}