{% snapshot snap_product %}

{{
    config(
        unique_key='product_id',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'PRODUCT') }}

{% endsnapshot %}