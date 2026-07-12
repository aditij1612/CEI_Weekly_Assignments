## Data Analytics System

## Overview
This project is an end-to-end data analytics mini project that demonstrates data generation, data cleaning, SQL analysis, and Python-SQL integration using an e-commerce dataset.

The project simulates a real-world online order processing system where raw data contains missing values, formatting issues, invalid records, and referential integrity problems. The data is cleaned and analyzed to generate meaningful business insights.

---

## Technologies Used

- Python 3
- SQLite
- Pandas
- Google Colab
- SQL (SQLite)

---

## Project Structure

```
├── orders.csv
├── order_items.csv
├── products.csv
├── customers.csv
│
├── orders_cleaned.csv
├── order_items_cleaned.csv
├── products_cleaned.csv
├── customers_cleaned.csv
│
├── ecommerce.db
├── data_generation.ipynb
├── data_cleaning.ipynb
├── sql_analysis.ipynb
├── command_line_tool.ipynb
├── test_cases.ipynb
└── README.md
```

---

## Project Phases

### Phase 1 – Data Generation

Generated four CSV files containing sample e-commerce data.

- Orders
- Order Items
- Products
- Customers

Intentional data issues were introduced, including:

- Missing customer IDs
- Invalid email addresses
- Incorrect date formats
- Negative quantities (returns)
- Extra spaces and mixed-case product names

---

### Phase 2 – Data Cleaning

Implemented Python functions to clean the datasets.

Tasks performed:

- Fixed invalid date formats
- Handled missing customer IDs
- Standardized product names
- Validated customer emails
- Checked referential integrity
- Generated cleaned CSV files

---

### Phase 3 – SQL Analysis

Performed business analysis using SQLite.

Implemented SQL queries for:

- Revenue by category
- Top 10 customers
- Monthly order count
- Customers with no delivered orders
- Return rate analysis
- Running totals
- Product ranking
- LAG/LEAD analysis
- CTEs
- NTILE segmentation
- Year-over-Year comparison
- Cohort analysis
- Frequently bought together products

---

### Phase 4 – Python + SQLite Integration

Developed a command-line reporting tool that:

- Accepts report type (Daily / Weekly / Monthly)
- Accepts a date range
- Connects to SQLite
- Displays:
  - Total Orders
  - Total Revenue
  - Unique Customers
  - Top 3 Products
  - Comparison with Previous Period

---

### Phase 5 – Edge Case Testing

Implemented test cases for:

- Invalid order IDs
- Discount greater than 100%
- Zero quantity
- Future order dates

---

## Database Schema

### Orders

- order_id
- customer_id
- order_date
- status
- region_code

### Order Items

- item_id
- order_id
- product_id
- quantity
- unit_price
- discount_percent

### Products

- product_id
- product_name
- category
- subcategory
- cost_price

### Customers

- customer_id
- customer_name
- email
- registration_date
- customer_type

---

## Features

- Fake data generation
- Data cleaning and validation
- SQLite database integration
- Advanced SQL queries
- Window functions
- Common Table Expressions (CTEs)
- Command-line reporting tool
- Edge case testing

---

## How to Run

### 1. Install dependencies

```bash
pip install pandas
```

(SQLite comes pre-installed with Python.)

### 2. Generate sample data

Run the Data Generation notebook.

### 3. Clean the data

Run the Data Cleaning notebook.

### 4. Create SQLite database

Load the cleaned CSV files into SQLite.

### 5. Execute SQL Analysis

Run all SQL queries from the SQL Analysis notebook.

### 6. Run the Reporting Tool

Execute the Python command-line tool.

Example:

```
Report Type (daily/weekly/monthly): monthly
Start Date: 2025-01-01
End Date: 2025-01-31
```

---

## Sample Output

```
========== REPORT ==========

Report Type : Monthly

Date Range : 2025-01-01 to 2025-01-31

Total Orders : 152

Total Revenue : 248950.50

Unique Customers : 115

Top 3 Products

1. Laptop
2. Smartphone
3. Headphones

Comparison with Previous Period

Orders Change : 8.32%

Revenue Change : 12.45%

Customers Change : 6.18%
```

---

## Learning Outcomes

This project demonstrates:

- Data preprocessing
- Data validation
- SQL joins
- Aggregations
- Window Functions
- CTEs
- Ranking functions
- Python-SQL integration
- Business reporting
- Data analytics workflow

---

## Future Improvements

- Interactive dashboard using Streamlit
- Automated ETL pipeline
- Power BI/Tableau integration
- Scheduled report generation
- Email report delivery
- Cloud database support

---

## Author

**Your Name**

Intern Mini Project – E-Commerce Order Analytics System
