with source as (
        select *from {{ source("ecommerce", "dist_centres") }}
),
staging as (
    select
        centre_id,
        name
    from source
)
select *
    from 
        staging stg
        order by 
        stg.centre_id
