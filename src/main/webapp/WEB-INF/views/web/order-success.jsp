<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt Hàng Thành Công</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .success-container {
                text-align: center;
                background: #fff;
                padding: 50px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .success-container h1 {
                color: #28a745;
                font-size: 2.5em;
            }

            .success-container p {
                font-size: 1.2em;
                color: #555;
            }

            .success-container a {
                display: inline-block;
                margin-top: 30px;
                padding: 12px 25px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
        </style>
    </head>

    <body>
        <div class="success-container">
            <h1>Đặt Hàng Thành Công!</h1>
            <p>Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi.</p>
            <p>Chúng tôi sẽ liên hệ với bạn để xác nhận đơn hàng trong thời gian sớm nhất.</p>
            <a href="${pageContext.request.contextPath}/home">Tiếp Tục Mua Sắm</a>
        </div>
    </body>

    </html>