select
    order_id,
    customer_id,
    order_status as status,
    order_purchase_ts as purchased_at,
    order_approved_ts as approved_at,
    order_delivered_carrier_ts as shipped_at,
    order_delivered_customer_ts as delivered_at,
    order_estimated_delivery_ts as estimated_delivery_at,
    delivery_days,
    is_delayed
from {{ source('silver', 'orders') }}