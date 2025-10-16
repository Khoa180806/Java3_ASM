<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 2:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Calculate</title>
    <style>
        body { margin: 0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial; background: #f6f7fb; color: #111; }
        form { max-width: 360px; margin: 40px auto; padding: 16px; background: #fff; border: 1px solid #e5e7eb; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,.05); }
        input { width: 100%; padding: 10px 12px; margin: 6px 0 10px; border: 1px solid #d1d5db; border-radius: 6px; outline: none; }
        input:focus { border-color: #60a5fa; box-shadow: 0 0 0 3px rgba(96,165,250,.25); }
        button { display: inline-block; padding: 8px 12px; margin-right: 6px; border-radius: 6px; border: 1px solid #3b82f6; background: #3b82f6; color: #fff; cursor: pointer; }
        button:last-child { margin-right: 0; }
        button:hover { filter: brightness(1.05); }
        .msg { max-width: 360px; margin: 8px auto; color: #065f46; }
    </style>
</head>
<body>
    <form method="post">
        <input name="a"><br>
        <input name="b"><br>
        <button formaction="/Calculate/add">+</button>
        <button formaction="/Calculate/sub">-</button>
    </form>
    <div class="msg">${message}</div>
</body>
</html>
