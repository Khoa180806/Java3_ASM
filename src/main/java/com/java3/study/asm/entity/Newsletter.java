package com.java3.study.asm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Newsletter {
    private String email;
    private Boolean enabled; //Trạng thái (true-còn hiệu lực) 
}
