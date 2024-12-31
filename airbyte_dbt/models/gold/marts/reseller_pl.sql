with temp_table as (SELECT s.ResellerKey,
       r.Business_Type,
       r.Reseller,
       r.City,
       ROUND(SUM((CASE
                  WHEN s.cost - s.sales > 0
                  THEN s.cost - s.sales ELSE 0 END))::numeric,2) as profit,
       ROUND(SUM((CASE
                  WHEN s.sales - s.cost > 0
                  THEN s.sales - s.cost ELSE 0 END))::numeric,2) as loss
FROM {{ref('stg_sales')}} s
INNER JOIN {{ref('stg_reseller')}} r ON r.ResellerKey = s.ResellerKey
GROUP BY s.ResellerKey, r.Business_Type, r.Reseller, r.City
ORDER BY s.ResellerKey),

temp_table2 AS (SELECT *,
       (CASE
        WHEN profit > loss THEN 'profit' ELSE 'loss' END) AS profit_or_loss
from temp_table)

SELECT *,
       (CASE
        WHEN profit_or_loss = 'profit' THEN profit - loss ELSE loss - profit END) AS income
FROM temp_table2
