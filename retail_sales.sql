--create table-
create table retail_sales(
					transactions_id	INT PRIMARY KEY,
					sale_date	DATE,
					sale_time	TIME,
					customer_id	 INT,
					gender VARCHAR(15),
					age INT,
					category VARCHAR(16),	
					quantiy INT,
					price_per_unit FLOAT,	
					cogs	FLOAT,
					total_sale FLOAT
);
--viewing overall data--
select *from retail_sales
limit 10
--count number of rows--
select count(*) from retail_sales
--checking null records--

select * from retail_sales
where total_sale is null
--deleting null values--
delete from retail_sales
where total_sale is null


--how many sales we have--
select count(*) as total_sale from retail_sales

--how many customers we have--
select count(distinct customer_id) from retail_sales

--how many categories we have --
select count(distinct category) from retail_sales


--data ananlysis & business key problems and answers--

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where (sale_date = '2022-11-05')

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select
*
from retail_sales
where category='Clothing'
	and
	to_char(sale_date,'YYYY-MM') ='2022-11'
	and 
	quantiy >=4
--Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
	category,
	sum(total_sale) as net_sale
	from retail_sales
	group by 1

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select
	round(avg(age),2) as average_age
	from retail_sales
	where category='Beauty'
--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select 
transactions_id from retail_sales
where total_sale>1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select
category,
gender,
count(*) as total_transaction
from retail_sales
group by category,gender
order by 1

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--**Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category