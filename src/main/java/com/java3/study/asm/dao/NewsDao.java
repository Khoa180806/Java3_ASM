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
    
    // Lấy danh sách bài viết theo category
    List<News> selectByCategory(String categoryId);
}
