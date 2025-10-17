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
        
        .category-badge {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
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
                    <c:when test="${param.success == 'create'}">Tạo danh mục thành công!</c:when>
                    <c:when test="${param.success == 'update'}">Cập nhật danh mục thành công!</c:when>
                    <c:when test="${param.success == 'delete'}">Xóa danh mục thành công!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'delete'}">Lỗi khi xóa danh mục!</c:when>
                    <c:when test="${param.error == 'not_found'}">Không tìm thấy danh mục!</c:when>
                    <c:when test="${param.error == 'invalid_id'}">ID danh mục không hợp lệ!</c:when>
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
        <jsp:include page="../../crud/CategoryCRUD.jsp" />
    </div>
    
    <!-- Footer -->
    <jsp:include page="quanlifooter.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Auto hide alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Form validation - already defined in CategoryCRUD.jsp
        // confirmCategoryDelete - already defined in CategoryCRUD.jsp
        
        // Additional category-specific functions
        function bulkCategoryAction(action) {
            var checkboxes = document.querySelectorAll('input[name="selectedCategories"]:checked');
            if (checkboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một danh mục!');
                return;
            }
            
            var ids = Array.from(checkboxes).map(cb => cb.value);
            var message = action === 'delete' ? 'xóa' : 'thao tác với';
            
            if (confirm('Bạn có chắc chắn muốn ' + message + ' ' + ids.length + ' danh mục đã chọn?')) {
                // Implement bulk action logic here
                console.log('Bulk ' + action + ' for Category IDs:', ids);
            }
        }
        
        // Toggle all checkboxes
        function toggleAllCategories(source) {
            var checkboxes = document.querySelectorAll('input[name="selectedCategories"]');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = source.checked;
            });
        }
        
        // Category ID format validation
        function formatCategoryId(input) {
            // Convert to uppercase and remove invalid characters
            input.value = input.value.toUpperCase().replace(/[^A-Z0-9_]/g, '');
        }
        
        // Add event listener for category ID input
        document.addEventListener('DOMContentLoaded', function() {
            var categoryIdInput = document.getElementById('categoryId');
            if (categoryIdInput) {
                categoryIdInput.addEventListener('input', function() {
                    formatCategoryId(this);
                });
            }
        });
    </script>
</body>
</html>
