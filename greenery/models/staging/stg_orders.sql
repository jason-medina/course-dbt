{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,
    promo_id,
    user_id,
    address_id,
    created_at,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    delivered_at,
    status
FROM {{source('greenery','orders')}}

/*CREATE TABLE orders (
  -- UUID for each unique order on platform
  order_id VARCHAR(256) PRIMARY KEY,
  -- UserId of the user that placed this order
  user_id VARCHAR(256) REFERENCES users(user_id),
  -- PromoId if any was used in the order
  promo_id VARCHAR(256) REFERENCES promos(promo_id),
  -- Delivery address for this order
  address_id VARCHAR(256) REFERENCES addresses(address_id),
  -- Timestamp when the order was created
  created_at TIMESTAMP,
  -- Dollar about of the items in the order
  order_cost REAL,
  -- Cost of shipping for the order
  shipping_cost REAL,
  -- Total cost of the order including shipping
  order_total REAL,
  -- Tracking number for the order/package
  tracking_id VARCHAR(256),
  -- Company that was used for shipping
  shipping_service VARCHAR(128),
  -- Estimated date of delivery
  estimated_delivery_at TIMESTAMP,
  -- Actual timestamp of delivery
  delivered_at TIMESTAMP,
  -- Status of the order
  status VARCHAR(128)
);*/