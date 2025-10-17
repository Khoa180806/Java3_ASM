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
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            border: none;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a32a3 0%, #d91a72 100%);
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
            border-color: #6f42c1;
            box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
        }
        
        .action-buttons .btn {
            margin: 0 2px;
        }
        
        .admin-badge {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            color: white;
            padding: 2px 8px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: bold;
        }
        
        /* Newsletter specific styles */
        .newsletter-stats .card {
            transition: transform 0.2s;
        }
        
        .newsletter-stats .card:hover {
            transform: translateY(-2px);
        }
        
        .email-badge {
            background: linear-gradient(135deg, #17a2b8 0%, #6610f2 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
        }
        
        .status-active {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }
        
        .status-inactive {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
        }
        
        .newsletter-row:hover {
            background-color: rgba(111, 66, 193, 0.05);
        }
        
        .bulk-actions {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="quanliheader.jsp" />
    
    <!-- Navigation -->
    <jsp:include page="quanlinav.jsp" />
    
    <!-- Main Content -->
    <div class="container-fluid main-content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty warning}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${warning}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- URL Parameters Messages -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success == 'disable'}">Đã vô hiệu hóa email thành công!</c:when>
                    <c:when test="${param.success == 'delete'}">Đã xóa email thành công!</c:when>
                    <c:when test="${param.success == 'bulk'}">Thao tác hàng loạt thành công!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'notfound'}">Không tìm thấy email!</c:when>
                    <c:when test="${param.error == 'invalid'}">Dữ liệu không hợp lệ!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Page Content -->
        <jsp:include page="../../crud/NewsLetterCRUD.jsp" />
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
        
        // Newsletter specific functions
        function confirmDeleteNewsletter(email, baseUrl) {
            if (confirm('Bạn có chắc chắn muốn xóa email "' + email + '"?\n\nThao tác này không thể hoàn tác.')) {
                window.location.href = baseUrl + '/delete?email=' + encodeURIComponent(email);
            }
        }
        
        function confirmDisableNewsletter(email, baseUrl) {
            if (confirm('Bạn có chắc chắn muốn vô hiệu hóa email "' + email + '"?\n\nEmail này sẽ không nhận được newsletter nữa.')) {
                window.location.href = baseUrl + '/disable?email=' + encodeURIComponent(email);
            }
        }
        
        // Bulk actions for newsletter
        function confirmBulkNewsletterAction(action, selectedEmails) {
            if (selectedEmails.length === 0) {
                alert('Vui lòng chọn ít nhất một email!');
                return false;
            }
            
            var actionText = action === 'disable' ? 'vô hiệu hóa' : 'xóa';
            var message = 'Bạn có chắc chắn muốn ' + actionText + ' ' + selectedEmails.length + ' email đã chọn?';
            
            if (action === 'delete') {
                message += '\n\nThao tác này không thể hoàn tác.';
            }
            
            return confirm(message);
        }
        
        // Toggle all checkboxes for newsletter
        function toggleAllNewsletters(source) {
            var checkboxes = document.querySelectorAll('input[name="selectedEmails"]');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = source.checked;
            });
        }
        
        // Search functionality enhancement
        function highlightSearchTerm(term) {
            var rows = document.querySelectorAll('.newsletter-row');
            rows.forEach(function(row) {
                var emailCell = row.querySelector('td:nth-child(2)');
                if (emailCell) {
                    var originalText = emailCell.getAttribute('data-original') || emailCell.textContent;
                    if (!emailCell.getAttribute('data-original')) {
                        emailCell.setAttribute('data-original', originalText);
                    }
                    
                    if (term && term.length > 0) {
                        var highlightedText = originalText.replace(
                            new RegExp('(' + term + ')', 'gi'),
                            '<mark>$1</mark>'
                        );
                        emailCell.innerHTML = highlightedText;
                    } else {
                        emailCell.textContent = originalText;
                    }
                }
            });
        }
        
        // Enhanced search with highlighting
        document.addEventListener('DOMContentLoaded', function() {
            var searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    var searchTerm = this.value.toLowerCase();
                    var rows = document.querySelectorAll('.newsletter-row');
                    
                    rows.forEach(function(row) {
                        var email = row.getAttribute('data-email').toLowerCase();
                        if (email.includes(searchTerm)) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                    
                    // Highlight search term
                    highlightSearchTerm(this.value);
                });
            }
        });
        
        // Statistics animation
        function animateStats() {
            var statNumbers = document.querySelectorAll('.newsletter-stats h4');
            statNumbers.forEach(function(stat) {
                var finalValue = parseInt(stat.textContent);
                var currentValue = 0;
                var increment = Math.ceil(finalValue / 20);
                
                var timer = setInterval(function() {
                    currentValue += increment;
                    if (currentValue >= finalValue) {
                        currentValue = finalValue;
                        clearInterval(timer);
                    }
                    stat.textContent = currentValue;
                }, 50);
            });
        }
        
        // Run stats animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(animateStats, 500);
        });
        
        // Email validation helper
        function validateEmail(email) {
            var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
        
        // Export functionality (future enhancement)
        function exportNewsletterList(format) {
            var emails = [];
            var rows = document.querySelectorAll('.newsletter-row:not([style*="display: none"])');
            
            rows.forEach(function(row) {
                var email = row.getAttribute('data-email');
                var statusElement = row.querySelector('.badge');
                var status = statusElement ? statusElement.textContent.trim() : 'Unknown';
                
                emails.push({
                    email: email,
                    status: status
                });
            });
            
            console.log('Export ' + format + ':', emails);
            // Implement actual export logic here
            alert('Xuất ' + emails.length + ' email sang định dạng ' + format.toUpperCase());
        }
    </script>
</body>
</html>