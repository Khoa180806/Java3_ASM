<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Khoa News Admin</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-content {
            min-height: calc(100vh - 200px);
        }
        
        .card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        
        .card-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #218838 0%, #1ea085 100%);
            transform: translateY(-1px);
        }
        
        .table th {
            background-color: #f8f9fa;
            border-top: none;
        }
        
        .alert {
            border-radius: 10px;
        }
        
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        
        .news-image {
            max-width: 100px;
            max-height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .action-buttons .btn {
            margin: 0 2px;
        }
        
        .admin-badge {
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
            padding: 2px 8px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="quanliheader.jsp" />
    
    <!-- Navigation -->
    <jsp:include page="quanlinav.jsp" />
    
    <!-- Main Content -->
    <div class="container main-content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success == 'create'}">Tạo tin tức thành công!</c:when>
                    <c:when test="${param.success == 'update'}">Cập nhật tin tức thành công!</c:when>
                    <c:when test="${param.success == 'delete'}">Xóa tin tức thành công!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'delete'}">Lỗi khi xóa tin tức!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Page Content -->
        <jsp:include page="../../crud/NewsCRUD.jsp" />
    </div>
    
    <!-- Footer -->
    <jsp:include page="quanlifooter.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Confirm delete - Dynamic URL based on context
        function confirmDelete(newsId, newsTitle, baseUrl) {
            if (confirm('Bạn có chắc chắn muốn xóa tin tức "' + newsTitle + '"?')) {
                window.location.href = baseUrl + '/delete?id=' + newsId;
            }
        }
        
        // Auto hide alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Form validation
        function validateForm() {
            var id = document.getElementById('newsId').value.trim();
            var title = document.getElementById('newsTitle').value.trim();
            var content = document.getElementById('newsContent').value.trim();
            
            if (id === '' || title === '' || content === '') {
                alert('Vui lòng điền đầy đủ thông tin bắt buộc (ID, Tiêu đề, Nội dung)!');
                return false;
            }
            
            return true;
        }
        
        // Admin specific functions
        function bulkAction(action) {
            var checkboxes = document.querySelectorAll('input[name="selectedNews"]:checked');
            if (checkboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một tin tức!');
                return;
            }
            
            var ids = Array.from(checkboxes).map(cb => cb.value);
            var message = action === 'delete' ? 'xóa' : action === 'publish' ? 'xuất bản' : 'ẩn';
            
            if (confirm('Bạn có chắc chắn muốn ' + message + ' ' + ids.length + ' tin tức đã chọn?')) {
                // Implement bulk action logic here
                console.log('Bulk ' + action + ' for IDs:', ids);
            }
        }
        
        // Toggle all checkboxes
        function toggleAll(source) {
            var checkboxes = document.querySelectorAll('input[name="selectedNews"]');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = source.checked;
            });
        }
        
        // Preview image before upload
        function previewImage(input) {
            var preview = document.getElementById('imagePreview');
            var previewImg = document.getElementById('previewImg');
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    if (previewImg) {
                        previewImg.src = e.target.result;
                    } else {
                        // For edit mode, update existing image
                        var img = preview.querySelector('img');
                        if (img) {
                            img.src = e.target.result;
                        }
                    }
                    preview.style.display = 'block';
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>