WITH temp_table AS (SELECT EmployeeID,
                           Target,
                           TO_CHAR(TargetMonth,'Month') as month_name,
                           EXTRACT(YEAR FROM TargetMonth) as year_value
                    FROM {{ref('stg_targets')}})

SELECT es.EmployeeID,
       es.Salesperson,
       es.month_name,
       es.year_value,
       es.sales,
       t.Target,
       (CASE
        WHEN es.sales > t.Target THEN 'Target Achieved' ELSE 'Target Failed' END) AS Target_Status
FROM {{ref('employee_sales')}} es
INNER JOIN temp_table t ON t.EmployeeID = es.EmployeeID AND
                           t.month_name = es.month_name AND
                           t.year_value = es.year_value
ORDER BY es.EmployeeID, es.Salesperson, es.year_value, es.month_name



