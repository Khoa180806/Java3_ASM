<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 2:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Title</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        ul { list-style: none; padding: 0; max-width: 700px; }
        li { padding: 6px 0; border-bottom: 1px solid #eee; }
        li:last-child { border-bottom: none; }
        .label { color: #555; }
        .content { white-space: pre-wrap; }
    </style>
</head>
<body>
    <ul>
        <li><span class="label">Title:</span> ${fn:toUpperCase(item.title)}</li>
        <li><span class="label">Content:</span>
            <c:choose>
                <c:when test="${fn:length(item.content) > 100}">
                    <span class="content">${fn:substring(item.content, 0, 100)}...</span>
                </c:when>
                <c:otherwise><span class="content">${item.content}</span></c:otherwise>
            </c:choose>
        </li>
    </ul>
</body>
</html>
