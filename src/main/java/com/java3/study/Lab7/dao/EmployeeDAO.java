package com.java3.study.Lab7.dao;

import com.java3.study.Lab7.entity.Employee;

import java.util.List;

public interface EmployeeDAO {
    /**Truy vấn tất cả*/
    List<Employee> findAll();
    /**Truy vấn theo mã*/
    Employee findById(String id);
    /**Thêm mới*/
    void create(Employee item);
    /**Cập nhật*/
    void update(Employee item);
    /**Xóa theo mã*/
    void deleteById(String id);
}
