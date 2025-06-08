<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${product.name} - Chi Tiết Sản Phẩm</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/web/css/style.css">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f8f9fa;
                    }

                    .container {
                        max-width: 960px;
                        margin: 40px auto;
                        padding: 20px;
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .product-detail-layout {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 40px;
                    }

                    .product-image img {
                        width: 100%;
                        border-radius: 8px;
                    }

                    .product-info h1 {
                        font-size: 2.5em;
                        margin-bottom: 20px;
                    }

                    .product-info .price {
                        font-size: 2em;
                        color: #e91e63;
                        font-weight: bold;
                        margin-bottom: 20px;
                    }

                    .product-info .description {
                        line-height: 1.6;
                        color: #666;
                        margin-bottom: 20px;
                    }

                    .product-info .meta {
                        margin-bottom: 20px;
                    }

                    .product-info .meta p {
                        margin: 5px 0;
                    }

                    .product-info .meta strong {
                        min-width: 80px;
                        display: inline-block;
                    }

                    .add-to-cart-form {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                        margin-top: 30px;
                    }

                    .add-to-cart-form input[type="number"] {
                        width: 70px;
                        padding: 10px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        text-align: center;
                        font-size: 1em;
                    }

                    .add-to-cart-form button {
                        padding: 12px 25px;
                        background-color: #007bff;
                        color: white;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        font-size: 1em;
                        transition: background-color 0.3s;
                    }

                    .add-to-cart-form button:hover {
                        background-color: #0056b3;
                    }

                    .back-link {
                        display: inline-block;
                        margin-bottom: 20px;
                        text-decoration: none;
                        color: #007bff;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <a href="${pageContext.request.contextPath}/home" class="back-link">&larr; Quay lại trang chủ</a>
                    <c:if test="${not empty product}">
                        <div class="product-detail-layout">
                            <div class="product-image">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                    alt="[Hình ảnh của ${product.name}]">
                            </div>
                            <div class="product-info">
                                <h1>${product.name}</h1>
                                <p class="price">
                                    <fmt:setLocale value="vi_VN" />
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" />
                                </p>
                                <div class="description">
                                    <p>${product.description}</p>
                                </div>
                                <div class="meta">
                                    <p><strong>Danh mục:</strong> ${product.categoryName}</p>
                                    <p><strong>Màu sắc:</strong> ${product.color}</p>
                                    <p><strong>Kích cỡ:</strong> ${product.size}</p>
                                    <p><strong>Tồn kho:</strong> ${product.stockQuantity}</p>
                                </div>
                                <form class="add-to-cart-form" method="POST"
                                    action="${pageContext.request.contextPath}/cart">
                                    <input type="hidden" name="productDetailId" value="${product.id}">
                                    <label for="quantity">Số lượng:</label>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1"
                                        max="${product.stockQuantity}">
                                    <button type="submit">Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${empty product}">
                        <h2>Sản phẩm không tồn tại.</h2>
                        <p>Sản phẩm bạn đang tìm kiếm có thể đã bị xóa hoặc không có sẵn.</p>
                    </c:if>
                </div>
            </body>

            </html>