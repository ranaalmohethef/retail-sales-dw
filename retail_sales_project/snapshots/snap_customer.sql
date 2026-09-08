{% snapshot snap_customer %}

{{
    config(
        unique_key='customerid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'CUSTOMER') }}

{% endsnapshot %}