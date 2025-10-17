package com.java3.study.asm.dao;

import com.java3.study.asm.entity.User;
import java.util.List;

public interface UserDao {
    // Tạo mới người dùng
    void insert(User user);
    
    // Cập nhật thông tin người dùng
    void update(User user);
    
    // Xóa người dùng theo ID
    void delete(String id);
    
    // Lấy thông tin người dùng theo id
    User getById(String id);
    
    // Lấy tất cả người dùng
    List<User> getAll();
    
    // Xác thực đăng nhập
    User authenticate(String id, String password);
}
