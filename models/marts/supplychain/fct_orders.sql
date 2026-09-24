with

order_items as (

    select * from {{ ref('int_order_items') }}

),

orders as (

    select * from {{ ref('int_order') }}

),

profitability as (

    select * from {{ ref('int_order_profitability') }}

),

delivery as (

    select * from {{ ref('int_delivery_performance') }}

)

select
    oi.order_item_id,
    oi.order_id,

    -- order-level attributes
    o.order_customer_id,
    o.order_date,
    o.order_status,
    o.market,
    o.order_region,
    o.order_country,
    o.order_state,
    o.order_city,
    o.shipping_mode,
    o.shipping_date,

    -- item-level attributes
    oi.product_id,
    oi.category_id,
    oi.category_name,
    oi.product_name,
    oi.product_price,
    oi.order_item_product_price,
    oi.order_item_quantity,
    oi.order_item_discount,
    oi.order_item_discount_rate,
    oi.order_item_total,

    -- profitability
    p.sales,
    p.order_profit,
    p.order_item_profit_ratio,

    -- delivery performance
    d.days_for_shipping_actual,
    d.days_for_shipment_scheduled,
    d.shipping_variance_days,
    d.is_late_calculated,
    d.delivery_status,
    d.late_delivery_risk

from order_items oi
left join orders o on oi.order_id = o.order_id
left join profitability p on oi.order_item_id = p.order_item_id
left join delivery d on oi.order_id = d.order_id