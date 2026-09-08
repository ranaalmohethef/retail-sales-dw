{% snapshot snap_address %}

{{
    config(
        unique_key='addressid',
        strategy='check',
        check_cols=[
            'addressline1',
            'addressline2',
            'city',
            'stateprovinceid',
            'postalcode',
            'spatiallocation'
        ]
    )
}}

select *
from {{ source('raw', 'ADDRESS') }}

{% endsnapshot %}