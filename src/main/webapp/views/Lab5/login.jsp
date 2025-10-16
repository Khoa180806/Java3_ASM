<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 10/8/2025
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <form action="/login" method="post">
        <input name="username" value="${username}"> <br>
        <input name="password" value="${password}">  <br>
        <input type="checkbox" name="remember-me"> Remember me?
        <hr>
        <button>Login</button>
    </form>
</body>
</html>
