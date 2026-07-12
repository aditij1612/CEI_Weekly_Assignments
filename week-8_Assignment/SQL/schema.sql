-- Create Orders Table
CREATE TABLE orders(
order_id INTEGER PRIMARY KEY,
customer_id INTEGER,
order_date TEXT,
status TEXT,
region_code TEXT
);

-- Create Order Items Table
CREATE TABLE order_items(
item_id INTEGER PRIMARY KEY,
order_id INTEGER,
product_id INTEGER,
quantity INTEGER,
unit_price REAL,
discount_percent REAL
);

-- Create Products Table
CREATE TABLE products(
product_id INTEGER PRIMARY KEY,
product_name TEXT,
category TEXT,
subcategory TEXT,
cost_price REAL
);

-- Create Customers Table
CREATE TABLE customers(
customer_id INTEGER PRIMARY KEY,
customer_name TEXT,
email TEXT,
registration_date TEXT,
customer_type TEXT
);
