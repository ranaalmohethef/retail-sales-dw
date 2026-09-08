with source as (

    select * from {{ ref('snap_customer') }}

),

renamed as (

    select
        customerid as customer_id,
        personid as person_id,
        storeid as store_id,
        territoryid as territory_id,
        accountnumber as account_number,
        try_to_timestamp_ntz(
    replace(to_varchar(modifieddate), '&', '')
) as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed