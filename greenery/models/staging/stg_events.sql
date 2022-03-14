{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    event_id,     -- UUID of each unique event on the platform
    session_id,   -- UUID of each browsing session on the platform which can contain many events
    user_id,      -- UUID of the user that this event is associated with, REFERENCES users(user_id)      
    page_url,     -- URL that the event happened on
    created_at,   -- Timestamp of the event
    event_type,   -- Type of event
    order_id,     -- If the event is specific to an order (mostly used for checkout), REFERENCES orders(order_id)
    product_id    -- If the event is specific to a product, REFERENCES products(product_id)

FROM {{ source('greenery', 'events') }}