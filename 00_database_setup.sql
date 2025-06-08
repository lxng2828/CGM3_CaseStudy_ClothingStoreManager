DROP DATABASE IF EXISTS cgm3_casestudy_clothingstoremanager;
CREATE DATABASE cgm3_casestudy_clothingstoremanager CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cgm3_casestudy_clothingstoremanager;
-- Bảng người dùng
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
-- Bảng danh mục
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
-- Bảng sản phẩm (thông tin chung)
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
-- Bảng chi tiết sản phẩm (biến thể theo màu, size)
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
-- Bảng đơn hàng
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
-- Bảng chi tiết đơn hàng
CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_detail_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_detail_id) REFERENCES product_details(id)
);
-- Bảng đánh giá
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
-- Tạo các chỉ mục để tăng tốc độ truy vấn
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);
-- Chèn dữ liệu cho bảng categories (Danh mục đồ nam)
INSERT INTO categories (name) VALUES
('Áo Thun'),          -- ID 1
('Áo Sơ Mi'),         -- ID 2
('Áo Polo'),          -- ID 3
('Áo Khoác'),         -- ID 4
('Quần Dài'),         -- ID 5
('Quần Short');       -- ID 6
-- Chèn dữ liệu cho bảng products
INSERT INTO products (name, description, category_id) VALUES
('Áo Thun Cổ Tròn Basic', 'Chất liệu 100% cotton, co giãn 4 chiều, thấm hút mồ hôi tốt.', 1), -- id 1
('Áo Thun In Hình Graphic', 'Thiết kế độc đáo với hình in nổi bật, thể hiện cá tính riêng.', 1), -- id 2
('Áo Sơ Mi Dài Tay Oxford', 'Vải Oxford cao cấp, đứng form, mang lại vẻ ngoài lịch lãm.', 2), -- id 3
('Áo Polo Pique Mắt Chim', 'Vải dệt kiểu mắt chim (pique) thoáng khí, cổ áo và tay áo bo viền.', 3), -- id 4
('Áo Khoác Bomber Vải Dù', 'Lớp vải dù bên ngoài chống nước nhẹ, bên trong có lớp lót mỏng.', 4), -- id 5
('Áo Hoodie Nỉ Bông', 'Chất nỉ bông dày dặn, giữ ấm tốt, có mũ và túi kangaroo tiện lợi.', 4), -- id 6
('Quần Jeans Dáng Slim-fit', 'Vải jeans cao cấp có độ co giãn nhẹ, tôn dáng người mặc.', 5), -- id 7
('Quần Kaki Chinos', 'Thiết kế thanh lịch, có thể kết hợp với nhiều loại áo.', 5), -- id 8
('Quần Short Thun Thể Thao', 'Chất thun polyeste co giãn, thoải mái cho mọi hoạt động.', 6), -- id 9
('Quần Jogger Thun', 'Vải thun da cá co giãn, form dáng thể thao thoải mái.', 5), -- id 10
('Quần Tây Âu Dáng Slim', 'Chất vải tổng hợp không nhăn, đứng dáng. Phù hợp môi trường công sở.', 5); -- id 11
-- Chèn dữ liệu cho bảng product_details (Đã rút gọn còn 20 biến thể)
-- 1. Áo Thun Cổ Tròn Basic (ID sản phẩm: 1)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(1, 'Trắng', 'M', 180000.00, 150, 'assets/web/images/product-1.png'),
(1, 'Đen', 'M', 180000.00, 145, 'assets/web/images/product-2.png'),
(1, 'Xám', 'L', 180000.00, 110, 'assets/web/images/product-3.png');
-- 2. Áo Thun In Hình Graphic (ID sản phẩm: 2)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(2, 'Đen', 'L', 250000.00, 70, 'assets/web/images/product-4.png');
-- 3. Áo Sơ Mi Dài Tay Oxford (ID sản phẩm: 3)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(3, 'Trắng', 'L', 350000.00, 55, 'assets/web/images/product-6.png'),
(3, 'Xanh da trời', 'M', 350000.00, 65, 'assets/web/images/product-7.png');
-- 4. Áo Polo Pique Mắt Chim (ID sản phẩm: 4)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(4, 'Xanh Navy', 'M', 320000.00, 80, 'assets/web/images/product-10.png'),
(4, 'Trắng', 'M', 320000.00, 75, 'assets/web/images/product-11.png');
-- 5. Áo Khoác Bomber Vải Dù (ID sản phẩm: 5)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(5, 'Đen', 'L', 550000.00, 50, 'assets/web/images/product-12.png');
-- 6. Áo Hoodie Nỉ Bông (ID sản phẩm: 6)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(6, 'Xám', 'L', 450000.00, 60, 'assets/web/images/product-14.png'),
(6, 'Đen', 'XL', 450000.00, 55, 'assets/web/images/product-15.png');
-- 7. Quần Jeans Dáng Slim-fit (ID sản phẩm: 7)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(7, 'Xanh Đậm', '30', 480000.00, 70, 'assets/web/images/product-16.png'),
(7, 'Xanh Đậm', '32', 480000.00, 65, 'assets/web/images/product-16.png'),
(7, 'Đen', '30', 480000.00, 60, 'assets/web/images/product-17.png');
-- 8. Quần Kaki Chinos (ID sản phẩm: 8)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(8, 'Be', '30', 420000.00, 80, 'assets/web/images/product-18.png'),
(8, 'Đen', '30', 420000.00, 75, 'assets/web/images/product-19.png');
-- 9. Quần Short Thun Thể Thao (ID sản phẩm: 9)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(9, 'Đen', 'L', 220000.00, 100, 'assets/web/images/product-22.png');
-- 10. Quần Jogger Thun (ID sản phẩm: 10)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(10, 'Xám Đậm', 'L', 350000.00, 70, 'assets/web/images/product-26.png'),
(10, 'Đen', 'L', 350000.00, 75, 'assets/web/images/product-27.png');
-- 11. Quần Tây Âu Dáng Slim (ID sản phẩm: 11)
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(11, 'Đen', '30', 520000.00, 40, 'assets/web/images/product-29.png');
-- Thêm một vài user mẫu
INSERT INTO users (full_name, email, password, phone_number, address, role) VALUES
('Nguyễn Văn A', 'a.nguyenvan@email.com', '123456', '0987654321', '123 Đường ABC, Quận 1, TP. HCM', 'USER'),
('Nguyễn Văn B', 'b.nguyenvan@email.com', '123456', '0123456789', '456 Đường XYZ, Quận Ba Đình, Hà Nội', 'USER'),
('Nguyễn Văn C', 'admin@shop.com', '123456', '0909090909', 'Trụ sở chính', 'ADMIN');
