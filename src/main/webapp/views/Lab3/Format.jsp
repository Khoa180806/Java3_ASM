<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<html>
<head>
    <title>Format</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        ul { list-style: none; padding: 0; max-width: 700px; }
        li { padding: 6px 0; border-bottom: 1px solid #eee; }
        li:last-child { border-bottom: none; }
        .label { color: #555; }
    </style>
</head>
<body>
    <ul>
        <li><span class="label">Name:</span> ${item.name}</li>
        <li><span class="label">Price:</span>
            <fmt:formatNumber value="${item.price}" pattern="#,###.00"/>
        </li>
        <li><span class="label">Date:</span>
            <fmt:formatDate value="${item.date}" pattern="MMM dd, yyyy"/>
        </li>
    </ul>
</body>
</html>
