with source as (
    select * from {{ source('ecommerce', 'orders') }}
),
staging as (
    select
        order_id
        , user_id as customer_id
        , product_id
        , nullif(trim(status), '') as status
        , to_date(created_at, 'DD/MM/YYYY') as order_date
        , to_date(delivered_at, 'DD/MM/YYYY') as delivered_date
        , to_date(returned_at, 'DD/MM/YYYY') as returned_date
        , sales_value{{ money() }} as sales
        , quantity as units
        , (sales_value/nullif(quantity, 0)){{ money() }} as item_price

    from source
)
select distinct *
    from 
        staging stg
    order by
        stg.order_id,
        stg.customer_id,
        stg.product_id