<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Dynamic context detection -->
<c:choose>
    <c:when test="${not empty contextPath}">
        <c:set var="currentContext" value="${contextPath}" />
    </c:when>
    <c:otherwise>
        <c:set var="requestURI" value="${pageContext.request.requestURI}" />
        <c:set var="currentContext" value="${requestURI.contains('/quanli/') ? 'quanli/newsletter' : 'newsletter'}" />
    </c:otherwise>
</c:choose>
<c:set var="baseUrl" value="${pageContext.request.contextPath}/${currentContext}" />

<!-- Main Content -->
<div class="container-fluid">
    
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h3 mb-0">
                <i class="fas fa-envelope-open-text text-primary me-2"></i>
                <c:choose>
                    <c:when test="${action == 'view'}">Chi tiết Newsletter</c:when>
                    <c:when test="${action == 'disable'}">Vô hiệu hóa Newsletter</c:when>
                    <c:when test="${action == 'delete'}">Xóa Newsletter</c:when>
                    <c:otherwise>Quản lý Newsletter</c:otherwise>
                </c:choose>
            </h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/quanli/">Quản lý</a></li>
                    <li class="breadcrumb-item"><a href="${baseUrl}/">Newsletter</a></li>
                    <c:if test="${action != 'list' && not empty action}">
                        <li class="breadcrumb-item active" aria-current="page">
                            <c:choose>
                                <c:when test="${action == 'view'}">Chi tiết</c:when>
                                <c:when test="${action == 'disable'}">Vô hiệu hóa</c:when>
                                <c:when test="${action == 'delete'}">Xóa</c:when>
                                <c:otherwise>${action}</c:otherwise>
                            </c:choose>
                        </li>
                    </c:if>
                </ol>
            </nav>
        </div>
    </div>

    <!-- Statistics Cards (chỉ hiển thị ở trang danh sách) -->
    <c:if test="${action == 'list' || empty action}">
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary bg-gradient rounded-circle p-3">
                                    <i class="fas fa-envelope text-white"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="card-title text-muted mb-1">Tổng Email</h6>
                                <h4 class="mb-0">${totalEmails}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-success bg-gradient rounded-circle p-3">
                                    <i class="fas fa-check-circle text-white"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="card-title text-muted mb-1">Đang Hoạt Động</h6>
                                <h4 class="mb-0 text-success">${activeEmails}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-warning bg-gradient rounded-circle p-3">
                                    <i class="fas fa-pause-circle text-white"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="card-title text-muted mb-1">Đã Vô Hiệu Hóa</h6>
                                <h4 class="mb-0 text-warning">${inactiveEmails}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Main Content Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            
            <!-- Danh sách Newsletter -->
            <c:if test="${action == 'list' || empty action}">
                <!-- Bulk Actions -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form id="bulkActionForm" method="post" action="${baseUrl}/bulk-action">
                            <div class="input-group">
                                <select name="action" class="form-select" style="max-width: 200px;">
                                    <option value="">Chọn thao tác...</option>
                                    <option value="disable">Vô hiệu hóa</option>
                                    <option value="delete">Xóa</option>
                                </select>
                                <button type="submit" class="btn btn-outline-primary" onclick="return confirmBulkAction()">
                                    <i class="fas fa-play me-1"></i>Thực hiện
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm email...">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Newsletter Table -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th width="50">
                                    <input type="checkbox" id="selectAll" class="form-check-input">
                                </th>
                                <th>Email</th>
                                <th width="120">Trạng Thái</th>
                                <th width="150">Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty newsletters}">
                                    <c:forEach var="newsletter" items="${newsletters}">
                                        <tr class="newsletter-row" data-email="${newsletter.email}">
                                            <td>
                                                <input type="checkbox" name="selectedEmails" value="${newsletter.email}" 
                                                       class="form-check-input newsletter-checkbox">
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-envelope text-muted me-2"></i>
                                                    <span class="fw-medium">${newsletter.email}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${newsletter.enabled}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check-circle me-1"></i>Hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">
                                                            <i class="fas fa-pause-circle me-1"></i>Vô hiệu hóa
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <a href="${baseUrl}/view?email=${newsletter.email}" 
                                                       class="btn btn-outline-info" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${newsletter.enabled}">
                                                        <a href="${baseUrl}/disable?email=${newsletter.email}" 
                                                           class="btn btn-outline-warning" title="Vô hiệu hóa">
                                                            <i class="fas fa-pause"></i>
                                                        </a>
                                                    </c:if>
                                                    <button type="button" class="btn btn-outline-danger" 
                                                            onclick="confirmDelete('${newsletter.email}', '${baseUrl}')" 
                                                            title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">
                                            <i class="fas fa-inbox fa-2x mb-2"></i>
                                            <p class="mb-0">Chưa có email nào đăng ký newsletter</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- Chi tiết Newsletter -->
            <c:if test="${action == 'view'}">
                <div class="row">
                    <div class="col-md-8 mx-auto">
                        <div class="card border-0 bg-light">
                            <div class="card-body">
                                <div class="text-center mb-4">
                                    <div class="bg-primary bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" 
                                         style="width: 80px; height: 80px;">
                                        <i class="fas fa-envelope fa-2x text-white"></i>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-sm-4">
                                        <strong>Email:</strong>
                                    </div>
                                    <div class="col-sm-8">
                                        <span class="text-primary fw-medium">${newsletter.email}</span>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-sm-4">
                                        <strong>Trạng thái:</strong>
                                    </div>
                                    <div class="col-sm-8">
                                        <c:choose>
                                            <c:when test="${newsletter.enabled}">
                                                <span class="badge bg-success fs-6">
                                                    <i class="fas fa-check-circle me-1"></i>Đang hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning fs-6">
                                                    <i class="fas fa-pause-circle me-1"></i>Đã vô hiệu hóa
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <hr>
                                
                                <div class="d-flex gap-2 justify-content-center">
                                    <a href="${baseUrl}/" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                                    </a>
                                    <c:if test="${newsletter.enabled}">
                                        <a href="${baseUrl}/disable?email=${newsletter.email}" class="btn btn-warning">
                                            <i class="fas fa-pause me-1"></i>Vô hiệu hóa
                                        </a>
                                    </c:if>
                                    <button type="button" class="btn btn-danger" 
                                            onclick="confirmDelete('${newsletter.email}', '${baseUrl}')">
                                        <i class="fas fa-trash me-1"></i>Xóa
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Form Vô hiệu hóa -->
            <c:if test="${action == 'disable'}">
                <div class="row">
                    <div class="col-md-6 mx-auto">
                        <div class="text-center mb-4">
                            <div class="bg-warning bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 80px; height: 80px;">
                                <i class="fas fa-pause fa-2x text-white"></i>
                            </div>
                            <h4 class="mt-3">Vô hiệu hóa Newsletter</h4>
                            <p class="text-muted">Bạn có chắc chắn muốn vô hiệu hóa email này?</p>
                        </div>
                        
                        <div class="card border-warning">
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Email:</strong> 
                                    <span class="text-primary">${newsletter.email}</span>
                                </div>
                                <div class="mb-3">
                                    <strong>Trạng thái hiện tại:</strong> 
                                    <span class="badge bg-success">Đang hoạt động</span>
                                </div>
                                
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Email này sẽ không nhận được newsletter nữa sau khi vô hiệu hóa.
                                </div>
                                
                                <form method="post" action="${baseUrl}/disable">
                                    <input type="hidden" name="email" value="${newsletter.email}">
                                    <div class="d-flex gap-2 justify-content-center">
                                        <a href="${baseUrl}/" class="btn btn-secondary">
                                            <i class="fas fa-times me-1"></i>Hủy
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-pause me-1"></i>Vô hiệu hóa
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Form Xóa -->
            <c:if test="${action == 'delete'}">
                <div class="row">
                    <div class="col-md-6 mx-auto">
                        <div class="text-center mb-4">
                            <div class="bg-danger bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 80px; height: 80px;">
                                <i class="fas fa-trash fa-2x text-white"></i>
                            </div>
                            <h4 class="mt-3 text-danger">Xóa Newsletter</h4>
                            <p class="text-muted">Bạn có chắc chắn muốn xóa email này?</p>
                        </div>
                        
                        <div class="card border-danger">
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Email:</strong> 
                                    <span class="text-primary">${newsletter.email}</span>
                                </div>
                                <div class="mb-3">
                                    <strong>Trạng thái:</strong> 
                                    <c:choose>
                                        <c:when test="${newsletter.enabled}">
                                            <span class="badge bg-success">Đang hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning">Đã vô hiệu hóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Cảnh báo:</strong> Thao tác này không thể hoàn tác. 
                                    Email sẽ bị xóa vĩnh viễn khỏi hệ thống.
                                </div>
                                
                                <form method="post" action="${baseUrl}/delete">
                                    <input type="hidden" name="email" value="${newsletter.email}">
                                    <div class="d-flex gap-2 justify-content-center">
                                        <a href="${baseUrl}/" class="btn btn-secondary">
                                            <i class="fas fa-times me-1"></i>Hủy
                                        </a>
                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-trash me-1"></i>Xóa vĩnh viễn
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
// Search functionality
document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('.newsletter-row');
    
    rows.forEach(row => {
        const email = row.getAttribute('data-email').toLowerCase();
        if (email.includes(searchTerm)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});

// Select all functionality
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.newsletter-checkbox');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

// Update select all when individual checkboxes change
document.querySelectorAll('.newsletter-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
        const allCheckboxes = document.querySelectorAll('.newsletter-checkbox');
        const checkedCheckboxes = document.querySelectorAll('.newsletter-checkbox:checked');
        const selectAllCheckbox = document.getElementById('selectAll');
        
        if (checkedCheckboxes.length === allCheckboxes.length) {
            selectAllCheckbox.checked = true;
            selectAllCheckbox.indeterminate = false;
        } else if (checkedCheckboxes.length > 0) {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = true;
        } else {
            selectAllCheckbox.checked = false;
            selectAllCheckbox.indeterminate = false;
        }
    });
});

// Confirm delete function
function confirmDelete(email, baseUrl) {
    if (confirm('Bạn có chắc chắn muốn xóa email "' + email + '"?\n\nThao tác này không thể hoàn tác.')) {
        window.location.href = baseUrl + '/delete?email=' + encodeURIComponent(email);
    }
}

// Confirm bulk action
function confirmBulkAction() {
    const form = document.getElementById('bulkActionForm');
    const action = form.querySelector('select[name="action"]').value;
    const checkedBoxes = document.querySelectorAll('.newsletter-checkbox:checked');
    
    if (!action) {
        alert('Vui lòng chọn thao tác cần thực hiện.');
        return false;
    }
    
    if (checkedBoxes.length === 0) {
        alert('Vui lòng chọn ít nhất một email.');
        return false;
    }
    
    const actionText = action === 'disable' ? 'vô hiệu hóa' : 'xóa';
    const message = `Bạn có chắc chắn muốn ${actionText} ${checkedBoxes.length} email đã chọn?`;
    
    if (action === 'delete') {
        return confirm(message + '\n\nThao tác này không thể hoàn tác.');
    }
    
    return confirm(message);
}
</script>