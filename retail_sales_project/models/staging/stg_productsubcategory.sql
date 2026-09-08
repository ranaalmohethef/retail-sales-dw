with source as (

    select * from {{ ref('snap_productsubcategory') }}

),

renamed as (

    select
        productsubcategoryid as product_subcategory_id,
        productcategoryid as product_category_id,
        name,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed