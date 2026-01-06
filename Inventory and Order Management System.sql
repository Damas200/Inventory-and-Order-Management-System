-- =============================================
-- Inventory and Order Management System
-- Author: Damas NIYONKURU 
-- Date: January 06, 2026
-- =============================================

DROP DATABASE IF EXISTS inventory_db;
CREATE DATABASE inventory_db;


-- Clean up existing tables if they exist 
DROP TABLE IF EXISTS Order_Items CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;

DROP VIEW IF EXISTS CustomerSalesSummary CASCADE;
DROP PROCEDURE IF EXISTS ProcessNewOrder(INT, INT, INT);

-- Customers
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    shipping_address VARCHAR(255)
);

-- Products
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

--  Inventory 
CREATE TABLE Inventory (
    product_id INTEGER PRIMARY KEY REFERENCES Products(product_id) ON DELETE CASCADE,
    quantity_on_hand INTEGER NOT NULL DEFAULT 0 CHECK (quantity_on_hand >= 0)
);

-- Orders
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES Customers(customer_id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'Pending'
        CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

-- Order Items (Bridge Table)
CREATE TABLE Order_Items (
    order_id INTEGER REFERENCES Orders(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES Products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

-- ========================================
-- 1. INSERT SAMPLE DATA
-- ========================================

-- Reset sequences to start from 1 (in case of previous runs)
ALTER SEQUENCE customers_customer_id_seq RESTART WITH 1;
ALTER SEQUENCE products_product_id_seq RESTART WITH 1;
ALTER SEQUENCE orders_order_id_seq RESTART WITH 1;

-- Customers
INSERT INTO Customers (customer_id, full_name, email, phone, shipping_address) VALUES
(1,'Alice Johnson', 'alice.j@gmail.com', '+1234567890', '123 Main St, New York, NY 10001'),
(2,'Bob Smith', 'bob.smith@hotmail.com', '+1987654321', '456 Oak Ave, Los Angeles, CA 90001'),
(3,'Carol Williams', 'carol.w@yahoo.com', '+1122334455', '789 Pine Rd, Chicago, IL 60601'),
(4,'David Brown', 'david.brown@outlook.com', '+1555666777', '321 Elm St, Houston, TX 77001'),
(5,'Emma Davis', 'emma.davis@gmail.com', '+1444333222', '654 Maple Dr, Phoenix, AZ 85001'),
(6,'Frank Miller', 'frank.m@company.com', '+1999888777', '987 Cedar Ln, Philadelphia, PA 19101'),
(7,'Grace Lee', 'grace.lee@gmail.com', '+1222111333', '147 Birch Blvd, San Antonio, TX 78201'),
(8,'Henry Wilson', 'henry.w@workmail.com', '+1333444555', '258 Spruce Way, San Diego, CA 92101'),
(9,'Isabella Martinez', 'isabella.m@gmail.com', '+1666777888', '369 Walnut St, Dallas, TX 75201'),
(10,'James Anderson', 'james.a@yahoo.com', '+1777888999', '741 Cherry Ave, San Jose, CA 95101'),
(11,'Sophia Taylor', 'sophia.t@gmail.com', '+1888999000', '852 Palm Ct, Austin, TX 73301'),
(12,'Liam Moore', 'liam.moore@tech.com', '+1111222333', '963 Ocean Dr, Jacksonville, FL 32201'),
(13,'Olivia Jackson', 'olivia.j@shopper.com', '+1222333444', '159 River Rd, Fort Worth, TX 76101'),
(14,'Noah White', 'noah.white@gmail.com', '+1333555777', '753 Lake View, Columbus, OH 43201'),
(15,'Mia Harris', 'mia.harris@ecom.com', '+1444666888', '951 Mountain Ln, Charlotte, NC 28201');

-- Products
INSERT INTO Products (product_id, product_name, category, price) VALUES
(1,'iPhone 15 Pro', 'Electronics', 1199.99),
(2,'Samsung Galaxy S24', 'Electronics', 999.99),
(3,'MacBook Air M3', 'Electronics', 1499.99),
(4,'Nike Air Max 270', 'Apparel', 149.99),
(5,'Adidas Ultraboost', 'Apparel', 179.99),
(6,'Levi''s 501 Jeans', 'Apparel', 89.99),
(7,'The Da Vinci Code', 'Books', 14.99),
(8,'Atomic Habits', 'Books', 19.99),
(9,'1984 by George Orwell', 'Books', 12.99),
(10,'Sony WH-1000XM5 Headphones', 'Electronics', 399.99),
(11,'Dell XPS 13 Laptop', 'Electronics', 1299.99),
(12,'Uniqlo Hoodie', 'Apparel', 49.99),
(13,'Kindle Paperwhite', 'Electronics', 129.99),
(14,'Pride and Prejudice', 'Books', 9.99),
(15,'Harry Potter Box Set', 'Books', 89.99);

-- Inventory
INSERT INTO Inventory (product_id, quantity_on_hand) VALUES
(1, 50), (2, 70), (3, 30), (4, 100), (5, 80),
(6, 120), (7, 200), (8, 150), (9, 180), (10, 40),
(11, 25), (12, 90), (13, 60), (14, 220), (15, 35);

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2024-11-15', 2399.98, 'Delivered'),
(2, 2, '2024-11-20', 1149.98, 'Shipped'),
(3, 3, '2024-12-01', 1649.97, 'Delivered'),
(4, 4, '2024-12-05', 179.98, 'Delivered'),
(5, 5, '2024-12-10', 359.98, 'Pending'),
(6, 6, '2024-12-12', 1214.98, 'Delivered'),
(7, 7, '2024-12-15', 449.98, 'Shipped'),
(8, 8, '2024-12-18', 104.97, 'Delivered'),
(9, 9, '2024-12-20', 1419.98, 'Delivered'),
(10, 10, '2024-12-22', 89.99, 'Pending'),
(11, 11, '2024-12-24', 219.98, 'Delivered'),
(12, 12, '2025-01-01', 1299.99, 'Shipped'),
(13, 13, '2025-01-02', 549.97, 'Delivered'),
(14, 14, '2025-01-03', 199.98, 'Delivered'),
(15, 15, '2025-01-04', 89.99, 'Delivered'),
(16, 1, '2025-01-04', 1679.97, 'Pending'),
(17, 2, '2025-01-05', 409.98, 'Shipped'),
(18, 3, '2025-01-05', 1349.98, 'Delivered'),
(19, 4, '2025-01-05', 29.98, 'Delivered'),
(20, 5, '2025-01-05', 1199.99, 'Shipped');

-- Order_Items
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 1199.99),
(2, 2, 1, 999.99), (2, 10, 1, 399.99),
(3, 3, 1, 1499.99), (3, 4, 1, 149.99),
(4, 5, 2, 179.99),
(5, 5, 2, 179.99),
(6, 1, 1, 1199.99), (6, 13, 1, 129.99),
(7, 6, 2, 89.99), (7, 8, 1, 19.99),
(8, 7, 3, 14.99), (8, 9, 2, 12.99), (8, 14, 1, 9.99),
(9, 11, 1, 1299.99), (9, 10, 1, 399.99),
(10, 12, 1, 49.99),
(11, 4, 2, 149.99), (11, 6, 1, 89.99),
(12, 15, 1, 89.99),
(13, 2, 1, 999.99), (13, 12, 1, 49.99), (13, 13, 1, 129.99),
(14, 8, 2, 19.99), (14, 9, 1, 12.99), (14, 7, 3, 14.99),
(15, 1, 1, 1199.99),
(16, 3, 1, 1499.99), (16, 10, 1, 399.99),
(17, 2, 1, 999.99), (17, 5, 1, 179.99),
(18, 11, 1, 1299.99),
(19, 13, 2, 129.99), (19, 14, 1, 9.99),
(20, 1, 1, 1199.99), (20, 4, 1, 149.99);

-- Update total_amount in Orders
UPDATE Orders o
SET total_amount = (
    SELECT SUM(oi.quantity * oi.unit_price)
    FROM Order_Items oi
    WHERE oi.order_id = o.order_id
);


--    
SELECT *
FROM Order_Items;

-- KPI 2: Top 10 Customers by Total Spending
SELECT *
FROM Customers;


-- ========================================
-- 2. BUSINESS KPI QUERIES
-- ========================================

-- KPI 1: Total Revenue (Shipped or Delivered)
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM Orders
WHERE status IN ('Shipped', 'Delivered');

-- KPI 2: Top 10 Customers by Total Spending
SELECT c.full_name, ROUND(SUM(o.total_amount), 2) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC
LIMIT 10;

-- KPI 3: Top 5 Best-Selling Products by Quantity
SELECT p.product_name, p.category, SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- KPI 4: Monthly Sales Trend (PostgreSQL uses TO_CHAR instead of DATE_FORMAT)
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS sales_month,
       ROUND(SUM(o.total_amount), 2) AS monthly_revenue
FROM Orders o
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY sales_month
ORDER BY sales_month;

-- ========================================
-- 3. ANALYTICAL QUERIES (WINDOW FUNCTIONS)
-- ========================================

-- Sales Rank by Category
SELECT p.category,
       p.product_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
       RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS sales_rank
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY p.product_id, p.product_name, p.category
ORDER BY p.category, sales_rank;

-- Customer Order Frequency (previous order date)
SELECT c.full_name,
       o.order_id,
       o.order_date AS current_order_date,
       LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS previous_order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Shipped', 'Delivered')
ORDER BY c.full_name, o.order_date;

-- ========================================
-- 4. PERFORMANCE OPTIMIZATION
-- ========================================

-- === VIEW ===
CREATE OR REPLACE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    c.full_name,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id, c.full_name;

-- Stored Procedure: ProcessNewOrder (PostgreSQL PL/pgSQL)
CREATE OR REPLACE PROCEDURE ProcessNewOrder(
    IN cust_id INT,
    IN prod_id INT,
    IN quant INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    stock INT;
    unit_pr DECIMAL(10,2);
    new_order_id INT;
BEGIN
    -- Check stock with row lock
    SELECT quantity_on_hand INTO stock
    FROM Inventory
    WHERE product_id = prod_id
    FOR UPDATE;

    IF stock < quant THEN
        RAISE EXCEPTION 'Insufficient stock for product %', prod_id;
    ELSE
        -- Get price
        SELECT price INTO unit_pr FROM Products WHERE product_id = prod_id;

        -- Reduce inventory
        UPDATE Inventory SET quantity_on_hand = quantity_on_hand - quant WHERE product_id = prod_id;

        -- Create order (current date = today)
        INSERT INTO Orders (customer_id, order_date, total_amount, status)
        VALUES (cust_id, CURRENT_DATE, (quant * unit_pr), 'Pending')
        RETURNING order_id INTO new_order_id;

        -- Create order item
        INSERT INTO Order_Items (order_id, product_id, quantity, unit_price)
        VALUES (new_order_id, prod_id, quant, unit_pr);

        COMMIT;
    END IF;
END;
$$;