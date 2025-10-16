package com.java3.study.asm.dao;

import com.java3.study.asm.entity.Category;
import java.util.List;

public interface CategoryDao {
    // Lấy danh sách tất cả danh mục
    List<Category> selectAll();
    
    // Lấy danh mục theo ID
    Category selectById(String id);
    
    // Thêm mới danh mục
    void insert(Category category);
    
    // Cập nhật danh mục
    void update(Category category);
    
    // Xóa danh mục
    void delete(String id);
}
