package com.java3.study.asm.dao;

import com.java3.study.asm.entity.User;
import java.util.List;

public interface UserDao {
    // Tạo mới người dùng
    void create(User user);
    
    // Cập nhật thông tin người dùng
    void update(User user);
    
    // Xóa người dùng theo ID
    void delete(String id);
    
    // Lấy thông tin người dùng theo ID
    User getById(String id);
    
    // Lấy thông tin người dùng theo email
    User getByEmail(String email);
    
    // Lấy thông tin người dùng theo username
    User getByUsername(String username);
    
    // Lấy tất cả người dùng
    List<User> getAll();
    
    // Đăng nhập
    User login(String username, String password);
    
    // Kiểm tra username đã tồn tại chưa
    boolean isUsernameExists(String username);
    
    // Kiểm tra email đã tồn tại chưa
    boolean isEmailExists(String email);
    
    // Đếm số lượng người dùng
    int count();
    
    // Tìm kiếm người dùng theo tên hoặc email
    List<User> search(String keyword);
    
    // Cập nhật mật khẩu
    void updatePassword(String userId, String newPassword);
}
