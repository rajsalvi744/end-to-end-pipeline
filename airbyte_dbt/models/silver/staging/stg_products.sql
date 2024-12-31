SELECT ProductKey,
       Product,
       Standard_Cost,
       Subcategory,
       Category
from {{source('sales','products')}}