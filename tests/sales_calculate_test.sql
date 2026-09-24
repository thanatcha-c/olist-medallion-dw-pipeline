select
    order_id,
    product_id,
    price,
    quantity,
    sales_amount,
    (price * quantity) as calculated_sales
from {{ ref('fact_order_items') }}
where abs((price * quantity) - sales_amount) > 0.01