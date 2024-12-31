SELECT SalesTerritoryKey,
       Region,
       Country,
       Groups
from {{source('sales','region')}}