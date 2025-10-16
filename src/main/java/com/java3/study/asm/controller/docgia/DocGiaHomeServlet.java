// In DocGiaHomeServlet.java
package com.java3.study.asm.controller.docgia;

import com.java3.study.asm.dao.CategoryDao;
import com.java3.study.asm.dao.NewsDao;
import com.java3.study.asm.dao.impl.CategoryDaoImpl;
import com.java3.study.asm.dao.impl.NewsDaoImpl;
import com.java3.study.asm.entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/docgia"})
public class DocGiaHomeServlet extends HttpServlet {
    
    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private final NewsDao newsDao = new NewsDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục
        var categories = categoryDao.selectAll();
        
        // Lấy top 5 bài viết xem nhiều nhất
        List<News> mostViewedNews = newsDao.selectFeaturedNews(5);
        
        // Lấy 5 bài viết mới nhất
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
        
        // Forward tới trang JSP
        request.getRequestDispatcher("/views/asm/docgiahome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}