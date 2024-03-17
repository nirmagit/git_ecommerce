{% snapshot customers %}

{% set new_schema = target.schema + '_snapshot' %}

{{
    config(
        target_database='DB_VN252_NS',
        target_schema=new_schema,
        unique_key='customer_id',

        strategy='timestamp',
        updated_at='created_at',
    )

}}

select * from {{ ref('dim_customers') }}

{% endsnapshot %}