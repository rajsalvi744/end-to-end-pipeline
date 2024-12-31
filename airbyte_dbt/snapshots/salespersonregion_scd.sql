{% snapshot salespersonregion_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select EmployeeKey||'-'||SalesTerritoryKey AS id,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'salespersonregion') }}

{% endsnapshot %}