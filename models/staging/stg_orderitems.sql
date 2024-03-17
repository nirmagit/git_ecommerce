with source as (
    select * from {{ source('ecommerce', 'orderitems') }}
),
staging as (
    select
        orderitems_id
        , order_id
        , user_id as customer_id
        , product_id
        , nullif(trim(status), '') as status
        , created_dt as created_dt
        , case 
            when status = 'Complete' then delivered_dt
            when status = 'Shipped' then shipped_dt
            when status = 'Returned' then returned_dt
            else created_dt
          end as updated_dt
        , sale_price{{ money() }} as sale_price
    
    from source
)
select distinct *
    from 
        staging stg
    order by
        stg.orderitems_id