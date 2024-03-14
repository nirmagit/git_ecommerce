with products as (
    select * from {{ ref('stg_products') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

products_sales as (
    select p.product_id
           , count(o.order_id) as total_orders
           , sum(o.sales) as products_sales
           , sum(o.units) as sold_units
    from 
        products p
        join 
        orders o
        on p.product_id = o.product_id
    where o.status = 'Complete'
    group by 1
),
final as (
    select p.product_id
           , p.category
           , p.name as product_name
           , p.brand
           , p.department
           , p.sku
           , coalesce(ps.total_orders, 0) as total_orders
           , coalesce(ps.products_sales, 0) as products_sales
           , coalesce(ps.sold_units, 0) as sold_units
        from 
            products p
            left join 
            products_sales ps
            on p.product_id = ps.product_id
        order by products_sales desc

)

select * from final