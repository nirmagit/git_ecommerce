with customers as (
    select * from {{ ref('dim_customers') }}
),

orders as (
    select * from {{ ref('fct_orderitems') }}
),

products as (
    select * from {{ ref('dim_products') }}
),

total_sales as (
    select c.country
           , year(o.updated_dt) as sales_year
           , month(o.updated_dt) as sales_month
           , o.status as order_status
           , p.brand
           , p.category
           , count(o.order_id) as total_orders
           , count(o.customer_id) as total_customers
           , sum(o.total_price) as total_sales
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
            year(o.updated_dt),
            month(o.updated_dt),
            o.status,
            p.brand,
            p.category

)
select * from total_sales