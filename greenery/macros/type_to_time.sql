{% macro type_to_time(column_name, value, time_col) %}
    MIN(
       (CASE WHEN {{ column_name }} = '{{value}}' THEN {{time_col}} END)
    )
{% endmacro %}