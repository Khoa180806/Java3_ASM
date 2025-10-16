<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 3:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upload</title>
    <style>
        body { margin: 0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial; background: #f6f7fb; color: #111; }
        form { max-width: 420px; margin: 40px auto; padding: 16px; background: #fff; border: 1px solid #e5e7eb; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,.05); }
        input[type="file"] { width: 100%; padding: 10px 12px; margin: 6px 0 10px; border: 1px dashed #9ca3af; border-radius: 6px; background: #f9fafb; }
        button { padding: 10px 14px; border-radius: 6px; border: 1px solid #10b981; background: #10b981; color: #fff; cursor: pointer; }
        button:hover { filter: brightness(1.05); }
        .msg { max-width: 420px; margin: 8px auto; color: #065f46; }
        img { border: 1px solid #e5e7eb; border-radius: 6px; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <c:url value="/Upload" var="url"/>
    <form action="${url}" method="post" enctype="multipart/form-data">
        <input name="photo" type="file"><br>
        <button>Upload</button>
    </form>
    <div class="msg">${message}</div>
    <c:if test="${not empty fileUrl}">
        <p>File đã lưu: <a href="${fileUrl}">${fileUrl}</a></p>
        <p><img src="${fileUrl}" alt="uploaded" style="max-width: 300px;"></p>
    </c:if>
</body>
</html>
