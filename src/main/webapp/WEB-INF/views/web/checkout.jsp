<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Thanh Toán Đơn Hàng</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                        color: #333;
                    }

                    .container {
                        max-width: 900px;
                        margin: 40px auto;
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 40px;
                    }

                    .checkout-form,
                    .order-summary {
                        background: #fff;
                        padding: 30px;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    }

                    h2 {
                        margin-top: 0;
                        border-bottom: 1px solid #eee;
                        padding-bottom: 15px;
                        margin-bottom: 20px;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-group label {
                        display: block;
                        margin-bottom: 5px;
                        font-weight: bold;
                    }

                    .form-group input {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        box-sizing: border-box;
                    }

                    .order-summary ul {
                        list-style: none;
                        padding: 0;
                        margin: 0;
                    }

                    .order-summary li {
                        display: flex;
                        justify-content: space-between;
                        padding: 10px 0;
                        border-bottom: 1px solid #eee;
                    }

                    .order-summary li:last-child {
                        border: none;
                    }

                    .order-summary .total {
                        font-weight: bold;
                        font-size: 1.2em;
                        margin-top: 20px;
                        padding-top: 20px;
                        border-top: 2px solid #333;
                    }

                    .submit-btn {
                        width: 100%;
                        padding: 15px;
                        background-color: #28a745;
                        color: white;
                        border: none;
                        border-radius: 5px;
                        font-size: 1.2em;
                        cursor: pointer;
                    }

                    .error-message {
                        color: red;
                        background-color: #ffebee;
                        border: 1px solid red;
                        padding: 10px;
                        border-radius: 4px;
                        margin-bottom: 20px;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <div class="checkout-form">
                        <h2>Thông Tin Giao Hàng</h2>
                        <c:if test="${not empty errorMessage}">
                            <p class="error-message">${errorMessage}</p>
                        </c:if>
                        <form action="${pageContext.request.contextPath}/checkout" method="POST">
                            <div class="form-group">
                                <label for="customerName">Họ và Tên</label>
                                <input type="text" id="customerName" name="customerName" required>
                            </div>
                            <div class="form-group">
                                <label for="shippingPhone">Số Điện Thoại</label>
                                <input type="tel" id="shippingPhone" name="shippingPhone" required>
                            </div>
                            <div class="form-group">
                                <label for="shippingAddress">Địa Chỉ Giao Hàng</label>
                                <input type="text" id="shippingAddress" name="shippingAddress" required>
                            </div>
                            <button type="submit" class="submit-btn">Hoàn Tất Đơn Hàng</button>
                        </form>
                    </div>
                    <div class="order-summary">
                        <h2>Tóm Tắt Đơn Hàng</h2>
                        <ul>
                            <c:set var="totalAmount" value="0" />
                            <c:forEach var="item" items="${sessionScope.cart.values()}">
                                <li>
                                    <span>${item.product.name} (x${item.quantity})</span>
                                    <strong>
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="đ" />
                                    </strong>
                                </li>
                                <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                            </c:forEach>
                            <li class="total">
                                <span>Tổng Cộng</span>
                                <span>
                                    <fmt:setLocale value="vi_VN" />
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" />
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
            </body>

            </html>