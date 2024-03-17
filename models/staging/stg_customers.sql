with source as (
        select * from {{ source("ecommerce", "customers") }}
),
staging as (
    select
        id as customer_id,
        first_name,
        last_name,
        {{ to_valid_email('email') }} as email,
        {{ is_age('age') }} as age,
        gender,
        state,
        city,
        country,
        created_at
    from source
)
select *
    from 
        staging stg
    where age <> 0
    order by 
        stg.customer_id
