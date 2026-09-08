with source as (

    select * from {{ ref('snap_countryregion') }}

),

renamed as (

    select
        snapshot_key as country_region_key,
        countryregioncode as country_region_code,
        name,
        case
            when try_to_timestamp_ntz(currencycode) is not null
                 and modifieddate is null
            then null
            else currencycode
        end as currency_code,
        coalesce(
            modifieddate,
            try_to_timestamp_ntz(currencycode)
        ) as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed