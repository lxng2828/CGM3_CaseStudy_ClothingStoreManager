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
</head>

<body class="bg-light">
<div class="container-fluid">
    <header class="row text-center mb-5" style="background-color: #6F6F6A">
        <img class="col-md-5" src="${pageContext.request.contextPath}/assets/web/images/banner-1.png" alt="Ảnh banner">
        <div class="col-md-7 d-flex flex-column justify-content-center" >
            <h1 class="fs-1" style="color: #EDEDE7">Chào mừng đến với Cửa hàng!</h1>
            <p class="fs-5" style="color: #EDEDE7">Những sản phẩm mới nhất</p>
        </div>

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
                                 alt="[Hình ảnh của ${p.name}]">
                        </a>
                        <div class="card-body text-center">
                            <h5 class="card-title">${p.name}</h5>
                            <p class="card-text text-danger fw-bold fs-5">
                                <fmt:setLocale value="vi_VN" />
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" />
                            </p>
                            <a href="${pageContext.request.contextPath}/product?id=${p.id}"
                               class="btn btn-primary">Xem Chi Tiết</a>
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
