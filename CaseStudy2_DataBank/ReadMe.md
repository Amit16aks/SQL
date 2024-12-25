# Case Study 2: Data Bank Analysis  

**Skills Demonstrated**
- **Advanced SQL:** CTEs, Aggregations, Joins, Analytical Functions
- **Data Analysis:** Customer Transactions, Network Nodes
- **Business Insights:** Regional Distribution, Transaction Trends

## Overview  
This project dives into the operations of **Data Bank**, a Neo-Bank linking customer account balances with cloud storage allocations. Using SQL, I analyzed the bank’s network structure, customer transactions, and node transitions to derive actionable insights for business optimization.

---

## Dataset  

📂 **Download the Dataset**:  
You can download the dataset from the repository:  
- DDL & CSV --> [Data Bank Dataset](https://github.com/Amit16aks/SQL/tree/main/CaseStudy2_DataBank/Datasets)  

---

## Project Details  

### Business Problem  
**Data Bank** aimed to:  
- Understand its network structure at regional and node levels.  
- Analyze customer behavior based on transaction types and amounts.  
- Calculate customer transition times between nodes.  
- Explore deposit patterns and multi-transaction activity.

---

## Dataset Schema  
The dataset includes the following tables:  

### **Regions Table**  
| **Column**    | **Description**                  |  
|---------------|----------------------------------|  
| `region_id`   | Unique identifier for each region |  
| `region_name` | Name of the region               |  

### **Customer Nodes Table**  
| **Column**    | **Description**                                     |  
|---------------|-----------------------------------------------------|  
| `customer_id` | Unique identifier for each customer                 |  
| `region_id`   | Identifier of the region where the customer resides |  
| `node_id`     | Node identifier                                     |  
| `start_date`  | Start date of the node assignment                   |  
| `end_date`    | End date of the node assignment                     |  

### **Customer Transactions Table**  
| **Column**    | **Description**                                     |  
|---------------|-----------------------------------------------------|  
| `customer_id` | Unique identifier for each customer                 |  
| `txn_date`    | Date of the transaction                             |  
| `txn_type`    | Type of transaction (e.g., deposit, withdrawal)     |  
| `txn_amount`  | Amount of the transaction                           |  

SQL Code:  
```sql
SELECT * FROM case2.regions;
```
**Regions Table**

![image](https://github.com/user-attachments/assets/d3d1d4bf-673b-4366-ac33-7bcac1fc30af)

SQL Code:  
```sql
SELECT * FROM case2.customer_nodes;
```
**Customer Nodes Table** 

![image](https://github.com/user-attachments/assets/ed5c6a84-9526-4b9c-91c1-df36ad992eca)

SQL Code:  
```sql
SELECT * FROM case2.customer_nodes;
```
**Customer Transactions Table** 

![image](https://github.com/user-attachments/assets/6cbbd818-443d-4b6d-8031-5ba1dee33956)

---

## Operations Performed  
---
### **Data Exploration**


#### 1.	How many different nodes make up the Data Bank network?

SQL Code: 
```sql
select count(distinct node_id) as unique_nodes
from customer_nodes;
```

**Output:**
- Total number of unique nodes in the Data Bank network.

![image](https://github.com/user-attachments/assets/5d51b133-fa5a-4fc7-a6bb-998c893be4d3)



#### 2.	How many nodes are there in each region?

SQL Code: 
```sql
select region_id, count(node_id) as node_count
from customer_nodes join regions
using(region_id)
group by region_id;
```

**Output:**
- Count of nodes per region.

![image](https://github.com/user-attachments/assets/d6e2f643-c681-41ad-b8db-4a6b070cbcc5)


#### 3.	How many customers are divided among the regions?

SQL Code: 
```sql
select region_id, count(distinct customer_id) as customers
from customer_nodes join regions
using(region_id)
group by region_id;
```

**Output:**
- Number of customers per region.

![image](https://github.com/user-attachments/assets/3e7e9d86-44c2-456a-9152-5e269f910e1c)


#### 4.	Determine the total amount of transactions for each region name.

SQL Code: 
```sql
select region_name, sum(txn_amount) as total_transaction
from customer_transactions join customer_nodes
using(customer_id)
join regions using(region_id)
group by region_name;
```

**Output:**

- Total transaction amount for each region.

![image](https://github.com/user-attachments/assets/36ce65f9-3efa-41fb-9a31-492bc8d7ea8c)


#### 5.	How long does it take on an average to move clients to a new node?

SQL Code: 
```sql
select round(avg(datediff(end_date, start_date)),2) as average_days
from customer_nodes
where end_date <> '9999-12-31';
```

**Output:**

- Average number of days customers spend on a node before transitioning.

![image](https://github.com/user-attachments/assets/dc32f571-0333-4660-bf63-624de9ab83de)


#### 6.	What is the unique count and total amount for each transaction type?

SQL Code: 
```sql
select txn_type, count(*) as unique_count, sum(txn_amount) as total_amount 
from customer_transactions
group by txn_type;
```

**Output:**

- Count and total amount for each transaction type.

![image](https://github.com/user-attachments/assets/b969c169-bb0d-4643-bbb3-033c840bf568)


#### 7.	What is the average number and size of past deposits across all customers?

SQL Code: 
```sql
select round(count(customer_id)/ (select count(distinct customer_id) from customer_transactions))as avg_no_of_deposits,
sum(txn_amount) / count(txn_amount) as avg_size_of_deposits
from customer_transactions
where txn_type = 'deposit';
```

**Output:**

- Average number and size of deposits across all customers.

![image](https://github.com/user-attachments/assets/8f60e936-453f-4006-9ddd-3359e52b378e)


#### 8.	For each month - how many Data Bank customers make more than 1 deposit and at least either 1 purchase or 1 withdrawal in a single month?

SQL Code: 
```sql
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
```

**Output:**

- Number of customers performing multiple transactions in each month.

![image](https://github.com/user-attachments/assets/b644d1aa-76ea-464b-a50c-cb1b3f89df44)


---

#### **Skills Demonstrated**

- **Advanced SQL:** CTEs, Aggregations, Joins, Analytical Functions
- **Data Analysis:** Customer Transactions, Network Nodes
- **Business Insights:** Regional Distribution, Transaction Trends
