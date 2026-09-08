{{
    config(
        materialized='incremental',
        unique_key='sales_order_detail_id',
        incremental_strategy='merge'
    )
}}

with header as (

    select *
    from {{ ref('stg_salesorderheader') }}

),

detail as (

    select *
    from {{ ref('stg_salesorderdetail') }}

),

final as (

    select
        d.sales_order_detail_id,
        d.sales_order_id,
        h.customer_id,
        d.product_id,
        h.ship_to_address_id as location_id,
        h.territory_id,
        h.order_date,
        h.due_date,
        h.ship_date,
        d.order_qty,
        d.unit_price,
        d.unit_price_discount,
        d.line_total,
        greatest_ignore_nulls(
            h.modified_date,
            d.modified_date
        ) as modified_date

    from detail d
    inner join header h
        on d.sales_order_id = h.sales_order_id

)

select *
from final

{% if is_incremental() %}

where order_date >= (
    select dateadd(day, -7, max(order_date))
    from {{ this }}
)

{% endif %}