<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Sử dụng contextPath từ servlet hoặc fallback detection --%>
<c:choose>
    <c:when test="${not empty contextPath}">
        <%-- Servlet đã set contextPath --%>
        <c:set var="currentContext" value="${contextPath}" />
    </c:when>
    <c:otherwise>
        <%-- Fallback: tự động phát hiện từ URL --%>
        <c:set var="requestURI" value="${pageContext.request.requestURI}" />
        <c:set var="currentContext" value="${requestURI.contains('/quanli/') ? 'quanli/user' : 'user'}" />
    </c:otherwise>
</c:choose>

<c:set var="baseUrl" value="${pageContext.request.contextPath}/${currentContext}" />

<%-- Context detection completed --%>

<!-- Main CRUD Content -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-users me-2"></i>
                    <c:choose>
                        <c:when test="${action == 'create'}">Tạo người dùng mới</c:when>
                        <c:when test="${action == 'edit'}">Chỉnh sửa người dùng</c:when>
                        <c:when test="${action == 'view'}">Chi tiết người dùng</c:when>
                        <c:otherwise>Quản lý người dùng</c:otherwise>
                    </c:choose>
                </h5>
            </div>
            <div class="card-body">
                
                <!-- List View -->
                <c:if test="${action == 'list' || empty action}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">Danh sách người dùng</h6>
                        <a href="${baseUrl}/new" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Tạo người dùng mới
                        </a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty userList}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Avatar</th>
                                            <th>ID</th>
                                            <th>Họ tên</th>
                                            <th>Email</th>
                                            <th>Giới tính</th>
                                            <th>Ngày sinh</th>
                                            <th>Vai trò</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${userList}">
                                            <tr>
                                                <td>
                                                    <div class="user-avatar" data-name="${user.fullname}"></div>
                                                </td>
                                                <td><strong>${user.id}</strong></td>
                                                <td>
                                                    <strong>${user.fullname}</strong>
                                                    <br>
                                                    <small class="text-muted">${user.mobile}</small>
                                                </td>
                                                <td>${user.email}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.gender}">
                                                            <span class="gender-badge gender-male">
                                                                <i class="fas fa-mars"></i> Nam
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="gender-badge gender-female">
                                                                <i class="fas fa-venus"></i> Nữ
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty user.birthday}">
                                                        <fmt:formatDate value="${user.birthday}" pattern="dd/MM/yyyy"/>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.role}">
                                                            <span class="role-badge role-admin">
                                                                <i class="fas fa-crown"></i> Admin
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="role-badge role-reporter">
                                                                <i class="fas fa-pen"></i> Phóng viên
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="action-buttons">
                                                    <a href="${baseUrl}/view?id=${user.id}" class="btn btn-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${baseUrl}/edit?id=${user.id}" class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button onclick="confirmDelete('${user.id}', '${user.fullname}', '${baseUrl}')" 
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
                                <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">Chưa có người dùng nào</h5>
                                <p class="text-muted">Hãy tạo người dùng đầu tiên của bạn!</p>
                                <a href="${baseUrl}/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i> Tạo người dùng mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                
                <!-- Create/Edit Form -->
                <c:if test="${action == 'create' || action == 'edit'}">
                    <form method="post" action="${baseUrl}/${action == 'edit' ? 'update' : 'new'}" onsubmit="return validateUserForm()">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userId" class="form-label">ID người dùng <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="userId" name="id" 
                                           value="${user.id}" ${action == 'edit' ? 'readonly' : ''} required>
                                    <div class="form-text">Chỉ được chứa chữ cái, số và dấu gạch dưới</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userPassword" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" id="userPassword" name="password" 
                                           value="${user.password}" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="userFullname" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="userFullname" name="fullname" 
                                           value="${user.fullname}" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="userBirthday" class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" id="userBirthday" name="birthday" 
                                           value="${user.birthday}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="userEmail" name="email" 
                                           value="${user.email}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userMobile" class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="userMobile" name="mobile" 
                                           value="${user.mobile}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Giới tính</label>
                                    <div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="genderMale" 
                                                   value="true" ${user.gender ? 'checked' : ''}>
                                            <label class="form-check-label" for="genderMale">
                                                <i class="fas fa-mars text-primary"></i> Nam
                                            </label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" 
                                                   value="false" ${!user.gender && user.gender != null ? 'checked' : ''}>
                                            <label class="form-check-label" for="genderFemale">
                                                <i class="fas fa-venus text-danger"></i> Nữ
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Vai trò</label>
                                    <div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="role" id="roleAdmin" 
                                                   value="true" ${user.role ? 'checked' : ''}>
                                            <label class="form-check-label" for="roleAdmin">
                                                <i class="fas fa-crown text-warning"></i> Admin
                                            </label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="role" id="roleReporter" 
                                                   value="false" ${!user.role && user.role != null ? 'checked' : ''}>
                                            <label class="form-check-label" for="roleReporter">
                                                <i class="fas fa-pen text-success"></i> Phóng viên
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${baseUrl}" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> 
                                ${action == 'edit' ? 'Cập nhật' : 'Tạo mới'}
                            </button>
                        </div>
                    </form>
                </c:if>
                
                <!-- View Details -->
                <c:if test="${action == 'view'}">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <div class="user-avatar mx-auto mb-3" data-name="${user.fullname}" style="width: 120px; height: 120px; font-size: 2rem;"></div>
                            <h4>${user.fullname}</h4>
                            <p class="text-muted">${user.email}</p>
                            
                            <c:choose>
                                <c:when test="${user.role}">
                                    <span class="role-badge role-admin fs-6">
                                        <i class="fas fa-crown"></i> Admin
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="role-badge role-reporter fs-6">
                                        <i class="fas fa-pen"></i> Phóng viên
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title">Thông tin chi tiết</h6>
                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-4"><strong>ID:</strong></div>
                                        <div class="col-sm-8">${user.id}</div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-4"><strong>Họ và tên:</strong></div>
                                        <div class="col-sm-8">${user.fullname}</div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-4"><strong>Email:</strong></div>
                                        <div class="col-sm-8">
                                            <a href="mailto:${user.email}">${user.email}</a>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty user.mobile}">
                                        <div class="row mb-3">
                                            <div class="col-sm-4"><strong>Số điện thoại:</strong></div>
                                            <div class="col-sm-8">
                                                <a href="tel:${user.mobile}">${user.mobile}</a>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-4"><strong>Giới tính:</strong></div>
                                        <div class="col-sm-8">
                                            <c:choose>
                                                <c:when test="${user.gender}">
                                                    <span class="gender-badge gender-male">
                                                        <i class="fas fa-mars"></i> Nam
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="gender-badge gender-female">
                                                        <i class="fas fa-venus"></i> Nữ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty user.birthday}">
                                        <div class="row mb-3">
                                            <div class="col-sm-4"><strong>Ngày sinh:</strong></div>
                                            <div class="col-sm-8">
                                                <fmt:formatDate value="${user.birthday}" pattern="dd/MM/yyyy"/>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <div class="row mb-3">
                                        <div class="col-sm-4"><strong>Vai trò:</strong></div>
                                        <div class="col-sm-8">
                                            <c:choose>
                                                <c:when test="${user.role}">
                                                    <span class="role-badge role-admin">
                                                        <i class="fas fa-crown"></i> Quản trị viên
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="role-badge role-reporter">
                                                        <i class="fas fa-pen"></i> Phóng viên
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${baseUrl}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                        </a>
                        <div>
                            <a href="${baseUrl}/edit?id=${user.id}" class="btn btn-warning">
                                <i class="fas fa-edit me-1"></i> Chỉnh sửa
                            </a>
                            <button onclick="confirmDelete('${user.id}', '${user.fullname}', '${baseUrl}')" 
                                    class="btn btn-danger">
                                <i class="fas fa-trash me-1"></i> Xóa
                            </button>
                        </div>
                    </div>
                </c:if>
                
            </div>
        </div>
    </div>
</div>