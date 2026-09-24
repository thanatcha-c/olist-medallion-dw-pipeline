select
    row_number() over(order by order_id, payment_sequential) as id,
    order_id,
    payment_sequential as payment_seq,
    payment_type,
    payment_installments as installments,
    payment_value
from {{ source('silver', 'order_payments') }}