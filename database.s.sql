-- Tabel User
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_type ENUM('farmer', 'customer'),
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    profile_picture VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Farmer
CREATE TABLE Farmer (
    farmer_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    farm_name VARCHAR(255),
    farm_description TEXT,
    farm_location POINT, -- Gunakan tipe data geometri untuk koordinat lokasi
    farm_address VARCHAR(255),
    farm_certificate VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Tabel Product
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT,
    product_name VARCHAR(255),
    product_description TEXT,
    product_category VARCHAR(255),
    product_subcategory VARCHAR(255),
    product_price DECIMAL(10,2),
    product_stock INT,
    product_unit VARCHAR(20),
    product_image VARCHAR(255),
    product_quality VARCHAR(255),
    product_availability JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id)
);

-- Tabel Order
CREATE TABLE Order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_status ENUM('pending', 'confirmed', 'shipped', 'delivered'),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_total DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES User(user_id)
);

-- Tabel Order_Item
CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    product_quantity INT,
    product_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Order(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabel Payment
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(255),
    payment_status ENUM('pending', 'confirmed', 'failed'),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_reference VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Order(order_id)
);

-- Tabel Shipping
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipping_method VARCHAR(255),
    shipping_status ENUM('pending', 'shipped', 'delivered'),
    shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_courier VARCHAR(255),
    shipping_tracking_number VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Order(order_id)
);

-- Tabel Review
CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    review_rating INT,
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES User(user_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabel Promo
CREATE TABLE Promo (
    promo_id INT PRIMARY KEY AUTO_INCREMENT,
    promo_name VARCHAR(255),
    promo_discount DECIMAL(10,2),
    promo_start_date DATE,
    promo_end_date DATE,
    promo_terms TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Product_Stock
CREATE TABLE Product_Stock (
    product_stock_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    stock_quantity INT,
    stock_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Tabel Courier
CREATE TABLE Courier (
    courier_id INT PRIMARY KEY AUTO_INCREMENT,
    courier_name VARCHAR(255),
    courier_phone VARCHAR(20),
    courier_location POINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
