CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    payment_method VARCHAR(255) NOT NULL,
    payment_status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    review TEXT NOT NULL,
    rating INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name, email, password) VALUES ('John Doe', 'john@example.com', 'password123');
INSERT INTO users (name, email, password) VALUES ('Jane Doe', 'jane@example.com', 'password123');

INSERT INTO products (name, description, price) VALUES ('Product 1', 'This is product 1', 19.99);
INSERT INTO products (name, description, price) VALUES ('Product 2', 'This is product 2', 9.99);

INSERT INTO orders (user_id, product_id, quantity, total) VALUES (1, 1, 2, 39.98);
INSERT INTO orders (user_id, product_id, quantity, total) VALUES (2, 2, 1, 9.99);

INSERT INTO payments (order_id, payment_method, payment_status) VALUES (1, 'Credit Card', 'Paid');
INSERT INTO payments (order_id, payment_method, payment_status) VALUES (2, 'PayPal', 'Paid');

INSERT INTO reviews (product_id, user_id, review, rating) VALUES (1, 1, 'This product is great!', 5);
INSERT INTO reviews (product_id, user_id, review, rating) VALUES (2, 2, 'This product is okay.', 3);

SELECT * FROM users;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM reviews;

SELECT u.name, p.name, o.quantity, p.price 
FROM users u 
JOIN orders o ON u.id = o.user_id 
JOIN products p ON o.product_id = p.id;

SELECT u.name, p.name, r.review, r.rating 
FROM users u 
JOIN reviews r ON u.id = r.user_id 
JOIN products p ON r.product_id = p.id;

SELECT o.id, u.name, p.name, o.quantity, p.price 
FROM orders o 
JOIN users u ON o.user_id = u.id 
JOIN products p ON o.product_id = p.id 
WHERE o.total > 10;

SELECT p.name, AVG(r.rating) 
FROM products p 
JOIN reviews r ON p.id = r.product_id 
GROUP BY p.name 
ORDER BY AVG(r.rating) DESC;

SELECT p.name, SUM(o.quantity) 
FROM products p 
JOIN orders o ON p.id = o.product_id 
GROUP BY p.name 
ORDER BY SUM(o.quantity) DESC;