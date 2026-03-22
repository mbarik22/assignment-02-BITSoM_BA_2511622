DROP DATABASE IF EXISTS retailstar;

 CREATE DATABASE retailstar;
 use retailstar;

-- STAR SCHEMA 
-- Data Cleaning Assumptions Applied
   -- Dates → standardized to YYYY-MM-DD
   -- NULL values → replaced with defaults (Unknown, 0)
   -- Category casing → standardized to UPPERCASE
   -- Duplicate formats unified

-- 1. Dimension Table: dim_date
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    year INT,
    quarter INT
);

-- 2. Dimension Table: dim_store
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- 3. Dimension Table: dim_product
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- 4. Fact Table: fact_sales
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- INSERT SAMPLE DATA
 
 -- INSERT: Dimension Tables
 -- dim_date
 INSERT INTO dim_date VALUES
(1, '2025-01-01', 1, 1, 2025, 1),
(2, '2025-01-02', 2, 1, 2025, 1),
(3, '2025-01-03', 3, 1, 2025, 1),
(4, '2025-01-04', 4, 1, 2025, 1),
(5, '2025-01-05', 5, 1, 2025, 1);

-- dim_store
INSERT INTO dim_store VALUES
(1, 'Store A', 'Mumbai', 'Maharashtra'),
(2, 'Store B', 'Delhi', 'Delhi'),
(3, 'Store C', 'Bangalore', 'Karnataka');

-- dim_product
INSERT INTO dim_product VALUES
(1, 'Laptop', 'ELECTRONICS'),
(2, 'Mobile', 'ELECTRONICS'),
(3, 'Shirt', 'APPAREL'),
(4, 'Shoes', 'APPAREL'),
(5, 'Headphones', 'ELECTRONICS');

-- INSERT: Fact Table (10 cleaned rows)
INSERT INTO fact_sales VALUES
(1, 1, 1, 1, 2, 50000.00, 100000.00),
(2, 1, 2, 2, 1, 20000.00, 20000.00),
(3, 2, 1, 3, 3, 1500.00, 4500.00),
(4, 2, 3, 4, 2, 3000.00, 6000.00),
(5, 3, 2, 5, 1, 2500.00, 2500.00),
(6, 3, 1, 2, 2, 21000.00, 42000.00),
(7, 4, 3, 1, 1, 52000.00, 52000.00),
(8, 4, 2, 3, 4, 1400.00, 5600.00),
(9, 5, 1, 4, 2, 3200.00, 6400.00),
(10, 5, 3, 5, 3, 2300.00, 6900.00);
