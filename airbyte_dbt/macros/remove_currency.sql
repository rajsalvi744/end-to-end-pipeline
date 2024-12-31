{% macro remove_currency(column_name)%}
   (CAST(REPLACE(RIGHT({{column_name}},LENGTH({{column_name}})-1),',','') AS FLOAT))
{% endmacro %}