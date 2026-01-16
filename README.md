#  Inventory and Order Management System

## Project Overview
This project is an SQL capstone for **Module 3 (NSS)**. It implements an **Inventory and Order Management System** for an e-commerce company using **PostgreSQL**. The system manages customers, products, inventory, and orders, and supports business analytics through advanced SQL queries.

---

## Objectives
- Design a **normalized relational database (3NF)**
- Implement the schema using **SQL DDL**
- Populate the database with realistic sample data
- Write **business KPI queries** and **analytical queries**
- Create **views** and **stored procedures** for performance and integrity

---

##  Database Design
The database consists of the following tables:
- **Customers** – stores customer information
- **Products** – stores product details
- **Inventory** – tracks available stock for each product
- **Orders** – stores order-level information
- **Order_Items** – bridge table linking orders and products

An ERD diagram is included to show relationships and cardinality.

---

## 🛠 Technologies Used
- PostgreSQL
- SQL (DDL & DML)
- dbdiagram.io (ERD design)
- Git & GitHub

---

---

##  Key Features
- Data integrity enforced using **primary keys, foreign keys, and constraints**
- Business KPIs:
  - Total revenue
  - Top customers by spending
  - Best-selling products
  - Monthly sales trends
- Analytical queries using **window functions**
- **CustomerSalesSummary** view for performance optimization
- **ProcessNewOrder** stored procedure to safely handle inventory updates

---


