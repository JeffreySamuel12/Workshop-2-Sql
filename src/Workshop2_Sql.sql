-- Creating the 'customers' table
CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        name VARCHAR(255),
email VARCHAR(255)
);

INSERT INTO customers (customer_id, name, email) VALUES
(1, 'John Doe', 'john.doe@example.com'),
        (2, 'Jane Smith', 'jane.smith@example.com'),
        (3, 'Alice Johnson', 'alice.johnson@example.com'),
        (4, 'Bob Brown', 'bob.brown@example.com'),
        (5, 'Carol Davis', 'carol.davis@example.com'),
        (6, 'David Wilson', 'david.wilson@example.com'),
        (7, 'Emily Clark', 'emily.clark@example.com'),
        (8, 'Frank Harris', 'frank.harris@example.com'),
        (9, 'Grace Lewis', 'grace.lewis@example.com'),
        (10, 'Hannah Walker', 'hannah.walker@example.com');

select * from customers;

-- Creating the 'orders' table
CREATE TABLE orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        total_amount DECIMAL(10, 2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        );

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
        (1, 1, '2024-08-01', 250.00),
(2, 2, '2024-08-02', 150.50),
        (3, 3, '2024-08-03', 99.99),
        (4, 4, '2024-08-04', 299.90),
        (5, 5, '2024-08-05', 189.75),
        (6, 6, '2024-08-06', 349.20),
        (7, 7, '2024-08-07', 129.45),
        (8, 8, '2024-08-08', 89.99),
        (9, 9, '2024-08-09', 499.99),
        (10, 10, '2024-08-10', 75.00),
        (11, 1, '2024-08-11', 400.50),
        (12, 2, '2024-08-12', 220.00),
        (13, 3, '2024-08-13', 105.25),
        (14, 4, '2024-08-14', 215.30),
        (15, 5, '2024-08-15', 310.00);

select * from orders;


-- Creating the 'products' table
CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(255),
price DECIMAL(10, 2)

);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop', 999.99),
        (2, 'Smartphone', 499.99),
        (3, 'Headphones', 89.99),
        (4, 'Keyboard', 45.99),
        (5, 'Mouse', 25.99),
        (6, 'Monitor', 199.99),
        (7, 'Printer', 129.99),
        (8, 'Tablet', 349.99),
        (9, 'Webcam', 59.99),
        (10, 'External Hard Drive', 129.99);

select * from products;


-- Creating the 'order_items' table
CREATE TABLE order_items (
        order_item_id INT PRIMARY KEY,
        order_id INT,
        product_id INT,
        quantity INT,
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
        );

INSERT INTO order_items (order_item_id, order_id, product_id,
                         quantity) VALUES
(1, 1, 1, 1), -- 1 Laptop
        (2, 1, 3, 2), -- 2 Headphones
        (3, 2, 2, 1), -- 1 Smartphone
        (4, 2, 5, 1), -- 1 Mouse
        (5, 3, 4, 1), -- 1 Keyboard
        (6, 4, 6, 2), -- 2 Monitors
        (7, 5, 7, 1), -- 1 Printer
        (8, 6, 8, 1), -- 1 Tablet
        (9, 7, 9, 1), -- 1 Webcam
        (10, 8, 3, 1), -- 1 Headphones
        (11, 9, 10, 1), -- 1 External Hard Drive
        (12, 10, 2, 1), -- 1 Smartphone
        (13, 11, 1, 1), -- 1 Laptop
        (14, 12, 6, 1), -- 1 Monitor
        (15, 13, 4, 1), -- 1 Keyboard
        (16, 14, 8, 1), -- 1 Tablet
        (17, 15, 5, 2); -- 2 Mice

select * from order_items;


-- Creating the 'categories' table
CREATE TABLE categories (
        category_id INT PRIMARY KEY,
        category_name VARCHAR(255)
);

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
        (2, 'Accessories'),
        (3, 'Computers'),
        (4, 'Office Supplies'),
        (5, 'Mobile Devices')

select * from categories;

--Queries Starting
--3
SELECT c.customer_id, c.name, o.order_id, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = 2;

        --4
SELECT p.product_name,p.product_id, c.category_name
FROM products p
INNER JOIN categories c ON p.product_id = c.category_id;

--5
SELECT order_items.order_id, products.product_name, order_items.quantity
FROM order_items
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN products ON order_items.product_id = products.product_id
WHERE order_items.order_id = 4;

        --6

SELECT c.customer_id, c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > 100.00;

        --7
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_amount_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

--8
SELECT p.product_name, SUM(o.quantity * p.price) AS total_sales_amount
FROM order_items o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;




--11
UPDATE products
SET price = price * (1 + 0.10);

select * from products;

--14
ALTER TABLE products
ADD stock_quantity INT;

select * from products;


--16
SELECT customers.*
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.order_date >= CURRENT_DATE - INTERVAL '30 days';

        --17
SELECT products.product_name, SUM(order_items.quantity * products.price) AS total_sales_amount
FROM order_items
INNER JOIN products
ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sales_amount DESC
LIMIT 5;







