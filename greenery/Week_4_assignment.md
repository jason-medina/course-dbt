# Week 4 assignment

### Part 1. dbt Snapshots
```
{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      updated_at='created_at',
      check_cols=['status']
    )
  }}

  SELECT * FROM {{source('greenery','orders')}}

{% endsnapshot %}
```

#### Create a snapshot model using the orders source in the /snapshots/ directory of our dbt project

> Run the snapshot model to create it in our database (dbt snapshot)
   make sure to add strategy and column checks to snapshot sql model

> Run delivery-update.sh to update the delivery status of some (3) orders. 
   This updates data for order Ids ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85', '939767ac-357a-4bec-91f8-a7b25edd46c9')

> Run dbt snapshot again and see how the data has changed
  > if the snapshot does not update, check snapshot logic


  
### Part 2. Modeling challenge
![image](https://user-images.githubusercontent.com/20348624/161450807-52f74ce0-1c18-49e8-b298-ebb635e08c43.png)

#### How are our users moving through the product funnel?
> From page view (578) to carts (467), and carts to checkout (361).  

#### Which steps in the funnel have largest drop off points? 
> Carts to checkout has the largest drop at 29%. 

~~~sql
WITH sessions AS (

  SELECT 
  * 
  FROM {{ ref('agg_user_session') }}
  ), 


funnel AS (

    SELECT 
      'Product funnel' AS funnel_step
      , COUNT( DISTINCT CASE WHEN 
                page_view > 0
                OR add_to_cart > 0
                OR checkout > 0 
                OR package_shipped > 0
                THEN session_id 
                ELSE NULL END) AS funnel_value
    FROM sessions

    UNION ALL

    SELECT
      'Conversion funnel' AS funnel_step
      , COUNT(DISTINCT CASE WHEN 
              add_to_cart > 0
              OR checkout > 0 
              OR package_shipped > 0
              THEN session_id
              ELSE NULL END) AS funnel_value
    FROM sessions

    UNION ALL
    
    SELECT
        'Checkout funnel' AS funnel_step
        , COUNT(DISTINCT CASE WHEN 
                checkout > 0 
                OR package_shipped > 0
                THEN session_id 
                ELSE NULL END) AS funnel_value
    FROM sessions

    ), 

previous_steps AS (

    SELECT 
        funnel_step
        , funnel_value
        , LAG(funnel_value) OVER () AS previous_funnel_step
        , MAX(funnel_value) OVER () AS first_funnel_step
    FROM funnel 

    ),

vwfunnel AS (

    SELECT 
        funnel_step
        , funnel_value
        , previous_funnel_step
        , ROUND(funnel_value / previous_funnel_step::NUMERIC, 2) AS step_conversion
    FROM previous_steps
    
    )

SELECT * FROM vwfunnel
~~~
