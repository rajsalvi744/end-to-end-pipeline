SELECT s.SalesTerritoryKey,
       r.Region,
       r.Country,
       r.Groups,
       ROUND(SUM(s.Sales)::numeric,2) as Sales,
       ROUND(SUM(s.sales-s.cost)::numeric,0) as profit
FROM {{ref('stg_sales')}} s
INNER JOIN {{ref('stg_region')}} r ON s.SalesTerritoryKey=r.SalesTerritoryKey
GROUP BY s.SalesTerritoryKey,r.Region, r.Country, r.Groups
ORDER BY s.SalesTerritoryKey ASC