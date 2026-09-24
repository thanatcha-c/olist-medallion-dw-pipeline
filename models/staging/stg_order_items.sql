select
    order_id,
    order_item_id as item_id,
    product_id,
    seller_id,
    shipping_limit_ts as shipping_limit_at,
    price,
    freight_value,
    total
from {{ source('silver', 'order_items') }}