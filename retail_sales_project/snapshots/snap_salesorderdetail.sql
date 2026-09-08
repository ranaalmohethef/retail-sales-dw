{% snapshot snap_salesorderdetail %}

{{
    config(
        unique_key='salesorderdetailid',
        strategy='check',
        check_cols='all'
    )
}}

select *
from {{ source('raw', 'SALESORDERDETAIL') }}

{% endsnapshot %}