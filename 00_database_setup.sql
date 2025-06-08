DROP DATABASE IF EXISTS cgm3_casestudy_clothingstoremanager;
CREATE DATABASE cgm3_casestudy_clothingstoremanager CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cgm3_casestudy_clothingstoremanager;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    address TEXT,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE product_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color VARCHAR(50),
    size VARCHAR(20),
    price DECIMAL(12, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    UNIQUE(product_id, color, size),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(15, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    shipping_address TEXT NOT NULL,
    shipping_phone VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_detail_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_detail_id) REFERENCES product_details(id)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating TINYINT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, user_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);

INSERT INTO categories (name) VALUES
('Áo Thun'),
('Áo Sơ Mi'),
('Áo Polo'),
('Áo Khoác');

INSERT INTO products (name, description, category_id) VALUES
('Áo Thun Cổ Tròn Basic', 'Chất liệu 100% cotton, co giãn 4 chiều, thấm hút mồ hôi tốt. Dễ dàng phối đồ.', 1),
('Áo Thun In Hình Graphic', 'Thiết kế độc đáo với hình in nổi bật, thể hiện cá tính riêng.', 1),
('Áo Sơ Mi Dài Tay Oxford', 'Vải Oxford cao cấp, đứng form, mang lại vẻ ngoài lịch lãm, trưởng thành.', 2),
('Áo Polo Pique', 'Vải dệt kiểu mắt chim (pique) thoáng khí, cổ áo và tay áo bo viền tinh tế.', 3),
('Áo Hoodie Nỉ Bông', 'Chất nỉ bông dày dặn, giữ ấm tốt, có mũ và túi kangaroo tiện lợi.', 4);

INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(1, 'Trắng', 'L', 180000.00, 150, 'assets/web/images/product-1.png'),
(1, 'Đen', 'L', 180000.00, 145, 'assets/web/images/product-2.png'),
(1, 'Xám', 'L', 180000.00, 110, 'assets/web/images/product-3.png'),
(1, 'Xanh Navy', 'L', 190000.00, 90, 'assets/web/images/product-4.png'),
(1, 'Be', 'L', 190000.00, 85, 'assets/web/images/product-5.png'),
(2, 'Đen', 'L', 250000.00, 80, 'assets/web/images/product-6.png'),
(2, 'Trắng', 'L', 250000.00, 75, 'assets/web/images/product-7.png'),
(2, 'Đỏ', 'L', 260000.00, 60, 'assets/web/images/product-8.png'),
(3, 'Trắng', 'M', 350000.00, 90, 'assets/web/images/product-9.png'),
(3, 'Xanh da trời', 'M', 350000.00, 85, 'assets/web/images/product-10.png'),
(3, 'Hồng nhạt', 'M', 360000.00, 70, 'assets/web/images/product-11.png'),
(3, 'Đen', 'M', 360000.00, 65, 'assets/web/images/product-12.png'),
(4, 'Xanh Navy', 'M', 320000.00, 100, 'assets/web/images/product-13.png'),
(4, 'Trắng', 'M', 320000.00, 95, 'assets/web/images/product-14.png'),
(4, 'Đen', 'M', 320000.00, 90, 'assets/web/images/product-15.png'),
(4, 'Xám', 'M', 320000.00, 80, 'assets/web/images/product-16.png'),
(5, 'Đen', 'XL', 450000.00, 70, 'assets/web/images/product-17.png'),
(5, 'Xám', 'XL', 450000.00, 65, 'assets/web/images/product-18.png'),
(5, 'Be', 'XL', 460000.00, 50, 'assets/web/images/product-19.png'),
(5, 'Xanh rêu', 'XL', 460000.00, 45, 'assets/web/images/product-20.png');

INSERT INTO users (full_name, email, password, phone_number, address, role) VALUES
('Nguyễn Văn A', 'a.nguyen@email.com', '123456', '0987654321', '123 Đường ABC, Quận 1, TP. HCM', 'USER'),
('Nguyễn Văn B', 'b.nguyen@email.com', '123456', '0123456789', '456 Đường XYZ, Quận Ba Đình, Hà Nội', 'USER'),
('Quản Trị Viên', 'admin@shop.com', '123456', '0909090909', 'Trụ sở chính', 'ADMIN');
