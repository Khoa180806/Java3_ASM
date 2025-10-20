<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khoa News</title>
    <style>
        .header {
            background-color: #f8f9fa;
            padding: 15px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
            color: #333;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <c:set var="headerUser" value="${not empty sessionScope.currentUser ? sessionScope.currentUser : sessionScope.user}" />
    <c:set var="headerUserName" value="${not empty headerUser.fullname ? headerUser.fullname : headerUser}" />
    <c:set var="headerUserId" value="${not empty headerUser.id ? headerUser.id : headerUser}" />
    <header class="bg-light border-bottom py-3 shadow-sm">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h4 mb-0 text-primary">
                        <i class="fas fa-book-open me-2"></i>
                        ${i18n_appName} - ${i18n_roleReader}
                        <c:if test="${not empty headerUserName}">
                            <span class="ms-2 text-dark">${headerUserName}</span>
                        </c:if>
                    </h1>
                    <p class="mb-0 small text-muted">${i18n_appSlogan}</p>
                </div>
                <div class="text-end">
                    <c:if test="${not empty headerUserId}">
                        <div class="small mb-2 text-muted">
                            <i class="fas fa-user me-1"></i>
                            ${headerUserId}
                            <span class="badge bg-primary-subtle text-primary ms-2">
                                ${i18n_roleReader}
                            </span>
                        </div>
                    </c:if>
                    <!-- Language Switcher -->
                    <div class="d-inline-block me-2">
                        <%@ include file="../language-switcher.jsp" %>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/dang-xuat" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i> ${i18n_logout}
                    </a>
                </div>
            </div>
        </div>
    </header>