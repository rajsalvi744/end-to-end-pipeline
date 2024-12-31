{% snapshot reseller_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='resellerkey',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select ResellerKey,
       Business_Type,
       Reseller,
       City,
       State_Province,
       Country_Region,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'reseller') }}

{% endsnapshot %}