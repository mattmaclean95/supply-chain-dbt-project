with

order_items as (

    select * from {{ ref('stg_supplychain__orders') }}

)

select
    order_item_id,
    order_id,
    sales,
    order_item_total,
    benefit_per_order as order_profit,
    order_item_profit_ratio

from order_items