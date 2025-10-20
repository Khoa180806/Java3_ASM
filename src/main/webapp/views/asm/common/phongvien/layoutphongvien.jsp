<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="${currentLanguage}"
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - ${i18n_appName}</title>
    
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
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
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
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
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="phongvienheader.jsp" />
    
    <!-- Navigation -->
    <jsp:include page="phongviennav.jsp" />
    
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
    <jsp:include page="phongvienfooter.jsp" />
    
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
        
        // Real-time validation for News ID
        function validateNewsId(input) {
            var id = input.value.trim();
            var errorDiv = document.getElementById('newsIdError');
            var isValid = true;
            var errorMessage = '';
            
            if (id === '') {
                errorMessage = 'ID tin tức không được để trống!';
                isValid = false;
            } else if (id.length < 3) {
                errorMessage = 'ID phải có ít nhất 3 ký tự!';
                isValid = false;
            } else if (id.length > 20) {
                errorMessage = 'ID không được quá 20 ký tự!';
                isValid = false;
            }
            
            if (!isValid) {
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                errorDiv.textContent = errorMessage;
                errorDiv.style.display = 'block';
            } else {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
                errorDiv.textContent = '';
                errorDiv.style.display = 'none';
            }
            
            return isValid;
        }
        
        // Real-time validation for News Title
        function validateNewsTitle(input) {
            var title = input.value.trim();
            var errorDiv = document.getElementById('newsTitleError');
            var isValid = true;
            var errorMessage = '';
            
            if (title === '') {
                errorMessage = 'Tiêu đề không được để trống!';
                isValid = false;
            } else if (title.length < 5) {
                errorMessage = 'Tiêu đề phải có ít nhất 5 ký tự!';
                isValid = false;
            } else if (title.length > 200) {
                errorMessage = 'Tiêu đề không được quá 200 ký tự!';
                isValid = false;
            }
            
            if (!isValid) {
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                errorDiv.textContent = errorMessage;
                errorDiv.style.display = 'block';
            } else {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
                errorDiv.textContent = '';
                errorDiv.style.display = 'none';
            }
            
            return isValid;
        }
        
        // Real-time validation for News Content
        function validateNewsContent(input) {
            var content = input.value.trim();
            var errorDiv = document.getElementById('newsContentError');
            var isValid = true;
            var errorMessage = '';
            
            if (content === '') {
                errorMessage = 'Nội dung không được để trống!';
                isValid = false;
            } else if (content.length < 10) {
                errorMessage = 'Nội dung phải có ít nhất 10 ký tự!';
                isValid = false;
            }
            
            if (!isValid) {
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                errorDiv.textContent = errorMessage;
                errorDiv.style.display = 'block';
            } else {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
                errorDiv.textContent = '';
                errorDiv.style.display = 'none';
            }
            
            return isValid;
        }
        
        // Form validation
        function validateForm() {
            var idInput = document.getElementById('newsId');
            var titleInput = document.getElementById('newsTitle');
            var contentInput = document.getElementById('newsContent');
            
            // Validate all fields
            var idValid = validateNewsId(idInput);
            var titleValid = validateNewsTitle(titleInput);
            var contentValid = validateNewsContent(contentInput);
            
            // If any field is invalid, prevent form submission
            if (!idValid || !titleValid || !contentValid) {
                // Focus on first invalid field
                if (!idValid) {
                    idInput.focus();
                } else if (!titleValid) {
                    titleInput.focus();
                } else if (!contentValid) {
                    contentInput.focus();
                }
                return false;
            }
            
            return true;
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