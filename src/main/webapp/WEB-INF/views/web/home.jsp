<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Cửa Hàng Quần Áo</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .bg-light {
            background-color: #f8f9fa;
        }

        header {
            background-color: #6F6F6A;
            height: 5rem;
        }

        .header-title {
            color: #EDEDE7;
            font-size: 2.5rem;
        }

        .header-subtitle {
            color: #EDEDE7;
            font-size: 1.5rem;
        }
    </style>
</head>

<body class="bg-light">
<div class="container-fluid">
    <header class="d-flex justify-content-between align-items-center px-4 py-3 bg-secondary text-white rounded shadow-sm flex-wrap">
        <h1 class="fs-4 m-0">Cửa hàng Quần Áo Nam</h1>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light d-flex align-items-center">
            <i class="bi bi-cart-fill me-2"></i> Giỏ hàng
        </a>
    </header>

    <main>
        <div class="row g-4">
            <c:if test="${empty products}">
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        Hiện tại chưa có sản phẩm nào để hiển thị.
                    </div>
                </div>
            </c:if>

            <c:forEach items="${products}" var="p">
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 shadow-sm">
                        <a href="${pageContext.request.contextPath}/product?id=${p.id}">
                            <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                 class="card-img-top img-fluid"
                                 alt="Hình ảnh của ${p.name}">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title">${p.name}</h5>
                            <p class="card-text text-danger fw-bold fs-5">
                                <fmt:setLocale value="vi_VN" />
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" />
                            </p>
                            <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="btn btn-primary">
                                Xem Chi Tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
