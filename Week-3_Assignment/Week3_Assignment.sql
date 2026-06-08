
--Week 3 Assignment – Sales Analysis

--Sample Superstore Dataset consist of :
--Rows: 9994
--Columns: 21

CREATE TABLE superstore (
    row_id INTEGER,
    order_id VARCHAR(20),
    order_date TEXT,
    ship_date TEXT,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC,
    quantity INTEGER,
    discount NUMERIC,
    profit NUMERIC
);


--Customers table
CREATE TABLE customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore;

--Product Table
CREATE TABLE products AS
SELECT DISTINCT
    product_id,
    product_name,
    category,
    sub_category
FROM superstore;

--order table
CREATE TABLE orders AS
SELECT DISTINCT
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
FROM superstore;

--Queries

--1. Find all orders where sales are greater than the average sales. (Subquery) 
SELECT *
FROM superstore
WHERE sales >
(
    SELECT AVG(sales)
    FROM superstore
);

--2. Find the highest sales order for each customer. (Subquery) 
SELECT *
FROM superstore s
WHERE sales =
(
    SELECT MAX(sales)
    FROM superstore
    WHERE customer_id = s.customer_id
);

--3. Calculate total sales for each customer. (CTE)
WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_id, customer_name
)
SELECT *
FROM customer_sales;

--4. Find customers whose total sales are above average. (CTE + Subquery) 
WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_id, customer_name
)

SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);

--5. Rank all customers based on total sales. (Window Function) 
WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_id, customer_name
)

SELECT
    customer_id,
    customer_name,
    total_sales,
    RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales;

--6. Assign row numbers to each order within a customer. (Window Function + PARTITION BY)  
SELECT
    customer_id,
    customer_name,
    order_id,
    sales,
    ROW_NUMBER()
    OVER(
        PARTITION BY customer_id
        ORDER BY sales DESC
    ) AS row_num
FROM superstore;

--7. Display top 3 customers based on total sales. (Window Function)  
WITH customer_sales AS
(
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_id, customer_name
)

SELECT *
FROM
(
    SELECT
        customer_name,
        total_sales,
        RANK() OVER(ORDER BY total_sales DESC) AS rank_no
    FROM customer_sales
) x
WHERE rank_no <= 3;

--Final Combined Query(Use JOIN + CTE + Window Function together)
WITH customer_sales AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.sales) AS total_sales
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name
)

SELECT
    customer_name,
    total_sales,
    RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales
ORDER BY sales_rank;

--Mini Project: Customer Sales Insights 


--1. Who are the top 5 customers? 
WITH customer_sales AS
(
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 5;

--2. Who are the bottom 5 customers? 
WITH customer_sales AS
(
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales ASC
LIMIT 5;

--3. Which customers made only one order?  
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS orders_count
FROM superstore
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT order_id) = 1;

--4. Which customers have above-average sales? 
WITH customer_sales AS
(
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_name
)

SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);

--5. What is the highest order value per customer?
SELECT
    customer_id,
    customer_name,
    MAX(sales) AS highest_order_value
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY highest_order_value DESC;