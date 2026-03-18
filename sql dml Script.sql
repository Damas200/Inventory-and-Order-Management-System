-- DROP VIEW IF EXISTS CustomerSalesSummary CASCADE;
-- DROP PROCEDURE IF EXISTS ProcessNewOrder(INT, INT, INT);



-- =====================================
-- 3. KPI & Advanced SQL Querying (DML)
-- ============================== 


TRUNCATE TABLE order_items, orders, inventory, products, customers RESTART IDENTITY CASCADE;

-- ========================================
--  INSERT SAMPLE DATA
-- ========================================

-- Customers
INSERT INTO customers (full_name, email, phone, shipping_address) VALUES
('Blaise Niyonkuru', 'blaise.niyonkuru@amalitech.com', '+250787933080', 'KN 3 Rd, Kacyiru, Kigali'),
('Arlette Musanabera', 'arlette.musanabera@amalitech.com', '+250788245671', 'KG 9 Ave, Kimironko, Kigali'),
('Niyonizeye Faustin', 'niyonizeye.faustin@amalitech.com', '+250783112459', 'KN 5 Rd, Nyamirambo, Kigali'),
('Kwibuka Confiance', 'kwibuka.confiance@amalitech.com', '+250781556732', 'KG 11 Ave, Gisozi, Kigali'),
('Aristote Katy', 'aristote.katy@amalitech.com', '+250782443198', 'KN 7 Rd, Remera, Kigali'),
('Ben Sekyondwa', 'ben.sekyondwa@amalitech.com', '+250789998877', 'KG 15 Ave, Kicukiro, Kigali'),
('Xavier Rucahobatinya', 'xavier.rucahobatinya@amalitech.com', '+250784221133', 'KN 1 Rd, Nyarutarama, Kigali'),
('Zachee Ishimwe', 'zachee.ishimwe@amalitech.com', '+250783344455', 'KG 17 Ave, Kanombe, Kigali'),
('Joel Rugagi', 'joel.rugagi@amalitech.com', '+250786677788', 'KN 14 Rd, Gacuriro, Kigali'),
('Charlotte Umutoni Karera', 'charlotte.karera@amalitech.com', '+250787788899', 'KG 5 Ave, Kabeza, Kigali'),
('Derrick Murengezi', 'derrick.murengezi@amalitech.com', '+250788899900', 'KN 8 Rd, Kimihurura, Kigali'),
('Sandra Umulisa', 'sandra.umulisa@amalitech.com', '+250781122233', 'KG 19 Ave, Gatenga, Kigali'),
('Yves Iradukunda', 'yves.iradukunda@amalitech.com', '+250782233344', 'KN 22 Rd, Batsinda, Kigali'),
('Ariane Masabo', 'ariane.masabo@amalitech.com', '+250783355577', 'KG 13 Ave, Kagarama, Kigali'),
('Jean Claude Mutabazi', 'jeanclaude.mutabazi@amalitech.com', '+250784466688', 'KN 41 St, Gikondo, Kigali');

-- Products
INSERT INTO Products (product_name, category, price) VALUES
('iPhone 15 Pro', 'Electronics', 1199.99),
('Samsung Galaxy S24', 'Electronics', 999.99),
('MacBook Air M3', 'Electronics', 1499.99),
('Nike Air Max 270', 'Apparel', 149.99),
('Adidas Ultraboost', 'Apparel', 179.99),
('Levi''s 501 Jeans', 'Apparel', 89.99),
('The Da Vinci Code', 'Books', 14.99),
('Atomic Habits', 'Books', 19.99),
('1984 by George Orwell', 'Books', 12.99),
('Sony WH-1000XM5 Headphones', 'Electronics', 399.99),
('Dell XPS 13 Laptop', 'Electronics', 1299.99),
('Uniqlo Hoodie', 'Apparel', 49.99),
('Kindle Paperwhite', 'Electronics', 129.99),
('Pride and Prejudice', 'Books', 9.99),
('Harry Potter Box Set', 'Books', 89.99);

-- Inventory
INSERT INTO Inventory (product_id, quantity_on_hand) VALUES
(1, 50), (2, 70), (3, 30), (4, 100), (5, 80),
(6, 120), (7, 200), (8, 150), (9, 180), (10, 40),
(11, 25), (12, 90), (13, 60), (14, 220), (15, 35);

