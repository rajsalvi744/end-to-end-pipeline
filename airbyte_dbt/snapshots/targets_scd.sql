{% snapshot targets_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select EmployeeID||'-'||TargetMonth as id,
       {{remove_currency('Target')}} as Target,
       '$' as currency,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'targets') }}

{% endsnapshot %}
