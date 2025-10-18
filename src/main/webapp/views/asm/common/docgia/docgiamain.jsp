<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-4">
    <!-- Thông báo đăng ký subscription -->
    <c:if test="${not empty sessionScope.subscriptionStatus}">
        <div class="row mb-3">
            <div class="col-12">
                <div class="alert alert-${sessionScope.subscriptionStatus == 'success' ? 'success' : sessionScope.subscriptionStatus == 'error' ? 'danger' : 'info'} alert-dismissible fade show" role="alert">
                    <c:choose>
                        <c:when test="${sessionScope.subscriptionStatus == 'success'}">
                            <i class="bi bi-check-circle-fill me-2"></i>
                        </c:when>
                        <c:when test="${sessionScope.subscriptionStatus == 'error'}">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-info-circle-fill me-2"></i>
                        </c:otherwise>
                    </c:choose>
                    <strong>${sessionScope.subscriptionMessage}</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <%-- Xóa message sau khi hiển thị --%>
        <c:remove var="subscriptionStatus" scope="session"/>
        <c:remove var="subscriptionMessage" scope="session"/>
    </c:if>

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
                        <a href="${pageContext.request.contextPath}/docgia/detail?id=${news.id}"
                           class="text-decoration-none text-dark">
                            <c:choose>
                                <c:when test="${news.image.startsWith('http://') || news.image.startsWith('https://')}">
                                    <img src="${news.image}"
                                         class="card-img-top"
                                         alt="${news.title}"
                                         style="height: 200px; object-fit: cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.jpg'; this.onerror=null;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${news.image}"
                                         class="card-img-top"
                                         alt="${news.title}"
                                         style="height: 200px; object-fit: cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.jpg'; this.onerror=null;">
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/docgia/detail?id=${news.id}"
                           class="text-decoration-none text-dark">
                            <h5 class="card-title">${news.title}</h5>
                        </a>
                        <p class="card-text text-muted small">
                            <i class="bi bi-calendar3"></i>
                            <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy" />
                            <span class="ms-2">
                                <i class="bi bi-eye"></i> ${news.viewCount} ${i18n_newsViewCount}
                            </span>
                        </p>
                        <p class="card-text">${news.content.length() > 100 ? news.content.substring(0, 100) : news.content}...</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>