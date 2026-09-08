with source as (

    select * from {{ ref('snap_salesorderheader') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        revisionnumber as revision_number,
        orderdate as order_date,
        duedate as due_date,
        shipdate as ship_date,
        status,
        onlineorderflag as online_order_flag,
        salesordernumber as sales_order_number,
        purchaseordernumber as purchase_order_number,
        accountnumber as account_number,
        customerid as customer_id,
        salespersonid as sales_person_id,
        territoryid as territory_id,
        billtoaddressid as bill_to_address_id,
        shiptoaddressid as ship_to_address_id,
        subtotal as subtotal,
        taxamt as tax_amount,
        freight,
        totaldue as total_due,
        modifieddate as modified_date
    from source
    where dbt_valid_to is null

)

select * from renamed