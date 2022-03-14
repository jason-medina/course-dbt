{{
    config(
        materialized = 'table'
    )
}}

SELECT
    promo_id,   -- Each unique promocode on platform
    discount,    -- Absolute dollar amount that is given off with the code
    status      -- Is the promo code active or disabled
FROM {{source('greenery','promos')}}