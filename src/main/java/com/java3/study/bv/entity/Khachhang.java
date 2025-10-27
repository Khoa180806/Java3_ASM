package com.java3.study.bv.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Khachhang {
    private String username;
    private String pass;
    private String hoten;
    private boolean gioitinh;
    private String email;
}
