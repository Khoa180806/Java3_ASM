<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 10/13/2025
  Time: 3:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Department Management</title><style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: inline-block;
            width: 120px;
        }
        input[type="text"], input[type="password"], input[type="date"], 
        input[type="number"], select, textarea {
            width: 300px;
            padding: 5px;
        }
        .btn {
            padding: 5px 15px;
            margin-right: 5px;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
<c:url var="path" value="/department" />
<!-- FORM -->
<form method="post">
    <label>Id:</label><br>
    <input name="id" value="${item.id}"><br>
    <label>Name:</label><br>
    <input name="name" value="${item.name}"><br>
    <label>Description:</label><br>
    <textarea name="description" rows="3">${item.description}</textarea>
    <hr>
    <button formaction="${path}/create">Create</button>
    <button formaction="${path}/update">Update</button>
    <button formaction="${path}/delete">Delete</button>
    <button formaction="${path}/reset">Reset</button>
</form>
<hr>
<!-- TABLE -->
<table border="1" style="width: 100%">
    <thead>
    <tr>
        <th>No.</th>
        <th>Id</th>
        <th>Name</th>
        <th>Description</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="d" items="${list}" varStatus="vs">
        <tr>
            <td>${vs.count}</td>
            <td>${d.id}</td>
            <td>${d.name}</td>
            <td>${d.description}</td>
            <td><a href="${path}/edit/${d.id}">Edit</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
