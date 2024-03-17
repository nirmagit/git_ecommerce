with orderitems as (
    select * from {{ ref('stg_orderitems') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),
distinct_orderitems as (
    select oi.*
        , o.units
        from orderitems oi 
        join orders o
        on oi.order_id = o.order_id 
        and oi.customer_id = o.customer_id
)
select *
    , (sale_price * units) as total_price
    from 
        distinct_orderitems
        order by 
            orderitems_id

