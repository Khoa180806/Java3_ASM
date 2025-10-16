<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/22/2025
  Time: 2:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.5; margin: 24px; }
        h1 { margin: 0 0 8px; font-size: 24px; }
        h2 { margin: 0 0 12px; font-size: 18px; color: #444; }
        .card { max-width: 640px; padding: 16px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
    </style>
</head>
<body>
    <div class="card">
        <h1>${message}</h1>
        <jsp:include page="/views/Lab2/user-info.jsp"/>
    </div>
</body>
</html>
