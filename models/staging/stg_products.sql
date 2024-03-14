with source as (
    select * from {{ source('ecommerce', 'products') }}
),
staging as (
    select
        id as product_id
        , name
        , {{to_brand('brand') }} as brand
        , category
        , rrp{{ money() }} as rrp
        , department
        , {{to_upc('sku') }} as sku

    from source
)
select distinct *
    from 
        staging stg
    order by
        stg.product_id