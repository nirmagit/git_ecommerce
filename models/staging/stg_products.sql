with source as (
    select * from {{ source('ecommerce', 'products') }}
),
staging as (
    select
        id as product_id
        , name as product_name
        , {{to_brand('brand') }} as brand
        , category
        , rrp{{ money() }} as rrp
        , cost_price{{ money() }} as cost_price
        , department
        , {{to_upc('sku') }} as sku
        , dist_centre_id

    from source
)
select distinct *
    from 
        staging stg
    order by
        stg.product_id