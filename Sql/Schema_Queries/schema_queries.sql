CREATE TABLE olist_product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

CREATE TABLE olist_sellers (
    seller_id VARCHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INTEGER NOT NULL,
    seller_city VARCHAR(100),
    seller_state VARCHAR(2)
);

CREATE TABLE olist_customers (
    customer_id VARCHAR(32) PRIMARY KEY,
    customer_unique_id VARCHAR(32) NOT NULL,
    customer_zip_code_prefix INTEGER NOT NULL,
    customer_city VARCHAR(100),
    customer_state VARCHAR(2)
);
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INTEGER NOT NULL,
    geolocation_lat NUMERIC(11, 8) NOT NULL,
    geolocation_lng NUMERIC(11, 8) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state VARCHAR(2) NOT NULL
);

CREATE TABLE olist_products (
    product_id VARCHAR(32) PRIMARY KEY,
    product_category_name VARCHAR(100) REFERENCES olist_product_category_translation(product_category_name),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER,
    product_volume_cm3 INTEGER
);

CREATE TABLE olist_orders (
    order_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL REFERENCES olist_customers(customer_id),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    -- Feature Engineered Columns
    order_purchase_date DATE,
    order_purchase_month INTEGER,
    order_purchase_year INTEGER,
    shipping_time_days NUMERIC,
    delivery_time_days NUMERIC,
    delay_days NUMERIC,
    is_late VARCHAR(3)
);

CREATE TABLE olist_order_items (
    order_id VARCHAR(32) NOT NULL REFERENCES olist_orders(order_id),
    order_item_id INTEGER NOT NULL,
    product_id VARCHAR(32) NOT NULL REFERENCES olist_products(product_id),
    seller_id VARCHAR(32) NOT NULL REFERENCES olist_sellers(seller_id),
    shipping_limit_date TIMESTAMP NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    freight_value NUMERIC(10, 2) NOT NULL,
    -- Feature Engineered Column
    item_total_cost NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE olist_order_payments (
    order_id VARCHAR(32) NOT NULL REFERENCES olist_orders(order_id),
    payment_sequential INTEGER NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_installments INTEGER NOT NULL,
    payment_value NUMERIC(10, 2) NOT NULL,
    -- Feature Engineered Column
    Value_per_installment NUMERIC(10, 5),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE olist_order_review (
    review_id VARCHAR(32) PRIMARY KEY,
    order_id VARCHAR(32) NOT NULL REFERENCES olist_orders(order_id),
    review_score INTEGER NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATE NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,
    -- Feature Engineered Columns
    review_polarity VARCHAR(10),
    response_time_days NUMERIC
);
