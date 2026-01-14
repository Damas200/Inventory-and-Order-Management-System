-- DROP VIEW IF EXISTS CustomerSalesSummary CASCADE;
-- DROP PROCEDURE IF EXISTS ProcessNewOrder(INT, INT, INT);



-- =====================================
-- 3. KPI & Advanced SQL Querying (DML)
-- ============================== 


-- ========================================
--  INSERT SAMPLE DATA
-- ========================================

-- Customers
INSERT INTO Customers (customer_id, full_name, email, phone, shipping_address) VALUES
(1,'Blaise Niyonkuru', 'blaise.niyonkuru@amalitech.com', '+250787933080', 'KN 3 Rd, Kacyiru, Kigali'),
(2,'Arlette Musanabera', 'arlette.musanabera@amalitech.com', '+250788245671', 'KG 9 Ave, Kimironko, Kigali'),
(3,'Niyonizeye Faustin', 'niyonizeye.faustin@amalitech.com', '+250783112459', 'KN 5 Rd, Nyamirambo, Kigali'),
(4,'Kwibuka Confiance', 'kwibuka.confiance@amalitech.com', '+250781556732', 'KG 11 Ave, Gisozi, Kigali'),
(5,'Aristote Katy', 'aristote.katy@amalitech.com', '+250782443198', 'KN 7 Rd, Remera, Kigali'),
(6,'Ben Sekyondwa', 'ben.sekyondwa@amalitech.com', '+250789998877', 'KG 15 Ave, Kicukiro, Kigali'),
(7,'Xavier Rucahobatinya', 'xavier.rucahobatinya@amalitech.com', '+250784221133', 'KN 1 Rd, Nyarutarama, Kigali'),
(8,'Zachee Ishimwe', 'zachee.ishimwe@amalitech.com', '+250783344455', 'KG 17 Ave, Kanombe, Kigali'),
(9,'Joel Rugagi', 'joel.rugagi@amalitech.com', '+250786677788', 'KN 14 Rd, Gacuriro, Kigali'),
(10,'Charlotte Umutoni Karera', 'charlotte.karera@amalitech.com', '+250787788899', 'KG 5 Ave, Kabeza, Kigali'),
(11,'Derrick Murengezi', 'derrick.murengezi@amalitech.com', '+250788899900', 'KN 8 Rd, Kimihurura, Kigali'),
(12,'Sandra Umulisa', 'sandra.umulisa@amalitech.com', '+250781122233', 'KG 19 Ave, Gatenga, Kigali'),
(13,'Yves Iradukunda', 'yves.iradukunda@amalitech.com', '+250782233344', 'KN 22 Rd, Batsinda, Kigali'),
(14,'Ariane Masabo', 'ariane.masabo@amalitech.com', '+250783355577', 'KG 13 Ave, Kagarama, Kigali'),
(15,'Jean Claude Mutabazi', 'jeanclaude.mutabazi@amalitech.com', '+250784466688', 'KN 41 St, Gikondo, Kigali');

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
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, order_status) VALUES
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
INSERT INTO Order_Items (order_id, product_id, quantity, price_at_purchase) VALUES
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




-- 3.1 Business KPIs
-- =======================================
-- 3.1.1 Total Revenue (Shipped + Delivered)
-- =====================================================

-- Calculates total revenue generated from completed orders.
-- Only orders with status 'Shipped' or 'Delivered' are included
-- because they represent confirmed sales.
-- =====================================================

SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status IN ('Shipped', 'Delivered');

-- =====================================================
-- 3.1.2 Top 10 Customers by Spending
-- ============================================

-- Joins customers with their orders.
-- Groups data by customer.
-- Calculates total spending per customer.
-- Orders results from highest to lowest spending.
-- =====================================================
SELECT
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC
LIMIT 10;


-- =====================================================
-- 3.1.3 Top 5 Best-Selling Products
-- =====================================================

-- Measures product popularity by total quantity sold.
-- Uses order_items to sum quantities per product.
-- =====================================================
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC
LIMIT 5;


-- =====================================================
-- 3.1.4 Monthly Sales Trend
-- =====================================

-- Groups sales by month using DATE_TRUNC.
-- Helps management understand sales performance over time.
-- =====================================================
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS monthly_sales
FROM orders
WHERE order_status IN ('Shipped', 'Delivered')
GROUP BY month
ORDER BY month;

-- ========================================
-- 3.2 ANALYTICAL QUERIES (USE WINDOW FUNCTIONS)
-- =====================================================

-- 3.2.1 Sales Rank by Category
-- ===================================

-- Calculates total revenue per product.
-- Uses RANK() window function to rank products
-- within each category based on revenue.
-- =====================================================
SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.price_at_purchase) AS revenue,
    RANK() OVER (
        PARTITION BY p.category
        ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC
    ) AS category_rank
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category, p.product_name;

-- =====================================================
-- 3.2.2 Customer Order Frequency
-- =============================

-- Uses LAG() to show the previous order date
-- for each customer.
-- Helps analyze how frequently customers return.
-- =====================================================
SELECT
    c.full_name,
    o.order_date,
    LAG(o.order_date) OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS previous_order_date
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

-- ======================================
-- 3.3 VIEW – PERFORMANCE OPTIMIZATION
-- =====================================

-- 3.3.1 CustomerSalesSummary
-- ====================================
-- Purpose:

-- Pre-calculates total spending per customer.
-- Improves performance and simplifies analytics queries.
-- =====================================================
CREATE VIEW CustomerSalesSummary AS
SELECT
    c.customer_id,
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- ==========================================

--  3.3.2 STORED PROCEDURE – BUSINESS LOGIC
-- =====================================================
--  ProcessNewOrder
-- ====================================
-- Purpose:

-- Safely processes a new order using a transaction.
-- Ensures inventory consistency and prevents overselling.
-- =====================================================
CREATE OR REPLACE FUNCTION ProcessNewOrder(
    p_customer_id INT,
    p_product_id INT,
    p_quantity INT
)
RETURNS VOID AS $$
DECLARE
    current_stock INT;
    product_price DECIMAL(10,2);
    new_order_id INT;
BEGIN
    -- Lock inventory row to prevent concurrent updates
    SELECT quantity_on_hand
    INTO current_stock
    FROM inventory
    WHERE product_id = p_product_id
    FOR UPDATE;

    -- Check if enough stock is available
    IF current_stock < p_quantity THEN
        RAISE EXCEPTION 'Insufficient stock available';
    END IF;

    -- Get current product price
    SELECT price
    INTO product_price
    FROM products
    WHERE product_id = p_product_id;

    -- Create new order record
    INSERT INTO orders (customer_id, order_date, total_amount, order_status)
    VALUES (
        p_customer_id,
        CURRENT_DATE,
        product_price * p_quantity,
        'Pending'
    )
    RETURNING order_id INTO new_order_id;

    -- Insert order item
    INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
    VALUES (
        new_order_id,
        p_product_id,
        p_quantity,
        product_price
    );
 
    -- Update inventory after successful order
    UPDATE inventory
    SET quantity_on_hand = quantity_on_hand - p_quantity
    WHERE product_id = p_product_id;
END;
$$ LANGUAGE plpgsql;

