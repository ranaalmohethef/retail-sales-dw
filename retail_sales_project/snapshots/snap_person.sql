{% snapshot snap_person %}

{{
    config(
        unique_key='businessentityid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'PERSON') }}

{% endsnapshot %}