<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khoa News - Trang chủ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            padding-top: 20px;
            background-color: #f8f9fa;
        }
        .main-content {
            min-height: calc(100vh - 300px);
            padding: 20px 0;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/views/asm/common/docgia/docgiaheader.jsp"/>
    
    <!-- Include Navigation -->
    <jsp:include page="/views/asm/common/docgia/docgianav.jsp"/>
    
    <!-- Main Content -->
    <div class="container main-content">
        <div class="row">
            <div class="col-md-8">
                <!-- Nội dung chính sẽ được thêm vào đây -->
                <h2>Chào mừng đến với Khoa News</h2>
                <p>Đây là trang tin tức tổng hợp mới nhất, cập nhật liên tục 24/7.</p>
            </div>
            <div class="col-md-4">
                <!-- Sidebar -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Tin nổi bật</h5>
                    </div>
                    <div class="card-body">
                        <p>Danh sách các tin tức nổi bật sẽ được hiển thị ở đây.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="/views/asm/common/docgia/docgiafooter.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>