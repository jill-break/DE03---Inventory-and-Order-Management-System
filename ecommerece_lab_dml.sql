-- Capstone Project: Step 3 - KPI & Advanced Querying (DML)


-- 0. Populate Sample Data
-- Insert Customers 
INSERT INTO customers (full_name, email, phone, shipping_address, city, country) VALUES
('Kwame Mensah', 'kwamemensah@gmail.com', '055-210-9831', '12 Ashongman Rd', 'Accra', 'Ghana'),
('Akosua Serwaa', 'akosua.serwaa@gmail.com', '024-889-1123', '44 Aboabo Street', 'Kumasi', 'Ghana'),
('Yaw Boakye', 'yawboakye12@gmail.com', '020-771-4521', '7 Beach Drive', 'Takoradi', 'Ghana'),
('Abena Konadu', 'konaduabena@gmail.com', '059-331-2210', '18 Odeneho Lane', 'Sunyani', 'Ghana'),
('Kojo Amankwah', 'amankwahkojo@gmail.com', '027-620-4457', '90 Ridge Avenue', 'Cape Coast', 'Ghana'),
('Nana Adjei', 'nanaadjei77@gmail.com', '026-880-1420', '55 Stadium Road', 'Koforidua', 'Ghana'),
('Efua Hammond', 'efuahammond@gmail.com', '050-673-9911', '21 Market Square', 'Sekondi', 'Ghana'),
('Kofi Nyarko', 'kofinyarko23@gmail.com', '054-920-4441', '10 Chapel Hill', 'Takoradi', 'Ghana'),
('Ama Owusu', 'amaowusu99@gmail.com', '024-112-7833', '5 Ashtown Lane', 'Kumasi', 'Ghana'),
('Kojo Antwi', 'kojoantwi@gmail.com', '020-772-1931', '3 Legon Boundary', 'Accra', 'Ghana'),

('Mansa Darko', 'mansadarko@gmail.com', '055-201-4322', '9 Adum Street', 'Kumasi', 'Ghana'),
('Emmanuel Tetteh', 'emmatetteh@gmail.com', '027-551-2101', '49 High Street', 'Accra', 'Ghana'),
('Gifty Agyapong', 'giftyagyapong@gmail.com', '059-330-2982', '66 Central Market Rd', 'Sunyani', 'Ghana'),
('Samuel Ofori', 'samuelofori@gmail.com', '026-743-1780', '22 Asafo Junction', 'Kumasi', 'Ghana'),
('Dora Akua', 'doraakua@gmail.com', '050-918-0011', '78 New Juaben Rd', 'Koforidua', 'Ghana'),
('Justice Dogbe', 'justicedogbe@gmail.com', '024-820-6617', '101 Liberation Road', 'Accra', 'Ghana'),
('Linda Anokye', 'lindaanokye@gmail.com', '020-882-7811', '14 Fante Newtown', 'Kumasi', 'Ghana'),
('Patrick Owusu', 'patrickowusu@gmail.com', '027-400-5511', '5 Kwesimintsim Ave', 'Takoradi', 'Ghana'),
('Naana Essel', 'naanaessel@gmail.com', '054-667-2910', '2 Kotokuraba Street', 'Cape Coast', 'Ghana'),
('Kwesi Debrah', 'kwesidebrah@gmail.com', '059-102-8411', '8 Adisadel Estate', 'Cape Coast', 'Ghana'),

('Sheila Boadu', 'sheilaboadu@gmail.com', '024-778-5532', '11 Asokwa Road', 'Kumasi', 'Ghana'),
('Yaw Asare', 'yawasare88@gmail.com', '055-209-4710', '33 Nungua Barrier', 'Accra', 'Ghana'),
('Kofi Adomako', 'kofiadomako@gmail.com', '050-683-2291', '15 Kasoa Overhead', 'Kasoa', 'Ghana'),
('Rita Osei', 'ritaosei@gmail.com', '059-230-5521', '6 Krofrom Road', 'Kumasi', 'Ghana'),
('Emelia Baah', 'emeliabaah23@gmail.com', '026-740-3990', '47 OLA Street', 'Sunyani', 'Ghana'),
('Daniel Gyasi', 'danielgyasi@gmail.com', '020-712-1001', '21 Nkroful Road', 'Takoradi', 'Ghana'),
('Michael Ababio', 'mikeababio@gmail.com', '024-007-5392', '40 Ridge Street', 'Sunyani', 'Ghana'),
('Elsie Adom', 'elsieadom@gmail.com', '055-320-1881', '16 Bantama High St', 'Kumasi', 'Ghana'),
('Kojo Frempong', 'kojofrempong@gmail.com', '054-551-8830', '29 A and C Mall Rd', 'Accra', 'Ghana'),
('Sarah Afriyie', 'sarahafriyie@gmail.com', '027-904-1781', '5 Tanokrom Road', 'Takoradi', 'Ghana'),

