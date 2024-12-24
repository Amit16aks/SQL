create database if not exists case2;
use case2;
##1
select count(distinct node_id) as unique_nodes
from customer_nodes;

## 2
select region_id, count(node_id) as node_count
from customer_nodes join regions
using(region_id)
group by region_id;

## 3
select region_id, count(distinct customer_id) as customers
from customer_nodes join regions
using(region_id)
group by region_id;

## 4
select region_name, sum(txn_amount) as total_transaction
from customer_transactions join customer_nodes
using(customer_id)
join regions using(region_id)
group by region_name;

##Q4
select region_name, sum(txn_amount) as 'total transaction amount' from regions,customer_nodes,customer_transactions 
where regions.region_id=customer_nodes.region_id and customer_nodes.customer_id=customer_transactions.customer_id 
group by region_name;

## 5
select round(avg(datediff(end_date, start_date)),2) as average_days
from customer_nodes
where end_date <> '9999-12-31';

## 6 
select txn_type, count(*) as unique_count, sum(txn_amount) as total_amount 
from customer_transactions
group by txn_type;

## 7
select round(count(customer_id)/ (select count(distinct customer_id) from customer_transactions))as avg_no_of_deposits,
sum(txn_amount) / count(txn_amount) as avg_size_of_deposits
from customer_transactions
where txn_type = 'deposit';

## 8 

with cte as 
(select customer_id, month(txn_date) as txn_month, 
sum(if(txn_type = 'deposit',1,0)) as deposit_count,
sum(if(txn_type = 'withdrawal',1,0)) as withdrawal_count,
sum(if(txn_type = 'purchase',1,0)) as purchase_count
from customer_transactions
group by customer_id, month(txn_date))
select txn_month, count(distinct customer_id) as customer_count
from cte
where deposit_count > 1
and purchase_count = 1 or withdrawal_count = 1
group by txn_month;





