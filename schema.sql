CREATE database dbms;
USE dbms;

-- Table: category
CREATE TABLE category (
    category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Table: subcategory
CREATE TABLE subcategory (
    subcategory_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    subcategory_name VARCHAR(50),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Table: supplier
CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255),
    email VARCHAR(255)
);

-- Table: product
CREATE TABLE product (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    description TEXT,
    subcategory_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),    FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);


-- Table: marketing_campaigns
CREATE TABLE marketing_campaigns (
    campaign_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(255),
    offer_week INT
);

-- Table: campaign_product_subcategory
CREATE TABLE campaign_product_subcategory (
    campaign_product_subcategory_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    campaign_id INT,
    subcategory_id INT,
    discount DECIMAL(3,2),
    FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);

-- Table: customer
CREATE TABLE customer (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    country VARCHAR(100)
);

-- Table: customer_product_ratings
CREATE TABLE customer_product_ratings (
    customerproductrating_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    ratings DECIMAL(2,1),
    review VARCHAR(255),
    sentiment VARCHAR(10),

    FOREIGN KEY (product_id) REFERENCES product(product_id),
    CHECK (ratings >= 1 AND ratings <= 5)
);

-- Table: payment_method
CREATE TABLE payment_method (
    payment_method_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(50)
);

-- Table: orders
CREATE TABLE orders (
    order_id_surrogate INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date DATE,
    campaign_id INT,
    amount INT,
    payment_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

-- Table: orderitem
CREATE TABLE orderitem (
    orderitem_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    supplier_id INT,
    subtotal DECIMAL(10,2),
    discount DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id_surrogate),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- Table: returns
CREATE TABLE returns (
    return_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    return_date DATE,
    reason TEXT,
    amount_refunded DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id_surrogate),
    FOREIGN KEY (product_id) REFERENCES product(product_id));


 INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (1, 1, 1, 1, 799.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (2, 2, 1, 2, 59.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (3, 3, 1, 3, 119.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (4, 4, 1, 4, 24.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (5, 5, 1, 5, 34.99, 0.00);
INSERT INTO returns (order_id, product_id, return_date, reason, amount_refunded) VALUES (1, 1, '2023-01-20', 'Defective item', 799.99);
INSERT INTO returns (order_id, product_id, return_date, reason, amount_refunded) VALUES (2, 2, '2023-02-25', 'Size mismatch', 59.99);
INSERT INTO returns (order_id, product_id, return_date, reason, amount_refunded) VALUES (3, 3, '2023-03-10', 'Changed mind', 119.99);
INSERT INTO returns (order_id, product_id, return_date, reason, amount_refunded) VALUES (4, 4, '2023-04-15', 'Wrong product', 24.99);
INSERT INTO returns (order_id, product_id, return_date, reason, amount_refunded) VALUES (5, 5, '2023-05-20', 'Missing parts', 34.99);
INSERT INTO orders (order_id, customer_id, order_date, campaign_id, amount, payment_method_id) VALUES (1, 1, '2023-01-15', 1, 800, 1);
INSERT INTO orders (order_id, customer_id, order_date, campaign_id, amount, payment_method_id) VALUES (2, 2, '2023-02-20', 2, 60, 2);
INSERT INTO orders (order_id, customer_id, order_date, campaign_id, amount, payment_method_id) VALUES (3, 3, '2023-03-05', 3, 120, 3);
INSERT INTO orders (order_id, customer_id, order_date, campaign_id, amount, payment_method_id) VALUES (4, 4, '2023-04-10', 4, 25, 4);
INSERT INTO orders (order_id, customer_id, order_date, campaign_id, amount, payment_method_id) VALUES (5, 5, '2023-05-15', 5, 35, 5);

INSERT INTO subcategory (subcategory_name, category_id) VALUES ('Smartphones', 1);
INSERT INTO subcategory (subcategory_name, category_id) VALUES ('Jeans', 2);
INSERT INTO subcategory (subcategory_name, category_id) VALUES ('Microwaves', 3);
INSERT INTO subcategory (subcategory_name, category_id) VALUES ('Science Fiction', 4);
INSERT INTO subcategory (subcategory_name, category_id) VALUES ('Board Games', 5);
INSERT INTO supplier (supplier_name, email) VALUES ('TechSupply Inc.', 'contact@techsupply.com');
INSERT INTO supplier (supplier_name, email) VALUES ('FashionFwd', 'info@fashionfwd.com');
INSERT INTO supplier (supplier_name, email) VALUES ('HomeGoods Co.', 'support@homegoods.com');
INSERT INTO supplier (supplier_name, email) VALUES ('BookWorld Publishers', 'publishing@bookworld.com');
INSERT INTO supplier (supplier_name, email) VALUES ('ToyZone', 'sales@toyzone.com');
INSERT INTO product (name, price, description, subcategory_id) VALUES ('iPhone 12', 799.99, 'Latest Apple smartphone', 1);
INSERT INTO product (name, price, description, subcategory_id) VALUES ('Levi’s Jeans', 59.99, 'Classic denim jeans', 2);
INSERT INTO product (name, price, description, subcategory_id) VALUES ('Panasonic Microwave', 120.00, 'Compact microwave oven', 3);
INSERT INTO product (name, price, description, subcategory_id) VALUES ('Dune', 24.99, 'Science fiction novel', 4);
INSERT INTO product (name, price, description, subcategory_id) VALUES ('Chess Board', 34.99, 'Wooden chess board with pieces', 5);
INSERT INTO marketing_campaigns (campaign_name, offer_week) VALUES ('Summer Sale', 25);
INSERT INTO marketing_campaigns (campaign_name, offer_week) VALUES ('Black Friday', 48);
INSERT INTO marketing_campaigns (campaign_name, offer_week) VALUES ('Cyber Monday', 49);
INSERT INTO marketing_campaigns (campaign_name, offer_week) VALUES ('Christmas Deals', 51);
INSERT INTO marketing_campaigns (campaign_name, offer_week) VALUES ('New Year Sale', 1);
INSERT INTO campaign_product_subcategory (campaign_id, subcategory_id, discount) VALUES (1, 1, 0.10);
INSERT INTO campaign_product_subcategory (campaign_id, subcategory_id, discount) VALUES (2, 2, 0.15);
INSERT INTO campaign_product_subcategory (campaign_id, subcategory_id, discount) VALUES (3, 3, 0.20);
INSERT INTO campaign_product_subcategory (campaign_id, subcategory_id, discount) VALUES (4, 4, 0.25);
INSERT INTO campaign_product_subcategory (campaign_id, subcategory_id, discount) VALUES (5, 5, 0.30);
INSERT INTO customer (first_name, last_name, email, country) VALUES ('John', 'Doe', 'john.doe@example.com', 'USA');
INSERT INTO customer (first_name, last_name, email, country) VALUES ('Jane', 'Doe', 'jane.doe@example.com', 'Canada');
INSERT INTO customer (first_name, last_name, email, country) VALUES ('Alice', 'Smith', 'alice.smith@example.com', 'UK');
INSERT INTO customer (first_name, last_name, email, country) VALUES ('Bob', 'Johnson', 'bob.johnson@example.com', 'Australia');
INSERT INTO customer (first_name, last_name, email, country) VALUES ('Carlos', 'Garcia', 'carlos.garcia@example.com', 'Mexico');
INSERT INTO customer_product_ratings (customer_id, product_id, ratings, review, sentiment) VALUES (1, 1, 4.5, 'Great product', 'Positive');
INSERT INTO customer_product_ratings (customer_id, product_id, ratings, review, sentiment) VALUES (2, 2, 4.0, 'Comfortable jeans', 'Positive');
INSERT INTO customer_product_ratings (customer_id, product_id, ratings, review, sentiment) VALUES (3, 3, 3.5, 'Useful but noisy', 'Neutral');
INSERT INTO customer_product_ratings (customer_id, product_id, ratings, review, sentiment) VALUES (4, 4, 5.0, 'Excellent read', 'Positive');
INSERT INTO customer_product_ratings (customer_id, product_id, ratings, review, sentiment) VALUES (5, 5, 2.5, 'Pieces missing', 'Negative');
INSERT INTO payment_method (payment_method) VALUES ('Credit Card');
INSERT INTO payment_method (payment_method) VALUES ('PayPal');
INSERT INTO payment_method (payment_method) VALUES ('Bank Transfer');
INSERT INTO payment_method (payment_method) VALUES ('Bitcoin');
INSERT INTO payment_method (payment_method) VALUES ('Gift Card');
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (1, 1, 1, 1, 799.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (2, 2, 1, 2, 59.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (3, 3, 1, 3, 119.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (4, 4, 1, 4, 24.99, 0.00);
INSERT INTO orderitem (order_id, product_id, quantity, supplier_id, subtotal, discount) VALUES (5, 5, 1, 5, 34.99, 0.00);


