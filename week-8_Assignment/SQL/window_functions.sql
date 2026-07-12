-- Query 7: Running Total Revenue
WITH daily AS(
SELECT o.region_code,
date(o.order_date) AS order_date,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS daily_revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.region_code,date(o.order_date)
)
SELECT region_code,order_date,daily_revenue,
SUM(daily_revenue) OVER(PARTITION BY region_code ORDER BY order_date) AS running_total
FROM daily;

-- Query 8: Product Ranking
SELECT p.category,p.product_name,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS total_revenue,
DENSE_RANK() OVER(
PARTITION BY p.category
ORDER BY SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) DESC
) AS rank_in_category
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.category,p.product_name;

-- Query 9: LAG Analysis
SELECT customer_id,
order_date,
LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
julianday(order_date)-julianday(
LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)
) AS days_gap
FROM orders;

-- Query 11: Customer Quartiles
WITH cte AS(
SELECT o.customer_id,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS total_value
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.customer_id
)
SELECT customer_id,total_value,
NTILE(4) OVER(ORDER BY total_value DESC) AS quartile
FROM cte;

-- Query 12: Year-over-Year Revenue
WITH rev AS(
SELECT strftime('%Y',order_date) AS yr,
strftime('%m',order_date) AS mn,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY yr,mn
)
SELECT r1.yr,r1.mn,r1.revenue,
r2.revenue AS prev_year_revenue
FROM rev r1
LEFT JOIN rev r2
ON r1.mn=r2.mn AND r1.yr=r2.yr+1;

-- Query 13: First and Last Purchased Category
WITH x AS(
SELECT o.customer_id,p.category,o.order_date,
FIRST_VALUE(p.category) OVER(PARTITION BY o.customer_id ORDER BY o.order_date) AS first_category,
LAST_VALUE(p.category) OVER(
PARTITION BY o.customer_id
ORDER BY o.order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_category
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
)
SELECT DISTINCT customer_id,first_category,last_category,
CASE WHEN first_category<>last_category THEN 'Yes' ELSE 'No' END AS category_shift
FROM x;

-- Query 14: Cumulative Distribution
WITH rev AS(
SELECT o.customer_id,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.customer_id
)
SELECT customer_id,revenue,
SUM(revenue) OVER(ORDER BY revenue DESC) AS cumulative_revenue,
ROUND(
SUM(revenue) OVER(ORDER BY revenue DESC)*100.0/
SUM(revenue) OVER(),2
) AS cumulative_percent
FROM rev;

-- Query 16: Frequently Bought Together
SELECT oi1.product_id AS product_a,
oi2.product_id AS product_b,
COUNT(*) AS times_bought_together
FROM order_items oi1
JOIN order_items oi2