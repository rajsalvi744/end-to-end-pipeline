SELECT EmployeeID,
       {{remove_currency('Target')}} as Target,
       '$' as currency,
       CAST(TargetMonth as DATE) AS TargetMonth
from {{source('sales','targets')}}
