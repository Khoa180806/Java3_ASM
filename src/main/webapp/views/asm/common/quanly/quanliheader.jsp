<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="headerUser" value="${not empty sessionScope.currentUser ? sessionScope.currentUser : sessionScope.user}" />

<header class="bg-primary text-white py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h4 mb-0">
                    <i class="fas fa-newspaper me-2"></i>
                    ${i18n_appName} - ${i18n_roleAdmin}
                    <c:if test="${not empty headerUser}">
                        <span class="ms-2 fw-semibold">${headerUser.fullname}</span>
                    </c:if>
                </h1>
                <p class="mb-0 small">${i18n_appSlogan}</p>
            </div>
            <div class="text-end">
                <c:if test="${not empty headerUser}">
                    <div class="small mb-1">
                        <i class="fas fa-id-badge me-1"></i>${headerUser.id}
                        <span class="badge bg-light text-primary ms-2">
                            <i class="fas fa-user-shield me-1"></i>${sessionScope.roleName != null ? sessionScope.roleName : i18n_roleAdmin}
                        </span>
                    </div>
                </c:if>
                <!-- Language Switcher -->
                <div class="d-inline-block me-2">
                    <%@ include file="../language-switcher.jsp" %>
                </div>
                
                <a href="${pageContext.request.contextPath}/dang-xuat" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i> ${i18n_logout}
                </a>
            </div>
        </div>
    </div>
</header>