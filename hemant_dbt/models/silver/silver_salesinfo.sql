with bronze_sales as (
    select
        sales_id,
        payment_method,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount,
        gross_amount
    from
        {{ ref('bronze_sales')}}
),
bronze_products as (
    select 
        product_sk,
        category
    from
        {{ ref('bronze_product')}}
),
customer as (
    select
        customer_sk,
        gender
    from
        {{ ref('bronze_customer')}}
),
joined_data as (
select
    sales.sales_id,
    sales.payment_method,
    sales.gross_amount,
    products.category,
    customer.gender
from
    bronze_sales as sales
    left join bronze_products as products on sales.product_sk = products.product_sk
    left join customer on sales.customer_sk = customer.customer_sk)
select
    category,
    gender,
    sum(gross_amount) as total_gross_amount
from
    joined_data
group by
    category,
    gender
