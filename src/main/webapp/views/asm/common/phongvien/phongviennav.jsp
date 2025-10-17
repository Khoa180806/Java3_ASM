<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#phongvienNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="phongvienNavbar">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'home' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/docgia">
                        <i class="fas fa-home me-1"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'news' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/phongvien">
                        <i class="fas fa-newspaper me-1"></i> Quản lý tin tức
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>