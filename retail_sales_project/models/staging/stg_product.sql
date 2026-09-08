with source as (

    select * from {{ ref('snap_product') }}

),

renamed as (

    select
        product_id,
        name,
        product_number,
        make_flag,
        finished_goods_flag,
        color,
        safety_stock_level,
        reorder_point,
        standard_cost,
        list_price,
        size,
        weight,
        days_to_manufacture,
        product_line,
        class,
        style,
        product_subcategory_id,
        product_model_id,
        sell_start_date,
        sell_end_date,
        discontinued_date,
        modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed