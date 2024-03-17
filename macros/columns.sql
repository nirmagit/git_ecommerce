{% macro to_valid_email(email) %}
    case when {{email}} rlike '^([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+)\\.([a-zA-Z]{2,})$' then {{email}} else NULL end
{% endmacro %}

{% macro to_upc(column_name) %}
    case when {{column_name}} rlike '^([a-zA-Z0-9]+)$' then {{column_name}} else NULL end
{% endmacro %}

{%  macro to_brand(column_name) %}
    case when rlike(nullif(trim({{column_name}}), ''), '.[a-z0-9]{1,}', 'i') then nullif(trim({{column_name}}), '') else NULL end
{% endmacro %}

{% macro is_age(age_column) %}
    case when {{ age_column }} >= 12 and {{ age_column }} <= 90 then {{ age_column }} else 0 end
{% endmacro %}

{% macro money(col) -%}
::decimal(16,4)
{%- endmacro %}

