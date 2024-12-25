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

![Dataset Schema Image](#)  

---

## Operations Performed  

#### 1. Total Quantity Sold for All Products 
SQL Code:  
```sql  

```


#### 2. What is the total generated revenue for all products before discounts?
SQL Code:  
```sql  

```

#### 3. What was the total discount amount for all products?
SQL Code:  
```sql  

```

#### 4. How many unique transactions were there?
SQL Code:  
```sql  

```

#### 5. What are the average unique products purchased in each transaction?
SQL Code:  
```sql  

```

#### 6. What is the average discount value per transaction?
SQL Code:  
```sql  

```

#### 7. What is the average revenue for member transactions and nonmember transactions?
SQL Code:  
```sql  

```

#### 8. What are the top 3 products by total revenue before discount?
SQL Code:  
```sql  

```

#### 9. What are the total quantity, revenue and discount for each segment?
SQL Code:  
```sql  

```

#### 10. What is the top selling product for each segment?
SQL Code:  
```sql  

```

#### 11. What are the total quantity, revenue and discount for each category?
SQL Code:  
```sql  

```

#### 12. What is the top selling product for each category?
SQL Code:  

```sql  

```
