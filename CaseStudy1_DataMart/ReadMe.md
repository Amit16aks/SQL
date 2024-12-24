# Case Study 1: Data Mart Analysis  

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

---

## Operations Performed  

### **1. Data Cleansing**  
SQL Code:  
```sql  
CREATE TABLE clean_weekly_sales AS  
SELECT  
    week_date,  
    WEEK(week_date) AS week_number,  
    MONTH(week_date) AS month_number,  
    YEAR(week_date) AS calendar_year,  
    region,  
    platform,  
    CASE WHEN segment = 'null' THEN 'Unknown' ELSE segment END AS segment,  
    CASE  
        WHEN RIGHT(segment, 1) = '1' THEN 'Young Adults'  
        WHEN RIGHT(segment, 1) = '2' THEN 'MiddleAged'  
        WHEN RIGHT(segment, 1) IN ('3', '4') THEN 'Retirees'  
        ELSE 'Unknown'  
    END AS age_band,  
    CASE  
        WHEN LEFT(segment, 1) = 'c' THEN 'Couples'  
        WHEN LEFT(segment, 1) = 'f' THEN 'Families'  
        ELSE 'Unknown'  
    END AS demographic,  
    customer_type,  
    transactions,  
    sales,  
    ROUND(sales / transactions, 2) AS avg_transaction  
FROM weekly_sales;
```
Output:

A cleaned table with consistent data for analysis.
Added derived columns: week_number, month_number, calender_year, age_band, demographic, and avg_transaction.

