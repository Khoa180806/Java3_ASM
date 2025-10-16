<%-- In docgiasidebar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Most Viewed News -->
<div class="card mb-4">
    <div class="card-header bg-primary text-white">
        <h5 class="mb-0">Bài viết xem nhiều nhất</h5>
    </div>
    <div class="list-group list-group-flush">
        <c:forEach items="${mostViewedNews}" var="news">
            <a href="<c:url value='/docgia/news/detail?id=${news.id}'/>" 
               class="list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">${news.title}</h6>
                    <small>${news.viewCount} lượt xem</small>
                </div>
                <small class="text-muted">${news.postedDate}</small>
            </a>
        </c:forEach>
    </div>
</div>

<!-- Latest News -->
<div class="card mb-4">
    <div class="card-header bg-success text-white">
        <h5 class="mb-0">Bài viết mới nhất</h5>
    </div>
    <div class="list-group list-group-flush">
        <c:forEach items="${latestNews}" var="news">
            <a href="<c:url value='/docgia/news/detail?id=${news.id}'/>" 
               class="list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">${news.title}</h6>
                    <small class="text-muted">${news.postedDate}</small>
                </div>
                <small>${news.viewCount} lượt xem</small>
            </a>
        </c:forEach>
    </div>
</div>

<!-- Recently Viewed -->
<c:if test="${not empty recentlyViewed}">
    <div class="card">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">Đã xem gần đây</h5>
        </div>
        <div class="list-group list-group-flush">
            <c:forEach items="${recentlyViewed}" var="news">
                <a href="<c:url value='/docgia/news/detail?id=${news.id}'/>" 
                   class="list-group-item list-group-item-action">
                    <div class="d-flex w-100 justify-content-between">
                        <h6 class="mb-1">${news.title}</h6>
                        <small class="text-muted">${news.postedDate}</small>
                    </div>
                    <small>${news.viewCount} lượt xem</small>
                </a>
            </c:forEach>
        </div>
    </div>
</c:if>