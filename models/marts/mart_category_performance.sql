select
    category_name,
    count(distinct i.order_id) as total_orders_count,
    sum(quantity) as total_units_sold,
    sum(sales_amount) as total_revenue,
    avg(price) as avg_unit_price
from {{ ref("fct_order_items")}} i
left join {{ref("dim_products")}} p
on i.product_id = p.product_id
left join {{ref("fct_orders")}} o
on i.order_id = o.order_id
where status = 'delivered'
group by category_name
order by total_revenue desc