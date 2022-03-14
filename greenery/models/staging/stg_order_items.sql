{{
    config(
        materialized = 'table'
    )
}}

SELECT
    order_id,       -- OrderId of this order, REFERENCES orders(order_id)
    product_id,     -- ProductId of a single item in this order, REFERENCES products(product_id)
    quantity        -- Number of units of the product in this order
FROM {{source('greenery','order_items')}}


/*CREATE TABLE order_items (
  
  order_id VARCHAR(256) 
  
  product_id VARCHAR(256) ,
  
  quantity INTEGER,
  PRIMARY KEY(order_id, product_id)
);*/