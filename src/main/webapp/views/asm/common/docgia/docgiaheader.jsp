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
    <header class="bg-light border-bottom py-3 mb-4 shadow-sm">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="h4 mb-0 text-primary">
                        <i class="fas fa-book-open me-2"></i>
                        Khoa News - Đọc giả
                        <c:if test="${not empty headerUserName}">
                            <span class="ms-2 text-dark">${headerUserName}</span>
                        </c:if>
                    </h1>
                    <p class="mb-0 small text-muted">Thưởng thức tin tức mới nhất mỗi ngày</p>
                </div>
                <div class="text-end">
                    <c:if test="${not empty headerUserId}">
                        <div class="small mb-2 text-muted">
                            <i class="fas fa-user me-1"></i>
                            ${headerUserId}
                            <span class="badge bg-primary-subtle text-primary ms-2">
                                Đọc giả
                            </span>
                        </div>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/dang-xuat" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </div>
    </header>