# Retail Sales SQL Analysis Project

## 📌 Project Overview

This project analyzes retail sales data using SQL to answer business questions and generate insights from customer transactions. The dataset contains information about sales transactions, customers, product categories, quantities sold, and revenue generated.

The goal of this project is to demonstrate SQL skills including:

* Data Cleaning
* Data Exploration
* Aggregate Functions
* Grouping and Filtering
* Window Functions
* Business Intelligence Queries
* Customer and Sales Analysis

---

## 🛠️ Technologies Used

* PostgreSQL
* SQL

---

## 📂 Database Schema

### Table: `retail_sales`

| Column Name     | Data Type         |
| --------------- | ----------------- |
| transactions_id | INT (Primary Key) |
| sale_date       | DATE              |
| sale_time       | TIME              |
| customer_id     | INT               |
| gender          | VARCHAR(15)       |
| age             | INT               |
| category        | VARCHAR(16)       |
| quantiy         | INT               |
| price_per_unit  | FLOAT             |
| cogs            | FLOAT             |
| total_sale      | FLOAT             |

---

## 📊 Data Cleaning

### Check Null Values

```sql
SELECT *
FROM retail_sales
WHERE total_sale IS NULL;
```

### Remove Null Records

```sql
DELETE FROM retail_sales
WHERE total_sale IS NULL;
```

---

## 🔍 Data Exploration

### Total Number of Sales

```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales;
```

### Total Number of Customers

```sql
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;
```

### Total Product Categories

```sql
SELECT COUNT(DISTINCT category)
FROM retail_sales;
```

---

## 📈 Business Questions & Solutions

### 1. Sales Made on 5th November 2022

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

### 2. Clothing Transactions with Quantity Greater Than 4 During November 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >= 4;
```

---

### 3. Total Sales by Category

```sql
SELECT
    category,
    SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;
```

---

### 4. Average Age of Customers Purchasing Beauty Products

```sql
SELECT
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### 5. Transactions with Sales Greater Than 1000

```sql
SELECT transactions_id
FROM retail_sales
WHERE total_sale > 1000;
```

---

### 6. Number of Transactions by Gender and Category

```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

---

### 7. Best Selling Month in Each Year

```sql
SELECT
    year,
    month,
    avg_sale
FROM
(
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1,2
) AS t1
WHERE rank = 1;
```

---

### 8. Top 5 Customers by Total Sales

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 9. Unique Customers by Category

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

## 📌 Key Insights

* Identified top-performing customers based on revenue generation.
* Analyzed category-wise sales performance.
* Measured customer purchasing behavior across categories.
* Determined the best-performing month for each year.
* Evaluated demographic trends using customer age and gender.

---

## 🚀 Future Improvements

* Create interactive dashboards using Power BI or Tableau.
* Add customer segmentation analysis.
* Perform sales forecasting using Machine Learning.
* Build KPI dashboards for business decision-making.

---

## 👨‍💻 Author

**Sandeep**

Aspiring Data Scientist | SQL Analyst | Generative AI Enthusiast

