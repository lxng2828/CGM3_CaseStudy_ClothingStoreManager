<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Cửa Hàng Quần Áo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .product-detail-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        .product-image {
            background-color: #f8f9fa;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .product-image img {
            max-width: 100%;
            max-height: 500px;
            object-fit: contain;
        }
        .product-info {
            padding: 2rem;
        }
        .product-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #2c3e50;
        }
        .product-price {
            font-size: 1.75rem;
            font-weight: 600;
            color: #e74c3c;
            margin-bottom: 1.5rem;
        }
        .product-description {
            color: #7f8c8d;
            line-height: 1.7;
            margin-bottom: 2rem;
        }
        .product-meta {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .meta-item {
            display: flex;
            margin-bottom: 0.75rem;
        }
        .meta-label {
            font-weight: 600;
            color: #2c3e50;
            min-width: 120px;
        }
        .meta-value {
            color: #7f8c8d;
        }
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        .quantity-btn {
            width: 40px;
            height: 40px;
            border: 1px solid #dee2e6;
            background: #fff;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: 1px solid #dee2e6;
            border-left: none;
            border-right: none;
        }
        .btn-add-to-cart {
            height: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 0.5rem 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        .back-link {
            color: #6c757d;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            margin-bottom: 1.5rem;
            transition: color 0.2s;
        }
        .back-link:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <a href="${pageContext.request.contextPath}/home" class="back-link">
            <i class="bi bi-arrow-left me-2"></i> Quay lại trang chủ
        </a>

        <c:choose>
            <c:when test="${not empty product}">
                <div class="card product-detail-card">
                    <div class="row g-0">
                        <div class="col-lg-6">
                            <div class="product-image">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                     alt="${product.name}"
                                     class="img-fluid">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="product-info">
                                <h1 class="product-title">${product.name}</h1>
                                <div class="product-price">
                                    <fmt:setLocale value="vi_VN" />
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" />
                                </div>

                                <div class="product-description">
                                    <p>${product.description}</p>
                                </div>

                                <div class="product-meta">
                                    <div class="meta-item">
                                        <span class="meta-label">Danh mục:</span>
                                        <span class="meta-value">${product.categoryName}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Màu sắc:</span>
                                        <span class="meta-value">${product.color}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Kích cỡ:</span>
                                        <span class="meta-value">${product.size}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Tình trạng:</span>
                                        <span class="meta-value">
                                            <c:choose>
                                                <c:when test="${product.stockQuantity > 0}">
                                                    <span class="text-success">Còn hàng (${product.stockQuantity} sản phẩm)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger">Hết hàng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>

                                <form method="POST" action="${pageContext.request.contextPath}/cart">
                                    <input type="hidden" name="productDetailId" value="${product.id}">

                                    <div class="d-flex align-items-center gap-4">
                                        <div class="quantity-selector">
                                            <button type="button" class="quantity-btn" onclick="decreaseQuantity()">-</button>
                                            <input type="number" id="quantity" name="quantity" value="1" min="1"
                                                   max="${product.stockQuantity}" class="quantity-input form-control">
                                            <button type="button" class="quantity-btn" onclick="increaseQuantity()">+</button>
                                        </div>

                                        <button type="submit" class="btn btn-primary btn-add-to-cart"
                                                ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                                            <i class="bi bi-cart-plus"></i>
                                            Thêm vào giỏ hàng
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <div class="card border-0 shadow-sm py-5">
                        <div class="card-body">
                            <i class="bi bi-exclamation-triangle" style="font-size: 4rem; color: #ffc107;"></i>
                            <h2 class="mt-4 mb-3">Sản phẩm không tồn tại</h2>
                            <p class="text-muted mb-4">Sản phẩm bạn đang tìm kiếm có thể đã bị xóa hoặc không có sẵn.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4">
                                <i class="bi bi-house-door me-2"></i>Về Trang Chủ
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateQuantity(change) {
            const input = document.getElementById('quantity');
            let value = parseInt(input.value) + change;
            const max = parseInt(input.max);

            if (value < 1) value = 1;
            if (value > max) value = max;

            input.value = value;
        }

        function increaseQuantity() {
            updateQuantity(1);
        }

        function decreaseQuantity() {
            updateQuantity(-1);
        }

        document.getElementById('quantity').addEventListener('change', function() {
            let value = parseInt(this.value);
            const max = parseInt(this.max);

            if (isNaN(value) || value < 1) {
                this.value = 1;
            } else if (value > max) {
                this.value = max;
            }
        });
    </script>
</body>
</html>