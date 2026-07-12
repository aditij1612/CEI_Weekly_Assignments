
-- Query 10: Multi-Level CTE (Customer Segments)

WITH monthly_revenue AS(
SELECT
o.customer_id,
strftime('%Y-%m',o.order_date) AS month,
SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id,month
),
customer_segment AS(
SELECT
customer_id,
month,
revenue,
CASE
WHEN revenue>10000 THEN 'High'
WHEN revenue>=5000 THEN 'Medium'
ELSE 'Low'
END AS category
FROM monthly_revenue
)
SELECT
month,
category,
COUNT(*) AS customer_count
FROM customer_segment
GROUP BY month,category
ORDER BY month,category;

-- Query 15: Cohort Analysis

WITH cohort AS(
SELECT
customer_id,
strftime('%Y-%m',registration_date) AS cohort_month
FROM customers
),
activity AS(
SELECT
o.customer_id,
strftime('%Y-%m',o.order_date) AS order_month,
c.cohort_month,
(
CAST(strftime('%Y',o.order_date) AS INTEGER)-
CAST(strftime('%Y',c.cohort_month||'-01') AS INTEGER)
)*12+
(
CAST(strftime('%m',o.order_date) AS INTEGER)-
CAST(strftime('%m',c.cohort_month||'-01') AS INTEGER)
) AS month_number
FROM orders o
JOIN cohort c
ON o.customer_id=c.customer_id
)
SELECT
cohort_month,
COUNT(DISTINCT CASE WHEN month_number=0 THEN customer_id END) AS month0,
COUNT(DISTINCT CASE WHEN month_number=1 THEN customer_id END) AS month1,
COUNT(DISTINCT CASE WHEN month_number=2 THEN customer_id END) AS month2,
COUNT(DISTINCT CASE WHEN month_number=3 THEN customer_id END) AS month3,
ROUND(
COUNT(DISTINCT CASE WHEN month_number=1 THEN customer_id END)*100.0/
NULLIF(COUNT(DISTINCT CASE WHEN month_number=0 THEN customer_id END),0),2
) AS retention_month1,
ROUND(
COUNT(DISTINCT CASE WHEN month_number=2 THEN customer_id END)*100.0/
NULLIF(COUNT(DISTINCT CASE WHEN month_number=0 THEN customer_id END),0),2
) AS retention_month2,
ROUND(
COUNT(DISTINCT CASE WHEN month_number=3 THEN customer_id END)*100.0/
NULLIF(COUNT(DISTINCT CASE WHEN month_number=0 THEN customer_id END),0),2
) AS retention_month3
FROM activity
GROUP BY cohort_month
ORDER BY cohort_month;