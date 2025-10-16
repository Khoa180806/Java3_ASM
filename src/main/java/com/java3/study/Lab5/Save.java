package com.java3.study.Lab5;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.beanutils.converters.DateTimeConverter;

import java.io.IOException;
import java.util.Date;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet(name = "Save", value = "/save")
public class Save extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/Lab5/save.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Staff bean = new Staff(); // dùng để chứa dữ liệu form
        try {
        // Khai báo định dạng ngày
            DateTimeConverter dtc = new DateConverter(new Date());
            dtc.setPattern("MM/dd/yyyy");
            ConvertUtils.register(dtc, Date.class);
            // đọc và chuyển đổi tham số vào bean
            BeanUtils.populate(bean, request.getParameterMap());
            System.out.println(bean.getFullname());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}