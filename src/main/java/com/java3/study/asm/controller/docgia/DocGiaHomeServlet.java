// In DocGiaHomeServlet.java
package com.java3.study.asm.controller.docgia;

import com.java3.study.asm.dao.CategoryDao;
import com.java3.study.asm.dao.NewsDao;
import com.java3.study.asm.dao.impl.CategoryDaoImpl;
import com.java3.study.asm.dao.impl.NewsDaoImpl;
import com.java3.study.asm.entity.News;
import com.java3.study.asm.service.SubscriptionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.regex.Pattern;

@WebServlet({"/docgia", "/docgia/detail", "/docgia/subscription"})
public class DocGiaHomeServlet extends HttpServlet {
    
    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private final NewsDao newsDao = new NewsDaoImpl();
    private final SubscriptionService subscriptionService = new SubscriptionService();
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String requestURI = request.getRequestURI();
        
        // Xử lý yêu cầu xem chi tiết bài viết
        if (requestURI.endsWith("/detail")) {
            handleDetailRequest(request, response);
        } else {
            handleHomeRequest(request, response);
        }
    }
    
    private void handleHomeRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục
        var categories = categoryDao.selectAll();
        
        // Lấy tham số categoryId nếu có
        String categoryId = request.getParameter("categoryId");
        List<News> newsList;
        String categoryName = "Tin tức mới nhất";
        
        // Nếu có chọn danh mục, lấy tin theo danh mục
        if (categoryId != null && !categoryId.isEmpty()) {
            newsList = newsDao.selectByCategory(categoryId);
            // Lấy tên danh mục để hiển thị
            var category = categories.stream()
                .filter(c -> c.getId().equals(categoryId))
                .findFirst()
                .orElse(null);
            if (category != null) {
                categoryName = "Danh mục: " + category.getName();
            }
        } else {
            // Nếu không chọn danh mục, lấy tất cả tin tức
            newsList = newsDao.selectAll();
        }
        
        // Lấy top 5 bài viết xem nhiều nhất
        List<News> mostViewedNews = newsDao.selectFeaturedNews(5);
        
        // Lấy 5 bài viết mới nhất cho sidebar
        List<News> latestNews = newsDao.selectLatestNews(5);
        
        // Lấy 5 bài viết xem gần đây từ session
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<News> recentlyViewed = (List<News>) session.getAttribute("recentlyViewed");
        if (recentlyViewed == null) {
            recentlyViewed = new ArrayList<>();
        }
        
        // Cập nhật danh sách xem gần đây nếu đang xem chi tiết bài viết
        String newsId = request.getParameter("id");
        if (newsId != null) {
            News currentNews = newsDao.selectById(newsId);
            if (currentNews != null) {
                // Loại bỏ nếu đã tồn tại trong danh sách
                recentlyViewed.removeIf(n -> n.getId().equals(newsId));
                // Thêm vào đầu danh sách
                recentlyViewed.add(0, currentNews);
                // Giới hạn danh sách tối đa 5 bài
                if (recentlyViewed.size() > 5) {
                    recentlyViewed = recentlyViewed.subList(0, 5);
                }
                // Lưu lại vào session
                session.setAttribute("recentlyViewed", recentlyViewed);
            }
        }
        
        // Đặt các danh sách vào request attribute
        request.setAttribute("categories", categories);
        request.setAttribute("mostViewedNews", mostViewedNews);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("recentlyViewed", recentlyViewed);
        request.setAttribute("newsList", newsList);
        request.setAttribute("categoryName", categoryName);
        
        // Sử dụng template
        request.setAttribute("mainContent", "/views/asm/common/docgia/docgiamain.jsp");
        request.setAttribute("pageTitle", "Trang chủ");
        request.getRequestDispatcher("/views/asm/template.jsp").forward(request, response);
    }
    
    private void handleDetailRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newsId = request.getParameter("id");
        if (newsId == null || newsId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số id");
            return;
        }
        
        News news = newsDao.selectById(newsId);
        if (news == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Tăng số lượt xem
        news.setViewCount(news.getViewCount() + 1);
        newsDao.update(news);
        
        // Lấy danh sách tin cùng chuyên mục (trừ tin hiện tại)
        List<News> relatedNews = newsDao.selectByCategory(news.getCategoryId())
                .stream()
                .filter(n -> !n.getId().equals(newsId))
                .limit(3)
                .collect(Collectors.toList());
        
        // Lấy danh sách danh mục cho menu
        var categories = categoryDao.selectAll();
        
        // Lấy 5 bài viết xem nhiều nhất cho sidebar
        List<News> mostViewedNews = newsDao.selectFeaturedNews(5);
        
        // Lấy 5 bài viết mới nhất cho sidebar
        List<News> latestNews = newsDao.selectLatestNews(5);
        
        // Lấy danh sách xem gần đây từ session
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<News> recentlyViewed = (List<News>) session.getAttribute("recentlyViewed");
        if (recentlyViewed == null) {
            recentlyViewed = new ArrayList<>();
        }
        
        // Cập nhật danh sách xem gần đây
        recentlyViewed.removeIf(n -> n.getId().equals(newsId));
        recentlyViewed.add(0, news);
        if (recentlyViewed.size() > 5) {
            recentlyViewed = recentlyViewed.subList(0, 5);
        }
        session.setAttribute("recentlyViewed", recentlyViewed);
        
        // Đặt các thuộc tính vào request
        request.setAttribute("categories", categories);
        request.setAttribute("mostViewedNews", mostViewedNews);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("recentlyViewed", recentlyViewed);
        request.setAttribute("news", news);
        request.setAttribute("relatedNews", relatedNews);
        
        // Sử dụng template
        request.setAttribute("pageTitle", news.getTitle() + " - Khoa News");
        request.setAttribute("mainContent", "/views/asm/common/docgia/detail.jsp");
        request.getRequestDispatcher("/views/asm/template.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String requestURI = request.getRequestURI();
        if (requestURI.endsWith("/subscription")) {
            handleSubscription(request, response);
            return;
        }
        doGet(request, response);
    }

    private void handleSubscription(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");

        // Validate email format
        if (email == null || email.isBlank() || !EMAIL_PATTERN.matcher(email).matches()) {
            session.setAttribute("subscriptionStatus", "error");
            session.setAttribute("subscriptionMessage", "Vui lòng nhập email hợp lệ để nhận tin mới.");
            response.sendRedirect(request.getContextPath() + "/docgia");
            return;
        }

        try {
            // Sử dụng SubscriptionService để xử lý đăng ký
            boolean success = subscriptionService.subscribe(email);
            
            if (success) {
                session.setAttribute("subscriptionStatus", "success");
                session.setAttribute("subscriptionMessage", 
                    "Đăng ký thành công! Chúng tôi đã gửi email xác nhận đến " + email);
            } else {
                session.setAttribute("subscriptionStatus", "info");
                session.setAttribute("subscriptionMessage", 
                    "Email này đã đăng ký nhận thông báo rồi.");
            }
        } catch (Exception e) {
            session.setAttribute("subscriptionStatus", "error");
            session.setAttribute("subscriptionMessage", 
                "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại sau.");
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/docgia");
    }
}