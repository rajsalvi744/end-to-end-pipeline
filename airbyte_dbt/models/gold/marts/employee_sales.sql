SELECT s.EmployeeKey,
       sp.EmployeeID,
       sp.Salesperson,
       sp.Title,
       TO_CHAR(OrderDate,'Month') AS month_name,
       EXTRACT(YEAR FROM OrderDate) AS year_value,
       ROUND(SUM(s.sales)::numeric,2) AS sales,
       ROUND(SUM(s.sales-s.cost)::numeric,0) AS profit
from {{ref('stg_sales')}} s
INNER JOIN {{ref('stg_salesperson')}} sp ON sp.EmployeeKey = s.EmployeeKey
GROUP BY s.EmployeeKey, sp.EmployeeID, sp.Salesperson, sp.Title, month_name, year_value
ORDER BY s.EmployeeKey, sp.EmployeeID, sp.Salesperson, sp.Title, year_value, month_name


