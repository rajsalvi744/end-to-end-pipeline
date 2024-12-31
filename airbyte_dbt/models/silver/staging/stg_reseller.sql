SELECT ResellerKey,
       Business_Type,
       Reseller,
       City,
       State_Province,
       Country_Region
from {{source('sales','reseller')}}