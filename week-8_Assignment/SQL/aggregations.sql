-- Query 1
SELECT p.category,SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS total_revenue
FROM order_items oi JOIN products p ON oi.product_id=p.product_id GROUP BY p.category;

-- Query 2
SELECT o.customer_id,SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100.0)) AS total_value
FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.customer_id ORDER BY total_value DESC LIMIT 10;

-- Query 3
SELECT strftime('%Y-%m',order_date) month,COUNT(*) order_count
FROM orders WHERE order_date>=date('now','-12 months')
GROUP BY month ORDER BY month;

-- Query 4
SELECT DISTINCT customer_id FROM orders
WHERE customer_id NOT IN(SELECT customer_id FROM orders WHERE status='DELIVERED');

-- Query 5
SELECT p.product_name,
SUM(CASE WHEN oi.quantity<0 THEN ABS(oi.quantity) ELSE 0 END) returns,
SUM(CASE WHEN oi.quantity>0 THEN oi.quantity ELSE 0 END) purchases
FROM order_items oi JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_name HAVING returns>purchases;

-- Query 6
SELECT p.category,ROUND(SUM(CASE WHEN oi.quantity<0 THEN ABS(oi.quantity) ELSE 0 END)*100.0/SUM(ABS(oi.quantity)),2) return_rate
FROM order_items oi JOIN products p ON oi.product_id=p.product_id GROUP BY p.category;
