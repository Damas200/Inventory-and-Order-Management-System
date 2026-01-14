`-- =============================================
-- Inventory and Order Management System
-- Author: Damas NIYONKURU 
-- Date: January 06, 2026
-- =============================================

CREATE DATABASE inventory_db;

-- Clean up existing Database if they exist
-- DROP DATABASE IF EXISTS inventory_db;

-- Clean up existing tables if they exist 
-- DROP TABLE IF EXISTS Order_Items CASCADE;
-- DROP TABLE IF EXISTS Orders CASCADE; 
-- DROP TABLE IF EXISTS Inventory CASCADE;
-- DROP TABLE IF EXISTS Products CASCADE;
-- DROP TABLE IF EXISTS Customers CASCADE;


-- =====================================
-- 2. DDL COMMENTS – TABLE CREATION
-- =====================================================


-- TABLE: customers
-- Purpose:
-- Stores all customer-related information.
-- Each customer can place multiple orders.
-- =====================================================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,        -- Unique identifier for each customer
    full_name VARCHAR(100) NOT NULL,        -- Customer full name (required)
    email VARCHAR(100) UNIQUE NOT NULL,     -- Email must be unique and not null
    phone VARCHAR(20),                      -- Optional phone number
    shipping_address TEXT                  -- Address used for shipping orders
);


-- =====================================================
-- TABLE: products
-- Purpose:
-- Stores all products sold by the e-commerce company.
-- =====================================================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,          -- Unique product identifier
    product_name VARCHAR(100) NOT NULL,     -- Name of the product
    category VARCHAR(50) NOT NULL,           -- Product category (Electronics, Apparel, etc.)
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
        -- Product price must always be non-negative
);


-- =====================================================
-- TABLE: inventory
-- Purpose:
-- Tracks current stock levels for each product.
-- Inventory is separated from products to avoid redundancy
-- and allow future scalability.
-- =====================================================
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,             -- One-to-one relationship with products
    quantity_on_hand INT NOT NULL CHECK (quantity_on_hand >= 0),
        -- Stock quantity cannot be negative
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);


-- =====================================================
-- TABLE: orders
-- Purpose:
-- Stores high-level order information.
-- Each order belongs to exactly one customer.
-- =====================================================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,             -- Unique order identifier
    customer_id INT NOT NULL,                -- Customer who placed the order
    order_date DATE NOT NULL,                -- Date when order was placed
    total_amount DECIMAL(10,2),              -- Total order value
    order_status VARCHAR(20) NOT NULL,       -- Pending, Shipped, Delivered
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- =====================================================
-- TABLE: order_items
-- Purpose:
-- Bridge table to resolve the many-to-many relationship
-- between orders and products.
-- Also stores historical price at time of purchase.
-- =====================================================
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,        -- Unique row identifier
    order_id INT NOT NULL,                   -- Associated order
    product_id INT NOT NULL,                 -- Product in the order
    quantity INT NOT NULL CHECK (quantity > 0),
        -- Quantity must be greater than zero
    price_at_purchase DECIMAL(10,2) NOT NULL CHECK (price_at_purchase >= 0),
        -- Historical price (important for accurate revenue reporting)
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);







