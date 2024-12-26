# Case Study 3: Texture Tales  

**Skills Demonstrated:**  
- **SQL:** Data Aggregation, Joins, CTEs, Analytical Functions  
- **Data Analysis:** Sales Trends, Product Performance, Customer Segmentation  

---

## Overview  

**Texture Tales Clothing Company** is a trendy fashion business that provides an optimized range of clothing and lifestyle wear for modern adventurers. The CEO requested assistance in analyzing their sales performance and generating a financial report to share with the wider business.  

This project focuses on extracting insights into product sales, revenue generation, and customer behavior using SQL queries.

---

## Dataset  

📂 **Download the Dataset**:  
You can download the dataset from the repository:  
- DDL & CSV --> [Texture Tales Dataset](https://github.com/Amit16aks/SQL/tree/main/CaseStudy3_TextureTales/DataSets)  

---

## Dataset Schema  

### **Product Details Table**  
| **Column**      | **Description**                            |  
|------------------|--------------------------------------------|  
| `product_id`     | Unique identifier for each product         |  
| `price`          | Price of the product                      |  
| `product_name`   | Name of the product                       |  
| `category_id`    | Unique identifier for each category        |  
| `segment_id`     | Unique identifier for each segment         |  
| `style_id`       | Unique identifier for each style           |  
| `category_name`  | Name of the product category               |  
| `segment_name`   | Name of the product segment                |  
| `style_name`     | Name of the product style                  |  

### **Sales Table**  
| **Column**       | **Description**                            |  
|-------------------|--------------------------------------------|  
| `prod_id`         | Identifier for the product sold            |  
| `qty`            | Quantity of product sold                  |  
| `price`          | Sale price of the product                 |  
| `discount`       | Discount percentage applied               |  
| `member`         | Whether the customer is a member          |  
| `txn_id`         | Unique transaction identifier             |  
| `start_txn_time` | Start time of the transaction             |  

### **Product Hierarchy Table**  
| **Column**       | **Description**                            |  
|-------------------|--------------------------------------------|  
| `id`             | Unique identifier for the hierarchy record |  
| `product_id`     | Identifier for the product in the hierarchy|  
| `price`          | Price of the product in the hierarchy      |  
| `start_date`     | Start date of the product hierarchy record |  
| `end_date`       | End date of the product hierarchy record   |  

### **Product Prices Table**  
| **Column**       | **Description**                            |  
|-------------------|--------------------------------------------|  
| `id`             | Unique identifier for the price record     |  
| `product_id`     | Identifier for the product price record    |  
| `price`          | Price of the product                      |  

SQL Code:  
```sql  
SELECT * FROM case3.product_details
limit 10;
```

**Output: Product Details Table**

![image](https://github.com/user-attachments/assets/92ed2f47-5f4e-495f-90a4-41be856c6699)

SQL Code:  
```sql  
SELECT * FROM case3.sales
limit 10;
```

**Output: Sales Table**

![image](https://github.com/user-attachments/assets/98bdbe5d-7e4c-4b1a-b04a-7f891f725b62)

SQL Code:  
```sql  
SELECT * FROM case3.product_hierarchy
limit 10;
```

**Output: Product Hierarchy Table**

![image](https://github.com/user-attachments/assets/e5d8c6e1-5dd5-472d-84f6-89e161528236)

SQL Code:  
```sql  
SELECT * FROM case3.product_prices
limit 10;
```

**Output: Product Prices Table**

![image](https://github.com/user-attachments/assets/23564e5f-e43a-4428-ac42-1aab0bb40820)

---

## Operations Performed  

#### 1. Total Quantity Sold for All Products 
SQL Code:  
```sql  
select details.product_name, sum(sales.qty) as sales_count
from sales join product_details as details
on sales.prod_id = details.product_id
group by details.product_name
order by sales_count desc;
```

**Output:**

![image](https://github.com/user-attachments/assets/644e36a9-cff6-475d-b285-13acd71fd23a)


#### 2. What is the total generated revenue for all products before discounts?
SQL Code:  
```sql  
select sum(price * qty) as revenue_before_discount
from sales;
```

**Output:**

![image](https://github.com/user-attachments/assets/6ea12b2e-8b87-401d-b01d-f5988c1478bb)

#### 3. What was the total discount amount for all products?
SQL Code:  
```sql  
select sum(price * qty * discount)/100  as total_discount
from sales;
```

**Output:**

![image](https://github.com/user-attachments/assets/93578329-bfe6-432f-8b5d-97c9478d3b5d)

#### 4. How many unique transactions were there?
SQL Code:  
```sql  
select  count( distinct txn_id) as transactions
from sales;
```

**Output:**

![image](https://github.com/user-attachments/assets/624ed45c-68c6-4fb5-a158-370c1de4a1fd)

#### 5. What are the average unique products purchased in each transaction?
SQL Code:  
```sql  
with cte as (
select txn_id, count(distinct prod_id) as product_count
from sales
group by txn_id)
select round(avg(product_count)) as 'avg unique products'
from cte;
```

**Output:**

![image](https://github.com/user-attachments/assets/e5342de6-3fb5-479d-b838-c38315a373f2)

#### 6. What is the average discount value per transaction?
SQL Code:  
```sql  
with cte_1 as (
select txn_id, sum(price * qty *discount)/100 as discount
from sales
group by txn_id)
select round(avg(discount)) as 'avg discount'
from cte_1;
```

**Output:**

![image](https://github.com/user-attachments/assets/df9a0212-a518-4b26-826d-134b777d2ff0)

#### 7. What is the average revenue for member transactions and nonmember transactions?
SQL Code:  
```sql  
with cte_2 as (
select member, txn_id, sum(price*qty) as revenue
from sales
group by member, txn_id)
select member, round(avg(revenue),2) as avg_revenue
from cte_2
group by member;
```

**Output:**

![image](https://github.com/user-attachments/assets/3afcbf96-9e44-48a5-8a65-bb594a894a95)

#### 8. What are the top 3 products by total revenue before discount?
SQL Code:  
```sql  
select d.product_name, sum(qty * sales.price) as revenue_before_discount
from sales join product_details d
on sales.prod_id = d.product_id
group by d.product_name
order by revenue_before_discount
limit 3;
```

**Output:**

![image](https://github.com/user-attachments/assets/51f8a0a4-89b0-48c2-8607-7474c835edac)

#### 9. What are the total quantity, revenue and discount for each segment?
SQL Code:  
```sql  
select d.segment_id, d.segment_name, sum(sales.qty) as total_qty, 
sum(qty * sales.price) as total_revenue, sum(qty * sales.price * discount)/100 as total_discount
from sales join product_details d
on sales.prod_id = d.product_id
group by d.segment_id, d.segment_name;
```

**Output:**

![image](https://github.com/user-attachments/assets/70e106d3-c91c-48e8-a44b-1183d3e6f541)

#### 10. What is the top selling product for each segment?
SQL Code:  
```sql  
select d.segment_id, d.segment_name, d.product_id, d.product_name, 
sum(sales.qty) as product_qty
from sales join product_details d
on sales.prod_id = d.product_id
group by 1,2,3,4
order by product_qty desc;
```

**Output:**

![image](https://github.com/user-attachments/assets/e0617829-c2dd-4387-9179-28155d9ba28f)

#### 11. What are the total quantity, revenue and discount for each category?
SQL Code:  
```sql  
select p.category_name, sum(qty) as total_qty, sum(qty * sales.price) as total_revenue,
sum(qty * sales.price * discount)/100  as total_discount
from sales join product_details p
on sales.prod_id = p.product_id
group by p.category_name;
```

**Output:**

![image](https://github.com/user-attachments/assets/d83d175e-4e53-453b-ae8b-c09ec85a0461)

#### 12. What is the top selling product for each category?
SQL Code:  

```sql  
with cte as (select p.category_name, p.product_name, sum(sales.qty) as total_qty
from product_details p join sales
on p.product_id = sales.prod_id
group by 1,2
order by total_qty desc), cte_1 as (
select category_name, product_name, total_qty,
rank() over (partition by category_name order by total_qty desc) as 'ranking'
from cte)
select * from cte_1
where ranking =1;
```

**Output:**

![image](https://github.com/user-attachments/assets/c62ef8a4-77ff-4f9a-af91-25187fcb2cab)


### **Skills Demonstrated:**  
- **SQL:** Data Aggregation, Joins, CTEs, Analytical Functions  
- **Data Analysis:** Sales Trends, Product Performance, Customer Segmentation  
