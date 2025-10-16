package com.java3.study.asm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String id;
    private String password;
    private String fullname;
    private Date birthday;
    private Boolean gender;
    private String mobile;
    private String email;
    private Boolean role; //Vai trò (true là quản trị, false là phóng viên) 
}
