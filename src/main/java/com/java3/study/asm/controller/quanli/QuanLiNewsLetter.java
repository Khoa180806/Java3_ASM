package com.java3.study.asm.controller.quanli;

import com.java3.study.asm.dao.NewsletterDao;
import com.java3.study.asm.dao.impl.NewsletterDaoImpl;
import com.java3.study.asm.entity.Newsletter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet quản lý Newsletter - Admin Panel
 * URL Pattern: /quanli/newsletter/*
 * 
 * Chức năng:
 * - Xem danh sách email đăng ký newsletter
 * - Quản lý trạng thái (enabled/disabled)
 * - Xóa email khỏi danh sách
 * - Xem chi tiết thông tin đăng ký
 */
@WebServlet("/quanli/newsletter/*")
public class QuanLiNewsLetter extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private NewsletterDao newsletterDao;
    
    @Override
    public void init() throws ServletException {
        super.init();
        newsletterDao = new NewsletterDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";
        
        // Set context path cho shared components
        request.setAttribute("contextPath", "quanli/newsletter");
        
        try {
            switch (action) {
                case "":
                case "list":
                    handleList(request, response);
                    break;
                case "view":
                    handleView(request, response);
                    break;
                case "disable":
                    handleDisable(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    // Redirect về danh sách nếu action không hợp lệ
                    response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            handleList(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";
        
        // Set context path cho shared components
        request.setAttribute("contextPath", "quanli/newsletter");
        
        try {
            switch (action) {
                case "disable":
                    handleDisablePost(request, response);
                    break;
                case "delete":
                    handleDeletePost(request, response);
                    break;
                case "bulk-action":
                    handleBulkAction(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            handleList(request, response);
        }
    }
    
    /**
     * Hiển thị danh sách tất cả email đăng ký newsletter
     */
    private void handleList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Newsletter> newsletters = newsletterDao.getAll();
        
        // Thống kê
        long totalEmails = newsletters.size();
        long activeEmails = newsletters.stream().mapToLong(n -> n.getEnabled() ? 1 : 0).sum();
        long inactiveEmails = totalEmails - activeEmails;
        
        request.setAttribute("newsletters", newsletters);
        request.setAttribute("totalEmails", totalEmails);
        request.setAttribute("activeEmails", activeEmails);
        request.setAttribute("inactiveEmails", inactiveEmails);
        request.setAttribute("action", "list");
        request.setAttribute("pageTitle", "Quản lý Newsletter");
        
        // Set active navigation
        request.setAttribute("activeNav", "newsletter");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutnewsletter.jsp")
               .forward(request, response);
    }
    
    /**
     * Xem chi tiết thông tin một email
     */
    private void handleView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            handleList(request, response);
            return;
        }
        
        Newsletter newsletter = newsletterDao.getByEmail(email.trim());
        
        if (newsletter == null) {
            request.setAttribute("error", "Không tìm thấy email: " + email);
            handleList(request, response);
            return;
        }
        
        request.setAttribute("newsletter", newsletter);
        request.setAttribute("action", "view");
        request.setAttribute("pageTitle", "Chi tiết Newsletter - " + email);
        
        // Set active navigation
        request.setAttribute("activeNav", "newsletter");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutnewsletter.jsp")
               .forward(request, response);
    }
    
    /**
     * Hiển thị form xác nhận vô hiệu hóa email
     */
    private void handleDisable(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            handleList(request, response);
            return;
        }
        
        Newsletter newsletter = newsletterDao.getByEmail(email.trim());
        
        if (newsletter == null) {
            request.setAttribute("error", "Không tìm thấy email: " + email);
            handleList(request, response);
            return;
        }
        
        if (!newsletter.getEnabled()) {
            request.setAttribute("warning", "Email này đã bị vô hiệu hóa rồi");
            handleList(request, response);
            return;
        }
        
        request.setAttribute("newsletter", newsletter);
        request.setAttribute("action", "disable");
        request.setAttribute("pageTitle", "Vô hiệu hóa Newsletter - " + email);
        
        // Set active navigation
        request.setAttribute("activeNav", "newsletter");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutnewsletter.jsp")
               .forward(request, response);
    }
    
    /**
     * Xử lý vô hiệu hóa email (POST)
     */
    private void handleDisablePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            handleList(request, response);
            return;
        }
        
        Newsletter newsletter = newsletterDao.getByEmail(email.trim());
        
        if (newsletter == null) {
            request.setAttribute("error", "Không tìm thấy email: " + email);
            handleList(request, response);
            return;
        }
        
        if (!newsletter.getEnabled()) {
            request.setAttribute("warning", "Email này đã bị vô hiệu hóa rồi");
        } else {
            newsletterDao.update(email.trim());
            request.setAttribute("success", "Đã vô hiệu hóa email: " + email);
        }
        
        response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
    }
    
    /**
     * Hiển thị form xác nhận xóa email
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            handleList(request, response);
            return;
        }
        
        Newsletter newsletter = newsletterDao.getByEmail(email.trim());
        
        if (newsletter == null) {
            request.setAttribute("error", "Không tìm thấy email: " + email);
            handleList(request, response);
            return;
        }
        
        request.setAttribute("newsletter", newsletter);
        request.setAttribute("action", "delete");
        request.setAttribute("pageTitle", "Xóa Newsletter - " + email);
        
        // Set active navigation
        request.setAttribute("activeNav", "newsletter");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutnewsletter.jsp")
               .forward(request, response);
    }
    
    /**
     * Xử lý xóa email (POST)
     */
    private void handleDeletePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            handleList(request, response);
            return;
        }
        
        Newsletter newsletter = newsletterDao.getByEmail(email.trim());
        
        if (newsletter == null) {
            request.setAttribute("error", "Không tìm thấy email: " + email);
        } else {
            newsletterDao.delete(newsletter);
            request.setAttribute("success", "Đã xóa email: " + email);
        }
        
        response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
    }
    
    /**
     * Xử lý các thao tác hàng loạt
     */
    private void handleBulkAction(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String[] selectedEmails = request.getParameterValues("selectedEmails");
        
        if (selectedEmails == null || selectedEmails.length == 0) {
            request.setAttribute("warning", "Vui lòng chọn ít nhất một email");
            response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
            return;
        }
        
        int successCount = 0;
        int errorCount = 0;
        
        for (String email : selectedEmails) {
            try {
                Newsletter newsletter = newsletterDao.getByEmail(email);
                if (newsletter != null) {
                    switch (action) {
                        case "disable":
                            if (newsletter.getEnabled()) {
                                newsletterDao.update(email);
                                successCount++;
                            }
                            break;
                        case "delete":
                            newsletterDao.delete(newsletter);
                            successCount++;
                            break;
                    }
                } else {
                    errorCount++;
                }
            } catch (Exception e) {
                errorCount++;
                e.printStackTrace();
            }
        }
        
        if (successCount > 0) {
            String actionText = "disable".equals(action) ? "vô hiệu hóa" : "xóa";
            request.setAttribute("success", 
                String.format("Đã %s thành công %d email", actionText, successCount));
        }
        
        if (errorCount > 0) {
            request.setAttribute("error", 
                String.format("Có %d email xử lý thất bại", errorCount));
        }
        
        response.sendRedirect(request.getContextPath() + "/quanli/newsletter/");
    }
}
