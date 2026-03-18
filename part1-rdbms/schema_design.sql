DROP DATABASE IF EXISTS classicmodels;

SHOW DATABASES;

CREATE DATABASE  IF NOT EXISTS classicmodels;

USE classicmodels;

/* Create the tables */

/* Customers Table*/
CREATE TABLE customers (
    customer_id      VARCHAR(20) PRIMARY KEY,
    customer_name    VARCHAR(100) NOT NULL,
    customer_email   VARCHAR(150) NOT NULL UNIQUE,
    customer_city    VARCHAR(100) NOT NULL
);

/* Products Table*/
CREATE TABLE products (
    product_id     VARCHAR(20) PRIMARY KEY,
    product_name   VARCHAR(150) NOT NULL,
    category       VARCHAR(100) NOT NULL,
    unit_price     DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0)
);

/* Offices Table */
CREATE TABLE offices (
    office_id        VARCHAR(20) PRIMARY KEY,
    office_address   VARCHAR(255) NOT NULL
);

/*Sales Representatives */
CREATE TABLE sales_reps (
    sales_rep_id     VARCHAR(20) PRIMARY KEY,
    sales_rep_name   VARCHAR(100) NOT NULL,
    sales_rep_email  VARCHAR(150) NOT NULL UNIQUE,
    office_id        VARCHAR(20) NOT NULL,

    CONSTRAINT fk_salesrep_office
        FOREIGN KEY (office_id)
        REFERENCES offices(office_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* Orders Table */
CREATE TABLE orders (
    order_id       VARCHAR(20) PRIMARY KEY,
    order_date     DATE NOT NULL,
    customer_id    VARCHAR(20) NOT NULL,
    sales_rep_id   VARCHAR(20) NOT NULL,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON UPDATE CASCADE                     /*If an order is deleted → its items should also go*/
        ON DELETE RESTRICT,                   /*Prevents accidental data loss (fixes delete anomaly)*/

    CONSTRAINT fk_orders_salesrep
        FOREIGN KEY (sales_rep_id)
        REFERENCES sales_reps(sales_rep_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT                    /*Prevents accidental data loss (fixes delete anomaly)*/
);

/*Order Items (Junction Table) */
CREATE TABLE order_items (
    order_id     VARCHAR(20) NOT NULL,
    product_id   VARCHAR(20) NOT NULL,
    quantity     INT NOT NULL CHECK (quantity > 0),

    PRIMARY KEY (order_id, product_id),

    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*INSERT statements to populate at least 5 rows per table*/

INSERT INTO offices (office_id, office_address) VALUES
('OFF1', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('OFF2', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('OFF3', 'Bangalore Tech Park, Whitefield, Bangalore - 560066'),
('OFF4', 'Hyderabad Hub, HITEC City, Hyderabad - 500081'),
('OFF5', 'Chennai Branch, T Nagar, Chennai - 600017');

INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_id) VALUES
('SR1', 'Amit Sharma', 'amit.sharma@company.com', 'OFF1'),
('SR2', 'Neha Verma', 'neha.verma@company.com', 'OFF2'),
('SR3', 'Rahul Nair', 'rahul.nair@company.com', 'OFF3'),
('SR4', 'Sneha Reddy', 'sneha.reddy@company.com', 'OFF4'),
('SR5', 'Karthik Iyer', 'karthik.iyer@company.com', 'OFF5');

INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('CUST1', 'Ravi Kumar', 'ravi.kumar@email.com', 'Hyderabad'),
('CUST2', 'Priya Singh', 'priya.singh@email.com', 'Delhi'),
('CUST3', 'Arjun Mehta', 'arjun.mehta@email.com', 'Mumbai'),
('CUST4', 'Divya Nair', 'divya.nair@email.com', 'Bangalore'),
('CUST5', 'Vikram Patel', 'vikram.patel@email.com', 'Ahmedabad');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P101', 'Laptop', 'Electronics', 75000.00),
('P102', 'Smartphone', 'Electronics', 25000.00),
('P103', 'Office Chair', 'Furniture', 8500.00),
('P104', 'Desk Table', 'Furniture', 12000.00),
('P105', 'Headphones', 'Accessories', 3000.00);

INSERT INTO orders (order_id, order_date, customer_id, sales_rep_id) VALUES
('ORD1001', '2026-03-01', 'CUST1', 'SR1'),
('ORD1002', '2026-03-02', 'CUST2', 'SR2'),
('ORD1003', '2026-03-03', 'CUST3', 'SR3'),
('ORD1004', '2026-03-04', 'CUST4', 'SR4'),
('ORD1005', '2026-03-05', 'CUST5', 'SR5');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
('ORD1001', 'P101', 1),
('ORD1001', 'P105', 2),

('ORD1002', 'P102', 1),
('ORD1002', 'P105', 1),

('ORD1003', 'P103', 2),

('ORD1004', 'P104', 1),
('ORD1004', 'P103', 1),

('ORD1005', 'P101', 1),
('ORD1005', 'P102', 1);