<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Dynamic context detection -->
<c:choose>
    <c:when test="${not empty contextPath}">
        <c:set var="currentContext" value="${contextPath}" />
    </c:when>
    <c:otherwise>
        <c:set var="requestURI" value="${pageContext.request.requestURI}" />
        <c:set var="currentContext" value="${requestURI.contains('/quanli/') ? 'quanli/category' : 'category'}" />
    </c:otherwise>
</c:choose>
<c:set var="baseUrl" value="${pageContext.request.contextPath}/${currentContext}" />

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-tags me-2"></i>
                    <c:choose>
                        <c:when test="${action == 'new'}">${i18n_categoryAdd}</c:when>
                        <c:when test="${action == 'edit'}">${i18n_categoryEdit}</c:when>
                        <c:when test="${action == 'view'}">${i18n_categoryView}</c:when>
                        <c:otherwise>${i18n_categoryManage}</c:otherwise>
                    </c:choose>
                </h5>
                <c:if test="${action == 'list'}">
                    <a href="${baseUrl}/new" class="btn btn-primary">
                        <i class="fas fa-plus me-1"></i>${i18n_buttonCreate}
                    </a>
                </c:if>
            </div>
            
            <div class="card-body">
                <!-- Form for Create/Edit -->
                <c:if test="${action == 'new' || action == 'edit'}">
                    <form method="post" action="${baseUrl}/${action == 'edit' ? 'update' : 'new'}" onsubmit="return validateCategoryForm()">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="categoryId" class="form-label">
                                        ${i18n_categoryId} <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="categoryId" 
                                           name="categoryId" 
                                           value="${category.id}" 
                                           ${action == 'edit' ? 'readonly' : ''}
                                           placeholder="Nhập ID danh mục (VD: TECH, SPORT, NEWS...)"
                                           required>
                                    <div class="form-text">ID không được thay đổi sau khi tạo</div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="categoryName" class="form-label">
                                        ${i18n_categoryName} <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="categoryName" 
                                           name="categoryName" 
                                           value="${category.name}" 
                                           placeholder="Nhập tên danh mục"
                                           required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i>
                                ${action == 'edit' ? i18n_buttonUpdate : i18n_buttonCreate}
                            </button>
                            <a href="${baseUrl}" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i>${i18n_buttonBackShort}
                            </a>
                        </div>
                    </form>
                </c:if>
                
                <!-- View Details -->
                <c:if test="${action == 'view'}">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">${i18n_categoryId}:</label>
                                <p class="form-control-plaintext">${category.id}</p>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">${i18n_categoryName}:</label>
                                <p class="form-control-plaintext">${category.name}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                        <a href="${baseUrl}/edit?id=${category.id}" class="btn btn-warning">
                            <i class="fas fa-edit me-1"></i>${i18n_actionEdit}
                        </a>
                        <a href="${baseUrl}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i>Quay lại
                        </a>
                    </div>
                </c:if>
                
                <!-- List Categories -->
                <c:if test="${action == 'list'}">
                    <c:choose>
                        <c:when test="${not empty categories}">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%">#</th>
                                            <th style="width: 20%">${i18n_categoryId}</th>
                                            <th style="width: 45%">${i18n_categoryName}</th>
                                            <th style="width: 30%" class="text-center">${i18n_tableActions}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="category" items="${categories}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>
                                                    <span class="badge bg-primary">${category.id}</span>
                                                </td>
                                                <td>
                                                    <strong>${category.name}</strong>
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group" role="group">
                                                        <a href="${baseUrl}/view?id=${category.id}" 
                                                           class="btn btn-sm btn-info" 
                                                           title="Xem chi tiết">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <a href="${baseUrl}/edit?id=${category.id}" 
                                                           class="btn btn-sm btn-warning" 
                                                           title="${i18n_actionEdit}">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button type="button" 
                                                                class="btn btn-sm btn-danger" 
                                                                onclick="confirmCategoryDelete('${category.id}', '${category.name}', '${baseUrl}')"
                                                                title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Statistics -->
                            <div class="mt-3">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Tổng cộng: <strong>${categories.size()}</strong> danh mục
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-tags fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">${i18n_emptyCategoryTitle}</h5>
                                <p class="text-muted">${i18n_emptyCategoryDescription}</p>
                                <a href="${baseUrl}/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>${i18n_emptyCategoryAction}
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script>
// Form validation for Category
function validateCategoryForm() {
    var id = document.getElementById('categoryId').value.trim();
    var name = document.getElementById('categoryName').value.trim();
    
    if (id === '' || name === '') {
        alert('Vui lòng điền đầy đủ thông tin bắt buộc (ID và Tên danh mục)!');
        return false;
    }
    
    // Validate ID format (chỉ chứa chữ cái, số và dấu gạch dưới)
    var idPattern = /^[A-Z0-9_]+$/;
    if (!idPattern.test(id)) {
        alert('ID danh mục chỉ được chứa chữ cái in hoa, số và dấu gạch dưới!');
        return false;
    }
    
    return true;
}

// Confirm delete for Category
function confirmCategoryDelete(categoryId, categoryName, baseUrl) {
    if (confirm('Bạn có chắc chắn muốn xóa danh mục "' + categoryName + '" (ID: ' + categoryId + ')?\n\nLưu ý: Việc xóa danh mục có thể ảnh hưởng đến các tin tức đang sử dụng danh mục này.')) {
        window.location.href = baseUrl + '/delete?id=' + categoryId;
    }
}
</script>