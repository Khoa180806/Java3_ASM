<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/docgia">Trang chủ</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:forEach items="${categories}" var="category">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/docgia?categoryId=${category.id}">
                            ${category.name}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>