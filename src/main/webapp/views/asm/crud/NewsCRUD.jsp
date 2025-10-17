<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Main CRUD Content -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-newspaper me-2"></i>
                    <c:choose>
                        <c:when test="${action == 'create'}">Tạo tin tức mới</c:when>
                        <c:when test="${action == 'edit'}">Chỉnh sửa tin tức</c:when>
                        <c:when test="${action == 'view'}">Chi tiết tin tức</c:when>
                        <c:otherwise>Quản lý tin tức</c:otherwise>
                    </c:choose>
                </h5>
            </div>
            <div class="card-body">
                
                <!-- List View -->
                <c:if test="${action == 'list' || empty action}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">Danh sách tin tức</h6>
                        <a href="${pageContext.request.contextPath}/phongvien/create" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Tạo tin tức mới
                        </a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty newsList}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hình ảnh</th>
                                            <th>Tiêu đề</th>
                                            <th>Tác giả</th>
                                            <th>Ngày đăng</th>
                                            <th>Lượt xem</th>
                                            <th>Trang nhất</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="news" items="${newsList}">
                                            <tr>
                                                <td><strong>${news.id}</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty news.image}">
                                                            <img src="${news.image}" alt="News Image" class="news-image">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="bg-light d-flex align-items-center justify-content-center news-image">
                                                                <i class="fas fa-image text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <strong>${news.title}</strong>
                                                    <br>
                                                    <small class="text-muted">
                                                        ${news.content.length() > 100 ? news.content.substring(0, 100).concat('...') : news.content}
                                                    </small>
                                                </td>
                                                <td>${news.author}</td>
                                                <td>
                                                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info">${news.viewCount}</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${news.home}">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-check"></i> Có
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">
                                                                <i class="fas fa-times"></i> Không
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/phongvien/view?id=${news.id}" 
                                                       class="btn btn-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/phongvien/edit?id=${news.id}" 
                                                       class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button onclick="confirmDelete('${news.id}', '${news.title}')" 
                                                            class="btn btn-danger btn-sm" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">Chưa có tin tức nào</h5>
                                <p class="text-muted">Hãy tạo tin tức đầu tiên của bạn!</p>
                                <a href="${pageContext.request.contextPath}/phongvien/create" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i> Tạo tin tức mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                
                <!-- Create/Edit Form -->
                <c:if test="${action == 'create' || action == 'edit'}">
                    <form method="post" 
                          action="${pageContext.request.contextPath}/phongvien/${action == 'edit' ? 'update' : 'create'}"
                          onsubmit="return validateForm()">
                        
                        <c:if test="${action == 'edit'}">
                            <input type="hidden" name="id" value="${news.id}">
                        </c:if>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsId" class="form-label">
                                        ID tin tức <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="newsId" name="id" 
                                           value="${news.id}" ${action == 'edit' ? 'readonly' : ''} required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="categoryId" class="form-label">Danh mục</label>
                                    <input type="text" class="form-control" id="categoryId" name="categoryId" 
                                           value="${news.categoryId}" placeholder="VD: thoi-su, the-gioi, kinh-te">
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newsTitle" class="form-label">
                                Tiêu đề <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="newsTitle" name="title" 
                                   value="${news.title}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newsContent" class="form-label">
                                Nội dung <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="newsContent" name="content" rows="8" required>${news.content}</textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsImage" class="form-label">URL hình ảnh</label>
                                    <input type="url" class="form-control" id="newsImage" name="image" 
                                           value="${news.image}" placeholder="https://example.com/image.jpg">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsAuthor" class="form-label">Tác giả</label>
                                    <input type="text" class="form-control" id="newsAuthor" name="author" 
                                           value="${news.author}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="viewCount" class="form-label">Lượt xem</label>
                                    <input type="number" class="form-control" id="viewCount" name="viewCount" 
                                           value="${news.viewCount}" min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <div class="form-check mt-4">
                                        <input class="form-check-input" type="checkbox" id="newsHome" name="home" 
                                               ${news.home ? 'checked' : ''}>
                                        <label class="form-check-label" for="newsHome">
                                            Hiển thị trên trang nhất
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/phongvien" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> 
                                ${action == 'edit' ? 'Cập nhật' : 'Tạo mới'}
                            </button>
                        </div>
                    </form>
                </c:if>
                
                <!-- View Detail -->
                <c:if test="${action == 'view'}">
                    <div class="row">
                        <div class="col-md-8">
                            <h2 class="mb-3">${news.title}</h2>
                            
                            <div class="mb-3">
                                <small class="text-muted">
                                    <i class="fas fa-user me-1"></i> ${news.author} | 
                                    <i class="fas fa-calendar me-1"></i> 
                                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/> | 
                                    <i class="fas fa-eye me-1"></i> ${news.viewCount} lượt xem
                                </small>
                            </div>
                            
                            <c:if test="${not empty news.image}">
                                <div class="mb-4">
                                    <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">
                                </div>
                            </c:if>
                            
                            <div class="news-content">
                                <p style="white-space: pre-wrap;">${news.content}</p>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">Thông tin tin tức</h6>
                                </div>
                                <div class="card-body">
                                    <table class="table table-sm">
                                        <tr>
                                            <td><strong>ID:</strong></td>
                                            <td>${news.id}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Danh mục:</strong></td>
                                            <td>${news.categoryId}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Tác giả:</strong></td>
                                            <td>${news.author}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Ngày đăng:</strong></td>
                                            <td>
                                                <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Lượt xem:</strong></td>
                                            <td>${news.viewCount}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Trang nhất:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${news.home}">
                                                        <span class="badge bg-success">Có</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Không</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/phongvien/edit?id=${news.id}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit me-1"></i> Chỉnh sửa
                                        </a>
                                        <button onclick="confirmDelete('${news.id}', '${news.title}')" 
                                                class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash me-1"></i> Xóa
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/phongvien" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                        </a>
                    </div>
                </c:if>
                
            </div>
        </div>
    </div>
</div>