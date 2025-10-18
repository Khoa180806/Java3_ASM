
package com.java3.study.asm.controller.phongvien;

import com.java3.study.asm.dao.CategoryDao;
import com.java3.study.asm.dao.impl.CategoryDaoImpl;
import com.java3.study.asm.dao.impl.NewsDaoImpl;
import com.java3.study.asm.entity.News;
import com.java3.study.asm.service.SubscriptionService;
import com.java3.study.asm.utils.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý CRUD tin tức cho phóng viên
 * Mapping: /phongvien/*
 */
@WebServlet("/phongvien/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class PhongVienServlet extends HttpServlet {
    
    private NewsDaoImpl newsDao;
    private SubscriptionService subscriptionService;
    private CategoryDao categoryDao;
    
    @Override
    public void init() throws ServletException {
        super.init();
        newsDao = new NewsDaoImpl();
        subscriptionService = new SubscriptionService();
        categoryDao = new CategoryDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        // Xử lý các action khác nhau
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách tin tức
            showNewsList(request, response);
        } else if (pathInfo.equals("/new")) {
            // Hiển thị form tạo tin tức mới (RESTful)
            showCreateForm(request, response);
        } else if (pathInfo.equals("/create")) {
            // Backward compatibility - redirect to /new
            response.sendRedirect(request.getContextPath() + "/phongvien/new");
        } else if (pathInfo.equals("/edit")) {
            // Hiển thị form chỉnh sửa tin tức
            showEditForm(request, response);
        } else if (pathInfo.equals("/delete")) {
            // Xóa tin tức
            deleteNews(request, response);
        } else if (pathInfo.equals("/view")) {
            // Xem chi tiết tin tức
            viewNewsDetail(request, response);
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
            // POST /phongvien/ hoặc /new hoặc /create → Tạo tin tức mới
            createNews(request, response);
        } else if (pathInfo.equals("/update")) {
            // POST /phongvien/update → Cập nhật tin tức
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
            request.setAttribute("contextPath", "phongvien");
            request.setAttribute("categories", categoryDao.selectAll());
            
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách tin tức: " + e.getMessage());
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
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
        request.setAttribute("contextPath", "phongvien");
        request.setAttribute("categories", categoryDao.selectAll());

        request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
               .forward(request, response);
    }
    
    /**
     * Hiển thị form chỉnh sửa tin tức
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String newsId = request.getParameter("id");
        
        if (newsId == null || newsId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/phongvien");
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
            request.setAttribute("contextPath", "phongvien");
            request.setAttribute("categories", categoryDao.selectAll());
            
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
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
        
        String newsId = request.getParameter("id");
        
        if (newsId == null || newsId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/phongvien");
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
            request.setAttribute("contextPath", "phongvien");
            
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
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
            String author = request.getParameter("author");
            String categoryId = request.getParameter("categoryId");
            String viewCountStr = request.getParameter("viewCount");
            String homeStr = request.getParameter("home");
            
            // Xử lý upload ảnh
            String imagePath = null;
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("");
                imagePath = FileUploadUtil.uploadImage(imagePart, uploadPath);
            }
            
            // Validate dữ liệu
            if (id == null || id.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.setAttribute("action", "create");
                request.setAttribute("pageTitle", "Tạo tin tức mới");
                request.setAttribute("contextPath", "phongvien");
                request.setAttribute("categories", categoryDao.selectAll());
                request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
                       .forward(request, response);
                return;
            }
            
            // Tạo đối tượng News
            News news = new News();
            news.setId(id.trim());
            news.setTitle(title.trim());
            news.setContent(content.trim());
            news.setImage(imagePath != null ? imagePath : "");
            news.setPostedDate(new Date(System.currentTimeMillis()));
            news.setAuthor(author != null ? author.trim() : "");
            news.setViewCount(viewCountStr != null && !viewCountStr.trim().isEmpty() ? 
                             Integer.parseInt(viewCountStr) : 0);
            news.setCategoryId(categoryId != null ? categoryId.trim() : "");
            news.setHome(homeStr != null && homeStr.equals("on"));
            
            // Lưu vào database
            newsDao.insert(news);
            
            // Gửi thông báo email đến subscribers
            try {
                String newsUrl = request.getScheme() + "://" + 
                                request.getServerName() + ":" + 
                                request.getServerPort() + 
                                request.getContextPath() + 
                                "/docgia/detail?id=" + news.getId();
                subscriptionService.notifyNewNews(news.getTitle(), newsUrl);
            } catch (Exception emailEx) {
                // Log lỗi nhưng không làm gián đoạn flow
                System.err.println("Lỗi khi gửi email thông báo: " + emailEx.getMessage());
            }
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/phongvien?success=create");
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Số lượt xem phải là số nguyên!");
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo tin tức mới");
            request.setAttribute("contextPath", "phongvien");
            request.setAttribute("categories", categoryDao.selectAll());
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tạo tin tức: " + e.getMessage());
            request.setAttribute("action", "create");
            request.setAttribute("pageTitle", "Tạo tin tức mới");
            request.setAttribute("contextPath", "phongvien");
            request.setAttribute("categories", categoryDao.selectAll());
            request.getRequestDispatcher("/views/asm/common/phongvien/layoutphongvien.jsp")
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
            String author = request.getParameter("author");
            String categoryId = request.getParameter("categoryId");
            String viewCountStr = request.getParameter("viewCount");
            String homeStr = request.getParameter("home");
            String oldImage = request.getParameter("oldImage");
            
            // Xử lý upload ảnh mới
            String imagePath = oldImage; // Giữ ảnh cũ nếu không upload ảnh mới
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("");
                imagePath = FileUploadUtil.uploadImage(imagePart, uploadPath);
                
                // Xóa ảnh cũ nếu có và nó là đường dẫn local (không phải URL)
                if (oldImage != null && !oldImage.isEmpty() && 
                    !oldImage.startsWith("http://") && !oldImage.startsWith("https://")) {
                    FileUploadUtil.deleteImage(oldImage, uploadPath);
                }
            }
            
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
            news.setImage(imagePath != null ? imagePath : "");
            news.setPostedDate(existingNews.getPostedDate()); // Giữ nguyên ngày đăng
            news.setAuthor(author != null ? author.trim() : "");
            news.setViewCount(viewCountStr != null && !viewCountStr.trim().isEmpty() ? 
                             Integer.parseInt(viewCountStr) : 0);
            news.setCategoryId(categoryId != null ? categoryId.trim() : "");
            news.setHome(homeStr != null && homeStr.equals("on"));
            
            // Cập nhật trong database
            newsDao.update(news);
            
            // Redirect về danh sách với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/phongvien?success=update");
            
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
            response.sendRedirect(request.getContextPath() + "/phongvien");
            return;
        }
        
        try {
            newsDao.delete(newsId.trim());
            response.sendRedirect(request.getContextPath() + "/phongvien?success=delete");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/phongvien?error=delete");
        }
    }
}