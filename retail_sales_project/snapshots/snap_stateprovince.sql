{% snapshot snap_stateprovince %}

{{
    config(
        unique_key='stateprovinceid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'STATEPROVINCE') }}

{% endsnapshot %}