{% snapshot region_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='salesterritorykey',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select SalesTerritoryKey,
       Region,
       Country,
       Groups,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'region') }}

{% endsnapshot %}