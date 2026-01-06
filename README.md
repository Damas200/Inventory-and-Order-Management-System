# Inventory and Order Management System – SQL Capstone Project

**Author:** Damas NIYONKURU  
**Date:** January 06, 2026  
**Course:** Database Systems / SQL

## Project Overview

This capstone project designs, implements, and queries a **fully normalized relational database** for an e-commerce company's **inventory and order management system**.

### Key Objectives Achieved
- Designed a **3NF-compliant** database schema with proper relationships
- Implemented DDL with primary/foreign keys, constraints, and data integrity rules
- Populated the database with realistic sample data (15 customers, 15 products, 20 orders)
- Wrote advanced SQL queries to answer real business questions (KPIs)
- Implemented window functions for analytical insights
- Created reusable views and a transactional stored procedure for order processing
- Demonstrated performance optimization and safe inventory management

## Database Schema (ERD Summary)

**Tables & Relationships**

- **Customers** (1) → (many) **Orders**
- **Orders** (1) → (many) **Order_Items** (bridge table)
- **Products** (1) → (many) **Order_Items**
- **Products** (1:1) **Inventory**

**Key Constraints**
- CHECK constraints on prices and quantities (≥ 0)
- NOT NULL on essential fields
- Composite primary key on Order_Items
- ON DELETE CASCADE for clean data removal

## Key Business Insights from Queries

1. **Total Revenue** from completed orders: ~$18,000+ (Shipped/Delivered)
2. **Top Customers**: Alice Johnson leads with multiple high-value electronics purchases
3. **Best-Selling Products**: Books and affordable apparel dominate by quantity sold
4. **Monthly Sales Trend**: Strong peak in December 2024 (holiday season)
5. **Category Rankings**: Clear leaders in Electronics (MacBook), Apparel (Adidas), Books (Da Vinci Code)
6. **Customer Behavior**: Some customers return within weeks (repeat buyers identified)


