{% snapshot snap_productcategory %}

{{
    config(
        unique_key='productcategoryid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'PRODUCTCATEGORY') }}

{% endsnapshot %}