<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang Chủ - Cửa Hàng Quần Áo</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/web/css/style.css">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 0;
                        padding: 20px;
                        background-color: #f4f4f4;
                    }

                    .header {
                        text-align: center;
                        margin-bottom: 20px;
                    }

                    .product-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                        gap: 20px;
                    }

                    .product-card {
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        background-color: #fff;
                        text-align: center;
                        padding: 15px;
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    }

                    .product-card img {
                        max-width: 100%;
                        height: auto;
                        border-radius: 4px;
                    }

                    .product-card h4 {
                        margin: 15px 0 10px;
                        font-size: 1.1em;
                    }

                    .product-card .price {
                        color: #e91e63;
                        font-weight: bold;
                        font-size: 1.2em;
                    }

                    .product-card .details-link {
                        display: inline-block;
                        margin-top: 15px;
                        padding: 8px 16px;
                        background-color: #007bff;
                        color: white;
                        text-decoration: none;
                        border-radius: 4px;
                    }
                </style>
            </head>

            <body>
                <header class="header">
                    <h1>Chào mừng đến với Cửa hàng!</h1>
                    <p>Những sản phẩm mới nhất</p>
                </header>
                <main>
                    <div class="product-grid">
                        <c:if test="${empty products}">
                            <p>Hiện tại chưa có sản phẩm nào để hiển thị.</p>
                        </c:if>
                        <c:forEach items="${products}" var="p">
                            <div class="product-card">
                                <a href="${pageContext.request.contextPath}/product?id=${p.id}">
                                    <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                        alt="[Hình ảnh của ${p.name}]">
                                </a>
                                <h4>${p.name}</h4>
                                <p class="price">
                                    <fmt:setLocale value="vi_VN" />
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" />
                                </p>
                                <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="details-link">Xem
                                    Chi Tiết</a>
                            </div>
                        </c:forEach>
                    </div>
                </main>
            </body>

            </html>