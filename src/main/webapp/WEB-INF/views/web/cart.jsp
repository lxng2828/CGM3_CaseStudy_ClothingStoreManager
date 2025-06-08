<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Giỏ Hàng Của Bạn</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/web/css/style.css">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                    }

                    .container {
                        max-width: 1100px;
                        margin: 40px auto;
                        padding: 20px;
                    }

                    .cart-title {
                        text-align: center;
                        margin-bottom: 30px;
                    }

                    .cart-table {
                        width: 100%;
                        border-collapse: collapse;
                        background: #fff;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        border-radius: 8px;
                        overflow: hidden;
                    }

                    .cart-table th,
                    .cart-table td {
                        padding: 15px;
                        text-align: left;
                    }

                    .cart-table thead {
                        background-color: #007bff;
                        color: white;
                    }

                    .cart-table tbody tr {
                        border-bottom: 1px solid #ddd;
                    }

                    .cart-table tbody tr:last-child {
                        border-bottom: none;
                    }

                    .product-info {
                        display: flex;
                        align-items: center;
                    }

                    .product-info img {
                        width: 80px;
                        height: 80px;
                        object-fit: cover;
                        border-radius: 4px;
                        margin-right: 15px;
                    }

                    .empty-cart {
                        text-align: center;
                        padding: 50px;
                        background: #fff;
                        border-radius: 8px;
                    }

                    .cart-summary {
                        margin-top: 30px;
                        float: right;
                        width: 300px;
                        background: #fff;
                        padding: 20px;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .cart-summary h3 {
                        margin-top: 0;
                    }

                    .cart-summary .total {
                        font-size: 1.5em;
                        font-weight: bold;
                        color: #e91e63;
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 20px;
                    }

                    .checkout-button {
                        display: block;
                        width: 100%;
                        padding: 15px;
                        background-color: #28a745;
                        color: white;
                        text-align: center;
                        text-decoration: none;
                        border-radius: 4px;
                        font-size: 1.2em;
                    }

                    .action-links a {
                        color: #dc3545;
                        text-decoration: none;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <h1 class="cart-title">Giỏ Hàng Của Bạn</h1>

                    <c:choose>
                        <c:when test="${not empty sessionScope.cart and not empty sessionScope.cart.values()}">
                            <table class="cart-table">
                                <thead>
                                    <tr>
                                        <th colspan="2">Sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Tạm tính</th>
                                        <%-- <th>Xóa</th> --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="totalAmount" value="0" />
                                    <c:forEach var="item" items="${sessionScope.cart.values()}">
                                        <tr>
                                            <td colspan="2">
                                                <div class="product-info">
                                                    <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                                        alt="${item.product.name}">
                                                    <div>
                                                        <strong>${item.product.name}</strong>
                                                        <br>
                                                        <small>Màu: ${item.product.color}, Size:
                                                            ${item.product.size}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <fmt:setLocale value="vi_VN" />
                                                <fmt:formatNumber value="${item.product.price}" type="currency"
                                                    currencySymbol="VNĐ" />
                                            </td>
                                            <td>${item.quantity}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.subtotal}" type="currency"
                                                    currencySymbol="VNĐ" />
                                            </td>
                                            <%-- <td class="action-links">
                                                <a href="#">Xóa</a>
                                                </td>
                                                --%>
                                        </tr>
                                        <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                                    </c:forEach>
                                </tbody>
                            </table>

                            <div class="cart-summary">
                                <h3>Tổng Cộng</h3>
                                <div class="total">
                                    <span>Tổng tiền</span>
                                    <span>
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="VNĐ" />
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/checkout" class="checkout-button">Tiến hành
                                    Thanh toán</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-cart">
                                <h2>Giỏ hàng của bạn đang trống</h2>
                                <p>Hãy tiếp tục mua sắm để thêm sản phẩm vào giỏ nhé!</p>
                                <a href="${pageContext.request.contextPath}/home"
                                    style="text-decoration: none; padding: 10px 20px; background-color: #007bff; color: white; border-radius: 4px;">Quay
                                    lại trang chủ</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </body>

            </html>