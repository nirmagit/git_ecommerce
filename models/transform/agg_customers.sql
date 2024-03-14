with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_orders as (

    select
        c.customer_id,
        o.status as order_status,
        count(order_id) as total_orders,
        sum(o.sales) as total_sales,
        sum(o.units) as total_units
    from 
        customers c
        join 
        orders o
        on c.customer_id = o.customer_id
    group by 1,2
),

final as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        coalesce(co.order_status, 'NIL') as order_status,
        coalesce(co.total_orders, 0) as total_orders,
        coalesce(co.total_sales, 0) as total_sales,
        coalesce(co.total_units, 0) as total_units

    from 
        customers c
        left join 
        customer_orders co 
        using (customer_id)
    order by total_sales desc
)

select * from final