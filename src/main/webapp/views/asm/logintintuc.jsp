<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Khoa News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            width: 100%;
            max-width: 450px;
            backdrop-filter: blur(10px);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-header h2 {
            color: #333;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .login-header p {
            color: #666;
            margin: 0;
        }
        
        .form-floating {
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            width: 100%;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            color: white;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            margin-bottom: 1.5rem;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
        }
        
        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: white;
            font-size: 2rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="logo">
                <i class="fas fa-newspaper"></i>
            </div>
            <h2>Đăng nhập</h2>
            <p>Khoa News - Hệ thống quản lý tin tức</p>
        </div>
        
        <!-- Hiển thị thông báo lỗi -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${errorMessage}
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/logintintuc" method="post" id="loginForm">
            <div class="form-floating mb-3">
                <input type="text" 
                       class="form-control" 
                       id="userId" 
                       name="userId" 
                       placeholder="Tên đăng nhập"
                       value="${userId}"
                       required>
                <label for="userId">Tên đăng nhập</label>
            </div>
            
            <div class="form-floating mb-4">
                <input type="password" 
                       class="form-control" 
                       id="password" 
                       name="password" 
                       placeholder="Mật khẩu"
                       required>
                <label for="password">Mật khẩu</label>
            </div>
            
            <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt me-2"></i>
                Đăng nhập
            </button>
        </form>
        
        <div class="text-center mt-4">
            <small class="text-muted">
                <i class="fas fa-info-circle me-1"></i>
                Liên hệ quản trị viên nếu quên mật khẩu
            </small>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const userId = document.getElementById('userId').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!userId || !password) {
                e.preventDefault();
                showAlert('Vui lòng nhập đầy đủ thông tin đăng nhập!', 'danger');
                return false;
            }
            
            // Hiển thị loading
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
            submitBtn.disabled = true;
            
            // Khôi phục button sau 3 giây nếu có lỗi
            setTimeout(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }, 3000);
        });
        
        // Hàm hiển thị alert
        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
            alertDiv.innerHTML = `
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            
            const form = document.getElementById('loginForm');
            form.parentNode.insertBefore(alertDiv, form);
            
            // Tự động ẩn sau 5 giây
            setTimeout(() => {
                alertDiv.remove();
            }, 5000);
        }
        
        // Focus vào input đầu tiên
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('userId').focus();
        });
        
        // Enter key navigation
        document.getElementById('userId').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('password').focus();
            }
        });
    </script>
</body>
</html>