with customers as (
    select * from {{ ref('dim_customers') }}
),

orderitems as (
    select * from {{ ref('fct_orderitems') }}
),

customer_orders as (

    select
        c.customer_id,
        o.status as order_status,
        count(o.order_id) as total_orders,
        count(o.product_id) as total_products,
        sum(o.total_price) as total_sales,
        sum(o.units) as total_units
    from 
        customers c
        join 
        orderitems o
        on c.customer_id = o.customer_id
    group by 1,2
),

final as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.gender,
        c.age,
        c.state,
        c.city,
        c.country,
        coalesce(co.order_status, 'NIL') as order_status,
        coalesce(co.total_orders, 0) as total_orders,
        coalesce(co.total_products, 0) as total_products,
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