{{
    config(
        materialized='incremental',
        unique_key='address_id',
        incremental_strategy='merge'
    )
}}

with address as (

    select *
    from {{ ref('stg_address') }}

),

state_province as (

    select *
    from {{ ref('stg_stateprovince') }}

),

country_region as (

    select *
    from {{ ref('stg_countryregion') }}

),

final as (

    select
        a.address_id,
        a.address_line_1,
        a.address_line_2,
        a.city,
        a.postal_code,
        a.state_province_id,
        s.state_province_code,
        s.name as state_province_name,
        s.country_region_code,
        c.name as country_region_name,
        c.currency_code,
        s.territory_id,
        greatest_ignore_nulls(
            a.modified_date,
            s.modified_date,
            c.modified_date
        ) as modified_date

    from address a
    left join state_province s
        on a.state_province_id = s.state_province_id
    left join country_region c
        on s.country_region_code = c.country_region_code

)

select *
from final

{% if is_incremental() %}

where modified_date > (
    select max(modified_date)
    from {{ this }}
)

{% endif %}