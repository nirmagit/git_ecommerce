with orderitems as (
    select * from {{ ref('stg_orderitems') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),
distinct_orderitems as (
    select oi.order_id
        , oi.customer_id
        , oi.product_id
        , oi.status
        , oi.created_dt
        , oi.updated_dt
        , count(product_id) as units
        , sum(oi.sale_price) as sale_price
        from orderitems oi 
        join orders o
        on oi.order_id = o.order_id 
        and oi.customer_id = o.customer_id
        group by 1,2,3,4,5,6
)
select *
    , (sale_price * units) as total_price
    from 
        distinct_orderitems
        order by 
            updated_dt

