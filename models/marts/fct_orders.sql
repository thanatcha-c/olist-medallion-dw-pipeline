with order_payments_agg as (
    select
        order_id,
        count(payment_sequential) as payment_count,
        sum(payment_value) as total_payment_value
    from {{ source("silver","order_payments")}}
    group by order_id
)

select
    row_number() over(order by o.order_id) as id,
    o.order_id,
    o.customer_id,
    o.order_status as status,
    o.order_purchase_ts as purchased_at,
    o.order_approved_ts as approved_at,
    o.order_delivered_carrier_ts as shipped_at,
    o.order_delivered_customer_ts as delivered_at,
    o.order_estimated_delivery_ts as estimated_delivery_at,
    o.delivery_days,
    o.is_delayed,
    coalesce(p.payment_count, 0) as payment_count,
    coalesce(p.total_payment_value, 0.0) as total_payment_value

from {{ source("silver","orders")}} o
left join order_payments_agg p on o.order_id = p.order_id