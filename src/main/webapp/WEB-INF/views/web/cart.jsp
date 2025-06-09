<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - Cửa Hàng Quần Áo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        .cart-summary {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <h1 class="mb-4 text-center">Giỏ Hàng Của Bạn</h1>

        <c:choose>
            <c:when test="${not empty sessionScope.cart and not empty sessionScope.cart.values()}">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card shadow-sm mb-4">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-primary">
                                            <tr>
                                                <th colspan="2" class="py-3">Sản phẩm</th>
                                                <th class="py-3">Đơn giá</th>
                                                <th class="py-3">Số lượng</th>
                                                <th class="py-3 text-end">Tạm tính</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="totalAmount" value="0" />
                                            <c:forEach var="item" items="${sessionScope.cart.values()}">
                                                <tr>
                                                    <td class="align-middle" style="width: 100px;">
                                                        <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                                            alt="${item.product.name}" class="img-fluid product-img">
                                                    </td>
                                                    <td class="align-middle">
                                                        <h6 class="mb-1">${item.product.name}</h6>
                                                        <small class="text-muted">Màu: ${item.product.color}, Size: ${item.product.size}</small>
                                                    </td>
                                                    <td class="align-middle">
                                                        <fmt:setLocale value="vi_VN" />
                                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="VNĐ" />
                                                    </td>
                                                    <td class="align-middle">${item.quantity}</td>
                                                    <td class="align-middle text-end">
                                                        <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="VNĐ" />
                                                    </td>
                                                </tr>
                                                <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Tổng Cộng</h5>
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0">Tổng tiền</h4>
                                    <h4 class="mb-0 text-primary">
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="VNĐ" />
                                    </h4>
                                </div>
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg w-100 py-2">
                                    Tiến Hành Thanh Toán
                                </a>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary w-100 mt-2 py-2">
                                    Tiếp Tục Mua Sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <div class="card shadow-sm border-0 py-5">
                        <div class="card-body">
                            <i class="bi bi-cart-x" style="font-size: 4rem; color: #6c757d;"></i>
                            <h2 class="mt-3">Giỏ hàng của bạn đang trống</h2>
                            <p class="text-muted mb-4">Hãy tiếp tục mua sắm để thêm sản phẩm vào giỏ nhé!</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2">
                                Quay Lại Trang Chủ
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>