select
    date_format(purchased_at, 'yyyy-MM') AS revenue_month,
    count(order_id) as total_delivered_orders,
    sum(case when is_delayed = true then 1 else 0 end) as delayed_orders_count,
    round(sum(case when is_delayed = true then 1 else 0 end) * 100.0 / count(order_id), 2) as delay_rate_pct,
    round(avg(delivery_days), 1) as avg_delivery_days
from {{ ref("fct_orders")}}
where status = 'delivered'
group by 1
order by 1 desc