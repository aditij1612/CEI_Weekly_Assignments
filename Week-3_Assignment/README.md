# Week 3 Assignment – Sales Analysis Using SQL

## Project Overview

This project analyzes the **Sample Superstore Dataset** using PostgreSQL. The objective is to apply SQL concepts such as **Subqueries**, **Common Table Expressions (CTEs)**, **Window Functions**, and **Joins** to solve business-related sales analysis problems.

The project demonstrates how SQL can be used to transform raw transactional data into meaningful business insights.

---

## Objectives

* Import and manage sales data in PostgreSQL.
* Normalize the dataset into separate tables.
* Use Subqueries to perform advanced filtering.
* Use CTEs for reusable aggregations.
* Apply Window Functions for ranking and analytical operations.
* Generate customer sales insights for business decision-making.

---

## Dataset Information

**Dataset:** Sample Superstore Dataset

**Rows:** 9,994

**Columns:** 21

### Key Attributes

* Order ID
* Order Date
* Customer ID
* Customer Name
* Product ID
* Product Name
* Category
* Sales
* Quantity
* Discount
* Profit
* Region

---

## Technologies Used

* PostgreSQL
* pgAdmin 4
* SQL
* GitHub

---

## Database Design

### Source Table

```sql
superstore_raw
```

### Normalized Tables

#### Customers

Contains unique customer information.

```sql
customers
```

#### Orders

Contains order-related information.

```sql
orders
```

#### Products

Contains product details.

```sql
products
```

---

## Tasks Performed

### Data Preparation

* Imported Superstore dataset into PostgreSQL.
* Created normalized tables:

  * Customers
  * Orders
  * Products
* Populated tables using `SELECT DISTINCT`.

### SQL Analysis

#### Subqueries

1. Orders with sales greater than average sales.
2. Highest sales order for each customer.

#### Common Table Expressions (CTEs)

3. Total sales per customer.
4. Customers with above-average total sales.

#### Window Functions

5. Rank customers based on total sales.
6. Assign row numbers to orders within each customer.
7. Identify top 3 customers by total sales.

#### Combined Query

8. Customer Name + Total Sales + Rank using:

   * JOIN
   * CTE
   * Window Function

---

## Business Questions Solved

### 1. Top 5 Customers

Identified customers generating the highest revenue.

### 2. Bottom 5 Customers

Identified customers contributing the least revenue.

### 3. Customers with Only One Order

Detected customers with a single purchase transaction.

### 4. Customers with Above-Average Sales

Identified high-value customers.

### 5. Highest Order Value Per Customer

Determined each customer's largest transaction.

---

## Key Insights

* A small percentage of customers contribute a large portion of overall revenue.
* Customer spending patterns vary significantly.
* Several customers placed only one order, indicating opportunities for retention strategies.
* High-value customers can be targeted for loyalty and marketing campaigns.
* Window functions provide efficient methods for customer ranking and sales analysis.

---

## SQL Concepts Demonstrated

* SELECT DISTINCT
* Aggregate Functions
* GROUP BY
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* ROW_NUMBER()
* RANK()
* JOIN Operations
* Data Normalization

---

## Conclusion

This project successfully demonstrates the use of PostgreSQL for sales data analysis. By applying Subqueries, CTEs, Window Functions, and Joins, meaningful customer and sales insights were extracted from the Superstore dataset. The analysis highlights the importance of SQL in supporting data-driven business decisions and customer performance evaluation.
