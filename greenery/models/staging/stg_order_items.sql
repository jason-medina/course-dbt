{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,
    product_id,
    quantity
FROM {{source('greenery','order_items')}}


/*CREATE TABLE order_items (
  -- OrderId of this order
  order_id VARCHAR(256) REFERENCES orders(order_id),
  -- ProductId of a single item in this order
  product_id VARCHAR(256) REFERENCES products(product_id),
  -- Number of units of the product in this order
  quantity INTEGER,
  PRIMARY KEY(order_id, product_id)
);*/