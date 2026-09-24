select
    date_format(purchased_at, 'yyyy-MM') AS revenue_month,
    count(distinct order_id) as total_orders,
    count(distinct c.customer_unique_id) as total_customers,
    sum(o.total_sales) as total_revenue,
    avg(o.total_sales) as avg_order_value
from {{ ref("fct_orders") }} o
left join {{ ref("dim_customers")}} c 
on o.customer_id = c.customer_id
where status = 'delivered' 
group by 1
order by revenue_month desc