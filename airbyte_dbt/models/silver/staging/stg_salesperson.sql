SELECT EmployeeKey,
       EmployeeID,
       Salesperson,
       Title,
       UPN
from {{source('sales','salesperson')}}
