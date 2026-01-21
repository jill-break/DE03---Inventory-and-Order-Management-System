-- Capstone Project: Step 3 - Advanced DML & KPIs
-- Part 1: Advanced Queries for Business Insights

-- 1. BUSINESS KPIs (Standard Aggregations)

-- Q1: Total Revenue
-- Logic: Calculates net revenue (Price * Qty - Discount) for completed orders.
SELECT 
    SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)) AS total_net_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status IN ('Shipped', 'Delivered');

-- Q2: Top 10 Customers by Total Spending
-- Logic: Aggregates net spending per customer UUID.
SELECT 
    c.full_name, 
    c.city,
    c.country,
    SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id, c.full_name, c.city, c.country
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Best-Selling Products by Quantity
-- Logic: Counts total units sold, excluding cancelled orders.
SELECT 
    p.product_name, 
    p.category,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Q4: Monthly Sales Trend
-- Logic: Groups revenue by month (formatted YYYY-MM).
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS sales_month,
    SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY sales_month
ORDER BY sales_month;


-- 2. ANALYTICAL QUERIES (Window Functions)

-- Q5: Sales Rank by Category
-- Logic: Ranks products #1, #2, etc., within their specific category based on revenue.
SELECT 
    p.category,
    p.product_name,
    SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)) AS product_revenue,
    RANK() OVER (
        PARTITION BY p.category 
        ORDER BY SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)) DESC
    ) as rank_in_category
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.category, p.product_name, p.product_id;

-- Q6: Customer Order Frequency
-- Logic: Uses LAG() to find the date difference between a customer's consecutive orders.
SELECT 
    c.full_name,
    o.order_date AS current_order_date,
    LAG(o.order_date) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS previous_order_date,
    -- Calculate interval between orders
    o.order_date - LAG(o.order_date) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS time_since_last_order
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;

-- 3. PERFORMANCE OPTIMIZATION (Views)

-- View: CustomerSalesSummary
-- Logic: Pre-calculates lifetime value (LTV) and order counts for fast reporting.
CREATE OR REPLACE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.country,
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- Using COALESCE to handle customers with 0 orders cleanly
    COALESCE(SUM((oi.quantity * oi.price_at_purchase) - COALESCE(oi.discount_amount, 0)), 0) AS total_lifetime_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status IN ('Shipped', 'Delivered') OR o.status IS NULL
GROUP BY c.customer_id, c.full_name, c.email, c.city, c.country;