('Dorcas Mireku', 'dorcasmireku@gmail.com', '059-330-4082', '13 Roman Hill', 'Kumasi', 'Ghana'),
('Isaac Techie', 'isaactechie@gmail.com', '050-213-9191', '18 Tema Station', 'Accra', 'Ghana'),
('Fred Boamah', 'fredboamah@gmail.com', '020-772-8922', '31 Airport Ridge', 'Takoradi', 'Ghana'),
('Josephine Oduro', 'josephineoduro@gmail.com', '024-913-7001', '52 Ridge Road', 'Koforidua', 'Ghana'),
('Kwabena Adu', 'kwabenaadu@gmail.com', '027-600-3312', '19 Adum Roundabout', 'Kumasi', 'Ghana'),
('Victoria Ampah', 'victoriaampah@gmail.com', '055-709-1170', '72 East Legon Hills', 'Accra', 'Ghana'),
('Felix Addo', 'felixaddo233@gmail.com', '059-234-1971', '4 Independence Ave', 'Accra', 'Ghana'),
('Patricia Mensima', 'pattimensima@gmail.com', '026-882-4102', '24 Effiakuma Rd', 'Takoradi', 'Ghana'),
('Bernard Oppong', 'bernardoppong@gmail.com', '050-681-0041', '6 Suame Magazine', 'Kumasi', 'Ghana'),
('Cynthia Torgbor', 'cynthiatorgbor@gmail.com', '054-820-5882', '13 Kpong Rd', 'Akosombo', 'Ghana'),

('Prince Larbi', 'princelarbi@gmail.com', '059-200-1122', '15 Adabraka Road', 'Accra', 'Ghana'),
('Rebecca Owusu', 'rebeccaowusu@gmail.com', '020-441-9810', '20 Asafo Market', 'Kumasi', 'Ghana'),
('Benedicta Nyame', 'benedictanyame@gmail.com', '055-330-8821', '93 SSNIT Road', 'Sunyani', 'Ghana'),
('Samuel Asamoah', 'samasamoah@gmail.com', '024-901-2843', '17 Aboadze Street', 'Takoradi', 'Ghana'),
('Nana Yaa Opoku', 'nanayaaopoku@gmail.com', '027-730-5100', '28 Ridge Estate', 'Koforidua', 'Ghana'),
('Joseph Addae', 'josephaddae@gmail.com', '059-713-2009', '61 Kasoa Market', 'Kasoa', 'Ghana'),
('Eunice Korang', 'eunicekorang@gmail.com', '055-441-2201', '33 Aboabo St', 'Kumasi', 'Ghana'),
('Francis Amartey', 'francisamartey@gmail.com', '050-112-5002', '10 Abeka Lapaz', 'Accra', 'Ghana'),
('Mary Takyiwaa', 'marytakyiwaa@gmail.com', '024-330-6782', '14 Tanoso Rd', 'Kumasi', 'Ghana'),
('Isaac Owuraku', 'isaacowuraku@gmail.com', '027-982-3011', '22 Melcom Road', 'Tamale', 'Ghana'),

