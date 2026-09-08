with source as (

    select * from {{ ref('snap_stateprovince') }}

),

renamed as (

    select
        stateprovinceid as state_province_id,
        stateprovincecode as state_province_code,
        countryregioncode as country_region_code,
        isonlystateprovinceflag as is_only_state_province_flag,
        name,
        territoryid as territory_id,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed