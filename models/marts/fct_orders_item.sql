with order_items_agg as (
    select
        order_id,
        product_id,
        seller_id,
        any_value(shipping_limit_ts) as shipping_limit_at,
        count(*) as quantity,
        sum(price) as sales,
        sum(freight_value) as freight_value,
        max(price) as price 
    from {{ source("silver","order_items")}}
    group by order_id, product_id, seller_id
)

select
    row_number() over(order by o.order_id, i.product_id, i.seller_id) as id,
    o.order_id,
    o.customer_id,
    i.product_id, 
    i.seller_id,
    i.shipping_limit_at,
    i.quantity,
    i.price,                    
    i.sales as sales_amount, 
    i.freight_value

from {{ source("silver", "orders")}} o
inner join order_items_agg i on o.order_id = i.order_id