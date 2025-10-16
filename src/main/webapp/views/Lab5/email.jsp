<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 10/8/2025
  Time: 3:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Email</title>
</head>
<body>
    <form action="/email" method="post">
        From: <input name="from" value="your.email@gmail.com"/><br/>
        To: <input name="to"/><br/>
        Subject: <input name="subject"/><br/>
        Body: <textarea name="body"></textarea><br/>
        <button>Send</button>
    </form>
</body>
</html>
