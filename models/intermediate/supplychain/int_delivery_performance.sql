with

orders as (

    select distinct
        order_id,
        days_for_shipping_actual,
        days_for_shipment_scheduled,
        delivery_status,
        late_delivery_risk

    from {{ ref('stg_supplychain__orders') }}

)

select
    order_id,
    days_for_shipping_actual,
    days_for_shipment_scheduled,
    case
        when delivery_status = 'Shipping canceled' then null
        else days_for_shipping_actual - days_for_shipment_scheduled
    end as shipping_variance_days,
    case
        when delivery_status = 'Shipping canceled' then null
        else days_for_shipping_actual > days_for_shipment_scheduled
    end as is_late_calculated,
    delivery_status,
    late_delivery_risk

from orders