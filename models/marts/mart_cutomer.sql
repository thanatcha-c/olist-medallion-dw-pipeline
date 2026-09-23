with customer_summary as (
    select
        c.customer_unique_id,
        datediff(day, max(purchased_at), '2018-10-17') as recency_days, 
        count(distinct order_id) as frequency,
        sum(total_sales) as monetary
    from {{ ref("fct_orders")}} o
    left join {{ ref("dim_customers")}} c
    on o.customer_id = c.customer_id
    where status != 'canceled'
    group by customer_unique_id
)

select
    customer_unique_id,
    recency_days,
    frequency,
    monetary
from customer_summary
order by frequency desc