-- Part 2: Audit Trails & Stored Procedures
-- 1. TRIGGER (Audit)
CREATE OR REPLACE FUNCTION log_inventory_change()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        INSERT INTO inventory_audit_log (product_id, old_quantity, new_quantity, change_type)
        VALUES (OLD.product_id, OLD.quantity_on_hand, NEW.quantity_on_hand, 'UPDATE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_audit_inventory ON inventory;
CREATE TRIGGER trg_audit_inventory
AFTER UPDATE ON inventory
FOR EACH ROW
EXECUTE FUNCTION log_inventory_change();


-- 2. POPULATE DATA
-- I must use explicit UUIDs here to maintain relationships in the script.
-- In production, the app would generate these or retrieve them after insert.

-- Insert Customers (Using hardcoded UUIDs for reference)
INSERT INTO customers (customer_id, full_name, email, phone, shipping_address, city, country) VALUES
('c0000000-0000-0000-0000-000000000001', 'Kwame Mensah', 'kwame@gmail.com', '055-000-0000', 'Accra Rd', 'Accra', 'Ghana'),
('c0000000-0000-0000-0000-000000000002', 'Akosua Serwaa', 'akosua@gmail.com', '024-000-0000', 'Kumasi St', 'Kumasi', 'Ghana');

-- Insert Products
INSERT INTO products (product_id, product_name, category, price, description) VALUES
('p0000000-0000-0000-0000-000000000001', 'Laptop', 'Electronics', 1200.00, 'High performance'),
('p0000000-0000-0000-0000-000000000002', 'Smartphone', 'Electronics', 850.00, 'AMOLED screen'),
('p0000000-0000-0000-0000-000000000003', 'Speaker', 'Electronics', 150.00, 'Bass boost');

-- Insert Inventory (Linking to Product UUIDs)
INSERT INTO inventory (product_id, quantity_on_hand, reorder_level) VALUES
('p0000000-0000-0000-0000-000000000001', 10, 5),
('p0000000-0000-0000-0000-000000000002', 20, 10),
('p0000000-0000-0000-0000-000000000003', 50, 15);

-- Insert Orders (Linking to Customer UUIDs)
INSERT INTO orders (order_id, customer_id, total_amount, status) VALUES
('o0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001', 1250.00, 'Delivered'),
('o0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000002', 850.00, 'Shipped');

-- Insert Order Items (Linking Order UUID and Product UUID)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
('o0000000-0000-0000-0000-000000000001', 'p0000000-0000-0000-0000-000000000001', 1, 1200.00), -- Laptop
('o0000000-0000-0000-0000-000000000002', 'p0000000-0000-0000-0000-000000000002', 1, 850.00);  -- Phone


-- 3. STORED PROCEDURE 
CREATE OR REPLACE PROCEDURE ProcessNewOrder(
    p_customer_id UUID,  
    p_product_id UUID,   
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price DECIMAL(10, 2);
    v_current_stock INT;
    v_new_order_id UUID; 
BEGIN
    -- 1. Get Product Data
    SELECT price, quantity_on_hand INTO v_price, v_current_stock
    FROM inventory i
    JOIN products p ON i.product_id = p.product_id
    WHERE i.product_id = p_product_id
    FOR UPDATE;

    -- 2. Validate
    IF v_current_stock IS NULL THEN
        RAISE EXCEPTION 'Product % not found', p_product_id;
    END IF;

    IF v_current_stock < p_quantity THEN
        INSERT INTO system_error_log (procedure_name, error_message)
        VALUES ('ProcessNewOrder', 'Insufficient Stock for Product ' || p_product_id);
        RAISE EXCEPTION 'Insufficient stock';
    END IF;

    -- 3. Execute
    UPDATE inventory 
    SET quantity_on_hand = quantity_on_hand - p_quantity
    WHERE product_id = p_product_id;

    -- Note: UUID is auto-generated by DEFAULT gen_random_uuid(), but we capture it via RETURNING
    INSERT INTO orders (customer_id, total_amount, status)
    VALUES (p_customer_id, (v_price * p_quantity), 'Pending')
    RETURNING order_id INTO v_new_order_id;

    INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
    VALUES (v_new_order_id, p_product_id, p_quantity, v_price);

    RAISE NOTICE 'Order % processed successfully.', v_new_order_id;

EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO system_error_log (procedure_name, error_message)
        VALUES ('ProcessNewOrder', SQLERRM);
        RAISE;
END;
$$;

-- 4: Auto-Restock Trigger
CREATE OR REPLACE FUNCTION check_and_restock()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the new stock level has fallen to (or below) the reorder threshold
    IF NEW.quantity_on_hand <= NEW.reorder_level THEN
        
        -- 1. Log the Low Stock Alert
        INSERT INTO system_error_log (procedure_name, error_message)
        VALUES ('AutoRestock', 'Low stock detected for Product ' || NEW.product_id || '. Triggering Restock.');

        -- 2. Auto Restock 
        UPDATE inventory
        SET quantity_on_hand = quantity_on_hand + 50
        WHERE inventory_id = NEW.inventory_id;
        
        RAISE NOTICE 'AUTO-RESTOCK: Product % was replenished by 50 units.', NEW.product_id;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the Inventory table
DROP TRIGGER IF EXISTS trg_auto_restock ON inventory;
CREATE TRIGGER trg_auto_restock
AFTER UPDATE ON inventory
FOR EACH ROW
WHEN (NEW.quantity_on_hand < OLD.quantity_on_hand) -- Only run when stock is GOING DOWN
EXECUTE FUNCTION check_and_restock();

-- 5: Process Bulk Order (JSONB Version)
CREATE OR REPLACE PROCEDURE ProcessBulkOrder(
    p_payload JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id UUID;
    v_order_id UUID;
    v_item JSONB;
    v_product_id UUID;
    v_qty INT;
    v_price DECIMAL(10,2);
    v_current_stock INT;
    v_total DECIMAL(12,2) := 0;
BEGIN
    -- 1. Extract Customer ID from JSON
    v_customer_id := (p_payload->>'customer_id')::UUID;

    -- 2. Create the "Head" Order (Empty Total initially)
    INSERT INTO orders (customer_id, status)
    VALUES (v_customer_id, 'Pending')
    RETURNING order_id INTO v_order_id;

    -- 3. Loop through the "items" array in the JSON
    FOR v_item IN SELECT * FROM jsonb_array_elements(p_payload->'items')
    LOOP
        -- Extract Item Details
        v_product_id := (v_item->>'product_id')::UUID;
        v_qty := (v_item->>'quantity')::INT;

        -- Check Stock & Price (Locking row)
        SELECT price, quantity_on_hand INTO v_price, v_current_stock
        FROM inventory i
        JOIN products p ON i.product_id = p.product_id
        WHERE i.product_id = v_product_id
        FOR UPDATE;

        IF v_current_stock < v_qty THEN
            RAISE EXCEPTION 'Insufficient stock for Product %. Have %, Need %', v_product_id, v_current_stock, v_qty;
        END IF;

        -- Update Inventory (Triggers Audit AND Auto-Restock if needed)
        UPDATE inventory 
        SET quantity_on_hand = quantity_on_hand - v_qty
        WHERE product_id = v_product_id;

        -- Create Order Item
        INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
        VALUES (v_order_id, v_product_id, v_qty, v_price);

        -- Add to Total
        v_total := v_total + (v_price * v_qty);
    END LOOP;

    -- 4. Update Final Total
    UPDATE orders SET total_amount = v_total WHERE order_id = v_order_id;

    RAISE NOTICE 'Bulk Order % processed successfully. Total: %', v_order_id, v_total;

EXCEPTION
    WHEN OTHERS THEN
        -- Log the JSON payload that caused the crash for debugging
        INSERT INTO system_error_log (procedure_name, error_message)
        VALUES ('ProcessBulkOrder', SQLERRM || ' Payload: ' || p_payload::TEXT);
        RAISE; -- Rollback transaction
END;
$$;