('Esther Donkor', 'estherdonkor@gmail.com', '055-210-1132', '17 Krobo Street', 'Koforidua', 'Ghana'),
('Bright Aning', 'brightaning@gmail.com', '020-883-1181', '71 Ridge Road', 'Ho', 'Ghana'),
('Sarah Amoako', 'sarahamoako@gmail.com', '024-310-4481', '12 Fiapre Street', 'Sunyani', 'Ghana'),
('Kwesi Attah', 'kwesiattah@gmail.com', '059-712-7811', '8 Mallam Junction', 'Accra', 'Ghana'),
('Diana Addo', 'dianaaddo@gmail.com', '026-771-9150', '4 Ankaful Road', 'Cape Coast', 'Ghana'),
('Kingsley Otoo', 'kingsleyotoo@gmail.com', '054-112-9931', '16 Tema Comm. 4', 'Tema', 'Ghana'),
('Bernice Sarpong', 'bernicesarpong@gmail.com', '059-601-2131', '33 Ahodwo Roundabout', 'Kumasi', 'Ghana'),
('Jonathan Frimpong', 'jonfrimpong@gmail.com', '020-882-5521', '50 GN Bank Road', 'Kasoa', 'Ghana'),
('Ruth Addai', 'ruthaddai@gmail.com', '024-778-2011', '5 McCarthy Hill', 'Accra', 'Ghana'),
('Joshua Anane', 'joshuananane@gmail.com', '027-663-4451', '18 Akwatia Line', 'Kumasi', 'Ghana'),

('Belinda Ansah', 'belindaansah@gmail.com', '055-209-1001', '6 Ministries Road', 'Ho', 'Ghana'),
('Alex Asiedu', 'alexasiedu@gmail.com', '050-721-5581', '12 Kotoka Street', 'Accra', 'Ghana'),
('Richmond Asamoah', 'richasamoah@gmail.com', '059-300-9121', '40 Adum Park Rd', 'Kumasi', 'Ghana'),
('Deborah Adubea', 'deborahadubea@gmail.com', '024-113-2011', '33 Ridge Rd', 'Sunyani', 'Ghana'),
('Solomon Obeng', 'solomonobeng@gmail.com', '020-773-6781', '13 Essikado St', 'Takoradi', 'Ghana');

-- Insert Products 
INSERT INTO products (product_name, category, price, description) VALUES
('Laptop', 'Electronics', 1200.00, 'High performance laptop with 16GB RAM'),
('Smartphone', 'Electronics', 850.00, 'Latest model smartphone with AMOLED display'),
('Bluetooth Speaker', 'Electronics', 150.00, 'Portable speaker with deep bass'),
('LED TV 43"', 'Electronics', 2200.00, 'Full HD smart TV with Wi-Fi connectivity'),
('Microwave Oven', 'Home Appliances', 650.00, 'Digital microwave with grill function'),
('Refrigerator', 'Home Appliances', 3200.00, 'Double-door fridge with energy saving'),
('Washing Machine', 'Home Appliances', 2800.00, 'Automatic washing machine, 7kg capacity'),
('Electric Kettle', 'Home Appliances', 120.00, '1.7L stainless steel electric kettle'),
('Air Conditioner', 'Home Appliances', 4100.00, '1.5HP split AC with remote control'),
('Ceiling Fan', 'Home Appliances', 180.00, 'High-speed ceiling fan with 5 blades'),

('Office Chair', 'Furniture', 450.00, 'Ergonomic chair with adjustable height'),
('Study Desk', 'Furniture', 700.00, 'Wooden study desk with drawers'),
('Sofa Set', 'Furniture', 3900.00, '3-piece living room sofa set'),
('Dining Table', 'Furniture', 2100.00, '6-seater dining table made of hardwood'),
('Wardrobe', 'Furniture', 1600.00, '3-door wardrobe with mirror'),
('Bed Frame', 'Furniture', 2300.00, 'Queen size wooden bed frame'),
('Bookshelf', 'Furniture', 550.00, '5-layer wooden bookshelf'),
('TV Stand', 'Furniture', 350.00, 'Modern TV stand with storage compartments'),
('Office Cabinet', 'Furniture', 900.00, 'Steel office cabinet with lock'),
('Mattress 6x4', 'Furniture', 780.00, 'Foam mattress with firm support'),

