with source as (

    select * from {{ ref('snap_salesorderdetail') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        salesorderdetailid as sales_order_detail_id,
        carriertrackingnumber as carrier_tracking_number,
        orderqty as order_qty,
        productid as product_id,
        specialofferid as special_offer_id,
        unitprice as unit_price,
        unitpricediscount as unit_price_discount,
        linetotal as line_total,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed