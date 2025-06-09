<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Hàng Thành Công - Cửa Hàng Quần Áo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .success-card {
            max-width: 600px;
            margin: 0 auto;
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .success-header {
            background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
            color: white;
            padding: 2.5rem 1.5rem;
            text-align: center;
        }
        .success-body {
            padding: 2.5rem;
            background: white;
        }
        .success-icon {
            font-size: 5rem;
            color: #4CAF50;
            margin-bottom: 1.5rem;
        }
        .btn-continue {
            padding: 0.8rem 2rem;
            font-size: 1.1rem;
            border-radius: 50px;
            margin-top: 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-continue:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="card success-card">
                    <div class="success-header">
                        <i class="bi bi-check-circle-fill success-icon"></i>
                        <h1 class="display-5 fw-bold mb-0">Đặt Hàng Thành Công!</h1>
                    </div>
                    <div class="success-body text-center">
                        <p class="lead mb-4">Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi.</p>
                        <p class="text-muted mb-4">
                            <i class="bi bi-info-circle me-2"></i>
                            Chúng tôi sẽ liên hệ với bạn để xác nhận đơn hàng trong thời gian sớm nhất.
                        </p>
                        <p class="text-muted mb-4">
                            <i class="bi bi-clock-history me-2"></i>
                            Mã đơn hàng: <strong>#${not empty orderId ? orderId : 'N/A'}</strong>
                        </p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-continue">
                            <i class="bi bi-arrow-left-circle me-2"></i>Tiếp Tục Mua Sắm
                        </a>
                        <div class="mt-4 pt-3 border-top">
                            <p class="small text-muted mb-2">Mọi thắc mắc xin liên hệ:</p>
                            <p class="mb-0">
                                <i class="bi bi-telephone me-2"></i>0123 456 789
                                <span class="mx-3">|</span>
                                <i class="bi bi-envelope me-2"></i>support@cuahangquanao.com
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>