('Rice Cooker', 'Kitchen Appliance', 260.00, '3L electric rice cooker'),
('Gas Cooker', 'Kitchen Appliance', 950.00, '4-burner gas stove with oven'),
('Blender', 'Kitchen Appliance', 180.00, 'Multi-speed blender with glass jar'),
('Toaster', 'Kitchen Appliance', 95.00, '2-slice toaster with browning control'),
('Cookware Set', 'Kitchen Appliance', 320.00, '10-piece non-stick cookware set'),
('Juicer', 'Kitchen Appliance', 240.00, 'Fruit juicer with stainless steel blades'),
('Deep Fryer', 'Kitchen Appliance', 480.00, 'Electric deep fryer, 3L capacity'),
('Dish Rack', 'Kitchen Appliance', 70.00, 'Double-layer stainless steel dish rack'),
('Water Dispenser', 'Kitchen Appliance', 650.00, 'Hot and cold water dispenser'),
('Pressure Cooker', 'Kitchen Appliance', 310.00, '6L electric pressure cooker'),

('Football Boots', 'Sports', 220.00, 'Lightweight boots for turf and grass'),
('Treadmill', 'Sports', 5200.00, 'Electric treadmill with LCD display'),
('Basketball', 'Sports', 85.00, 'Official size leather basketball'),
('Dumbbell Set', 'Sports', 260.00, '20kg adjustable dumbbell set'),
('Skipping Rope', 'Sports', 25.00, 'Durable skipping rope for cardio'),
('Gym Bag', 'Sports', 110.00, 'Water-resistant multipurpose gym bag'),
('Yoga Mat', 'Sports', 75.00, 'Non-slip yoga mat for workouts'),
('Goalkeeper Gloves', 'Sports', 130.00, 'Professional goalkeeper gloves'),
('Boxing Gloves', 'Sports', 260.00, '16oz padded boxing gloves'),
('Tennis Racket', 'Sports', 420.00, 'Lightweight carbon fiber racket'),

('Shampoo', 'Cosmetics', 45.00, 'Hair strengthening shampoo'),
('Body Lotion', 'Cosmetics', 60.00, 'Moisturizing lotion with shea butter'),
('Perfume', 'Cosmetics', 150.00, 'Long-lasting floral fragrance'),
('Lip Balm', 'Cosmetics', 18.00, 'Hydrating lip balm with vitamin E'),
('Hair Dryer', 'Cosmetics', 160.00, '1200W hair dryer with heat control'),
('Hand Sanitizer', 'Cosmetics', 22.00, 'Alcohol-based hand sanitizer'),
('Facial Cleanser', 'Cosmetics', 70.00, 'Deep cleansing facial wash'),
('Beard Oil', 'Cosmetics', 55.00, 'Natural beard oil with essential oils'),
('Makeup Kit', 'Cosmetics', 230.00, 'Complete makeup kit with accessories'),
('Deodorant', 'Cosmetics', 28.00, '48-hour active protection deodorant');

-- Insert Inventory 
INSERT INTO inventory (product_id, quantity_on_hand, reorder_level) VALUES
(1, 10, 5),   -- Laptop
(2, 20, 10),  -- Smartphone
(3, 50, 15),  -- Bluetooth Speaker
(4, 30, 10),  -- LED TV 43"
(5, 25, 5),   -- Microwave Oven
(6, 15, 5),   -- Refrigerator
(7, 12, 5),   -- Washing Machine
(8, 40, 10),  -- Electric Kettle
(9, 8, 3),    -- Air Conditioner
(10, 35, 10), -- Ceiling Fan
(11, 20, 5),  -- Office Chair
(12, 18, 5),  -- Study Desk
(13, 10, 3),  -- Sofa Set
(14, 6, 2),   -- Dining Table
(15, 14, 5),  -- Wardrobe
(16, 22, 5),  -- Bed Frame
(17, 30, 10), -- Bookshelf
(18, 25, 5),  -- TV Stand
(19, 18, 5),  -- Office Cabinet
(20, 50, 15), -- Mattress 6x4
(21, 40, 10), -- Rice Cooker
(22, 15, 5),  -- Gas Cooker
(23, 60, 20), -- Blender
(24, 45, 15), -- Toaster
(25, 35, 10), -- Cookware Set
(26, 25, 5),  -- Juicer
(27, 12, 3),  -- Deep Fryer
(28, 30, 10), -- Dish Rack
(29, 20, 5),  -- Water Dispenser
(30, 18, 5);  -- Pressure Cooker

