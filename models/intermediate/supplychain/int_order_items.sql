with

order_items as (

    select * from {{ ref('stg_supplychain__orders') }}

)

select
    order_item_id,
    order_id,
    product_id,
    category_id,
    category_name,
    product_name,
    product_price,
    order_item_product_price,
    order_item_quantity,
    order_item_discount,
    order_item_discount_rate,
    order_item_total

from order_items