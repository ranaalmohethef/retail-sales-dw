with source as (

    select *
    from {{ ref('snap_address') }}

),

renamed as (

    select
        addressid as address_id,
        addressline1 as address_line_1,
        addressline2 as address_line_2,
        city,
        stateprovinceid as state_province_id,
        postalcode as postal_code,
        spatiallocation as spatial_location,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed