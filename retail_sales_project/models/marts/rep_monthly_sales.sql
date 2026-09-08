{{
    config(
        materialized='table'
    )
}}

with sales as (

    select *
    from {{ ref('fct_sales_per_order_line') }}

),

product as (

    select *
    from {{ ref('dim_product') }}

),

final as (

    select
        date_trunc('month', s.order_date) as sales_month,
        p.product_category_name,
        s.territory_id,
        sum(s.line_total) as total_sales_amount,
        count(distinct s.sales_order_id) as order_count,
        count(distinct s.customer_id) as distinct_customer_count,
        sum(s.line_total)
            / nullif(count(distinct s.sales_order_id), 0)
            as average_order_value

    from sales s
    left join product p
        on s.product_id = p.product_id

    group by
        date_trunc('month', s.order_date),
        p.product_category_name,
        s.territory_id

)

select *
from final