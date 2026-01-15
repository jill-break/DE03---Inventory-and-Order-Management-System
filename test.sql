-- Testing the Stored Procedure

-- Step 1: Check initial state (Product 1 = Laptop, Stock = 10)
SELECT product_id, product_name, price, quantity_on_hand 
FROM inventory 
JOIN products USING (product_id) 
WHERE product_id = 1;

-- Step 2: Call the procedure
-- Customer 1 (Alice) buys 2 Laptops (Product 1)
CALL ProcessNewOrder(1, 1, 2);

-- Step 3: Verify the changes
-- A. Inventory should now be 8 (10 - 2)
SELECT product_id, product_name, quantity_on_hand 
FROM inventory 
JOIN products USING (product_id) 
WHERE product_id = 1;

-- B. Check for the new Order (Status should be 'Pending')
SELECT * FROM orders 
ORDER BY order_id DESC 
LIMIT 1;

-- C. Check for the new Order Items
SELECT * FROM order_items 
WHERE order_id = (SELECT MAX(order_id) FROM orders);

-- Step 4: Test Error Handling (Insufficient Stock)
-- Expected Output: NOTICE: Transaction rolled back: Insufficient stock. Available: 8, Requested: 1000
CALL ProcessNewOrder(1, 1, 1000);
CALL RestockInventory(1, 50);

-- Customer 2 (Bob) buys: 1 Smartphone (ID 2), 5 T-Shirts (ID 4)
CALL ProcessBulkOrder('
{
  "customer_id": 2,
  "items": [
    { "product_id": 2, "quantity": 1 },
    { "product_id": 4, "quantity": 5 }
  ]
}'::jsonb);


-- Verify new stock level (Should be 8 + 50 = 58)
SELECT product_id, product_name, quantity_on_hand 
FROM inventory 
JOIN products USING (product_id) 
WHERE product_id = 1;