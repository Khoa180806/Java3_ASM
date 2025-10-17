
package com.java3.study.asm.controller.quanli;

import com.java3.study.asm.dao.impl.NewsDaoImpl;
import com.java3.study.asm.entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý CRUD tin tức cho quản lý
 * 
 * URL Mapping theo RESTful pattern:
 * - GET  /quanli/news/          → Danh sách tin tức
 * - GET  /quanli/news/new       → Form tạo tin tức mới
 * - POST /quanli/news/          → Tạo tin tức mới
 * - GET  /quanli/news/{id}      → Xem chi tiết tin tức
 * - GET  /quanli/news/{id}/edit → Form chỉnh sửa tin tức
 * - POST /quanli/news/{id}      → Cập nhật tin tức
 * - GET  /quanli/news/delete?id=xxx → Xóa tin tức (legacy)
 * 
 * Backward compatibility:
 * - GET  /quanli/news/create    → Redirect to /new
 * - GET  /quanli/news/edit?id=xxx → Form chỉnh sửa (legacy)
 * - GET  /quanli/news/view?id=xxx → Xem chi tiết (legacy)
 */
@WebServlet("/quanli/news/*")
public class QuanLiNews extends HttpServlet {
    
    private NewsDaoImpl newsDao;
    
    @Override
    public void init() throws ServletException {
        super.init();
        newsDao = new NewsDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        // Xử lý các action theo RESTful pattern
        if (pathInfo == null || pathInfo.equals("/")) {
            // GET /quanli/news/ → Danh sách tin tức
            showNewsList(request, response);
        } else if (pathInfo.equals("/new")) {
            // GET /quanli/news/new → Form tạo tin tức mới
            showCreateForm(request, response);
        } else if (pathInfo.equals("/create")) {
            // Backward compatibility - redirect to /new
            response.sendRedirect(request.getContextPath() + "/quanli/news/new");
        } else if (pathInfo.equals("/edit")) {
            // GET /quanli/news/edit?id=xxx → Form chỉnh sửa tin tức
            showEditForm(request, response);
        } else if (pathInfo.equals("/delete")) {
            // GET /quanli/news/delete?id=xxx → Xóa tin tức (không khuyến khích)
            deleteNews(request, response);
        } else if (pathInfo.equals("/view")) {
            // GET /quanli/news/view?id=xxx → Xem chi tiết tin tức
            viewNewsDetail(request, response);
        } else if (pathInfo.matches("/\\w+")) {
            // GET /quanli/news/{id} → Xem chi tiết tin tức theo ID
            String newsId = pathInfo.substring(1); // Bỏ dấu / đầu
            request.setAttribute("newsId", newsId);
            viewNewsDetail(request, response);
        } else if (pathInfo.matches("/\\w+/edit")) {
            // GET /quanli/news/{id}/edit → Form chỉnh sửa tin tức theo ID
            String newsId = pathInfo.substring(1, pathInfo.lastIndexOf("/edit"));
            request.setAttribute("newsId", newsId);
            showEditForm(request, response);
        } else {
            // Trang không tồn tại
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/") || pathInfo.equals("/new") || pathInfo.equals("/create")) {
            // POST /quanli/news/ hoặc /new hoặc /create → Tạo tin tức mới
            createNews(request, response);
        } else if (pathInfo.equals("/update")) {
            // POST /quanli/news/update → Cập nhật tin tức
            updateNews(request, response);
        } else if (pathInfo.matches("/\\w+")) {
            // POST /quanli/news/{id} → Cập nhật tin tức theo ID
            updateNews(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
    
    /**
     * Hiển thị danh sách tin tức
     */
    private void showNewsList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<News> newsList = newsDao.selectAll();
            request.setAttribute("newsList", newsList);
            request.setAttribute("action", "list");
            request.setAttribute("pageTitle", "Quản lý tin tức");
            request.setAttribute("contextPath", "quanli/news");
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách tin tức: " + e.getMessage());
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
        }
    }
    
    /**
     * Hiển thị form tạo tin tức mới
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("action", "create");
        request.setAttribute("pageTitle", "Tạo tin tức mới");
        request.setAttribute("contextPath", "quanli/news");
        
        request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
               .forward(request, response);
    }
    
    /**
     * Hiển thị form chỉnh sửa tin tức
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy ID từ URL path hoặc parameter
        String newsId = (String) request.getAttribute("newsId");
        if (newsId == null) {
            newsId = request.getParameter("id");
        }
        
        if (newsId == null || newsId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/news");
            return;
        }
        
        try {
            News news = newsDao.selectById(newsId);
            
            if (news == null) {
                request.setAttribute("errorMessage", "Không tìm thấy tin tức với ID: " + newsId);
                showNewsList(request, response);
                return;
            }
            
            request.setAttribute("news", news);
            request.setAttribute("action", "edit");
            request.setAttribute("pageTitle", "Chỉnh sửa tin tức");
            request.setAttribute("contextPath", "quanli/news");
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải tin tức: " + e.getMessage());
            showNewsList(request, response);
        }
    }
    
    /**
     * Xem chi tiết tin tức
     */
    private void viewNewsDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy ID từ URL path hoặc parameter
        String newsId = (String) request.getAttribute("newsId");
        if (newsId == null) {
            newsId = request.getParameter("id");
        }
        
        if (newsId == null || newsId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/news");
            return;
        }
        
        try {
            News news = newsDao.selectById(newsId);
            
            if (news == null) {
                request.setAttribute("errorMessage", "Không tìm thấy tin tức với ID: " + newsId);
                showNewsList(request, response);
                return;
            }
            
            request.setAttribute("news", news);
            request.setAttribute("action", "view");
            request.setAttribute("pageTitle", "Chi tiết tin tức");
            request.setAttribute("contextPath", "quanli/news");
            
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải tin tức: " + e.getMessage());
            showNewsList(request, response);
        }
    }
    
