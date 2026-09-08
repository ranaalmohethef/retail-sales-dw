with source as (

    select * from {{ ref('snap_productcategory') }}

),

renamed as (

    select
        productcategoryid as product_category_id,
        name,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed