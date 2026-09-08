{{
    config(
        materialized='incremental',
        unique_key='product_id',
        incremental_strategy='merge'
    )
}}

with product as (

    select *
    from {{ ref('stg_product') }}

),

subcategory as (

    select *
    from {{ ref('stg_productsubcategory') }}

),

category as (

    select *
    from {{ ref('stg_productcategory') }}

),

final as (

    select
        p.product_id,
        p.name as product_name,
        p.product_number,
        p.color,
        p.standard_cost,
        p.list_price,
        p.size,
        p.weight,
        p.product_subcategory_id,
        s.name as product_subcategory_name,
        s.product_category_id,
        c.name as product_category_name,
        greatest_ignore_nulls(
            p.modified_date,
            s.modified_date,
            c.modified_date
        ) as modified_date

    from product p
    left join subcategory s
        on p.product_subcategory_id = s.product_subcategory_id
    left join category c
        on s.product_category_id = c.product_category_id

)

select *
from final

{% if is_incremental() %}

where modified_date > (
    select max(modified_date)
    from {{ this }}
)

{% endif %}