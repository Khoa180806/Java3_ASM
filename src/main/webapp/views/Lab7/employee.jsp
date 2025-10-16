<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Employee Management</title>
    <style>
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
    <h1>QUẢN LÝ NHÂN VIÊN</h1>
    
    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div style="color: green; margin: 10px 0; padding: 10px; background: #e8f5e9; border: 1px solid #a5d6a7;">
            ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="color: #d32f2f; margin: 10px 0; padding: 10px; background: #ffebee; border: 1px solid #ef9a9a;">
            ${error}
        </div>
    </c:if>
    
    <!-- Form thêm/cập nhật nhân viên -->
    <form action="${pageContext.request.contextPath}/employee/${empty form.id ? 'create' : 'update'}" method="post">
        <div class="form-group">
            <label for="id">Mã nhân viên:</label>
            <input type="text" id="id" name="id" value="${form.id}" ${not empty form.id ? 'readonly' : ''}>
        </div>
        
        <div class="form-group">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" value="${form.password}">
        </div>
        
        <div class="form-group">
            <label for="fullname">Họ và tên:</label>
            <input type="text" id="fullname" name="fullname" value="${form.fullname}">
        </div>
        
        <div class="form-group">
            <label for="photo">Hình ảnh:</label>
            <input type="text" id="photo" name="photo" value="${form.photo}">
        </div>
        
        <div class="form-group">
            <label>Giới tính:</label>
            <input type="radio" id="male" name="gender" value="true" ${form.gender ? 'checked' : ''}>
            <label for="male">Nam</label>
            <input type="radio" id="female" name="gender" value="false" ${not form.gender ? 'checked' : ''}>
            <label for="female">Nữ</label>
        </div>
        
        <div class="form-group">
            <label for="birthday">Ngày sinh:</label>
            <input type="date" id="birthday" name="birthday" value="${form.birthday}">
        </div>
        
        <div class="form-group">
            <label for="salary">Lương:</label>
            <input type="number" id="salary" name="salary" step="0.01" value="${form.salary}">
        </div>
        
        <div class="form-group">
            <label for="departmentId">Phòng ban:</label>
            <select id="departmentId" name="departmentId">
                <c:forEach items="${departments}" var="dept">
                    <option value="${dept.id}" ${form.departmentId eq dept.id ? 'selected' : ''}>
                        ${dept.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn">${empty form.id ? 'Thêm mới' : 'Cập nhật'}</button>
            <a href="${pageContext.request.contextPath}/employee/reset" class="btn">Làm mới</a>
        </div>
    </form>
    
    <!-- Bảng hiển thị danh sách nhân viên -->
    <table>
        <thead>
            <tr>
                <th>Mã NV</th>
                <th>Họ và tên</th>
                <th>Giới tính</th>
                <th>Ngày sinh</th>
                <th>Lương</th>
                <th>Phòng ban</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${items}" var="emp">
                <tr>
                    <td>${emp.id}</td>
                    <td>${emp.fullname}</td>
                    <td>${emp.gender ? 'Nam' : 'Nữ'}</td>
                    <td>${emp.birthday}</td>
                    <td><fmt:formatNumber value="${emp.salary}" type="currency" currencyCode="VND"/></td>
                    <td>${emp.departmentId}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/employee/edit/${emp.id}">Sửa</a>
                        <a href="${pageContext.request.contextPath}/employee/delete/${emp.id}"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
