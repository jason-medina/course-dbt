{{
    config(
        materialized = 'table'
    )
}}

SELECT
    product_id,
    name,
    price,
    inventory
    status
FROM {{source('greenery','products')}}

/*
CREATE TABLE products (
  -- UUID for each unique product on platform
  product_id VARCHAR(256) PRIMARY KEY,
  -- Name of the product
  name VARCHAR(1024),
  -- Price of the product
  price REAL,
  -- Amount of the inventory we have for this product
  inventory INTEGER
);*/