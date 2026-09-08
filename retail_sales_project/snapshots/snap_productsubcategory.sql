{% snapshot snap_productsubcategory %}

{{
    config(
        unique_key='productsubcategoryid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'PRODUCTSUBCATEGORY') }}

{% endsnapshot %}