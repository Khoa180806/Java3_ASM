package com.java3.study.bv.dao;

import java.util.List;

import com.java3.study.bv.entity.Khachhang;

public interface KhachhangDAO {
    void insert(Khachhang kh);
    void update(Khachhang kh);
    void delete(String username);
    Khachhang findByUsername(String username);
    List<Khachhang> findAll();
}
