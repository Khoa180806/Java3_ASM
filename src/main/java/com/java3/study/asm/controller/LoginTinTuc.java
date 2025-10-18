package com.java3.study.asm.controller;

import com.java3.study.asm.dao.UserDao;
import com.java3.study.asm.dao.impl.UserDaoImpl;
import com.java3.study.asm.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logintintuc")
public class LoginTinTuc extends HttpServlet {
    
    private UserDao userDao;
    
    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Hiển thị trang đăng nhập
        request.getRequestDispatcher("/views/asm/logintintuc.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        // Validation cơ bản
        if (userId == null || userId.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin đăng nhập!");
            request.getRequestDispatcher("/views/asm/logintintuc.jsp").forward(request, response);
            return;
        }
        
        try {
            // Xác thực người dùng
            User user = userDao.authenticate(userId.trim(), password);
            
            if (user != null) {
                // Đăng nhập thành công - Lưu thông tin vào session
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("fullname", user.getFullname());
                session.setAttribute("role", user.getRole());
                session.setAttribute("roleName", user.getRole() ? "Quản trị viên" : "Phóng viên");
                
                // Phân quyền theo vai trò
                if (user.getRole()) {
                    // Admin (role = true) → chuyển đến trang quản lý
                    response.sendRedirect(request.getContextPath() + "/quanli/news");
                } else {
                    // Phóng viên (role = false) → chuyển đến trang phóng viên
                    response.sendRedirect(request.getContextPath() + "/phongvien");
                }
                
            } else {
                // Đăng nhập thất bại
                request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.setAttribute("userId", userId); // Giữ lại userId đã nhập
                request.getRequestDispatcher("/views/asm/logintintuc.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đăng nhập!");
            request.setAttribute("userId", userId);
            request.getRequestDispatcher("/views/asm/logintintuc.jsp").forward(request, response);
        }
    }
}
