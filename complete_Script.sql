
-- E-Commerce Database Schema
-- Week 1 Database Project Setup

-- Drop existing tables if they exist
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory_movements;
DROP TABLE IF EXISTS product_suppliers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS promotions;

-- Create Categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Create Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    registration_date DATE NOT NULL,
    birth_date DATE
);

-- Create Suppliers table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(2),
    country VARCHAR(50),
    rating DECIMAL(3,2)
);

-- Create Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT,
    brand VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    weight_kg DECIMAL(5,2),
    dimensions VARCHAR(50),
    description TEXT,
    created_date DATE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    payment_method VARCHAR(50),
    shipping_address VARCHAR(200),
    shipping_city VARCHAR(50),
    shipping_state VARCHAR(2),
    shipping_zip VARCHAR(10),
    shipping_date DATE,
    delivery_date DATE,
    total_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Order Items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date DATE NOT NULL,
    helpful_votes INT DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Create Product Suppliers table (many-to-many relationship)
CREATE TABLE product_suppliers (
    product_id INT,
    supplier_id INT,
    supply_price DECIMAL(10,2),
    lead_time_days INT,
    min_order_quantity INT,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Create Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),
    position VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Create Inventory Movements table
CREATE TABLE inventory_movements (
    movement_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    movement_type VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    movement_date DATE NOT NULL,
    reference_number VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Promotions table
CREATE TABLE promotions (
    promotion_id INT PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    description TEXT,
    discount_percentage DECIMAL(5,2),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT FALSE
);

-- Create indexes for better performance
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_reviews_customer ON reviews(customer_id);
CREATE INDEX idx_inventory_product ON inventory_movements(product_id);
CREATE INDEX idx_inventory_date ON inventory_movements(movement_date);

-- Create Views

-- Customer Summary View
CREATE VIEW customer_summary AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.state,
    COUNT(o.order_id) as total_orders,
    COALESCE(SUM(o.total_amount), 0) as total_spent,
    COALESCE(AVG(o.total_amount), 0) as avg_order_value,
    MAX(o.order_date) as last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city, c.state;

-- Product Performance View
CREATE VIEW product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    cat.category_name,
    p.brand,
    p.price,
    p.stock_quantity,
    COUNT(oi.order_item_id) as times_ordered,
    COALESCE(SUM(oi.quantity), 0) as total_quantity_sold,
    COALESCE(SUM(oi.total_price), 0) as total_revenue,
    COALESCE(AVG(r.rating), 0) as avg_rating,
    COUNT(r.review_id) as review_count
FROM products p
LEFT JOIN categories cat ON p.category_id = cat.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, cat.category_name, p.brand, p.price, p.stock_quantity;

-- Monthly Sales View
CREATE VIEW monthly_sales AS
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') as month_year,
    COUNT(o.order_id) as total_orders,
    COUNT(DISTINCT o.customer_id) as unique_customers,
    SUM(o.total_amount) as total_revenue,
    AVG(o.total_amount) as avg_order_value
FROM orders o
WHERE o.status != 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month_year;

-- Create Stored Procedures

DELIMITER //

-- Stored Procedure: Get Customer Order History
CREATE PROCEDURE GetCustomerOrderHistory(IN customer_id_param INT)
BEGIN
    SELECT 
        o.order_id,
        o.order_date,
        o.status,
        o.total_amount,
        COUNT(oi.order_item_id) as item_count
    FROM orders o
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = customer_id_param
    GROUP BY o.order_id, o.order_date, o.status, o.total_amount
    ORDER BY o.order_date DESC;
END //

-- Stored Procedure: Update Product Stock
CREATE PROCEDURE UpdateProductStock(IN product_id_param INT, IN quantity_change INT, IN movement_type_param VARCHAR(20))
BEGIN
    DECLARE current_stock INT;

    -- Get current stock
    SELECT stock_quantity INTO current_stock FROM products WHERE product_id = product_id_param;

    -- Update stock
    UPDATE products 
    SET stock_quantity = current_stock + quantity_change 
    WHERE product_id = product_id_param;

    -- Log the movement
    INSERT INTO inventory_movements (product_id, movement_type, quantity, movement_date, reference_number)
    VALUES (product_id_param, movement_type_param, quantity_change, CURDATE(), CONCAT('AUTO-', UNIX_TIMESTAMP()));
END //

-- Stored Procedure: Calculate Order Total
CREATE PROCEDURE CalculateOrderTotal(IN order_id_param INT)
BEGIN
    DECLARE order_total DECIMAL(10,2);

    -- Calculate total from order items
    SELECT COALESCE(SUM(total_price), 0) INTO order_total
    FROM order_items 
    WHERE order_id = order_id_param;

    -- Update the order
    UPDATE orders 
    SET total_amount = order_total 
    WHERE order_id = order_id_param;

    SELECT order_total as calculated_total;
END //

DELIMITER ;

-- Create Triggers

DELIMITER //

-- Trigger: Update order total when order items change
CREATE TRIGGER update_order_total_after_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET total_amount = (
        SELECT COALESCE(SUM(total_price), 0) 
        FROM order_items 
        WHERE order_id = NEW.order_id
    ) 
    WHERE order_id = NEW.order_id;
END //

-- Trigger: Update product stock when order item is added
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products 
    SET stock_quantity = stock_quantity - NEW.quantity 
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;

-- Sample Queries for Practice

-- Query 1: Top 10 customers by total spending
-- SELECT * FROM customer_summary ORDER BY total_spent DESC LIMIT 10;

-- Query 2: Products with low stock (less than 10 items)
-- SELECT product_name, stock_quantity FROM products WHERE stock_quantity < 10 ORDER BY stock_quantity;

-- Query 3: Monthly revenue trend
-- SELECT * FROM monthly_sales ORDER BY month_year;

-- Query 4: Top selling products
-- SELECT * FROM product_performance ORDER BY total_quantity_sold DESC LIMIT 10;

-- Query 5: Customer segments by order frequency
-- SELECT 
--   CASE 
--     WHEN total_orders >= 10 THEN 'High Value'
--     WHEN total_orders >= 5 THEN 'Medium Value'
--     ELSE 'Low Value'
--   END as customer_segment,
--   COUNT(*) as customer_count,
--   AVG(total_spent) as avg_spending
-- FROM customer_summary 
-- GROUP BY customer_segment;
