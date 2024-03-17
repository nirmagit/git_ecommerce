{% test warn_if_neg(model, column_name) %}

    {{ config(severity = 'warn') }}

    select *
    from {{ model }}
    where {{ column_name }} < 0

{% endtest %}