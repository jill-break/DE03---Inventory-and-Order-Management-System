### E-commerce Inventory & Order Management System
### 1. Entity-Relationship Diagram (ERD)
The following diagram illustrates the normalized (3NF) schema designed for this project. It now includes all attributes from the diagram, including audit timestamps and tracking details.

entity_relationship_diagram.png


    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    PRODUCTS ||--|{ ORDER_ITEMS : "included in"
    PRODUCTS ||--|| INVENTORY : "stocked in"

    CUSTOMERS {
        int customer_id PK
        string full_name
        string email
        string phone
        string shipping_address
        string city
        string country
        datetime created_at
    }

    PRODUCTS {
        int product_id PK
        string product_name
        string description
        string category
        decimal price
        datetime created_at
    }

    INVENTORY {
        int inventory_id PK
        int product_id FK
        int quantity_on_hand
        int reorder_level
        datetime last_updated
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        datetime order_date
        datetime delivery_date
        string tracking_number
        decimal total_amount
        enum status
        datetime created_at
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal price_at_purchase
        decimal discount_amount
        datetime created_at
    }


### 2. Design Choices & Constraints
Normalization (3NF)1NF: All columns contain atomic values.

**2NF:** All non-key attributes are dependent on the primary key. 
We separated Inventory into its own table (1:1 with Product) to logically separate "Catalog Data" (Product Name, Price) from "Operational Data" (Current Stock).

**3NF:** No transitive dependencies. 
Customer details (including City/Country) are stored once in the Customers table, not repeated in every Order.

**ConstraintsPrimary Keys:** Used SERIAL for auto-incrementing IDs on all tables.

**Foreign Keys:** ON DELETE CASCADE is used for Orders -> Order Items to ensure if an order is deleted, its items are too.

**Data Integrity:** CHECK (price >= 0) and CHECK (quantity >= 0) prevent bad data.

**TIMESTAMPTZ** ensures timezone-aware date tracking.

### 3. How to Run
**Execute ecommerce_lab_ddl.sql**
First to build the empty database structure.

**Execute ecommerce_lab_dml.sql**
to populate sample data and run the analysis queries.