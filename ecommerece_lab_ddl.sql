-- =============================================
-- Capstone Project: E-commerce Inventory & Order Management
-- Step 2: Schema Implementation (DDL)
-- =============================================

-- 1. Clean up existing tables
-- Drop View first to avoid dependency issues
DROP VIEW IF EXISTS CustomerSalesSummary;

-- Drop tables in dependency order
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Drop Enum
DROP TYPE IF EXISTS order_status_type;

-- 2. Create ENUM
CREATE TYPE order_status_type AS ENUM ('Pending', 'Shipped', 'Delivered', 'Cancelled');

-- 3. Create Tables

-- Table: Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    shipping_address TEXT NOT NULL,
    city VARCHAR(100),       
    country VARCHAR(100),    
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Table: Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,        
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Table: Inventory
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INT UNIQUE NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
    quantity_on_hand INT NOT NULL DEFAULT 0 CHECK (quantity_on_hand >= 0),
    reorder_level INT DEFAULT 10, 
    last_updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Table: Orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    delivery_date TIMESTAMPTZ,       
    tracking_number VARCHAR(100),    
    total_amount DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (total_amount >= 0),
    status order_status_type DEFAULT 'Pending',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Table: Order Items
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00, 
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
-- =============================================
-- End of DDL Script
-- =============================================