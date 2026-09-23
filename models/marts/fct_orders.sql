with order_items_agg as (
    select
        order_id,
        count(*) as item_count,
        sum(price) as total_sales,
        sum(freight_value) as total_freight_value
    from  {{ source("silver","order_items")}} 
    group by order_id
),

order_payments_agg as (
    select
        order_id,
        count(*) as payment_count,
        sum(payment_value) as total_payment_value
    from  {{ source("silver","order_payments")}} 
    group by order_id
)

select
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
    coalesce(i.item_count, 0) as item_count,
    coalesce(i.total_sales, 0) as total_sales,
    coalesce(i.total_freight_value, 0) as total_freight_value,
    coalesce(p.payment_count, 0) as payment_count,
    coalesce(p.total_payment_value, 0) as total_payment_value

from {{ source("silver","orders")}} o
left join order_items_agg i on o.order_id = i.order_id
left join order_payments_agg p on o.order_id = p.order_id