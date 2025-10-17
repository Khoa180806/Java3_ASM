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
                    <a class="nav-link ${param.active == 'category' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/quanli/category">
                        <i class="fas fa-tags me-1"></i> Quản lý loại tin tức
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'news' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/quanli/news">
                        <i class="fas fa-newspaper me-1"></i> Quản lý tin tức
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'newsletter' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/quanli/newsletter">
                        <i class="fas fa-envelope-open-text me-1"></i> Quản lý newsletter
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.active == 'user' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/quanli/user">
                        <i class="fas fa-users me-1"></i> Quản lý người dùng
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>