{{
  config(
    materialized = 'table'
  )
}}

SELECT 
    address_id,   -- UUID for each unique address on platform
    address,      -- The first few lines of the address
    zipcode,      -- The zipcode of the address
    state,        -- state this delivery address is based in
    country       -- country this delivery address is based in
FROM {{ source('greenery', 'addresses') }}