{{
    config(
        materialized = 'table'
    )
}}

SELECT
    product_id,                         -- UUID for each unique product on platform
    name    AS product_name,            -- Name of the product
    price,                              -- Price of the product
    inventory                           -- Amount of the inventory we have for this product
FROM {{source('greenery','products')}}