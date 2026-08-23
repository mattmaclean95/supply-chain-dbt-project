with

orders as (

    select * from {{ ref('stg_supplychain__orders') }}

)

select distinct
    order_id,
    order_customer_id,
    order_date,
    order_status,
    market,
    order_region,
    order_country,
    order_state,
    order_city,
    shipping_mode,
    shipping_date

from orders