{{
    config(
        materialized='incremental',
        unique_key='customer_id',
        incremental_strategy='merge'
    )
}}

with customer as (

    select *
    from {{ ref('stg_customer') }}

),

person as (

    select *
    from {{ ref('stg_person') }}

),

final as (

    select
        c.customer_id,
        c.person_id,
        c.store_id,
        c.territory_id,
        c.account_number,
        p.first_name,
        p.middle_name,
        p.last_name,
        greatest_ignore_nulls(
            c.modified_date,
            p.modified_date
        ) as modified_date

    from customer c
    left join person p
        on c.person_id = p.business_entity_id

)

select *
from final

{% if is_incremental() %}

where modified_date > (
    select max(modified_date)
    from {{ this }}
)

{% endif %}