# Case Study 1: Data Mart Analysis  
**Skills Demonstrated:**
- **SQL:** Data Cleansing, Aggregation, Window Functions, Case Statements
- **Data Analysis:** Demographics, Sales Trends, Platform Performance

## Overview  
This project focuses on analyzing weekly sales data for **Data Mart**, a sustainable business model. Using SQL, I performed data cleansing, exploration, and insights generation to help optimize decision-making processes.

---

## Project Details  

### Business Problem  
Data Mart wanted to:  
- Clean and preprocess their raw weekly sales data.  
- Identify missing week numbers.  
- Analyze sales trends by regions, platforms, and demographics.  
- Derive actionable insights to drive business growth.

---

## Dataset Schema  
The dataset includes the following table:  

### **Weekly Sales Table**  

| **Column**          | **Description**                                |  
|----------------------|-----------------------------------------------|  
| `week_date`          | Date of the sales week                        |  
| `region`             | Geographic region                             |  
| `platform`           | Sales platform (e.g., Retail, Shopify)        |  
| `segment`            | Customer segment                              |  
| `customer_type`      | Type of customer (e.g., new, returning)       |  
| `transactions`       | Number of transactions                        |  
| `sales`              | Total sales amount                            |  



![image](https://github.com/user-attachments/assets/074b5055-44bf-48ef-b98f-535c4f37e4f8)


---

## Operations Performed  

### **1. Data Cleansing**  
SQL Code:  
```sql  
create table clean_weekly_sales as
select week_date, week(week_date) as week_number, month(week_date) as month_number,
year(week_date) as calender_year, region, platform,
case when segment = 'null' then 'Unknown'
        else segment
        end as segment,
case when right(segment, 1) = '1' then 'Young Adults'
	when right(segment, 1) = '2' then 'MiddleAged'
    when right(segment, 1) in ('3','4') then 'Retirees'
    else 'unknown'
    end as age_band,
case when left(segment, 1) = 'c' then 'Couples'
	when left(segment, 1) = 'f' then 'Families'
    else 'unknown'
    end as demographic,
customer_type, transactions, sales, round(sales/transactions,2) as avg_transaction
from weekly_sales;
select * from clean_weekly_sales limit 10;
```
Output:
- A cleaned table with consistent data for analysis.
- Added derived columns: week_number, month_number, calender_year, age_band, demographic, and avg_transaction.

![image](https://github.com/user-attachments/assets/6756da43-4c9c-45aa-8ba3-db405df9b1a1)

---
### **2. Data Exploration**

#### 1. Which week numbers are missing from the dataset?
SQL Code: 
```sql
create table seq100(x int auto_increment primary key);
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 select x+50 from seq100;

create table seq52 as select x from seq100 limit 52;
select * from seq52;
select distinct x as week_day
from seq52 where x not in (select distinct week_number from clean_weekly_sales);
select distinct week_number from clean_weekly_sales;
```

Output:
- A list of missing weeks in the dataset.

![image](https://github.com/user-attachments/assets/91f42d07-a43f-458f-bd9f-4091ba0a8301)


#### 2. How many total transactions were there for each year in the dataset?

SQL Code: 
```sql
select calender_year, sum(transactions) as total_transactions
from clean_weekly_sales
group by calender_year;
```

Output:
- Yearly transaction counts.

![image](https://github.com/user-attachments/assets/e99b713b-0cd2-4dae-81e4-55d7393db72b)


#### 3. total sales for each region each month

SQL Code: 
```sql
select region, month_number, sum(sales) as total_sales
from clean_weekly_sales
group by region, month_number;
```

Output:
- Monthly sales trends by region.

![image](https://github.com/user-attachments/assets/cc447ca7-2774-4afc-a489-9ee39eeace73)


#### 4. what is the total count of transactions for each platform?

SQL Code: 
```sql
select platform, sum(transactions) as total_no_transaction
from clean_weekly_sales
group by platform;
````

Output:
- Total transactions for each sales platform (e.g., Retail vs Shopify).

![image](https://github.com/user-attachments/assets/dc30815d-b379-4f09-a095-0ae9b02cd814)


#### 5. what is the percentage of sales for retail vs shopify for each month ?

SQL Code: 
```sql
with monthly_platform_sales as 
(select month_number, calender_year, platform, sum(sales) as monthly_sales
from clean_weekly_sales
group by month_number, calender_year, platform)

select month_number, calender_year,
round(100*max( case when platform = 'retail' then monthly_sales
				else null end ) / sum(monthly_sales),2) as retail_percentage,
round(100*max( case when platform = 'shopify' then monthly_sales
				else null end ) / sum(monthly_sales),2) as shopify_percentage
from monthly_platform_sales
group by month_number, calender_year;
```

Output:
- Monthly sales percentage for Retail and Shopify.

![image](https://github.com/user-attachments/assets/e224b362-e377-42b8-af45-7db91769cc0b)


#### 6. What is the percentage of sales by demographic for each year in the dataset?

SQL Code: 
```sql
select calender_year, demographic, sum(sales)as yearly_sales,
round(100* sum(sales)/ sum(sum(sales)) over (partition by demographic),2) as percentage
from clean_weekly_sales
group by calender_year, demographic
order  by calender_year;
```

Output:
- Yearly sales contributions by demographic.

![image](https://github.com/user-attachments/assets/0ce69831-5d9d-4abb-9a13-05e76c37b3d6)


#### 7. which age band and demographic values contribute the most to retail sales?

SQL Code: 
```sql
select age_band, demographic, sum(sales) as total_sales
from clean_weekly_sales
where platform = 'retail'
group by age_band, demographic
order by total_sales desc;
```

Output:
- Top contributing demographic for retail sales.

![image](https://github.com/user-attachments/assets/61b3e34a-66d5-4d45-b26d-de845bdc8d10)

---

**Skills Demonstrated:**
- **SQL:** Data Cleansing, Aggregation, Window Functions, Case Statements
- **Data Analysis:** Demographics, Sales Trends, Platform Performance




