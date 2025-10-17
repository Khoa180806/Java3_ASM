<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<header class="bg-primary text-white py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h4 mb-0">
                    <i class="fas fa-newspaper me-2"></i>
                    Trang quản lý của phóng viên 
                    <c:if test="${not empty sessionScope.user.hoTen}">
                        ${sessionScope.user.hoTen}
                    </c:if>
                </h1>
                <p class="mb-0 small">Khoa News - Hệ thống quản lý tin tức</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/dang-xuat" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </div>
</header>