-- Insert Orders (Now includes Delivery Date and Tracking Number)
INSERT INTO orders (customer_id, order_date, total_amount, status, delivery_date, tracking_number) VALUES
(1, '2023-01-15 10:00:00', 1250.00, 'Delivered', '2023-01-18 14:00:00', 'TRK-1001'),
(1, '2023-02-10 14:30:00', 150.00, 'Shipped', NULL, 'TRK-1002'),
(2, '2023-01-20 09:15:00', 800.00, 'Delivered', '2023-01-22 10:00:00', 'TRK-2001'),
(3, '2023-03-05 11:00:00', 1200.00, 'Pending', NULL, NULL),
(4, '2023-01-25 16:45:00', 2500.00, 'Delivered', '2023-01-28 11:30:00', 'TRK-3001'),
(5, '2023-02-15 12:00:00', 60.00, 'Cancelled', NULL, NULL),
(6, '2023-03-10 09:30:00', 950.00, 'Delivered', '2023-03-13 15:00:00', 'TRK-4001'),
(7, '2023-04-01 13:45:00', 450.00, 'Shipped', NULL, 'TRK-5001'),
(8, '2023-04-12 10:20:00', 1300.00, 'Pending', NULL, NULL),
(9, '2023-04-15 15:00:00', 220.00, 'Delivered', '2023-04-17 12:30:00', 'TRK-6001'),
(10, '2023-05-01 11:15:00', 780.00, 'Delivered', '2023-05-04 16:00:00', 'TRK-7001'),
(11, '2023-05-08 14:00:00', 310.00, 'Shipped', NULL, 'TRK-8001'),
(12, '2023-05-15 09:50:00', 1200.00, 'Pending', NULL, NULL),
(13, '2023-05-20 16:20:00', 1800.00, 'Delivered', '2023-05-23 13:45:00', 'TRK-9001'),
(14, '2023-06-05 10:30:00', 250.00, 'Cancelled', NULL, NULL),
(15, '2023-06-10 12:45:00', 600.00, 'Delivered', '2023-06-12 15:00:00', 'TRK-10001'),
(16, '2023-06-15 11:10:00', 90.00, 'Shipped', NULL, 'TRK-11001'),
(17, '2023-06-20 14:35:00', 1400.00, 'Pending', NULL, NULL),
(18, '2023-07-01 09:05:00', 320.00, 'Delivered', '2023-07-03 10:30:00', 'TRK-12001'),
(19, '2023-07-05 16:45:00', 500.00, 'Delivered', '2023-07-08 13:00:00', 'TRK-13001'),
(20, '2023-07-10 10:25:00', 75.00, 'Cancelled', NULL, NULL),
(21, '2023-07-15 13:15:00', 2200.00, 'Shipped', NULL, 'TRK-14001'),
(22, '2023-07-20 09:40:00', 1100.00, 'Pending', NULL, NULL),
(23, '2023-07-25 15:30:00', 890.00, 'Delivered', '2023-07-28 11:15:00', 'TRK-15001'),
(24, '2023-08-01 12:00:00', 430.00, 'Shipped', NULL, 'TRK-16001'),
(25, '2023-08-05 10:10:00', 650.00, 'Delivered', '2023-08-08 14:45:00', 'TRK-17001');