    /**
     * Tạo tin tức mới
     */
    private void createNews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String image = request.getParameter("image");
            String author = request.getParameter("author");
            String categoryId = request.getParameter("categoryId");
            String viewCountStr = request.getParameter("viewCount");
            String homeStr = request.getParameter("home");
            
            // Validate dữ liệu
            if (id == null || id.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.setAttribute("action", "create");
                request.setAttribute("pageTitle", "Tạo tin tức mới");
                request.setAttribute("contextPath", "quanli/news");
                request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                       .forward(request, response);
                return;
            }
            
            // Tạo đối tượng News
            News news = new News();
            news.setId(id.trim());
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setImage(image != null ? image.trim() : "");
            news.setPostedDate(new Date(System.currentTimeMillis()));
            news.setAuthor(author != null ? author.trim() : "");
            news.setViewCount(viewCountStr != null && !viewCountStr.trim().isEmpty() ? 
                             Integer.parseInt(viewCountStr) : 0);
            news.setCategoryId(categoryId != null ? categoryId.trim() : "");
            news.setHome(homeStr != null && homeStr.equals("on"));
            
            // Lưu vào database
            newsDao.insert(news);
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/quanli/news?success=create");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Số lượt xem phải là số nguyên!");
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo tin tức mới");
            request.setAttribute("contextPath", "quanli/news");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tạo tin tức: " + e.getMessage());
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo tin tức mới");
            request.setAttribute("contextPath", "quanli/news");
            request.getRequestDispatcher("/views/asm/common/quanly/layoutquanli.jsp")
                   .forward(request, response);
        }
    }
    
    /**
     * Cập nhật tin tức
     */
    private void updateNews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String image = request.getParameter("image");
            String author = request.getParameter("author");
            String categoryId = request.getParameter("categoryId");
            String viewCountStr = request.getParameter("viewCount");
            String homeStr = request.getParameter("home");
            
            // Validate dữ liệu
            if (id == null || id.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                showEditForm(request, response);
                return;
            }
            
            // Lấy tin tức hiện tại để giữ nguyên ngày đăng
            News existingNews = newsDao.selectById(id.trim());
            if (existingNews == null) {
                request.setAttribute("errorMessage", "Không tìm thấy tin tức để cập nhật!");
                showNewsList(request, response);
                return;
            }
            
            // Cập nhật thông tin
            News news = new News();
            news.setId(id.trim());
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setImage(image != null ? image.trim() : "");
            news.setPostedDate(existingNews.getPostedDate()); // Giữ nguyên ngày đăng
            news.setAuthor(author != null ? author.trim() : "");
            news.setViewCount(viewCountStr != null && !viewCountStr.trim().isEmpty() ? 
                             Integer.parseInt(viewCountStr) : 0);
            news.setCategoryId(categoryId != null ? categoryId.trim() : "");
            news.setHome(homeStr != null && homeStr.equals("on"));
            
            // Cập nhật trong database
            newsDao.update(news);
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/quanli/news?success=update");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Số lượt xem phải là số nguyên!");
            showEditForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật tin tức: " + e.getMessage());
            showEditForm(request, response);
        }
    }
    
    /**
     * Xóa tin tức
     */
    private void deleteNews(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String newsId = request.getParameter("id");
        
        if (newsId == null || newsId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quanli/news");
            return;
        }
        
        try {
            newsDao.delete(newsId.trim());
            response.sendRedirect(request.getContextPath() + "/quanli/news?success=delete");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/quanli/news?error=delete");
        }
    }
}