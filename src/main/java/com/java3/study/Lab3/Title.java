package com.java3.study.Lab3;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Lớp Servlet được tạo từ template.
 */
@WebServlet("/Title")
public class Title extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Object> map = new HashMap<>();
        map.put("title", "Tiêu đề bản tin");
        map.put("content", "Nội dung bản tin thường rất dài");
        request.setAttribute("item", map);
        request.getRequestDispatcher("/views/Lab3/Title.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}