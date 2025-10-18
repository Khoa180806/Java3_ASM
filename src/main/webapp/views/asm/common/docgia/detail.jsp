<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Tiêu đề bài viết -->
            <h1 class="mb-3">${news.title}</h1>
            
            <!-- Thông tin bài viết -->
            <div class="d-flex align-items-center mb-4 text-muted">
                <div class="me-3">
                    <i class="far fa-user me-1"></i> ${not empty news.author ? news.author : 'Admin'}
                </div>
                <div class="me-3">
                    <i class="far fa-calendar-alt me-1"></i> 
                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" />
                </div>
                <div>
                    <i class="far fa-eye me-1"></i> ${news.viewCount} lượt xem
                </div>
            </div>
            
            <!-- Hình ảnh đại diện -->
            <c:if test="${not empty news.image}">
                <div class="mb-4">
                    <c:choose>
                        <c:when test="${news.image.startsWith('http://') || news.image.startsWith('https://')}">
                            <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}" class="img-fluid rounded">
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
            
            <!-- Nội dung bài viết -->
            <div class="news-content mb-5">
                ${news.content}
            </div>
            
            <!-- Tin cùng chuyên mục -->
            <div class="related-news mb-5">
                <h4 class="border-bottom pb-2 mb-3">Tin cùng chuyên mục</h4>
                <div class="row">
                    <c:forEach items="${relatedNews}" var="related" end="2">
                        <div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <c:if test="${not empty related.image}">
                                    <c:choose>
                                        <c:when test="${related.image.startsWith('http://') || related.image.startsWith('https://')}">
                                            <img src="${related.image}" 
                                                 class="card-img-top" alt="${related.title}" 
                                                 style="height: 150px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${related.image}" 
                                                 class="card-img-top" alt="${related.title}" 
                                                 style="height: 150px; object-fit: cover;">
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/docgia/detail?id=${related.id}" 
                                           class="text-decoration-none">
                                            ${related.title}
                                        </a>
                                    </h5>
                                    <p class="card-text small text-muted">
                                        <fmt:formatDate value="${related.postedDate}" pattern="dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CSS tùy chỉnh -->
<style>
.news-content {
    line-height: 1.8;
    font-size: 1.1rem;
}
.news-content img {
    max-width: 100%;
    height: auto;
    margin: 1.5rem 0;
    border-radius: 0.5rem;
}
.related-news .card {
    transition: transform 0.2s;
}
.related-news .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
}
</style>