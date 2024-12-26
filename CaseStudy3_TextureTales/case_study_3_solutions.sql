use case3;

#### 1
select details.product_name, sum(sales.qty) as sales_count
from sales join product_details as details
on sales.prod_id = details.product_id
group by details.product_name
order by sales_count desc;

#### 2
select sum(price * qty) as revenue_before_discount
from sales;

#### 3
select sum(price * qty * discount)/100  as total_discount
from sales;

#### 4
select  count( distinct txn_id) as transactions
from sales;

#### 5
with cte as (
select txn_id, count(distinct prod_id) as product_count
from sales
group by txn_id)
select round(avg(product_count)) as 'avg unique products'
from cte;


#### 6
with cte_1 as (
select txn_id, sum(price * qty *discount)/100 as discount
from sales
group by txn_id)
select round(avg(discount)) as 'avg discount'
from cte_1;

#### 7
with cte_2 as (
select member, txn_id, sum(price*qty) as revenue
from sales
group by member, txn_id)
select member, round(avg(revenue),2) as avg_revenue
from cte_2
group by member;

#### 8
select d.product_name, sum(qty * sales.price) as revenue_before_discount
from sales join product_details d
on sales.prod_id = d.product_id
group by d.product_name
order by revenue_before_discount
limit 3;

#### 9
select d.segment_id, d.segment_name, sum(sales.qty) as total_qty, 
sum(qty * sales.price) as total_revenue, sum(qty * sales.price * discount)/100 as total_discount
from sales join product_details d
on sales.prod_id = d.product_id
group by d.segment_id, d.segment_name;

#### 10
select d.segment_id, d.segment_name, d.product_id, d.product_name, 
sum(sales.qty) as product_qty
from sales join product_details d
on sales.prod_id = d.product_id
group by 1,2,3,4
order by product_qty desc;

#### 11
select p.category_name, sum(qty) as total_qty, sum(qty * sales.price) as total_revenue,
sum(qty * sales.price * discount)/100  as total_discount
from sales join product_details p
on sales.prod_id = p.product_id
group by p.category_name;

#### 12
with cte as (select p.category_name, p.product_name, sum(sales.qty) as total_qty
from product_details p join sales
on p.product_id = sales.prod_id
group by 1,2
order by total_qty desc), cte_1 as (
select category_name, product_name, total_qty, rank() over (partition by category_name order by total_qty desc) as 'ranking'
from cte)
select * from cte_1
where ranking =1;










