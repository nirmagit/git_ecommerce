with products as (
    select * from {{ ref('stg_products') }}
),

dist_centres as (
    select * from {{ ref('stg_dist_centre') }}
),
dim_products as (
    select p.*
        , dc.name as dist_centre
    from products p
    join dist_centres dc
    on p.dist_centre_id = dc.centre_id
)
select * 
    from dim_products