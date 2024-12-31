{% snapshot sales_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='salesordernumber',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select SalesOrderNumber,
       CAST(OrderDate as DATE) as OrderDate,
       ProductKey,
       ResellerKey,
       EmployeeKey,
       SalesTerritoryKey,
       Quantity,
       {{remove_currency('Unit_Price')}} AS Unit_Price,
       {{remove_currency('Sales')}} AS Sales,
       {{remove_currency('cost')}}AS cost,
       '$' as currency,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'sales') }}

{% endsnapshot %}