with
    customers as (select * from {{ source("jaffle_shop", "customers") }}),

    orders as (select * from {{ source("jaffle_shop", "orders") }}),

    payments as (select * from {{ source("stripe", "payments") }}),

    completed_payments as (
        select
            orderid as order_id,
            max(created) as payment_finalized_date,
            sum(amount) / 100.0 as total_amount_paid
        from payments p
        where status <> 'fail'
        group by all

    ),

    paid_orders as (
        select
            o.id as order_id,
            o.user_id as customer_id,
            o.order_date as order_placed_at,
            o.status as order_status,
            p.total_amount_paid,
            p.payment_finalized_date,
            c.first_name as customer_first_name,
            c.last_name as customer_last_name
        from orders o
        left join completed_payments p on o.id = p.order_id
        left join customers c on o.user_id = c.id
    ),

    customer_orders as (
        select
            c.id as customer_id,
            min(order_date) as first_order_date,
            max(order_date) as most_recent_order_date,
            count(o.id) as number_of_orders
        from customers c
        left join orders as o on o.user_id = c.id
        group by all
    )

select
    p.*,
    row_number() over (order by p.order_id) as transaction_seq,
    row_number() over (
        partition by customer_id order by p.order_id
    ) as customer_sales_seq,
    case
        when c.first_order_date = p.order_placed_at then 'new' else 'return'
    end as nvsr,
    sum(total_amount_paid) over (
        partition by customer_id order by order_id
    ) as customer_lifetime_value,
    c.first_order_date as fdos
from paid_orders p
left join customer_orders as c using (customer_id)
order by order_id
