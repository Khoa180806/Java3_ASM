package com.java3.study.bv.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java3.study.bv.dao.KhachhangDAO;
import com.java3.study.bv.dao.impl.KhachhangDAOImpl;
import com.java3.study.bv.entity.Khachhang;

@WebServlet("/khachhang")
public class KhachhangServlet extends HttpServlet {
    private KhachhangDAO khachhangDAO = new KhachhangDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "edit":
                handleEdit(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                handleList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "create";
        }
        
        switch (action) {
            case "create":
                handleCreate(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                handleList(request, response);
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve all customers from database
        List<Khachhang> customers = khachhangDAO.findAll();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/views/bv/khachhang.jsp").forward(request, response);
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract form parameters
            String username = request.getParameter("username");
            String pass = request.getParameter("pass");
            String hoten = request.getParameter("hoten");
            boolean gioitinh = "on".equals(request.getParameter("gioitinh"));
            String email = request.getParameter("email");
            
            // Validate required fields
            if (username == null || username.trim().isEmpty() ||
                pass == null || pass.trim().isEmpty() ||
                hoten == null || hoten.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                handleList(request, response);
                return;
            }
            
            // Check if username already exists
            if (khachhangDAO.findByUsername(username) != null) {
                request.setAttribute("error", "Username đã tồn tại!");
                handleList(request, response);
                return;
            }
            
            // Create new customer
            Khachhang kh = new Khachhang(username, pass, hoten, gioitinh, email);
            khachhangDAO.insert(kh);
            request.setAttribute("success", "Tạo khách hàng thành công!");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        handleList(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve customer by username for editing
        String username = request.getParameter("username");
        Khachhang kh = khachhangDAO.findByUsername(username);
        
        if (kh != null) {
            request.setAttribute("customer", kh);
        } else {
            request.setAttribute("error", "Khách hàng không tồn tại!");
        }
        
        List<Khachhang> customers = khachhangDAO.findAll();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/views/bv/khachhang.jsp").forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract form parameters
            String username = request.getParameter("username");
            String pass = request.getParameter("pass");
            String hoten = request.getParameter("hoten");
            boolean gioitinh = "on".equals(request.getParameter("gioitinh"));
            String email = request.getParameter("email");
            
            // Validate required fields
            if (username == null || username.trim().isEmpty() ||
                pass == null || pass.trim().isEmpty() ||
                hoten == null || hoten.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                handleList(request, response);
                return;
            }
            
            // Update customer
            Khachhang kh = new Khachhang(username, pass, hoten, gioitinh, email);
            khachhangDAO.update(kh);
            request.setAttribute("success", "Cập nhật khách hàng thành công!");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        handleList(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Delete customer by username
            String username = request.getParameter("username");
            
            if (username == null || username.trim().isEmpty()) {
                request.setAttribute("error", "Username không hợp lệ!");
            } else {
                khachhangDAO.delete(username);
                request.setAttribute("success", "Xóa khách hàng thành công!");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        handleList(request, response);
    }
}
