<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 3:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dangky</title>
    <style>
        body { margin: 0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial; background: #f6f7fb; color: #111; }
        h1 { text-align: center; margin-top: 24px; }
        form { max-width: 520px; margin: 16px auto 40px; padding: 16px; background: #fff; border: 1px solid #e5e7eb; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,.05); line-height: 1.8; }
        input[type="text"], input[type="password"], select, textarea { width: 100%; padding: 10px 12px; margin: 6px 0 10px; border: 1px solid #d1d5db; border-radius: 6px; outline: none; }
        textarea { resize: vertical; }
        input:focus, select:focus, textarea:focus { border-color: #60a5fa; box-shadow: 0 0 0 3px rgba(96,165,250,.25); }
        button { padding: 10px 14px; border-radius: 6px; border: 1px solid #10b981; background: #10b981; color: #fff; cursor: pointer; }
        button:hover { filter: brightness(1.05); }
        label { display: inline-block; margin-right: 8px; }
    </style>
</head>
<body>
    <h1>Đăng Ký</h1>
    <c:url value="/Dangky" var="dk"/>
    <form method="post" action="${dk}">
        Tên đăng nhập:
        <input type="text" name="username" value="nghiemn" style="width: 320px;">
        <br>
        Mật khẩu:
        <input type="password" name="password" value="12345" style="width: 320px;">
        <br>
        Giới tính:
        <input type="radio" name="gender" value="male" checked>Nam
        <input type="radio" name="gender" value="female">Nữ
        <br>
        Đã có gia đình?
        <input type="checkbox" name="married">
        <br>
        Quốc tịch:
        <select name="country">
            <option>Vietnam</option>
            <option selected>United States</option>
            <option>Japan</option>
            <option>France</option>
        </select>
        <br>
        Sở thích:
        <input type="checkbox" name="hobby" value="reading">Đọc sách
        <input type="checkbox" name="hobby" value="travel" checked>Du lịch
        <input type="checkbox" name="hobby" value="music" checked>Âm nhạc
        <input type="checkbox" name="hobby" value="other">Khác
        <br>
        <textarea name="note" rows="6" cols="60">Đang tìm bạn gái</textarea>
        <br>
        Ghi chú:
        <br>
        <button type="submit">Đăng ký</button>
    </form>
</body>
</html>
