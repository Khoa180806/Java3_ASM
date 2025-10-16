<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/22/2025
  Time: 2:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.5; margin: 24px; }
        form { max-width: 520px; padding: 16px; border: 1px solid #ddd; border-radius: 8px; background: #fff; }
        div { margin: 8px 0 4px; font-weight: 600; }
        input[type="text"], input[type="email"], input[type="password"], select { width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; }
        input[readonly] { background: #f7f7f7; color: #555; }
        input[type="radio"] { margin-right: 6px; }
        button { padding: 8px 14px; border: 1px solid #ccc; border-radius: 6px; background: #f5f5f5; cursor: pointer; margin-right: 8px; }
        button:hover:not([disabled]) { background: #eee; }
        button[disabled] { opacity: 0.6; cursor: not-allowed; }
        hr { border: none; border-top: 1px solid #eee; margin: 16px 0; }
    </style>
</head>
<body>
    <form action="/form/update">
        <div>Fullname:</div>
        <input name="fullname" value="${user.fullname}"
        ${editable ? "readonly" : ""}><br>

        <div>Gender:</div>
        <input type="radio" name="gender" value="true"
        ${user.gender ? "checked" : ""}> Male<br>
        <input type="radio" name="gender" value="false"
        ${!user.gender ? "checked" : ""}> Female<br>

        <div>Country:</div>
        <select name="country">
            <option value="VN" ${user.country == 'VN' ? "selected" : ""}>Việt Nam</option>
            <option value="US" ${user.country == 'US' ? "selected" : ""}>United States</option>
            <option value="CN" ${user.country == 'CN' ? "selected" : ""}>China</option>
        </select>

        <hr>
        <button ${editable ? "disabled" : ""}>Create</button>
        <button>Update</button>
    </form>
</body>
</html>
