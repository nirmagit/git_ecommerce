with
    source as (select * from {{ source("ecommerce", "customers") }}),
    staging as (
        select
            id as customer_id,
            first_name,
            last_name,
            {{ to_valid_email("email") }} as email,
            gender,
            country

        from source
    )
select distinct *
from staging stg
order by stg.customer_id
