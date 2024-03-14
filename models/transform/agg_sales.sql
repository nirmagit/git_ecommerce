with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

total_sales as (
    select c.country
           , year(o.order_date) as sales_year
           , month(o.order_date) as sales_month
           , o.status as order_status
           , p.brand
           , p.category
           , count(o.order_id) as total_orders
           , sum(o.sales) as total_sales
           , sum(o.units) as total_units
        from 
            orders o
            join 
            customers c 
            on o.customer_id = c.customer_id
            join 
            products p
            on o.product_id = p.product_id
        group by 
            c.country,
            year(o.order_date),
            month(o.order_date),
            o.status,
            p.brand,
            p.category

)
select * from total_sales