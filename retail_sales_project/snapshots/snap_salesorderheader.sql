{% snapshot snap_salesorderheader %}

{{
    config(
        unique_key='salesorderid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'SALESORDERHEADER') }}

{% endsnapshot %}