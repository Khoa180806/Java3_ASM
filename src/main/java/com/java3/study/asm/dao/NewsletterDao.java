package com.java3.study.asm.dao;

import com.java3.study.asm.entity.Newsletter;
import java.util.List;

public interface NewsletterDao {
    // Đăng ký nhận bản tin mới
    void insert(Newsletter newsletter);
    
    // Hủy đăng ký nhận bản tin
    void update(String email);
    
    // Xóa thông tin đăng ký
    void delete(Newsletter newsletter);
    
    // Lấy thông tin đăng ký theo email
    Newsletter getByEmail(String email);
    
    // Lấy tất cả người đăng ký
    List<Newsletter> getAll();
}
