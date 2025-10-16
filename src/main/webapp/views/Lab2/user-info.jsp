<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/22/2025
  Time: 2:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User-info</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.5; margin: 16px 24px; }
        b { display: inline-block; margin-bottom: 8px; }
        ul { margin: 0; padding-left: 18px; }
        li { margin: 4px 0; }
    </style>
</head>
<body>
    <b>YOUR INFORMATION:</b>
    <ul>
        <li>Fullname: ${user.fullname}</li>
        <li>Gender: ${user.gender}</li>
        <li>Country: ${user.country}</li>
    </ul>
</body>
</html>
