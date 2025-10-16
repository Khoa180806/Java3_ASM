<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 2:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Country</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        select { padding: 6px; margin-bottom: 12px; }
        table { border-collapse: collapse; width: 100%; max-width: 700px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        thead { background: #f5f5f5; }
        tbody tr:nth-child(even) { background: #fafafa; }
    </style>
</head>
<body>
    <select name="country">
        <c:forEach var="ct" items="${countries}">
        <option value="${ct.id}">${ct.name}</option>
        </c:forEach>
    </select>
    <table>
        <thead>
        <tr>
            <th>No.</th>
            <th>Id</th>
            <th>Name</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="ct" items="${countries}" varStatus="vs">
                <tr>
                    <td>${vs.count}</td>
                    <td>${ct.id}</td>
                    <td>${ct.name}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
