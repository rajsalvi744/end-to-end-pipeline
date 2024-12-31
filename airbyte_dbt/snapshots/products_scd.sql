{% snapshot products_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='productkey',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select ProductKey,
       Product,
       Standard_Cost,
       Subcategory,
       Category,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'products') }}

{% endsnapshot %}