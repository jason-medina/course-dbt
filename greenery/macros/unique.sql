{% test unique(model, column_name) %}

   with row_counter as (
   select {{ column_name }}, count(0) row_count
   from {{ model }}
   group by {{ column_name }}
   )

   select {{ column_name }} from row_counter 
   where row_count > 1

{% endtest %}