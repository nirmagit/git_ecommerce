with source as (
    select * from {{ source('ecommerce', 'orders') }}
),
staging as (
    select
        order_id
        , user_id as customer_id
        , nullif(trim(status), '') as status
        , created_dt as created_dt
        , case 
            when status = 'Complete' then delivered_dt
            when status = 'Shipped' then shipped_dt
            when status = 'Returned' then returned_dt
            else created_dt
          end as updated_dt
        , nullif(quantity, 0) as units
    from source
)
select distinct *
    from 
        staging stg
    order by
        stg.order_id,
        stg.customer_id