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
('Áo Khoác'),
('Quần Dài'),
('Quần Short');
INSERT INTO products (name, description, category_id) VALUES
('Áo Thun Cổ Tròn Basic', 'Chất liệu 100% cotton, co giãn 4 chiều, thấm hút mồ hôi tốt. Kiểu dáng cơ bản không bao giờ lỗi mốt.', 1),
('Áo Thun In Hình Graphic', 'Thiết kế độc đáo với hình in nổi bật, thể hiện cá tính riêng.', 1),
('Áo Sơ Mi Dài Tay Oxford', 'Vải Oxford cao cấp, đứng form, mang lại vẻ ngoài lịch lãm, trưởng thành.', 2),
('Áo Sơ Mi Flannel Kẻ Caro', 'Chất vải flannel mềm mại, ấm áp, họa tiết kẻ caro trẻ trung, năng động.', 2),
('Áo Polo Pique Mắt Chim', 'Vải dệt kiểu mắt chim (pique) thoáng khí, cổ áo và tay áo bo viền tinh tế.', 3),
('Áo Khoác Bomber Vải Dù', 'Lớp vải dù bên ngoài chống nước nhẹ, bên trong có lớp lót mỏng, phù hợp thời tiết se lạnh.', 4),
('Áo Hoodie Nỉ Bông', 'Chất nỉ bông dày dặn, giữ ấm tốt, có mũ và túi kangaroo tiện lợi.', 4),
('Quần Jeans Dáng Slim-fit', 'Vải jeans cao cấp có độ co giãn nhẹ, tôn dáng người mặc.', 5),
('Quần Kaki Chinos', 'Thiết kế thanh lịch, có thể kết hợp với áo thun, sơ mi hay polo đều đẹp.', 5),
('Quần Short Kaki Túi Hộp', 'Kiểu dáng cargo với nhiều túi tiện lợi, phong cách bụi bặm, cá tính.', 6),
('Quần Short Thun Thể Thao', 'Chất thun polyeste co giãn, thoải mái cho mọi hoạt động thể thao.', 6),
('Áo Len Cổ Lọ', 'Chất len dệt kim mềm mại, giữ ấm tuyệt đối cho mùa đông. Thiết kế cổ lọ ôm vừa vặn.', 4),
('Quần Jogger Thun', 'Vải thun da cá co giãn, form dáng thể thao thoải mái. Bo chun ở gấu quần gọn gàng.', 5),
('Áo Sơ Mi Tay Ngắn Họa Tiết', 'Chất vải lanh mát mẻ, họa tiết lá cây nhiệt đới, phù hợp cho những chuyến đi biển hoặc dạo phố mùa hè.', 2),
('Quần Tây Âu Dáng Slim', 'Chất vải tổng hợp không nhăn, đứng dáng. Thiết kế hiện đại, phù hợp môi trường công sở.', 5);
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(1, 'Trắng', 'M', 180000.00, 150, 'assets/web/images/product-1.jpg'),
(1, 'Trắng', 'L', 180000.00, 120, 'assets/web/images/product-1.jpg'),
(1, 'Trắng', 'XL', 180000.00, 100, 'assets/web/images/product-1.jpg'),
(1, 'Đen', 'M', 180000.00, 145, 'assets/web/images/product-2.jpg'),
(1, 'Đen', 'L', 180000.00, 130, 'assets/web/images/product-2.jpg'),
(1, 'Đen', 'XL', 180000.00, 90, 'assets/web/images/product-2.jpg'),
(1, 'Xám', 'L', 180000.00, 110, 'assets/web/images/product-3.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(2, 'Đen', 'M', 250000.00, 80, 'assets/web/images/product-4.jpg'),
(2, 'Đen', 'L', 250000.00, 70, 'assets/web/images/product-4.jpg'),
(2, 'Trắng', 'L', 250000.00, 65, 'assets/web/images/product-5.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(3, 'Trắng', 'M', 350000.00, 60, 'assets/web/images/product-6.jpg'),
(3, 'Trắng', 'L', 350000.00, 55, 'assets/web/images/product-6.jpg'),
(3, 'Xanh da trời', 'M', 350000.00, 65, 'assets/web/images/product-7.jpg'),
(3, 'Xanh da trời', 'L', 350000.00, 50, 'assets/web/images/product-7.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(4, 'Đỏ-Đen', 'L', 380000.00, 40, 'assets/web/images/product-8.jpg'),
(4, 'Xanh-Đen', 'L', 380000.00, 45, 'assets/web/images/product-9.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(5, 'Xanh Navy', 'M', 320000.00, 80, 'assets/web/images/product-10.jpg'),
(5, 'Xanh Navy', 'L', 320000.00, 70, 'assets/web/images/product-10.jpg'),
(5, 'Trắng', 'M', 320000.00, 75, 'assets/web/images/product-11.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(6, 'Đen', 'L', 550000.00, 50, 'assets/web/images/product-12.jpg'),
(6, 'Xanh Olive', 'L', 550000.00, 45, 'assets/web/images/product-13.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(7, 'Xám', 'L', 450000.00, 60, 'assets/web/images/product-14.jpg'),
(7, 'Đen', 'XL', 450000.00, 55, 'assets/web/images/product-15.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(8, 'Xanh Đậm', '30', 480000.00, 70, 'assets/web/images/product-16.jpg'),
(8, 'Xanh Đậm', '31', 480000.00, 75, 'assets/web/images/product-16.jpg'),
(8, 'Xanh Đậm', '32', 480000.00, 65, 'assets/web/images/product-16.jpg'),
(8, 'Đen', '30', 480000.00, 60, 'assets/web/images/product-17.jpg'),
(8, 'Đen', '32', 480000.00, 50, 'assets/web/images/product-17.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(9, 'Be', '30', 420000.00, 80, 'assets/web/images/product-18.jpg'),
(9, 'Be', '31', 420000.00, 70, 'assets/web/images/product-18.jpg'),
(9, 'Đen', '30', 420000.00, 75, 'assets/web/images/product-19.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(10, 'Kaki', '30', 280000.00, 90, 'assets/web/images/product-20.jpg'),
(10, 'Rêu', '32', 280000.00, 80, 'assets/web/images/product-21.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(11, 'Đen', 'L', 220000.00, 100, 'assets/web/images/product-22.jpg'),
(11, 'Xám', 'L', 220000.00, 95, 'assets/web/images/product-23.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(12, 'Kem', 'L', 420000.00, 50, 'assets/web/images/product-24.jpg'),
(12, 'Đen', 'L', 420000.00, 45, 'assets/web/images/product-25.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(13, 'Xám Đậm', 'M', 350000.00, 80, 'assets/web/images/product-26.jpg'),
(13, 'Xám Đậm', 'L', 350000.00, 70, 'assets/web/images/product-26.jpg'),
(13, 'Đen', 'L', 350000.00, 75, 'assets/web/images/product-27.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(14, 'Nền Trắng Họa Tiết Xanh', 'M', 300000.00, 60, 'assets/web/images/product-28.jpg'),
(14, 'Nền Trắng Họa Tiết Xanh', 'L', 300000.00, 55, 'assets/web/images/product-28.jpg');
INSERT INTO product_details (product_id, color, size, price, stock_quantity, image_url) VALUES
(15, 'Đen', '30', 520000.00, 40, 'assets/web/images/product-29.jpg'),
(15, 'Xám Chì', '31', 520000.00, 35, 'assets/web/images/product-30.jpg'),
(15, 'Xám Chì', '32', 520000.00, 30, 'assets/web/images/product-30.jpg');
INSERT INTO users (full_name, email, password, phone_number, address, role) VALUES
('Nguyễn Văn A', 'a.nguyenvan@email.com', '123456', '0987654321', '123 Đường ABC, Quận 1, TP. HCM', 'USER'),
('Nguyễn Văn B', 'b.nguyenvan@email.com', '123456', '0123456789', '456 Đường XYZ, Quận Ba Đình, Hà Nội', 'USER'),
('Nguyễn Văn C', 'admin@shop.com', '123456', '0909090909', 'Trụ sở chính', 'ADMIN');
