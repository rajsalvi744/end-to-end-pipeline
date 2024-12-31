SELECT SalesOrderNumber,
       CAST(OrderDate as DATE) as OrderDate,
       ProductKey,
       ResellerKey,
       EmployeeKey,
       SalesTerritoryKey,
       Quantity,
       {{remove_currency('Unit_Price')}} AS Unit_Price,
       {{remove_currency('Sales')}} AS Sales,
       {{remove_currency('cost')}}AS cost,
       '$' as currency
from {{source('sales','sales')}}
