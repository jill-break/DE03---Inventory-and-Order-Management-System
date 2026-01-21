-- TEST SCRIPT

DO $$
DECLARE
    -- We need to grab valid IDs from our table to make the JSON
    v_cust_id UUID;
    v_prod_1 UUID;
    v_prod_2 UUID;
    v_json_payload JSONB;
BEGIN
    -- 1. Get IDs (Using LIMIT 1 to just grab whatever is there)
    SELECT customer_id INTO v_cust_id FROM customers LIMIT 1;
    SELECT product_id INTO v_prod_1 FROM products LIMIT 1;  -- Let's say this is 'Laptop'
    SELECT product_id INTO v_prod_2 FROM products OFFSET 1 LIMIT 1; -- Another product

    -- 2. Force Inventory to be LOW for Product 1 (to test Auto-Restock)
    -- We set it to 12. Reorder level is 10.
    -- If we buy 5, it goes to 7. 7 <= 10, so Auto-Restock should fire +50.
    UPDATE inventory SET quantity_on_hand = 12, reorder_level = 10 WHERE product_id = v_prod_1;

    -- 3. Construct the JSON Payload
    v_json_payload := jsonb_build_object(
        'customer_id', v_cust_id,
        'items', jsonb_build_array(
            jsonb_build_object('product_id', v_prod_1, 'quantity', 5), -- Triggers Restock
            jsonb_build_object('product_id', v_prod_2, 'quantity', 1)  -- Normal item
        )
    );

    -- 4. Run the Procedure
    RAISE NOTICE 'Testing JSON Bulk Order...';
    CALL ProcessBulkOrder(v_json_payload);

END $$;

-- VERIFICATION
-- Check if Product 1 was restocked.
-- Math: Started at 12 -> Sold 5 (Left 7) -> Trigger fired (+50) -> Final Result should be 57.
SELECT 
    p.product_name, 
    i.quantity_on_hand, 
    i.reorder_level 
FROM inventory i 
JOIN products p ON i.product_id = p.product_id;

-- Check the logs to see the "AUTO-RESTOCK" event
SELECT * FROM system_error_log ORDER BY occurred_at DESC;