-- Insert Order Items 
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase, discount_amount) VALUES
(1, 1, 1, 1200.00, 0.00), 
(1, 4, 2, 25.00, 5.00),  -- Order 1 items
(2, 3, 1, 150.00, 0.00), -- Order 2 items
(3, 2, 1, 800.00, 20.00),-- Order 3 items
(4, 1, 1, 1200.00, 0.00), 
(4, 2, 1, 800.00, 0.00), -- Order 4 items
(5, 5, 1, 60.00, 0.00),  -- Order 5 items
(6, 6, 1, 950.00, 0.00), -- Order 6 items
(7, 7, 2, 450.00, 10.00),-- Order 7 items
(8, 8, 1, 1300.00, 50.00),-- Order 8 items
(9, 9, 3, 220.00, 15.00), -- Order 9 items
(10, 10, 1, 780.00, 0.00),-- Order 10 items
(11, 11, 2, 310.00, 20.00),-- Order 11 items
(12, 12, 1, 1200.00, 0.00),-- Order 12 items
(13, 13, 1, 1800.00, 100.00),-- Order 13 items
(14, 14, 1, 250.00, 0.00), -- Order 14 items
(15, 15, 1, 600.00, 50.00), -- Order 15 items
(16, 16, 1, 90.00, 0.00),   -- Order 16 items
(17, 17, 2, 1400.00, 200.00),-- Order 17 items
(18, 18, 1, 320.00, 0.00),   -- Order 18 items
(19, 19, 1, 500.00, 0.00),   -- Order 19 items
(20, 20, 1, 75.00, 0.00),    -- Order 20 items
(21, 21, 2, 2200.00, 100.00),-- Order 21 items
(22, 22, 1, 1100.00, 0.00),  -- Order 22 items
(23, 23, 1, 890.00, 50.00),  -- Order 23 items
(24, 24, 1, 430.00, 0.00),   -- Order 24 items
(25, 25, 1, 650.00, 0.00);   -- Order 25 items


-- 1. Business KPIs


-- Q1: Total Revenue (from 'Shipped' or 'Delivered' orders)
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status IN ('Shipped', 'Delivered');

-- Q2: Top 10 Customers by Total Spending 
SELECT 
    c.full_name, 
    c.city,
    c.country,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id, c.full_name, c.city, c.country
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Best-Selling Products (by Quantity Sold)
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
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE status IN ('Shipped', 'Delivered')
GROUP BY sales_month
ORDER BY sales_month;


-- 2. Analytical Queries (Window Functions)

-- Q5: Sales Rank by Category
SELECT 
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.price_at_purchase) AS product_revenue,
    RANK() OVER (
        PARTITION BY p.category 
        ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC
    ) as rank_in_category
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.category, p.product_name, p.product_id;

-- Q6: Customer Order Frequency
SELECT 
    c.full_name,
    o.order_date AS current_order_date,
    LAG(o.order_date) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS previous_order_date,
    o.order_date - LAG(o.order_date) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
    ) AS days_since_last_order
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;


-- 3. Performance Optimization (Views & Procedures)


-- Create View: CustomerSalesSummary
CREATE OR REPLACE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    c.full_name,
    c.email,
    c.city,
    c.country,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_lifetime_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status IN ('Shipped', 'Delivered') OR o.status IS NULL
GROUP BY c.customer_id, c.full_name, c.email, c.city, c.country;

-- Stored Procedure: ProcessNewOrder
CREATE OR REPLACE PROCEDURE ProcessNewOrder(
    p_customer_id INT,
    p_product_id INT,
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price DECIMAL(10, 2);
    v_current_stock INT;
    v_new_order_id INT;
BEGIN
    -- 1. Check current stock and price
    SELECT quantity_on_hand, price INTO v_current_stock, v_price
    FROM inventory i
    JOIN products p ON i.product_id = p.product_id
    WHERE i.product_id = p_product_id;

    -- 2. Validate Stock
    IF v_current_stock IS NULL THEN
        RAISE EXCEPTION 'Product % not found in inventory', p_product_id;
    END IF;

    IF v_current_stock < p_quantity THEN
        RAISE EXCEPTION 'Insufficient stock. Available: %, Requested: %', v_current_stock, p_quantity;
    END IF;

    -- 3. Execute Transaction Logic
    -- Reduce Inventory
    UPDATE inventory 
    SET quantity_on_hand = quantity_on_hand - p_quantity
    WHERE product_id = p_product_id;

    -- Create Order Header (Initial status Pending)
    INSERT INTO orders (customer_id, total_amount, status)
    VALUES (p_customer_id, (v_price * p_quantity), 'Pending')
    RETURNING order_id INTO v_new_order_id;

    -- Create Order Item 
    INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase, discount_amount)
    VALUES (v_new_order_id, p_product_id, p_quantity, v_price, 0.00);

    RAISE NOTICE 'Order % processed successfully', v_new_order_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Transaction rolled back: %', SQLERRM;
END;
$$;