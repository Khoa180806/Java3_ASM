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
            background: linear-gradient(135deg, #007bff 0%, #6610f2 100%);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #6610f2 100%);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #520dc2 100%);
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
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff 0%, #6610f2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .action-buttons .btn {
            margin: 0 2px;
        }
        
        .role-badge {
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: bold;
        }
        
        .role-admin {
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
        }
        
        .role-reporter {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }
        
        .gender-badge {
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8em;
        }
        
        .gender-male {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        
        .gender-female {
            background-color: #fce4ec;
            color: #c2185b;
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
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${successMessage}
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
        <jsp:include page="../../crud/UserCRUD.jsp" />
    </div>
    
    <!-- Footer -->
    <jsp:include page="quanlifooter.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Confirm delete - Dynamic URL based on context
        function confirmDelete(userId, userFullname, baseUrl) {
            if (confirm('Bạn có chắc chắn muốn xóa người dùng "' + userFullname + '"?\n\nLưu ý: Thao tác này sẽ xóa vĩnh viễn tài khoản và không thể khôi phục!')) {
                window.location.href = baseUrl + '/delete?id=' + userId;
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
        
        // Real-time validation for User ID
        function validateUserId(input) {
            var id = input.value.trim();
            var errorDiv = document.getElementById('userIdError');
            var isValid = true;
            var errorMessage = '';
            
            if (id === '') {
                errorMessage = 'ID người dùng không được để trống!';
                isValid = false;
            } else if (id.length < 3) {
                errorMessage = 'ID phải có ít nhất 3 ký tự!';
                isValid = false;
            } else if (id.length > 20) {
                errorMessage = 'ID không được quá 20 ký tự!';
                isValid = false;
            } else if (!/^[a-zA-Z0-9_]+$/.test(id)) {
                errorMessage = 'ID chỉ được chứa chữ cái, số và dấu gạch dưới!';
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
        
        // Real-time validation for Password
        function validateUserPassword(input) {
            var password = input.value;
            var errorDiv = document.getElementById('userPasswordError');
            var isValid = true;
            var errorMessage = '';
            
            if (password === '') {
                errorMessage = 'Mật khẩu không được để trống!';
                isValid = false;
            } else if (password.length < 6) {
                errorMessage = 'Mật khẩu phải có ít nhất 6 ký tự!';
                isValid = false;
            } else if (password.length > 50) {
                errorMessage = 'Mật khẩu không được quá 50 ký tự!';
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
        
        // Real-time validation for Fullname
        function validateUserFullname(input) {
            var fullname = input.value.trim();
            var errorDiv = document.getElementById('userFullnameError');
            var isValid = true;
            var errorMessage = '';
            
            if (fullname === '') {
                errorMessage = 'Họ tên không được để trống!';
                isValid = false;
            } else if (fullname.length < 2) {
                errorMessage = 'Họ tên phải có ít nhất 2 ký tự!';
                isValid = false;
            } else if (fullname.length > 100) {
                errorMessage = 'Họ tên không được quá 100 ký tự!';
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
        
        // Real-time validation for Email
        function validateUserEmail(input) {
            var email = input.value.trim();
            var errorDiv = document.getElementById('userEmailError');
            var isValid = true;
            var errorMessage = '';
            
            if (email === '') {
                errorMessage = 'Email không được để trống!';
                isValid = false;
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                errorMessage = 'Định dạng email không hợp lệ!';
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
        
        // Real-time validation for Mobile
        function validateUserMobile(input) {
            var mobile = input.value.trim();
            var errorDiv = document.getElementById('userMobileError');
            var isValid = true;
            var errorMessage = '';
            
            // Mobile is optional, only validate if not empty
            if (mobile !== '') {
                if (!/^[0-9]{10,11}$/.test(mobile)) {
                    errorMessage = 'Số điện thoại phải có 10-11 chữ số!';
                    isValid = false;
                }
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
        function validateUserForm() {
            var idInput = document.getElementById('userId');
            var passwordInput = document.getElementById('userPassword');
            var fullnameInput = document.getElementById('userFullname');
            var emailInput = document.getElementById('userEmail');
            var mobileInput = document.getElementById('userMobile');
            
            // Validate all fields
            var idValid = validateUserId(idInput);
            var passwordValid = validateUserPassword(passwordInput);
            var fullnameValid = validateUserFullname(fullnameInput);
            var emailValid = validateUserEmail(emailInput);
            var mobileValid = validateUserMobile(mobileInput);
            
            // If any required field is invalid, prevent form submission
            if (!idValid || !passwordValid || !fullnameValid || !emailValid || !mobileValid) {
                // Focus on first invalid field
                if (!idValid) {
                    idInput.focus();
                } else if (!passwordValid) {
                    passwordInput.focus();
                } else if (!fullnameValid) {
                    fullnameInput.focus();
                } else if (!emailValid) {
                    emailInput.focus();
                } else if (!mobileValid) {
                    mobileInput.focus();
                }
                return false;
            }
            
            return true;
        }
        
        // Admin specific functions
        function bulkAction(action) {
            var checkboxes = document.querySelectorAll('input[name="selectedUsers"]:checked');
            if (checkboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một người dùng!');
                return;
            }
            
            var ids = Array.from(checkboxes).map(cb => cb.value);
            var message = action === 'delete' ? 'xóa' : action === 'activate' ? 'kích hoạt' : 'vô hiệu hóa';
            
            if (confirm('Bạn có chắc chắn muốn ' + message + ' ' + ids.length + ' người dùng đã chọn?')) {
                // Implement bulk action logic here
                console.log('Bulk ' + action + ' for IDs:', ids);
            }
        }
        
        // Toggle all checkboxes
        function toggleAll(source) {
            var checkboxes = document.querySelectorAll('input[name="selectedUsers"]');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = source.checked;
            });
        }
        
        // Generate avatar initials
        function getInitials(fullname) {
            return fullname.split(' ').map(word => word.charAt(0)).join('').substring(0, 2).toUpperCase();
        }
        
        // Initialize avatars
        document.addEventListener('DOMContentLoaded', function() {
            var avatars = document.querySelectorAll('.user-avatar[data-name]');
            avatars.forEach(function(avatar) {
                var fullname = avatar.getAttribute('data-name');
                avatar.textContent = getInitials(fullname);
            });
        });
    </script>
</body>
</html>