SELECT EmployeeKey,
       SalesTerritoryKey
from {{source('sales','salespersonregion')}}