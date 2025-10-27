<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khách hàng</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        
        .alert {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 4px;
            border-left: 4px solid;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left-color: #28a745;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border-left-color: #dc3545;
        }
        
        .form-section {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 4px;
            background-color: #fafafa;
        }
        
        .form-group {
            display: grid;
            grid-template-columns: 120px 1fr;
            gap: 10px;
            margin-bottom: 10px;
            align-items: center;
        }
        
        label {
            font-weight: bold;
            color: #333;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 14px;
            width: 100%;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        
        .gender-group {
            display: flex;
            gap: 20px;
        }
        
        .gender-group label {
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: normal;
        }
        
        input[type="radio"] {
            cursor: pointer;
        }
        
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 15px;
        }
        
        button {
            padding: 8px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .btn-create {
            background-color: #28a745;
            color: white;
        }
        
        .btn-create:hover {
            background-color: #218838;
        }
        
        .btn-update {
            background-color: #007bff;
            color: white;
        }
        
        .btn-update:hover {
            background-color: #0056b3;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-delete:hover {
            background-color: #c82333;
        }
        
        .btn-reset {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-reset:hover {
            background-color: #5a6268;
        }
        
        .btn-edit {
            background-color: #ffc107;
            color: black;
            padding: 5px 10px;
            font-size: 12px;
        }
        
        .btn-edit:hover {
            background-color: #e0a800;
        }
        
        .table-section {
            margin-top: 30px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        
        th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
            border: 1px solid #0056b3;
        }
        
        td {
            padding: 10px 12px;
            border: 1px solid #ddd;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        tr:hover {
            background-color: #f0f0f0;
        }
        
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quản lý Khách hàng</h1>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <!-- Form Section -->
        <div class="form-section">
            <form method="POST" action="/khachhang">
                <input type="hidden" name="action" value="${not empty customer ? 'update' : 'create'}">
                
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" 
                           value="${not empty customer ? customer.username : ''}" 
                           ${not empty customer ? 'readonly' : ''} required>
                </div>
                
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="pass" 
                           value="${not empty customer ? customer.pass : ''}" required>
                </div>
                
                <div class="form-group">
                    <label>Họ và tên:</label>
                    <input type="text" name="hoten" 
                           value="${not empty customer ? customer.hoten : ''}" required>
                </div>
                
                <div class="form-group">
                    <label>Giới tính:</label>
                    <div class="gender-group">
                        <label>
                            <input type="radio" name="gioitinh" value="off" 
                                   ${not empty customer && !customer.gioitinh ? 'checked' : 'checked'}> Nam
                        </label>
                        <label>
                            <input type="radio" name="gioitinh" value="on" 
                                   ${not empty customer && customer.gioitinh ? 'checked' : ''}> Nữ
                        </label>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" 
                           value="${not empty customer ? customer.email : ''}" required>
                </div>
                
                <div class="button-group">
                    <c:choose>
                        <c:when test="${not empty customer}">
                            <button type="submit" class="btn-update">Update</button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn-create">Create</button>
                        </c:otherwise>
                    </c:choose>
                    <button type="reset" class="btn-reset">Reset</button>
                </div>
            </form>
        </div>
        
        <!-- Table Section -->
        <div class="table-section">
            <h2>Danh sách khách hàng</h2>
            <c:choose>
                <c:when test="${not empty customers}">
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Họ và tên</th>
                                <th>Giới tính</th>
                                <th>Email</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="kh" items="${customers}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${kh.username}</td>
                                    <td>${kh.pass}</td>
                                    <td>${kh.hoten}</td>
                                    <td>${kh.gioitinh ? 'Nữ' : 'Nam'}</td>
                                    <td>${kh.email}</td>
                                    <td>
                                        <a href="/khachhang?action=edit&username=${kh.username}" class="btn-edit">Edit</a>
                                        <a href="/khachhang?action=delete&username=${kh.username}" class="btn-delete" 
                                           onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?');" style="text-decoration: none; color: white; padding: 5px 10px; display: inline-block; border-radius: 3px;">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">Không có dữ liệu khách hàng</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>