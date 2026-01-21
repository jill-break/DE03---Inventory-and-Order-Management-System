-- =============================================
-- Capstone Project: UUID Implementation
-- Part 1: DDL (Schema)
-- =============================================

-- 1. EXTENSION SETUP
-- Required for generating random UUIDs (Standard in Postgres 13+, needed via pgcrypto in older)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 2. CLEANUP
DROP TABLE IF EXISTS system_error_log;
DROP TABLE IF EXISTS inventory_audit_log;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TYPE IF EXISTS order_status_type;

-- 3. ENUM
CREATE TYPE order_status_type AS ENUM ('Pending', 'Shipped', 'Delivered', 'Cancelled');

-- 4. TABLES WITH UUIDs

CREATE TABLE customers (
    -- Change: UUID type with random default
    customer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    shipping_address TEXT NOT NULL,
    city VARCHAR(100),       
    country VARCHAR(100),    
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name VARCHAR(255) NOT NULL,
    description TEXT,        
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inventory (
    inventory_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- FK must match the UUID type of products
    product_id UUID UNIQUE NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
    quantity_on_hand INT NOT NULL DEFAULT 0 CHECK (quantity_on_hand >= 0),
    reorder_level INT DEFAULT 10, 
    last_updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    delivery_date TIMESTAMPTZ,       
    tracking_number VARCHAR(100),    
    total_amount DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (total_amount >= 0),
    status order_status_type DEFAULT 'Pending',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00, 
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 5. LOGGING TABLES (Updated for UUID FKs)

CREATE TABLE inventory_audit_log (
    log_id SERIAL PRIMARY KEY, -- Logs usually keep Serial for easy sorting
    product_id UUID NOT NULL,  -- Must match Product UUID
    old_quantity INT,
    new_quantity INT,
    change_type VARCHAR(50),
    changed_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE system_error_log (
    error_id SERIAL PRIMARY KEY,
    procedure_name VARCHAR(100),
    error_code VARCHAR(50),
    error_message TEXT,
    occurred_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 6. INDEXES
CREATE INDEX idx_inventory_product_id ON inventory(product_id);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_orders_order_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 
CREATE INDEX idx_products_category ON products(category);