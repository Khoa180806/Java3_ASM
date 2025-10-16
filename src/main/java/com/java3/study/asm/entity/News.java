package com.java3.study.asm.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class News {
    private String id;
    private String title;
    private String content;
    private String image; //Hình ảnh/video 
    private Date postedDate;
    private String author; //Tác giả (mã phóng viên) 
    private int viewCount;
    private String categoryId;
    private Boolean home; //Trang nhất (true sẽ xuất hiện trên trang chủ) 
}
