-- Q1: List all customers along with the total number of orders they have placed
SELECT
             c.customer_id,
             c.name,
             COUNT(o.order_id) AS total_orders
         FROM read_csv_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\customers.csv") c
         LEFT JOIN read_json_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\orders.json") o
         ON c.customer_id = o.customer_id
         GROUP BY c.customer_id, c.name
         ORDER BY total_orders DESC;

-- Q2: Find the top 3 customers by total order value
SELECT
             c.customer_id,
             c.name,
             SUM(o.total_amount) AS total_spent
         FROM read_csv_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\customers.csv") c
         JOIN read_json_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\orders.json") o
         ON c.customer_id = o.customer_id
         GROUP BY c.customer_id, c.name
         ORDER BY total_spent DESC
         LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT
             p.product_name
         FROM read_csv_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\customers.csv") c
         JOIN read_json_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\orders.json") o
         ON c.customer_id = o.customer_id
         JOIN read_parquet("C:\assignment-02-BITSoM_BA_2511622\datasets\products.parquet") p
         ON o.order_id = p.order_id
         WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT
        c.name,
        o.order_date,
        p.product_name,
        p.quantity
        FROM read_csv_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\customers.csv") c
        JOIN read_json_auto("C:\assignment-02-BITSoM_BA_2511622\datasets\orders.json") o
        ON c.customer_id = o.customer_id
        JOIN read_parquet("C:\assignment-02-BITSoM_BA_2511622\datasets\products.parquet") p
        ON o.order_id = p.order_id
        ORDER BY o.order_date;

