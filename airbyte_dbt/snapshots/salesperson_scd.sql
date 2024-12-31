{% snapshot salesperson_snapshot %}

{{
    config(
      target_database='sales',
      target_schema='snapshots',
      unique_key='employeekey',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select EmployeeKey,
       EmployeeID,
       Salesperson,
       Title,
       UPN,
       _ab_source_file_last_modified as updated_at
from {{ source('sales', 'salesperson') }}

{% endsnapshot %}