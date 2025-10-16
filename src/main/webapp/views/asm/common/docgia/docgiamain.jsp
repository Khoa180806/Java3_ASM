<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-4">
    <!-- Tiêu đề danh mục -->
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="border-bottom pb-2">${categoryName}</h2>
        </div>
    </div>

    <!-- Danh sách tin tức -->
    <div class="row">
        <c:forEach items="${newsList}" var="news">
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <c:if test="${not empty news.image}">
                        <a href="${pageContext.request.contextPath}/docgia?id=${news.id}"
                           class="text-decoration-none text-dark">
                            <img src="${pageContext.request.contextPath}/uploads/${news.image}"
                                 class="card-img-top"
                                 alt="${news.title}"
                                 style="height: 200px; object-fit: cover;">
                        </a>
                    </c:if>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/docgia?id=${news.id}"
                           class="text-decoration-none text-dark">
                            <h5 class="card-title">${news.title}</h5>
                        </a>
                        <p class="card-text text-muted small">
                            <i class="bi bi-calendar3"></i>
                            <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy" />
                            <span class="ms-2">
                                <i class="bi bi-eye"></i> ${news.viewCount} lượt xem
                            </span>
                        </p>
                        <p class="card-text">${news.content.length() > 100 ? news.content.substring(0, 100) : news.content}...</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>