-- Orders
INSERT INTO Orders (customer_id, order_date, total_amount, order_status) VALUES
(1, '2024-11-15', 2399.98, 'Delivered'),
(2, '2024-11-20', 1149.98, 'Shipped'),
(3, '2024-12-01', 1649.97, 'Delivered'),
(4, '2024-12-05', 179.98, 'Delivered'),
(5, '2024-12-10', 359.98, 'Pending'),
(6, '2024-12-12', 1214.98, 'Delivered'),
(7, '2024-12-15', 449.98, 'Shipped'),
(8, '2024-12-18', 104.97, 'Delivered'),
(9, '2024-12-20', 1419.98, 'Delivered'),
(10, '2024-12-22', 89.99, 'Pending'),
(11, '2024-12-24', 219.98, 'Delivered'),
(12, '2025-01-01', 1299.99, 'Shipped'),
(13, '2025-01-02', 549.97, 'Delivered'),
(14, '2025-01-03', 199.98, 'Delivered'),
(15, '2025-01-04', 89.99, 'Delivered'),
(1, '2025-01-04', 1679.97, 'Pending'),
(2, '2025-01-05', 409.98, 'Shipped'),
(3, '2025-01-05', 1349.98, 'Delivered'),
(4, '2025-01-05', 29.98, 'Delivered'),
(5, '2025-01-05', 1199.99, 'Shipped');

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


-- INDEXES (PERFORMANCE IMPROVEMENT)
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_inventory_product_id ON inventory(product_id);

-- VIEW: CUSTOMER SALES SUMMARY
-- =====================================================

CREATE OR REPLACE VIEW CustomerSalesSummary AS
SELECT
    c.customer_id,
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

-- AUDIT TABLE (LOGGING)
-- =====================================================

CREATE TABLE IF NOT EXISTS order_audit (
    audit_id SERIAL PRIMARY KEY,
    order_id INT,
    action VARCHAR(50),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- UPDATED FUNCTION: ProcessNewOrder (ENTERPRISE LEVEL)
-- =====================================================

CREATE OR REPLACE FUNCTION ProcessNewOrder(
    p_customer_id INT,
    p_items JSON
)
RETURNS VOID AS $$
DECLARE
    item JSON;
    v_order_id INT;
    v_stock INT;
    v_price DECIMAL(10,2);
    v_total DECIMAL := 0;
BEGIN

    -- Validate customer exists
    IF NOT EXISTS (
        SELECT 1 FROM customers WHERE customer_id = p_customer_id
    ) THEN
        RAISE EXCEPTION 'Customer % does not exist', p_customer_id;
    END IF;

    -- Create order
    INSERT INTO orders (customer_id, order_date, total_amount, order_status)
    VALUES (p_customer_id, CURRENT_DATE, 0, 'Pending')
    RETURNING order_id INTO v_order_id;

    -- Loop through items
    FOR item IN SELECT * FROM json_array_elements(p_items)
    LOOP
        -- Lock inventory
        SELECT quantity_on_hand INTO v_stock
        FROM inventory
        WHERE product_id = (item->>'product_id')::INT
        FOR UPDATE;

        --  Improved error handling 
        IF v_stock < (item->>'quantity')::INT THEN
            RAISE EXCEPTION 
            'Insufficient stock for product %, available: %, requested: %',
            (item->>'product_id'),
            v_stock,
            (item->>'quantity')::INT;
        END IF;

        -- Get price
        SELECT price INTO v_price
        FROM products
        WHERE product_id = (item->>'product_id')::INT;

        -- Insert order item
        INSERT INTO order_items (
            order_id, product_id, quantity, price_at_purchase
        )
        VALUES (
            v_order_id,
            (item->>'product_id')::INT,
            (item->>'quantity')::INT,
            v_price
        );

        -- Update total
        v_total := v_total + (v_price * (item->>'quantity')::INT);

        -- Update inventory
        UPDATE inventory
        SET quantity_on_hand = quantity_on_hand - (item->>'quantity')::INT
        WHERE product_id = (item->>'product_id')::INT;

        --  Inventory audit logging 
        INSERT INTO inventory_audit (product_id, change_quantity, action)
        VALUES (
            (item->>'product_id')::INT,
            -(item->>'quantity')::INT,
            'Order Deduction'
        );

    END LOOP;

    --  Update order + status 
    UPDATE orders
    SET total_amount = v_total,
        order_status = 'Completed'
    WHERE order_id = v_order_id;

    -- Log creation
    INSERT INTO order_audit (order_id, action)
    VALUES (v_order_id, 'Order Created');

    --  Status log
    INSERT INTO order_audit (order_id, action)
    VALUES (v_order_id, 'Order Completed');

    -- Success message
    RAISE NOTICE 'Order processed successfully. Order ID: %', v_order_id;

END;
$$ LANGUAGE plpgsql;