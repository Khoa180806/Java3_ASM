<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 10/15/2025
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
    <c:when test="${not empty param.lang}">
        <fmt:setLocale value="${param.lang}" scope="session"/>
    </c:when>
    <c:when test="${empty sessionScope.lang}">
        <fmt:setLocale value="vi" scope="session"/>
    </c:when>
</c:choose>
<fmt:setBundle basename="language/global" var="globalBundle"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <header>
        <h1>FPT POLYTECHNIC</h1>
    </header>
    <nav>
        <hr>
        <a href="${pageContext.request.contextPath}/home/index"><fmt:message key="menu.home" bundle="${globalBundle}"/></a> |
        <a href="${pageContext.request.contextPath}/home/about"><fmt:message key="menu.about" bundle="${globalBundle}"/></a> |
        <a href="${pageContext.request.contextPath}/home/contact"><fmt:message key="menu.contact" bundle="${globalBundle}"/></a> ||
        <a href="?lang=vi">Tiếng Việt</a>
        <a href="?lang=en">English</a>
        <hr>
    </nav>
    <main>
        <jsp:include page="${view}" />
    </main>
    <footer>
        <hr> &copy; 2024 by FPT Polytechnic. All rights resersed.
    </footer>
</body>
</html>
