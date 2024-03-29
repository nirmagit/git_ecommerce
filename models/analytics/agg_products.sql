with products as (
    select * from {{ ref('dim_products') }}
),

orderitems as (
    select * from {{ ref('fct_orderitems') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),


products_sales as (
    select p.product_id
           , o.status
           , count(oi.order_id) as total_orders
           , count(oi.customer_id) as total_customers
           , sum(oi.total_price) as products_sales
           , sum(oi.units) as sold_units
           , sum(oi.sale_price) - sum(p.cost_price) as profit_or_loss
    from 
        products p
        join 
        orderitems oi
        on p.product_id = oi.product_id
        join orders o
        on oi.order_id = o.order_id
        group by 1,2
),
final as (
    select p.product_id
           , p.category
           , p.product_name
           , p.brand
           , p.department
           , p.sku
           , p.dist_centre
           , ps.status
           , coalesce(ps.total_orders, 0) as total_orders
           , coalesce(ps.total_customers, 0) as total_customers
           , coalesce(ps.products_sales, 0) as products_sales
           , coalesce(ps.sold_units, 0) as sold_units
           , coalesce(ps.profit_or_loss, 0) as profit_or_loss
        from 
            products p
            left join 
            products_sales ps
            on p.product_id = ps.product_id
        order by products_sales desc

)

select * from final