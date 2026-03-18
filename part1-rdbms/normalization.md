## Anomaly Analysis
An Insert Anomaly: *product_id (Col F)*, *product_name (Col G)*, *category*, *unit_price*

An Update Anomaly: *customer_id (Col B), customer_name (Col C), customer_email (Col D), customer_city (Col E)*

A Delete Anomaly: *order_id (Col A), product_id (Col F), customer_id, sales_rep_id*


## Normalization Justification
Yes, the manager is right that a single table feels simpler initially—but in this dataset, that simplicity breaks quickly.

Refute the position for this case:

1. Data inconsistency:
The dataset contains variations like “Nariman Point” vs “Nariman Pt”. In a single table, this value is repeated across many rows. If not updated everywhere, reports (e.g., GROUP BY office_address) become incorrect.

2. Update anomalies:
A customer (e.g., CUST101) appears in multiple rows. If they move cities, we must update every occurrence. Missing even one row will lead to conflicting data (same customer, different cities).

3. Insert limitations:
 We cannot add a new product or sales rep without creating a full order row (with order_id, customer_id). This forces dummy or NULL data, which is a bad design and blocks real business workflows.

4. Delete risks:
If a product appears in only one order, deleting that order removes the product entirely—causing unintended data loss.

5. Scalability & performance:
Repeating customer, product, and office data increases storage and slows queries as data grows.

6. When a single table is okay: small, read-only, or temporary datasets (e.g., Excel reports).

Conclusion:
Normalization may add a few joins, but it ensures data accuracy, consistency, and scalability.

“Single-table design optimizes for short-term simplicity; normalization ensures long-term correctness and reliability.”