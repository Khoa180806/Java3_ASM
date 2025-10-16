<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 10/15/2025
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setBundle basename="language/home" var="bundle"/>
<html>
<head>
    <title>Index</title>
</head>
<body>
    <h1><fmt:message key="index.title" bundle="${bundle}"/></h1>
</body>
</html>