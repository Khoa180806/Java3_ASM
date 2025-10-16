package com.java3.study.asm.dao;

import com.java3.study.asm.entity.News;
import java.util.List;

public interface NewsDao {
    // Tạo mới bài viết
    void insert(News news);
    
    // Cập nhật bài viết
    void update(News news);
    
    // Xóa bài viết theo ID
    void delete(String id);
    
    // Lấy bài viết theo ID
    News selectById(String id);
    
    // Lấy tất cả bài viết
    List<News> selectAll();

    // Lấy tin tức theo danh mục
    List<News> selectByCategory(String categoryId);

    // Lấy 5 tin tức xem nhiều nhất
    List<News> selectFeaturedNews(int limit);

    // Lấy 5 tin tức mới nhất
    List<News> selectLatestNews(int limit);
}
