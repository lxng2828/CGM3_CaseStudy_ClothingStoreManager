<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Cửa Hàng Quần Áo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .checkout-form, .order-summary {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-7">
                <div class="checkout-form p-4 mb-4">
                    <h2 class="mb-4 pb-2 border-bottom">
                        <i class="bi bi-truck me-2"></i>Thông Tin Giao Hàng
                    </h2>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/checkout" method="POST" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="customerName" class="form-label fw-bold">Họ và Tên</label>
                            <input type="text" class="form-control form-control-lg" id="customerName" name="customerName" required>
                            <div class="invalid-feedback">
                                Vui lòng nhập họ và tên
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="shippingPhone" class="form-label fw-bold">Số Điện Thoại</label>
                            <input type="tel" class="form-control form-control-lg" id="shippingPhone" name="shippingPhone" required>
                            <div class="invalid-feedback">
                                Vui lòng nhập số điện thoại
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="shippingAddress" class="form-label fw-bold">Địa Chỉ Giao Hàng</label>
                            <input type="text" class="form-control form-control-lg" id="shippingAddress" name="shippingAddress" required>
                            <div class="invalid-feedback">
                                Vui lòng nhập địa chỉ giao hàng
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 py-3">
                            <i class="bi bi-credit-card me-2"></i>Hoàn Tất Đơn Hàng
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="order-summary p-4">
                    <h2 class="mb-4 pb-2 border-bottom">
                        <i class="bi bi-receipt me-2"></i>Tóm Tắt Đơn Hàng
                    </h2>

                    <div class="list-group mb-4">
                        <c:set var="totalAmount" value="0" />
                        <c:forEach var="item" items="${sessionScope.cart.values()}">
                            <div class="list-group-item border-0 px-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/${item.product.imageUrl}"
                                             alt="${item.product.name}"
                                             class="rounded me-3"
                                             style="width: 60px; height: 60px; object-fit: cover;">
                                        <div>
                                            <h6 class="mb-1">${item.product.name}</h6>
                                            <small class="text-muted">Số lượng: ${item.quantity}</small>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold">
                                            <fmt:setLocale value="vi_VN" />
                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="VNĐ" />
                                        </div>
                                        <small class="text-muted">
                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="VNĐ" />/cái
                                        </small>
                                    </div>
                                </div>
                            </div>
                            <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                        </c:forEach>
                    </div>

                    <div class="border-top pt-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-muted">Tạm tính</span>
                            <span>
                                <fmt:setLocale value="vi_VN" />
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="VNĐ" />
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-muted">Phí vận chuyển</span>
                            <span>Miễn phí</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="fw-bold">Tổng cộng</span>
                            <h4 class="text-primary mb-0">
                                <fmt:setLocale value="vi_VN" />
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="VNĐ" />
                            </h4>
                        </div>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary w-100">
                            <i class="bi bi-arrow-left me-2"></i>Quay Lại Giỏ Hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>