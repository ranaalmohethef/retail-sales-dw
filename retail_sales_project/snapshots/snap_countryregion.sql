{% snapshot snap_countryregion %}

{{
    config(
        unique_key='snapshot_key',
        strategy='check',
        check_cols='all'
    )
}}

select
    *,
    coalesce(countryregioncode, '__NAME__' || name) as snapshot_key
from {{ source('raw', 'COUNTRYREGION') }}

{% endsnapshot %}