{{
    config(
        materialized = 'table'
    )
}}

SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
FROM {{source('greenery','users')}}


/*CREATE TABLE users (
  -- UUID for each unique user on platform
  user_id VARCHAR(256) PRIMARY KEY,
  -- first name of the user
  first_name VARCHAR(256),
  -- last name of the user
  last_name VARCHAR(256),
  -- email address of the user
  email VARCHAR(1024),
  -- phone number of the user
  phone_number VARCHAR(256),
  -- timestamp the user was created
  created_at TIMESTAMP,
  -- timestamp the user was last updated
  updated_at TIMESTAMP,
  -- default delivery address for the user
  address_id VARCHAR(256) REFERENCES addresses(address_id)
);*/