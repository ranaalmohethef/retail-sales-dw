with source as (

    select * from {{ ref('snap_person') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        persontype as person_type,
        namestyle as name_style,
        title,
        firstname as first_name,
        middlename as middle_name,
        lastname as last_name,
        suffix,
        emailpromotion as email_promotion,
       try_to_timestamp_ntz(
    replace(to_varchar(modifieddate), '&', '')
) as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed