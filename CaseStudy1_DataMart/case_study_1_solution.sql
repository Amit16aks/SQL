use case1;

SELECT * FROM case1.weekly_sales limit 10;

## Data Cleansing
create table clean_weekly_sales as
select week_date, week(week_date) as week_number, month(week_date) as month_number,
year(week_date) as calender_year, region, platform, case when segment = 'null' then 'Unknown'
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


## Data Exploration

#1. which week numbers are missing from the dataset?

create table seq100(x int auto_increment primary key);
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 values (), (), (), (), (), (), (), (), (), ();
insert into seq100 select x+50 from seq100;

select * from seq100;

create table seq52 as select x from seq100 limit 52;
select * from seq52;
select distinct x as week_day
from seq52 where x not in (select distinct week_number from clean_weekly_sales);
select distinct week_number from clean_weekly_sales;

## 2. how many total transactions were there for each year in the dataset?

select calender_year, sum(transactions) as total_transactions
from clean_weekly_sales
group by calender_year;

## 3. total sales for each region each month

select region, month_number, sum(sales) as total_sales
from clean_weekly_sales
group by region, month_number;

## 4. what is the total count of transactions for each platform?

select platform, sum(transactions) as total_no_transaction
from clean_weekly_sales
group by platform;

## 5. what is the percentage of sales for retail vs shopify for each month ?

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

## 6. What is the percentage of sales by demographic for each year in the dataset?

select calender_year, demographic, sum(sales)as yearly_sales,
round(100* sum(sales)/ sum(sum(sales)) over (partition by demographic),2) as percentage
from clean_weekly_sales
group by calender_year, demographic
order  by calender_year;

## 7. which age band and demographic value s contribute the most to retail sales?

select age_band, demographic, sum(sales) as total_sales
from clean_weekly_sales
where platform = 'retail'
group by age_band, demographic
order by total_sales desc;


